dism /Get-WimInfo /WimFile:install.esd
dism /Get-WimInfo /WimFile:install.esd /index:1
dism /export-image /SourceImageFile:install.esd /SourceIndex:1 /DestinationImageFile:install.wim /Compress:max /CheckIntegrity