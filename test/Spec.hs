
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
