@echo off

rem Using WMIC
rem get interfaces
wmic nic get name, index

rem disable / enable interface
wmic path win32_networkadapter where index=1 call disable
wmic path win32_networkadapter where index=1 call enable


rem Using netsh
rem show interfaces
netsh interface show interface

rem disable / enable interface
netsh interface set interface "InterfaceName" disable
netsh interface set interface "InterfaceName" enable