#!/usr/bin/env bash

docker build -f app.Dockerfile -t tec-macro-project .

docker-compose up -d --force-recreate