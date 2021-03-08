# Dockerで設定込みのneovim環境を作る[研究室内メモ]

## 目的
自分のPC以外での作業が多く、毎度毎度neovimのセットアップ(フォントやPython関係)を行うのが面倒だった。
セットアップスクリプトを書くことも考えましたが、osに依存する部分が多くなりちょっと違うんじゃないかと思った。
Dockerでneovim環境を作ってる人たちがいることを知って自分も真似させていただくことにした。


## 参考にしたページ 
[個人設定込みNeovimのDokcerイメージを作成した](https://qiita.com/succi0303/items/c2c3676f24e48161e6ff)
こちらを参考にさせていただきました。

リンクが切れてしまっていました。

## Dockerfile
``````
FROM alpine:edge AS ripgrep

LABEL maintainer="mo10aki.931@gmail.com"

ENV LANG="ja_JP.UTF-8" LANGUAGE="ja_JP:ja" LC_ALL="ja_JP.UTF-8"

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && \
      apk upgrade && \
      apk add --no-cache \
      curl \
      gcc \
      git \
      linux-headers \
      musl-dev\
      neovim \
      bash \
      fzf \
      shadow \
      sudo \
      ripgrep \
      bat@testing \
      python-dev \
      py-pip \
      python3-dev \
      boost-python3 \
      firefox \
      terminus-font \
      ttf-freefont \
      fontconfig-dev \
      freetype-dev \
      libcanberra-gtk3 \
      make\
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

RUN pip3 install --upgrade pip pynvim

RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python2 get-pip.py
RUN python3 get-pip.py
RUN python2 -m pip install pynvim

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

RUN nvim +PlugInstall +qa

WORKDIR /home/motoaki/.local/share/nvim/plugged/vimproc.vim 
RUN make

WORKDIR /usr/src/nvim
ENTRYPOINT ["nvim"]
``````

### ブラウザ用の日本語フォントのインストール
```
RUN mkdir /noto
ADD https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip /noto 
WORKDIR /noto

RUN unzip NotoSansCJKjp-hinted.zip && \
    mkdir -p /usr/share/fonts/noto && \
    cp *.otf /usr/share/fonts/noto && \
    chmod 644 -R /usr/share/fonts/noto/ && \
    fc-cache -fv

RUN cp /usr/share/fonts/noto/* /usr/share/fonts
```````

### Pythonにpynvimをインストール
```
ENV PYTHONUNBUFFERED=1

RUN pip3 install --upgrade pip pynvim

RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python2 get-pip.py
RUN python3 get-pip.py
RUN python2 -m pip install pynvim
```````
### userを作成
ownerとブラウザ用にXを使うuserを追加する.
```
# Add new user with our credentials
ENV USERNAME ${user}
RUN addgroup -g ${gid} -S $USERNAME
RUN adduser -u ${uid} --ingroup $USERNAME -S $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    chmod 0440 /etc/sudoers && \
    echo "$USERNAME:$USERNAME" | chpasswd && \
    usermod -aG $USERNAME $USERNAME
```````

## Dockerイメージの作成
### 前提
  docker-ceがインストールされていること。
  インストールがまだの場合は、[公式ページ](https://docs.docker.com/engine/install/debian/)を参考にインストールしてください。

### build
1. githubから作業ディレクトリをダウンロード。
```
$ git clone 
```````
2. gitconfigをコピーする。
``````
$ cd ./my_docker_neovim
$ cp ~/.gitconfig ./
```````


3. 作業ディレクトリで``build.sh``を実行(少々時間がかかります)
```
$ ./build.sh
```````
4. 実行
```
$ docker run -it --rm \
          -e DISPLAY=unix$DISPLAY \
          -v /tmp/.X11-unix:/tmp/.X11-unix \
          -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \
          -e XAUTHORITY=/tmp/.docker.xauth \
          -v ${dir_name}:/usr/src/nvim nvim
```````
5. イメージができたら作業ディレクトリは削除可
```
$ cd ..
$ rm -rf ./my_docker_neovim
```````

## bashrcやzshrcに関数を作っておくと便利です
以下は自分の設定
```
function dvim() {
    if [ $# -ne 1 ];
    then
        # 引数がなかった場合、カレントディレクトリをルートとしてvimを起動
        dir_name=$(pwd)
        docker run -it --rm \
          -e DISPLAY=unix$DISPLAY \
          -v /tmp/.X11-unix:/tmp/.X11-unix \
          -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \
          -e XAUTHORITY=/tmp/.docker.xauth \
          -v ${dir_name}:/usr/src/nvim nvim
    else
        file_path=${1}
        if [ -d ${file_path} ]; then
            # ディレクトリが引数だった場合、そのディレクトリをルートとしてvimを起動
            dir_name=$($(cd $(dirname ${1}) &> /dev/null) && pwd )
            dir_name=$(echo "${dir_name}")
            file_name=$(echo $(basename ${1}))
            dir_path=$(echo "${dir_name}/${file_name}")
            docker run  -it --rm \
              -e DISPLAY=unix$DISPLAY \
              -v /tmp/.X11-unix:/tmp/.X11-unix \
              -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \
              -e XAUTHORITY=/tmp/.docker.xauth \
              -v ${dir_path}:/usr/src/nvim nvim
        else
            # 引数がファイルだった場合は、ファイルのあるディレクトリをルートとしてvimを起動
            dir_name=$($(cd $(dirname ${1}) &> /dev/null) && pwd )
            file_name=$(echo $(basename ${1}))
            docker run  -it --rm \
              -e DISPLAY=unix$DISPLAY \
              -v /tmp/.X11-unix:/tmp/.X11-unix \
              -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \
              -e XAUTHORITY=/tmp/.docker.xauth \
              -v ${dir_name}:/usr/src/nvim nvim ${file_name}
        fi
    fi
}
```````

### 実行
```
$ dvim
```````

### c-pが適切に反応しないことがあります．dockerのショートカットがデフォルトで登録されてるため．
以下の設定をする.

## neovimの主な設定

### 透過処理
guiアプリ動かしながらshell操作することがあり,端末を透過設定にしていることが多いので
vimも合わせて透過設定している。

### NERDTree
`Ctrl-n`で起動

### fzf関係
プレフィクスは`<Space>`
`<Space>`+`f`: カレントディレクトリ以下のファイル検索
`<Space>`+`j`: ジャンプリスト
`<Space>`+`l`: バッファで行検索
`<Space>`+`/`: 現在開いているファイルで行検索
`<Space>`+`g`: `ripgrep`


### ripgrep
``Ctrl-g``

### 翻訳
visualモードで選択して`<Space>`+`e`で英語から日本語，`<Space>`+'j'で日本語から英語

## フォントについて

パワーラインとノードをそれぞれホストマシンにいれて端末のフォントをノードにする必要が有る．
逆にイメージのなかではフォントをダウンロードしなくてもよい？

[]
```bash:PowerlineFontsのインストール
$ git clone https://github.com/powerline/fonts.git --depth=1
$ cd fonts
$ ./install.sh
Copying fonts...
Powerline fonts installed to /Users/user/Library/Fonts
$ cd ..
$ rm -rf fonts
```

```bash:NerdFontsのインストール
$ git clone --branch=master --depth 1 https://github.com/ryanoasis/nerd-fonts.git
$ cd nerd-fonts
$ ./install.sh
$ cd ..
$ rm -fr nerd-fonts
```


## 課題

めちゃめちゃあります。
- イメージの容量が大きくなってしまった

    本末転倒。せっかくalpineのイメージを使っているのに、イメージ容量が1.2Gbもある。

- 元イメージにローリング・リリースのalpine:edigを使っている.

  多分あんまり良くないと思う。リリースの状況によってはbuildし直さなければならない．

- フォントの設定の仕方がよくわかってない

- vimからfirefoxコマンドを呼び出した時に固まる

    !firefox が帰ってこない
    ホストのfirefoxはデフォルトでバックグランドで実行されるのですがコレいかに。
    open_veiwも同じような感じで帰ってきません。

- firefoxがタブでクラッシュする。

    本当は、ブラウンジグもできるようにしたかったのですが、new tabするとクラッシュしてしまいます。
    また、firefoxのプラグイン等を設定済みの状態でイメージにする方法がよくわからなかったので、そのへんも改良していきたい。

- diniteの設定がうまくできなかった。

    検索履歴の呼び出しなどができて便利なのですが、うまく起動させることができず、今回は使っていません。
    代わりにファインダーとしてfzf-previewとripgrepを使用しています。

- C-zでフリーズする。

    シェルに戻れたら結構便利な使い方ができるかと思うんですが。もう少し勉強しています。

- 結構オーバーヘッドがある?

- イメージがホスト依存

    previm用にguiを使うので,uidとguidをビルド時に渡しているが、entry_pintで専用のシェルを作るとrunするときに指定できるようなので改善したい。

    やっちゃいけないことをしている気がしてならない。
