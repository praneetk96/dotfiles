if status is-interactive
    # Commands to run in interactive sessions can go here
end

### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin  $HOME/.local/bin $fish_user_paths

### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set TERM "xterm-256color"                         # Sets the terminal type
set EDITOR nvim                                   # $EDITOR use Neovim in terminal
set VISUAL nvim                                   # $VISUAL use Neovim in GUI mode
set SUDO_EDITOR nvim

### SET MANPAGER
### Uncomment only one of these!

### "nvim" as manpager
set -x MANPAGER "nvim +Man!"

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### FUNCTIONS ###

# extract compressed files
# function extract
#     ~/.local/bin/extract $argv
# end

# mkdir and cd at the same time
function mcd
    mkdir -p "$argv[1]" && cd "$argv[1]"
end

# quickly cd to most used directory
function goto
    switch "$argv[1]"
        case "dots"
            cd ~/.git/dotfiles/
        case "yt"
            cd ~/Videos/youtube
        case "code"
            cd ~/.gitlab/codechef-practice/problem-solutions
        case '*'
            echo "Usage: goto {dots|yt|code|...}"
    end
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Function for copying files and directories, even recursively.
# ex: copy DIRNAME LOCATIONS
# result: copies the directory and all of its contents.
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | trim-right /)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

### END OF FUNCTIONS ###


### ALIASES ###
# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias v='nvim'

# Changing "ls" to "eza"
alias ls='eza -al --color=always --icons=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --icons=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --icons=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --icons=always --group-directories-first' # tree listing
alias l.='eza -a | egrep "^\."'
alias l.='eza -al --color=always --icons=always --group-directories-first ../' # ls on the PARENT directory
alias l..='eza -al --color=always --icons=always --group-directories-first ../../' # ls on directory 2 levels up
alias l...='eza -al --color=always --icons=always --group-directories-first ../../../' # ls on directory 3 levels up

#alias whichGpu='glxinfo | egrep "OpenGL vendor|OpenGL renderer"'
alias whichGpu='glxinfo | grep -E "OpenGL vendor|OpenGL renderer"'
alias whichClass='xprop | grep "WM_CLASS"'

# Changing "cat" to "bat"
alias cat='bat --color=always'

# crontab
alias editCron='crontab -e'
alias listCron='crontab -l'
alias editCronRoot='sudo crontab -u root -e'
alias listCronRoot='sudo crontab -u root -l'

#alias listCron='sudo crontab -u gideon -l'
#alias listCronRoot='sudo crontab -u root -l'
#alias editCron='sudo crontab -u gideon -e'
#alias editCronRoot='sudo crontab -u root -e'
alias rmCron='sudo crontab -r -u gideon'
alias rmCronRoot='sudo crontab -r -u root'

alias sch='sudo find / -iname'

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
alias tag='git tag'
alias newtag='git tag -a'

# mpv
alias playm4a='mpv *.m4a --no-audio-display'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# python apps (yt-dlp, gallery-dl,...)
alias yta-grabber='yt-dlp --batch-file links.txt -S ext:m4a -x --embed-thumbnail --convert-thumbnail png --cookies ~/.local/bin/brave-cookies.txt -o "downloaded_audios/%(title)s.%(ext)s"'
alias yt-upd='python3 -m pip install -U "yt-dlp[default]"'
alias gallery-upd='python3 -m pip install -U "gallery-dl[default]"'

# IMP
alias install-nvidia='sudo dnf install kernel-devel akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-libs.i686'
alias rm-nvidia='sudo dnf remove kernel-devel akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-libs.i686'
alias install-bspwm='sudo dnf install bspwm sxhkd polybar picom nitrogen xfce4-terminal rofi dmenu dunst redshift redshift-gtk lxappearance lxsession lxappearance xfce4-volumed'
alias rm-bspwm='sudo dnf remove bspwm sxhkd polybar picom nitrogen xfce4-terminal rofi dmenu dunst redshift redshift-gtk lxappearance lxsession lxappearance xfce4-volumed'

alias install-kde='sudo dnf group install kde-apps kde-desktop kde-education kde-media kde-office kde-pim kde-software-development kde-spin-initial-setup && sudo dnf install plasma-workspace-x11'
alias rm-kde='sudo dnf group remove kde-apps kde-desktop kde-education kde-media kde-office kde-pim kde-software-development kde-spin-initial-setup && sudo dnf remove plasma-workspace-x11'

alias install-budgie='sudo dnf group install budgie-desktop budgie-desktop-apps; sudo dnf remove plasma-discover'
alias rm-budgie='sudo dnf group remove budgie-desktop budgie-desktop-apps; sudo dnf remove plasma-discover'

alias install-gnome='sudo dnf group install workstation-product gnome-desktop gnome-games; sudo dnf install gnome-tweaks gnome-session-xsession'
alias rm-gnome='sudo dnf group remove workstation-product gnome-desktop gnome-games; sudo dnf remove gnome-tweaks gnome-session-xsession'

alias install-xmonad='sudo dnf install arandr dmenu dunst ghc-xmonad ghc-xmonad-contrib ghc-xmonad-contrib-devel ghc-xmonad-contrib-doc ghc-xmonad-doc lxappearance lxsession nitrogen picom rofi stalonetray xfce4-power-manager xfce4-volumed xmobar xmonad xmonad-basic xmonad-config xmonad-core'
alias rm-xmonad='sudo dnf remove arandr dmenu dunst ghc-xmonad ghc-xmonad-contrib ghc-xmonad-contrib-devel ghc-xmonad-contrib-doc ghc-xmonad-doc lxappearance lxsession nitrogen picom rofi stalonetray xfce4-power-manager xfce4-volumed xmobar xmonad xmonad-basic xmonad-config xmonad-core'

alias install-qtile='sudo dnf install dmenu dunst lxappearance lxsession nitrogen picom qtile qtile-extras qtile-wayland rofi xfce4-power-manager xfce4-volumed lxpolkit redshift redshift-gtk arandr'
alias rm-qtile='sudo dnf remove dmenu dunst lxappearance lxsession nitrogen picom qtile qtile-extras qtile-wayland rofi xfce4-power-manager xfce4-volumed lxpolkit redshift redshift-gtk arandr'

alias install-hyprland='sudo dnf install hypridle hyprland hyprland-devel hyprland-qt-support hyprland-qtutils hyprlock hyprpaper hyprpicker hyprpolkitagent hyprsunset hyprsysteminfo mako qt5-qtwayland qt6-qtwayland sddm swaybg waybar waypaper wofi rofi wlogout clipse foot fzf chafa jq grim hyprshot SwayNotificationCenter'
alias rm-hyprland='sudo dnf remove hypridle hyprland hyprland-devel hyprland-qt-support hyprland-qtutils hyprlock hyprpaper hyprpicker hyprpolkitagent hyprsunset hyprsysteminfo mako qt5-qtwayland qt6-qtwayland sddm swaybg waybar waypaper wofi rofi wlogout clipse foot fzf chafa jq grim hyprshot SwayNotificationCenter'

alias install-gaming='sudo dnf install steam lutris wine q4wine gamescope goverlay protontricks umu-launcher'
alias rm-gaming='sudo dnf remove steam lutris wine q4wine gamescope goverlay protontricks umu-launcher'

alias mpvtest='mpv --hwdec=auto --hwdec-codecs=all'
alias rm-thumbnails='rm -rf .cache/thumbnails/'

### SETTING THE STARSHIP PROMPT ###
starship init fish | source

### SETTING UP ZOXIDE CD COMMAND ###
zoxide init fish | source

### AFETCH ###
afetch
