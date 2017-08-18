
fish_vi_key_bindings

set -x FZF_FIND_FILE_COMMAND "rg --files"
# These had been set by .bashrc
set -u FZF_DEFAULT_COMMAND
set -u FZF_CTRL_T_COMMAND

function fish_user_key_bindings
  # sane control-d
  bind \cd kill-line
  bind -M insert \cd kill-line
  bind -M visual \cd kill-line

  # hitting right to accept is annoying
  bind -M insert \cl accept-autosuggestion
  bind -M visual \cl accept-autosuggestion

  # bash style up/down history
  bind -M insert \ck history-search-backward
  bind -M insert \cj history-search-forward

  bind -M insert \ct '__fzf_find_file'
  bind -M insert \cd '__fzf_cd'
  bind -M insert \cr '__fzf_reverse_isearch'
end


