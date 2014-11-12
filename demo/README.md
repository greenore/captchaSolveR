Web Scraping Documentation
==========================

The idea of this project is to download and parse web data with R. In the initial phase the idea is to implement this for the new Comparis page.

## Installation (Selenium Server)
Alas, the Selenium server file can't be downloaded directly through the Baloise proxy. This means that the installation has to be conducted manually. Enter checkSeleniumServer() to get the instruction on how to download the server file. 

Important: In order to run the selenium java server, the system installation of java has to be in the system path (windows environment variable). On Windows 7 this means to follow the procedure below: 

- From the desktop, right click the Windows icon.
- Choose "Properties"" from the context menu.
- Click the "Advanced system settings"" link.
- Click "Environment Variables". In the section "System Variables"", find the "PATH environment variable"" and select it. Click Edit
- In the "Edit System Variable"" (or New System Variable) window, specify the value of the PATH environment variable (e.g., *C:\Program Files\Java\jdk1.7.0_21\bin;*).
- Click OK. Close all remaining windows by clicking OK.

## Available browsers
- Firefox
- Google Chrome
- Internet Explorer
- Phantomjs (headless browser)

### Available browsers on a Baloise machines
- Firefox
- Google Chrome (limited mode, i.e., w/o profiles)

### How to install Chrome
Using Chrome as a remote driver can be considered as having three parts and therefore it is necessary to install all those parts. There is the browser itself (*"chrome"*), the language bindings provided by the Selenium project (*"the driver"*) and an executable downloaded from the Chromium project which acts as a bridge between "chrome" and the "driver".

This executable is called "chromedriver". It is necessary to have a "chromedriver" running. The download directory for chromedriver is currently located at http://chromedriver.storage.googleapis.com/index.html. The most update version of chromedriver at the time of writing was 2.9.

Download the appropriate file for windows and extract the .exe to a folder of your own choosing (e.g., C:\Users\b029580\NoBackupData\Software\Selenium). The .exe can be placed wherever *but it must be in the system path* (see the guide above to do the same). 

## How to run the analysis
Open the file "01_main.R" and run the code. 
