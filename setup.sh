#!/bin/bash

# location of where settings.json is located
if command -v code &> /dev/null
then
    SETTINGS_PATH="$HOME/.vscode-remote/data/Machine/"
else
    SETTINGS_PATH="$HOME/.local/share/code-server/User"
fi

# make directory if it doesn't exist
mkdir -p $SETTINGS_PATH
echo [config]: $SETTINGS_PATH

# update vscode settings before installing extensions 
echo '{
    "workbench.colorTheme": "Horizon Italic",
    "workbench.iconTheme": "material-icon-theme",
    "terminal.integrated.defaultProfile.linux": "bash",
}' > $SETTINGS_PATH/settings.json

# list of all extensions to install
# coder doesn't have 
EXTENSIONS=(
    "jolaleye.horizon-theme-vscode" # theme
    "ms-azuretools.vscode-docker"
    "dbaeumer.vscode-eslint"
    "eamodio.gitlens"
    "yandeu.five-server"
    "Prisma.prisma"
    "PKief.material-icon-theme"
    "bradlc.vscode-tailwindcss"
    "Gruntfuggly.todo-tree"

    # local
    "/tmp/copilot.vsix"
)

# copilot cannot be found in the marketplace, it needs to be download manually
# downloading from marketplace doesn't work
curl -L https://derock.media/r/DAQPqA.vsix \
    -o /tmp/copilot.vsix

# install extensions
for EXTENSION in "${EXTENSIONS[@]}"
do
    # use `code` if exists, or use `code-server` otherwise
    if command -v code &> /dev/null
    then
        code --install-extension $EXTENSION &
    else
        code-server --install-extension $EXTENSION &
    fi
done

wait
echo "Done"
