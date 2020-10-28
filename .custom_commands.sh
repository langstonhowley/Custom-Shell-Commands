#!/bin/bash 

function starsearch(){
	unset OBJECT LIMIT RADIUS VELO ROT DIST

	USAGE=("Usage:
    $0 [options] [-l|--limit LIMIT] <-r|--radius RADUIS> <star_name>
	$0 -h
    options:
        -h|--help: Show usage
        -r|--radius RADIUS: arcminute formatted string: '0d6m0s' or degree value: 0.1 (1° = 60 arcmin)
        -l|--limit LIMIT: limit the amount of objects returned
        -v|--velo: show velocity data 
        -o|--rot: show rotational velocity data
        -d|--dist: show distance data
		
Example: $0 -r '0d6m0s' -l 10 -d Andromeda")

	while getopts ":hr:l:vod-:" opt; do
		case ${opt} in
			h) 
				echo $USAGE
				kill -INT $$
			;;
			r)
				RADIUS="-r $OPTARG"
			;;
			l)
				LIMIT="-l $OPTARG"
			;;
			v)
				VELO='-v'
			;;
			o)
				ROT='-o'
			;;
			d)
				DIST='-d'
			;;
		esac
	done
	shift $(( OPTIND - 1 ))

	OBJECT=$1

	if [[ -z $OBJECT ]]
	then
		echo "ERROR: No object specified!\n"
		echo $USAGE
		kill -INT $$
	fi

	# if [[ -z $RADIUS ]]
	# then
	# 	echo "ERROR: No radius specified!\n"
	# 	echo $USAGE
	# 	kill -INT $$
	# fi

	#$CUSTOM_COMMANDS_HOME/env/bin/python3 $CUSTOM_COMMANDS_HOME/python/starsearch.py -r $RADIUS $VELO $ROT $DIST $OBJECT
	echo "$CUSTOM_COMMANDS_HOME/env/bin/python3 $CUSTOM_COMMANDS_HOME/python/starsearch.py $RADIUS $LIMIT $VELO $ROT $DIST $OBJECT"
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
