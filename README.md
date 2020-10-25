# Custom Shell Commands
### By Langston Howley

The idea of this project is to have custom commands that I can run in the terminal for personal convinience.

> The current functions include:
- weather
- starsearch

> Additions coming soon



## Installation

```bash
    #open your terminal and type these commands to install
    git clone https://github.com/langstonhowley/Custom-Shell-Commands
    chmod +x Custom-Shell-Commands/install.sh
    Custom-Shell-Commands/install.sh
```

## Weather Command

The `weather` command allows a user to get current weather information for a speified location. Its return includes: 

- Current Weather
    - At your location and the highest and lowest temp recorded in that location at runtime.
- Pressure & Humidity
- Wind Data

Usage:
```bash
weather -m|-i  -c CITY_NAME
    -m: Use metric units (°C, m/s)
    -i: Use imperial units (°F, mph)
    -c CITY: Specify the city

Example: weather -m -c "Los Angeles"
```

Example Output:
```
Current Weather Los Angeles:

        Current Temp: 16.69, 18/14.44 (°C)
        Pressure: 1013 hPa | Humidity: 68 %
        Wind: 3 m/s @ 238°
```

## Star Search Command

The `starsearch` command allows a user to get current positional information for a speified star/galaxy/nebula. Its return includes: 

- ID based on SIMBAD identification
- Right Ascension Data (h:m:s)
- Declination Data (°:m:s)

Usage:
```bash
starsearch -s STAR_NAME
    -s STAR_NAME: Specify the star/galaxy/nebula
	-h: Help
	
Example: starsearch -s 'Andromeda Galaxy'
```
Example Output:
```
Object ID: M  31
        RA: 00 42 44.330
        DEC: +41 16 07.50
```