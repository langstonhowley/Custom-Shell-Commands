#!/bin/bash 

#     Copyright 2020 Langston Howley

#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at

#        http://www.apache.org/licenses/LICENSE-2.0

#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

if  [ -f $HOME/.bash_profile ]; then
    touch $HOME/.bash_profile
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo -e "\nexport CUSTOM_COMMANDS_HOME=$DIR" >> $HOME/.bash_profile
echo -e "source $DIR/.custom_commands.sh" >> $HOME/.bash_profile

echo "CUSTOM_COMMANDS_HOME set to $DIR"

virtualenv $DIR/env -p python3
source $DIR/env/bin/activate
pip3 install -r $DIR/python/requirements.txt
touch $DIR/python/.env
echo -e "WEATHER_API_KEY = " >> $DIR/python/.env
echo -e "\nDon't forget to put a Weather API Key in /python/.env\nMore info @ https://openweathermap.org/appid"
source $HOME/.bash_profile
cd $DIR