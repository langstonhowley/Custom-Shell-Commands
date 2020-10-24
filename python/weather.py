from decouple import config
import requests
import sys, getopt


if __name__ == '__main__':

    BASE_URL = 'http://api.openweathermap.org/data/2.5/weather'
    KEY = config('WEATHER_API_KEY')
    CITY = ''
    UNITS = ''

    opts, args = getopt.getopt(sys.argv[1:],"c:mi",["city=,metric,imperial"])
    for opt,arg in opts:
        if(opt in ('-c','--city')):
            CITY = arg
        elif(opt in ('-m', '--metric')):
            UNITS = 'metric'
        elif(opt in ('-i', '--imperial')):
            UNITS = 'imperial'

    #TODO: cahnge q and units to parameters
    payload = {'appid': KEY, 'q': CITY, 'units': UNITS}

    r = requests.get(BASE_URL,params=payload).json()
    pre_data = r["weather"]
    sys_data = r["sys"]
    weather_data = r["main"]
    wind_data = r["wind"]
    CITY = r["name"]


    weather_string = ("\nCurrent Weather {}:\n\n"
                       "\tCurrent Temp: {}, {}/{} (°{})\n"
                       "\tPressure: {} hPa | Humidity: {} %\n"
                       "\tWind: {} {} @ {}°\n").format(
                           CITY,
                           weather_data["temp"], weather_data["temp_max"], weather_data["temp_min"],'C' if UNITS=='metric' else 'F',
                           weather_data["pressure"], weather_data['humidity'],
                           wind_data["speed"], 'm/s' if UNITS=='metric' else 'mph', wind_data["deg"])


    print(weather_string)

    #r.json()
    #print(weather_data, r)
    


