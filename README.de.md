
# AnnoSaveGameBackUpAndCleanup
Dieses Script erstellt ein Backup deines Accountordners und räumt alte AutoSaveFiles weg.

*Read this in other languages: [English](README.md), [German](README.de.md).*

## Vorraussetzungen
- Powershell 3 oder höher muss installiert sein. (Bei Windows 10 Home/Pro im Standard vorhanden)

## Konfiguration
Das Skript hat mehrere Konfigurationsmöglichkeiten 
In der Standardeinstellung wird ein Backup unter "C:\Archive" erstellt und die letzten 10 Speicherstände in den Profilordnern belassen.

Die Konfigurationsmöglichkeiten sind im Skript dokumentiert.
(siehe [PSScriptBackupAndCleanAnnoAccount.ps1](PSScriptBackupAndCleanAnnoAccount.ps1)). 

## Ausführung
### Einmaliges Ausführen
Kann über das Kontextmenü gestartet werden

![grafik](https://user-images.githubusercontent.com/29517354/147792472-954525de-1d90-41e9-b27b-73643d53ec5e.png)

Diese Nachricht erscheint, da Scripte aus dem Internet von Windows als unsicher eingestuft werden. Beim Klick auf "Öffnen" wird das Script jedoch ausgeführt.

Wenn du den Haken entfernst, wird die Meldung das nächste Mal nicht mehr auftauchen.

![grafik](https://user-images.githubusercontent.com/29517354/147825468-9a1bef87-2177-4c58-bec7-f48d2cce00e1.png)


### Repetitive execution 
Kann über die Windows Aufgabenplanung konfiguriert werden
Hinweis: Für die Aufgabenausführung ist es nötig, die PowerShell ExecutionPolicy anzupassen. Mehr darüber unter "Setup PowerShell ExecutionPolicy".

1. Speicher die Scriptdatei an einem Ort, wo sie nicht stört.
   In diesem Beispiel "C:\Users\Fuchur\Documents\PSScriptBackupAndCleanAnnoAccount.ps1".

2. Öffne die Aufgabenplanung

![grafik](https://user-images.githubusercontent.com/29517354/147822071-a4d01808-6e53-4c86-b727-0d8cb4d8df52.png)

3. Klicke "Aufgabe erstellen..." auf der rechten Seite

![grafik](https://user-images.githubusercontent.com/29517354/147822139-284d7bc5-5d07-42ab-a0cf-12264e82bb62.png)

4. Gib der Aufgabe einen sprechenden Namen

![grafik](https://user-images.githubusercontent.com/29517354/147822167-59e0f933-25fa-4494-8fbb-155104f74ffb.png)

5. Setze einen Trigger für die Aufgabe. In diesem Beispiel "Bei Anmeldung" (Anmelden bei Windows)

![grafik](https://user-images.githubusercontent.com/29517354/147822217-0ffc3e16-b4ef-4d3a-be25-63ba47d253c6.png)

6. Setze eine Aktion für die Aufgabe.

![grafik](https://user-images.githubusercontent.com/29517354/147822694-67ac1315-b22e-49cd-be09-1a7eb0f89ff7.png)

Du kannst einfach diese Werte kopieren, stelle nur sicher, dass du den Pfad zu der Scriptdatei anpasst.

**Program/Script:** C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe

**Add arguments:** -windowstyle hidden -command "C:\Users\Fuchur\Documents\PSScriptBackupAndCleanAnnoAccount.ps1"

7. Nachdem du mit "OK" bestätigst, wird die Aufgabe unter "Aktive Aufgaben" aufgeführt

![grafik](https://user-images.githubusercontent.com/29517354/147822763-72491e45-cf8f-4b22-ad2a-b86087c16d6e.png)

8. Das nächste Mal, wenn du dich nun bei Windows anmeldest, wird die Aufgabe automatisch durchgeführt.


## Setup PowerShell ExecutionPolicy

- Die PowerShell ExecutionPolicy muss auf Unrestricted gesetzt werden (siehe https://go.microsoft.com/fwlink/?LinkID=135170 für mehr Informationen)
- NOTE: Das aktivieren der Policy erlaubt es Scripte aus externen Quellen auszuführen. Dies ist ein potenzielles Sicherheitsrisiko!

1. Starte die Windows PowerShell als Administrator

![grafik](https://user-images.githubusercontent.com/29517354/147792058-8ece6813-bf47-47b4-91a3-720f9e60c4cd.png)

2. Führe _Get-ExecutionPolicy -list_ in der PowerShell aus.

![image](https://user-images.githubusercontent.com/29517354/147788401-17309f55-cd79-467e-8b15-8075d95fe073.png)

Ist die ExecutionPolicy für LocalMaschine bereits auf RemoteSigned gesetzt, bist du fertig.

3. Führe _Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine_ in der PowerShell aus, um Scripte aus externen Quellen zu erlauben.

4. Akzeptiere die ExecutionPolicy mit [J] Ja

![image](https://user-images.githubusercontent.com/29517354/147788569-aab1b314-519e-4ba7-a17c-1b745d3ba705.png)



