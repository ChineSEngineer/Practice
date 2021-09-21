#!/bin/bash

function rm_except() {
    local options=()
    local files=()
    local cmd=("rm")
    local option_end=0
    local program=${FUNCNAME[0]}


    while [[ "$#" -gt 0 ]]; do
        key="$1"
        if [[ $option_end -eq 0 ]] && [[ $key =~ ^-.* ]]; then
            if [[ $key == "--help" ]]; then
                rm --help | sed -e "s/rm/$program/"
                return 0
            fi
            if [[ $key == "--" ]]; then
                option_end=1
            else
                cmd+=("$key")
            fi
        else
            if [[ "$key" =~ .*/$ ]]; then  # endwith /
                key=${key::-1}
            fi
            if [[ "$key" =~ ^\./.* ]]; then   # startwith ./
                key=${key:2}
            fi
            files+=("$key")
        fi  
        shift
    done 

    if [[ ${#files[@]} -eq 0 ]]; then
        echo -e "$program: missing operand\nTry '$program --help' for more information"
        return 1
    fi 

    local files_str='-- !('
    for file in "${files[@]}"; do
        files_str+="$file|"
    done
    files_str="${files_str%?})"  # strip the last character and add a parentheses

    cmd+=("$files_str")
    echo "${cmd[@]}"
    shopt -s extglob
    shopt -s dotglob
    eval "${cmd[@]}"
    shopt -u dotglob
    shopt -u extglob
}


