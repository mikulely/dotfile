#!/bin/sh
# ~/.xinitrc executed by startx for awesome WM.

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrandr --output LVDS1 --auto
xrandr --output  VGA1 --left-of LVDS1  --auto

#For FCITX
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

#For localization
export LANG=zh_CN.UTF-8
#export LC_ALL="zh_CN.UTF-8"

#Bell
xset bell off
#Cursor Theme
xsetroot -cursor_name ComixCursors-Opaque-Black-Large-Slim

#Locks in 10 minutes of inactivity, or whenever you place the mouse cursor in
#the bottom right corner for 3 seconds
xautolock -time 10 -locker slock -nowlocker slock -detectsleep -corners 000+ -cornerdelay 3 &

sudo dnscrypt-proxy --local-address=127.0.0.1 --edns-payload-size=4096 \
    --pidfile=/run/dnscrypt-proxy.pid  --user=nobody \
    --logfile=/var/log/dnscrypt.log --daemonize &
xbindkeys &

#Awesome
exec awesome
