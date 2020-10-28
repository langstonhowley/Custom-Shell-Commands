# Custom Shell Commands

> By Langston Howley

The idea of this project is to have custom commands that users can run in the terminal for personal convenience and entertainment.

> The current commands include:

- weather
- starsearch

## Installation

```bash
    # clone the repository into your current directory
    git clone https://github.com/langstonhowley/Custom-Shell-Commands
    # allow the install script to be run on your machine
    chmod +x Custom-Shell-Commands/install.sh
    # run the install script
    Custom-Shell-Commands/install.sh
```

## Weather Command

The `weather` command allows a user to get current weather information for a speified location. Its return includes:

- Current Weather
  - Toggle with the `--noC` option
- Pressure & Humidity
- Wind Data
- 5-day Forecast
  - Toggle with the `--noF` option

Usage:

```bash
Usage:
    weather -i|-m [--noF | --noC] <city_name>
    weather -h
        <city_name> : Specify the city
        -m : Use Metric (°C only)
        -i : Use Imperial (°F only)
        --noC : omit current weather data (forecast only)
        --noF : omit 5-day forecast data (current only)
        -h : Help

Example: weather -i "Los Angeles"
```

Example Output:

```bash
Current Weather Los Angeles:

    Current Temp: 55.44, 71.55/55.44 (°F)
    Pressure: 1013 hPa | Humidity: 71 %
    Wind: 6.17 mph @ 51°

5-day Forecast Los Angeles:

    27/10/2020: 76.42/62.56 (°F) clear sky
    28/10/2020: 76.33/64.06 (°F) clear sky
    29/10/2020: 77.99/64.87 (°F) clear sky
    30/10/2020: 78.82/65.53 (°F) clear sky
    31/10/2020: 81.39/67.03 (°F) broken clouds
```

## Star Search Command

The `starsearch` command allows a user to get current positional information for a speified star/galaxy/nebula. Its return includes:

- ID based on SIMBAD identification
- Right Ascension Data (h : m : s)
- Declination Data (° : m : s)

Usage:

```bash
starsearch -s STAR_NAME
    -s STAR_NAME: Specify the star/galaxy/nebula
    -h: Help

Example: starsearch -s 'Andromeda Galaxy'
```

Example Output:

```bash
Object ID: M  31
        RA: 00 42 44.330
        DEC: +41 16 07.50
```
