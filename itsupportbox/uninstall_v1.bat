@echo off
setlocal enabledelayedexpansion

:: Log-Datei Pfad definieren (für die Deinstallation)
set "LOGFILE=C:\ProgramData\softlogs\Logs\itsbox_uninstall_log.txt"

:: Stelle sicher, dass das Log-Verzeichnis existiert
if not exist "C:\ProgramData\softlogs" mkdir "C:\ProgramData\softlogs"
if not exist "C:\ProgramData\softlogs\Logs" mkdir "C:\ProgramData\softlogs\Logs"

:: Erstelle neue Log-Datei mit Zeitstempel
echo ================================================= >> "%LOGFILE%"
echo Deinstallation gestartet am %date% %time% >> "%LOGFILE%"
echo ================================================= >> "%LOGFILE%"

:: 1. Befehl: Beende den Prozess itsupportbox.exe falls er läuft
start /wait taskkill /IM itsupportbox.exe /F
if %errorlevel%==0 (
    echo [OK] Prozess itsupportbox.exe wurde erfolgreich beendet >> "%LOGFILE%"
) else if %errorlevel%==128 (
    echo [INFO] Prozess itsupportbox.exe war nicht aktiv oder wurde bereits beendet >> "%LOGFILE%"
) else (
    echo [FEHLER] Prozess itsupportbox.exe konnte nicht beendet werden (Errorlevel: %errorlevel%) >> "%LOGFILE%"
)

:: 2. Befehl: Lösche das Installationsverzeichnis komplett
:: Prüfe zuerst ob das Verzeichnis überhaupt existiert
if exist "C:\Program Files\itsupportbox" (
    rmdir /s /q "C:\Program Files\itsupportbox"
    if not exist "C:\Program Files\itsupportbox" (
        echo [OK] Verzeichnis "C:\Program Files\itsupportbox" wurde erfolgreich geloescht >> "%LOGFILE%"
    ) else (
        echo [FEHLER] Verzeichnis "C:\Program Files\itsupportbox" konnte nicht geloescht werden >> "%LOGFILE%"
    )
) else (
    echo [INFO] Verzeichnis "C:\Program Files\itsupportbox" existierte nicht oder wurde bereits geloescht >> "%LOGFILE%"
)

:: 3. Befehl: Lösche die Startmenü-Verknüpfung
if exist "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\IT Support Box.lnk" (
    del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\IT Support Box.lnk"
    if not exist "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\IT Support Box.lnk" (
        echo [OK] Startmenue-Verknuepfung wurde erfolgreich geloescht >> "%LOGFILE%"
    ) else (
        echo [FEHLER] Startmenue-Verknuepfung konnte nicht geloescht werden >> "%LOGFILE%"
    )
) else (
    echo [INFO] Startmenue-Verknuepfung existierte nicht oder wurde bereits geloescht >> "%LOGFILE%"
)

:: 4. Befehl: Lösche die Desktop-Verknüpfung
if exist "C:\Users\Public\Desktop\IT Support Box.lnk" (
    del "C:\Users\Public\Desktop\IT Support Box.lnk"
    if not exist "C:\Users\Public\Desktop\IT Support Box.lnk" (
        echo [OK] Desktop-Verknuepfung wurde erfolgreich geloescht >> "%LOGFILE%"
    ) else (
        echo [FEHLER] Desktop-Verknuepfung konnte nicht geloescht werden >> "%LOGFILE%"
    )
) else (
    echo [INFO] Desktop-Verknuepfung existierte nicht oder wurde bereits geloescht >> "%LOGFILE%"
)

:: 5. Befehl: Lösche die Erfolgs-Logdatei
if exist "C:\ProgramData\softlogs\Logs\itsbox_install_ok.txt" (
    del "C:\ProgramData\softlogs\Logs\itsbox_install_ok.txt"
    if not exist "C:\ProgramData\softlogs\Logs\itsbox_install_ok.txt" (
        echo [OK] Erfolgs-Logdatei wurde erfolgreich geloescht >> "%LOGFILE%"
    ) else (
        echo [FEHLER] Erfolgs-Logdatei konnte nicht geloescht werden >> "%LOGFILE%"
    )
) else (
    echo [INFO] Erfolgs-Logdatei existierte nicht oder wurde bereits geloescht >> "%LOGFILE%"
)

:: 6. Befehl: Lösche die Installations-Logdatei
if exist "C:\ProgramData\softlogs\Logs\itsbox_install_log.txt" (
    del "C:\ProgramData\softlogs\Logs\itsbox_install_log.txt"
    if not exist "C:\ProgramData\softlogs\Logs\itsbox_install_log.txt" (
        echo [OK] Installations-Logdatei wurde erfolgreich geloescht >> "%LOGFILE%"
    ) else (
        echo [FEHLER] Installations-Logdatei konnte nicht geloescht werden >> "%LOGFILE%"
    )
) else (
    echo [INFO] Installations-Logdatei existierte nicht oder wurde bereits geloescht >> "%LOGFILE%"
)

:: 7. Lösche leere Verzeichnisse (optional)
if exist "C:\Program Files\itsupportbox" (
    rmdir "C:\Program Files\itsupportbox" 2>nul
    if not exist "C:\Program Files\itsupportbox" (
        echo [OK] Leeres Verzeichnis "C:\Program Files\itsupportbox" wurde geloescht >> "%LOGFILE%"
    )
)

if exist "C:\ProgramData\softlogs\Logs" (
    rmdir "C:\ProgramData\softlogs\Logs" 2>nul
    if not exist "C:\ProgramData\softlogs\Logs" (
        echo [OK] Leeres Logs-Verzeichnis wurde geloescht >> "%LOGFILE%"
        
        if exist "C:\ProgramData\softlogs" (
            rmdir "C:\ProgramData\softlogs" 2>nul
            if not exist "C:\ProgramData\softlogs" (
                echo [OK] Leeres softlogs-Verzeichnis wurde geloescht >> "%LOGFILE%"
            )
        )
    )
)

:: 8. Abschluss der Deinstallation
echo ================================================= >> "%LOGFILE%"
echo [ERFOLG] Deinstallation abgeschlossen am %date% %time% >> "%LOGFILE%"
echo ================================================= >> "%LOGFILE%"

:: 9. Warte 15 Sekunden (wie im Original)
echo [INFO] Warte 15 Sekunden... >> "%LOGFILE%"
timeout 15

:: Ende des Skripts
echo [INFO] Deinstallationsskript beendet >> "%LOGFILE%"
echo. >> "%LOGFILE%"

echo.
echo Deinstallation abgeschlossen. Details im Log: %LOGFILE%
timeout 3