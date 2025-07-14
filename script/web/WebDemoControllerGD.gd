extends Control

var creature_sheet: CreatureSheetGD

# Palette checkboxes
@onready var color_variations_checkbox: CheckBox
@onready var natural_checkbox: CheckBox
@onready var blue_checkbox: CheckBox
@onready var brown_checkbox: CheckBox
@onready var green_checkbox: CheckBox
@onready var greyscale_checkbox: CheckBox
@onready var purple_checkbox: CheckBox
@onready var red_checkbox: CheckBox

# Saturation checkboxes
@onready var saturation_1_checkbox: CheckBox
@onready var saturation_2_checkbox: CheckBox
@onready var saturation_3_checkbox: CheckBox
@onready var saturation_4_checkbox: CheckBox

# Fur checkboxes
@onready var plain_fur_checkbox: CheckBox
@onready var fuzzy_fur_checkbox: CheckBox
@onready var scales_fur_checkbox: CheckBox

# Age checkboxes
@onready var young_adult_checkbox: CheckBox
@onready var mid_adult_checkbox: CheckBox
@onready var full_adult_checkbox: CheckBox

# Face attribute checkboxes
@onready var face_strength_checkbox: CheckBox
@onready var face_intelligence_checkbox: CheckBox
@onready var face_dexterity_checkbox: CheckBox
@onready var face_balance_checkbox: CheckBox

# Feet attribute checkboxes
@onready var feet_strength_checkbox: CheckBox
@onready var feet_intelligence_checkbox: CheckBox
@onready var feet_dexterity_checkbox: CheckBox
@onready var feet_balance_checkbox: CheckBox

# Crown attribute checkboxes
@onready var crown_strength_checkbox: CheckBox
@onready var crown_intelligence_checkbox: CheckBox
@onready var crown_dexterity_checkbox: CheckBox
@onready var crown_balance_checkbox: CheckBox

func _ready():
	print("🚀 WebDemoController (GDScript) starting initialization...")
	
	# Get CreatureSheet
	creature_sheet = get_node("MainContainer/CreatureDisplay/DisplayArea/CreatureSheet") as CreatureSheetGD
	print("✅ CreatureSheet found successfully")
	
	# Get controls container with detailed path checking
	print("🔍 Looking for ControlsScrollContainer...")
	var scroll_container = get_node("MainContainer/NinePatchRect/VSplitContainer/SettingsMarginContainer/NinePatchRect/MarginContainer/ControlsScrollContainer") as ScrollContainer
	print("✅ ControlsScrollContainer found")
	
	var controls = scroll_container.get_node("ControlsContainer") as VBoxContainer
	print("✅ ControlsContainer found")
	
	# Palette checkboxes
	var palette_section = controls.get_node("PaletteSection") as VBoxContainer
	color_variations_checkbox = palette_section.get_node("ColorVariationsCheckbox") as CheckBox
	var palette_container = palette_section.get_node("PaletteContainer") as GridContainer
	natural_checkbox = palette_container.get_node("NaturalCheckbox") as CheckBox
	blue_checkbox = palette_container.get_node("BlueCheckbox") as CheckBox
	brown_checkbox = palette_container.get_node("BrownCheckbox") as CheckBox
	green_checkbox = palette_container.get_node("GreenCheckbox") as CheckBox
	greyscale_checkbox = palette_container.get_node("GreyscaleCheckbox") as CheckBox
	purple_checkbox = palette_container.get_node("PurpleCheckbox") as CheckBox
	red_checkbox = palette_container.get_node("RedCheckbox") as CheckBox
	print("✅ Palette checkboxes loaded")
	
	# Saturation checkboxes
	var saturation_section = controls.get_node("SaturationSection") as VBoxContainer
	var saturation_container = saturation_section.get_node("SaturationContainer") as GridContainer
	saturation_1_checkbox = saturation_container.get_node("Saturation1Checkbox") as CheckBox
	saturation_2_checkbox = saturation_container.get_node("Saturation2Checkbox") as CheckBox
	saturation_3_checkbox = saturation_container.get_node("Saturation3Checkbox") as CheckBox
	saturation_4_checkbox = saturation_container.get_node("Saturation4Checkbox") as CheckBox
	print("✅ Saturation checkboxes loaded")
	
	# Fur checkboxes
	var fur_section = controls.get_node("FurSection") as VBoxContainer
	var fur_container = fur_section.get_node("FurContainer") as GridContainer
	plain_fur_checkbox = fur_container.get_node("PlainFurCheckbox") as CheckBox
	fuzzy_fur_checkbox = fur_container.get_node("FuzzyFurCheckbox") as CheckBox
	scales_fur_checkbox = fur_container.get_node("ScalesFurCheckbox") as CheckBox
	print("✅ Fur checkboxes loaded")
	
	# Age checkboxes
	var age_section = controls.get_node("AgeSection") as VBoxContainer
	var age_container = age_section.get_node("AgeContainer") as GridContainer
	young_adult_checkbox = age_container.get_node("YoungAdultCheckbox") as CheckBox
	mid_adult_checkbox = age_container.get_node("MidAdultCheckbox") as CheckBox
	full_adult_checkbox = age_container.get_node("FullAdultCheckbox") as CheckBox
	print("✅ Age checkboxes loaded")
	
	# Face attribute checkboxes
	var face_section = controls.get_node("FaceSection") as VBoxContainer
	var face_container = face_section.get_node("FaceContainer") as GridContainer
	face_strength_checkbox = face_container.get_node("FaceStrengthCheckbox") as CheckBox
	face_intelligence_checkbox = face_container.get_node("FaceIntelligenceCheckbox") as CheckBox
	face_dexterity_checkbox = face_container.get_node("FaceDexterityCheckbox") as CheckBox
	face_balance_checkbox = face_container.get_node("FaceBalanceCheckbox") as CheckBox
	print("✅ Face checkboxes loaded")
	
	# Feet attribute checkboxes
	var feet_section = controls.get_node("FeetSection") as VBoxContainer
	var feet_container = feet_section.get_node("FeetContainer") as GridContainer
	feet_strength_checkbox = feet_container.get_node("FeetStrengthCheckbox") as CheckBox
	feet_intelligence_checkbox = feet_container.get_node("FeetIntelligenceCheckbox") as CheckBox
	feet_dexterity_checkbox = feet_container.get_node("FeetDexterityCheckbox") as CheckBox
	feet_balance_checkbox = feet_container.get_node("FeetBalanceCheckbox") as CheckBox
	print("✅ Feet checkboxes loaded")
	
	# Crown attribute checkboxes
	var crown_section = controls.get_node("CrownSection") as VBoxContainer
	var crown_container = crown_section.get_node("CrownContainer") as GridContainer
	crown_strength_checkbox = crown_container.get_node("CrownStrengthCheckbox") as CheckBox
	crown_intelligence_checkbox = crown_container.get_node("CrownIntelligenceCheckbox") as CheckBox
	crown_dexterity_checkbox = crown_container.get_node("CrownDexterityCheckbox") as CheckBox
	crown_balance_checkbox = crown_container.get_node("CrownBalanceCheckbox") as CheckBox
	print("✅ Crown checkboxes loaded")
	
	# Connect all checkbox signals
	connect_checkbox_signals()
	
	# Generate initial creature
	_on_randomize_button_pressed()
	
	print("🎉 WebDemoController (GDScript) initialization complete!")

