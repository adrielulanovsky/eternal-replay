module EternalReplay.GameState where

type CardId = Int
data Ability = 
    Aegis 
    | Berserk 
    | Charge 
    | Endurance 
    | Exalted 
    | Killer 
    | Reckless 
    | Deadly 
    | DoubleDamage 
    | Overwhelm 
    | Lifesteal 
    | Quickdraw
    | Flying
    | Unblockable
    deriving (Show, Eq)
-- skills to use: Aegis Berserk Charge Endurance Exalted Killer Reckless
-- skills in battle: Deadly Double Damage Overwhelm Lifesteal Quickdraw Flying Unblockable
-- skills ignore: Warcry Revenge

data Creature = Creature { creatureName :: String, creatureLife :: Int, creatureAttack :: Int, creatureAbilities :: [Ability] }
    deriving Show

data Player = Player { playerName :: String, playerLife :: Int, hand :: [CardId], board :: [Creature] }
    deriving Show

data GameState = GameState { turn :: Bool, player0 :: Player, player1 :: Player }
    deriving Show


creature1 :: Creature
creature1 = Creature {creatureAttack = 5, creatureLife = 2, creatureName = "creature1", creatureAbilities = [DoubleDamage, Deadly]}
    
initialState :: GameState
initialState = GameState {turn = True, player0 = Player "player0" 25 [1, 2, 3] [], player1 = Player "player1" 25 [4,5,6] []}