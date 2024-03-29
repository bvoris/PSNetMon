# Name: Powershell NetMon System Information Module
# Written by: Brad Voris 
# Description: Script that gathers system information and creates an HTML page
# Additional Notes: None
# Version: 4.5
 
#Computer Name 
$HN = "$env:computername.$env:userdnsdomain" 
 
#Date 
$dated = Get-Date -format "MM/dd/yyyy hh:mm tt"
 
#Uptime 
$bootTime = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty LastBootupTime
$upTime = New-TimeSpan -Start $bootTime
$uptimeinmin = [int]$upTime.TotalMinutes
 
#Boot Config  
$BootConfig = Get-CIMInstance -ClassName Win32_BootConfiguration | Select-Object ConfigurationPath | ConvertTo-Html 
 
#System Manufacturing Information  
$SystemInfo = Get-CIMInstance -ClassName Win32_ComputerSystem | Select-Object Model,Manufacturer,PrimaryOwnerName,SystemType |ConvertTo-Html 
 
#BIOS Information  
$BIOS = Get-CIMInstance -ClassName Win32_BIOS | Select-Object  Manufacturer , Version | ConvertTo-Html 
 
#Operating System 
$os = Get-CIMInstance -ClassName Win32_OperatingSystem | Select-Object @{Name="Operating System"; Expression={$_.caption}}, @{Name="Architecture"; Expression={$_.OSArchitecture}}, @{Name="Service Pack"; Expression={$_.ServicePackMajorVersion}} | ConvertTo-Html 
 
#PowerShell Version 
$PowerShellVersion = Get-Host | Select-Object @{Name="Power Shell Version"; Expression={$_.Version}} | ConvertTo-Html 
 
#Processor 
$Processor = Get-CIMInstance -ClassName Win32_Processor | Select-Object Name | ConvertTo-Html 
 
#Memory 
$Memory = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object  @{Name="Total Memory"; Expression={[math]::Round($_.TotalVisibleMemorySize/1KB)}}, @{Name="Free Physical Memory"; Expression={[math]::Round($_.FreePhysicalMemory/1KB)}} | ConvertTo-Html 
 
#Pagefile 
$Pagefile = Get-CIMInstance -ClassName Win32_OperatingSystem | Select-Object @{Name="Total Pagefile Size"; Expression={[math]::Round($_.TotalVirtualMemorySize/1KB)}}, @{Name="Free Pagefile Memory"; Expression={[math]::Round($_.FreeVirtualMemory/1KB)}} | ConvertTo-Html 
 
#Network IP Configuration  
$Network = Get-CIMInstance -ClassName Win32_NetworkAdapterConfiguration | Select-Object Description, @{Name="IP Address"; Expression={$_.IPAddress}},@{Name="Domain"; Expression={$_.DNSDomain}},@{Name="DNS Servers"; Expression={$_.DNSServerSearchOrder}},@{Name="Default Gateway"; Expression={$_.DefaultIPGateway}}  | ConvertTo-Html 
 
#Storage Capcity information 
$StorageCap = Get-CIMInstance -ClassName win32_logicaldisk | Select-Object @{Name="Drive"; Expression={$_.deviceid}}, @{Name="Total Space"; Expression={($_.size/1GB).tostring("0.00")}},@{Name="Free Space"; Expression={($_.freespace/1GB).tostring("0.00")}}  | ConvertTo-Html 
 
#Drive information 
$DriveInfo = Get-CIMInstance -ClassName win32_logicaldisk | Select-Object Model, description, mediatype, partitions, status | ConvertTo-Html 
 
#Start-up Programs 
$Startup = Get-CIMInstance -ClassName Win32_StartupCommand | Select-Object Name, @{Name="Application Command"; Expression={$_.command}},Location | ConvertTo-Html 
 
#List running services 
$Services = Get-Service | Where-Object {$_.status -eq "running"} | Select-Object DisplayName,Status | ConvertTo-Html 
 
#Software installed 
$Software = Get-CIMInstance -ClassName win32_Product | Select-Object Name,Version,@{Name="Install Date"; Expression={$_.Installdate}},Vendor | ConvertTo-Html 
 
#System Log errors 
$SysEvent = Get-Eventlog -Logname system -Newest 5  
$SysError = $SysEvent | Where-Object {$_.EntryType -like 'Error' -or $_.EntryType -like 'Warning'} | Sort-Object TimeWritten | Select-Object EventID, Source, TimeWritten, Message | ConvertTo-Html 
 
#Security Log errors 
$SecEvent = Get-Eventlog -Logname system -Newest 5  
$SecError = $SecEvent | Where-Object {$_.EntryType -like 'Audit Failure' -or $_.EntryType -like 'Warning'} | Sort-Object TimeWritten | Select-Object EventID, Source, TimeWritten, Message | ConvertTo-Html 
 
