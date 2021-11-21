# https://stackoverflow.com/a/18770794/102699
$ProgressPreference = 'SilentlyContinue'

# Copy the scripts from the C:\Host\scripts directory
New-Item -Force -Path C:\Windows\Temp\Scripts -ItemType Directory
Copy-Item -Force -Recurse -Verbose E:\scripts\* -Destination C:\Windows\Temp\Scripts

# See https://adamtheautomator.com/powershell-download-file/#Using_PowerShell_to_Download_Files_from_URLs_Four_Ways
# Download the SQL Server Developer 2019 Installer
$url=[System.Uri]"https://download.microsoft.com/download/d/a/2/da259851-b941-459d-989c-54a18a5d44dd/SQL2019-SSEI-Dev.exe"
$filename=[System.IO.Path]::GetFileName($url)
New-Item -Force -Path C:\Windows\Temp\Software -ItemType Directory
Invoke-WebRequest -Uri $url -OutFile C:\Windows\Temp\Software\$filename -UseBasicParsing

