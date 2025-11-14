REM Step 1: Enable Windows Firewall
echo.
echo Step 1: Enabling Windows Firewall...
echo This will enable the Windows Firewall on your system.
echo.
pause
netsh advfirewall set allprofiles state on

REM Step 2: Enable BitLocker (optional)
echo.
echo Step 2: Enabling BitLocker...
echo This will enable BitLocker drive encryption on your system.
echo (Note: BitLocker requires compatible hardware support.)
echo.
pause
manage-bde -on C: -used