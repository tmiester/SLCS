@echo off
title cyberpatriot 18 script in the big '25 
color 02
chcp 65001 >nul 2>&1
::
REM Check for Administrator Privileges
::net session >nul 2>&1
::if %errorlevel% neq 0 (
::  echo Run as Administrator
::  pause
::  exit /b
::)
::

REM Display Intro Screen
echo ╔═══════════════════════════════════════════════════════════╗
echo         --- Cyberpatriot 18 Script Windows 11 ---
echo             by BlueJayCoding and Team 18-3245
echo      GitHub Profile: https://github.com/BlueJayCoding/
echo ╚═══════════════════════════════════════════════════════════╝
echo.
echo Make sure to read both the forensics questions and the README before proceeding.
echo This script is intended to help automate the hardening process for CyberPatriot rounds.

REM copy and paste borders
REM ║ ╔  ╗  ╠  ╣  ╦  ╩  ╬  ═
REM   ╚  ╝


REM Main Menu

:menu
echo ╔══════════════════════════════════════════════════════╗
echo ║                      MENU                            ║
echo ╠══════════════════════════════════════════════════════╣
echo ║  1) Enable Windows Firewall                          ║
echo ║  2) Set Password Policies                            ║
echo ║  3) Disable Autoplay                                 ║
echo ║  4) Screensaver Lock                                 ║
echo ║  5) Disable Guest Account                            ║
echo ║  6) Disable Unused Services                          ║
echo ║  7) Enable SmartScreen                               ║
echo ║  8) Configure Audit Policy                           ║
echo ║  9) Rename Admin Account                             ║
echo ║ 10) SAM Restrictions                                 ║
echo ║ 11) Blank Password Console Limit                     ║
echo ║ 12) UAC Strengthening                                ║
echo ║ 13) Disable CTRL+ALT+DEL Requirement                 ║
echo ║                                                      ║
echo ╚══════════════════════════════════════════════════════╝
echo. 
set /p choice=Choose an option (type only the number, no spaces):

if "%choice%"=="1" goto firewall
if "%choice%"=="2" goto passwordpolicy
if "%choice%"=="3" goto autoplay
if "%choice%"=="4" goto screensaver
if "%choice%"=="5" goto guestaccount
if "%choice%"=="6" goto disableunusedservices
if "%choice%"=="7" goto smartscreen
if "%choice%"=="8" goto auditpolicy
if "%choice%"=="9" goto renameadmin
if "%choice%"=="10" goto samaccount
if "%choice%"=="11" goto blankpasswords
if "%choice%"=="12" goto uac
if "%choice%"=="13" goto ctrlaltdel
else (
  echo Invalid choice. Please try again.
  pause
  goto menu
)
goto menu

:firewall
REM Step 1: Enable Windows Firewall
echo.
echo Step 1: Enabling Windows Firewall...
echo This will enable the Windows Firewall on your system.
echo.
pause
netsh advfirewall set allprofiles state on
echo Windows Firewall has been enabled successfully.
pause
goto menu

:passwordpolicy
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
goto menu

:autoplay
REM Step 3: Disable Autorun/Autoplay for removable devices
echo.
echo Step 3: Disabling Autorun/Autoplay for removable devices...
echo.
pause
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 255 /f
echo Autorun/Autoplay has been disabled succesfully.
pause
goto menu

:screensaver
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
goto menu

:guestaccount
REM Step 5: Delete guest account
echo.
echo Step 5 : Disabling guest accounts...
echo This will disable guest accounts on your system.
echo.
pause
net user guest /active:no
echo Guest accounts have been disabled successfully.
pause
goto menu

:disableunusedservices
REM Step 6: Disable unused services (modify as needed)
SETLOCAL
echo Step 6: Disabling unused services...
echo This will disable several unused services on your system such as World Wide Publishing Service Fax, Remote Registry, Telnet, FTP, SNMP, UPnP, and SSDP.
echo Press 1 to disalbe Fax - Press 2 to disable Remote Registry - Press 3 to disable Telnet - Press 4 to disable uPnP - Press 5 to disable SSDP
echo Press 6 to disable FTP - Press 7 to disable SNMP - Press 8 to disable W3SVC - Press 9 to disable all services listed -Press 10 to go to menu

set /p servicesInput= Enter your choice (no spaces):

:: the > command redirects output so you don't see it
:: the 2>&1 part sents it to the same place as standard output (nul)
:: The && mean "if the previous command succeeded, then run the next command"

:: Fax
if "%servicesInput%"=="1" (
  sc config Fax start= disabled >nul 2>&1
  net stop Fax >nul 2>&1
  echo Fax service disabled.
)

:: Remote Registry
if "%servicesInput%"=="2" (
  sc config RemoteRegistry start= disabled >nul 2>&1
  net stop RemoteRegistry >nul 2>&1
  echo Remote Registry service disabled.
)

