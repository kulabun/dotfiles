#!/usr/bin/env fish

function polybar-reload
 polybar --config="/data/dotfiles/config/polybar/config" openbox-bar --reload & disown
end
