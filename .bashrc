# enable color support of ls and also add handy aliases
alias ls='ls -hGFp'
alias dir='ls -hGFp'
alias vdir='ls -hGFp'
alias g='git'
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl" 

complete -o default -o nospace -F _git g
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export DBUSER=root
export DBPASS=
export PGHOST=localhost
#eval "$(gh alias -s)"
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PATH=$PATH:$HOME/.rvm/bin:/opt/local/bin:/opt/local/sbin:/Users/dancingbudha/.rvm/gems/ruby-2.0.0-p195/bin:/Users/dancingbudha/.rvm/gems/ruby-2.0.0-p195@global/bin:/Users/dancingbudha/.rvm/rubies/ruby-2.0.0-p195/bin:/Users/dancingbudha/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/Users/dancingbudha/.rvm/bin # Add RVM to PATH for scripting


###############################################################################
# IDENTIFICATION OF LOCAL HOST: CHANGE TO YOUR COMPUTER NAME
###############################################################################

PRIMARYHOST="localhost"


###############################################################################
# PROMPT
###############################################################################

###############################################################################
# Terminal Title

set_terminal_title() {
    if [[ -z $@ ]]
    then
        TERMINAL_TITLE=$PWD
    else
        TERMINAL_TITLE=$@
    fi
}
alias stt='set_terminal_title'
STANDARD_PROMPT_COMMAND='history -a ; echo -ne "\033]0;${TERMINAL_TITLE}\007"'
PROMPT_COMMAND=$STANDARD_PROMPT_COMMAND

###############################################################################
# Parses Git info for prompt

function _set_git_envar_info {
    GIT_BRANCH=""
    GIT_HEAD=""
    GIT_STATE=""
    GIT_LEADER=""
    local STATUS
    STATUS=$(git status 2> /dev/null)
    if [[ -z $STATUS ]]
    then
        return
    fi
    GIT_LEADER=":"
    GIT_BRANCH="$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
    GIT_HEAD=":$(git rev-parse --short HEAD)"
    if [[ "$STATUS" == *'working directory clean'* ]]
    then
        GIT_STATE=""
    else
        GIT_HEAD=$GIT_HEAD":"
        GIT_STATE=""
        if [[ "$STATUS" == *'Changes to be committed:'* ]]
        then
            GIT_STATE=$GIT_STATE'+I' # Index has files staged for commit
        fi
        if [[ "$STATUS" == *'Changed but not updated:'* || "$STATUS" == *'Changes not staged for commit'* ]]
        then
            GIT_STATE=$GIT_STATE"+M" # Working tree has files modified but unstaged
        fi
        if [[ "$STATUS" == *'Untracked files:'* ]]
        then
            GIT_STATE=$GIT_STATE'+U' # Working tree has untracked files
        fi
        GIT_STATE=$GIT_STATE''
    fi
    gdir=$(cd $GIT_ROOT; pwd -P)
    export gdir
}

