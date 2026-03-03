start /wait taskkill /IM itsupportbox.exe /F 
rmdir /s /q "C:\Program Files\itsupportbox\" 
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\IT Support Box.lnk" 
del "C:\Users\Public\Desktop\IT Support Box.lnk"
del "C:\ProgramData\softlogs\Logs\itsbox_install_ok.txt"  
timeout 15
