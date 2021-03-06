module AcmeTest.Main (main) where

import Test.Tasty

import AcmeTest.TestCase (unitTests, propTests, raceTests)

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Demo App Tests" [unitTests, propTests, raceTests]
