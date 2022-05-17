#Define Server & Services Variable$ServerListA = Get-Content "C:\inetpub\wwwroot\cfg\servicehostsa.cfg"$ServicesListA = Get-Content "C:\inetpub\wwwroot\cfg\servicesa.cfg"$ServerListB = Get-Content "C:\inetpub\wwwroot\cfg\servicehostsb.cfg"$ServicesListB = Get-Content "C:\inetpub\wwwroot\cfg\servicesb.cfg"#$ServerListC =  Get-Content "C:\inetpub\wwwroot\cfg\servicehostsc.cfg"#$ServicesListC = Get-Content "C:\inetpub\wwwroot\cfg\servicesc.cfg"
$serviceastatus = get-service -computername "$ServerListA" "$ServicesListA"
$servicebstatus = get-service -computername "$ServerListB" "$ServicesListB"
write-host $ServerListA, $serviceastatus.DisplayName, $serviceastatus.Status
write-host $ServerListB, $servicebstatus.DisplayName, $servicebstatus.Status