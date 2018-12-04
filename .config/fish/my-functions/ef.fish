function ef
    set -l ENCRYPT_FILE "$HOME"/.yadm/encrypt

    # Validate function name provided
    test (count $argv) -eq 0; and echo "ERROR: function name required"; and return 1

    set -l name $argv[1]
    set -l class ""
    set -l suffix ""

    # Check if we have class for file (YADM)
    test (count $argv) -eq 2; and set -l class "$argv[2]"; and set -l suffix "##$class"

    set -l func_file_path "$FISH_CUSTOM_FUNCTIONS_PATH"/"$name.fish$suffix"

    eval $EDITOR "$func_file_path" 
    not test -e "$func_file_path"; and return 1;

    source "$func_file_path"
    yadm add "$func_file_path" 1>&2 2> /dev/null

    if [ "$class" = "work" ]
        if ! cat "$ENCRYPT_FILE" | grep "$func_file_path" > /dev/null
            echo "$func_file_path" | sed "s|$HOME/||" >> "$HOME"/.yadm/encrypt
        end
    end
end

complete -e -c ef
complete -c ef -d "Custom Function" -a "(ls \"$FISH_CUSTOM_FUNCTIONS_PATH\"/*.fish | sed 's/.*&lt;\(.*\)>/\1/' | xargs -n 1 basename | cut -d'.' -f1)" --no-files
