PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/X11R6/bin:/usr/local/sbin:/usr/local/bin
#TERM=xterm-color

INPUTRC=/etc/inputrc
PS1='\[\033[01;31m\]\H \[\033[01;34m\]\W \$ \[\033[00m\]'

PAGER=/usr/bin/more
EDITOR=vim

export PAGER EDITOR
export PATH INPUTRC
export PS1

export GREP_OPTIONS="--colour=auto"
export LANG=en_US.UTF-8

# some useful aliases
alias updatelocate='/usr/libexec/locate.updatedb'

alias su='su -m'
alias h='fc -l'
alias j=jobs
alias m=$PAGER
alias ll='ls -laFo'
alias lf='ls -FA'
alias l='ls -l'
alias g='egrep -i'
alias su="su -m"
alias lt='ls -lt $1 |head'

alias disksize='df -kh'
alias dirsize='du -h -d 1 .'
alias free='top -d1 | head -5 | tail -2'
alias showpath='echo $PATH | tr -s '':'' ''\\012'''
alias llc='echo Total number of files `ll | wc -l` in `pwd`'
alias psx="ps -auxw |grep $1"
alias javaps="/usr/local/jdk1.6.0/bin/jps -m"

# Colour code
# FILE-TYPE =fb
# where f is the foreground color
# b is the background color
# So to setup Directory color blue setup DIR to ex
# Default for all
# Color code (fb)
# a     black
# b     red
# c     green
# d     brown
# e     blue
# f     magenta
# g     cyan
# h     light grey
# A     bold black, usually shows up as dark grey
# B     bold red
# C     bold green
# D     bold brown, usually shows up as yellow
# E     bold blue
# F     bold magenta
# G     bold cyan
# H     bold light grey; looks like bright white
# x     default foreground or background
DIR=Ex
SYM_LINK=Gx
SOCKET=Fx
PIPE=dx
EXE=Cx
BLOCK_SP=Dx
CHAR_SP=Dx
EXE_SUID=hb
EXE_GUID=ad
DIR_STICKY=Ex
DIR_WO_STICKY=Ex
# Want to see fancy ls output? blank to disable it
ENABLE_FANCY="-F"

export LSCOLORS="$DIR$SYM_LINK$SOCKET$PIPE$EXE$BLOCK_SP$CHAR_SP$EXE_SUID$EXE_GUID$DIR_STICKY$DIR_WO_STICKY"

[ "$ENABLE_FANCY" == "-F" ] && alias ls='ls -GF' || alias ls='ls -G'

