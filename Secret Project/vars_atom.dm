atom
	movable/glide_size = 6
	movable
		var
			toxicity = 0

			energy = 100
			energy_max = 100

			power_exp = 0
			energy_exp = 0
			strength_exp = 0
			endurance_exp = 0
			force_exp = 0
			resistance_exp = 0
			offence_exp = 0
			defence_exp = 0

			psionic_power = 1
			strength = 1
			endurance = 1
			force = 1
			resistance = 1
			offence = 1
			defence = 1

			energy_base = 1
			psionic_power_base = 1
			strength_base = 1
			endurance_base = 1
			force_base = 1
			resistance_base = 1
			offence_base = 1
			defence_base = 1

			ki_power = 1
			ki_force = 1

			ki_offence = 1
			ki_spread = 2
			ki_agility = 1
			force_usage = 1
			tmp/mob/ki_owner = null

			resources = 0
	var
		hp = 100
		hp_max = 100
		id = 0;
		desc_extra = null
		spawned = 0 //Use this to determine if an obj was already created, and saved. For example, if a player has weights and those weights New() proc is called, make sure it doesn't rename them.

		percent_health = 100

		immune_dmg = 0

		level = 1 //Magic or Tech lvl of item or bodypart, or wall.


		submerged = 0
		radius = 5; //Size of effected area for things like gravity, ect.
		activated = 0


		image/img = null
		owner = null
		weight = 0
		bolted = 0 //1 means only tk can unbolt it and the player who created it, 2 means it can never be moved
		power = 0 //powered by batteries?
		fuel = 0
		value = 0
		obj/shadow = null
		obj/reflection = null
		can_pocket = 0 //Set to 1 if this item can be placed inside players inven
		can_activate = 0
		creator = null //As a key or number?
		density_factor = 0 //A var used to determine how dense an object is. For example, roofs are 2, which stops all forms of entry. Others are 1, which won't stop flying, and 0 allows all movement.
		dust = 1 //Set to 1 if hitting this whilst being knocked back creates dust, like a rock. trees do not.
		fake_x = 0
		fake_y = 0
		legendary = 0 //Set to 1 if this obj is a legendary, stops being destroyed.
		hashadow = 0
		hasreflect = 0//Does an obj have a reflection?
		laymod = 1 //The default layer assigned to a obj, which is then decreased based on that objs status, such as using the flight skill.
		shakes = 1
		explode_impact = 0
		mouse_button = "left" //Assigns which mouse button activates this item.
		shudders = 0
		is_node = 0
		go_x = 0
		go_y = 0
		go_z = 0
		i_width = 0 //Height and width in pixels
		i_height = 0
		weather // Sets this tile to have a specific weather type, which is then applied to player upon entering.
		flashing = 0;
		shaking = 0;
		change_icon = 0 //Can this atom have its icon changed?
		icon_original = null //This is the default icon for the atom.
		grav = 1;
		microwaves = 1;

		//Tech power vars
		generator = 0; //Set to 1 if this obj makes power
		can_generate = 1; //Set to 0 for things like solar power at night or non windy days for turbines.
		generates = 0; //How much raw power this obj generates in power
		uses = 0 //How much power this tech drains

		tmp/tracked_y = 0 //Tracks how many micro movements are done on the y axis, to help calculate player layer.
		tmp/turf/lastloc
		tmp/last_step_x = 0
		tmp/last_step_y = 0
		tmp/tmp_dmg = 0 //Lower than 0 are cold locations, higher than 0 are hot.

		tmp/mob/grabbed_by = null //The mob you were grabbed by.
		tmp/tk = 0 //Set to 1 when an atom is being tked
		tmp/prev_loc = null
		tmp/prev_bump = null //the location that this item previously hit something at, so it doesn't happen twice in a row.
		tmp/travel = 0 //How many tiles this item has been moved by TK, and thus how much built up energy it has.
		tmp/KB = 0
		tmp/KB_furrow = 0
		//tmp/tk_pos
		//tmp/lifts = 0 //How many lifts up, or minus for down, this object is moved during the lifting minigame.
		//tmp/lift_delay = 0
		tmp/thrown_str = 1 //How hard this obj was thrown.
		tmp/thrown_offence = 1 //How accurate this obj was thrown.
		tmp/mob/lobber = null //Mob who threw this obj
		tmp/mob/used_by = null;

		//HUD vars
		screen_x = 0
		screen_y = 0
		screen_step_x = 0
		screen_step_y = 0
		hud_moves = 0 //Set to 1 if you can drag and move this hud around the screen.