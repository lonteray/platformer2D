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
const PLAYER_LIFETIME = 10.0 # seconds
const PLAYER_HEALTH_NUM = 3
const PLAYER_HEALTH_DENOM = 3
const PLAYER_HEALTH_INNER_STEP = 0.1

#for enemy
const ENEMY_HEALTH_NUM = 3
const ENEMY_HEALTH_DENOM = 5

#for area
const ENEMY_RESPAWN_TIME = 5.0

#for player tools
const CAMP_HEALING_REFRESH_TIME = 4.0
const QUEST_CHEST_REFRESH_TIME = 5.0
