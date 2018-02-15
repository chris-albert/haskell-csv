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
  args      <- getArgs
  stream    <- handleDataStream $ file args
  let output = dispatch args stream
  putStr output

dispatch :: CSVArgs -> String -> String
-- If we just want to print the arguments
dispatch csv @ (CSVArgs _ _ True _ _ _) = const $ show csv
-- If we are printing the body
dispatch csvArgs = 
  let body    = dispatchPrint csvArgs
   in runFormats csvArgs . body

runFormats :: CSVArgs -> String -> String
runFormats args = 
  foldl (\f i -> f . i args) id formatFuncs  

formatFuncs :: [CSVArgs -> (String -> String)]
formatFuncs =
  [
    doIfTrue L.killHeaders . noHeaders
   ,doIfJust L.formatColumns . width
  ]

doIfTrue :: (String -> String) -> Bool -> (String -> String)
doIfTrue f True  = f
doIfTrue _ False = id

doIfJust :: (a -> String -> String) -> Maybe a -> (String -> String)
doIfJust _ Nothing  = id
doIfJust f (Just a) = f a 

dispatchPrint :: CSVArgs -> String -> String
dispatchPrint (CSVArgs _ columns @ (_:_) _ _ _ _) = L.getColumns columns
dispatchPrint _                                   = id

handleDataStream :: Maybe String -> IO String
handleDataStream Nothing         = getContents
handleDataStream (Just fileName) = 
  hGetContents =<< openFile fileName ReadMode

