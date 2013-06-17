ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="nebirhos"

#For Fcitx
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
#Emacs中使用fcitx
export LC_CTYPE="zh_CN.UTF-8"

export SHELL='zsh'
export TERM='screen-256color'
export BROWSER="firefox"
export EDITOR='vim'

# Using Vim as $MANPAGER
# http://zameermanji.com/blog/2012/12/30/using-vim-as-manpager/
# export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

#pkgfile helps you find cmd
source /usr/share/doc/pkgfile/command-not-found.zsh

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
archlinux
autojump
bundler
cp
gem
git
git-extra
ruby
rvm
rake
rails
systemd
vundle
pip
)

source $ZSH/oh-my-zsh.sh
#For rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM

#For virtualenv
export WORKON_HOME=$HOME/.virtualenvs

#For virtualenvwrapper
source /usr/bin/virtualenvwrapper.sh
export PIP_RESPECT_VIRTUALENV=true
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export VIRTUALENV_USE_DISTRIBUTE=1        # <-- Always use pip/distribute

#For metasploit
alias msfconcole='sudo systemctl start postgresql.service && cd /opt/metasploit && /opt/metasploit/metasploit -y database.yml'

#Personal Function
function ctags_with_dep(){
    # ./ctags_with_dep.sh file1.c file2.c ... to generate a tags file for these files.

    gcc -M $* | sed -e 's/[\\ ]/\n/g' | \
                 sed -e '/^$/d' -e '/\.o:[ \t]*$/d' | \
                 ctags -L - --c++-kinds=+p --fields=+iaS --extra=+q
}

function proxyon() {
    export http_proxy="http://127.0.0.1:8087"
    export https_proxy=$http_proxy
    export ftp_proxy="http//127.0.0.1:8087"
    echo -e "\nProxy environment variable enabled.\n"
}

function proxyoff() {
    export HTTP_PROXY=""
    export http_proxy=""
    export HTTPS_PROXY=""
    export https_proxy=""
    export FTP_PROXY=""
    export ftp_proxy=""
    echo -e "\nProxy environment variable removed.\n"
}

function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

##在命令前插入sudo
##定义功能
sudo-command-line() {
   [[ -z $BUFFER ]] && zle up-history
   [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
   zle end-of-line                 #光标移动到行末
}
zle -N sudo-command-line
#定义快捷键为： [Esc] [Esc]
bindkey "\e\e" sudo-command-line

#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS
#相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS
#在命令前添加空格，不将此命令添加到纪录文件中
setopt HIST_IGNORE_SPACE

HISTSIZE=5000

#路径别名
hash -d P="/home/tacey/Downloads/Yunio/octopress/source/_posts/"
hash -d N="/home/tacey/Dropbox/Notes"

#文件关联
alias -s png=ristretto
alias -s jpg=ristretto
alias -s pdf=zathura
alias -s zip=xarchiver
alias -s ape=mocp
alias -s ape=mocp
alias -s mp3=mocp
alias -s wma=mocp
alias -s mp4=vlc
alias -s flv=vlc

#For colorize cmd
alias ls="ls -AlF --color --time-style=long-iso"
#alias ls="ls --color=auto -l -h -a"
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#For colorize manpages
#export PAGER='most'
#For LS_COLOR
eval $(dircolors -b $HOME/.dircolors)

alias downit="wget -c -r -p -np -k "
alias winxp="vboxmanage  startvm xp"
alias t="tmux"
alias m="mutt"
# alias e="emacs -nw"
alias english="vim /home/tacey/Dropbox/Word/13.3.26.md"
alias e="emacsclient -t"
alias ec="emacsclient -c"
alias vi="emacsclient -t"

# try loading .rvmrc, add it below the line loading RVM
#cd ..;1
cd .
PATH=$PATH:$HOME/.rvm/bin:/opt/metasploit # Add RVM to PATH for scripting

# For C core dump
ulimit -c unlimited
