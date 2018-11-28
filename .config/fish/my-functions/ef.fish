function ef
    set -l func_file_path "$FISH_CUSTOM_FUNCTIONS_PATH"/"$argv[1].fish"
    eval $EDITOR "$func_file_path" 
    source "$func_file_path"
end

complete -e -c ef
complete -c ef -d "Custom Function" -a "(ls \"$FISH_CUSTOM_FUNCTIONS_PATH\"/*.fish | sed 's/.*&lt;\(.*\)>/\1/' | xargs -n 1 basename | cut -d'.' -f1)" --no-files
