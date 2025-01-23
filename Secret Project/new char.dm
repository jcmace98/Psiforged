/*
.:Cheat sheet for character creation:.

create_research()
	- Creates all the research for a player and puts it into their technology list

create_body()
	- Creates the players body, first creating the bodyparts list, then adding bodyparts(head,torso,leftarm,rightarm,rightleg,leftleg)
	- head
	- torso
	- leftarm
	- rightarm
	- rightleg
	- leftleg

create_menus()
	- Creates all the main menus for the player
	- Is activated on world startup, using the empty player shells that are stored

create_races()
	- Only used once and on world creation
	- Creates 100 of each race and stores them in a list
	- Player then gets made into one of these empty shells, filling them

set_lists()
	- A special proc run only once per race, that sets up all their lists to = list()
	- Supposed to help with game memory allocation, especially on objects
	- Reason being because when you assign a list() in vars, then use new to create a mob/obj, it will use resources to allocate a new list
	- Using list = list() is supposed to help stop unneeded allocation

.:Things that share a loc with a player:.
    --- i.e, Meditation.loc = usr ---

	- All skills are inside the player
	- All menus are inside the player
	- All inventory objs are inside the player
	- Avatar/Player portrait

.:Player tech buttons:.
	- The button codes are located at /obj/hud/buttons/expand_buttons/tech_expand_buttons, which consist of engineering, genetics and physics
	- The buttons are actually the ones responsible/setup for creating what tech is displayed when clicked or first opening the menus
	- The expand_button is the one responsible for setting up what is displayed under the "Build Tech" tab
	- Excpand buttons uses create_expand_buttons() to create all the tech that can be clicked on, which the player has already researched
	- The create_expand_buttons() proc makes sure to link the button for that tech with the actual tech, using the tech_ref var
*/

