# Name: Powershell Network Monitor RSS Feed Ticker
# Written by: Brad Voris# Description: This script is used to generate results for the rssticker.html page
# Additional Information: N/A# Version: 4.5#Script variables
$dated = Get-Date -format "MM/dd/yyyy hh:mm tt"
$rssfeeds = get-content "C:\inetpub\wwwroot\cfg\rssfeedstreams.cfg" -first 2

#1st RSS Feed Stream
#ForEach ($rssfeed in $rssfeeds) {
#  $rssfeedstreamsdes = (Invoke-RestMethod -Uri $rssfeed | Select-object -expandproperty description -first 5 | Out-String) -replace '<.*?>',''
#  $rssfeedstreamslink = Invoke-RestMethod -Uri $rssfeed | Select-object -expandproperty link -first 5 | Format-List | Out-String
#  $rssfeedstreams = Invoke-RestMethod -Uri $rssfeed | Select-object title -first 5 | ConvertTo-Html 
#}
$feedstreams = @()
$feedstreams = $rssfeeds | Where-Object {-not ($_.StartsWith('#'))} | ForEach-Object { Invoke-RestMethod -Uri $_ | Select-Object title, link, description -first 5}$feedtitle = $feedstreams.title$feedlink = $feedstreams.link$feeddes = ($feedstreams.description | Out-String) -replace '<.*?>',''
#HTML Header Coding
$HTMLHeadRSSM = @"
<!DOCTYPE html>
<HEAD>
<META charset="UTF-8">
<TITLE>PSNetMon - RSS Ticker Module</TITLE>
<CENTER>
<META http-equiv="refresh" CONTENT="60">
<LINK REL="STYLEsheet" TYPE="text/css" HREF="../css/theme.css"> </HEAD>
"@

#HTML Body Coding
$HTMLBodyRSSM = @"<CENTER><TABLE  border="0"><B>RSS Feeds</B><BR>
<I>$Dated</I><BR>
<TR bgcolor=#5CB3FF>
<TD><UL><A HREF="$feedlink" target=”_blank” Title="$feeddes"><LI>$feedtitle</LI></A><UL></TD>
</TR>
</TABLE></CENTER>"@

#Export to HTML
$Script | ConvertTo-HTML -Head $HTMLHeadRSSM -Body $HTMLBodyRSSM | Out-file "C:\inetpub\wwwroot\gen\rssticker.html"

