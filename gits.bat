@echo off
setlocal EnableDelayedExpansion
cd /d "C:\SALMAN\flutter\bat_commit"
REM Example usage:
call :print_date_range "2024-03-15" "2024-03-21"
exit /b

:print_date_range
set "start_date=%~1"
set "end_date=%~2"

REM Extract year, month, and day from the start date
for /f "tokens=1-3 delims=-" %%a in ("%start_date%") do (
    set /a "start_year=%%a", "start_month=%%b", "start_day=%%c"
)

REM Extract year, month, and day from the end date
for /f "tokens=1-3 delims=-" %%a in ("%end_date%") do (
    set /a "end_year=%%a", "end_month=%%b", "end_day=%%c"
)

REM Iterate through dates and print them
for /l %%y in (!start_year!, 1, !end_year!) do (
    REM Determine the start and end months for the current year
    set /a "m_start=1"
    set /a "m_end=12"
    if %%y equ !start_year! set /a "m_start=!start_month!"
    if %%y equ !end_year! set /a "m_end=!end_month!"

    for /l %%m in (!m_start!, 1, !m_end!) do (
        REM Determine the start and end days for the current month
        set /a "d_start=1"
        set /a "d_end=31"
        if %%y equ !start_year! if %%m equ !start_month! set /a "d_start=!start_day!"
        if %%y equ !end_year! if %%m equ !end_month! set /a "d_end=!end_day!"

        REM Print the dates for the current year and month
        for /l %%d in (!d_start!, 1, !d_end!) do (
            REM Format month and day with leading zeros
            set "mm=%%m"
            if %%m lss 10 set "mm=0%%m"
            set "dd=%%d"
            if %%d lss 10 set "dd=0%%d"

            echo %%y-!mm!-!dd!

            REM Set system date using PowerShell
            powershell -Command "(Get-Date '%%y-!mm!-!dd!').ToLocalTime() | Set-Date"



           for /l %%i in (1, 1, 1000000) do (
                REM Append current date to README.md
                echo "5" >> README.md

                REM Commit changes to Git repository
                git add .
                git commit -m "Update README with date %%y-!mm!-!dd!"
           )
        )
    )
)
exit /b
