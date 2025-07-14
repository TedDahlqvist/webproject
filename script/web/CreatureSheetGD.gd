class_name CreatureSheetGD
extends CharacterBody2D

@export var current_config: CreatureConfig

# Debug controls for color variations
var enable_color_variations: bool = false
var enable_saturation_1: bool = true
var enable_saturation_2: bool = true
var enable_saturation_3: bool = true
var enable_saturation_4: bool = true

# Skin Type Debugging properties
var enable_skin_type_debugging: bool = false
var enable_spring_season_debug: bool = true
var enable_summer_season_debug: bool = true
var enable_autumn_season_debug: bool = true
var enable_winter_season_debug: bool = true

# Evolution 1 (Face/Jaw) attribute properties
var enable_evo1_strength: bool = true
var enable_evo1_intelligence: bool = true
var enable_evo1_dexterity: bool = true
var enable_evo1_balance: bool = true

# Feet attribute properties
var enable_feet_strength: bool = true
var enable_feet_intelligence: bool = true
var enable_feet_dexterity: bool = true
var enable_feet_balance: bool = true

# Crown attribute properties
var enable_crown_strength: bool = true
var enable_crown_intelligence: bool = true
var enable_crown_dexterity: bool = true
var enable_crown_balance: bool = true

# Age debug properties
var enable_young_adult: bool = true
var enable_mid_adult: bool = true
var enable_full_adult: bool = true

# Sprite references
@onready var body_sprite: Sprite2D = $BodySprite
@onready var leg_sprite: Sprite2D = $LegSprite
@onready var head_sprite: Sprite2D = $HeadSprite
@onready var eye_sprite: Sprite2D = $EyeSprite
@onready var crown_sprite: Sprite2D = $CrownSprite
@onready var crown_hind_sprite: Sprite2D = $CrownHindSprite

# Generator
var generator: CreatureGeneratorGD
var current_spritesheet: Texture2D

func _ready():
	# Add to group so other systems can find this creature
	add_to_group("creatures")
	
	# Initialize generator with debug settings
	generator = CreatureGeneratorGD.new()
	sync_debug_settings()
	
	# Generate initial random creature if no config is set
	if current_config == null:
		randomize_creature()
	else:
		apply_creature_config(current_config)

func sync_debug_settings():
	print("🔧 SyncDebugSettings called")
	generator.enable_color_variations = enable_color_variations
	generator.enable_saturation_1 = enable_saturation_1
	generator.enable_saturation_2 = enable_saturation_2
	generator.enable_saturation_3 = enable_saturation_3
	generator.enable_saturation_4 = enable_saturation_4
	
	# Sync skin type debugging settings
	generator.enable_skin_type_debugging = enable_skin_type_debugging
	generator.enable_spring_season_debug = enable_spring_season_debug
	generator.enable_summer_season_debug = enable_summer_season_debug
	generator.enable_autumn_season_debug = enable_autumn_season_debug
	generator.enable_winter_season_debug = enable_winter_season_debug
	
	# Sync Evolution 1 (Face/Jaw) attribute settings
	generator.enable_evo1_strength = enable_evo1_strength
	generator.enable_evo1_intelligence = enable_evo1_intelligence
	generator.enable_evo1_dexterity = enable_evo1_dexterity
	generator.enable_evo1_balance = enable_evo1_balance
	
	# Sync Feet attribute settings
	generator.enable_feet_strength = enable_feet_strength
	generator.enable_feet_intelligence = enable_feet_intelligence
	generator.enable_feet_dexterity = enable_feet_dexterity
	generator.enable_feet_balance = enable_feet_balance
	
	# Sync Crown attribute settings
	generator.enable_crown_strength = enable_crown_strength
	generator.enable_crown_intelligence = enable_crown_intelligence
	generator.enable_crown_dexterity = enable_crown_dexterity
	generator.enable_crown_balance = enable_crown_balance
	
	# Sync age settings
	generator.enable_young_adult = enable_young_adult
	generator.enable_mid_adult = enable_mid_adult
	generator.enable_full_adult = enable_full_adult
	print("🎯 Age sync - Young: ", enable_young_adult, ", Mid: ", enable_mid_adult, ", Full: ", enable_full_adult)

func randomize_creature():
	sync_debug_settings()
	current_config = generator.generate_random_creature()
	apply_creature_config(current_config)
	
	var feet_name = CreatureGeneratorGD.get_feet_variant_name(current_config.feet_variant)
	var face_name = CreatureGeneratorGD.get_face_variant_name(current_config.face_variant)
	var crown_name = CreatureGeneratorGD.get_crown_variant_name(current_config.crown_variant)
	var crown_type = "Adult" if current_config.use_adult_crown else "Young"
	
	print("Generated creature: ", current_config.get_age_string(), " ", current_config.get_fur_string(), " - Parts: Feet=", feet_name, ", Face=", face_name, ", Crown=", crown_name, "(", crown_type, ")")

func set_creature_config(config: CreatureConfig):
	current_config = config
	apply_creature_config(config)

