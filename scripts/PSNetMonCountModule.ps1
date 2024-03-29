# Name: Powershell Network Monitor Count Module# Written by: Brad Voris
# Description: This script is used to generate results for the count.html page# Additional Notes: None# Version: 4.5
#Script variables$dated = Get-Date -format "MM/dd/yyyy hh:mm tt"
#Script commands to parse config files[array]$hostsarray = Get-Content -Path "C:\inetpub\wwwroot\cfg\computers.cfg"[array]$portarraya = Get-Content -Path "C:\inetpub\wwwroot\cfg\porthostsa.cfg"[array]$portarrayb = Get-Content -Path "C:\inetpub\wwwroot\cfg\porthostsb.cfg"[array]$servicesaarray = Get-Content -Path "C:\inetpub\wwwroot\cfg\servicesa.cfg"[array]$servicesbarray = Get-Content -Path "C:\inetpub\wwwroot\cfg\servicesb.cfg"[array]$servicescarray = Get-Content -Path "C:\inetpub\wwwroot\cfg\servicesc.cfg"#Calculate Length of config file contents$hoststotal=$hostsarray.length$portatotal=$portarraya.length$portbtotal=$portarrayb.length$servicetotal=$servicesaarray.length+$servicesbarray.length+$servicescarray.length$porttotal = $portatotal+$portbtotal
#HTML Header Coding
$HTMLHeadCOM = @"
<META http-equiv="refresh" CONTENT="30">
<TITLE> 
PSNetMon - Count Module
</TITLE>
<HEAD>
<LINK REL="STYLEsheet" TYPE="text/css" HREF="../css/theme.css"> 
</HEAD><CENTER>"@
#HTML Body Coding
$HTMLBodyCOM = @"<CENTER><B>Monitored Resources</B><BR /><I>$Dated</I><TABLE><TR BGCOLOR=#2554C7><TD>Hosts</TD> <TD>Ports</TD> <TD>Services</TD></TR><TR BGCOLOR=#5CB3FF><TD>$hoststotal</TD><TD>$porttotal</TD><TD>$servicetotal</TD></TR></TABLE></CENTER>"@
# Export to CSV for reports#$countresults2=@"#$Dated,$hoststotal,$servicetotal,$porttotal#"@#$countresults2 | Add-Content "C:\inetpub\wwwroot\reports\count.csv"
# Export to HTML$Script | ConvertTo-HTML -Head $HTMLHeadCOM -Body $HTMLBodyCOM | Out-file "C:\inetpub\wwwroot\gen\count.html"