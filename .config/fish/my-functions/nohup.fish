#!/usr/bin/env fish

function nohup
    command nohup $argv </dev/null >/dev/null 2>&1 & disown
end
