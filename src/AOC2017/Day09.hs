module AOC2017.Day09 (day09a, day09b) where

import           AOC2017.Types        (Challenge)
import           Control.Applicative  (many)
import           Data.Maybe           (catMaybes)
import           Data.Void            (Void)
import qualified Text.Megaparsec      as P
import qualified Text.Megaparsec.Char as P

data Tree = Garbage String
          | Group   [Tree]

type Parser = P.Parsec Void String

parseTree :: Parser Tree
parseTree = P.choice [ Group   <$> parseGroup
                     , Garbage <$> parseGarbage
                     ]
  where
    parseGroup :: Parser [Tree]
    parseGroup = P.between (P.char '{') (P.char '}') $
        parseTree `P.sepBy` P.char ','
    parseGarbage :: Parser String
    parseGarbage = P.between (P.char '<') (P.char '>') $
        catMaybes <$> many garbageTok
      where
        garbageTok :: Parser (Maybe Char)
        garbageTok = P.choice
          [ Nothing <$ (P.char '!' *> P.anyChar)
          , Just    <$> P.noneOf ">"
          ]

treeScore :: Tree -> Int
treeScore = go 1
  where
    go _ (Garbage _ ) = 0
    go n (Group   ts) = n + sum (go (n + 1) <$> ts)

treeGarbage :: Tree -> Int
treeGarbage (Garbage n ) = length n
treeGarbage (Group   ts) = sum (treeGarbage <$> ts)

parse :: String -> Tree
parse = either (error . show) id . P.runParser parseTree ""

day09a :: Challenge
day09a = show . treeScore   . parse

day09b :: Challenge
day09b = show . treeGarbage . parse
