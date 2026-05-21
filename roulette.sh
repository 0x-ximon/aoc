#!/bin/zsh

# Array of the 16 specified programming languages
languages=(
    "C"
    "C#"
    "C++"
    "Dart"
    "Gleam"
    "Go"
    "Haskell"
    "Java"
    "Kotlin"
    "Lisp"
    "Lua"
    "Python"
    "Rust"
    "Swift"
    "TypeScript"
    "Zig"
)

total_languages=${#languages[@]}
random_index=$(( RANDOM % total_languages ))
selected_language=${languages[$random_index]}

echo "========================================="
echo "🎄 Advent of Code Language Roulette 🎄"
echo "========================================="
echo " Your language for today is:  $selected_language "
echo "========================================="
