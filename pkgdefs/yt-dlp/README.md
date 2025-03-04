# yt-dlp

Download auto generated subtitles: `yt-dlp \[https://www.youtube.com/watch?v=\](https://www.youtube.com/watch?v=I9khGr4oDRA)<hash> --write-auto-sub --sub-lang en`

Some options to check: `--netrc --sponsorblock-remove all --add-chapters -o %(title)s.%(ext)s -f "(bv\*\[vcodec\~='^((he|a)vc|h26\[45\])'\]+ba\*\[ext=m4a\]) / (bv\*+ba/b)" --write-sub --sub-lang "en.\*" --convert-subs srt --embed-subs`
