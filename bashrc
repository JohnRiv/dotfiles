# aliases
alias be='bundle exec'
alias cdp='cd ~/projects/'
alias la='ls -laG'
alias lh='ls -laGh'
alias ll='ls -lG'
alias pys='python -m SimpleHTTPServer'
alias gulpdebug='node --inspect --debug-brk node_modules/gulp/bin/gulp.js'
alias gruntdebug='node --inspect --debug-brk node_modules/grunt/lib/grunt.js'
alias nodedebug='node --inspect --debug-brk'

# git & svn functions
function parse_git_in_rebase {
  [[ -d .git/rebase-apply ]] && echo " REBASING"
}

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}

function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " ("${ref#refs/heads/}$(parse_git_dirty)$(parse_git_in_rebase)")"
}

function parse_svn_repo {
  info=$(svn info 2> /dev/null) || return
  root=$(echo $info | sed -e 's/^.*Repository Root: //g' -e 's,.*/,,g' -e 's/ .*//g')
  revision=$(echo $info | sed -e 's/^.*Revision: //g' -e 's/ .*//g')
  echo " ($root:$revision)"
}

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NORMAL="\[\033[0m\]"
PINK="\033[35m\]"

export PS1="\n$YELLOW\w:$GREEN\$(parse_git_branch)\$(parse_svn_repo)\n$RED$ $NORMAL"

function gitresume {
  git reset --soft HEAD^
  git reset .
  git status
}
