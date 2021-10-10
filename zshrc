### Variable Declarations

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

 
# Set up the prompt (with git branch name)
PMPT_LAST_CMD_STATUS='%(?.%B%F{034}✔%f%b.%B%F{124}✘%f%b) '
PMPT_CURRENT_DIR='%F{136}%n%f in %2~' 
PMPT_IS_PRIVILEGED='%B%F{033}>> %f%b'

PROMPT='${PMPT_LAST_CMD_STATUS}${PMPT_CURRENT_DIR} ${PMPT_IS_PRIVILEGED}'
RPROMPT='$vcs_info_msg_0_'
### END ZSH Prompt

### Aliases

### END Aliases
