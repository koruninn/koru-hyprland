#!/bin/zsh

# Define the directory where recordings will be saved
RECORDINGS_DIR="$HOME/Vídeos/Grabación de pantalla"
mkdir -p "$RECORDINGS_DIR" # Create the directory if it doesn't exist

# Define the output filename with a timestamp
FILENAME="recording_$(date +'%Y-%m-%d_%H-%M-%S').mp4"
FILEPATH="$RECORDINGS_DIR/$FILENAME"

# Check if wf-recorder is already running
if pgrep -x "wf-recorder" > /dev/null; then
    # If running, send SIGINT to stop it gracefully
    pkill -INT -x wf-recorder
    notify-send "Grabando pantalla" "Grabación detenida. Guardada en $FILEPATH"
    exit 0
else
    # If not running, start recording the whole screen
    # You can customize codec, framerate, and audio options here.
    # --audio: records audio (requires PipeWire and a configured audio input)
    # -f: specifies the output file
    # -c:v h264_nvenc: Example for NVIDIA hardware encoding.
    # -c:v h264_vaapi: Example for Intel/AMD VAAPI hardware encoding.
    # If you don't have hardware encoding, just use -c:v libx264
    
    # Example for full screen with audio (adjust codec as needed)
    wf-recorder --audio -f "$FILEPATH" &

    # Store the PID to track it later if needed (optional)
    echo $! > /tmp/wf-recorder.pid

    notify-send "Grabando pantalla" "Grabación iniciada: $FILENAME"
    exit 0
fi
