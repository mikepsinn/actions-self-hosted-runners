# Restore script

# Define the location of the backup file
$backupFile = "C:\Vagrant_Backups\actions-runner.box"

# Define the name to give the restored box
$boxName = "actions-runner"

# Add the backup file as a new Vagrant box
vagrant box add $boxName $backupFile

# Confirm that the box was added
if (vagrant box list | Select-String -Pattern $boxName) {
  Write-Host "Vagrant box $boxName was successfully restored"
} else {
  Write-Host "An error occurred while restoring the Vagrant box $boxName"
}