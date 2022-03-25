rem Wifi Network Name is in <name>...</name>
rem Wifi Network Password is in <keyMaterial>...</keyMaterial>

mkdir wifi-pwd && echo Creating directory to save wifi(s) info
netsh wlan export profile interface=wi-fi key=clear folder=%~dp0\wifi-pwd
if not exist %~dp0\wifi-pwd\*.xml rmdir "wifi-pwd" && echo "There is no wifi logged, Deleting directory."

rem for powershell
rem  (netsh wlan show profiles) | Select-String “\:(.+)$” | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | %{(netsh wlan show profile name=”$name” key=clear)} | Select-String “Key Content\W+\:(.+)$” | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | %{[PSCustomObject]@{ PROFILE_NAME=$name;PASSWORD=$pass }} | Format-Table -AutoSize