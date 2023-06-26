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



function build {
    echo " [ ** ]: Assembly sources"
    echo

    for subdir in ${SRC_DIR}/*
    do
	for source in ${subdir}/*
	do
	    if [ -f $source ]
	    then
	        local output=${source//${SRC_DIR}/${OBJ_DIR}}
		local output=${output//".asm"/".o"}

		mkdir -p ${subdir//${SRC_DIR}/${OBJ_DIR}}

		as --64 -march=corei7 -mtune=corei7 -warn -o $output $source

		echo "    ->  source:  $source assembled"
		echo "        output:  $output"
		echo
	    fi
	done
    done

    echo " [ OK ]: Assembly complete"
    echo
    echo
}


function link {
    echo " [ ** ]: Static link objects"
    echo

    local objects=()
    local path_exe=${BIN_DIR}/${NAME_EXE}

    mkdir -p $BIN_DIR

    for subdir in ${OBJ_DIR}/*
    do
	for obj in ${subdir}/*
	do
	    if [ -f $obj ]
	    then
		objects+=($obj)
		echo "     -> add $obj"
	    fi
	done
    done

    ld \
	-b elf64-x86-64 \
	--dynamic-linker /lib64/ld-linux.so.2 \
	-nostdlib \
	-e _start \
	-s ${objects[@]} \
	-o $path_exe

    echo
    echo " [ OK ]: Link complete"
    echo
    echo " ─────────────────────────────────── "
    echo
    echo " Executable: $path_exe"
    echo
}



build
link
