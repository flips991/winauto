#add-AppxPackage -Path "C:\Install\winget\Microsoft.UI.Xaml.2.8.x64.appx"
#add-AppxPackage -Path "C:\Install\winget\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

# Turn off sleep "standby timeout" on battery and on plugged in
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0

# Set turn off display to 10 minutes on battery and 15 minutes on plugged in
powercfg /change monitor-timeout-ac 15
powercfg /change monitor-timeout-dc 10

# Set when pressing the power button to shut down on battery and on plugged in
powercfg -setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 3
powercfg -setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 3

# Set when closing the lid to Do nothing on battery and on plugged in
powercfg -setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
powercfg -setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0

# Define the language keyboards

$usLanguage = New-WinUserLanguageList en-US
$serbianLanguageLatin = New-WinUserLanguageList sr-Latn-RS
$serbianLanguageCyrillic = New-WinUserLanguageList sr-Cyrl-RS

# Add the US keyboard
$usLanguage[0].InputMethodTips.Add("0409:00000409")

# Add the Serbian Latin keyboard
$serbianLanguageLatin[0].InputMethodTips.Add("241A:0000081A")

# Add the Serbian Cyrillic keyboard
$serbianLanguageCyrillic[0].InputMethodTips.Add("281A:00000C1A")

# Combine language lists
$combinedLanguages = $usLanguage + $serbianLanguageLatin + $serbianLanguageCyrillic

# Apply the language list to the system
Set-WinUserLanguageList $combinedLanguages -Force

# Output the current language list for verification
Get-WinUserLanguageList

# Define the registry path for regional format settings
$regPath = "HKCU:\Control Panel\International"

# Set the values for Serbian (Latin, Serbia)
Set-ItemProperty -Path $regPath -Name "Locale" -Value "0000081A"
Set-ItemProperty -Path $regPath -Name "LocaleName" -Value "sr-Latn-RS"
Set-ItemProperty -Path $regPath -Name "sCountry" -Value "Serbia"
Set-ItemProperty -Path $regPath -Name "sLanguage" -Value "SRB"

# Set time zone
Set-TimeZone -Name "Central Europe Standard Time"

# Set registry key to enable receiving updates for other Microsoft products
$regPath = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
$regName = "AllowMUUpdateService"
$regValue = 1
# Create or update the registry key
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue
# Restart the Windows Update service to apply changes
Restart-Service -Name wuauserv

# Copy the current user's international settings to the Welcome screen and system accounts, and new user accounts
Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True
