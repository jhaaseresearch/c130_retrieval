## Scripts
- `0B_c130toags.sh`: Copies sbf from agsd to /ags/data/hiaper/*
- `4A_c130toinsitu.sh`: Copies all the 1-sec data in agsd to products
  - **!! run `c130insitu.py` in /ags/projects/hiaper/code_kloo before running this script !!**
  - the command would look like
    ```bash
    $ ./c130insitu.py schedule_tc25_a0xt.yaml
    ```
  - output: `newfilename.txt` in code_kloo
- `completeflights.sh`: Checks if flight data exists, and copies the necessary files to agsd if it does
- `dailystorm.sh`: Archives Tropical Tidbits track and intensity forecast, and NHC cone projection. The active storms have to be updated almost daily.
- `opendaily.sh`: I've been using this to look at all the Flightaware tabs so I don't have to open every single tab lol
- For cronjobs:

  These are the scripts that I add to my crontab for automating tasks.

  `podnhc.sh`: Archives NHC plan of the day.

  `nhcscreenshot.py`: Archives NHC maps of the Atlantic, Eastern Pacific, and Central Pacific.

## Source

- **Author**: Kelly Loo, kloo@ucsd.edu
- **Date modified**: 2025-11-18
- **Date created**: 2025-11-18
