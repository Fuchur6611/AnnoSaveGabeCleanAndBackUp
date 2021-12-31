# AnnoSaveGameBackUpAndCleanup
Script to create a Backup of your account-folder and clean up old auto save files

*Read this in other languages: [English](README.md), [German](README.de.md).*

## Requierements
- Powershell 3 or higher must be installed (already present by default with Windows 10 Home/Pro)
- Powershell ExecutionPolicy must set on Unrestricted (see https://go.microsoft.com/fwlink/?LinkID=135170 for more information)
- NOTE: Enabling the policy allows to run scripts from external (insigned) sources. This is a potentially security risk.

## Setup
1. Download the script file to a directory of your choice.
2. Start Windows PowerShell as Administrator

![grafik](https://user-images.githubusercontent.com/29517354/147792058-8ece6813-bf47-47b4-91a3-720f9e60c4cd.png)

3. Run _Get-ExecutionPolicy -list_ in powershell 

![image](https://user-images.githubusercontent.com/29517354/147788401-17309f55-cd79-467e-8b15-8075d95fe073.png)

Is the ExecutionPolicy for LocalMaschine already set to RemoteSigned you can skip step 4-5

4. Run _Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine_ in powershell to allow scripts from external source.
5. Accept the new ExecutionPolicy with [Y] Yes 

![image](https://user-images.githubusercontent.com/29517354/147788569-aab1b314-519e-4ba7-a17c-1b745d3ba705.png)


## Configuration
The script has several configuration options. 
By default, a backup of the entire account folder is created on "C:\Archive" and the last 10 saves are left in each profile folder during the cleanup.

The configuration options are documented in the script.
(see [PSScriptBackupAndCleanAnnoAccount.ps1](PSScriptBackupAndCleanAnnoAccount.ps1)). 

## Execution
A one-time execution can be started via the context menu.

![grafik](https://user-images.githubusercontent.com/29517354/147792472-954525de-1d90-41e9-b27b-73643d53ec5e.png)

Repetitive execution can be configured via Windows Task Scheduler
