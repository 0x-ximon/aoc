module Lib where

import Data.List (sort, sortOn, tails)
import qualified Data.Map.Strict as M
import Data.Ord (Down (..))

first :: [String] -> Int -> Int
first raw limit =
    let
        points = map (intoPoint . splitBy ',') raw
        distances = sort [(distance p q, p, q) | (p : rest) <- tails points, q <- rest]
        clusters = foldl (\dsu (_, p, q) -> union dsu p q) M.empty (take limit distances)
        circuits = foldl (\counts p -> increment counts p clusters) M.empty points
        top = take 3 (sortOn (Down . snd) (M.toList circuits))
     in
        case top of
            [(_, a), (_, b), (_, c)] -> a * b * c
            _ -> error "Not enough elements"

-- ---------------------------------------------------------------
--                             TYPES
-- ---------------------------------------------------------------

type Point = (Int, Int, Int)
type DSU = M.Map Point Point
type Counts = M.Map Point Int

-- ---------------------------------------------------------------
--                          ALGORITHMS
-- ---------------------------------------------------------------

distance :: Point -> Point -> Double
distance (a, b, c) (x, y, z) =
    sqrt (fromIntegral (((a - x) ^ (2 :: Int)) + ((b - y) ^ (2 :: Int)) + ((c - z) ^ (2 :: Int))))

increment :: Counts -> Point -> DSU -> Counts
increment counts p dsu = case M.lookup r counts of
    Just i -> M.insert r (i + 1) counts
    Nothing -> M.insert r 1 counts
  where
    r = find dsu p

find :: DSU -> Point -> Point
find dsu p = case M.lookup p dsu of
    Just q -> if p == q then q else find dsu q
    Nothing -> p

union :: DSU -> Point -> Point -> DSU
union dsu p q = case (M.notMember p dsu, M.notMember q dsu) of
    (True, True) -> M.insert q p (M.insert p p dsu)
    (True, False) -> M.insert p (find dsu q) dsu
    (False, True) -> M.insert q (find dsu p) dsu
    (False, False) ->
        let rootP = find dsu p
            rootQ = find dsu q
         in if rootP == rootQ
                then dsu
                else M.insert rootP rootQ dsu

-- ---------------------------------------------------------------
--                             HELPERS
-- ---------------------------------------------------------------

splitBy :: Char -> String -> [String]
splitBy delimiter string = case break (== delimiter) string of
    (chunk, []) -> [chunk]
    (chunk, _ : rest) -> chunk : splitBy delimiter rest

intoPoint :: [String] -> Point
intoPoint [x, y, z] = (read x, read y, read z)
intoPoint _ = error "Could not convert into point"
