FROM mcr.microsoft.com/devcontainers/python:3.12-bullseye

COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN mkdir /home/vscode/.git && chown 1000:1000 /home/vscode/.git
RUN mkdir /home/vscode/.docker && chown 1000:1000 /home/vscode/.docker
