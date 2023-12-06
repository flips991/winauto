# Install Programs
Write-Host "Installing Programs"

winget install -e --id Adobe.Acrobat.Reader.64-bit
winget install -e --id Google.Chrome
winget install -e --id Mozilla.Firefox
winget install -e --id 7zip.7zip
winget install -e --id AnyDeskSoftwareGmbH.AnyDesk
winget install -e --id TeamViewer.TeamViewer --force
winget install -e --id VideoLAN.VLC

Write-Host "Programs Installed"

# Enable NetFramework 3.5
Write-Host "Enabling .net 3.5"

DISM /Online /Enable-Feature /FeatureName:NetFx3 /ALL
