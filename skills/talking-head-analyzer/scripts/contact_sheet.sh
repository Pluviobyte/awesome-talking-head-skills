#!/usr/bin/env bash
# 把视频的一段抽成带时间戳的拼图，用来逐帧看动作。
# 用法：contact_sheet.sh <视频> <输出.jpg> [开始秒=0] [时长秒=20] [每秒帧数=2] [列x行=8x5] [单帧宽=320]
# 例：
#   contact_sheet.sh clip.mp4 overview.jpg               # 前 20 秒，每秒 2 帧，看整体结构
#   contact_sheet.sh clip.mp4 closeup.jpg 10.5 6 4 6x4 400  # 10.5 秒起 6 秒，每秒 4 帧，看手势
set -euo pipefail

in=${1:?需要输入视频}
out=${2:?需要输出图片路径}
start=${3:-0}
dur=${4:-20}
fps=${5:-2}
grid=${6:-8x5}
width=${7:-320}

font=""
for f in /System/Library/Fonts/Supplemental/Arial.ttf \
         /usr/share/fonts/truetype/dejavu/DejaVuSans.ttf \
         /usr/share/fonts/dejavu/DejaVuSans.ttf; do
  [ -f "$f" ] && font="fontfile=$f:" && break
done

filter=$(mktemp)
trap 'rm -f "$filter"' EXIT
# 时间戳显示原片里的绝对时间（加上开始秒）
printf "fps=%s,scale=%s:-2,drawtext=%stext='%%{pts\\\\:hms\\\\:%s}':x=6:y=6:fontsize=20:fontcolor=yellow:box=1:boxcolor=black@0.6,tile=%s\n" \
  "$fps" "$width" "$font" "$start" "$grid" > "$filter"

ffmpeg -v error -y -ss "$start" -i "$in" -t "$dur" -filter_script:v "$filter" -frames:v 1 "$out"
echo "$out"