func apply_creature_config(config: CreatureConfig):
	if config == null:
		return
	
	# Load the appropriate spritesheet
	var spritesheet_path = generator.get_spritesheet_path(config)
	current_spritesheet = load(spritesheet_path) as Texture2D
	
	print("Loading spritesheet: ", spritesheet_path)
	
	if current_spritesheet == null:
		print("Failed to load spritesheet: ", spritesheet_path)
		return
	
	print("Successfully loaded spritesheet. Size: ", current_spritesheet.get_width(), "x", current_spritesheet.get_height())
	
	# Apply each part
	apply_creature_part(body_sprite, CreatureConfig.CreaturePartType.BODY, config)
	apply_creature_part(leg_sprite, CreatureConfig.CreaturePartType.FEET, config)
	apply_creature_part(head_sprite, CreatureConfig.CreaturePartType.FACE, config)
	apply_creature_part(eye_sprite, CreatureConfig.CreaturePartType.EYES, config)
	
	# Handle crown front and back sprites based on age
	if config.use_adult_crown:
		apply_creature_part(crown_sprite, CreatureConfig.CreaturePartType.CROWN_ADULT, config)
		apply_creature_part(crown_hind_sprite, CreatureConfig.CreaturePartType.CROWN_ADULT_HIND, config)
	else:
		apply_creature_part(crown_sprite, CreatureConfig.CreaturePartType.CROWN_YOUNG, config)
		apply_creature_part(crown_hind_sprite, CreatureConfig.CreaturePartType.CROWN_YOUNG_HIND, config)

func apply_creature_part(sprite: Sprite2D, part_type: CreatureConfig.CreaturePartType, config: CreatureConfig):
	if sprite == null or current_spritesheet == null:
		return
	
	var atlas_texture = extract_creature_part(current_spritesheet, config, part_type)
	sprite.texture = atlas_texture

func extract_creature_part(spritesheet: Texture2D, config: CreatureConfig, part_type: CreatureConfig.CreaturePartType) -> AtlasTexture:
	var atlas = AtlasTexture.new()
	atlas.atlas = spritesheet
	
	# Sprite dimensions match C# version
	const sprite_width = 64
	const sprite_height = 80
	
	# Calculate row based on fur type and part type
	var base_row = get_part_type_base_row(part_type)
	var fur_offset = get_fur_offset(config.fur_type)
	var row = base_row + fur_offset
	
	# Get column based on part variant
	var column = get_part_column(config, part_type)
	
	atlas.region = Rect2(column * sprite_width, row * sprite_height, sprite_width, sprite_height)
	
	return atlas

func get_part_type_base_row(part_type: CreatureConfig.CreaturePartType) -> int:
	# These match the CreaturePartType enum values in C#
	match part_type:
		CreatureConfig.CreaturePartType.BODY:
			return 0
		CreatureConfig.CreaturePartType.EYES:
			return 1
		CreatureConfig.CreaturePartType.FEET:
			return 2
		CreatureConfig.CreaturePartType.FACE:
			return 3
		CreatureConfig.CreaturePartType.CROWN_YOUNG:
			return 4
		CreatureConfig.CreaturePartType.CROWN_YOUNG_HIND:
			return 5
		CreatureConfig.CreaturePartType.CROWN_ADULT:
			return 6
		CreatureConfig.CreaturePartType.CROWN_ADULT_HIND:
			return 7
		_:
			return 0

func get_fur_offset(fur_type: CreatureConfig.CreatureFur) -> int:
	match fur_type:
		CreatureConfig.CreatureFur.PLAIN:
			return 0     # Rows 0-7
		CreatureConfig.CreatureFur.FUZZY:
			return 8     # Rows 8-15
		CreatureConfig.CreatureFur.SCALES:
			return 16    # Rows 16-23
		_:
			return 0



func get_part_column(config: CreatureConfig, part_type: CreatureConfig.CreaturePartType) -> int:
	match part_type:
		CreatureConfig.CreaturePartType.BODY:
			return config.body_variant
		CreatureConfig.CreaturePartType.FEET:
			return config.feet_variant
		CreatureConfig.CreaturePartType.FACE:
			return config.face_variant
		CreatureConfig.CreaturePartType.EYES:
			return config.eye_variant
		CreatureConfig.CreaturePartType.CROWN_ADULT, CreatureConfig.CreaturePartType.CROWN_ADULT_HIND:
			return config.crown_variant
		CreatureConfig.CreaturePartType.CROWN_YOUNG, CreatureConfig.CreaturePartType.CROWN_YOUNG_HIND:
			return config.crown_variant
		_:
			return 0

# Input handling for click-to-randomize
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Check if click is on this creature (simple bounds check)
			var global_pos = get_global_mouse_position()
			var creature_pos = global_position
			var distance = global_pos.distance_to(creature_pos)
			
			if distance < 50:  # 50 pixel radius
				randomize_creature()
				get_viewport().set_input_as_handled()

# Public methods for external control
func set_age(age: CreatureConfig.CreatureAge):
	if current_config != null:
		current_config.age = age
		apply_creature_config(current_config)

func set_fur_type(fur_type: CreatureConfig.CreatureFur):
	if current_config != null:
		current_config.fur_type = fur_type
		apply_creature_config(current_config)

func toggle_crown_type():
	if current_config != null:
		current_config.use_adult_crown = not current_config.use_adult_crown
		# Update both crown sprites
		if current_config.use_adult_crown:
			apply_creature_part(crown_sprite, CreatureConfig.CreaturePartType.CROWN_ADULT, current_config)
			apply_creature_part(crown_hind_sprite, CreatureConfig.CreaturePartType.CROWN_ADULT_HIND, current_config)
		else:
			apply_creature_part(crown_sprite, CreatureConfig.CreaturePartType.CROWN_YOUNG, current_config)
			apply_creature_part(crown_hind_sprite, CreatureConfig.CreaturePartType.CROWN_YOUNG_HIND, current_config)
