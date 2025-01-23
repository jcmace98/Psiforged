mob
	proc
		set_stats(var/pp=1,var/eng=1,var/str=1,var/end=1,var/pot=1,var/res=1,var/acc=1,var/ref=1)
			src.energy = eng
			src.energy_max = eng

			src.strength = str
			src.endurance = end
			src.force = pot
			src.resistance = res
			src.offence = acc
			src.defence = ref
		Celestial_Wings()
			var/obj/h = new
			h.icon = 'halo2.dmi'
			h.pixel_y = 30;
			h.pixel_x = 6;
			h.plane = 4
			h.appearance_flags = KEEP_APART
			src.halo = h;
			src.overlays += src.halo;
			src.wings = global.celestial_wings[1]
			src.vis_contents += src.wings
			src.vis_contents += new/obj/effects/celestial_energy

			//src.filters = null
			//src.filters += filter(type="drop_shadow", x=0, y=0,size=5, offset=2, color=rgb(102,204,170))
			//src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)

mob
	races
		Human
			race = "Human"
			icon = 'Human_Base_Male.dmi'
			mortal = 1
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 1
			dark_matter_mod = 1

			need_food = "Yes"
			need_water = "Yes"
			need_o2 = "Yes"
			need_sleep = "Yes"
			tiredness_rate = 0.1
			metabolic_rate = 0.1
			dehydration_rate = 0.1
			has_stomach = 1

			mod_psionic_power = 1
			psionic_power = 1

			percent_health = 100

			strength = 2
			endurance = 2
			force = 2
			resistance = 2
			offence = 2
			defence = 2

			strength_base = 2
			endurance_base = 2
			force_base = 2
			resistance_base = 2
			offence_base = 2
			defence_base = 2

			mod_energy = 2
			mod_strength = 2
			mod_agility = 2
			mod_endurance = 2
			mod_force = 2
			mod_resistance = 2
			mod_offence = 2
			mod_defence = 2
			mod_regeneration = 2
			mod_recovery = 2
			mod_sense = 2
			mod_tech_potential = 4

			//Used to calculate the plus and minus of stats, when creating a char.
			gains_trained_power_mod = 1
			gains_trained_energy_mod = 2
			gains_trained_strength_mod = 2
			gains_trained_endurance_mod = 2
			gains_trained_agility_mod = 2
			gains_trained_force_mod = 2
			gains_trained_resistance_mod = 2
			gains_trained_off_mod = 2
			gains_trained_def_mod = 2
			gains_trained_regen_mod = 2
			gains_trained_recov_mod = 2

			mod_immune_rads = 0
			mod_immune_cold = 0
			mod_immune_heat = 0
			mod_immune_gravity = 0
			mod_immune_microwaves = 0
			mod_immune_toxins = 0

			lifespan = 80
			has_hair = 1
			has_eyes = 1
			gains_trained_energy = 1000
			New()
				..()
				prime = lifespan / 5
				src.ascensions = list()
				src.ascensions = list(new /:divine_body,new /:balanced_soul,new /:divine_mind,new /:human_ascension,new /:petrified_body,new /:dark_soul,new /:lichdom)
				for(var/obj/a in src.ascensions)
					a.name = a.info_name

				src.milestones = list()
				src.milestones = list(new /:microcosmic_orbit,new /:resilient_hide,new /:herculean_muscles,new /:hardened_bones,new /:unified_organs, new /:obliteration_fists, new /:fused_ribcage,new /:third_eye)
				for(var/obj/p in src.milestones)
					p.name = p.info_name

				src.soul = list()
				src.soul = list(new /:the_soul,new /:envy,new /:gluttony,new /:greed,new /:lust,new /:pride,new /:sloth,new /:wrath,new /:charity,new /:chastity,new /:diligence,new /:humility,new /:kindness,new /:patience,new /:temperance,new /:nirvana)
				for(var/obj/p in src.soul)
					p.name = p.info_name
		Custom_Race
			race = "Human"
			icon = 'Human_Base_Male.dmi'
			mortal = 1
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 1
			dark_matter_mod = 1

			need_food = "Yes"
			need_water = "Yes"
			need_o2 = "Yes"
			need_sleep = "Yes"
			tiredness_rate = 0.1
			metabolic_rate = 0.1
			dehydration_rate = 0.1
			has_stomach = 1

			mod_psionic_power = 1

			percent_health = 100

			strength = 10
			endurance = 10
			force = 10
			resistance = 10
			offence = 10
			defence = 10

			strength_base = 10
			endurance_base = 10
			force_base = 10
			resistance_base = 10
			offence_base = 10
			defence_base = 10

			mod_energy = 20
			mod_strength = 10
			mod_agility = 10
			mod_endurance = 10
			mod_force = 10
			mod_resistance = 10
			mod_offence = 10
			mod_defence = 10
			mod_regeneration = 10
			mod_recovery = 10
			mod_sense = 2
			mod_tech_potential = 4

			//Used to calculate the plus and minus of stats, when creating a char.


			mod_immune_rads = 0
			mod_immune_cold = 0
			mod_immune_heat = 0
			mod_immune_gravity = 0
			mod_immune_microwaves = 0
			mod_immune_toxins = 0

			lifespan = 80

			gains_trained_energy = 1000
			New()
				..()
				prime = lifespan / 5
		Sion
			//Saiyan inspired race?
			//Maybe call them Psionian?
			race = "Human"
			icon = 'Human_Base_Male.dmi'
			mortal = 1
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 1
			dark_matter_mod = 1

			need_food = "Yes"
			need_water = "Yes"
			need_o2 = "Yes"
			need_sleep = "Yes"
			tiredness_rate = 0.1
			metabolic_rate = 0.1
			dehydration_rate = 0.1
			has_stomach = 1

			mod_psionic_power = 2

			percent_health = 100

			strength = 10
			endurance = 10
			force = 10
			resistance = 10
			offence = 10
			defence = 10

			strength_base = 10
			endurance_base = 10
			force_base = 10
			resistance_base = 10
			offence_base = 10
			defence_base = 10

			mod_energy = 20
			mod_strength = 10
			mod_agility = 10
			mod_endurance = 10
			mod_force = 10
			mod_resistance = 10
			mod_offence = 10
			mod_defence = 10
			mod_regeneration = 10
			mod_recovery = 10
			mod_sense = 2
			mod_tech_potential = 4

			//Used to calculate the plus and minus of stats, when creating a char.


			mod_immune_rads = 0
			mod_immune_cold = 0
			mod_immune_heat = 0
			mod_immune_gravity = 0
			mod_immune_microwaves = 0
			mod_immune_toxins = 0

			lifespan = 100
			has_hair = 1
			has_eyes = 1
			gains_trained_energy = 100
			New()
				..()
				prime = lifespan / 5
		Yukopian
			/*
			Namekian-style race
			- No bones, entirely plant-based
			- Stronger in sun light, get energy faster from it being daytime?
			- Weak to Cold/Heat
			- Regenerate from death when killed, so long as their seed-pod they were born in is still intact
			- Lay seed pods, instead of eggs
			- Their world can become thick with spores and de-buff others who visit, if they're not careful
			- Their heart is a seed and they can plant themselves into the ground. When they die, they also grow.
			- Can sprout into a mini world-tree using their heart-seed, which will power their plant-vine-network.

			Story goes their world was flooded, and it took years for their mega-world-tree to suck up all the water.
			Now the surviors must go about and cultivate the land once more, planting seeds and tending to the world.
			The more plants and trees that are created, the stronger their race becomes.
			*/
			race = "Yukopian"
			icon = 'Yukopian_male_green.dmi'
			mortal = 1
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 1
			dark_matter_mod = 1

			need_food = "No"
			need_water = "Yes"
			need_o2 = "Yes"
			need_sleep = "Yes"
			tiredness_rate = 0.075
			metabolic_rate = 0.1
			dehydration_rate = 0.1
			has_stomach = 1

			mod_psionic_power = 1.5
			mod_psionic_power_base = 1.5

			percent_health = 100

			strength = 1
			endurance = 1
			force = 1
			resistance = 1
			offence = 1
			defence = 2

			strength_base = 1
			endurance_base = 1
			force_base = 1
			resistance_base = 1
			offence_base = 1
			defence_base = 2

			mod_energy = 2
			mod_strength = 1
			mod_agility = 1
			mod_endurance = 1
			mod_force = 1
			mod_resistance = 1
			mod_offence = 1
			mod_defence = 2
			mod_regeneration = 2
			mod_recovery = 1
			mod_sense = 4
			mod_tech_potential = 1

			//Used to calculate the plus and minus of stats, when creating a char.
			gains_trained_power_mod = 1.5
			gains_trained_energy_mod = 2
			gains_trained_strength_mod = 1
			gains_trained_endurance_mod = 1
			gains_trained_agility_mod = 1
			gains_trained_force_mod = 1
			gains_trained_resistance_mod = 1
			gains_trained_off_mod = 1
			gains_trained_def_mod = 2
			gains_trained_regen_mod = 2
			gains_trained_recov_mod = 1

			mod_immune_rads = 0
			mod_immune_cold = -0.5
			mod_immune_heat = -0.5
			mod_immune_gravity = 0
			mod_immune_microwaves = 0
			mod_immune_toxins = 0.5

			immune_cold_trained = -0.5
			immune_heat_trained = -0.5
			immune_toxins_trained = 0.5

			has_hair = 0
			has_eyes = 1

			lifespan = 250
			gains_trained_energy = 1000
			New()
				..()
				prime = lifespan / 5
				src.ascensions = list()
				src.ascensions = list(new /:petrified_body,new /:dark_soul,new /:lichdom,new /:divine_body,new /:balanced_soul,new /:divine_mind,new /:yukopian_ascension)
				for(var/obj/a in src.ascensions)
					a.name = a.info_name

				src.milestones = list()
				src.milestones = list(new /:microcosmic_orbit,new /:resilient_hide,new /:herculean_muscles,new /:unified_organs,new /:obliteration_fists)
				for(var/obj/p in src.milestones)
					p.name = p.info_name

				src.soul = list()
				src.soul = list(new /:the_soul,new /:envy,new /:gluttony,new /:greed,new /:lust,new /:pride,new /:sloth,new /:wrath,new /:charity,new /:chastity,new /:diligence,new /:humility,new /:kindness,new /:patience,new /:temperance)
				for(var/obj/p in src.soul)
					p.name = p.info_name

				var/obj/hrn = new
				hrn.icon = 'horns_yukopian_01.dmi'
				hrn.appearance_flags = KEEP_TOGETHER
				hrn.layer = src.layer+1
				hrn.pixel_x = -8
				src.horns = hrn
				src.overlays += hrn
		Tyuran
			//Thanos style race
			race = "Human"
			icon = 'Human_Base_Male.dmi'
			mortal = 1
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 1
			dark_matter_mod = 1

			need_food = "Yes"
			need_water = "Yes"
			need_o2 = "Yes"
			need_sleep = "Yes"
			tiredness_rate = 0.1
			metabolic_rate = 0.1
			dehydration_rate = 0.1
			has_stomach = 1

			mod_psionic_power = 15

			percent_health = 100

			strength = 10
			endurance = 10
			force = 10
			resistance = 10
			offence = 10
			defence = 10

			strength_base = 10
			endurance_base = 10
			force_base = 10
			resistance_base = 10
			offence_base = 10
			defence_base = 10

			mod_energy = 20
			mod_strength = 10
			mod_agility = 10
			mod_endurance = 10
			mod_force = 10
			mod_resistance = 10
			mod_offence = 10
			mod_defence = 10
			mod_regeneration = 10
			mod_recovery = 10
			mod_sense = 2
			mod_tech_potential = 4

			//Used to calculate the plus and minus of stats, when creating a char.


			mod_immune_rads = 0
			mod_immune_cold = 0
			mod_immune_heat = 0
			mod_immune_gravity = 0
			mod_immune_microwaves = 0
			mod_immune_toxins = 0

			gains_trained_energy = 1000
			New()
				..()
				prime = lifespan / 5
		Celestial
			race = "Celestial"
			icon = 'Celestial_Base_Male2.dmi'
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 1
			dark_matter_mod = 1

			need_food = "No"
			need_water = "No"
			need_o2 = "No"
			need_sleep = "Yes"
			tiredness_rate = 0.075
			metabolic_rate = 0.05
			dehydration_rate = 0.1
			has_stomach = 0

			mod_psionic_power = 2
			mod_psionic_power_base = 2

			percent_health = 100

			strength = 1
			endurance = 1
			force = 1
			resistance = 1
			offence = 1
			defence = 1

			strength_base = 1
			endurance_base = 1
			force_base = 1
			resistance_base = 1
			offence_base = 1
			defence_base = 1

			mod_energy = 2
			mod_strength = 1
			mod_agility = 1
			mod_endurance = 1
			mod_force = 1
			mod_resistance = 1
			mod_offence = 1
			mod_defence = 1
			mod_regeneration = 1
			mod_recovery = 1
			mod_sense = 2
			mod_tech_potential = 4

			//Used to calculate the plus and minus of stats, when creating a char.
			gains_trained_power_mod = 2
			gains_trained_energy_mod = 2
			gains_trained_strength_mod = 1
			gains_trained_endurance_mod = 1
			gains_trained_agility_mod = 1
			gains_trained_force_mod = 1
			gains_trained_resistance_mod = 1
			gains_trained_off_mod = 1
			gains_trained_def_mod = 1
			gains_trained_regen_mod = 1
			gains_trained_recov_mod = 1

			mod_immune_rads = 0
			mod_immune_cold = 1
			mod_immune_heat = 0
			mod_immune_gravity = 0
			mod_immune_microwaves = 0
			mod_immune_toxins = 0

			mortal = 0
			has_hair = 1
			has_eyes = 1
			gains_trained_energy = 1000
			New()
				..()
				prime = lifespan / 5
				src.ascensions = list()
				src.ascensions = list(new /:whole_body,new /:divine_body,new /:divine_soul,new /:celestial_ascension)
				for(var/obj/a in src.ascensions)
					a.name = a.info_name

				src.milestones = list()
				src.milestones = list(new /:microcosmic_orbit,new /:resilient_hide,new /:herculean_muscles,new /:hardened_bones,new /:unified_organs,new /:obliteration_fists, new /:fused_ribcage)
				for(var/obj/p in src.milestones)
					p.name = p.info_name

				src.soul = list()
				src.soul = list(new /:the_soul,new /:envy,new /:gluttony,new /:greed,new /:lust,new /:pride,new /:sloth,new /:wrath,new /:charity,new /:chastity,new /:diligence,new /:humility,new /:kindness,new /:patience,new /:temperance)
				for(var/obj/p in src.soul)
					p.name = p.info_name

				total_organs = length(global.grow_order)
		Cambion
			race = "Human"
			icon = 'Human_Base_Male.dmi'
			mortal = 1
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 1
			dark_matter_mod = 1

			mod_psionic_power = 1

			percent_health = 100

			strength = 10
			endurance = 10
			force = 10
			resistance = 10
			offence = 10
			defence = 10

			strength_base = 10
			endurance_base = 10
			force_base = 10
			resistance_base = 10
			offence_base = 10
			defence_base = 10

			mod_energy = 20
			mod_strength = 10
			mod_agility = 10
			mod_endurance = 10
			mod_force = 10
			mod_resistance = 10
			mod_offence = 10
			mod_defence = 10
			mod_regeneration = 10
			mod_recovery = 10
			mod_sense = 2
			mod_tech_potential = 4

			//Used to calculate the plus and minus of stats, when creating a char.

			mod_immune_rads = 0
			mod_immune_cold = 0
			mod_immune_heat = 0
			mod_immune_gravity = 0
			mod_immune_microwaves = 0
			mod_immune_toxins = 0

			lifespan = 90

			has_stomach = 1

			gains_trained_energy = 1000
			New()
				..()
				prime = lifespan / 5
		Divine
			//Demi-gods?
			race = "Human"
			icon = 'Human_Base_Male.dmi'
			mortal = 0
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 1
			dark_matter_mod = 1

			mod_psionic_power = 2

			percent_health = 100

			strength = 10
			endurance = 10
			force = 10
			resistance = 10
			offence = 10
			defence = 10

			strength_base = 10
			endurance_base = 10
			force_base = 10
			resistance_base = 10
			offence_base = 10
			defence_base = 10

			mod_energy = 20
			mod_strength = 10
			mod_agility = 10
			mod_endurance = 10
			mod_force = 10
			mod_resistance = 10
			mod_offence = 10
			mod_defence = 10
			mod_regeneration = 10
			mod_recovery = 10
			mod_sense = 2
			mod_tech_potential = 4

			//Used to calculate the plus and minus of stats, when creating a char.

			mod_immune_rads = 0
			mod_immune_cold = 0
			mod_immune_heat = 0
			mod_immune_gravity = 0
			mod_immune_microwaves = 0
			mod_immune_toxins = 0

			mortal = 0

			has_stomach = 1
			gains_trained_energy = 1000
			New()
				..()
				prime = lifespan / 5
		Teuthid
			race = "Human"
			icon = 'Human_Base_Male.dmi'
			mortal = 1
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 1
			dark_matter_mod = 1

			mod_psionic_power = 1

			percent_health = 100

			strength = 10
			endurance = 10
			force = 10
			resistance = 10
			offence = 10
			defence = 10

			strength_base = 10
			endurance_base = 10
			force_base = 10
			resistance_base = 10
			offence_base = 10
			defence_base = 10

			mod_energy = 20
			mod_strength = 10
			mod_agility = 10
			mod_endurance = 10
			mod_force = 10
			mod_resistance = 10
			mod_offence = 10
			mod_defence = 10
			mod_regeneration = 10
			mod_recovery = 10
			mod_sense = 2
			mod_tech_potential = 4

			//Used to calculate the plus and minus of stats, when creating a char.

			mod_immune_rads = 0
			mod_immune_cold = 0
			mod_immune_heat = 0
			mod_immune_gravity = 0
			mod_immune_microwaves = 0
			mod_immune_toxins = 0

			lifespan = 90

			has_stomach = 1

			gains_trained_energy = 1000
			New()
				..()
				prime = lifespan / 5
		Cerebroid
			//Aliens
			race = "Cerebroid"
			//icon = 'goog.dmi'
			bounds = "13,-4 to 27,1"
			pixel_x = -16
			pixel_y = -16
			pixel_x_og = -16
			pixel_y_og = -16
			mortal = 1
			divine_energy_mod = 1
			dark_matter_mod = 1

			need_food = "Yes"
			need_water = "Yes"
			need_o2 = "Yes"
			need_sleep = "No"
			tiredness_rate = 0
			metabolic_rate = 0.05
			dehydration_rate = 0.05
			has_stomach = 1

			mod_psionic_power = 1
			psionic_power = 1

			percent_health = 100

			strength = 1
			endurance = 1
			force = 1
			resistance = 1
			offence = 1
			defence = 1

			strength_base = 1
			endurance_base = 1
			force_base = 1
			resistance_base = 1
			offence_base = 1
			defence_base = 1

			mod_energy = 2
			mod_strength = 1
			mod_agility = 1
			mod_endurance = 1
			mod_force = 1
			mod_resistance = 1
			mod_offence = 1
			mod_defence = 1
			mod_regeneration = 1
			mod_recovery = 1
			mod_sense = 2
			mod_tech_potential = 4

			//Used to calculate the plus and minus of stats, when creating a char.
			gains_trained_power_mod = 1
			gains_trained_energy_mod = 2
			gains_trained_strength_mod = 1
			gains_trained_endurance_mod = 1
			gains_trained_agility_mod = 1
			gains_trained_force_mod = 1
			gains_trained_resistance_mod = 1
			gains_trained_off_mod = 1
			gains_trained_def_mod = 1
			gains_trained_regen_mod = 1
			gains_trained_recov_mod = 1

			mod_immune_rads = 0
			mod_immune_cold = 0
			mod_immune_heat = 0
			mod_immune_gravity = 0
			mod_immune_microwaves = 0
			mod_immune_toxins = 0.5

			immune_toxins_trained = 0.5

			lifespan = 80
			has_hair = 0
			has_eyes = 0
			gains_trained_energy = 1000
			New()
				..()
				prime = lifespan / 5
				src.ascensions = list()

				src.milestones = list()
				src.milestones = list(new /:microcosmic_orbit,new /:resilient_hide,new /:herculean_muscles,new /:hardened_bones,new /:unified_organs, new /:obliteration_fists, new /:fused_ribcage)

				src.soul = list()
				src.soul = list(new /:the_soul,new /:envy,new /:gluttony,new /:greed,new /:lust,new /:pride,new /:sloth,new /:wrath,new /:charity,new /:chastity,new /:diligence,new /:humility,new /:kindness,new /:patience,new /:temperance)
				for(var/obj/p in src.soul)
					p.name = p.info_name
		Imp
			race = "Imp"
			icon = 'imp_grey_ears_down.dmi'
			skin_pos = 3
			mortal = 1
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 1
			dark_matter_mod = 1

			need_food = "Yes"
			need_water = "Yes"
			need_o2 = "Yes"
			need_sleep = "Yes"
			tiredness_rate = 0.05
			metabolic_rate = 0.05
			dehydration_rate = 0.05
			has_stomach = 1

			mod_psionic_power = 2

			percent_health = 100

			strength = 1
			endurance = 1
			force = 1
			resistance = 1
			offence = 1
			defence = 1

			strength_base = 1
			endurance_base = 1
			force_base = 1
			resistance_base = 1
			offence_base = 1
			defence_base = 1

			mod_energy = 2
			mod_strength = 1
			mod_agility = 1
			mod_endurance = 1
			mod_force = 1
			mod_resistance = 1
			mod_offence = 1
			mod_defence = 1
			mod_regeneration = 1
			mod_recovery = 1
			mod_sense = 2
			mod_tech_potential = 4

			//Used to calculate the plus and minus of stats, when creating a char.
			gains_trained_power_mod = 2
			gains_trained_energy_mod = 2
			gains_trained_strength_mod = 1
			gains_trained_endurance_mod = 1
			gains_trained_agility_mod = 1
			gains_trained_force_mod = 1
			gains_trained_resistance_mod = 1
			gains_trained_off_mod = 1
			gains_trained_def_mod = 1
			gains_trained_regen_mod = 1
			gains_trained_recov_mod = 1

			mod_immune_rads = 0
			mod_immune_cold = 0
			mod_immune_heat = 0
			mod_immune_gravity = 0
			mod_immune_microwaves = 0
			mod_immune_toxins = 0

			lifespan = 1000
			has_hair = 0
			has_eyes = 1
			gains_trained_energy = 1000
			New()
				..()
				prime = lifespan / 5
				src.ascensions = list()
				src.ascensions = list(new /:divine_mind,new /:petrified_body,new /:dark_soul,new /:lichdom)
				for(var/obj/a in src.ascensions)
					a.name = a.info_name

				src.milestones = list()
				src.milestones = list(new /:microcosmic_orbit,new /:resilient_hide,new /:herculean_muscles,new /:hardened_bones,new /:unified_organs,new /:obliteration_fists, new /:fused_ribcage)
				for(var/obj/p in src.milestones)
					p.name = p.info_name

				src.soul = list()
				src.soul = list(new /:the_soul,new /:envy,new /:gluttony,new /:greed,new /:lust,new /:pride,new /:sloth,new /:wrath,new /:charity,new /:chastity,new /:diligence,new /:humility,new /:kindness,new /:patience,new /:temperance)
				for(var/obj/p in src.soul)
					p.name = p.info_name
		Manakin
			race = "Human"
			icon = 'Human_Base_Male.dmi'
			mortal = 0
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 1
			dark_matter_mod = 1

			mod_psionic_power = 1

			percent_health = 100

			strength = 10
			endurance = 10
			force = 10
			resistance = 10
			offence = 10
			defence = 10

			strength_base = 10
			endurance_base = 10
			force_base = 10
			resistance_base = 10
			offence_base = 10
			defence_base = 10

			mod_energy = 20
			mod_strength = 10
			mod_agility = 10
			mod_endurance = 10
			mod_force = 10
			mod_resistance = 10
			mod_offence = 10
			mod_defence = 10
			mod_regeneration = 10
			mod_recovery = 10
			mod_sense = 2
			mod_tech_potential = 4

			//Used to calculate the plus and minus of stats, when creating a char.

			mod_immune_rads = 0
			mod_immune_cold = 0
			mod_immune_heat = 0
			mod_immune_gravity = 0
			mod_immune_microwaves = 0
			mod_immune_toxins = 0

			has_stomach = 1
			gains_trained_energy = 1000
			New()
				..()
				prime = lifespan / 5
		Android
			race = "Android"
			icon = 'android_liquid_male.dmi'
			mortal = 1
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 0
			dark_matter_mod = 1

			need_food = "No"
			need_water = "No"
			need_o2 = "No"
			need_sleep = "No"
			tiredness_rate = 0
			metabolic_rate = 0
			dehydration_rate = 0
			has_stomach = 0

			radius = 1

			mod_psionic_power = 3

			percent_health = 100

			strength = 1
			endurance = 1
			force = 1
			resistance = 1
			offence = 1
			defence = 1

			strength_base = 1
			endurance_base = 1
			force_base = 1
			resistance_base = 1
			offence_base = 1
			defence_base = 1

			mod_energy = 2.5
			mod_strength = 1
			mod_agility = 1
			mod_endurance = 1
			mod_force = 1
			mod_resistance = 1
			mod_offence = 1
			mod_defence = 1
			mod_regeneration = 1
			mod_recovery = 1
			mod_sense = 2
			mod_tech_potential = 4

			//Used to calculate the plus and minus of stats, when creating a char.
			gains_trained_power_mod = 3
			gains_trained_energy_mod = 3
			gains_trained_strength_mod = 1
			gains_trained_endurance_mod = 1
			gains_trained_agility_mod = 1
			gains_trained_force_mod = 1
			gains_trained_resistance_mod = 1
			gains_trained_off_mod = 1
			gains_trained_def_mod = 1
			gains_trained_regen_mod = 1
			gains_trained_recov_mod = 1

			mod_immune_rads = 1
			mod_immune_cold = 1
			mod_immune_heat = 1
			mod_immune_gravity = 0.5
			mod_immune_microwaves = -0.5
			mod_immune_toxins = 2

			immune_rads_trained = 1
			immune_cold_trained = 1
			immune_heat_trained = 1
			immune_gravity_trained = 0.5
			immune_microwaves_trained = -0.5
			immune_toxins_trained = 2

			has_hair = 1
			has_eyes = 1
			lifespan = 1000
			gains_trained_energy = 1000
			gains_trained_o2 = 0
			New()
				..()
				prime = lifespan / 5
				src.soul = list()

				src.milestones = list()

				src.ascensions = list()
				src.ascensions = list(new /:robotic_ascension)
				for(var/obj/p in src.ascensions)
					p.name = p.info_name
				prime = lifespan / 5
		Kemono
			race = "Human"
			icon = 'Human_Base_Male.dmi'
			mortal = 1
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 1
			dark_matter_mod = 1

			mod_psionic_power = 1

			percent_health = 100

			strength = 10
			endurance = 10
			force = 10
			resistance = 10
			offence = 10
			defence = 10

			strength_base = 10
			endurance_base = 10
			force_base = 10
			resistance_base = 10
			offence_base = 10
			defence_base = 10

			mod_energy = 20
			mod_strength = 10
			mod_agility = 10
			mod_endurance = 10
			mod_force = 10
			mod_resistance = 10
			mod_offence = 10
			mod_defence = 10
			mod_regeneration = 10
			mod_recovery = 10
			mod_sense = 2
			mod_tech_potential = 4

			//Used to calculate the plus and minus of stats, when creating a char.

			mod_immune_rads = 0
			mod_immune_cold = 0
			mod_immune_heat = 0
			mod_immune_gravity = 0
			mod_immune_microwaves = 0
			mod_immune_toxins = 0

			lifespan = 80

			has_stomach = 1
			gains_trained_energy = 1000
			New()
				..()
				prime = lifespan / 5
		Demon
			/*
			Maybe give them the ability to manifest a sword made from bone.
			The more bodyparts they have, the longer they can remain in the mortal realms? Since they are made from ectoplasm, the more parts they have, the better than can remain.

			When they ascend, they can choose an aspect. So if they choose shadow/fire/diamond for example, their flesh becomes infused with shadow/fire/diamond.
			*/
			race = "Demon"
			icon = 'Demon_Red_Male.dmi'
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 1
			dark_matter_mod = 1
			psiforging_speed = 2

			need_food = "No"
			need_water = "No"
			need_o2 = "No"
			need_sleep = "Yes"
			tiredness_rate = 0.075
			metabolic_rate = 0.1
			dehydration_rate = 0.05
			has_stomach = 0

			mod_psionic_power = 1.5

			percent_health = 100

			strength = 1
			endurance = 10
			force = 1
			resistance = 10
			offence = 1
			defence = 1

			strength_base = 1
			endurance_base = 1
			force_base = 1
			resistance_base = 1
			offence_base = 1
			defence_base = 1

			mod_energy = 2
			mod_strength = 1
			mod_agility = 1
			mod_endurance = 1
			mod_force = 1
			mod_resistance = 1
			mod_offence = 1
			mod_defence = 1
			mod_regeneration = 1
			mod_recovery = 1
			mod_sense = 2
			mod_tech_potential = 1

			//Used to calculate the plus and minus of stats, when creating a char.
			gains_trained_power_mod = 1.5
			gains_trained_energy_mod = 2
			gains_trained_strength_mod = 1
			gains_trained_endurance_mod = 1
			gains_trained_agility_mod = 1
			gains_trained_force_mod = 1
			gains_trained_resistance_mod = 1
			gains_trained_off_mod = 1
			gains_trained_def_mod = 1
			gains_trained_regen_mod = 1
			gains_trained_recov_mod = 1

			mod_immune_rads = 0
			mod_immune_cold = 0
			mod_immune_heat = 1
			mod_immune_gravity = 0
			mod_immune_microwaves = 0
			mod_immune_toxins = 0

			immune_heat_trained = 1

			mortal = 0
			has_hair = 1
			has_eyes = 1
			gains_trained_energy = 1000
			New()
				..()
				prime = lifespan / 5
				src.ascensions = list()
				src.ascensions = list(new /:whole_body,new /:dark_body,new /:dark_soul,new /:demonic_ascension)
				for(var/obj/a in src.ascensions)
					a.name = a.info_name

				src.milestones = list()
				src.milestones = list(new /:microcosmic_orbit,new /:resilient_hide,new /:herculean_muscles,new /:hardened_bones,new /:unified_organs,new /:obliteration_fists, new /:fused_ribcage)
				for(var/obj/p in src.milestones)
					p.name = p.info_name

				src.soul = list()
				src.soul = list(new /:the_soul,new /:envy,new /:gluttony,new /:greed,new /:lust,new /:pride,new /:sloth,new /:wrath,new /:charity,new /:chastity,new /:diligence,new /:humility,new /:kindness,new /:patience,new /:temperance)
				for(var/obj/p in src.soul)
					p.name = p.info_name

				total_organs = length(global.grow_order)
		Manite
			race = "Human"
			icon = 'Human_Base_Male.dmi'
			mortal = 0
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 1
			dark_matter_mod = 1

			mod_psionic_power = 3

			percent_health = 100

			strength = 10
			endurance = 10
			force = 10
			resistance = 10
			offence = 10
			defence = 10

			strength_base = 10
			endurance_base = 10
			force_base = 10
			resistance_base = 10
			offence_base = 10
			defence_base = 10

			mod_energy = 20
			mod_strength = 10
			mod_agility = 10
			mod_endurance = 10
			mod_force = 10
			mod_resistance = 10
			mod_offence = 10
			mod_defence = 10
			mod_regeneration = 10
			mod_recovery = 10
			mod_sense = 2
			mod_tech_potential = 4

			//Used to calculate the plus and minus of stats, when creating a char.

			has_stomach = 1
			gains_trained_energy = 1000
			New()
				..()
				prime = lifespan / 5
		Splicer
			race = "Human"
			icon = 'Human_Base_Male.dmi'
			mortal = 1
			pixel_x_og = 0
			pixel_y_og = 0
			divine_energy_mod = 1
			dark_matter_mod = 1

			mod_psionic_power = 2

			percent_health = 100

			strength = 10
			endurance = 10
			force = 10
			resistance = 10
			offence = 10
			defence = 10

			strength_base = 10
			endurance_base = 10
			force_base = 10
			resistance_base = 10
			offence_base = 10
			defence_base = 10

			mod_energy = 20
			mod_strength = 10
			mod_agility = 10
			mod_endurance = 10
			mod_force = 10
			mod_resistance = 10
			mod_offence = 10
			mod_defence = 10
			mod_regeneration = 10
			mod_recovery = 10
			mod_sense = 2
			mod_tech_potential = 4

			//Used to calculate the plus and minus of stats, when creating a char.
			has_stomach = 1
			gains_trained_energy = 1000
			New()
				..()
				prime = lifespan / 5