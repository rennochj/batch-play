
build: 
	cd batch-play && poetry lock && poetry install 
	docker build -f /workspaces/batch-play/container/Dockerfile . -t batch-play-container    

run:
	cd batch-play && poetry run python batch_play/main.py

run-container: 
	docker run -it --rm --name my-running-app -v "${BATCH_PLAY_DATA_PATH}:/data" batch-play-container python /app/batch-play/main.py

publish:
	echo "publish not implemented"
