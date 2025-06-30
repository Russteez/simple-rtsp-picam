#!/bin/bash

# Start MediaMTX in the background
/home/raspi/mediamtx /etc/mediamtx/mediamtx.yml &

# Wait a moment for the server to initialize
sleep 2

# Start the FFmpeg stream
ffmpeg -f v4l2 -input_format mjpeg -video_size 640x480 -i /dev/video0 -c:v copy -f rtsp rtsp://localhost:8554/stream

# Keep the service running
wait