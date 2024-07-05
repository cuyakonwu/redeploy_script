tmux kill-server

cd ..
cd /MLH-Portfolio

git fetch && git reset origin/main --hard

source venv/bin/activate
pip install -r requirements.txt

tmux new-session -d -s flask_server "cd /MLH-Portfolio && source venv/bin/activate && flask run --host=0.0.0.0 --port=5000"

echo "Deployment script executed successfully."
