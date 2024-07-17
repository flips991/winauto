# Define an array of script URLs
$scriptUrls = @(
    "https://raw.githubusercontent.com/flips991/winauto/main/pwandkeyset.ps1"
    # "https://raw.githubusercontent.com/ChrisTitusTech/winutil/main/winget.ps1",
    "https://raw.githubusercontent.com/flips991/winauto/main/programs.ps1"
)

# Loop through each script URL and execute it
foreach ($scriptUrl in $scriptUrls) {
    Write-Host "Downloading and executing script from $scriptUrl"
    
    # Download the script content
    $scriptContent = Invoke-RestMethod -Uri $scriptUrl
    
    # Create a script block and execute it
    $scriptBlock = [ScriptBlock]::Create($scriptContent)
    & $scriptBlock -Force

    Write-Host "Script execution complete."
}
