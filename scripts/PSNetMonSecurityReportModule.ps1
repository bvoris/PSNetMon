# Name: Powershell Script Analyzer Security Module# Written by: Brad Voris
# Description: PSScriptAnaylizer -PSScriptAnalyzer is a static code checker for PowerShell modules and scripts. PSScriptAnalyzer checks the quality of PowerShell code by running a set of rules.# Link: https://docs.microsoft.com/en-us/powershell/module/psscriptanalyzer/?view=ps-modules# Additional Notes: I've added this ass an additional module that can be run seperately to validate code changes and security recommendations# Version: 4.5
# Installation of the module if not present. This will require selecting OK the first time its been run or needs an update
Install-Module PSScriptAnalyzer 
# Date variable for body
$dated = Get-Date -format "MM/dd/yyyy hh:mm tt"

#HTML Head
$HTMLHeadPRTM = @"
<!DOCTYPE html>
<HEAD>
<META charset="UTF-8">
<TITLE>PSNetMon - Security Report Module</TITLE>
<CENTER>
<LINK REL="STYLEsheet" TYPE="text/css" HREF="../css/theme.css"> </HEAD>
"@
#HTML Body Content
$HTMLBodyPRTM = @"<CENTER>Report last ran $dated <BR />A Blank Report means no vulnerabilities, warnings or errors found in the scripts directory. <BR /></CENTER>"@



# Invoke the analyzer as a variable
$securityreport = Invoke-ScriptAnalyzer C:\inetpub\wwwroot\scripts\*.ps1 -Settings PSGallery,DSC,ScriptSecurity,CMDLetDesign,ScriptFunctions -Severity Warning,Error 

# Generate the report
$securityreport | ConvertTo-HTML -head $HTMLHeadPRTM -body $HTMLBodyPRTM | out-file "C:\inetpub\wwwroot\gen\psnetmonsecurityreport.html"