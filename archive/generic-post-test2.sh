#!/bin/bash

# or http://localhost:11434/api/chat ?
curl -X POST http://localhost:11434/v1/chat/completions \
-H "Content-Type: application/json" \
-d @- <<EOF
{
  "model": "alex",
  "messages": [{"role": "user", "content": "Hello, Alex. I'm back!"}],
  "stream": true
}
EOF