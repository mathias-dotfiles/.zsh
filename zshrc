### Variable Declarations and Properties
export CLICOLOR=1
export COLORTERM=truecolor

### END Variables Declarations

### ZSH Options

# Enable vi mode
bindkey -v

setopt AUTO_CD
setopt EXTENDED_HISTORY

### End ZSH Options

### ZSH prompt
autoload -Uz vcs_info
setopt prompt_subst

precmd_vcs_info() { 
    VCS_STATUS=$(command git status --porcelain 2> /dev/null)
    if [[ -n $VCS_STATUS ]] then
        zstyle ':vcs_info:git:*' formats '%F{160}(%b)%f'
    else   
        zstyle ':vcs_info:git:*' formats '%F{034}(%b)%f'
    fi
    vcs_info
}

precmd_functions+=(precmd_vcs_info)

 
### Set up the prompt (with git branch name)

# Check if in a SSH Session and add Icon to prompt
PMPT_LAST_CMD_STATUS='%(?.%B%F{034}✔%f%b.%B%F{196}✘%f%b) '
PROMPT="${PMPT_LAST_CMD_STATUS}"
if [[ -n "$SSH_CONNECTION" ]]; && PROMPT="${PROMPT}%B%F{120}%m %f%b "
PMPT_CURRENT_DIR='in %2~' 
if [[ $EUID -eq 0 ]]; then
  PMPT_USER='%B%F{160} root%f%b ' 
  PMPT_IS_PRIVILEGED='%B%F{196}%f%b '  # icon for root, red color
else
  PMPT_USER='%F{136}%n%f ' 
  PMPT_IS_PRIVILEGED='%B%F{033}>> %f%b'
fi

PROMPT="${PROMPT}${PMPT_USER}${PMPT_CURRENT_DIR} ${PMPT_IS_PRIVILEGED}"
RPROMPT='$vcs_info_msg_0_'
### END ZSH Prompt


### Navigation
function prototype() {
    local prot_dir="$HOME/Documents/Carreira/Projetos/Desenvolvimento/Prototipos"
    if [ "$#" -lt 1 ]; then
        ls "$prot_dir"
    else
        cd "$prot_dir/$1"
    fi
}

function aulas() {
    cd "$HOME/Documents/Carreira/UESC/Aulas/$1"
}
### END Navigation


### Aliases
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias ls='ls --color=auto'
    alias ll='ls -lah --color=auto' 
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='ls -G'
    alias ll="ls -l -G"
fi
### END Aliases

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
