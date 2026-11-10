if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/pts/0" ]; then
    source ~/.bashrc
    exec niri-session -l
fi
