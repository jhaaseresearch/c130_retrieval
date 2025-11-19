## Scripts
- `c130toags.sh`: Copies sbf from agsd to /ags/data/hiaper/* and 1-second data to /ags/products/hiaper/*/c130-insitu_usaf
- `completeflights.sh`: Checks if flight data exists, and copies the necessary files to agsd if it does
- `dailystorm.sh`: Archives Tropical Tidbits track and intensity forecast, and NHC cone projection. The active storms have to be updated almost daily. Intended to be used during hurricane season.
- `opendaily.sh`: I've been using this to look at all the Flightaware tabs so I don't have to open every single tab lol
- For cronjobs:

  These are the scripts that I add to my crontab for automating tasks.

  `nhcscreenshot.py`: Archives NHC maps of the Atlantic, Eastern Pacific, and Central Pacific.

  `podnhc.sh`: Archives NHC plan of the day.

  `ttscreenshot.py`: Archives Tropical Tidbit recon flight dropsonde screenshots, then renames the files to indicate the time it was saved.

## Source

- **Author**: Kelly Loo, kloo@ucsd.edu
- **Date created**: 2025-11-18
