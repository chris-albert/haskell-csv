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
  let headers = commas $ getHeaders stream :: [String]
      indexs = getColumnsIndex headers selectedColumns :: [Int]
      l = commas <$> lines stream :: [[String]]
   in unlines $ fmap (`getRow` indexs) l
