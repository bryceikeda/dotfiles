autoload -Uz vcs_info

# Set vcs_info parameters
#
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' formats "$FX[bold]%r$FX[no-bold]/%S" "%s/%b" "%%u%c"
zstyle ':vcs_info:*:*' actionformats "$FX[bold]%r$FX[no-bold]/%S" "%s/%b" "%u%c (%a)"
zstyle ':vcs_info:*:*' nvcsformats "%~" "" ""

# Display information about the current repository
#
repo_information() {
  vcs_info # Get version control info before we start outputting stuff
  echo "%F{94}${vcs_info_msg_0_%%/.}"
}

PROMPT='$(repo_information)$FX[bold]%F{94}$(git_prompt_info)%f$FX[no-bold] '

ZSH_THEME_GIT_PROMPT_PREFIX=" (%F{91}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{94}) %F{yellow}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{94})"
