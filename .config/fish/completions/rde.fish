function __fish_prog_needs_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq 1 -a $cmd[1] = 'rde' ]
        return 0
    end
    return 1
end

function __fish_prog_using_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq 2 ]
        if [ $argv[1] = $cmd[2] ]
            return 0
        end
    end
    return 1
end



complete -f -c rde -n '__fish_prog_needs_command' -a help --description 'Help about any command'

complete -f -c rde -n '__fish_prog_needs_command' -a definition --description 'Tools that help you manipulate the RDE definition.'
complete -f -c rde -n '__fish_prog_using_command definition' -a convert --description 'Converts an existing RDE definition from JSON to YAML form'
complete -f -c rde -n '__fish_prog_using_command definition' -a create --description 'Creates or updates a RDE definition.'
complete -f -c rde -n '__fish_prog_using_command definition' -a delete --description 'Deletes the existing RDE definition.'
complete -f -c rde -n '__fish_prog_using_command definition' -a show --description 'Shows the content of the current RDE definition file.'

complete -f -c rde -n '__fish_prog_needs_command' -a environment --description 'Tools that help you manipulate the local development environment.'
complete -f -c rde -n '__fish_prog_using_command environment' -a clean --description 'Removes RDE allocated resources (such as docker)'
complete -f -c rde -n '__fish_prog_using_command environment' -a setup --description 'Sets up the local development environment.'
complete -f -c rde -n '__fish_prog_using_command environment' -a validate --description 'Validates the local development environment.'

complete -f -c rde -n '__fish_prog_needs_command' -a stack --description 'Tools that help you manipulate the Personal Stack'
complete -f -c rde -n '__fish_prog_using_command stack' -a build --description 'Builds one or more applications from the Personal Stack'
complete -f -c rde -n '__fish_prog_using_command stack' -a exec --description 'Executes a command inside an application container from the Personal Stack'
complete -f -c rde -n '__fish_prog_using_command stack' -a provision --description 'Provisions one or more applications from the Personal Stack'
complete -f -c rde -n '__fish_prog_using_command stack' -a restart --description 'Restarts one or more applications from the Personal Stack'
complete -f -c rde -n '__fish_prog_using_command stack' -a show --description 'Shows info about the Personal Stack'
complete -f -c rde -n '__fish_prog_using_command stack' -a start --description 'Starts one or more applications from the Personal Stack'
complete -f -c rde -n '__fish_prog_using_command stack' -a stop --description 'Stops one or more applications from the Personal Stack'


complete -f -c rde -n '__fish_prog_needs_command' -a workflow --description 'Tools that help you automate your development workflow.'
complete -f -c rde -n '__fish_prog_using_command workflow' -a run --description 'Run a specific workflow or step.'
complete -f -c rde -n '__fish_prog_using_command workflow' -a show --description 'Show steps for a specific workflow.'
