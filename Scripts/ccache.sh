#!/bin/sh

source $(dirname $0)/ccache-config.sh

if [ -z "$DEVELOPER_DIR" ]; then
    
    CLANG=/usr/bin/clang
    
else
    
    CLANG=$DEVELOPER_DIR/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
    
fi

if type -p ccache > /dev/null 2>&1; then
    
    if test -f ~/.distcc/hosts && type -p distcc > /dev/null 2>&1; then
        
        export CCACHE_PREFIX="distcc"
        
    elif test -f ~/.distcc/hosts && type -p /usr/local/distcc/bin/distcc > /dev/null 2>&1; then
        
        export CCACHE_PREFIX="/usr/local/distcc/bin/distcc"
        
    fi
    
    exec ccache $CLANG "$@"
    
else
    
    exec $CLANG "$@"
    
fi
