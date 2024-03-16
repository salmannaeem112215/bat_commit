@echo off

for /l %%i in (0, 1,10) do (
    echo "1" >> README.md
    REM Commit changes to Git repository
    git add .
    git commit -m "Update README"
)
