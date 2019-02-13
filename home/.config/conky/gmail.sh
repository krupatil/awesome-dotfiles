#!/bin/bash

curl -u krunal9091@gmail.com:<password> https://mail.google.com/mail/feed/atom/unread | sed 's/<\/entry>/<\/entry>\n/g' | grep "<entry>" |wc -l
#curl -u krunal.patil@smartthings.com:krunal.patil https://mail.google.com/mail/feed/atom/unread | sed 's/<\/entry>/<\/entry>\n/g' | grep "<entry>" |wc -l
