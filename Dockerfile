FROM ubuntu:20.04 

ARG PYTHON=python3.9 

ENV PYTHON="$PYTHON" \ 
    TERM=xterm-256color \ 
    TZ=Europe/London \ 
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \ 
    LANGUAGE=en_US:en 

# Development Tools 
RUN apt update && \ 
    apt  install -y  \ 
    git  \ 
    python3.9 \
    python3-pip \ 
    python3.9-venv \
    tmux \ 
    less \ 
    gcc \ 
    curl \ 
    make \ 
    wget \ 
    zsh powerline fonts-powerline language-pack-en \ 
    python3-neovim \
    gdb \
    cmake \ 
    clangd-12 \
    clang \
    g++ \ 
    rsync \
    silversearcher-ag \
    zip \ 
    openssh-server \
    libstdc++-10-dev \
    libtool \
    npm \
    pkg-config \
    libgtest-dev \ 
    glibc-source \
    && update-locale \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# oh-my-zsh
RUN sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" && \
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
    git clone --depth=1 --single-branch https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions 


ENV SHELL=/usr/bin/zsh

# Python 
RUN python3 -m pip install --user jedi-language-server 
RUN python3 -m pip install setuptools pynvim pytest black pylint 
RUN python3 -m pip install poetry black cmake-format pylint mypy nox

# Setup bbgihub keys 
# When you rebuild the image, add contents of github.pub to a github key 
RUN rm -rf /root/.ssh/github 
RUN rm -rf /root/.ssh/github.pub 
RUN ssh-keygen -t rsa -C "Yussef Soudan yussefsoudan@gmail.com" -f ~/.ssh/github -P ""
RUN touch /root/.ssh/config 
RUN echo "Host github github.com" >> /root/.ssh/config 
RUN echo "Hostname github.com" >> /root/.ssh/config 
RUN echo "User git" >> /root/.ssh/config 
RUN echo "UserKnownHostsFile /dev/null" >> /root/.ssh/config 
RUN echo "StrictHostKeyChecking no" >> /root/.ssh/config 
RUN chmod 600 /root/.ssh/config

# Neovim 
## Get latest Nodejs v14+
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get update && \ 
    apt-get clean && \ 
    apt-get autoremove && \ 
    apt-get install -y nodejs 
## Get newer version of neovim
RUN apt-get update && \
    apt-get clean && \ 
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:neovim-ppa/stable && \
    apt-get update && \
    apt-get install -y neovim
## Setup neovim and coc extensions
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
RUN mkdir -p ~/.config/nvim
RUN mkdir -p ~/.cache/nvim/backups/
COPY ./homefiles/.config/nvim/init.vim /root/.config/nvim/init.vim
COPY ./homefiles/.config/nvim/coc-settings.json /root/.config/nvim/coc-settings.json
RUN nvim --headless -n -i NONE +PlugInstall +qall && \ 
    mkdir -p ~/.config/coc/extensions && \ 
    [ ! -f package.json ] && echo '{"dependencies":{}}'> ~/.config/coc/extensions/package.json; \
    npm install -C ~/.config/coc/extensions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-snippets && \
    npm install -C ~/.config/coc/extensions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-pyright && \
    npm install -C ~/.config/coc/extensions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-jedi && \
    npm install -C ~/.config/coc/extensions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-clang-format-style-options && \
    npm install -C ~/.config/coc/extensions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-clangd && \
    npm install -C ~/.config/coc/extensions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-json && \
    npm install -C ~/.config/coc/extensions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-yaml && \
    npm install -C ~/.config/coc/extensions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-xml && \
    npm install -C ~/.config/coc/extensions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-toml && \
    npm install -C ~/.config/coc/extensions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-docker && \
    npm install -C ~/.config/coc/extensions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-pairs && \
    npm install -C ~/.config/coc/extensions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-cmake && \
    npm install -C ~/.config/coc/extensions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-markdownlint && \
    npm install -C ~/.config/coc/extensions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod coc-sh      

# Tmux 
RUN git clone https://github.com/gpakosz/.tmux.git /path/to/oh-my-tmux && \ 
    ln -s -f /path/to/oh-my-tmux/.tmux.conf ~/.tmux.conf && \ 
    cp /path/to/oh-my-tmux/.tmux.conf.local ~/.tmux.conf.local

# Allow clangd to be accessible to neovim 
RUN cp -a /usr/lib/llvm-12/bin/. /usr/bin/

CMD ["/usr/bin/zsh"]

