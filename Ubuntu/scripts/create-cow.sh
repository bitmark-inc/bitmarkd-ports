#!/bin/sh
# create or update the cowuider base for a specific dist and arch

# settings
dist=wily
arch=amd64

# errors
ERROR()
{
  echo error: $*
  exit 1
}

# base directory
base="/var/cache/pbuilder/${dist}-${arch}"
[ -d "${base}" ] || sudo mkdir -p "/var/cache/pbuilder/${dist}-${arch}"

# base image file
cow="${base}/base.cow"

# ensure the configuration is up to date
cp -p ../files/dot.pbuilderrc "${HOME}/.pbuilderrc"

# create or update the base image
if [ ! -d "${cow}" ]
then
  # create new chroot base image
  sudo HOME="${HOME}" cowbuilder --create --basepath "/var/cache/pbuilder/${dist}-${arch}/base.cow" --distribution "${dist}" --debootstrapopts --arch --debootstrapopts "${arch}"
  [ $? -ne 0 ] && ERROR "cowbuilder --create failed"

else

  # update the chroot
  #   setting HOME is necessary as sudo strips environment variables for security reasons
  #   otherwise cowbuilder will not find the ~/.pbuilderrc
  [ X"${created}" = X"no" ] && sudo HOME="${HOME}" DIST="${dist}" ARCH="${arch}" cowbuilder --update

fi

# Example of builing a specific package
#
#   # build a package
#   dget -x http://ftp.de.debian.org/debian/pool/main/n/nano/nano_2.2.6-1.dsc
#
#   # build a package
#   sudo DIST="${dist}" ARCH="${arch}" cowbuilder --build nano_2.2.6-1.dsc
#
#   # result will be available in: /var/cache/pbuilder/${dist}-${arch}/result
#   ls -al "/var/cache/pbuilder/${dist}-${arch}/result"
