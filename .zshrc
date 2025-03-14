# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  spaceship-vi-mode
  zsh-syntax-highlighting # must be last
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.


# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[C' forward-word                       # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[D' backward-word                      # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[Z' undo                               # shift + tab undo last action

# Aliases
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Python alias python3
alias python="python3"
# py also alias python3
alias py="python3"

#----------
# Spaceship user defined custom
#----------

# just put an empty space so that I can get the prefix
spaceship_space() {
  # color doesnt matter
  spaceship::section::v4 --color "white" " "
}

spaceship_line_two() {
  # line two config of spaceship prompt
  # | languages
  spaceship::section::v4 --color "white" " ├──"
}

spaceship_line_three() {
  # line two config of spaceship prompt
  # | languages
  spaceship::section::v4 --color "white" " └──"
}

# Starship customisations
SPACESHIP_PROMPT_ORDER=(
  space
  user          # Username section
  host          # Hostname section
  time
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # new line
  line_two      # the line two thingy
  dir           # Current directory section
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  gcloud        # Google Cloud Platform section
  venv          # virtualenv section
  conda         # conda virtualenv section
  dotnet        # .NET section
  kubectl       # Kubectl context section
  terraform     # Terraform workspace section
  line_sep      # Line break
  line_three
  # battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

# SPACESHIP_RPROMPT_ORDER=(
#   time          # Time stamps section
# )

# NOT WORKING
# SPACESHIP_PROMPT_FIRST_PREFIX_SHOW="true"

# SPACESHIP_PROMPT_DEFAULT_PREFIX=""

# to remove the default one set last time
# or in other words, to confirm thr isnt one
SPACESHIP_CHAR_PREFIX=""
# changes the char symbol to be different
SPACESHIP_CHAR_SYMBOL="$ "
# specifically change the root one
# just changing charsymbol doesnt seem to work on root
SPACESHIP_CHAR_SYMBOL_ROOT="$ "
# for multiline commands
SPACESHIP_CHAR_SYMBOL_SECONDARY="> "

# time show config
SPACESHIP_TIME_SHOW="true"

# username show config
SPACESHIP_USER_SHOW="always"
SPACESHIP_USER_COLOR="blue"
# SPACESHIP_USER_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
SPACESHIP_USER_PREFIX="┌──("
# SPACESHIP_USER_SUFFIX=") "
SPACESHIP_USER_SUFFIX=""

SPACESHIP_HOST_SHOW="always"
SPACESHIP_HOST_COLOR="cyan"
SPACESHIP_HOST_PREFIX="@"
SPACESHIP_HOST_SUFFIX=") "

# SPACRESHIP_DIR_CONFIG
SPACESHIP_DIR_PREFIX="["
SPACESHIP_DIR_SUFFIX="] "
SPACESHIP_DIR_TRUNC_PREFIX="../"

# for venv
SPACESHIP_VENV_PREFIX='('
SPACESHIP_VENV_SUFFIX=')'

# Env variable config
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin:$HOME/.local/bin"
export PATH="$PATH:$HOME/dev_dependencies/flutter/bin"
export PATH="$PATH:$HOME/.local/share/bob/nvim-bin" # using bob to handle neovim versions (path is configured in mac, may or may not need to be changed in linux)

# ZVM (use to manage installations of zig)
export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

# evals
eval spaceship_vi_mode_enable # enable vi mode provided by spaceship prompt
