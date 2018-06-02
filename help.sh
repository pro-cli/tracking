#!/usr/bin/env bash

# # # # # # # # # # # # # # # # # # # #
# show tracking commands
if [ -f "$PROJECT_CONFIG" ]; then
    printf "TRACKING COMMANDS:\n"
    printf "    ${BLUE}track${NORMAL}${HELP_SPACE:5}Start and stop tracking for the current project.\n"
    printf "    ${BLUE}trackings${NORMAL}${HELP_SPACE:8}List trackings for the current project.\n"
fi
