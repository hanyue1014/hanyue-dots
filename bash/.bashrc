. ~/git-prompt.sh

alias l=ls
alias la=ls -a
alias ll=ls -la

exit_status_with_color() {
    local s=$?
    if (( s == 0 )); then
        printf '\001\e[38;5;82m\002%d' "$s"   # green
    else
        printf '\001\e[38;5;196m\002%d' "$s"  # red
    fi
}


# custom prompt ;) overrides all the above prompts (what is this monstrosity:- https://bash-prompt-generator.org/)
PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (git:%s)")'; PS1='\n\[\e[38;5;81m\]┌─[\[\e[0;1m\]\u\[\e[0m\]@\[\e[38;5;41m\]\H\[\e[38;5;81m\]]-\[\e[0m\](\w)${PS1_CMD1}\n\[\e[38;5;81m\]└─\[\e[38;5;214m\][\[\e[38;5;215m\]\T]\[\e[38;5;81m\]-($(exit_status_with_color)\[\e[38;5;81m\])-[\[\e[38;5;82m\]\\$\[\e[38;5;81m\]]\[\e[0m\] ' 
