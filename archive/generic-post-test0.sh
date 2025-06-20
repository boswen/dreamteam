#!/bin/bash

# or http://localhost:11434/api/chat ?
curl -X POST http://localhost:11434/v1/chat/completions -H "Content-Type: application/json" -d '{
  "model": "alex",
  "messages": [{"role": "user", "content": "Tell me about Canada."}],
  "stream": false,
  "format": {
    "type": "object",
    "properties": {
      "name": {
        "type": "string"
      },
      "capital": {
        "type": "string"
      },
      "languages": {
        "type": "array",
        "items": {
          "type": "string"
        }
      }
    },
    "required": [
      "name",
      "capital", 
      "languages"
    ]
  }
}'