#!usr/bin/env bash
export PATH_QUEUE_FILE=~/.path_queue_file
EXAM_FOLDER="/home/heyisun/Documents/study/CS-GY9053/exam"
JAVA_FOLDER="${EXAM_FOLDER}/src/main/java"
TEST_FOLDER="${JAVA_FOLDER}/com/test"
EXAM_JAR_FILE="${EXAM_FOLDER}/fall2019-midterm.jar"
EXAM_EMAIL="hs3880@nyu.edu"
EXAM_PASSWORD="MjNhYzY0YTktYTcyMC00NGU5LWJjMjItNTcwOGIzN2NkMTlm"

function answer-file() {
    local problem=$1
    local filepath=$2

    java -cp ${EXAM_JAR_FILE} edu.nyu.cs9053.Exam answer-file ${EXAM_EMAIL} ${EXAM_PASSWORD} ${problem} ${filepath}
}

function answer-file-test() {
    local problem=$1
    local filepath=$2

    java -cp ${EXAM_JAR_FILE} edu.nyu.cs9053.Exam answer-file-test ${EXAM_EMAIL} ${EXAM_PASSWORD} ${problem} ${filepath}
}

function answer() {
    local problem=$1
    local my_answer=$2

    java -cp ${EXAM_JAR_FILE} edu.nyu.cs9053.Exam answer ${EXAM_EMAIL} ${EXAM_PASSWORD} ${problem} "${my_answer}"
}

function take_exam() {
    java -cp ${EXAM_JAR_FILE} edu.nyu.cs9053.Exam take ${EXAM_EMAIL} ${EXAM_PASSWORD}
}

function authenticate() {
    java -cp ${EXAM_JAR_FILE} edu.nyu.cs9053.Exam authenticate ${EXAM_EMAIL}
}

function goto() {
    if [[ -z $1 || $1 == "exam" ]];then
        cd "${EXAM_FOLDER}"
    elif [[ $1 == "code" ]];then
        cd "${EXAM_FOLDER}/../code"
    elif [[ $1 == "test" ]];then
        cd "${TEST_FOLDER}"
    elif [[ $1 == "java" ]];then
        cd "${JAVA_FOLDER}"
    else
        local number=$1
        cd "${EXAM_FOLDER}/../fall-2019-i-homework-${number}-ChineSEngineer"
    fi
}

function vvv() {
    local filename=$1
    local javafile="${TEST_FOLDER}/$filename.java"
    if [[ ! -f $javafile ]];then
        touch $javafile
        echo -e "package com.test;\n\npublic class $filename {\n}" > $javafile
    fi
    vim $javafile
}

function ccc() {
    local filename=$1
    local javafile="${TEST_FOLDER}/$filename.java"
    javac -sourcepath ${JAVA_FOLDER} $javafile
}

function ppp() {
    local filename=$1

    ccc $filename
    if [[ $? == 0 ]];then
        java -cp ${JAVA_FOLDER} "com.test.$filename"
    fi
}

function rrr() {
    local filename=$1
    local javafile="${TEST_FOLDER}/$filename.java"
    local classfile="${TEST_FOLDER}/$filename.class"
    rm -rf $javafile $classfile
}

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

