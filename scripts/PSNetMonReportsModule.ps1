# Name: Powershell Network Monitor Reports Script# Written by: Brad Voris
# Description: This script is used to generate results for the reports.html page# Additional Notes: None# Version: 4.5
#Script variables$dated = Get-Date -format "MM/dd/yyyy hh:mm tt"
#Script commands to parse config files$getfiledata = Get-ChildItem -Path  "c:\inetpub\wwwroot\reports\" | format-table Name | out-string;#HTML Header Coding
$HTMLHeadCOM = @"
<META http-equiv="refresh" CONTENT="30">
<TITLE> 
PSNetMon - Count Module
</TITLE>
<HEAD>
<LINK REL="STYLEsheet" TYPE="text/css" HREF="../css/theme.css"> 
</HEAD><CENTER>"@
#HTML Body Coding
$HTMLBodyCOM = @"<CENTER><B>Report Data</B><BR /><TABLE><TR BGCOLOR=#2554C7><TD>Report Data</TD></TR><TR BGCOLOR=#5CB3FF><TD>$getfiledata</TD></TR></TABLE><I>$Dated</I></CENTER>"@

# Export to HTML$Script | ConvertTo-HTML -Head $HTMLHeadCOM -Body $HTMLBodyCOM | Out-file "C:\inetpub\wwwroot\gen\reports.html"