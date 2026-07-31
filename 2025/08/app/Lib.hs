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

second :: [String] -> Int
second raw =
    let
        points = map (intoPoint . splitBy ',') raw
        distances = sort [(distance p q, p, q) | (p : rest) <- tails points, q <- rest]
        (_, _, pair) = foldl (\(dsu, c, r) (_, p, q) -> track dsu c p q r) (M.empty, length points, Nothing) distances
     in
        case pair of
            Just ((a, _, _), (x, _, _)) -> a * x
            Nothing -> error "Pair not located"

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

track :: DSU -> Int -> Point -> Point -> Maybe (Point, Point) -> (DSU, Int, Maybe (Point, Point))
track dsu circuits p q result = case result of
    Just r -> (dsu, circuits, Just r)
    Nothing ->
        let
            x = find dsu p
            y = find dsu q
            c = if x == y then circuits else circuits - 1
            m = merge dsu p q
         in
            if c == 1
                then (m, c, Just (p, q))
                else (m, c, Nothing)

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

merge :: DSU -> Point -> Point -> DSU
merge dsu p q =
    if x == y
        then dsu
        else M.insert y x (M.insert x x dsu)
  where
    x = find dsu p
    y = find dsu q

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
