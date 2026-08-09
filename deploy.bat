@echo off
REM Double-click to deploy the site. Window stays open so you can read the result.
cd /d "%~dp0"
set CLOUDFLARE_ACCOUNT_ID=5b48ce2ce927599a4374e91dfeb21fac

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0bump-version.ps1"
if errorlevel 1 (echo Version bump failed. & pause & exit /b 1)

echo.
echo Deploying...
echo.
call npx --yes wrangler@latest pages deploy public --project-name=preet-mendpara-portfolio --branch=main --commit-dirty=true
if errorlevel 1 (
    echo.
    echo DEPLOY FAILED.
    echo If it says you are not logged in, run this once:  npx wrangler login
    echo.
    pause
    exit /b 1
)

echo.
echo Checking live site...
for %%P in (/ /overrides.css /enhancements.js /assets/spa-index-BbxwJ9Tg.js) do (
    for /f %%C in ('curl -s -o NUL -w "%%{http_code}" https://preetmendpara.qzz.io%%P') do (
        if "%%C"=="200" (echo   OK   %%P) else (echo   FAIL %%C %%P & set FAILED=1)
    )
)

echo.
if defined FAILED (
    echo Live check failed - site may be broken. Check the URLs above.
) else (
    echo Done. https://preetmendpara.qzz.io
)
echo.
pause
