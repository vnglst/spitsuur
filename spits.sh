#!/bin/bash

echo "Installing Node dependencies"
yarn

ROOT=`pwd`
mkdir -p videos
DATE=$(date +%Y-%m-%d)
mkdir -p screenshots/$DATE
SCREENSHOTS="$_"

# Recording between 4:00 and 20:00
echo "Capturing Google Maps (with traffic)"
while [[ "$(date +"%T")" > '04:00:00' ]] && [[ "$(date +"%T")" < '20:00:00' ]]
do
	node capture.js $ROOT/$SCREENSHOTS/$(date +%H:%M:%S).jpg
	sleep 5 # 60 seconds
	echo -ne '#'
done
echo "Done recording screenshots."

echo "Generating video from jpg files"
convert -delay 10 -quality 100 \
		$ROOT/$SCREENSHOTS/*.jpg \
		-gravity South -pointsize 80 -annotate +0+100 %f \
		$ROOT/videos/randstad-$DATE.mp4
VIDEOFILE="randstad-$DATE.mp4"

echo "Uploading $VIDEOFILE to YouTube"
node upload.js $ROOT/videos/$VIDEOFILE

echo "Moving $VIDEOFILE to uploaded folder"
mv $ROOT/videos/$VIDEOFILE $ROOT/videos/uploaded

echo "All done"
