{-# LANGUAGE RankNTypes #-}

module AOC2017.Challenge.Day21 (day21a, day21b) where

import           AOC2017.Types   (Challenge)
import           AOC2017.Util    ((!!!), strip)
import           Data.List       (transpose)
import           Data.List.Split (chunksOf, splitOn)
import qualified Data.Map        as M

type Grid = [[Bool]]

type Rules = M.Map Grid Grid

-- | Split a grid into a grid of subgrids
splitGrid :: Int -> Grid -> [[Grid]]
splitGrid n = transpose
            . map (map transpose . chunksOf n . transpose)
            . chunksOf n

-- | Join a grid of subgrids into a grid
joinGrid :: [[Grid]] -> Grid
joinGrid = transpose . concatMap (transpose . concat)

step :: Rules -> Grid -> Grid
step r g = joinGrid . (map . map) (r M.!) . splitGrid n $ g
  where
    n | length g `mod` 2 == 0 = 2
      | length g `mod` 3 == 0 = 3
      | otherwise             = error "hello there"

day21 :: Int -> Rules -> Int
day21 n r = length . filter id . concat
          $ iterate (step r) grid0 !!! n
  where
    grid0 = map (== '#') <$> [".#.","..#","###"]

day21a :: Challenge
day21a = show . day21 5 . parse

day21b :: Challenge
day21b = show . day21 18 . parse

-- | All 8 symmetries (elements of D8)
--
-- Generated by r, r^2, r^3, r^4, and flip times all of those
--
-- Thanks to https://en.wikipedia.org/wiki/Dihedral_group_of_order_8
symmetries :: Grid -> [Grid]
symmetries g = do
    r <- take 4 (iterate rot90 g)   -- from the four rotations
    [r, mirror r]                   -- ... include the rotation plus its flip
  where
    -- rotate 90 degrees
    rot90 = map reverse . transpose
    -- flip
    mirror = reverse

parse :: String -> Rules
parse = M.unions . map (M.fromList . parseLine) . lines
  where
    parseLine :: String -> [(Grid, Grid)]
    parseLine (map(splitOn "/".strip).splitOn"=>"->[xs,ys]) =
          [ (g, gridOut) | g <- symmetries gridIn ]
      where
        gridIn  = fmap (== '#') <$> xs
        gridOut = fmap (== '#') <$> ys
    parseLine _ = error "No parse"
