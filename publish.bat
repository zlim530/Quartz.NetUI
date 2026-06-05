@echo off
chcp 65001 >nul
echo Starting publish for Quartz.NET.Web...

set OUTPUT_DIR=%~dp0publish

if exist "%OUTPUT_DIR%" (
    rd /s /q "%OUTPUT_DIR%"
)

dotnet publish "%~dp0Quartz.NET.Web\Quartz.NET.Web.csproj" -c Release -r win-x64 --self-contained true -o "%OUTPUT_DIR%\Quartz.NET.Web"

if %ERRORLEVEL% neq 0 (
    echo Publish failed!
    pause
    exit /b %ERRORLEVEL%
)

xcopy "%~dp0QuartzSettings" "%OUTPUT_DIR%\QuartzSettings" /E /I /Y

(
echo @echo off
echo chcp 65001 ^>nul
echo title Quartz.NET Task Scheduler
echo echo Starting Quartz.NET service...
echo echo Please visit http://localhost:9950 in your browser.
echo start http://localhost:9950
echo cd /d %%~dp0Quartz.NET.Web
echo Quartz.NET.Web.exe
) > "%OUTPUT_DIR%\一键启动.bat"

echo Publish success!
echo Output directory: %OUTPUT_DIR%
pause
