#!/bin/bash 

function starsearch(){
	echo 'You entered: ' $1
}

function weather(){
	unset CITY UNIT

	USAGE=("Usage: $0 -m|-i  -c CITY_NAME
	\t-m: Use Metric (°C)
	\t-i: Use Imperial (°F)
	\t-c CITY_NAME: Specify the city
	\t-h: Help
	
Example: weather -i -c 'Los Angeles'\n")

	while getopts "c:mih" opt; do
		case ${opt} in
			m)	UNIT="-m" ;;
			i)	UNIT="-i" ;;
			c)	CITY=$OPTARG ;;
			h) 
				echo $USAGE
				kill -INT $$
			;;

		esac
	done

	if [[ -z $UNIT ]]
	then
		echo "ERROR: No Unit Specified!\n"
		echo $USAGE
		kill -INT $$
	fi

	if [[ -z $CITY ]]
	then
		echo "ERROR: No City Specified!\n"
		echo $USAGE
		kill -INT $$
	fi

	$CUSTOM_COMMANDS_HOME/env/bin/python3 $CUSTOM_COMMANDS_HOME/python/weather.py -c $CITY $UNIT
}
