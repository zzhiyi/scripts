#!/bin/bash
# Bash strict mode, see http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

export LANG=C
THIS_CMD="$0 $@"
REPO_DIR=$1
PACKAGES_DIR=${REPO_DIR}/Packages/
LOG_FILE=/home/y/auto-update-repo.log
ALERT_SCRIPT=/home/y/alert-wechat.sh

function finish {
  ${ALERT_SCRIPT} "ALERT: ${THIS_CMD} exited"
  echo "$(date) ${THIS_CMD} exited"|tee -a ${LOG_FILE}
}
trap finish QUIT EXIT INT TERM SIGHUP SIGTERM SIGINT

if [ -z ${REPO_DIR} ] || [ ! -e ${REPO_DIR} ]; then
	exit 1;
fi

if [ -z ${PACKAGES_DIR} ] || [ ! -e ${PACKAGES_DIR} ]; then
	exit 2;
fi

inotifywait -r -m ${PACKAGES_DIR} -e modify -e move -e create -e delete |
    while read path action file; do
        echo "${path} {$action} ${file}" | tee -a ${LOG_FILE}
        ret=createrepo --update ${REPO_DIR} | tee -a ${LOG_FILE}
        if [ ${ret} -ne 0 ];then
		${ALERT_SCRIPT} "WARNING: ${THIS_CMD} createrepo return $ret" $(tail -n 20 ${LOG_FILE})
	fi
    done
