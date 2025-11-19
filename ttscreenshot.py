from selenium import webdriver
from selenium.webdriver.common.by import By
import requests
import os
import time
from urllib.parse import urljoin
import base64
from datetime import datetime
import glob
from pathlib import Path

# URL of the page
url = "https://www.tropicaltidbits.com/recon/"

# Folder to save the images
home_dir = Path.home()
tt_dir=f"{home_dir}/agsd Dropbox/agsd's shared workspace/data_temp/hiaper/2026.00x_ar2026_datalog/tropical_tidbit_screenshots/"
os.chdir(tt_dir)
today=datetime.today().strftime('%Y-%m-%d')
save_folder = str(today)
os.makedirs(save_folder, exist_ok=True)

# Start Selenium
driver = webdriver.Chrome()
driver.get(url)

# Waits for 2 secs
# time.sleep(2)

# Find all img tags ending with .png
img_links = driver.find_elements(By.CSS_SELECTOR, "img[src$='dropsondes.png']")

print(f"Found {len(img_links)} PNG files.")


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

print("Done saving PNG files to folder:", save_folder)

# rename based on time
today_dir=os.path.join(tt_dir,save_folder) 
current_time=datetime.today().strftime('%H')
os.chdir(today_dir) # chdir into today's folder
today_images=glob.glob("*dropsondes.png") # find the relevant files

for image in today_images:
    root,ext=os.path.splitext(image)
    new_name=f"{root}_{current_time}pst{ext}"
    os.rename(image,new_name)
    print(f"{image} new name is {new_name}")