mkdir -p videos
mkdir -p screenshots/$(date +%Y)/$(date +%m)/$(date +%d) && cd "$_"
# Recording between 4:00 and 20:00
while [[ "$(date +"%T")" > '04:00:00' ]] && [[ "$(date +"%T")" < '20:00:00' ]]
do
		open -a safari "https://www.google.nl/maps/@52.1404712,4.9350591,9z/data=!5m1!1e1"
		echo "Loading Google Maps (with traffic) in Safari"
		sleep 60 # 60 seconds
		echo "Making screenshot of current traffic"
		screencapture -S -t jpg $(date +%H:%M:%S).jpg
done
echo "Done recording."
echo "Generating video from jpg files"
convert -delay 10 -quality 100 *.jpg \
		-gravity South -pointsize 80 -annotate +0+100 %f \
		randstad-$(date +%y-%m-%d_%H-%M-%S).mp4
VIDEOFILE=$_
mv $VIDEOFILE ../../../../videos/
cd ../../../../
echo "Uploading video $VIDEOFILE to YouTube"
node upload.js videos/$VIDEOFILE
