#!/bin/bash
# Bash strict mode, see http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

export LANG=C
IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
CropID=wx740ecac6b2a01dfe
Secret=ihGVT66QxXxtSd9RYnNwSp2VJg8fpOY5YlaYgPZm3A_g3PtbZfzz2oVq9FN2X74-
GURL="https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=$CropID&corpsecret=$Secret"
Gtoken=$(/usr/bin/curl -s -G $GURL | awk -F\" '{print $4}')
PURL="https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=$Gtoken"
MSG="$(date)\nHostname: $(hostname)\nIP: ${IP}\n$@"
/usr/bin/curl --data-ascii '{"touser":"@all","msgtype":"text","agentid":"1","text":{"content":"'${MSG}'"},"safe":"0"}' --url ${PURL}
echo
