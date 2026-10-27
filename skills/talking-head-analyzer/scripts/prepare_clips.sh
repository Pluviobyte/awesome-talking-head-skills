#!/usr/bin/env bash
# 把下载好的视频批量截成开头 N 秒，并导出 16k 单声道音频供转写。
# 用法：prepare_clips.sh <原片目录> <工作目录> [截取秒数=25]
# 产出：<工作目录>/clips/*.mp4、<工作目录>/audio/*.wav、<工作目录>/sheets/*_overview.jpg
set -euo pipefail

src=${1:?需要原片目录}
work=${2:?需要工作目录}
secs=${3:-25}
here=$(cd "$(dirname "$0")" && pwd)

mkdir -p "$work/clips" "$work/audio" "$work/sheets"
for f in "$src"/*.mp4 "$src"/*.mov; do
  [ -e "$f" ] || continue
  name=$(basename "${f%.*}")
  ffmpeg -v error -y -i "$f" -t "$secs" -vf "scale=-2:720" -c:v libx264 -preset veryfast -crf 20 -c:a aac "$work/clips/$name.mp4"
  ffmpeg -v error -y -i "$work/clips/$name.mp4" -vn -ac 1 -ar 16000 "$work/audio/$name.wav"
  "$here/contact_sheet.sh" "$work/clips/$name.mp4" "$work/sheets/${name}_overview.jpg" 0 20 2 8x5 320 >/dev/null
  echo "done: $name"
done
