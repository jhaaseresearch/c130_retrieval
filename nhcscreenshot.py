from selenium import webdriver
from selenium.webdriver.common.by import By
import requests
import os
import time
from urllib.parse import urljoin
import base64
from datetime import datetime

# download nhc screenshots

# image URLs
epac_url = "https://www.nhc.noaa.gov/?epac"
cpac_url = "https://www.nhc.noaa.gov/?cpac"
atlantic_url = "https://www.nhc.noaa.gov/?atl"

# folder to save files
nhc_dropbox_path="/Users/kyloo/agsd Dropbox/agsd's shared workspace/data_temp/tc25_usaf_aro/screenshot_nhc/"
os.chdir(nhc_dropbox_path)
today=datetime.today().strftime('%Y-%m-%d')
save_folder = str(today)
os.makedirs(save_folder, exist_ok=True)

oceans=[epac_url,cpac_url,atlantic_url]
# Start Selenium
driver = webdriver.Chrome()
# driver.get(epac_url)
# driver.get(cpac_url)
# driver.get(atlantic_url)

for url in oceans:
    driver.get(url)
    time.sleep(2)
    # Find all img tags ending with .png
    img_links = driver.find_elements(By.CSS_SELECTOR, "img[src$='7d0.png']")

    for i, link in enumerate(img_links, start=1):
        img_url = link.get_attribute("src")

        try:
            # Using JavaScript to fetch img as base64 
            # Bypasses issues with (browser 403)
            img_base64 = driver.execute_async_script("""
                const url = arguments[0];
                const callback = arguments[1];
                fetch(url)
                .then(response => response.blob())
                .then(blob => {
                    const reader = new FileReader();
                    reader.onload = () => callback(reader.result);
                    reader.readAsDataURL(blob);
                })
                .catch(err => callback(null));
            """, img_url)

            if img_base64:
                header, encoded = img_base64.split(",", 1)
                data = base64.b64decode(encoded)

                filename = os.path.join(save_folder, os.path.basename(img_url))
                with open(filename, "wb") as f:
                    f.write(data)
                print(f"[{i}] Saved {filename}")
            else:
                print(f"[{i}] Failed to fetch {img_url}")
        except Exception as e:
            print(f"[{i}] Error downloading {img_url}: {e}")

driver.quit()
print("Image downloaded.")

os.chdir(nhc_dropbox_path+str(today))
os.rename('two_atl_7d0.png', str(today)+'_atlantic.png')
os.rename('two_pac_7d0.png', str(today)+'_epac.png')
os.rename('two_cpac_7d0.png', str(today)+'_cpac.png')