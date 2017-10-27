#!/bin/bash

curl -u krunal9091@gmail.com:krunal1986 https://mail.google.com/mail/feed/atom/unread | sed 's/<\/entry>/<\/entry>\n/g' | grep "<entry>" |wc -l
#curl -u krunal.patil@smartthings.com:E7T>VaBY https://mail.google.com/mail/feed/atom/unread | sed 's/<\/entry>/<\/entry>\n/g' | grep "<entry>" |wc -l
