mob
	verb
		adjust_strength()
			set hidden = 1
			set name = ".adjust_strength"
			var/v = winget(usr,"stats_other.bar_adjust_strength","value")
			v = round(text2num(v))
			if(v < 0.01) v = 0.01
			usr.mod_str_usage = v / 100
			winset(usr,"stats_other.str_adjust_percent","text=[v]%")
			if(usr.skill_psi_clone)
				for(var/mob/m in usr.skill_psi_clone.active_splits)
					m.mod_str_usage = v / 100
			if(usr.skill_divine_weapon)
				for(var/mob/m in usr.skill_divine_weapon.active_splits)
					m.mod_str_usage = v / 100
		adjust_force()
			set hidden = 1
			set name = ".adjust_force"
			var/v = winget(usr,"stats_other.bar_adjust_force","value")
			v = round(text2num(v))
			if(v < 0.01) v = 0.01
			usr.mod_force_usage = v / 100
			winset(usr,"stats_other.force_adjust_percent","text=[v]%")
			if(usr.skill_psi_clone)
				for(var/mob/m in usr.skill_psi_clone.active_splits)
					m.mod_force_usage = v / 100
			if(usr.skill_divine_weapon)
				for(var/mob/m in usr.skill_divine_weapon.active_splits)
					m.mod_force_usage = v / 100
