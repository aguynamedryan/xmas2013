# This script resizes all photos to 612x612
find ${INSTAUSER}_instagram_photos -name "*.jpg" | xargs mogrify -resize 612x612
