### Script zur Sicherung und Bereinigung des Anno 1800 Account-Ordners.
# Es wird keine Haftung für Schäden am Computer übernommen, Einsatz auf eigene Gefahr.
#
# ACHTUNG: Dieses Script LÖSCHT Dateien!
# Bevor du es testest, solltest du daher eine manuelle Sicherung deiner Speicherstände durchführen. Diese sind in der Regel unter "%userprofile%\Documents\Anno 1800" zu finden.
#
# Dieses Script bereinigt den Ordner für Speicherstände von Anno 1800.
# Das Script sichert dabei (default) den kompletten Accounts-Ordner und bereinigt darin ALLE Speicherstände der Profile, bis auf die letzten 10 Stück.
# Ob eine Sicherung durchgeführt wird und wieviele Speicherstände behalten werden, kann weiter unten konfiguriert werden.
#
# Das Script wurde auf Windows 10 21H2 mit der Aktuellen Anno Version (13.0.x) getestet
###

### Script to backup and clean up the Anno 1800 account folder.
# No liability is assumed for damage to the computer, use at your own risk.
#
# WARNING: This script DELETES files!
# Before you test it, you should therefore perform a manual backup of your saves. These are usually to be found under "%userprofile%\Documents\Anno 1800".
#
# This script cleans the folder for saves of Anno 1800.
# The script saves (default) the complete accounts folder and cleans in it ALL saves of the profiles, except for the last 10 pieces.
# Whether a backup is performed and how many saves are kept, can be configured below.
#
# The script has been tested on Windows 10 Home/Pro 21H2 with the current Anno version (13.0.x).
# Translated with https://www.DeepL.com/Translator (free version)
###

### Vorraussetzungen 
# Powershell 3 oder höher muss installiert sein (Standardweise bei Windows 10 Home/Pro bereits vorhanden)
# Powershell ExecutionPolicy muss auf "Unrestricted" gesetzt werden (siehe https://go.microsoft.com/fwlink/?LinkID=135170 für weitere Informationen
# Hinweis: Berücksichitige, dass aktivieren der Policy erlaubt es Scripte aus externen (unsignierten) Quellen auszuführen. Dies ist potenziell ein potenzielles Sicherheitsrisiko
###

### Requierements 
# Powershell 3 or higher must be installed (already present by default with Windows 10 Home/Pro)
# Powershell ExecutionPolicy must set on Unrestricted (see https://go.microsoft.com/fwlink/?LinkID=135170 for more information)
# NOTE: Note that enabling the policy allows to run scripts from external (insigned) sources. This is a potentially security risk.
###

### Common configurations / Allgemeine Einstellungen
# Specifies whether multiplayer sessions are to be taken into account
# Gibt an, ob Multiplayer Sessions berücksichtigt werden sollen
$IgnoreMultiplayerSessions = $false

# Number of scores that remain in the profile. At least one is always kept, even if it is 0.
# Anzahl an Spielständen, die im Profil bleiben. Es bleibt immer mindestens einer erhalten, auch bei 0.
[int]$NumberOfSavsToKeepInProfiles = 10

# Specifies the prefix that folders of MultiplayerSessions have
# Gibt den Prefix an, den Ordner von MultiplayerSessions haben
$MultiplayerSessionFolderPrefix = 'MP-'

# Specifies the file extension of the SaveFiles
# Gibt die Dateierweiterung der SaveFiles an
$SaveGameFileExtention = ".a7s"
###

### Backup configuration / Einstellungen für die Sicherung
# Indicates whether a backup should be created ($true) for YES, ($false) for NO.
# Gibt an, ob ein Backup erstellt werden soll ($true) für JA, ($false) für NEIN.
$BackUpActive = $true

# Specifies the path where backups should be stored. (Can also point to a NAS, for example).
# Gibt den Pfad an, wo Backups abgelegt werden sollen. (Kann bspw. auch auf ein NAS zeigen)
$BackUpPathAnnoAccount = "C:\Archive"

# Specifies the filename of the backup (Will be supplemented with timestamp if active).
# Gibt den Dateinamen des Backups an (Wird, wenn aktiv, mit Datumsstempel ergänzt)
$BackUpName = "Anno1800Backup#"

# Specifies whether the DateFormat should be used for the backup.
# Gibt an ob für das Backup das DateFormat benutzt werden soll
$UseDateStamp = $true

