#!/bin/bash
# Bash strict mode, see http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

export LANG=C
ALERT_SCRIPT=alert-wechat.sh

if test "`find rsync.log -mtime +1`";then
	$(ALERT_SCRIPT) "daily backup failed";
fi
