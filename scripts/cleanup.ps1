Function Remove-Files {
Param (
    [string]$Filespec
)
    Get-ChildItem "$Filespec" `
        -Recurse `
        -Force `
        -Verbose `
        -ErrorAction SilentlyContinue `
        | Remove-Item `
            -Force `
            -Verbose `
            -Recurse `
            -ErrorAction SilentlyContinue
}
Function Cleanup {

    Write-Output "Clearing Host."
    Clear-Host

    Write-Output "Stopping the Windows update service."
    Get-Service -Name wuauserv `
        | Stop-Service `
            -Force `
            -Verbose `
            -ErrorAction SilentlyContinue

    Write-Output "Deleting the contents of Windows software distribution."
    Remove-Files "C:\Windows\SoftwareDistribution\*"

    Write-Output "BYPASSING Deletion the Windows Temp folder contents."
#     Get-ChildItem `
#         -Path "C:`Windows`Temp`*" `
#         -Exclude packer-ps-env-vars-*.psi `
#         -Recurse `
#         -Force `
#         -Verbose `
#         -ErrorAction SilentlyContinue `
#         | Remove-Item `
#             -Force `
#             -Verbose `
#             -Recurse `
#             -ErrorAction SilentlyContinue

    Write-Output "Deleting all files and folders in user's Temp folder."
    Remove-Files "C:\users\*\AppData\Local\Temp\*"

    Write-Output "Removing all files and folders in user's Temporary Internet Files."
    Remove-Files "C:\users\*\AppData\Local\Microsoft\Windows\Temporary Internet Files\*"
}

Cleanup