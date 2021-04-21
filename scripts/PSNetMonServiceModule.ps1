# Service monitor script for PSNetmon
# Created By Brad Voris
# Description: Script monitors specified services 

#Define Server & Services Variable
$ServerListA = Get-Content "C:\inetpub\wwwroot\cfg\servicehostsa.cfg"
$ServicesListA = Get-Content "C:\inetpub\wwwroot\cfg\servicesa.cfg"
$ServerListB = Get-Content "C:\inetpub\wwwroot\cfg\servicehostsb.cfg"
$ServicesListB = Get-Content "C:\inetpub\wwwroot\cfg\servicesb.cfg"
$ServerListC =  Get-Content "C:\inetpub\wwwroot\cfg\servicehostsc.cfg"
$ServicesListC = Get-Content "C:\inetpub\wwwroot\cfg\servicesc.cfg"


#Define other variables
$CSS = get-content "C:\inetpub\wwwroot\css\theme.css"
$Report = "C:\inetpub\wwwroot\gen\servicehosts.html" 
$Dateserv = ([datetime]::Now)
$checkrep = Test-Path "C:\inetpub\wwwroot\gen\servicehosts.html" 

If ($checkrep -like "True")
{
Remove-Item "C:\inetpub\wwwroot\gen\servicehosts.html"
}

New-Item "C:\inetpub\wwwroot\gen\servicehosts.html" -type file

#HTML Header Coding
$HTMLHead = @"
<META http-equiv="refresh" CONTENT="30">
<TITLE> 
PSNetMon - Service Module
</TITLE>
<HEAD>
<LINK REL="STYLEsheet" TYPE="text/css" HREF="../css/theme.css"> 
</HEAD>
<CENTER>
"@

#ADD HTML Content
Add-Content $report "<HTML>" 
Add-Content $report "<HEAD>" 
Add-Content $report '<META http-equiv="refresh" CONTENT="30">' 
Add-Content $report '<TITLE>Service Status Report</TITLE>' 
Add-Content $report "<Style>$CSS</style>"
Add-Content $report "<CENTER>"
add-content $report  "<FONT SIZE=4><B>Monitored Services</B></FONT></BR>" 
add-content $report  "<I>$dateserv</I>" 
add-content $report  "<TABLE>" 
Add-Content $report "<TR BGCOLOR=#2554C7>" 
Add-Content $report  "<TD ALIGN='center'><B>Server Name</B></TD>" 
Add-Content $report "<TD ALIGN='center'><B>Service Name</B></TD>" 
Add-Content $report  "<TD ALIGN='center'><B>Status</B></TD>" 
Add-Content $report "</TR>" 

#Get Services Status
Function servicestatus ($serverlist, $serviceslist)
{
foreach ($machineName in $serverlist) 
 { 
  foreach ($service in $serviceslist)
     {
      $serviceStatus = get-service -ComputerName $machineName $service
		 if ($serviceStatus.status -eq "Running") {


         $svcName = $serviceStatus.displayname 
         $svcState = $serviceStatus.status         

         Add-Content $report "<TR>" 
         Add-Content $report "<TD BGCOLOR=#5CB3FF>$machineName</TD>" 
         Add-Content $report "<TD BGCOLOR=#5CB3FF>$svcName</TD>" 
         Add-Content $report "<TD BGCOLOR=#5CB3FF>$svcState</TD>" 
         Add-Content $report "</TR>" 

    

              

                                                   }



	        else 

                                                   { 


         $svcName = $serviceStatus.displayname 
         $svcState = $serviceStatus.status          

         Add-Content $report "<TR>" 
         Add-Content $report "<TD BGCOLOR= 'Red'><B>$machineName</B></TD>" 
         Add-Content $report "<TD BGCOLOR= 'Red'><B>$svcName</B></TD>" 
         Add-Content $report "<TD BGCOLOR= 'Red'><B>$svcState</B></TD>" 
         Add-Content $report "</TR>" 



                                                  } 



             



       } 

 } 

}

#Call Function
servicestatus $ServerListA $ServicesListA
servicestatus $ServerListB $ServicesListB
servicestatus $ServerListC $ServicesListC

#Close HTMl Tables
Add-content $report "</CENTER>"
Add-content $report "</TABLE>" 
Add-Content $report "</BODY>" 
Add-Content $report "</HTML>" 


#Email Notification Script
#If ($serviceStatus -eq "Stopped") 
#{$smtpbody = "$machineName, $svcName, $svcState"
#$smtpto = (get-content "C:\inetpub\wwwroot\cfg\sendmail.cfg")[1]
#$smtpfrom = (get-content "C:\inetpub\wwwroot\cfg\sendmail.cfg")[3]
#$smtpsubject = "PSNetmon Notification Service Down. $dated"
#$smtpservername = (get-content "C:\inetpub\wwwroot\cfg\sendmail.cfg")[9]

#Send mail function
#Send-MailMessage -To $smtpto -From $smtpfrom -subject $smtpsubject -Body $smtpbody -SMTPServer $smtpservername
# }

#CSV for reports
#$countresults1= $Dateserv,$machineName,$svcName,$svcState
#$countresults1 | Add-Content "C:\inetpub\wwwroot\reports\services.csv"
