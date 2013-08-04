#!/usr/bin/env sh

# @description: Nginx is an HTTP(S) server, HTTP(S)
# reverse proxy and IMAP/POP3 proxy server
#
# @synopsis:    nginx.sh [ start| stop | restart | reload | process | info ]
# @author       Alexander Guinness <monolithed@gmail.com>
# @version      0.0.1
# @license:     MIT, BSD, GPL
# @date:        Jun 12 01:33:00 2013

read -d '' help <<- EOF
	Usage:
		${0} [ start | stop | restart | reload | test | process | info | help ]

	Call pure nginx process:
	${0} precess [-?hvVtq] [-s signal] [-c filename] [-p prefix] [-g directives]

	Options:
		-?,-h         : This help

		-v            : Show version and exit

		-V            : Show version and configure options then exit

		-t            : Test configuration and exit.
		                Nginx checks configuration for correct syntax
		                and then try to open files referred in configuration.

		-q            : Suppress non-error messages during configuration testing

		-s signal     : Send signal to a master process: stop, quit, reopen, reload

		-p prefix     : Set prefix path (default: /opt/local/)

		-c filename   : Set configuration file (default: /opt/local/etc/nginx/nginx.conf)

		-g directives : Set global directives out of configuration file (version >=0.7.4)

		For more info see http://wiki.nginx.org/CommandLine
EOF


NGINX_DIR=/opt/local;
NGINX_DAEMON=${NGINX_DIR}/sbin/nginx;
NGINX_CONF=${NGINX_DIR}/etc/nginx/nginx.conf;


__test() {
	local NGINX_TEST="${NGINX_DAEMON} -c ${NGINX_CONF} -t";
	2>&1 ${NGINX_TEST} &>/dev/null || ${NGINX_TEST};
}

__launch() {
	__test && ${NGINX_DAEMON} -s ${1} &>/dev/null;
}

__start() {
	[ -r ${NGINX_CONF} ] || exit 1;
	__test && ${NGINX_DAEMON} -c ${NGINX_CONF} &>/dev/null || return ${?};
}

__stop() {
	__launch stop;
}

__reload() {
	__test && __launch reload || return ${?};
}

__restart() {
	__stop && __start;
}

__process() {
	${NGINX_DAEMON} ${1} &>/dev/null;
}

__info() {
	ps axw -o pid,user,%cpu,%mem,command | {
		awk 'NR == 1 || /uwsgi/' | grep -v awk;
		echo -$_{1..80} | tr -d ' ';
	}

	2>&1 ${NGINX_DAEMON} -V | sed 's/--/\'$'\n&/g';
}

__help() {
	echo "$help";
}

case "${1}" in
	start|stop|restart|reload|process|test|info|help)
		#[ -z ${NGINX_DAEMON} ] || exit 2;
		__${1}
		;;
	*)
		__help
	;;
esac
