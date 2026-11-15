# Load list of directories in ~/.pathrc, resolves ~ 
if test -f ~/.pathrc
    cat ~/.pathrc | while read -l p
        # Skip empty lines or comments
        if test -n "$p"; and not string match -q "#*" $p
            fish_add_path (eval echo $p) # eval echo expands ~ properly
        end
    end
end