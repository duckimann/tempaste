# sc.exe delete <service_name>
# sc.exe create <service_name> binPath=<path_to_executable_file>
# Open regedit -> HKLM -> SYSTEM -> CurrentControlSet -> services -> <service_name> -> Modify String named "ImagePath" to fit your command ;)