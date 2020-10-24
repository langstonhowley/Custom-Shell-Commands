#!/bin/bash 

if  [ -f $HOME/.bash_profile ]; then
    touch $HOME/.bash_profile
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo -e "\nexport CUSTOM_COMMANDS_HOME=$DIR" >> $HOME/.bash_profile
echo -e "source $DIR/.custom_commands.sh" >> $HOME/.bash_profile

echo "CUSTOM_COMMANDS_HOME set to $DIR"

virtualenv env -p python3
source env/bin/activate
pip3 install -r $DIR/python/requirements.txt
touch $DIR/python/.env
echo -e "WEATHER_API_KEY = " >> $DIR/python/.env
echo -e "Don't forget to put a Weather API Key in /python/.env\nMore info @ https://openweathermap.org/appid"
source $HOME/.bash_profile
cd $DIR