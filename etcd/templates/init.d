#!/bin/sh
# chkconfig: 345 85 15
# description: Manages the etcd webserver
# processname: etcd

# Author: Wayne E. Seguin
#         wayneeseguin@gmail.com
#
# etcd control file.
#
#   May be either in the $PATH as etcd_ctl
#   or used as /etc/init.d/etcd
#

typeset action

log()  { printf "$*\n" ; return $? ;  }

usage() {
	log "
	Usage:

	$0 [action]

	Actions:

	start    - Start etcd
	stop     - Stop etcd
	restart  - Restart etcd
	status   - etcd status
	help     - Display this usage information
	"
}

while [[ $# -gt 0 ]]
do
	token="$1" ; shift
	case $token in
		start|stop|restart|status|help)
			action=$token
			break
			;;
		*)       
			action="error" 
			break
			;;
	esac
done

if [[ -x /bin/sm ]]
then sm="/bin/sm"
else sm="/opt/sm/bin/sm"
fi

case "$action" in
	start|stop|restart|status)
		${sm} etcd ${action}
		;;
	help)
		usage    
		;;
	*)        
		usage 
		exit 1 
		;;
esac

exit $?
