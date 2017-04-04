# MOTD
# Nice greeting when opening a terminal window
if [[ -d "$DOTDIR/.motd.d" ]];then for f in `ls $DOTDIR/.motd.d/*`; do source $f; done; fi
