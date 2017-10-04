PROMPT=$'%(!:%{$fg_bold[red]%}:%{$fg_bold[green]%})%n@%m %{$fg_no_bold[red]%}%D{[%I:%M:%S]} %{$fg_no_bold[cyan]%}%3~ %{$fg_no_bold[blue]%}%(1j:(%j %(2j:jobs:job)%) :)$(git_prompt_info)\
%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[yellow]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[yellow]%}] %{$fg_bold[red]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[yellow]%}] %{$fg_no_bold[green]%}✓"
