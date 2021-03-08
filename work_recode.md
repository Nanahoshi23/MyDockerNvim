##2020年10月英語翻訳機能を追加


trans
open_jtalk
apk add gcc g++ make build-base alsa-audio alpine-sdk musl-dev
sudo wget https://sourceforge.net/projects/hts-engine/files/hts_engine%20API/hts_engine_API-1.10/hts_engine_API-1.10.tar.gz
sudo wget https://sourceforge.net/projects/hts-engine/files/hts_engine%20API/hts_engine_API-1.06/hts_engine_API-1.06.tar.gz
sudo wget https://netbsd.pkgs.org/9.0/netbsd-aarch64/hts_engine_API-1.10.tgz

$ which hts_engine
/usr/local/bin/hts_engine

open-jtalk
./configure --with-hts-engine-header-path=/usr/local/include --with-hts-engine-library-path=/usr/local/lib --wit
h-charset=UTF-8

## 合成音声機能をつけたくて全部失敗した.
open_jtalk等

## ただしグーグルトランスを使った方法があることに気づいたので実装

ディスプレイと一緒でサウンド関連もdocker内で使うには必要だから
下に記す.


ソケットファイルの作成
  $ pacmd load-module module-native-protocol-unix socket=/tmp/pulseaudio.socket

パルスオーディオのコンフィグを作る
  $ touch /tmp/pulseaudio.client.conf

編集
  default-server = unix:/tmp/pulseaudio.socket
  # Prevent a server running in the container
  autospawn = no
  daemon-binary = /bin/true
  # Prevent the use of shared memory
  enable-shm = false

大事なのは--evn2つと--volume２つ
  $ docker run --rm \
    --env PULSE_SERVER=unix:/tmp/pulseaudio.socket \
    --env PULSE_COOKIE=/tmp/pulseaudio.cookie \
    --volume /tmp/pulseaudio.socket:/tmp/pulseaudio.socket \
    --volume /tmp/pulseaudio.client.conf:/etc/pulse/client.conf \
    --user $(id -u):$(id -g) \
    imagename


## あとはpandoc

texliveのくだりだけだね!

this is test



RUN  mkdir -p /home/$USERNAME/.local/share/fonts && \
    cd /home/$USERNAME/.local/share/fonts && \
    curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf


