#!/bin/bash
ROOT=`pwd`
mkdir -p videos
DATE=$(date +%Y-%m-%d)
mkdir -p screenshots/$DATE
SCREENSHOTS="$_"
# Recording between 4:00 and 20:00
echo "Loading Google Maps (with traffic) in Safari"
 while [[ "$(date +"%T")" > '04:00:00' ]] && [[ "$(date +"%T")" < '20:00:00' ]]
 do

	# # Randstad large
	#	open -a safari "https://www.google.nl/maps/@52.1404712,4.9350591,9z/data=!5m1!1e1"

	# # Randstad up close (mobile)
	open -a safari "https://www.google.nl/maps/@52.1101191,4.7936101,10z/data=!5m1!1e1"

	sleep 60 # 60 seconds
	screencapture -S -t jpg $ROOT/$SCREENSHOTS/$(date +%H:%M:%S).jpg
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
