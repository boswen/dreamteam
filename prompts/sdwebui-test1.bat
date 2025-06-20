@echo off
setlocal

set "URL=http://127.0.0.1:7861/sdapi/v1/txt2img"
set "JSON_PAYLOAD=^"{ ^"prompt^": ^"puppy dog^", ^"steps^": 5 ^}"
set "OUTPUT_JSON=response.json"
set "OUTPUT_PNG=output.png"
set "TEMP_BASE64_FILE=temp_image_base64.txt"

echo Sending request to %URL% with payload %JSON_PAYLOAD%

:: Step 1: Send the request using curl and save the JSON response
:: Note: This assumes you have curl.exe available in your PATH.
curl -X POST %URL% -H "Content-Type: application/json" -d "%JSON_PAYLOAD%" -o %OUTPUT_JSON%

if errorlevel 1 (
    echo Error: Curl command failed. Check connection and URL.
    goto :eof
)

echo.
echo JSON response saved to %OUTPUT_JSON%

:: Step 2: Extract the base64 image string from the JSON using PowerShell (fallback for native batch is much harder)
:: We're embedding a PowerShell command directly into the batch file
echo Extracting base64 string...
powershell -Command "(Get-Content -Raw '%OUTPUT_JSON%' | ConvertFrom-Json).images[0] | Set-Content -Path '%TEMP_BASE64_FILE%'"

if not exist %TEMP_BASE64_FILE% (
    echo Error: Failed to extract base64 image data.
    goto :eof
)

echo.
echo Decoding base64 to image file...

:: Step 3: Decode the base64 string to a PNG file using certutil
:: certutil expects BEGIN/END CERTIFICATE headers for some of its modes,
:: but it can decode raw base64 if it's the only content in the file.
certutil -decode %TEMP_BASE64_FILE% %OUTPUT_PNG%

if errorlevel 1 (
    echo Error: Base64 decoding failed.
    goto :eof
)

echo.
echo Image saved successfully to %OUTPUT_PNG%

:: Clean up temporary file
del %TEMP_BASE64_FILE%

echo.
echo Done.
pause