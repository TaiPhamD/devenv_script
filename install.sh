#!/bin/bash

# store all existing conda envs to yaml

# loop through conda env list and export to yaml per environment
mkdir conda_env_backup
for env in $(conda env list | grep -v '#' | awk '{print $1}' | grep -v '^$'); do
    conda env export -n $env > conda_env_backup/$env.yaml
done

# check if conda is installed if so rename miniconda3 to miniconda3_old
if [ -d "$HOME/miniconda3" ]; then
    mv $HOME/miniconda3 $HOME/miniconda3_old
fi


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
 
 
cp starship.toml $HOME/.config/starship.toml
 
conda install -n base -c conda-forge starship -y
 
# install oh-my-zsh for plugins
git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
 
 # echo new line
echo "" >> ~/.zshrc
echo "export ZSH=\"\$HOME/.oh-my-zsh\"" >> ~/.zshrc
echo "plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)" >> ~/.zshrc
echo "source \$ZSH/oh-my-zsh.sh" >> ~/.zshrc
echo "eval \"\$(starship init zsh)\"" >> ~/.zshrc

zsh