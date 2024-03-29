# Name: Powershell Network Monitor ICMP Module # Written by: Brad Voris# Description: Script pings resources to determine if they are up# Additional Notes: None# Version: 4.5#Varibales$CSS = get-content "C:\inetpub\wwwroot\css\theme.css"$HTMLHead =  "<Style>$CSS</style>"$HTMLHead = $HTMLHead + "<CENTER><Font SIZEe=4><B>Monitored Hosts</B></FONT></BR>"$ConfigFile = get-content C:\inetpub\wwwroot\cfg\computers.cfg$dated = Get-Date -format "MM/dd/yyyy hh:mm tt"
#Check content and ping computers$icmpresults = $ConfigFile | Where-Object {-not ($_.StartsWith('#'))} | ForEach-Object {  if (test-connection $_  -count 2)  { New-Object psobject -Property @{   	Server = $_   	Status = "Online"   } }  else  {New-Object psobject -Property @{   	Server = $_   	Status = "Offline" 
#Email Notification Script#If (Status -eq "Offline") #{$smtpbody = "$machineName, $svcName, $svcState"#$smtpto = (get-content "C:\inetpub\wwwroot\cfg\sendmail.cfg")[1]#$smtpfrom = (get-content "C:\inetpub\wwwroot\cfg\sendmail.cfg")[3]#$smtpsubject = "PSNetmon Notification Host Down. $dated"#$smtpservername = (get-content "C:\inetpub\wwwroot\cfg\sendmail.cfg")[9]#Send-MailMessage -To $smtpto -From $smtpfrom -subject $smtpsubject -Body $smtpbody -SMTPServer $smtpservername
# }  
   }
 }
}
$HTMLBody = @"<META http-equiv="refresh" CONTENT="30">
<CENTER><I>$dated</I><BR /></CENTER>"@
# CSV for reports#$countresults1=@()#$dated,$Icmpresults.Server,$Icmpresults.Status | Add-Content "C:\inetpub\wwwroot\reports\icmp.csv"
#  Export to HTML$icmpresults | ConvertTo-HTML -head $HTMLHead -body $HTMLBody -Property Server,Status |
     ForEach-Object { if ($_ -like "*<TD>Online</TD>*" ) 
                      {$_ -replace "<TR>","<TR BGCOLOR=#5CB3FF>" }
                    else {$_ -replace "<TR>","<TR BGCOLOR=red>"}} | 
                    out-file "C:\inetpub\wwwroot\gen\icmphosts.html"

            
