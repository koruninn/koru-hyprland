#!/bin/zsh

# This script fetches and displays only the location name using wttr.in.
#
# Usage:
#   ./get_location_name.sh          # Automatically detects location based on your IP
#   ./get_location_name.sh "London" # Specifies 'London' as the location
#   ./get_location_name.sh "New York" # Specifies 'New York' (spaces handled)
#   ./get_location_name.sh "Lima, Peru" # More specific location for clarity

# Check if a location argument is provided.
if [ -z "$1" ]; then
    # If no argument, wttr.in will use your current public IP's location.
    # Note: For this to show "Lima" consistently for you, your public IP
    # needs to resolve to Lima.
    LOCATION=""
else
    # If an argument is provided, use it as the location.
    # We replace spaces with '+' for URL compatibility.
    LOCATION="$(echo "$1" | sed 's/ /+/g')"
fi

# Use curl to fetch the location name from wttr.in.
# -s: Silent mode (don't show progress meter or error messages).
# ?format=%l: This specific format string tells wttr.in to return ONLY the location name.
# 2>/dev/null: Redirects any potential error output from curl to /dev/null
#              to keep the terminal clean if there's a network issue, etc.
curl -s "wttr.in/$LOCATION?format=%l" 2>/dev/null
