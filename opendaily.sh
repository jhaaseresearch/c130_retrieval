# !/bin/bash/

: << 'CONVENTION'
This code opens all the links that needs to be checked daily.
- Tropical Tidbits (Recon and Storm Info)
- Tropical Atlantic (Current recon)
- NHC POD and tropical cyclone watch
- C-130s, P3, and G-IV on FlightAware

INPUT: None

OUTPUT: Websites mentioned above opens in a new window.
CONVENTION

cd /Applications/ 
echo "Starting process..."
echo ""

# User changes to prefered brower
browser="Google Chrome"
#browser="Safari"

echo "Loading websites"
websites=("https://tropicalatlantic.com/recon/recon.cgi?all=1
https://www.tropicaltidbits.com/storminfo/
https://www.flightaware.com/live/flight/965300 
https://www.flightaware.com/live/flight/965301 
https://www.flightaware.com/live/flight/965302 
https://www.flightaware.com/live/flight/975303 
https://www.flightaware.com/live/flight/975304 
https://www.flightaware.com/live/flight/975305 
https://www.flightaware.com/live/flight/975306 
https://www.flightaware.com/live/flight/985307 
https://www.flightaware.com/live/flight/985308 
https://www.flightaware.com/live/flight/995309
https://www.flightaware.com/live/flight/N49RF
https://www.nhc.noaa.gov/text/MIAREPRPD.shtml")
echo " "

open -na "$browser" --args --new-window $websites
# open ~/agsd\ Dropbox/agsd\'s\ shared\ workspace/data_temp/tc25_usaf_aro/forecast_record_tc25.docx 


echo "...browser opened."