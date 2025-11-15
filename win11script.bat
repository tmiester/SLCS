@echo off
title cyberpatriot script frfr
color 0a

REM Display Intro Screen
echo ============================================
echo          Cyberpatriot 18 Script Win11
echo                by BlueJayCoding
echo   GitHub Repository: https://github.com/BlueJayCoding/
echo ============================================
echo.
echo this script should help you secure a couple of points ong 
echo.
echo please run this script as administrator, and make sure to read each step before proceeding.
echo.
echo you'll do great! don't worry :D
pause


REM Step 1: Enable Windows Firewall
echo.
echo Step 1: Enabling Windows Firewall...
echo This will enable the Windows Firewall on your system.
echo.
pause
netsh advfirewall set allprofiles state on

REM Step 2: Enable BitLocker
echo.
echo Step 2: Enabling BitLocker...
echo This will enable BitLocker drive encryption on your system.
echo BitLocker requires compatible hardware support however.
echo.
pause
manage-bde -on C: -used

REM Step 3: Disable USB Ports
echo Disabling USB ports...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "Start" /t REG_DWORD /d 4 /f
echo USB ports have been disabled.
pause

echo Step 4: Setting password policies...
rem Set minimum password length to 8 characters
net accounts /minpwlen:8
rem Set password expiration to 30 days
net accounts /maxpwage:30
rem Enforce password history to prevent reuse
net accounts /uniquepw:5
echo Password policies have been applied.
pause


REM Step 5: Disable Autorun/Autoplay for removable devices
echo.
echo Step 5: Disabling Autorun/Autoplay for removable devices...
echo.
pause
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 255 /f
echo Autorun/Autoplay has been disabled succesfully.


REM Step 6: Enable screensaver password protection (timeout is currently set to 60 seconds)
echo. Step 6: Enabling screensaver password protection... 
echo.
pause
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaverTimeout /t REG_SZ /d 60 /f
echo All steps completed. Your system security settings have been updated.
pause 


REM Step 7: Delete guest account
echo.
echo Step 7 : Disabling guest accounts...
echo This will disable guest accounts on your system.
echo.
pause
net user guest /active:no
echo Guest accounts have been disabled successfully.
pause

REM end of script 11/14/2025
echo All steps completed, good luck, and win the round! :D 




