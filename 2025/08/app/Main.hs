module Main (main) where

import Lib

main :: IO ()
main = do
    raw <- readFile "input.txt"
    let contents = lines raw

    let firstAnswer = first contents 1000
    putStrLn $ "First Answer: " ++ show firstAnswer
