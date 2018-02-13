{-# LANGUAGE DeriveDataTypeable #-}
{-# OPTIONS_GHC -fno-cse #-}
module Main where

import System.IO
import qualified Lib as L
import System.Console.CmdArgs
import System.Exit
import Control.Exception

main :: IO ()
main = handleArgs

handleArgs :: IO ()
handleArgs = do
  args <- cmdArgs csvArgs
  stream <- handleDataStream args
  let output = dispatch args stream
  putStr output

dispatch :: CSVArgs -> String -> String
dispatch (CSVArgs True _) = L.getAndFormatHeaders
dispatch (CSVArgs False _) = id

handleDataStream :: CSVArgs -> IO String
handleDataStream (CSVArgs _ Nothing) = 
  getContents
handleDataStream (CSVArgs _ (Just fileName)) = 
  hGetContents =<< openFile fileName ReadMode


-- CmdArgs definitions
data CSVArgs = CSVArgs 
  {headers :: Bool
  ,file :: Maybe FilePath
  }
  deriving (Data,Typeable,Show,Eq)

csvArgs :: CSVArgs
csvArgs = CSVArgs
  {headers = def &= help "Display headers" &= typ "Bool"
  ,file = def &= args &= typFile
  }
