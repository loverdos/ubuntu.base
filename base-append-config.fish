function source_if_exists
  set -l file $argv[1]
  test -f $file; and source $file > /dev/null 2> /dev/null or true
end

set -gx PATH ~/bin ~/.local/bin $PATH