FROM ubuntu:22.04 

ARG PYTHON=python3.10

ENV PYTHON="$PYTHON" \ 
    TERM=xterm-256color \ 
    TZ=Europe/London \ 
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \ 
    LANGUAGE=en_US:en 

# Development Tools 
RUN apt-get update 
RUN apt-get install -y git tmux less curl wget zsh openssh-server zip unzip ripgrep
RUN apt-get install -y ${PYTHON} ${PYTHON}-venv python3-pip
RUN apt-get install -y lua5.3
RUN apt-get install -y npm nodejs
RUN apt-get install -y gcc-12 make cmake gdb clangd-15 clang g++ libstdc++-12-dev libtool pkg-config gettext ninja-build
RUN apt-get clean

# oh-my-zsh
RUN sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" && \
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
    git clone --depth=1 --single-branch https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions 

ENV SHELL=/usr/bin/zsh

# Rust 
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y 
RUN export PATH="$HOME/.cargo/bin:$PATH"

# Python 
RUN ${PYTHON} -m pip install --user jedi-language-server 
RUN ${PYTHON} -m pip install pytest black poetry 

# Setup gihub keys 
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

## Setup latest neovim 
RUN git clone --depth 1 https://github.com/neovim/neovim /root/neovim
RUN cd /root/neovim && make CMAKE_BUILD_TYPE=Release
RUN cd /root/neovim && make install

COPY ./homefiles/.config/ /root/.config/

## Install packer and needed plugins
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
RUN nvim --headless ':MasonInstallAll' +q

# Allow clangd to be accessible to neovim 
RUN cp -a /usr/lib/llvm-15/bin/. /usr/bin/

CMD ["/usr/bin/zsh"]
