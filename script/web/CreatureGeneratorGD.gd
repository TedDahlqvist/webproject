class_name CreatureGeneratorGD
extends RefCounted

# Static arrays for random selection
var color_names = ["blue", "brown", "green", "greyscale", "natural", "purple", "red"]
var saturation_levels = [1, 2, 3, 4]
var ages = [CreatureConfig.CreatureAge.YOUNG_ADULT, CreatureConfig.CreatureAge.MID_ADULT, CreatureConfig.CreatureAge.FULL_ADULT]
var fur_types = [CreatureConfig.CreatureFur.PLAIN, CreatureConfig.CreatureFur.FUZZY, CreatureConfig.CreatureFur.SCALES]

# Random number generator
var rng: RandomNumberGenerator

# Debug toggles for color variations
var enable_color_variations: bool = false
var enable_saturation_1: bool = true
var enable_saturation_2: bool = true
var enable_saturation_3: bool = true
var enable_saturation_4: bool = true

# Skin Type Debugging - primary toggle and season selections
var enable_skin_type_debugging: bool = false
var enable_spring_season_debug: bool = true
var enable_summer_season_debug: bool = true
var enable_autumn_season_debug: bool = true
var enable_winter_season_debug: bool = true

# Evolution 1 (Face/Jaw) attribute toggles
var enable_evo1_strength: bool = true
var enable_evo1_intelligence: bool = true
var enable_evo1_dexterity: bool = true
var enable_evo1_balance: bool = true

# Feet attribute toggles
var enable_feet_strength: bool = true
var enable_feet_intelligence: bool = true
var enable_feet_dexterity: bool = true
var enable_feet_balance: bool = true

# Crown attribute toggles
var enable_crown_strength: bool = true
var enable_crown_intelligence: bool = true
var enable_crown_dexterity: bool = true
var enable_crown_balance: bool = true

# Age debug toggles
var enable_young_adult: bool = true
var enable_mid_adult: bool = true
var enable_full_adult: bool = true

# Individual color palette toggles
var enable_natural: bool = true
var enable_blue: bool = true
var enable_brown: bool = true
var enable_green: bool = true
var enable_greyscale: bool = true
var enable_purple: bool = true
var enable_red: bool = true

func _init(seed_value: int = -1):
	rng = RandomNumberGenerator.new()
	if seed_value != -1:
		rng.seed = seed_value
	else:
		rng.randomize()

func generate_random_creature() -> CreatureConfig:
	var config = CreatureConfig.new()
	
	config.age = get_random_enabled_age()
	config.fur_type = get_seasonal_fur_type_from_debug_settings()
	
	# Color and saturation based on debug toggles
	config.color_name = "natural" if not enable_color_variations else get_random_enabled_color()
	config.saturation_level = 2 if not enable_color_variations else get_random_enabled_saturation()
	
	# Single variant for body, multiple variants for other parts with debug controls
	config.body_variant = 0
	config.eye_variant = rng.randi() % 3  # 3 eye variations (columns 0-2)
	config.feet_variant = get_random_feet_variant()  # 4 feet variations with debug controls
	config.face_variant = get_random_face_variant()  # 8 face variations with debug controls
	config.crown_variant = get_random_crown_variant()  # 8 crown variations with debug controls
	config.use_adult_crown = rng.randf() > 0.3
	
	return config

func get_random_enabled_age() -> CreatureConfig.CreatureAge:
	var enabled_ages = []
	
	if enable_young_adult:
		enabled_ages.append(CreatureConfig.CreatureAge.YOUNG_ADULT)
	if enable_mid_adult:
		enabled_ages.append(CreatureConfig.CreatureAge.MID_ADULT)
	if enable_full_adult:
		enabled_ages.append(CreatureConfig.CreatureAge.FULL_ADULT)
	
	if enabled_ages.is_empty():
		print("🎯 Age Debug - No ages enabled, falling back to FullAdult")
		return CreatureConfig.CreatureAge.FULL_ADULT
	
	var selected_age = enabled_ages[rng.randi() % enabled_ages.size()]
	print("🎯 Age Debug - Selected age: ", selected_age)
	return selected_age

func get_seasonal_fur_type_from_debug_settings() -> CreatureConfig.CreatureFur:
	if not enable_skin_type_debugging:
		# Use basic random selection when not debugging
		return fur_types[rng.randi() % fur_types.size()]
	
	# Collect enabled seasons and their corresponding fur types
	var enabled_seasons = []
	
	if enable_spring_season_debug:
		enabled_seasons.append(CreatureConfig.CreatureFur.PLAIN)
	if enable_summer_season_debug:
		enabled_seasons.append(CreatureConfig.CreatureFur.SCALES)
	if enable_autumn_season_debug:
		enabled_seasons.append(CreatureConfig.CreatureFur.PLAIN)
	if enable_winter_season_debug:
		enabled_seasons.append(CreatureConfig.CreatureFur.FUZZY)
	
	if enabled_seasons.is_empty():
		# Fallback if no seasons are enabled
		return CreatureConfig.CreatureFur.PLAIN
	
	# Pick random from enabled seasons
	return enabled_seasons[rng.randi() % enabled_seasons.size()]

func get_random_enabled_saturation() -> int:
	var enabled_saturations = []
	
	if enable_saturation_1:
		enabled_saturations.append(1)
	if enable_saturation_2:
		enabled_saturations.append(2)
	if enable_saturation_3:
		enabled_saturations.append(3)
	if enable_saturation_4:
		enabled_saturations.append(4)
	
	if enabled_saturations.is_empty():
		return 2  # Default fallback
	
	return enabled_saturations[rng.randi() % enabled_saturations.size()]

