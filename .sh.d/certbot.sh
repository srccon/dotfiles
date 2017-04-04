(if [[ ! -x "$DOTBIN/certbot-auto" ]]; then echo "Installing certbot-auto"; cd "$DOTBIN/"; wget https://dl.eff.org/certbot-auto; chmod a+x certbot-auto; fi)
