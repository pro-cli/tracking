#!/usr/bin/env bash

. "${BASE_DIR}/plugins/tracking/includes/functions.sh"

readonly TRACKING_CONFIG_PATH="${BASE_DIR}/.trackings.json"

if [ ! -f "$TRACKING_CONFIG_PATH" ]; then
    echo "{ \"projects\": {} }" | jq -M . > "$TRACKING_CONFIG_PATH"
fi

TRACKING_JSON=$(cat "$TRACKING_CONFIG_PATH")
