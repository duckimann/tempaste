# If rooted, apks will be located in /data/app
# Using adb, no root
adb shell pm list packages
adb shell pm path com.example.someapp
adb pull /data/app/com.example.someapp-2.apk path/to/desired/destination