func connect_checkbox_signals():
	# Connect all checkboxes to trigger randomization when toggled
	if color_variations_checkbox:
		color_variations_checkbox.toggled.connect(_on_checkbox_toggled)
	
	if natural_checkbox:
		natural_checkbox.toggled.connect(_on_checkbox_toggled)
	if blue_checkbox:
		blue_checkbox.toggled.connect(_on_checkbox_toggled)
	if brown_checkbox:
		brown_checkbox.toggled.connect(_on_checkbox_toggled)
	if green_checkbox:
		green_checkbox.toggled.connect(_on_checkbox_toggled)
	if greyscale_checkbox:
		greyscale_checkbox.toggled.connect(_on_checkbox_toggled)
	if purple_checkbox:
		purple_checkbox.toggled.connect(_on_checkbox_toggled)
	if red_checkbox:
		red_checkbox.toggled.connect(_on_checkbox_toggled)
	
	if saturation_1_checkbox:
		saturation_1_checkbox.toggled.connect(_on_checkbox_toggled)
	if saturation_2_checkbox:
		saturation_2_checkbox.toggled.connect(_on_checkbox_toggled)
	if saturation_3_checkbox:
		saturation_3_checkbox.toggled.connect(_on_checkbox_toggled)
	if saturation_4_checkbox:
		saturation_4_checkbox.toggled.connect(_on_checkbox_toggled)
	
	if plain_fur_checkbox:
		plain_fur_checkbox.toggled.connect(_on_checkbox_toggled)
	if fuzzy_fur_checkbox:
		fuzzy_fur_checkbox.toggled.connect(_on_checkbox_toggled)
	if scales_fur_checkbox:
		scales_fur_checkbox.toggled.connect(_on_checkbox_toggled)
	
	if young_adult_checkbox:
		young_adult_checkbox.toggled.connect(_on_checkbox_toggled)
	if mid_adult_checkbox:
		mid_adult_checkbox.toggled.connect(_on_checkbox_toggled)
	if full_adult_checkbox:
		full_adult_checkbox.toggled.connect(_on_checkbox_toggled)
	
	if face_strength_checkbox:
		face_strength_checkbox.toggled.connect(_on_checkbox_toggled)
	if face_intelligence_checkbox:
		face_intelligence_checkbox.toggled.connect(_on_checkbox_toggled)
	if face_dexterity_checkbox:
		face_dexterity_checkbox.toggled.connect(_on_checkbox_toggled)
	if face_balance_checkbox:
		face_balance_checkbox.toggled.connect(_on_checkbox_toggled)
	
	if feet_strength_checkbox:
		feet_strength_checkbox.toggled.connect(_on_checkbox_toggled)
	if feet_intelligence_checkbox:
		feet_intelligence_checkbox.toggled.connect(_on_checkbox_toggled)
	if feet_dexterity_checkbox:
		feet_dexterity_checkbox.toggled.connect(_on_checkbox_toggled)
	if feet_balance_checkbox:
		feet_balance_checkbox.toggled.connect(_on_checkbox_toggled)
	
	if crown_strength_checkbox:
		crown_strength_checkbox.toggled.connect(_on_checkbox_toggled)
	if crown_intelligence_checkbox:
		crown_intelligence_checkbox.toggled.connect(_on_checkbox_toggled)
	if crown_dexterity_checkbox:
		crown_dexterity_checkbox.toggled.connect(_on_checkbox_toggled)
	if crown_balance_checkbox:
		crown_balance_checkbox.toggled.connect(_on_checkbox_toggled)
	
	print("✅ All checkbox signals connected successfully")

