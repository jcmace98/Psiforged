/*
:Tech vars:.
	- Setting has_subtech = 1 will force the tech, when displayed inside the "Build Tech", to show a plus(+)
	- tech_ref is assigned to the expand_button's that are created, so when the player clicks them, it knows which tech is selected

*/

obj
	step_size = 6
	var/const/HAIR_LAYER = FLOAT_LAYER-1
	var/const/ARMOUR_LAYER = FLOAT_LAYER-1
	var/const/EQUIPMENT_LAYER = FLOAT_LAYER
	Move()
		if(src.loc)
			src.layer = MOB_LAYER + src.laymod - (src.y + src.step_y / 32) / world.maxy
			if(src.shadow)
				src.shadow.loc = src.loc
				src.shadow.step_x = src.step_x
				src.shadow.step_y = src.step_y
		..()
	items
		New()
			if(isturf(src.loc)) if(src.icon)
				src.layer = MOB_LAYER + src.laymod - (src.y + src.step_y / 32) / world.maxy
			spawn(1)
				if(src)
					var/icon/i = new(src.icon)
					src.i_width = i.Width()
					src.i_height = i.Height()
					if(src.hashadow) src.create_shadow()
			..()
		Del()
			if(src.shadow) del(src.shadow)
			..()
	var
		adapted = 0
		floor_state
		inven_state
		open = 0
		rarity = 1
		stacks = 1 //-1 makes sure this item doesn't stack, ever. -2 or 0 means this item was used and should be deleted. In the case of -2, it's because the code takes 1 away from -1.
		stack_exempt = 0
		tmp/image/stack_display

		act
		act_drop
		act_load

		skill_y = -464
		translated_y = 0
		translated_x = 0
		translate_max = 420
		icon_y_saved = 270 //The y that the scrollbar is sitting at
		icon_x_saved = 83 //The x that the scrollbar is sitting at
		y_start = 0
		x_start = 0

		/*
		ki_spread = 2
		ki_dmg = 0
		ki_offence = 0
		ki_power = 0
		ki_damage = 0
		ki_exp = 0
		*/

		//Energy skills vars
		deflectable = 1
		bullet = 0
		active = 0 //Is this obj/skill skipped when checking the players state?
		tmp/using = 0 //Is this skill currently being used in a proc?
		tmp/image/over
		disabled_ko = 1 //Is this skill disabled when you become koed?
		disabled_switch = 0 //Is this attack turned off when another like it is activated?
		repeat = 0 //For skills and macros. If set to 1, the skill in question forces the macro being used to be a repeat macro.
		trait = 0; //Is this a trait or a skill?
		stance = 0;
		//Relations
		relations = 0 //Can be minus for bad and plus for good.
		relation_points = 0 //The longer a player is around another player, the more relation points they get to spend on relations.
		relation_points_comitted = 0 //Number of relation points actually put inside the relations already.
		//Skill info vars
		info_energy_cost = 0 //General idea of energy cost for skill
		info_dmg = 0 //General idea of dmg potential from skill
		info_spd = 0 //General idea of how fast skill moves and/or charges
		info_mastery = 0 //General idea of how long it takes to master and teach
		info_point_cost //How many points this skill costs to unlock
		info_duration //How long the buff lasts for
		info_buffs //Which stats are buffed by this skill
		info_stats //Contains more of the info found inside info_buffs, used for displaying skill bonuses inside the skills menu.
		info_point_cost_type //Which stat points are used to unlock this skill
		info_name //How this skills name would appear as a button. Must include _ instead of spaces.
		list/info_prerequisite //Skill needed before this one can be unlocked. Must be exactly as the name appears for the skills.
		info //The text description of a trait or skill
		info_path //The interface name
		info_calculations //Lets the player know how the damage or buff works mechanically.
		info_relation = "None"//The relation of the players contact, for example, good, bad, rival, lover, ect.
		info_relation_points = 0 //The numerical value of the relation points
		info_cd = 0 //The text format of the cd related to skills.
		info_last_seen = 0 //How many months ago a player last saw a contact
		info_last_loc = null
		info_race
		info_client //The Contact type, player, npc
		info_auth //Type of authentication, Byond, Steam, ect.

		image/img_select = null
		image/img_over = null

		//Tech
		tech_tree //Which of the 3 tech tree's does this tech belong to, physics, genetics or egineering.
		tech_subtech
		tech_parent_path //The associated tech that determines the max lvl of this tech
		tech_time //Time it takes for research to finish
		tech_repeatable = 0 //Can this be repeated, like construction or armor/weapon upgrades?
		tech_upgradable = 0
		tech_exp_gain = 0
		tech_give_txt = "None" //List in txt format of what this tech will give when researched
		tech_needed_txt = "None"
		tech_display = 1;
		tech_lvl = 0
		tech_water = 0 //Can this tech be placed over water/liquid?

		help_text
		tutorial_text
		seen = 0 //Set to 1 if this help topic was seen already
		input_type = "text" //Can be num or text

		//Usually attached to the input box itself and not the player

		tmp/string_full = "" //This is the uncut, full sized length of the text without edits or CSS/maptext edits.
		tmp/list/string_display[10] //These are the actual strings we will show. Because only a certain number of pixels can be shown, and text can be much longer, show the correct part
		tmp/string_selected = ""
		tmp/string_min = 1
		tmp/string_max = 1
		tmp/caret_pos = 1
		tmp/caret_line = 1 //The line the caret is currently on, which is text height divided by 13. (i.e, 52/13=4)
		tmp/display_pos = 1 //This is the pos within the string_display list

		obj/overlay_special = null

		capacity = 0 // How much a battery holds in raw power
		capacity_max = 1000
		on = 0
		on_always = 0
		spawning = 1; //Set to 0 once an item finishes loading/spawning
		tmp/list/remote_views //For the large map, keeps a list of whats seen.
		silo = 0
		build = null //The /type of atom to create once this is clicked in the build menu
		skill_exp = 1 //From 1-100, having 100 in a skill means its fully mastered.
		skill_lvl = 1
		setting = 0 //Can be the setting of a tech item, for example, gravity lvl.
		needs_node = 0 //Does this tech item only function over a node?
		tmp/pos = null //position related to tk minigame
		tutorial_shown = 0
		disable_logout = 0 //If set to 1, prevents this item saving to a players inventory on logout.
		hud_x = 0
		hud_y = 0
		saved_x = 0
		saved_y = 0
		saved_step_x = 0
		saved_step_y = 0
		item_info = null
		scale_x = 64;
		scale_y = 64;
		invul_melee = 0 //Can't be damaged by melee

		//Item icon states
		state_ground = null
		state_wear = null

		//hairs - How many frames per hair and the current frame
		frames = 2
		frame_current = 1

		//skill learning
		//list/cant_learn = list()
		learnable = 1
		difficulty = 10
		added_map = 0 //Set to 1 if this item was added to the mini map display already
		energy_skill = 0

		//HUD vars
		slot = -1
		tmp/obj/slot_taken = null //For inventory slots. A reference to the item thats inside this inventory slot.
		tmp/obj/skill_taken = null //For the skill lots.A reference to the skill thats inside this skill slot.
		image/txt_i //The image text shown when mousing over things.
		display = 1//Whether the bodypart or item should display in a grid or not
		shift_y = 0
		shift_x = 0
		box_x_scale = 128
		box_y_scale = 64
		box_x_shift = 64
		box_y_shift = 32
		tmp/select_started = 0
		tmp/select_end = 0
		tmp/excluded_before = ""
		tmp/excluded_after = ""

		//Pixel offsets, ect.
		p_x = 0 //How many pixels this item should be offset when assigning its icon to an obj, like a players builder mouse.
		p_y = 0