###################################################################################################
# PSNetMon - Alerts Script
# Written by Brad Voris & Lilo Elia (weather widget)
###################################################################################################
#Yahoo Weather Forcast originally developed by: Lilo Elia
#require -version 2.0
#require -shellid PoshConsole
###################################################################################################
## Get-Weather 
## Parse and display the current weather and forecast from yahoo RSS
## Note that you _could_ modify this a bit to return "current condition" and "forecast" objects
##   but for now, it just prints them out in a relatively nice format
###################################################################################################
## Version History:
## 2.1 - Updated for Out-WPF 2.0, can show -Popup graphics even in PowerShell.exe (with Out-WPF)
## 2.0 - Updated for Out-WPF and PoshConsole, now shows inline graphics in PoshConsole, 
## 1.1 - Added TempColor function
## 1.0 - My initial cleanup of a script from 
##       http`://fortheloveofcode.wordpress.com/2008/04/28/powershell-webservice-client/
#########
## ToDo: Color code the "text": Showers/Rain/Snow/...
## ToDo: Pull out extreme weather *Warnings*
## ToDo: Parse wind and show the wind-chill when temp is cold
###################################################################################################
# function get-weather {

param($zip=77002,[switch]$Celcius,[switch]$Popup)
$Url = "http`://weather.yahooapis.com/forecastrss?p={0}{1}" -f $zip, $(if($Celcius){"&u=c"})

$Channel = ([xml](New-Object Net.WebClient).DownloadString($Url)).rss.channel

function TempColor ($Temp) {
   if($Celcius) { 
      if( $Temp -lt 0 ) { "blue" } elseif( $Temp -le 10 ) { "cyan" } elseif( $Temp -le 21 ) { "blue" } elseif( $Temp -lt 27 ) { "green" } else { "red" } 
   } else { 
      if( $Temp -lt 5 ) { "blue" } elseif( $Temp -le 50 ) { "cyan" } elseif( $Temp -le 70 ) { "blue" } elseif( $Temp -lt 80 ) { "green" } else { "red" }
   }
}

