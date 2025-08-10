#!/usr/bin/env zsh
# ~/.config/waybar/scripts/net_speed.sh
# Usage: net_speed.sh [interface]
# If no interface given, tries to auto-detect the default-up interface.

INTERFACE="$1"

# Try to auto-detect default interface if none provided
if [ -z "$INTERFACE" ]; then
  INTERFACE=$(ip route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<NF;i++) if($i=="dev"){print $(i+1); exit}}')
fi

# Fallback: first non-loopback 'up' interface
if [ -z "$INTERFACE" ]; then
  INTERFACE=$(ip -o link show up | awk -F': ' '{print $2}' | grep -v lo | head -n1)
fi

# If still empty, return a friendly JSON so Waybar won't break
if [ -z "$INTERFACE" ] || [ ! -d "/sys/class/net/$INTERFACE" ]; then
  echo "{\"text\":\" N/A  N/A\",\"tooltip\":\"No network interface detected\"}"
  exit 0
fi

RX_FILE="/sys/class/net/$INTERFACE/statistics/rx_bytes"
TX_FILE="/sys/class/net/$INTERFACE/statistics/tx_bytes"

if [ ! -r "$RX_FILE" ] || [ ! -r "$TX_FILE" ]; then
  echo "{\"text\":\" N/A  N/A\",\"tooltip\":\"Cannot read statistics for $INTERFACE\"}"
  exit 0
fi

RX1=$(cat "$RX_FILE")
TX1=$(cat "$TX_FILE")

# short sample period (1 second)
sleep 1

RX2=$(cat "$RX_FILE")
TX2=$(cat "$TX_FILE")

# bytes/sec (handle possible negative differences)
RXBPS=$(( RX2 - RX1 ))
TXBPS=$(( TX2 - TX1 ))
if [ "$RXBPS" -lt 0 ]; then RXBPS=0; fi
if [ "$TXBPS" -lt 0 ]; then TXBPS=0; fi

# convert to megabits per second and format with awk (no external bc)
RXMBPS=$(awk -v b="$RXBPS" 'BEGIN{printf "%.2f", (b*8)/1000000}')
TXMBPS=$(awk -v b="$TXBPS" 'BEGIN{printf "%.2f", (b*8)/1000000}')

# Nerd Font icons:  (down) and  (up)
TEXT=" ${RXMBPS} Mbps  ${TXMBPS} Mbps"
TOOLTIP="Interface: ${INTERFACE}\nDownload: ${RXMBPS} Mbps\nUpload: ${TXMBPS} Mbps"

# Output JSON for Waybar custom module
echo "{\"text\": \"${TEXT}\", \"tooltip\": \"${TOOLTIP}\"}"

