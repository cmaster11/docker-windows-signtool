Set-PSDebug -Trace 1
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$PSDefaultParameterValues["*:ErrorAction"] = "Stop"

Invoke-WebRequest "https://go.microsoft.com/fwlink/?linkid=2250105" -usebasicparsing -outfile "winsdksetup.exe"
$params = @("/features", "OptionId.SigningTools", "/quiet", "/norestart", "/log", "WinSDK-Install.log")
$p = Start-Process "./winsdksetup.exe" -ArgumentList $params -NoNewWindow -Wait -PassThru
if ($p.ExitCode -ne 0)
{
    throw "Windows SDK setup failed"
}
Remove-Item -Path "winsdksetup.exe"
Remove-Item "WinSDK-Install.log"

# Get installed version name
$Version = (Get-ChildItem -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots\").PSChildName
$SignToolBin = "C:\Program Files (x86)\Windows Kits\10\bin\" + $Version + "\x64\signtool.exe"

if (!(Test-Path $SignToolBin -PathType Leaf))
{
    throw "signtool binary not found"
}

New-Item -ItemType SymbolicLink -Path "C:\signtool.exe" -Target $SignToolBin