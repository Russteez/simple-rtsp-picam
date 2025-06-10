# simple-rtsp-picam

# Download and install mediamtx
wget https://github.com/bluenviron/mediamtx/releases/download/v1.6.0/mediamtx_v1.6.0_linux_arm64v8.tar.gz
tar xvf mediamtx_v1.6.0_linux_arm64v8.tar.gz
sudo ./mediamtx &

# Then stream to it with FFmpeg
ffmpeg -f v4l2 \
       -input_format mjpeg \
       -video_size 640x480 \
       -i /dev/video0 \
       -c:v copy \
       -f rtsp \
       rtsp://localhost:8554/stream
