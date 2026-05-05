if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    source ~/.bashrc
    exec niri-session -l
fi
