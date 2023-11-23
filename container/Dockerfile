FROM python:3.9.18

RUN pip install poetry

RUN mkdir /batch-play
ADD ../batch-play /batch-play
WORKDIR /batch-play
RUN poetry install

