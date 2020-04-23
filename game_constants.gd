extends Node

class_name Constants

# layouts ids constants
const PLAYER_LEVEL = 1
const ENEMY_LEVEL = 2
const FOOD_LEVEL = 3
const WORLD_LEVEL = 4

const FIGHT_CLOUD_OFFSET = Vector2(0.0, -70.0)
const FIGHT_TIME = 1.0

#for player
const PLAYER_LIFETIME = 25.0 # seconds
const PLAYER_HEALTH_NUM = 5
const PLAYER_HEALTH_DENOM = 5
const PLAYER_HEALTH_INNER_STEP = 0.1

#for enemy
const ENEMY_HEALTH_NUM = 3
const ENEMY_HEALTH_DENOM = 5
const ENEMY_SPEED_SLOWER = 0.7

#for area
const ENEMY_RESPAWN_TIME = 5.0

#for player tools
const CAMP_HEALING_REFRESH_TIME = 60.0
const QUEST_CHEST_REFRESH_TIME = 60.0

#for quest
const QUEST_DENOM_LOW_LIMIT = 2
const QUEST_DENOM_HIGH_LIMIT = 6
const QUEST_NUM_LOW_LIMIT = 2
const QUEST_NUM_HIGH_LIMIT = 8
const QUEST_OPTIONS_COUNT = 4
const QUEST_END_DELAY_TIME = 1.5
