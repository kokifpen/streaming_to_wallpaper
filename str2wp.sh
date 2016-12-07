#!/bin/bash

# Get streaming and set as wallpaper

TMP_DIR=`mktemp -d`

# Set base url of streaming
BASE_URL=http://example.com:1935/live/xxxx.stream

PLAYLIST=`curl -sS $BASE_URL/playlist.m3u8 | tail -n 1`

CLIP=`curl -sS $BASE_URL/$PLAYLIST | tail -n 1`
echo $CLIP
URL=$BASE_URL/$CLIP
#echo $URL

curl -sS -o $TMP_DIR/out.ts $URL

cp ~/.wp_out.jpg ~/.wp_out_tmp.jpg
ffmpeg -loglevel quiet -i $TMP_DIR/out.ts -y -ss 1 -vframes 1 -f image2 ~/.wp_out.jpg
osascript -e 'tell application "System Events" to set picture of current desktop to "~/.wp_out_tmp.jpg"'
osascript -e 'tell application "System Events" to set picture of current desktop to "~/.wp_out.jpg"' && echo 'changed'

rm -rf $TMP_DIR ~/.wp_out_tmp.jpg
