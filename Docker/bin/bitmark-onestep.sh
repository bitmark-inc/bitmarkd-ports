#!/bin/sh
ERROR()
{
  echo error: $*
  exit 1
}

USAGE()
{
  [ -z "$1" ] || echo error: $*
  echo usage: $(basename "$0") '[options] <commands> ...'
  echo '(* = required)'
  echo ''
  echo '       --help               -h             this message'
  echo '       --network=net        -n net         Connect to which bitmark network bitmark|testing|local [testing]'
  echo '       --cli-config=dir     -c dir        *bitmark-cli config directory'
  echo '       --pay-config=file    -w file       *bitmark-pay config file'
  echo '       --identity=name      -i name        bitmark-cli identity [default identity]'
  echo ''
  echo ' setup  setup bitmark-onestep     '
  echo '       --connect=IP:PORT    -x IP:PORT    *bitmarkd host/IP and port, HOST:PORT'
  echo '       --description=desc   -d desc       *bitmark-cli identity description'
  echo ''
  echo ' issue  issue and pay bitmark'
  echo '       --asset=name         -a name       *asset name'
  echo '       --description=desc   -d desc       *asset description'
  echo '       --fingerprint=fp     -f fp         *asset fingerprint'
  echo '       --quantity=num       -q num         quantity to issue [1]'
  echo ''
  echo ' transfer transfer and pay bitmark'
  echo '       --txid=txid          -t txid       *transaction id to transfer'
  echo '       --receiver=name      -r name       *identity name to receive the transaction'
  exit 1
}

password=""
network="testing"
cliConfig=""
payConfig=""
identity=""
connect=""
description=""
asset=""
fingerprint=""
quantity=1
txid=""
receiver=""

getopt=/usr/local/bin/getopt
[ -x "${getopt}" ] || getopt=getopt
args=$(${getopt} -o hp:n:c:w:i:x:d:a:f:q:t:r: --long=help,password:,network:,cli-config:,pay-config:,identity:,connect:,description:,asset:,fingerprint:,quantity:,txid:,receiver: -- "$@") ||exit 1

eval set -- "${args}"

# parse options
while :
do
  case "$1" in
    (-p|--password)
      password="$2"
      [ -z "${password}" ] && USAGE password cannot be blank
      shift
      ;;
    (-n|--network)
      network="$2"
      [ "testing" = "${network}" -o "bitmark" = "${network}" -o "local" = "${network}" ] ||   ERROR unrecognized network: ${network}
      shift
      ;;
    (-c|--cli-config)
      cliConfig="$2"
      [ -z "${cliConfig}" ] && USAGE cli-config cannot be blank
      shift
      ;;
    (-w|--pay-config)
      payConfig="$2"
      [ -z "${payConfig}" ] && USAGE pay-config cannot be blank
      shift
      ;;
    (-i|--identity)
      identity="$2"
      [ -z "${identity}" ] && USAGE identity cannot be blank
      shift
      ;;
    (-x|--connect)
      connect="$2"
      [ -z "${connect}" ] && USAGE connect cannot be blank
      shift
      ;;
    (-d|--description)
      description="$2"
      [ -z "${description}" ] && USAGE description cannot be blank
      shift
      ;;
    (-a|--asset)
      asset="$2"
      [ -z "${asset}" ] && USAGE asset cannot be blank
      shift
      ;;
    (-f|--fingerprint)
      fingerprint="$2"
      [ -z "${fingerprint}" ] && USAGE fingerprint cannot be blank
      shift
      ;;
    (-q|--quantity)
      quantity="$2"
      [ -z "${quantity}" ] && USAGE quantity cannot be blank
      shift
      ;;
    (-t|--txid)
      txid="$2"
      [ -z "${txid}" ] && USAGE txid cannot be blank
      shift
      ;;
    (-r|--receiver)
      receiver="$2"
      [ -z "${receiver}" ] && USAGE receiver cannot be blank
      shift
      ;;
    (--)
      shift
      break
      ;;
    (-h|--help)
      USAGE
      ;;
    (*)
      USAGE invalid option: $1
      ;;
  esac
  shift
done

