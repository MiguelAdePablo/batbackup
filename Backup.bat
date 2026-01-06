@echo off

:: ===========================================================================
:: SECTION 1: USER FEEDBACK — Clear start message with timestamp
:: Purpose: Provide immediate visual feedback that the backup process has begun.
:: ===========================================================================
echo(
echo ********************************
echo STARTING DOCUMENTS BACKUP
echo(
echo Process started at: %time%
echo ********************************
echo(

:: ===========================================================================
:: SECTION 2: PATH DEFINITIONS
:: Notes:
:: - ORIGIN uses a wildcard (*) to include all contents of Documents.
:: - DESTINATION is a full path to the .7z archive (not a folder).
:: - Quotes are handled via set "VAR=value" syntax to avoid trailing spaces.
:: ===========================================================================
set "ZIP=C:\PROGRAMAS\UTILES\7-Zip\7z.exe"
set "ORIGIN=%USERPROFILE%\Documents\*"
set "DESTINATION=C:\Backups\Documents.7z"

echo Origin: %ORIGIN%
echo Destination: %DESTINATION%
echo(

:: ===========================================================================
:: SECTION 3: ENSURE DESTINATION DIRECTORY EXISTS
:: Why: 7-Zip will fail if the parent folder (C:\Backups) doesn't exist.
:: How: Use %%~dpD to extract the directory path from the full archive path.
:: ===========================================================================
for %%D in ("%DESTINATION%") do (
    if not exist "%%~dpD" mkdir "%%~dpD"
)

:: ===========================================================================
:: SECTION 4: VALIDATE 7-ZIP INSTALLATION
:: Why: Prevent cryptic errors if 7z.exe is missing or moved.
:: Action: Halt with clear error message if not found.
:: ===========================================================================
if not exist "%ZIP%" (
    echo ERROR: 7-Zip not found at "%ZIP%"
    echo Please install 7-Zip or update the ZIP path.
    pause
    exit /b 1
)

:: ===========================================================================
:: SECTION 5: RUN BACKUP WITH EXCLUSIONS
:: Critical decision:
::   - Exclude "My Music", "My Pictures", "My Videos".
::   - These are system-created junctions in Documents that trigger "Access denied"
::     warnings (even though they're harmless).
::   - Warnings cause 7-Zip to return errorlevel=1, which we want to avoid.
::   - Using -x! excludes items by name (matches directly under Documents).
:: ===========================================================================
"%ZIP%" a -t7z "%DESTINATION%" "%ORIGIN%" -x!"My Music" -x!"My Pictures" -x!"My Videos" -mx9 -aoa

:: ===========================================================================
:: SECTION 6: INTERPRET EXIT CODE ROBUSTLY
:: 7-Zip exit codes:
::   0 = Success
::   1 = Warning (e.g., file locked, access denied — but archive may be fine)
::   2+ = Error (e.g., disk full, invalid path)
::
:: Strategy:
::   - If errorlevel is 0 → success.
::   - If errorlevel is 1 → check if archive was actually created.
::   - Only treat as failure if errorlevel >=2 OR errorlevel=1 AND no archive.
:: ===========================================================================
if %errorlevel% equ 0 (
    set "SUCCESS=1"
) else if %errorlevel% equ 1 (
    if exist "%DESTINATION%" (
        set "SUCCESS=1"
    ) else (
        set "SUCCESS=0"
    )
) else (
    set "SUCCESS=0"
)

:: ===========================================================================
:: SECTION 7: FINAL FEEDBACK AND EXIT
:: Provide clear success/failure message and consistent exit code.
:: ===========================================================================
if defined SUCCESS if "%SUCCESS%"=="1" (
    echo(
    echo ********************************
    echo BACKUP COMPLETED SUCCESSFULLY
    echo(
    echo Process ended at: %time%
    echo ********************************
    exit /b 0
) else (
    echo(
    echo ********************************
    echo BACKUP FAILED
    echo(
    echo Process ended at: %time%
    echo ********************************
    exit /b 1
)