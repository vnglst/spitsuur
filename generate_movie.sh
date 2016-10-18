#!/bin/bash
# ROOT=$1
# DATE=$2
# echo "Generating video from jpg files"
# convert -delay 10 -quality 100 *.jpg \
# 		-gravity South -pointsize 80 -annotate +0+100 %f \
# 		$ROOT/videos/randstad-$DATE.mp4
# VIDEOFILE="$_"
# cd $ROOT
# echo "Uploading $VIDEOFILE to YouTube"
# node upload.js $VIDEOFILE
# echo "Moving $VIDEOFILE to uploaded folder"
# cd videos
# mkdir -p uploaded
# mv $VIDEOFILE uploaded
