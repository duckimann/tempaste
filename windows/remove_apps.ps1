# Set-ExecutionPolicy RemoteSigned

# Run PS as Admin
# Get-AppxPackage       # Show all apps and its info
# Get-AppxPackage | Select Name, PackageFullName       # Show all apps but only show the name and package full name
# Get-AppxPackage *name*        # Get apps with "name"
# Get Appxpackage *name* | Remove-AppxPackage       # Remove app "name"
# Get Appxpackage *name* -AllUsers | Remove-AppxPackage       # Remove app "name" with all users

Get-AppxPackage *3DViewer* -AllUsers | Remove-AppxPackage # Remove "3D Viewer"
Get-AppxPackage *BingWeather* -AllUsers | Remove-AppxPackage # Remove "Weather"
# Get-AppxPackage *Edge* -AllUsers | Remove-AppxPackage # Remove "Edge"
Get-AppxPackage *Feedback* -AllUsers | Remove-AppxPackage # Remove "Feedback Hub"
Get-AppxPackage *GetStarted* -AllUsers | Remove-AppxPackage # Remove "Get Started"
Get-AppxPackage *MSPaint* -AllUsers | Remove-AppxPackage # Remove "MS Paint"
Get-AppxPackage *Microsoft.GetHelp* -AllUsers | Remove-AppxPackage # Remove "Get Help"
Get-AppxPackage *Microsoft.People* -AllUsers | Remove-AppxPackage # Remove "People"
Get-AppxPackage *MixedReality* -AllUsers | Remove-AppxPackage # Remove "Mixed Reality"
Get-AppxPackage *Office.OneNote* -AllUsers | Remove-AppxPackage # Remove "OneNote"
Get-AppxPackage *OfficeHub* -AllUsers | Remove-AppxPackage # Remove "Office"
Get-AppxPackage *Photos* -AllUsers | Remove-AppxPackage # Remove "Photos"
Get-AppxPackage *ScreenSketch* -AllUsers | Remove-AppxPackage # Remove "Snip & Sketch"
Get-AppxPackage *SkypeApp* -AllUsers | Remove-AppxPackage # Remove "Skype"
Get-AppxPackage *SolitaireCollection* -AllUsers | Remove-AppxPackage # Remove "Solitaire"
Get-AppxPackage *SoundRecorder* -AllUsers | Remove-AppxPackage # Remove "Sound Recorder"
Get-AppxPackage *Stickynotes* -AllUsers | Remove-AppxPackage # Remove "Sticky Notes"
Get-AppxPackage *WindowsMaps* -AllUsers | Remove-AppxPackage # Remove "Maps"
Get-AppxPackage *XboxApp* -AllUsers | Remove-AppxPackage # Remove "Xbox"
Get-AppxPackage *YourPhone* -AllUsers | Remove-AppxPackage # Remove "YourPhone"
Get-AppxPackage *ZuneMusic* -AllUsers | Remove-AppxPackage # Remove "Music"
Get-AppxPackage *ZuneVideo* -AllUsers | Remove-AppxPackage # Remove "Video"
Get-AppxPackage *communicationsapps* -AllUsers | Remove-AppxPackage # Remove "Mail"
Get-AppxPackage Microsoft.549981C3F5F10 -AllUsers | Remove-AppxPackage # Remove "Cortana"

echo "Remove OneDrive"
if (Test-Path "$env:systemroot\System32\OneDriveSetup.exe") {
    & "$env:systemroot\System32\OneDriveSetup.exe" /uninstall
}
if (Test-Path "$env:systemroot\SysWOW64\OneDriveSetup.exe") {
    & "$env:systemroot\SysWOW64\OneDriveSetup.exe" /uninstall
}

echo "Remove MS Edge (Using Installer)"
if (Test-Path "${env:ProgramFiles(x86)}/Microsoft/Edge/Application/[0-9]*/Installer/setup.exe") {
	& "${env:ProgramFiles(x86)}/Microsoft/Edge/Application/[0-9]*/Installer/setup.exe" --uninstall --force-uninstall --system-level
}