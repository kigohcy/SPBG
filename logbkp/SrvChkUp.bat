@echo off
@For /f "tokens=1-3 delims=/ " %%a in ('date /t') do (set date1=%%a-%%b-%%c)
@For /f "tokens=1-3 delims=/ " %%a in ('date /t') do (set date2=%%a%%b%%c)
@For /f "tokens=1-3 delims=: " %%a in ('time /t') do (set time=%%a %%b:%%c)
@For /f "tokens=1" %%a in ('forfiles /P "D:\." /M fedirun /C "cmd /C echo @isdir"') do (set YesDir=%%a)

REM -------- 這個 %date1% 或 %time% 變數可以拿來做很多用途... --------

REM -------- 產生每天的資料夾 (如果目錄不存在就建立目錄) --------
D:
CD D:\logbkp
@IF NOT EXIST %date1% mkdir %date1%
REM ------------------------------------------------------------------------------------------

REM **********************************
REM 以任何方式檢查伺服器的狀態....
REM **********************************

REM -------- 產生每天的 log 檔名，並記錄時間 (如果檔案不存在就建立檔案) --------
@set dailylog=%date1%.log
@IF NOT EXIST %date1%/%dailylog% echo ******************** > %date1%/%dailylog%
REM ------------------------------------------------------------------------------------------

echo ************************************************************************************************************************ >> %date1%/%dailylog%
REM -------- 如果伺服器停掉了，就記錄下來 --------
@echo %date1% %time% >> %date1%/%dailylog%
@echo Begin to Check FEDI Server  >> %date1%/%dailylog%
echo ******************** >> %date1%/%dailylog%
REM ------------------------------------------------------------------------------------------


set KeepDay=30


SET RESTART=0

REM -------- 啟動ActiveMQ Server --------
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

REM -------- 啟動FEDI Server --------
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

REM -------- 啟動Tomcat Services --------
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

REM -------- 啟動Tomcat8M Services --------
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