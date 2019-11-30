@echo off
set dllhostcounter=0
set dllhostcounter2=0
set dllhostcounter3=0
set dllhostcounter4=0
set isRunning=0

:check

tasklist /nh /fi "imagename eq dllhost.exe" | find /i "dllhost.exe" >nul && (
   set isRunning=1
) || (
   set dllhostcounter=0
   set dllhostcounter2=0
   set dllhostcounter3=0
   set dllhostcounter4=0
   set isRunning=0
)

if %isRunning% EQU 0 (
    goto :check_process
)

for /f "skip=2 tokens=2-6 delims=," %%A in ('typeperf "\Process(dllhost*)\%% Processor Time" -sc 1') do (
    set cpu_usage=%%A
    set cpu_usage2=%%B
    set cpu_usage3=%%C
    set cpu_usage4=%%D
    goto :break
)

:break

if "%cpu_usage%" NEQ "" (
     for /f "tokens=1 delims=." %%A in (%cpu_usage%) do (
        set cpu_usage=%%A
     )
) else (
   set cpu_usage=0
)

if "%cpu_usage2%" NEQ "" (
     for /f "tokens=1 delims=." %%A in (%cpu_usage2%) do (
        set cpu_usage2=%%A
     )
) else (
   set cpu_usage2=0
)

if "%cpu_usage3%" NEQ "" (
      for /f "tokens=1 delims=." %%A in (%cpu_usage3%) do (
          set cpu_usage3=%%A
      )
) else (
   set cpu_usage3=0
)

if "%cpu_usage4%" NEQ "" (
    for /f "tokens=1 delims=." %%A in (%cpu_usage4%) do (
        set cpu_usage4=%%A
    )
) else (
   set cpu_usage4=0
)

if %cpu_usage% GTR 95 (
    if %cpu_usage% LSS 101 (
        echo %cpu_usage%
    	echo DLL Host Overload
        if %dllhostcounter% GTR 1 (
             echo Terminating Process
             taskkill /IM "dllhost.exe" /F
        ) else (
             set /A dllhostcounter=dllhostcounter+1
        )
    ) else (
	set dllhostcounter=0
    )
) else (
     set dllhostcounter=0
)

if %cpu_usage2% GTR 95 (
    if %cpu_usage2% LSS 101 (
    	echo DLL Host Overload
        if %dllhostcounter2% GTR 1 (
             echo Terminating Process
             taskkill /IM "dllhost.exe" /F
        ) else (
             set /A dllhostcounter2=dllhostcounter2+1
        )
    ) else (
	set dllhostcounter2=0
    )
) else (
     set dllhostcounter2=0
)

if %cpu_usage3% GTR 95 (
    if %cpu_usage3% LSS 101 (
    	echo DLL Host Overload
        if %dllhostcounter3% GTR 1 (
             echo Terminating Process
             taskkill /IM "dllhost.exe" /F
        ) else (
             set /A dllhostcounter3=dllhostcounter3+1
        )
    ) else (
	set dllhostcounter3=0
    )
) else (
     set dllhostcounter3=0
)

if %cpu_usage4% GTR 95 (
    if %cpu_usage4% LSS 101 (
    	echo DLL Host Overload
        if %dllhostcounter4% GTR 1 (
             echo Terminating Process
             taskkill /IM "dllhost.exe" /F
        ) else (
             set /A dllhostcounter4=dllhostcounter4+1
        )
    ) else (
	set dllhostcounter4=0
    )
) else (
     set dllhostcounter4=0
)

:check_process
pathping 127.0.0.1 -n -q 1 -p 10000 >nul 2>&1
goto :check
endlocal