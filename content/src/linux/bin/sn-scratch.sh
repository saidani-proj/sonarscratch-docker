#!/bin/bash

show_help () {
    echo
    echo Usage : sn-scratch [OPTIONS] COMMAND
    echo
    echo Sonar Scratch, run a custom SonarQube container \for your project
    echo
    echo Options :
    echo "   --help    Print this help and quit"
    echo "   -h        Print this help and quit"
    echo "   --version Print current version and quit"
    echo "   -v        Print current version and quit"
    echo
    echo Commands :
    echo "   new       Start new Sonar Scratch container using custom configuration image"
    echo "   factory   Start new Sonar Scratch container using factory configuration"
    echo "   image     Pull ou push a Sonar Scratch configuration image"
    echo "   start     Start stopped Sonar Scratch container"
    echo "   stop      Stop running Sonar Scratch container"
    echo "   help      Print this help and quit"
    echo "   version   Print current version and quit"
    echo
    echo Run \'sn-scratch COMMAND --help\' \for more information on a command
    echo See https://github.com \for more details and examples
}

if [ "$1" == "--help" ] || [ "$1" == "-h" ] || [ "$1" == "help" ] ; then
    show_help
elif [ "$1" == "--version" ] || [ "$1" == "-v" ] || [ "$1" == "version" ] ; then
    echo 1.0.0
elif [ "$1" == "new" ] ; then
    if [ "$2" == "--help" ] || [ "$2" == "-h" ] ; then
        echo
        echo Usage : sn-scratch new ROOT NAME [-d]
        echo
        echo Start new Sonar Scratch container using custom configuration image
        echo
        echo "  ROOT    Root path for images"
        echo "  NAME    Image name, a directory with same name must exists in root images path"
        echo "          Takes 'default' value if not specified"
        echo "  -d      Activate debug mode"
        echo
        echo See https://github.com \for more details and examples
    else
        $(dirname $(realpath $0))/../commands/start-new.sh $2 $3 $4
    fi
elif [ "$1" == "factory" ]; then
    if [ "$2" == "--help" ] || [ "$2" == "-h" ] ; then
        echo
        echo Usage : sn-scratch factory [-d]
        echo
        echo Start new Sonar Scratch container using factory configuration
        echo
        echo "  -d      Activate debug mode"
        echo
        echo See https://github.com \for more details and examples
    else
        $(dirname $(realpath $0))/../commands/start-factory.sh $2
    fi
elif [ "$1" == "image" ]; then
    if [ "$2" == "--help" ] || [ "$2" == "-h" ] ; then
        echo
        echo "Usage : sn-scratch image pull ROOT NAME [-d]"
        echo "        sn-scratch image push ROOT NAME [-d]"
        echo
        echo Pull ou push a Sonar Scratch configuration image
        echo
        echo "  ROOT    Root path for images"
        echo "  NAME    Image name. When pulling, a directory with same name must exists in root images path"
        echo "          Takes 'default' value if not specified"
        echo "  -d      Activate debug mode"
        echo
        echo See https://github.com \for more details and examples
    else
        ROOT=$3
        if [ -z "$ROOT" ] ; then
            echo Root path must be specified
            show_help
        else
            NAME=$4
            if [ -z "$NAME" ] ; then
                NAME=default
            fi

            if [ "$2" == "push" ] ; then
                TMP=$XDG_RUNTIME_DIR
                if [ -z "$TMP" ] ; then
                    TMP=/tmp
                fi

                TMP=$TMP/snscratch-$RANDOM
                mkdir -p $TMP \
                && $(dirname $(realpath $0))/../commands/push-images.sh $TMP \
                && $(dirname $(realpath $0))/../commands/archive-images.sh $NAME $TMP $ROOT
                rm -rf $TMP
            elif [ "$2" == "pull" ]; then
                $(dirname $(realpath $0))/../commands/pull-images.sh $NAME $ROOT
            else
                if [ -z "$2" ] ; then
                    echo Image command must be specified
                else
                    echo Unknown image command \'$2\'
                fi
                
                echo Only \'push\', \'pull\' are accepted
                show_help
            fi
        fi
    fi
elif [ "$1" == "start" ]; then
    if [ "$2" == "--help" ] || [ "$2" == "-h" ] ; then
        echo
        echo Usage : sn-scratch start
        echo
        echo Start stopped Sonar Scratch container
        echo
        echo See https://github.com \for more details and examples
    else
        $(dirname $(realpath $0))/../commands/start.sh $2
    fi
elif [ "$1" == "stop" ]; then
    if [ "$2" == "--help" ] || [ "$2" == "-h" ] ; then
        echo
        echo Usage : sn-scratch stop
        echo
        echo Stop running Sonar Scratch container
        echo
        echo See https://github.com \for more details and examples
    else
        $(dirname $(realpath $0))/../commands/stop.sh
    fi
else
    if [ -z "$1" ] ; then
        echo Command must be specified
    else
        echo Unknown command \'$1\'
    fi
    
    echo Only \'new\', \'factory\', \'image\', \'start\' and \'stop\' are accepted
    show_help
fi