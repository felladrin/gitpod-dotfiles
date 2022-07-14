startTime=$(date +%s)

if [ -x "$(command -v brew)" ]; then
  brew install \
    lazygit \
    ripgrep \
    zellij \
    ranger \
    procs \
    bat \
    fzf
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
    {
      echo "alias ranger='. ranger'"
      echo "alias cloudcmd='npx -y cloudcmd';"
    } >> ~/.bash_aliases &&
    echo "Done!"

  echo "Installing Ble.sh (https://github.com/akinomyoga/ble.sh)..." &&
    curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf - &&
    rm -rf blesh &&
    mv ble-nightly* blesh &&
    rm -rf ~/.local/share/blesh &&
    mkdir -p ~/.local/share &&
    mv blesh/ ~/.local/share &&
    echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc &&
    echo "Done!"

  source ~/.bashrc
  source ~/.bash_aliases
fi

endTime=$(date +%s)

echo "Install finished in $((endTime-startTime)) seconds."
