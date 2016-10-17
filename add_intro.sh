#!/bin/bash

mkdir -p videos/intro

convert -size 2560x1600 xc:White \
  -gravity Center \
  -weight 700 -pointsize 200 \
  -annotate 0 "FILES\nRANDSTAD\n$(date +%y/%m/%d)" \
	videos/intro/_intro.jpg

echo "Generating intro video"
convert -delay 300 videos/intro/*.jpg \
	videos/intro/intro-$(date +%y-%m-%d_%H-%M-%S).mp4

rm videos/intro/*.jpg
