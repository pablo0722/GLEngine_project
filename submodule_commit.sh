#!/bin/bash
function git_submodule_commit {
    local dir=$1
    local msg=$2
    local branch=$3
    local last_pwd=$(pwd)
    echo "1- message: $msg"
    echo "1- branch: $branch"
    echo "pwd: $(pwd)"
    dir=${dir//\'}
    cd "$(pwd)/$dir"
    declare -a arr=($(git submodule  foreach --recursive))
    if [ ${#arr[@]} -ne 0 ]; then
        local i
        for i in "${arr[@]}"
        do
            if [[ $i != *"Entering"* ]]; then
                git_submodule_commit "$i" "$msg" "$branch"
            fi
        done
    fi

    git add --all .
    echo "2- message: $msg"
    echo "2- branch: $branch"
    git commit -m "$msg"
    git push origin "$branch"

    cd $last_pwd
}

if [ $# -ne 2 ]; then
    echo "Usage: $0 msg branch"
    exit 1
fi

msg=$1
branch=$2
git_submodule_commit "." "$msg" "$branch"