#!/bin/bash

echo "Installing Node dependencies"
yarn

ROOT=`pwd`
mkdir -p videos
mkdir -p videos/uploaded
DATE=$(date +%Y-%m-%d)
mkdir -p screenshots/$DATE
SCREENSHOTS="$_"

# Recording between 4:00 and 20:00
echo "Capturing Google Maps (with traffic)"
while [[ "$(date +"%T")" > '04:00:00' ]] && [[ "$(date +"%T")" < '19:00:00' ]]
do
	node capture.js $ROOT/$SCREENSHOTS/$(date +%H:%M).jpg
	sleep 60 # 60 seconds
	echo -ne '#'
done
echo "Done recording screenshots."

echo "Generating video from jpg files"
convert -delay 20 -quality 80 \
		$ROOT/$SCREENSHOTS/*.jpg \
		-gravity North -pointsize 80 -annotate +0+100 %f \
		$ROOT/videos/randstad-$DATE.mp4
VIDEOFILE="randstad-$DATE.mp4"

echo "Emailing file"
echo | mutt -s "Video $DATE" -a $ROOT/videos/$VIDEOFILE -- koen+spits@koenvangilst.nl

echo "Uploading $VIDEOFILE to YouTube"
node upload.js $ROOT/videos/$VIDEOFILE $DATE

echo "Moving $VIDEOFILE to uploaded folder"
mv $ROOT/videos/$VIDEOFILE $ROOT/videos/uploaded/

echo "All done"
