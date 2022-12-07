# Personal Development Container :hammer:
A development container for C++ and Python3 development using neovim as an editor and tmux as a terminal multiplexer.

## Installation & Usage :rocket:
It's best to alias the following commands if you'll work with the container daily. 
Remember to change references to my own email and name to yours [here](https://github.com/yussefsoudan/development_container/blob/16b3df9021181e4b90b16dfaada4bba1c0019b74/Dockerfile#L63) and [here](https://github.com/yussefsoudan/development_container/blob/16b3df9021181e4b90b16dfaada4bba1c0019b74/homefiles/.gitconfig#L3). 

1. First, build the image. This will take some time. 

```
docker build -t dev:latest .
```

2. Bring up the container. 

```
docker-compose up --detach
```

3. Enter the container. 

```
docker exec -ti dev_container /opt/bb/bin/zsh
```

4. Take down the container. 

```
docker-compose down
```

**Note**: when you build the image for the first time, or when you rebuild it, remember to copy the contents of `~/.ssh/github.pub` to a new SSH key in your Github account (Settings -> SSH and GPG Keys --> New SSH Key). This will enable SSH-based pulls and pushes to Github.  

## Choosing a Font :art:
This will make things a lot prettier when using neovim (enabling folder icons in Nerdtree, etc.) and zsh (enabling a pretty status line). 
Note that this is independent of the Docker container.

### With Windows Terminal
First, [choose a font](https://github.com/ryanoasis/nerd-fonts#patched-fonts) and then installe it by downloading the [installation file](https://github.com/source-foundry/Hack-windows-installer/releases/tag/v1.6.0) for it.
After installing the font, you can go to your Windows Terminal application's settings, choose Ubuntu from the left, then Appearance and then change Font Face to your installed font. 

### With MacOS Terminal 
In your terminal, you can install fonts using homebrew, like [instructed here](https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts) and pick the colour your installed in Preferences. 

## Tips for Developing in C++ :safety_vest:
### Autocompletion and Errors
In this setup, I use [coc.nvim](https://github.com/neoclide/coc.nvim) and its [coc-clangd](https://github.com/clangd/coc-clangd) extention to aid with development. 
For CoC to process your project's includes though, remember to take the following steps:
- Run cmake with the flag: `-DCMAKE_EXPORT_COMPILE_COMMANDS=1` 
- Then: `ln -s ~/myproject/cmake-build/compile_commands.json ~/myproject/`

### Formatting 
Formatting should be taken care of by `clangd`; you should see the file auto-formatting when you save and you can format selected regions using `<leader>f`. 
Note, however, that if you place a custom `.clang-format` in an outer directory to your project's that it will then take precedence. 

You can turn off autoformatting for `cpp` files by removing `cpp` from [here](https://bbgithub.dev.bloomberg.com/ysoudan1/development_container/blob/accf8071a3ab923a5a44f624b5cb1d7a477ea706/homefiles/.config/nvim/coc-settings.json#L16). 

## Tips for Developing in Python :safety_vest:
### Autocompletion and Errors
Things are good to go for Python out of the box thanks to `coc-pyright` and `coc-jedi`. 

### Formatting
For formatting, `black` is used and it auto-formats when you save. Note that `black` does not support selection formatting. 
You can turn off autoformatting for `python` files by removing `python` from [here](https://bbgithub.dev.bloomberg.com/ysoudan1/development_container/blob/accf8071a3ab923a5a44f624b5cb1d7a477ea706/homefiles/.config/nvim/coc-settings.json#L16). 

## Customizing :pencil2:
Feel free to fork this repository and change the setup suit your needs. 

Things you might want to customise may include:
- Changing the installed packages in the `Dockerfile`. 
- Changing what files or directories are mounted in the `docker-compose.yaml`. 
- Customising your neovim setup in `init.vim`. 


