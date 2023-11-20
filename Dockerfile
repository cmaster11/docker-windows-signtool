FROM mcr.microsoft.com/windows/servercore:10.0.20348.2113

COPY install.ps1 "C:\install.ps1"
RUN "powershell -File C:\install.ps1"

ENTRYPOINT "C:\signtool.exe"