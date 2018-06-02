#!/usr/bin/env bash

get_timestamp() {
    local US_URL="http://www.convert-unix-time.com/api?timestamp=now"

    echo $(curl -H 'Cache-Control: no-cache' -s "$US_URL" | jq -r '.timestamp')
}

project_exists() {
    END=$(echo "$TRACKING_JSON" | jq --arg PN "$PROJECT_NAME" '.projects[$PN] | select(.!=null)')

    if [ -z "$END" ]; then
        return 1
    fi

    return 0
}

has_active_trackings() {
    LENGTH=$(echo "$TRACKING_JSON" | jq --arg PN "$PROJECT_NAME" '.projects[$PN] | length')

    [ $LENGTH -eq 0 ] && return 1

    START=$(echo "$TRACKING_JSON" | jq --arg PN "$PROJECT_NAME" '.projects[$PN] | select(.!=null) | .[-1] | .start | select(.!=null)')

    [ -z "$START" ] && return 1

    END=$(echo "$TRACKING_JSON" | jq --arg PN "$PROJECT_NAME" '.projects[$PN] | select(.!=null) | .[-1] | .end | select(.!=null)')

    [ ! -z "$END" ] && return 1

    return 0
}

try_to_stop_tracking() {
    read -p "You need to stop the current tracking first. Would you like to do that now? [y|n]: " -n 1 -r
    printf "\n"

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        printf "Stop tracking ... "
        local TIMESTAMP=$(get_timestamp)
        echo "$TRACKING_JSON" | jq --arg PN "$PROJECT_NAME" --arg TIME $TIMESTAMP '.projects[$PN][-1].end = $TIME' > "$TRACKING_CONFIG_PATH"
        TRACKING_JSON=$(cat "$TRACKING_CONFIG_PATH")

        printf "${GREEN}done${NORMAL}\n"
    fi
}

save_config() {
    echo ""
}
