# Color
GREEN="%{$fg_bold[green]%}"
BLUE="%{$fg_bold[blue]%}"
RED="%{$fg_bold[red]%}"
YELLOW="%{$fg_bold[yellow]%}"
CYAN="%{$fg_bold[cyan]%}"
MAGENTA="%{$fg_bold[magenta]%}"
WHITE="%{$fg_bold[white]%}"
RESET="%{$reset_color%}"

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX="$YELLOW $CYAN"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" $RED✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" $GREEN✔"

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_ADDED="$GREEN+"
ZSH_THEME_GIT_PROMPT_MODIFIED="$BLUE!"
ZSH_THEME_GIT_PROMPT_DELETED="$RED-"
ZSH_THEME_GIT_PROMPT_RENAMED="$MAGENTA>"
ZSH_THEME_GIT_PROMPT_UNMERGED="$YELLOW#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="$CYAN?"

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD="$WHITE^"

# Directory info
# local current_dir='${PWD/#$HOME/~}'

function get_right_prompt() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ -z $(git_prompt_info) ]]; then
            echo -n "$BLUEdetached-head$RESET $(git_prompt_status)"
        else
            echo -n "$(git_prompt_info) $(git_prompt_status)|$WHITE$(git_prompt_short_sha)$RESET"
        fi
    else
        echo -n "$RESET"
    fi
}

function get_prompt() {
    RETVAL=$?
    if [[ "$UID" == 0 ]]; then
        DRAGON_PREFIX="$RED⬡"
    else
        DRAGON_PREFIX="$GREEN⬢"
    fi

    DRAGON_DATE="$CYAN%D{%FT%H:%M:%S%z}"
    DRAGON_USER="%n"
    DRAGON_SEPARATOR="$RESET@"
    DRAGON_MACHINE="$MAGENTA%m"
    DRAGON_DIRECTORY="$YELLOW%~"

    if [[ ${RETVAL} -ne 0 ]]; then
        DRAGON_PROMPT="$RED→ "
    else
        DRAGON_PROMPT="$CYAN→ "
    fi
    DRAGON_PROMPT="$DRAGON_PROMPT$RESET"
    
    echo "$DRAGON_PREFIX $DRAGON_USER$DRAGON_SEPARATOR$DRAGON_MACHINE: $DRAGON_DIRECTORY $DRAGON_DATE
$DRAGON_PROMPT"
}

PROMPT='$(get_prompt)'
RPROMPT='$(get_right_prompt)'