func get_random_enabled_color() -> String:
	var enabled_colors = []
	
	if enable_natural:
		enabled_colors.append("natural")
	if enable_blue:
		enabled_colors.append("blue")
	if enable_brown:
		enabled_colors.append("brown")
	if enable_green:
		enabled_colors.append("green")
	if enable_greyscale:
		enabled_colors.append("greyscale")
	if enable_purple:
		enabled_colors.append("purple")
	if enable_red:
		enabled_colors.append("red")
	
	if enabled_colors.is_empty():
		return "natural"  # Default fallback
	
	return enabled_colors[rng.randi() % enabled_colors.size()]

func get_random_face_variant() -> int:
	var enabled_variants = []
	
	if enable_evo1_balance:
		enabled_variants.append_array([1, 5])
	if enable_evo1_intelligence:
		enabled_variants.append_array([2, 6])
	if enable_evo1_dexterity:
		enabled_variants.append_array([3, 7])
	if enable_evo1_strength:
		enabled_variants.append_array([4, 8])
	
	if enabled_variants.is_empty():
		# Fallback to Balance if nothing is enabled
		return 0  # Convert to 0-based indexing
	
	return (enabled_variants[rng.randi() % enabled_variants.size()] - 1)  # Convert to 0-based indexing

func get_random_feet_variant() -> int:
	var enabled_variants = []
	
	if enable_feet_balance:
		enabled_variants.append(1)
	if enable_feet_intelligence:
		enabled_variants.append(2)
	if enable_feet_dexterity:
		enabled_variants.append(3)
	if enable_feet_strength:
		enabled_variants.append(4)
	
	if enabled_variants.is_empty():
		return 0  # Fallback to Balance (0-based)
	
	return (enabled_variants[rng.randi() % enabled_variants.size()] - 1)  # Convert to 0-based indexing

func get_random_crown_variant() -> int:
	var enabled_variants = []
	
	if enable_crown_balance:
		enabled_variants.append_array([1, 5])
	if enable_crown_intelligence:
		enabled_variants.append_array([2, 6])
	if enable_crown_dexterity:
		enabled_variants.append_array([3, 7])
	if enable_crown_strength:
		enabled_variants.append_array([4, 8])
	
	if enabled_variants.is_empty():
		return 0  # Fallback to Balance (0-based)
	
	return (enabled_variants[rng.randi() % enabled_variants.size()] - 1)  # Convert to 0-based indexing

func get_spritesheet_path(config: CreatureConfig) -> String:
	print("🎨 Getting spritesheet path for: ", config.color_name, " saturation ", config.saturation_level, " color_variations enabled: ", enable_color_variations)
	
	if enable_color_variations:
		# Use batch-converted color variation spritesheets if they exist
		var age_prefix = ""
		match config.age:
			CreatureConfig.CreatureAge.YOUNG_ADULT:
				age_prefix = "young-adult"
			CreatureConfig.CreatureAge.MID_ADULT:
				age_prefix = "mid-adult"
			CreatureConfig.CreatureAge.FULL_ADULT:
				age_prefix = "full-adult"
			_:
				age_prefix = "full-adult"
		
		var age_folder = age_prefix + "_color_variations"
		var filename = age_prefix + "_" + config.color_name + "_saturation_" + str(config.saturation_level) + ".png"
		var color_variation_path = "res://textures/actors/creatures/adult/" + age_folder + "/" + filename
		
		print("🔍 Checking for color variation file: ", color_variation_path)
		
		# Check if the color variation file exists, if not fall back to base spritesheet
		if FileAccess.file_exists(color_variation_path):
			print("✅ Found color variation file: ", color_variation_path)
			return color_variation_path
		else:
			# Fall back to base spritesheet if color variation doesn't exist
			print("❌ Color variation file not found: ", color_variation_path, ", falling back to base spritesheet")
	
	# Use base spritesheets (either when color variations disabled or as fallback)
	var base_filename = ""
	match config.age:
		CreatureConfig.CreatureAge.YOUNG_ADULT:
			base_filename = "young-adult.png"
		CreatureConfig.CreatureAge.MID_ADULT:
			base_filename = "mid-adult.png"
		CreatureConfig.CreatureAge.FULL_ADULT:
			base_filename = "full-adult.png"
		_:
			base_filename = "full-adult.png"
	
	var fallback_path = "res://art/Creatures/variation_spritesheet/" + base_filename
	print("📁 Using base spritesheet: ", fallback_path)
	return fallback_path

# Static helper methods for variant names
static func get_feet_variant_name(variant: int) -> String:
	match variant:
		0: return "Balanced"
		1: return "Precise" 
		2: return "Quick"
		3: return "Powerful"
		_: return "Unknown"

static func get_face_variant_name(variant: int) -> String:
	match variant:
		0: return "Balanced"
		1: return "Refined"
		2: return "Agile" 
		3: return "Strong"
		4: return "Wise"
		5: return "Swift"
		6: return "Mighty"
		7: return "Reserved"
		_: return "Unknown"

static func get_crown_variant_name(variant: int) -> String:
	match variant:
		0: return "Balanced Crown"
		1: return "Wise Crown"
		2: return "Swift Crown"
		3: return "Mighty Crown"
		4: return "Serene Crown"
		5: return "Clever Crown"
		6: return "Graceful Crown"
		7: return "Imposing Crown"
		_: return "Unknown Crown"
