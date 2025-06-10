gource --seconds-per-day 1 \
       --stop-at-end \
       --viewport 1920x1080 \
       --output-ppm-stream - \
       --output-framerate 60 | ffmpeg -y \
       -r 60 -f image2pipe -vcodec ppm -i - \
       -vcodec libx264 -preset fast -crf 18 -pix_fmt yuv420p \
       gource.mp4