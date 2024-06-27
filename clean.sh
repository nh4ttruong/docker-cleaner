#!/bin/bash

REPOSITORIES=$(docker images --format '{{.Repository}}' | sort -u)
KEEP_MAX_IMAGES=$1

for repo in $REPOSITORIES; do
    # use `tac` to reverse order to oldest first
    IMAGE_IDS=$(docker images --format '{{.ID}}' --filter=reference="$repo" | tac)

    IMAGE_COUNT=$(echo "$IMAGE_IDS" | wc -l)

    if [ "$IMAGE_COUNT" -gt "$KEEP_MAX_IMAGES" ]; then
        IMAGES_TO_REMOVE=$((IMAGE_COUNT - KEEP_MAX_IMAGES))
        IDS_TO_REMOVE=$(echo "$IMAGE_IDS" | tail -n "$IMAGES_TO_REMOVE")

        echo "[$(date +'%Y-%m-%d %H:%M:%S')] Removed $IMAGES_TO_REMOVE old image(s) of repository: $repo"
        for id in $IDS_TO_REMOVE; do
            docker rmi -f "$id"
        done
    fi
done