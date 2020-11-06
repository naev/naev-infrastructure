FROM microsoft/windowsservercore:2004
# Make sure we're in temp for the downloads
WORKDIR c:/windows/temp

# Switch to PowerShell
SHELL ["powershell", "-command"] 

RUN Invoke-WebRequest -UserAgent 'DockerCI' -outfile 7zsetup.exe http://www.7-zip.org/a/7z1604-x64.exe
RUN Invoke-WebRequest -UserAgent 'DockerCI' -outfile msys2-x86_64-latest.tar.xz http://repo.msys2.org/distrib/msys2-x86_64-latest.tar.xz 


RUN Start-Process .\7zsetup -ArgumentList '/S /D=c:/7zip' -Wait
RUN C:\7zip\7z e msys2-x86_64-latest.tar.xz -Wait
RUN C:\7zip\7z x msys2-x86_64-latest.tar -o"C:\\" 
RUN del *

#ENV PATH C:\msys64\usr\bin;C:\Windows;C:\Windows\System32
ENV MSYSTEM MSYS2

CMD powershell