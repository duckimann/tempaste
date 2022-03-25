#!/bin/bash

# THIS IS JUST A GUIDE, NOT A PROPER SCRIPT
# refs:
# https://stackoverflow.com/questions/47844205/decrypt-aes-128-encrypted-m3u8-playlist-and-ts-files-with-ffmpeg/47852871#47852871
# https://superuser.com/questions/1563182/decrypt-m3u8-playlist-and-merge-it-into-single-mp4-file-with-ffmpeg/1564432#1564432

# required files:
# *.m3u8
# *.key
# *.ts

# *.key contents (should looks like) (it's just a key so just that short)
# 8051bEc64316DfcF

# *.m3u8 contents (should looks like)
# #EXTM3U
# #EXT-X-VERSION:3
# #EXT-X-TARGETDURATION:20
# #EXT-X-MEDIA-SEQUENCE:0
# #EXT-X-KEY:METHOD=AES-128,URI="ts.key",IV=0x00000000000000000000000000000000
# #EXTINF:10.427089,
# index0.ts
# ...
# #EXT-X-ENDLIST

# ffmpeg -i [path_to_m3u8] -c copy output.ts
ffmpeg -i http://127.0.0.1/index.m3u8 -c copy output.mp4 # if local http server

ffmpeg -protocol_whitelist file,tls,tcp,https,crypto -allowed_extensions ALL -i index.m3u8 -c copy output.mp4 # if not using local http server and files path in m3u8 file just relatively to each other (some what same with the above example)