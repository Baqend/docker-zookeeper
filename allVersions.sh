#!/bin/bash
# read parameters
. params.sh

# Now check all given arguments:
for var in "$@"; do
    if [[ "$var" == "build" ]]; then
        eval "$var=$var"
    elif [[ "$var" == "push" ]]; then
        eval "$var=$var"
    else
        echo "unknown argument: $var"
    fi
done

# Put all versions into an array:
IFS=', ' read -r -a allVersionsArray <<< "$allVersions"
export allVersionsArray=$allVersionsArray

# iterate over all versions
for index in "${!allVersionsArray[@]}"; do
    version=${allVersionsArray[index]}
    if ! [[ -z "$build" ]]; then
        echo building $version:
        tags="--tag $image:$version"
        if [[ $version == $latest ]]; then
            tags="$tags --tag $image:latest"
        fi
        buildCmd="docker build $tags --build-arg BIN_VERSION=$version $dir"
        echo "executing: $buildCmd"
        eval "$buildCmd"
    fi
    if ! [[ -z "$push" ]]; then
        echo pushing $version:
        pushCmd="docker push $image:$version"
        echo "executing: $pushCmd"
        eval "$pushCmd"
    fi
done
