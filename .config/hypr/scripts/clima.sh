#!/bin/zsh

# This script fetches and displays the current weather in Spanish for a specific location.
# To change the location, replace "Lima" with your desired city, airport code, or
# landmark. For locations with spaces, use a '+' sign (e.g., San+Francisco).
# The 'lang=es' parameter ensures the output is in Spanish.
# The 'format=%c+%C+%t' specifies the icon, condition, and temperature.

echo "$(curl -s 'wttr.in/Lima?lang=es&format=%c+%C+%t' 2>/dev/null)"
