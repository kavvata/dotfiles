if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting ""
    set -gx EDITOR nvim

    zoxide init fish | source
end
