declare -A UZE_TAGS_FOR

uze/_set () {
    local bound=$argv[(i)--]
    (( bound > $#argv )) && {
        UZE_EXPORT=("${(@)argv}")
        UZE_ARGS=()
        return
    }
    UZE_EXPORT=( "${argv[1,bound-1]}" ) 
    UZE_ARGS=( "${argv[bound+1,-1]}" )
}

uze () {
    declare -A UZE_TAGS
    declare -a UZE_EXPORT
    declare -a UZE_ARGS
    local __PACKAGE__=$1
    shift
    uze/_set "$@"
    autoload -z $__PACKAGE__.zsh
    $__PACKAGE__.zsh "${(@)UZE_ARGS}" || return

    local UZE_AS=${UZE_AS-}${UZE_AS+/}
    local k v
    for k v ( ${(kv)UZE_TAGS} ) UZE_TAGS_FOR[$1:$k]=$v
    #strict/loff # because $MATCH, $MEND $MBEGIN globally created there
    for k ( ${(us: :)UZE_EXPORT/(#m):*/${UZE_TAGS[$MATCH]}} )
        alias ${UZE_AS}$k=$__PACKAGE__/$k

}

: <<=cut

## Current namespace "::" alias

Namespaces doesn't exist for real in zsh so

    hello     () { print "i'm out" }
    thisLongJavaAlikeNS/hello () { print "i'm an insider" }
    thisLongJavaAlikeNS/greetings () { hello }

will print "i'm out" when "i'm an insider" would be generaly more useful.
so you can write

    thisLongJavaAlikeNS/greetings () { thehello }  

### Known problems

alias '::' uses $0 to find the name of your function so it will be broken if
you overwrite it.

=cut

∷ () { "$1/$2" "$@[3,-1]" }
alias ::='∷ ${0%/*}'

# foo/bar  () { :: note "$@" }
# foo/note () { for it { print -l "note: $it" } }
# foo/bar this is good 

# uze helpers :tag :tag func -- those are parameters for the init module
# uze/export :as h helpers:{tag,tag,sym}
