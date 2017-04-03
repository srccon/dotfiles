(if [[ ! -h "$HOME/.config/ranger" ]]; then mv "$HOME/.config/ranger" "$DOTORIG/"; cd "$HOME/.config"; ln -s "../$DOTDIRNAME/.config/ranger.link" "ranger"; fi)
