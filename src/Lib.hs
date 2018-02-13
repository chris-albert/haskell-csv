module Lib where

import qualified Data.List.Split as S

splitComma :: String -> [String]
splitComma = S.splitOn "," 

getAndFormatHeaders :: String -> String
getAndFormatHeaders = formatHeaders . getHeaders

getHeaders :: String -> String
getHeaders s = head $ lines s

formatHeaders :: String -> String
formatHeaders s = unlines $ splitComma s 

