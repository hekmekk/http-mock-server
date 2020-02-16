#!/bin/bash

DEFAULT_RESPONSE_MESSAGE=${1:-OK}
DEFAULT_RESPONSE="HTTP/1.1 200\n\n$DEFAULT_RESPONSE_MESSAGE"
MAPPINGS_DIR=$2

while read line
do
	echo -e "$(date) request: ${line}" > /dev/tty

	case $line in
		GET*|PUT*|POST*|DELETE*)
			response=$(`pwd`/request_handler.sh $line $MAPPINGS_DIR)
			if [[ -z $response ]]; then
				echo "$(date) using default response: $DEFAULT_RESPONSE" > /dev/tty
				echo -e $DEFAULT_RESPONSE
			else
				echo "$(date) using configured response: $response" > /dev/tty
				echo -e "$response"
			fi
			break
			;;
		*)
			break
			;;
	esac
done

