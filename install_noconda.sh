#!/bin/bash


cp starship.toml $HOME/.config/starship.toml
 
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
else
    echo "oh-my-zsh already installed"
fi

# check to see if zsh syntax highlitghting is installed
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
    echo "zsh-syntax-highlighting already installed"
fi

# check to see if zsh autosuggestions is installed
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "zsh-autosuggestions already installed"
fi
 
# echo new line

# check to see of $HOME/.zshrc has the line "export ZSH=$HOME/.oh-my-zsh"
if ! grep -q "export ZSH=\"\$HOME/.oh-my-zsh\"" "$HOME/.zshrc"; then
    echo "" >> ~/.zshrc
    echo "export ZSH=\"\$HOME/.oh-my-zsh\"" >> ~/.zshrc
else
    echo "export ZSH=\"\$HOME/.oh-my-zsh\" already in .zshrc"
fi

# check to see if $HOME/.zshrc has the line plugins=(xxxxx)
if ! grep -q "plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)" "$HOME/.zshrc"; then
    echo "" >> ~/.zshrc
    echo "plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)" >> ~/.zshrc
else
    echo "plugins=(git z zsh-autosuggestions zsh-syntax-highlighting) already in .zshrc"
fi

# check if $HOME/.zshrc has the line source $ZSH/oh-my-zsh.sh
if ! grep -q "source \$ZSH/oh-my-zsh.sh" "$HOME/.zshrc"; then
    echo "" >> ~/.zshrc
    echo "source \$ZSH/oh-my-zsh.sh" >> ~/.zshrc
else
    echo "source \$ZSH/oh-my-zsh.sh already in .zshrc"
fi

# check if $HOME/.zshrc has the line: eval "$(starship init zsh)"
if ! grep -q "eval \"\$(starship init zsh)\"" "$HOME/.zshrc"; then
    echo "" >> ~/.zshrc
    echo "eval \"\$(starship init zsh)\"" >> ~/.zshrc
else
    echo "eval \"\$(starship init zsh)\" already in .zshrc"
fi