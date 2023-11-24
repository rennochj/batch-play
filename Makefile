
app/.venv/bin/activate: app/pyproject.toml
	cd batch-play && poetry lock && poetry install
	touch app/.venv/bin/activate

build: app/.venv/bin/activate
	BUILDKIT=1 docker build -f container/Dockerfile . -t batch-play-container 

run: app/.venv/bin/activate
	cd app && poetry run python batch_play/main.py

run-container: 
	docker run -it --rm --name my-running-app -v "${BATCH_PLAY_DATA_PATH}:/data" connerjh/batch-play-container:latest python /app/batch-play/main.py

create-builder:
	docker buildx create --name batch-play-builder --node batch-play-builder0 --use --bootstrap

remove-builder:
	docker buildx rm batch-play-builder

publish: create-builder
	docker buildx build --push --platform linux/amd64,linux/arm64 -f /workspaces/batch-play/container/Dockerfile --tag connerjh/batch-play-container:$(shell date '+%Y%m%d')  --tag connerjh/batch-play-container:latest .