#HTML Heading 
$htmlhead = @" 
<!DOCTYPE html> 
<HEAD> 
<META charset="UTF-8"> 
<TITLE>System Information Report</TITLE> 
<STYLE> 
TABLE {border-collapse: collapse;} 
TABLE, TD, TH {border: 0px solid black;} 
<LINK REL="STYLEsheet" TYPE="text/css" HREF="../css/theme.css"> 
</STYLE> 
</HEAD> 
"@ 
 
#HTML Body for report 
$htmlbody = @" 
 
 
<TABLE cellpadding="5" cellspacing="10"> 
    <TR> 
        <TD><Font size=5><B>$HN System Information Report</B></font></TD></BR> 
    </TR> 
    <TR> 
        <TD><Font size=3>$dated</TD><BR /> 
    </TR> 
    <TR> 
        <TD><Font size=3>Last system boot in minutes : $uptimeinmin</TD><BR /> 
    </TR> 
    <TR> 
        <TD><I>Purpose:</I> This report is general system information for $HN.</TD> 
    </TR> 
 
<BR /><BR /> 
    <TR> 
        <TD><B><A NAME="ToC">Table of Contents</A></B></TD> 
    </TR> 
    <TR> 
        <TD> 
        <A HREF="#MANU">Manufacturer Information</A></BR> 
        <A HREF="#BIOS">Bios Information</A></BR> 
        <A HREF="#OS">Operating System Information</A></BR> 
        <A HREF="#BOOT">Boot Location Information</A></BR> 
        <A HREF="#PS">PowerShell Information</A></BR> 
        <A HREF="#CPU">Processor Information</A></BR> 
        <A HREF="#MEM">Memory Information</A></BR> 
        <A HREF="#PF">Page File Information</A></BR> 
        <A HREF="#STORE">Storage Information</A></BR> 
        <A HREF="#DRIVE">Drive Information</BR> 
        <A HREF="#NET">Network Information</A></BR> 
        <A HREF="#START">Startup Information</A></BR> 
        <A HREF="#SERVICE">Services Information</A></BR> 
        <A HREF="#SOFT">Software Information</A></BR> 
        <A HREF="#SYS">System Logs</A></BR> 
        <A HREF="#SEC">Security Logs</A></BR> 
         
        </TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="MANU">Manufacturer Information</A></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></TD> 
    </TR> 
    <TR> 
        <TD>$Systeminfo</TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="BIOS">BIOS</A></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></TD> 
    </TR> 
    <TR> 
        <TD>$BIOS</TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="OS">Operating System</A></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></TD> 
    </TR> 
    <TR> 
        <TD>$OS</TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="BOOT">Boot Location</A></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></TD> 
    </TR> 
    <TR> 
        <TD>$BootConfig</TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="PS">PowerShell Version</A></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></TD> 
    </TR> 
        <TR> 
        <TD>$PowerShellVersion</TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="CPU">Processors</A></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></TD> 
    </TR> 
    <TR> 
        <TD>$Processor</TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="MEM">Memory</A></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></TD> 
    </TR> 
    <TR> 
        <TD>$Memory</TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="PF">Pagefile</A></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></TD> 
    </TR> 
    <TR> 
        <TD>$Pagefile</TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="STORE">Storage Information</A></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></TD> 
    </TR> 
    <TR> 
        <TD>$StorageCap</TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="DRIVE">Drive Information</A></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></TD> 
    </TR> 
    <TR> 
        <TD>$DriveInfo</TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="NET">Network Configuration</A></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></TD> 
    </TR> 
    <TR> 
        <TD>$Network</TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="START">Startup Items</A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></B></TD> 
    </TR> 
    <TR> 
        <TD>$Startup</TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="SERVICE">Current Running Services</A></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></TD> 
    </TR> 
    <TR> 
        <TD>$Services</TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="SOFT">Software Inventory</A></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></TD> 
    </TR> 
    <TR> 
        <TD>$Software</TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="SYS">System Log Errors</A></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></TD> 
    </TR> 
    <TR> 
        <TD>$SysError</TD> 
    </TR> 
    <TR> 
        <TD><B><A NAME="SEC">Security Log Errors</A></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="#ToC">ToC</A></TD> 
    </TR> 
    <TR> 
        <TD>$SecError</TD> 
    </TR> 
</TABLE> 
 
"@ 
 
 
#Report output & location 
ConvertTo-HTML -head $htmlhead -body $htmlbody | Out-File C:\inetpub\wwwroot\gen\hostreport.html