#!/usr/bin/env bash
rm /usr/bin/sudo /usr/bin/visudo /usr/bin/su
ln -s /usr/bin/sudo-rs /usr/bin/sudo
ln -s /usr/bin/visudo-rs /usr/bin/visudo
ln -s /usr/bin/su-rs /usr/bin/su
