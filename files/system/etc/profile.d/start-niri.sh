if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/pts/0" ]; then
    source ~/.bashrc
    kmscon-launch-gui niri-session -l
fi
