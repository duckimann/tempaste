if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-ExecutionPolicy Bypass -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}

$RegHeader = @"
Windows Registry Editor Version 5.00


"@;
$data_enable = [ordered]@{
    "260 Character Path Limit" = @"
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
"LongPathsEnabled"=dword:00000000
"@
    "Context Menu: Print" = @"
[HKEY_CLASSES_ROOT\SystemFileAssociations\image\shell\print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\batfile\shell\print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\cmdfile\shell\print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\docxfile\shell\print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\fonfile\shell\print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\htmlfile\shell\print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\inffile\shell\print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\inifile\shell\print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\JSEFile\Shell\Print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\otffile\shell\print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\pfmfile\shell\print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\regfile\shell\print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\rtffile\shell\print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\ttcfile\shell\print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\ttffile\shell\print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\txtfile\shell\print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\VBEFile\Shell\Print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\VBSFile\Shell\Print]
"ProgrammaticAccessOnly"=""

[HKEY_CLASSES_ROOT\WSFFile\Shell\Print]
"ProgrammaticAccessOnly"=""
"@
    "Context Menu: Give Access To X" = @"
[HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\Sharing]
@="{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"

[HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers\Sharing]
@="{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"

[HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers\Sharing]
@="{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"

[HKEY_CLASSES_ROOT\Directory\shellex\CopyHookHandlers\Sharing]
@="{40dd6e20-7c17-11ce-a804-00aa003ca9f6}"

[HKEY_CLASSES_ROOT\Directory\shellex\PropertySheetHandlers\Sharing]
@="{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"

[HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\Sharing]
@="{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"

[HKEY_CLASSES_ROOT\Drive\shellex\PropertySheetHandlers\Sharing]
@="{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"

[HKEY_CLASSES_ROOT\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing]
@="{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"

[HKEY_CLASSES_ROOT\UserLibraryFolder\shellex\ContextMenuHandlers\Sharing]
@="{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoInplaceSharing"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
"forceguest"=dword:00000000
"@
    "Context Menu: Include in Library" = @"
[HKEY_CLASSES_ROOT\Folder\ShellEx\ContextMenuHandlers\Library Location]
@="{3dad6c5d-2167-4cae-9914-f99e41c12cfa}"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\ShellEx\ContextMenuHandlers\Library Location]
@="{3dad6c5d-2167-4cae-9914-f99e41c12cfa}"
"@
    "Context Menu: Pin to Start Menu" = @"
[HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\PintoStartScreen]
@="{470C0EBD-5D73-4d58-9CED-E91E22E23282}"

[HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\PintoStartScreen]
@="{470C0EBD-5D73-4d58-9CED-E91E22E23282}"

[HKEY_CLASSES_ROOT\Microsoft.Website\ShellEx\ContextMenuHandlers\PintoStartScreen]
@="{470C0EBD-5D73-4d58-9CED-E91E22E23282}"

[HKEY_CLASSES_ROOT\mscfile\shellex\ContextMenuHandlers\PintoStartScreen]
@="{470C0EBD-5D73-4d58-9CED-E91E22E23282}"
"@
    "Context Menu: Pin to Quick Access" = @"
[-HKEY_CLASSES_ROOT\Folder\shell\pintohome]

[HKEY_CLASSES_ROOT\Folder\shell\pintohome]
"MUIVerb"="@shell32.dll,-51377"
"AppliesTo"="System.ParsingName:<>\"::{679f85cb-0220-4080-b29b-5540cc05aab6}\""

[HKEY_CLASSES_ROOT\Folder\shell\pintohome\command]
"DelegateExecute"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"

[-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shell\pintohome]

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shell\pintohome]
"MUIVerb"="@shell32.dll,-51377"
"AppliesTo"="System.ParsingName:<>\"::{679f85cb-0220-4080-b29b-5540cc05aab6}\""

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shell\pintohome\command]
"DelegateExecute"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"
"@
    "Explorer: 3D Objects Folder" = @"
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace]
"@
    "Explorer: Desktop Folder" = @"
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}]
"@
    "Explorer: Document Folder" = @"
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}]
"@
    "Explorer: Downloads Folder" = @"
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}]
"@
    "Explorer: Libraries Folder" = @"
[HKEY_CURRENT_USER\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}]
"System.IsPinnedToNameSpaceTree"=dword:1
"@
    "Explorer: Music Folder" = @"
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}]
"@
    "Explorer: Network Folder" = @"
[HKEY_CLASSES_ROOT\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder]
"Attributes"=dword:b0040064

[HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}}\ShellFolder]
"Attributes"=dword:b0040064
"@
    "Explorer: OneDrive Folder" = @"
[HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}]
"System.IsPinnedToNameSpaceTree"=dword:1

[HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}]
"System.IsPinnedToNameSpaceTree"=dword:1
"@
    "Explorer: Pictures Folder" = @"
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}]
"@
    "Explorer: Quick Access Folder" = @"
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"HubMode"=dword:00000000
"@
    "Explorer: Removable Drives" = @"
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}]
@="Removable Drives"

[HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}]
@="Removable Drives"
"@
    "Explorer: Videos Folder" = @"
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}]
"@
    "Notification: Could Not Reconnect All Network Drives" = @"
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\NetworkProvider]
"RestoreConnection"=-
"@
    "Properties: Previous Version Tab" = @"
[HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[HKEY_CLASSES_ROOT\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]


; Add to Properties tab
[HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[HKEY_CLASSES_ROOT\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[HKEY_CLASSES_ROOT\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[HKEY_CLASSES_ROOT\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]


; To clear any policies
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
"NoPreviousVersionsPage"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"NoPreviousVersionsPage"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PreviousVersions]
"DisableLocalPage"=-

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
"NoPreviousVersionsPage"=-

[HKEY_CURRENT_USER\Software\Policies\Microsoft\PreviousVersions]
"DisableLocalPage"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{596AB062-B4D2-4215-9F74-E9109B0A8153}"=-
"@
    "Taskbar: Meet Now Icon" =@"
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"HideSCAMeetNow"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"HideSCAMeetNow"=-
"@
};
$data_disable = [ordered]@{
    "260 Character Path Limit" = @"
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
"LongPathsEnabled"=dword:00000001
"@
    "Context Menu: Print" = @"
[HKEY_CLASSES_ROOT\SystemFileAssociations\image\shell\print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\batfile\shell\print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\cmdfile\shell\print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\docxfile\shell\print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\fonfile\shell\print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\htmlfile\shell\print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\inffile\shell\print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\inifile\shell\print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\JSEFile\Shell\Print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\otffile\shell\print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\pfmfile\shell\print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\regfile\shell\print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\rtffile\shell\print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\ttcfile\shell\print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\ttffile\shell\print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\txtfile\shell\print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\VBEFile\Shell\Print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\VBSFile\Shell\Print]
"ProgrammaticAccessOnly"=-

[HKEY_CLASSES_ROOT\WSFFile\Shell\Print]
"ProgrammaticAccessOnly"=-
"@
    "Context Menu: Give Access To X" = @"
[-HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\Sharing]

[-HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers\Sharing]

[-HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers\Sharing]

[-HKEY_CLASSES_ROOT\Directory\shellex\CopyHookHandlers\Sharing]

[-HKEY_CLASSES_ROOT\Directory\shellex\PropertySheetHandlers\Sharing]

[-HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\Sharing]

[-HKEY_CLASSES_ROOT\Drive\shellex\PropertySheetHandlers\Sharing]

[-HKEY_CLASSES_ROOT\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing]

[-HKEY_CLASSES_ROOT\UserLibraryFolder\shellex\ContextMenuHandlers\Sharing]
"@
    "Context Menu: Include in Library" = @"
[-HKEY_CLASSES_ROOT\Folder\ShellEx\ContextMenuHandlers\Library Location]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\ShellEx\ContextMenuHandlers\Library Location]
"@
    "Context Menu: Pin to Start Menu" = @"
[-HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\PintoStartScreen]

[-HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\PintoStartScreen]

[-HKEY_CLASSES_ROOT\Microsoft.Website\ShellEx\ContextMenuHandlers\PintoStartScreen]

[-HKEY_CLASSES_ROOT\mscfile\shellex\ContextMenuHandlers\PintoStartScreen]
"@
    "Context Menu: Pin to Quick Access" = @"
[-HKEY_CLASSES_ROOT\Folder\shell\pintohome]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shell\pintohome]
"@
    "Explorer: 3D Objects" = @"
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}]
"@
    "Explorer: Desktop Folder" = @"
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}]
"@
    "Explorer: Document Folder" = @"
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}]
"@
    "Explorer: Downloads Folder" = @"
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}]
"@
    "Explorer: Libraries Folder" = @"
[-HKEY_CURRENT_USER\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}]
"System.IsPinnedToNameSpaceTree"=dword:1
"@
    "Explorer: Music Folder" = @"
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}]
"@
    "Explorer: Network Folder" = @"
[-HKEY_CLASSES_ROOT\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder]
"Attributes"=dword:b0940064

[-HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}}\ShellFolder]
"Attributes"=dword:b0940064
"@
    "Explorer: OneDrive Folder" = @"
[-HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}]
"System.IsPinnedToNameSpaceTree"=dword:0

[-HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}]
"System.IsPinnedToNameSpaceTree"=dword:0
"@
    "Explorer: Pictures Folder" = @"
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}]
"@
    "Explorer: Quick Access Folder" = @"
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"HubMode"=dword:00000001
"@
    "Explorer: Removable Drives" = @"
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}]
@="Removable Drives"

