# MOTD
# Nice greeting when opening a terminal window
if [[ -d "$DOTDIR/.motd.d" ]];then for f in `ls $HOME/.motd.d/*`; do source $f; done; fi