:: Telnet
if "%servicesInput%"=="3" (
  sc config TlntSvr start= disabled >nul 2>&1
  net stop TlntSvr >nul 2>&1
  echo Telnet service disabled.
)

:: uPnP
if "%servicesInput%"=="4" (
  sc config upnphost start= disabled >nul 2>&1
  net stop upnphost >nul 2>&1
  echo uPnP service disabled.
)

:: SSDP
if "%servicesInput%"=="5" (
  sc config SSDPSRV start= disabled >nul 2>&1
  net stop SSDPSRV >nul 2>&1
  echo SSDP service disabled.
)

:: FTP
if "%servicesInput%"=="6" (
  sc query msftpsvc >nul 2>&1 && sc config msftpsvc start= disabled
  sc query msftpsvc >nul 2>&1 && net stop msftpsvc
  echo FTP service disabled.
)

:: SNMP
if "%servicesInput%"=="7" (
  sc query SNMP >nul 2>&1 && sc config SNMP start= disabled
  sc query SNMP >nul 2>&1 && net stop SNMP
  echo SNMP service disabled.
)

:: World Wide Web Publishing Service (W3SVC)
if "%servicesInput%"=="8" (
  sc query W3SVC >nul 2>&1 && sc config W3SVC start= disabled >nul 2>&1
  sc query W3SVC >nul 2>&1 && net stop W3SVC >nul 2>&1
  echo W3SVC service disabled.
  pause
)

:: Disable all services
if "%servicesInput%"=="9" (
  sc config Fax start= disabled >nul 2>&1
  net stop Fax >nul 2>&1
  sc config RemoteRegistry start= disabled >nul 2>&1
  net stop RemoteRegistry >nul 2>&1
  sc config TlntSvr start= disabled >nul 2>&1
  net stop TlntSvr >nul 2>&1
  sc query W3SVC >nul 2>&1 && sc config W3SVC start= disabled >nul 2>&1
  sc query W3SVC >nul 2>&1 && net stop W3SVC >nul 2>&1
  sc query SNMP >nul 2>&1 && sc config SNMP start= disabled
  sc query SNMP >nul 2>&1 && net stop SNMP
  sc query msftpsvc >nul 2>&1 && sc config msftpsvc start= disabled
  sc query msftpsvc >nul 2>&1 && net stop msftpsvc
  sc config SSDPSRV start= disabled >nul 2>&1
  net stop SSDPSRV >nul 2>&1
  sc config upnphost start= disabled >nul 2>&1
  net stop upnphost >nul 2>&1
  echo All services have been disabled.
)

if "%servicesInput%"=="10" (
  goto menu
)
ENDLOCAL
pause
echo Done disabling unused services as entered.
echo
pause

goto menu

:smartscreen
REM Step 7: Enable Windows Defender SmartScreen
echo.
echo Step 7: Enabling Windows Defender SmartScreen...
echo This will enable Windows Defender SmartScreen on your system.
echo.
pause
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen /t REG_DWORD /d 1 /f
echo Windows Defender SmartScreen has been enabled successfully.
pause
goto menu

:auditpolicy
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
goto menu

:renameadmin
REM Step 9: Renaming adminstrator account
echo.
echo This will rename the built-in Administrator account to "SecureAdmin"
echo.
pause
wmic useraccount where name='Administrator' rename SecureAdmin
echo Admin account renamed successfully.
goto menu

:samaccount
REM Step 10: Do not allow anonymous enumeration of SAM accounts
echo Enforcing: Do not allow anonymous enumeration of SAM accounts...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v RestrictAnonymousSAM /t REG_DWORD /d 1 /f
echo Policy applied.
echo.
pause
goto menu

:blankpasswords
REM Step 11: Limit local account use of blank passwords to console logon only
echo Enforcing: Limit local account use of blank passwords to console logon only...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v LimitBlankPasswordUse /t REG_DWORD /d 1 /f
echo Done.
echo.
pause
goto menu

:uac
REM Step 12: Enable User Account Control (UAC) for the built-in Administrator account
echo Enforcing: Enable User Account Control (UAC) for the built-in Administrator account...
echo Enforcing UAC secure settings...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 1 /f
echo UAC hardened.
echo.
pause
goto menu

:ctrlaltdel
REM Step 13: Disable requirement for CTRL+ALT+DEL (CyberPatriot requirement)
echo Step 13: Disabling CTRL+ALT+DEL requirement for logon...
echo This is required for CyberPatriot compliance.
pause
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableCAD /t REG_DWORD /d 1 /f
echo Disabled CTRL+ALT+DEL requirement
pause
goto menu

REM end of script 11/16/2025
echo ======================================================
echo All steps completed, good luck, and win the round! :D
echo ======================================================
pause
