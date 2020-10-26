#!/bin/bash 

function starsearch(){
	unset STAR 

	USAGE=("Usage: $0 -s STAR_NAME
	\t-s STAR_NAME: Specify the star/galaxy/nebula
	\t-h: Help
	
Example: starsearch -s 'Andromeda Galaxy'\n")

	while getopts "s:h" opt; do
		case ${opt} in
			s)	STAR=$OPTARG ;;
			h) 
				echo $USAGE
				kill -INT $$
			;;
		esac
	done

	if [[ -z $STAR ]]
	then
		echo "ERROR: No Object Specified!\n"
		echo $USAGE
		kill -INT $$
	fi

	$CUSTOM_COMMANDS_HOME/env/bin/python3 $CUSTOM_COMMANDS_HOME/python/starsearch.py -s $STAR
}

function weather(){
	unset CITY
	unset UNIT
	unset OMIT


	USAGE=("Usage: 
	$0 -i|-m [--noF | --noC] <city_name>
	$0 -h
	\t\t<city_name> : Specify the city
	\t-m : Use Metric (°C only)
	\t-i : Use Imperial (°F only)
	\t--noC : omit current weather data (forecast only)
	\t--noF : omit 5-day forecast data (current only)
	\t-h : Help	

Example: weather -i \"Los Angeles\"\n")

	while getopts ":hmi-:" opt; do
		case "${opt}" in
			-)
				case "${OPTARG}" in
					noC)
						if [[ -z $OMIT ]]
						then
							#echo "Omitting current weather"
							OMIT="--noC"
						else
							echo "ERROR: An omit flag was already set: ${OMIT}."
							echo $USAGE
						fi
					;;
					noF)
						if [[ -z $OMIT ]]
						then
							#echo "Omitting weather forecast"
							OMIT="--noF"
						else
							echo "ERROR: An omit flag was already set: ${OMIT}."
							echo $USAGE
						fi
					;;
				esac
			;;
			m)
				if [[ -z $UNIT ]]
				then
					#echo "Unit set to Metric"
					UNIT='-m'
				else
					echo "Unit is set to ${UNIT} but changing to Metric"
					UNIT='-m'
				fi
			;; 
			i)
				if [[ -z $UNIT ]]
				then
					#echo "Unit set to Imperial"
					UNIT='-i'
				else
					echo "Unit is set to ${UNIT} but changing to Imperial"
					UNIT='-i'
				fi
			;;
			h) 
				echo $USAGE
				kill -INT $$
			;;
		esac
	done
	shift $(( OPTIND - 1 ))

	CITY=$1

	if [[ -z $UNIT ]]
	then
		echo "ERROR: No Unit Specified!"
		echo $USAGE
		kill -INT $$
	fi

	if [[ -z $CITY ]]
	then
		echo "ERROR: No City Specified!"
		echo $USAGE
		kill -INT $$
	fi

	#echo "City: ${CITY}, Unit: ${UNIT}, Omit: ${OMIT}"

	$CUSTOM_COMMANDS_HOME/env/bin/python3 $CUSTOM_COMMANDS_HOME/python/weather.py $UNIT $OMIT $CITY
}
