#!/bin/sh
ERROR()
{
  echo ERROR: $*
  exit 1
}

EXIT()
{
  echo $*
  exit 0
}

network=""

Welcome()
{
  echo ''
  echo 'Welcome to use bitmark command line service'
  echo 'Please choose the bitmark network to join:'
  echo '1) testing'
  echo '2) bitmark'
  echo ''
  read -p 'join to: ' network
  echo ''

  case ${network} in
    1) echo 'testing'
       network='testing'
       ;;
    2) echo 'bitmark'
       network='bitmark'
       ;;
    *) ERROR invalid network ;;
  esac

  InitVariable

  service=""
  echo 'Please choose the service: '
  echo '1) Setup'
  echo '2) Issue an bitmark'
  echo '3) Transfer an bitmark'
  echo ''
  read -p 'service: ' service
  echo ''

  case ${service} in
    1) Setup ;;
    2) Issue ;;
    3) Transfer ;;
    *) ERROR Service not support ;;
  esac
}

bin='./bin'
bitmarkCli=bitmark-cli
bitmarkPay="java -jar -Dorg.apache.logging.log4j.simplelog.StatusLogger.level=OFF ${bin}/bitmarkPayService"
cliConfig=""
payConfig=""
identity="admin"

InitVariable()
{
  cliConfig="./config/bitmark-cli/bitmark-cli-${network}.conf"
  payNetwork=`echo "$network" | awk '{print toupper($0)}'`
  payConfig="./config/bitmark-pay/bitmark-pay-${payNetwork}.xml"
}

Setup ()
{
  [ -f "${cliConfig}" ] && RemoveFile ${cliConfig} && echo ''
  [ -f "${cliConfig}" ] && EXIT Abort setup

  connect="127.0.0.1:2130"
  description="admin"

  cliFlags="--config ${cliConfig}"
  cliFlags="${cliFlags} --identity ${identity}"
  cliPassword=""

  # get and verify password
  while [ -z cliPassword -o ${#cliPassword} -lt 8 ]
  do
    cliPassword=$(GetPassword 'password (>=8)')
    if [ -z cliPassword -o ${#cliPassword} -lt 8 ]
    then
      echo ''
      echo 'invalid password'
      echo ''
    fi
  done

  echo ''
  verifyPassword=$(GetPassword 'verify password')
  echo ''
  if [ "${cliPassword}" != "${verifyPassword}" ]
  then
    ERROR verify password fail
  fi

  # setup bitmark-cli
  echo '---- setup bitmark-cli ----'
  ${bitmarkCli} ${cliFlags} --password "${cliPassword}" setup --network ${network} --connect ${connect} --description ${description} || rm ${cliConfig}
  echo ''

  keyPairResult=$(${bitmarkCli} ${cliFlags} --password "${cliPassword}" keypair)
  privateKey=$(echo "${keyPairResult}" | jq -r '.private_key')
  echo 'Please right down your private key to a secure place. There is no way to get the private key back.'
  echo "${privateKey}"
  echo ''
  read -p 'type any key to continue ...' c

  # setup bitmark-pay
  echo '---- setup bitmark-pay ----'
  ${bitmarkPay} --net="${network}" --config="${payConfig}" --password="${privateKey}"  encrypt
  echo ''
  ${bitmarkPay} --net="${network}" --config="${payConfig}" info
  echo ''

  # clean password and private key
  cliPassword=''
  verifyPassword=''
  keyPairResult=''
  privateKey=''
}

RemoveFile()
{
  response="N"
  read -p 'config file is existed, do you want to delete it? (y/N) ' response
  if [ "${response}" = "y" ]
  then
    echo "Remove file ..."
    rm $1
  fi
}

GetPassword()
{
  password=''
  stty -echo
  if [ -z "${password}" ]
  then
    read -p "$1: " password
  fi
  stty echo
  echo ${password}
}


Issue()
{
  # get issue field
  while [ true ]
  do
    asset=$(GetRequiredField 'asset name')
    description=$(GetRequiredField 'description')
    filePath=$(GetRequiredField 'file path')
    filePath=$(realpath "${filePath}")
    while [ ! -f "${filePath}" ]
    do
      echo "${filePath} not exists"
      filePath=$(GetRequiredField 'file path')
      filePath=$(realpath "${filePath}")
    done
    quantity=$(GetRequiredField 'quantity')

    echo ''
    echo '==== asset info ===='
    echo "asset name: ${asset}"
    echo "description: ${description}"
    echo "file: ${filePath}"
    echo "quantity: ${quantity}"
    echo ''
    read -p 'issue this asset? (y/N) ' issue
    [ "y" = "${issue}" ] && break
  done

  fingerprint=$(sha512sum "${filePath}")
  fingerprint=$(echo "${fingerprint}" | awk -F ' ' '{print $1}')

  cliFlags="--config ${cliConfig}"
  cliFlags="${cliFlags} --identity ${identity}"

  cliPassword=$(GetPassword 'password')

  echo ''
  echo '---- issue asset ----'
  result=$(${bitmarkCli} ${cliFlags} --password ${cliPassword} issue --asset ${asset} --description ${description} --fingerprint ${fingerprint} --quantity ${quantity})
  echo "${result}"
  issueIds=$(echo "${result}" | jq -r '.issueIds')
  paymentAddress=$(echo "${result}" | jq -r '.paymentAddress[0].address')
  [ -z "${paymentAddress}" ] && ERROR issue asset failed

  # pay the issue ids to the address
  keyPairResult=$(${bitmarkCli} ${cliFlags} --password "${cliPassword}" keypair)
  privateKey=$(echo "${keyPairResult}" | jq -r '.private_key')

  echo ''
  echo '---- pay issues ----'
  for issueId in $(echo ${issueIds} | jq -r '.[]')
  do
    echo "---- paying ${issueId} ----"
    printf '%s\n' "${payPassword}" | ${bitmarkPay} --net="${network}" --config="${payConfig}" --password="${privateKey}" pay "${issueId}" "${paymentAddress}"
  done

  # cleanup
  cliPassword=''
  privateKey=''
}

Transfer()
{
  # check transfer options
  echo ''
  echo 'Please enter the txId you would like to transfer'
  txid=$(GetRequiredField 'txid')
  receiver=$(GetRequiredField 'receiver')

  cliFlags="--config ${cliConfig}"
  cliFlags="${cliFlags} --identity ${identity}"

  echo "---- transfer ${txid} ----"
  result=$(${bitmarkCli} ${cliFlags} transfer --txid ${txid} --receiver ${receiver})
  echo "${result}"
  transferId=$(echo "${result}" | jq -r '.transferId')
  paymentAddress=$(echo "${result}" | jq -r '.paymentAddress[0].address')
  [ -z "${paymentAddress}" ] && ERROR transfer transaction failed
  echo "${paymentAddress}"

  exit 0
  # pay to the address
  payFlags="${payFlags} --stdin"
  echo '--- pay transfer ----'
  echo "---- paying ${transferId} ----"
  printf '%s\n' "${payPassword}" | ${bitmarkPay} ${payFlags} pay "${transferId}" "${paymentAddress}"
}

GetRequiredField()
{
  value=''
  while [ -z "${value}" ]
  do
    read -p "$1: " value
    if [ -z "${value}" ]
    then
      echo "$1 is required" >&2
      echo '' >&2
    fi
  done

  echo $value
}

Welcome
