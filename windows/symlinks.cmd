mklink /d c:\path\to\symlink c:\target\directory

rem Powershell
New-Item -Path C:\LinkDir -ItemType SymbolicLink -Value F:\RealDir