function batman --wraps=man --description 'wrapper function for printing man pages with bat'
    man $argv | bat -l man --decorations never

end
