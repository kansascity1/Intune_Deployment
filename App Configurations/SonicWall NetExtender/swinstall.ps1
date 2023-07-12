<#
    .NOTES
    =============================================================================
    Author: j0shbl0ck https://github.com/j0shbl0ck
    Version: 1.0.6
    Date: 12.21.21
    Type: Public
    Source: https://stackoverflow.com/questions/50274909/unattended-silent-install-notepad  CHANGEEEE
    Source: https://adamtheautomator.com/powershell-check-if-file-exists/
    Source: https://www.educba.com/else-if-in-powershell/  [Flowchart If/ elseif if condition]
    Description: Copies the SonicWall NetExtender application and registy profile key.
    =============================================================================
#>

### VARIABLES ###
$app = "C:\Program Files (x86)\SonicWall\SSL-VPN\NetExtender\NEGui.exe"
# Need to change below to match GUID of new MSI
$software = "{EF06A6A8-6B81-4A09-8223-789953972FFF}"
$version = (Get-ItemPropertyValue HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$software -Name DisplayVersion -ErrorAction SilentlyContinue)
### VARIABLES ###

## BEGIN IF/ ELSEIF IF STATEMENT FOR APPLICATION

# If SonicWall NetExtender App does not exist, install it
if (-not(Test-Path -Path $app -PathType Leaf)) {

    # Creates new folder on C: Drive to host setup files
    New-Item -ItemType Directory -Force -Path "C:\MDM\SonicWallNetExtender" | Out-Null

    # Copies NetExtender.msi to newly created folder
    Copy-Item -Path "$PSScriptRoot\netextender-x64-10.2.331.msi" -Destination "C:\MDM\SonicWallNetExtender\netextender-x64-10.2.331.msi"

    #Copies profile.ps1 to newly created folder
    Copy-Item -Path "$PSScriptRoot\profile.ps1" -Destination "C:\MDM\SonicWallNetExtender\profile.ps1"

    # Copies batch file to the startup folder to run on next startup of device
    Copy-Item -Path "$PSScriptRoot\Create_Profile.bat" -Destination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Create_Profile.bat"

    #This installs SonicWall NetExtender. Note, this does a restart! If you perform /norestart the file will not install correct.
    msiexec.exe /i "C:\MDM\SonicWallNetExtender\netextender-x64-10.2.331.msi" /norestart /qn 
    }
# If SonicWall NetExtender App does exist, check if version meets minimum requirements
elseif ($version -le 10.1) {
    # Creates new folder on C: Drive to host setup files
    New-Item -ItemType Directory -Force -Path "C:\MDM\SonicWallNetExtender" | Out-Null

    # Copies NetExtender.msi to newly created folder
    Copy-Item -Path "$PSScriptRoot\netextender-x64-10.2.331.msi" -Destination "C:\MDM\SonicWallNetExtender\netextender-x64-10.2.331.msi"

    #Copies profile.ps1 to newly created folder
    Copy-Item -Path "$PSScriptRoot\profile.ps1" -Destination "C:\MDM\SonicWallNetExtender\profile.ps1"

    # Copies batch file to the startup folder to run on next startup of device
    Copy-Item -Path "$PSScriptRoot\Create_Profile.bat" -Destination "C:\MDM\SonicWallNetExtender\Create_Profile.bat"

    # Copies batch file to the startup folder to run on next startup of device
    Copy-Item -Path "$PSScriptRoot\runinstall.bat" -Destination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\runinstall.bat" 

    #Removes NetExtender by Product code. This removes application and registry files. 
    # Need to change below to match GUID of new MSI
    msiexec /x "{EF06A6A8-6B81-4A09-8223-789953972FFF}" /q 
    }
else {
    # This shuts down powershell, if application is already installed and version is above minimum.
    stop-process -ID $PID 
}









 



