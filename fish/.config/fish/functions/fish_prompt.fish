function fish_prompt
    set -l last_status $status

    # Prevent Python venv from overriding custom prompt settings
    if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end

    # --- Line 1: ┌─[user@host]-(cwd)(git:branch) ---
    echo
    set_color blue
    printf '┌─['

    set_color --bold
    printf '%s' $USER
    set_color --reset

    printf '@'

    set_color green
    printf '%s' (prompt_hostname)
    set_color --reset

    set_color blue
    printf ']-('
    set_color --reset

    # Standard Fish path behavior (prompt_pwd)
    set_color $fish_color_cwd
    printf '%s' (prompt_pwd --full-length-dirs=2 --dir-length=3)
    set_color --reset

    set_color blue
    printf ') '
    set_color --reset

    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set_color magenta
        printf '(git: %s)' (fish_git_prompt "%s")
        set_color --reset
    end

    # --- Line 2: └─[Time]-(exit_status)-[$]- ---
    echo
    set_color blue
    printf '└─['

    set_color yellow
    printf '%s' (date +%T)
    set_color blue
    printf ']-('

    if test $last_status -eq 0
        set_color green
    else
        set_color red
    end
    printf '%d' $last_status

    set_color blue
    printf ')-['

    if fish_is_root_user
        set_color red
        printf '#'
    else
        set_color green
        printf '$'
    end

    set_color blue
    printf '] '
    set_color --reset
end