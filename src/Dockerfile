FROM alpine:edge AS ripgrep

LABEL maintainer="nanahoshi.931@gmail.com"
ENV LANG="ja_JP.UTF-8" LANGUAGE="ja_JP:ja" LC_ALL="ja_JP.UTF-8"

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && \
      apk upgrade && \
      apk add --no-cache \
      curl \
      gcc \
      g++ \
      git \
      linux-headers \
      musl-dev\
      neovim \
      neovim-doc \
      xclip \
      bash \
      fzf \
      shadow \
      sudo \
      ripgrep \
      bat@testing \
      py-pip \
      python2-dev \
      python3-dev \
      boost-python3 \
      firefox \
      terminus-font \
      ttf-freefont \
      fontconfig-dev \
      freetype-dev \
      libcanberra-gtk3 \
      imagemagick \
      make\
      gawk\
      nodejs\
      npm \
      yarn \
      mplayer\
      mlocate\
      alsa-utils \
      alsa-utils-doc \
      alsa-lib \
      alsaconf \
      pulseaudio \
      pulseaudio-alsa \
      tesseract-ocr \
      py3-pip && \
      rm -rf /var/cache/apk/*


RUN mkdir /noto
ADD https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip /noto 
WORKDIR /noto

RUN unzip NotoSansCJKjp-hinted.zip && \
    mkdir -p /usr/share/fonts/noto && \
    cp *.otf /usr/share/fonts/noto && \
    chmod 644 -R /usr/share/fonts/noto/ && \
    fc-cache -fv

RUN cp /usr/share/fonts/noto/* /usr/share/fonts

WORKDIR /
RUN rm -rf /noto


ENV PYTHONUNBUFFERED=1

# 入れ替え
# RUN pip3 install --upgrade pip pynvim
RUN pip3 install --upgrade pip pynvim

RUN wget https://bootstrap.pypa.io/get-pip.py
#RUN python2 get-pip.py
RUN python3 get-pip.py
#RUN python2 -m pip install pynvim


# Arguments picked from the command line!
ARG user
ARG uid
ARG gid

# Add new user with our credentials
ENV USERNAME ${user}
RUN addgroup -g ${gid} -S $USERNAME
RUN adduser -u ${uid} --ingroup $USERNAME -S $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    chmod 0440 /etc/sudoers && \
    echo "$USERNAME:$USERNAME" | chpasswd && \
    usermod -aG $USERNAME $USERNAME

USER ${USERNAME}



COPY nvim_config /home/$USERNAME/.config
COPY nvim_config /root/.config

RUN curl -fLo /home/$USERNAME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN echo "${gitconfig_file_path}"
COPY git_config/.gitconfig /home/$USERNAME/

# 
RUN sudo wget git.io/trans -O /usr/local/bin/trans && \
    sudo chmod +x /usr/local/bin/trans

RUN curl --compressed -o- -L https://yarnpkg.com/install.sh | bash


RUN sudo mkdir /home/$USERNAME/.config/coc
RUN sudo chmod 777 /home/$USERNAME/.config/coc

RUN sudo chmod 777 /home/$USERNAME/.config/
RUN sudo npm install -g neovim
RUN nvim +PlugInstall +qa

WORKDIR /home/$USERNAME/.local/share/nvim/plugged/vimproc.vim 
#RUN sudo chmod 777 /home/$USERNAME/.local/share/nvim/plugged/vimproc.vim && make
RUN git clone https://github.com/Shougo/vimproc.vim.git /home/$USERNAME/.vim/bundle/vimproc.vim
#RUN sudo chmod 777 /home/$USERNAME/.vim/bundle/vimproc.vim && \
#    cd /home/$USERNAME/.vim/bundle/vimproc.vim && \
#     sudo make

# Previm
#RUN rm /home/$USERNAME/.local/share/nvim/plugged/previm/preview/_/index.html
#RUN rm /home/$USERNAME/.local/share/nvim/plugged/previm/preview/_/js/previm.js
#COPY previm_config/index.html /home/$USERNAME/.local/share/nvim/plugged/previm/preview/_
#COPY previm_config/previm.js /home/$USERNAME/.local/share/nvim/plugged/previm/preview/_/js

WORKDIR /usr/src/nvim
ENTRYPOINT ["nvim"]
