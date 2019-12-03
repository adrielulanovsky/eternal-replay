module SimpleGame where

import Control.Monad.Trans.Class
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.IO.Class

import EternalReplay.Action
import EternalReplay.GameState

simpleGame :: Action ()
simpleGame = do
    dealDamage 5
    s0 <- get
    liftIO (putStrLn (show s0))
    endTurn
    dealDamage $ attackingDamage creature1
    s1 <- get
    liftIO (putStrLn (show s1))
