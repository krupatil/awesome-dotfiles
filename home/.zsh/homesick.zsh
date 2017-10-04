# Display message if homesick files more than a week old
now=$(date +%s)
fetch_head=~/.homesick/repos/dotfiles/.git/FETCH_HEAD
last_fetch=$(stat -c %Y $fetch_head 2>/dev/null || echo $now)
if [[ $((now - last_fetch)) -gt 604800 ]]
then
    echo "Your homesick repo is over a week old."
    echo "Please do an update at your earliest convenience."
fi

