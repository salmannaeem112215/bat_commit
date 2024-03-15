@echo off
setlocal EnableDelayedExpansion

REM Set initial date to January 1, 2022
set "current_date=2022-01-01"
set "end_date=2024-12-31"

:LOOP
REM Set system date using PowerShell
powershell -Command "(Get-Date '%current_date%').ToShortDateString()" | set /p=

REM Append current date to README.md
echo %current_date% >> README.md

REM Commit changes to Git repository
git add .
git commit -m "Update README with date %current_date%"

REM Increment current date by one day
call :increment_date

REM Check if current date is less than or equal to end date
if "%current_date%" LEQ "%end_date%" (
    goto LOOP
)

exit /b

:increment_date
REM Increment current date by one day
set /a "yyyy=!current_date:~0,4!"
set /a "mm=!current_date:~5,2!"
set /a "dd=!current_date:~8,2!"

set /a "dd+=1"

REM Handle month and year changes
if !dd! gtr 31 (
    set /a "dd=1"
    set /a "mm+=1"
    if !mm! gtr 12 (
        set /a "mm=1"
        set /a "yyyy+=1"
    )
)

REM Format date back to yyyy-mm-dd
set "current_date=!yyyy!-!mm:~-2!-!dd:~-2!"
exit /b
