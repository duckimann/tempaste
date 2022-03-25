# Ref
# https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/manage-bde
# https://docs.microsoft.com/en-us/windows/security/information-protection/bitlocker/bitlocker-use-bitlocker-drive-encryption-tools-to-manage-bitlocker
# https://superuser.com/questions/1507217/how-does-a-microsoft-accountless-bitlocker-encryption-scheme-work

# DWROD: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\BitLocker\PreventDeviceEncryption		[Value: 1]
# Cmd command
manage-bde -status
manage-bde -off [DriveLetter]:
manage-bde -on [DriveLetter]:
manage-bde [DriveLetter]: -protectors -get

# Powershell command
Get-BitLockerVolume
Get-BitLockerVolume -MountPoint "C:"
Disable-BitLocker -MountPoint $BLV