#!/bin/bash

project_name=$(grep 'let siteName' Project.swift | sed 's/.*"\(.*\)"/\1/')

for arg in "$@"; do
    case $arg in
        --c|--clean)
            tuist clean
            ;;
        --dc|--deepClean)
            tuist clean
            git clean -fd
            rm -rf ~/Library/Developer/Xcode/DerivedData/"$project_name"*
            ;;
    esac
done

tuist generate --no-open
rm -rf "$project_name.xcworkspace"
open "$project_name.xcodeproj"
