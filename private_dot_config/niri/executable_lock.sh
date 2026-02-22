# /bin/bash

playerctl pause
noctalia-shell ipc call lockScreen lock
exit 0 # return early so swayidle continues
