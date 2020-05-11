#!/bin/bash

function prop {
    grep "${1}" ${2} | cut -d '=' -f2
}

function propCredentials {
    CREDENTIALS=''

    OPENSUBTITLES_CREDENTIALS=`prop opensubtitles.credentials $1`
    if ! [ -z "$OPENSUBTITLES_CREDENTIALS" ]; then
        CREDENTIALS+="--opensubtitles $OPENSUBTITLES_CREDENTIALS "
    fi

    ADDICTED_CREDENTIALS=`prop addic7ed.credentials $1`
    if ! [ -z "$ADDICTED_CREDENTIALS" ]; then
        CREDENTIALS+="--addic7ed $ADDICTED_CREDENTIALS "
    fi

    LEGENDASTV_CREDENTIALS=`prop legendas.credentials $1`
    if ! [ -z "$LEGENDASTV_CREDENTIALS" ]; then
        CREDENTIALS+="--legendastv $LEGENDASTV_CREDENTIALS "
    fi

    echo $CREDENTIALS | xargs
}

function propLanguages {
    LANGUAGES=`prop languages $1`

    echo "-l $LANGUAGES"
}

