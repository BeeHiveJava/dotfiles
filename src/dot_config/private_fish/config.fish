for file in $__fish_config_dir/custom.d/*.fish
  source $file
end

## Launch The Fuck
if type -q thefuck
  thefuck --alias | source
end
