############################################################################## Service monitor script for PSNetmon# Created By Brad Voris
# Script monitors specified services#############################################################################
#Define Server & Services Variable$ServerListA = Get-Content "C:\inetpub\wwwroot\cfg\servicehosts.cfg"$ServicesListA = Get-Content "C:\inetpub\wwwroot\cfg\services.cfg"
#$ServerListB = Get-Content "C:\Users\bradley.voris\Desktop\Checkservices\EvJserver.txt"#$ServicesListB = Get-Content "C:\Users\bradley.voris\Desktop\Checkservices\EvJservices.txt"
#$ServerListC =  Get-Content "C:\Users\bradley.voris\Desktop\Checkservices\EvDAserver.txt"#$ServicesListC = Get-Content "C:\Users\bradley.voris\Desktop\Checkservices\EvDAservices.txt"

#Define other variables$CSS = get-content "C:\inetpub\wwwroot\css\theme.css"$Report = "C:\inetpub\wwwroot\gen\servicehosts.htm" $Dated = (Get-Date -format F)$checkrep = Test-Path "C:\inetpub\wwwroot\gen\servicehosts.htm" 
If ($checkrep -like "True")
{
Remove-Item "C:\inetpub\wwwroot\gen\servicehosts.htm"
}
New-Item "C:\inetpub\wwwroot\gen\servicehosts.htm" -type file#ADD HTML ContentAdd-Content $report "<html>" Add-Content $report "<head>" Add-Content $report '<meta http-equiv="refresh" content="30">' Add-Content $report '<title>Service Status Report</title>' Add-Content $report "<Style>$CSS</style>"Add-Content $report "<CENTER>"add-content $report  "<Font size=4><B>Monitored Services</B></font></BR>" add-content $report  "<I>Script last run:$dated</I>" add-content $report  "<table>" Add-Content $report "<tr bgcolor=#2554C7>" Add-Content $report  "<td align='center'><B>Server Name</B></td>" Add-Content $report "<td align='center'><B>Service Name</B></td>" Add-Content $report  "<td align='center'><B>Status</B></td>" Add-Content $report "</tr>" 
#Get Services StatusFunction servicestatus ($serverlist, $serviceslist){
foreach ($machineName in $serverlist) 
 { 
  foreach ($service in $serviceslist)
     {
      $serviceStatus = get-service -ComputerName $machineName -DisplayName $service  
		 if ($serviceStatus.status -eq "Running") {

         $svcName = $serviceStatus.displayname          $svcState = $serviceStatus.status         
         Add-Content $report "<tr>"          Add-Content $report "<td bgcolor=#5CB3FF>$machineName</td>"          Add-Content $report "<td bgcolor=#5CB3FF>$svcName</td>"          Add-Content $report "<td bgcolor=#5CB3FF>$svcState</td>"          Add-Content $report "</tr>" 
    #CSV for reports$countresults1=@"$Dated,$machineName,$svcName,$svcState"@$countresults1 | Add-Content "C:\inetpub\wwwroot\reports\services.csv"              
                                                   }

	        else 
                                                   { 

         $svcName = $serviceStatus.displayname          $svcState = $serviceStatus.status          
         Add-Content $report "<tr>"          Add-Content $report "<td bgcolor= 'Red'><B>$machineName</B></td>"          Add-Content $report "<td bgcolor= 'Red'><B>$svcName</B></td>"          Add-Content $report "<td bgcolor= 'Red'><B>$svcState</B></td>"          Add-Content $report "</tr>" 
#CSV for reports$countresults1=@"$Dated,$machineName,$svcName,$svcState"@$countresults1 | Add-Content "C:\inetpub\wwwroot\reports\services.csv"

         
                                                  } 

             

       } 


 } 

}
#Call Functionservicestatus $ServerListA $ServicesListA#servicestatus $ServerListB $ServicesListB#servicestatus $ServerList $ServicesListC#Email Notification Script#If ($serviceStatus -eq "Stopped") #{$smtpbody = "$machineName, $svcName, $svcState"#$smtpto = (get-content "C:\inetpub\wwwroot\cfg\sendmail.cfg")[1]#$smtpfrom = (get-content "C:\inetpub\wwwroot\cfg\sendmail.cfg")[3]#$smtpsubject = "PSNetmon Notification Service Down. $dated"#$smtpservername = (get-content "C:\inetpub\wwwroot\cfg\sendmail.cfg")[9]#Send mail function#Send-MailMessage -To $smtpto -From $smtpfrom -subject $smtpsubject -Body $smtpbody -SMTPServer $smtpservername# }#CSV for reports$countresults1=@"$Dated,$machineName,$svcName,$svcState"@$countresults1 | Add-Content "C:\inetpub\wwwroot\reports\services.csv"
#Close HTMl TablesAdd-content $report "</CENTER>"Add-content $report "</table>" Add-Content $report "</body>" Add-Content $report "</html>" 