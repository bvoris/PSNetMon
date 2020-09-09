# PSNetMon
PSNetMon - PowerShell Network Resource Monitoring Tool <BR />
PSNetMon is a completely PowerShell driven resource monitoring tool. It is completely open source.<BR />
PSNetMon can be run from any computer with PowerShell 3.0 or greater.<BR /><BR />
Network resource monitoring utility written in HTML and PowerShell. Completely customizable. Monitor hosts, ports and services. Always a work in progress. Looking for others to help with development. <BR />
Contributors always welcome!<BR /><BR />

Code Base:<BR /><BR />

PowerShell - all scripts stored in \scripts<BR /><BR />

HTML - all scripts write results to HTML files stored in root and \gen directories<BR /><BR />

CSS - customizable cascading style files used for customizing the appearance of PSNetMon<BR /><BR />

This is still a work in progress and incomplete but it is a network monitoring utility. This is a tool was developted to help monitor hosts, ports, and services on a network. It is designed to be completely customizable and written in PowerShell and HTML with no additional plugins. Small form factor with a total install base of under 1MB. Designed with small environments in mind. Anyone interested in assisting with this project please let me know.

PSNetMon<BR />

By: Brad Voris<BR />

 

Prerequisites<BR />

Microsoft Windows XP (Sp 3) or higher<BR />

IIS Web Server (Internet Information Services) (any version will do)<BR />

Powershell 3.0 or higher<BR />

 

Download and Installation<BR />

Download PSNetMon.zip to the computer<BR />

Unzip the contents of PSNetMon.zip to the Inetpub\wwwroot directory and overwrite the existing files (if this is a new webserver install)<BR /><BR />

 

Follow instructions in docs\How to install PSNetMon.docx<BR /><BR />

* report files will grow with the data that is written from the script files. this data is very small but eventually you may want to archive or delete the report files

reports are disabled but can be re-enabled by creating new CSV files and placing them in the \reports directory named icmp.csv, ports.csv, count.csv, services.csv<BR /><BR />

To Do list
 - [ ] Be awesome
- [ ] Prepare dinner
  - [ ] Research recipe
  - [ ] Buy ingredients
  - [ ] Cook recipe
- [ ] Sleep

Change Revision<BR />

Notes over changes of product<BR />

Rev .01: 3-26-12<BR /

Maps: None Known<BR />

Monitored Hosts: Single Host usable<BR />

Monitored Ports:  Not working<BR />

Monitored Services: Not Working<BR /><BR />

Rev .02: 3-30-12<BR />

Maps: None Known<BR />

Monitored Hosts: Single Host usable<BR />

Monitored Ports:  Not working<BR />

Monitored Services: Not Working<BR /><BR />

Rev 1.00: 3-24-14<BR />

Maps: None Known<BR />

Monitored Hosts: None Known<BR />

Monitored Ports:  Can only monitor a single machine and single port at this time<BR />

Monitored Services: None Known<BR /><BR />

Rev 1.01 4-7-14<BR />

Maps: None Known<BR />

Monitored Hosts: None Known<BR />

Monitored Ports:  Can only monitor a single machine and single port at this time<BR />

Monitored Services: None Known<BR />

Install Guide: Install guide create<BR />

 

Rev 1.02 4-7-14<BR />

Menu_1: Rev now included in index page<BR />

Maps: None Known<BR />

Monitored Hosts: None Known<BR />

Monitored Ports:  Can only monitor a single machine and single port at this time<BR />

Monitored Services: None Known<BR />

Install Guide: None Known<BR />

Credits: Credits added<BR />

Button Coding: Buttons converted to CSS no longer static images previous buttons removed from formatting. Button coding validated in Firefox, IE, Chrome<BR />

Change Revision: Document created<BR /><BR />

 

Rev 2.5 9-4-15<BR />

Overall changes: Removed all frames from HTML<BR />

Code: Optimized code in scripting<BR />

Minimized total number of scripts to single invoking script<BR />

Added new vertical menu system<BR />

Added Alert preview with current weather (changeable to your area code by modifying area code variable) and future forecasts<BR />

Mapped Alert to my home cameras but this can easily be changed to your own camera system, or really anything you want that is HTML based…<BR />

Reporting: Reporting feature now enables export of results to CSV files which will be stored in Reports folder<BR /><BR />

Rev 2.6 9-11-15<BR />

Overall Changes: Correct HTML syntax issues<BR />

Added RSS Feed reader (still in beta)<BR /><BR />

 

2.7 9-14-15<BR />
Overall changes: Correct small issues with notation<BR />

Added RSS Ticker to Alerts<BR />
Created new CSS for RSS Ticker<BR />
Added favicon.ico to root<BR />
Added icon in Index.html, index2.html and logo.html<BR />
Converted Cameras to cameras module which is easier to remove or add from alerts page<BR />
Removed How to install PSNetMon Rev 1.docx to lighten load<BR /><BR />

2.8 9-18-15<BR />
Overall changes: Correct small issues with notation<BR />
Added detailed step by step instructions!!!!<BR /><BR />
 
2.9 5-17-16<BR />
Overall changes: Code Corrections<BR />
Added Functionality:<BR />
PSNetMonSystemInfo.ps1 – new script added for gathering system information (can be used as a module, report or for random information gathering)<BR />
PSNetMonFileSynchScript.ps1 – Checks when files were last changed and generates a web page based on the results. – Request per Technet User gculbert70<BR />
