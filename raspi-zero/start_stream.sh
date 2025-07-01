#!/bin/bash                                                                                           │[mpeg4 @ 0x121a080c0] illegal dc vlc
                                                                                                      │[mpeg4 @ 0x121a080c0] Error at MB: 1173
# Start MediaMTX in the background                                                                    │[mpeg4 @ 0x121a080c0] concealing 104 DC, 104 AC, 104 MV errors in I frame
echo "Starting RTSP server..."                                                                        │[swscaler @ 0x1281c8000] No accelerated colorspace conversion found from yuv420p to bgr24.
/home/raspi/mediamtx /home/raspi/mediamtx.yml &                                                       │[swscaler @ 0x140120000] No accelerated colorspace conversion found from yuv420p to bgr24.
                                                                                                      │[swscaler @ 0x1282d0000] No accelerated colorspace conversion found from yuv420p to bgr24.
# Wait for server to become ready                                                                     │[swscaler @ 0x1283d8000] No accelerated colorspace conversion found from yuv420p to bgr24.
SERVER_READY=0                                                                                        │[swscaler @ 0x1284e0000] No accelerated colorspace conversion found from yuv420p to bgr24.
for i in {1..10}; do                                                                                  │[swscaler @ 0x1285e8000] No accelerated colorspace conversion found from yuv420p to bgr24.
  if ss -tuln | grep -q ':8554'; then                                                                 │[swscaler @ 0x1286f0000] No accelerated colorspace conversion found from yuv420p to bgr24.
    SERVER_READY=1                                                                                    │[swscaler @ 0x1287f8000] No accelerated colorspace conversion found from yuv420p to bgr24.
    break                                                                                             │[swscaler @ 0x140140000] No accelerated colorspace conversion found from yuv420p to bgr24.
  fi                                                                                                  │[rtsp @ 0x12076e860] max delay reached. need to consume packet
  sleep 1                                                                                             │[rtsp @ 0x12076e860] RTP: missed 2 packets
done                                                                                                  │[rtsp @ 0x12076e860] max delay reached. need to consume packet
                                                                                                      │[rtsp @ 0x12076e860] RTP: missed 2 packets
if [ $SERVER_READY -eq 1 ]; then                                                                      │^C%                                                                                                   
  echo "Server is up and running on port 8554"                                                        │╭─russelchan at russels-MacBook-Air in ~/Dev
  echo "Starting FFmpeg stream..."                                                                    │╰─○ ffplay rtsp://192.168.0.138:8554/stream
                                                                                                      │ffplay version 7.1.1 Copyright (c) 2003-2025 the FFmpeg developers
  # Start FFmpeg with error handling                                                                  │  built with Apple clang version 17.0.0 (clang-1700.0.13.3)
  ffmpeg \                                                                                            │  configuration: --prefix=/opt/homebrew/Cellar/ffmpeg/7.1.1_3 --enable-shared --enable-pthreads --enab
    -f v4l2 \                                                                                         │le-version3 --cc=clang --host-cflags= --host-ldflags='-Wl,-ld_classic' --enable-ffplay --enable-gnutls
    -input_format mjpeg \                                                                             │ --enable-gpl --enable-libaom --enable-libaribb24 --enable-libbluray --enable-libdav1d --enable-libhar
    -video_size 340x240 \                                                                             │fbuzz --enable-libjxl --enable-libmp3lame --enable-libopus --enable-librav1e --enable-librist --enable
    -i /dev/video0 \                                                                                  │-librubberband --enable-libsnappy --enable-libsrt --enable-libssh --enable-libsvtav1 --enable-libtesse
    -c:v mpeg4 \                                                                                      │ract --enable-libtheora --enable-libvidstab --enable-libvmaf --enable-libvorbis --enable-libvpx --enab
    -preset ultrafast \                                                                               │le-libwebp --enable-libx264 --enable-libx265 --enable-libxml2 --enable-libxvid --enable-lzma --enable-
    -tune zerolatency \                                                                               │libfontconfig --enable-libfreetype --enable-frei0r --enable-libass --enable-libopencore-amrnb --enable
    -f rtsp \                                                                                         │-libopencore-amrwb --enable-libopenjpeg --enable-libspeex --enable-libsoxr --enable-libzmq --enable-li
    rtsp://localhost:8554/stream \                                                                    │bzimg --disable-libjack --disable-indev=jack --enable-videotoolbox --enable-audiotoolbox --enable-neon
    2> >(while read line; do echo "FFmpeg: $line"; done)                                              │  libavutil      59. 39.100 / 59. 39.100
                                                                                                      │  libavcodec     61. 19.101 / 61. 19.101
  echo "FFmpeg stream ended"                                                                          │  libavformat    61.  7.100 / 61.  7.100
else                                                                                                  │  libavdevice    61.  3.100 / 61.  3.100
  echo "Error: RTSP server failed to start"                                                           │  libavfilter    10.  4.100 / 10.  4.100
  exit 1                                                                                              │  libswscale      8.  3.100 /  8.  3.100
fi                                                                                                    │  libswresample   5.  3.100 /  5.  3.100
                                                                                                      │  libpostproc    58.  3.100 / 58.  3.100
# Keep service running                                                                                │Input #0, rtsp, from 'rtsp://192.168.0.138:8554/stream':
wait    