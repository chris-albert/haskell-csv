{-# OPTIONS_GHC -fno-cse #-}
module Main where

import System.IO
import qualified Lib as L
import System.Exit
import Control.Exception
import CSVArgs
import Data.Maybe


main :: IO ()
main = handleArgs

handleArgs :: IO ()
handleArgs = do
  args <- getArgs
  stream <- handleDataStream $ file args
  let output = dispatch args stream
  putStr output

dispatch :: CSVArgs -> String -> String
-- If we just want to print the arguments
dispatch csv @ (CSVArgs _ _ True _ _ _) = const $ show csv
-- If we aren't doing anything, then just pass through
dispatch (CSVArgs _ _ _ _ True _) = L.killHeaders
-- If we are printing the body
dispatch csvArgs = 
  let body    = dispatchPrint csvArgs
   in runFormats csvArgs . body

runFormats :: CSVArgs -> String -> String
runFormats args = 
  foldl (\f i -> if fst i args then snd i else id) id formatFuncs

formatFuncs :: [(CSVArgs -> Bool,String -> String)]
formatFuncs = 
  [
    (noHeaders,L.killHeaders)
    ,(isJust . width,id)
  ]

dispatchPrint :: CSVArgs -> String -> String
dispatchPrint (CSVArgs _ columns @ (_:_) _ _ _ _) = L.getColumns columns
dispatchPrint _ = id

handleDataStream :: Maybe String -> IO String
handleDataStream Nothing = getContents
handleDataStream (Just fileName) = 
  hGetContents =<< openFile fileName ReadMode

