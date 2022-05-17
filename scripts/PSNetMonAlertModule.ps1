# Name: Powershell Network Monitor Alerts Module
# Written by: Brad Voris
# Description: Alerts page for custom modules
# Additional Notes: None
# Version: 4.5

#HTML Header Coding
$HTMLHeaderAM = @"
<HTML>
    <HEAD>
    <TITLE> 
    PSNetMon - Alert Panel Module
    </TITLE>
<LINK REL="STYLEsheet" TYPE="text/css" HREF="../css/theme.css"> 
</HEAD>
"@

#Html Body Coding
$HTMLBodyAM = @"
<BODY onload="startTime()">
<CENTER>
<B>Current Time</B><BR>
<div id="clock"></div>
<script>
setInterval(myTimer, 1000);

function myTimer() {
  const d = new Date();
  document.getElementById("clock").innerHTML = d.toLocaleTimeString();
}
</script>

<B><div id="MyClockDisplay" class="clock" onload="showTime()"></div></B>

<!--Insert Modules below here-->
<!--Determine width and height of module based on need-->
<!--Weather Module-->
<IFRAME TITLE="Local Weather" SRC="weather.html" frameBorder=0 style="width:100%;height:160PX;"></IFRAME>
<!--RSS Feed module-->   
<IFRAME TITLE="RSSTicker" SRC="rssticker.html" frameBorder=0 style="width:100%;height:350PX;"></IFRAME>

</BODY>
</HTML>
"@

#HTML Export
$Script | ConvertTo-HTML -Head $HTMLHeaderAM -Body $HTMLBodyAM  | Out-File "C:\inetpub\wwwroot\gen\alerts.html"