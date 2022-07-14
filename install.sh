startTime=$(date +%s)

if [ -x "$(command -v brew)" ]; then
  brew install \
    lazygit \
    ripgrep \
    zellij \
    procs \
    bat \
    fzf \
    lf
fi

if [ -x "$(command -v vim)" ]; then
  echo "Installing SpaceVim..." &&
    curl -sLf https://spacevim.org/install.sh | bash &&
    echo "Done!"
fi

if [ -x "$(command -v bash)" ]; then
  echo "Configuring bash..." &&
    echo 'HISTTIMEFORMAT="|%Y-%m-%d %T| "' >> ~/.bashrc &&
    echo 'FZF_DEFAULT_COMMAND="rg --files"' >> ~/.bashrc &&
    echo "Done!"

  echo "Adding bash aliases..." &&
    (LF_ALIAS='lf -last-dir-path=$HOME/.lf-last-dir-path; LASTDIR=`cat $HOME/.lf-last-dir-path`; cd "$LASTDIR";';
    {
      echo "alias lf='$LF_ALIAS';"
      echo "alias cloudcmd='npx -y cloudcmd';"
    }) >> ~/.bash_aliases &&
    echo "Done!"

  echo "Installing Ble.sh (https://github.com/akinomyoga/ble.sh)..." &&
    curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf - &&
    mv ble-nightly* blesh &&
    mkdir -p ~/.local/share &&
    mv blesh/ ~/.local/share &&
    echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc &&
    echo "Done!"
fi

endTime=$(date +%s)

echo "Install finished in $((endTime-startTime)) seconds."
