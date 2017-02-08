#!/bin/bash
# Bash strict mode, see http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

DIRS=`ls --directory -- */`
GIT_DIRS=""
for i in ${DIRS};do
	if [ -d ${i}/.git/ ];then
		GIT_DIRS+="${i}\n"
	fi
done
echo -e ${GIT_DIRS}|tee /dev/tty|xargs --max-args=1 --max-procs=99 --replace git -C {} pull