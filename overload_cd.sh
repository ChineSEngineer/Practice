#!usr/bin/env bash
export PATH_QUEUE_FILE=~/.path_queue_file
alias cd=ggg

function ggg() {
    local shell_name=$(basename $SHELL) 
    local prog_name=$(basename $0)
    local ggg_path=$1

    if [[ -z $1 ]];then
        echo "$shell_name: Usage: $prog_name [path]"
        false
    elif [[ ! -f "$PATH_QUEUE_FILE" ]];then
        echo "$shell_name: $prog_name: Please set variable PATH_QUEUE_FILE"
        false
    elif [[ $ggg_path == "-" || $ggg_path == "." || $ggg_path == ".." || $ggg_path == "../*" ]];then
        builtin cd $ggg_path
    else 

        builtin cd $ggg_path > /dev/null 2>&1
        if [[ $? == 1 ]];then
            local queried_path
            queried_path=$(path_queue_query $ggg_path)
            if [[ $? == 0 ]];then
                #echo "Correct the path automatically"
                builtin cd $queried_path
                path_queue_push $queried_path
            else
                echo "$shell_name: $prog_name: $1: No such file or directory"
                false
            fi
        else
            ggg_path=$(pwd)
            path_queue_push $ggg_path
        fi

    fi
}

function path_queue_push() {
    if [[ -z $1 ]];then
        return 1
    fi

    local element=$1

    while IFS='' read -r line;do 
        if [[ $line == $element ]];then
            sed -i "\+^${line}$+d" $PATH_QUEUE_FILE
            echo $line >> $PATH_QUEUE_FILE
            return 0
        fi
    done < $PATH_QUEUE_FILE

    echo $element >> $PATH_QUEUE_FILE
    local nline=$(wc -l < $PATH_QUEUE_FILE)
    if [[ $nline -gt 100 ]];then
        sed -i '1d' $PATH_QUEUE_FILE
    fi
    return 0
}

function path_queue_query() {
    if [[ -z $1 ]];then
        return 1
    fi

    while IFS='' read -r line;do 
        local bname=$(basename $line)
        if [[ $bname == $1 ]];then
            echo $line
            return 0
        fi
    done < $PATH_QUEUE_FILE
    return 1
}

