# Use cat if bat is not installed
if not type -q bat
  set fzf_preview_file_cmd cat
end

# Use eza if possible
if type -q eza
  set fzf_preview_dir_cmd eza --all --color=always
end

# FZF Show hidden files except some directories
set fzf_fd_opts --hidden --exclude=.git --exclude=.cache

# FZF keybindings
if type -q fzf_configure_bindings
  fzf_configure_bindings \
    --git_log=\cg \
    --git_status=\cs \
    --variables=\ce \
    --directory=\cf \
    --history=\ch
end
