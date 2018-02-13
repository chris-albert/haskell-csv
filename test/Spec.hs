
import Test.Tasty.HUnit
import Test.Tasty
import qualified Lib as L

main :: IO ()
main = do 
  putStrLn ""
  putStrLn "Running Tests"
  defaultMain tests

tests :: TestTree
tests = testGroup "Properties" [unitTests]

unitTests :: TestTree
unitTests = testGroup "Comma splitting"
  [
    testCase "Split nothing if no comma" $ 
      L.splitComma "none" @?= ["none"]
  ,
    testCase "Split on comma" $ 
      L.splitComma "a,b,foo,20" @?= ["a","b","foo","20"]
  ]


