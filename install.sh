#!/bin/bash

# store all existing conda envs to yaml


# check if the folder $HOME/miniconda3 exists
if [ ! -d "$HOME/miniconda3" ]; then
    # Specify the Miniconda version to download
    MINICONDA_VERSION="latest"
    # auto detect if this is macos ARM or linux x64
    MINICONDA_OS="$(uname -s)"
    echo $MINICONDA_OS

    if [ "$MINICONDA_OS" == "Darwin" ]; then
        MINICONDA_OS="MacOSX"
    elif [ "$MINICONDA_OS" == "Linux" ]; then
        MINICONDA_OS="Linux"
    else
        echo "OS not supported"
        exit 1
    fi

    MINICONDA_ARCH="$(uname -m)"

    if [ "$MINICONDA_ARCH" == "x86_64" ]; then
        MINICONDA_ARCH="x86_64"
    elif [ "$MINICONDA_ARCH" == "arm64" ]; then
        MINICONDA_ARCH="arm64"
    elif [ "$MINICONDA_ARCH" == "aarch64" ]; then
        MINICONDA_ARCH="aarch64"    
    else
        echo "Architecture not supported"
        exit 1
    fi
    # Specify the installation directory for Miniconda
    INSTALL_DIR="$HOME/miniconda3"
    # Download the Miniconda installer for the right architecture
    wget https://repo.anaconda.com/miniconda/Miniconda3-$MINICONDA_VERSION-$MINICONDA_OS-$MINICONDA_ARCH.sh -O miniconda.sh
    # Make the installer executable
    chmod +x miniconda.sh
    # Run the installer with silent mode, accept all defaults, and specify the installation directory
    ./miniconda.sh -b -p $INSTALL_DIR
    # Clean up by removing the installer script
    rm miniconda.sh
    # Initialize conda for all shells (may require restarting the shell)
    $INSTALL_DIR/bin/conda init zsh
    source ~/.zshrc
else
    echo "conda already installed"
fi

cp starship.toml $HOME/.config/starship.toml
conda install -n base -c conda-forge starship -y
 
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

# check if we have a conda environment named "311"
if ! conda env list | grep -q "311"; then
    conda env create -f environment.yml
else
    echo "conda environment 311 already exists"
fi

zsh