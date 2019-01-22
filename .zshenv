export MAILDIR=$HOME/Mail
export LC_ALL=en_US.UTF-8
export EDITOR='emacs -nw'
export SVN_EDITOR="rm svn-commit.tmp && cp ~/.gitmessage.3gdma svn-commit.tmp && vi svn-commit.tmp"
export ASYMPTOTE_PDFVIEWER=evince
export ASYMPTOTE_PSVIEWER=evince
export ALTERNATE_EDITOR=
export STUDIO_JDK=/usr/java/latest
export ANDROID_SDK_ROOT=/usr/local/android-sdk
export ANDROID_NDK_ROOT=/usr/local/android-sdk/ndk-bundle
export ADB_INSTALL_TIMEOUT=20
export ANDROID_HOME=$ANDROID_SDK_ROOT
export ANDROID_NDK_HOME=$ANDROID_NDK_ROOT
export ANDROID_TMP=/home/joshua/tmp
export NDK_TMPDIR=$ANDROID_TMP
export GOPATH=$HOME/code/go
export GOROOT=`go env GOROOT`

## export JAVA_HOME JDK/JRE ##
export JAVA_HOME=$(dirname $(dirname $(readlink -f /usr/bin/javac)))

export PATH=$PATH:$ANDROID_NDK_ROOT:$ANDROID_SDK_ROOT:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/build-tools/27.0.3:${GOPATH}/bin:${HOME}/bin:${HOME}/.local/bin:${HOME}/.local/node_modules/.bin:${JAVA_HOME}/bin:$HOME/.cargo/bin


export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
