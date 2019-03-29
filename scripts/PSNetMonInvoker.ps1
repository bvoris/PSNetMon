########################################################################
#  Powershell NetMon Consolidation Script#  
#  Script that runs all of the PSNetMon scripts
#  Created by: Brad Voris
########################################################################

# Run PSNetMon Count Script for count of monitored resources
Invoke-Command {C:\inetpub\wwwroot\scripts\psnetmoncountscript.ps1}

# Run PSNetMon ICMP Script to ping resources
Invoke-Command {C:\inetpub\wwwroot\scripts\psnetmonicmpscript.ps1}

# Run PSNetMon Port Script to check if ports are open
Invoke-Command {C:\inetpub\wwwroot\scripts\psnetmonportscript.ps1}

# Run PSNetMon Service Script checks if services are running
Invoke-Command {C:\inetpub\wwwroot\scripts\psnetmonservicescript.ps1}

# Run PSNetMon Service Script runs RSS Feed module
Invoke-Command {C:\inetpub\wwwroot\scripts\PSNetMonRSSTicker.ps1}