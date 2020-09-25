#  Powershell NetMon Consolidation Script
#  Created by: Brad Voris
#  Description: Script that runs all of the PSNetMon scripts

# Run PSNetMon Count Script for count of monitored resources
Invoke-Command {C:\inetpub\wwwroot\scripts\PSNetMonCountModule.ps1}

# Run PSNetMon ICMP Script to ping resources
Invoke-Command {C:\inetpub\wwwroot\scripts\PSNetMonICMPModule.ps1}

# Run PSNetMon Port Script to check if ports are open
Invoke-Command {C:\inetpub\wwwroot\scripts\PSNetMonPortModule.ps1}

# Run PSNetMon Service Script checks if services are running
Invoke-Command {C:\inetpub\wwwroot\scripts\PSNetMonServiceModule.ps1}

# Run PSNetMon Service Module runs RSS Feed module
Invoke-Command {C:\inetpub\wwwroot\scripts\PSNetMonRSSTickerModule.ps1}

# Run PSNetMon Service Script runs Weather module
Invoke-Command {C:\inetpub\wwwroot\scripts\PSNetMonWeatherModule.ps1}

