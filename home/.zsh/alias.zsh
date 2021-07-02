#!/bin/sh

### Get os name via uname
_myos="$(uname)"

# Aliases
alias -- -='cd -'
alias .....='cd ../../../..'
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias ls='colorls'
alias j='autojump'
alias hr='hrs'
alias br='hr "*"'
alias bc='bc -l '
alias c='clear'
alias df='df -h'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias mkdir='mkdir -p'
alias myip='curl ifconfig.me'
alias q='exit'
alias screen='echo "Use tmux you dolt"; false'
alias su='sudo -i'
alias root='sudo -i'
alias h='hi'
alias j='jobs -l'
alias mount='mount |column -t'
alias sha1='openssl sha1'
alias diff='colordiff'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias terminal_color='wget -O gogh https://git.io/vQgMr && chmod +x gogh && ./gogh && rm gogh'
alias info='archey'
### Add safetry nets
# confirmation
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
# Parenting changing perms on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

### System memory related
## pass options to free
alias meminfo='free -m -l -t'
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
## get top process eating cpu
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
## Get server cpu info
alias cpuinfo='lscpu'
## older system use /proc/cpuinfo
alias cpuinfo='less /proc/cpuinfo'
## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
alias top='htop'


### Network alias
# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'
# Show open ports
alias ports='netstat -tulanp'

### Control firewall
## shortcut  for iptables and pass it via sudo#
alias ipt='sudo /sbin/iptables'
# display all rules #
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

### tmux alias
alias tmux='tmux -2'

### vim alias
alias vi='vim'
alias svi='sudo vi'
alias edit='vim'
alias vimupdate='vim +PlugUpgrade +PlugUpdate +qall'

### if user is not root, pass all commands via sudo #
if [ $UID -ne 0 ]; then
    alias reboot='sudo reboot'
fi

### add alias as per os using $_myos
case $_myos in
   Linux)
      alias la='\ls --color=auto -F -T 0 -A'
      alias ll='\ls --color=auto -F -T 0 -la'
      alias ls='ls --color=auto -F -T 0'
      alias lc="colorls"
      alias l.='ls -d .* --color=auto'
      alias apt-get='sudo apt-get'
      alias apt-list-installed='apt list --installed'
      ### Add safetry nets
      # do not delete / or prompt if deleting more than 3 files at a time
      # alias rm='rm -I --preserve-root'
      alias rm='trash-put'
      if [ $UID -ne 0 ]; then
         alias update='sudo apt-get update'
         alias upgrade='sudo apt-get upgrade'
      fi
      ;;
   Darwin)
      alias lc="colorls"
      ;;
   FreeBSD|OpenBSD)
      alias foo='/path/to/bsd/bin/foo'
      ;;
   SunOS)
      alias foo='/path/to/sunos/bin/foo'
      ;;
   *) ;;
esac

extract()
{
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}


### Generic git
alias git_authors='git-authors'
alias gitlog='git log --decorate --graph --abbrev-commit --date=relative'
alias gitcommit='git commit -s'
alias gits='git status'

### SmartThings git related
alias gith_clone_hub-core='git clone --recursive https://github.com/PhysicalGraph/hub-core'
alias gith_clone_cLib='git clone --recursive https://github.com/PhysicalGraph/cLib'
alias gith_clone_cLib-os='git clone --recursive https://github.com/PhysicalGraph/cLib-os'
alias gith_clone_executor-lib='git clone --recursive https://github.com/PhysicalGraph/executor-lib'
alias gith_clone_hub-ember='git clone --recursive https://github.com/PhysicalGraph/hub-ember'
alias gith_clone_hub-zipgateway='git clone --recursive https://github.com/PhysicalGraph/hub-zipgateway'
alias gith_clone_hub-s3-log-pusher='git clone --recursive https://github.com/PhysicalGraph/hub-s3-log-pusher'
alias gith_clone_hub-factory-reset-utils='git clone --recursive https://github.com/PhysicalGraph/hub-factory-reset-utils'
alias gith_clone_hubv2-os='git clone --recursive https://github.com/PhysicalGraph/hubv2-os'
alias gith_clone_hub-linux='git clone --recursive https://github.com/PhysicalGraph/hub-linux'
alias gith_clone_hub-uboot='git clone --recursive https://github.com/PhysicalGraph/hub-uboot'
alias gith_clone_imx_usb_loader='git clone --recursive https://github.com/PhysicalGraph/imx_usb_loader'
alias gith_clone_hub-v2-utils='git clone --recursive https://github.com/PhysicalGraph/hub-v2-utils'
alias gith_clone_hub-led-daemon='git clone --recursive https://github.com/PhysicalGraph/hub-led-daemon'
alias gith_clone_hub-ble='git clone --recursive https://github.com/PhysicalGraph/hub-ble'
alias gith_clone_hub-prod='git clone --recursive https://github.com/PhysicalGraph/hub-prod'
alias gith_clone_electronics='git clone --recursive https://github.com/PhysicalGraph/electronics'
alias gith_clone_hub-scripts='git clone --recursive https://github.com/PhysicalGraph/hub-scripts'

### Samsung git related
alias gitl_clone_hub-core='git clone --recursive https://git.vandevlab.com/iot-hub/hub-core'
alias gitl_clone_hub-ember='git clone --recursive https://git.vandevlab.com/iot-hub/hub-ember'
alias gitl_clone_hub-factory-reset-utils='git clone --recursive https://git.vandevlab.com/iot-hub/hub-factory-reset-utils'

### Misc alias 
alias weather='wego'
alias matrix='cmatrix'