# validate arguments
[ $# -ne 1 ] && USAGE invalid arguments

# check general required options
[ -z "${cliConfig}" ] && ERROR cli-config is required
[ -z "${payConfig}" ] && ERROR pay-config is required

bin='./bin'
bitmarkCli=bitmark-cli
bitmarkPay="java -jar -Dorg.apache.logging.log4j.simplelog.StatusLogger.level=OFF ${bin}/bitmarkPayService"

cleanup()
{
  payPassword=""
  stty echo
}
trap cleanup INT EXIT

payPassword=""
getPayPassword()
{
  stty -echo
  if [ -z "${payPassword}" ]
  then
    read -p "pay password: " payPassword
  fi
  stty echo
  echo ''
}

# set bitmark-pay network
payNetwork=''
case ${network} in
  (bitmark)
    payNetwork='livenet'
    ;;
  (testing)
    payNetwork='regtest'
  ;;
  (local)
    payNetwork='local'
    ;;
  (*)
    ERROR invalid network arguments
    ;;
esac

cliFlags="--config ${cliConfig}"
payFlags="--net=${payNetwork} --config=${payConfig}"

# run command
case $1 in
  (setup)
    # setup bitmark-cli
    [ -z "${connect}" ] && ERROR connect is required
    [ -z "${description}" ] && ERROR description is required
    [ -z "${identity}" ] && ERROR identity is required
    cliFlags="${cliFlags} --identity ${identity}"
    echo '---- setup bitmark-cli ----'
    ${bitmarkCli} ${cliFlags} setup --network ${network} --connect ${connect} --description ${description}

    # setup bitmark-pay
    echo '---- setup bitmark-pay ----'
    ${bitmarkPay} ${payFlags} encrypt
    ${bitmarkPay} ${payFlags} address
    ;;
  (issue)
    # check issue options
    [ -z "${identity}" ] && ERROR identity is required
    cliFlags="${cliFlags} --identity ${identity}"
    [ -z "${asset}" ] && ERROR asset is required
    [ -z "${description}" ] && ERROR description is required
    [ -z "${fingerprint}" ] && ERROR fingerprint is required
    [ ${quantity} -le 0 ] && ERROR invalid quantity

    echo '---- issue asset ----'
    result=$(${bitmarkCli} ${cliFlags} issue --asset ${asset} --description ${description} --fingerprint ${fingerprint} --quantity ${quantity})
    echo "${result}"
    issueIds=$(echo "${result}" | jq -r '.issueIds')
    paymentAddress=$(echo "${result}" | jq -r '.paymentAddress[0].address')
    [ -z "${paymentAddress}" ] && ERROR issue asset failed

    # pay the issue ids to the address
    payFlags="${payFlags} --stdin"
    echo '---- pay issues ----'
    getPayPassword
    for issueId in $(echo ${issueIds} | jq -r '.[]')
    do
      echo "---- paying ${issueId} ----"
      printf '%s\n' "${payPassword}" | ${bitmarkPay} ${payFlags} pay "${issueId}" "${paymentAddress}"
    done
    cleanup
    ;;
  (transfer)
    # check transfer options
    [ -z "${txid}" ] && ERROR txid is required
    [ -z "${receiver}" ] && ERROR receiver is required
    [ -n "${identity}" ] && cliFlags="${cliFlags} --identity ${identity}"

    echo "---- transfer ${txid} ----"
    result=$(${bitmarkCli} ${cliFlags} transfer --txid ${txid} --receiver ${receiver})
    echo "${result}"
    transferId=$(echo "${result}" | jq -r '.transferId')
    paymentAddress=$(echo "${result}" | jq -r '.paymentAddress[0].address')
    [ -z "${paymentAddress}" ] && ERROR transfer transaction failed
    echo "${paymentAddress}"

    # pay to the address
    payFlags="${payFlags} --stdin"
    echo '--- pay transfer ----'
    getPayPassword
    echo "---- paying ${transferId} ----"
    printf '%s\n' "${payPassword}" | ${bitmarkPay} ${payFlags} pay "${transferId}" "${paymentAddress}"
    cleanup
    ;;
  (*)
    USAGE invalid command: $1
    ;;
esac