# Gibt die Formatierung des Datumsstempel an
# Wenn das Script mehrmals am Tag durchlaufen werden soll, ist der Format mit Uhrzeit empfohlen. Sonst werden die Backups innerhalb eines Tages überschrieben.
#$DateFormat= "yyyy_MM_dd" # Date stamp without time / Datumsstempel ohne Uhrzeit
$DateFormat = "yyyy_MM_dd#hh_mm" # Date stamp with time / Datumsstempel mit Uhrzeit
###


### Do not change anything from here on! / Ab hier nichts mehr umändern! ###
$PathAnnoAccount =  [Environment]::GetFolderPath("MyDocuments") + "\Anno 1800\accounts"
$BackUpFullFileName = $BackUpPathAnnoAccount  + "\" + $BackUpName
if($UseDateStamp){
    $CurrentDate = Get-Date -Format $DateFormat
    $BackUpFullFileName = $BackUpFullFileName + "_" + $CurrentDate  + ".zip"
} else {
    $BackUpFullFileName = $BackUpFullFileName + ".zip"
}

$BackupSuccess = $false
if( $BackupActive )
{
    # Backup Account
    Write-Output "Backup `"" $PathAnnoAccount "`" to `"" $BackUpFullFileName "`""
    try {
        mkdir $BackUpPathAnnoAccount -EA 0 | Out-Null
            
        If(Test-Path $BackUpFullFileName) {Remove-item $BackUpFullFileName}
        
        Add-Type -assembly "system.io.compression.filesystem"
        [io.compression.zipfile]::CreateFromDirectory($PathAnnoAccount, $BackUpFullFileName)    
        $BackupSuccess = $true
    }
    catch {        
        $BackupSuccess = $false
    }           
} else {$BackupSuccess = $true}


### This is where the cleanup starts / Hier fängt die Bereinigung an
if ($BackupSuccess) 
{    
    $_foundAccounts = $(Get-ChildItem $PathAnnoAccount -Directory)
 
    :AccountLoop foreach($account in $_foundAccounts){
        # Iterate through all account folders / Durch alle Accountordner iterieren 
        $_currentAccountPath = $PathAnnoAccount + "\" + $account
        $_foundProfiles = $(Get-ChildItem -Path $_currentAccountPath -Recurse -Directory -Force -ErrorAction SilentlyContinue | Select-Object Name)

        :ProfileLoop foreach($profile in $_foundProfiles){
            # Iterate through all profile folders / Durch alle Profilordner iterieren             
            if(($IgnoreMultiplayerSessions) -and $profile.Name -like ($MultiplayerSessionFolderPrefix + "*") ){
                continue ProfileLoop 
            }

            $_currentProfilePath = $_currentAccountPath + "\" + $profile.Name            
            $_saveFiles = Get-ChildItem "$_currentProfilePath\*.*" -include ("*" + $SaveGameFileExtention) | Sort-Object LastWriteTime -Descending             

            if(($_saveFiles.Count -le [int]$NumberOfSavsToKeepInProfiles) -or ($_saveFiles.Count -eq 1) ){
                # There are fewer scores than should remain available. Therefore jump directly to the next one.
                # Es sind weniger Spielstände da als übrig bleiben sollen vorhanden. Daher direkt zum nächsten springen.
                continue ProfileLoop
            }
            
            if([int]$NumberOfSavsToKeepInProfiles -le 0){                
                $NumberOfSavsToKeepInProfiles = 1
            }       
            
            $_dateOfLastFile = $_saveFiles[([int]$NumberOfSavsToKeepInProfiles - 1)].LastWriteTime
            
            Write-Host $(-join("All files with change date older ", $_dateOfLastFile, " would be delete."))         
            Write-Host $(-join((Get-ChildItem -Path $_currentProfilePath -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.LastWriteTime -lt $_dateOfLastFile }).Count, " files in ",$profile.Name, " are deleted."))                                
            try {
                Get-ChildItem -Path $_currentProfilePath -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.LastWriteTime -lt $_dateOfLastFile } | Remove-Item -Force            
            }
            catch {
                Write-Output "An error has occurred during deletion."        
            }
            
        }
    }
} else {Write-Output "Backup could not created. No files are deleted."}

