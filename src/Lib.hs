module Lib where

import qualified Data.List.Split as S
import Data.List
-- Headers

splitComma :: String -> [String]
splitComma = S.splitOn "," 

getAndFormatHeaders :: String -> String
getAndFormatHeaders = formatHeaders . getHeaders

getHeaders :: String -> String
getHeaders = head . lines

formatHeaders :: String -> String
formatHeaders = unlines . splitComma

-- Columns

getColumnsIndex :: [String] -> [String] -> [Int]
getColumnsIndex allColumns columns = 
  columns >>= (`elemIndices` allColumns)

getColumns :: [String] -> String -> String
getColumns selectedColumns stream =
  let headers = splitComma $ getHeaders stream :: [String]
      indexs = getColumnsIndex headers selectedColumns :: [Int]
      l = splitComma <$> lines stream :: [[String]]
   in unlines [ line !! c | line <- l, c <- indexs]    
