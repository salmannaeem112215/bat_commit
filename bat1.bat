@echo off
setlocal EnableDelayedExpansion


REM Example usage:
call :print_date_range "2022-01-01" "2023-01-10"
exit /b

:print_date_range
set "start_date=%~1"
set "end_date=%~2"

:LOOP
REM Set system date and time using PowerShell
powershell -Command "(Get-Date '%start_date%').ToLocalTime() | Set-Date"

REM Append current date to README.md
echo %start_date% >> README.md

REM Commit changes to Git repository
git add .
git commit -m "Update README with date %start_date%"

REM Increment current date by one day
call :increment_date %start_date%

REM Check if current date is less than or equal to end date
if "%start_date%" LEQ "%end_date%" (
    goto LOOP
)

exit /b

:increment_date
REM Increment current date by one day
set "date_str=%~1"

REM Extract year, month, and day
for /f "tokens=1-3 delims=-" %%a in ("%date_str%") do (
    set /a "yyyy=%%a", "mm=100+%%b", "dd=100+%%c"
)

REM Increment day
set /a "dd+=1"

REM Adjust month and year if necessary
if !dd! gtr 31 (
    set "dd=01"
    set /a "mm+=1"
    if !mm! gtr 12 (
        set "mm=01"
        set /a "yyyy+=1"
    )
)

REM Format date back to yyyy-mm-dd
set "start_date=!yyyy!-!mm:~-2!-!dd:~-2!"

exit /b