func _on_checkbox_toggled(_pressed: bool):
	update_creature_settings()
	# Regenerate creature to apply new settings
	if creature_sheet != null:
		creature_sheet.randomize_creature()
		print("🔄 Creature regenerated with new settings!")
	else:
		print("❌ CreatureSheet is null - cannot regenerate")

func _on_randomize_button_pressed():
	update_creature_settings()
	if creature_sheet != null:
		creature_sheet.randomize_creature()
		print("🎲 Creature randomized successfully!")
	else:
		print("❌ CreatureSheet is null - cannot randomize")

func update_creature_settings():
	if creature_sheet == null:
		print("CreatureSheet is null in update_creature_settings()")
		return
	
	print("🔧 Updating creature settings...")
	
	# Color variations - this controls whether palette variations are used
	if color_variations_checkbox:
		creature_sheet.enable_color_variations = color_variations_checkbox.button_pressed
		print("Color Variations: ", creature_sheet.enable_color_variations)
	
	# Saturation levels
	if saturation_1_checkbox:
		creature_sheet.enable_saturation_1 = saturation_1_checkbox.button_pressed
	if saturation_2_checkbox:
		creature_sheet.enable_saturation_2 = saturation_2_checkbox.button_pressed
	if saturation_3_checkbox:
		creature_sheet.enable_saturation_3 = saturation_3_checkbox.button_pressed
	if saturation_4_checkbox:
		creature_sheet.enable_saturation_4 = saturation_4_checkbox.button_pressed
	
	# Force seasonal debug mode on so we can control fur types directly
	creature_sheet.enable_skin_type_debugging = true
	if plain_fur_checkbox:
		creature_sheet.enable_spring_season_debug = plain_fur_checkbox.button_pressed
		creature_sheet.enable_autumn_season_debug = plain_fur_checkbox.button_pressed
	if scales_fur_checkbox:
		creature_sheet.enable_summer_season_debug = scales_fur_checkbox.button_pressed
	if fuzzy_fur_checkbox:
		creature_sheet.enable_winter_season_debug = fuzzy_fur_checkbox.button_pressed
	
	# Face (Evolution 1) attributes
	if face_strength_checkbox:
		creature_sheet.enable_evo1_strength = face_strength_checkbox.button_pressed
	if face_intelligence_checkbox:
		creature_sheet.enable_evo1_intelligence = face_intelligence_checkbox.button_pressed
	if face_dexterity_checkbox:
		creature_sheet.enable_evo1_dexterity = face_dexterity_checkbox.button_pressed
	if face_balance_checkbox:
		creature_sheet.enable_evo1_balance = face_balance_checkbox.button_pressed
	
	# Feet attributes
	if feet_strength_checkbox:
		creature_sheet.enable_feet_strength = feet_strength_checkbox.button_pressed
	if feet_intelligence_checkbox:
		creature_sheet.enable_feet_intelligence = feet_intelligence_checkbox.button_pressed
	if feet_dexterity_checkbox:
		creature_sheet.enable_feet_dexterity = feet_dexterity_checkbox.button_pressed
	if feet_balance_checkbox:
		creature_sheet.enable_feet_balance = feet_balance_checkbox.button_pressed
	
	# Crown attributes
	if crown_strength_checkbox:
		creature_sheet.enable_crown_strength = crown_strength_checkbox.button_pressed
	if crown_intelligence_checkbox:
		creature_sheet.enable_crown_intelligence = crown_intelligence_checkbox.button_pressed
	if crown_dexterity_checkbox:
		creature_sheet.enable_crown_dexterity = crown_dexterity_checkbox.button_pressed
	if crown_balance_checkbox:
		creature_sheet.enable_crown_balance = crown_balance_checkbox.button_pressed
	
	# Age controls
	if young_adult_checkbox:
		creature_sheet.enable_young_adult = young_adult_checkbox.button_pressed
		print("🎯 Young Adult set to: ", young_adult_checkbox.button_pressed)
	if mid_adult_checkbox:
		creature_sheet.enable_mid_adult = mid_adult_checkbox.button_pressed
		print("🎯 Mid Adult set to: ", mid_adult_checkbox.button_pressed)
	if full_adult_checkbox:
		creature_sheet.enable_full_adult = full_adult_checkbox.button_pressed
		print("🎯 Full Adult set to: ", full_adult_checkbox.button_pressed)
	
	print("✅ Creature settings updated successfully")
