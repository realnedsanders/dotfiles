xset r rate 250 100
.screenlayout/hex.sh
xbindkeys
nitrogen --restore &
picom --daemon
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
exec dbus-launch --sh-syntax --exit-with-session dwm

