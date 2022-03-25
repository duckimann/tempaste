@echo off
reg add "HKCU\control panel\desktop" /v wallpaper /t REG_SZ /d "" /f 
reg add "HKCU\control panel\desktop" /v wallpaper /t REG_SZ /d "C:\Crack All Of Them\10.jpg" /f 
reg delete "HKCU\Software\Microsoft\Internet Explorer\Desktop\General" /v WallpaperStyle /f

reg add "HKCU\control panel\desktop" /v WallpaperStyle /t REG_SZ /d 10 /f
rem Center	0
rem Fill	4
rem Fit	    3
rem Span	5
rem Stretch	2
rem Tile	1

RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters 
exit