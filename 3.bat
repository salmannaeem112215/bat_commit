 @echo off
setlocal EnableDelayedExpansion
cd /d "C:\SALMAN\flutter\bat_commit"
 for /l %%i in (1, 1, 1000000) do (
                REM Append current date to README.md
                echo "5" >> README.md

                REM Commit changes to Git repository
                git add .
                git commit -m "Update README with date %%i"
           )
exit /b