mob
	proc
		confirm_creation()
			src.confirm = "confirm char"
			src.confirm_text = "Confirm this character?"
			//var/t = winget(src,"char_creation.input_name","text")
			var/obj/n = src.hud_char.name_input
			var/t = n.maptext
			if(src.mod_points_spent != 10)
				src.confirm_text = "Confirm this character? You still have points to spend."
			if(t == "" || t == null || t == " " || t == "[css_outline]<font size = 1><left>")
				t = "[src.key]"
				src.confirm_text = "Confirm this character? No name selected."
				t = src.key
			if(!t && src.mod_points_spent != 10)
				src.confirm_text = "Confirm? You still have points to spend and no name."
			if(global.names_taken.Find(t) || findtext(t,"npc"))
				src.confirm_text = "That name is already taken."
				//winset(src,"confirm.label_confirm","text=\"[src.confirm_text]\"")
				//winset(src,"confirm.cross","is-disabled=true")
				//winshow(src,"confirm",1)
				src.hud_confirm.confirm_text(1,"[src.confirm_text]",src)
				src.confirm = "cancel char"
				return
			src.name = t
			src.real_name = t
			//src.ai_name = t
			//winset(src,"confirm.label_confirm","text=\"[src.confirm_text]\"")
			//winset(src,"confirm","pos=[src.scrwidth/2],[src.scrheight/2]")
			//winshow(src,"confirm",1)
			src.hud_confirm.confirm_text(1,"[src.confirm_text]",src)
		reset_mods()
			src.mod_points_spent = 0
			src.mod_points = 10
			src.mod_energy_points = 0
			src.mod_strength_points = 0
			src.mod_endurance_points = 0
			src.mod_agility_points = 0
			src.mod_force_points = 0
			src.mod_resistance_points = 0
			src.mod_offence_points = 0
			src.mod_defence_points = 0
			src.mod_regeneration_points = 0
			src.mod_recovery_points = 0

			src.mod_energy = initial(src.mod_energy)
			src.mod_strength = initial(src.mod_strength)
			src.mod_agility = initial(src.mod_agility)
			src.mod_endurance = initial(src.mod_endurance)
			src.mod_force = initial(src.mod_force)
			src.mod_resistance = initial(src.mod_resistance)
			src.mod_offence = initial(src.mod_offence)
			src.mod_defence = initial(src.mod_defence)
			src.mod_regeneration = initial(src.mod_regeneration)
			src.mod_recovery = initial(src.mod_recovery)
			src.mod_sense = initial(src.mod_sense)
			src.mod_tech_potential = initial(src.mod_tech_potential)

			src.mod_energy_base = initial(src.mod_energy_base)
			src.mod_strength_base = initial(src.mod_strength_base)
			src.mod_endurance_base = initial(src.mod_endurance_base)
			src.mod_agility_base = initial(src.mod_agility_base)
			src.mod_force_base = initial(src.mod_force_base)
			src.mod_resistance_base = initial(src.mod_resistance_base)
			src.mod_offence_base = initial(src.mod_offence_base)
			src.mod_defence_base = initial(src.mod_defence_base)
			src.mod_regeneration_base = initial(src.mod_regeneration_base)
			src.mod_recovery_base = initial(src.mod_recovery_base)

			src.gains_trained_power_mod = initial(src.gains_trained_power_mod)
			src.gains_trained_energy_mod = initial(src.gains_trained_energy_mod)
			src.gains_trained_strength_mod = initial(src.gains_trained_strength_mod)
			src.gains_trained_endurance_mod = initial(src.gains_trained_endurance_mod)
			src.gains_trained_agility_mod = initial(src.gains_trained_agility_mod)
			src.gains_trained_force_mod = initial(src.gains_trained_force_mod)
			src.gains_trained_resistance_mod = initial(src.gains_trained_resistance_mod)
			src.gains_trained_off_mod = initial(src.gains_trained_off_mod)
			src.gains_trained_def_mod = initial(src.gains_trained_def_mod)
			src.gains_trained_regen_mod = initial(src.gains_trained_regen_mod)
			src.gains_trained_recov_mod = initial(src.gains_trained_recov_mod)

			src.hair_pos = 1
			src.eye_pos = 1
			src.mouth_pos = 1
			src.horn_pos = 1
			src.nose_pos = 1
			src.skin_pos = 1
			src.body_pos = 1
			if(src.has_hair) src.hair_pos = 11
		set_info_box()
			if(src.info_box1) src.info_box1.destroy()
			if(src.info_box2) src.info_box2.destroy()
			if(src.info_box3) src.info_box3.destroy()

			var/obj/o1 = new
			o1.icon = 'new_hud_pixel.dmi'
			o1.plane = 40
			o1.layer = 40
			o1.appearance_flags = PIXEL_SCALE
			o1.mouse_opacity = 0
			src.info_box1 = o1

			var/obj/o2 = new
			o2.icon = 'new_hud_tiny_box.dmi'
			o2.plane = 40
			o2.layer = 41
			o2.appearance_flags = PIXEL_SCALE
			o2.mouse_opacity = 0
			src.info_box2 = o2

			var/obj/o3 = new
			o3.icon = null
			o3.plane = 40
			o3.layer = 42
			o3.maptext_x = 7
			o3.maptext_y = 1
			o3.appearance_flags = PIXEL_SCALE
			o3.mouse_opacity = 0
			src.info_box3 = o3
		switch_race(var/new_race)
			src.loc = null
			src.choosing_character = 0
			src.started = 0
			src.transform = null
			var/mob/races/m = null
			//If the player is trying to switch to a new race, make sure var/mob/m is correctly set to one of the mobs inside the corresponding race lists
			switch(new_race)
				if("Human")
					if(races_humans.len > 0)
						m = races_humans[1]
						races_humans -= races_humans[1]
				if("Demon")
					if(races_demons.len > 0)
						m = races_demons[1]
						races_demons -= races_demons[1]
				if("Celestial")
					if(races_celestials.len > 0)
						m = races_celestials[1]
						races_celestials -= races_celestials[1]
				if("Android")
					if(races_androids.len > 0)
						m = races_androids[1]
						races_androids -= races_androids[1]
				if("Cerebroid")
					if(races_cerebroids.len > 0)
						m = races_cerebroids[1]
						races_cerebroids -= races_cerebroids[1]
				if("Imp")
					if(races_imps.len > 0)
						m = races_imps[1]
						races_imps -= races_imps[1]
				if("Yukopian")
					if(races_yukopians.len > 0)
						m = races_yukopians[1]
						races_yukopians -= races_yukopians[1]
			if(m)
				if(src.hud_char)
					var/obj/txt = src.hud_char.origins_desc_txt
					txt.maptext = ""

				m.sav_active = src.sav_active
				m.hud_char = src.hud_char
				m.hud_updates = src.hud_updates
				m.hud_confirm = src.hud_confirm
				m.hud_confirm_nums = src.hud_confirm_nums

				src.hud_char.loc = m
				src.hud_updates.loc = m
				src.hud_confirm.loc = m
				src.hud_confirm_nums.loc = m

				src.hud_char = null
				src.hud_updates = null
				src.hud_confirm = null
				src.hud_confirm_nums = null

				src.clear_portrait()
				src.sav_active = 0

				//Reset some vars that might of been saved if another player was previously using this mob to assign mod points, age, ect.
				m.started = 0
				m.age = 20
				m.age_soul = 20
				m.birth_year = year-20
				m.choosing_character = 1
				m.loc = locate(260,260,2)
				m.reset_mods()
				m.set_origins()
				m.update_looks()
				m.key = src.key
				m.client.eye = locate(250,250,2)
		set_origins()
			var/xx = 404
			var/yy = 516//-538
			var/obj/hud/menus/char_creation_background/bg = null
			if(src.hud_char) bg = src.hud_char
			//Checks to see if the players learnable_origins has 0 entries in it first.
			if(src.learnable_origins == null) src.learnable_origins = list()
			if(src.learnable_origins.len <= 0)
				for(var/x in origins)
					var/obj/origins/I = new x()
					src.learnable_origins += I
			//Clear the vis_contents of the menu first
			for(var/obj/origins/x in bg.origins_txt_holder.vis_contents)
				bg.origins_txt_holder.vis_contents -= x
			//Start populating the players char_creation_background with the origins
			for(var/obj/origins/x in src.learnable_origins)
				//Clear the origins when switching to another race.
				if(bg && bg.origins_txt_holder) bg.origins_txt_holder.vis_contents -= x
				//Now organise the origins based on if they're locked or not for that players race and apply them to the hud.
				var/learnable = 1
				if(src.race in x.banned_races)
					learnable = 0
					//Ones not added -should- be collected by the garbage collector?
				if(learnable)
					var/matrix/m = matrix()
					yy -= 20
					x.hud_x = xx
					x.hud_y = yy
					m.Translate(x.hud_x,x.hud_y)
					x.transform = m
					if(bg && bg.origins_txt_holder) bg.origins_txt_holder.vis_contents += x
		clear_portrait()
			var/mob/target = src
			if(target.port)
				target.port.port_iris = null
				target.port.port_eyes = null
				for(var/obj/portrait/p in target.port)
					p.destroy()
				if(target.client) target.client.screen -= target.port
				if(target.hud_char) target.hud_char.vis_contents -= target.port
				if(target.hud_load) target.hud_load.vis_contents -= target.port
				target.port.destroy()
				target.port = null
		set_icon(var/mob/target,var/ascend = 0)
			if(target)
				//Clear the old portrait first, making sure to delete any obj/refs
				if(target.port)
					target.port.port_iris = null
					target.port.port_eyes = null
					for(var/obj/portrait/p in target.port)
						p.destroy()
					if(target.client) target.client.screen -= target.port
					if(target.hud_char) target.hud_char.vis_contents -= target.port
					if(target.hud_load) target.hud_load.vis_contents -= target.port
					target.port.destroy()

				//Then re-create the portrait
				target.port = new /obj/portrait/body

				var/obj/portrait/portrait_part/portrait_horns = new(target.port)
				var/obj/portrait/portrait_part/portrait_hair = new(target.port)
				var/obj/portrait/portrait_part/portrait_mouth = new(target.port)
				var/obj/portrait/portrait_part/portrait_nose = new(target.port)
				var/obj/portrait/eyes/portrait_eyes = new(target.port)
				var/obj/portrait/portrait_part/portrait_iris = new(target.port)

				//for(var/obj/p in target.port)
					//world << "DEBUG - Found [p] inside [target.port]"

				target.port.plane = 25
				portrait_iris.layer = 5.2
				portrait_hair.layer = 5.3

				target.port.overlays += /obj/portrait/border
				target.port.underlays += /obj/portrait/background

				portrait_eyes.p_owner = target
				portrait_iris.p_owner = target

				target.port.port_iris = portrait_iris
				target.port.port_eyes = portrait_eyes

				var/b_state = "body1"
				if(target.body_pos == 2) b_state = "body2"
				else if(target.body_pos == 3) b_state = "body3"

				//world << "DEBUG - created [src.port] for [src]"


				var/icon/P

				if(target.gen == "Female")
					switch(target.race)
						if("Demon")
							var/p_icon = 'portrait_demon_female.dmi'
							var/p_state
							var/list/eye_list
							if(target.skin_pos == 1)
								p_icon = 'portrait_demon_female.dmi'
								p_state = "[b_state] skin1"
								eye_list = eyes_portrait_female_demon
							if(target.skin_pos == 2)
								p_icon = 'portrait_demon_female.dmi'
								p_state = "[b_state] skin2"
								eye_list = eyes_portrait_female_demon
							if(target.skin_pos == 3)
								p_icon = 'portrait_human_female.dmi'
								p_state = "[b_state] skin1"
								eye_list = eyes_portrait_female
							if(target.skin_pos == 4)
								p_icon = 'portrait_human_female.dmi'
								p_state = "[b_state] skin2"
								eye_list = eyes_portrait_female
							if(target.skin_pos == 5)
								p_icon = 'portrait_human_female.dmi'
								p_state = "[b_state] skin3"
								eye_list = eyes_portrait_female
							if(target.eye_pos > length(eye_list)) target.eye_pos = 1
							P = icon(p_icon,p_state,SOUTH,1,0)
							target.port.icon = P

							if(target.body_pos != 3)
								var/obj/eyes = eye_list[target.eye_pos]
								portrait_eyes.icon = eyes.icon
								portrait_eyes.icon_state = eyes.icon_state

								var/icon/P_eyes_c = icon(eyes.icon,"[eyes.icon_state] color",SOUTH,1,0)
								if(target.eye_c) P_eyes_c.Blend(target.eye_c)
								else P_eyes_c.Blend(rgb(0,0,155))
								portrait_iris.icon = P_eyes_c
								P.Blend(P_eyes_c,ICON_OVERLAY)

								var/obj/nose = nose_portrait_female[target.nose_pos]
								portrait_nose.icon = nose.icon
								portrait_nose.icon_state = nose.icon_state

								var/obj/mouth = mouth_portrait_female[target.mouth_pos]
								portrait_mouth.icon = mouth.icon
								portrait_mouth.icon_state = mouth.icon_state

								if(target.hair_pos == 11) target.hair_pos = 1 //Added this here for npc's, ect. Just to make sure there's no out of bounds errors, since 11 for female doesn't exist.
								var/obj/hair = hairs_portrait_female[target.hair_pos]
								portrait_hair.icon = hair.icon
								portrait_hair.icon_state = hair.icon_state
						if("Celestial")
							var/p_state = "[b_state] skin1"
							if(ascend) p_state = "[b_state] skin2"
							P = icon('portrait_celestial_female.dmi',p_state,SOUTH,1,0)
							target.port.icon = P

							var/obj/eyes = eyes_portrait_female[target.eye_pos]
							portrait_eyes.icon = eyes.icon
							portrait_eyes.icon_state = eyes.icon_state

							var/icon/P_eyes_c = icon(eyes.icon,"[eyes.icon_state] color",SOUTH,1,0)
							if(target.eye_c) P_eyes_c.Blend(target.eye_c)
							else P_eyes_c.Blend(rgb(0,0,155))
							portrait_iris.icon = P_eyes_c
							P.Blend(P_eyes_c,ICON_OVERLAY)

							var/obj/nose = nose_portrait_female[target.nose_pos]
							portrait_nose.icon = nose.icon
							portrait_nose.icon_state = nose.icon_state

							var/obj/mouth = mouth_portrait_female[target.mouth_pos]
							portrait_mouth.icon = mouth.icon
							portrait_mouth.icon_state = mouth.icon_state

							if(target.hair_pos == 11) target.hair_pos = 1 //Added this here for npc's, ect. Just to make sure there's no out of bounds errors, since 11 for female doesn't exist.
							var/obj/hair = hairs_portrait_female[target.hair_pos]
							portrait_hair.icon = hair.icon
							portrait_hair.icon_state = hair.icon_state
						if("Human")
							var/p_state = 'portrait_human_female.dmi'

							if(target.skin_pos == 1) p_state = "[b_state] skin1"
							if(target.skin_pos == 2) p_state = "[b_state] skin2"
							if(target.skin_pos == 3) p_state = "[b_state] skin3"
							P = icon('portrait_human_female.dmi',p_state,SOUTH,1,0)
							target.port.icon = P

							var/obj/eyes = eyes_portrait_female[target.eye_pos]
							portrait_eyes.icon = eyes.icon
							portrait_eyes.icon_state = eyes.icon_state

							var/icon/P_eyes_c = icon(eyes.icon,"[eyes.icon_state] color",SOUTH,1,0)
							if(target.eye_c) P_eyes_c.Blend(target.eye_c)
							else P_eyes_c.Blend(rgb(0,0,155))
							portrait_iris.icon = P_eyes_c
							P.Blend(P_eyes_c,ICON_OVERLAY)

							var/obj/nose = nose_portrait_female[target.nose_pos]
							portrait_nose.icon = nose.icon
							portrait_nose.icon_state = nose.icon_state

							var/obj/mouth = mouth_portrait_female[target.mouth_pos]
							portrait_mouth.icon = mouth.icon
							portrait_mouth.icon_state = mouth.icon_state

							if(target.hair_pos == 11) target.hair_pos = 1 //Added this here for npc's, ect. Just to make sure there's no out of bounds errors, since 11 for female doesn't exist.
							var/obj/hair = hairs_portrait_female[target.hair_pos]
							portrait_hair.icon = hair.icon
							portrait_hair.icon_state = hair.icon_state

						if("Android")
							var/list/eye_list = null
							var/p_state = "skin1"
							switch(target.skin_pos)
								if(1)
									p_state = "[b_state] skin1"
									P = icon('portrait_android_female.dmi',p_state,SOUTH,1,0)
									eye_list = eyes_portrait_android_female
								if(2)
									p_state = "[b_state] skin2"
									P = icon('portrait_android_female.dmi',p_state,SOUTH,1,0)
								if(3)
									p_state = "[b_state] skin1"
									P = icon('portrait_human_female.dmi',p_state,SOUTH,1,0)
									eye_list = eyes_portrait_female
								if(4)
									p_state = "[b_state] skin2"
									P = icon('portrait_human_female.dmi',p_state,SOUTH,1,0)
									eye_list = eyes_portrait_female
								if(5)
									p_state = "[b_state] skin3"
									P = icon('portrait_human_female.dmi',p_state,SOUTH,1,0)
									eye_list = eyes_portrait_female
							target.port.icon = P

							if(target.skin_pos != 2)
								var/obj/eyes = eye_list[target.eye_pos]
								portrait_eyes.icon = eyes.icon
								portrait_eyes.icon_state = eyes.icon_state

								var/icon/P_eyes_c = icon(eyes.icon,"[eyes.icon_state] color",SOUTH,1,0)
								if(target.skin_pos != 1)
									if(target.eye_c) P_eyes_c.Blend(target.eye_c)
									else P_eyes_c.Blend(rgb(0,0,155))
								portrait_iris.icon = P_eyes_c
								P.Blend(P_eyes_c,ICON_OVERLAY)

								var/obj/nose = nose_portrait_female[target.nose_pos]
								portrait_nose.icon = nose.icon
								portrait_nose.icon_state = nose.icon_state

								var/obj/mouth = mouth_portrait_female[target.mouth_pos]
								portrait_mouth.icon = mouth.icon
								portrait_mouth.icon_state = mouth.icon_state

								if(target.hair_pos == 11) target.hair_pos = 1 //Added this here for npc's, ect. Just to make sure there's no out of bounds errors, since 11 for female doesn't exist.
								var/obj/hair = hairs_portrait_female[target.hair_pos]
								portrait_hair.icon = hair.icon
								portrait_hair.icon_state = hair.icon_state
				if(target.gen == "Male")
					switch(target.race)
						if("Demon")
							var/p_icon = 'portrait_demon_male.dmi'
							var/p_state
							var/list/eye_list
							if(target.skin_pos == 1)
								p_icon = 'portrait_demon_male.dmi'
								p_state = "[b_state] skin1"
								eye_list = eyes_portrait_yuk
							if(target.skin_pos == 2)
								p_icon = 'portrait_demon_male.dmi'
								p_state = "[b_state] skin2"
								eye_list = eyes_portrait_yuk
							if(target.skin_pos == 3)
								p_icon = 'portrait_human_male.dmi'
								p_state = "[b_state] skin1"
								eye_list = eyes_portrait_male
							if(target.skin_pos == 4)
								p_icon = 'portrait_human_male.dmi'
								p_state = "[b_state] skin2"
								eye_list = eyes_portrait_male
							if(target.skin_pos == 5)
								p_icon = 'portrait_human_male.dmi'
								p_state = "[b_state] skin3"
								eye_list = eyes_portrait_male
							if(target.eye_pos > length(eye_list)) target.eye_pos = 1
							P = icon(p_icon,p_state,SOUTH,1,0)
							target.port.icon = P

							if(target.body_pos != 3)
								var/obj/eyes = eye_list[target.eye_pos]
								portrait_eyes.icon = eyes.icon
								portrait_eyes.icon_state = eyes.icon_state

								var/icon/P_eyes_c = icon(eyes.icon,"[eyes.icon_state] color",SOUTH,1,0)
								if(target.eye_c) P_eyes_c.Blend(target.eye_c)
								else P_eyes_c.Blend(rgb(0,0,155))
								portrait_iris.icon = P_eyes_c
								P.Blend(P_eyes_c,ICON_OVERLAY)

								var/obj/nose = nose_portrait_male[target.nose_pos]
								portrait_nose.icon = nose.icon
								portrait_nose.icon_state = nose.icon_state

								var/obj/mouth = mouth_portrait_male[target.mouth_pos]
								portrait_mouth.icon = mouth.icon
								portrait_mouth.icon_state = mouth.icon_state

								var/obj/hair = hairs_portrait_male[target.hair_pos]
								portrait_hair.icon = hair.icon
								portrait_hair.icon_state = hair.icon_state
						if("Celestial")
							var/p_state = "[b_state] skin1"
							if(ascend) p_state = "[b_state] skin2"
							P = icon('portrait_celestial_male.dmi',p_state,SOUTH,1,0)
							target.port.icon = P

							var/obj/eyes = eyes_portrait_male[target.eye_pos]
							portrait_eyes.icon = eyes.icon
							portrait_eyes.icon_state = eyes.icon_state

							var/icon/P_eyes_c = icon(eyes.icon,"[eyes.icon_state] color",SOUTH,1,0)
							if(target.eye_c) P_eyes_c.Blend(target.eye_c)
							else P_eyes_c.Blend(rgb(0,0,155))
							portrait_iris.icon = P_eyes_c
							P.Blend(P_eyes_c,ICON_OVERLAY)

							var/obj/nose = nose_portrait_male[target.nose_pos]
							portrait_nose.icon = nose.icon
							portrait_nose.icon_state = nose.icon_state

							var/obj/mouth = mouth_portrait_male[target.mouth_pos]
							portrait_mouth.icon = mouth.icon
							portrait_mouth.icon_state = mouth.icon_state

							var/obj/hair = hairs_portrait_male[target.hair_pos]
							portrait_hair.icon = hair.icon
							portrait_hair.icon_state = hair.icon_state
						if("Human")
							var/p_state = 'portrait_human_male.dmi'
							if(target.skin_pos == 1) p_state = "[b_state] skin1"
							if(target.skin_pos == 2) p_state = "[b_state] skin2"
							if(target.skin_pos == 3) p_state = "[b_state] skin3"
							P = icon('portrait_human_male.dmi',p_state,SOUTH,1,0)
							target.port.icon = P

							var/obj/eyes = eyes_portrait_male[target.eye_pos]
							portrait_eyes.icon = eyes.icon
							portrait_eyes.icon_state = eyes.icon_state

							var/icon/P_eyes_c = icon(eyes.icon,"[eyes.icon_state] color",SOUTH,1,0)
							if(target.eye_c) P_eyes_c.Blend(target.eye_c)
							else P_eyes_c.Blend(rgb(0,0,155))
							portrait_iris.icon = P_eyes_c
							P.Blend(P_eyes_c,ICON_OVERLAY)

							var/obj/nose = nose_portrait_male[target.nose_pos]
							portrait_nose.icon = nose.icon
							portrait_nose.icon_state = nose.icon_state

							var/obj/mouth = mouth_portrait_male[target.mouth_pos]
							portrait_mouth.icon = mouth.icon
							portrait_mouth.icon_state = mouth.icon_state

							var/obj/hair = hairs_portrait_male[target.hair_pos]
							portrait_hair.icon = hair.icon
							portrait_hair.icon_state = hair.icon_state

						if("Android")
							var/p_state = "skin1"
							var/list/eye_list = null
							switch(target.skin_pos)
								if(1)
									p_state = "skin1"
									P = icon('portrait_android_male.dmi',p_state,SOUTH,1,0)
									eye_list = eyes_portrait_android_male
								if(2)
									p_state = "skin2"
									P = icon('portrait_android_male.dmi',p_state,SOUTH,1,0)
								if(3)
									p_state = "[b_state] skin1"
									P = icon('portrait_human_male.dmi',p_state,SOUTH,1,0)
									eye_list = eyes_portrait_male
								if(4)
									p_state = "[b_state] skin2"
									P = icon('portrait_human_male.dmi',p_state,SOUTH,1,0)
									eye_list = eyes_portrait_male
								if(5)
									p_state = "[b_state] skin3"
									P = icon('portrait_human_male.dmi',p_state,SOUTH,1,0)
									eye_list = eyes_portrait_male
							target.port.icon = P

							if(target.skin_pos != 2)
								var/obj/eyes = eye_list[target.eye_pos]
								portrait_eyes.icon = eyes.icon
								portrait_eyes.icon_state = eyes.icon_state

								var/icon/P_eyes_c = icon(eyes.icon,"[eyes.icon_state] color",SOUTH,1,0)
								if(target.skin_pos != 1)
									if(target.eye_c) P_eyes_c.Blend(target.eye_c)
									else P_eyes_c.Blend(rgb(0,0,155))
								portrait_iris.icon = P_eyes_c
								P.Blend(P_eyes_c,ICON_OVERLAY)

								var/obj/nose = nose_portrait_male[target.nose_pos]
								portrait_nose.icon = nose.icon
								portrait_nose.icon_state = nose.icon_state

								var/obj/mouth = mouth_portrait_male[target.mouth_pos]
								portrait_mouth.icon = mouth.icon
								portrait_mouth.icon_state = mouth.icon_state

								var/obj/hair = hairs_portrait_male[target.hair_pos]
								portrait_hair.icon = hair.icon
								portrait_hair.icon_state = hair.icon_state

				if(target.race == "Yukopian")
					var/p_state = "skin1"
					if(target.skin_pos == 1) p_state = "[b_state] skin1"
					if(target.skin_pos == 2) p_state = "[b_state] skin2"
					if(target.skin_pos == 3) p_state = "[b_state] skin3"
					P = icon('portrait_yukopian.dmi',p_state,SOUTH,1,0)
					target.port.icon = P

					var/obj/nose = nose_portrait_male[target.nose_pos]
					portrait_nose.icon = nose.icon
					portrait_nose.icon_state = nose.icon_state

					var/obj/eyes = eyes_portrait_yuk[target.eye_pos]
					portrait_eyes.icon = eyes.icon
					portrait_eyes.icon_state = eyes.icon_state

					var/icon/P_eyes_c = icon(eyes.icon,"[eyes.icon_state] color",SOUTH,1,0)
					if(target.eye_c) P_eyes_c.Blend(target.eye_c)
					else P_eyes_c.Blend(rgb(0,0,155))
					portrait_iris.icon = P_eyes_c
					P.Blend(P_eyes_c,ICON_OVERLAY)

					var/obj/mouth = mouth_portrait_male[target.mouth_pos]
					portrait_mouth.icon = mouth.icon
					portrait_mouth.icon_state = mouth.icon_state

					var/obj/horn = horns_portrait_yuk[target.horn_pos]
					portrait_horns.icon = horn.icon
					portrait_horns.icon_state = horn.icon_state

				if(target.race == "Cerebroid")
					P = icon('portrait_cerebroid.dmi',"skin1",SOUTH,1,0)
					target.port.icon = P

					var/obj/eyes = eyes_portrait_cerebroid[target.eye_pos]
					portrait_eyes.icon = eyes.icon
					portrait_eyes.icon_state = eyes.icon_state

				for(var/obj/portrait/p in target.port)
					if(p.icon) target.port.vis_contents += p
					else
						//Purge any portrait parts that didn't get assigned an icon
						//No icon means its not used for that race for one reason or another
						p.p_owner = null
						if(p == target.port.port_eyes) target.port.port_eyes = null
						if(p == target.port.port_iris) target.port.port_iris = null
						p.destroy()

				if(portrait_iris.icon)
					if(target.race == "Android" && target.skin_pos == 1)
						if(target.eye_c == null) target.eye_c = rgb(0,0,255)
						portrait_iris.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=src.eye_c)
						portrait_iris.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
					target.port.vis_contents += portrait_iris

				return P
		set_genetic_limits()
			src.gene_limit_psi = round(src.mod_psionic_power + src.gene_limit,0.1)
			src.gene_limit_energy = round(src.mod_energy + src.gene_limit,0.1)
			src.gene_limit_strength = round(src.mod_strength + src.gene_limit,0.1)
			src.gene_limit_endurance = round(src.mod_endurance + src.gene_limit,0.1)
			src.gene_limit_resistance = round(src.mod_resistance + src.gene_limit,0.1)
			src.gene_limit_force = round(src.mod_force + src.gene_limit,0.1)
			src.gene_limit_agility = round(src.mod_agility + src.gene_limit,0.1)
			src.gene_limit_offence = round(src.mod_offence + src.gene_limit,0.1)
			src.gene_limit_defence = round(src.mod_defence + src.gene_limit,0.1)
			src.gene_limit_regen = round(src.mod_regeneration + src.gene_limit,0.1)
			src.gene_limit_recov = round(src.mod_recovery + src.gene_limit,0.1)
		remove_player_blip()
			if(src.map_blip)
				for(var/mob/m in players)
					if(m.client) m.client.images -= src.map_blip
		create_player_blip()
			if(maps_created && src.map_blip == null)
				var/image/map_blip/m_p = image('map_blip.dmi',map_master,"",10)
				if(src.client) m_p.ref = src.client.key
				m_p.pixel_x = src.x-3
				m_p.pixel_y = src.y-19
				src.map_blip = m_p
				if(src.client) src.client.images += m_p
		create_afterimages()
			src.afterimages = list()
			var num = 200;
			while(num > 0) {
				num -= 1;
				var/obj/effects/after_image/af = new
				af.hashadow = 0
				af.enable(src)
				src.afterimages.Add(af)
			}
		create_main_bars()
			if(src.hud_hp_bar == null)
				//Create hp bars
				var/obj/hud/bars/player_hp/b = new
				src.hud_hp_bar = b

				var/obj/hud/bars/player_hp_inner/h = new
				var/matrix/m = matrix()
				m.Scale(src.percent_health*2,1)
				m.Translate(src.percent_health,0)
				h.transform = m
				h.loc = b
				src.hud_hp_bar_inner = h

			if(hud_eng_bar == null)
				//Create eng bars
				var/obj/hud/bars/player_eng/b2 = new
				src.hud_eng_bar = b2

				var/obj/hud/bars/player_eng_inner/m = new
				var/matrix/mt = matrix()
				mt.Scale(src.percent_health*2,1)
				mt.Translate(src.percent_health,0)
				m.transform = mt
				m.loc = b2
				src.hud_eng_bar_inner = m

			if(src.hud_pp == null)
				//Create psionic power bars
				var/obj/pp = new
				pp.maptext_width = 320
				pp.maptext = "<font size = 1> <text align=left>[css_outline]Psionic Power: 0"
				pp.screen_loc = "3:-1,18:-13"
				src.hud_pp = pp

			if(src.hud_eat == null)
				//Create eating bar
				var/obj/hud/bars/player_eat/e = new
				src.hud_eat = e

			if(src.client)
				src.client.screen += src.hud_hp_bar
				src.client.screen += src.hud_hp_bar_inner
				src.client.screen += src.hud_eng_bar
				src.client.screen += src.hud_eng_bar_inner
				src.client.screen += src.hud_pp

		stat_desc(var/stat)
			var/t
			if(stat == "Energy")
				t = text_eng
			if(stat == "Strength")
				t = text_str
			if(stat == "Endurance")
				t = text_end
			if(stat == "Agility")
				t = text_agil
			if(stat == "resistance")
				t = text_res
			if(stat == "Force")
				t = text_force
			if(stat == "Offence")
				t = text_acc
			if(stat == "Defence")
				t = text_reflex
			if(stat == "Recovery")
				t = text_recov
			if(stat == "Regeneration")
				t = text_regen
			winset(src,"char_creation.stat_info","text=\"[t]\"")
			winset(src,"char_creation.label_stat","text=\"[stat]\"")
		switch_character()
			src.client.screen += src.screen_text
			src.client.images += src.map_blip
			src.client.screen += src.hud_info
			src.enable_planes()
			src.create_main_bars()
			if(src.port)
				src.client.screen += src.port
				src.port.transform = null
		confirm_new_character()
			src.transform = null
			src.confirm_stats()

			var/image/ko = image('bars_ko.dmi',src,"100",20)
			src.bar_ko = ko

			if(src.vision == null)
				var/obj/effects/vision/v = new
				src.vision = v
				if(src.client) src.client.screen += v

			src.tutorials = list(new /:Help_Underwater,new /:Help_Meditation,new /:Help_Focus,new /:Help_Bodyparts,new /:Help_Death,new /:Help_Grabbing,new /:Help_Divine_Energy,new /:Help_Skill_Points,new /:Help_Combat_Levels,new /:Alert_Misc,new /:Help_Map,new /:Help_Bodypart_Stats,new /:Help_Cybernetics,new /:Help_Gravity,new /:Help_Dark_Matter)

			if(src.started == 0)
				src.vision.alpha = 255
				animate(src.vision,alpha = 0,time = 20)
				src.starting_skills(0) //Create any starting skills for the player
				src.round_mods()
				src.real_name = "[src.name]"
				src.icon_original = src.icon
				src.enable_planes()
				src.create_main_bars()
				src.create_afterimages()

				if(src.origin_selected)
					var/obj/origins/o = new src.origin_selected.type (src)
					call(o.act)(src,o)
					src.origin_selected = null

				if(src.origin && src.origin.type == /obj/origins/skilled)
					for(var/obj/skills/s in src)
						s.skill_lvl += 24

				var/obj/effects/screen_text/st = new
				src.screen_text = st
				var/obj/hud/menus/info/inf = new
				src.hud_info = inf
				var/obj/hud/bars/name_bar/nb = new
				src.hud_namebar = nb

				if(src.race == "Demon")
					src.loc = locate(250,475,2)
					var/obj/skills/Incubation/inc = new
					inc.loc = src
				else if(src.race == "Android")
					src.loc = locate(38,233,3)
				else if(src.race == "Celestial")
					src.loc = locate(290,42,2)
					spawn(20)
						if(src) src.Celestial_Wings()
					var/obj/skills/Incubation/inc = new
					inc.loc = src
					var/obj/skills/Hide_Wings/hw = new
					hw.loc = src
				else if(src.race == "Imp") src.loc = locate(65,336,2)
				else if(src.race == "Yukopian")
					src.loc = locate(250,250,4)
					src.give_divine_seed()
				else src.loc = locate(123,335,1)

				if(src.race == "Cerebroid")
					src.hair = null
					src.overlays = null
					src.give_extra_lobe()
					src.total_organs += 1
				else if(src.race == "Android")
					src.rad_field()
					if(src.skin_pos == 1 && src.eyes)
						src.eyes.icon = 'humanoid_eyes_iris_android.dmi'
						if(src.eye_c == null) src.eye_c = rgb(0,0,255)
						src.eyes.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=src.eye_c)
						src.eyes.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)

			if(isobj(src.loc))
				var/obj/o = src.loc
				src.loc = o.loc

			if(src.z == 2) src.apply_afterlife_glow(1)
			else src.apply_afterlife_glow(0)

			if(src.client)
				if(!players.Find(src)) players += src
				src.show_worldtree(1)
				if(src.client) winset(src,"chat","alpha=190")
				if(src.client) winset(src,"chat.alpha","value=45")

				src.client.screen += src.screen_text
				if(src.hud_chat) src.client.screen += src.hud_chat
				//Music
				//src.update_tracks()
				src.music_random = 0
				//src.StopMidi()
				//src.play_all_music()
				src.title(1)
				src.client.screen += src.hud_info
				src.setup_alert_history()
				src.change_icon = 1
				src.byond_key = src.key
				src.new_contact_world()
				src.gain_relations()
				src.show_ui()
				//src.sight = SEE_BLACKNESS// | SEE_PIXELS
				src.online = 1
				//src.create_research() //Create all the tech for the player

			src.SAVEFILE_VERSION = game_version
			src.name_txt()
			src.create_player_blip()
			src.log_year = global.year
			src.log_psi_year = global.psi_year
			if(global.names_taken.Find(src.real_name) == 0) global.names_taken += src.real_name
			world.Save_Contacts()
			src.set_shadow()
			src.eyes_copy = src.eyes
			src.eyes_white_copy = src.eyes_white
			if(src.hud_body) src.hud_body.color_paperdoll(src)
			src.started = 1
			src.choosing_character = 0
			src.can_save = 1
			spawn(20)
				if(src)
					src.process_stats()
			if(src.client)
				src.key_save()
				if(src.port)
					src.client.screen += src.port
					src.port.transform = null
		confirm_stats()
			//Set new character starting stats here based on their mods.
			src.psionic_power = 1*src.mod_psionic_power
			src.energy_max = 1*src.mod_energy
			src.strength = 1*src.mod_strength
			src.endurance = 1*src.mod_endurance
			src.force = 1*src.mod_force
			src.resistance = 1*src.mod_resistance
			src.offence = 1*src.mod_offence
			src.defence = 1*src.mod_defence
		create_menus()
			var/obj/hud/menus/core_stats_background/bg = new
			src.hud_stats = bg
			bg.loc = src
			bg.menu_create()

			var/obj/hud/menus/inventory_background/inv = new
			src.hud_inv = inv
			inv.loc = src
			inv.menu_create()

			var/obj/hud/menus/tech_background/tech = new
			src.hud_tech = tech
			tech.loc = src
			tech.menu_create()

			var/obj/hud/menus/unlocks_background/unlocks = new
			src.hud_unlocks = unlocks
			unlocks.loc = src
			unlocks.menu_create()

			var/obj/hud/menus/options_background/opt = new
			src.hud_opt = opt
			opt.loc = src
			opt.menu_create()

			var/obj/hud/menus/skills_background/skl = new
			src.hud_skills = skl
			skl.loc = src
			skl.menu_create()

			var/obj/hud/menus/bodyparts_background/bp = new
			src.hud_body = bp
			bp.loc = src
			bp.menu_create()

			var/obj/hud/menus/contacts_background/cb = new
			src.hud_contacts = cb
			cb.loc = src
			cb.menu_create()

			var/obj/hud/menus/build_background/bb = new
			src.hud_build = bb
			bb.loc = src
			bb.menu_create()

			var/obj/hud/menus/chat_background/ch = new
			src.hud_chat = ch
			ch.loc = src
			ch.menu_create()

			var/obj/hud/menus/help_background/h = new
			src.hud_help = h
			h.loc = src
			h.menu_create()
		starting_skills(var/all = 0)
			var/obj/skills/Meditate/m = new
			m.loc = src
			src.skill_meditation = m

			src.add_to_skillbar(m,src.hud_skillbar[1])

			var/obj/skills/Wrestle/w = new
			w.loc = src

			var/obj/skills/Dig/dg = new
			dg.loc = src

			var/obj/skills/Sleep/slp = new
			slp.loc = src

			var/obj/skills/Attack/att = new
			att.loc = src

			src.add_to_skillbar(att,src.hud_skillbar[2])

			var/obj/skills/Finish/fin = new
			fin.loc = src

			var/obj/skills/Psi_Clone/psi_c = new
			psi_c.loc = src

			if(all)

				var/obj/skills/Active_Meditation/am = new
				am.loc = src

				var/obj/skills/Flight/fl = new
				fl.loc = src

				var/obj/skills/Divine_Weapon/dw = new
				dw.loc = src

				var/obj/skills/Sense/sn = new
				sn.loc = src

				var/obj/skills/Germination/gm = new
				gm.loc = src

				var/obj/skills/Cleanse/cl = new
				cl.loc = src

				var/obj/skills/Stunning_Blow/sb = new
				sb.loc = src

				var/obj/skills/Five_Hit_Exploding_Heart_Technique/tod = new
				tod.loc = src

				var/obj/skills/Dark_Petrifaction/dp = new
				dp.loc = src

				var/obj/skills/Dark_Transmutation/dt = new
				dt.loc = src

				var/obj/skills/Dark_Formation/df = new
				df.loc = src

				var/obj/skills/Psi_Lightning/psi_l = new
				psi_l.loc = src

				var/obj/skills/Psi_Storm/psi_s = new
				psi_s.loc = src

				var/obj/skills/Psionic_Lance/pl = new
				pl.loc = src

				var/obj/skills/Astral_Projection/ap = new
				ap.loc = src

				var/obj/skills/Remote_Viewing/rm = new
				src.skill_remote_viewing = rm
				rm.loc = src

				var/obj/skills/Teleportation/tp = new
				tp.loc = src

				var/obj/skills/Reformation/rr = new
				rr.loc = src

				var/obj/skills/Revivification/rv = new
				rv.loc = src

				var/obj/skills/Restoration/res = new
				res.loc = src

				var/obj/skills/Telepathy/tel = new
				tel.loc = src

				var/obj/skills/Beam/be = new
				be.loc = src

				var/obj/skills/Invisibility/i = new
				i.loc = src

				var/obj/skills/Expand/e = new
				e.loc = src

				var/obj/skills/Focus/f = new
				f.loc = src

				var/obj/skills/Charge/ch = new
				ch.loc = src

				var/obj/skills/Self_Destruct/SD = new
				SD.loc = src

				var/obj/skills/Obfuscation/ob = new
				ob.loc = src

				var/obj/skills/Super_Speed/SP = new
				SP.loc = src

				var/obj/skills/Divine_Infusion/di = new
				di.loc = src

				var/obj/skills/Dark_Infusion/dark = new
				dark.loc = src

				var/obj/skills/Crane_Breathing/cr = new
				cr.loc = src

			if(src.client)
				var/count = 0
				for(var/obj/skills/o in src)
					src << output(o,"skills.grid_skills:[++count]")
				winset(src, "skills.grid_skills", "cells=\"[count]\"")
		tmp_lists()
			remembers_strength = list()
			remembers_endurance = list()
			remembers_agility = list()
			remembers_resistance = list()
			remembers_force = list()
			remembers_offence = list()
			remembers_defence = list()
			remembers_recovery = list()
			remembers_regeneration = list()
			blips = list()
			open_menus = list()
			chat_see = list()
			hurt_limbs = list()

			power_sources = list()
			energy_sources = list()
			divine_sources = list()
			dark_matter_sources = list()
			strength_sources = list()
			endurance_sources = list()
			resistance_sources = list()
			agility_sources = list()
			force_sources = list()
			offence_sources = list()
			defence_sources = list()
			regen_sources = list()
			recov_sources = list()
		set_lists()
			learnable_origins = list()
			options = list()
			habitats = list()
			debuffs = list()
			tech_lvls = list()
			tech_xp = list()
			tech_unlocked = list()
			bodyparts = list()
			RP_last = list()
			RP_last_100 = list()
			hurt_limbs = list()
			hud_map = list(new /:map_loc,new /:map_cords)
			RP_word_count = list()

			clones = list()

			sense_boxes = list()
			hud_skillbar = list(new /:skillbar_one,new /:skillbar_two,new /:skillbar_three,new /:skillbar_four,new /:skillbar_five,new /:skillbar_six,new /:skillbar_seven,new /:skillbar_eight,new /:skillbar_nine,new /:skillbar_zero)
			hud_main = list(new /:button_body,new /:button_build,new /:button_contacts,new /:button_emote,new /:button_inv,new /:button_options,new /:button_skills,new /:button_stats,new /:button_tech,new /:button_unlocks,new /:button_map)

			remembers_strength = list()
			remembers_endurance = list()
			remembers_agility = list()
			remembers_resistance = list()
			remembers_force = list()
			remembers_offence = list()
			remembers_defence = list()
			remembers_recovery = list()
			remembers_regeneration = list()

			power_sources = list()
			energy_sources = list()
			divine_sources = list()
			dark_matter_sources = list()
			strength_sources = list()
			endurance_sources = list()
			resistance_sources = list()
			agility_sources = list()
			force_sources = list()
			offence_sources = list()
			defence_sources = list()
			regen_sources = list()
			recov_sources = list()

			open_menus = list()
			chat_see = list()
			tk_minigame = list()
			blips = list()
			mobs_map = list()
			blips_map = list()
			mobs_map_mini = list()
			blips_map_mini = list()
			remote_viewer = list()
			player_contacts = list()

			one = list()
			two = list()
			three = list()
			four = list()
			five = list()
			six = list()
			seven = list()
			eight = list()
			nine = list()
			zero = list()
			minus = list()
			equal = list()
			traits = list()
		update_looks(var/t)
			//Find out if we're changing a clones appearance, a players, or the settings of a cloning tank.
			var/mob/target = src
			var/obj/items/tech/Vat/clone_tank = null
			if(target.tech_using)
				if(istype(target.tech_using,/obj/items/tech/Vat))
					clone_tank = target.tech_using
					target = null
					//if(v.in_use) target = v.in_use //Don't want to be able to make changes to a clone thats already grown.

			if(target && target.race == "Cerebroid")
				target.set_icon(target)
				return
			if(target) target.filters = null
			//Select sex
			if(t == "gender")
				if(target && target.race != "Imp")
					if(target.gen == "Male")
						target.gen = "Female"
						target.skin_pos = 1
						target.hair_pos = 1
						target.eye_pos = 1
						target.nose_pos = 1
						target.mouth_pos = 1
					else
						target.gen = "Male"
						target.skin_pos = 1
						target.hair_pos = 11
						target.eye_pos = 1
						target.nose_pos = 1
						target.mouth_pos = 1
			//Portrait nose/eyes/mouth selection
			if(t == "+ mouth")
				if(target)
					target.mouth_pos += 1
					if(target.race == "Yukopian")
						if(target.mouth_pos >= 5) target.mouth_pos = 1
					else if(target.race == "Demon")
						if(target.gen == "Female")
							if(target.mouth_pos >= 6) target.mouth_pos = 1
						if(target.gen == "Male")
							if(target.mouth_pos >= 5) target.mouth_pos = 1
					else
						if(target.gen == "Female")
							if(target.mouth_pos >= 6) target.mouth_pos = 1
						if(target.gen == "Male")
							if(target.mouth_pos >= 5) target.mouth_pos = 1
			if(t == "- mouth")
				if(target)
					target.mouth_pos -= 1
					if(target.race == "Yukopian")
						if(target.mouth_pos <= 0) target.mouth_pos = 4
					else if(target.race == "Demon")
						if(target.gen == "Female")
							if(target.mouth_pos <= 0) target.mouth_pos = 5
						if(target.gen == "Male")
							if(target.mouth_pos <= 0) target.mouth_pos = 4
					else
						if(target.gen == "Female")
							if(target.mouth_pos <= 0) target.mouth_pos = 5
						if(target.gen == "Male")
							if(target.mouth_pos <= 0) target.mouth_pos = 4
			if(t == "+ nose")
				if(target)
					target.nose_pos += 1
					if(target.race == "Yukopian")
						if(target.nose_pos >= 3) target.nose_pos = 1
					else if(target.race == "Demon")
						if(target.gen == "Female")
							if(target.nose_pos >= 3) target.nose_pos = 1
						if(target.gen == "Male")
							if(target.nose_pos >= 3) target.nose_pos = 1
					else
						if(target.gen == "Female")
							if(target.nose_pos >= 3) target.nose_pos = 1
						if(target.gen == "Male")
							if(target.nose_pos >= 3) target.nose_pos = 1
			if(t == "- nose")
				if(target)
					target.nose_pos -= 1
					if(target.race == "Yukopian")
						if(target.nose_pos <= 0) target.nose_pos = 2
					else if(target.race == "Demon")
						if(target.gen == "Female")
							if(target.nose_pos <= 0) target.nose_pos = 2
						if(target.gen == "Male")
							if(target.nose_pos <= 0) target.nose_pos = 2
					else
						if(target.gen == "Female")
							if(target.nose_pos <= 0) target.nose_pos = 2
						if(target.gen == "Male")
							if(target.nose_pos <= 0) target.nose_pos = 2
			if(t == "+ eyes")
				if(target)
					if(target.race == "Yukopian") target.eye_pos = 1
					else if(target.race == "Demon")
						target.eye_pos += 1
						if(target.gen == "Female")
							if(target.skin_pos == 1 || target.skin_pos == 2) target.eye_pos = 1
							else if(target.eye_pos >= 4) target.eye_pos = 1
						if(target.gen == "Male")
							if(target.skin_pos == 1 || target.skin_pos == 2) target.eye_pos = 1
							else if(target.eye_pos >= 3) target.eye_pos = 1
					else
						target.eye_pos += 1
						if(target.gen == "Female")
							if(target.eye_pos >= 4) target.eye_pos = 1
						if(target.gen == "Male")
							if(target.eye_pos >= 3) target.eye_pos = 1
			if(t == "- eyes")
				if(target)
					if(target.race == "Yukopian") target.eye_pos = 1
					else if(target.race == "Demon")
						target.eye_pos -= 1
						if(target.gen == "Female")
							if(target.skin_pos == 1 || target.skin_pos == 2) target.eye_pos = 1
							else if(target.eye_pos <= 0) target.eye_pos = 3
						if(target.gen == "Male")
							if(target.skin_pos == 1 || target.skin_pos == 2) target.eye_pos = 1
							else if(target.eye_pos <= 0) target.eye_pos = 2
					else
						target.eye_pos -= 1
						if(target.gen == "Female")
							if(target.eye_pos <= 0) target.eye_pos = 3
						if(target.gen == "Male")
							if(target.eye_pos <= 0) target.eye_pos = 2
			//Body type selection
			var/max_body = 3
			if(target.race == "Demon") max_body = 4
			if(t == "+ body")
				target.body_pos += 1
				if(target.body_pos == max_body) target.body_pos = 1
			if(t == "- body")
				target.body_pos -= 1
				if(target.body_pos == 0) target.body_pos = max_body-1
			//Skin colour selection
			var/max_skin = 4
			if(target)
				if(target.race == "Demon") max_skin = 6
				else if(target.race == "Android") max_skin = 6
				else if(target.race == "Yukopian") max_skin = 4
			if(t == "+ skin")
				if(clone_tank)
					clone_tank.vat_skin += 1
					if(clone_tank.vat_skin == max_skin) clone_tank.vat_skin = 1

				if(target)
					target.skin_pos += 1
					if(target.skin_pos == max_skin) target.skin_pos = 1
			if(t == "- skin")
				if(clone_tank)
					clone_tank.vat_skin -= 1
					if(clone_tank.vat_skin == 0) clone_tank.vat_skin = max_skin-1

				if(target)
					target.skin_pos -= 1
					if(target.skin_pos == 0) target.skin_pos = max_skin-1
			//Hair and Imp ear selection
			if(t == "+")
				//Handle normal hair/ear selection
				if(target)
					if(target.race == "Imp")
						target.ear_pos += 1
						if(target.ear_pos >= 4) target.ear_pos = 1;
					else if(target.race == "Yukopian")
						target.horn_pos += 1
						if(target.horn_pos >= 5) target.horn_pos = 1;
					else if(target.has_hair >= 1)
						target.hair_pos += 1
						if(target.hair_pos == 12 && target.gen == "Male") target.hair_pos = 1
						if(target.hair_pos == 10 && target.gen == "Female") target.hair_pos = 1
			if(t == "-")
				//Handle normal hair/ear selection
				if(target)
					if(target.race == "Imp")
						target.ear_pos -= 1
						if(target.ear_pos <= 0) target.ear_pos = 3;
					else if(target.race == "Yukopian")
						target.horn_pos -= 1
						if(target.horn_pos <= 0) target.horn_pos = 4;
					else if(target.has_hair >= 1)
						target.hair_pos -= 1
						if(target.hair_pos == 0)
							if(target.gen == "Male") target.hair_pos = 11
							if(target.gen == "Female") target.hair_pos = 9

			//Reset hair for some races, since they don't have any.
			var/obj/h = null
			if(target)
				if(target.race == "Android" && target.skin_pos == 2)
					h = null
					if(target.hair)
						target.overlays -= target.hair
						target.hair = null
						target.hair_icon = null
				else if(target.race == "Imp") h = hairs_male[11]
				else if(target.race == "Yukopian") h = hairs_male[11]
				else if(target.gen == "Male") h = hairs_male[target.hair_pos]
				else if(target.gen == "Female") h = hairs_female[target.hair_pos]

			var/icon/i_race
			var/icon/i_horn
			var/obj/horn = new
			if(target)
				//Celestial icon creation
				if(target.race == "Celestial")
					if(target.gen == "Male") i_race = 'Celestial_Base_Male2.dmi'
					if(target.gen == "Female") i_race = 'Celestial_Base_Female2.dmi'
				//Demon icon creation
				if(target.race == "Demon")
					if(target.gen == "Male")
						if(target.skin_pos == 1)
							i_race = 'Demon_Red_Male.dmi'
							target.has_hair = 1
						if(target.skin_pos == 2)
							i_race = 'Demon_Black_Male.dmi'
							target.has_hair = 1
						if(target.skin_pos == 3)
							i_race = 'Human_Base_Male.dmi'
							target.has_hair = 1
						if(target.skin_pos == 4)
							i_race = 'Human_Base_Male_Tan.dmi'
							target.has_hair = 1
						if(target.skin_pos == 5)
							i_race = 'Human_Base_Male_Black.dmi'
							target.has_hair = 1
					if(target.gen == "Female")
						if(target.skin_pos == 1)
							i_race = 'Demon_Red_Female.dmi'
							target.has_hair = 1
						if(target.skin_pos == 2)
							i_race = 'Demon_Black_Female.dmi'
							target.has_hair = 1
						if(target.skin_pos == 3)
							i_race = 'Human_Base_Female.dmi'
							target.has_hair = 1
						if(target.skin_pos == 4)
							i_race = 'Human_Base_Female_Tan.dmi'
							target.has_hair = 1
						if(target.skin_pos == 5)
							i_race = 'Human_Base_Female_Black.dmi'
							target.has_hair = 1
				//Yukopian horns
				if(target.race == "Yukopian")
					if(target.horn_pos == 1) i_horn = 'horns_yukopian_01.dmi'
					if(target.horn_pos == 2) i_horn = 'horns_yukopian_02.dmi'
					if(target.horn_pos == 3) i_horn = 'horns_yukopian_03.dmi'
					if(target.horn_pos == 4) i_horn = 'horns_yukopian_04.dmi'
					if(target.skin_pos == 1) i_race = 'Yukopian_male_green.dmi'
					if(target.skin_pos == 2) i_race = 'Yukopian_male_yellow.dmi'
					if(target.skin_pos == 3) i_race = 'Yukopian_male_red.dmi'
				//Android icon creation
				if(target.race == "Android")
					if(target.gen == "Male")
						if(target.skin_pos == 1)
							i_race = 'android_liquid_male.dmi'
							target.has_hair = 1
						if(target.skin_pos == 2)
							i_race = 'android_endoskeleton_lighter.dmi'
							target.has_hair = 0
						if(target.skin_pos == 3)
							i_race = 'Human_Base_Male.dmi'
							target.has_hair = 1
						if(target.skin_pos == 4)
							i_race = 'Human_Base_Male_Tan.dmi'
							target.has_hair = 1
						if(target.skin_pos == 5)
							i_race = 'Human_Base_Male_Black.dmi'
							target.has_hair = 1
					if(target.gen == "Female")
						if(target.skin_pos == 1)
							i_race = 'android_liquid_female.dmi'
							target.has_hair = 1
						if(target.skin_pos == 2)
							i_race = 'android_endoskeleton_lighter.dmi'
							target.has_hair = 0
						if(target.skin_pos == 3)
							i_race = 'Human_Base_Female.dmi'
							target.has_hair = 1
						if(target.skin_pos == 4)
							i_race = 'Human_Base_Female_Tan.dmi'
							target.has_hair = 1
						if(target.skin_pos == 5)
							i_race = 'Human_Base_Female_Black.dmi'
							target.has_hair = 1
				//Human icon creation
				if(target.race == "Human")
					if(target.gen == "Male")
						if(target.skin_pos == 1) i_race = 'Human_Base_Male.dmi'
						if(target.skin_pos == 2) i_race = 'Human_Base_Male_Tan.dmi'
						if(target.skin_pos == 3) i_race = 'Human_Base_Male_Black.dmi'
					if(target.gen == "Female")
						if(target.skin_pos == 1) i_race = 'Human_Base_Female.dmi'
						if(target.skin_pos == 2) i_race = 'Human_Base_Female_Tan.dmi'
						if(target.skin_pos == 3) i_race = 'Human_Base_Female_Black.dmi'
				//Imp icon creation
				if(target.race == "Imp")
					if(target.skin_pos == 1)
						if(target.ear_pos == 1) i_race = 'imp_brown_ears_down.dmi'
						if(target.ear_pos == 2) i_race = 'imp_brown_ears_curled.dmi'
						if(target.ear_pos == 3) i_race = 'imp_brown_ears_pointed.dmi'
					if(target.skin_pos == 2)
						if(target.ear_pos == 1) i_race = 'imp_blue_ears_down.dmi'
						if(target.ear_pos == 2) i_race = 'imp_blue_ears_curled.dmi'
						if(target.ear_pos == 3) i_race = 'imp_blue_ears_pointed.dmi'
					if(target.skin_pos == 3)
						if(target.ear_pos == 1) i_race = 'imp_grey_ears_down.dmi'
						if(target.ear_pos == 2) i_race = 'imp_grey_ears_curled.dmi'
						if(target.ear_pos == 3) i_race = 'imp_grey_ears_pointed.dmi'

			if(target) target.icon = i_race

			//world << "Debug - i_race = [i_race]"
			var/icon/I = icon(i_race,"",SOUTH,1,0)
			I.Scale(128,128)

			//Do hair and hair color
			if(h)
				var/icon/E = icon(h.icon,"",SOUTH,1,0)
				var/icon/E_hair = icon(h.icon)
				E.Scale(128,128)

				if(target && target.hair_c)
					E.Blend(target.hair_c)
					E_hair.Blend(target.hair_c)
				if(clone_tank && clone_tank.vat_hair_c)
					E.Blend(clone_tank.vat_hair_c)
					E_hair.Blend(clone_tank.vat_hair_c)
				I.Blend(E,ICON_OVERLAY,1,13)

				if(target && target.has_hair >= 1)
					var/obj/new_hair = new h.type
					//new_hair.icon = E_hair
					target.hair = new_hair
					target.hair_icon = new_hair.icon
					target.overlays = null
					target.overlays += target.hair

			target.set_icon(target)

			//Do eye color next
			if(target.eyes)
				target.vis_contents -= target.eyes
				target.eyes = null
			if(target.eyes_white)
				target.vis_contents -= target.eyes_white
				target.eyes_white = null
			var/i_white = 'humanoid_eyes_white.dmi'
			var/i_iris = 'humanoid_eyes_iris.dmi'
			if(target.race == "Android" && target.skin_pos == 1)
				i_white = 'humanoid_eyes_iris_android.dmi'
				i_iris = 'humanoid_eyes_iris_android.dmi'
			if(target.race == "Imp")
				i_white = 'imp_eyes_eyebrow.dmi'
				i_iris = 'imp_eyes_iris.dmi'
			var/icon/P_white = icon(i_white,"",SOUTH,1,0)
			var/icon/P_eyecolor = icon(i_iris,"",SOUTH,1,0)
			if(target.has_eyes)
				var/proceed_eyes = 1
				if(target.race == "Android")
					if(target.skin_pos == 2)
						proceed_eyes = 0

				if(proceed_eyes)
					var/has_white = 1
					//if(target.race == "Android" && target.skin_pos == 1) has_white = 0
					if(has_white)
						P_white.Scale(128,128)
						I.Blend(P_white,ICON_OVERLAY)

					P_eyecolor.Scale(128,128)
					if(target.eye_c) P_eyecolor.Blend(target.eye_c)
					else P_eyecolor.Blend(rgb(0,0,155))
					I.Blend(P_eyecolor,ICON_OVERLAY)

					if(has_white)
						var/obj/eye_white = new
						eye_white.icon = i_white
						eye_white.layer = 10
						eye_white.vis_flags = VIS_INHERIT_DIR | VIS_INHERIT_ICON_STATE// | VIS_INHERIT_ID
						target.eyes_white = eye_white
						target.vis_contents += target.eyes_white

					var/obj/eye_iris = new
					eye_iris.icon = i_iris
					var/icon/eye = new(eye_iris.icon)
					if(target.eye_c) eye.Blend(target.eye_c)
					eye_iris.icon = eye
					eye_iris.layer = 11
					eye_iris.vis_flags = VIS_INHERIT_DIR | VIS_INHERIT_ICON_STATE// | VIS_INHERIT_ID // | VIS_INHERIT_DIR// | VIS_INHERIT_LAYER
					target.eyes = eye_iris
					target.vis_contents += target.eyes

				/*
				if(target.race == "Android")
					if(target.skin_pos == 1 || target.skin_pos == 2)
						target.vis_contents -= target.eyes
						target.eyes = null
						target.vis_contents -= target.eyes_white
						target.eyes_white = null
				*/


			//Now set the actual in game portrait
			if(i_horn)
				var/icon/race = icon(i_race,"",SOUTH,1,0)
				var/icon/horns = icon(i_horn,"meditate",SOUTH,1,0)
				var/obj/hrn_chosen = horns_yuk[target.horn_pos]
				var/icon/hrn = icon(hrn_chosen.icon)
				horn.icon = hrn
				horn.pixel_x = -8
				horn.layer = 5
				race.Shift(EAST,8)
				horns.Blend(race,ICON_UNDERLAY)
				P_white.Scale(88,88)
				P_eyecolor.Scale(88,88)
				P_white.Shift(EAST,20)
				P_eyecolor.Shift(EAST,20)
				P_white.Shift(SOUTH,2)
				P_eyecolor.Shift(SOUTH,2)
				horns.Scale(128,128)
				horns.Blend(P_white,ICON_OVERLAY)
				horns.Blend(P_eyecolor,ICON_OVERLAY)
				target.save_icon = horns

				target.horns = horn
				target.overlays = null
				target.overlays += target.horns
	proc
		ages(var/adjust as text)
			set name = ".ages"
			set hidden = 1
			if(src.started) return
			if(adjust == "+")
				if(src.age_text == "Adult")
					src.age_text = "Senior"
					src.age = 50
					src.age_soul = 50
					src.birth_year = year-50
				else if(src.age_text == "Senior")
					src.age_text = "Child"
					src.age = 10
					src.age_soul = 10
					src.birth_year = year-10
				else if(src.age_text == "Child")
					src.age_text = "Adult"
					src.age = 20
					src.age_soul = 20
					src.birth_year = year-20
			if(adjust == "-")
				if(src.age_text == "Adult")
					src.age_text = "Child"
					src.age = 10
					src.age_soul = 10
					src.birth_year = year-10
				else if(src.age_text == "Senior")
					src.age_text = "Adult"
					src.age = 20
					src.birth_year = year-20
					src.age_soul = 20
				else if(src.age_text == "Child")
					src.age_text = "Senior"
					src.age = 50
					src.age_soul = 50
					src.birth_year = year-50
			winset(src,"char_creation.label_age","text=\"[src.age_text]\"")
		bodysize(var/adjust as text)
			set name = ".bodysize"
			set hidden = 1
			if(src.started) return
			if(adjust == "+")
				if(src.bodysize == "Medium")
					src.bodysize = "Large"
					winset(src,"char_creation.stat_info","text=\"[text_bodysize_large]\"")
				else if(src.bodysize == "Large")
					src.bodysize = "Small"
					winset(src,"char_creation.stat_info","text=\"[text_bodysize_small]\"")
				else if(src.bodysize == "Small")
					src.bodysize = "Medium"
					winset(src,"char_creation.stat_info","text=\"[text_bodysize_medium]\"")
			if(adjust == "-")
				if(src.bodysize == "Medium")
					src.bodysize = "Small"
					winset(src,"char_creation.stat_info","text=\"[text_bodysize_small]\"")
				else if(src.bodysize == "Small")
					src.bodysize = "Large"
					winset(src,"char_creation.stat_info","text=\"[text_bodysize_large]\"")
				else if(src.bodysize == "Large")
					src.bodysize = "Medium"
					winset(src,"char_creation.stat_info","text=\"[text_bodysize_medium]\"")
			winset(src,"char_creation.label_size","text=\"[src.bodysize]\"")
		//Plus/Minus adjustments
		mod_points(var/type,var/mod)
			if(src.started) return
			var/times = 1
			if(src.client.shift >= 1) times = 10;
			while(times)
				times -= 1
				if(src.mod_points > 0) if(src.mod_points_spent < 10)
					if(type == "+")
						if(mod == "energy")
							if(src.mod_energy_points < 10)
								src.mod_energy += 0.1
								src.mod_energy_points += 1
								src.gains_trained_energy_mod += 0.1
								src.mod_points -= 1
								src.mod_points_spent += 1
								src.stat_desc("Energy")
						if(mod == "strength")
							if(src.mod_strength_points < 10)
								src.mod_strength += 0.1
								src.mod_strength_points += 1
								src.gains_trained_strength_mod += 0.1
								src.mod_points -= 1
								src.mod_points_spent += 1
								src.stat_desc("Strength")
						if(mod == "endurance")
							if(src.mod_endurance_points < 10)
								src.mod_endurance += 0.1
								src.mod_endurance_points += 1
								src.gains_trained_endurance_mod += 0.1
								src.mod_points -= 1
								src.mod_points_spent += 1
								src.stat_desc("Endurance")
						if(mod == "agility")
							if(src.mod_agility_points < 10)
								src.mod_agility += 0.1
								src.mod_agility_points += 1
								src.gains_trained_agility_mod += 0.1
								src.mod_points -= 1
								src.mod_points_spent += 1
								src.stat_desc("Agility")
						if(mod == "resistance")
							if(src.mod_resistance_points < 10)
								src.mod_resistance += 0.1
								src.mod_resistance_points += 1
								src.mod_points -= 1
								src.mod_points_spent += 1
								src.stat_desc("resistance")
						if(mod == "force")
							if(src.mod_force_points < 10)
								src.mod_force += 0.1
								src.mod_force_points += 1
								src.gains_trained_resistance_mod += 0.1
								src.mod_points -= 1
								src.mod_points_spent += 1
								src.stat_desc("Force")
						if(mod == "offence")
							if(src.mod_offence_points < 10)
								src.mod_offence += 0.1
								src.mod_offence_points += 1
								src.gains_trained_off_mod += 0.1
								src.mod_points -= 1
								src.mod_points_spent += 1
								src.stat_desc("Offence")
						if(mod == "defence")
							if(src.mod_defence_points < 10)
								src.mod_defence += 0.1
								src.mod_defence_points += 1
								src.gains_trained_def_mod += 0.1
								src.mod_points -= 1
								src.mod_points_spent += 1
								src.stat_desc("Defence")
						if(mod == "recovery")
							if(src.mod_recovery_points < 10)
								src.mod_recovery += 0.1
								src.mod_recovery_points += 1
								src.gains_trained_recov_mod += 0.1
								src.mod_points -= 1
								src.mod_points_spent += 1
								src.stat_desc("Recovery")
						if(mod == "regen")
							if(src.mod_regeneration_points < 10)
								src.mod_regeneration += 0.1
								src.mod_regeneration_points += 1
								src.gains_trained_regen_mod += 0.1
								src.mod_points -= 1
								src.mod_points_spent += 1
								src.stat_desc("Regeneration")
				if(type == "-")
					if(mod == "energy") if(src.mod_energy_points)
						src.mod_energy -= 0.1
						src.mod_energy_points -= 1
						src.gains_trained_energy_mod -= 0.1
						src.mod_points += 1
						src.mod_points_spent -= 1
						src.stat_desc("Energy")
					if(mod == "strength") if(src.mod_strength_points)
						src.mod_strength -= 0.1
						src.mod_strength_points -= 1
						src.gains_trained_strength_mod -= 0.1
						src.mod_points += 1
						src.mod_points_spent -= 1
						src.stat_desc("Strength")
					if(mod == "endurance") if(src.mod_endurance_points)
						src.mod_endurance -= 0.1
						src.mod_endurance_points -= 1
						src.gains_trained_endurance_mod -= 0.1
						src.mod_points += 1
						src.mod_points_spent -= 1
						src.stat_desc("Endurance")
					if(mod == "agility") if(src.mod_agility_points)
						src.mod_agility -= 0.1
						src.mod_agility_points -= 1
						src.gains_trained_agility_mod -= 0.1
						src.mod_points += 1
						src.mod_points_spent -= 1
						src.stat_desc("Agility")
					if(mod == "resistance") if(src.mod_resistance_points)
						src.mod_resistance -= 0.1
						src.mod_resistance_points -= 1
						src.gains_trained_resistance_mod -= 0.1
						src.mod_points += 1
						src.mod_points_spent -= 1
						src.stat_desc("resistance")
					if(mod == "force") if(src.mod_force_points)
						src.mod_force -= 0.1
						src.mod_force_points -= 1
						src.gains_trained_force_mod -= 0.1
						src.mod_points += 1
						src.mod_points_spent -= 1
						src.stat_desc("Force")
					if(mod == "offence") if(src.mod_offence_points)
						src.mod_offence -= 0.1
						src.mod_offence_points -= 1
						src.gains_trained_off_mod -= 0.1
						src.mod_points += 1
						src.mod_points_spent -= 1
						src.stat_desc("Offence")
					if(mod == "defence") if(src.mod_defence_points)
						src.mod_defence -= 0.1
						src.mod_defence_points -= 1
						src.gains_trained_def_mod -= 0.1
						src.mod_points += 1
						src.mod_points_spent -= 1
						src.stat_desc("Defence")
					if(mod == "recovery") if(src.mod_recovery_points)
						src.mod_recovery -= 0.1
						src.mod_recovery_points -= 1
						src.gains_trained_recov_mod -= 0.1
						src.mod_points += 1
						src.mod_points_spent -= 1
						src.stat_desc("Recovery")
					if(mod == "regen") if(src.mod_regeneration_points)
						src.mod_regeneration -= 0.1
						src.mod_regeneration_points -= 1
						src.gains_trained_regen_mod -= 0.1
						src.mod_points += 1
						src.mod_points_spent -= 1
						src.stat_desc("Regeneration")
			if(src.hud_char)
				var/obj/p = src.hud_char.points
				p.maptext = "[css_outline]<font size = 1><center>[src.mod_points]"
		//This currently changes the players hair/skin when trying to use on a clone inside a tank, plus it needs a clear up anyway probably.
		create_cycle(var/t as text)
			set name = ".create_cycle"
			set hidden = 1
			src.update_looks(t)