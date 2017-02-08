#!/bin/bash
# Bash strict mode, see http://redsymbol.net/articles/unofficial-bash-strict-mode/
#set -euo pipefail
#IFS=$'\n\t'

DIRS=`ls --directory -- */`
for i in ${DIRS};do
	if [ -d ${i}/.git/ ];then
		echo ${i}
		git -C ${i} pull
	fi
done
