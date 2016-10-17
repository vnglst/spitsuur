#!/bin/bash
ROOT=`pwd`
mkdir -p videos
mkdir -p screenshots/$(date +%Y-%m-%d) && cd "$_"
# Recording between 4:00 and 20:00
echo "Loading Google Maps (with traffic) in Safari"
# while [[ "$(date +"%T")" > '04:00:00' ]] && [[ "$(date +"%T")" < '20:00:00' ]]
# do
	open -a safari "https://www.google.nl/maps/@52.1404712,4.9350591,9z/data=!5m1!1e1"
	sleep 60 # 60 seconds
	screencapture -S -t jpg $(date +%H:%M:%S).jpg
# done
echo "Done recording screenshots."
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
echo "All done"
