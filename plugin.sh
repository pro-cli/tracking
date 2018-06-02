#!/usr/bin/env bash

if [ "$1" == "track" ]; then
    shift
    . "$BASE_DIR/plugins/tracking/includes/bootstrap.sh"
    #echo $(get_timestamp)

    if ! project_exists; then
        echo "$TRACKING_JSON" | jq --arg PN "$PROJECT_NAME" '.projects[$PN] = []' | jq -M . > "$TRACKING_CONFIG_PATH"
        TRACKING_JSON=$(cat "$TRACKING_CONFIG_PATH")
    fi

    if has_active_trackings; then
        try_to_stop_tracking
        exit
    fi

    printf "Start tracking ... "
    TIMESTAMP=$(get_timestamp)
    echo "$TRACKING_JSON" | jq --arg PN "$PROJECT_NAME" --arg TIME $TIMESTAMP '.projects[$PN] += [{"start": $TIME}]' > "$TRACKING_CONFIG_PATH"
    TRACKING_JSON=$(cat "$TRACKING_CONFIG_PATH")
    printf "${GREEN}done${NORMAL}\n"
    exit
elif [ "$1" == "trackings" ]; then
    cat "$TRACKINGS_CONFIG_PATH" | jq .
    exit
fi
