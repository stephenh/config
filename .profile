
#
# For GUIs:
# * .profile is loaded on login
# * .bashrc is loaded when new shells launch
# * .bash_profile is not loaded on login
#
# For SSH:
# * .profile is not loaded
# * .bashrc is not loaded
# * .bash_profile is loaded
#
# So our .bash_profile conditionallys loaded .profile and .bashrc.
#
# See: http://askubuntu.com/a/121075/156471
#

export EDITOR=vim

if [ -d /opt/local/bin ] ; then
    export PATH=/opt/local/bin:$PATH
fi

if [ -d /usr/lib/jvm/java-8-oracle/ ] ; then
    export JAVA_HOME=/usr/lib/jvm/java-8-oracle
    export PATH=$JAVA_HOME/bin:$PATH
elif [ -d /usr/lib/jvm/java-7-oracle/ ] ; then
    export JAVA_HOME=/usr/lib/jvm/java-7-oracle
    export PATH=$JAVA_HOME/bin:$PATH
elif [ -d /usr/lib/jvm/java-7-openjdk-amd64/ ] ; then
    export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
    export PATH=$JAVA_HOME/bin:$PATH
elif [ -d /usr/lib/jvm/java-6-sun ] ; then
    export JAVA_HOME=/usr/lib/jvm/java-6-sun
    export PATH=$JAVA_HOME/bin:$PATH
fi

# Random apps go into ~/apps, so put all bin folders, e.g. ~/apps/apache-ant-whatever/bin/, on the path
for dir in ~/apps/* ; do
    if [ -d $dir/bin ] ; then
        export PATH=$PATH:$dir/bin
    fi
done

# Same for tools, I guess
for dir in ~/tools/* ; do
    if [ -d $dir/bin ] ; then
        export PATH=$PATH:$dir/bin
    fi
done

if [ -d /var/lib/gems/1.8 ] ; then
    export PATH=$PATH:/var/lib/gems/1.8/bin
fi
if [ -d /var/lib/gems/1.9.1 ] ; then
    export PATH=$PATH:/var/lib/gems/1.9.1/bin
fi

# EC2
if [ -d ~/bizo/aws-tools ] ; then
    # keys are needed by ec2- commands.
    if [ -d ~/.aws-tools ] ; then
        export EC2_PRIVATE_KEY=`ls -1 ~/.aws-tools/pk-*.pem|head -1`
        export EC2_CERT=`ls -1 ~/.aws-tools/cert-*.pem|head -1`
    fi
fi

# For vimrc
export TEMP=$HOME/.temp
export PATH=$PATH:~/tools

# For go
if [ -d /usr/share/go ]; then
  export GOPATH="/usr/share/go/"
fi

export PATH=$PATH:~/bin

# for LI stuff
if [ -d /export/apps ]; then
  export JAVA_HOME=/export/apps/jdk/JDK-1_8_0_40
  export JDK_HOME=/export/apps/jdk/JDK-1_8_0_40
  export NLS_LANG=American_America.UTF8
  export M2_HOME=/local/maven
  export M2=$M2_HOME/bin
  export PATH=$JAVA_HOME/bin:/usr/local/bin:/usr/local/mysql/bin:/usr/local/linkedin/bin:$PATH
fi
if [ -d /export/content/linkedin ]; then
  export PATH=/export/content/linkedin/bin:$PATH
fi

# For rust
export PATH="$HOME/.cargo/bin:$PATH"


