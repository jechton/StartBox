#!/bin/bash

config_dir=$HOME/.config/StartBox
config_path=$HOME/.config/StartBox/config.yaml
cache_dir=$HOME/.cache/StartBox

# install pip reqs
echo "Downloading pip dependencies..."
pip install --user bs4

# check if .config path exists
if [ ! -d "$HOME/.config" ]; then
  echo "The directory '~/.config' does not exist, or you do not have permissions to edit it."
  exit
fi

# check if .cache path exists
if [ ! -d "$HOME/.cache" ]; then
  echo "The directory '~/.cache' does not exist, or you do not have permissions to edit it."
  exit
fi

# check if .config/StartBox exists, create it and config if not
if [ ! -d "$config_dir" ]; then
  echo "Creating '~/.config/StartBox'..."
  mkdir $config_dir
  echo "Copying config.yaml..."
  cp ./config.yaml $config_path
  echo
fi

# check if config.yaml exists
if [ ! -f "$config_path" ]; then
  echo "No config.yaml found in '~/.config/StartBox'"
  echo "Copy the example config with:"
  echo "\tcp ./config.yaml $HOME/.config/StartBox/config.yaml"
  echo "or create your own in that directory."
  exit
fi

# create directory structure in .cache
if [ ! -d "$cache_dir" ]; then
  echo "Creating '$cache_dir'..."
  mkdir $cache_dir

  echo "Symlinking themes..."
  ln -s $(pwd)/themes $HOME/.cache/StartBox/themes

  echo "Creating '$cache_dir/styles'..."
  mkdir "$cache_dir/styles"
fi

echo "Creating style.css..."
cp "./skeletons/style.css" "$cache_dir/styles/style.css"

echo "Creating font files..."
cp "./skeletons/JetBrainsMonoNerdFont-Regular.ttf" "$cache_dir/styles/JetBrainsMonoNerdFont-Regular.ttf"
cp "./skeletons/JetBrainsMonoNerdFont-Bold.ttf" "$cache_dir/styles/JetBrainsMonoNerdFont-Bold.ttf"

# add to path
FILEPATH=$(readlink -f "generate.py")
ln -s $FILEPATH $HOME/.local/bin/startbox.py
echo "generate.py has been linked to $HOME/.local/bin/"
echo "Make sure this directory is in your \$PATH"

FILEPATH=$(readlink -f "docker/data/default.conf")
ln -s $FILEPATH $HOME/.cache/StartBox/default.conf

sed -i "/# replace line/{n;s@.*@repo_dir = \"$(pwd)\"@}" generate.py
