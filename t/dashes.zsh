# i don't use uze conventions in this test suite
# because we're testing things that must work in uze
#
# it's on your own to load devel/TAP functions in the main namespace.
# as example:

. ./TAP.zsh
. ./uze.zsh

for it ( ${(Mk)functions:#devel/TAP/*} )
    alias ${it/devel?TAP?/}=$it

dashes () {
    declare -a UZE_EXPORT
    declare -a UZE_ARGS

    uze/_set  symbols are here
    is "$UZE_EXPORT" "symbols are here" \
        "got symbols"
    (( $#UZE_ARGS    == 0 )); ok "no args"
    

    uze/_set  symbols are here -- extra --commands -- are there
    is "$UZE_EXPORT" "symbols are here" \
        "got symbols"  ||note "UZE_EXPORT: $UZE_EXPORT"
    is "$UZE_ARGS" "extra --commands -- are there" \
        "got commands" ||note "UZE_ARGS: $UZE_ARGS"

    uze/_set  -- extra --commands -- are there
    (( $#UZE_EXPORT  == 0 )); ok "no symbol to export"
    is "$UZE_ARGS" "extra --commands -- are there" \
        "got commands"

    uze/_set -- 
    (( $#UZE_EXPORT  == 0 )); ok "no symbol to export"
    (( $#UZE_ARGS    == 0 )); ok "no args"

}

prove dashes
