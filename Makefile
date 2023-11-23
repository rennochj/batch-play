
build:
	docker build -f /workspaces/batch-play/container/Dockerfile . -t batch-play    

run:
	docker run -it --rm --name my-running-app -v "${BATCH_PLAY_DATA_PATH}:/data" batch-play poetry run python batch_play/main.py

publish:
	echo "publish not implemented"
