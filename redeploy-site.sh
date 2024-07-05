#!/bin/bash

# Kill all existing tmux sessions
tmux kill-server

# Navigate to the project directory
cd /root/redeploy_script
cd ../MLH-Portfolio || { echo "Project directory /root/MLH-Portfolio not found."; exit 1; }

# Fetch the latest changes from the main branch and reset the local repository
git fetch && git reset origin/main --hard || { echo "Git fetch or reset failed."; exit 1; }

# Activate the python virtual environment and install dependencies
source python3-virtualenv/bin/activate || { echo "Virtual environment activation failed."; exit 1; }
pip install -r requirements.txt || { echo "Pip install failed."; exit 1; }

# Start a new detached tmux session that goes to the project directory, activates the virtual environment, and starts the Flask server on port 5000
tmux new-session -d -s flask_server "cd /root/MLH-Portfolio && source python3-virtualenv/bin/activate && flask run --host=0.0.0.0 --port=5000" || { echo "Failed to start tmux session."; exit 1; }

echo "Deployment script executed successfully."
