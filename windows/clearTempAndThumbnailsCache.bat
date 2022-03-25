taskkill /f /im explorer.exe
del /f /s /q %temp%
del /f /s /q %LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db
rmdir /s /q %temp%
start explorer.exe