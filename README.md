# Personal Development Container :hammer:
A development container for C++ and Python3 development using neovim as an editor and tmux as a terminal multiplexer.
The `neovim` setup is built on [NvChad](https://github.com/NvChad/NvChad) with a few customisations for C++ and Python development. I recommend you do the same.

## Installation & Usage :rocket:
It's best to alias the following commands if you'll work with the container daily. 
Remember to change references to my own email and name to yours [here](https://github.com/yussefsoudan/development_container/blob/16b3df9021181e4b90b16dfaada4bba1c0019b74/Dockerfile#L41) and [here](https://github.com/yussefsoudan/development_container/blob/16b3df9021181e4b90b16dfaada4bba1c0019b74/homefiles/.gitconfig#L3). 

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
For the display of real colours, MacOS Terminal will not do. You'll need to get iTerm. 

In your terminal, you can install fonts using homebrew, like [instructed here](https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts) and you can choose your installed font in Preferences --> Profiles. 

## Tips for Developing in C++ :safety_vest:
### Autocompletion and Errors
In this setup, I use `lspconfig` with `clangd` as the language server. 
For `lspconfig` to process your project's includes though, remember to take the following steps:
- Run cmake with the flag: `-DCMAKE_EXPORT_COMPILE_COMMANDS=1` 
- Then: `ln -s ~/myproject/cmake-build/compile_commands.json ~/myproject/`

### Formatting 
Formatting should be taken care of by `clang-format` (already installed in my custom NvChad setup); you should see the file auto-formatting when you save and you can format selected regions using `<leader>fm`. 
Note, however, that if you place a custom `.clang-format` in an outer directory to your project's that it will then take precedence. 

## Tips for Developing in Python :safety_vest:
### Autocompletion and Errors
`mypy` and `ruff` are used for static analysis and `pyright` is used as a language server. 

### Formatting
For formatting, `black` is used and it auto-formats when you save. Note that `black` does not support selection formatting. 

## Customizing :pencil2:
Feel free to fork this repository and change the setup suit your needs. 
