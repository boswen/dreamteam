#!/bin/bash

# or http://localhost:11434/api/chat ?
curl -X POST http://localhost:11434/v1/chat/completions \
-H "Content-Type: application/json" \
-d @- <<EOF
{
  "model": "alex",
  "messages": [{"role": "user", "content": "OK! Let's run some initial trials together: Describe to me how you might draw a futuristic cityscape at sunset."}],
  "stream": false
}
EOF