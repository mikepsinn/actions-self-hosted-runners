# Backup script

# Define the name of the Vagrant box to be backed up
$boxName = "actions-runner"

# Define the location to save the backup file
$backupLocation = "C:\Vagrant_Backups\"

# Check if the backup location exists, if not create it
if (!(Test-Path $backupLocation)) {
  New-Item -ItemType Directory -Force -Path $backupLocation
}

# Create the backup file name
$backupFile = "$boxName-$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss').box"

# Run the backup command
vagrant package --base $boxName --output $backupLocation$backupFile

# Confirm that the backup was created
if (Test-Path $backupLocation$backupFile) {
  Write-Host "Vagrant box $boxName was successfully backed up to $backupLocation$backupFile"
} else {
  Write-Host "An error occurred while backing up the Vagrant box $boxName"
}
