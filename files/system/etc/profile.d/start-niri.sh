if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    source ~/.bashrc
    niri-session &
fi
