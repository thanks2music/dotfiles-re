# 補完機能有効
fpath=($HOME/.zsh/completion ${fpath})
autoload -U compinit
compinit

# 256色
export TERM=xterm-256color

# 文字コードの設定
export LANG=ja_JP.UTF-8

# PATH
# PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
# Homebrewのインストールディレクトリを変更
export XDG_CONFIG_HOME=$HOME/.vim
# NeoVimの環境変数
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
# Vimでクリップボードを使えるようにする
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/man:$MANPATH
export PATH="$HOME/bin:$PATH"
export FDK_EXE=$HOME/Library/FDK/Tools/osx
export PATH=$FDK_EXE:$PATH

if [ -d /usr/local/Cellar/coreutils ]; then
  PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

if [ -d /usr/local/Cellar/gnu-sed ]; then
  PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
  MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
fi

if [ -d ${HOME}/.anyenv ] ; then
  PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  for D in `find $HOME/.anyenv/envs -maxdepth 1 -type d`; do
    PATH="$D/shims:$PATH"
  done
fi

if [ -d /usr/local/heroku ] ; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

if [ -d /usr/local/opt/android-sdk ] ; then
  export ANDROID_HOME=/usr/local/opt/android-sdk
fi

# android sdks
if [ -d /Applications/android-sdk-macosx ]; then
  PATH="/Applications/android-sdk-macosx/tools:$PATH"
fi

# vim
if [ -d $HOME/Applications/MacVim.app ]; then
  export EDITOR=$HOME/Applications/MacVim.app/Contents/MacOS/Vim
  alias vim='$EDITOR "$@"'
  alias gvim='open -a $HOME/Applications/MacVim.app "$@"'
  alias vimdiff=$HOME/Applications/MacVim.app/Contents/MacOS/vimdiff
fi

# Go
export GOPATH=$HOME/go
export GO15VENDOREXPERIMENT=1

# 関数
function find-grep { find . -name $1 -type f -print | xargs grep -n --binary-files=without-match $2 }
function find-sed { find . -name $1 -type f | xargs gsed -i $2 }

function extract {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.tar.xz)    tar xvJf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *.lzma)      lzma -dv $1    ;;
      *.xz)        xz -dv $1      ;;
      *)           echo "don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

function static-httpd {
  if type python > /dev/null; then
    if python -V 2>&1 | grep -qm1 'Python 3\.'; then
      python -m http.server 5000
    else
      python -m SimpleHTTPServer 5000
    fi
  elif type ruby > /dev/null; then
    if ruby -v | grep -qm1 'ruby 2\.'; then
      ruby -run -e httpd -- --port=5000 .
    else
      ruby -rwebrick -e 'WEBrick::HTTPServer.new(:Port => 5000, :DocumentRoot => ".").start'
    fi
  elif type node > /dev/null; then
    node -e "var c=require('connect'), d=process.env.PWD; c().use(c.logger()).use(c.static(d)).use(c.directory(d)).listen(5000);"
  fi
}

function grep-git-files {
  [ $@ ] && git ls-files -z | xargs -0 ag --pager="less -R --no-init --quit-if-one-screen" --smart-case $@
}

function move-to-ghq-directory {
  local p="$(ghq list | peco --select-1)"
  [ $p ] && cd $(ghq root)/$p
}

function edit-grepped-file {
  if [ $@ ]; then
    local s="$(grep-git-files $@ | peco --select-1)"
    [ $s ] && shift $# && vim +"$(echo $s | cut -d : -f2)" "$(echo $s | cut -d : -f1)"
  fi
}


# エイリアスの設定
alias ll='ls -l'
alias la='ls -A'
alias lal='ls -l -A'

