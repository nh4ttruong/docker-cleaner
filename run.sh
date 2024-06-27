#!/bin/bash

KEEP_MAX_IMAGES=5
curl -sL c"https://github.com/nh4ttruong/runner-cleanup/raw/main/clean.sh" | bash -s $KEEP_MAX_IMAGES

# docker clear cache from https://docs.gitlab.com/runner/executors/docker.html#clear-the-docker-cache
curl -sL "https://github.com/nh4ttruong/runner-cleanup/raw/main/clear-docker-cache.sh" | bash