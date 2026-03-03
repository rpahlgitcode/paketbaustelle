start /wait taskkill /IM itsupportbox.exe /F 
rmdir /s /q "C:\Program Files\itsupportbox" 
mkdir "C:\Program Files\itsupportbox" 
xcopy "%~dp0itsupportbox.exe" "C:\Program Files\itsupportbox\" /O /X /E /H /K /R 
xcopy "%~dp0IT Support Box.lnk" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\" /Y /R 
xcopy "%~dp0IT Support Box.lnk" "C:\Users\Public\Desktop\"  /Y /R
timeout 5
if %errorlevel%==0 (
    if not exist "C:\ProgramData\softlogs" mkdir "C:\ProgramData\softlogs"
    if not exist "C:\ProgramData\softlogs\Logs" mkdir "C:\ProgramData\softlogs\Logs"
    echo Erfolgreich am %date% %time% > "C:\ProgramData\softlogs\Logs\itsbox_install_ok.txt"
)
timeout 5