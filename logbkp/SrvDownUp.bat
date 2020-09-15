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
@echo Begin to Restart FEDI Server  >> %date1%/%dailylog% 
echo ******************** >> %date1%/%dailylog% 
REM ------------------------------------------------------------------------------------------


set KeepDay=30

REM -------- 停止Tomcat8M Services --------
@net stop "Tomcat8M" >> %date1%/%dailylog% 
taskkill /F /FI "SERVICES eq Tomcat8M"
@For /f "tokens=1-3 delims=: " %%a in ('time /t') do (set time=%%a %%b:%%c) 
@echo Tomcat8M Server stop at %date1% %time% >> %date1%/%dailylog% 
REM ------------------------------------------------------------------------------------------


REM -------- 停止Tomcat Services --------
@net stop "Tomcat8" >> %date1%/%dailylog% 
taskkill /F /FI "SERVICES eq Tomcat8"
@For /f "tokens=1-3 delims=: " %%a in ('time /t') do (set time=%%a %%b:%%c) 
@echo Tomcat8 Server stop at %date1% %time% >> %date1%/%dailylog% 
REM ------------------------------------------------------------------------------------------

REM -------- 停止FEDI Server --------
@net stop  "HiTRUST_FEDIServer" >> %date1%/%dailylog% 
taskkill /F /FI "SERVICES eq HiTRUST_FEDIServer" 
@For /f "tokens=1-3 delims=: " %%a in ('time /t') do (set time=%%a %%b:%%c) 
@echo FEDI Server (HiTRUST_FEDIServer) stop at %date1% %time% >> %date1%/%dailylog% 
REM ------------------------------------------------------------------------------------------


REM -------- 停止ActiveMQ Server --------
@net stop  "ActiveMQ" >> %date1%/%dailylog% 
taskkill /F /FI "SERVICES eq ActiveMQ" 
@For /f "tokens=1-3 delims=: " %%a in ('time /t') do (set time=%%a %%b:%%c) 
@echo ActiveMQ Server (ActiveMQ) stop at %date1% %time% >> %date1%/%dailylog% 
REM ------------------------------------------------------------------------------------------


sc query "HiTRUST_FEDIServer" >> %date1%/%dailylog%
sc query "Tomcat8" >> %date1%/%dailylog%
sc query "Tomcat8M" >> %date1%/%dailylog%
sc query "ActiveMQ" >> %date1%/%dailylog%

echo ********** End STOP **************************************************************************************************** >> %date1%/%dailylog% 
echo >>  %date1%/%dailylog% 
echo ********** Begin Start ************************************************************************************************* >> %date1%/%dailylog% 

REM -------- 啟動ActiveMQ Server --------
net start  "ActiveMQ"  >> %date1%/%dailylog% 


for /F "tokens=3 delims=: " %%H in ('sc query "ActiveMQ" ^| findstr "        STATE"') do (
  if /I "%%H" NEQ "RUNNING" (
   net start "ActiveMQ" >> %date1%/%dailylog% 
   @sc start  "ActiveMQ"  >> %date1%/%dailylog%
  )
)

@For /f "tokens=1-3 delims=: " %%a in ('time /t') do (set time=%%a %%b:%%c) 
@echo ActiveMQ start at %date1% %time% >> %date1%/%dailylog%
REM sc query "ActiveMQ" >> %date1%/%dailylog%
echo ******************** >> %date1%/%dailylog% 
REM ------------------------------------------------------------------------------------------

REM -------- 啟動FEDI Server --------
net start  "HiTRUST_FEDIServer" >> %date1%/%dailylog% 


for /F "tokens=3 delims=: " %%H in ('sc query "HiTRUST_FEDIServer" ^| findstr "        STATE"') do (
  if /I "%%H" NEQ "RUNNING" (
   net start "HiTRUST_FEDIServer" >> %date1%/%dailylog% 
   @sc start  "HiTRUST_FEDIServer"  >> %date1%/%dailylog%
  )
)

@For /f "tokens=1-3 delims=: " %%a in ('time /t') do (set time=%%a %%b:%%c) 
@echo FEDI Server start at %date1% %time% >> %date1%/%dailylog%
REM sc query "HiTRUST_FEDIServer" >> %date1%/%dailylog%
echo ******************** >> %date1%/%dailylog% 

REM ------------------------------------------------------------------------------------------


REM -------- 啟動Tomcat Services --------
net start "Tomcat8" >> %date1%/%dailylog% 


for /F "tokens=3 delims=: " %%H in ('sc query "Tomcat8" ^| findstr "        STATE"') do (
  if /I "%%H" NEQ "RUNNING" (
   net start "Tomcat8" >> %date1%/%dailylog% 
   @sc start  "Tomcat8"  >> %date1%/%dailylog%
  )
)

@For /f "tokens=1-3 delims=: " %%a in ('time /t') do (set time=%%a %%b:%%c) 
@echo Tomcat8 Server start at %date1% %time% >> %date1%/%dailylog% 
REM sc query "Tomcat8" >> %date1%/%dailylog%
echo ******************** >> %date1%/%dailylog% 
REM ------------------------------------------------------------------------------------------


REM -------- 啟動Tomcat8M Services --------
net start "Tomcat8M" >> %date1%/%dailylog% 


for /F "tokens=3 delims=: " %%H in ('sc query "Tomcat8M" ^| findstr "        STATE"') do (
  if /I "%%H" NEQ "RUNNING" (
   net start "Tomcat8M" >> %date1%/%dailylog% 
   @sc start  "Tomcat8M"  >> %date1%/%dailylog%
  )
)

@For /f "tokens=1-3 delims=: " %%a in ('time /t') do (set time=%%a %%b:%%c) 
@echo Tomcat8M Server start at %date1% %time% >> %date1%/%dailylog% 
REM sc query "Tomcat8M" >> %date1%/%dailylog%
echo ******************** >> %date1%/%dailylog% 
REM ------------------------------------------------------------------------------------------

sc query "ActiveMQ" >> %date1%/%dailylog%
sc query "HiTRUST_FEDIServer" >> %date1%/%dailylog%
sc query "Tomcat8" >> %date1%/%dailylog%
sc query "Tomcat8M" >> %date1%/%dailylog%

@echo End to Restart FEDI Server  >> %date1%/%dailylog% 
echo ************************************************************************************************************************ >> %date1%/%dailylog% 