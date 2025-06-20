#!/bin/bash

# Check if the number of arguments is not equal to 2
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <agent_name> <modelfile_name>"
  exit 1
fi

# Assign arguments to variables for clarity (optional)
AGENT_NAME="$1"
MODEL_FILE="$2"

# Run the ollama create command
echo "Creating agent '$AGENT_NAME' using modelfile '$MODEL_FILE'..."
ollama create "$AGENT_NAME" -f "$MODEL_FILE"

echo "Ollama agent creation process existed. See output above for more details."