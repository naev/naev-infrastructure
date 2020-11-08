FROM mcr.microsoft.com/windows/servercore:ltsc2016

LABEL Description="Windows Server Core development environment for Qbs with Qt, Chocolatey and various dependencies for testing Qbs modules and functionality"

# Disable crash dialog for release-mode runtimes
RUN reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
RUN reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v DontShowUI /t REG_DWORD /d 1 /f

RUN powershell -NoProfile -ExecutionPolicy Bypass -Command \
    $Env:chocolateyVersion = '0.10.8' ; \
    $Env:chocolateyUseWindowsCompression = 'false' ; \
    "[Net.ServicePointManager]::SecurityProtocol = \"tls12, tls11, tls\"; iex ((New-Object System.Net.WebClient).DownloadString('http://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"


RUN choco install -y python && \
    choco install -y 7zip --version 19.0 && \
    choco install -y git --version 2.24.0 --params "/GitAndUnixToolsOnPath" && \
    choco install -y msys2



SHELL ["C:\\tools\\msys64\\autorebase.bat"]

RUN pacman -Syu && pacman -Su

CMD C:\tools\msys64\autorebase.bat
