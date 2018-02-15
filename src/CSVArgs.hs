{-# LANGUAGE DeriveDataTypeable #-}
module CSVArgs where

import System.Console.CmdArgs
import Control.Lens
import qualified Data.List.Split as S

data CSVArgs = CSVArgs 
  {
    headers :: Bool
    ,columns :: [String]
    ,showArgs :: Bool
    ,file :: Maybe FilePath
    ,noHeaders :: Bool
    ,width :: Maybe Int
  }
  deriving (Data,Typeable,Show,Eq)

csvArgs :: CSVArgs
csvArgs = CSVArgs
  {
    headers = def &= help "Display headers only" &= typ "Bool"
   ,columns = def &= help "Columns to display" &= typ "String"
   ,showArgs = def &= help "Prints parsed arguments" &= typ "Bool"
   ,file = def &= args &= typFile
   ,noHeaders = def &= help "Removes headers from output"
   ,width = def &= help "Width of each column"
  } &= summary "hcsv v0.0.1, (C) Chris Albert"

columnsL :: Lens' CSVArgs [String]
columnsL = lens columns (\a c -> a {columns = c})

fix :: CSVArgs -> CSVArgs
fix c = set columnsL (S.splitOn "," =<< columns c) c

getArgs :: IO CSVArgs
getArgs = fix <$> cmdArgs csvArgs
