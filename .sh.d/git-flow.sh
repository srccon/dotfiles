(if [[ ! -x "$DOTBIN/git-flow" ]]; then cd "$DOTLIB/gitflow"; git submodule init; git submodule update; make prefix=$DOTDIR install; fi)