if($Channel) {
   if( ($Host.PrivateData.GetType().Name  -eq "PoshOptions") -OR ( $Popup -AND (Get-Command Out-WPF -Type Cmdlet -EA SilentlyContinue))) { 

      # alternate images: http`://l.yimg.com/us.yimg.com/i/us/we/52/
      $Template = @"
  <StackPanel xmlns="http`://schemas.microsoft.com/winfx/2006/xaml/presentation" >
  <TextBlock FontFamily="Constantia" FontSize="12pt">{0}, {1} {2}</TextBlock>
  <StackPanel Orientation="Horizontal">
  <StackPanel VerticalAlignment="Top" Margin="6,2,6,2" ToolTip="{3}">
  <Image Source="http`://image.weather.com/web/common/wxicons/52/{4}.png" Stretch="Uniform"
         Width="{{Binding Source.PixelWidth,RelativeSource={{RelativeSource Self}}}}"
         Height="{{Binding Source.PixelHeight,RelativeSource={{RelativeSource Self}}}}" />
  <TextBlock TextAlignment="Center"><Run FontWeight="700" Text="Now: " /><Run Foreground="{5}"> {6}{7}</Run></TextBlock>
  </StackPanel>
  <StackPanel VerticalAlignment="Top" Margin="6,2,6,2" ToolTip="{8}">
  <Image Source="http`://image.weather.com/web/common/wxicons/52/{9}.png" Stretch="Uniform"
         Width="{{Binding Source.PixelWidth,RelativeSource={{RelativeSource Self}}}}"
         Height="{{Binding Source.PixelHeight,RelativeSource={{RelativeSource Self}}}}" />
  <TextBlock TextAlignment="Center">
    <Run FontWeight="700">{10}</Run><LineBreak/>
    <Run Foreground="{11}">{12}{7}</Run> - <Run Foreground="{13}">{14}{7}</Run></TextBlock>
  </StackPanel>
  <StackPanel VerticalAlignment="Top" Margin="6,2,6,2" ToolTip="{15}">
  <Image Source="http`://image.weather.com/web/common/wxicons/52/{16}.png" Stretch="Uniform"
         Width="{{Binding Source.PixelWidth,RelativeSource={{RelativeSource Self}}}}"
         Height="{{Binding Source.PixelHeight,RelativeSource={{RelativeSource Self}}}}" />
  <TextBlock TextAlignment="Center">
  <Run FontWeight="700">{17}</Run><LineBreak/>
  <Run Foreground="{18}">{19}{7}</Run> - <Run Foreground="{20}">{21}{7}</Run></TextBlock>
  </StackPanel>
  </StackPanel>
  </StackPanel>
"@ 

      $Template = ($Template -f $Channel.location.city,  $Channel.location.region, $Channel.lastBuildDate, 
      $Channel.item.condition.text, $Channel.item.condition.code, (TempColor $Channel.item.condition.temp), $Channel.item.condition.temp,
      $Channel.units.temperature, $Channel.item.forecast[0].text, $Channel.item.forecast[0].code, 
      $Channel.item.forecast[0].day, (TempColor $Channel.item.forecast[0].low), $Channel.item.forecast[0].low, (TempColor $Channel.item.forecast[0].high), $Channel.item.forecast[0].high, 
      $Channel.item.forecast[1].text, $Channel.item.forecast[1].code, $Channel.item.forecast[1].day,
      (TempColor $Channel.item.forecast[1].low), $Channel.item.forecast[1].low, (TempColor $Channel.item.forecast[1].high), $Channel.item.forecast[1].high)

      $Template | out-clipboard
      ## Work around defect in Out-WPF that hides -POpup when -Popup is implied. Silly of me.
      if($Host.PrivateData.GetType().Name  -eq "PoshOptions") {
         Out-WPF -SourceTemplate $Template -Popup:$Popup
      } else {
         Out-WPF -SourceTemplate $Template 
      }

   } else { # "ConsoleColorProxy"
      
      $Current = $Channel.item.condition
      Write-Host
      Write-Host ("Location:    {0}" -f $Channel.location.city)
      Write-Host ("Last Update: {0}" -f $Channel.lastBuildDate)
      Write-Host ("Weather:     {0}" -f $Current.text)-NoNewline
      Write-Host (" {0}°{1}" -f $Current.temp, $(if($Celcius){"C"}else{"F"})) -ForegroundColor $(TempColor $Current.temp)
      Write-Host
      Write-Host "Forecasts"
      Write-Host "---------"
      foreach ($F in $Channel.item.forecast) {
         Write-Host ("`t{0}, {1}: {2}" -f $F.day, $F.date, $F.text) -NoNewline
         Write-Host (" {0}-{1}°{2}" -f $F.low, $F.high, $(if($Celcius){"C"}else{"F"})) -ForegroundColor $(TempColor $F.High)
      }
      Write-Host
   }
}
#############################################################################################################################
#Variables for HTML Export
#############################################################################################################################
$LocationVAR = ("Location:    {0}" -f $Channel.location.city) 
$LastUpdateVAR = ("Last Update: {0}" -f $Channel.lastBuildDate)
$WeatherVAR1 = ("Weather:     {0}" -f $Current.text)
$WeatherVAR2 = (" {0}°{1}" -f $Current.temp, $(if($Celcius){"C"}else{"F"})) 
$CityLocationVAR = $Channel.location.city
$DailyVar1 = foreach ($F in $Channel.item.forecast) {
          ("`t{0}, {1}: {2}" -f $F.day, $F.date, $F.text) 
         (" {0}-{1}°{2}" -f $F.low, $F.high, $(if($Celcius){"C"}else{"F"}))
      }

$Var01 = $DailyVar1.Split("`t")
$DailyVar1.Split("`t") | ForEach {Write-Host ("$_")}

$CSS = Get-Content "C:\inetpub\wwwroot\css\theme.css"

#HTML Header Coding
$HTMLHeader = @"
<HTML>
    <HEAD>
    <TITLE> 
    PSNetMon - Alert Panel Module
    </TITLE>
    <STYLE>$CSS</STYLE>
    </HEAD>
"@

#Html Body Coding
$HTMLBody = @"
<BODY>
    <CENTER>
    <script type="text/javascript">
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
</script>
<div id="clockbox"></div>
</BR>
    <U>Current Weather Forecast for: $CityLocationVAR</U><BR />
    Todays $WeatherVAR1, $WeatherVAR2<BR /><BR />
    <U>Future Five Day Forcast for $CityLocationVAR</U><BR />
   $Var01<BR /><BR />

<!--Insert Modules below here-->
<!--Determine width and height of module based on need-->
<!--Camera module-->
<IFRAME  src="cameras.html" frameBorder=0 style="width:100%;height:400PX;"></IFRAME>
<!--RSS Feed module-->   
<IFRAME  src="rssticker.html" frameBorder=0 style="width:100%;height:440PX;"></IFRAME>

</BODY>
</HTML>
"@

#HTML Export
$Script | ConvertTo-HTML -Head $HTMLHeader -Body $HTMLBody  | Out-File "C:\inetpub\wwwroot\gen\alerts.html"
#}