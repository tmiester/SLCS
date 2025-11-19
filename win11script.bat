@echo off
title cyberpatriot script frfr
color 02

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Run as Administrator
    pause
    exit /b
)

REM Display Intro Screen
echo ===========================================================
echo           Cyberpatriot 18 Script Windows 11
echo            by BlueJayCoding & Team 18-3245
echo     GitHub Profile: https://github.com/BlueJayCoding/
echo ===========================================================
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
echo Windows Firewall has been enabled successfully.
pause

echo Step 2: Setting all password policies...
rem Set minimum password length to 8 characters
net accounts /minpwlen:8
rem Set password expiration to 30 days
net accounts /maxpwage:30
rem Enforce password history to prevent reuse
net accounts /uniquepw:5
rem Set account lockout threshold to 5 invalid attempts 
net accounts /lockoutthreshold:5 /lockoutduration:15
echo Password policies have been applied.
pause


REM Step 3: Disable Autorun/Autoplay for removable devices
echo.
echo Step 3: Disabling Autorun/Autoplay for removable devices...
echo.
pause
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 255 /f
echo Autorun/Autoplay has been disabled succesfully.


REM Step 4: Enable screensaver password protection (timeout is currently set to 300 seconds)
echo. Step 4: Enabling screensaver password protection... 
echo.
pause
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaveActive /t REG_SZ /d 1 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaverIsSecure /t REG_SZ /d 1 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaverTimeout /t REG_SZ /d 300 /f
pause
echo All steps completed. Your system security settings have been updated.
pause 


REM Step 5: Delete guest account
echo.
echo Step 5 : Disabling guest accounts...
echo This will disable guest accounts on your system.
echo.
pause
net user guest /active:no
echo Guest accounts have been disabled successfully.
pause

REM Step 6: Disable unused services (modify as needed)

echo Step 6: Disabling unused services...
echo This will disable several unused services on your system such as Fax, Remote Registry, Telnet, FTP, SNMP, UPnP, and SSDP.
echo.
pause
:: the > command redirects output so you don't see it
:: the 2>&1 part sents it to the same place as standard output (nul)
:: The && mean "if the previous command succeeded, then run the next command"

:: Fax
sc config Fax start= disabled >nul 2>&1
net stop Fax >nul 2>&1
:: Remote Registry
sc config RemoteRegistry start= disabled >nul 2>&1
net stop RemoteRegistry >nul 2>&1
:: Telnet
sc config TlntSvr start= disabled >nul 2>&1
net stop TlntSvr >nul 2>&1
::uPnP 
sc config upnphost start= disabled >nul 2>&1
net stop upnphost >nul 2>&1
:: SSDP
sc config SSDPSRV start= disabled >nul 2>&1
net stop SSDPSRV >nul 2>&1
:: FTP
sc query msftpsvc >nul 2>&1 && sc config msftpsvc start= disabled
sc query msftpsvc >nul 2>&1 && net stop msftpsvc
:: SNMP
sc query SNMP >nul 2>&1 && sc config SNMP start= disabled
sc query SNMP >nul 2>&1 && net stop SNMP
pause
echo Done disabling unused services.
echo 
pause

REM Step 7: Enable Windows Defender SmartScreen
echo.
echo Step 7: Enabling Windows Defender SmartScreen...
echo This will enable Windows Defender SmartScreen on your system.
echo.
pause
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen /t REG_DWORD /d 1 /f

REM Step 8: Configure Audit Policy to log successful and failed logon attempts
echo.
echo Step 8: Configuring Audit Policy for logon attempts...
echo.
pause
auditpol /set /category:"Account Logon" /success:enable /failure:enable
auditpol /set /category:"Logon/Logoff" /success:enable /failure:enable
auditpol /set /category:"Policy Change" /success:enable /failure:enable
auditpol /set /category:"Privilege Use" /failure:enable /success:enable
auditpol /set /category:"System" /success:enable /failure:enable
auditpol /set /category:"Object Access" /success:enable /failure:disable
pause
echo Audit Policy has been configured successfully.
pause

REM Step 9: Renaming adminstrator account 
echo.
echo This will rename the built-in Administrator account to "SecureAdmin"
echo.
pause
wmic useraccount where name='Administrator' rename SecureAdmin

REM Step 10: Do not allow anonymous enumeration of SAM accounts
echo Enforcing: Do not allow anonymous enumeration of SAM accounts...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v RestrictAnonymousSAM /t REG_DWORD /d 1 /f
echo Policy applied.
echo.
pause

REM Step 11: Limit local account use of blank passwords to console logon only
echo Enforcing: Limit local account use of blank passwords to console logon only...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v LimitBlankPasswordUse /t REG_DWORD /d 1 /f
echo Done.
echo.
pause

REM Step 12: Enable User Account Control (UAC) for the built-in Administrator account
echo Enforcing: Enable User Account Control (UAC) for the built-in Administrator account...
echo Enforcing UAC secure settings...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 1 /f
echo UAC hardened.
echo.
pause

REM Step 13: Disable requirement for CTRL+ALT+DEL (CyberPatriot requirement)
echo Step 13: Disabling CTRL+ALT+DEL requirement for logon...
echo This is required for CyberPatriot compliance.
pause
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableCAD /t REG_DWORD /d 1 /f
echo Disabled CTRL+ALT+DEL requirement
pause

REM end of script 11/16/2025
echo ======================================================
echo All steps completed, good luck, and win the round! :D 
echo ======================================================
pause





