#!/usr/bin/env fish

function polybar-reload
 polybar --config="$HOME/.config/polybar/config" openbox-bar --reload & disown
end
