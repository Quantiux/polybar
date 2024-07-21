#!/usr/bin/env bash

# notify-send without title 
# https://www.linuxquestions.org/questions/blog/the-dsc-472367/for-those-who-dont-like-notify-send-exhibiting-its-title-notify-send-on-lxqt-38940/

if [[ ! "${@}" =~ "-a " ]] ; then
    /usr/bin/notify-send -a "" "${@}"
else
    /usr/bin/notify-send "${@}"
fi
