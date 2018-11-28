function pass
    set -l fzf_args ""
    test (count $argv) -gt 0; test -n "$argv[1]"; and set fzf_args "-q $argv"
    set -l target (gopass ls --flat | fzf $fzf_args)
    [ -n "$target" ]; and gopass --clip $target
end
