# PowerShell Script (Save as, e.g., Invoke-SDAPI.ps1)

# Define the URL and the payload to send.
$url = "http://127.0.0.1:7861"
$endpoint = "/sdapi/v1/txt2img"

$payload = @{
    prompt = "puppy dog"
    steps = 5
}

# Convert payload to JSON
$jsonPayload = $payload | ConvertTo-Json

Write-Host "Sending request to $($url)$($endpoint) with payload: $($jsonPayload)"

# Send the payload to the URL through the API.
try {
    # Using Invoke-RestMethod for direct JSON parsing of the response
    $response = Invoke-RestMethod -Uri "$url$endpoint" -Method Post -ContentType "application/json" -Body $jsonPayload

    # --- DEBUGGING STEP 1: Inspect the full response object ---
    Write-Host "`nFull API Response Object (for debugging):"
    $response | Format-List -Force # This will show all properties and their values

    # --- DEBUGGING STEP 2: Check if 'images' property exists and is an array ---
    if ($response.PSObject.Properties.Name -contains "images") {
        Write-Host "Response contains 'images' property."

        # Check if 'images' is an array and has elements
        if ($response.images -is [System.Array] -and $response.images.Length -gt 0) {
            Write-Host "Images array found with $($response.images.Length) elements."

            # Extract the base64 image string
            $base64Image = $response.images[0]

            # --- DEBUGGING STEP 3: Check the extracted base64 string ---
            if ([string]::IsNullOrWhiteSpace($base64Image)) {
                Write-Warning "Extracted base64 image string is empty or whitespace. Cannot save 0-byte file."
            } else {
                Write-Host "Base64 image string extracted successfully (length: $($base64Image.Length))."

                # Decode base64 string to bytes
                $bytes = [System.Convert]::FromBase64String($base64Image)

                # Define output file path
                $outputPath = "C:\temp\output.png"

                # Save the bytes to a file
                [System.IO.File]::WriteAllBytes($outputPath, $bytes)

                Write-Host "Image saved successfully to $outputPath"
            }
        } else {
            Write-Warning "The 'images' property is present but is not an array or is empty."
        }
    } else {
        Write-Warning "API response does not contain an 'images' property. Check API documentation for expected response format."
    }

} catch {
    Write-Error "Failed to connect or process API response."
    Write-Error "Error Message: $($_.Exception.Message)"
    Write-Error "Detailed Error Info:"
    $_.Exception | Format-List -Force # Output detailed error for debugging
    if ($_.Exception.InnerException) {
        Write-Error "Inner Exception: $($_.Exception.InnerException.Message)"
    }
}

Write-Host "`nScript Finished."