## Env
alias v='vi'
alias vi='nvim'
alias vd='vimdiff'
alias t='tmux'
alias npm-exec='PATH=$(npm bin):$PATH'
alias search='ag -g . | ag '
alias b='bundle exec'
alias n='npm-exec'
alias dc='docker-compose'
alias r='rails'
alias reload='source ~/.zshrc && exec $SHELL'
alias nb='nodebrew'
## Git
alias g='git'
alias s='git status'
alias gs='git fetch'
alias gg='git grep'
alias ga='git add -A'
alias s='git status -s'
alias d='git diff'
alias gm= 'git co master'
alias gi='git'
alias gp='git pull --rebase'
alias gitrc='vi ~/.gitconfig'
alias gitclean='git fsck && git gc && git rup'
alias gv='edit-grepped-file'
## Rails
alias ms='yarn install && bundle install && bundle exec rake db:migrate && foreman start -f Procfile'
alias ms-reset='yarn && bundle && bin/rails world_db:structure:load db:seed:world && bin/rails item_db:structure:load db:seed:item && bin/rails db:setup && bin/rails s'
## Docker
alias docker-rm-all='docker rm $(docker ps -a -q)'
alias docker-rmi-all='docker rmi $(docker images -q)'
## rc
alias vimrc='vi ~/.vimrc'
alias zshrc='vi ~/.zshrc'
alias tmuxrc='vi ~/.tmux.conf'

# Cloud Functions
alias cf='command functions'

# 細かい設定
bindkey -e
fpath=(~/.zsh/functions/Completion ${fpath})

# シェルのプロセスごとに履歴を共有
setopt share_history

# 余分なスペースを削除してヒストリに記録する
setopt hist_reduce_blanks

# ヒストリにhistoryコマンドを記録しない
setopt hist_no_store

# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

# 行頭がスペースで始まるコマンドラインはヒストリに記録しない
setopt hist_ignore_space

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups

# 重複したヒストリは追加しない
setopt hist_ignore_all_dups

# cdのタイミングで自動的にpushd
setopt auto_pushd

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加
setopt append_history

# 補完候補が複数ある時に、一覧表示
setopt auto_list

# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示しない
setopt no_list_types

# 保管結果をできるだけ詰める
setopt list_packed

# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完
setopt auto_menu

# カッコの対応などを自動的に補完
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# ビープ音を鳴らさないようにする
setopt no_beep

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs

# 8 ビット目を通すようになり、日本語のファイル名を表示可能
setopt print_eight_bit
setopt correct
setopt noautoremoveslash
setopt nolistbeep
setopt EXTENDED_HISTORY
setopt complete_aliases

# プロンプトの設定
autoload -Uz vcs_info
autoload smart-insert-last-word
autoload -U compinit; compinit
autoload zed
autoload zmv
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats '[%s: %b]'
zstyle ':vcs_info:*' actionformats '[%s: %b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true
ZSHFG=`expr $RANDOM / 128`

function precmd {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"

  if [ $ZSHFG -ge 250 ]; then
    ZSHFG=0
  fi

  ZSHFG=`expr $ZSHFG + 10`
  RPROMPT="%1(v|%F{$ZSHFG}%1v%f|)"
}

## Default shell configuration
# colors enables us to idenfity color by $fg[red].
autoload colors
colors
case ${UID} in
0)
    PROMPT="🍻 %B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="🍻 %B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="🍻 %{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
