module Lib where

import qualified Data.List.Split as S
import Data.List
-- Headers

commas :: String -> [String]
commas = S.splitOn "," 

uncommas :: [String] -> String
uncommas = intercalate ","

getAndFormatHeaders :: String -> String
getAndFormatHeaders = formatHeaders . getHeaders

getHeaders :: String -> String
getHeaders = head . lines

killHeaders :: String -> String
killHeaders = unlines . tail . lines

formatHeaders :: String -> String
formatHeaders = unlines . commas

-- Columns

getColumnsIndex :: [String] -> [String] -> [Int]
getColumnsIndex allColumns columns = 
  columns >>= (`elemIndices` allColumns)

getRow :: [String] -> [Int] -> String
getRow columns indexs =
  uncommas $ fmap (columns !!) indexs

getColumns :: [String] -> String -> String
getColumns selectedColumns stream =
  let headers = commas $ getHeaders stream
      indexs  = getColumnsIndex headers selectedColumns
      l       = commas <$> lines stream
   in unlines $ fmap (`getRow` indexs) l

formatColumns :: Int -> String -> String
formatColumns width stream = fieldLens stream (pad width)

pad :: Int -> String -> String
pad w i = 
  let cut = take w (remove ' ' i)
      diff = w - length cut
  in if diff > 0 then cut ++ replicate diff ' ' else cut

remove :: Eq a => a -> [a] -> [a]
remove i []   = []
remove i (x:xs) = if x == i then remove i xs else x : remove i xs 

fieldLens :: String -> (String -> String) -> String
fieldLens stream func = 
  let fields = commas <$> lines stream
      mapped = fmap (fmap func) fields
   in unlines $ fmap uncommas mapped 
