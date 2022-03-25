@echo off
(
	echo ^<?xml version="1.0" encoding="UTF-16"?^>
	echo ^<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task"^>
	echo ^<RegistrationInfo^>
	echo ^<URI^>\Powershell^</URI^>
	echo ^</RegistrationInfo^>
	echo ^<Triggers^>
	echo ^<LogonTrigger^>
	echo ^<Enabled^>true^</Enabled^>
	echo ^</LogonTrigger^>
	echo ^</Triggers^>
	echo ^<Principals^>
	echo ^<Principal id="Author"^>
	echo ^<LogonType^>InteractiveToken^</LogonType^>
	echo ^<RunLevel^>HighestAvailable^</RunLevel^>
	echo ^</Principal^>
	echo ^</Principals^>
	echo ^<Settings^>
	echo ^<MultipleInstancesPolicy^>IgnoreNew^</MultipleInstancesPolicy^>
	echo ^<DisallowStartIfOnBatteries^>true^</DisallowStartIfOnBatteries^>
	echo ^<StopIfGoingOnBatteries^>true^</StopIfGoingOnBatteries^>
	echo ^<AllowHardTerminate^>true^</AllowHardTerminate^>
	echo ^<StartWhenAvailable^>false^</StartWhenAvailable^>
	echo ^<RunOnlyIfNetworkAvailable^>false^</RunOnlyIfNetworkAvailable^>
	echo ^<IdleSettings^>
	echo ^<StopOnIdleEnd^>true^</StopOnIdleEnd^>
	echo ^<RestartOnIdle^>false^</RestartOnIdle^>
	echo ^</IdleSettings^>
	echo ^<AllowStartOnDemand^>true^</AllowStartOnDemand^>
	echo ^<Enabled^>true^</Enabled^>
	echo ^<Hidden^>false^</Hidden^>
	echo ^<RunOnlyIfIdle^>false^</RunOnlyIfIdle^>
	echo ^<WakeToRun^>false^</WakeToRun^>
	echo ^<ExecutionTimeLimit^>PT72H^</ExecutionTimeLimit^>
	echo ^<Priority^>7^</Priority^>
	echo ^</Settings^>
	echo ^<Actions Context="Author"^>
	echo ^<Exec^>
	echo ^<Command^>%%SystemRoot%%\system32\WindowsPowerShell\v1.0\powershell.exe^</Command^>
	echo ^<WorkingDirectory^>%%userprofile%%/Desktop^</WorkingDirectory^>
	echo ^</Exec^>
	echo ^</Actions^>
	echo ^</Task^>
) >> Powershell.xml
schtasks /create /xml "Powershell.xml" /tn "Powershell"
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force}"
del Powershell.xml
pause