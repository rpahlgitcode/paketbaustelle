📦 Paketbaustelle

Beherbergt unter anderen von eigenen Anwendungen wie dem Programm: "IT Support Box" die Softwareverteilung Batch und oder PS1 Dateien. Es ist eine modulare Software- und Deployment-Lösung zur standardisierten Bereitstellung, Installation und Wartung von Anwendungen in Unternehmensumgebungen (mit SCCM/ Intune).

Ziel ist es, meine eigenen Softwarepakete reproduzierbar, dokumentiert und automatisierbar für den Rollout bereitzustellen.

Projektziel

Die Paketbaustelle dient als zentraler Anlaufpunkt für:

Standardisierte Install- und Uninstall-Routinen
Silent-Install-Konfigurationen
Unternehmenskompatible Deployment-Skripte
Dokumentierte Paketstrukturen
Vorbereitung für Softwareverteilung (z. B. SCCM / Intune / Gruppenrichtlinien)
Langfristiges Ziel ist der produktive Einsatz in Unternehmensumgebungen mit klar definierten Installationsstandards.

Architektur

Die Projektstruktur folgt einem modularen Ansatz:

Paketbaustelle

Packages
SoftwareName
Install.bat
Uninstall.bat
Detection.txt
Optional: README.txt
Documentation: Tools

Jedes Softwarepaket enthält:

Installationsroutine (Silent / Enterprise-Ready)
Deinstallationsroutine
Erkennungslogik (Detection Method)

Paketdokumentation

Paketbaustelle (Dokumentationsprinzip)

Alle zukünftigen Eigenentwicklungen sowie Softwarepakete werden nach folgendem Prinzip dokumentiert:

Zweck der Software
Installationsparameter
Abhängigkeiten
Silent-Parameter
Rückgabecodes
Bekannte Besonderheiten im Unternehmensumfeld
Rollout-Empfehlung

Ziel ist eine vollständige Transparenz für:

IT-Administratoren
Deployment-Verantwortliche
Systemintegratoren

Rollout-Ziel

Die Paketbaustelle ist ausgelegt für:

Zentrale Softwareverteilung
Automatisierte Installationen
Standardisierte Unternehmensumgebungen
Reproduzierbare Deployment-Prozesse

Geplante bzw. unterstützte Plattformen:

Microsoft Endpoint Configuration Manager
Microsoft Intune
Windows Active Directory Umgebungen

Lizenz

Dieses Projekt steht unter der MIT License.
Siehe LICENSE-Datei für weitere Informationen.

Autor

Roland Pahl
Fachinformatiker für Systemintegration
Schwerpunkt: Deployment, Softwarepaketierung, Unternehmensumgebungen
