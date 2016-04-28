# todo: does basics must be removed ? 
. ./basics.zsh
. ./uze.zsh
. ./TAP.zsh

fpath+=${0%/*}

% ( ok prove is note )
    alias $it=devel/TAP/$it

load_module () {
    uze fake/module :hope test4 || print -l $fpath
    got="${(@Mk)aliases:#test?}"
    expected='test0 test1 test4'
    is "$got" $expected "exported symbols in main"
}

prove load_module