mob
	proc
		stats_mods()
			/*
			.:So how this work is:.

			mod_base
				- gains_trained + gains_psiforged + gains_items = mod_base

			gains_temp_mod
				- mod_current - mod_base = gains_temp_mod

			stat_base
				- gains_trained + gains_psiforged + gains_items x mod_base = stat_base

			gains_temp_stat
				- stat - stat_base = gains_temp_stat

			gains_temp_stat vars are NOT used to calculate power/energy, and should NOT be used to do so
				- Only for visual representation
				- The actual temp stats are baked into the real stat calculations by default
			*/

			//Mods
			src.mod_psionic_power_base = src.gains_trained_power_mod + src.gains_psiforged_power_mod + src.gains_items_power_mod
			src.gains_temp_power_mod = round(src.mod_psionic_power - src.mod_psionic_power_base,0.01)

			src.mod_energy_base = src.gains_trained_energy_mod + src.gains_psiforged_energy_mod + src.gains_items_energy_mod
			src.gains_temp_energy_mod = round(src.mod_energy - src.mod_energy_base,0.01)

			src.mod_strength_base = src.gains_trained_strength_mod + src.gains_psiforged_strength_mod + src.gains_items_strength_mod
			src.gains_temp_strength_mod = round(src.mod_strength - src.mod_strength_base,0.01)

			src.mod_endurance_base = src.gains_trained_endurance_mod + src.gains_psiforged_endurance_mod + src.gains_items_endurance_mod
			src.gains_temp_endurance_mod = round(src.mod_endurance - src.mod_endurance_base,0.01)

			src.mod_force_base = src.gains_trained_force_mod + src.gains_psiforged_force_mod + src.gains_items_force_mod
			src.gains_temp_force_mod = round(src.mod_force - src.mod_force_base,0.01)

			src.mod_resistance_base = src.gains_trained_resistance_mod + src.gains_psiforged_resistance_mod + src.gains_items_resistance_mod
			src.gains_temp_resistance_mod = round(src.mod_resistance - src.mod_resistance_base,0.01)

			src.mod_agility_base = src.gains_trained_agility_mod + src.gains_psiforged_agility_mod + src.gains_items_agility_mod
			src.gains_temp_agility_mod = round(src.mod_agility - src.mod_agility_base,0.01)

			src.mod_offence_base = src.gains_trained_off_mod + src.gains_psiforged_off_mod + src.gains_items_off_mod
			src.gains_temp_off_mod = round(src.mod_offence - src.mod_offence_base,0.01)

			src.mod_defence_base = src.gains_trained_def_mod + src.gains_psiforged_def_mod + src.gains_items_def_mod
			src.gains_temp_def_mod = round(src.mod_defence - src.mod_defence_base,0.01)

			src.mod_regeneration_base = src.gains_trained_regen_mod + src.gains_psiforged_regen_mod + src.gains_items_regen_mod
			src.gains_temp_regen_mod = round(src.mod_regeneration - src.mod_regeneration_base,0.01)

			src.mod_recovery_base = src.gains_trained_recov_mod + src.gains_psiforged_recov_mod + src.gains_items_recov_mod
			src.gains_temp_recov_mod = round(src.mod_recovery - src.mod_recovery_base,0.01)

			//Tolerances
			src.immune_rads_base = src.immune_rads_trained + src.immune_rads_psiforged + src.immune_rads_items
			src.immune_rads_temp = round(src.mod_immune_rads - src.immune_rads_base,0.01)

			src.immune_cold_base = src.immune_cold_trained + src.immune_cold_psiforged + src.immune_cold_items
			src.immune_cold_temp = round(src.mod_immune_cold - src.immune_cold_base,0.01)

			src.immune_heat_base = src.immune_heat_trained + src.immune_heat_psiforged + src.immune_heat_items
			src.immune_heat_temp = round(src.mod_immune_heat - src.immune_heat_base,0.01)

			src.immune_gravity_base = src.immune_gravity_trained + src.immune_gravity_psiforged + src.immune_gravity_items
			src.immune_gravity_temp = round(src.mod_immune_gravity - src.immune_gravity_base,0.01)

			src.immune_microwaves_base = src.immune_microwaves_trained + src.immune_microwaves_psiforged + src.immune_microwaves_items
			src.immune_microwaves_temp = round(src.mod_immune_microwaves - src.immune_microwaves_base,0.01)

			src.immune_toxins_base = src.immune_toxins_trained + src.immune_toxins_psiforged + src.immune_toxins_items
			src.immune_toxins_temp = round(src.mod_immune_toxins - src.immune_toxins_base,0.01)

			//Stats
			src.psionic_power_base = (src.gains_trained_power + src.gains_psiforged_power + src.gains_items_power - src.injury_power)*src.mod_psionic_power_base
			src.gains_temp_power = round(src.psionic_power - src.psionic_power_base,0.01)

			src.energy_max = (src.gains_trained_energy + src.gains_psiforged_energy + src.gains_items_energy - src.injury_energy)*src.mod_energy

			src.energy_base = (src.gains_trained_energy + src.gains_psiforged_energy + src.gains_items_energy - src.injury_energy)*src.mod_energy_base
			src.gains_temp_energy = round(src.energy_max - src.energy_base,0.01)
			/*
			world << "DEBUG - trained: [src.gains_trained_energy]"
			world << "DEBUG - psiforged: [src.gains_psiforged_energy]"
			world << "DEBUG - items: [src.gains_items_energy]"
			world << "DEBUG - injury: [src.injury_energy]"
			world << "DEBUG - energy_mod_base: [src.mod_energy_base]"
			*/

			src.strength_base = (src.gains_trained_strength + src.gains_psiforged_strength + src.gains_items_strength - src.injury_strength)*src.mod_strength_base
			src.gains_temp_strength = round(src.strength - src.strength_base,0.01)

			src.endurance_base = (src.gains_trained_endurance + src.gains_psiforged_endurance + src.gains_items_endurance - src.injury_endurance)*src.mod_endurance_base
			src.gains_temp_endurance = round(src.endurance - src.endurance_base,0.01)

			src.force_base = (src.gains_trained_force + src.gains_psiforged_force + src.gains_items_force - src.injury_force)*src.mod_force_base
			src.gains_temp_force = round(src.force - src.force_base,0.01)

			src.resistance_base = (src.gains_trained_resistance + src.gains_psiforged_resistance + src.gains_items_resistance - src.injury_resistance)*src.mod_resistance_base
			src.gains_temp_resistance = round(src.resistance - src.resistance_base,0.01)

			src.offence_base = (src.gains_trained_off + src.gains_psiforged_off + src.gains_items_off - src.injury_off)*src.mod_offence_base
			src.gains_temp_off = round(src.offence - src.offence_base,0.01)

			src.defence_base = (src.gains_trained_def + src.gains_psiforged_def + src.gains_items_def - src.injury_def)*src.mod_defence_base
			src.gains_temp_def = round(src.defence - src.defence_base,0.01)
		stats()
			src.energy_max = (src.gains_trained_energy + src.gains_psiforged_energy + src.gains_items_energy - src.injury_energy)*src.mod_energy
			//src.stats_mods()
			//Health recovery & Energy recovery
			if(src.KB <= 0)
				if(src.koed == 0)
					if(src.percent_health < 0)
						src.KO() // Checked V 0.10 for crashes
						src.percent_health = 0
					else
						//Regenerate health
						if(percent_health < 100)
							percent_health += 0.1*mod_regeneration
							if(icon_state == "meditate") percent_health += 0.1*mod_regeneration
						if(percent_health > 100) percent_health = 100
						//Flush toxins slowly
						if(src.toxicity > 0)
							src.toxicity -= (0.01*mod_regeneration)*(1+src.mod_immune_toxins)
							if(src.toxicity <= 0) src.toxicity = 0
							if(src.toxicity >= 200)
								src.KO() // Checked V 0.10 for crashes
								src.percent_health = 0
						//Energy recovery
						if(percent_energy<100)
							var/gain_eng = 0
							if(mortal) gain_eng = 1
							else if(z == 2 || z == 6) gain_eng = 1
							else gain_eng = (src.organ_grow/src.total_organs)+0.1
							energy += (0.01*energy_max*mod_recovery)*gain_eng
						if(energy > energy_max) energy = energy_max
						if(energy < 0) energy = 0
						//Divine energy recovery
						divine_energy += 0.01*divine_energy_mod
						if(src.skill_meditation && src.skill_meditation.active || src.skill_active_meditation && src.skill_active_meditation.active) divine_energy += 0.01*divine_energy_mod
						if(divine_energy < 0) divine_energy = 0
						//Heal limbs over time
						for(var/obj/body_related/p in src.hurt_limbs)
							if(p.disabled_perma == 0)
								p.hp += (0.1*mod_regeneration)*rand(1,2)
								if(icon_state == "meditate") p.hp += (0.1*mod_regeneration)*rand(1,2)
								p.set_part_color()
								if(src.hud_body) src.hud_body.color_paperdoll(src)
								if(p.hp >= 100)
									p.hp = 100
									if(p.damaged)
										src.damage_part(p, 0)
										//If its a bone, find all the parts connected to it and enable them also.
										if(p.bodypart_type == "Bone" && src.has_body)
											var/list/extensions = list()
											for(var/obj/body_related/x in p.loc)
												if(x.part_hierarchy < p.part_hierarchy)
													extensions += x
											src.disable_parts(extensions,0,0)
									src.hurt_limbs -= p
				else if(src.toxicity >= 200)
					src.Death("Toxicity buildup",1)
			//Dynamically adjust hp bars
			if(src.change_hp != src.percent_health && src.hud_hp_bar_inner)
				var/obj/bar_hp = src.hud_hp_bar_inner
				var/matrix/m = matrix()
				m.Scale(src.percent_health*2,1)
				m.Translate(src.percent_health,0)
				bar_hp.transform = m
				var/obj/hud/bars/player_hp/hp = bar_hp.loc
				if(hp && hp.txt_percent) hp.txt_percent.maptext = "<font size = 1> <text align=center valign=top>[css_outline][round(src.percent_health)]%"
			//Power Calculations
			var/Health_Multiplier=percent_health/100
			var/chosen_pp = 1
			if(icon_state == "ko") Health_Multiplier=1
			if(origin && istype(origin,/obj/origins/chosen_one))
				if(chosen_ones <= 0) chosen_ones = 1
				chosen_pp = 1+(1/chosen_ones)
			src.psionic_power = ((src.gains_trained_power + src.gains_psiforged_power + src.gains_items_power - src.injury_power)*src.mod_psionic_power*chosen_pp*Health_Multiplier*(vigour*0.01)*(power_percent/100))/weight
			if(psionic_power <= 0) psionic_power = 1;
			//if(dead) psionic_power /= 2
			if(src.hud_pp) src.hud_pp.maptext = "<font size = 1> <text align=left>[css_outline]Psionic Power: [Commas(src.psionic_power)]"
			if(percent_power<0.01) percent_power=0.01
			//KO Recovery
			if(ko_time_max && ko_time)
				ko_time -= 10
				if(ko_time < 0) ko_time = 0
				if(ko_time > 0) percent_ko = (ko_time/ko_time_max)*100
			//Dynamically adjust eng bars
			percent_power = (percent_health*0.01)*100
			percent_energy = (energy/energy_max)*100
			if(percent_energy > 100) percent_energy = 100
			if(src.change_eng != src.percent_energy && src.hud_eng_bar_inner)
				var/obj/bar_eng = src.hud_eng_bar_inner
				var/matrix/m = matrix()
				m.Scale(src.percent_energy*2,1)
				m.Translate(src.percent_energy,0)
				bar_eng.transform = m
				var/obj/hud/bars/player_eng/eng = bar_eng.loc
				if(eng && eng.txt_percent) eng.txt_percent.maptext = "<font size = 1> <text align=center valign=top>[css_outline][round(src.percent_energy)]% ([round(src.energy)]/[round(src.energy_max)])"
			src.change_eng = src.percent_energy
			src.change_hp = src.percent_health

		gain_stat(var/stat,var/multi=1,var/exp = 100,var/source,var/remove_source = 0,var/divider = 1)
			if(src.part_focus) //Finish training limb part and adjust stats as reward.
				var/obj/body_related/bodyparts/part = src.part_focus
				//Can train a Dantian without a body, but only if meditating.
				if(part.type == /obj/body_related/bodyparts/meridians/dantian)
					if(src.skill_meditation && src.skill_meditation.active)
						part.part_reward(src,exp)
					else if(src.skill_active_meditation && src.skill_active_meditation.active)
						part.part_reward(src,exp)
				//Otherwise, probably training a bodypart instead.
				else part.part_reward(src,exp)

			if(src.trait_prodigy) exp *=1.25 //Put this here, because we want this trait to increase combat stat gains, and not both psiforging exp AND combat stat gains

			//200% gains for Celestial, but only if they're meditating.
			if(src.race == "Celestial")
				if(src.skill_meditation && src.skill_meditation.active) exp *= 2
				else if(src.skill_active_meditation && src.skill_active_meditation.active) exp *= 2

			if(stat == "power")
				src.gaining_power = 1;
				//Update buff obj to display correct info and sources
				if(src.buff_power)
					var/obj/buffs_and_debuffs/b = src.buff_power
					b.active = 1;
					if(source)
						if(src.power_sources && islist(src.power_sources) && src.power_sources.Find(source) == 0) src.power_sources += source
					var/txt = "<br><u>Sources</u>"
					for(var/t in src.power_sources)
						txt = "[txt]<br>[t]."
					b.info_txt.maptext = "<font size = 1><text align=center valign=top>[b.desc][txt]"
					if(remove_source == 1)
						spawn(10)
							if(src && b)
								src.power_sources -= source
				//Proceed with gaining the stat
				src.power_exp += (exp/4)+(src.gravity_mastered/100)
				if(src.power_exp >= 10000) src.power_exp = 10000 //Makes sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.xp_power >= 10000) src.xp_power = 10000 //Makes sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.power_exp >= 100)
					while(src.power_exp >= 100)
						src.power_exp = src.power_exp-100
						src.gains_trained_power += multi
						src.xp_power += 10;
				if(src.xp_power >= 100)
					while(src.xp_power >= 100)
						src.xp_power = src.xp_power-100
						src.skill_points_power += 1;
						if(src.client) winset(src,"skill_pane_power.label_points","text=\"Power Points: [src.skill_points_power]\"")
						src.set_alert("+1 Psi Power Skill Points",'stat_power.dmi',null)
						src.create_chat_entry("alerts","+1 Psi Power Skill Points")

			if(stat == "energy")
				src.gaining_energy = 1;
				//Update buff obj to display correct info and sources
				if(src.buff_energy)
					var/obj/buffs_and_debuffs/b = src.buff_energy
					b.active = 1;
					if(source)
						if(src.energy_sources && islist(src.energy_sources) && src.energy_sources.Find(source) == 0) src.energy_sources += source
					var/txt = "<br><u>Sources</u>"
					for(var/t in src.energy_sources)
						txt = "[txt]<br>[t]."
					b.info_txt.maptext = "<font size = 1><text align=center valign=top>[b.desc][txt]"
					if(remove_source == 1)
						spawn(10)
							if(src && b)
								src.energy_sources -= source
				//Proceed with gaining the stat
				src.energy_exp += exp/4
				if(src.energy_exp >= 10000) src.energy_exp = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.xp_energy >= 10000) src.xp_energy = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.energy_exp >= 100)
					while(src.energy_exp >= 100)
						src.energy_exp = src.energy_exp-100
						src.gains_trained_energy += 1
						src.xp_energy += 10;
				if(src.energy_exp < 0) src.energy_exp = 0
				if(src.xp_energy >= 100)
					if(islist(src.tutorials))
						var/obj/help_topics/H = src.tutorials[8]
						if(H.seen == 0)
							H.seen = 1
							H.skill_up(src)
					while(src.xp_energy >= 100)
						src.xp_energy = src.xp_energy-100
						src.skill_points_energy += 1;
						if(src.client) winset(src,"skill_pane_engery.label_points","text=\"Energy Points: [src.skill_points_energy]\"")
						src.set_alert("+1 Energy Skill Points",'stat_energy.dmi',"energy")
						src.create_chat_entry("alerts","+1 Energy Skill Points")

			if(stat == "divine")
				src.gaining_divine = 1;
				//Update buff obj to display correct info and sources
				if(src.buff_divine)
					var/obj/buffs_and_debuffs/b = src.buff_divine
					b.active = 1;
					if(source)
						if(src.divine_sources && islist(src.divine_sources) && src.divine_sources.Find(source) == 0) src.divine_sources += source
					var/txt = "<br><u>Sources</u>"
					for(var/t in src.divine_sources)
						txt = "[txt]<br>[t]."
					b.info_txt.maptext = "<font size = 1><text align=center valign=top>[b.desc][txt]"
					if(remove_source == 1)
						spawn(10)
							if(src && b)
								src.divine_sources -= source
			if(stat == "dark matter")
				src.gaining_dark_matter = 1;
				//Update buff obj to display correct info and sources
				if(src.buff_dark_matter)
					var/obj/buffs_and_debuffs/b = src.buff_dark_matter
					b.active = 1;
					if(source)
						if(src.dark_matter_sources && islist(src.dark_matter_sources) && src.dark_matter_sources.Find(source) == 0) src.dark_matter_sources += source
					var/txt = "<br><u>Sources</u>"
					for(var/t in src.dark_matter_sources)
						txt = "[txt]<br>[t]."
					b.info_txt.maptext = "<font size = 1><text align=center valign=top>[b.desc][txt]"
					if(remove_source == 1)
						spawn(10)
							if(src && b)
								src.dark_matter_sources -= source

			if(stat == "strength")
				src.gaining_strength = 1;
				//Update buff obj to display correct info and sources
				if(src.buff_strength)
					var/obj/buffs_and_debuffs/b = src.buff_strength
					b.active = 1;
					if(source)
						if(src.strength_sources && islist(src.strength_sources) && src.strength_sources.Find(source) == 0) src.strength_sources += source
					var/txt = "<br><u>Sources</u>"
					for(var/t in src.strength_sources)
						txt = "[txt]<br>[t]."
					b.info_txt.maptext = "<font size = 1><text align=center valign=top>[b.desc][txt]"
					if(remove_source == 1)
						spawn(10)
							if(src && b)
								src.strength_sources -= source
				//Proceed with gaining the stat
				src.strength_exp += exp/(src.strength/src.mod_strength)
				if(src.strength_exp >= 10000) src.strength_exp = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.xp_strength >= 10000) src.xp_strength = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.strength_exp >= 100)
					while(src.strength_exp >= 100)
						src.strength_exp = src.strength_exp-100
						src.strength_base += multi*src.mod_strength
						src.strength += multi*src.mod_strength
						src.gains_trained_strength += multi
						src.combat_exp += 10
						src.xp_strength += 10;
						src.display_gain(stat)
					src.update_weight()
				if(src.xp_strength >= 100)
					if(islist(src.tutorials))
						var/obj/help_topics/H = src.tutorials[8]
						if(H.seen == 0)
							H.seen = 1
							H.skill_up(src)
					while(src.xp_strength >= 100)
						src.xp_strength = src.xp_strength-100
						src.skill_points_strength += 1;
						if(src.client) winset(src,"skill_pane_strength.label_points","text=\"Strength Points: [src.skill_points_strength]\"")
						src.set_alert("+1 Strength Skill Points",'stat_strength.dmi',"strength")
						src.create_chat_entry("alerts","+1 Strength Skill Points")

			if(stat == "endurance")
				src.gaining_endurance = 1;
				//Update buff obj to display correct info and sources
				if(src.buff_endurance)
					var/obj/buffs_and_debuffs/b = src.buff_endurance
					b.active = 1;
					if(source)
						if(src.endurance_sources && islist(src.endurance_sources) && src.endurance_sources.Find(source) == 0) src.endurance_sources += source
					var/txt = "<br><u>Sources</u>"
					for(var/t in src.endurance_sources)
						txt = "[txt]<br>[t]."
					b.info_txt.maptext = "<font size = 1><text align=center valign=top>[b.desc][txt]"
					if(remove_source == 1)
						spawn(10)
							if(src && b)
								src.endurance_sources -= source
				//Proceed with gaining the stat
				src.endurance_exp += exp/(src.endurance/src.mod_endurance)
				if(src.endurance_exp >= 10000) src.endurance_exp = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.xp_endurance >= 10000) src.xp_endurance = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.endurance_exp >= 100)
					while(src.endurance_exp >= 100)
						src.endurance_exp = src.endurance_exp-100
						src.endurance_base += multi*src.mod_endurance
						src.endurance += multi*src.mod_endurance
						src.gains_trained_endurance += multi
						src.combat_exp += 10
						src.xp_endurance += 10;
						src.display_gain(stat)
					src.update_weight()
				if(src.xp_endurance >= 100)
					if(islist(src.tutorials))
						var/obj/help_topics/H = src.tutorials[8]
						if(H.seen == 0)
							H.seen = 1
							H.skill_up(src)
					while(src.xp_endurance >= 100)
						src.xp_endurance = src.xp_endurance-100
						src.skill_points_endurance += 1;
						if(src.client) winset(src,"skill_pane_endurance.label_points","text=\"Endurance Points: [src.skill_points_endurance]\"")
						src.set_alert("+1 Endurance Skill Points",'stat_endurance.dmi',"endurance")
						src.create_chat_entry("alerts","+1 Endurance Skill Points")

			if(stat == "force")
				src.gaining_force = 1;
				//Update buff obj to display correct info and sources
				if(src.buff_force)
					var/obj/buffs_and_debuffs/b = src.buff_force
					b.active = 1;
					if(source)
						if(src.force_sources && islist(src.force_sources) && src.force_sources.Find(source) == 0) src.force_sources += source
					var/txt = "<br><u>Sources</u>"
					for(var/t in src.force_sources)
						txt = "[txt]<br>[t]."
					b.info_txt.maptext = "<font size = 1><text align=center valign=top>[b.desc][txt]"
					if(remove_source == 1)
						spawn(10)
							if(src && b)
								src.force_sources -= source
				//Proceed with gaining the stat
				src.force_exp += exp/(src.force/src.mod_force)
				if(src.force_exp >= 10000) src.force_exp = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.xp_force >= 10000) src.xp_force = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.force_exp >= 100)
					while(src.force_exp >= 100)
						src.force_exp = src.force_exp-100
						src.force_base += multi*src.mod_force
						src.force += multi*src.mod_force
						src.gains_trained_force += multi
						src.combat_exp += 10
						src.xp_force += 10;
						src.display_gain(stat)
				if(src.xp_force >= 100)
					if(islist(src.tutorials))
						var/obj/help_topics/H = src.tutorials[8]
						if(H.seen == 0)
							H.seen = 1
							H.skill_up(src)
					while(src.xp_force >= 100)
						src.xp_force = src.xp_force-100
						src.skill_points_force += 1;
						if(src.client) winset(src,"skill_pane_force.label_points","text=\"Force Points: [src.skill_points_force]\"")
						src.set_alert("+1 Force Skill Points",'stat_potency.dmi',"potency")
						src.create_chat_entry("alerts","+1 Force Skill Points")

			if(stat == "resistance")
				src.gaining_resistance = 1;
				//Update buff obj to display correct info and sources
				if(src.buff_resistance)
					var/obj/buffs_and_debuffs/b = src.buff_resistance
					b.active = 1;
					if(source)
						if(src.resistance_sources && islist(src.resistance_sources) && src.resistance_sources.Find(source) == 0) src.resistance_sources += source
					var/txt = "<br><u>Sources</u>"
					for(var/t in src.resistance_sources)
						txt = "[txt]<br>[t]."
					b.info_txt.maptext = "<font size = 1><text align=center valign=top>[b.desc][txt]"
					if(remove_source == 1)
						spawn(10)
							if(src && b)
								src.resistance_sources -= source
				//Proceed with gaining the stat
				src.resistance_exp += exp/(src.resistance/src.mod_resistance)
				if(src.resistance_exp >= 10000) src.resistance_exp = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.xp_resistance >= 10000) src.xp_resistance = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.resistance_exp > 100)
					while(src.resistance_exp >= 100)
						src.resistance_exp = src.resistance_exp-100
						src.resistance_base += multi*src.mod_resistance
						src.resistance += multi*src.mod_resistance
						src.gains_trained_resistance += multi
						src.combat_exp += 10
						src.xp_resistance += 10;
						src.display_gain(stat)
				if(src.xp_resistance >= 100)
					if(islist(src.tutorials))
						var/obj/help_topics/H = src.tutorials[8]
						if(H.seen == 0)
							H.seen = 1
							H.skill_up(src)
					while(src.xp_resistance >= 100)
						src.xp_resistance = src.xp_resistance-100
						src.skill_points_resistance += 1;
						if(src.client) winset(src,"skill_pane_resistance.label_points","text=\"resistance Points: [src.skill_points_resistance]\"")
						src.set_alert("+1 Resistance Skill Points",'stat_resistence.dmi',"resistance")
						src.create_chat_entry("alerts","+1 Resistance Skill Points")

			if(stat == "offence")
				src.gaining_offence = 1;
				//Update buff obj to display correct info and sources
				if(src.buff_offence)
					var/obj/buffs_and_debuffs/b = src.buff_offence
					b.active = 1;
					if(source)
						if(src.offence_sources && islist(src.offence_sources) && src.offence_sources.Find(source) == 0) src.offence_sources += source
					var/txt = "<br><u>Sources</u>"
					for(var/t in src.offence_sources)
						txt = "[txt]<br>[t]."
					b.info_txt.maptext = "<font size = 1><text align=center valign=top>[b.desc][txt]"
					if(remove_source == 1)
						spawn(10)
							if(src && b)
								src.offence_sources -= source
				//Proceed with gaining the stat
				src.offence_exp += exp/(src.offence/src.mod_offence)
				if(src.offence_exp >= 10000) src.offence_exp = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.xp_offence >= 10000) src.xp_offence = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.offence_exp >= 100)
					while(src.offence_exp >= 100)
						src.offence_exp = src.offence_exp-100
						src.offence_base += multi*src.mod_offence
						src.offence += multi*src.mod_offence
						src.gains_trained_off += multi
						src.combat_exp += 10
						src.xp_offence += 10;
						src.display_gain(stat)
				if(src.xp_offence >= 100)
					if(islist(src.tutorials))
						var/obj/help_topics/H = src.tutorials[8]
						if(H.seen == 0)
							H.seen = 1
							H.skill_up(src)
					while(src.xp_offence >= 100)
						src.xp_offence = src.xp_offence-100
						src.skill_points_offence += 1;
						if(src.client) winset(src,"skill_pane_offence.label_points","text=\"Offence Points: [src.skill_points_offence]\"")
						src.set_alert("+1 Offence Skill Points",'stat_accuracy.dmi',"accuracy")
						src.create_chat_entry("alerts","+1 Offence Skill Points")

			if(stat == "defence")
				src.gaining_defence = 1;
				//Update buff obj to display correct info and sources
				if(src.buff_defence)
					var/obj/buffs_and_debuffs/b = src.buff_defence
					b.active = 1;
					if(source)
						if(src.defence_sources && islist(src.defence_sources) && src.defence_sources.Find(source) == 0) src.defence_sources += source
					var/txt = "<br><u>Sources</u>"
					for(var/t in src.defence_sources)
						txt = "[txt]<br>[t]."
					b.info_txt.maptext = "<font size = 1><text align=center valign=top>[b.desc][txt]"
					if(remove_source == 1)
						spawn(10)
							if(src && b)
								src.defence_sources -= source
				//Proceed with gaining the stat
				src.defence_exp += exp/(src.defence/src.mod_defence)
				if(src.defence_exp >= 10000) src.defence_exp = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.xp_defence >= 10000) src.xp_defence = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.defence_exp >= 100)
					while(src.defence_exp >= 100)
						src.defence_exp = src.defence_exp-100
						src.defence_base += multi*src.mod_defence
						src.defence += multi*src.mod_defence
						src.gains_trained_def += multi
						src.combat_exp += 10
						src.xp_defence += 10;
						src.display_gain(stat)
				if(src.xp_defence >= 100)
					if(islist(src.tutorials))
						var/obj/help_topics/H = src.tutorials[8]
						if(H.seen == 0)
							H.seen = 1
							H.skill_up(src)
					while(src.xp_defence >= 100)
						src.xp_defence = src.xp_defence-100
						src.skill_points_defence += 1;
						if(src.client) winset(src,"skill_pane_defence.label_points","text=\"Defence Points: [src.skill_points_defence]\"")
						src.set_alert("+1 Defence Skill Points",'stat_reflexes.dmi',"reflexes")
						src.create_chat_entry("alerts","+1 Defence Skill Points")

			if(stat == "regen")
				src.xp_regen += 1;
				if(src.xp_regen >= 10000) src.xp_regen = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.xp_regen >= 100)
					while(src.xp_regen >= 100)
						src.xp_regen = src.xp_regen-100
						src.skill_points_regen += 1;
						src.set_alert("+1 Regen Skill Points",'stat_regen.dmi',"regen")
						src.create_chat_entry("alerts","+1 Regeneration Skill Points")

			if(stat == "recovery")
				src.xp_recovery += 1;
				if(src.xp_recovery >= 10000) src.xp_recovery = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.xp_recovery >= 100)
					while(src.xp_recovery >= 100)
						src.xp_recovery = src.xp_recovery-100
						src.skill_points_recovery += 1;
						src.set_alert("+1 Recov Skill Points",'stat_recovery.dmi',"recovery")
						src.create_chat_entry("alerts","+1 Recovery Skill Points")

			if(stat == "agility")
				src.xp_agility += 1;
				if(src.xp_agility >= 10000) src.xp_agility = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				if(src.xp_agility >= 100)
					while(src.xp_agility >= 100)
						src.xp_agility = src.xp_agility-100
						src.skill_points_agility += 1;
						src.set_alert("+1 Agility Skill Points",'stat_agility.dmi',"agility")
						src.create_chat_entry("alerts","+1 Agility Skill Points")

			if(src.combat_exp >= 100)
				if(islist(src.tutorials))
					var/obj/help_topics/H = src.tutorials[9]
					if(H.seen == 0)
						H.seen = 1
						H.skill_up(src)
				if(src.combat_exp >= 10000) src.combat_exp = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				while(src.combat_exp >= 100)
					src.combat_lvl += 1
					src.combat_exp = src.combat_exp-100
					src.trait_exp += 1
					src.display_gain("combat")

				src.set_alert("Combat Level reached [src.combat_lvl]",'stat_lvl.dmi',"lvl")
				src.create_chat_entry("alerts","Combat Level reached [src.combat_lvl]")

			if(src.trait_exp >= 10)
				if(src.trait_exp >= 10000) src.trait_exp = 10000 //Make sure the while() stuff doesn't hang or crash, because too high a number will throw an inf loop error.
				while(src.trait_exp >= 10)
					src.trait_exp = src.trait_exp-10
					src.skill_points_combat += 1
				src.set_alert("+1 Trait points",'stat_recovery.dmi',"recovery")
				src.create_chat_entry("alerts","+1 Trait points")
