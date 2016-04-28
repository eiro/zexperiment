# expuze

this is an attempt to make zsh more perlish in a way we can load modules, write
test, use perldoc as documentation system. it could be a rewrite of
[uze](http://zsh-uze.github.io/) using instead of path.

the basics are

    path+=( ~/.zsh/bin )
    fpath+=( ~/.zsh/lib )
    . basics.zsh
    . uze.zsh
    uze a

but ... a doesn't work because aliases doesn't work