###############################################################################
# Composes prompt.
function setps1 {

    # Help message.
    local USAGE="Usage: setps1 [none] [screen=] [user=] [dir=] [git=] [wrap=] [which-python=]"

    if [[ (-z $@) || ($@ == "*-h*") || ($@ == "*--h*") ]]
    then
        echo $USAGE
        return
    fi

    # Prompt colors.
    local CLEAR="\[\033[0m\]"
    #local STY_COLOR='\[\033[1;37;41m\]'
    local STY_COLOR='\[\033[1;33m\]'
    #local PROMPT_COLOR='\[\033[0;33m\]'
    local PROMPT_COLOR='\[\033[1;94m\]'
    local USER_HOST_COLOR='\[\033[1;30m\]'
    local PROMPT_DIR_COLOR='\[\033[1;94m\]'
    #local PROMPT_DIR_COLOR='\[\033[0;28m\]'
    local GIT_LEADER_COLOR='\[\033[1;30m\]'
    local GIT_BRANCH_COLOR=$CLEAR'\[\033[1;90m\]\[\033[4;90m\]'
    local GIT_HEAD_COLOR=$CLEAR'\[\033[1;32m\]'
    local GIT_STATE_COLOR=$CLEAR'\[\033[1;31m\]'

    # Hostname-based colors in prompt.
    if [[ $HOSTNAME != $PRIMARYHOST ]]
    then
        USER_HOST_COLOR=$REMOTE_USER_HOST_COLOR
    fi

    # Start with empty prompt.
    local PROMPTSTR=""

    # Set screen session id.
    if [[ $@ == *screen=1* ]]
    then
        ## Decorate prompt with indication of screen session ##
        if [[ -z "$STY" ]] # if screen session variable is not defined
        then
            local SCRTAG=""
        else
            local SCRTAG="$STY_COLOR(STY ${STY%%.*})$CLEAR" # get screen session number
        fi
    fi

    # Set user@host.
    if [[ $@ == *user=1* ]]
    then
         PROMPTSTR=$PROMPTSTR"$USER_HOST_COLOR\\u@\\h$CLEAR"
    fi

    # Set directory.
    if [[ -n $PROMPTSTR && ($@ == *dir=1* || $@ == *dir=2*) ]]
    then
            PROMPTSTR=$PROMPTSTR"$PROMPT_COLOR:"
    fi

    if [[ $@ == *dir=1* ]]
    then
        PROMPTSTR=$PROMPTSTR"$PROMPT_DIR_COLOR\W$CLEAR"
    elif [[ $@ == *dir=2* ]]
    then
        PROMPTSTR=$PROMPTSTR"$PROMPT_DIR_COLOR\$(pwd -P)$CLEAR"
    fi


    # set git
    if [[ $(which git 2> /dev/null) && $@ == *git=1* ]]
    then
        PROMPT_COMMAND=$PROMPT_COMMAND"; _set_git_envar_info"
        PROMPTSTR=$PROMPTSTR"$BG_COLOR$GIT_LEADER_COLOR\$GIT_LEADER$GIT_BRANCH_COLOR\$GIT_BRANCH$GIT_HEAD_COLOR\$GIT_HEAD$GIT_STATE_COLOR\$GIT_STATE$CLEAR"
        #PROMPTSTR=$PROMPTSTR"$GIT_LEADER_COLOR\$(_echo_git_envar_info)"
    else
        PROMPT_COMMAND=$STANDARD_PROMPT_COMMAND
    fi

    # Set wrap.
    if [[ $@ == *wrap=1* ]]
    then
        local WRAP="$CLEAR\n"
    else
        local WRAP=""
    fi

    # Set wrap.
    if [[ $@ == *which-python=1* ]]
    then
        local WHICHPYTHON="$CLEAR\n(python is '\$(which python)')$CLEAR\n"
    else
        local WHICHPYTHON=""
    fi

    # Finalize.
    if [[ -z $PROMPTSTR || $@ == none ]]
    then
        PROMPTSTR="\$ "
    else
        PROMPTSTR="$TITLEBAR\n$SCRTAG${PROMPT_COLOR}[$CLEAR$PROMPTSTR$PROMPT_COLOR]$WRAP$WHICHPYTHON$PROMPT_COLOR\$$CLEAR "
    fi

    # Set.
    PS1=$PROMPTSTR
    PS2='> '
    PS4='+ '
}

alias setps1-long='setps1 screen=1 user=1 dir=2 git=1 wrap=1'
alias setps1-short='setps1 screen=1 user=1 dir=1 git=1 wrap=0'
alias setps1-default='setps1-short'
alias setps1-plain='setps1 screen=0 user=0 dir=0 git=0 wrap=0'
alias setps1-nogit='setps1 screen=0 user=1 dir=1 git=0 wrap=0'
alias setps1-local-long='setps1 screen=1 user=0 dir=2 git=1 wrap=1'
alias setps1-local-short='setps1 screen=0 user=0 dir=1 git=1 wrap=0'
alias setps1-local='setps1-local-short'
alias setps1-dev-short='setps1 screen=0 user=0 dir=1 git=1 wrap=0 which-python=1'
alias setps1-dev-long='setps1 screen=0 user=1 dir=2 git=1 wrap=0 which-python=1'
alias setps1-dev-remote='setps1 screen=0 user=1 dir=1 git=1 wrap=0 which-python=1'
if [[ "$HOSTNAME" = "$PRIMARYHOST" ]]
then
    setps1 screen=0 user=0 dir=2 git=1 wrap=0 which-python=0
else
    setps1 screen=1 user=1 dir=2 git=1 wrap=0 which-python=0
fi

setps1 screen=0 user=0 dir=2 git=1 wrap=0 which-python=0

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