*)
    #
    # Color
    #
    DEFAULT=$'%{\e[1;0m%}'
    RESET="%{${reset_color}%}"
    GREEN="%{${fg[green]}%}"
    BLUE="%{${fg[blue]}%}"
    RED="%{${fg[red]}%}"
    CYAN="%{${fg[cyan]}%}"
    WHITE="%{${fg[white]}%}"
    POH="🚬 $"

    #
    # Prompt
    #
    PROMPT='☕ %{$fg_bold[blue]%}${USER}@%m ${RESET}${WHITE}${POH} ${RESET}'
    RPROMPT='${RESET}${WHITE}[${BLUE}%(5~,%-2~/.../%2~,%~)% ${WHITE}]${RESET}'

    #
    # Vi入力モードでPROMPTの色を変える
    # http://memo.officebrook.net/20090226.html
    function zle-line-init zle-keymap-select {
      case $KEYMAP in
        vicmd)
        PROMPT="☕ %{$fg_bold[cyan]%}${USER}@%m ${RESET}${WHITE}${POH} ${RESET}"
        ;;
        main|viins)
        PROMPT="☕ %{$fg_bold[blue]%}${USER}@%m ${RESET}${WHITE}${POH} ${RESET}"
        ;;
      esac
      zle reset-prompt
    }
    zle -N zle-line-init
    zle -N zle-keymap-select

    # Show git branch when you are in git repository
    # http://d.hatena.ne.jp/mollifier/20100906/p1

    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git svn hg bzr
    zstyle ':vcs_info:*' formats '(%s)-[%b]'
    zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
    zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
    zstyle ':vcs_info:bzr:*' use-simple true

    autoload -Uz is-at-least
    if is-at-least 4.3.10; then
      # この check-for-changes が今回の設定するところ
      zstyle ':vcs_info:git:*' check-for-changes true
      zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
      zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
      zstyle ':vcs_info:git:*' formats '(%s)-[%c%u%b]'
      zstyle ':vcs_info:git:*' actionformats '(%s)-[%c%u%b|%a]'
    fi

    function _update_vcs_info_msg() {
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        psvar[2]=$(_git_not_pushed)
        [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    }
    add-zsh-hook precmd _update_vcs_info_msg

    # show status of git pushed to HEAD in prompt
    function _git_not_pushed()
    {
      if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
        head="$(git rev-parse HEAD)"
        for x in $(git rev-parse --remotes)
        do
          if [ "$head" = "$x" ]; then
            return 0
          fi
        done
        echo "|?"
      fi
      return 0
    }

    # git のブランチ名 *と作業状態* を zsh の右プロンプトに表示＋ status に応じて色もつけてみた - Yarukidenized:ヤルキデナイズド :
    # http://d.hatena.ne.jp/uasi/20091025/1256458798
    autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

    function rprompt-git-current-branch {
      local name st color gitdir action pushed
      if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
              return
      fi

      name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
      if [[ -z $name ]]; then
              return
      fi

      gitdir=`git rev-parse --git-dir 2> /dev/null`
      action=`VCS_INFO_git_getaction "$gitdir"` && action="|$action"
      pushed="`_git_not_pushed`"

      st=`git status 2> /dev/null`
      if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
        color=%F{green}
      elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
        color=%F{yellow}
      elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
        color=%B%F{red}
      else
        color=%F{red}
      fi

      echo "[$color$name$action$pushed%f%b]"
    }

    RPROMPT='`rprompt-git-current-branch`${RESET}${WHITE}[${BLUE}%(5~,%-2~/.../%2~,%~)${WHITE}]${RESET}'

    ;;
esac

# 補完設定
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000


# 補完するかの質問は画面を超える時にのみに行う｡
LISTMAX=0

# sudo でも補完の対象
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# Ctrl+wで､直前の/までを削除する｡
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# ディレクトリを水色にする｡
export LS_COLORS='di=01;36'

# ファイルリスト補完でもlsと同様に色をつける｡
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# cd をしたときにlsを実行する
function chpwd() { ls }

# ディレクトリ名だけで､ディレクトリの移動をする｡
setopt auto_cd

# C-s, C-qを無効にする。
setopt no_flow_control

# パラメタは1/100秒単位で指定する。デフォルトは0.4秒なので、これを短くする
KEYTIMEOUT=1

# C-p C-n でコマンド履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# tmuxの自動起動
# http://d.hatena.ne.jp/tyru/20100828/run_tmux_or_screen_at_shell_startup
is_screen_running() {
    # tscreen also uses this varariable.
    [ ! -z "$WINDOW" ]
}
is_tmux_runnning() {
    [ ! -z "$TMUX" ]
}
is_screen_or_tmux_running() {
    is_screen_running || is_tmux_runnning
}
shell_has_started_interactively() {
    [ ! -z "$PS1" ]
}
resolve_alias() {
    cmd="$1"
    while \
        whence "$cmd" >/dev/null 2>/dev/null \
        && [ "$(whence "$cmd")" != "$cmd" ]
    do
        cmd=$(whence "$cmd")
    done
    echo "$cmd"
}

if ! is_screen_or_tmux_running && shell_has_started_interactively; then
    for cmd in tmux tscreen screen; do
        if whence $cmd >/dev/null 2>/dev/null; then
            $(resolve_alias "$cmd")
            break
        fi
    done
fi

# ローカルの .zshrc を読み込む
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# PATH の重複を消す
typeset -U path PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yito/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/yito/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yito/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/yito/google-cloud-sdk/completion.zsh.inc'; fi
