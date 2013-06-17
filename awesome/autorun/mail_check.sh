#!/bin/bash
 
while inotifywait -e moved_to ~/.Mail/Nsfocus/new/; do
    notify-send -t 50000 -i /usr/share/icons/Faenza-Darkest/actions/48/mail-attachment.png  "公司的邮件哦～"
    aplay -q ./english_msg.wav
done 
