#!/bin/bash

usage() {
	echo "Usage:"
	echo "    ./server.sh -h                                                                     Display this help message."
	echo "    ./server.sh [-l port default=1500] [-m message default=OK] [-c mapping-dir]        Run the server."
}

while getopts ":l:m:c:h" opt; do
	case ${opt} in
		h)
			usage
			exit 0
			;;
		l)
			PORT=$OPTARG
			;;
		m)
			DEFAULT_RESPONSE_MESSAGE=$OPTARG
			;;
		c)
			MAPPINGS_DIR=$OPTARG
			;;
		\?)
			echo "Invalid option: $OPTARG" 1>&2
			usage
			exit 0
			;;
		:)
			echo "Invalid option: $OPTARG requires an argument" 1>&2
			usage
			exit 0
			;;
	esac
done
shift $((OPTIND -1))

PORT=${PORT:-1500}
DEFAULT_RESPONSE_MESSAGE=${DEFAULT_RESPONSE_MESSAGE:-OK}
MAPPINGS_DIR=${MAPPINGS_DIR:-$(pwd)}

shutdown() {
	echo -e "$(date) server stopped"
	exit
}

trap shutdown INT TERM;

echo -e "$(date) server about to listen on $PORT with mappings-dir=$MAPPINGS_DIR ..."
while true; do
	nc -l $PORT -e "`pwd`/input_reader.sh $DEFAULT_RESPONSE_MESSAGE $MAPPINGS_DIR"
done

