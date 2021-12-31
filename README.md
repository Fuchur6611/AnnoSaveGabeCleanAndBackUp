# AnnoSaveGameBackUpAndCleanup
Script to create a Backup of your account-folder and clean up old auto save files

*Read this in other languages: [English](README.md), [German](README.de.md).*

## Requierements
- Powershell 3 or higher must be installed (already present by default with Windows 10 Home/Pro)

## Configuration
The script has several configuration options. 
By default, a backup of the entire account folder is created on "C:\Archive" and the last 10 saves are left in each profile folder during the cleanup.

The configuration options are documented in the script.
(see [PSScriptBackupAndCleanAnnoAccount.ps1](PSScriptBackupAndCleanAnnoAccount.ps1)). 

## Execution
### A one-time execution
Can be started via the context menu.

![grafik](https://user-images.githubusercontent.com/29517354/147792472-954525de-1d90-41e9-b27b-73643d53ec5e.png)

This message appears because script files from the Internet are considered unsafe by Windows. However, when you click on "Open", the script is executed.

If you uncheck the box, the message will not appear next time.

![grafik](https://user-images.githubusercontent.com/29517354/147825468-9a1bef87-2177-4c58-bec7-f48d2cce00e1.png)


### Repetitive execution 
Can be configured via Windows Task Scheduler
NOTE: For task execution it is necessary to set up the PowerShell ExecutionPolicy. More about this under "Setup PowerShell ExecutionPolicy". 

1. Save the file where it does not interfere
   In the example the file is located on "C:\Users\Fuchur\Documents\PSScriptBackupAndCleanAnnoAccount.ps1".

2. Open the Task Scheduler

![grafik](https://user-images.githubusercontent.com/29517354/147822071-a4d01808-6e53-4c86-b727-0d8cb4d8df52.png)

3. Click "Create Task..." in the right side

![grafik](https://user-images.githubusercontent.com/29517354/147822139-284d7bc5-5d07-42ab-a0cf-12264e82bb62.png)

4. Give the task a meaningful name

![grafik](https://user-images.githubusercontent.com/29517354/147822167-59e0f933-25fa-4494-8fbb-155104f74ffb.png)

5. Set a trigger for the task. For the example it is set to the Windows user logon.

![grafik](https://user-images.githubusercontent.com/29517354/147822217-0ffc3e16-b4ef-4d3a-be25-63ba47d253c6.png)

6. Set an action for the task.

![grafik](https://user-images.githubusercontent.com/29517354/147822694-67ac1315-b22e-49cd-be09-1a7eb0f89ff7.png)

You can simply copy these values. Just make sure that the path to your script file is adjusted.

**Program/Script:** C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe

**Add arguments:** -windowstyle hidden -command "C:\Users\Fuchur\Documents\PSScriptBackupAndCleanAnnoAccount.ps1"

7. After you confirm with OK, the task will appear in the "Active Task" list.

![grafik](https://user-images.githubusercontent.com/29517354/147822763-72491e45-cf8f-4b22-ad2a-b86087c16d6e.png)

9. The next time you log in to your PC, the script will now run automatically.


## Setup PowerShell ExecutionPolicy

- Powershell ExecutionPolicy must set on Unrestricted (see https://go.microsoft.com/fwlink/?LinkID=135170 for more information)
- NOTE: Enabling the policy allows to run scripts from external (insigned) sources. This is a potentially security risk.

1. Start Windows PowerShell as Administrator

![grafik](https://user-images.githubusercontent.com/29517354/147792058-8ece6813-bf47-47b4-91a3-720f9e60c4cd.png)

2. Run _Get-ExecutionPolicy -list_ in PowerShell 

![image](https://user-images.githubusercontent.com/29517354/147788401-17309f55-cd79-467e-8b15-8075d95fe073.png)

Is the ExecutionPolicy for LocalMaschine already set to RemoteSigned you are finished

4. Run _Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine_ in powershell to allow scripts from external source.

5. Accept the new ExecutionPolicy with [Y] Yes 

![image](https://user-images.githubusercontent.com/29517354/147788569-aab1b314-519e-4ba7-a17c-1b745d3ba705.png)


## Ideas
For example, you can save the script twice. Once that it creates backups ($BackUpActive = $true) and once that it does not create backups ($BackUpActive = $false).

Then it would be possible to create two tasks... that e.g. the cleanup is done at every login and the backup only 1x per month.
![grafik](https://user-images.githubusercontent.com/29517354/147828553-7c4036a1-e22b-4e33-9175-a7c72c961d63.png)
