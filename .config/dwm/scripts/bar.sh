#!/bin/dash

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors
. ~/.config/dwm/scripts/bar_themes/onedark

readNotifTxt() {
  notif=$(cat /home/evan/.config/dwm/scripts/sometext.txt)
  if [ ! -z "$notif" ]; then
    printf "^c$white^ ^b$grey^ $notif"
    wait
  fi
}

cpu() {
	cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

	printf "^c$black^ ^b$green^ CPU"
	printf "^c$white^ ^b$grey^ $cpu_val"
}

pkg_updates() {
	updates=$(checkupdates | wc -l)

	if [ -z "$updates" ]; then
		printf "^c$green^  Fully Updated"
	else
		printf "^c$green^  $updates"" updates"
	fi
}

mem() {
	printf "^c$blue^^b$black^  "
	printf "^c$blue^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

lan() {
	case "$(cat /sys/class/net/en*/operstate 2>/dev/null)" in
	up) printf "^c$black^ ^b$blue^ 󰤨 ^d^%s" " ^c$blue^Connected" ;;
	down) printf "^c$black^ ^b$blue^ 󰤭 ^d^%s" " ^c$blue^Disconnected" ;;
	esac
}

clock() {
	printf "^c$black^ ^b$darkblue^ 󱑆 "
	printf "^c$black^^b$blue^ $(date '+%I:%M %p')  "
}

volume() {
  muteIcon=' 婢 '
  onIcon=' 墳 '
  mute=$(pactl get-sink-mute @DEFAULT_SINK@)
  volume=$(pamixer --get-volume)
  if [ "${mute}" = 'Mute: yes' ]
  then
	  printf "^c$blue^ ^b$black^ 婢 "
	  printf "^c$white^ ^b$grey^ $volume%%"
  else
	  printf "^c$blue^ ^b$black^ 墳 "
	  printf "^c$white^ ^b$grey^ $volume%%"
  fi
}

nowPlaying() {
  curSong=$(playerctl --player=spotifyd,spotify metadata --format '{{ artist }} - {{ title }}')
  if [ ! -z "$curSong" ]; then
    printf "^c$white^ ^b$grey^ $curSong"
  fi
}

while true; do
	[ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
	interval=$((interval + 1))

  sleep 1 && xsetroot -name "$updates $(nowPlaying) $(cpu) $(mem) $(lan) $(volume) $(clock) $(readNotifTxt)"
done
