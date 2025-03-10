#!/bin/bash

# Temporary file to save the screenshot
IMAGE_PATH="/tmp/screenshot_search.png"

# Capture a selected area and save it
flameshot gui -r > "$IMAGE_PATH"

# Ensure the image is saved
if [[ ! -s "$IMAGE_PATH" ]]; then
    echo "Screenshot capture failed or was canceled."
    exit 1
fi

# Upload image to 0x0.st (anonymous upload)
IMAGE_URL=$(curl -F "file=@$IMAGE_PATH" https://0x0.st)

# Validate upload
if [[ ! $IMAGE_URL =~ ^https?:// ]]; then
    echo "Image upload failed."
    exit 1
fi

# Open image in Google Lens
xdg-open "https://lens.google.com/uploadbyurl?url=$IMAGE_URL"
