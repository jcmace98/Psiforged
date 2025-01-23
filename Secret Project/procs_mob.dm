/*
.:Cheat sheet for mob procs:.

	- List of procs that proc every few seconds for the player.
	- Most of the procs in this file don't proc, but the ones listed below do.
	- Also includes procs not in this file

	process_stats() - "procs_mob.dm"
		- procs every 10 seconds in game
	gain_relations() - "contacts.dm"
		- procs every 60 seconds in game

*/

mob
	proc
		process_stats()
			//set background = 1
			var/mob/m = src
			m.stats() // Checked V 0.10 for crashes
			//Melee attack speed
			if(m.mod_agility > 0) m.attack_rate=10/m.mod_agility
			if(m.attack_rate <= 1) m.attack_rate = 1
			else if(m.skill_super_speed && m.skill_super_speed.active) m.attack_rate/=2
			if(m.client && m.started)
				m.update_skill_exp()
				m.update_body_exp_hp()
				m.lift = (m.strength+m.endurance)*2
				if(m.open_stats)
					//Then set the core stats
					//if(m && m.client && winget(m,"stats.tab_stats","current-tab") == "stats_other") winset(m,null,"stats_other.label_rads.text=\"Radiation tolerance: [m.mod_immune_rads*100]%\";stats_other.label_cold.text=\"Cold tolerance: [m.mod_immune_cold*100]%\";stats_other.label_heat.text=\"Heat tolerance: [m.mod_immune_heat*100]%\";stats_other.label_lift.text=\"Lift: [m.lift]\";stats_other.label_age.text=\"Physical Age: [m.age]\";stats_other.label_soul_age.text=\"Soul Age: [m.age_soul]\";stats_other.label_decline_age.text=\"Decline Age: [m.oldage]\";stats_other.label_lifespan.text=\"Lifespan: [m.lifespan]\";stats_other.label_vigour.text=\"Vigour: [m.vigour]%\";stats_other.label_traits.text=\"Trait Points: [m.skill_points_combat]\";stats_other.label_grav_mas.text=\"Gravity Mastered: [m.gravity_mastered]\";stats_other.label_grav_res.text=\"Gravity tolerance: [m.mod_immune_gravity]\"")
					//else if(m && m.client && winget(m,"stats.tab_stats","current-tab") == "stats_core")
					//Calculate and show buffs/debuffs and boosts to power in percentages
					//Update and display stats
					m.hud_stats.update_bars(m)
					m.update_player_info()

				if(m.mouse_skill && m.client) winset(m,null,"skills.bar_skill.value=[m.mouse_skill.skill_exp];skills.label_lvl.text=\"[m.mouse_skill.skill_lvl]\"")
				//Underwater
				if(m) m.check_underwater() // Checked V 0.10 for crashes
				//Adjust estimates
				if(m && m.target) m.estimates() // Checked V 0.10 for crashes
				//Inventory check
				if(m.accessing)
					if(ismob(m.accessing))
						var/mob/m_inv = m.accessing
						//If the mob is not ko, then switch back to player if not already done so.
						if(m_inv.owner != m.real_name && m_inv.koed == 0 && m_inv != m)
							m.accessing = m
							m.refresh_inv()
					//If the mob is too far away, switch back to player.
					if(get_dist(m,m.accessing) > 2)
						m.accessing = m
						m.refresh_inv() // Checked V 0.10 for crashes
						if(m.left_click_function == "revive defibrillator")
							m.left_click_function = null
							m.left_click_ref = null

				else
					//When not accessing a container, switch back to players inv
					m.accessing = m
					m.refresh_inv() // Checked V 0.10 for crashes
			if(m)
				//Hunger/Thirst/Tiredness
				if(m.has_body)
					m.hunger -= m.metabolic_rate
					m.thirst -= m.dehydration_rate
					if(m.skill_sleep == null || m.skill_sleep && m.skill_sleep.active == 0) m.restedness -= m.tiredness_rate
				else
					m.hunger = 0
					m.thirst = 0
					m.restedness = 0
				m.hunger = clamp(m.hunger,0,100)
				m.thirst = clamp(m.thirst,0,100)
				m.restedness = clamp(m.restedness,0,100)

				if(m.percent_energy < 0 || m.energy < 0)
					m.percent_energy = 0
					m.energy = 0
				//if(m.client) m.client.images -= m.bar_ko
				if(m.bar_ko)
					if(m.client) m.client.images -= m.bar_ko
					m.bar_ko.icon_state = round(m.percent_ko,10)
					if(m.client) m.client.images += m.bar_ko
					/*
					var/image/ko = image('bars_ko.dmi',m,"[round(m.percent_ko,10)]",1000)
					ko.pixel_y = -14;
					ko.pixel_x = 6;
					m.bar_ko = ko
					if(m.client) m.client.images += m.bar_ko
					*/
				if(m.slice_eng) m.slice_eng.pixel_x = (m.percent_energy/3)-33 //m.bar_energy.icon_state = "[round(m.percent_energy,10)]"
				if(m.slice_hp) m.slice_hp.pixel_x = (m.percent_health/3)-33 //m.bar_health.icon_state = "[round(m.percent_health,10)]"
				if(m.slice_o2) m.slice_o2.pixel_x = (((m.o2/m.o2_max)*100)/3)-33 //m.bar_o2.icon_state = "[round(m.o2,10)]"
				if(m.target)
					var/mob/t = m.target
					var/p = round((t.psionic_power/m.psionic_power)*100)
					for(var/obj/hud/menus/sense_box/b in m.sense_boxes)
						for(var/obj/o in b)
							o.maptext = "[css_outline]<font size = 1>Name: [t.name]\nDirection: [dir2text_sense(get_dir(m.loc,t.loc))]\nPower: [p]%"
							break

				//Environmental damage/training
				if(m && m.started)
					if(m.origin)
						if(istype(m.origin,/obj/origins/exalted))
							for(var/mob/x in view(6,m))
								if(x != m && x.debuff_exalted)
									if(x.skill_active_meditation == null || x.skill_active_meditation && x.skill_active_meditation.active == 0)
										if(x.skill_meditation == null || x.skill_meditation && x.skill_meditation.active == 0)
											x.debuff_exalted.active = 1
											x.blinding_light = 1
											for(var/obj/body_related/bodyparts/head/hd in x.bodyparts)
												for(var/obj/body_related/bodyparts/head/left_eye/le in hd)
													x.damage_limb(x,0, 1, 0.2*x.mod_regeneration,le)
													break
												for(var/obj/body_related/bodyparts/head/right_eye/re in hd)
													x.damage_limb(x,0, 1, 0.2*x.mod_regeneration,re)
													break
						else if(istype(m.origin,/obj/origins/baleful))
							for(var/mob/x in view(4,m))
								if(x != m && x.debuff_baleful)
									x.debuff_baleful.active = 1
									x.baleful_light = 1
									var/eng = (x.energy_max/80)*x.mod_recovery
									x.energy -= eng
									m.energy += eng
						else if(istype(m.origin,/obj/origins/solar_powered))
							if(m.z == 1 || m.z == 2 || m.z == 4 || m.z == 5)
								m.gain_stat("energy",1,10,"Solar Powered")
						else if(istype(m.origin,/obj/origins/self_learning_algorithms))
							var/obj/body_related/h = m.bodyparts[1]
							for(var/obj/body_related/bodyparts/head/artificial_brain/b in h)
								if(b.disabled == 0 && b.damaged == 0)
									b.part_exp += 4
									b.part_reward(m,1,null,0)
					if(m.z == 4)
						if(world_tree)
							if(m.x >= 210 && m.x <= 290)
								if(m.y >= 250 && m.y <= 305)
									m.gain_stat("divine",1,10,"World Tree",1)
									m.divine_energy += 0.01*m.divine_energy_mod
					else if(m.z == 2 || m.z == 6)
						//if(prob(10)) m << sound(pick(thunder),0,1,5,100)
						m.gain_stat("power",1,1,"Psionic Realm saturation")
						m.gain_stat("energy",1,10,"Psionic Realm saturation")
						m.gain_stat("divine",1,10,"Psionic Realm saturation")
						m.divine_energy += 0.01*m.divine_energy_mod
						if(islist(m.tutorials))
							var/obj/help_topics/H = m.tutorials[7]
							if(H.seen == 0)
								H.seen = 1
								H.skill_up(m)
					if(m.tmp_dmg != 0)
						if(m.has_body && m.afk == 0)
							if(m && m.percent_health > 10)
								m.check_quest("tutorial_environmentals",1)
								m.gain_stat("endurance",1,10,"Environmental",1)
								m.lvl_typesof_bodypart(list("Skin"),1,1)
							if(m && m.tmp_dmg > 0)
								if(m.debuff_hot && m.debuff_hot.active == 0)
									call(m.debuff_hot.act)(m,m.debuff_hot)
									if(m && m.debuff_cold && m.debuff_cold.active)
										call(m.debuff_cold.act)(m,m.debuff_cold)
										if(m.client) m.client.screen -= m.debuff_cold
								if(m && m.percent_health >= 10)
									var/dmg = abs(m.tmp_dmg)-m.mod_immune_heat
									//world << "DEBUG - heat dmg is [dmg]"
									if(dmg > 0)
										m.percent_health -= dmg
									m.check_quest("env_heat",1,1,1)
							if(m && m.tmp_dmg < 0)
								if(m.debuff_cold && m.debuff_cold.active == 0)
									call(m.debuff_cold.act)(m,m.debuff_cold)
									if(m && m.debuff_hot && m.debuff_hot.active)
										call(m.debuff_hot.act)(m,m.debuff_hot)
										if(m.client) m.client.screen -= m.debuff_hot
								if(m && m.percent_health >= 10)
									var/dmg = abs(m.tmp_dmg)-m.mod_immune_cold
									if(dmg > 0)
										m.percent_health -= dmg
									m.check_quest("env_cold",1,1,1)
					else
						if(m && m.debuff_hot && m.debuff_hot.active)
							call(m.debuff_hot.act)(m,m.debuff_hot)
							if(m.client) m.client.screen -= m.debuff_hot
						if(m && m.debuff_cold && m.debuff_cold.active)
							call(m.debuff_cold.act)(m,m.debuff_cold)
							if(m.client) m.client.screen -= m.debuff_cold
						if(m && m.client && m.started) m.endurance_sources -= "Environmental"
					//Check if player weighted
					if(m.weight > 1)
						if(m.debuff_weights && m.debuff_weights.active == 0) call(m.debuff_weights.act)(m,m.debuff_weights)
						m.gain_stat("power",1,1,"Weights")
						m.gain_stat("strength",1,10,"Weights")
					//Check if player inside a high gravity field.
					if(m.loc)
						//Handle blackholes and neutron stars here
						var/turf/t = m.loc
						if(t.grav < 0) m.grav = m.gravity_mastered+0.1
						if(t.microwaves < 0) m.microwaves = m.microwaves_mastered+0.1

						//Set grav/micro records
						if(m.grav > m.grav_highest) m.grav_highest = m.grav
						if(m.microwaves > m.micro_highest) m.micro_highest = m.microwaves
					if(m.grav > m.gravity_mastered && m.koed == 0 && m.grav > 0 && m.afk == 0)
						m.check_quest("tutorial_environmentals",1)
						m.in_gravity = 2;
						if(m.debuff_gravity && m.debuff_gravity.active == 0) call(m.debuff_gravity.act)(m,m.debuff_gravity)
						if(m.koed == 0 && m.percent_health > 10 && m.afk == 0)
							m.check_quest("env_grav",1,1,1)
							var/DMG = (m.grav/m.gravity_mastered)/(1+m.mod_immune_gravity)
							if(DMG > 0) m.percent_health -= DMG
							if(m.percent_health < 0)
								m.KO()
								//return
							if(m.grab) m.gain_stat("strength",1,1,"High gravity")
							else m.gain_stat("strength",1,1,"High gravity")
							m.gain_stat("endurance",1,1,"High gravity")
							m.gain_stat("dark matter",1,5,"High gravity")
							m.dark_matter += 0.01*m.dark_matter_mod
							if(islist(m.tutorials))
								var/obj/help_topics/H = m.tutorials[14]
								if(H.seen == 0)
									H.seen = 1
									H.skill_up(m)
							if(islist(m.tutorials))
								var/obj/help_topics/H = m.tutorials[15]
								if(H.seen == 0)
									H.seen = 1
									H.skill_up(m)
							if(m.grav > 0) m.gain_stat("power",1,1+(m.grav/100),"High gravity")
							if(m.grav > 0) m.gravity_mastered += ((0.005*m.mod_endurance)*m.mod_gravity)*(m.grav/m.gravity_mastered) //Did a grav check as there might be a tiny delay in gain_stat?
							m.lvl_typesof_bodypart(list("Muscle","Bone"),1,1)
					if(m.microwaves > m.microwaves_mastered && m.koed == 0 && m.microwaves > 0 && m.afk == 0)
						m.check_quest("tutorial_environmentals",1)
						m.in_microwaves = 2;
						if(m.debuff_microwaves && m.debuff_microwaves.active == 0) call(m.debuff_microwaves.act)(m,m.debuff_microwaves)
						if(m.koed == 0 && m.percent_health > 10 && m.afk == 0)
							m.check_quest("env_micro",1,1,1)
							var/DMG = (m.microwaves/m.microwaves_mastered)
							DMG = DMG/(1+m.mod_immune_microwaves)
							if(DMG > 0) m.percent_health -= DMG
							m.percent_health -= DMG
							if(m.percent_health < 0)
								m.KO()
								//return
							m.gain_stat("energy",1,1,"High microwaves")
							m.gain_stat("force",1,1,"High microwaves")
							m.gain_stat("resistance",1,1,"High microwaves")
							if(islist(m.tutorials))
								var/obj/help_topics/H = m.tutorials[14]
								if(H.seen == 0)
									H.seen = 1
									H.skill_up(m)
							if(islist(m.tutorials))
								var/obj/help_topics/H = m.tutorials[15]
								if(H.seen == 0)
									H.seen = 1
									H.skill_up(m)
							if(m.microwaves > 0) m.gain_stat("power",1,1+(m.microwaves/100),"High microwaves")
							if(m.microwaves > 0) m.microwaves_mastered += ((0.005*m.mod_resistance)*m.mod_microwaves)*(m.microwaves/m.microwaves_mastered)
							m.lvl_typesof_bodypart(list("Organ"),1,1)
							for(var/obj/body_related/bodyparts/meridians/dantian/d in m.meridians)
								var/xp = 1
								d.part_exp += xp
								d.part_reward(m,1,null,1)
								break
				//Update the buffs and debuffs screen locs. Do this after any stat gains.
				if(m.client && m.started)
					m.update_debuffs() // Checked V 0.10 for crashes
					//While we're here, check if player went afk.
					if(m.afk == 0)
						if(m.client && m.client.inactivity >= 3000)
							m.overlays -= /obj/effects/afk
							m.overlays += /obj/effects/afk
							m.afk = 1
							if(m.client) winset(m,"chat.afk","is-checked=true")
							for(var/mob/x in view(8,m))
								x << output("[m] automatically went afk.","chat.local")
					else if(m.client && m.afk == 1 && m.client.inactivity <= 100 && m.client.inactivity >= 0)
						m.overlays -= /obj/effects/afk
						m.afk = 0
						if(m.client) winset(m,"chat.afk","is-checked=false")
						for(var/mob/x in view(8,m))
							x << output("[m] came back from afk.","chat.local")
			spawn(10)
				if(m) m.process_stats()
		update_player_info()
			/*
			if(src.hud_stats)
				//Character info
				var/obj/info1 = src.hud_stats.txt_info1
				var/obj/info2 = src.hud_stats.txt_info2
				info1.maptext = "[css_outline]<font size = 1><text align=left valign=top>\
						<SPAN STYLE='text-decoration: underline'>Age</span>\n\n\
						Physical Age: [round(src.age,0.1)]\n\n\
						Soul Age: [round(src.age_soul,0.1)]\n\n\
						Old Age: [src.oldage]\n\n\
						Lifespan: [src.lifespan]\n\n\
						Vigour: [src.vigour]%\n\n\
						Year Born: [src.birth_year]"
				info2.maptext = "[css_outline]<font size = 1><text align=left valign=top>\
						<SPAN STYLE='text-decoration: underline'>General Info</span>\n\n\
						Name: [src.name]\n\n\
						Real Name: [src.real_name]\n\n\
						Sex: [src.gen]\n\n\
						Race: [src.race]\n\n\
						Lifting Capacity: [src.lift]\n\n\
						Origin: [src.origin] \n\n\
						Intelligence Mod: [src.mod_intelligence]\n\n\
						Teaching Cooldown: \n\n\
						Trait Points: [src.skill_points_combat]"
				//Survival info
				var/obj/info3 = src.hud_stats.txt_info3
				var/obj/info4 = src.hud_stats.txt_info4
				info3.maptext = "[css_outline]<font size = 1><text align=left valign=top>\
						<SPAN STYLE='text-decoration: underline'>Tolerances</span>\n\n\
						Radiation Tolerance: [src.mod_immune_rads*100]%\n\n\
						Heat Tolerance: [src.mod_immune_heat*100]%\n\n\
						Cold Tolerance: [src.mod_immune_cold*100]%\n\n\
						Gravity Tolerance: [src.mod_immune_gravity*100]%\n\n\
						Microwave Tolerance: [src.mod_immune_microwaves*100]%\n\n\
						Toxin Tolerance: [src.mod_immune_toxins*100]%\n\n\
						Toxicity Buildup: [src.toxicity]%\n\n\
						<SPAN STYLE='text-decoration: underline'>Masteries</span>\n\n\
						Gravity Multiplier: [src.mod_gravity]\n\n\
						Microwave Multiplier: [src.mod_microwaves]\n\n\
						Gravity Mastered: [src.gravity_mastered]\n\n\
						Microwaves Mastered: [src.microwaves_mastered]"
				info4.maptext = "[css_outline]<font size = 1><text align=left valign=top>\
						<SPAN STYLE='text-decoration: underline'>Needs</span>\n\n\
						Oxygen: [src.o2]/[src.o2_max]\n\n\
						Needs Oxygen: [src.need_o2]\n\n\
						Needs Food: [src.need_food]\n\n\
						Needs Water: [src.need_water]\n\n\
						Satiation: [src.hunger]%\n\n\
						Hydration: [src.thirst]%\n\n\
						Restedness: [src.restedness]%\n\n\
						Metabolic Rate: [src.metabolic_rate]\n\n\
						Dehydration Rate: [src.dehydration_rate]\n\n\
						Tiredness Rate: [src.tiredness_rate]\n\n\
						Dead: \n\n\
						Has Body:"
			*/
		create_target_bars(var/mob/m)
			if(src.sense_boxes == null || length(src.sense_boxes) <= 0)
				src.sense_boxes = list()
				var/obj/hud/menus/sense_box/b = new
				b.layer = m.layer - 1
				src.sense_boxes += b

				var/obj/hud/menus/sense_box_advanced/ba = new
				ba.layer = m.layer - 1
				src.sense_boxes += ba

				var/obj/hud/menus/sense_button/bu = new
				bu.layer = m.layer - 1
				src.sense_boxes += bu

				var/obj/box_text = new
				box_text.maptext_width = 160
				box_text.maptext_height = 64
				box_text.appearance_flags = KEEP_APART | RESET_COLOR | NO_CLIENT_COLOR | RESET_TRANSFORM
				box_text.maptext = "[css_outline]<font size = 1>[m.name]"
				//box_text.filters += filter(type="outline", size=1, color=rgb(0,0,0))
				box_text.screen_loc = "2:18,14:-23"
				box_text.loc = b

				var/obj/box_text_advanced = new
				box_text_advanced.layer = ba.layer + 1
				box_text_advanced.maptext_width = 160
				box_text_advanced.maptext_height = 320
				box_text_advanced.appearance_flags = KEEP_APART | RESET_COLOR | NO_CLIENT_COLOR | RESET_TRANSFORM
				box_text_advanced.maptext = "<font size = 1>Offence: 100%\nDefence: 100%\nStrength:100%\nEndurance: 100%\nForce: 100%\nResistance: 100%\nAgility: 100%\nRegeneration: 100%\nRecovery: 100%"
				box_text_advanced.filters += filter(type="outline", size=1, color=rgb(0,0,0))
				box_text_advanced.screen_loc = "1:6,9:-2"
				box_text_advanced.loc = ba
			if(!m.bar_health)
				var/image/hp_shell = image('bars_health.dmi',m,"shell",20)
				var/matrix/mat = matrix()
				mat.Translate(abs(src.pixel_x_og),src.i_height+5)
				hp_shell.transform = mat
				hp_shell.appearance_flags = KEEP_APART// | RESET_TRANSFORM

				var/obj/hp = new
				hp.icon = 'bars_health.dmi'
				hp.icon_state = "bar"
				hp.layer = 20
				hp.appearance_flags = KEEP_TOGETHER// | RESET_TRANSFORM

				var/obj/hud/bars/hp_slice/hp_s = new
				hp_shell.vis_contents += hp
				hp.vis_contents += hp_s

				m.slice_hp = hp_s
				m.bar_health = hp_shell
			if(!m.bar_energy)
				var/image/eng_shell = image('bars_health.dmi',m,"shell",20)
				var/matrix/mat = matrix()
				mat.Translate(abs(src.pixel_x_og),src.i_height)
				eng_shell.transform = mat
				eng_shell.appearance_flags = KEEP_APART// | RESET_TRANSFORM

				var/obj/eng = new
				eng.icon = 'bars_health.dmi'
				eng.icon_state = "bar"
				eng.layer = 20
				eng.appearance_flags = KEEP_TOGETHER// | RESET_TRANSFORM

				var/obj/hud/bars/hp_slice/eng_s = new
				eng_s.icon_state = "bar eng"
				eng_shell.vis_contents += eng
				eng.vis_contents += eng_s

				m.slice_eng = eng_s
				m.bar_energy = eng_shell
		drop_cybertech()
			var/list/cybertech = list()
			for(var/obj/body_related/bodyparts/limb in src.bodyparts)
				for(var/obj/body_related/bodyparts/part in limb)
					for(var/obj/body_related/bodyparts/cybernetics/c in part)
						part.cybernetics_current -= 1
						cybertech += c
			if(length(cybertech) > 0)
				src.disable_parts(cybertech,0,1,0)
				for(var/obj/body_related/bodyparts/cybernetics/c in cybertech)
					c.loc = src.loc
					c.desc = "Level: [c.level]/1000 \n[initial(c.info)]"
				if(src.client) src.refresh_inv()
				src.set_alert("All cybertech removed",'alert.dmi',"alert")
				src.create_chat_entry("alerts","All cybertech removed.")
		add_to_skillbar(var/obj/skills/skill,var/obj/h)
			if(skill.type == /obj/skills/AA_Skill_Copy)
				for(var/obj/skills/s in src)
					if(skill.cloned == "[s.name] aa_clone_aa")
						skill = s
						break
			if(istype(h,/obj/hud/buttons/skillbar/skillbar_one) || istype(h,/obj/skills) && src.one && length(src.one) > 0 && src.one[1] == h)
				src.check_skillbar(skill)
				src.one = list(skill)
				if(istype(h,/obj/skills)) src.client.screen -= h
				skill.screen_loc = "12:-13,1:4"
				for(var/obj/hud/buttons/skillbar/skillbar_one/h1 in src.hud_skillbar)
					h1.overlays = null
					h1.overlays += /obj/hud/buttons/skillbar/skillbar_one_overlay
					break
				src.client.screen += skill
				if(skill.repeat == 1)
					if(src.one_rep == 0)
						winset(src,"macro.1","name= 1+REP")
						src.one_rep = 1;
				else if(src.one_rep == 1)
					winset(src,"macro.1+REP","name= 1")
					src.one_rep = 0;
				return
			if(istype(h,/obj/hud/buttons/skillbar/skillbar_two) || istype(h,/obj/skills) && src.two && length(src.two) > 0 && src.two[1] == h)
				src.check_skillbar(skill)
				src.two = list(skill)
				if(istype(h,/obj/skills)) src.client.screen -= h
				skill.screen_loc = "13:-12,1:4"
				src.client.screen += skill
				for(var/obj/hud/buttons/skillbar/skillbar_two/h1 in src.hud_skillbar)
					h1.overlays = null
					h1.overlays += /obj/hud/buttons/skillbar/skillbar_two_overlay
					break
				if(skill.repeat == 1)
					if(src.two_rep == 0)
						winset(src,"macro.2","name= 2+REP")
						src.two_rep = 1;
				else if(src.two_rep == 1)
					winset(src,"macro.2+REP","name= 2")
					src.two_rep = 0;
				return

			if(istype(h,/obj/hud/buttons/skillbar/skillbar_three) || istype(h,/obj/skills) && src.three && length(src.three) > 0 && src.three[1] == h)
				src.check_skillbar(skill)
				src.three = list(skill)
				if(istype(h,/obj/skills)) src.client.screen -= h
				skill.screen_loc = "14:-11,1:4"
				src.client.screen += skill
				for(var/obj/hud/buttons/skillbar/skillbar_three/h1 in src.hud_skillbar)
					h1.overlays = null
					h1.overlays += /obj/hud/buttons/skillbar/skillbar_three_overlay
					break
				if(skill.repeat == 1)
					if(src.three_rep == 0)
						winset(src,"macro.3","name= 3+REP")
						src.three_rep = 1;
				else if(src.three_rep == 1)
					winset(src,"macro.3+REP","name= 3")
					src.three_rep = 0;
				return

			if(istype(h,/obj/hud/buttons/skillbar/skillbar_four) || istype(h,/obj/skills) && src.four && length(src.four) > 0 && src.four[1] == h)
				src.check_skillbar(skill)
				src.four = list(skill)
				if(istype(h,/obj/skills)) src.client.screen -= h
				skill.screen_loc = "15:-10,1:4"
				src.client.screen += skill
				for(var/obj/hud/buttons/skillbar/skillbar_four/h1 in src.hud_skillbar)
					h1.overlays = null
					h1.overlays += /obj/hud/buttons/skillbar/skillbar_four_overlay
					break
				if(skill.repeat == 1)
					if(src.four_rep == 0)
						winset(src,"macro.4","name= 4+REP")
						src.four_rep = 1;
				else if(src.four_rep == 1)
					winset(src,"macro.4+REP","name= 4")
					src.four_rep = 0;
				world << "DEBUG - Set skill bar four as [skill]"
				return

			if(istype(h,/obj/hud/buttons/skillbar/skillbar_five) || istype(h,/obj/skills) && src.five && length(src.five) > 0 && src.five[1] == h)
				src.check_skillbar(skill)
				src.five = list(skill)
				if(istype(h,/obj/skills)) src.client.screen -= h
				skill.screen_loc = "16:-9,1:4"
				src.client.screen += skill
				for(var/obj/hud/buttons/skillbar/skillbar_five/h1 in src.hud_skillbar)
					h1.overlays = null
					h1.overlays += /obj/hud/buttons/skillbar/skillbar_five_overlay
					break
				if(skill.repeat == 1)
					if(src.five_rep == 0)
						winset(usr,"macro.5","name= 5+REP")
						src.five_rep = 1;
				else if(src.five_rep == 1)
					winset(usr,"macro.5+REP","name= 5")
					src.five_rep = 0;
				return

			if(istype(h,/obj/hud/buttons/skillbar/skillbar_six) || istype(h,/obj/skills) && src.six && length(src.six) > 0 && src.six[1] == h)
				src.check_skillbar(skill)
				src.six = list(skill)
				if(istype(h,/obj/skills)) src.client.screen -= h
				skill.screen_loc = "17:-8,1:4"
				src.client.screen += skill
				for(var/obj/hud/buttons/skillbar/skillbar_six/h1 in src.hud_skillbar)
					h1.overlays = null
					h1.overlays += /obj/hud/buttons/skillbar/skillbar_six_overlay
					break
				if(skill.repeat == 1)
					if(src.six_rep == 0)
						winset(usr,"macro.6","name= 6+REP")
						src.six_rep = 1;
				else if(src.six_rep == 1)
					winset(usr,"macro.6+REP","name= 6")
					src.six_rep = 0;
				return

			if(istype(h,/obj/hud/buttons/skillbar/skillbar_seven) || istype(h,/obj/skills) && src.seven && length(src.seven) > 0 && src.seven[1] == h)
				src.check_skillbar(skill)
				src.seven = list(skill)
				if(istype(h,/obj/skills)) src.client.screen -= h
				skill.screen_loc = "18:-7,1:4"
				src.client.screen += skill
				for(var/obj/hud/buttons/skillbar/skillbar_seven/h1 in src.hud_skillbar)
					h1.overlays = null
					h1.overlays += /obj/hud/buttons/skillbar/skillbar_seven_overlay
					break
				if(skill.repeat == 1)
					if(src.seven_rep == 0)
						winset(usr,"macro.7","name= 7+REP")
						src.seven_rep = 1;
				else if(src.seven_rep == 1)
					winset(usr,"macro.7+REP","name= 7")
					src.seven_rep = 0;
				return

			if(istype(h,/obj/hud/buttons/skillbar/skillbar_eight) || istype(h,/obj/skills) && src.eight && length(src.eight) > 0 && src.eight[1] == h)
				src.check_skillbar(skill)
				src.eight = list(skill)
				if(istype(h,/obj/skills)) src.client.screen -= h
				skill.screen_loc = "19:-6,1:4"
				src.client.screen += skill
				for(var/obj/hud/buttons/skillbar/skillbar_eight/h1 in src.hud_skillbar)
					h1.overlays = null
					h1.overlays += /obj/hud/buttons/skillbar/skillbar_eight_overlay
					break
				if(skill.repeat == 1)
					if(src.eight_rep == 0)
						winset(usr,"macro.8","name= 8+REP")
						src.eight_rep = 1;
				else if(src.eight_rep == 1)
					winset(usr,"macro.8+REP","name= 8")
					src.eight_rep = 0;
				return

			if(istype(h,/obj/hud/buttons/skillbar/skillbar_nine) || istype(h,/obj/skills) && src.nine && length(src.nine) > 0 && src.nine[1] == h)
				src.check_skillbar(skill)
				src.nine = list(skill)
				if(istype(h,/obj/skills)) src.client.screen -= h
				skill.screen_loc = "20:-5,1:4"
				src.client.screen += skill
				for(var/obj/hud/buttons/skillbar/skillbar_nine/h1 in src.hud_skillbar)
					h1.overlays = null
					h1.overlays += /obj/hud/buttons/skillbar/skillbar_nine_overlay
					break
				if(skill.repeat == 1)
					if(src.nine_rep == 0)
						winset(usr,"macro.9","name= 9+REP")
						src.nine_rep = 1;
				else if(src.nine_rep == 1)
					winset(usr,"macro.9+REP","name= 9")
					src.nine_rep = 0;
				return

			if(istype(h,/obj/hud/buttons/skillbar/skillbar_zero) || istype(h,/obj/skills) && src.zero && length(src.zero) > 0 && src.zero[1] == h)
				src.check_skillbar(skill)
				src.zero = list(skill)
				if(istype(h,/obj/skills)) src.client.screen -= h
				skill.screen_loc = "21:-4,1:4"
				src.client.screen += skill
				for(var/obj/hud/buttons/skillbar/skillbar_zero/h1 in src.hud_skillbar)
					h1.overlays = null
					h1.overlays += /obj/hud/buttons/skillbar/skillbar_zero_overlay
					break
				if(skill.repeat == 1)
					if(src.zero_rep == 0)
						winset(usr,"macro.0","name= 0+REP")
						src.zero_rep = 1;
				else if(src.zero_rep == 1)
					winset(usr,"macro.0+REP","name= 0")
					src.zero_rep = 0;
				return
		grab_something(var/atom/movable/x)
			if(src.grab == null)
				var/list/itm = list()
				//If an item is specified, pick it up.
				if(x) itm += x
				//Otherwise proceed with default behaviour and search for an item instead.
				else
					for(var/atom/movable/A in range(2,src))
						var/D = get_dir(src,A)
						if(A.bolted == 0 || src.trait_hm)
							if(bounds_dist(src,A) <= 16)
								if(src.mouse_over == A)
									itm += A
									src.dir = get_dir(src,A)
								if(src.dir == EAST)
									if(D == EAST || D == NORTHEAST || D == SOUTHEAST || D == 0) itm += A
								if(src.dir == WEST)
									if(D == WEST || D == NORTHWEST || D == SOUTHWEST || D == 0) itm += A
								if(src.dir == NORTH)
									if(D == NORTH || D == NORTHWEST || D == NORTHEAST || D == 0) itm += A
								if(src.dir == SOUTH)
									if(D == SOUTH || D == SOUTHWEST || D == SOUTHEAST || D == 0) itm += A
								if(src.dir == SOUTHEAST)
									if(D == SOUTH || D == EAST || D == SOUTHEAST || D == 0) itm += A
								if(src.dir == SOUTHWEST)
									if(D == SOUTH || D == WEST || D == SOUTHWEST || D == 0) itm += A
								if(src.dir == NORTHEAST)
									if(D == EAST || D == NORTH || D == NORTHEAST || D == 0) itm += A
								if(src.dir == NORTHWEST)
									if(D == WEST || D == NORTH || D == NORTHWEST || D == 0) itm += A
				for(var/atom/movable/A in itm)
					var/proceed = 1
					if(isturf(A.loc))
						//Otherwise, grab and lift the item.
						if(A.pixel_z > 0) proceed = 0
						if(A.bolted && src.trait_hm == null)
							proceed = 0
						if(A.bolted >= 2) proceed = 0
						if(A == src) proceed = 0
						if(A.icon == null) proceed = 0
						if(A.tk) proceed = 0
						if(ismob(A))
							var/mob/m = A
							if(m.grab && m.afk == 0)
								if(m.grab == src)
									proceed = 0
								else
									m.letgo()
					if(proceed)
						if(src.client && src.tutorials.Find(text_grabbing))
							winshow(src,"tutorial",1)
							winset(src,"tutorial.tutorial_title","text=\"Grab tutorial\"")
							winset(src,"tutorial.tutorial_info","text=\"[text_grabbing]\"")
							src.tutorials -= text_grabbing
						var/turf/t = A.loc
						if(t.liquid) A.submerge(0,1,t)
						if(!ismob(A)) animate(A, pixel_z = 16, flags = ANIMATION_PARALLEL,time = 1)
						else
							var/mob/m = A
							var/Evasion=src.evasion(src,m)//(src.psionic_power*(src.offence+(src.mod_agility*0.2)))/(m.psionic_power*(m.defence+(m.mod_agility*0.22)))
							if(m.icon_state != "meditate" && Evasion == 1)
								view(8,src) << output("<font color = purple> [m] avoids [src]'s grab attempt.", "chat.local")
								return
							if(m.eating) m.cancel_eat()
							if(m.bodyparts && length(m.bodyparts) > 0)
								src.grab_part = pick(m.bodyparts)
								view(8,src) << output("<font color = purple> [src] grabs [m] by the [src.grab_part].", "chat.local")
						A.density_factor = 0
						src.grab = A
						//world << "DEBUG - grabbed [A]"
						if(src.icon_state == "fly") src.icon_state = "fly beam"
						else if(src.icon_state == "levitate") src.icon_state = "fly beam"
						else src.icon_state = "beam"
						A.grabbed_by = src
						//If the player grabs a generator, cut the power if applicable.
						if(istype(A,/obj/items/tech/))
							for(var/turf/trf in A.locs)
								for(var/obj/items/tech/Power_Line/p in trf)
									spawn(2)
										if(p) p.reconnect_power()
						break
				if(!src.client)
					src.function = null
					src.target_go = null
				spawn(1)
					if(src && src.grab)
						while(src&&src.grab)
							if(src.client && src.client.inactivity >= 3000)
								break
							var/L = get_step(src.loc,src.dir)
							var/A = src.GetAngleStep(L)
							src.grab.loc = src.loc
							src.grab.step_x = src.step_x
							src.grab.step_y = src.step_y
							if(ismob(src.grab))
								var/mob/m = src.grab
								m.MoveAng(A,22,0,0,null) //Making this more than 30 pixels makes the Move() proc not work.
								m.layer = MOB_LAYER + m.laymod - (m.y + m.step_y / 32) / world.maxy
								m.icon_state = "grabbed"
								m.dir = get_dir(m,src)
								m.KB = 0
								if(m.map_blip)
									m.map_blip.pixel_x = m.x-3
									m.map_blip.pixel_y = m.y-3
							else
								src.grab.MoveAng(A,30,0,0,null) //Making this more than 30 pixels makes the Move() proc not work.
								src.grab.layer = src.layer+0.1
							src.grab.set_shadow()
							src.gain_stat("strength",1,0.01,"Lifting",0,0.33) //Because strength has a kinda soft-cap, unlike power, the divider var we pass ca be higher.
							src.energy -= 0.1
							src.gain_stat("power",1,0.002,"Lifting",0,0.0025)
							//if(src.grab) src.grab.layer = src.layer+0.1
							sleep(0.1)
						if(src.grab == null || src.client.inactivity > 3000)
							src.letgo()
			else
				src.letgo()
		check_planet()
			var/planet
			if(src.z == 1 || src.z == 3) planet = "Earth"
			else if(src.z == 2 || src.z == 6) planet = "Psionic Realm"
			else if(src.z == 4 || src.z == 7) planet = "Yukopia"
			else if(src.z == 5 || src.z == 8) planet = "Psionica"
			return planet
		divine_weapon_reset()
			animate(src)
			animate(src,transform = turn(matrix(), 0), time = 3)
			animate(src,pixel_y = 10, time = 20,loop = -1)
			animate(pixel_y = 0, time = 20)
		divine_weapon_attack()
			var/T = src.target
			while(src.target && src.target == T && src.target.loc && src.target.koed == 0)
				//world << "DEBUG - running divine weapon attack"
				if(src.target.fight_area == null) src.target.fight_area = src.target.loc
				else src.fight_area = src.target.fight_area
				var/steps = rand(10,100)
				var/ang = rand(0,360)
				var/num = pick(-3,3,-4,4)
				var/attack = pick(1,2)
				var/reset = 1
				var/dist_area = get_dist(src,src.target)
				if(dist_area > 8) attack = 5
				if(reset)
					animate(src,transform = turn(matrix(), 120), time = 6, loop = -1)
					animate(transform = turn(matrix(), 240), time = 6)
					animate(transform = null, time = 6)
					reset = 0
				if(attack == 5)
					steps = 40
					ang = src.GetAngle(src.target)
					while(steps)
						steps -= 1
						if(prob(10)) ang += num
						src.MoveAng(ang,8,0,0,null)
						sleep(0.5)
				else if(attack == 2)
					steps = 25
					ang = src.GetAngle(src.target)
					animate(src,transform = turn(matrix(), ang+120), time = 2)
					reset = 1
					while(steps)
						src.can_attack = 1
						src.Attack()
						src.MoveAng(ang,16,0,0,null)
						steps -= 1
						sleep(0.1)
				else
					while(steps)
						steps -= 1
						src.MoveAng(ang,8,0,0,null)
						ang += num
						sleep(0.5)
			animate(src)
			animate(src,transform = turn(matrix(), 0), time = 3)
			animate(src,pixel_y = 10, time = 20,loop = -1)
			animate(pixel_y = 0, time = 20)
		get_mouse_pos()
			if(src.target)
				var/mob/a = src.target
				var/new_x = (a.x*32)+a.step_x
				var/new_y = (a.y*32)+a.step_y
				var/xx = (src.x*32)+src.step_x
				var/yy = (src.y*32)+src.step_y
				var/d=src.atan2(xx - new_x, yy - new_y)
				d = (180-d)
				d = round(d)
				src.mouse_degree = d
				src.mouse_saved_loc = src.target.loc
		get_mouse_degree_from_player(var/xx_mouse,var/yy_mouse,var/pixel_x_mouse,var/pixel_y_mouse)
			var/new_x = (xx_mouse*32)+pixel_x_mouse
			var/new_y = (yy_mouse*32)+pixel_y_mouse
			var/xx = (17*32)+16//src.step_x
			var/yy = (11*32)+2//+24//src.step_y
			var/d=src.atan2(xx - new_x, yy - new_y)
			d = (180-d)
			d = round(d)
			world << "degree: [d], mouse: [new_x],[new_y], player: [xx],[yy]"
			return d
		check_splits()
			if(src.skill_psi_clone)
				for(var/mob/s in src.skill_psi_clone.active_splits)
					s.activated = 0
					var/image/sel = image('select.dmi',s,null,10,pixel_y = 8)
					sel.appearance_flags = KEEP_APART | RESET_TRANSFORM
					s.target_img = sel
			if(src.skill_divine_weapon)
				for(var/mob/s in src.skill_divine_weapon.active_splits)
					s.filters += filter(type="outline",size=1, color=rgb(204,236,255))
					s.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(204,236,255))
					s.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
					animate(s,pixel_y = 10, time = 20,loop = -1)
					animate(pixel_y = 0, time = 20)
					s.activated = 0
					var/image/sel = image('select.dmi',s,null,10,pixel_y = 8)
					sel.appearance_flags = KEEP_APART | RESET_TRANSFORM
					s.target_img = sel
					s.orbiting = 0
					if(s.shadow) s.shadow.vis_contents += new/obj/effects/weapon_energy
		check_wounds()
			if(src.bodyparts && length(src.bodyparts) > 0)
				for(var/obj/o in src.bodyparts)
					for(var/obj/p in o)
						if(p.hp < 100) src.hurt_limbs += p
		hide_sense(var/hide = 0,var/sense = 0)
			if(src.client)
				if(hide == 0)
					for(var/obj/b in src.sense_boxes)
						if(src.skill_sense && src.skill_sense.active)
							src.client.screen += b
							for(var/obj/o in b)
								src.client.screen += o
						else if(b.type == /obj/hud/menus/sense_box)
							src.client.screen += b
							for(var/obj/o in b)
								src.client.screen += o
						else if(b.type == /obj/hud/menus/sense_button)
							var/obj/hud/menus/sense_button/sb = b
							sb.hidden = 0
				else
					for(var/obj/b in src.sense_boxes)
						if(sense == 0)
							src.client.screen -= b
							if(b.type == /obj/hud/menus/sense_button)
								var/obj/hud/menus/sense_button/sb = b
								sb.hidden = 0
							for(var/obj/o in b)
								src.client.screen -= o
						else if(b.type == /obj/hud/menus/sense_box_advanced || b.type == /obj/hud/menus/sense_button)
							src.client.screen -= b
							for(var/obj/o in b)
								src.client.screen -= o
		add_remove_target(var/mob/m,var/remove = 0)
			if(src.target && src.client) src.client.screen -= src.target
			if(src.skill_touch_of_death && src.skill_touch_of_death.active) src.skill_touch_of_death.hits = 0
			if(remove == 0)
				src.target = m
				src.estimates()
				src.create_target_bars(m)
				m.screen_loc = "1:[8+m.pixel_x_og],13:[2+(round(m.pixel_y_og/2))]"
				if(src.client)
					//src.client.images += m.target_img
					src.client.images += m.bar_energy
					src.client.images += m.bar_health
				src.hide_sense(0)
				if(src.client) src.client.screen += m
			else
				if(src.target.bar_energy && src.client)
					src.client.images -= src.target.bar_energy
				if(src.target.bar_health && src.client)
					src.client.images -= src.target.bar_health
				if(src.target.target_img && src.client) src.client.images -= src.target.target_img
				if(src.client) src.client.screen -= src.target
				src.target = null
				//src.reset_estimates()
				src.hide_sense(1)
		get_angle(var/atom/a, var/atom/b)
			return atan2(b.y - a.y, b.x - a.x)
		atan2(x, y)
			if(!x && !y) return 0
			return y >= 0 ? arccos(x / sqrt(x * x + y * y)) : -arccos(x / sqrt(x * x + y * y))
		lvl_typesof_bodypart(var/list/bod_types,var/xp = 1,var/harm = 0,var/meridians = 0,var/give_anyway = 0,var/overide = 0)
			if(src.race == "Android" && overide == 0) return
			var/lvls = 0
			var/cal = 1
			if(xp >= 100) cal = xp/100
			if(meridians)
				for(var/obj/body_related/b in src.meridians)
					if(b.type != /obj/body_related/bodyparts/meridians/dantian)
						if(b.disabled == 0 && b.damaged == 0)
							b.part_exp += xp
							if(b.part_exp >= 100) lvls += 1
							b.part_reward(src,xp,null,1)
						else if(give_anyway)
							b.level += round(cal)
							lvls += round(cal)
			else
				for(var/obj/o in src.bodyparts)
					for(var/obj/body_related/b in o)
						var/train = 0
						for(var/t in bod_types)
							if(findtext(b.name,t)) train = 1
						if(b.bodypart_type in bod_types) train = 1
						if(train)
							if(b.disabled == 0 && b.damaged == 0)
								b.part_exp += xp
								if(b.part_exp >= 100) lvls += 1
								b.part_reward(src,xp,null,1)
								if(harm) src.damage_limb(src,0, 0, 0.15*src.mod_regeneration,b)
							else if(give_anyway)
								b.level += round(cal)
								lvls += 1
			if(lvls > 1)
				src.set_alert("[lvls] body parts increased in level by +[round(cal)]",'alert.dmi',"forged")
				src.create_chat_entry("alerts","[lvls] body parts increased in level by +[cal].")
			else if(lvls > 0)
				src.set_alert("[lvls] body part increased in level by +[round(cal)]",'alert.dmi',"forged")
				src.create_chat_entry("alerts","[lvls] body part increased in level by +[cal].")
		lvl_rand_bodypart()
			if(src.race == "Android") return
			if(src.bodyparts)
				if(length(src.bodyparts) > 0)
					var/obj/o = pick(src.bodyparts)
					var/list/p = list()
					for(var/obj/b in o)
						p += b
					if(length(p) > 0)
						var/obj/body_related/x = pick(p)
						x.part_exp = 100
						x.part_reward(src,1)
		stop_charging()
			if(src.charging)
				var/obj/ranged/c = src.charging
				c.remove()
				src.charging = null
				src.can_ki = 1
				src.stunned -= 1
				src.stunned_pending -= 1
				if(src.icon_state == "fly beam" || src.icon_state == "beam") src.icon_state = src.state()
		grab_clipboard()
			var/html={"
			<head></head>


			<body onLoad="document.getclip.submit()">
			<form name="getclip" method=GET>
			<input type="hidden" name="src" value="\ref[src]">
			<input type="hidden" name="clip" value=1>
			<SCRIPT LANGUAGE="JavaScript"><!--

			 getclip.clip.value = window.clipboardData.getData("Text");



			// --></SCRIPT>
			</form>
			"}
			//getos.clip.value = window.clipboardData.clearData("Text");

			winshow(src,"browser",1)
			winset(src,"browser.browser1","focus=true")
			src << browse(html)

			/*
			spawn(10)
				if(src && src.ctrl_held == 0) src << browse(null,"window=browser")
			*/
		check_underwater()
			if(src.submerged) //Underwater training
				src.check_quest("tutorial_environmentals",1)
				if(islist(src.tutorials))
					var/obj/help_topics/H = src.tutorials[1]
					if(H.seen == 0)
						H.seen = 1
						H.skill_up(src)
				if(src.client && !src.bar_o2 && src.need_o2 == "Yes" && src.has_body)
					var/image/o2_shell = image('bars_health.dmi',src,"shell",20)
					var/matrix/m = matrix()
					m.Translate(abs(src.pixel_x_og),-4)
					o2_shell.transform = m
					o2_shell.appearance_flags = KEEP_APART

					var/obj/o2 = new
					o2.icon = 'bars_health.dmi'
					o2.icon_state = "bar"
					o2.layer = 20
					o2.appearance_flags = KEEP_TOGETHER

					var/obj/hud/bars/hp_slice/o2_s = new
					o2_s.icon_state = "bar o2"
					o2_shell.vis_contents += o2
					o2.vis_contents += o2_s

					src.slice_o2 = o2_s
					src.bar_o2 = o2_shell

					src.client.images -= src.bar_o2
					src.client.images += src.bar_o2
				var/harm = 0
				if(src.need_o2 == "Yes" && src.has_body)
					src.o2 -= 1
					src.check_quest("env_breath",1,1,1)
				if(src.o2 <= 0 && src.need_o2 == "Yes" && src.has_body)
					src.o2 = 0;
					harm = 1
					if(src.debuff_underwater && src.debuff_underwater.active == 0)
						call(src.debuff_underwater.act)(src,src.debuff_underwater)
					if(src.percent_health > 10)
						var/dmg = (1*src.mod_regeneration)/1.4
						if(dmg > 0 && src.afk == 0)  src.percent_health -= dmg
					else if(src.percent_health <= 10)
						if(src.loc)
							var/turf/t = src.loc
							if(t.liquid != "psionic") src.submerge(0,1,src.loc)
				if(src.percent_health > 10 && src.afk == 0)
					src.gain_stat("endurance",1,10,"Underwater pressure",1)
					src.gain_stat("power",1,1,"Underwater pressure",1)
					src.lvl_typesof_bodypart(list("Lungs"),1,harm)
			else
				src.o2 += round(src.o2_max/10)
				if(src.o2 >= src.o2_max) src.o2 = src.o2_max
				if(src.debuff_underwater && src.debuff_underwater.active)
					call(src.debuff_underwater.act)(src,src.debuff_underwater)
					src.client.screen -= src.debuff_underwater

		map_update_overlays()
			for(var/obj/hud/map/map_large/x in maps)
				if(x.build_overlay)
					if(src.z == x.z_level && src.open_map) src.client.screen += x.build_overlay
					else src.client.screen -= x.build_overlay
		map_update_blip(var/task)
			if(task == "remove all" || task == "both")
				for(var/mob/p in players)
					p.client.images -= src.map_blip
			if(task == "add" || task == "both")
				for(var/mob/p in players)
					if(p.z == src.z && p.map_blip)
						if(p.skill_obfuscation == null || p.skill_obfuscation && p.skill_obfuscation.active == 0) src.client.images += p.map_blip
		map_proc(var/close = 0)
			if(islist(src.tutorials))
				var/obj/help_topics/H = src.tutorials[11]
				if(H.seen == 0)
					H.seen = 1
					H.skill_up(src)
			if(maps_created)
				if(close)
					src.open_map = 0
					src.open_menus.Remove(".open_map")
					for(var/obj/o in src.hud_map)
						src.client.screen -= o
					for(var/obj/o in map_locales)
						src.client.screen -= o
					for(var/obj/hud/map/map_large/o in maps)
						src.client.screen -= o
						src.client.screen -= o.build_overlay
					src.client.screen -= map_master
					for(var/mob/p in players)
						if(p.map_blip) src.client.images -= p.map_blip
					winshow(src,"chat",1)
					//src.adjust_skills_bar("true")
					//src.adjust_buttons("true")
					winset(src,"main.map_main","focus=true")
				else
					src.open_map = 1
					src.open_menus.Add(".open_map")
					for(var/obj/o in src.hud_map)
						src.client.screen += o
					for(var/obj/o in map_locales)
						src.client.screen += o
					var/zed = src.z
					var/obj/hud/map/map_large/m = maps[zed]
					if(m)
						src.client.screen += m
						if(m.build_overlay) src.client.screen += m.build_overlay
					src.client.screen += map_master
					if(src.map_blip) src.client.images += src.map_blip
					if(src.skill_sense && src.skill_sense.active) src.map_update_blip("add")
					winshow(src,"chat",0)
					//src.adjust_skills_bar("false")
					//src.adjust_buttons("false")
					winset(src,"main.map_main","focus=true")
		check_weather()
			var/turf/t = src.loc
			//var/set_rain = 0
			//var/set_snow = 0
			//var/set_sand = 0
			if(t.weather_type == weather_grass && src.weather != t.weather_type)
				src.client.screen += global.rainstorm
			if(t.weather_type == weather_snow && src.weather != t.weather_type)
				src.client.screen += global.snowstorm
			if(t.weather_type == weather_desert && src.weather != t.weather_type)
				src.client.screen += global.sandstorm
			src.weather = t.weather_type
			if(src.weather)
				if(src.weather != t.weather_type)
					src.client.screen -= global.rainstorm
					src.client.screen -= global.sandstorm
					src.client.screen -= global.snowstorm
					src.weather = null
					if(src.tmp_dmg == 0)
						if(src.debuff_hot && src.debuff_hot.active) call(src.debuff_hot.act)(src,src.debuff_hot)
						if(src.debuff_cold && src.debuff_cold.active) call(src.debuff_cold.act)(src,src.debuff_cold)
				else if(src.weather == "storm")
					if(src.meditating)
						if(prob(src.shock_chance))
							var/proceed = 1
							if(src.koed)
								proceed = 0
							if(proceed)
								src.gain_stat("resistance",1,1000,"Weather")
								src.gain_stat("energy",1,333,"Weather")
								src.gain_stat("power",1,1,"Weather")
								var/dmg = 1 + 14-(src.resistance/100)
								if(dmg <= 0) dmg = 1
								src.energy += src.energy_max/5
								src.percent_health -= dmg
								var/obj/effects/lightning_bolt/bolt = new
								bolt.loc = src.loc
								bolt.SetCenter(src)
								animate(bolt, alpha = 0, time = 7)
								spawn(7)
									if(bolt) del(bolt)
					if(weather_grass == null)
						src.client.screen -= global.rainstorm
						src.weather = null
				else if(src.weather == "sandstorm")
					if(src.percent_health >= 10)
						src.gain_stat("endurance",1,100,"Weather")
						src.gain_stat("power",1,1,"Weather")
						src.percent_health -= 1
					if(src.debuff_hot && src.debuff_hot.active == 0) call(src.debuff_hot.act)(src,src.debuff_hot)
					if(weather_desert == null)
						src.client.screen -= global.sandstorm
						src.weather = null
				else if(src.weather == "snowstorm")
					if(src.percent_health >= 10)
						src.gain_stat("endurance",1,100,"Weather")
						src.gain_stat("power",1,1,"Weather")
						src.percent_health -= 1
					if(src.debuff_cold && src.debuff_cold.active == 0) call(src.debuff_cold.act)(src,src.debuff_cold)
					if(weather_snow == null)
						src.client.screen -= global.snowstorm
						src.weather = null
		enable_planes()
			//The if() checks are in place because switching between followers/npc is a thing
			if(src.hud_energy == null)
				var/obj/hud/planes/plane_energy/e = new
				src.hud_energy = e

			if(src.hud_divine == null)
				var/obj/hud/planes/plane_divine/e_c = new
				src.hud_divine = e_c

			if(src.hud_wings == null)
				var/obj/hud/planes/plane_wings/w = new
				src.hud_wings = w

			if(src.hud_liquid == null)
				var/obj/hud/planes/plane_liquid/l = new
				src.hud_liquid = l

			if(src.client)
				src.client.screen += src.hud_energy
				src.client.screen += src.hud_divine
				src.client.screen += src.hud_wings
				src.client.screen += src.hud_liquid
		update_wings()
			if(src.race == "Celestial" && src.wings_hidden == 0)
				if(global.celestial_wings.len > 0)
					if(src.wings) src.vis_contents -= src.wings
					else src.wings = global.celestial_wings[1]

					if(src.dir == SOUTH)
						src.vis_contents += global.celestial_wings[1]
						src.wings = global.celestial_wings[1]
					else if(src.dir == NORTH)
						src.vis_contents += global.celestial_wings[2]
						src.wings = global.celestial_wings[2]
					else if(src.dir == EAST || src.dir == NORTHEAST || src.dir == SOUTHEAST)
						src.vis_contents += global.celestial_wings[3]
						src.wings = global.celestial_wings[3]
					else if(src.dir == WEST || src.dir == NORTHWEST || src.dir == SOUTHWEST)
						src.vis_contents += global.celestial_wings[4]
						src.wings = global.celestial_wings[4]
		reset_planes()
			if(src.hud_liquid)
				var/obj/hud/planes/plane_liquid/L = src.hud_liquid
				src.client.screen -= L
				animate(L)
				L.filters = null
				L.wavesold()
				src.client.screen += L
			if(src.hud_energy)
				src.client.screen -= src.hud_energy
				src.client.screen += src.hud_energy
			if(src.hud_divine)
				src.client.screen -= src.hud_divine
				src.client.screen += src.hud_divine
			if(src.hud_hud)
				src.client.screen -= src.hud_hud
				src.client.screen += src.hud_hud
		round_mods()
			src.mod_psionic_power = round(src.mod_psionic_power,0.1)
			src.mod_energy = round(src.mod_energy,0.1)
			src.mod_strength = round(src.mod_strength,0.1)
			src.mod_agility = round(src.mod_agility,0.1)
			src.mod_endurance = round(src.mod_endurance,0.1)
			src.mod_force = round(src.mod_force,0.1)
			src.mod_resistance = round(src.mod_resistance,0.1)
			src.mod_offence = round(src.mod_offence,0.1)
			src.mod_defence = round(src.mod_defence,0.1)
			src.mod_regeneration = round(src.mod_regeneration,0.1)
			src.mod_recovery = round(src.mod_recovery,0.1)
			src.mod_gravity = round(src.mod_gravity,0.1)
		cancel_build()
			if(src.build_mouse && src.build_tech)
				src.client.images -= src.build_mouse
				src.build_mouse.loc = null
				src.build_mouse = null
				//del(src.build_mouse)
				src.build_tech = null
				if(src.hud_build) src.client.screen += src.hud_build
				//winshow(src,"build_open",1)
				return
		cancel_tech()
			if(src.build_mouse && src.build_tech)
				src.client.images -= src.build_mouse
				src.build_mouse.loc = null
				src.build_mouse = null
				//del(src.build_mouse)
				src.build_tech = null
				//winshow(src,"tech_panes",1)
				if(src.hud_tech) src.client.screen += src.hud_tech
				for(var/obj/t in global.tech)//src.technology_researched)
					src.client.images -= t.img_select
				return
		astral_ripple()
			var/start = src.filters.len
			var/i,f
			for(i=1, i<=WAVE_COUNT, ++i)
				src.filters += filter(type="wave", x=15, y=15, size=1, offset=1)
			for(i=1, i<=WAVE_COUNT, ++i)
				// animate phase of each wave from its original phase to phase-1 and then reset;
				// this moves the wave forward in the X,Y direction
				f = src.filters[start+i]
				animate(f, offset=f:offset, time=0, loop=-1, flags=ANIMATION_PARALLEL)
				animate(offset=f:offset-1, time=20)
		cloning()
			spawn(600)
				if(src)
					//src.being_cloned = 0;
					if(src.stunned > 0)
						src.stunned -= 1;
						src.stunned_pending -= 1
		cancel_eat()
			src.eating = null
			src.icon_state = src.state()
			if(src.hud_eat)
				src.stunned -= 1
				src.stunned_pending -= 1
				src.hud_eat.flash_red()
				src.hud_eat.shake()
				//flick("cancel",src.hud_eat)
				spawn(2)
					if(src && src.hud_eat && src.eating == null) src.vis_contents -= src.hud_eat
		eat()
			//src.dir = SOUTH
			src.stunned += 1
			src.stunned_pending += 1
			if(src.hud_eat)
				src.vis_contents += src.hud_eat
				flick("eat",src.hud_eat)
			if(src.skill_flight && src.skill_flight.active || src.submerged) src.icon_state = "fly eat"
			else if(src.skill_levitation && src.skill_levitation.active || src.submerged) src.icon_state = "fly eat"
			else src.icon_state = "eat"
				/*
				spawn(global.eat_time)
					if(src && src.eating)
						src.icon_state = src.state()
						if(src.hud_eat)
							src.vis_contents -= src.hud_eat
							src.stunned -= 1
							src.stunned_pending -= 1
				*/
		show_worldtree(var/show = 1,var/overide = 0)
			if(world_tree)
				if(src.z == 4 || overide == 1)
					if(show)
						var/obj/items/tech/world_tree/wt = world_tree
						if(src.client && wt)
							if(wt.wt_trunk) src.client.images += wt.wt_trunk
							if(wt.wt_top) src.client.images += wt.wt_top
							for(var/image/i in wt.wt_rays)
								src.client.images += i
					else
						var/obj/items/tech/world_tree/wt = world_tree
						if(src.client && wt)
							if(wt.wt_trunk) src.client.images -= wt.wt_trunk
							if(wt.wt_top) src.client.images -= wt.wt_top
							for(var/image/i in wt.wt_rays)
								src.client.images -= i
		open_close_eyes(var/close = 1)
			if(close)
				//Close players eyes, if they have any.
				if(src.port)
					if(src.race == "Cerebroid") src.port.icon_state = "skin1 blink"
					if(src.port.port_iris) src.port.vis_contents -= src.port.port_iris
					if(src.port.port_eyes)
						var/obj/portrait/p = src.port
						if(p.port_eyes.state_og == null && p.port_eyes.icon) p.port_eyes.state_og = p.port_eyes.icon_state
						p.port_eyes.icon_state = "[p.port_eyes.state_og] blink"
				if(src.eyes) src.vis_contents -= src.eyes
				if(src.eyes_white) src.vis_contents -= src.eyes_white
			else
				//Open players eyes, if they have any.
				if(src.port)
					var/obj/portrait/p = src.port
					if(src.race == "Cerebroid") src.port.icon_state = "skin1"
					if(p.port_eyes) p.port_eyes.icon_state = "[p.port_eyes.state_og]"
					if(p.port_iris) p.vis_contents += p.port_iris
				if(src.eyes) src.vis_contents += src.eyes
				if(src.eyes_white) src.vis_contents += src.eyes_white
		place_percise(var/params)
			var screen_loc = params2list(params)["screen-loc"]
			var position = 1
			var colons = 0
			var first_colon
			for(var/_ in 1 to 3)
				var colon = findtext(screen_loc, ":", position)
				if(colon)
					if(!first_colon) first_colon = colon
					position = colon + 1
					colons ++
				else break
			if(colons > 2) screen_loc = copytext(screen_loc, first_colon + 1)
			//  We split "x:px,y:py" into "x:px" and "y:py".
			var comma = findtext(screen_loc, ",")
			var screen_x = copytext(screen_loc, 1, comma)
			var screen_y = copytext(screen_loc, comma + 1)
			//  Split "x:px" into x and px.
			var colon_x = findtext(screen_x, ":")
			var xx = text2num(copytext(screen_x, 1, colon_x))
			//var px = text2num(copytext(screen_x, colon_x + 1))
			//  Split "y:py" into y and py.
			var colon_y = findtext(screen_y, ":")
			var yy = text2num(copytext(screen_y, 1, colon_y))
			//var py = text2num(copytext(screen_y, colon_y + 1))
			src.new_x = src.x-(16-xx)
			src.new_y = src.y-(9-yy)
			src.client.client_mouse_screen_x = xx
			src.client.client_mouse_screen_y = yy
		toggle_skill(var/obj/o)
			for(var/obj/skills/s in src)
				if(s.disabled_switch && s != o)
					if(s.active)
						src.mouse_dir = "left"
						s.Click()
						s.active = 0
						src.mouse_dir = null
						//world << "DEBUG - Toggled [s] off"
		stun_cd(var/time)
			if(time)
				spawn(time)
					if(src)
						src.stunned -= 1
						src.stunned_pending -= 1
						src.overlays -= 'fx_stun.dmi'
		refresh_inv()
			if(src.accessing)
				var/mob/owner = src.accessing
				if(owner != src)
					for(var/sl=1, sl<49, sl++)
						if(src.inv[sl] != null)
							src.hud_inv.vis_contents -= src.inv[sl]
				if(src.hud_inv.title) src.hud_inv.title.maptext = "[css_outline]<font size = 1><text align=left valign=top>[owner]'s Inventory"
				var/n_x = -2
				var/n_y = 0
				var/xx = 0
				var/yy = 0
				for(var/sl=1, sl<49, sl++)
					if(n_x >= 4)
						n_x = -2
						n_y += 1
						//world << "reset x - [n_x]"
					if(n_y >= 8)
						n_y = 0
						//world << "reset x - [n_x]"
					n_x += 1
					if(owner.inv[sl] != null)
						xx = sl%6
						if(xx == 0 && sl > 0) xx = 6
						//world << "xx = [xx]"
						yy = ((sl-xx)+6)/6
						//world << "yy = [yy]"
						var/matrix/m = matrix()
						m.Translate((xx*32-21)+n_x,(288-yy*32)-n_y)
						owner.inv[sl].transform = m
						//src.inv[sl].vis_flags = VIS_INHERIT_PLANE | VIS_INHERIT_LAYER
						src.hud_inv.vis_contents -= inv[sl]
						src.hud_inv.vis_contents += inv[sl]
						if(owner != src && owner.hud_inv)
							owner.hud_inv.vis_contents -= inv[sl]
							owner.hud_inv.vis_contents += inv[sl]
						//world << "item = [inv[sl]]"
						var/obj/I = inv[sl]
						if(I.stack_display == null) inv[sl].create_stack_display()
						if(I.stack_exempt == 0)
							src.client.images += inv[sl].stack_display
							if(owner != src && owner.client) owner.client.images += inv[sl].stack_display
						if(owner != src)
							if(I == owner.item_selected && owner.hud_inv) owner.hud_inv.item_desc.maptext = "[css_outline]<font size = 1><text align=center valign=top>[I.name]<text align=left valign=top>\n\nRarity: [global.rarity_color[I.rarity]]\n\n[I.desc_extra][I.desc]"
							else src.hud_inv.item_desc.maptext = "[css_outline]<font size = 1><text align=center valign=top>[I.name]<text align=left valign=top>\n\nRarity: [global.rarity_color[I.rarity]]\n\n[I.desc_extra][I.desc]"
						else if(I == src.item_selected) src.hud_inv.item_desc.maptext = "[css_outline]<font size = 1><text align=center valign=top>[I.name]<text align=left valign=top>\n\nRarity: [global.rarity_color[I.rarity]]\n\n[I.desc_extra][I.desc]"
						/*
						inv.xx += 33
						N += 1
						if(N >= 6)
							N = 0
							inv.xx = 10
							inv.yy -= 33
						return
						*/
				/*
				if(src.client) winset(src,"inven.label_inven","text=\"[src.accessing]'s inventory\"")
				src << output(null,"inven.grid_inven")
				var/count = 0
				for(var/obj/O in src.accessing)
					if(istype(O,/obj/items/) == 1 || istype(O,/obj/body_related/bodyparts/cybernetics/) == 1) src << output(O,"inven.grid_inven:[++count]")
				if(src.client) winset(src, "inven.grid_inven", "cells=\"[count]\"")
				*/
		refresh_skills_tab(var/t)
			//Clear grid first
			winset(src, "skills.grid_skills", "cells=0")
			src << output(null,"skills.grid_skills")
			//Then continue
			winset(src,null,"skills.button_all.is-flat = false;skills.button_power.is-flat = false;skills.button_energy.is-flat = false;skills.button_strength.is-flat = false;skills.button_endurance.is-flat = false;skills.button_force.is-flat = false;skills.button_resistance.is-flat = false;skills.button_agility.is-flat = false;skills.button_offence.is-flat = false;skills.button_defence.is-flat = false;skills.button_regen.is-flat = false;skills.button_recovery.is-flat = false;skills.button_utility.is-flat = false;skills.button_buffs.is-flat = false")
			//winset(src,"skills.button_all","is-flat = false")
			//winset(src,"skills.button_power","is-flat = false")
			//winset(src,"skills.button_energy","is-flat = false")
			//winset(src,"skills.button_strength","is-flat = false")
			//winset(src,"skills.button_endurance","is-flat = false")
			//winset(src,"skills.button_force","is-flat = false")
			//winset(src,"skills.button_resistance","is-flat = false")
			//winset(src,"skills.button_agility","is-flat = false")
			//winset(src,"skills.button_offence","is-flat = false")
			//winset(src,"skills.button_defence","is-flat = false")
			//winset(src,"skills.button_regen","is-flat = false")
			//winset(src,"skills.button_recovery","is-flat = false")
			//winset(src,"skills.button_utility","is-flat = false")
			//winset(src,"skills.button_buffs","is-flat = false")
			var/count = 0
			if(t == "All")
				winset(src,"skills.button_all","is-flat = true")
				for(var/obj/skills/o in src)
					src << output(o,"skills.grid_skills:[++count]")
				for(var/obj/stances/o in src)
					src << output(o,"skills.grid_skills:[++count]")
			if(t == "Energy")
				winset(src,"skills.button_energy","is-flat = true")
				for(var/obj/skills/o in src)
					if(!o.category) o.category = list()
					if(o.category.Find("Energy"))
						src << output(o,"skills.grid_skills:[++count]")
			if(t == "Strength")
				winset(src,"skills.button_strength","is-flat = true")
				for(var/obj/skills/o in src)
					if(!o.category) o.category = list()
					if(o.category.Find("Strength"))
						src << output(o,"skills.grid_skills:[++count]")
			if(t == "Endurance")
				winset(src,"skills.button_endurance","is-flat = true")
				for(var/obj/skills/o in src)
					if(!o.category) o.category = list()
					if(o.category.Find("Endurance"))
						src << output(o,"skills.grid_skills:[++count]")
			if(t == "Force")
				winset(src,"skills.button_force","is-flat = true")
				for(var/obj/skills/o in src)
					if(!o.category) o.category = list()
					if(o.category.Find("Force"))
						src << output(o,"skills.grid_skills:[++count]")
			if(t == "resistance")
				winset(src,"skills.button_resistance","is-flat = true")
				for(var/obj/skills/o in src)
					if(!o.category) o.category = list()
					if(o.category.Find("resistance"))
						src << output(o,"skills.grid_skills:[++count]")
			if(t == "Offence")
				winset(src,"skills.button_offence","is-flat = true")
				for(var/obj/skills/o in src)
					if(!o.category) o.category = list()
					if(o.category.Find("Offence"))
						src << output(o,"skills.grid_skills:[++count]")
			if(t == "Defence")
				winset(src,"skills.button_defence","is-flat = true")
				for(var/obj/skills/o in src)
					if(!o.category) o.category = list()
					if(o.category.Find("Defence"))
						src << output(o,"skills.grid_skills:[++count]")
			if(t == "Regen")
				winset(src,"skills.button_regen","is-flat = true")
				for(var/obj/skills/o in src)
					if(!o.category) o.category = list()
					if(o.category.Find("Regeneration"))
						src << output(o,"skills.grid_skills:[++count]")
			if(t == "Recovery")
				winset(src,"skills.button_recovery","is-flat = true")
				for(var/obj/skills/o in src)
					if(!o.category) o.category = list()
					if(o.category.Find("Recovery"))
						src << output(o,"skills.grid_skills:[++count]")
			if(t == "Agility")
				winset(src,"skills.button_agility","is-flat = true")
				for(var/obj/skills/o in src)
					if(!o.category) o.category = list()
					if(o.category.Find("Agility"))
						src << output(o,"skills.grid_skills:[++count]")
			if(t == "Power")
				winset(src,"skills.button_power","is-flat = true")
				for(var/obj/skills/o in src)
					if(!o.category) o.category = list()
					if(o.category.Find("Power"))
						src << output(o,"skills.grid_skills:[++count]")
			if(t == "Buff")
				winset(src,"skills.button_buffs","is-flat = true")
				for(var/obj/skills/o in src)
					if(!o.category) o.category = list()
					if(o.category.Find("Buff"))
						src << output(o,"skills.grid_skills:[++count]")
			if(t == "Utility")
				winset(src,"skills.button_utility","is-flat = true")
				for(var/obj/skills/o in src)
					if(!o.category) o.category = list()
					if(o.category.Find("Utility"))
						src << output(o,"skills.grid_skills:[++count]")
			winset(src, "skills.grid_skills", "cells=\"[count]\"")
		disable_skills()
			for(var/obj/skills/s in src)
				if(s.active && s.act)
					call(s.act)(src,s)
		disable_stances(var/obj/st,var/all)
			if(all)
				for(var/obj/stances/s in src)
					if(s.active && s.act)
						call(s.act)(src,s)
			else
				for(var/obj/stances/s in src)
					if(s.active && s.act && s != st)
						call(s.act)(src,s)
		fps_display()
			var/obj/ticks = new
			ticks.maptext = "tick usage = [world.tick_usage]"
			ticks.maptext_height = 128
			ticks.maptext_width  = 128
			ticks.screen_loc = "1,1:500"
			src.client.screen += ticks
			var/obj/cpu = new
			cpu.maptext = "cpu usage = [world.cpu]"
			cpu.maptext_height = 128
			cpu.maptext_width  = 128
			cpu.screen_loc = "1,1:468"
			src.client.screen += cpu
			var/obj/fps = new
			fps.maptext = "fps = [client.fps]"
			fps.maptext_height = 128
			fps.maptext_width  = 128
			fps.screen_loc = "1,1:436"
			src.client.screen += fps
			while(1)
				ticks.maptext = "tick usage = [world.tick_usage]"
				cpu.maptext = "cpu usage = [world.cpu]"
				fps.maptext = "fps = [client.fps]"
				sleep(0.1)
		clear_minigame_tk()
			return
			/*
			src.minigame = null
			for(var/obj/skills/Ranged/Telekinesis/T in src)
				T.spin_speed = 4
				src.tk_multiplier = 1
				T.tk_pointer.spin_speed = 1
				T.tk_range.icon_state = "0"
				T.tk_pointer.bar_passes = 0
				for(var/obj/hud/h in T)
					src.client.screen -= h
					h.spin_speed = 0.7
				for(var/obj/I in src.tk_minigame)
					src.tk_minigame -= I
					I.pos = null
					I.tk = 0
					I.density_factor = initial(I.density_factor)
					animate(I, pixel_z = initial(I.pixel_z), time = 2, easing = BOUNCE_EASING)
					sleep(3)
					animate(I, pixel_x = initial(I.pixel_x),pixel_y = initial(I.pixel_y), time = 10)
					if(istype(I,/obj/items/tech/Battery))
						var/obj/items/tech/Battery/b = I
						b.check_power_lines("battery movement")
			*/
		create_map_box(var/params,var/obj/i)
			if(src.mouse_txt == null)
				var/obj/txt = new
				src.mouse_txt = txt
				txt.maptext_height = 64
				txt.maptext_width = 128
				txt.maptext_y = -53
				txt.maptext_x = -23
				txt.mouse_opacity = 0
				txt.appearance_flags = TILE_BOUND
				txt.layer = 50
				//txt.appearance_flags = KEEP_TOGETHER
				var/obj/o = new
				o.icon = 'mouse_box.dmi'
				o.pixel_y = -34
				o.pixel_x = 6
				o.layer = 49
				txt.underlays += o
				txt.filters = filter(type="outline", size=1, color=rgb(0,0,0))
				//txt.alpha = 225
			src.mouse_txt.maptext = "<text align=center valign=middle><font size = 1>[i.name]"
			src.mouse_txt.screen_loc = src.client.client_mouse_screen_loc
			src.client.screen += src.mouse_txt
		clear_states()
			//src.states -= "teleporting"
			//src.states -= "lifting"
		del_elec(var/time)
			spawn(time)
				if(src) src.overlays -= /obj/effects/elec


		/*
		create_research()
			var/list/tech_creation = typesof(/obj/items/tech/)
			tech_creation -= /obj/items/tech
			tech_creation -= /obj/items/tech/Ship
			tech_creation -= /obj/items/tech/Conveyor_Belt
			tech_creation -= /obj/items/tech/Resource_Cache
			tech_creation -= /obj/items/tech/Container_Tech
			tech_creation -= /obj/items/tech/Robot_Factory
			tech_creation -= /obj/items/tech/Silo
			tech_creation -= /obj/items/tech/world_tree
			tech_creation -= /obj/items/tech/sub_tech
			for(var/x in tech_creation)
				var/obj/items/tech/I = new x()
				src.technology += I
		*/
		output_msg(var/t)
			src << output("[t].", "chat.world")
			src << output("[t].", "chat.local")
			src << output("[t].", "chat.system")
		redraw_appearance()
			src.overlays = null
			if(src.hair) src.overlays += src.hair
			if(src.horns) src.overlays += src.horns
			if(src.halo) src.overlays += src.halo
			if(src.divine_elec) src.overlays += src.divine_elec
			if(src.skill_focus && src.skill_focus.active) src.overlays += /obj/effects/elec
			for(var/obj/items/i in src)
				if(i.suffix == "worn")
					var/matrix/m = i.transform
					i.transform = null
					src.overlays += i
					i.transform = m
				if(i.suffix == "equipped")
					if(src.skill_dig && src.skill_dig.active)
						if(i.type == /obj/items/tech/digging/Shovel) src.overlays += 'spade_dig.dmi'
						else if(i.type == /obj/items/tech/digging/Drill) src.overlays += 'drill_dig.dmi'

		drop(var/obj/i)
			if(src.accessing == null) src.accessing = src
			var/mob/x = src.accessing
			for(var/sl=1, sl<49, sl++)
				if(x.inv[sl] == i)
					x.inv[sl] = null
					i.slot = -1
					break
			if(i == x.eating) x.cancel_eat()
			i.transform = null
			i.vis_contents -= global.inv_slot
			i.loc = x.loc
			i.step_x = x.step_x
			i.step_y = x.step_y
			x.overlays -= i
			x.underlays -= i
			i.underlays = null
			i.layer = initial(i.layer)
			if(src.client)
				src.client.screen -= i
				src.client.images -= i.stack_display
				if(src.hud_inv) src.hud_inv.vis_contents -= i
				if(i == src.item_selected)
					src.item_selected = null
					src.hud_inv.item_desc.maptext = null
				if(i == src.mouse_down) src.mouse_down = null
				if(i == src.mouse_over) src.mouse_over = null
				src.refresh_inv()
			if(x.client && x != src)
				x.client.screen -= i
				x.client.images -= i.stack_display
				if(x.hud_inv) x.hud_inv.vis_contents -= i
				if(i == x.item_selected)
					x.item_selected = null
					x.hud_inv.item_desc.maptext = null
				if(i == x.mouse_down) x.mouse_down = null
				if(i == x.mouse_over) x.mouse_over = null
				x.refresh_inv()
			i.overlays -= /obj/effects/select_item
			i.set_shadow()
			if(i.floor_state) i.icon_state = i.floor_state
		pickup(var/obj/i,var/radius = 1)
			if(i in range(radius,src))
				if(i.bolted == 0 && i.can_pocket && i.grabbed_by == null)
					var/found_stack = 0
					var/overflow = 0
					//If this item stacks, search for another stack of the same item and fuse them
					if(i.stacks > -1)
						if(i.stack_display == null) i.create_stack_display()
						for(var/sl=1, sl<49, sl++)
							if(src.inv[sl] != null)
								if(src.inv[sl] != i && src.inv[sl].type == i.type && src.inv[sl].stacks > -1 && src.inv[sl].stacks < 98 && i.tech_lvl == src.inv[sl].tech_lvl)
									if(src.inv[sl].stack_display == null) src.inv[sl].create_stack_display()
									var/total = (i.stacks + src.inv[sl].stacks)
									if(total > 99)
										overflow = total-99
										i.stacks = overflow
										total = 99
										src.inv[sl].stacks = total
										i.stack_display.maptext = "[css_outline]<font size = 1><text align=right valign=bottom>[i.stacks]"
										src.inv[sl].stack_display.maptext = "[css_outline]<font size = 1><text align=right valign=bottom>[src.inv[sl].stacks]"
									else
										src.inv[sl].stacks = total
										src.inv[sl].stack_display.maptext = "[css_outline]<font size = 1><text align=right valign=bottom>[src.inv[sl].stacks]"
										found_stack = 1
									break
					//If it doesn't stack, or we can't kind an existing stack, simply add it into the inventory as normal.
					if(found_stack == 0)
						//Find empty slot for this item to go into
						var/found_slot = 0
						for(var/sl=1, sl<49, sl++)
							if(src.inv[sl] == null)
								src.inv[sl] = i
								i.slot = sl
								i.vis_contents += global.inv_slot
								found_slot = sl
								break
						if(found_slot)
							i.loc = src
							animate(i)
							i.pixel_y = initial(i.pixel_y)
							if(i.shadow) i.shadow.loc = null
							if(i.inven_state) i.icon_state = i.inven_state
							i.overlays -= /obj/effects/select_item
							src.mouse_down = null
							src.mouse_over = null
							if(src.client) src.refresh_inv()
							return
						else
							src.set_alert("Inventory full",'alert.dmi',"alert")
							src.create_chat_entry("alerts","Inventory full.")
							return
					else
						i.destroy()
						return
		drop_tk()
			if(src) if(src.tk)
				if(ismovable(src.tk))
					var/atom/movable/A = src.tk
					A.filters -= filter(type="drop_shadow", x=0, y=0, size=5, offset=0, color=rgb(102,0,204))
					A.tk = 0
					animate(A, pixel_z = initial(A.pixel_z), time = 2, easing = BOUNCE_EASING)
					spawn(2)
						if(A)
							var/obj/effects/dust_medium/d = new
							d.SetCenter(A)
					A.layer = initial(A.layer)
					A.density_factor = initial(A.density_factor)
					A.mouse_opacity = initial(A.mouse_opacity)
					if(src.client) src.force_sources -= "Telekinesis"
					src.tk = null
					//A.recycle()
					A.set_shadow()
		letgo()
			//src.clear_minigame_lift()
			if(src.grab)
				if(src.client)
					src.strength_sources -= "Lifting"
					src.power_sources -= "Lifting"
				src.held = 0
				var/atom/movable/a = src.grab
				//world << output("Debug - Dropped [a]", "chat.system")
				//var/icon/I = new(a.icon,a.icon_state,a.dir)
				animate(a, pixel_z = initial(a.pixel_z),pixel_x = initial(a.pixel_x),pixel_y = initial(a.pixel_y), time = 2,easing = BOUNCE_EASING,flags = ANIMATION_PARALLEL)
				if(a.shadow) animate(a.shadow, pixel_z = initial(a.shadow.pixel_z),pixel_x = initial(a.pixel_x),pixel_y = a.pixel_y-2, time = 2,easing = BOUNCE_EASING,flags = ANIMATION_PARALLEL)
				//del(I)
				a.layer = MOB_LAYER + a.laymod - (a.y + a.step_y / 32) / world.maxy
				a.density_factor = initial(a.density_factor)
				if(ismob(src.grab))
					var/mob/m = src.grab
					m.icon_state = m.state()
				src.grab = null
				src.grab_part = null
				src.wrestle_stage = null
				src.lift_multiplier = 0
				a.grabbed_by = null
				//a.recycle()
				src.icon_state = src.state()
				var/turf/t = a.loc
				if(t.liquid) a.submerge(1,5,t)
				for(var/turf/trf in a.locs)
					for(var/obj/items/tech/Power_Line/p in trf)
						p.reconnect_power()
						return
		show_ui()
			for(var/obj/hud/h in src.hud_main)
				if(src.client) src.client.screen += h
			for(var/obj/hud/h in src.hud_skillbar)
				if(src.client) src.client.screen += h

			winshow(src,"chat",1)

			//winset(src,null,"main.bar_energy.is-visible=true;main.bar_health.is-visible=true;main.power_percent.is-visible=true;main.pp.is-visible=true;main.percent_hp.is-visible=true;main.percent_eng.is-visible=true;main.label_background_percents.is-visible=true")

			//winset(src,"main.map_main","focus=true")

			//winset(src,"percents.bar_health","bar-color=#FF0000")

			if(src.vision) src.client.screen += src.vision
		reset_ui_proc()
			//winshow(src,"resolution",1)
			//winset(src,"resolution","size=1920x1080")
			//src.scrwidth = getWinX("resolution")
			//src.scrheight = getWinY("resolution")
			winset(src,"main","pos=0,0")
			//winshow(src,"resolution",0)
			/*
			winset(src,"inven","size=[src.og_player_inven]")
			winset(src,"help","size=[src.og_player_help]")
			winset(src,"percents","size=[src.og_player_percents]")
			winset(src,"skills","size=[src.og_player_skills]")
			winset(src,"tech_panes","size=[src.og_player_tech]")
			winset(src,"settings","size=[src.og_player_settings]")
			winset(src,"build_open","size=[src.og_player_build]")
			winset(src,"stats","size=[src.og_player_stats]")
			winset(src,"sense","size=[src.og_player_sense]")
			winset(src,"chat","size=[src.og_player_chat]")
			*/
			//winset(src,"chat","pos=[scrwidth/1.25],[scrheight/1.25]")
			//winset(src,"sense","pos=0,[scrheight-10]")
			//winset(src,"settings_main.bar_ui_scale","value=100")
		build_menu()
			if(src.build == "floors")
				src << output(null,"build_open.grid_build")
				var/count = 0
				for(var/obj/buildings/floors/O in floors)
					src << output(O,"build_open.grid_build:[++count]")
				if(demolish) src << output(demolish,"build_open.grid_build:[++count]")
				winset(src, "build_open.grid_build", "cells=\"[count]\"")
				//winshow(src,"build_open.grid_build",1)
			if(src.build == "walls")
				src << output(null,"build_open.grid_build")
				var/count = 0
				for(var/obj/buildings/walls/O in walls)
					src << output(O,"build_open.grid_build:[++count]")
				if(demolish) src << output(demolish,"build_open.grid_build:[++count]")
				winset(src, "build_open.grid_build", "cells=\"[count]\"")
				//winshow(src,"build_open.grid_build",1)
			if(src.build == "roofs")
				src << output(null,"build_open.grid_build")
				var/count = 0
				for(var/obj/buildings/roofs/O in roofs)
					src << output(O,"build_open.grid_build:[++count]")
				if(demolish) src << output(demolish,"build_open.grid_build:[++count]")
				winset(src, "build_open.grid_build", "cells=\"[count]\"")
				//winshow(src,"build_open.grid_build",1)
		display_gain(var/stat)
			var/obj/I = new
			I.icon = 'stats.dmi'
			I.loc = src.loc
			I.icon_state = "[stat]"
			I.layer = 33
			I.pixel_x = src.stat_pixel
			I.pixel_y = rand(16,32)
			I.display_gain_reset()
		/*
		learn()
			for(var/mob/teacher in range(6,src))
				if(teacher != src)
					var/Chance = 0.02
					for(var/obj/skills/s in teacher)
						if(s.active)
							if(prob((src.energy_max*Chance)/s.difficulty)&&!locate(s) in src)
								new s.type(src)
		*/
		update_mods(var/list/mods)
			for(var/obj/o in src.hud_stats)
				for(var/txt in mods)
					if(txt == "Energy")
						if(o.name == "Energy bar") o.icon_state = "[round(energy_exp,10)]"
						if(o.name == "Energy lvl") o.maptext = "<font size = 1>[css_outline][round(src.energy)] ([round(src.mod_energy,0.1)])"
					if(txt == "Strength")
						if(o.name == "Strength bar") o.icon_state = "[round(strength_exp,10)]"
						if(o.name == "Strength lvl") o.maptext = "<font size = 1>[css_outline][round(src.strength)] ([round(src.mod_strength,0.1)])"
					if(txt == "Endurance")
						if(o.name == "Endurance bar") o.icon_state = "[round(endurance_exp,10)]"
						if(o.name == "Endurance lvl") o.maptext = "<font size = 1>[css_outline][round(src.endurance)] ([round(src.mod_endurance,0.1)])"
					if(txt == "force")
						if(o.name == "force bar") o.icon_state = "[round(force_exp,10)]"
						if(o.name == "force lvl") o.maptext = "<font size = 1>[css_outline][round(src.force)] ([round(src.mod_force,0.1)])"
					if(txt == "resistance")
						if(o.name == "resistance bar") o.icon_state = "[round(resistance_exp,10)]"
						if(o.name == "resistance lvl") o.maptext = "<font size = 1>[css_outline][round(src.resistance)] ([round(src.mod_resistance,0.1)])"
					if(txt == "offence")
						if(o.name == "offence bar") o.icon_state = "[round(offence_exp,10)]"
						if(o.name == "offence lvl") o.maptext = "<font size = 1>[css_outline][round(src.offence)] ([round(src.mod_offence,0.1)])"
					if(txt == "defence")
						if(o.name == "defence bar") o.icon_state = "[round(defence_exp,10)]"
						if(o.name == "defence lvl") o.maptext = "<font size = 1>[css_outline][round(src.defence)] ([round(src.mod_defence,0.1)])"
					if(txt == "Recovery")
						if(o.name == "Recovery lvl") o.maptext = "<font size = 1>[css_outline][round(src.mod_recovery,0.1)]"
					if(txt == "Regeneration")
						if(o.name == "Regeneration lvl") o.maptext = "<font size = 1>[css_outline][round(src.mod_regeneration,0.1)]"
					if(txt == "Agility")
						if(o.name == "Agility lvl") o.maptext = "<font size = 1>[css_outline][round(src.mod_agility,0.1)]"

			/*
			var/combat = (src.strength_base/src.mod_strength)+(src.endurance_base/src.mod_endurance)+(src.resistance_base/src.mod_resistance)+(src.force_base/src.mod_force)+(src.offence_base/src.mod_offence)+(src.defence_base/src.mod_defence)
			var/combat_lvl = combat/10 // 600 stats total = lvl 60
			combat_lvl = round(combat_lvl)
			if(combat_lvl <= 0)
				combat_lvl = 1

			//var/combat = src.strength_base+src.endurance_base+src.resistance_base+src.force_base+src.offence_base+src.defence_base
			var/combat_real = combat/10
			combat = round(combat/10)
			src.combat_lvl = combat
			src.combat_exp = combat_real - src.combat_lvl
			src.combat_exp = round(abs(src.combat_exp),0.1)
			src.combat_exp_max = round(1 - src.combat_exp,0.1)
			if(src.combat_lvl <= 1)
				src.combat_lvl = 1
			*/


		set_announce(var/N,var/I,var/IS,var/msg)
			if(src.started)
				if(src.client)
					var/obj/help_topics/H = src.tutorials[10]
					H.name = N
					H.icon = I
					H.icon_state = IS
					H.help_text = msg
					H.skill_up(src)
		set_alert(var/N,var/I,var/IS)
			if(src.started)
				if(src.client)
					var/obj/help_topics/H = src.tutorials[10]
					H.name = N
					H.icon = I
					H.icon_state = IS
					H.skill_up(src)
		set_decline()
			if(src.lifespan > 0)
				src.oldage = round(src.lifespan / 1.3)
			else if(src.has_body == 0) src.Death("Old Age",1)
			if(src.hair)
				src.grey_hair = 100-(((src.oldage+10)-src.age)*10)
				src.grey_hair = clamp(src.grey_hair,0,100)
				src.overlays -= src.hair
				src.hair.icon = src.hair_icon
				src.hair.icon += rgb(src.grey_hair,src.grey_hair,src.grey_hair)
				src.redraw_appearance()
		name_txt()
			var/image/txt = image(null,src,null,100)
			txt.maptext_x = -64
			txt.maptext_y = -14
			txt.maptext_width = 160
			txt.maptext_height = 64
			txt.appearance_flags = KEEP_APART | RESET_COLOR | NO_CLIENT_COLOR | RESET_TRANSFORM
			txt.maptext = "[css_outline]<font size = 1><center>[src.name]"
			//txt.filters += filter(type="outline", size=1, color=rgb(0,0,0))
			txt.pixel_x -= src.pixel_x
			txt.pixel_y -= src.pixel_y
			/*
			var/len = length(src.name)
			var/len_x = 22
			while(len)
				len_x -= 2
				len -= 1
			txt.maptext_x = len_x
			*/
			src.name_txt = txt
		trait_proc_fervent_fury(var/act = 0)
			if(act)
				src.mod_strength*=1.2
				src.mod_endurance*=1.2
				src.mod_resistance*=1.2
				src.mod_force*=1.2
				src.mod_offence*=1.2
				src.mod_defence*=1.2
				src.mod_agility*=1.2
				src.mod_regeneration*=1.2
			else
				src.mod_strength/=1.2
				src.mod_endurance/=1.2
				src.mod_resistance/=1.2
				src.mod_force/=1.2
				src.mod_offence/=1.2
				src.mod_defence/=1.2
				src.mod_agility/=1.2
				src.mod_regeneration/=1.2
		update_weight()
			var/w_current = 0
			for(var/obj/items/tech/weights/wgt in src)
				if(wgt.suffix) w_current += wgt.weight
			src.weight = (w_current/(src.strength+src.endurance))
			if(src.weight < 1) src.weight = 1
			//world << "DEBUG - Player weight multi is [src.weight]"
		set_weather_imgs()
			for(var/image/I in sandstorm_imgs)
				src.client.images += I
			for(var/image/I in snowstorm_imgs)
				src.client.images += I
			for(var/image/I in rainstorm_imgs)
				src.client.images += I
		check_mouse_loc(params)
			var/s = params2list(params)["screen-loc"]
			if(ScreenLocParser.Find(s))
				var tile_x = text2num(ScreenLocParser.group[2])
				var step_x = text2num(ScreenLocParser.group[3])
				var tile_y = text2num(ScreenLocParser.group[4])
				var step_y = text2num(ScreenLocParser.group[5])
				if(tile_x) src.mouse_x = tile_x
				if(tile_y) src.mouse_y = tile_y
				if(step_x) src.mouse_pix_x = step_x
				if(step_y) src.mouse_pix_y = step_y
				src.mouse_screen_loc = "[tile_x]:[step_x],[tile_y]:[step_y]"
				//world << "Test mouse = [src.mouse_screen_loc]"
		create_info_tooltips()
			var/image/o = new
			o.maptext_width = 160
			o.maptext_height = 160
			o.appearance_flags = KEEP_APART | RESET_COLOR | NO_CLIENT_COLOR | RESET_TRANSFORM
			o.maptext = "<font size = 1>"
			o.filters += filter(type="outline", size=1, color=rgb(0,0,0))
			o.layer = 30
			o.plane = 12
			o.pixel_x = 33
			src.mouse_over_tooltip = o


			var/image/v = new
			v.icon = 'mouse_over_visual.dmi'
			v.layer = 30
			v.plane = 12
			src.mouse_over_visual = v
		show_info_tech(var/obj/o)
			if(src.mouse_over_tooltip == null)
				src.create_info_tooltips()
			if(src.client) src.client.images += src.mouse_over_tooltip
			var/build = "???"
			var/health = "???"
			var/lvl = "???"
			if(src.hp < src.hp_max/4) health = "Falling apart"
			else if(src.hp < src.hp_max/3) health = "Badly damaged"
			else if(src.hp < src.hp_max/2) health = "Damaged"
			else if(src.hp < src.hp_max) health = "Slightly damaged"
			else health = "Fine"
			if(src.seen_build == null) src.seen_build = list()
			if(o.owner == src.real_name)
				build = "[src.real_name]"
				lvl = "[o.level]"
			else if(o.owner in src.seen_build) build = "[src.real_name]"
			if(o.owner == null) build = "none"
			src.mouse_over_tooltip.pixel_y = -19
			src.mouse_over_tooltip.loc = o.loc
			src.mouse_over_visual.loc = null
			src.mouse_over_tooltip.maptext = "<font size = 1><u>Tech Info</u>\nName: [o.name]\nLevel: [lvl]\nHealth: [health]\nBuilder: [build]"
			//world << "DEBUG - updated tooltip - lvl = [o.tech_lvl]"
		show_info(var/turf/x)
			if(x)
				var/area/t = null
				for(var/area/a in world)
					if(x in a.contents)
						t = a
				if(t)
					if(src.mouse_over_tooltip == null)
						src.create_info_tooltips()
					if(src.client)
						src.client.images += src.mouse_over_tooltip
						src.client.images += src.mouse_over_visual
					if(t.level)
						var/pow = 0
						if(t.bats_list)
							for(var/obj/o in t.bats_list)
								pow += o.capacity
						var/build = "???"
						var/health = "???"
						if(t.hp < t.hp_max/4) health = "Falling apart"
						else if(t.hp < t.hp_max/3) health = "Badly damaged"
						else if(t.hp < t.hp_max/2) health = "Damaged"
						else if(t.hp < t.hp_max) health = "Slightly damaged"
						else health = "Fine"
						var/lvl = "???"
						if(src.tech_pos_se > 0)
							if(src.tech_lvls[src.tech_pos_se] >= t.level) lvl = "[t.level]"
						if(src.seen_build == null) src.seen_build = list()
						if(x.builder in src.seen_build) build = "[src.real_name]"
						else if(x.builder == src.real_name) build = "[src.real_name]"
						if(x.builder == null) build = "none"

						//Power Gain
						var/c_gain = "<font color = white>"
						if(t.excess_grid < 0) c_gain = "<font color = red>"
						else if(t.excess_grid > 0) c_gain = "<font color = green>"

						//Power Drain
						var/c_drain
						//If there is a power drain, but there is NO battery with power inside it: red.
						if(t.used_grid > t.excess_grid && pow <= 0) c_drain = "<font color = red>"
						//If there is a power drain, but there is a battery with power inside it: yellow.
						else if(t.used_grid > t.excess_grid && pow > 0) c_drain = "<font color = yellow>"
						//No drain and no power
						else if(t.used_grid == 0) c_drain = "<font color = white>"
						//No power drain: green
						else if(t.currents_grid > t.used_grid) c_drain = "<font color = green>"

						//Power Total
						var/c_total = "<font color = white>"
						if(t.currents_grid == 0 && t.excess_grid < 0) c_total = "<font color = red>"
						else if(t.currents_grid > 0) c_total = "<font color = green>"

						//Power Stored
						var/c_stored = "<font color = white>"
						if(t.excess_grid < 0 && pow <= 0) c_stored = "<font color = red>"
						else if(t.excess_grid < 0 && pow > 0) c_stored = "<font color = yellow>"
						else if(pow > 0) c_stored = "<font color = green>"

						var/powered = ""
						if(t.layer == 2.1)//if(t.power_grid || t.layer == 2.1)
							powered = "\n<u>Power Line</u>\nPower Gain: [c_gain][Commas(t.excess_grid)]</font>\nPower Drain: [c_drain][Commas(t.used_grid)]</font>\nPower Stored: [c_stored][Commas(pow)]</font>\nPower Total: [c_total][Commas(t.currents_grid)]</font>"
							src.mouse_over_tooltip.pixel_y = -84
						else
							src.mouse_over_tooltip.pixel_y = -19


						src.mouse_over_tooltip.loc = x
						src.mouse_over_visual.loc = x
						src.mouse_over_tooltip.maptext = "<font size = 1><u>Tile Info</u>\nLevel: [lvl]\nHealth: [health]\nBuilder: [build][powered]"
		build(var/obj/o,var/obj/i)
			if(i == null) return
			else
				var/turf/t = i.loc
				if(t && isturf(t))
					if(t.liquid)
						src.set_alert("Must build on solid foundation",'alert.dmi',"alert")
						src.create_chat_entry("alerts","Must build on solid foundation.")
						return
					if(o == demolish)
						if(t.builder == src.real_name)
							if(t.og_type) new t.og_type(t)
							turfs[1][t.z] -= t
							var/obj/effects/dust_medium/d = new
							d.SetCenter(t)
							t.create_worldmap_building()
							t.og_type = null
						else
							//src.set_alert("Tile must belong to you",'alert.dmi',"alert")
							src << "Tile must belong to you."
					else if(o.icon_state != "demolish")
						var/obj/item = new o.type(i.loc)
						item.alpha = 100
						item.pixel_z = 32
						animate(item, pixel_z = initial(item.pixel_z), alpha = 255,time = 2, easing = BOUNCE_EASING)
						sleep(1)
						var/obj/effects/dust_medium/d = new
						d.SetCenter(item)
						sleep(6)
						//item.loc = null
						item.destroy()
						if(o.build)
							var/og_t = t.type
							new o.build(t)
							turfs[1][t.z] += t
							t.builder = src.real_name
							t.builder_key = src.key
							t.og_type = og_t
							//Dynamically change the worldmap to mirror the changes made when building.
							t.create_worldmap_building()
							//Update the info for anyone near, so they know who built what.
							for(var/mob/m in view(16,src))
								if(m.seen_build == null) m.seen_build = list()
								if(m.seen_build.Find(src.real_name) == 0) m.seen_build += src.real_name
							//Remove any plants when building.
							for(var/obj/items/plants/p in range(1,t))
								p.destroy()
								t.overlays = null
		build_tech(var/obj/o,var/obj/i)
			if(i == null) return
			var/turf/t = i.loc
			if(t && isturf(t))
				if(t.liquid)
					if(src.build_tech)
						if(src.build_tech.tech_water == 0)
							src.set_alert("Must build on solid foundation",'alert.dmi',"alert")
							src.create_chat_entry("alerts","Must build on solid foundation.")
							return
			var/lvl = 1
			var/val_multi = 1
			if(src.hud_tech)
				var/obj/hud/menus/tech_background/s = src.hud_tech
				val_multi = s.num_to_make
				lvl = s.lvl_to_make
			var/val = o.value*val_multi
			if(src.trait_ic) val/=2
			var/afford = 0
			if(src.resources >= val)
				afford = 1
				src.resources -= val
				src.update_rsc()
			if(afford)
				var/obj/item = new o.type(i.loc)
				item.weight = o.weight
				item.owner = src.real_name
				if(istype(item,/obj/items/tech/Power_Line))
					var/obj/items/tech/Power_Line/pl = item
					pl.built = 1
				//item.loc = i.loc
				if(item.pixel_x > 0) item.step_x = abs(item.pixel_x)/2
				if(src.build_tech.type == /obj/items/tech/Conveyor_Belt)
					item.dir = src.dir
				if(istype(item,/obj/items/drugs/) == 1)
					for(var/obj/items/tech/sub_tech/Genetics/Drug_Synthesis/DS in global.tech)//src.technology_researched)
						item.tech_lvl = src.tech_lvls[DS.list_pos]//DS.tech_lvl
						break
				if(istype(item,/obj/items/tech/doors/) == 1)
					item.icon = o.icon
					if(winget(src,"confirm","is-visible") == "false")
						winset(src,"numbers.label_numbers","text=\"Set door password.\"")
						winshow(src,"numbers",1)
						src.numbers_text = "set door password"
						src.left_click_ref = item
				item.alpha = 100
				item.pixel_z = 32
				item.level = lvl
				animate(item, pixel_z = initial(item.pixel_z), alpha = 255,time = 2, easing = BOUNCE_EASING)
				spawn(1)
					if(item) item.set_shadow()
				for(var/obj/x in item.loc)
					if(x != item)
						if(istype(x,/obj/items/tech/Power_Line) && istype(src.build_tech,/obj/items/tech/Power_Line))
							src << "There is already a powerline there."
							del(item)
							return
				items += item
				src.client.images -= src.build_mouse
				sleep(1)
				var/obj/effects/dust_medium/d = new
				d.SetCenter(item)
				sleep(1)
				if(src.build_mouse) src.client.images += src.build_mouse
				/*
				var/image/txt = image(null,src,null,1000)
				txt.maptext_x = 14
				txt.maptext_y = 50
				txt.maptext_width = 128
				txt.filters += filter(type="outline", size=1, color=rgb(0,0,0))
				var/total_val = 0
				for(var/obj/items/resources/r in src)
					txt.maptext = "[Commas(r.value)]<font color = red> - [Commas(val)]"
					total_val = r.value
				src.overlays += txt
				var/tens = 0
				var/target = total_val-o.value
				while(total_val != target)
					total_val -= 1
					tens += 1
					if(tens == 100)
						tens = 0
						src.overlays -= txt
						txt.maptext = "[Commas(total_val)]<font color = red> - [Commas(val)]"
						src.overlays += txt
						sleep(0.1)
				src.overlays -= txt
				txt.maptext = "[Commas(total_val)]"
				src.overlays += txt
				spawn(15)
					if(src && txt)
						src.overlays -= txt
						del(txt)
				*/
			else
				src << "Not enough resources.<br>"
				src.set_alert("Not enough resources",'alert.dmi',"alert")
				src.create_chat_entry("alerts","Not enough resources.")
		reset_estimates()
			if(src.started)
				winset(src,null,"sense.label_img.image=;sense.bar_hp.value=100;sense.bar_eng.value=100;sense.lab_psi.text=\"???\";sense.lab_name.text=;sense.lab_str.text=\"???\";sense.lab_end.text=\"???\";sense.lab_agility.text=\"???\";sense.lab_acc.text=\"???\";sense.lab_def.text=\"???\";sense.lab_force.text=\"???\";sense.lab_recov.text=\"???\";sense.lab_res.text=\"???\";sense.lab_regen.text=\"???\"")


		StopSounds()
			//Stops all MIDI and sound effects played for this mob.
			if(!src.key || !src.client) return

			src << sound(null)
		update_rsc()
			if(src.hud_inv) src.hud_inv.update_rsc(src)
			if(src.hud_tech) src.hud_tech.update_rsc(src)
		estimates()
			if(src.started)
				if(src.skill_sense && src.skill_sense.active)
					var/mob/m = src.target

					/*
					if(src.client)
						src << output(null,"sense.grid_sense")
						src << output(m,"sense.grid_sense:1,1")
						var/est_m = round((m.psionic_power/src.psionic_power)*100)
						est_m = "[est_m]%"
						for(var/obj/items/tech/Scanner/s in src)
							if(s.suffix)
								var/max_pp = s.level*1000
								if(m.psionic_power > max_pp) est_m = "???"
								else est_m = "[Commas(m.psionic_power)]"
								break
						//winset(src,"sense.bar_psi","value=[round(est_src/2)]")
						if(src.client) winset(src,"sense.lab_psi","text=\"[est_m]\"")

						if(src.client) winset(src,"sense.lab_name","text=\"[m.name]\"")
					*/

					var/see_stat = 0
					var/e_strength = "???"
					var/e_endurance = "???"
					var/e_agility = "???"
					var/e_offence = "???"
					var/e_defence = "???"
					var/e_force = "???"
					var/e_regen = "???"
					var/e_res = "???"
					var/e_recov = "???"

					if(src.trait_ta) see_stat = 10

					//Estimate strength
					if(m.id in src.remembers_strength) see_stat += 1
					if(see_stat)
						//var/e_src = round((src.strength/m.strength)*100)
						e_strength = round((m.strength/src.strength)*100)
						//winset(src,"sense.bar_str","value=[round(e_src/2)]")
						//winset(src,"sense.lab_str","text=\"[e_m]%\"")
						see_stat -= 1
					//else winset(src,"sense.lab_str","text=\"???\"")

					//Estimate endurance
					if(m.id in src.remembers_endurance) see_stat += 1
					if(see_stat)
						//var/e_src = round((src.endurance/m.endurance)*100)
						e_endurance = round((m.endurance/src.endurance)*100)
						//winset(src,"sense.bar_end","value=[round(e_src/2)]")
						//winset(src,"sense.lab_end","text=\"[e_m]%\"")
						see_stat -= 1
					//else winset(src,"sense.lab_end","text=\"???\"")

					//Estimate agility
					if(m.id in src.remembers_agility) see_stat += 1
					if(see_stat)
						//var/e_src = round((src.mod_agility/m.mod_agility)*100)
						e_agility = round((m.mod_agility/src.mod_agility)*100)
						//winset(src,"sense.bar_str","value=[round(e_src/2)]")
						//winset(src,"sense.lab_agility","text=\"[e_m]%\"")
						see_stat -= 1
					//else winset(src,"sense.lab_agility","text=\"???\"")

					//Estimate offence
					if(m.id in src.remembers_offence) see_stat += 1
					if(see_stat)
						//var/e_src = round((src.offence/m.offence)*100)
						e_offence = round((m.offence/src.offence)*100)
						//winset(src,"sense.bar_off","value=[round(e_src/2)]")
						//winset(src,"sense.lab_acc","text=\"[e_m]%\"")
						see_stat -= 1
					//else winset(src,"sense.lab_acc","text=\"???\"")

					//Estimate defence
					if(m.id in src.remembers_defence) see_stat += 1
					if(see_stat)
						//var/e_src = round((src.defence/m.defence)*100)
						e_defence = round((m.defence/src.defence)*100)
						//winset(src,"sense.bar_def","value=[round(e_src/2)]")
						//winset(src,"sense.lab_def","text=\"[e_m]%\"")
						see_stat -= 1
					//else winset(src,"sense.lab_def","text=\"???\"")

					//Estimate force
					if(m.id in src.remembers_force) see_stat += 1
					if(see_stat)
						//var/e_src = round((src.force/m.force)*100)
						e_force = round((m.force/src.force)*100)
						//winset(src,"sense.bar_force","value=[round(e_src/2)]")
						//winset(src,"sense.lab_force","text=\"[e_m]%\"")
						see_stat -= 1
					//else winset(src,"sense.lab_force","text=\"???\"")

					//Estimate recovery
					if(m.id in src.remembers_recovery) see_stat += 1
					if(see_stat)
						//var/e_src = round((src.mod_recovery/m.mod_recovery)*100)
						e_recov = round((m.mod_recovery/src.mod_recovery)*100)
						//winset(src,"sense.bar_recov","value=[round(e_src/2)]")
						//winset(src,"sense.lab_recov","text=\"[e_m]%\"")
						see_stat -= 1
					//else winset(src,"sense.lab_recov","text=\"???\"")

					//Estimate resistance
					if(m.id in src.remembers_resistance) see_stat += 1
					if(see_stat)
						//var/e_src = round((src.resistance/m.resistance)*100)
						e_res = round((m.resistance/src.resistance)*100)
						//winset(src,"sense.bar_res","value=[round(e_src/2)]")
						//winset(src,"sense.lab_res","text=\"[e_m]%\"")
						see_stat -= 1
					//else winset(src,"sense.lab_res","text=\"???\"")

					//Estimate regen
					if(m.id in src.remembers_regeneration) see_stat += 1
					if(see_stat)
						//var/e_src = round((src.mod_regeneration/m.mod_regeneration)*100)
						e_regen = round((m.mod_regeneration/src.mod_regeneration)*100)
						//winset(src,"sense.bar_regen","value=[round(e_src/2)]")
						//winset(src,"sense.lab_regen","text=\"[e_m]%\"")
						see_stat -= 1
					//else winset(src,"sense.lab_regen","text=\"???\"")

					for(var/obj/hud/menus/sense_box_advanced/a in src.sense_boxes)
						for(var/obj/o in a)
							o.maptext = "<font size = 1>Offence: [e_offence]%\nDefence: [e_defence]%\nStrength:[e_strength]%\nEndurance: [e_endurance]%\nForce: [e_force]%\nResistance: [e_res]%\nAgility: [e_agility]%\nRegeneration: [e_regen]%\nRecovery: [e_recov]%"
							break