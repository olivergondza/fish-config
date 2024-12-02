function ytdp
    yt-dlp -x --audio-format mp3 --write-thumbnail --convert-thumbnails jpg \
        -o "%(playlist_autonumber)02d%(title)s.%(ext)s" \
        $argv[1]

    # `--write-thumbnail` creates file for each track with name specified by `-o`
    # Consolidate to a single cover.jpg instead.
    mv 01*.jpg cover
    rm *.jpg
    mv cover cover.jpg
end
