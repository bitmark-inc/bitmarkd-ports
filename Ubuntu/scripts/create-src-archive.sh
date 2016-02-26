#!/bin/sh
# scan all dependencies of the current git repo and produce a set of archives
# then tar into a master archive
# this script must be in the root directory of this repository to work

ERROR()
{
  echo error: $*
  exit 1
}

USAGE()
{
  [ -z "$1" ] || echo error: $*
  echo usage: $(basename "$0") '<options> <projects...>'
  echo '       --help           -h         this message'
  echo '       --verbose        -v         more messages'
  echo '       --account=ACC    -a ACC     github account name'
  echo '       --work-dir=DIR   -w DIR     working directory'
  echo '       --debug          -d         show debug information'
  exit 1
}

# main program

verbose=no
account=
work_dir=

getopt=/usr/local/bin/getopt
[ -x "${getopt}" ] || getopt=getopt
args=$(${getopt} -o hva:w:d --long=help,verbose,account:,work-dir:,debug -- "$@") ||exit 1

# replace the arguments with the parsed values
eval set -- "${args}"

while :
do
  case "$1" in
    (-v|--verbose)
      verbose=yes
      ;;

    (-a|--account)
      account=$2
      shift
      ;;

    (-w|--work-dir)
      work_dir=$2
      shift
      ;;

    (-d|--debug)
      debug=yes
      ;;

    (--)
      shift
      break
      ;;

    (*)
      USAGE invalid argument $1
      ;;
  esac
  shift
done

