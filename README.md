# Dockerで設定込みのneovim環境を作る

## 目的
自分のPC以外での作業が多く、毎度毎度neovimのセットアップ(フォントやPython関係)を行うのが面倒だった。
セットアップスクリプトを書くことも考えましたが、osに依存する部分が多くなりちょっと違うんじゃないかと思った。
Dockerでneovim環境を作ってる人たちがいることを知って自分も真似させていただくことにした。


## 参考にしたページ 
[個人設定込みNeovimのDokcerイメージを作成した](https://qiita.com/succi0303/items/c2c3676f24e48161e6ff)
こちらを参考にさせていただきました。

リンクが切れてしまっていました。

## Install
### 前提

docker-ceがインストールされていること。
インストールがまだの場合は、[公式ページ](https://docs.docker.com/engine/install/debian/)を参考にインストールしてください。

ホストマシンにフォントを入れないと一部のフォントが文字化けします．
以下のコマンドでフォントをインストール．

PowerlineFontsのインストール
```.zsh
$ git clone https://github.com/powerline/fonts.git --depth=1
$ cd fonts
$ ./install.sh
Copying fonts...
Powerline fonts installed to /Users/user/Library/Fonts
$ cd ..
$ rm -rf fonts
```

NerdFontsのインストール
```.zsh
$ git clone --branch=master --depth 1 https://github.com/ryanoasis/nerd-fonts.git
$ cd nerd-fonts
$ ./install.sh
$ cd ..
$ rm -fr nerd-fonts
```

端末のプロファイル設定を，Nerd系のフォントに変更してください．


### build
1. githubからソースコードをダウンロード。
```.zsh
$ git clone https://github.com/Nanahoshi23/MyDockerNvim
```````

2. gitの設定を変更する.
```.zsh
$ vim src/git_config/.git_config
```
mail,userは変更したほうが良いと思います．
その他の設定についても

3. nvimの設定を変更する．(任意)
```.zsh
$ vim src/nvim_config/nvim/init.vim
```

4. イメージを作成
srcディレクトリで``build.sh``を実行(少々時間がかかります)
```.zsh
$ cd ./src
$ ./build.sh
```````


5. 実行
```.zsh
$ docker run -it --rm \
          -e DISPLAY=unix$DISPLAY \
          -v /tmp/.X11-unix:/tmp/.X11-unix \
          -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \
          -e XAUTHORITY=/tmp/.docker.xauth \
          -v ${dir_name}:/usr/src/nvim nvim
```````

6. イメージができたら作業ディレクトリは削除可
```
$ cd ..
$ rm -rf ./MyDockerNvim
```

### bashrcやzshrcに関数を作っておくと便利です
以下は自分の設定

```````.zsh
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
          -v /dev/dsp:/dev/dsp:rw \
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
              -v /dev/dsp:/dev/dsp:rw \
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
              -v /dev/dsp:/dev/dsp:rw \
              -v ${dir_name}:/usr/src/nvim nvim ${file_name}
        fi
    fi
}
```````

### 実行
```
$ dvim
```````
c-pが適切に反応しないことがあります．dockerのショートカットがデフォルトで登録されてるため．
私の場合は`~/.docker/config.json`に以下の設定を追加することで解消されました．
```
{
    "detachKeys": "ctrl-\\"
}
```

## neovimの主な設定
細かい設定は`src/nvim_config/nvim/init.vim`を参照．
気に入らない場合はイメージを作る前に書き換える(イメージを作ったあとに設定ファイルを書き換えても変更が反映されません．今後修正予定)
なるべくデフォルトのキーマッピングは残したかったけど，結構かえてしまった．

### 透過処理
guiアプリ動かしながらshell操作することがあり,端末を透過設定にしていることが多いので
vimも合わせて透過設定している。

### スクリーン操作
プレフィックスは`s`keyにまとめてある．
畳み込みの操作も`s`keyにまとめた．


### NERDTree
`Ctrl-n`でトグルします．

### fzf関係
プレフィクスは`<Space>`
`<Space>`+`f`: カレントディレクトリ以下のファイル検索
`<Space>`+`j`: ジャンプリスト
`<Space>`+`l`: バッファで行検索
`<Space>`+`/`: 現在開いているファイルで行検索
`<Space>`+`g`: `ripgrep`


### 翻訳
visualモードで選択して`<Space>`+`e`で英語から日本語，`<Space>`+'j'で日本語から英語

### スクショから英語を英文を抽出してクリップボードに貼り付ける．
　余分な文字が出てしまいます．今後修正予定.
```
:ScreenShotEinglish
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

- スクショ英文抽出に問題あり

    previm用にguiを使うので,uidとguidをビルド時に渡しているが、entry_pintで専用のシェルを作るとrunするときに指定できるようなので改善したい。
