# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc


### EXPORT
export TERM="xterm-256color"                      # getting proper colors
export HISTCONTROL=ignoredups:erasedups           # no duplicate entries
export EDITOR="nvim"                              # $EDITOR use Neovim in terminal
export VISUAL="nvim"                              # $VISUAL use Neovim in GUI mode

### SET MANPAGER
### Uncomment only one of these!

### "nvim" as manpager
export MANPAGER="nvim +Man!"

### ARCHIVE EXTRACTION
# usage: ex <file>
function ex {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "ex: '$n' - unknown archive method"
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

# Better extraction
# extract() { ~/.local/bin/extract "$@"; }

# navigation
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}

# Function to make a directory and change into it
mcd() {
    mkdir -p "$1" && cd "$1" || return
}


# Function to navigate to predefined directories
goto() {
    case $1 in
        yt)
            cd ~/Videos/youtube/ || return
            ;;
    	code)
            cd ~/.gitlab/codechef-practice/problem-solutions || return
            ;;
        # Add more bookmarks here
        # example:
        # proj)
        #     cd ~/Projects/ || return
        #     ;;
        *)
            echo "Bookmark not found: $1"
            ;;
    esac
}

### ALIASES ###
# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# vim and emacs
alias v="nvim"

#alias whichGpu='glxinfo | egrep "OpenGL vendor|OpenGL renderer"'
alias whichGpu='glxinfo | grep -E "OpenGL vendor|OpenGL renderer"'
alias whichClass='xprop | grep "WM_CLASS"'

# Changing "cat" to "bat"
alias cat='bat --color=always'

# crontab
alias listCron='sudo crontab -u gideon -l'
alias listCronRoot='sudo crontab -u root -l'
alias editCron='sudo crontab -u gideon -e'
alias editCronRoot='sudo crontab -u root -e'
alias rmCron='sudo crontab -r -u gideon'
alias rmCronRoot='sudo crontab -r -u root'

alias sch='sudo find / -iname'

# Changing "ls" to "eza"
alias ls='eza -al --color=always --icons=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --icons=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --icons=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --icons=always --group-directories-first' # tree listing
alias l.='eza -al --color=always --icons=always --group-directories-first ../' # ls on the PARENT directory
alias l..='eza -al --color=always --icons=always --group-directories-first ../../' # ls on directory 2 levels up
alias l...='eza -al --color=always --icons=always --group-directories-first ../../../' # ls on directory 3 levels up

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# adding flags
alias df='df -h'               # human-readable sizes
alias free='free -m'           # show sizes in MB
alias grep='grep --color=auto' # colorize output (good for log files)

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# Merge Xresources
alias merge='xrdb -merge ~/.Xresources'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'  # 'status' is protected name so using 'stat' instead
alias tag='git tag'
alias newtag='git tag -a'

# mpv
alias playm4a='mpv *.m4a --no-audio-display'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

alias yta-grabber='yt-dlp --batch-file links.txt -S ext:m4a -x --embed-thumbnail --convert-thumbnail png -o "downloaded_audios/%(title)s.%(ext)s"'
alias rm-thumbnails='rm -rf .cache/thumbnails/'

### SETTING THE STARSHIP PROMPT ###
eval "$(starship init bash)"

### SETTING UP ZOXIDE CD COMMAND ###
eval "$(zoxide init bash)"
