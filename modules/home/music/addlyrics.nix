{ pkgs, ... }:
{
  programs.fish.functions = {
    addlyrics = ''
      set opus_path $argv[1]

      set filename (basename $opus_path .opus)
      set dir (dirname $opus_path)
      set lrc_path "$dir/$filename.lrc"

      set title (python3 -c "
from mutagen.oggopus import OggOpus
a = OggOpus('$opus_path')
v = a.get('title')
print(v[0] if v else '$filename')
")
      set artist (python3 -c "
from mutagen.oggopus import OggOpus
a = OggOpus('$opus_path')
v = a.get('artist')
print(v[0] if v else 'Unknown')
")
      set album (python3 -c "
from mutagen.oggopus import OggOpus
a = OggOpus('$opus_path')
v = a.get('album')
print(v[0] if v else 'Unknown')
")

      set clean_title (echo $title | sed 's/([^)]*)//g' | string trim)
      set query (string replace -a " " "+" "$clean_title $artist")

      echo "Searching lyrics for $clean_title - $artist..."
      set lyrics (curl -s "https://lrclib.net/api/search?q=$query" | jq -r '.[0].syncedLyrics // .[0].plainLyrics // empty')

      if test -n "$lyrics"
          printf "[ti:%s]\n[ar:%s]\n[al:%s]\n%s\n" $title $artist $album $lyrics > $lrc_path
          python3 -c "
from mutagen.oggopus import OggOpus
audio = OggOpus('$opus_path')
audio['lyrics'] = [open('$lrc_path').read()]
audio.save()
"
          echo "✓ Lyrics saved and embedded for $clean_title"
      else
          echo "✗ No lyrics found for $clean_title"
      end
    '';
  };
}
