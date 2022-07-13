startTime=$(date +%s)

if [ -x "$(command -v brew)" ]; then
  brew install \
    lazygit \
    ripgrep \
    zellij \
    micro \
    procs \
    bat \
    fzf \
    lf
fi

if [ -x "$(command -v micro)" ]; then
  micro -plugin install \
    lsp \
    fzf
fi

echo "Installing Ble.sh (https://github.com/akinomyoga/ble.sh)..." &&
  curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf - &&
  mv ble-nightly* blesh &&
  mkdir -p ~/.local/share &&
  mv blesh/ ~/.local/share &&
  echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc &&
  echo "Done!"

echo "Configuring bash..." &&
  echo 'HISTTIMEFORMAT="|%Y-%m-%d %T| "' >> ~/.bashrc &&
  echo 'FZF_DEFAULT_COMMAND="rg --files"' >> ~/.bashrc &&
  echo "Done!"

echo "Adding bash aliases..." &&
  (ALIAS='lf -last-dir-path=$HOME/.lf-last-dir-path; LASTDIR=`cat $HOME/.lf-last-dir-path`; cd "$LASTDIR";'; echo "alias lf='$ALIAS';") >> ~/.bash_aliases &&
  echo "alias cloudcmd='npx -y cloudcmd';" >> ~/.bash_aliases &&
  echo "Done!"

endTime=$(date +%s)

echo "Install finished in $((endTime-startTime)) seconds."
