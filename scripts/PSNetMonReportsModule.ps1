﻿# Name: Powershell Network Monitor Reports Script
# Description: This script is used to generate results for the reports.html page
#Script variables
#Script commands to parse config files
$HTMLHeadCOM = @"
<META http-equiv="refresh" CONTENT="30">
<TITLE> 
PSNetMon - Count Module
</TITLE>
<HEAD>
<LINK REL="STYLEsheet" TYPE="text/css" HREF="../css/theme.css"> 
</HEAD>

$HTMLBodyCOM = @"

# Export to HTML