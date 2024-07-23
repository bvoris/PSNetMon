﻿#Define Server & Services Variable
$serviceastatus = get-service -computername "$ServerListA" "$ServicesListA"
$servicebstatus = get-service -computername "$ServerListB" "$ServicesListB"
write-host $ServerListA, $serviceastatus.DisplayName, $serviceastatus.Status
write-host $ServerListB, $servicebstatus.DisplayName, $servicebstatus.Status