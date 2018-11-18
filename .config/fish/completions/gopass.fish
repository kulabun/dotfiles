set PROG 'gopass'

function __fish_gopass_needs_command
  set -l cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = $PROG ]
    return 0
  end
  return 1
end

function __fish_gopass_uses_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

function __fish_gopass_print_entries
  gopass ls --flat
end

function __fish_gopass_print_entry_dirs
  for i in (gopass ls --flat)
    echo (dirname $i)
  end | sort -u
end

# erase any existing completions for gopass
complete -c $PROG -e
complete -c $PROG -f
complete -c $PROG -f -n '__fish_gopass_needs_command' -a "show copy move edit insert create new delete completion config fix fsck help generate grep init list sync templates update version" 
complete -c $PROG -f -n '__fish_gopass_needs_command' -a "(__fish_gopass_print_entries)"
complete -c $PROG -f -s c -l clip -r -a "(__fish_gopass_print_entries)"
complete -c $PROG -f -n '__fish_gopass_uses_command show' -r -a "(__fish_gopass_print_entries)"
complete -c $PROG -f -n '__fish_gopass_uses_command copy' -r -a "(__fish_gopass_print_entries)"
complete -c $PROG -f -n '__fish_gopass_uses_command move' -r -a "(__fish_gopass_print_entries)"
complete -c $PROG -f -n '__fish_gopass_uses_command edit' -r -a "(__fish_gopass_print_entries)"
complete -c $PROG -f -n '__fish_gopass_uses_command delete' -r -a "(__fish_gopass_print_entries)"
complete -c $PROG -f -n '__fish_gopass_uses_command insert' -r -a "(__fish_gopass_print_entry_dirs)"
complete -c $PROG -f -n '__fish_gopass_uses_command generate' -r -a "(__fish_gopass_print_entry_dirs)"
complete -c $PROG -f -n '__fish_gopass_uses_command list' -r -a "(__fish_gopass_print_entry_dirs)"

