module Main where

import Control.Monad.Trans.Except
import Control.Monad.Trans.State.Lazy
import EternalReplay.GameState
import SimpleGame

main :: IO ()
main = do 
    result <- flip evalStateT initialState $ runExceptT simpleGame
    case result of
        Left err -> putStrLn err
        Right _  -> putStrLn "Success!!"
