@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" `
    -NoProfile `
    -InputFormat None `
    -ExecutionPolicy Bypass `
    -Command "




Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))


[System.Net.ServicePointManager]::SecurityProtocol = 3072;
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"