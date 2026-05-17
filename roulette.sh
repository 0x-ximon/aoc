#!/bin/zsh

# Array of the 16 specified programming languages
languages=(
    "Rust"
    "Go"
    "Zig"
    "Solidity"
    "C++"
    "C#"
    "C"
    "Closure"
    "Kotlin"
    "Swift"
    "Dart"
    "Gleam"
    "Python"
    "TypeScript"
    "Java"
    "Haskell"
)

total_languages=${#languages[@]}
random_index=$(( RANDOM % total_languages ))
selected_language=${languages[$random_index]}

echo "========================================="
echo "🎄 Advent of Code Language Roulette 🎄"
echo "========================================="
echo " Your language for today is:  $selected_language "
echo "========================================="