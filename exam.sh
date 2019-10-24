#!usr/bin/env bash
EXAM_FOLDER="/home/heyisun/Documents/study/CS-GY9053/exam"
JAVA_FOLDER="${EXAM_FOLDER}/src/main/java"
TEST_FOLDER="${JAVA_FOLDER}/com/test"
EXAM_JAR_FILE="${EXAM_FOLDER}/fall2019-midterm.jar"
EXAM_EMAIL="hs3880@nyu.edu"
EXAM_PASSWORD="***"

function answer-file() {
    local problem=$1
    local filepath=$2

    java -cp ${EXAM_JAR_FILE} edu.nyu.cs9053.Exam answer-file ${EXAM_EMAIL} ${EXAM_PASSWORD} ${problem} ${filepath}
}

function answer-file-test() {
    local problem=$1 local filepath=$2

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

