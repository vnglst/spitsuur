#!/bin/bash
ROOT=$1
echo "Generating video from jpg files"
convert -delay 10 -quality 100 *.jpg \
		-gravity South -pointsize 80 -annotate +0+100 %f \
		$ROOT/videos/randstad-$(date +%y-%m-%d_%H-%M-%S).mp4
VIDEOFILE="$_"
cd $ROOT
echo "Uploading $VIDEOFILE to YouTube"
node upload.js $VIDEOFILE
echo "Moving $VIDEOFILE to uploaded folder"
cd videos
mkdir -p uploaded
mv $VIDEOFILE uploaded
