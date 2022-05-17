# Name: Powershell Network Monitor Support Page
# Written by: Brad Voris# Description: This script is used to generate results for the support.html page
# Additional Information: N/A# Version: 4.5

#Variables, Functions, and Processes
$dated = Get-Date -format "MM/dd/yyyy hh:mm tt"

$foldersize = "{0:N2} MB" -f ((get-childitem –force C:\inetpub\wwwroot –Recurse -ErrorAction SilentlyContinue| Measure-Object Length -s).sum / 1MB)

$processinfo = Get-Process w3wp -IncludeUserName | ConvertTo-Html `
    @{Label = "Non-Paged Memory Kb"; Expression = {[int]($_.NPM / 1024)}},
    @{Label = "Paged Memory Kb"; Expression = {[int]($_.PM / 1024)}},
    @{Label = "Working Set Mb"; Expression = {[int]($_.WS / 1024)}},
    @{Label = "Virtual Memory Mb"; Expression = {[int]($_.VM / 1MB)}},
    @{Label = "CPU(s)"; Expression = {if ($_.CPU) {$_.CPU.ToString("N")}}},
    Id, ProcessName

$processver = Get-process w3wp -FileVersionInfo
$serviceinfo = get-service w3svc | Select-Object DisplayName, Name, Status, RequiredServices| ConvertTo-Html

#HTML Header Coding
$HTMLHeadSup = @"
<!DOCTYPE html>
<HEAD>
<META charset="UTF-8">
<TITLE>PSNetMon - Support Module</TITLE>
<LINK REL="STYLEsheet" TYPE="text/css" HREF="../css/theme.css"> </HEAD>
"@

#HTML Body Coding
$HTMLBodySup = @"<BODY><B>PSNetMon - PowerShell Network Monitoring Utility Credits:</B></BR></BR>


<B>Design and layout:</B></BR>
Brad Voris</BR></BR>

<B>Scripting:</B></BR>
By: Brad Voris</BR></BR>


<B>CSS Button Design:</B></BR>
http://www.bestcssbuttongenerator.com</BR></BR>

<B>Special Thanks:</B></BR>
My wife for her patience with me as I tinker away late at night on I.T. stuff</BR>
The Scripting Guy Technet blog</BR>
The Scripting Guys for assistance in just about every aspect of Powershell, WMI, VBScript, and batch file configuration over the years</BR>
Willie Horn</BR>
Microsoft Technet </BR></BR>

<B>Brad Voris Bio:</B></BR>
An Information Technology and Information Security Professional since 1999. Brad Voris has numerous certifications across multiple domains, written and published numerouse articles for the Information Technology/Security Communities.</BR></BR>

<a href="https://drive.google.com/open?id=1DzQY4ea9uMTXVPRR-U3rWyW6Fox7yybid71V0mtI0Mc" target="_blank">Link to My Resume</a></BR></BR>
<a href="https://www.linkedin.com/in/brad-voris" target="_blank">Link to My LinkedIn Profile</a></BR></BR>

<B>For Technical Support:</B></BR>
For Support of PSNetMon reachout to me via Technet at the following link:</BR>
<A HREF="https://github.com/bvoris/PSNetMon" target="_blank">PSNetMon's New GitHub Home</A></BR></BR>

<B>Support Resource Information:</B></BR></BR>
<I>$Dated</I><BR>
<B>Service Information</B></BR>
$serviceinfo<BR></BR>
<B>File Size Information</B></BR>
File Size for C:\Inetpub\wwwroot $foldersize<BR></BR>
<B>Process Information</B></BR>
$processver<BR></BR>
$Processinfo<BR></BR>
</BODY>"@#Export to HTML
$Script | ConvertTo-HTML -Head $HTMLHeadSup -Body $HTMLBodySup | Out-file "C:\inetpub\wwwroot\gen\support.html"