#!/bin/bash

# Start MediaMTX in the background
echo "Starting RTSP server..."
/home/raspi/mediamtx /home/raspi/mediamtx.yml &

# Wait for server to become ready
SERVER_READY=0
for i in {1..10}; do
  if ss -tuln | grep -q ':8554'; then
    SERVER_READY=1
    break
  fi
  sleep 1
done

if [ $SERVER_READY -eq 1 ]; then
  echo "Server is up and running on port 8554"
  echo "Starting FFmpeg stream..."
  
  # Start FFmpeg with error handling
  ffmpeg \
    -f v4l2 \
    -input_format mjpeg \
    -video_size 340x240 \
    -i /dev/video0 \
    -c:v mpeg4 \
    -preset ultrafast \
    -tune zerolatency \
    -f rtsp \
    rtsp://localhost:8554/stream \
    2> >(while read line; do echo "FFmpeg: $line"; done)

  echo "FFmpeg stream ended"
else
  echo "Error: RTSP server failed to start"
  exit 1
fi

# Keep service running
wait