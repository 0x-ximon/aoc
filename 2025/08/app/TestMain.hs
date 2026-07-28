module TestMain where

import Lib
import System.Exit (exitFailure)

assert :: (Eq a, Show a) => a -> a -> IO ()
assert expected actual =
    if expected == actual
        then putStrLn "Test Passed."
        else do
            putStrLn $ "Test Failed; Expected: " ++ show expected ++ ", Actual: " ++ show actual
            exitFailure

d :: [String]
d =
    [ "162,817,812"
    , "57,618,57"
    , "906,360,560"
    , "592,479,940"
    , "352,342,300"
    , "466,668,158"
    , "542,29,236"
    , "431,825,988"
    , "739,650,466"
    , "52,470,668"
    , "216,146,977"
    , "819,987,18"
    , "117,168,530"
    , "805,96,715"
    , "346,949,466"
    , "970,615,88"
    , "941,993,340"
    , "862,61,35"
    , "984,92,344"
    , "425,690,689"
    ]

testMain :: IO ()
testMain =
    let
        firstExpected = 40
        firstActual = first d 10
     in
        assert firstExpected firstActual
