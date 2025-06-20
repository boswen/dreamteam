#!/bin/sh

sudo apt update && sudo apt install python3-venv git -y
python3 -m venv ~/invokeai-venv
source ~/invokeai-venv/bin/activate
pip install invokeai