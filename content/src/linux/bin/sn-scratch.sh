#!/bin/bash

show_help() {
    echo
    echo Usage : sn-scratch COMMAND [OPTIONS]
    echo
    echo Sonar Scratch, run a custom SonarQube container \for your project
    echo
    echo Options :
    echo "   --help      Print this help and quit"
    echo "   -h          Print this help and quit"
    echo "   --version   Print current version and quit"
    echo "   -v          Print current version and quit"
    echo "   --name [N]  SonarQube image name, default value : sonarqube"
    echo "   --port [P]  Exposed port, default value : 9000"
    echo "   --limit [L] Memory limit (example 800m), default value : no limit"
    echo "   --debug     Debug, default value : no debug"
    echo
    echo Commands :
    echo "   new         Start new Sonar Scratch container using custom configuration image"
    echo "   factory     Start new Sonar Scratch container using factory configuration"
    echo "   image       Pull ou push a Sonar Scratch configuration image"
    echo "   start       Start stopped Sonar Scratch container"
    echo "   stop        Stop running Sonar Scratch container"
    echo "   help        Print this help and quit"
    echo "   version     Print current version and quit"
    echo
    echo Run \'sn-scratch COMMAND --help\' \for more information on a command
    echo See https://github.com/tcdorg/sonarscratch-docker \for more details and examples
}

COMMANDS_PATH=$(dirname $(realpath $0))/../commands
if [ "$1" == "--help" ] || [ "$1" == "-h" ] || [ "$1" == "help" ]; then
    show_help
elif [ "$1" == "--version" ] || [ "$1" == "-v" ] || [ "$1" == "version" ]; then
    echo 1.0.0
elif [ "$1" == "new" ]; then
    if [ "$2" == "--help" ] || [ "$2" == "-h" ]; then
        echo
        echo Usage : sn-scratch new ROOT NAME [OPTIONS]
        echo
        echo Start new Sonar Scratch container using custom configuration image
        echo
        echo "  ROOT    Root path for images"
        echo "  NAME    Image name, a directory with same name must exists in root images path"
        echo "          Takes 'default' value if not specified"
        echo
        echo See https://github.com \for more details and examples
    else
        shift
        $COMMANDS_PATH/start-new.sh $@
    fi
elif [ "$1" == "factory" ]; then
    if [ "$2" == "--help" ] || [ "$2" == "-h" ]; then
        echo
        echo Usage : sn-scratch factory [OPTIONS]
        echo
        echo Start new Sonar Scratch container using factory configuration
        echo
        echo See https://github.com \for more details and examples
    else
        shift
        $COMMANDS_PATH/start-factory.sh $@
    fi
elif [ "$1" == "image" ]; then
    if [ "$2" == "--help" ] || [ "$2" == "-h" ]; then
        echo
        echo "Usage : sn-scratch image pull ROOT NAME"
        echo "        sn-scratch image push ROOT NAME"
        echo
        echo Pull ou push a Sonar Scratch configuration image
        echo
        echo "  ROOT    Root path for images"
        echo "  NAME    Image name. When pulling, a directory with same name must exists in root images path"
        echo "          Takes 'default' value if not specified"
        echo
        echo See https://github.com \for more details and examples
    else
        ROOT=$3
        if [ -z "$ROOT" ]; then
            echo Root path must be specified
            show_help
        else
            NAME=$4
            if [ -z "$NAME" ]; then
                NAME=default
            fi

            if [ "$2" == "push" ]; then
                TMP=$XDG_RUNTIME_DIR
                if [ -z "$TMP" ]; then
                    TMP=/tmp
                fi

                TMP=$TMP/snscratch-$RANDOM
                mkdir -p $TMP &&
                    $COMMANDS_PATH/push-images.sh $TMP &&
                    $COMMANDS_PATH/archive-images.sh $NAME $TMP $ROOT
                rm -rf $TMP
            elif [ "$2" == "pull" ]; then
                $COMMANDS_PATH/pull-images.sh $NAME $ROOT
            else
                if [ -z "$2" ]; then
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
    if [ "$2" == "--help" ] || [ "$2" == "-h" ]; then
        echo
        echo Usage : sn-scratch start [OPTIONS]
        echo
        echo Start stopped Sonar Scratch container
        echo
        echo See https://github.com \for more details and examples
    else
        shift
        $COMMANDS_PATH/start.sh $@
    fi
elif [ "$1" == "stop" ]; then
    if [ "$2" == "--help" ] || [ "$2" == "-h" ]; then
        echo
        echo Usage : sn-scratch stop
        echo
        echo Stop running Sonar Scratch container
        echo
        echo See https://github.com \for more details and examples
    else
        $COMMANDS_PATH/stop.sh
    fi
else
    if [ -z "$1" ]; then
        echo Command must be specified
    else
        echo Unknown command \'$1\'
    fi

    echo Only \'new\', \'factory\', \'image\', \'start\' and \'stop\' are accepted
    show_help
fi
