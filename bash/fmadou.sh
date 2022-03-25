#!/bin/bash
# Required: curl, ffmpeg
echo -e "\033[1;31mFetching first page...\033[0m";
INIT=$(curl -s "$1" | grep -Po "https?:\/\/dash\.madou\.club\/share\/\S+");

# Get middle shit
echo -e "\033[1;31mFetching m3u8 file...\033[0m";
MID=$(curl -s "$INIT");
M3_TOKEN=$(echo "$MID" | grep -Po "(?<=token\s=\s\")[^\"]+");
M3=$(echo "$MID" | grep -Po "\/videos.*m3u8");
curl -s -o index.m3u8 "https://dash.madou.club$M3?token=$M3_TOKEN";

# Get key
echo -e "\033[1;31mFetching key...\033[0m";
curl -s -O $(grep -Po "http.*\.key" ./index.m3u8);

# Get TS Files
echo -e "\033[1;31mFetching TS files (Video Body)...\033[0m";
URL=$(grep -Po "http.*\/" ./index.m3u8);
SMF=$(grep -Po "\d+(?=\.ts)" ./index.m3u8 | tail -1)
curl -O "$URL/index[0-$SMF].ts";

# Replace url to be relatively local
echo -e "\033[1;31mMaking key available for local...\033[0m";
sed -Ei "s/http.*\///g" ./index.m3u8;

echo -e "\033[1;31mTranscoding...\033[0m";
ffmpeg -protocol_whitelist file,tls,tcp,https,crypto -allowed_extensions ALL -i ./index.m3u8 -c copy "$2".mp4;

# Usage
# ./fmadou.sh "URL_To_Video_Page"