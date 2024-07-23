# DUE TO CHANGES IN POWERSHELL: PSNetMon will no longer be mantained.
# PSNetMon
<IMG SRC="https://github.com/bvoris/PSNetMon/blob/master/screenshots/psnetmonss00.PNG"><BR /> 
PSNetMon - PowerShell Network Resource Monitoring Tool v4.5 <BR />
PSNetMon is a completely PowerShell driven resource monitoring tool. It is completely open source.<BR />
PSNetMon can be run from any computer with PowerShell 5.X (Not Compatible with PoSh 6.x+).<BR /><BR />
Description: Network resource monitoring utility written in HTML and PowerShell. Completely customizable. Monitor hosts, ports and services. Always a work in progress. Looking for others to help with development. <BR />
Contributors always welcome!<BR /><BR />
Created By: Brad Voris<BR />
<img alt="GitHub followers" src="https://img.shields.io/github/followers/bvoris?style=social">
<img alt="GitHub User's stars" src="https://img.shields.io/github/stars/bvoris?style=social"><BR />
<img alt="GitHub" src="https://img.shields.io/github/license/bvoris/PSNetMon">
<img alt="GitHub commit activity" src="https://img.shields.io/github/commit-activity/m/bvoris/PSNetMon">
<img alt="GitHub All Releases" src="https://img.shields.io/github/downloads/bvoris/PSNetMon/total">
<img alt="GitHub repo size" src="https://img.shields.io/github/repo-size/bvoris/PSNetMon">
<img alt="GitHub language count" src="https://img.shields.io/github/languages/count/bvoris/PSNetMon">
<img alt="GitHub issues" src="https://img.shields.io/github/issues/bvoris/PSNetMon">
<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/bvoris/PSNetMon">



# CODE BASE:
Base menu system - all HTML base menu system files stored in c:\inetpub\wwwroot<BR />
PowerShell - all scripts stored in c:\inetpub\wwwroot\scripts<BR />
CFG - all configuration files for variables stored in c:\inetpub\wwwroot\cfg<BR />
HTML - all scripts write results to HTML files stored in and c:\inetpub\wwwroot\gen directories<BR />
CSS - customizable cascading style files used for customizing the appearance of PSNetMon<BR /><BR />
Base file system will resemble the following:<BR />
<IMG SRC="https://github.com/bvoris/PSNetMon/blob/master/screenshots/psnetmonss04.PNG"><BR /> 

This is still a work in progress and incomplete but it is a network monitoring utility. This is a tool was developted to help monitor hosts, ports, and services on a network. It is designed to be completely customizable and written in PowerShell and HTML with no additional plugins. Small form factor with a total install base of under 10MB. Designed with small environments in mind. Anyone interested in assisting with this project please let me know.


# Prerequisites
Microsoft Windows 7 or higher<BR />
IIS Web Server (Internet Information Services) (any version will do)<BR />
Powershell 5.x (6.x & 7.x not supported)<BR />

 
# Download and Installation

Download PSNetMon.zip to the computer<BR />
Unzip the contents of PSNetMon.zip to the Inetpub\wwwroot directory and overwrite the existing files (if this is a new webserver install)<BR /><BR />


Follow instructions in docs\How to install PSNetMon.docx<BR /><BR />

* report files will grow with the data that is written from the script files. this data is very small but eventually you may want to archive or delete the report files

reports are disabled but can be re-enabled by creating new CSV files and placing them in the \reports directory named icmp.csv, ports.csv, count.csv, services.csv<BR /><BR />

# PSNetMon To Do list
- [x] Consolidate code
- [x] Remove old menu system
- [x] IPv6 Support
- [x] Implement weather system information based on existing project and webscrapping
- [x] Dashboard clean-up
- [ ] Review feature requests


# Screenshots for this project:
Main Dashboard v4.5<BR />
<IMG SRC="https://github.com/bvoris/PSNetMon/blob/master/screenshots/psnetmonss01.PNG"><BR />
Support Page v4.5<BR />
<IMG SRC="https://github.com/bvoris/PSNetMon/blob/master/screenshots/psnetmonss02.PNG"><BR />


# RECENT CHANGES FOR 4.5
4.5 2-2022 - 5-2022 Public release update
Overall Changes: Versioning added tp scripts<BR />
removed deprecated C# code for date and time stamp added new dated conversion function<BR /> 
fix date time function with 12 hour vs 24 hour time<BR /> 
fixed broken count function for multiple counts<BR /> 
removed Technet link<BR /><BR />
Support: additional support functionality and integration for Linux by removing depricated C# calls.<BR /> 
Converted C# calls to PowerShell 7.x+ capatibility (Not fully compatible with 7.x)<BR />
Added meta tag for 30 minute refresh of index.html (rectifies internal server failure error)<BR /><BR />
Structure:  renamed menu_2 to menu (left over from original menu systems)<BR />
Function Additions: Host Report button and function added. <BR />
Seperate script to run weekly or monthly ONLY<BR />
Added PSNetMon Security Report<BR />
Current Time added to Alerts via JavaScript<BR />
IPv6 support<BR /><BR />

## Connect with me at

<a href="https://twitter.com/HMInfoSecViking?ref_src=twsrc%5Etfw"><IMG SRC="https://github.com/bvoris/bvoris/blob/master/twitter.jpg" WIDTH=10% HEIGHT=10% ALIGN=LEFT></a>

<a href="https://www.linkedin.com/in/brad-voris" target="_blank"><IMG SRC="https://github.com/bvoris/bvoris/blob/master/linkedin.png" WIDTH=10% HEIGHT=4% ALIGN=RIGHT></a>

<BR /><BR />
<BR /><BR />

<A HREF="https://www.victimoftechnology.com">Victim Of Technology<A />
<BR /><BR />
<A HREF="https://www.cyberforgesecurity.com">Cyber Forge Security, Inc.<A />
<BR /><BR />
