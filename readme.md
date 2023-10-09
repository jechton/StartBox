# StartBox

A comfortable home page modified from [Apro's Startpage](https://github.com/Aproxia-dev/startpage) and [StartTree](https://github.com/Paul-Houser/StartTree).

<!-- <p align="center">
  <img src="/images/StartTree.png", title="StartTree"/>
</p> -->

# Usage

## Installation

To install StartBox for the first time, run the following commands:
(Note: If the `~/.config/StartBox` directory already exists, `init.sh` will not copy the example config to prevent accidentally overwriting a custom config.)

```
git clone https://github.com/retchohrips/StartBox.git
cd StartBox
chmod +x init.sh
chmod +x generate.py
./init.sh
./generate.py
```

This will create the directory `~/.config/StartBox` containing the default `config.yaml`, install `startbox.py` to your `$PATH`, as well as generate the html/css, which you can view by pointing your browser at `$HOME/.cache/StartBox/index.html`.

## Config

The config should be placed in `~/.config/StartBox/config.yaml`

## Updating the HTML

To re-generate the html/css after editing the config, execute `startbox.py` from any directory.

# Example Config

```yaml
font_size: 22 # specify font size
theme: catppuccin # specify the name of a theme in the themes/ directory, or use 'pywal'
name: Johnny # name for the greeting
row_1: # each row should be named 'row_X' where X is unique for each row.
  general: # Group name
    github: "https://www.github.com/" # Link-text: url
    monkeytype: "https://monkeytype.com/"
  reddit:
    # the following is an example of naming a link something with a space,
    # or containing characters that cannot be in a yaml variable name.
    frontpage:
      - "https://www.reddit.com/"
      - "front page"
    unixporn: "https://www.reddit.com/r/unixporn/"
row_2:
  other:
    archwiki:
      - "https://archlinux.org/"
      - "arch wiki"
    backloggd: "https://backloggd.com/"
```

# Themes

A variety of themes can be found in the `themes` directory.

If one wishes to dynamically theme from `pywal`, they may select `pywal` as their chosen theme in `config.yaml`.

# Docker

In order to circumvent some restrictions on browsers for what is allowed as a "Home" and "New Tab" page, you can host StartTree as a lightweight `NGINX` server through `docker-compose`.

To set this up, one must have `docker` and `docker-compose` installed and configured. Then, go into the directory where you cloned `StartBree`, and run

```bash
cd docker
nvim docker-compose.yaml # edit specifics to your liking
docker-compose -f docker-compose.yaml up -d
```

This will make the `NGINX` server persist across reboots. You can point your browser's new tab and home page to `localhost:p<port#>` and you should see your startpage!

### NOTE:

Currently, docker is unaware if a file changes on the fly (like generating a new colorscheme or adding new shortcuts), so you have to restart the container with

`docker-compose -f docker-compose.yaml restart <servicename>`
