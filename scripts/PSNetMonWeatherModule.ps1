# Name: Powershell Network Monitor Weather Module
# Written by: Brad Voris
# Description: This script is used to generate current weather conditions
# Additional Notes: $ZipCode should be changed to your location
# Version: 4.5

#Script variables
$dated = Get-Date -format "MM/dd/yyyy hh:mm tt"
$zipcode = Get-Content -Path "C:\inetpub\wwwroot\cfg\zipcode.cfg"

#Script commands to parse config files
$uri = "https://weather.com/weather/today/l/$zipcode"
$data = Invoke-WebRequest $uri
$data = Invoke-WebRequest $uri
$TodaysWeather = $data.ParsedHtml.body.getElementsByTagName('div') | 
    Where-Object {$_.getAttributeNode('data-testid').Value -eq 'CurrentConditionsContainer'} | Select-Object -expandProperty outerText


$Currentforcast = $data.ParsedHtml.body.getElementsByTagName('div') | 
    Where-Object {$_.getAttributeNode('id').Value -in 'todayDetails'} | Select-Object -expandProperty outerText

#$TodaysWeather
#$Currentforcast


#HTML Header Coding
$HTMLHeadCOM = @"
<META http-equiv="refresh" CONTENT="30">
<TITLE> 
PSNetMon - Weather Module
</TITLE>
<HEAD>
<LINK REL="STYLEsheet" TYPE="text/css" HREF="../css/theme.css"> 
</HEAD>
<CENTER>
"@

#HTML Body Coding
$HTMLBodyCOM = @"
<CENTER>
<TABLE>
<B>Weather</B><BR>
<I>$Dated</I>
<TR BGCOLOR=#2554C7>
<TD>Todays Weather</TD>
</TR>
<TR BGCOLOR=#5CB3FF>
<TD>$TodaysWeather</TD>
</TR>
<TR BGCOLOR=#2554C7>
<TD>Today's Forecast</TD>
</TR>
<TR BGCOLOR=#5CB3FF>
<TD>$Currentforcast</TD>
</TR>
</TABLE>
</CENTER>
"@


# Export to HTML
 ConvertTo-HTML -Head $HTMLHeadCOM -Body $HTMLBodyCOM | Out-file "C:\inetpub\wwwroot\gen\weather.html"