[-HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}]
@="Removable Drives"
"@
    "Explorer: Videos Folder" = @"
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}]
"@
    "Notification: Could Not Reconnect All Network Drives" = @"
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\NetworkProvider]
"RestoreConnection"=dword:00000000
"@
    "Properties: Previous Version Tab" = @"
; Removed from Properties tab
[-HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[-HKEY_CLASSES_ROOT\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[-HKEY_CLASSES_ROOT\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[-HKEY_CLASSES_ROOT\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]


; Remove from context menu
[-HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[-HKEY_CLASSES_ROOT\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[-HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[-HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]


; To clear any policies
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
"NoPreviousVersionsPage"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"NoPreviousVersionsPage"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PreviousVersions]
"DisableLocalPage"=-

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
"NoPreviousVersionsPage"=-

[HKEY_CURRENT_USER\Software\Policies\Microsoft\PreviousVersions]
"DisableLocalPage"=-
"@
    "Taskbar: Meet Now Icon" =@"
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"HideSCAMeetNow"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"HideSCAMeetNow"=dword:00000001
"@
};
$data_misc = [ordered]@{
    "Network: Reservable Bandwidth = 0" = @"
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched]
"NonBestEffortLimit"=dword:00000000
"@
    "Login: Verbose" = @"
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"VerboseStatus"=dword:00000001
"@
}

$OutputReg = "";

# Setup Form
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms");
[System.Windows.Forms.Application]::EnableVisualStyles();

$Form = New-Object System.Windows.Forms.Form;
$Form.text = "Registry Tweaks";
$Form.AutoSize = $true;
$Form.MinimizeBox = $false;
$Form.MaximizeBox = $false;
$Form.FormBorderStyle = "Fixed3D";
$Form.Font = New-Object System.Drawing.Font("Consolas", 11);

Function Gen-CBGroup($GroupTitle = "", $Arr = "", $PosX = 0, $PosY = 0) {
    $groupBox = New-Object System.Windows.Forms.GroupBox;
    $groupBox.Location = New-Object System.Drawing.Size($PosX, $PosY);
    $groupBox.AutoSize = $true;
    $groupBox.text = $GroupTitle;
    $Form.Controls.Add($groupBox);

    $Checkboxes = @();
    $y = 20;

    foreach ($a in $Arr.keys) {
        $Checkbox = New-Object System.Windows.Forms.CheckBox;
        $Checkbox.Text = $a;
        $Checkbox.Location = New-Object System.Drawing.Size(10, $y);
        $Checkbox.AutoSize = $true;
        $y += 25;
        $groupBox.Controls.Add($Checkbox);
        $Checkboxes += $Checkbox;
    }
    return $Checkboxes;
}

$CBEnable = Gen-CBGroup "Enable" $data_enable 5 5;
$CBDisable = Gen-CBGroup "Disable" $data_disable 490 5;
$CBMisc = Gen-CBGroup "Misc" $data_misc 975 5;

# Control Buttons
$AppyBtn = new-object System.Windows.Forms.Button;
$AppyBtn.Location = new-object System.Drawing.Size(500, 600);
$AppyBtn.Size = new-object System.Drawing.Size(200, 30);
$AppyBtn.Text = "Apply Tweaks";
$AppyBtn.Add_Click({
    foreach($CheckBox in $CBEnable) {
        if($CheckBox.Checked) {
            $OutputReg += "$($data_enable[$CheckBox.Text])`n`n";
        }
    }
    foreach($CheckBox in $CBDisable) {
        if($CheckBox.Checked) {
            $OutputReg += "$($data_disable[$CheckBox.Text])`n`n";
        }
    }
    foreach($CheckBox in $CBMisc) {
        if($CheckBox.Checked) {
            $OutputReg += "$($data_misc[$CheckBox.Text])`n`n";
        }
    }
    "$($RegHeader)$($OutputReg)" | Out-File ./mod.reg;
    taskkill /f /im explorer.exe;
    regedit /s ./mod.reg;
    Start-Sleep -s 3;
    Remove-Item ./mod.reg;
    explorer.exe;
    $Form.Close();
    [System.Environment]::Exit(0);
})
$Form.Controls.Add($AppyBtn);

$CancelBtn = new-object System.Windows.Forms.Button;
$CancelBtn.Location = new-object System.Drawing.Size(730, 600);
$CancelBtn.Size = new-object System.Drawing.Size(100, 30);
$CancelBtn.Text = "Cancel";
$CancelBtn.Add_Click({
    $Form.Close();
    [System.Environment]::Exit(0);
})
$Form.Controls.Add($CancelBtn);
$Form.ShowDialog() | Out-Null;