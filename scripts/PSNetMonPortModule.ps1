# Name: Powershell NetMon Port Monitor Module# Written by: Brad Voris
# DescriptionL Script scans port to check status if available# Additional Notes: None# Version: 4.5
#Variables$dated = Get-Date -format "MM/dd/yyyy hh:mm tt"

#HTML Head
$HTMLHeadPRTM = @"
<!DOCTYPE html>
<HEAD>
<META charset="UTF-8">
<TITLE>PSNetMon - Port Monitor Module</TITLE>
<CENTER>
<LINK REL="STYLEsheet" TYPE="text/css" HREF="../css/theme.css"> </HEAD>
"@
#  Get content from config files$hostida = (get-content  "C:\inetpub\wwwroot\cfg\porthostsa.cfg" | Where-Object {-not ($_.StartsWith('#'))})$portnumbera = (get-content "C:\inetpub\wwwroot\cfg\portcfga.cfg" | Where-Object {-not ($_.StartsWith('#'))})$hostidb = (get-content  "C:\inetpub\wwwroot\cfg\porthostsb.cfg" | Where-Object {-not ($_.StartsWith('#'))})$portnumberb = (get-content "C:\inetpub\wwwroot\cfg\portcfgb.cfg" | Where-Object {-not ($_.StartsWith('#'))})
#Check status of ports single port A$socketa = new-object Net.Sockets.TcpClient$socketa.Connect($hostida, $portnumbera)if ($socketa.Connected) {$statusa = “Port Open”$socketa.Close()}else {$statusa = “Port Closed”}
#HTML Body Content
$HTMLBodyPRTM = @"<CENTER><META http-equiv="refresh" CONTENT="30">
<FONT size=4><B>Monitored Ports</B></FONT></BR><I>$dated</I><BR /><TABLE><TR bgcolor=#2554C7><TD>Hosts</TD> <TD>Port Number</TD> <TD>Status</TD></TR><TR bgcolor=#5CB3FF><TD>$hostida</TD> <TD>$portnumbera</TD> <TD>$statusa</TD></TR></TABLE></CENTER>"@
#Check status of ports single port B$socketb = new-object Net.Sockets.TcpClient$socketb.Connect($hostidb, $portnumberb)if ($socketb.Connected) {$statusb = “Port Open”$socketb.Close()}else {$statusb = “Port Closed”}
#HTML Body Content
$HTMLBodyPRTM = $HTMLBodyPRTM + @"<CENTER><BR /><TABLE><TR bgcolor=#2554C7><TD>Hosts</TD> <TD>Port Number</TD> <TD>Status</TD></TR><TR bgcolor=#5CB3FF><TD>$hostidb</TD> <TD>$portnumberb</TD> <TD>$statusb</TD></TR></TABLE></CENTER>"@
# CSV for reports#$countresults1=@"#$Dated,$hostida,$portnumbera,$statusa,$Dated,$hostidb,$portnumberb,$statusb#"@#$countresults1 | Add-Content "C:\inetpub\wwwroot\reports\ports.csv"
#$countresults2=@"#$Dated,$hostidb,$portnumberb,$statusb#"@#$countresults2 | Add-Content "C:\inetpub\wwwroot\reports\ports.csv"
#Export to HTMLConvertTo-HTML -head $HTMLHeadPRTM -body $HTMLBodyPRTM | out-file "C:\inetpub\wwwroot\gen\porthosts.html"