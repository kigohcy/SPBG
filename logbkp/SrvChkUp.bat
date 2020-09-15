@echo off
@For /f "tokens=1-3 delims=/ " %%a in ('date /t') do (set date1=%%a-%%b-%%c)
@For /f "tokens=1-3 delims=/ " %%a in ('date /t') do (set date2=%%a%%b%%c)
@For /f "tokens=1-3 delims=: " %%a in ('time /t') do (set time=%%a %%b:%%c)
@For /f "tokens=1" %%a in ('forfiles /P "D:\." /M fedirun /C "cmd /C echo @isdir"') do (set YesDir=%%a)

REM -------- �o�� %date1% �� %time% �ܼƥi�H���Ӱ��ܦh�γ~... --------

REM -------- ���ͨC�Ѫ���Ƨ� (�p�G�ؿ����s�b�N�إߥؿ�) --------
D:
CD D:\logbkp
@IF NOT EXIST %date1% mkdir %date1%
REM ------------------------------------------------------------------------------------------

REM **********************************
REM �H����覡�ˬd���A�������A....
REM **********************************

REM -------- ���ͨC�Ѫ� log �ɦW�A�ðO���ɶ� (�p�G�ɮפ��s�b�N�إ��ɮ�) --------
@set dailylog=%date1%.log
@IF NOT EXIST %date1%/%dailylog% echo ******************** > %date1%/%dailylog%
REM ------------------------------------------------------------------------------------------

echo ************************************************************************************************************************ >> %date1%/%dailylog%
REM -------- �p�G���A�������F�A�N�O���U�� --------
@echo %date1% %time% >> %date1%/%dailylog%
@echo Begin to Check FEDI Server  >> %date1%/%dailylog%
echo ******************** >> %date1%/%dailylog%
REM ------------------------------------------------------------------------------------------


set KeepDay=30


SET RESTART=0

REM -------- �Ұ�ActiveMQ Server --------
REM net start  "ActiveMQ"  >> %date1%/%dailylog%


for /F "tokens=3 delims=: " %%H in ('sc query "ActiveMQ" ^| findstr "        STATE"') do (
  if /I "%%H" NEQ "RUNNING" (
   REM net start "ActiveMQ" >> %date1%/%dailylog%
   REM @sc start  "ActiveMQ"  >> %date1%/%dailylog%
   SET RESTART=1
  )
)

REM @For /f "tokens=1-3 delims=: " %%a in ('time /t') do (set time=%%a %%b:%%c)
REM @echo ActiveMQ start at %date1% %time% >> %date1%/%dailylog%
REM sc query "ActiveMQ" >> %date1%/%dailylog%
echo ******************** >> %date1%/%dailylog%
REM ------------------------------------------------------------------------------------------

REM -------- �Ұ�FEDI Server --------
REM net start  "HiTRUST_FEDIServer" >> %date1%/%dailylog%


for /F "tokens=3 delims=: " %%H in ('sc query "HiTRUST_FEDIServer" ^| findstr "        STATE"') do (
  if /I "%%H" NEQ "RUNNING" (
   REM net start "HiTRUST_FEDIServer" >> %date1%/%dailylog%
   REM @sc start  "HiTRUST_FEDIServer"  >> %date1%/%dailylog%
   SET RESTART=1
  )
)

REM @For /f "tokens=1-3 delims=: " %%a in ('time /t') do (set time=%%a %%b:%%c)
REM @echo FEDI Server start at %date1% %time% >> %date1%/%dailylog%
REM sc query "HiTRUST_FEDIServer" >> %date1%/%dailylog%
echo ******************** >> %date1%/%dailylog%

REM ------------------------------------------------------------------------------------------

REM -------- �Ұ�Tomcat Services --------
REM net start "Tomcat8" >> %date1%/%dailylog%


for /F "tokens=3 delims=: " %%H in ('sc query "Tomcat8" ^| findstr "        STATE"') do (
  if /I "%%H" NEQ "RUNNING" (
   REM net start "Tomcat8" >> %date1%/%dailylog%
   REM @sc start  "Tomcat8"  >> %date1%/%dailylog%
   SET RESTART=1
  )
)

REM @For /f "tokens=1-3 delims=: " %%a in ('time /t') do (set time=%%a %%b:%%c)
REM @echo Tomcat8 Server start at %date1% %time% >> %date1%/%dailylog%
REM sc query "Tomcat8" >> %date1%/%dailylog%
echo ******************** >> %date1%/%dailylog%
REM ------------------------------------------------------------------------------------------

REM -------- �Ұ�Tomcat8M Services --------
REM net start "Tomcat8M" >> %date1%/%dailylog%


for /F "tokens=3 delims=: " %%H in ('sc query "Tomcat8M" ^| findstr "        STATE"') do (
  if /I "%%H" NEQ "RUNNING" (
   REM net start "Tomcat8M" >> %date1%/%dailylog%
   REM @sc start  "Tomcat8M"  >> %date1%/%dailylog%
   SET RESTART=1
  )
)

REM @For /f "tokens=1-3 delims=: " %%a in ('time /t') do (set time=%%a %%b:%%c)
REM @echo Tomcat8M Server start at %date1% %time% >> %date1%/%dailylog%
REM sc query "Tomcat8M" >> %date1%/%dailylog%

if %RESTART%==1 call "D:\LOGBKP\SrvDownUp.bat"

echo ******************** >> %date1%/%dailylog%
REM ------------------------------------------------------------------------------------------

sc query "ActiveMQ" >> %date1%/%dailylog%
sc query "HiTRUST_FEDIServer" >> %date1%/%dailylog%
sc query "Tomcat8" >> %date1%/%dailylog%
sc query "Tomcat8M" >> %date1%/%dailylog%

@echo End to Check FEDI Server  >> %date1%/%dailylog%
echo ************************************************************************************************************************ >> %date1%/%dailylog%