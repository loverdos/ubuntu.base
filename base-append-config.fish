# general
function have
  type -q $argv[1]
end

function PRINT_STDERR
  echo $argv 1>&2
end

function LOG
  status --is-interactive; and PRINT_STDERR $argv
end

alias ty type

function source_if_exists
  set -l file $argv[1]
  test -f $file; and source $file > /dev/null 2> /dev/null or true
end

# git
alias cst 'clear; git st'
abbr -a gd git diff
abbr -a clone git clone
abbr -a pull git pull
abbr -a fetch git fetch

function git-select-branch
  have fzy; and begin
    git checkout (git branch | cut -c 3- | fzy)
  end
end

function git-repack
  du -sh
  git repack -ad
  git gc
  du -sh
end

function github-get-latest-release
  set -l repo $argv[1]
  set -l url "https://api.github.com/repos/$repo/releases/latest"
  LOG $url
  curl --silent "$url" | jq -r '.tag_name'
end

set -gx PATH ~/bin ~/.local/bin $PATH