function source_if_exists
  set -l file $argv[1]
  test -f $file; and source $file > /dev/null 2> /dev/null or true
end

# linuxbrew
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx PATH ~/.linuxbrew/bin $PATH
