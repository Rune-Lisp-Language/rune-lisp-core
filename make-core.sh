#!/bin/sh


VERSION_AS=$(as --version | grep -o "[0-9]\.[0-9][0-9].[0-9]")
VERSION_LD=$(ld --version | grep -o "[0-9]\.[0-9][0-9].[0-9]")


echo "                                     "
echo " ╔═════════════════════════════════╗ "
echo " ║     GNU Assembler & Linker      ║ "
echo " ╚═════════════════════════════════╝ "
echo "                                     "
echo "       ■ as: $VERSION_AS             "
echo "       ■ ld: $VERSION_LD             "
echo "                                     "
echo "       x86_64-pc-linux-gnu           "
echo "                                     "
echo " ─────────────────────────────────── "
echo "                                     "



SRC_DIR="src"
BUILD_DIR="build"
OBJ_DIR=${BUILD_DIR}/obj
BIN_DIR=${BUILD_DIR}/bin

NAME_EXE="runec-core"


SUBDIR_ENTRY="entry"
SUBDIR_SHARE="share"
SUBDIR_LANG_CORE="lang-core"


MODULES_ENTRY=(
    "main"
    "args"
    "errors"
)

MODULES_SHARE=(
    "syscalls"
    "len"
    "print"
    "read"
    "write"
)

MODULES_LANG_CORE=(
    "atoms"
    "symbols"
)


LINK_NAMES=()



function build {
    local subdir=$1
    local modules=$2[@]

    for name in ${!modules}
    do
	local source=${SRC_DIR}/${subdir}/${name}.asm
	local output=${OBJ_DIR}/${subdir}/${name}.o

	as --64 -march=corei7 -mtune=corei7 -warn -o $output $source

        if [ $? -eq 0 ]
	then
	    echo "    ->" ${source} assembled
	    LINK_NAMES+=($output)
	else
	    echo "    ||" ${source} not assembled
	fi

    done

    echo " "
}


function link {
    local objects=$1[@]

    ld \
	-b elf64-x86-64 \
	--dynamic-linker /lib64/ld-linux.so.2 \
	-nostdlib \
	-e _start \
	-s ${!objects} \
	-o ${BIN_DIR}/${NAME_EXE}

    if [ $? -eq 0 ]
    then
	for name in ${!objects}
	do
	    echo "    ->" $name linked
	done
	echo " "
    fi
}


function make {
    echo " [ ** ]: Assembly"
    echo " "

    build $SUBDIR_ENTRY MODULES_ENTRY

    if [ $? -eq 0 ]
    then
	build $SUBDIR_SHARE MODULES_SHARE

	if [ $? -eq 0 ]
	then
	    build $SUBDIR_LANG_CORE MODULES_LANG_CORE

	    if [ $? -eq 0 ]
	    then
		echo " [ OK ]: Assembly complete"
		echo " "
	    else
		echo " [ ER ]: Assembly" ${SUBDIR_LANG_CORE}
	    fi

        else
	    echo " [ ER ]: Assembly" ${SUBDIR_SHARE}
	fi

    else
	echo " [ ER ]: Assembly" ${SUBDIR_ENTRY}
    fi


    echo " "
    echo " [ ** ]: Static link"
    echo " "

    link LINK_NAMES

    if [ $? -eq 0 ]
    then
	echo " [ OK ]: Link complete"
    else
	echo " [ ER ]: Link error"
    fi

    echo " "
    echo "    ->" ${BIN_DIR}/${NAME_EXE} "executable"
    echo " "
}



make
