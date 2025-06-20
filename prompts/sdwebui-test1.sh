#!/bin/bash

# Use 10.255.255.254 for WSL if you ran the server in windows
# You may need to run this in powershell as well:
# New-NetFirewallRule -DisplayName "Allow SDAPI from WSL" -Direction Inbound -Protocol TCP -LocalPort 7861 -Action Allow -EdgeTraversal NotRequired -Profile Any

# ...Otherwise, localhost should be fine

echo '''Running curl -X GET \
  http://10.255.255.254:7861/sdapi/v1/txt2img \
  -H "Content-Type: application/json" \
  -d '{ "prompt": "puppy dog", "steps": 5 }' \
  -o output.json
  '''
curl -X GET \
  http://10.255.255.254:7861/sdapi/v1/txt2img \
  -H "Content-Type: application/json" \
  -d '{ "prompt": "puppy dog", "steps": 5 }' \
  -o output.json

echo "Running jq -r '.images[0]' output.json | base64 --decode > output.png"
jq -r '.images[0]' output.json | base64 --decode > output.png