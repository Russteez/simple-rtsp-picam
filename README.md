# simple-rtsp-picam

# Download ffmpeg

```
sudo apt install ffmpeg -y
```

#Works with raspi that support 64bit/arm64
# Download and install mediamtx
```
wget https://github.com/bluenviron/mediamtx/releases/download/v1.6.0/mediamtx_v1.6.0_linux_arm64v8.tar.gz
tar xvf mediamtx_v1.6.0_linux_arm64v8.tar.gz
sudo ./mediamtx &
```

# Then stream to it with FFmpeg
```
ffmpeg -f v4l2 \
       -input_format mjpeg \
       -video_size 640x480 \
       -i /dev/video0 \
       -c:v copy \
       -f rtsp \
       rtsp://localhost:8554/stream
```

# For raspi that using 32bit/arm
# Download and install mediamtx
```
wget https://github.com/bluenviron/mediamtx/releases/download/v1.6.0/mediamtx_v1.6.0_linux_armv7.tar.gz
tar xvf mediamtx_v1.6.0_linux_armv7.tar.gz
```

```
ffmpeg -f v4l2 \
       -video_size 340x240 \
       -framerate 20 \
       -i /dev/video0 \
       -c:v libx264 \
       -preset ultrafast \
       -tune zerolatency \
       -f rtsp \ 
       rtsp://localhost:8554/stream
```

# Use the mediamtx.yml config for any device
# Copy and put on the same directory that you download the mediamtx file

# To start rtsp picam upon startup follow this step
1. Create or copy the `start_stream.sh` file to you home directory or any directory
2. Execute this command `sudo chmod +x /your-directory/start_stream.sh`
3. Create new file on `/etc/systemd/system/stream.service`
4. Create or copy the `stream.service` file on `/etc/systemd/system/stream.service`
5. run this command 
```
sudo systemctl daemon-reload
sudo systemctl enable stream.service
sudo systemctl start stream.service
```