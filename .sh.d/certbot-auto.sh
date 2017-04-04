(if [[ ! -x "$DOTBIN/certbot-auto" ]]; then echo "Installing certbot-auto"; cd "$DOTBIN/"; wget --quiet https://dl.eff.org/certbot-auto; chmod a+x certbot-auto; fi)
