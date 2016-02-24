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
  [ -z "$1" ] && echo error: $*
  echo usage: $(basename "$0") work-dir
  exit 1
}

# check argument
work_dir="$1"; shift
[ -z "${work_dir}" ] && USAGE "missing argument"
[ -d "${work_dir}" ] || USAGE "missing work directory: ${work_dir}"

# set initial directory
cd "${work_dir}" || ERROR "cannot change to directory: ${work_dir}"
work_dir="${PWD}"

# need this to work
libucl=vstakhov-libucl-0.7.3_GH0.tar.gz
libucl_url=https://codeload.github.com/vstakhov/libucl/tar.gz/0.7.3
libucl_dir="${work_dir}/cache"

# fetch and cache libucl source
mkdir -p "${libucl_dir}"
[ -f "${libucl_dir}/${libucl}" ] || curl -o  "${libucl_dir}/${libucl}" "${libucl_url}"

# define supported projects
project_list='bitmarkd miniature-spoon'
account_path=github.com/bitmark-inc
go_src_dir="${GOPATH}/src"

[ -d "${go_src_dir}" ] || ERROR "missing GO source dir: ${go_src_dir}"

cd_or_error()
{
  [ -d "$1" ] || ERROR "not a directory: $1"
  cd "$1" || ERROR "cannot change directory to:: $1"
}

make_mega_package()
{
  local account_path project
  account_path="$1"; shift
  project="$1"; shift

  local version debian version
  version='0.0.0'
  debian_version=1

  echo "processing project: ${project}"

  # find project root
  local project_dir
  project_dir="${go_src_dir}/${account_path}/${project}"
  cd_or_error "${project_dir}"

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
  master_file="${work_dir}/${project}_${version}+dfsg${debian_version}.orig.tar.gz"
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

  # back to work dir to create debian files
  cd_or_error "${work_dir}"

  dpkg-source -b --diff-ignore='.*' "${project_dir}"

}

# create all projects
for project in ${project_list}
do
  make_mega_package "${account_path}" "${project}"
done
