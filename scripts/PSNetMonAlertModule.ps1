# PSNetMon - Alerts Script
# Written by Brad Voris
# Description: Alerts page for custom modules

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
<BODY>
    <CENTER>
    <SCRIPT TYPE="text/javascript">
tday=new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");
tmonth=new Array("January","February","March","April","May","June","July","August","September","October","November","December");

function GetClock(){
var d=new Date();
var nday=d.getDay(),nmonth=d.getMonth(),ndate=d.getDate(),nyear=d.getYear(),nhour=d.getHours(),nmin=d.getMinutes(),ap;
     if(nhour==0){ap=" AM";nhour=12;}
else if(nhour<12){ap=" AM";}
else if(nhour==12){ap=" PM";}
else if(nhour>12){ap=" PM";nhour-=12;}

if(nyear<1000) nyear+=1900;
if(nmin<=9) nmin="0"+nmin;

document.getElementById('clockbox').innerHTML=""+tday[nday]+", "+tmonth[nmonth]+" "+ndate+", "+nyear+" "+nhour+":"+nmin+ap+"";
}

window.onload=function(){
GetClock();
setInterval(GetClock,1000);
}
</SCRIPT>
<B>Todays Date is:</B>
<DIV id="clockbox"></DIV>

<!--Insert Modules below here-->
<!--Determine width and height of module based on need-->
<!--Weather Module-->
<!--<IFRAME TITLE="Weather" SRC="weather.html" frameBorder=0 style="width:100%;height:300PX;"></IFRAME>-->
<!--RSS Feed module-->   
<IFRAME TITLE="RSSTicker" SRC="rssticker.html" frameBorder=0 style="width:100%;height:350PX;"></IFRAME>

</BODY>
</HTML>
"@

#HTML Export
$Script | ConvertTo-HTML -Head $HTMLHeaderAM -Body $HTMLBodyAM  | Out-File "C:\inetpub\wwwroot\gen\alerts.html"