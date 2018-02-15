
import Test.Tasty.HUnit
import Test.Tasty
import qualified Lib as L

main :: IO ()
main = do 
  putStrLn ""
  putStrLn "Running Tests"
  defaultMain tests

tests :: TestTree
tests = testGroup "Properties" 
  [
    unitTests
   ,columnsTests
   ,killHeadersTests
   ,formatColumnsTests
  ]

unitTests :: TestTree
unitTests = testGroup "Comma splitting"
  [
    testCase "Split nothing if no comma" $ 
      L.commas "none" @?= ["none"]
  ,
    testCase "Split on comma" $ 
      L.commas "a,b,foo,20" @?= ["a","b","foo","20"]
  ]

columnsTests :: TestTree
columnsTests = testGroup "Columns"
  [
    testCase "Get nothing if no columns found" $
      L.getColumnsIndex ["a","b"] ["c"] @?= []
  ,
    testCase "Get nothing if no columns found" $
      L.getColumnsIndex ["a","b","c"] ["c","a"] @?= [2,0]
  ]

killHeadersTests :: TestTree
killHeadersTests = testGroup "Kill Headers"
  [
    testCase "Kill first line" $
      L.killHeaders "first,second\na,b\nc,d" @?= "a,b\nc,d\n"
  ]

formatColumnsTests :: TestTree
formatColumnsTests = testGroup "Format columns"
  [
    testCase "Pad characters" $
      L.formatColumns 5 "first,second\na,b\nc,d" @?= "first,secon\na    ,b    \nc    ,d    \n"
  ]
