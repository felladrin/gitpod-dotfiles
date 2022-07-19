#!/bin/bash

# For some reason, when running the workspace with VS Code Desktop IDE,
# it crashes during the initialization. That's why we're exiting in this case.
if [[ $GITPOD_IDE_ALIAS == "code-desktop" ]]; then exit 0; fi

startTime=$(date +%s)

if [ -x "$(command -v brew)" ]; then
  brew update

  brew install \
    starship \
    zsh-autosuggestions \
    zsh-syntax-highlighting
fi

if [ -x "$(command -v bash)" ]; then
  echo "Configuring bash..." &&
    {
      echo "export SHELL=$(which bash)"

      echo 'eval "$(starship init bash)"'

      echo 'HISTTIMEFORMAT="|%Y-%m-%d %T| "'

      echo 'export FZF_DEFAULT_COMMAND="rg --files"'

      echo 'export NVM_DIR="$HOME/.nvm"'
      echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
      echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'

      echo 'export PNPM_HOME="$HOME/.local/share/pnpm"'
      echo 'export PATH="$PNPM_HOME:$PATH"'

      echo '[[ $0 == *"bash"* ]] && [[ $# -eq 0 ]] && [[ $0 != "bash" ]] && exec $(which zsh)'
    } >>~/.bashrc &&
    echo "Done!"

  echo "Adding bash aliases..." &&
    {
      echo "alias ls='ls --color=auto'"
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

if [ -x "$(command -v zsh)" ]; then
  echo "Configuring zsh..." &&
    {
      echo "export SHELL=$(which zsh)"

      echo 'source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh'
      echo 'source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'

      echo 'eval "$(starship init zsh)"'

      echo 'export FZF_DEFAULT_COMMAND="rg --files"'

      echo 'if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi'
      echo 'if [[ -n $SSH_CONNECTION ]]; then cd $GITPOD_REPO_ROOT; fi'

      echo 'export NVM_DIR="$HOME/.nvm"'
      echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
      echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'

      echo 'export PNPM_HOME="$HOME/.local/share/pnpm"'
      echo 'export PATH="$PNPM_HOME:$PATH"'
    } >>~/.zshrc &&
    echo "Done!"
fi

endTime=$(date +%s)

echo "Install finished in $((endTime - startTime)) seconds."
