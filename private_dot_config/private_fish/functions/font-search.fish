function font-search --wraps=fc-list --description 'fuzzy search installed fonts'
    fc-list -f '%{family}\t%{style}\n' \
        | sort -u \
        | fzf \
        | awk -F '\t' '{print $1}' \
        | wl-copy
end
