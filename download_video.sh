#!/usr/bin/env sh

su - user -c "vlc ${1} :demux=dump :demuxdump-file=downloaded_video.mkv vlc://quit"
