@echo off
setlocal enabledelayedexpansion

:: Log-Datei Pfad definieren
set "LOGFILE=C:\ProgramData\softlogs\Logs\itsbox_install_log.txt"
set "UNINSTALL_LOGFILE=C:\ProgramData\softlogs\Logs\itsbox_uninstall_log.txt"

:: Stelle sicher, dass das Log-Verzeichnis existiert
if not exist "C:\ProgramData\softlogs" mkdir "C:\ProgramData\softlogs"
if not exist "C:\ProgramData\softlogs\Logs" mkdir "C:\ProgramData\softlogs\Logs"

:: Lösche alte Uninstall-Logdatei vor der Installation
if exist "%UNINSTALL_LOGFILE%" (
    del "%UNINSTALL_LOGFILE%"
    if not exist "%UNINSTALL_LOGFILE%" (
        echo [INFO] Alte Uninstall-Logdatei wurde geloescht >> "%LOGFILE%"
    ) else (
        echo [WARNUNG] Alte Uninstall-Logdatei konnte nicht geloescht werden >> "%LOGFILE%"
    )
)

:: Lösche alte Installations-Logdatei oder erstelle neue mit Zeitstempel
if exist "%LOGFILE%" (
    del "%LOGFILE%"
)
echo ================================================= >> "%LOGFILE%"
echo Installation gestartet am %date% %time% >> "%LOGFILE%"
echo ================================================= >> "%LOGFILE%"

:: 1. Befehl: Beende den Prozess itsupportbox.exe falls er läuft
:: /wait - warte auf Abschluss des Befehls
:: /IM - Image Name (Prozessname)
:: /F - Force (erzwingt Beendigung)
start /wait taskkill /IM itsupportbox.exe /F
:: Überprüfe ob Befehl erfolgreich war (errorlevel 0 = erfolgreich, 128 = Prozess nicht gefunden, 1 = anderer Fehler)
if %errorlevel%==0 (
    echo [OK] Prozess itsupportbox.exe wurde erfolgreich beendet >> "%LOGFILE%"
) else if %errorlevel%==128 (
    echo [INFO] Prozess itsupportbox.exe war nicht aktiv oder wurde bereits beendet >> "%LOGFILE%"
) else (
    echo [FEHLER] Prozess itsupportbox.exe konnte nicht beendet werden (Errorlevel: %errorlevel%) >> "%LOGFILE%"
)

:: 2. Befehl: Lösche das vorhandene Installationsverzeichnis komplett
:: /s - Lösche alle Unterverzeichnisse
:: /q - Quiet Mode (keine Nachfrage)
if exist "C:\Program Files\itsupportbox" (
    rmdir /s /q "C:\Program Files\itsupportbox"
    if not exist "C:\Program Files\itsupportbox" (
        echo [OK] Verzeichnis "C:\Program Files\itsupportbox" wurde geloescht >> "%LOGFILE%"
    ) else (
        echo [FEHLER] Verzeichnis "C:\Program Files\itsupportbox" konnte nicht geloescht werden >> "%LOGFILE%"
    )
) else (
    echo [INFO] Verzeichnis "C:\Program Files\itsupportbox" existierte nicht oder wurde bereits geloescht >> "%LOGFILE%"
)

:: 3. Befehl: Erstelle das Installationsverzeichnis neu
mkdir "C:\Program Files\itsupportbox"
:: Überprüfe ob Befehl erfolgreich war
if %errorlevel%==0 (
    echo [OK] Verzeichnis "C:\Program Files\itsupportbox" wurde erstellt >> "%LOGFILE%"
) else (
    echo [FEHLER] Verzeichnis "C:\Program Files\itsupportbox" konnte nicht erstellt werden (Errorlevel: %errorlevel%) >> "%LOGFILE%"
)

:: 4. Befehl: Kopiere die Programmdatei ins Installationsverzeichnis
:: %~dp0 - Pfad des aktuellen Skript-Verzeichnisses
:: /O - Besitzer-Informationen kopieren
:: /X - Datei-Überwachungsinformationen kopieren
:: /E - Kopiert Verzeichnisse und Unterverzeichnisse (auch leere)
:: /H - Kopiert versteckte und Systemdateien
:: /K - Kopiert Attribute (wie schreibgeschützt)
:: /R - Überschreibt schreibgeschützte Dateien
xcopy "%~dp0itsupportbox.exe" "C:\Program Files\itsupportbox\" /O /X /E /H /K /R
if %errorlevel%==0 (
    echo [OK] itsupportbox.exe wurde erfolgreich kopiert >> "%LOGFILE%"
) else (
    echo [FEHLER] itsupportbox.exe konnte nicht kopiert werden (Errorlevel: %errorlevel%) >> "%LOGFILE%"
)

:: 5. Befehl: Kopiere die Verknüpfung ins Startmenü
:: /Y - Bestätige Überschreiben ohne Nachfrage
:: /R - Überschreibt schreibgeschützte Dateien
xcopy "%~dp0IT Support Box.lnk" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\" /Y /R
if %errorlevel%==0 (
    echo [OK] Startmenue-Verknuepfung wurde erfolgreich kopiert >> "%LOGFILE%"
) else (
    echo [FEHLER] Startmenue-Verknuepfung konnte nicht kopiert werden (Errorlevel: %errorlevel%) >> "%LOGFILE%"
)

:: 6. Befehl: Kopiere die Verknüpfung auf den öffentlichen Desktop
xcopy "%~dp0IT Support Box.lnk" "C:\Users\Public\Desktop\"  /Y /R
if %errorlevel%==0 (
    echo [OK] Desktop-Verknuepfung wurde erfolgreich kopiert >> "%LOGFILE%"
) else (
    echo [FEHLER] Desktop-Verknuepfung konnte nicht kopiert werden (Errorlevel: %errorlevel%) >> "%LOGFILE%"
)

:: 7. Warte 5 Sekunden (Zeit für den Benutzer um Meldungen zu lesen)
echo [INFO] Warte 5 Sekunden... >> "%LOGFILE%"
timeout 5

:: 8. Überprüfe den Gesamterfolg des Skripts (errorlevel des letzten Befehls)
if %errorlevel%==0 (
    echo ================================================= >> "%LOGFILE%"
    echo [ERFOLG] Installation komplett abgeschlossen am %date% %time% >> "%LOGFILE%"
    echo ================================================= >> "%LOGFILE%"
    
    :: Zusätzliche Erfolgs-Logdatei (wie im Original)
    echo Erfolgreich am %date% %time% > "C:\ProgramData\softlogs\Logs\itsbox_install_ok.txt"
) else (
    echo ================================================= >> "%LOGFILE%"
    echo [FEHLER] Installation mit Fehlern abgeschlossen am %date% %time% >> "%LOGFILE%"
    echo ================================================= >> "%LOGFILE%"
)

:: 9. Zweite Wartezeit von 5 Sekunden
timeout 5

:: Ende des Skripts
echo [INFO] Skript beendet >> "%LOGFILE%"
echo. >> "%LOGFILE%"