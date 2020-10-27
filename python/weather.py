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

from decouple import config
import requests
import sys, getopt
from datetime import datetime as dt


if __name__ == '__main__':

    BASE_URL = 'http://api.openweathermap.org/data/2.5/weather'
    CURRENT_URL = "https://api.openweathermap.org/data/2.5/onecall?exclude=minutely,hourly,alerts"
    FORECAST_URL = "https://api.openweathermap.org/data/2.5/onecall?exclude=current,minutely,hourly,alerts"
    KEY = config('WEATHER_API_KEY')
    CITY = sys.argv[-1]
    UNITS = ''
    OMIT = ''

    opts, args = getopt.getopt(sys.argv[1:],"mi",['noC', 'noF'])
    for opt,arg in opts:
        if(opt in ('-m')):
            UNITS = 'metric'
        elif(opt in ('-i')):
            UNITS = 'imperial'
        elif(opt in ('--noC')):
#            print('No current')
            OMIT = 'c'
        elif(opt in ('--noF')):
#            print('No forecast')
            OMIT = 'f'

#    print('Checked options and got city: {}, units: {}, omit: {}.\nSending request...'.format(
#        CITY,UNITS,OMIT
#    ))

    payload = {'appid': KEY, 'q': CITY, 'units': UNITS}
    res = requests.get(BASE_URL,params=payload).json()
#    print('Got response from first request')
    longitude = res['coord']['lon']
    lattitude = res['coord']['lat']

    payload = {'appid': KEY, 'lat': lattitude, 'lon': longitude, 'units': UNITS}
    res = requests.get(CURRENT_URL, params=payload).json()

    current_data = res["current"]
    daily_data = res["daily"]
    #weather_data = res["main"]
    #wind_data = res["wind"]
    weather_string = ''

    if(OMIT is not 'c'):
        weather_string = ("\nCurrent Weather {}:\n\n"
                        "\tCurrent Temp: {}, {}/{} (°{})\n"
                        "\tPressure: {} hPa | Humidity: {} %\n"
                        "\tWind: {} {} @ {}°\n").format(
                            CITY,
                            current_data["temp"], daily_data[0]["temp"]["max"], daily_data[0]["temp"]["min"],'C' if UNITS=='metric' else 'F',
                            current_data["pressure"], current_data['humidity'],
                            current_data["wind_speed"], 'm/s' if UNITS=='metric' else 'mph', current_data["wind_deg"])

#    print('Got Long: {}, Lat: {}\nSending second request...'.format(longitude,lattitude))

    forecast_string = ''
    if(OMIT is not 'f'):
        #payload = {'appid': KEY, 'lat': lattitude, 'lon': longitude, 'units': UNITS}
        #res = requests.get(FORECAST_URL, params=payload).json()
        forecast_string = "5-day Forecast {}:\n\n".format(CITY)
#       print('Got response from second request')

        for f in daily_data[1:6]:
            time = dt.fromtimestamp(f['dt'])
            day_forecast_string = '\t{}/{}/{}: {}/{} (°{}) {}\n'.format(
                time.day, time.month, time.year,
                f['temp']['max'], f['temp']['min'], 'C' if UNITS=='metric' else 'F',
                f['weather'][0]['description']
            )
            forecast_string = forecast_string + day_forecast_string
#           print(day_forecast_string)
        
    print(weather_string)
    print(forecast_string)
    


