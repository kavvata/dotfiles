# Completions for nbdiff: nbdiff <base> <remote> [paths ...]
#   - base / remote (args 1-2): local git branches
#   - paths (arg 3+): tracked git files
#   - nothing is offered outside a git repository

function __nbdiff_in_git
    git rev-parse --git-dir >/dev/null 2>&1
end

function __nbdiff_branches
    git for-each-ref --format='%(refname:short)' refs/heads 2>/dev/null
end

function __nbdiff_tracked_files
    git ls-files -z 2>/dev/null | string split0
end

# Number of positional arguments typed so far (flags are skipped,
# and --out consumes its value)
function __nbdiff_pos
    set -l toks (commandline -opc)
    set -e toks[1]
    set -l count 0
    set -l i 1
    while test $i -le (count $toks)
        if not string match -q -- '-*' $toks[$i]
            set count (math $count + 1)
        else if test $toks[$i] = --out
            set i (math $i + 1)
        end
        set i (math $i + 1)
    end
    echo $count
end

# Inside a git repo: branches for args 1-2, tracked files from arg 3 on.
# -f suppresses the default path completion so only these are offered.
complete -c nbdiff -d 'base (local branch)' -f \
    -n '__nbdiff_in_git; and test (__nbdiff_pos) = 0' \
    -a '(__nbdiff_branches)'

complete -c nbdiff -d 'remote (local branch)' -f \
    -n '__nbdiff_in_git; and test (__nbdiff_pos) = 1' \
    -a '(__nbdiff_branches)'

complete -c nbdiff -d 'path (tracked git file)' -f \
    -n '__nbdiff_in_git; and test (__nbdiff_pos) -ge 2' \
    -a '(__nbdiff_tracked_files)'

# Outside a git repo: no completions at all (including the default paths)
complete -c nbdiff -f -n 'not __nbdiff_in_git'
