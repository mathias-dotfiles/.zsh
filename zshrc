### Variable Declarations and Properties
export CLICOLOR=1
export COLORTERM=truecolor
export PMPT_TYPE='detailed'
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
PMPT_STATUS='%(?.%B%F{034}✔%f%b.%B%F{196}✘%f%b) '
if [[ -n "${SSH_CONNECTION}" ]]; then 
    PMPT_DETAILED_STATUS="${PMPT_STATUS}%B%F{120}%m %f%b "
    PMPT_MIN_STATUS="${PMPT_STATUS}%B%F{120} %f%b "
fi

PMPT_CURRENT_DIR='in %2~' 
if [[ $EUID -eq 0 ]]; then
  PMPT_USER='%B%F{160} root%f%b ' 
  PMPT_MIN_USER="${PMPT_USER} "
  PMPT_IS_PRIVILEGED='%B%F{196}%f%b '  # icon for root, red color
  PMPT_MIN_IS_PRIVILEGED=PMPT_IS_PRIVILEGED  # icon for root, red color
else
  PMPT_USER='%F{136}%n%f '
  PMPT_MIN_USER="${PMPT_USER}"
  PMPT_IS_PRIVILEGED='%B%F{033}>> %f%b'
  PMPT_MIN_IS_PRIVILEGED='%B%F{033}> %f%b'
fi


function pmpt_clean() {
    PROMPT="${PMPT_MIN_STATUS}${PMPT_MIN_USER}${PMPT_MIN_IS_PRIVILEGED}"
    RPROMPT=''
}

function pmpt_detailed() {
    PROMPT="${PMPT_DETAILED_STATUS}${PMPT_USER}${PMPT_CURRENT_DIR} ${PMPT_IS_PRIVILEGED}"
    RPROMPT='%{$(vcs_info)%}${vcs_info_msg_0_}'
}

function pmpt_minimal() {
    PROMPT='%B%F{033}>> %f%b'
    RPROMPT=''
}


if [[ "$PMPT_TYPE" == "clean" ]]; then
    pmpt_clean
elif [[ "$PMPT_TYPE" == "detailed" ]]; then
    pmpt_detailed
elif [[ "$PMPT_TYPE" == "minimal" ]]; then
    pmpt_minimal
fi

### END ZSH Prompt

### Navigation
#
### END Navigation

# Load custom scripts
if [ -d "$HOME/.zsh/custom" ]; then
  for f in "$HOME"/.zsh/custom/*.sh; do
    [ -f "$f" ] || continue    # skip if no match
    echo "Loading custom zsh script: $f"
    source "$f"
  done
  if [ -d "$HOME/.zsh/custom/personalized" ]; then
    for f in "$HOME"/.zsh/custom/personalized/*.sh; do
      [ -f "$f" ] || continue    # skip if no match
      echo "Loading custom zsh script: $f"
      source "$f"
    done
  fi
fi

### Aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.zsh/aliases ] && source ~/.zsh/aliases

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias ls='ls --color=auto'
    alias ll='ls -lah --color=auto' 
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='ls -G'
    alias ll="ls -l -G"
fi
alias rsudo='eval "sudo $(history | tail -n 1 | cut -c 8-)"'
### END Aliases

export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
fi

if [[ -s "$NVM_DIR/bash_completion" ]]; then
  source "$NVM_DIR/bash_completion"
fi

### PATH CONFIG 
export PATH=$PATH:$HOME/.local/bin
### END PATH CONFIG
