#!/bin/bash
startTime=$(date +%s)

if [ -x "$(command -v brew)" ]; then
  brew install \
    starship
fi

if [ -x "$(command -v bash)" ]; then
  echo "Configuring bash..." &&
    {
      echo 'HISTTIMEFORMAT="|%Y-%m-%d %T| "'
      echo 'export FZF_DEFAULT_COMMAND="rg --files"'
      echo "export SHELL=$(which bash)"
      # shellcheck disable=SC2016
      echo 'eval "$(starship init bash)"'
    } >>~/.bashrc &&
    echo "Done!"

  echo "Adding bash aliases..." &&
    {
      echo "alias ranger='(ranger --version &> /dev/null || brew install ranger &> /dev/null) && . ranger'"
      echo "alias dust='(dust --version &> /dev/null || brew install dust &> /dev/null) && dust -i'"
      echo "alias lazygit='(lazygit --version &> /dev/null || brew install lazygit &> /dev/null) && lazygit'"
      echo "alias zellij='(zellij --version &> /dev/null || brew install zellij &> /dev/null) && zellij'"
      echo "alias procs='(procs --version &> /dev/null || brew install procs &> /dev/null) && procs'"
      echo "alias fzf='(fzf --version &> /dev/null || brew install fzf &> /dev/null) && fzf'"
      echo "alias cloudcmd='npx -y cloudcmd'"
      echo "alias install-lunarvim='brew install neovim && bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y'"
    } >>~/.bash_aliases &&
    echo "Done!"
fi

endTime=$(date +%s)

echo "Install finished in $((endTime - startTime)) seconds."
