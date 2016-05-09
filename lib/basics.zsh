# vim: ft=zsh sw=4 fdm=marker path+=~/bin,~/src/unistra/bin

setopt pathdirs # that's all we have for namespacing
setopt multios  # built-in tee
setopt rcquotes # reduce quoting hell
setopt braceccl
setopt histsubstpattern
setopt globstarshort

# make extendedglob work in strict mode
setopt extendedglob
declare -g MATCH MBEGIN MEND

LAST_ERROR=${LAST_ERROR-}
warn     () { LAST_ERROR=$?; print -u2 "$*"; return $LAST_ERROR }
die      () { LAST_ERROR=$?; print -u2 "$*"; exit   $LAST_ERROR }

# $_ is already used and $REPLY is sooo boring ... we need another convention.
# '$it' comes from groovy
declare -g it
alias %='for it'
alias %-='while {read it}'
alias @-='while {read -A argv}'
alias hush1='1>/dev/null'
alias hush2='2>/dev/null'
alias hush='&>/dev/null'
alias it1=': ${1:=$it}'

alias strict/on='setopt nounset warncreateglobal'
alias strict/off='setopt unset nowarncreateglobal'
alias strict/loff='setopt localoptions unset nowarncreateglobal'
forgive () { setopt localoptions unset nowarncreateglobal; "$@" }

alias error='warn "in $0 line $LINENO:"'
alias ...='{error Unimplemented; return 255}'
alias unreachable='{error Unreachable; return 255}'

alias l='print -l'
alias my@='declare -a'
alias my%='declare -A'

## () {return 5}
## warn "something's going wrong"
## print $?
