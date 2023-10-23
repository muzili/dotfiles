export MAILDIR=$HOME/Mail
export LC_ALL=en_US.UTF-8
export EDITOR='nvim'
export ADB_INSTALL_TIMEOUT=20

PATH=/snap/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:${HOME}/bin:${HOME}/.local/bin:$HOME/.cargo/bin:$HOME/code/go/bin
if [ -f /usr/bin/javac ]; then
    export JAVA_HOME=$(dirname $(dirname $(readlink -f /usr/bin/javac)))
    [ ! -z "${JAVA_HOME}" ] && PATH=${PATH}:${JAVA_HOME}/bin
fi


[ -e "${HOME}/code/go" ] && export GOPATH=$HOME/code/go
export PATH

export PYTHONPATH=$PYTHONPATH:.

export ANDROID_SDK_ROOT=/usr/local/android-sdk
export ANDROID_HOME=/usr/local/android-sdk
export ANDROID_NDK_ROOT=/usr/local/android-sdk/ndk/25.2.9519653
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/tools
export PATH=$PATH:$ANDROID_NDK_ROOT
export USE_CCACHE=1
export NDK_CCACHE=/usr/bin/ccache
export ALIYUNPAN_CONFIG_DIR=$HOME/.config/aliyunpan
export CUDA_HOME=/usr/local/cuda
