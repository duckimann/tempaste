%__COMPAT_LAYER%
%ALLUSERSPROFILE%
%APPDATA%
%CommonProgramFiles%
%CommonProgramFiles(x86)%
%CommonProgramW6432%
%COMPUTERNAME%
%ComSpec%
%DriverData%
%FPS_BROWSER_APP_PROFILE_STRING%
%FPS_BROWSER_USER_PROFILE_STRING%
%HOMEDRIVE%
%HOMEPATH%
%LOCALAPPDATA%
%LOGONSERVER%
%NUMBER_OF_PROCESSORS%
%OneDrive%
%OS%
%Path%
%PATHEXT%
%PROCESSOR_ARCHITECTURE%
%PROCESSOR_ARCHITEW6432%
%PROCESSOR_IDENTIFIER%
%PROCESSOR_LEVEL%
%PROCESSOR_REVISION%
%ProgramData%
%ProgramFiles%
%ProgramFiles(x86)%
%ProgramW6432%
%PSModulePath%
%PUBLIC%
%SystemDrive%
%SystemRoot%
%temp%
%tmp%
%userdata%
%USERDOMAIN%
%USERDOMAIN_ROAMINGPROFILE%
%USERNAME%
%USERPROFILE%
%windir%

rem start menu
C:\ProgramData\Microsoft\Windows\Start Menu
%appdata%\Microsoft\Windows\Start Menu

rem Registry Startup
rem HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
rem HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
rem HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run
rem HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32
rem HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\StartupFolder
rem HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
rem HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
rem HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce
rem HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run
rem HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce

rem Special Shell Commands
shell:Startup
shell:Common Startup
shell:Common Start Menu
shell:AppData
shell:ControlPanelFolder
shell:AppsFolder
shell:Common Programs
shell:Local AppData
shell:LocalAppDataLow
shell:ProgramFiles
shell:ProgramFilesCommon
shell:ProgramFilesCommonX64
shell:ProgramFilesCommonX86
shell:ProgramFilesX64
shell:ProgramFilesX86
shell:Programs
shell:SendTo
shell:Start Menu
shell:Desktop
shell:AccountPictures
shell:Common Administrative Tools
shell:Common AppData
shell:Common Programs
shell:ConnectionsFolder
shell:DocumentsLibrary
shell:Downloads
shell:Fonts
shell:MyComputerFolder
shell:Profile
shell:User Pinned
shell:RecycleBinFolder
shell:ResourceDir
shell:System
shell:SystemX86
shell:ThisPCDesktopFolder
shell:Windows

appwiz.cpl
compmgmt.msc
control
control folders
control mouse
control netconnections
control printers
main.cpl
mmsys.cpl
ncpa.cpl
useraccountcontrolsettings
winver
rundll32.exe shell32.dll,Control_RunDll hotplug.dll

%0 - %10 rem use in scripting
%~dp0