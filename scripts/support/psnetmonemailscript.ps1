################################################################
# Parse txt file for parmeters
################################################################
# Call this script for sending email based on 
# parameters for failure
#
################################################################
# Variables for email
################################################################
$smtpto = (get-content "C:\inetpub\wwwroot\cfg\sendmail.cfg")[1]
$smtpfrom = (get-content "C:\inetpub\wwwroot\cfg\sendmail.cfg")[3]
$smtpsubject = (get-content "C:\inetpub\wwwroot\cfg\sendmail.cfg")[5]
$smtpbody = (get-content "C:\inetpub\wwwroot\cfg\sendmail.cfg")[7]
$smtpservername = (get-content "C:\inetpub\wwwroot\cfg\sendmail.cfg")[9]

################################################################
#Send mail function
################################################################
Send-MailMessage    -To $smtpto -From $smtpfrom -subject $smtpsubject -Body $smtpbody -SMTPServer $smtpservername