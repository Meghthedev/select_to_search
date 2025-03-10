#!/bin/bash

# Kill any previous instances
pkill -f "python3 -m http.server"
pkill -f "ngrok"

# Detect local IP
IP=$(ip -4 addr show enp3s0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
PORT=8080

if [[ -z "$IP" ]]; then
    echo "Failed to determine local IP address."
    exit 1
fi

echo "Using Local IP: $IP"

# Create a temp directory for hosting
TEMP_DIR=$(mktemp -d)
IMAGE_PATH="$TEMP_DIR/screenshot.png"

# Capture the selected area and save it
flameshot gui -r > "$IMAGE_PATH"

# Ensure the image was saved
if [[ ! -s "$IMAGE_PATH" ]]; then
    echo "Screenshot capture failed or was canceled."
    exit 1
fi

# Start a Python HTTP server in the background
cd "$TEMP_DIR"
python3 -m http.server $PORT > /dev/null 2>&1 &

# Wait for the server to start
sleep 2

# Expose the server using ngrok
ngrok http $PORT > /dev/null 2>&1 &
sleep 3  # Reduce ngrok wait time

# Get the public URL
NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')

if [[ -z "$NGROK_URL" || "$NGROK_URL" == "null" ]]; then
    echo "Failed to get public URL from ngrok."
    exit 1
fi

IMAGE_URL="$NGROK_URL/screenshot.png"
echo "Image available at: $IMAGE_URL"

# Open Google Lens with the image
xdg-open "https://lens.google.com/uploadbyurl?url=$IMAGE_URL"

# Clean up after 10 seconds
sleep 10
pkill -f "python3 -m http.server"
pkill -f "ngrok"
rm -rf "$TEMP_DIR"
