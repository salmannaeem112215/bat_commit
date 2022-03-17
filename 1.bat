@echo off

REM Set the date to March 17, 2022
powershell -Command "(Get-Date '2022-03-17').ToLocalTime() | Set-Date"
