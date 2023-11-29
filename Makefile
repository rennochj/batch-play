
app/.venv/bin/activate: app/pyproject.toml test
	cd /workspaces/batch-play/app && poetry lock && poetry install
	touch app/.venv/bin/activate

build: app/.venv/bin/activate
	BUILDKIT=1 docker build -f container/Dockerfile . -t batch-play-container 

run: app/.venv/bin/activate
	cd /workspaces/batch-play/app && poetry run python batch_play/main.py

test: 
	cd /workspaces/batch-play/app && poetry run pytest -W ignore::DeprecationWarning tests/*.py

run-container: 
	docker run -it --rm --pull always --name my-running-app -v "${BATCH_PLAY_DATA_PATH}:/data" connerjh/batch-play-container:latest python /app/batch-play/main.py

create-builder:
	docker buildx create --name batch-play-builder --node batch-play-builder0 --use --bootstrap

remove-builder:
	docker buildx rm batch-play-builder

run-batch:
	kubectl apply -f kubernetes/batch-play-job.yaml

publish: create-builder
	docker buildx build --push --platform linux/amd64,linux/arm64 --no-cache -f /workspaces/batch-play/container/Dockerfile --tag connerjh/batch-play-container:$(shell TZ=America/Chicago date '+%Y%m%d')  --tag connerjh/batch-play-container:latest .
