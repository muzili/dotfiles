export MAILDIR=$HOME/Mail
export LC_ALL=en_US.UTF-8
export EDITOR='nvim'
export SVN_EDITOR="rm svn-commit.tmp && cp ~/.gitmessage.3gdma svn-commit.tmp && vi svn-commit.tmp"
export ASYMPTOTE_PDFVIEWER=evince
export ASYMPTOTE_PSVIEWER=evince
export ALTERNATE_EDITOR=
export STUDIO_JDK=/usr/java/latest
export ANDROID_SDK_ROOT=/usr/local/android-sdk
#export ANDROID_NDK_ROOT=/usr/local/android-sdk/ndk-bundle
export ADB_INSTALL_TIMEOUT=20
export ANDROID_HOME=$ANDROID_SDK_ROOT
#export ANDROID_NDK_HOME=$ANDROID_NDK_ROOT
export ANDROID_TMP=/home/joshua/tmp
export NDK_TMPDIR=$ANDROID_TMP
export GOPATH=$HOME/code/go

## export JAVA_HOME JDK/JRE ##
export JAVA_HOME=$(dirname $(dirname $(readlink -f /usr/bin/javac)))

export PATH=/usr/local/cuda-11.2/bin:/snap/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:${HOME}/bin:${HOME}/.local/bin:${HOME}/.local/node_modules/.bin:${JAVA_HOME}/bin:$HOME/.cargo/bin:$HOME/code/go/bin
#export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/build-tools/27.0.3:/usr/local/go/bin:${HOME}/bin:${HOME}/.local/bin:${HOME}/.local/node_modules/.bin:${JAVA_HOME}/bin:$HOME/.cargo/bin:$HOME/code/go/bin:/mnt/eng-nfs/external/hisi-linux/x86-arm/Hi3559A_V100R001C02SPC020/aarch64-himix100-linux/bin:/mnt/eng-nfs/external/hisi-linux/x86-arm/Hi3516CV500R001C02SPC020/arm-himix200-linux/bin


export GOROOT=`go env GOROOT`

export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias bb='cd ~/data/nvr/nvr && ./build.sh && cd -'
alias lst='ls -lrt'

# 清华大学
# export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup  
# 中国科学技术大学
# export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
# export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup  
# 上海交通大学
#export RUSTUP_DIST_SERVER=https://mirrors.sjtug.sjtu.edu.cn/rust-static/
#
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
source "$HOME/.cargo/env"

[ -e $HOME/.sfplatformsdk ]  && source  $HOME/.sfplatformsdk
