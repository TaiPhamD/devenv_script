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