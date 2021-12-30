# AnnoSaveGameBackUpAndCleanup
Script to create a Backup of your account-folder and clean up old auto save files

**Setup**
1. Download the script file to a directory of your choice.
2. Start PowerShell as Administrator
![image](https://user-images.githubusercontent.com/29517354/147788209-d3557455-bfd4-4b3b-9ba8-3605317cff66.png)
3. Run _Get-ExecutionPolicy -list_ in powershell 

![image](https://user-images.githubusercontent.com/29517354/147788401-17309f55-cd79-467e-8b15-8075d95fe073.png)

Is the ExecutionPolicy for LocalMaschine already set to RemoteSigned you can skip step 4-5

4. Run _Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine_ in powershell to allow scripts from external source.
5. Accept the new ExecutionPolicy with [Y] Yes 
![image](https://user-images.githubusercontent.com/29517354/147788569-aab1b314-519e-4ba7-a17c-1b745d3ba705.png)

