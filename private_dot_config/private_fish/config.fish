eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"
set -gx EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting ""
    source /home/linuxbrew/.linuxbrew/share/fish/vendor_completions.d/*
    zoxide init fish | source
    starship init fish | source
end

# uv
fish_add_path "/home/kav/.local/bin"
