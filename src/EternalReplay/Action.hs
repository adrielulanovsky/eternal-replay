module EternalReplay.Action where

import Control.Monad.Trans.Class
import Control.Monad.State
import Control.Monad.Except

import EternalReplay.GameState

type ActionT m = ExceptT String (StateT GameState m)
type Action = ActionT IO

calculateAttackingDamage :: Creature -> Int
attackingDamage Creature { creatureAttack = a, creatureAbilities = c } = 
    if DoubleDamage `elem` c
    then 2*a
    else a

calculateSurvivingBlockers :: [Creature] -> Int -> Bool -> [Creature]
calculateSurvivingBlockers [] _ _ = []
calculateSurvivingBlockers blockers dmg _ 
    | dmg <= 0 = blockers
calculateSurvivingBlockers (b:bs) dmg True = drop dmg (b:bs)
calculateSurvivingBlockers (b:bs) dmg False
    | (creatureLife b) > dmg = b:bs
    | otherwise = calculateSurvivingBlockers bs (dmg - creatureLife b) False

        
battle :: Creature -> [Creature] -> Action ()
battle attacker blockers = do
    s <- get
    let attackingDmg = calculateAttackingDamage attacker
    let isDeadly = Deadly `elem` (creatureAbilities attacker)
    let survivingBlockers = calculateSurvivingBlockers blockers attackingDmg isDeadly
    


battlePhase :: [(Creature, [Creature])] -> Action ()
battlePhase [] = do return ()
battlePhase ((attacker, blockers):ls) = do
    battle attacker blockers
    battlePhase ls

dealDamage :: Int -> Action ()
dealDamage x = do
    s <- get
    if (turn s)
    then put (s { player1 = (player1 s) {playerLife = playerLife (player1 s) - x} })
    else put (s { player0 = (player0 s) {playerLife = playerLife (player0 s) - x} })

endTurn :: Action ()
endTurn = do
    s <- get
    put (s { turn = (not (turn s)) })
