class_name CreatureConfig
extends Resource

# Creature age types
enum CreatureAge {
	YOUNG_ADULT,
	MID_ADULT,
	FULL_ADULT
}

# Creature fur types
enum CreatureFur {
	PLAIN,
	FUZZY,
	SCALES
}

# Creature part types for spritesheet extraction (must match C# enum order!)
enum CreaturePartType {
	BODY = 0,
	EYES = 1,
	FEET = 2,
	FACE = 3,
	CROWN_YOUNG = 4,
	CROWN_YOUNG_HIND = 5,
	CROWN_ADULT = 6,
	CROWN_ADULT_HIND = 7
}

# Configuration properties
@export var age: CreatureAge = CreatureAge.FULL_ADULT
@export var fur_type: CreatureFur = CreatureFur.PLAIN
@export var color_name: String = "natural"
@export var saturation_level: int = 2

# Part variations (column indices in spritesheets)
@export var body_variant: int = 0
@export var eye_variant: int = 0
@export var feet_variant: int = 0
@export var face_variant: int = 0
@export var crown_variant: int = 0
@export var use_adult_crown: bool = true

func _init():
	pass

func get_age_string() -> String:
	match age:
		CreatureAge.YOUNG_ADULT:
			return "young-adult"
		CreatureAge.MID_ADULT:
			return "mid-adult"
		CreatureAge.FULL_ADULT:
			return "full-adult"
		_:
			return "full-adult"

func get_fur_string() -> String:
	match fur_type:
		CreatureFur.PLAIN:
			return "Plain"
		CreatureFur.FUZZY:
			return "Fuzzy"
		CreatureFur.SCALES:
			return "Scales"
		_:
			return "Plain"