# check have arguments
[ $# -eq 0 ] && USAGE missing arguments

# validate options
[ -z "${account}" ] && USAGE "missing --account argument"
[ -z "${work_dir}" ] && USAGE "missing --work-dir argument"
[ -d "${work_dir}" ] || USAGE "missing work directory: ${work_dir}"

[ X"${debug}" = X"yes" ] && set -x

account_path="github.com/${account}"

# set initial directory and make absolute path
cd "${work_dir}" || ERROR "cannot change to directory: ${work_dir}"
work_dir="${PWD}"

# need this to work
libucl=vstakhov-libucl-0.7.3_GH0.tar.gz
libucl_url=https://codeload.github.com/vstakhov/libucl/tar.gz/0.7.3
libucl_dir="${work_dir}/cache"

# fetch and cache libucl source
mkdir -p "${libucl_dir}"
[ -f "${libucl_dir}/${libucl}" ] || curl -o "${libucl_dir}/${libucl}" "${libucl_url}"

# check the go path
go_src_dir="${GOPATH}/src"
[ -d "${go_src_dir}" ] || ERROR "missing GO source dir: ${go_src_dir}"

cd_or_error()
{
  [ -d "$1" ] || ERROR "not a directory: $1"
  cd "$1" || ERROR "cannot change directory to:: $1"
}

make_mega_package()
{
  local account_path project debian_version dfsg
  account_path="$1"; shift
  project="$1"; shift
  debian_version="$1"; shift
  dfsg="$1"; shift

  echo "processing project: ${project}"

  # find project root
  local project_dir
  project_dir="${go_src_dir}/${account_path}/${project}"
  cd_or_error "${project_dir}"

  # NOTE: full version string is: <MAJOR>.<MINOR>+<YYYMMDD>.<COUNT>+git<HASH>+dfsg-<DEBIAN-VERSION>

  # get the most recent git tag
  #   allowd tag values: <MAJOR>.<MINOR>  v<MAJOR>.<MINOR>  V<MAJOR>.<MINOR>
  # if tag is N commits deep the the following suffix is added:
  #   -<N>-g<HASH>
  local tag
  tag=$(git describe --tags | egrep '^[vV]?[[:digit:]]+\.[[:digit:]]+(-[[:digit:]]+-g[[:xdigit:]]+)?$' | sed 's/^[vV]//;s/-g/ /;s/-/ /g')
  [ -z "${tag}" ] && ERROR "no valid git tag found for: ${project}"

  # extract major.minor depth hash
  local version depth hash
  version="$(printf '%s' "${tag}" | awk '{print $1}')"
  depth="$(printf '%s' "${tag}" | awk '{print $2}')"
  hash="$(printf '%s' "${tag}" | awk '{print $3}')"

  # if version tag is deeper then add date.depth, git-hash, optional dfsg and debian version suffix
  local today debian_version
  today=$(date -u +'%Y%m%d')
  [ -n "${hash}" ] && version="${version}+${today}.${depth}+git${hash}"
  [ "${dfsg}" -ne 0 ] && version="${version}+dfsg"
  [ -n "${debian_version}" ] && version="${version}-${debian_version}"

  # display the final version string
  echo "package version: ${version}"

  # check that there is a debian directory
  local debian_dir
  debian_dir="${project_dir}/debian"
  if [ ! -d "${debian_dir}" ]
  then
    echo "skipping: ${project}"
    echo "not a debian directory: ${debian_dir}"
    return 1
  fi

  # compute all dependencies and extract unique items
  local depends
  depends=$(go list -f '{{join .Deps "\n"}}' . | (
             while read dep
             do
               dir="${GOPATH}/src/${dep}"
               [ -d "${dir}" ] && (cd "${dir}" && git rev-parse --show-toplevel)
             done
           ) | sort -u)

  # to cache the individual archives
  local archive_dir
  archive_dir="${work_dir}/archives"
  rm -rf "${archive_dir}"
  mkdir -p "${archive_dir}"

  # install the libucl sources
  [ -f "${archive_dir}/${libucl}" ] || cp -p "${libucl_dir}/${libucl}" "${archive_dir}"

  # build individual packages
  local packages fullpath repo account hash file
  packages=''
  for fullpath in ${depends}
  do
    echo processing: ${fullpath}
    repo=$(basename "${fullpath}")
    account=$(basename $(dirname "${fullpath}"))

    cd "${fullpath}" || ERROR "cannot change directory to: ${fullpath}"

    hash=$(git log -n 1 --pretty='%h')

    echo detected: ${account}/${repo} hash: ${hash}
    packages="${packages} github.com/${account}/${repo}:${hash}"

    file="${archive_dir}/${account}-${repo}-${hash}_GH0.tar.gz"
    if [ -f "${file}" ]
    then
      echo "skipping: ${file}"
    else
      echo "creating: ${file}"
      git archive --format=tar.gz --prefix="${repo}-${hash}/" "${hash}" -o "${file}"
    fi

  done

  # auto detect version? from git tags perhaps
  # hash=$(git log -n 1 --pretty='%h')

  # make the mega-package
  local master_file
  master_file="${work_dir}/${project}_${version}.orig.tar.gz"
  rm -f "${master_file}"
  echo "creating: ${master_file}"
  tar czf "${master_file}" -C "${archive_dir}" .

  # setup Debian structure
  local versions_mk
  versions_mk="${debian_dir}/versions.mk"
  rm -f "${versions_mk}"
  for p in ${packages}
  do
    printf 'GO_PACKAGES += %s\n' "${p}" >> "${versions_mk}"
  done

  printf 'LIBUCL = %s\n' "${libucl}" >> "${versions_mk}"

  printf 'APP_NAME = %s\n' "${project}" >> "${versions_mk}"

  # force the current version
  git checkout "${debian_dir}/changelog"
  dch --newversion="${version}" 'set build version'
  dch --release 'set release'

  # back to work dir to create debian files
  cd_or_error "${work_dir}"

  dpkg-source -b --diff-ignore='.*' "${project_dir}"

  # restore the changelog
  git checkout "${debian_dir}/changelog"

}

# create all projects
debian_version=1
dfsg=0
for project in $*
do
  make_mega_package "${account_path}" "${project}" "${debian_version}" "${dfsg}"
done
