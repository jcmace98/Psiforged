obj
	skills
		icon = 'skills.dmi'
		icon_state = "origin"
		skill_lvl = 1
		layer = 34//27
		plane = 33
		box_x_scale = 64
		box_y_scale = 16
		box_x_shift = 16
		box_y_shift = 4
		var
			list/category = null //The category this skill is in.
			obj/lvl_overlay
			overlay_pos
			displayed = 0
			disable_sleep = 0 //Makes sure this skills sleep procs, if any, are not ticking when part of a world.list
			attack_state = null
			last_used = null
			teach_energy = 0
			teach_cd = 0
			cd_current = 0
			cd_max = 0
			cd_text = null
			cd_state = 32
			image/cd_bar = null
			obj/cd_box = null
			cloned = null //When set to non-null, means this skill had its looks and act var copied to a AA_Skill_Copy, ready to be displayed in the skills menu.
			tmp/obj/clone_of = null //A ref pointer to the actual orginal skill. Set by AA_Skill_Copy objs only
			tmp/obj/clone = null //A ref pointer, from the orginal skill to its clone. Set by /obj/skills only
			/*
			.:For skill bar info:.
			0 = None
			1 = Low
			2 = Medium
			3 = High
			4 = Very High
			5 = Extreme
			*/

		New()
			var/image/over = image('unlocks_over.dmi',src,"over",100)
			over.pixel_x = -1
			over.pixel_y = -1
			src.img_over = over
		Click()
			usr.check_quest("tutorial_use_skill",1)
			if(src.loc == null && usr.hud_unlocks)
				usr.skill_selected = src
				var/obj/hud/menus/unlocks_background/bg = usr.hud_unlocks
				var/cats = ""
				var/stats = ""
				if(src.info_stats) stats = "\n\n[src.info_stats]"
				for(var/c in src.category)
					if(cats == "") cats = "[c]"
					else cats = "[cats], [c]"
				bg.info_txt.maptext = "[css_outline]<font size = 1><text align=left valign=top>Point Cost: [src.info_point_cost]\n\nCategories: [cats]\n\n[src.info_buffs][stats]\n\n[src.info]"

				var/icon/I = icon(src.icon,src.icon_state,SOUTH,1,0)
				I.Scale(64,64)
				bg.unlock_icon.icon = I
				var/matrix/m = matrix()
				m.Translate(464,280)
				bg.unlock_icon.hud_x = 464
				bg.unlock_icon.hud_y = 280
				bg.unlock_icon.transform = m

				if(isnum(src.info_dmg)) bg.bar_power.icon_state = "[src.info_dmg]"
				if(isnum(src.info_spd)) bg.bar_speed.icon_state = "[src.info_spd]"
				if(isnum(src.info_energy_cost)) bg.bar_energy.icon_state = "[src.info_energy_cost]"
				if(isnum(src.info_mastery)) bg.bar_mastery.icon_state = "[src.info_mastery]"
				if(isnum(src.info_cd)) bg.bar_cooldown.icon_state = "[src.info_cd]"

				bg.name_txt.maptext = "[css_outline]<font size = 1><center>[src.name]"
		MouseMove(location,control,params)
			usr.update_info_box(src,"[src.name]",params)

		MouseWheel(delta_x,delta_y,location,control,params)
			var/obj/hud/menus/skills_background/s = usr.hud_skills
			var/obj/sc = s.skills_scroller

			usr.check_mouse_loc(params)
			var/true_y = ((usr.mouse_y-1)*32)+usr.mouse_pix_y
			usr.mouse_y_true = true_y
			var/wheel_move = 0
			if(delta_y > 0) wheel_move = 16
			else if(delta_y < 0) wheel_move = -16
			var/result = sc.translated_y+wheel_move
			result = clamp(result,0,-218)

			var/matrix/m = matrix()
			m.Translate(0,result)
			sc.transform = m
			sc.translated_y = result
			var/ratio = -1 + ((-218 + result) / -218)
			ratio = clamp(ratio,0,1)
			var/scroll_y = round(200*ratio)

			for(var/obj/txt in s.skills_holder.vis_contents)
				var/matrix/m2 = matrix()
				m2.Translate(txt.hud_x,txt.hud_y+scroll_y)
				txt.transform = m2
		MouseEntered(object,location,control,params)
			usr.client.images += src.img_over
			//src.filters -= filter(type="outline",size=1,color = rgb(255,255,255))
			//src.filters += filter(type="outline",size=1,color = rgb(255,255,255))
			//if(src.img_select) usr.client.images += src.img_select

				//port.icon_state = src.icon_state
			usr.mouse_skill = src
			/*
			var/obj/s = usr.hud_skills
			s.txt.maptext = "<td valign = top><font size = 1>[css_outline]<b>[src.name]</b> - [src.help_text]</SPAN>"
			while(usr.mouse_skill == src)
				for(var/obj/bar in s)
					if(bar.icon == 'HUD_skill_exp.dmi') bar.icon_state = "[round(usr.mouse_skill.skill_exp,10)]"
					if(bar.name == "lvl") bar.maptext = "<font size = 1>[css_outline][src.skill_lvl]"
				sleep(1)
			*/
			if(usr.info_box1)
				var/L = usr.client.MeasureText("<font size = 1>[src.name]")
				var/x_pos = findtext(L, "x")
				L = text2num(copytext(L, 1, x_pos))
				src.box_x_scale = L + 6
				src.box_x_shift = 2 + round(src.box_x_scale/2)
				usr.client.screen += usr.info_box1
				usr.client.screen += usr.info_box2
				usr.client.screen += usr.info_box3
		MouseExited(location,control,params)
			usr.client.images -= src.img_over
			//src.filters -= filter(type="outline",size=1,color = rgb(255,255,255))
			//if(src.img_select) usr.client.images -= src.img_select
			usr.mouse_skill = null
			/*
			var/obj/s = usr.hud_skills
			s.txt.maptext = null
			for(var/obj/bar in s)
				if(bar.icon == 'HUD_skill_exp.dmi') bar.icon_state = "0"
				if(bar.name == "lvl") bar.maptext = "<font size = 1>0"
			*/
			if(usr.info_box1)
				usr.client.screen -= usr.info_box1
				usr.client.screen -= usr.info_box2
				usr.client.screen -= usr.info_box3
				usr.info_box3.maptext = null
		MouseDrag(over_object,src_location,over_location,src_control,over_control,params)
			if(src.loc != null)
				var/icon/i = new(src.icon,src.icon_state)
				usr.client.mouse_pointer_icon = i
		MouseDrop(over_object,src_location,over_location,src_control,over_control,params)
			if(src.loc != null)
				usr.client.mouse_pointer_icon = null
				//usr << output("Test drag and drop skill - [over_control],[over_object]", "chat.system")
				//if(findtext(over_control,"main"))
				var/obj/skills/skill = src
				var/dismiss = 0
				if(over_object && isobj(over_object))
					var/obj/h = over_object
					if(istype(h,/obj/hud/buttons/skillbar/) || istype(h,/obj/skills/)) usr.add_to_skillbar(skill,h)
					else dismiss = 1
				else dismiss = 1

				if(dismiss)
					if(src.type == /obj/skills/AA_Skill_Copy)
						for(var/obj/skills/s in usr)
							if(src.cloned == "[s.name] aa_clone_aa")
								skill = s
								break
					if(usr.one && length(usr.one) > 0 && usr.one[1] == skill)
						for(var/obj/hud/buttons/skillbar/skillbar_one/h in usr.hud_skillbar)
							h.overlays = null
						usr.one = null
						usr.client.screen -= skill
					if(usr.two && length(usr.two) > 0 && usr.two[1] == skill)
						for(var/obj/hud/buttons/skillbar/skillbar_two/h in usr.hud_skillbar)
							h.overlays = null
						usr.two = null
						usr.client.screen -= skill
					if(usr.three && length(usr.three) > 0 && usr.three[1] == skill)
						for(var/obj/hud/buttons/skillbar/skillbar_three/h in usr.hud_skillbar)
							h.overlays = null
						usr.three = null
						usr.client.screen -= skill
					if(usr.four && length(usr.four) > 0 && usr.four[1] == skill)
						for(var/obj/hud/buttons/skillbar/skillbar_four/h in usr.hud_skillbar)
							h.overlays = null
						usr.four = null
						usr.client.screen -= skill
					if(usr.five && length(usr.five) > 0 && usr.five[1] == skill)
						for(var/obj/hud/buttons/skillbar/skillbar_five/h in usr.hud_skillbar)
							h.overlays = null
						usr.five = null
						usr.client.screen -= skill
					if(usr.six && length(usr.six) > 0 && usr.six[1] == skill)
						for(var/obj/hud/buttons/skillbar/skillbar_six/h in usr.hud_skillbar)
							h.overlays = null
						usr.six = null
						usr.client.screen -= skill
					if(usr.seven && length(usr.seven) > 0 && usr.seven[1] == skill)
						for(var/obj/hud/buttons/skillbar/skillbar_seven/h in usr.hud_skillbar)
							h.overlays = null
						usr.seven = null
						usr.client.screen -= skill
					if(usr.eight && length(usr.eight) > 0 && usr.eight[1] == skill)
						for(var/obj/hud/buttons/skillbar/skillbar_eight/h in usr.hud_skillbar)
							h.overlays = null
						usr.eight = null
						usr.client.screen -= skill
					if(usr.nine && length(usr.nine) > 0 && usr.nine[1] == skill)
						for(var/obj/hud/buttons/skillbar/skillbar_nine/h in usr.hud_skillbar)
							h.overlays = null
						usr.nine = null
						usr.client.screen -= skill
					if(usr.zero && length(usr.zero) > 0 && usr.zero[1] == skill)
						for(var/obj/hud/buttons/skillbar/skillbar_zero/h in usr.hud_skillbar)
							h.overlays = null
						usr.zero = null
						usr.client.screen -= skill
		skill_overlay
			icon_state = "over"
		//Maybe make it display the skills dmg/buff calculations in the description of the skill.

		/*
		Wrestle system ideas

		Start by using grab on someone

		Make a skill that lets you lock body parts. Maybe not the head and possibly torso?

		Locking bodypart
		- Lock bodypart (Chooses a random one?)
		- Does a strength check to see if the opponent can resist
		- If successful, half usefullness from that part? Or at least disabled until let go? Think Freiza getting his hand grabed by ssj goku.

		Breaking/disabling bodypart
		- Second part of the wrestle skill, like in dwarf fortress
		- Does another strength check to see if the opponent can resist
		- If sucessful, completely disables that part.

		Maybe if really strong, or through a trait, have a third part.
		- Third part, limb is torn off.
		- Does another strength check to see if the opponent can resist
		- If sucessful, completely destroys that part.

		Once you finish doing the above once, player is automatically let go, for balance reasons?

		Destroyed bodyparts can only be replaced via special ways.
		*/



		AA_Skill_Copy
			Click()
				if(usr.skill_selected)
					var/obj/skills/s = usr.skill_selected
					if(s.img_select) usr.client.images -= s.img_select
				usr.skill_selected = src
				if(src.img_select) usr.client.images += src.img_select

				var/obj/hud/menus/skills_background/sk = usr.hud_skills
				sk.txt_raw.maptext = "[css_outline]<font size = 1><text align=left valign=top>[src.info]\n[src.info_stats]\n"
				var/icon/I = icon(src.icon,src.icon_state,SOUTH,1,0)
				I.Scale(64,64)
				sk.skills_portrait.icon = I
				var/matrix/m = matrix()
				m.Translate(317,204)
				sk.skills_portrait.hud_x = 317
				sk.skills_portrait.hud_y = 204
				sk.skills_portrait.transform = m

				usr.update_skill_exp()

				sk.skills_name.maptext = "[css_outline]<font size = 1><center>[src.name]"
				if(isnum(src.info_dmg)) sk.bar_power.icon_state = "[src.info_dmg]"
				if(isnum(src.info_spd)) sk.bar_speed.icon_state = "[src.info_spd]"
				if(isnum(src.info_energy_cost)) sk.bar_energy.icon_state = "[src.info_energy_cost]"
				if(isnum(src.info_mastery)) sk.bar_mastery.icon_state = "[src.info_mastery]"
				if(isnum(src.info_cd)) sk.bar_cooldown.icon_state = "[src.info_cd]"
		Embryonic_Breathing
			/*
			also known as Taixi or Fetal Breathing. A form of breathing without using one’s nose and mouth. Instead, the practitioner might breathe through their pores or
			dantian (for example). This is generally considered to be a highly-advanced Breathing Exercise which grants mystical benefits and brings the practitioner closer to nature.
			Often compared to how babies breathe in the womb (through the umbilical cord).
			*/
		Crane_Breathing
			//Make this increase divine energy recovery and gains. And make it so the lvl of the lungs help contribute toward energy recovery while in use.
			name = "Crane Breathing"
			icon_state = "Meditate off"
			info_energy_cost = 0
			info_mastery = 1
			info_point_cost = 1
			teach_energy = 1000
			info_buffs = "Rapid energy recovery"
			info_duration = "Toggleable"
			info_name = "crane_breathing"
			info_point_cost_type = "recovery"
			info = "Using very specific breathing techniques, you are able to regulate your own internal Energy and Psionic Power. In doing so, you recover your Divine Energy quicker than normal. The rate you regain your Divine Energy is based on the level of this skill, and the level of your lungs. Using this skill will enter you into a minigame, where you must press E at the correct time, otherwise you must begin again."
			act = /obj/skills/Crane_Breathing/proc/activate
			var/obj/bar = null
			var/obj/bar_inner = null
			var/obj/e_but = null
			var/fullness = 0
			var/up = 1
			var/showing_e = 0
			hud_x = 20
			hud_y = 636
			proc
				activate(var/mob/m,var/obj/skills/Crane_Breathing/s)
					if(s.active == 0)
						return
						if(m.skill_flight && m.skill_flight.active)
							call(m.skill_flight.act)(m,m.skill_flight)
						if(m.skill_levitation && m.skill_levitation.active)
							call(m.skill_levitation.act)(m,m.skill_levitation)
						if(m.submerged)
							m << output("<font color = teal>You can't to do this when unable to breathe.","chat.system")
							return
						for(var/obj/skills/Meditate/med in m)
							if(med.active == 0) call(med.act)(m,med)
						s.active = 1
						m.client.screen += s.bar
						m.client.screen += s.bar_inner
						m.client.screen += s.e_but
						m.stunned += 1
						m.stunned_pending += 1
						m.minigame = "breathing"
						s.icon_state = "Meditate"
					else
						s.active = 0
						if(m.client)
							m.client.screen -= s.bar_inner
							m.client.screen -= s.bar
							m.client.screen -= s.e_but
						s.bar_inner.screen_loc  = "17:-8,11:-6"
						s.fullness = 0
						m.stunned -= 1
						m.stunned_pending -= 1
						m.minigame = null
						var/matrix/M = matrix()
						M.Scale(1,1)
						s.bar_inner.transform = M
						s.icon_state = "Meditate off"
						if(m.client && m.started)
							m.energy_sources -= "Crane Breathing"
							m.divine_sources -= "Crane Breathing"
			New()
				..()
				e_but = new /:e_button
				bar = new /:breathing_bar
				bar_inner = new /:breathing_bar_inner
				bar_inner.color = rgb(200,0,0)
				category = list("Recovery","Buff")
				spawn(10)


					if(src.disable_sleep) return
					spawn(10)
					if(src)
						while(src)
							var/t = 10
							if(src.active)
								var/mob/m = null
								if(ismob(src.loc))
									m = src.loc
									if(src.fullness < 25)
										bar_inner.color = rgb(200,0,0)
									if(src.fullness >= 25)
										bar_inner.color = rgb(232,232,43)
									if(src.fullness >= 45)
										bar_inner.color = rgb(0,153,0)
									if(src.up)
										t = 0.5
										src.fullness += 1
										if(src.fullness >= 51)
											src.fullness = 51
											src.up = 0
									else
										t = 0.5
										src.fullness -= 1
										src.e_but.icon_state = "normal"
										if(src.fullness <= 0)
											src.fullness = 0
											src.up = 1
									if(m.client)
										//m.client.screen -= src.bar_inner
										//src.bar_inner.screen_loc  = "17:-8,10:[round(src.fullness/2)+1]"
										var/matrix/M = matrix()
										M.Scale(1,round(src.fullness))
										src.bar_inner.transform = M
										//m.client.screen += src.bar_inner
							sleep(t)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(m.skill_breathing == null) m.skill_breathing = src
							call(src.act)(m,src)
		Organogenesis
			icon_state = "Revivification off"
			info_energy_cost = 4
			info_mastery = 1
			info_point_cost = 3
			info_name = "organogenesis"
			teach_energy = 1500
			info_buffs = "+20% Strength"
			info_duration = "Toggleable"
			info_point_cost_type = "strength"
			act = /obj/skills/Organogenesis/proc/activate
			info = "Via the complex manipulation of psionic power and divine energy, mould, form and shape a new organ or bodypart into existence."
			/*
			Opens up a special menu that lets players fully design and create a new organ, muscle or bone. They decide where to place it, and put points into each stat.
			*/
			proc
				activate(var/mob/m,var/obj/s)
					if(m.part_focus) m.part_focus.update_part_stats(m) //Update the reward for completing training on this body part.
					var/needed = (10/m.mod_recovery) + (10/s.skill_lvl)
					if(s.active)
						s.active = 0
						s.icon_state = "Expand off"
						m.mod_strength/=1.2
						m.expand = 1
						//m.buffs -= "expand"
					else if(m.energy >= needed)
						//m.buffs += "expand"
						s.icon_state = "Expand"
						s.active = 1
						m.mod_strength*=1.2
						m.expand = 1.2
						m.shockwave()
					if(m.part_selected) m.part_selected.update_part_stats(m) //Update the reward for completing training on this body part.
			New()
				..()
				category = list("Strength","Endurance","Buff")
				spawn(10)


					if(src.disable_sleep) return
					spawn(10)
						while(src)
							if(ismob(src.loc))
								var/mob/m = src.loc
								if(src.active)
									var/removes = (10/m.mod_recovery) + (10/src.skill_lvl)
									if(m.energy >= removes)
										//m.energy-=((m.energy_max/10)/src.skill_lvl)/m.mod_recovery/m.mod_energy
										m.energy-=removes
										//world << "[removes] energy removed by [src]"
										//m << output("<font color = teal>[removes] energy removed by [src]","chat.system")
										src.skill_exp += (10-(src.skill_lvl/10))*m.mod_skill
										if(src.skill_exp >= 100 && src.skill_lvl < 100)
											src.skill_exp = 1
											src.skill_lvl += 1
											src.skill_up(m)
									else
										m.mouse_dir = "left"
										call(src.act)(m,src)
							//CHECK_TICK
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Expand
			icon_state = "Expand off"
			info_energy_cost = 1
			info_mastery = 1
			info_point_cost = 3
			info_name = "expand"
			teach_energy = 1500
			info_buffs = "+20% Strength"
			info_duration = "Toggleable"
			info_point_cost_type = "strength"
			act = /obj/skills/Expand/proc/activate
			info = "By sending excess Energy throughout your body, you're able to increase your strength significantly. Using this ability expands your muscles, draining your Energy slowly, but increasing your strength by 20%."
			hud_x = 20
			hud_y = 636
			proc
				activate(var/mob/m,var/obj/s)
					if(m.part_focus) m.part_focus.update_part_stats(m) //Update the reward for completing training on this body part.
					var/needed = (10/m.mod_recovery) + (10/s.skill_lvl)
					if(s.active)
						s.active = 0
						s.icon_state = "Expand off"
						m.mod_strength/=1.2
						m.strength/=1.2
						m.expand = 1
						//m.buffs -= "expand"
					else if(m.energy >= needed)
						//m.buffs += "expand"
						s.icon_state = "Expand"
						s.active = 1
						m.mod_strength*=1.2
						m.strength*=1.2
						m.expand = 1.2
						m.shockwave()
					if(m.part_selected) m.part_selected.update_part_stats(m) //Update the reward for completing training on this body part.
			New()
				..()
				category = list("Strength","Endurance","Buff")
				spawn(10)


					if(src.disable_sleep) return
					spawn(10)
						while(src)
							if(ismob(src.loc))
								var/mob/m = src.loc
								if(src.active)
									var/removes = (10/m.mod_recovery) + (10/src.skill_lvl)
									if(m.energy >= removes)
										//m.energy-=((m.energy_max/10)/src.skill_lvl)/m.mod_recovery/m.mod_energy
										m.energy-=removes
										//world << "[removes] energy removed by [src]"
										//m << output("<font color = teal>[removes] energy removed by [src]","chat.system")
										//world << "DEBUG - [(10-(src.skill_lvl/10))*m.mod_skill]"
										src.skill_exp += (2.5-(src.skill_lvl/40)*m.mod_skill)+0.025
										//world << "DEBUG - exp for expand = [(2.5-(src.skill_lvl/40)*m.mod_skill)+0.025]"
										if(src.skill_exp >= 100 && src.skill_lvl < 100)
											src.skill_exp = 1
											src.skill_lvl += 1
											src.skill_up(m)
									else
										m.mouse_dir = "left"
										call(src.act)(m,src)
							//CHECK_TICK
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)


		Revivification
			icon_state = "Revivification off"
			info_energy_cost = 4
			info_mastery = 1
			info_point_cost = 3
			teach_energy = 3000
			info_name = "revivification"
			info_buffs = "Revive soul"
			info_duration = "Channeled"
			info_point_cost_type = "regen"
			act = /obj/skills/Revivification/proc/activate
			info = "Whilst already dead, but possessing a body, channel ambient Psionic Power and Divine Energy to reknit your deceased soul. The revivification process takes quite some time and needs at least 25 Divine Energy to complete."
			hud_x = 20
			hud_y = 588
			var/progress = 0;
			var/obj/bar = null
			var/obj/bar_inner = null
			var/tmp/mob/skill_target = null
			proc
				activate(var/mob/m,var/obj/skills/Revivification/s)
					if(s in m)
						if(m.skill_revive == null) m.skill_revive = s
					if(s.active == 0)
						if(m.stance) //Switch off all stances
							m.disable_stances(null,1)
						if(m.grab) m.letgo()
						if(round(m.divine_energy) < 25)
							m << output("<font color = teal>You need at least 25 Divine Energy to attempt the revivification process.","chat.system")
							m.set_alert("25 Divine Energy needed",s.icon,s.icon_state)
							m.create_chat_entry("alerts","You need at least 25 Divine Energy to attempt the revivification process.")
							return
						if(m.energy < m.energy_max/1.05)
							m << output("<font color = teal>You need to be at max energy to attempt the revivification process.","chat.system")
							m.set_alert("Need max energy",s.icon,s.icon_state)
							m.create_chat_entry("alerts","You need to be at max energy to attempt the revivification process.")
							return
						m.open_skills = 0
						m.open_menus.Remove(".open_skills")
						winshow(m,"skills",0)
						//m.left_click_function = "revive"
						//m.set_alert("Select target to revive",s.icon,s.icon_state)
						s.icon_state = "Revivification"
						var/mob/trg = m
						if(m.target) trg = m.target
						if(trg.client)
							m.left_click_function = null
							if(get_dist(m,trg) > 2)
								m << output("<font color = teal>They are too far away to interact with.","chat.system")
								m.set_alert("Too far away",'alert.dmi',"alert")
								m.create_chat_entry("alerts","They are too far away to interact with.")
								m.skill_revive.icon_state = "Revivification off"
								return
							if(trg.has_body == 0)
								m << output("<font color = teal>They need to have a body to attempt the revivification process.","chat.system")
								m.set_alert("Need body",m.skill_revive.icon,m.skill_revive.icon_state)
								m.create_chat_entry("alerts","They need to have a body to attempt the revivification process.")
								m.skill_revive.icon_state = "Revivification off"
								return
							if(trg.dead == 0)
								m << output("<font color = teal>They are already alive.","chat.system")
								m.set_alert("Already alive",m.skill_revive.icon,m.skill_revive.icon_state)
								m.skill_revive.icon_state = "Revivification off"
								m.create_chat_entry("alerts","They are already alive.")
								return
							if(trg.dead && trg.z == 2)
								for(var/obj/skills/Meditate/med in m)
									if(med.active) call(med.act)(m,med)
								m.skill_revive.active = 1
								m.skill_revive.skill_target = trg
								m.icon_state = "meditate"
								m.stunned += 1
								m.stunned_pending += 1
								m.client.screen += m.skill_revive.bar
								if(trg != m) trg.client.screen += m.skill_revive.bar
								view(8,m) << output("<font color = purple> [m] begins to revive [trg]'s soul.", "chat.local")
							else
								m << output("<font color = teal>They need to be dead and in the Psionic Realm for you to attempt the revivification process.","chat.system")
								m.set_alert("Target must be dead and in Psi Realms",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Target must be dead and in Psi Realms")
								m.skill_revive.icon_state = "Revivification off"
								return
						else
							s.icon_state = "Revivification off"
							m.set_alert("Only used on players",'alert.dmi',"alert")
							m.create_chat_entry("alerts","Only used on players.")
							return
					else
						s.active = 0
						m.stunned -= 1
						m.stunned_pending -= 1
						m.icon_state = ""
						m.client.screen -= s.bar_inner
						m.client.screen -= s.bar
						s.bar_inner.screen_loc = "16:-2,10:-3"
						s.progress = 0
						s.icon_state = "Revivification off"
						if(s.skill_target && s.skill_target.client)
							s.skill_target.client.screen -= s.bar_inner
							s.skill_target.client.screen -= s.bar
						s.skill_target = null
			New()
				..()
				bar = new /:revive_bar
				bar_inner = new /:revive_bar_inner
				category = list("Regeneration","Utility")


				if(src.disable_sleep) return
				spawn(10)
					if(src)
						while(src)
							if(src.active)
								var/mob/m = null
								if(ismob(src.loc))
									if(src.skill_target)
										var/mob/tar = src.skill_target
										m = src.loc
										if(get_dist(m,tar) <= 2)
											if(tar.dead && tar.has_body)
												if(m.energy >= src.skill_lvl+10)
													m.energy -= src.skill_lvl+10;
													src.progress += 1+round(src.skill_lvl/10)
													//src.skill_exp += (10/src.skill_lvl)*m.mod_skill
													src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
													if(src.skill_exp >= 100 && src.skill_lvl < 100)
														src.skill_exp = 1
														src.skill_lvl += 1
														src.skill_up(m)

												if(m.client)
													m.client.screen -= src.bar_inner
													src.bar_inner.screen_loc  = "16:[round(src.progress/2)-2],10:-3"
													var/matrix/M = matrix()
													M.Scale(round(src.progress),1)
													src.bar_inner.transform = M
													m.client.screen += src.bar_inner
													if(tar.client && tar != m)
														tar.client.screen -= src.bar_inner
														src.bar_inner.screen_loc  = "16:[round(src.progress/2)-2],10:-3"
														var/matrix/M2 = matrix()
														M2.Scale(round(src.progress),1)
														src.bar_inner.transform = M2
														tar.client.screen += src.bar_inner

												var/obj/effects/orb/o = new
												o.loc = tar.loc
												o.step_x = tar.step_x
												o.step_y = tar.step_y
												o.pixel_x = rand(-64,64)
												o.pixel_y = rand(-64,64)
												animate(o,pixel_x = 0, pixel_y = 0, alpha = 0, time = 10)
												spawn(10)
													if(o) del(o)

												if(m.koed || m.meditating)
													call(src.act)(m,src)
												if(src.progress >= 100)
													tar.Revive()
													m.icon_state = ""
													m.divine_energy -= 25
													m.set_alert("Revivification successful!",src.icon,src.icon_state)
													m.create_chat_entry("alerts","Revivification successful!")
													view(8,m) << output("<font color = purple> [m] finishes reknitting [tar]'s soul and fuses it back to their body.", "chat.local")
													if(src.active) call(src.act)(m,src)
										else if(src.active)
											m.set_alert("Revive target too far",'alert.dmi',"alert")
											m.create_chat_entry("alerts","Revive target too far.")
											if(src.skill_target && src.skill_target != m)
												src.skill_target.set_alert("Revive target too far",'alert.dmi',"alert")
												src.skill_target.create_chat_entry("alerts","Revive target too far.")
											call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Restoration
			icon_state = "Revivification off"
			info_energy_cost = 4
			info_mastery = 1
			info_point_cost = 3
			teach_energy = 3000
			info_name = "restoration"
			info_buffs = "Restore youth, vigour and vitality"
			info_duration = "Channeled"
			info_point_cost_type = "regen"
			act = /obj/skills/Restoration/proc/activate
			info = "Summon forth Divine Energy and confer a powerful restorative effect upon somebody. Bestowing an individual with this accumulation of energy will cast their body in the image of youth, allowing you to sculpt them to a time before the ravages of time."
			hud_x = 20
			hud_y = 492
			var/progress = 0;
			var/obj/bar = null
			var/obj/bar_inner = null
			var/tmp/mob/skill_target = null
			proc
				activate(var/mob/m,var/obj/skills/Restoration/s)
					if(s in m)
						if(m.skill_restoration == null) m.skill_restoration = s
					if(s.active == 0)
						if(m.stance) //Switch off all stances
							m.disable_stances(null,1)
						if(m.grab) m.letgo()
						if(m.energy < m.energy_max/1.05)
							m << output("<font color = teal>You need to be at max energy to attempt the restoration process.","chat.system")
							m.set_alert("Need max energy",'alert.dmi',"alert")
							m.create_chat_entry("alerts","You need to be at max energy to attempt the restoration process.")
							return
						if(round(m.divine_energy) < 25)
							m << output("<font color = teal>You need at least 25 Divine Energy to attempt the restoration process.","chat.system")
							m.set_alert("25 Divine Energy needed",s.icon,s.icon_state)
							m.create_chat_entry("alerts","25 Divine Energy needed.")
							return
						m.open_skills = 0
						m.open_menus.Remove(".open_skills")
						winshow(m,"skills",0)
						//m.left_click_function = "restoration"
						//m.set_alert("Select target to restore",s.icon,s.icon_state)
						s.icon_state = "Revivification"

						var/mob/trg = m
						if(m.target) trg = m.target
						if(trg.client)
							m.left_click_function = null
							if(get_dist(m,trg) > 2)
								m << output("<font color = teal>They are too far away to interact with.","chat.system")
								m.set_alert("Too far away",'alert.dmi',"alert")
								m.create_chat_entry("alerts","They are too far away to interact with.")
								m.skill_reformation.icon_state = "Revivification off"
								return
							for(var/obj/skills/Meditate/med in m)
								if(med.active) call(med.act)(m,med)
							m.skill_restoration.active = 1
							m.skill_restoration.skill_target = trg
							m.icon_state = "meditate"
							m.stunned += 1
							m.stunned_pending += 1
							animate(trg, color = list("#000", "#000", "#000", "#fff"),time = 20, loop = -1)
							animate(color = initial(trg.color),time = 20)
							m.client.screen += m.skill_restoration.bar
							if(trg != m) trg.client.screen += m.skill_restoration.bar
							view(8,m) << output("<font color = purple> [m] begins to restore [trg]'s youth.", "chat.local")
						else
							s.icon_state = "Revivification off"
							m.set_alert("Only used on players",'alert.dmi',"alert")
							m.create_chat_entry("alerts","Only used on players.")
							return
					else
						s.active = 0
						animate(m)
						m.stunned -= 1
						m.stunned_pending -= 1
						m.icon_state = ""
						m.client.screen -= s.bar_inner
						m.client.screen -= s.bar
						s.bar_inner.screen_loc = "16:-2,10:-3"
						s.progress = 0
						s.icon_state = "Revivification off"
						if(s.skill_target && s.skill_target.client)
							s.skill_target.client.screen -= s.bar_inner
							s.skill_target.client.screen -= s.bar
						s.skill_target = null
			New()
				..()
				bar = new /:revive_bar
				bar_inner = new /:revive_bar_inner
				category = list("Regeneration","Utility")


				if(src.disable_sleep) return
				spawn(10)
					if(src)
						while(src)
							if(src.active)
								var/mob/m = null
								if(ismob(src.loc))
									if(src.skill_target)
										var/mob/tar = src.skill_target
										m = src.loc
										if(get_dist(m,tar) <= 2)
											if(m.energy >= src.skill_lvl+10)
												m.energy -= src.skill_lvl+10;
												src.progress += 1+round(src.skill_lvl/10)
												//src.skill_exp += (10/src.skill_lvl)*m.mod_skill
												src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
												if(src.skill_exp >= 100 && src.skill_lvl < 100)
													src.skill_exp = 1
													src.skill_lvl += 1
													src.skill_up(m)

											if(m.client)
												m.client.screen -= src.bar_inner
												src.bar_inner.screen_loc  = "16:[round(src.progress/2)-2],10:-3"
												var/matrix/M = matrix()
												M.Scale(round(src.progress),1)
												src.bar_inner.transform = M
												m.client.screen += src.bar_inner
												if(tar.client && tar != m)
													tar.client.screen -= src.bar_inner
													src.bar_inner.screen_loc  = "16:[round(src.progress/2)-2],10:-3"
													var/matrix/M2 = matrix()
													M2.Scale(round(src.progress),1)
													src.bar_inner.transform = M2
													tar.client.screen += src.bar_inner

											if(m.koed || m.meditating)
												call(src.act)(m,src)
											if(src.progress >= 100)
												animate(tar,alpha = 255, time = 30)
												tar.icon_state = ""
												tar.screen_text.maptext = "<font size = 6><center>Youth restored"
												if(tar.lifespan <= tar.prime) tar.lifespan = tar.prime
												tar.age = tar.prime
												tar.vigour = 100
												m.divine_energy -= 25
												m.set_alert("Restoration successful!",src.icon,src.icon_state)
												m.create_chat_entry("alerts","Restoration successful!")
												animate(tar.screen_text,alpha = 255,time = 60)
												animate(alpha = 0,time = 60)
												view(8,m) << output("<font color = purple> [m] finishes restoring [tar]'s youth.", "chat.local")
												if(src.active) call(src.act)(m,src)
										else if(src.active)
											m.set_alert("Restoration target too far",'alert.dmi',"alert")
											m.create_chat_entry("alerts","Restoration target too far.")
											if(src.skill_target && src.skill_target != m)
												src.skill_target.set_alert("Restoration target too far",'alert.dmi',"alert")
												src.skill_target.create_chat_entry("alerts","Restoration target too far.")
											call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Cleanse
			icon_state = "Cleanse off"
			info_energy_cost = 4
			info_mastery = 1
			info_point_cost = 3
			teach_energy = 1000
			hud_x = 260
			hud_y = 636
			info_name = "divine_infusion"
			info_buffs = "Cleanse a bodypart of infusions"
			info_duration = "Channeled"
			info_point_cost_type = "energy"
			act = /obj/skills/Cleanse/proc/activate
			info = "This skill, despite its name, is not a gentle process. In order to remove divinity from a bodypart, great effort must be exerted upon that part. Ironically, Divine Energy is used to wash away and shed any traces of infusion upon the selected part, be it Dark Matter, Petrifaction, or even Divine Energy itself. Once the bodypart has been wreathed in the saturation of the divine, and the infusion of that part collected, the excess is disgarded violently, cast off like a band-aid, leaving the bodypart sundered."
			var/progress = 0;
			var/obj/bar = null
			var/obj/bar_inner = null
			var/obj/wave = null
			proc
				activate(var/mob/m,var/obj/skills/Cleanse/s)
					s.progress = 0
					if(s.active)
						if(m.stance) //Switch off all stances
							m.disable_stances(null,1)
						if(m.grab) m.letgo()
						s.icon_state = "Cleanse off"
						if(s.active == 2)
							m.stunned -= 1
							m.stunned_pending -= 1
						s.active = 0
						m.icon_state = ""
						if(m.client) m.client.screen -= s.bar_inner
						if(m.client) m.client.screen -= s.bar
						s.bar_inner.screen_loc = "16:-2,10:-3"
						s.progress = 0
						m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(255,255,255))
						if(s.wave)
							s.wave.loc = null
							animate(s.wave)
							s.wave = null
					else
						for(var/obj/skills/Dark_Infusion/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Incubation/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Dark_Petrifaction/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						if(m.has_body == 0)
							m << output("<font color = teal>You can only cleanse your body of divine power when you have a body.","chat.system")
							m.set_alert("Unable without body",s.icon,s.icon_state)
							m.create_chat_entry("alerts","Unable without body.")
							return
						if(round(m.divine_energy) < 10)
							m << output("<font color = teal>You need at least 10 Divine Energy to wash away divine power from a bodypart.","chat.system")
							m.set_alert("10 Divine Energy needed",s.icon,s.icon_state)
							m.create_chat_entry("alerts","10 Divine Energy needed.")
							return
						s.icon_state = "Cleanse"
						s.active = 1
						winshow(m,"skills",0)
						m.open_skills = 0
						m.open_menus.Remove(".open_skills")
						if(m.open_body == 0)
							m.open_body = 1
							m.open_menus.Add(".open_body")
							if(m.hud_body) m.client.screen += m.hud_body
						m.set_alert("Select bodypart to cleanse",s.icon,s.icon_state)
			New()
				..()
				bar = new /:revive_bar
				bar_inner = new /:divine_bar_inner
				category = list("Energy","Buff")


				if(src.disable_sleep) return
				spawn(10)
					if(src)
						while(src)
							if(src.active == 2)
								var/mob/m = null
								if(ismob(src.loc))
									m = src.loc
									src.progress += 2+round(src.skill_lvl/10)
									//src.skill_exp += (33/src.skill_lvl)*m.mod_skill
									src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
									if(src.skill_exp >= 100 && src.skill_lvl < 100)
										src.skill_exp = 1
										src.skill_lvl += 1
										src.skill_up(m)

									if(m.client)
										m.client.screen -= src.bar_inner
										src.bar_inner.screen_loc  = "16:[round(src.progress/2)-2],10:-3"
										var/matrix/M = matrix()
										M.Scale(round(src.progress),1)
										src.bar_inner.transform = M
										m.client.screen += src.bar_inner
									if(round(m.divine_energy) < 10)
										call(src.act)(m,src)
										m << output("<font color = teal>You must have at least 10 divine energy to continue using Cleanse.","chat.system")
										m.set_alert("10 Divine Energy needed",src.icon,src.icon_state)
										m.create_chat_entry("alerts","10 Divine Energy needed.")
									/*
									if(m.cleansing && m.cleansing.disabled || m.cleansing.damaged)
										call(src.act)(m,src)
										m << output("<font color = teal>Can only cleanse heathly bodyparts.","chat.system")
										m.set_alert("Bodypart damaged during cleansing",src.icon,src.icon_state)
									*/

									var/obj/effects/orb_divine/o = new
									o.loc = m.loc
									o.step_x = m.step_x
									o.step_y = m.step_y
									o.pixel_x = 0//rand(-64,64)
									o.pixel_y = 0//rand(-64,64)
									o.alpha = 0
									animate(o,pixel_x = rand(-64,64), pixel_y = rand(-64,64), alpha = 255, time = 10)
									spawn(10)
										if(o) o.loc = null//del(o)

									if(m.koed || m.meditating)
										call(src.act)(m,src)
									if(src.progress >= 100)
										m.divine_energy -= 10
										animate(m,alpha = 255, time = 30)
										m.icon_state = ""
										m.screen_text.maptext = "<font size = 6><center>[m.cleansing] cleansed"
										m.cleansing.i_state = "[initial(m.cleansing.icon_state)]"
										m.cleansing.icon_state = m.cleansing.i_state
										m.cleansing.infused_divine = 0
										m.cleansing.infused_dark = 0
										m.cleansing.infused_petrified = 0
										m.cleansing.disabled_perma = 0
										if(m.cleansing.disabled == 0 && m.cleansing.damaged == 0) m.damage_limb(m,0,1,100,m.cleansing)
										m.cleansing = null
										animate(m.screen_text,alpha = 255,time = 60)
										animate(alpha = 0,time = 60)
										m.shockwave()
										if(m.dead)
											m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
											m.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
										if(src.active) call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(m.skill_cleanse == null) m.skill_cleanse = src
							call(src.act)(m,src)
		Reconstruction
			// Sets a bodypart to 0 hp, but gives a large boost to psiforging while healing it immedtately.
			icon_state = "Revivification off"
			info_energy_cost = 4
			info_mastery = 1
			info_point_cost = 3
			info_name = "reconstruction"
			info_buffs = "Reform a body"
			info_duration = "Channeled"
			teach_energy = 3000
			info_point_cost_type = "regen"
			act = /obj/skills/Reconstruction/proc/activate
			info = "Whilst already dead, channel ambient Psionic Power and Divine Energy to form a new body to inhabit. However, this will not revive you from the dead, since your soul would still be deceased. The reformation process takes quite some time and needs at least 25 Divine Energy to complete."
			proc
				activate(var/mob/m,var/obj/skills/Reformation/s)
		Reformation
			icon_state = "Reformation off"
			info_energy_cost = 4
			info_mastery = 1
			info_point_cost = 3
			info_name = "reformation"
			info_buffs = "Reform a body"
			info_duration = "Channeled"
			teach_energy = 3000
			hud_x = 20
			hud_y = 636
			info_point_cost_type = "regen"
			act = /obj/skills/Reformation/proc/activate
			info = "Whilst already dead, channel ambient Psionic Power and Divine Energy to form a new body to inhabit. However, this will not revive you from the dead, since your soul would still be deceased. The reformation process takes quite some time and needs at least 25 Divine Energy to complete."
			var/progress = 0;
			var/obj/bar = null
			var/obj/bar_inner = null
			var/tmp/mob/skill_target = null
			proc
				activate(var/mob/m,var/obj/skills/Reformation/s)
					if(s in m)
						if(m.skill_reformation == null) m.skill_reformation = s
					if(s.active == 0)
						if(m.stance) //Switch off all stances
							m.disable_stances(null,1)
						if(m.grab) m.letgo()
						if(m.energy < m.energy_max/1.05)
							m << output("<font color = teal>You need to be at max energy to attempt the reformation process.","chat.system")
							m.set_alert("Need max energy",'alert.dmi',"alert")
							m.create_chat_entry("alerts","Need max energy.")
							return
						if(round(m.divine_energy) < 25)
							m << output("<font color = teal>You need at least 25 Divine Energy to attempt the reformation process.","chat.system")
							m.set_alert("25 Divine Energy needed",s.icon,s.icon_state)
							m.create_chat_entry("alerts","25 Divine Energy needed.")
							return
						m.open_skills = 0
						m.open_menus.Remove(".open_skills")
						winshow(m,"skills",0)
						/*
						m.left_click_function = "reformation"
						m.set_alert("Select target to reform",s.icon,s.icon_state)
						*/
						s.icon_state = "Reformation"

						var/mob/trg = m
						if(m.target) trg = m.target
						if(trg.client)
							if(get_dist(m,trg) > 2)
								m << output("<font color = teal>They are too far away to interact with.","chat.system")
								m.set_alert("Too far away",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Too far away.")
								m.skill_reformation.icon_state = "Reformation off"
								return
							if(trg.has_body)
								m << output("<font color = teal>You have no need to reform their body, since they already have one.","chat.system")
								m.set_alert("Already have body",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already have body.")
								m.skill_reformation.icon_state = "Reformation off"
								return
							if(trg.dead && trg.z == 2)
								for(var/obj/skills/Meditate/med in m)
									if(med.active) call(med.act)(m,med)
								m.skill_reformation.active = 1
								m.skill_reformation.skill_target = trg
								m.icon_state = "meditate"
								m.stunned += 1
								m.stunned_pending += 1
								m.client.screen += m.skill_reformation.bar
								if(trg != m) trg.client.screen += m.skill_reformation.bar
								view(8,m) << output("<font color = purple> [m] begins to reform a new body for [trg].", "chat.local")
							else
								m << output("<font color = teal>They need to be dead and in the Psionic Realm for you to attempt the reformation process.","chat.system")
								m.set_alert("Target must be dead and in Psi Realms",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Target must be dead and in Psi Realms.")
								m.skill_reformation.icon_state = "Reformation off"
								return
					else
						s.active = 0
						m.stunned -= 1
						m.stunned_pending -= 1
						m.icon_state = ""
						m.client.screen -= s.bar_inner
						m.client.screen -= s.bar
						s.bar_inner.screen_loc = "16:-2,10:-3"
						s.progress = 0
						s.icon_state = "Reformation off"
						if(s.skill_target && s.skill_target.client)
							s.skill_target.client.screen -= s.bar_inner
							s.skill_target.client.screen -= s.bar
						s.skill_target = null
			New()
				..()
				bar = new /:revive_bar
				bar_inner = new /:revive_bar_inner
				category = list("Regeneration","Utility")


				if(src.disable_sleep) return
				spawn(10)
					if(src)
						while(src)
							if(src.active)
								var/mob/m = null
								if(ismob(src.loc))
									if(src.skill_target)
										var/mob/tar = src.skill_target
										m = src.loc
										if(get_dist(m,tar) <= 2)
											if(m.energy >= src.skill_lvl+10)
												m.energy -= src.skill_lvl+10;
												src.progress += 1+round(src.skill_lvl/10)
												//src.skill_exp += (10/src.skill_lvl)*m.mod_skill
												src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
												if(src.skill_exp >= 100 && src.skill_lvl < 100)
													src.skill_exp = 1
													src.skill_lvl += 1
													src.skill_up(m)

											if(m.client)
												m.client.screen -= src.bar_inner
												src.bar_inner.screen_loc  = "16:[round(src.progress/2)-2],10:-3"
												var/matrix/M = matrix()
												M.Scale(round(src.progress),1)
												src.bar_inner.transform = M
												m.client.screen += src.bar_inner
												if(tar.client && tar != m)
													tar.client.screen -= src.bar_inner
													src.bar_inner.screen_loc  = "16:[round(src.progress/2)-2],10:-3"
													var/matrix/M2 = matrix()
													M2.Scale(round(src.progress),1)
													src.bar_inner.transform = M2
													tar.client.screen += src.bar_inner

											var/obj/effects/orb/o = new
											o.loc = tar.loc
											o.step_x = tar.step_x
											o.step_y = tar.step_y
											o.pixel_x = rand(-64,64)
											o.pixel_y = rand(-64,64)
											animate(o,pixel_x = 0, pixel_y = 0, alpha = 0, time = 10)
											spawn(10)
												if(o) del(o)

											if(m.koed || m.meditating)
												call(src.act)(m,src)
											if(src.progress >= 100)
												if(tar.has_body == 0)
													tar.Body()
													m.divine_energy -= 25
													m.set_alert("Reformation successful!",src.icon,src.icon_state)
													m.create_chat_entry("alerts","Reformation successful!")
													view(8,m) << output("<font color = purple> [m] finishes reforming a new body for [tar].", "chat.local")
													if(src.active) call(src.act)(m,src)
										else if(src.active)
											m.set_alert("Reformation target too far",'alert.dmi',"alert")
											m.create_chat_entry("alerts","Reformation target too far.")
											if(src.skill_target && src.skill_target != m)
												src.skill_target.set_alert("Reformation target too far",'alert.dmi',"alert")
												src.skill_target.create_chat_entry("alerts","Reformation target too far.")
											call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Dig
			icon_state = "Explosion off"
			info_energy_cost = 1
			info_mastery = 1
			info_point_cost = 1
			info_name = "dig"
			info_buffs = "Dig for resources"
			info_duration = "Channeled"
			info_point_cost_type = "strength"
			act = /obj/skills/Dig/proc/activate
			info = "Digging allows you to collect resources from the ground. The amount you find is based off your level in digging, and whether you're using a tool, such as a shovel or drill. While rudimentary, this does allow you to gather some resources starting out before moving onto heavier machinery. Digging also raises your Strength, but slowly drains your Energy."
			var/tmp/shov = null
			var/tmp/dig_mod = 1
			proc
				activate(var/mob/m,var/obj/skills/Dig/s)
					s.shov = null
					s.dig_mod = 1
					if(s in m)
						if(m.skill_dig == null) m.skill_dig = s
					if(s.active == 0)
						if(m.loc)
							var/turf/x = m.loc
							if(x.liquid == null)
								var/obj/effects/craters/crater_small/c = new
								c.SetCenter(m)
								m.icon_state = "dig"
								if(m.race == "Cerebroid")
									c.step_x -= 4
									s.dig_mod = 3
								else
									for(var/obj/items/tech/digging/sh in m)
										if(sh.suffix)
											s.shov = sh
											if(sh.type == /obj/items/tech/digging/Shovel)
												m.overlays += 'spade_dig.dmi'
												s.dig_mod = 2
											else
												m.overlays += 'drill_dig.dmi'
												//m.icon_state = "blast"
												m.icon_state = "drill"
												s.dig_mod = 3
											break
								if(m.stance) //Switch off all stances
									m.disable_stances(null,1)
								if(m.grab) m.letgo()
								if(m.energy < 1)
									m << output("<font color = teal>You need more energy to dig.","chat.system")
									m.set_alert("Need more energy",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Need more energy.")
									return
								m.stunned += 1
								m.stunned_pending += 1
								m.dir = SOUTH
								m.update_wings()
								//m.particles = new/particles/dust
								if(m.digging_dust) m.vis_contents -= m.digging_dust
								var/turf/t = locate(m.x,m.y-1,m.z)
								if(t.tmp_dmg < 0) m.digging_dust = new/obj/effects/digging_snow
								else if(istype(t,/turf/lava_cooled) || istype(t,/turf/lava_cooling)) m.digging_dust = new/obj/effects/digging_ash
								else m.digging_dust = new/obj/effects/digging
								m.vis_contents += m.digging_dust
								s.active = 1
								s.icon_state = "Explosion"
								if(m.shadow) m.shadow.alpha = 0
							else
								m << output("<font color = teal>Can't do this in any sort of liquid.","chat.system")
								m.set_alert("Need solid ground",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Need solid ground.")
						else
							m << output("<font color = teal>Need to be on the map to dig.","chat.system")
							m.set_alert("Need solid ground",'alert.dmi',"alert")
							m.create_chat_entry("alerts","Need solid ground.")
						return
					else
						s.active = 0
						m.stunned -= 1
						m.stunned_pending -= 1
						//m.particles = null
						if(!m.client) m.icon_state = "meditate"
						else m.icon_state = ""
						s.icon_state = "Explosion off"
						m.overlays -= 'spade_dig.dmi'
						m.overlays -= 'drill_dig.dmi'
						if(m.digging_dust) m.vis_contents -= m.digging_dust
						if(m.shadow && m.skill_invis == null || m.skill_invis && m.skill_invis.active == 0) m.shadow.alpha = 255
			New()
				..()
				category = list("Strength","Utility")


				if(src.disable_sleep) return
				spawn(10)
					if(src)
						while(src)
							//var/T = 60
							if(src.active)
								//T = 10
								var/mob/m = null
								if(ismob(src.loc))
									m = src.loc
									if(m.energy >= 1)
										m.energy -= 1
										//src.skill_exp += (3/src.skill_lvl)*m.mod_skill
										//src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
										src.skill_exp += (2.5-(src.skill_lvl/40)*m.mod_skill)+0.025
										if(src.skill_exp >= 100 && src.skill_lvl < 100)
											src.skill_exp = 1
											src.skill_lvl += 1
											src.skill_up(m)

										if(m.koed || m.meditating || m.stunned > 1)
											call(src.act)(m,src)

										else
											m.resources += round(src.dig_mod*src.skill_lvl)
											m.update_rsc()
											m.gain_stat("strength",1,1,"Digging",1)
											var/X = rand(-96,96)
											var/Y = rand(-96,96)
											var/turf/t = locate(m.x,m.y-1,m.z)
											var/I = 'fx_dust_plume.dmi'
											if(t)
												if(t.tmp_dmg < 0) I = 'fx_dust_plume_snow.dmi'
												else if(istype(t,/turf/lava_cooled) || istype(t,/turf/lava_cooling)) I = 'fx_ash_plume.dmi'
											for(var/obj/d in dusts)
												if(d.loc == null)
													d.loc = t
													d.icon = I
													d.step_x = m.step_x-9
													d.step_y = m.step_y
													d.alpha = 200
													animate(d, pixel_y = Y,pixel_x = X,alpha = 0, time = 30)
													spawn(30)
														if(d)
															d.pixel_y = 0
															d.pixel_x = 0
															d.alpha = 255
															d.loc = null
															d.layer = 3
															d.icon = initial(d.icon)
													break
									else call(src.act)(m,src)
							sleep(6)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Focus
			icon_state = "Focus off"
			info_energy_cost = 1
			info_mastery = 1
			info_point_cost = 3
			teach_energy = 1500
			info_buffs = "+20% Force"
			info_duration = "Toggleable"
			info_point_cost_type = "force"
			info_name = "focus"
			act = /obj/skills/Focus/proc/activate
			info_stats = "+20% Force\n\nConstant energy drain\n\nToggleable"
			hud_x = 20
			hud_y = 636
			proc
				activate(var/mob/m,var/obj/s)
					if(islist(m.tutorials))
						var/obj/help_topics/H = m.tutorials[3]
						if(H.seen == 0)
							H.seen = 1
							H.skill_up(m)
					var/needed = (10/m.mod_recovery) + (10/s.skill_lvl)
					if(s.active)
						//m.buffs -= "focus"
						s.active = 0
						if(m.client) m.force_sources -= "From Focus skill"

						//m.overlays -= 'focus_eyes.dmi'
						//m.overlays -= /obj/effects/eyes_focus
						s.icon_state = "Focus off"
						if(m.race == "Cerebroid") m.overlays -= /obj/effects/elec_cerebroid
						else m.overlays -= /obj/effects/elec
						m.med_pixel = 1
						m.shock_chance = 0
						//m.mod_force/=1.2
						//m.multi_force -= 0.2
						m.vis_contents -= m.eyes_white
						m.vis_contents -= m.eyes
						if(m.eyes)
							m.eyes = m.eyes_copy
							var/proceed = 1
							if(m.skill_active_meditation && m.skill_active_meditation.active) proceed = 0
							if(proceed)
								m.vis_contents += m.eyes_white
								m.vis_contents += m.eyes
						//animate(m)
						var/turf/t = m.loc
						if(t && t.liquid == null) animate(m)
						//m.update_mods(list("Strength","Endurance","resistance","offence","defence","Regeneration","Agility","force"))
						//if(m.meditating)
							//animate(m,pixel_y = initial(m.pixel_y), time = 10)
					else if(m.energy >= needed)
						//m.buffs += "focus"
						s.active = 1
						s.icon_state = "Focus"
						var/turf/t = m.loc
						if(!t.liquid)
							var/obj/effects/dust_medium/d = new
							d.SetCenter(m)
						if(m.race == "Cerebroid")
							m.overlays -= /obj/effects/elec_cerebroid
							m.overlays += /obj/effects/elec_cerebroid
						else
							m.overlays -= /obj/effects/elec
							m.overlays += /obj/effects/elec
						//for(var/mob/h in view(8,m))
							//h << sound('focus1.mp3',0,1,10,100)
						m.shock_chance = 10
						//m.mod_force*=1.2
						//m.multi_force += 0.2
						m.vis_contents -= m.eyes_white
						m.vis_contents -= m.eyes
						if(m.eyes)
							if(m.race == "Celestial") m.eyes = global.eyes_focus_celestial
							else m.eyes = global.eyes_focus
							var/proceed = 1
							if(m.skill_active_meditation && m.skill_active_meditation.active) proceed = 0
							if(proceed)
								m.vis_contents += m.eyes_white
								m.vis_contents += m.eyes
						//hearers(8,m) << 'shockwave.wav'
						m.shockwave()
						if(m.meditating)
							var/pix_y = 0
							if(m.race == "Cerebroid") pix_y = -16
							animate(m,pixel_y = 10, time = 20,loop = -1,flags = ANIMATION_PARALLEL)
							animate(pixel_y = pix_y, time = 20)
						//hearers(8,m) << 'focus_activate.wav'
						//hearers(8,m) << 'electric.wav'
					if(m.part_selected) m.part_selected.update_part_stats(m) //Update the reward for completing training on this body part.
			New()
				..()
				category = list("Force","Agility","Buff")
				spawn(10)
					src.info = text_focus


					if(src.disable_sleep) return
					spawn(10)
						while(src)
							var/mob/m = null
							if(ismob(src.loc))
								m = src.loc
								if(src.active)
									var/removes = (10/m.mod_recovery) + (10/src.skill_lvl)
									if(m.energy >= removes)
										//m.energy-=5+((m.energy_max/5)/src.skill_lvl)/m.mod_recovery/m.mod_energy
										//var/removes = 1 + 10 - (m.mod_recovery+m.mod_energy) - (src.skill_lvl/10)
										m.energy -= removes
										//world << "[removes] energy removed by [src]"
										//m << output("<font color = teal>[removes] energy removed by [src]","chat.system")
										if(m.meditating)
											var/proceed = 1
											for(var/obj/items/tech/Regeneration_Tank/t in range(2,m))
												if(bounds_dist(t, m) < 3)
													proceed = 0
											if(proceed)
												//animate(m,pixel_y = 2, time = 10)
												//animate(m,pixel_y = 10, time = 11)
												if(m.reflection) animate(m.reflection,pixel_y = 10, time = 11)
										//src.skill_exp += (5-(src.skill_lvl/20))*m.mod_skill
										m.gain_stat("force",1,1,"From Focus skill")
										//src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
										src.skill_exp += (2.5-(src.skill_lvl/40)*m.mod_skill)+0.025
										if(src.skill_exp >= 100 && src.skill_lvl < 100)
											src.skill_exp = 1
											src.skill_lvl += 1
											src.skill_up(m)
										if(m.energy < 1)
											m.mouse_dir = "left"
											call(src.act)(m,src)
									else
										m.mouse_dir = "left"
										call(src.act)(m,src)
							sleep(5)
							if(m) if(src.active) if(m.meditating)
								var/proceed = 1
								for(var/obj/items/tech/Regeneration_Tank/t in range(2,m))
									if(bounds_dist(t, m) < 3)
										proceed = 0
								if(proceed)
									//animate(m,pixel_y = 0, time = 11)
									if(m.reflection) animate(m.reflection,pixel_y = 0, time = 11)
							sleep(5)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(m.skill_focus == null) m.skill_focus = src
							call(src.act)(m,src)

		Planetary_Genesis
			//Realms could also just be new planets the player creates, with more limited rules. But cost much less investment.
			icon_state = "Planetary Genesis off"
			info_energy_cost = 1
			info_mastery = 1
			info_point_cost = 3
			teach_energy = 1500
			info_buffs = "+20% Force"
			info_duration = "Toggleable"
			info_point_cost_type = "force"
			info_name = "planetary genesis"
			act = /obj/skills/Planetary_Genesis/proc/activate
			info_stats = "+20% Force\n\nConstant energy drain\n\nToggleable"
			//hud_x = 20
			//hud_y = 636
			proc
				activate(var/mob/m,var/obj/s)
			New()
				..()
				category = list("Force","Agility","Buff")
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(m.skill_focus == null) m.skill_focus = src
							call(src.act)(m,src)
		Psi_Storm
			name = "Psi Storm"
			icon_state = "Psi Storm off"
			disabled_switch = 1;
			info_energy_cost = 4
			info_dmg = 3
			info_spd = 1
			info_mastery = 1
			info_point_cost = 3
			info_point_cost_type = "force"
			info_name = "psi_storm"
			info_prerequisite = list("Psi Lightning")
			info_stats = "Energy Cost: Very High\n\nDamage: High\n\nSpeed: Slow\n\nMastery: Very Slow\n\nToggleable"
			energy_skill = 1
			teach_energy = 1000
			cd_max = 6000
			hud_x = 68
			hud_y = 492
			New()
				..()
				category = list("Energy","Utility","Offence","Agility")
				spawn(10)
					src.info = text_super_speed


			Click(location,control,params)
				..()
				if(ismob(src.loc))
					return
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(m.loc)
								if(src.cd_state < 32)
									m << output("<font color = teal>Skill is on cooldown, please wait.","chat.system")
									src.icon_state = "cd"
									spawn(3)
										if(src) src.icon_state = "Psi Storm off"
									return
								if(m.skill_lightning_storm == null) m.skill_lightning_storm = src
								m.skill_cooldown(src)
								var/turf/t = m.loc
								m.cloud_circle()
								t.storm_psionic()
		Explosion
			icon_state = "Explosion off"
			disabled_ko = 0
			info_energy_cost = 2
			info_dmg = 2
			info_spd = 5
			info_mastery = 2
			info_point_cost = 3
			teach_energy = 1500
			info_point_cost_type = "force"
			info_name = "explosion"
			info_prerequisite = list("Telekinesis")
			info_stats = "Energy Cost: Medium\n\nDamage: Medium\n\nSpeed: Instant\n\nMastery: Medium\n\nToggleable"
			info = ""
			act = /obj/skills/Explosion/proc/activate
			energy_skill = 1
			disabled_switch = 1
			cd_max = 200
			hud_x = 164
			hud_y = 492
			proc
				activate(var/mob/m,var/obj/s)
					if(m.skill_explosion == null) m.skill_explosion = s
					if(s.active)
						s.active = 0
						s.icon_state = "Explosion off"
					else
						s.icon_state = "Explosion"
						s.active = 1
			New()
				..()
				category = list("Force","Offence")
				spawn(10)
					src.info = text_super_speed


			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Beam
			icon_state = "Beam off"
			disabled_ko = 1
			act = /obj/skills/Beam/proc/activate
			info_energy_cost = 4
			info_dmg = 3
			info_spd = 1
			info_mastery = 2
			info_point_cost = 5
			info_point_cost_type = "force"
			info_cd = 0
			info_name = "beam"
			info_prerequisite = list("Blast")
			info_stats = "Energy Cost: High\n\nDamage: High\n\nSpeed: Slow\n\nMastery: Medium\n\nToggleable\n\nChargeable"
			info = "Gather, condense and form psionic power into a deadly ball before unleashing the pent up force as a beam of energy. It does 50% of the users Force stat in damage to anything it hits every 0.1 seconds. You can charge this skill by holding the left mouse button. Releasing the button will fire the skill. Charge time is quicker the higher your Recovery stat is."
			energy_skill = 1
			teach_energy = 1000
			disabled_switch = 1
			attack_state = "beam"
			var/tmp/list/parts = list()
			hud_x = 212
			hud_y = 540
			proc
				activate(var/mob/m)
					if(src in m)
						if(m.active_attack) return
						if(m.energy <= 10) return
						if(m.koed || m.stunned || m.meditating) return
						if(m.skill_beam == null) m.skill_beam = src

						//Beam stages
						//How it looks when it starts
						//How it looks as it expands
						//How it looks when finished.

						var/obj/ball = new
						ball.icon = 'beam_charge.dmi'
						for(var/obj/body_related/ascension_milestones/a in m.ascensions)
							if(a.major_ascension && a.icon_state == "ascension" && a.level > 0)
								ball.icon_state = "divine"
								ball.plane = 2
								break
							else
								ball.icon_state = "psionic"
								ball.plane = 1
						ball.pixel_x = -48
						ball.pixel_y = -48
						ball.transform*=0.1
						ball.bolted = 2
						ball.density_factor = -1

						m.active_attack = src
						m.icon_state = m.state()
						m << output("Current attack is [src], [m.active_attack]", "chat.system")

						var/obj/ball_hit = new
						ball_hit.icon = 'beam_charge.dmi'
						for(var/obj/body_related/ascension_milestones/a in m.ascensions)
							if(a.major_ascension && a.icon_state == "ascension" && a.level > 0)
								ball_hit.icon_state = "divine"
								ball_hit.plane = 2
								break
							else
								ball_hit.icon_state = "psionic"
								ball_hit.plane = 1
						ball_hit.pixel_x = -48
						ball_hit.pixel_y = -48
						ball_hit.transform*=0.1
						ball_hit.density_factor = -1
						ball_hit.bolted = 2

						var/obj/beam = new
						beam.icon = 'beam_body_new.dmi'
						for(var/obj/body_related/ascension_milestones/a in m.ascensions)
							if(a.major_ascension && a.icon_state == "ascension" && a.level > 0)
								beam.icon_state = "divine"
								beam.plane = 2
								break
							else
								beam.icon_state = "psionic"
								beam.plane = 1
						beam.pixel_y = -48
						beam.bolted = 2
						beam.density_factor = -1
						beam.transform*=0.1

						var/obj/ranged/checker/checker = new
						checker.origin = m
						checker.KB_furrow = 1
						//checker.density_factor = -1
						var/steps = 0

						//var/list/visited_x = list()
						//var/list/visited_y = list()

						var/obj/ray = new
						ray.loc = m.loc
						ray.bolted = 2
						ray.icon = 'fx_ray.dmi'
						ray.pixel_x = -144
						ray.pixel_y = -144
						ray.filters += filter(type="rays",x=0,y=0,size=96,color=rgb(255,255,255),offset=0,density=10,threshold=0.7,factor=0,flags=FILTER_OVERLAY)
						animate(ray.filters[1],offset = 100,time = 1000, loop = -1)
						animate(offset = 0,time = 0)

						src.parts = list(ball,ball_hit,beam,checker,ray)

						var/pix_max = 0.1;
						var/trans_max = 1;
						var/trans_extra = 0;
						var/pix = 0.1
						var/trans = 0.1

						//Controls beam sizes and pulsations
						var/size = 0.1
						var/size_upper = 0.1
						//var/size_dir = 0

						var/hov_dis = 16
						//var/hov_dis_extra = 0;

						//var/charging = 0; //If the attack is charging, increase its size and offset the assets correctly.
						var/fired = 0;
						var/stopping = 0;
						var/charge_check = 1;
						var/too_close = 0
						var/turf/t = null

						var/go = 1

						while(go == 1)
							var/e = (0.5/m.mod_recovery)+(0.5/src.skill_lvl)
							//While this skill is active, give some exp.
							src.skill_exp += ((0.1-(src.skill_lvl/100))*m.mod_skill)+0.1

							if(src.skill_exp >= 100 && src.skill_lvl < 100)
								src.skill_exp = 1
								src.skill_lvl += 1
								src.skill_up(m)
							//Once we reach 0 size, the attack is finished and considered ended.
							if(size <= 0)
								size = 0;
								if(ray) ray.loc = null
								del(beam)
								del(ball)
								del(ball_hit)
								checker.origin = null
								checker.loc = null
								//del(checker)
								m.icon_state = m.state()
								return

							//If the player doesn't have enough energy while firing or charging, or they become stunned, ect, then force the ball and beams to shrink and vanish.
							if(m.energy <= e) m.active_attack = null
							if(m.koed || m.stunned || m.meditating) m.active_attack = null
							if(!ball)
								m.active_attack = null
								go = 0;
								return;

							//Otherwise continue
							else
								//m.dir = get_dir(m,m.mouse_saved_loc)
								switch(m.mouse_degree-180)
									if(0 to 44) m.dir = WEST
									if(45 to 135) m.dir = NORTH
									if(136 to 225) m.dir = EAST
									if(226 to 315) m.dir = SOUTH
									if(316 to 360) m.dir = WEST
								m.update_wings()

								//Check if the attack is active. If its not, it means player canceled the attack or something else happened.
								if(m.active_attack == null)
									if(stopping == 0)
										stopping = 1
										for(var/mob/h in view(8,m))
											h << sound(null, channel=3)

								var/move_x = hov_dis * cos(m.mouse_degree)
								var/move_y = hov_dis * sin(m.mouse_degree)

								//world << "Beam charge size removes [removes_charging]"

								ball.Move(m.loc, 0, m.step_x + move_x, m.step_y - move_y)
								if(ray && ray.loc)
									ray.loc = ball.loc
									ray.step_x = ball.step_x
									ray.step_y = ball.step_y

								//If the beam is canceled for any reason, force the ball and ball_hit to shrink and make the size reduce for the beam and balls.
								if(stopping >= 1)
									hov_dis -= 0.075
									size -= size_upper/20
									trans_extra -= 0.034 //240/88 = 2.727. Then divided by 8, which is the steps. Equals 0.34

									if(hov_dis <= 16) hov_dis = 16

									var/matrix/B = matrix()
									B.Scale(size,size)
									ball.transform = B

									var/matrix/B_H = matrix()
									B_H.Scale(size,size)
									ball_hit.transform = B_H

								//If the attack is on-going and the player has their mouse held down, charge the attack and make it bigger.
								else if(m.mouse_down)
									//if(size == 0.1)
										//for(var/mob/h in view(8,m))
											//h << sound('activate.mp3',1,0,3,100)
									var/matrix/B = matrix()
									B.Scale(size,size)
									ball.transform = B

									var/matrix/B_H = matrix()
									B_H.Scale(size,size)
									ball_hit.transform = B_H

									hov_dis += 0.075*m.mod_recovery
									size += 0.001*m.mod_recovery
									//Increase the charge lvl of the attack, and its dmg, then check if the rounded charge lvl of the attack is higher than when we looked last. Only looking for whole increases.
									checker.charge_lvl += 0.01*m.mod_recovery
									checker.ki_force = (m.force/100)*checker.charge_lvl
									checker.force_usage = m.mod_force_usage
									checker.ki_power = m.psionic_power
									var/charge_rounded = round(checker.charge_lvl)
									if(charge_rounded > charge_check)
										charge_check = charge_rounded
										m.charge_nums("<font color = green>x[charge_check]")
										//world << "Beam charge lvl is [checker.charge_lvl] and rounded it is [round(checker.charge_lvl)]"
									m.energy -= e*checker.charge_lvl
									size_upper += 0.001*m.mod_recovery
									if(size >= 1) size = 1;
									//issue is trans_extra
									//if(size > 0.2) m.mouse_down = null
									if(size < 1) trans_extra += 0.034*m.mod_recovery //240/88 = 2.727. Then divided by 8, which is the steps. Equals 0.34

									if(hov_dis >= 80) hov_dis = 80 //Max 80 seems good

									//Create cool gathering energy effect around the main charging orb.
									if(prob(10))
										if(ball && isturf(ball.loc))
											var/obj/orb = null
											if(ball.icon_state == "psionic") orb = new /obj/effects/orb
											else if(ball.icon_state == "divine") orb = new /obj/effects/orb_divine
											orb.loc = ball.loc
											orb.step_x = ball.step_x
											orb.step_y = ball.step_y
											orb.pixel_x = rand(-64,64)
											orb.pixel_y = rand(-64,64)
											animate(orb,pixel_x = 0, pixel_y = 0, alpha = 0, time = 10)
											spawn(10)
												if(orb) orb.loc = null//del(o)
								//If the beam isn't canceled and the mouse isn't held, then fire the attack.
								else if(fired <= 0)
									//for(var/mob/h in view(8,m))
										//h << sound('beam1.mp3',1,0,3,100)
									fired = 1
									if(ray && ray.loc) ray.loc = null
									var/obj/effects/hit/h = new
									h.loc = m.loc
									h.dir = m.dir
									if(m.dir == SOUTH ||m.dir == NORTH) h.pixel_x += 16
									h.step_x = m.step_x
									h.step_y = m.step_y
									spawn(10)
										if(h) h.destroy()

								//This is still executed, even if the player stops or starts charging again.
								if(fired >= 1)
									pix_max = 0.1;
									trans_max = 1-trans_extra
									//if(trans_max >= 240) trans_max = 1
									//else trans_max = 1-trans_extra;
									t = get_step(m,m.dir)
									too_close = 0
									if(t && t.density || t.density_factor == 2)
										checker.loc = null
										too_close = 1
									else
										//The checker's position is reset every loop, ready to travel out and plot a course.
										checker.loc = m.loc
										checker.step_x = m.step_x
										checker.step_y = m.step_y

									m.energy -= e*checker.charge_lvl
									//world << "Beam firing removes [removes]"

									//Sends an obj out to seek obstacles. Tracks how long the beam will be.
									while(checker.loc)
										pix_max += 21/88 //This is derived from 20*24, which is 480, +5% for adjustments
										if(pix_max >= 15) pix_max = 15
										trans_max += 336/88 //This is derived from 480/1.5, then + 5% for adjustments.
										//if(trans_max >= 245) trans_max = 245; //Half of the beam length in pixels
										if(trans_max >= 240) trans_max = 240; //Half of the beam length in pixels - This is the og setting
										steps += 8
										var/m_x = steps * cos(m.mouse_degree)
										var/m_y = steps * sin(m.mouse_degree)
										checker.Move(m.loc, 0, m.step_x + m_x, m.step_y - m_y)
										if(prob(1)) checker.dust_and_furrows(pick(1,2,3,4,5,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0))
										/*
										if(visited_x.Find(checker.step_x) == 0 && visited_y.Find(checker.step_y) == 0)
											checker.dust_and_furrows(0)
											visited_x += checker.step_x
											visited_y += checker.step_y
										*/
										if(steps >= 705) checker.loc = null //88 steps to reach 704, 8*88 = 704+1

									//Make sure we're not too close to a solid turf.
									if(too_close == 0)
										//Once we know how far and long the beam can travel, cap it off with an end graphically
										//var/b_x = ((pix*32)+(trans_max/10)) * cos(m.mouse_degree)
										//var/b_y = ((pix*32)+(trans_max/10)) * sin(m.mouse_degree)
										var/b_x = ((pix*32)+16) * cos(m.mouse_degree)// - og setting
										var/b_y = ((pix*32)+16) * sin(m.mouse_degree)// - og setting
										ball_hit.Move(m.loc, 0, m.step_x + b_x, m.step_y - b_y)
										ball_hit.layer = 6
									else ball_hit.loc = null

									steps = 0

									//Stretch out the beam graphically to the length of the plotted course, then set its location a tiny bit away from the caster.

									size = clamp(size,0,1) //Make sure beam has a max size

									var/matrix/M = matrix()
									M.Scale(pix,size)
									M.Translate(trans,0)
									M.Turn(m.mouse_degree)
									beam.transform = M

									//beam.filters = list(filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(255,255,170)))
									//beam.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)

									beam.Move(m.loc, 0, m.step_x + move_x, m.step_y - move_y)

									pix += 1
									pix = clamp(pix,0,pix_max)
									//world << "pix = [pix], trans = [trans], size = [size]"
									trans += 16
									trans = clamp(trans,0,trans_max)
							sleep(0.1)
			New()
				..()
				category = list("Force","Offence")
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(src.active)
								src.active = 0
								if(src == m.current_attack) m.current_attack = null
								if(src == m.active_attack) m.active_attack = null
								src.icon_state = "Beam off"
							else
								src.icon_state = "Beam"
								m.current_attack = src
								src.active = 1
								m.toggle_skill(src)
		Eye_Laser_Test
			icon_state = "Beam off"
			disabled_ko = 1
			act = /obj/skills/Eye_Laser_Test/proc/activate
			info_energy_cost = 4
			info_dmg = 3
			info_spd = 1
			info_mastery = 2
			info_point_cost = 5
			info_point_cost_type = "force"
			info_cd = 0
			info_name = "beam"
			info_prerequisite = list("Blast")
			info_stats = "Energy Cost: High\n\nDamage: High\n\nSpeed: Slow\n\nMastery: Medium\n\nToggleable\n\nChargeable"
			info = "Gather, condense and form psionic power into a deadly ball before unleashing the pent up force as a beam of energy. It does 50% of the users Force stat in damage to anything it hits every 0.1 seconds. You can charge this skill by holding the left mouse button. Releasing the button will fire the skill. Charge time is quicker the higher your Recovery stat is."
			energy_skill = 1
			teach_energy = 1000
			disabled_switch = 1
			attack_state = ""
			var/tmp/list/parts = list()
			//hud_x = 212
			//hud_y = 540
			proc
				activate(var/mob/m)
					if(src in m)
						if(m.active_attack) return
						if(m.energy <= 10) return
						if(m.koed || m.stunned || m.meditating) return

						//Beam stages
						//How it looks when it starts
						//How it looks as it expands
						//How it looks when finished.

						m.active_attack = src
						m.icon_state = m.state()
						m << output("Current attack is [src], [m.active_attack]", "chat.system")

						var/obj/beam = new
						beam.icon = 'eye_lasers.dmi'
						//beam.blend_mode = BLEND_INSET_OVERLAY
						//beam.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
						//beam.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
						for(var/obj/body_related/ascension_milestones/a in m.ascensions)
							if(a.major_ascension && a.icon_state == "ascension" && a.level > 0)
								beam.icon_state = "divine"
								beam.plane = 2
								break
							else
								beam.icon_state = "all dir"
								beam.plane = 1
						beam.pixel_y = 4
						beam.bolted = 2
						beam.density_factor = -1

						var/obj/ranged/checker/checker = new
						checker.origin = m
						checker.KB_furrow = 1
						var/steps = 0
						checker.charge_lvl += 0.01*m.mod_recovery
						checker.ki_force = (m.force/100)*checker.charge_lvl
						checker.force_usage = m.mod_force_usage
						checker.ki_power = m.psionic_power

						src.parts = list(beam,checker)

						var/pix_max = 0.1;
						var/trans_max = 1;
						var/trans_extra = 0;
						var/pix = 0.1
						var/trans = 0.1


						var/hov_dis = 1
						var/fired = 1;
						var/turf/t = null
						var/stop = 0

						var/go = 1

						while(go == 1)
							var/e = (0.5/m.mod_recovery)+(0.5/src.skill_lvl)

							//While this skill is active, give some exp.
							src.skill_exp += ((0.1-(src.skill_lvl/100))*m.mod_skill)+0.1

							if(src.skill_exp >= 100 && src.skill_lvl < 100)
								src.skill_exp = 1
								src.skill_lvl += 1
								src.skill_up(m)

							//If the player doesn't have enough energy while firing or charging, or they become stunned, ect, then force the attack to stop.

							if(m.energy <= e) stop = 1
							if(m.koed || m.stunned || m.meditating) stop = 1
							if(m.active_attack == null) stop = 1
							if(stop)
								del(beam)
								checker.origin = null
								checker.loc = null
								m.icon_state = m.state()
								return

							m.dir = Directions.FromDegreesToCardinal(m.mouse_degree)//get_dir(m,m.mouse_saved_loc)
							m.update_wings()

							var/move_x = hov_dis * cos(m.mouse_degree)
							var/move_y = hov_dis * sin(m.mouse_degree)

							//This is still executed, even if the player stops or starts charging again.
							if(fired >= 1)
								pix_max = 0.1;
								trans_max = 1-trans_extra
								t = get_step(m,m.dir)
								if(t && t.density || t.density_factor == 2)
									checker.loc = null
								else
									//The checker's position is reset every loop, ready to travel out and plot a course.
									checker.loc = m.loc
									checker.step_x = m.step_x
									checker.step_y = m.step_y

								m.energy -= e*checker.charge_lvl

								//Sends an obj out to seek obstacles. Tracks how long the beam will be.
								while(checker.loc)
									pix_max += 21/88 //This is derived from 20*24, which is 480, +5% for adjustments
									if(pix_max >= 15) pix_max = 15
									trans_max += 336/88 //This is derived from 480/1.5, then + 5% for adjustments.
									//if(trans_max >= 245) trans_max = 245; //Half of the beam length in pixels
									if(trans_max >= 240) trans_max = 240; //Half of the beam length in pixels - This is the og setting
									steps += 8
									var/m_x = steps * cos(m.mouse_degree)
									var/m_y = steps * sin(m.mouse_degree)
									checker.Move(m.loc, 0, m.step_x + m_x, m.step_y - m_y)
									if(prob(1)) checker.dust_and_furrows(pick(1,2,3,4,5,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0))
									if(steps >= 705) checker.loc = null //88 steps to reach 704, 8*88 = 704+1

								steps = 0

								//Stretch out the beam graphically to the length of the plotted course, then set its location a tiny bit away from the caster.

								//beam.filters = null

								var/d = m.get_mouse_degree_from_player(m.mouse_x,m.mouse_y,m.mouse_pix_x,m.mouse_pix_y)

								var/matrix/M = matrix()
								M.Scale(pix,1)
								M.Translate(trans,0)
								M.Turn(d)//m.mouse_degree)
								beam.transform = M


								//beam.filters = list(filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204)),filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175))
								if(beam.dir == NORTH) beam.Move(m.loc, 0, m.step_x + move_x, m.step_y - move_y + 5)
								else beam.Move(m.loc, 0, m.step_x + move_x, m.step_y - move_y)

								switch(d)
									if(0 to 44) m.dir = EAST
									if(45 to 135) m.dir = SOUTH
									if(136 to 225) m.dir = WEST
									if(226 to 315) m.dir = NORTH
									if(316 to 360) m.dir = EAST

								pix += 1
								pix = clamp(pix,0,pix_max)
								trans += 16
								trans = clamp(trans,0,trans_max)
							sleep(0.1)
			New()
				..()
				category = list("Force","Offence")
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(src.active)
								src.active = 0
								if(src == m.current_attack) m.current_attack = null
								if(src == m.active_attack) m.active_attack = null
								src.icon_state = "Beam off"
							else
								src.icon_state = "Beam"
								m.current_attack = src
								src.active = 1
								m.toggle_skill(src)
		Eye_Laser
			icon_state = "Explosion off"
			disabled_ko = 1
			act = /obj/skills/Eye_Laser/proc/activate
			info_energy_cost = 4
			info_dmg = 3
			info_spd = 3
			info_mastery = 1
			info_point_cost = 5
			info_point_cost_type = "force"
			info_name = "laser"
			info_prerequisite = list("Beam")
			energy_skill = 1
			disabled_switch = 1
			var/list/segments
			proc
				activate(var/mob/m)
					if(src in m)
						if(m.active_attack) return
						if(m.koed || m.stunned || m.meditating) return
						m.active_attack = src
						var/obj/eyes = new
						//if(m.race == "Cerebroid") eyes.icon = 'goog_eye_glow.dmi'
						eyes.icon = 'humanoid_eyes_glow.dmi'
						eyes.filters += filter(type="outline", size=1, color=rgb(118,66,138))
						eyes.plane = 1;
						m.overlays += eyes
						var/pix_y = 3
						var/pix_x = 0;
						if(m.race == "Cerebroid")
							pix_y = 17;
							pix_x = 6;
						var/go = 1
						while(go == 1)
							var/di = 0
							di = m.mouse_degree
							m.dir = get_dir(m,m.mouse_saved_loc)
							if(src)
								src.skill_exp += (1/src.skill_lvl)*m.mod_skill
								if(src.skill_exp >= 100 && src.skill_lvl < 100)
									src.skill_exp = 1
									src.skill_lvl += 1
								var/e = (1/m.mod_recovery)+(1/src.skill_lvl)
								if(m.mouse_saved_loc)
									m.energy -= e
									//Grab any beams that got removed from play for any reason and put them back into play, unless the player canceled use of the skill.
									var/fly = 0;
									if(m.skill_flight && m.skill_flight.active) fly = 1;
									if(m.race == "Cerebroid")
										if(m.dir == WEST || m.dir == NORTHWEST || m.dir == SOUTHWEST) pix_x = 0
										else pix_x = 6
									for(var/obj/ranged/eye_laser/o in src.segments)
										if(o.loc == null && m.active_attack)
											o.loc = m.loc
											o.ki_owner = m
											o.pix_away = 18
											o.finishing = 0
											o.fired = 1;
											o.alpha = 255;
											if(fly) o.pixel_y = pix_y+5
											else o.pixel_y = pix_y
											o.pixel_x = pix_x
											//Because eye lasers don't have a charge phase, we can apply the damage here. Other beams must have their damage updated on impact instead.
											o.charge_lvl += 1*m.mod_recovery
											o.ki_power = m.psionic_power
											o.ki_force = (m.force/10)*o.charge_lvl
											o.force_usage = m.mod_force_usage
											o.ki_offence = m.offence
											o.ki_agility = m.mod_agility
											//o.MoveAngInstant(di,o.pix_away,0,0,null)
											break
								var/matrix/M = matrix()
								M.Turn(di)
								for(var/obj/ranged/eye_laser/o in src.segments)
									if(o.loc)
										//If the player has enough energy, move all the beams in a straight line and adjust the location if the player rotates the origin point.
										o.loc = m.loc
										o.step_x = m.step_x
										o.step_y = m.step_y
										o.MoveAngInstant(di,o.pix_away,0,0,null)
										o.dir = m.dir
										//var/matrix/M = matrix()
										//var/t = 0
										//M.Turn(di)
										if(o.finishing == 0)
											o.pix_away += 12
											if(o.pix_away >= 500)
												o.loc = null
											if(m.active_attack == null) //If the attack is canceled for any reason, force all the beam segments to shrink and vanish. (Beams no longer move further than where they are, because pix_away is no longer increasing.)
												o.finishing = 1
												go = 0
												animate(o,alpha = 0,time = 5)
												spawn(5)
													if(o) o.loc = null
										o.transform = M
								//If the player doesn't have enough energy while firing or charging, force the ball and beams to shrink and vanish.
								if(m.energy <= 1) m.active_attack = null
								if(m.koed || m.stunned || m.meditating) m.active_attack = null
							else
								m.active_attack = null
								go = 0;
								return
							sleep(0.1)
						m.overlays -= eyes
						del(eyes)
			New()
				..()
				category = list("Force","Offence")
				spawn(10)
					src.info = text_super_speed


					src.segments = list()
					var/n = 42
					while(n)
						n -= 1
						var/obj/ranged/eye_laser/l = new
						src.segments += l
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(src.active)
								src.active = 0
								if(src == m.current_attack) m.current_attack = null
								src.icon_state = "Explosion off"
							else
								src.icon_state = "Explosion"
								m.current_attack = src
								src.active = 1
								m.toggle_skill(src)
		Piercing_Beam
			icon_state = "Explosion off"
			disabled_ko = 1
			act = /obj/skills/Piercing_Beam/proc/activate
			info_energy_cost = 4
			info_dmg = 4
			info_spd = 3
			info_mastery = 1
			info_point_cost = 5
			info_point_cost_type = "force"
			info_name = "piercing_beam"
			info_prerequisite = list("Beam")
			energy_skill = 1
			disabled_switch = 1
			proc
				activate(var/mob/m)
					return
					if(src in m)
						if(m.active_attack) return
						if(m.koed || m.stunned || m.meditating) return
						var/obj/ranged/beam_charge/b = new
						b.ki_owner = m
						if(m.skill_flight && m.skill_flight.active) m.icon_state = "fly blast"
						else m.icon_state = "blast"
						m.active_attack = b
						var/matrix/trix = matrix()
						trix.Scale(0,0)
						b.transform = trix
						var/list/beam_list = list()
						b.pix_away = 18
						var/go = 1;
						while(go == 1)
							var/di = 0
							var/b_num = 0
							//If the charge ball exists, move it relative to player mouse position and continue with the rest of the code.
							if(b)
								src.skill_exp += (1/src.skill_lvl)*m.mod_skill
								if(src.skill_exp >= 100 && src.skill_lvl < 100)
									src.skill_exp = 1
									src.skill_lvl += 1
								b.loc = m.loc
								m.dir = get_dir(m,m.mouse_saved_loc)
								di = m.mouse_degree//m.GetAngleStep(m.mouse_saved_loc)
								b.step_x = m.step_x
								b.step_y = m.step_y
								b.MoveAng(di,b.pix_away,0,0,null)
								if(b.fired == 0)
									b.shockwave()
									var/matrix/M = matrix()
									M.Scale(0.1,0.1)
									animate(b,transform = M,time = 5)
									b.size = 0.2
									b.charge_lvl = 5
									b.fired = 1
									spawn(5)
										if(b) b.fired = 2
								src.skill_exp += (1/src.skill_lvl)*m.mod_skill
								if(src.skill_exp >= 100 && src.skill_lvl < 100)
									src.skill_exp = 1
									src.skill_lvl += 1
								b.loc = m.loc
								m.dir = get_dir(m,m.mouse_saved_loc)
								di = m.mouse_degree//m.GetAngleStep(m.mouse_saved_loc)
								b.step_x = m.step_x
								b.step_y = m.step_y
								b.MoveAng(di,b.pix_away,0,0,null)
								if(b.fired == 2)
									for(var/obj/ranged/beam/o in beam_list)
										//If the player has enough energy, move all the beams in a straight line and adjust the location if the player rotates the origin point.
										var/t = 0
										b_num += 1
										o.icon = 'beam_body_sharp.dmi'
										var/icon/I_start = new(o.icon)
										I_start.Turn(di)
										o.icon = I_start
										if(o.finishing == 0)
											if(m.active_attack == null) //If the attack is canceled for any reason, force all the beam segments to shrink and vanish.
												o.finishing = 1
												var/matrix/M2 = matrix()
												M2.Scale(0,0)
												animate(o,transform = M2,time = 10)
												t = 10
												o.hit_solid = 1
										o.loc = b.loc
										o.step_x = b.step_x
										o.step_y = b.step_y
										o.ki_power = m.psionic_power
										o.ki_force = (m.force/10)*b.charge_lvl
										o.force_usage = m.mod_force_usage
										o.ki_offence = m.offence
										o.ki_agility = m.mod_agility
										o.MoveAngInstant(di,o.pix_away,0,0,null)
										if(o.finishing == 0)
											o.pix_away += 32
											if(o.pix_away >= 500)
												o.hit_solid = 1
										if(o.hit_solid == 1)
											o.hit_solid = 2
											spawn(t)
												if(o)
													o.loc = null
													o.suffix = null
													o.fired = 0;
													b_num -= 1
													beam_list -= o
									//If the attack was canceled, or the player ran out of energy during charging or firing, force the attack segements to shrink and vanish.
									if(m.active_attack == null)
										if(b.finishing == 0)
											m.icon_state = m.state()
											var/matrix/M = matrix()
											M.Scale(0,0)
											animate(b,transform = M,time = 10)
											b.finishing = 1
											spawn(10)
												if(b)
													go = 0
													del(b)
									var/e = ((1/m.mod_recovery)+(1/src.skill_lvl)*b.charge_lvl)
									if(m.mouse_saved_loc)
										if(b.fired)
											m.energy -= e
											if(b_num < 30 && b.finishing == 0)
												//Make sure we have no more than 40 beam segements and create them as needed.
												for(var/obj/ranged/beam/o in beams)
													if(o.loc == null && o.suffix == null)
														o.icon = 'beam_body_sharp.dmi'
														o.pixel_x = -16
														o.pixel_y = -16
														o.suffix = "in use"
														var/matrix/M = matrix()
														M.Scale(1,1)
														o.transform = M
														beam_list += o
														b_num += 1
														o.ki_owner = m
														o.pix_away = 32
														o.finishing = 0
														o.hit_solid = 0
														break
								//If the player doesn't have enough energy while firing or charging, force the ball and beams to shrink and vanish.
								if(m.energy <= 1) m.active_attack = null
								if(m.koed || m.stunned || m.meditating) m.active_attack = null
							else
								go = 0
								m.active_attack = null
								return
							sleep(0.1)
			New()
				..()
				category = list("Force","Offence")
				spawn(10)
					src.info = text_super_speed


			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(src.active)
								src.active = 0
								if(src == m.current_attack) m.current_attack = null
								src.icon_state = "Explosion off"
							else
								src.icon_state = "Explosion"
								m.current_attack = src
								src.active = 1
								m.toggle_skill(src)
		Psychokinetic_Lash
			icon_state = "Telekinesis off"
			info_energy_cost = 1
			info_dmg = 1
			info_spd = 5
			info_mastery = 2
			teach_energy = 2000
			info_point_cost = 1
			info_point_cost_type = "force"
			info_name = "telekinesis"
			act = /obj/skills/Telekinesis/proc/activate
			hud_x = 164
			hud_y = 636
			/*
			Special form of Telekinesis that acts like the attack skill, but doesn't ever require the user to be near, or teleport near, the target. It also uses the force stat instead.
			     - Ranged
			     - Uses Force
			     - Doesn't warp player near target, unless they get knocked out of range, in which case, brings the user slightly closer instead
			     - Half-knock back
			     - Appears as a kind of purple slash/lash
			     - Uses a lot more energy than normal Attack skill
			     - Has a cooldown like super speed, which is based on Recovery stat
			*/
		Telekinesis
			icon_state = "Telekinesis off"
			info_energy_cost = 1
			info_dmg = 1
			info_spd = 5
			info_mastery = 2
			teach_energy = 2000
			info_point_cost = 1
			info_point_cost_type = "force"
			info_name = "telekinesis"
			act = /obj/skills/Telekinesis/proc/activate
			hud_x = 164
			hud_y = 636
			/*
			Redesign this, so you click something to activate it.
			Then you can do the normal stuff, like moving that item about with the mouse.
			However, double-clicking another turf or movable forces the item in your control to slam into it
			Right clicking the item you are controlling starts to dmg it
			Right clicking a mob will start to squeeze it like the wrestle system, and break limbs.
			Bonus, maybe at high lvls and stupid high force, can just pluck out eyes, ect.
			*/
			proc
				activate(var/mob/m,var/obj/s)
					return
					if(s in m)
						if(m.skill_tk == null) m.skill_tk = s
						if(s.active)
							s.active = 0
							s.icon_state = "Telekinesis off"
							m.drop_tk()
							//clear = 1
						else
							s.icon_state = "Telekinesis"
							s.active = 1
							m.left_click_function = "tk"
							m.set_alert("Select target",s.icon,s.icon_state)
							winshow(m,"skills",0)
							m.open_skills = 0
							m.open_menus.Remove(".open_skills")
			var
				tmp/mob/tether
				tk_mini = 0
				obj/tk_ring
			New()
				..()
				category = list("Energy","Force","Utility")
				spawn(10)
					if(src.spawned == 0)
						src.spawned = 1
						src.info = text_telekinesis


						/*
						var/obj/hud/minigames/tk/tk_pointer/H = new
						H.loc = src
						src.tk_pointer = H
						var/obj/hud/minigames/tk/tk_bar/H2 = new
						H2.loc = src
						var/obj/hud/minigames/tk/tk_range/H3 = new
						H3.loc = src
						src.tk_range = H3
						var/obj/hud/minigames/tk/tk_multi/H4 = new
						H4.loc = src
						*/
					var/obj/effects/minigames/tk_ring/ring = new
					src.tk_ring = ring
					if(ismob(src.loc)) src.tether = src.loc
					/*
					while(src)
						var/spd = 10
						if(src.active)
							spd = 0.1
							if(ismob(src.loc))
								var/mob/m = src.loc
								src.tk_ring.loc = m.loc
								src.step_x = m.step_x
								src.step_y = m.step_y
								var/list/items = list()
								for(var/obj/items/x in orange(4,m))
									if(x.bolted == 0) if(x.bolted != 5)
										if(get_dist(x,m) == 3)
											//x.tk_pos = pick(m.tk_spaces)
											//m.tk_spaces -= x.tk_pos
											//x.tk_pos = text2num(x.tk_pos)
											m.tk_minigame += x
											x.tk = 1
											x.bolted = 5
											x.density_factor = 0
											animate(x, pixel_z = 16, time = 1)
											var/obj/effects/dust_medium/d = new
											d.pixel_x -= 10
											d.loc = x.loc
											d.step_x = x.step_x
											d.step_y = x.step_y
											items += x
											sleep(2)
								sleep(1)
								for(var/obj/i in items)
									var/d = m.GetAngle(i.loc)
									var/turf/t = orbit_pos(m,i,96,d)
									while(i.loc != t)
										i.MoveAngInstant(d,6,1,0,t)
										sleep(1)
									//world << "angle is [d]"
									orbiting(i,m, 6,96,d)
									//orbiting(i,m,6,96,i.tk_pos)
						sleep(spd)
					*/
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					//var/clear = 0
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"] || m.mouse_dir == "right")
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)

					if(dir == "right")
						m << "This minigame is being re-designed."
						src.tk_mini = 1
						m.tk_spaces = list("45","90","135","180","225","270","315","360")
						m.tk_minigame = list()
						return





						if(src.tutorial_shown == 0)
							src.tutorial_shown = 1
							winshow(m,"tutorial",1)
							winset(m,"tutorial.tutorial_title","text=\"[src.name] tutorial\"")
							winset(m,"tutorial.tutorial_info","text=\"[src.tutorial_text]\"")
						/*
						if(src.active) if(usr.minigame == null)
							m.minigame = "tk"
							var/turf/right = locate(m.x+src.spin_size,m.y,m.z)
							var/turf/left = locate(m.x-src.spin_size,m.y,m.z)
							var/turf/up = locate(m.x,m.y+src.spin_size,m.z)
							var/turf/down = locate(m.x,m.y-src.spin_size,m.z)
							src.positions = list(right,left,up,down)
							var/L = length(m.tk_minigame)
							for(var/obj/hud/minigames/H in src)
								m.client.screen += H
							if(L != 4)
								for(var/obj/items/I in orange(6,m))
									if(!m.tk_minigame.Find(I)) if(L != 4) if(I.bolted == 0) if(I.pos == null)
										m.tk_minigame.Add(I)
										L = length(m.tk_minigame)
										I.density_factor = 0
										I.tk = 1
										I.SetOrbitRadius(src.spin_size)
										var/turf/T = pick(src.positions)
										I.pos = T
										src.positions -= T
										I.dir = EAST
										if(I.pixel_z < 8)
											animate(I, pixel_z = 8, time = 2)
							else
								clear = 1
						else
							clear = 1
					if(clear)
						src.spin_speed = 4
						m.clear_minigame_tk()
					*/
		Telepathy
			icon_state = "Sense off"
			info_energy_cost = 1
			info_mastery = 1
			info_point_cost = 1
			info_buffs = "Instant communication"
			info_duration = "Toggleable"
			info_point_cost_type = "energy"
			info_name = "telepathy"
			teach_energy = 1000
			act = /obj/skills/Telepathy/proc/activate
			info_prerequisite = list("Sense")
			info_stats = "Instant communication\n\nNot usable on dead or sleeping"
			hud_x = 341
			hud_y = 588

			proc
				activate(var/mob/m,var/obj/s)
					if(s in m)
						if(m.skill_telepathy == null) m.skill_telepathy = s
						m.left_click_function = "telepath"
						winshow(m,"skills",0)
						m.open_skills = 0
						m.open_menus.Remove(".open_skills")
						m << output("Select someone to telepath by either clicking them directly, or their name in your contacts list.", "chat.system")
						m.set_alert("Select contact to telepath",s.icon,s.icon_state)
						//m.skill_ref = s
			New()
				..()
				category = list("Energy","Utility")
				spawn(10)
					if(src)
						src.info = text_telekinesis


						if(ismob(src.loc))
							var/mob/m = src.loc
							m.skill_telepathy = src
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"] || m.mouse_dir == "right")
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
					if(dir == "left")
						return
		Pyrokinesis
			icon_state = "Pyrokinesis off"
			act = /obj/skills/Pyrokinesis/proc/activate
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active)
						s.active = 0
					else
						s.icon_state = "Pyrokinesis"
						s.active = 1
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)

		Razor_Disk
			name = "Razor Disk"
			icon_state = "Charge off"
			repeat = 1;
			disabled_switch = 1;
			//act = /obj/skills/Razor_Disk/proc/activate
			info_energy_cost = 4
			info_dmg = 4
			info_spd = 1
			info_mastery = 1
			info_point_cost = 6
			info_point_cost_type = "force"
			info_name = "razor_disk"
			info_prerequisite = list("Charged Blast")
			disabled_switch = 1
			energy_skill = 1
			var
				tmp/obj/fly = null
			New()
				..()
				category = list("Force","Offence")
			Click(location,control,params)
				..()
				return
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(src.active)
								src.active = 0
								src.icon_state = "Charge off"
								if(src == m.current_attack) m.current_attack = null
								m.stop_charging()
							else
								src.icon_state = "Charge"
								src.active = 1
								m.current_attack = src;
								m.toggle_skill(src)
		Charge
			name = "Charged Blast"
			icon_state = "origin"
			disabled_switch = 1;
			act = /obj/skills/Charge/proc/activate
			info_energy_cost = 2
			info_dmg = 2
			info_spd = 2
			info_mastery = 2
			info_point_cost = 3
			info_point_cost_type = "force"
			info_name = "charged_blast"
			info_prerequisite = list("Blast")
			info_stats = "Energy Cost: Medium\n\nDamage: Medium\n\nSpeed: Medium\n\nMastery: Medium\n\nToggleable\n\nChargeable"
			info = "Gather, condense and form psionic power into a deadly ball before unleashing the pent up force. You can charge this skill by holding the left mouse button. Releasing the button will fire the skill. Charge time is quicker the higher your Recovery stat is."
			energy_skill = 1
			teach_energy = 600
			attack_state = "beam"
			cd_max = 200
			act = /obj/skills/Charge/proc/activate
			hud_x = 212
			hud_y = 588
			New()
				..()
				category = list("Force","Offence")
			proc
				activate(var/mob/m)
					if(src in m)
						if(m.active_attack) return
						if(m.koed || m.stunned || m.meditating) return
						if(m.can_ki == 0) return
						if(m.energy <= 10) return
						if(src.cd_state < 32)
							m << output("<font color = teal>Skill is on cooldown, please wait.","chat.system")
							//var/is = src.icon_state
							src.icon_state = "cd"
							spawn(3)
								if(src) src.icon_state = "Charge"
							return
						var/obj/ranged/beam_charge/b = new
						for(var/obj/body_related/ascension_milestones/a in m.ascensions)
							if(a.major_ascension && a.icon_state == "ascension" && a.level > 0)
								b.icon_state = "divine"
								b.plane = 2
								break
							else
								b.icon_state = "psionic"
								b.plane = 1
						b.ki_owner = m

						var/obj/ray = new
						ray.bolted = 2
						ray.icon = 'fx_ray.dmi'
						ray.pixel_x = -144
						ray.pixel_y = -144
						ray.filters += filter(type="rays",x=0,y=0,size=96,color=rgb(255,255,255),offset=0,density=10,threshold=0.7,factor=0,flags=FILTER_OVERLAY)
						animate(ray.filters[1],offset = 100,time = 1000, loop = -1)
						animate(offset = 0,time = 0)

						m.active_attack = b
						m.icon_state = m.state()
						m.can_ki = 0
						var/charge_check = 1;
						var/too_close = 0
						var/turf/t = null
						src.cd_max = (initial(src.cd_max)/m.mod_agility)/(1+src.skill_lvl/100)
						m.skill_cooldown(src)
						while(m)
							var/di = 0
							//If the charge ball exists, move it relative to player mouse position and continue with the rest of the code.
							if(b && b.expired == 0)
								var/e = ((1/m.mod_recovery)+(1/src.skill_lvl)*b.charge_lvl)
								if(b.fired == 0)
									//src.skill_exp += (1/src.skill_lvl)*m.mod_skill
									src.skill_exp += ((0.1-(src.skill_lvl/1000))*m.mod_skill)+0.1
									if(src.skill_exp >= 100 && src.skill_lvl < 100)
										src.skill_exp = 1
										src.skill_lvl += 1
										src.skill_up(m)
									b.loc = m.loc
									m.dir = get_dir(m,m.mouse_saved_loc)
									m.update_wings()
									di = m.mouse_degree//m.GetAngleStep(m.mouse_saved_loc)
									b.step_x = m.step_x
									b.step_y = m.step_y
									t = get_step(m,m.dir)
									too_close = 0
									if(t)
										if(t.density || t.density_factor == 2) too_close = 1
									if(too_close == 0) b.MoveAng(di,b.pix_away,0,0,null)
									b.ki_power = m.psionic_power
									b.ki_force = m.force*b.charge_lvl
									b.force_usage = m.mod_force_usage
									b.ki_offence = m.offence
									b.ki_agility = m.mod_agility

									ray.loc = m.loc
									ray.step_x = m.step_x
									ray.step_y = m.step_y
									ray.MoveAng(di,b.pix_away,0,0,null)

									//If the attack was canceled, or the player ran out of energy during charging or firing, force the attack to shrink and vanish.
									if(m.active_attack == null)
										if(b.finishing == 0)
											m.icon_state = m.state()
											//m.can_ki = 1
											var/matrix/M = matrix()
											M.Scale(0,0)
											animate(b,transform = M,time = 10)
											b.finishing = 1
											spawn(10)
												if(b)
													b.expired = 1
													b.destroy() //del(b)
												if(ray) ray.loc = null
												if(m) m.can_ki = 1
									//Continue to fire or charge the attack.
								if(m.mouse_down)
									if(b.just_started)
										b.shockwave()
										b.just_started = 0
									//Make the ball bigger and the charge lvl higher if players charged ball wasn't canceled for any reason.
									if(b.finishing == 0)
										if(b.size < 1)
											//Charge increase and displays charge lvl
											b.charge_lvl += 0.01*m.mod_recovery
											var/charge_rounded = round(b.charge_lvl)
											if(charge_rounded > charge_check)
												charge_check = charge_rounded
												m.charge_nums("<font color = green>x[charge_check]")
											//m << output("Charge lvl is [b.charge_lvl]", "chat.system")
											m.energy-=e
											b.size += 0.001*m.mod_recovery
											if(b.size > 1) b.size = 1
											var/matrix/M = matrix()
											M.Scale(b.size,b.size)
											b.transform = M
											b.pix_away += 0.07*m.mod_recovery
											if(b.pix_away >= 80) b.pix_away = 80
											//Create cool gathering energy effect
											if(prob(10))
												var/obj/orb = null
												if(b.icon_state == "psionic") orb = new /obj/effects/orb
												else if(b.icon_state == "divine") orb = new /obj/effects/orb_divine
												orb.loc = b.loc
												orb.step_x = b.step_x
												orb.step_y = b.step_y
												orb.pixel_x = rand(-64,64)
												orb.pixel_y = rand(-64,64)
												animate(orb,pixel_x = 0, pixel_y = 0, alpha = 0, time = 10)
												spawn(10)
													if(orb) orb.loc = null//del(o)
												/*
												for(var/obj/o in orbs)
													if(o.loc == null)
														o.alpha = 255;
														o.loc = b.loc
														o.step_x = b.step_x
														o.step_y = b.step_y
														o.pixel_x = rand(-32-b.pix_away,32+b.pix_away)
														o.pixel_y = rand(-32-b.pix_away,32+b.pix_away)
														animate(o,pixel_x = 0, pixel_y = 0, alpha = 0, time = 10)
														spawn(10)
															if(o) o.loc = null
														break
												*/
								else if(b.fired == 0 && m.active_attack)
									di = m.mouse_degree//b.GetAngleStep(m.mouse_saved_loc)
									b.ang = di
									b.fired = 1
									b.travel = 40
									b.explode_impact = 1
									b.go()
									m.active_attack = null
									m.icon_state = m.state()
									var/time = 10/m.mod_agility
									if(time < 1) time = 1
									spawn(time)
										if(m) m.can_ki = 1
									ray.loc = null
									return
								//If the player doesn't have enough energy while firing or charging, force the ball and beams to shrink and vanish.
								if(m.energy <= 1) m.active_attack = null
								if(m.koed || m.stunned || m.meditating) m.active_attack = null
							else
								m.active_attack = null
								return
							sleep(0.1)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(src.active)
								src.active = 0
								src.icon_state = "Charge off"
								if(src == m.current_attack) m.current_attack = null
								m.stop_charging()
							else
								src.icon_state = "Charge"
								src.active = 1
								m.current_attack = src;
								m.toggle_skill(src)
		Psionic_Lance
			name = "Psionic Lance"
			icon_state = "origin"
			disabled_switch = 1;
			act = /obj/skills/Psionic_Lance/proc/activate
			info_energy_cost = "Extreme"
			info_dmg = 3
			info_spd = 3
			info_mastery = 1
			info_point_cost = 3
			teach_energy = 1500
			info_point_cost_type = "force"
			info_name = "psionic_lance"
			info_prerequisite = list("Beam")
			info_stats = "Energy Cost: Extreme\n\nDamage: High\n\nSpeed: Fast\n\nMastery: Slow\n\nToggleable\n\nChargeable"
			energy_skill = 1
			cd_max = 300
			attack_state = "blast"
			hud_x = 260
			hud_y = 588
			var
				tmp/obj/fly = null
			New()
				..()
				category = list("Force","Offence")
			proc
				activate(var/mob/m)
					if(src in m)
						if(m.active_attack) return
						if(m.energy <= 10) return
						if(m.koed || m.stunned || m.meditating) return
						if(m.can_ki == 0) return
						if(src.cd_state < 32)
							m << output("<font color = teal>Skill is on cooldown, please wait.","chat.system")
							//var/is = src.icon_state
							src.icon_state = "cd"
							spawn(3)
								if(src) src.icon_state = "Charge"
							return
						src.cd_max = (initial(src.cd_max)/m.mod_agility)/(1+src.skill_lvl/100)
						m.skill_cooldown(src)
						var/ascended = "psionic"
						var/obj/ranged/beam_charge/b = new
						b.size = 0.3
						b.pix_away = 32
						b.icon = 'attack_spike.dmi'
						for(var/obj/body_related/ascension_milestones/a in m.ascensions)
							if(a.major_ascension && a.icon_state == "ascension" && a.level > 0)
								b.plane = 2
								ascended = "divine"
								break
							else
								b.plane = 1
						b.ki_owner = m

						m.active_attack = b
						m.icon_state = m.state()
						m.can_ki = 0
						var/charge_check = 1;
						var/too_close = 0
						var/turf/t = null
						while(m)
							var/di = 0
							//If the charge ball exists, move it relative to player mouse position and continue with the rest of the code.
							if(b && b.expired == 0)
								var/e = ((4/m.mod_recovery)+(4/src.skill_lvl)*b.charge_lvl)
								if(b.fired == 0)
									//src.skill_exp += (1/src.skill_lvl)*m.mod_skill
									src.skill_exp += ((0.1-(src.skill_lvl/1000))*m.mod_skill)+0.1
									if(src.skill_exp >= 100 && src.skill_lvl < 100)
										src.skill_exp = 1
										src.skill_lvl += 1
										src.skill_up(m)
									b.loc = m.loc
									m.dir = get_dir(m,m.mouse_saved_loc)
									m.update_wings()
									di = m.mouse_degree//m.GetAngleStep(m.mouse_saved_loc)
									b.step_x = m.step_x
									b.step_y = m.step_y
									t = get_step(m,m.dir)
									too_close = 0
									if(t)
										if(t.density || t.density_factor == 2) too_close = 1
									if(too_close == 0) b.MoveAng(di,b.pix_away,0,0,null)
									b.ki_power = m.psionic_power
									b.ki_force = m.force*b.charge_lvl
									b.force_usage = m.mod_force_usage
									b.ki_offence = m.offence
									b.ki_agility = m.mod_agility

									//If the attack was canceled, or the player ran out of energy during charging or firing, force the attack to shrink and vanish.
									if(m.active_attack == null)
										if(b.finishing == 0)
											m.icon_state = m.state()
											//m.can_ki = 1
											var/matrix/M = matrix()
											M.Scale(0,0)
											animate(b,transform = M,time = 10)
											b.finishing = 1
											spawn(10)
												if(b)
													b.expired = 1
													b.destroy() //del(b)
												//if(ray) ray.loc = null
												if(m) m.can_ki = 1
												//if(ray) ray.loc = null
									//Continue to fire or charge the attack.
								if(m.mouse_down)
									if(b.just_started)
										b.shockwave()
										b.just_started = 0
									//Make the ball bigger and the charge lvl higher if players charged ball wasn't canceled for any reason.
									if(b.finishing == 0)
										if(b.size < 1)
											//Charge increase and displays charge lvl
											b.charge_lvl += 0.02*m.mod_recovery
											var/charge_rounded = round(b.charge_lvl)
											if(charge_rounded > charge_check)
												charge_check = charge_rounded
												m.charge_nums("<font color = green>x[charge_check]")
											//m << output("Charge lvl is [b.charge_lvl]", "chat.system")
											m.energy-=e
											b.size += 0.002*m.mod_recovery
											if(b.size > 1) b.size = 1
											b.pix_away += 0.14*m.mod_recovery
											if(b.pix_away >= 80) b.pix_away = 80
											//Create cool gathering energy effect
											if(prob(10))
												var/obj/orb = null
												if(ascended == "psionic") orb = new /obj/effects/orb
												else if(ascended == "divine") orb = new /obj/effects/orb_divine
												orb.loc = b.loc
												orb.step_x = b.step_x
												orb.step_y = b.step_y
												orb.pixel_x = rand(-64,64)
												orb.pixel_y = rand(-64,64)
												animate(orb,pixel_x = 0, pixel_y = 0, alpha = 0, time = 10)
												spawn(10)
													if(orb) orb.loc = null//del(o)
												/*
												for(var/obj/o in orbs)
													if(o.loc == null)
														o.alpha = 255;
														o.loc = b.loc
														o.step_x = b.step_x
														o.step_y = b.step_y
														o.pixel_x = rand(-32-b.pix_away,32+b.pix_away)
														o.pixel_y = rand(-32-b.pix_away,32+b.pix_away)
														animate(o,pixel_x = 0, pixel_y = 0, alpha = 0, time = 10)
														spawn(10)
															if(o) o.loc = null
														break
												*/
									var/matrix/M = matrix()
									M.Scale(b.size,b.size)
									M.Turn(m.mouse_degree)
									b.transform = M
								else if(b.fired == 0 && m.active_attack)
									di = m.mouse_degree//b.GetAngleStep(m.mouse_saved_loc)
									b.ang = di
									b.travel = 40
									b.fired = 1
									b.explode_impact = 1
									b.go()
									m.active_attack = null
									m.icon_state = m.state()
									var/time = 10/m.mod_agility
									if(time < 1) time = 1
									spawn(time)
										if(m) m.can_ki = 1
									//ray.loc = null
									return
								//If the player doesn't have enough energy while firing or charging, force the ball and beams to shrink and vanish.
								if(m.energy <= 1) m.active_attack = null
								if(m.koed || m.stunned || m.meditating) m.active_attack = null
							else
								m.active_attack = null
								return
							sleep(0.1)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(src.active)
								src.active = 0
								src.icon_state = "Charge off"
								if(src == m.current_attack) m.current_attack = null
								m.stop_charging()
							else
								src.icon_state = "Charge"
								src.active = 1
								m.current_attack = src;
								m.toggle_skill(src)
		Homing_Charge
			name = "Homing Charged Blast"
			icon_state = "Charge off"
			disabled_switch = 1;
			act = /obj/skills/Charge/proc/activate
			info_energy_cost = 3
			info_dmg = 2
			info_spd = 3
			info_mastery = 1
			info_point_cost = 6
			info_point_cost_type = "force"
			info_name = "homing_charged_blast"
			info_prerequisite = list("Charged Blast")
			energy_skill = 1
			var
				tmp/obj/fly = null
			act = /obj/skills/Homing_Charge/proc/activate
			New()
				..()
				category = list("Force","Offence")
			proc
				activate(var/mob/m)
					return
					if(src in m)
						if(m.active_attack) return
						if(m.koed || m.stunned || m.meditating) return
						if(m.can_ki == 0) return
						var/obj/ranged/beam_charge/b = new
						b.spd = 6
						b.ki_owner = m
						b.homing = 1
						if(m.skill_flight && m.skill_flight.active) m.icon_state = "fly beam"
						else m.icon_state = "beam"
						m.active_attack = b
						m.can_ki = 0
						b.explode_impact = 1
						var/di = 0
						var/LOC = m.mouse_saved_loc
						//var/e = ((10/m.mod_recovery)+(1/src.skill_lvl)*b.charge_lvl)
						b.fired = 1
						b.shockwave()
						var/matrix/M = matrix()
						M.Scale(0.5,0.5)
						animate(b,transform = M,time = 5)
						b.size = 0.5
						b.pix_away = 40
						b.charge_lvl = 3.5
						b.ki_power = m.psionic_power
						b.ki_force = m.force*b.charge_lvl
						b.force_usage = m.mod_force_usage
						b.ki_offence = m.offence
						b.ki_agility = m.mod_agility
						src.skill_exp += (1/src.skill_lvl)*m.mod_skill
						if(src.skill_exp >= 100 && src.skill_lvl < 100)
							src.skill_exp = 1
							src.skill_lvl += 1
						b.loc = m.loc
						m.dir = get_dir(m,LOC)
						di = m.GetAngleStep(LOC)
						b.step_x = m.step_x
						b.step_y = m.step_y
						b.MoveAng(di,b.pix_away,0,0,null)
						m.stunned += 1
						m.stunned_pending += 1
						sleep(5)
						if(m)
							m.stunned -= 1
							m.stunned_pending -= 1
							m.active_attack = null
							m.icon_state = m.state()
							var/time = 10/m.mod_agility
							if(time < 1) time = 1
							spawn(time)
								if(m) m.can_ki = 1
						if(b)
							b.explode_impact = 1
							b.fired = 1
							b.go(80,di)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(src.active)
								src.active = 0
								src.icon_state = "Charge off"
								if(src == m.current_attack) m.current_attack = null
								m.stop_charging()
							else
								src.icon_state = "Charge"
								src.active = 1
								m.current_attack = src;
								m.toggle_skill(src)
		Attack
			icon_state = "Attack off"
			info_energy_cost = "Low"
			info_dmg = 1
			disabled_switch = 1;
			info_spd = 2
			info_name = "attack"
			info_mastery = 3
			info_point_cost = 0
			info_point_cost_type = "offence"
			info_stats = "Energy Cost: Low \n\n Damage: Low \n\n Speed: Medium \n\n Mastery: Fast"
			act = /obj/skills/Attack/proc/activate
			info = "A basic melee attack that can be toggled on and off. Keeping this on will make you automatically attack your target when they are close. The rate at which you attack is based on your Agility mod. Using this with Super Speed will allow you to auto-combo-attack your target. Using this without a target will cause you to attack objects instead."
			New()
				..()
				category = list("Strength","Offence")
			proc
				activate(var/mob/m,var/obj/s)
					if(s in m)
						if(m.skill_attack == null) m.skill_attack = s
					if(m.started == 0) return
					if(s.active == 0)
						s.active = 1
						s.icon_state = "Attack"
						spawn(0.1)
							if(m && s)
								while(s && s.active)
									m.Attack()
									sleep(0.1)
					else
						s.active = 0
						s.icon_state = "Attack off"
						return
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
							if(src.active) m.toggle_skill(src)
		Five_Hit_Exploding_Heart_Technique
			icon_state = "Expand off"
			info_energy_cost = 1
			info_mastery = 1
			info_point_cost = 3
			info_name = "expand"
			teach_energy = 1500
			cd_max = 1000
			info_duration = "Toggleable"
			info_point_cost_type = "offence"
			act = /obj/skills/Five_Hit_Exploding_Heart_Technique/proc/activate
			info = "By sending excess Energy throughout your body, you're able to increase your strength significantly. Using this ability expands your muscles, draining your Energy slowly, but increasing your strength by 20%."
			var/tmp/hits = 0
			hud_x = 20
			hud_y = 636
			proc
				activate(var/mob/m,var/obj/skills/Five_Hit_Exploding_Heart_Technique/s)
					if(m.skill_touch_of_death == null) m.skill_touch_of_death = s
					if(s.cd_state < 32)
						m << output("<font color = teal>Skill is on cooldown, please wait.","chat.system")
						s.icon_state = "cd"
						spawn(3)
							if(s) s.icon_state = "Blast off"
						return
					if(s.active)
						s.active = 0
						s.icon_state = "Expand off"
					else
						s.icon_state = "Expand"
						s.active = 1
						s.hits = 0
			New()
				..()
				category = list("Strength","Offence")
				spawn(10)


					if(src.disable_sleep) return
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Stunning_Blow
			icon_state = "Attack off"
			info_energy_cost = 1
			info_dmg = 1
			disabled_switch = 1;
			info_spd = 2
			info_name = "attack"
			info_mastery = 2
			info_point_cost = 0
			cd_max = 200
			info_point_cost_type = "strength"
			info_stats = "Energy Cost: Low \n\n Damage: Low \n\n Speed: Medium \n\n Mastery: Medium"
			act = /obj/skills/Stunning_Blow/proc/activate
			info = "A basic melee attack that can be toggled on and off. Keeping this on will make you automatically attack your target when they are close. The rate at which you attack is based on your Agility mod. Using this with Super Speed will allow you to auto-combo-attack your target. Using this without a target will cause you to attack objects instead."
			hud_x = 68
			hud_y = 636
			New()
				..()
				category = list("Strength","Offence")
			proc
				activate(var/mob/m,var/obj/skills/Stunning_Blow/s)
					if(s in m)
						if(s.cd_state < 32)
							m << output("<font color = teal>Skill is on cooldown, please wait.","chat.system")
							s.icon_state = "cd"
							spawn(3)
								if(s) s.icon_state = "Blast off"
							return
						if(m.koed || m.stunned || m.recovering)
							m.set_alert("Unable while stunned or unconscious",'alert.dmi',"alert")
							m.create_chat_entry("alerts","Unable while stunned or unconscious.")
							return
						var/removes = (25/m.mod_recovery) + (25/s.skill_lvl)
						if(m.energy < removes)
							m << output("<font color = teal>Need [removes] energy","chat.system")
							m.set_alert("Need [removes] energy",s.icon,s.icon_state)
							m.create_chat_entry("alerts","Need [removes] energy.")
							return
						if(m.target)
							var/mob/tgt = m.target
							if(tgt.KB > 0)
								m << output("<font color = teal>Target stunned already.","chat.system")
								m.set_alert("Target stunned already",s.icon,s.icon_state)
								m.create_chat_entry("alerts","Target stunned already.")
								return
							if(bounds_dist(m, tgt) <= m.attack_range)
								m.skill_cooldown(s)
								m.energy -= removes
								s.skill_exp += (2.5-(s.skill_lvl/40)*m.mod_skill)+0.025
								if(s.skill_exp >= 100 && s.skill_lvl < 100)
									s.skill_exp = 1
									s.skill_lvl += 1
									s.skill_up(m)
								flick(pick("punch","kick"),m)
								var/Evasion=m.evasion(m,tgt)
								if(Evasion)
									return
								new /obj/effects/shockwave_small (tgt.loc)
								var/obj/effects/hit/h = new
								h.loc = m.loc
								h.dir = m.dir
								if(m.dir == SOUTH ||m.dir == NORTH) h.pixel_x += 16
								h.step_x = m.step_x
								h.step_y = m.step_y
								var/KB_dir = m.dir
								tgt.KB = 30
								tgt.KB_furrow = 1
								tgt.dir = KB_dir
								tgt.overlays += /obj/effects/stunned
								tgt.stunned += 1
								tgt.stunned_pending += 1
								tgt.KnockBack(KB_dir)
								sleep(6)
								if(tgt)
									tgt.stunned -= 1
									tgt.stunned_pending -= 1
									tgt.overlays -= /obj/effects/stunned
								return
					if(m.started == 0) return
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
							if(src.active) m.toggle_skill(src)
		Wrestle
			icon_state = "Blast off"
			info_energy_cost = 1
			info_dmg = 4
			info_spd = 5
			info_name = "wrestle"
			info_mastery = 1
			info_point_cost = 0
			info_point_cost_type = "strength"
			info_stats = "Energy Cost: Low \n\n Damage: Very High \n\n Speed: Instant \n\n Mastery: Very Slow"
			info = ""
			cd_max = 200
			level = 1
			act = /obj/skills/Wrestle/proc/activate
			New()
				..()
				category = list("Strength","Offence")
			proc
				activate(var/mob/m,var/obj/skills/s)
					if(s in m)
						if(m.skill_wrestle == null) m.skill_wrestle = s
					if(m.started == 0) return
					if(s.cd_state < 32)
						m << output("<font color = teal>Skill is on cooldown, please wait.","chat.system")
						//var/is = s.icon_state
						s.icon_state = "cd"
						spawn(3)
							if(s) s.icon_state = "Blast off"
						return
					if(m.grab && m.grab_part)
						if(ismob(m.grab))
							var/mob/t = m.grab
							if(m.wrestle_stage == null)
								var/strength_contest = (m.strength*m.psionic_power)/(t.strength*t.psionic_power)
								//world << "DEBUG - Chance is [strength_contest*33]%"
								if(prob(strength_contest*33))
									m.wrestle_stage = "locking joint"
									view(8,m) << output("<font color = magenta> [m] manages to tighten their grip on [t]'s [m.grab_part]!", "chat.local")
									t.flash_red()
									t.shake()
									return
								else
									view(8,m) << output("<font color = green> [m] fails to tighten their grip on [t]'s [m.grab_part]!", "chat.local")
									return
							else if(m.wrestle_stage == "locking joint")
								s.cd_max = (initial(s.cd_max)/m.mod_agility)/(1+s.skill_lvl/100)
								m.skill_cooldown(s)
								s.skill_exp += ((5-(s.skill_lvl/20))*m.mod_skill)+0.5
								if(s.skill_exp >= 100 && s.skill_lvl < 100)
									s.skill_exp = 1
									s.skill_lvl += 1
									s.skill_up(m)
								var/strength_contest = (m.strength*m.psionic_power)/(t.strength*t.psionic_power)
								//world << "DEBUG - Chance is [strength_contest*33]%"
								if(prob(strength_contest*33))
									var/obj/body_related/limb = pick(m.grab_part)
									if(length(limb.contents) > 0)
										var/obj/body_related/p = pick(limb.contents)
										var/msgs = pick("mangling their [p] badly!","crushing their [p] badly!","damaging their [p] terribly!","horrifically injuring their [p]!","mutilating their [p]!")
										view(8,m) << output("<font color = red> [m] puts immense pressure on [t]'s [m.grab_part], [msgs]", "chat.local")
										t.damage_limb(m,0, 0, 100,p)
									else
										view(8,m) << output("<font color = magenta> [m] manages to crush [t]'s [m.grab_part]!", "chat.local")
										var/Damage = ((m.strength*m.mod_str_usage)*(m.psionic_power))/(t.endurance*t.psionic_power)
										if(Damage < 0) Damage = 0.1
										t.percent_health -= Damage
										if(t.percent_health < 0) t.KO()
									m.wrestle_stage = null
									m.letgo()
									t.flash_red()
									t.shake()
									return
								else
									view(8,m) << output("<font color = green> [m] fails to tighten their grip on [t]'s [m.grab_part]!", "chat.local")
									return
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Finish
			icon_state = "Attack off"
			info_energy_cost = 1
			info_dmg = 5
			info_spd = 5
			info_name = "finish"
			info_mastery = 5
			info_point_cost = 0
			info_point_cost_type = "offence"
			info_stats = "Energy Cost: Low \n\n Damage: Very High \n\n Speed: Instant \n\n Mastery: Instant"
			info = "Finishes off an unconscious enemy. Can only be used on the target you have selected and they must be knocked out. Enemies can also be finished using psionic attacks instead of this skill."
			level = 100
			act = /obj/skills/Finish/proc/activate
			New()
				..()
				category = list("Strength","Offence")
			proc
				activate(var/mob/m,var/obj/s)
					if(s in m)
						if(m.skill_attack == null) m.skill_attack = s
					if(m.started == 0) return
					if(m.target)
						if(ismob(m.target))
							var/mob/t = m.target
							if(t.koed)
								flick(pick("punch","kick"),m)
								var/obj/effects/dust_medium/d = new
								d.SetCenter(t)
								sleep(1)
								if(t) t.shockwave()
								sleep(1)
								if(t && m)
									t.Death("[m]")
									m.target = null
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Blast
			icon_state = "origin"
			//repeat = 1;
			disabled_switch = 1;
			act = /obj/skills/Blast/proc/activate
			var/tmp/obj/fly = null
			info_energy_cost = 1
			info_dmg = 1
			info_spd = 4
			info_name = "blast"
			info_mastery = 4
			info_point_cost = 1
			info_point_cost_type = "force"
			energy_skill = 1
			teach_energy = 400
			disabled_switch = 1
			attack_state = "blast"
			info_stats = "Energy Cost: Low \n\n Damage: Low \n\n Speed: Fast \n\n Mastery: Fast \n\n Toggleable"
			act = /obj/skills/Blast/proc/activate
			info = "With this skill selected, you can click, or click and drag, to manifest a portion of your Energy, creating psionic blasts. Like most psionic attacks, the damage scales with your Force stat. And the energy cost scales with the level of this skill and your Recovery stat."
			hud_x = 212
			hud_y = 636
			New()
				..()
				category = list("Force","Offence")
			proc
				activate(var/mob/m)
					if(src == null) return
					if(src.active) return
					else src.active = 1
					m.current_attack = src
					m.active_attack = src
					while(m.mouse_down)
						if(src in m)
							if(m.build_mouse == null) if(m.meditating == 0) if(m.koed == 0) if(m.stunned == 0)
								if(src.fly == null)
									for(var/obj/skills/Flight/f in m)
										src.fly = f
								var/e = 1
								e = (10/m.mod_recovery) + (10/src.skill_lvl)
								m.icon_state = m.state()
								//if(src.fly && src.fly.active || m.submerged) m.icon_state = "fly blast"//flick("fly blast",m)
								//else m.icon_state = "blast"//flick("blast",m)
								if(m.energy >= e)
									m.energy-=e
									//m << output("<font color = teal>[e] energy removed by [src]","chat.system")
									//src.skill_exp += (10/src.skill_lvl)*m.mod_skill
									//src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
									src.skill_exp += (2.5-(src.skill_lvl/40)*m.mod_skill)+0.025
									if(src.skill_exp >= 100 && src.skill_lvl < 100)
										src.skill_exp = 1
										src.skill_lvl += 1
										src.skill_up(m)
									m.can_ki = 0
									src.icon_state = "Blast"
									//for(var/mob/h in view(8,m))
										//h << sound('blast.mp3',0,0,3,100)
									var/d = m.mouse_degree//m.GetAngleStep(m.mouse_saved_loc)
									var/obj/ranged/blast/b = pick(blasts)

									var/matrix/M = matrix()
									M.Turn(d)
									b.transform = M

									/*
									if(b && b.icon)
										var/icon/I = new(b.icon)
										I.Turn(d)
										b.icon = I
									*/

									b.KB = 40
									b.loc = m.loc
									b.step_x = m.step_x
									b.step_y = m.step_y
									b.step_y -= 16;
									b.step_x -= 16;
									b.ki_power = m.psionic_power
									b.ki_force = m.force
									b.force_usage = m.mod_force_usage
									b.ki_offence = m.offence
									b.ki_agility = m.mod_agility
									b.ki_owner = m
									b.alpha = 0
									animate(b, alpha = 255,1)
									m.dir = get_dir(m,m.mouse_saved_loc)
									b.travel = 40
									b.ang = d
									b.go()
									m.gain_stat("force",1,10,"From Blast skill")
						var/time = 3/m.mod_agility
						if(time < 1) time = 1
						sleep(time)
					m.can_ki = 1
					src.active = 0
					if(m.active_attack == src) m.active_attack = null
					m.icon_state = m.state()
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(src == m.current_attack)
								//src.active = 0
								src.icon_state = "Blast off"
								m.current_attack = null
								if(m.client) m.force_sources -= "From Blast skill"
							else
								src.icon_state = "Blast"
								//src.active = 1
								m.current_attack = src;
								m.toggle_skill(src)


			// The powering down part of power control
			// Make someone undetactable from long distance via sense
		Obfuscation
			icon_state = "Invisibility off"
			info_name = "invisibility"
			act = /obj/skills/Obfuscation/proc/activate
			teach_energy = 2000
			proc
				activate(var/mob/m,var/obj/s)
					if(s in m)
						if(m.skill_obfuscation == null) m.skill_obfuscation = s
						var/needed = (10/m.mod_recovery) + (10/s.skill_lvl)
						if(s.active)
							s.active = 0
							s.icon_state = "Invisibility off"
							if(m.map_blip)
								for(var/mob/p in players)
									if(p.open_map)
										if(p != m && p.z == m.z) p.client.images += m.map_blip
						else if(m.energy >= needed)
							s.active = 1
							s.icon_state = "Invisibility"
							if(m.map_blip)
								for(var/mob/p in players)
									if(p != m) p.client.images -= m.map_blip
			New()
				..()
				category = list("Energy","Utility")
				spawn(10)
					src.info = text_invisibility


					if(src.disable_sleep) return
					spawn(10)
						while(src)
							var/mob/m = null
							if(ismob(src.loc))
								m = src.loc
								if(src.active)
									var/removes = (10/m.mod_recovery) + (10/src.skill_lvl)
									if(m.energy >= removes)
										m.energy -= removes
										src.skill_exp += (2.5-(src.skill_lvl/40)*m.mod_skill)+0.025
										if(src.skill_exp >= 100 && src.skill_lvl < 100)
											src.skill_exp = 1
											src.skill_lvl += 1
											src.skill_up(m)
									else
										m.mouse_dir = "left"
										call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Limit_Breaker
			// The powering up part of power control
			// Burns lifespan, energy and limb hp
			// Gives +200% psionic energy output while active
			// Energy burns slower if your recovery is higher - makes power up builds a bit better
		/*
		Power_Control
			icon_state = "Profusion off"
			info_name = "power_control"
			info_energy_cost = "High"
			info_mastery = "Medium"
			info_point_cost = 3
			teach_energy = 2000
			info_buffs = "Power boost"
			info_duration = "Toggleable"
			info_point_cost_type = "power"
			var/obj/aura = null
			info_stats = "Energy Cost: High\n\nMastery: Medium\n\nToggleable"
			// Used to lower power to spar others on equal terms
			// Used to hide power from others
			// Used to power up for extra damage
			// Used to return power to normal
			New()
				category = list("Energy","Power","Buff")
				spawn(10)
					src.info = text_profusion


					var/obj/effects/aura/a = new
					src.aura = a;
					if(src.disable_sleep) return
					spawn(10)
						while(src)
							if(ismob(src.loc))
								var/mob/m = src.loc
								if(src.active >= 1 && m.icon_state != "meditate") m.power_percent += 1*m.mod_recovery
								if(src.active < 0) m.power_percent*=0.9
								if(m.power_percent <= 1) m.power_percent = 1;
								if(m.power_percent > 100)
									var/drain=1*(m.power_percent-100)/pick(1,m.mod_recovery)
									if(m.energy >= drain)
										m.energy -= drain
										m << output("Now at [m.power_percent]% power","chat.local")
										m << output("Psionic power now at [m.psionic_power]","chat.local")
										m.gain_stat("recovery",1,100,"From Power Control skill")
									else
										m.power_percent = 100;
										m.powering_up = 0
										src.icon_state = "Profusion off"
										src.active = 0;
										m.overlays -= src.aura
							//CHECK_TICK
							sleep(10)
			Click(location,control,params)
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"] || m.mouse_dir == "right")
						dir = "right"
					if(dir == "right")
						if(src in m)
							if(src.active == 0) //Power down
								if(m.power_percent > 100)
									m.power_percent = 100
									m << output("You return your power to normal.","chat.local")
									if(m.client) m.recov_sources -= "From Power Control skill"
									return
								src.active = -1;
								m.powering_up = -1;
								m << output("You begin powering down.","chat.local")
								src.icon_state = "Profusion"
								return
							if(src.active == 1) //If we were powering up, take it down a level
								src.active = 0;
								m.powering_up = 0
								m << output("You stop powering up.","chat.local")
								src.icon_state = "Profusion off"
								//m.overlays -= src.aura
								return
					if(dir == "left")
						if(src in m)
							if(src.active == 0) //Power up
								src.active = 1;
								m.powering_up = 1
								m.power_percent = 100;
								m << output("You begin to power up!","chat.local")
								src.icon_state = "Profusion"
								m.shockwave()
								sleep(2)
								m.shockwave_huge()
								return
							if(src.active == -1) //If we were powering up, take it down a level
								src.active = 0;
								m.powering_up = 0
								m << output("You stop powering down.","chat.local")
								src.icon_state = "Profusion off"
								m.overlays -= src.aura
								return
		*/
		Profusion
			icon_state = "Profusion off"
			info_name = "profusion"
			act = /obj/skills/Profusion/proc/activate
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active)
						s.active = 0
						s.icon_state = "Profusion off"
						m.filters -= filter(type="drop_shadow", x=0, y=0,size=5, offset=2, color=rgb(150,150,225))

						m.mod_strength*=1.2
						m.mod_resistance/=1.2
						m.mod_agility/=1.2
						m.mod_force/=1.3
						m.mod_regeneration/=1.2
						m.mod_recovery*=1.2
					else
						s.icon_state = "Profusion"
						m.filters += filter(type="drop_shadow", x=0, y=0,size=5, offset=2, color=rgb(150,150,225))

						s.active = 1

						m.mod_strength/=1.2
						m.mod_resistance*=1.2
						m.mod_agility*=1.2
						m.mod_force*=1.3
						m.mod_regeneration*=1.2
						m.mod_recovery/=1.2

						m.shockwave()
					if(m.part_selected) m.part_selected.update_part_stats(m) //Update the reward for completing training on this body part.

			New()
				..()
				spawn(10)
					src.info = text_profusion


					if(src.disable_sleep) return
					spawn(10)
						while(src)
							if(ismob(src.loc))
								var/mob/m = src.loc
								if(src.active)
									if(m.energy>=1)
										//m.energy-=5+((m.energy_max/10)/src.skill_lvl)/m.mod_recovery/m.mod_energy
										var/removes = (10/m.mod_recovery) + (10/src.skill_lvl)
										m.energy-=removes
										//world << "[removes] energy removed by [src]"
										//m << output("<font color = teal>[removes] energy removed by [src]","chat.system")
										//src.skill_exp += (10/src.skill_lvl)*m.mod_skill
										src.skill_exp += (2.5-(src.skill_lvl/40)*m.mod_skill)+0.025
										if(src.skill_exp >= 100 && src.skill_lvl < 100)
											src.skill_exp = 1
											src.skill_lvl += 1
											src.skill_up(m)
									else
										m.mouse_dir = "left"
										call(src.act)(m,src)
							//CHECK_TICK
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)



		//healing waves
		Astral_Projection
			icon_state = "Astral Projection off"
			name = "Astral Projection"
			info_energy_cost = 2
			info_mastery = 1
			info_point_cost = 2
			info_name = "astral_projection"
			info_buffs = "Remotely project your spirit to other places."
			info_duration = "Instant"
			info_point_cost_type = "energy"
			info_stats = "Energy Cost: Medium\n\nSpeed: Instant\n\nMastery: Slow\n\nToggleable"
			teach_energy = 1000
			hud_x = 308
			hud_y = 540
			info_prerequisite = list("Remote Viewing","Telepathy")
			info = "Reach out with your mind and project a copy of your physical body. Doing so will leave you in a meditative state while your soul-projection travels out to your desired location. When activated, you will be prompted to click a physical location on the map for your astral projection to appear. The manifestation that you create has quite vague features, roughly resembling someone of your species. You can move it about, talk, hear and see through it, but you can't interact in any other way."
			act = /obj/skills/Astral_Projection/proc/activate
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active)
						s.active = 0
						s.icon_state = "Astral Projection off"
						if(m.client)
							m.client.perspective = MOB_PERSPECTIVE | EDGE_PERSPECTIVE//initial(m.client.perspective)
							m.client.eye = m
						if(m.projection)
							m.projection.shockwave()
							animate(m.projection,alpha = 0, time = 7)
							spawn(8)
								if(m)
									m.projection.loc = null
									m.projection.destroy()
									m.projection = null
					else
						s.active = 1
						s.icon_state = "Astral Projection"
						m.map_proc(0)
						winshow(m,"skills",0)
						m.open_skills = 0
						m.open_menus.Remove(".open_skills")
						for(var/obj/skills/Remote_Viewing/rm in m)
							if(rm.active) call(rm.act)(m,rm)
						/*
						if(m.projection == null)
							for(var/obj/skills/Meditate/med in m)
								if(med.active == 0) call(med.act)(m,med)
							var/mob/p = new
							p.appearance = m.appearance
							p.loc = locate(m.x,m.y-1,m.z)
							p.step_x = m.step_x
							p.step_y = m.step_y
							p.icon_state = ""
							m.projection = p
							m.client.perspective = EYE_PERSPECTIVE
							m.client.eye = p
							s.icon_state = "Meditate"
						*/
			New()
				..()
				category = list("Energy","Utility")
				spawn(10)


					if(src.disable_sleep) return
					spawn(10)
						while(src)
							if(ismob(src.loc))
								var/mob/m = src.loc
								if(src.active)
									var/removes = (1/m.mod_recovery) + (1/src.skill_lvl)
									if(m.energy >= removes)
										m.energy -= removes
										//world << "[removes] energy removed by [src]"
										//m << output("<font color = teal>[removes] energy removed by [src]","chat.system")
										//src.skill_exp += (10/src.skill_lvl)*m.mod_skill
										//src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
										src.skill_exp += (2.5-(src.skill_lvl/40)*m.mod_skill)+0.025
										if(src.skill_exp >= 100 && src.skill_lvl < 100)
											src.skill_exp = 1
											src.skill_lvl += 1
											src.skill_up(m)
									else
										m.mouse_dir = "left"
										call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)

					winset(m,"main.map_main","focus=true")
		Hide_Wings
			icon_state = "Hide Wings off"
			name = "Hide Wings"
			info_energy_cost = 0
			info_mastery = 0
			info_point_cost = 2
			info_name = "hide_wings"
			info_buffs = "Hide your divine heritage."
			info_duration = "Instant"
			info_point_cost_type = "energy"
			info_stats = "Hides Wings"
			teach_energy = 1000
			info = "Hide your divine heritage."
			skill_lvl = 1
			act = /obj/skills/Hide_Wings/proc/activate
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active)
						s.active = 0
						s.icon_state = "Hide Wings off"
						m.wings_hidden = 0
						m.update_wings()
					else
						s.active = 1
						s.icon_state = "Hide Wings"
						m.wings_hidden = 1
						if(m.wings) m.vis_contents -= m.wings
						m.wings = null
			New()
				..()
				category = list("Utility")
				spawn(10)


					if(src.disable_sleep) return
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)

					winset(m,"main.map_main","focus=true")
		Remote_Viewing
			name = "Remote Viewing"
			icon_state = "Remote Viewing off"
			info_energy_cost = 1
			info_mastery = 1
			teach_energy = 1000
			info_point_cost = 3
			hud_x = 275
			hud_y = 588
			info_name = "remote_viewing"
			info_buffs = "Remotely view others"
			info_duration = "Instant"
			info_point_cost_type = "energy"
			info_prerequisite = list("Sense")
			info_stats = "Energy Cost: Low\n\nMastery: Slow\n\nConstant energy drain\n\nToggleable"
			act = /obj/skills/Remote_Viewing/proc/activate
			proc
				activate(var/mob/m,var/obj/s)
					if(s in m)
						if(m.skill_remote_viewing == null) m.skill_remote_viewing = s
						if(s.active)
							s.active = 0
							//m.buffs -= "remote view"
							s.icon_state = "Remote Viewing off"
							if(m.client)
								m.client.eye = m
								m.client.perspective = EYE_PERSPECTIVE | EDGE_PERSPECTIVE
						else
							s.icon_state = "Remote Viewing"
							s.active = 1
							//m.buffs += "remote view"
							m.map_proc(0)
							winshow(m,"skills",0)
							m.open_skills = 0
							m.open_menus.Remove(".open_skills")
							for(var/obj/skills/Astral_Projection/ap in m)
								if(ap.active) call(ap.act)(m,ap)
			New()
				..()
				category = list("Energy","Utility")
				spawn(10)
					src.info = text_sense


					if(src.disable_sleep) return
					spawn(10)
						while(src)
							if(ismob(src.loc))
								var/mob/m = src.loc
								if(src.active)
									if(m.energy>=2)
										var/removes = (1/m.mod_recovery) + (1/src.skill_lvl)
										m.energy -= removes
										//world << "[removes] energy removed by [src]"
										//m << output("<font color = teal>[removes] energy removed by [src]","chat.system")
										//src.skill_exp += (10/src.skill_lvl)*m.mod_skill
										//src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
										src.skill_exp += (2.5-(src.skill_lvl/40)*m.mod_skill)+0.025
										if(src.skill_exp >= 100 && src.skill_lvl < 100)
											src.skill_exp = 1
											src.skill_lvl += 1
											src.skill_up(m)
									else
										m.mouse_dir = "left"
										call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
							m.toggle_skill(src)

					winset(m,"main.map_main","focus=true")
		Dark_Petrifaction
			icon_state = "Dark Petrifaction off"
			info_energy_cost = 5
			info_mastery = 1
			info_point_cost = 3
			teach_energy = 1000
			info = "Use Dark Matter energy to petrify organs, muscles and bone in preperation for the transformation into an ever living Lich. When using this ability, you can select a bodypart to saturate in Dark Matter Energy, withering it to the point of no return. In doing so, the body part will be disabled until either the Lichdom ritual is complete, or the body part is cleansed. However, this dark transfiguration will bring you one step closer to the Petrified Body ascension needed in the Lichdom ritual."
			info_duration = "Channeled"
			info_name = "divine_petrifaction"
			info_point_cost_type = "energy"
			act = /obj/skills/Dark_Petrifaction/proc/activate
			info_buffs = "Wither a bodypart with dark matter energy"
			hud_x = 20
			hud_y = 636
			var/progress = 0;
			var/obj/bar = null
			var/obj/bar_inner = null
			var/tmp/mob_filter_pos = 0
			var/rotate = 0
			proc
				activate(var/mob/m,var/obj/skills/Dark_Petrifaction/s)
					s.progress = 0
					if(s.active)
						if(m.stance) //Switch off all stances
							m.disable_stances(null,1)
						if(m.grab) m.letgo()
						s.icon_state = "Dark Petrifaction off"
						if(s.active == 2)
							m.stunned -= 1
							m.stunned_pending -= 1
						s.active = 0
						m.icon_state = ""
						if(m.client)
							m.client.screen -= s.bar_inner
							m.client.screen -= s.bar
						s.bar_inner.screen_loc = "16:-2,10:-3"
						s.progress = 0
						if(s.mob_filter_pos) m.filters -= m.filters[s.mob_filter_pos]
					else
						for(var/obj/skills/Incubation/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Divine_Infusion/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Dark_Infusion/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						if(m.dead)
							m << output("<font color = teal>You can only petrify your body with dark power when you are alive.","chat.system")
							m.set_alert("Unable while dead",s.icon,s.icon_state)
							m.create_chat_entry("alerts","Unable while dead.")
							return
						if(m.dark_matter < 10)
							m << output("<font color = teal>You need at least 10 Dark Matter Energy to wreath a bodypart in cosmic power.","chat.system")
							m.set_alert("10 Dark Matter Energy needed",s.icon,s.icon_state)
							m.create_chat_entry("alerts","10 Dark Matter Energy needed.")
							return
						s.icon_state = "Dark Petrifaction"
						s.active = 1
						winshow(m,"skills",0)
						m.open_skills = 0
						m.open_menus.Remove(".open_skills")
						if(m.open_body == 0)
							m.open_body = 1
							m.open_menus.Add(".open_body")
							if(m.hud_body) m.client.screen += m.hud_body
						m.set_alert("Select bodypart to petrify",s.icon,s.icon_state)
			New()
				..()
				bar = new /:revive_bar
				bar_inner = new /:divine_bar_inner
				category = list("Energy","Buff")


				if(src.disable_sleep) return
				spawn(10)
					if(src)
						while(src)
							if(src.active == 2)
								var/mob/m = null
								if(ismob(src.loc))
									m = src.loc
									src.progress += 3+round(src.skill_lvl/10)
									//src.skill_exp += (33/src.skill_lvl)*m.mod_skill
									src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
									if(src.rotate == 0)
										m.shockwave_inverse()
										src.rotate = 1
									else src.rotate = 0
									if(src.skill_exp >= 100 && src.skill_lvl < 100)
										src.skill_exp = 1
										src.skill_lvl += 1
										src.skill_up(m)

									if(m.client)
										m.client.screen -= src.bar_inner
										src.bar_inner.screen_loc  = "16:[round(src.progress/2)-2],10:-3"
										var/matrix/M = matrix()
										M.Scale(round(src.progress),1)
										src.bar_inner.transform = M
										m.client.screen += src.bar_inner
									if(m.dark_matter < 10)
										call(src.act)(m,src)
										m << output("<font color = teal>You must have at least 10 dark matter energy to continue using Dark Petrifaction.","chat.system")
										m.set_alert("10 Dark Matter Energy needed",src.icon,src.icon_state)
										m.create_chat_entry("alerts","10 Dark Matter Energy needed.")
									/*
									if(m.infusing && m.infusing.disabled || m.infusing.damaged)
										call(src.act)(m,src)
										m << output("<font color = teal>Can only wither heathly bodyparts.","chat.system")
										m.set_alert("Bodypart damaged during infusion",src.icon,src.icon_state)
									*/
									var/obj/effects/orb_dark/o = new
									o.loc = m.loc
									o.step_x = m.step_x
									o.step_y = m.step_y
									o.pixel_x = rand(-64,64)
									o.pixel_y = rand(-64,64)
									animate(o,pixel_x = 0, pixel_y = 0, alpha = 0, time = 10)
									spawn(10)
										if(o) del(o)

									if(m.koed || m.meditating)
										call(src.act)(m,src)
									if(src.progress >= 100)
										m.dark_matter -= 10
										animate(m,alpha = 255, time = 30)
										//m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
										m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(0,0,0))
										m.icon_state = ""
										//m.stunned -= 1;
										//m.stunned_pending -= 1
										m.screen_text.maptext = "<font size = 6><center>[m.infusing] petrified"
										m.infusing.i_state = "[initial(m.infusing.icon_state)] petrified"
										m.infusing.icon_state = m.infusing.i_state
										m.infusing.infused_petrified = 1
										if(m.infusing.damaged  == 0 && m.infusing.disabled == 0) m.damage_limb(m,0,1,100,m.infusing)
										m.infusing.disabled_perma = 1
										m.infusing = null
										m.check_quest("tutorial_infuse",1)
										animate(m.screen_text,alpha = 255,time = 60)
										animate(alpha = 0,time = 60)
										m.shockwave()
										if(m.dead)
											m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
											m.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
										if(src.active) call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(m.skill_dark_petrifaction == null) m.skill_dark_petrifaction = src
							call(src.act)(m,src)
		Dark_Infusion
			icon_state = "Dark Infusion off"
			info_energy_cost = 5
			info_mastery = 1
			info_point_cost = 3
			info_buffs = "Infuse a bodypart with dark matter energy"
			info_duration = "Channeled"
			info_name = "dark_infusion"
			teach_energy = 1000
			hud_x = 68
			hud_y = 636
			info_point_cost_type = "energy"
			act = /obj/skills/Dark_Infusion/proc/activate
			info = "Using Dark Matter Energy and your skills at Psiforging bodyparts, weave the fabric of the universe into your very physical essence. When using this ability, you can select a bodypart to saturate in Dark Matter Energy, permeating it with power and bringing you closer to ascension. In doing so, this ability will automatically grant 10 levels in the chosen bodypart and bring the Divine Body ascension requirement closer to completion."
			var/progress = 0;
			var/obj/bar = null
			var/obj/bar_inner = null
			proc
				activate(var/mob/m,var/obj/skills/Dark_Infusion/s)
					s.progress = 0
					if(s.active)
						if(m.stance) //Switch off all stances
							m.disable_stances(null,1)
						if(m.grab) m.letgo()
						s.icon_state = "Dark Infusion off"
						if(s.active == 2)
							m.stunned -= 1
							m.stunned_pending -= 1
						s.active = 0
						m.icon_state = ""
						if(m.client)
							m.client.screen -= s.bar_inner
							m.client.screen -= s.bar
						s.bar_inner.screen_loc = "16:-2,10:-3"
						s.progress = 0
						m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(0,0,0))
					else
						for(var/obj/skills/Incubation/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Divine_Infusion/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Dark_Petrifaction/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						if(m.dead)
							m << output("<font color = teal>You can only infuse your body with dark power when you are alive.","chat.system")
							m.set_alert("Unable while dead",s.icon,s.icon_state)
							m.create_chat_entry("alerts","Unable while dead.")
							return
						if(m.dark_matter < 10)
							m << output("<font color = teal>You need at least 10 Dark Matter Energy to wreath a bodypart in cosmic power.","chat.system")
							m.set_alert("10 Dark Matter Energy needed",s.icon,s.icon_state)
							m.create_chat_entry("alerts","10 Dark Matter Energy needed.")
							return
						s.icon_state = "Dark Infusion"
						s.active = 1
						winshow(m,"skills",0)
						m.open_skills = 0
						m.open_menus.Remove(".open_skills")
						if(m.open_body == 0)
							m.open_body = 1
							m.open_menus.Add(".open_body")
							if(m.hud_body) m.client.screen += m.hud_body
						m.set_alert("Select bodypart to infuse",s.icon,s.icon_state)
			New()
				..()
				bar = new /:revive_bar
				bar_inner = new /:divine_bar_inner
				category = list("Energy","Buff")


				if(src.disable_sleep) return
				spawn(10)
					if(src)
						while(src)
							if(src.active == 2)
								var/mob/m = null
								if(ismob(src.loc))
									m = src.loc
									src.progress += 3+round(src.skill_lvl/10)
									//src.skill_exp += (33/src.skill_lvl)*m.mod_skill
									src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
									if(src.skill_exp >= 100 && src.skill_lvl < 100)
										src.skill_exp = 1
										src.skill_lvl += 1
										src.skill_up(m)

									if(m.client)
										m.client.screen -= src.bar_inner
										src.bar_inner.screen_loc  = "16:[round(src.progress/2)-2],10:-3"
										var/matrix/M = matrix()
										M.Scale(round(src.progress),1)
										src.bar_inner.transform = M
										m.client.screen += src.bar_inner
									if(m.dark_matter < 10)
										call(src.act)(m,src)
										m << output("<font color = teal>You must have at least 10 dark matter energy to continue using Dark Infusion.","chat.system")
										m.set_alert("10 Dark Matter Energy needed",src.icon,src.icon_state)
										m.create_chat_entry("alerts","10 Dark Matter Energy needed.")
									if(m.infusing && m.infusing.disabled || m.infusing.damaged)
										call(src.act)(m,src)
										m << output("<font color = teal>Can only infuse heathly bodyparts.","chat.system")
										m.set_alert("Bodypart damaged during infusion",src.icon,src.icon_state)
										m.create_chat_entry("alerts","Bodypart damaged during infusion.")
									var/obj/effects/orb_dark/o = new
									o.loc = m.loc
									o.step_x = m.step_x
									o.step_y = m.step_y
									o.pixel_x = rand(-64,64)
									o.pixel_y = rand(-64,64)
									animate(o,pixel_x = 0, pixel_y = 0, alpha = 0, time = 10)
									spawn(10)
										if(o) del(o)

									if(m.koed || m.meditating)
										call(src.act)(m,src)
									if(src.progress >= 100)
										m.dark_matter -= 10
										animate(m,alpha = 255, time = 30)
										//m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
										m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(0,0,0))
										m.icon_state = ""
										//m.stunned -= 1;
										//m.stunned_pending -= 1
										m.screen_text.maptext = "<font size = 6><center>[m.infusing] infused"
										m.infusing.i_state = "[initial(m.infusing.icon_state)] dark"
										m.infusing.icon_state = m.infusing.i_state
										m.infusing.infused_dark = 1
										m.infusing.part_exp = 1000
										m.infusing.part_reward(m,1)
										m.check_quest("tutorial_infuse",1)
										m.infusing = null
										animate(m.screen_text,alpha = 255,time = 60)
										animate(alpha = 0,time = 60)
										m.shockwave()
										if(m.dead)
											m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
											m.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
										if(src.active) call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(m.skill_dark_infusion == null) m.skill_dark_infusion = src
							call(src.act)(m,src)
		Divine_Infusion
			icon_state = "Divine Infusion off"
			info_energy_cost = 5
			info_mastery = 1
			info_point_cost = 3
			teach_energy = 1000
			info_name = "divine_infusion"
			info_buffs = "Infuse a bodypart with divine energy"
			info_duration = "Channeled"
			info_point_cost_type = "energy"
			hud_x = 116
			hud_y = 636
			act = /obj/skills/Divine_Infusion/proc/activate
			info = "Using Divine Energy and your skills at Psiforging bodyparts, meld divinity into your very physical essence. When using this ability, you can select a bodypart to saturate in Divine Energy, permeating it with power and bringing you closer to divinity. In doing so, this ability will automatically grant 10 levels in the chosen bodypart and bring the Divine Body ascension requirement closer to completion."
			var/progress = 0;
			var/obj/bar = null
			var/obj/bar_inner = null
			proc
				activate(var/mob/m,var/obj/skills/Divine_Infusion/s)
					s.progress = 0
					if(s.active)
						if(m.stance) //Switch off all stances
							m.disable_stances(null,1)
						if(m.grab) m.letgo()
						s.icon_state = "Divine Infusion off"
						if(s.active == 2)
							m.stunned -= 1
							m.stunned_pending -= 1
						s.active = 0
						m.icon_state = ""
						if(m.client) m.client.screen -= s.bar_inner
						if(m.client) m.client.screen -= s.bar
						s.bar_inner.screen_loc = "16:-2,10:-3"
						s.progress = 0
						m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(255,255,170))
					else
						for(var/obj/skills/Dark_Infusion/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Incubation/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Dark_Petrifaction/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						if(m.has_body == 0)
							m << output("<font color = teal>You can only infuse your body with divine power when you have a body.","chat.system")
							m.set_alert("Unable without body",s.icon,s.icon_state)
							m.create_chat_entry("alerts","Unable without body.")
							return
						if(round(m.divine_energy) < 10)
							m << output("<font color = teal>You need at least 10 Divine Energy to wreath a bodypart in godly power.","chat.system")
							m.set_alert("10 Divine Energy needed",s.icon,s.icon_state)
							m.create_chat_entry("alerts","10 Divine Energy needed.")
							return
						s.icon_state = "Divine Infusion"
						s.active = 1
						winshow(m,"skills",0)
						m.open_skills = 0
						m.open_menus.Remove(".open_skills")
						if(m.open_body == 0)
							m.open_body = 1
							m.open_menus.Add(".open_body")
							if(m.hud_body) m.client.screen += m.hud_body
						m.set_alert("Select bodypart to infuse",s.icon,s.icon_state)
				/*
				activate(var/mob/m,var/obj/skills/Divine_Infusion/s)
					if(s.active == 0)
						if(m.divine_energy < 25)
							m << output("<font color = teal>You need at least 25 Divine Energy to attempt the revivification process.","chat.system")
							return
						if(m.dead && m.z == 2)
							if(m.energy < m.energy_max)
								m << output("<font color = teal>You need to be at max energy to attempt the revivification process.","chat.system")
								return
							s.active = 1
							m.icon_state = "meditate"
							m.stunned += 1
							m.stunned_pending += 1
							m.client.screen += s.bar
						else m << output("<font color = teal>You need to be dead and in the Psionic Realm to attempt the revivification process.","chat.system")
					else
						s.active = 0
						m.stunned -= 1
						m.icon_state = ""
						m.client.screen -= s.bar_inner
						m.client.screen -= s.bar
						s.bar_inner.screen_loc = "18:-2,11:-6"
						s.progress = 0
				*/
			New()
				..()
				bar = new /:revive_bar
				bar_inner = new /:divine_bar_inner
				category = list("Energy","Buff")


				if(src.disable_sleep) return
				spawn(10)
					if(src)
						while(src)
							if(src.active == 2)
								var/mob/m = null
								if(ismob(src.loc))
									m = src.loc
									src.progress += 3+round(src.skill_lvl/10)
									//src.skill_exp += (33/src.skill_lvl)*m.mod_skill
									src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
									if(src.skill_exp >= 100 && src.skill_lvl < 100)
										src.skill_exp = 1
										src.skill_lvl += 1
										src.skill_up(m)

									if(m.client)
										m.client.screen -= src.bar_inner
										src.bar_inner.screen_loc  = "16:[round(src.progress/2)-2],10:-3"
										var/matrix/M = matrix()
										M.Scale(round(src.progress),1)
										src.bar_inner.transform = M
										m.client.screen += src.bar_inner
									if(round(m.divine_energy) < 10)
										call(src.act)(m,src)
										m << output("<font color = teal>You must have at least 10 divine energy to continue using Divine Infusion.","chat.system")
										m.set_alert("10 Divine Energy needed",src.icon,src.icon_state)
										m.create_chat_entry("alerts","10 Divine Energy needed.")
									if(m.infusing && m.infusing.disabled || m.infusing.damaged)
										call(src.act)(m,src)
										m << output("<font color = teal>Can only infuse heathly bodyparts.","chat.system")
										m.set_alert("Bodypart damaged during infusion",src.icon,src.icon_state)
										m.create_chat_entry("alerts","Bodypart damaged during infusion.")
									var/obj/effects/orb_divine/o = new
									o.loc = m.loc
									o.step_x = m.step_x
									o.step_y = m.step_y
									o.pixel_x = rand(-64,64)
									o.pixel_y = rand(-64,64)
									animate(o,pixel_x = 0, pixel_y = 0, alpha = 0, time = 10)
									spawn(10)
										if(o) o.loc = null//del(o)

									if(m.koed || m.meditating)
										call(src.act)(m,src)
									if(src.progress >= 100)
										m.divine_energy -= 10
										animate(m,alpha = 255, time = 30)
										//m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
										m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(255,255,170))
										m.icon_state = ""
										//m.stunned -= 1;
										//m.stunned_pending -= 1

										m.screen_text.maptext = "<font size = 6><center>[m.infusing] infused"
										m.infusing.i_state = "[initial(m.infusing.icon_state)] divine"
										m.infusing.icon_state = m.infusing.i_state
										m.infusing.infused_divine = 1
										m.infusing.part_exp = 1000
										m.infusing.part_reward(m,1)
										m.infusing = null
										m.check_quest("tutorial_infuse",1)
										animate(m.screen_text,alpha = 255,time = 60)
										animate(alpha = 0,time = 60)
										m.shockwave()
										if(m.dead)
											m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
											m.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
										if(src.active) call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(m.skill_divine_infusion == null) m.skill_divine_infusion = src
							call(src.act)(m,src)
		Germination
			icon_state = "Germination off"
			info_energy_cost = 1
			info_mastery = 1
			info_point_cost = 3
			teach_energy = 3000
			hud_x = 164
			hud_y = 636
			info_name = "germination"
			info_buffs = "Use Divine Energy to manifest a godly fruit"
			info_duration = "Channeled"
			info_point_cost_type = "energy"
			info = "Send forth bounteous Divine Energy and force it to collapse into a singular and powerful manifestation of divine will. Pure concentrated, prodigious power is poured into a special godly fruit. The process is very taxing and requires a massive sacrifice of 100 Divine Energy. Eating this physical expression of immortal power will grant the consumer many levels in any and all bodyparts they possess and increase their lifespan by 100 years. Can only be used every few years."
			act = /obj/skills/Germination/proc/activate
			var/progress = 0;
			var/obj/bar = null
			var/obj/bar_inner = null
			var/tmp/obj/g_ball = null
			var/tmp/obj/g_rays = null
			var/tmp/list/pixs
			proc
				activate(var/mob/m,var/obj/skills/Germination/s)
					if(s.active == 0)
						s.pixs = list()
						if(m.stance) //Switch off all stances
							m.disable_stances(null,1)
						if(m.grab) m.letgo()
						if(s.last_used != null)
							if(year-s.last_used < 2)
								m << output("<font color = teal>This can only be used every 2 years. Next use will be available in [round(2-(year-s.last_used),0.1)] years.","chat.system")
								m.set_alert("Available in [round(2-(year-s.last_used),0.1)] years",s.icon,s.icon_state)
								m.create_chat_entry("alerts","Available in [round(2-(year-s.last_used),0.1)] years.")
								return
						if(round(m.divine_energy) < 100)
							m << output("<font color = teal>You need at least 100 Divine Energy to attempt the germination process.","chat.system")
							m.set_alert("100 Divine Energy needed",s.icon,s.icon_state)
							m.create_chat_entry("alerts","100 Divine Energy needed.")
							return
						if(m.has_body == 0)
							m << output("<font color = teal>You need to have a body to attempt the germination process.","chat.system")
							m.set_alert("Need body",s.icon,s.icon_state)
							m.create_chat_entry("alerts","Need body.")
							return
						if(m.energy < m.energy_max/1.05)
							m << output("<font color = teal>You need to be at max energy to attempt the germination process.","chat.system")
							m.set_alert("Need max energy",s.icon,s.icon_state)
							m.create_chat_entry("alerts","Need max energy.")
							return
						for(var/obj/skills/Meditate/med in m)
							if(med.active) call(med.act)(m,med)
						for(var/obj/skills/Dark_Transmutation/dt in m)
							if(dt.active) call(dt.act)(m,dt)
						for(var/obj/skills/Dark_Infusion/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Divine_Infusion/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Dark_Petrifaction/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Incubation/inc in m)
							if(inc.active) call(inc.act)(m,inc)
						//m.energy = 1
						s.active = 1
						s.icon_state = "Germination"
						m.icon_state = "beam"
						m.stunned += 1
						m.stunned_pending += 1
						m.client.screen += s.bar

						var/obj/ball = new
						ball.loc = locate(m.x,m.y-2,m.z)
						ball.layer = 10
						ball.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(255,255,170))
						ball.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
						ball.step_x = m.step_x
						ball.step_y = m.step_y+12
						ball.icon = 'consumables.dmi'
						ball.icon_state = "divine fruit"
						ball.bolted = 2
						var/turf/t = ball.loc
						if(!t.liquid)
							var/obj/effects/dust_medium/d = new
							d.SetCenter(ball)
						ball.shockwave()
						ball.shockwave_huge()
						animate(ball,pixel_y = 4, color = list("#000", "#000", "#000", "#fff"),time = 12, loop = -1)
						animate(pixel_y = 0, color = initial(m.color),time = 12)
						animate(transform = turn(matrix(), 120), time = 6, loop = -1,flags = ANIMATION_PARALLEL)
						animate(transform = turn(matrix(), 240), time = 6)
						animate(transform = null, time = 6)
						s.g_ball = ball

						var/obj/rays = new
						rays.icon = 'fx_ray_small.dmi'
						rays.pixel_x = -16
						rays.pixel_y = -16
						rays.loc = locate(m.x,m.y-2,m.z)
						rays.bolted = 2
						rays.step_x = m.step_x
						rays.step_y = m.step_y+12
						rays.layer = 9
						rays.filters += filter(type="rays",x=0,y=0,size=64,color=rgb(255,255,170),offset=0,density=10,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
						animate(rays.filters[1],offset = 100,time = 1500, loop = -1)
						animate(offset = 0,time = 0)
						animate(rays.filters[1],y = 4,time = 12, loop = -1, flags = ANIMATION_PARALLEL)
						animate(y = 0, time = 12)
						s.g_rays = rays

						var/p = 33
						while(p)
							if(prob(25))
								sleep(1)
							p -= 1;
							var/obj/pix = new
							pix.icon = 'fx.dmi'
							pix.icon_state = "pixel"
							pix.loc = locate(m.x,m.y-2,m.z)
							pix.step_x = m.step_x
							pix.step_y = m.step_y+12
							pix.pixel_x = rand(-200,200)
							pix.pixel_y = rand(-200,200)
							pix.bolted = 2
							animate(pix,pixel_x = 0, pixel_y = 0, time = rand(5,10), alpha = 0,loop = -1)
							animate(pixel_x = rand(-200,200), pixel_y = rand(-200,200), time = 0, alpha = 255)
							if(s.pixs && islist(s.pixs)) s.pixs += pix
							else s.pixs = list()

					else
						s.active = 0
						m.stunned -= 1
						m.stunned_pending -= 1
						m.icon_state = ""
						m.client.screen -= s.bar_inner
						m.client.screen -= s.bar
						s.bar_inner.screen_loc = "16:-2,10:-3"
						s.progress = 0
						s.icon_state = "Germination off"
						animate(m)
						if(s.pixs && islist(s.pixs))
							for(var/obj/o in s.pixs)
								o.destroy()
						s.pixs = list()
						if(s.g_rays) s.g_rays.destroy()
						s.g_rays = null
						if(s.g_ball) s.g_ball.destroy()
						s.g_ball = null
						//m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(0,0,0))
			New()
				..()
				bar = new /:revive_bar
				bar_inner = new /:divine_bar_inner
				category = list("Utility","Buff")


				if(src.disable_sleep) return
				spawn(10)
					if(src)
						while(src)
							if(src.active)
								var/mob/m = null
								if(ismob(src.loc))
									m = src.loc
									src.progress += 3+round(src.skill_lvl/10)
									//src.skill_exp += (10/src.skill_lvl)*m.mod_skill
									src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
									if(src.skill_exp >= 100 && src.skill_lvl < 100)
										src.skill_exp = 1
										src.skill_lvl += 1
										src.skill_up(m)

									if(m.client)
										m.client.screen -= src.bar_inner
										src.bar_inner.screen_loc  = "16:[round(src.progress/2)-2],10:-3"
										var/matrix/M = matrix()
										M.Scale(round(src.progress),1)
										src.bar_inner.transform = M
										m.client.screen += src.bar_inner

									if(round(m.divine_energy) < 100)
										call(src.act)(m,src)
										m << output("<font color = teal>You must have at least 100 divine energy to continue using Germination.","chat.system")
										m.set_alert("100 Divine Energy needed",src.icon,src.icon_state)
										m.create_chat_entry("alerts","100 Divine Energy needed.")
									if(m.koed || m.meditating)
										call(src.act)(m,src)
									if(src.progress >= 100)
										if(src.g_ball)
											animate(src.g_ball)
											src.g_ball.shockwave()
										if(src.g_rays)
											src.g_rays.destroy()
											src.g_rays = null
										sleep(10)
										if(src && m)
											if(src.pixs && islist(src.pixs))
												for(var/obj/o in src.pixs)
													animate(o)
													o.destroy()
													sleep(1)
												src.pixs = null
											if(src.g_ball)
												src.g_ball.icon_state = "divine fruit grown"
												sleep(10)
												if(src && m)
													var/obj/items/consumables/divine_fruit/f = new
													f.loc = src.g_ball.loc
													f.step_x = src.g_ball.step_x
													f.step_y = src.g_ball.step_y
													f.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(255,255,170))
													var/fil = f.filters[1]
													animate(fil,size = 0,offset = 0, time = 10)
													spawn(10)
														if(f) f.filters = null
													src.g_ball.destroy()
													src.g_ball = null
													src.last_used = year
													m.divine_energy -= 100
											if(src && src.active && m) call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Dark_Formation
			icon_state = "Dark Formation off"
			info_energy_cost = 5
			info_mastery = 1
			info_point_cost = 3
			teach_energy = 3000
			hud_x = 212
			hud_y = 492
			info_name = "dark_formation"
			info_buffs = "Use Dark Matter to create a black hole"
			info_duration = "Channeled"
			info_prerequisite = list("Dark Transmutation")
			info_point_cost_type = "energy"
			info = "Summon forth a huge collection of Dark Matter confined within yourself to initiate the creation of a micro-black hole. With sufficient concentration and extreme supervision, Dark Matter can be manipulated and twisted into higher dimensional spaces, curling and circling into unknowable depths and places to coalesce, forming a mighty singularity. These are astronomically dangerous, if not useful tools, allowing those near to experience gravitational effects that harden the body - or completely destroy it."
			act = /obj/skills/Dark_Formation/proc/activate
			var/progress = 0;
			var/obj/bar = null
			var/obj/bar_inner = null
			var/tmp/list/things = list()
			var/tmp/list/dusts = list()
			var/tmp/list/disk_dust1 = list()
			var/tmp/list/disk_dust2 = list()
			var/tmp/obj/items/environmental/blackhole/blackhole = null
			var/rotation = 0
			//var/tmp/list/pixs
			//var/tmp/list/dusts
			proc
				activate(var/mob/m,var/obj/skills/Dark_Formation/s)
					if(s.active == 0)
						s.things = list()
						if(m.stance) //Switch off all stances
							m.disable_stances(null,1)
						if(m.grab) m.letgo()
						if(s.last_used != null)
							if(year-s.last_used < 5)
								m << output("<font color = teal>This can only be used every 5 years. Next use will be available in [5-(year-s.last_used)] years.","chat.system")
								m.set_alert("Available in [5-(year-s.last_used)] years",s.icon,s.icon_state)
								m.create_chat_entry("alerts","Available in [5-(year-s.last_used)] years.")
								return
						if(round(m.dark_matter) < 200)
							m << output("<font color = teal>You need at least 200 Dark Matter to create a black hole.","chat.system")
							m.set_alert("200 Dark Matter needed",s.icon,s.icon_state)
							m.create_chat_entry("alerts","200 Dark Matter needed.")
							return
						if(m.energy < m.energy_max/1.05)
							m << output("<font color = teal>You need to be at max energy to create a black hole.","chat.system")
							m.set_alert("Need max energy",s.icon,s.icon_state)
							m.create_chat_entry("alerts","Need max energy.")
							return
						for(var/obj/skills/Meditate/med in m)
							if(med.active) call(med.act)(m,med)
						for(var/obj/skills/Dark_Transmutation/dt in m)
							if(dt.active) call(dt.act)(m,dt)
						for(var/obj/skills/Dark_Infusion/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Divine_Infusion/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Dark_Petrifaction/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Incubation/inc in m)
							if(inc.active) call(inc.act)(m,inc)
						//m.energy = 1
						s.active = 1
						s.icon_state = "Dark Formation"
						m.icon_state = "beam"
						m.stunned += 1
						m.stunned_pending += 1
						m.client.screen += s.bar
						m.step_x = 0
						m.step_y = 0
						m.set_shadow()

						var/create_dusts = 66
						var/xx = 0
						var/yy = 6
						var/deg = 0
						var/t = 0
						var/obj/h = new
						var/turf/trf = locate(m.x,m.y-2,m.z)
						h.loc = trf
						h.alpha = 0
						s.things += h
						locate(m.x,m.y-3,m.z).explosion(7)
						var/obj/effects/shockwave_medium/b = new
						b.pixel_x = -96
						b.pixel_y = -96
						b.loc = h.loc
						b.transform *= 0.1
						animate(b, transform = matrix()*1, alpha = 0, time = 3)
						spawn(3)
							if(b) b.destroy()
						var/terrain = null
						var/turf/t_usr = m.loc
						if(t_usr.liquid == "water")
							terrain = "water"
							h.plane = -1
						else if(t_usr.liquid == "psionic") terrain = "psionic"
						else if(istype(t_usr,/turf/snows/)) terrain = "snow"
						else if(istype(t_usr,/turf/lava_static)) terrain = "lava"
						while(create_dusts)
							create_dusts -= 1
							for(var/obj/effects/dust/d in global.dusts)
								if(d.loc == null)
									var/matrix/mat = matrix()
									mat.Translate(xx,yy)
									mat.Turn(deg)
									d.transform = mat
									d.plane = 0
									d.alpha = 255
									if(terrain == "snow" && prob(50)) d.icon = 'fx_dust.dmi'
									else if(terrain == "psionic") d.icon = 'fx_dust_cosmic.dmi'
									else if(terrain == "water")
										d.icon = 'fx_water.dmi'
										d.filters += filter(type="outline",size=1, color=rgb(204,236,255))
										d.plane = -1
									else if(terrain == "lava")
										if(prob(33))
											d.icon = 'fx_lava.dmi'
											d.filters += filter(type="drop_shadow", x=0, y=0, size=2, offset=2, color=rgb(224,128,0))
										else d.icon = 'fx_ash.dmi'
									d.loc = h
									yy += 6
									deg += 10
									t += 1
									d.trans_x = xx
									d.trans_y = yy
									d.deg = deg
									h.overlays += d
									s.dusts += d
									break
						create_dusts = 66
						xx = 0
						yy = 6
						deg = 0
						t = 0
						while(create_dusts)
							create_dusts -= 1
							for(var/obj/effects/dust/d in global.dusts)
								if(d.loc == null)
									var/matrix/mat = matrix()
									mat.Translate(xx,yy)
									mat.Turn(deg)
									d.transform = mat
									d.loc = h
									d.plane = 0
									d.alpha = 255
									if(terrain == "snow" && prob(50)) d.icon = 'fx_dust.dmi'
									else if(terrain == "psionic") d.icon = 'fx_dust_cosmic.dmi'
									else if(terrain == "water")
										d.icon = 'fx_water.dmi'
										d.filters += filter(type="outline",size=1, color=rgb(204,236,255))
										d.plane = -1
									else if(terrain == "lava")
										if(prob(33))
											d.icon = 'fx_lava.dmi'
											d.filters += filter(type="drop_shadow", x=0, y=0, size=2, offset=2, color=rgb(224,128,0))
										else d.icon = 'fx_ash.dmi'
									yy -= 6
									deg += 10
									t += 1
									d.trans_x = xx
									d.trans_y = yy
									d.deg = deg
									h.overlays += d
									s.dusts += d
									break
						create_dusts = 120
						deg = 360
						while(create_dusts)
							create_dusts -= 1
							for(var/obj/effects/dust/d in global.dusts)
								if(d.loc == null)
									d.plane = 0
									d.loc = h.loc
									d.step_x = -16
									if(terrain == "snow" && prob(50)) d.icon = 'fx_dust.dmi'
									else if(terrain == "psionic") d.icon = 'fx_dust_cosmic.dmi'
									else if(terrain == "water")
										d.icon = 'fx_water.dmi'
										d.filters += filter(type="outline",size=1, color=rgb(204,236,255))
										d.plane = -1
									else if(terrain == "lava")
										if(prob(33))
											d.icon = 'fx_lava.dmi'
											d.filters += filter(type="drop_shadow", x=0, y=0, size=2, offset=2, color=rgb(224,128,0))
										else d.icon = 'fx_ash.dmi'
									var/px = cos(deg)
									var/py = sin(deg)
									animate(d, pixel_x = px*200, pixel_y = py*200, time = 10)
									d.trans_x = px*200
									d.trans_y = py*200
									d.og_layer = d.layer
									d.deg = deg
									s.disk_dust1 += d
									s.dusts += d
									break
							deg -= 3
						create_dusts = 120
						deg = 360
						while(create_dusts)
							create_dusts -= 1
							for(var/obj/effects/dust/d in global.dusts)
								if(d.loc == null)
									d.loc = h.loc
									d.plane = 0
									if(terrain == "snow" && prob(50)) d.icon = 'fx_dust.dmi'
									else if(terrain == "psionic") d.icon = 'fx_dust_cosmic.dmi'
									else if(terrain == "water")
										d.icon = 'fx_water.dmi'
										d.filters += filter(type="outline",size=1, color=rgb(204,236,255))
										d.plane = -1
									else if(terrain == "lava")
										if(prob(33))
											d.icon = 'fx_lava.dmi'
											d.filters += filter(type="drop_shadow", x=0, y=0, size=2, offset=2, color=rgb(224,128,0))
										else d.icon = 'fx_ash.dmi'
									d.step_x = -16
									d.deg = deg
									var/px = cos(deg)
									var/py = sin(deg)
									animate(d, pixel_x = px*170, pixel_y = py*170, time = 10)
									d.trans_x = px*170
									d.trans_y = py*170
									d.og_layer = d.layer
									s.disk_dust2 += d
									s.dusts += d
									break
							deg -= 3
						//sleep(10)
						create_dusts = 66
						while(create_dusts)
							create_dusts -= 1
							for(var/obj/effects/dust/d in global.dusts)
								if(d.loc == null)
									d.loc = h.loc
									if(terrain == "snow" && prob(50)) d.icon = 'fx_dust.dmi'
									else if(terrain == "psionic") d.icon = 'fx_dust_cosmic.dmi'
									else if(terrain == "water")
										d.icon = 'fx_water.dmi'
										d.filters += filter(type="outline",size=1, color=rgb(204,236,255))
										d.plane = -1
									else if(terrain == "lava") d.icon = 'fx_ash.dmi'
									var/px = rand(-320,320)
									var/py = rand(-320,320)
									if(px < 64 && px > 0) px = 64
									if(px > -64 && px < 0) px = -64
									if(py < 64 && py > 0) py = 64
									if(py > -64 && py < 0) py = -64
									d.pixel_x = px
									d.pixel_y = py
									animate(d,pixel_x = -20,pixel_y = -12, alpha = 55,time = rand(5,15), loop = -1)
									animate(pixel_x = px,pixel_y = py,alpha = 255, time = 0)
									s.dusts += d
									break
						animate(h, transform = turn(matrix(), -120), time = 15, loop = -1)
						animate(transform = turn(matrix(), -240), time = 15)
						animate(transform = null, time = 15)
						animate(h,alpha = 255,time = 10, flags = ANIMATION_PARALLEL)

						var/obj/items/environmental/blackhole/bh = new
						bh.loc = h.loc
						bh.transform = matrix()*0.1
						bh.grown = 0
						bh.layer = m.layer+0.1
						animate(bh)
						animate(bh,transform = matrix()*1, time = 1000)
						bh.spin()
						s.blackhole = bh


						for(var/obj/effects/dust/d in s.disk_dust1)
							animate(d,transform = turn(matrix(),120), time = 5,loop = -1)
							animate(transform = turn(matrix(),240), time = 5)
							animate(transform = null, time = 5)
						for(var/obj/effects/dust/d in s.disk_dust2)
							animate(d,transform = turn(matrix(),120), time = 5,loop = -1)
							animate(transform = turn(matrix(),240), time = 5)
							animate(transform = null, time = 5)


					else
						s.active = 0
						m.stunned -= 1
						m.stunned_pending -= 1
						m.icon_state = ""
						m.client.screen -= s.bar_inner
						m.client.screen -= s.bar
						s.bar_inner.screen_loc = "18:-2,11:-6"
						s.progress = 0
						s.icon_state = "Dark Formation off"
						s.rotation = 1
						animate(m)
						if(s.blackhole && s.blackhole.grown == 0)
							s.blackhole.destroy()
							s.blackhole = null
						if(s.things && islist(s.things))
							for(var/obj/o in s.things)
								o.destroy()
						if(s.dusts && islist(s.dusts))
							for(var/obj/o in s.dusts)
								animate(o)
								animate(o,alpha = 0, pixel_x = -10,pixel_y = -10,time = 10)
								spawn(10)
									if(o)
										o.loc = null
										o.alpha = 255
										o.pixel_y = 0
										o.pixel_x = -20
										o.layer = 3
										o.color = null
										o.icon = initial(o.icon)
										o.plane = initial(o.plane)
										animate(o)
						s.things = list()
						s.dusts = list()
						s.disk_dust1 = list()
						s.disk_dust2 = list()
			New()
				..()
				bar = new /:revive_bar
				bar_inner = new /:revive_bar_inner
				category = list("Utility")


				if(src.disable_sleep) return
				spawn(10)
					if(src)
						while(src)
							if(src.active)
								var/mob/m = null
								if(ismob(src.loc))
									m = src.loc
									src.progress += 2+round(src.skill_lvl/10)
									src.skill_exp += (10/src.skill_lvl)*m.mod_skill
									if(prob(50))
										var/obj/effects/lightning_bolt_psi_temp/bolt = new
										bolt.loc = locate(m.x+rand(-3,3),m.y+rand(-3,3),m.z)
									if(src.skill_exp >= 100 && src.skill_lvl < 100)
										src.skill_exp = 1
										src.skill_lvl += 1
										src.skill_up(m)

									if(m.client)
										m.client.screen -= src.bar_inner
										src.bar_inner.screen_loc  = "16:[round(src.progress/2)-2],10:-3"
										var/matrix/M = matrix()
										M.Scale(round(src.progress),1)
										src.bar_inner.transform = M
										m.client.screen += src.bar_inner

									if(round(m.dark_matter) < 200)
										call(src.act)(m,src)
										m << output("<font color = teal>You must have at least 200 dark matter to continue using Dark Formation.","chat.system")
										m.set_alert("200 Dark Matter needed",src.icon,src.icon_state)
										m.create_chat_entry("alerts","200 Dark Matter needed.")
									if(m.koed || m.meditating)
										call(src.act)(m,src)
									for(var/obj/effects/dust/d in src.disk_dust1)
										var/col = null
										if(src.rotation == 1)
											if(d.deg >= 180 && d.deg <= 360)
												d.layer = src.blackhole.layer-0.1 //2.3
												col = rgb(200,200,200)
												//d.icon = 'fx_dust_cosmic.dmi'
											else
												d.layer = 11
											animate(d,pixel_y = round(d.trans_y-(d.trans_y*2)), easing = SINE_EASING,time = 15,flags = ANIMATION_PARALLEL)
											animate(d, color = col, time = 7.5,easing = SINE_EASING, flags = ANIMATION_PARALLEL)
											animate(color = null, time = 7.5)
											//src.rotation1 = 2
										else
											if(d.deg >= 180 && d.deg <= 360)
												d.layer = 11
												//d.icon = 'fx_dust_cosmic.dmi'
											else
												d.layer = src.blackhole.layer-0.1 //2.3
												col = rgb(200,200,200)
											animate(d,pixel_y = round(d.trans_y-(d.trans_y*2)), easing = SINE_EASING,time = 15,flags = ANIMATION_PARALLEL)
											animate(d, color = col, time = 7.5, easing = SINE_EASING,flags = ANIMATION_PARALLEL)
											animate(color = null, time = 7.5)
											//src.rotation1 = 1
										d.trans_y = d.pixel_y

									for(var/obj/effects/dust/d in src.disk_dust2)
										var/col = null
										if(src.rotation == 1)
											if(d.deg >= 90 && d.deg <= 270)
												d.layer = src.blackhole.layer-0.2 //2.2
												col = rgb(200,200,200)
											else
												d.layer = 10
											animate(d,pixel_x = round(d.trans_x-(d.trans_x*2)), time = 15,easing = SINE_EASING,flags = ANIMATION_PARALLEL)
											animate(d, color = col, time = 7.5, easing = SINE_EASING,flags = ANIMATION_PARALLEL)
											animate(color = null, time = 7.5)
											//src.rotation2 = 2
										else
											if(d.deg >= 90 && d.deg <= 270)
												d.layer = 10
											else
												d.layer = src.blackhole.layer-0.2 //2.2
												col = rgb(200,200,200)
											animate(d,pixel_x = round(d.trans_x-(d.trans_x*2)), time = 15,easing = SINE_EASING,flags = ANIMATION_PARALLEL)
											animate(d, color = col, time = 7.5, loop = 0, easing = SINE_EASING,flags = ANIMATION_PARALLEL)
											animate(color = null, time = 7.5)
											//src.rotation2 = 1
										d.trans_x = d.pixel_x

									if(src.rotation == 1) src.rotation = 2
									else src.rotation = 1
									if(src.progress >= 100)
										if(src.blackhole)
											src.blackhole.grown = 1
											src.blackhole = null
										m.dark_matter -= 200
										call(src.act)(m,src)
							sleep(15)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Dark_Transmutation
			icon_state = "Dark Transmutation off"
			info_energy_cost = 5
			info_mastery = 1
			info_point_cost = 3
			teach_energy = 3000
			hud_x = 212
			hud_y = 636
			info_name = "dark transmutation"
			info_stats = "Convert 2 Divine Energy into 1 Dark Matter"
			info_stats = "Energy Cost: Very High\n\nSpeed: Slow\n\nMastery: Slow\n\nChanneled\n\nConvert 2 Divine Energy into 1 Dark Matter"
			info_duration = "Channeled"
			info_point_cost_type = "energy"
			info = "With directed focus and careful application of skill, twist Divine Energy into a new form. With Dark Transmutation, you take the entirety of your Divine Energy reserves and compress them into a micro singularity, squeezing out and collecting droplets of Dark Matter energy. The process in which Dark Matter is created this way isn't very effective, but it is safe. The conversion rate is 1 Dark Matter for every 2 Divine Energy you possess, a 2 to 1 ratio."
			act = /obj/skills/Dark_Transmutation/proc/activate
			var/progress = 0;
			var/obj/bar = null
			var/obj/bar_inner = null
			var/tmp/obj/g_ball = null
			var/tmp/obj/g_rays = null
			var/tmp/list/pixs
			var/tmp/mob_filter_pos = 0
			proc
				activate(var/mob/m,var/obj/skills/Dark_Transmutation/s)
					if(s.pixs && islist(s.pixs))
						for(var/obj/o in s.pixs)
							o.destroy()
					if(s.active == 0)
						s.pixs = list()
						if(m.stance) //Switch off all stances
							m.disable_stances(null,1)
						if(m.grab) m.letgo()
						if(m.energy < m.energy_max/1.05)
							m << output("<font color = teal>You need to be at max energy to attempt Dark Transmutation.","chat.system")
							m.set_alert("Need max energy",s.icon,s.icon_state)
							m.create_chat_entry("alerts","Need max energy.")
							return
						for(var/obj/skills/Meditate/med in m)
							if(med.active) call(med.act)(m,med)
						for(var/obj/skills/Dark_Infusion/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Divine_Infusion/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Dark_Petrifaction/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Incubation/inc in m)
							if(inc.active) call(inc.act)(m,inc)
						m.energy = 1
						s.active = 1
						s.icon_state = "Dark Transmutation"
						m.stunned += 1
						m.stunned_pending += 1
						m.client.screen += s.bar
						m.icon_state = "meditate"
						m.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(0,0,0))
						s.mob_filter_pos = m.filters.len
						animate(m.filters[m.filters.len], size = 3,offset = 1, time = 15, loop = -1)
						animate(size = -3,offset = -3, time = 15, loop = -1)

						var/p = 33
						while(p)
							p -= 1;
							var/obj/pix = new
							pix.icon = 'fx.dmi'
							pix.icon_state = "pixel"
							pix.loc = m.loc
							pix.step_x = m.step_x
							pix.step_y = m.step_y
							pix.pixel_x = rand(-200,200)
							pix.pixel_y = rand(-200,200)
							pix.bolted = 2
							pix.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(255,255,170))
							pix.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
							animate(pix,pixel_x = 0, pixel_y = 0, time = rand(10,20), alpha = 255,loop = -1)
							animate(pixel_x = rand(-200,200), pixel_y = rand(-200,200), time = 0, alpha = 0)
							if(s.pixs && islist(s.pixs)) s.pixs += pix
							else s.pixs = list()
						p = 33
						while(p)
							p -= 1;
							var/obj/pix = new
							pix.icon = 'fx.dmi'
							pix.icon_state = "pixel"
							pix.loc = m.loc
							pix.step_x = m.step_x
							pix.step_y = m.step_y
							pix.pixel_x = 0
							pix.pixel_y = 0
							pix.bolted = 2
							pix.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(102,0,204))
							pix.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
							animate(pix,pixel_x = rand(-200,200), pixel_y = rand(-200,200), time = rand(10,20), alpha = 0,loop = -1)
							animate(pixel_x = 0, pixel_y = 0, time = 0, alpha = 255)
							if(s.pixs && islist(s.pixs)) s.pixs += pix
							else s.pixs = list()

					else
						s.active = 0
						m.stunned -= 1
						m.stunned_pending -= 1
						m.icon_state = ""
						m.client.screen -= s.bar_inner
						m.client.screen -= s.bar
						s.bar_inner.screen_loc = "16:-2,10:-3"
						s.progress = 0
						s.icon_state = "Dark Transmutation off"
						//animate(m)
						if(s.mob_filter_pos) m.filters -= m.filters[s.mob_filter_pos]
						//m.filters = null
			New()
				..()
				bar = new /:revive_bar
				bar_inner = new /:revive_bar_inner
				category = list("Utility")


				if(src.disable_sleep) return
				spawn(10)
					if(src)
						while(src)
							if(src.active)
								var/mob/m = null
								if(ismob(src.loc))
									m = src.loc
									src.progress += 2+round(src.skill_lvl/10)
									//src.skill_exp += (10/src.skill_lvl)*m.mod_skill
									src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
									if(src.skill_exp >= 100 && src.skill_lvl < 100)
										src.skill_exp = 1
										src.skill_lvl += 1
										src.skill_up(m)

									if(m.client)
										m.client.screen -= src.bar_inner
										src.bar_inner.screen_loc  = "16:[round(src.progress/2)-2],10:-3"
										var/matrix/M = matrix()
										M.Scale(round(src.progress),1)
										src.bar_inner.transform = M
										m.client.screen += src.bar_inner

									if(m.koed || m.meditating)
										call(src.act)(m,src)
									if(src.progress >= 100)
										if(src && m)
											if(src.pixs && islist(src.pixs))
												for(var/obj/o in src.pixs)
													animate(o)
													o.destroy()
													sleep(0.1)
												src.pixs = null
											if(m.divine_energy > 0) m.dark_matter += (m.divine_energy/2)*m.dark_matter_mod
											m.divine_energy = 0
											if(src && src.active && m) call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Incubation
			icon_state = "Incubation off"
			info_energy_cost = 1
			info_mastery = 1
			info_point_cost = 3
			teach_energy = 1000
			info_name = "incubation"
			info_buffs = "Use psionic power to grow a bodypart"
			info_duration = "Channeled"
			info_point_cost_type = "energy"
			info_stats = "Grow a new bodypart\n\nOr duplicate a bodypart\n\nOr Split a bodypart\n\nOr strengthen a bodypart"
			info = "A Demon or Celestials physical form is manifested from psionic energy, made whole and solid by thought and sheer will. Usually, a newly awakened Demon or Celestial is made from pure ectoplasm. Using this ability, you can grow new organs for your body. Each time this is used, a bodypart you don't already have is grown. Each bodypart that you grow extends the time you can exist outside the Psionic Realm as a supernatural being."
			act = /obj/skills/Incubation/proc/activate
			var/progress = 0;
			var/obj/bar = null
			var/obj/bar_inner = null
			proc
				activate(var/mob/m,var/obj/skills/Incubation/s)
					if(s.active == 0)
						if(m.stance) //Switch off all stances
							m.disable_stances(null,1)
						if(m.grab) m.letgo()
						if(m.organ_grow >= m.total_organs+1)
							m << "All bodyparts grown."
							m.set_alert("All bodyparts grown",s.icon,s.icon_state)
							m.create_chat_entry("alerts","All bodyparts grown.")
							return
						if(m.has_body == 0)
							m << output("<font color = teal>You need to have a body to attempt the incubation process.","chat.system")
							m.set_alert("Need body",s.icon,s.icon_state)
							m.create_chat_entry("alerts","Need body.")
							return
						if(m.energy < m.energy_max/1.05)
							m << output("<font color = teal>You need to be at max energy to attempt the incubation process.","chat.system")
							m.set_alert("Need max energy",s.icon,s.icon_state)
							m.create_chat_entry("alerts","Need body.")
							return
						for(var/obj/skills/Meditate/med in m)
							if(med.active) call(med.act)(m,med)
						for(var/obj/skills/Dark_Transmutation/dt in m)
							if(dt.active) call(dt.act)(m,dt)
						for(var/obj/skills/Dark_Infusion/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Divine_Infusion/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Dark_Petrifaction/sk in m)
							if(sk.active) call(sk.act)(m,sk)
						for(var/obj/skills/Germination/gm in m)
							if(gm.active) call(gm.act)(m,gm)
						m.energy = 1
						s.active = 1
						s.icon_state = "Incubation"
						m.icon_state = "meditate"
						m.stunned += 1
						m.stunned_pending += 1
						m.client.screen += s.bar
						//m.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(0,0,0))
						animate(m, color = list("#000", "#000", "#000", "#fff"),time = 20, loop = -1)
						animate(color = initial(m.color),time = 20)
					else
						s.active = 0
						m.stunned -= 1
						m.stunned_pending -= 1
						m.icon_state = ""
						if(m.client)
							m.client.screen -= s.bar_inner
							m.client.screen -= s.bar
						s.bar_inner.screen_loc = "16:-2,10:-3"
						s.progress = 0
						s.icon_state = "Incubation off"
						animate(m)
						//m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(0,0,0))
			New()
				..()
				bar = new /:revive_bar
				bar_inner = new /:revive_bar_inner
				category = list("Utility","Buff")


				if(src.disable_sleep) return
				spawn(10)
					if(src)
						while(src)
							if(src.active)
								var/mob/m = null
								if(ismob(src.loc))
									m = src.loc
									src.progress += 3+round(src.skill_lvl/10)
									//src.skill_exp += (10/src.skill_lvl)*m.mod_skill
									src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
									if(src.skill_exp >= 100 && src.skill_lvl < 100)
										src.skill_exp = 1
										src.skill_lvl += 1
										src.skill_up(m)

									if(m.client)
										m.client.screen -= src.bar_inner
										src.bar_inner.screen_loc  = "16:[round(src.progress/2)-2],10:-3"
										var/matrix/M = matrix()
										M.Scale(round(src.progress),1)
										src.bar_inner.transform = M
										m.client.screen += src.bar_inner
									var/obj/effects/orb/o = new
									o.loc = m.loc
									o.step_x = m.step_x
									o.step_y = m.step_y
									o.pixel_x = rand(-64,64)
									o.pixel_y = rand(-64,64)
									animate(o,pixel_x = 0, pixel_y = 0, alpha = 0, time = 10)
									spawn(10)
										if(o) del(o)

									if(m.koed || m.meditating)
										call(src.act)(m,src)
										animate(m)
									if(src.progress >= 100)
										src.progress = 0
										//Player should have a list of lists. Inside each sub-list should be all the organs missings for that limb.
										if(m.race == "Demon" || m.race == "Celestial")
											LOOP
											if(m.organ_grow >= m.total_organs+1)
												m << "All bodyparts grown."
												m.set_alert("All bodyparts grown",src.icon,src.icon_state)
												m.create_chat_entry("alerts","All bodyparts grown.")
												return
											var/obj/body_related/bodyparts/part = global.grow_order[m.organ_grow]

											if(istype(part,/obj/body_related/bodyparts/head/))
												var/obj/body_related/bodyparts/head/h = m.bodyparts[1]
												var/dupe = 0
												for(var/obj/body_related/bodyparts/b in h)
													if(b.type == part.type)
														dupe = 1
														break
												if(dupe == 0) part = new part.type (h)
												else
													m.organ_grow += 1
													goto LOOP

											if(istype(part,/obj/body_related/bodyparts/torso/))
												var/obj/body_related/bodyparts/torso/t = m.bodyparts[2]
												var/dupe = 0
												for(var/obj/body_related/bodyparts/b in t)
													if(b.type == part.type)
														dupe = 1
														break
												if(dupe == 0) part = new part.type (t)
												else
													m.organ_grow += 1
													goto LOOP

											if(istype(part,/obj/body_related/bodyparts/left_arm/))
												var/obj/body_related/bodyparts/left_arm/la = m.bodyparts[3]
												var/dupe = 0
												for(var/obj/body_related/bodyparts/b in la)
													if(b.type == part.type)
														dupe = 1
														break
												if(dupe == 0) part = new part.type (la)
												else
													m.organ_grow += 1
													goto LOOP

											if(istype(part,/obj/body_related/bodyparts/right_arm/))
												var/obj/body_related/bodyparts/right_arm/ra = m.bodyparts[4]
												var/dupe = 0
												for(var/obj/body_related/bodyparts/b in ra)
													if(b.type == part.type)
														dupe = 1
														break
												if(dupe == 0) part = new part.type (ra)
												else
													m.organ_grow += 1
													goto LOOP

											if(istype(part,/obj/body_related/bodyparts/right_leg/))
												var/obj/body_related/bodyparts/right_leg/rl = m.bodyparts[5]
												part = new part.type (rl)
												var/dupe = 0
												for(var/obj/body_related/bodyparts/b in rl)
													if(b.type == part.type)
														dupe = 1
														break
												if(dupe == 0) part = new part.type (rl)
												else
													m.organ_grow += 1
													goto LOOP
											if(istype(part,/obj/body_related/bodyparts/left_leg/))
												var/obj/body_related/bodyparts/left_leg/ll = m.bodyparts[6]
												part = new part.type (ll)
												var/dupe = 0
												for(var/obj/body_related/bodyparts/b in ll)
													if(b.type == part.type)
														dupe = 1
														break
												if(dupe == 0) part = new part.type (ll)
												else
													m.organ_grow += 1
													goto LOOP
											part.name = part.info_name
											part.i_state = part.icon_state
											part.part_exp = 500//1000
											part.part_reward(m,1)
											if(part.type == /obj/body_related/bodyparts/torso/stomach) m.has_stomach = 1
											m.organ_grow += 1
											m.shockwave()
											m.screen_text.maptext = "<font size = 6><center>[part] grown"
											animate(m.screen_text,alpha = 255,time = 60)
											animate(alpha = 0,time = 60)
											if(src.active) call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Sense
			icon_state = "Sense off"
			info_energy_cost = 1
			info_mastery = 1
			info_point_cost = 3
			teach_energy = 1000
			hud_x = 308
			hud_y = 636
			info_name = "sense"
			info_buffs = "Sense power/location of others"
			info_duration = "Toggleable"
			info_point_cost_type = "energy"
			act = /obj/skills/Sense/proc/activate
			proc
				activate(var/mob/m,var/obj/s)
					if(m.skill_sense == null) m.skill_sense = s
					if(s.active)
						s.active = 0
						if(m.target) m.hide_sense(1,1)
						//m.buffs -= "sense"
						s.icon_state = "Sense off"
						//winshow(m,"sense",0)
						m.open_sense = 0
						if(m.open_map)
							for(var/mob/p in players)
								if(p.loc && p != m && p.map_blip && m.client) m.client.images -= p.map_blip
					else
						s.icon_state = "Sense"
						s.active = 1
						if(m.target) m.hide_sense(0)
						//m.buffs += "sense"
						if(m.open_map)
							m.map_update_blip("add")
							/*
							for(var/mob/p in players)
								if(p.loc && p != m && p.z == m.z && p.map_blip)
									if(maps[m.z] in m.client.screen)
									//if(m.z != 3 && maps[m.z] in m.client.screen)
										m.client.images += p.map_blip
							*/
			New()
				..()
				category = list("Energy","Utility")
				spawn(10)
					src.info = text_sense


					if(src.disable_sleep) return
					spawn(10)
						if(ismob(src.loc))
							var/mob/m = src.loc
							if(m.skill_sense == null) m.skill_sense = src
						while(src)
							if(ismob(src.loc))
								var/mob/m = src.loc
								if(src.active)
									var/removes = (1/m.mod_recovery) + (1/src.skill_lvl)
									if(m.energy >= removes)
										m.energy -= removes
										//world << "[removes] energy removed by [src]"
										//m << output("<font color = teal>[removes] energy removed by [src]","chat.system")
										//src.skill_exp += (10/src.skill_lvl)*m.mod_skill
										//src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
										src.skill_exp += (2.5-(src.skill_lvl/40)*m.mod_skill)+0.025
										if(src.skill_exp >= 100 && src.skill_lvl < 100)
											src.skill_exp = 1
											src.skill_lvl += 1
											src.skill_up(m)
									else
										m.mouse_dir = "left"
										call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					//var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
						m.mouse_dir = "left"
					if(params["right"])
						dir = "right"
						m.mouse_dir = "right"
					if(src in m)
						call(src.act)(m,src)

					winset(m,"main.map_main","focus=true")
		Teleportation
			icon_state = "Teleportation off"
			disabled_ko = 1
			info_name = "teleportation"
			teach_energy = 3000
			cd_max = 3000
			hud_x = 308
			hud_y = 492
			info_point_cost_type = "energy"
			act = /obj/skills/Teleportation/proc/activate
			info_prerequisite = list("Astral Projection")
			proc
				activate(var/mob/m,var/obj/skills/s)
					if(s in m)
						if(m.skill_teleport == null) m.skill_teleport = s
						if(s.active)
							s.active = 0
							s.icon_state = "Teleportation off"
						else
							if(s.cd_state < 32)
								m << output("<font color = teal>Skill is on cooldown, please wait.","chat.system")
								//var/is = s.icon_state
								s.icon_state = "cd"
								spawn(3)
									if(s) s.icon_state = "Teleportation off"
								return
							s.icon_state = "Teleportation"
							s.active = 1
							m.map_proc(0)
							winshow(m,"skills",0)
							m.open_skills = 0
							m.open_menus.Remove(".open_skills")
			New()
				..()
				spawn(10)
					src.info = text_super_speed


			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
							m.toggle_skill(src)


		Concussive_Blow
			icon_state = "Concussive Blow off"
			disabled_ko = 0
			New()
				..()
				spawn(10)
					src.info = text_super_speed


			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(m.target && bounds_dist(m, m.target) <= 32)
								var/mob/trg = m.target
								if(m.skill_flight && m.skill_flight.active)
									flick("punch right fly",m)
								else if(m.skill_levitation && m.skill_levitation.active)
									flick("punch right fly",m)
								else
									flick("punch right",m)
								//trg.dmg_nums("<font color = yellow>Stun")
								if(trg.stunned == 0)
									trg.overlays -= 'fx_stun.dmi'
									trg.overlays += 'fx_stun.dmi'
									trg.stun_cd(20)
		Self_Destruct
			icon_state = "Self Destruct off"
			disabled_ko = 1
			info_energy_cost = 5
			info_mastery = 4
			info_point_cost = 3
			teach_energy = 1500
			info_name = "self_destruct"
			info_buffs = "Explode in one last blaze of glory"
			info_duration = "Channeled"
			info_point_cost_type = "force"
			info_prerequisite = list("Explosion")
			cd_max = 6000
			level = 100
			act = /obj/skills/Self_Destruct/proc/activate
			hud_x = 116
			hud_y = 492
			proc
				activate(var/mob/m,var/obj/skills/s)
					if(s.active)
						s.active = 0
						s.icon_state = "Self Destruct off"
					else
						if(s.cd_state < 32)
							m << output("<font color = teal>Skill is on cooldown, please wait.","chat.system")
							//var/is = s.icon_state
							s.icon_state = "cd"
							spawn(3)
								if(s) s.icon_state = "Self Destruct off"
							return
						m.skill_cooldown(s)
						s.icon_state = "Self Destruct"
						s.active = 1
						m.stunned += 1
						m.stunned_pending += 1
						m.shockwave_huge()

						var/obj/rays = new
						rays.icon = 'fx_ray_large.dmi'
						rays.pixel_x = -284
						rays.pixel_y = -284
						rays.loc = m.loc
						rays.step_x = m.step_x
						rays.step_y = m.step_y
						rays.bolted = 2
						rays.layer = m.layer+100
						m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
						m.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
						rays.filters += filter(type="rays",x=0,y=0,size=300,color=rgb(255,255,255),offset=0,density=15,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
						animate(rays.filters[1],offset = 100,time = 1000, loop = -1)
						animate(offset = 0,time = 0)

						var/obj/o = new
						o.icon = m.icon
						o.icon_state = m.icon_state
						o.overlays = m.overlays
						o.loc = m.loc
						o.step_x = m.step_x
						o.step_y = m.step_y
						o.bolted = 2
						o.layer = m.layer+1
						animate(o, color = list("#000", "#000", "#000", "#fff"),time=20)
						//animate(alpha = 155, time = 20, flags = ANIMATION_PARALLEL)
						spawn(33)
							if(m && s)
								m.loc.explosion(7)
								rays.loc = null
								o.loc = null
								m.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
								m.Death("Self-Destruction",0)
								if(m)
									m.stunned -= 1
									m.stunned_pending -= 1
						//animate(o, transform = matrix()*2,alpha = 0, time = 10, loop = -1)
						//animate(transform = matrix()*1,alpha = 155,time = 0)
			New()
				..()
				category = list("Energy","Buff","resistance")
				spawn(10)
					src.info = text_super_speed


			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Shield
			icon_state = "Super Speed off"
			disabled_ko = 0
			info_energy_cost = 2
			info_mastery = 1
			info_name = "shield"
			info_point_cost = 3
			info_buffs = "Protection against Force based attacks"
			info_duration = "Toggleable"
			info_point_cost_type = "resistance"
			act = /obj/skills/Shield/proc/activate
			proc
				activate(var/mob/m,var/obj/s)
					//if(m.skill_super_speed == null) m.skill_super_speed = s
					if(s.active)
						s.active = 0
						s.icon_state = "Super Speed off"
					else
						s.icon_state = "Super Speed"
						s.active = 1
			New()
				..()
				category = list("Energy","Buff","resistance")
				spawn(10)
					src.info = text_super_speed


			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Give_Power
			icon_state = "Super Speed off"
			disabled_ko = 0
			info_energy_cost = 5
			info_mastery = 2
			info_point_cost = 5
			info_buffs = "Transfer all power to target"
			info_duration = "Instant"
			info_name = "give_power"
			info_point_cost_type = "power"
			act = /obj/skills/Give_Power/proc/activate
			proc
				activate(var/mob/m,var/obj/s)
					//if(m.skill_super_speed == null) m.skill_super_speed = s
					if(s.active)
						s.active = 0
						s.icon_state = "Super Speed off"
					else
						s.icon_state = "Super Speed"
						s.active = 1
			New()
				..()
				category = list("Power","Utility")
				spawn(10)
					src.info = text_super_speed


			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Give_Energy
			icon_state = "Super Speed off"
			disabled_ko = 0
			info_energy_cost = 5
			info_mastery = 2
			info_point_cost = 5
			info_name = "give_energy"
			info_buffs = "Transfer all energy to target"
			info_duration = "Instant"
			info_point_cost_type = "energy"
			act = /obj/skills/Give_Energy/proc/activate
			proc
				activate(var/mob/m,var/obj/s)
					//if(m.skill_super_speed == null) m.skill_super_speed = s
					if(s.active)
						s.active = 0
						s.icon_state = "Super Speed off"
					else
						s.icon_state = "Super Speed"
						s.active = 1
			New()
				..()
				category = list("Energy","Utility")
				spawn(10)
					src.info = text_super_speed


			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Mental_Battle //Used when mediating, creates an arena in the players head where he can choose to fight an npc or player.
			icon_state = "Super Speed off"
			disabled_ko = 0
			info_energy_cost = 3
			info_mastery = 1
			info_name = "mental_battle"
			info_point_cost = 5
			info_buffs = "Fight a mental battle against an opponent"
			info_duration = "Toggleable"
			info_point_cost_type = "Energy"
			act = /obj/skills/Mental_Battle/proc/activate
			proc
				activate(var/mob/m,var/obj/s)
					//if(m.skill_super_speed == null) m.skill_super_speed = s
					if(s.active)
						s.active = 0
						s.icon_state = "Super Speed off"
					else
						s.icon_state = "Super Speed"
						s.active = 1
			New()
				..()
				category = list("Energy","Utility")
				spawn(10)
					src.info = text_super_speed


			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Dash_Attack
		Psi_Lightning
			name = "Psi Lightning"
			icon_state = "Psi Lightning off"
			disabled_switch = 1;
			info_energy_cost = 4
			info_dmg = 3
			info_spd = 1
			info_mastery = 1
			info_point_cost = 3
			info_point_cost_type = "force"
			info_name = "psi_lightning"
			info_stats = "Energy Cost: Very High\n\nDamage: High\n\nSpeed: Slow\n\nMastery: Very Slow\n\nToggleable"
			energy_skill = 1
			teach_energy = 1000
			cd_max = 100
			info_cd = "10 seconds"
			hud_x = 68
			hud_y = 636
			New()
				..()
				category = list("Energy","Utility","Offence","Agility")
				spawn(10)
					src.info = text_super_speed


			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(m.skill_lightning == null) m.skill_lightning = src
							if(src.active)
								src.active = 0
								src.icon_state = "Psi Lightning off"
								if(src == m.current_attack) m.current_attack = null
								m.stop_charging()
							else
								src.icon_state = "Psi Lightning"
								src.active = 1
								m.current_attack = src;
								m.toggle_skill(src)

								src.cd_current = src.cd_max
		Quicksilver
			icon_state = "Super Speed off"
			disabled_ko = 0
			info_energy_cost = 2
			info_mastery = 2
			info_point_cost = 3
			teach_energy = 1000
			info_name = "quicksilver"
			info_buffs = "Quicksilver speed"
			info_duration = "Toggleable"
			info_point_cost_type = "agility"
			act = /obj/skills/Quicksilver/proc/activate
			var/speed_ramp = 0
			var/speed_skip = 0
			var/obj/speed = null
			proc
				activate(var/mob/m,var/obj/skills/Quicksilver/s)
					if(m.skill_quicksilver == null) m.skill_quicksilver = s
					if(s.active)
						s.active = 0
						s.icon_state = "Super Speed off"
						s.speed_ramp = 0
						m.density_factor = 1
						if(m.skill_focus == null || m.skill_focus && m.skill_focus.active == 0) m.overlays -= /obj/effects/elec
						if(s.speed) s.speed.loc = null
						m.icon_state = m.state()
					else
						s.icon_state = "Super Speed"
						s.active = 1
						m.KB_furrow = 1
						m.density_factor = 0
			New()
				..()
				category = list("Energy","Utility","Offence","Agility")
				spawn(10)
					src.info = text_super_speed


					var/obj/effects/speed_shockwave/h = new
					src.speed = h
					spawn(10)
						if(src)
							var/mob/m = null
							if(ismob(src.loc)) m = src.loc
							else return
							while(src)
								var/spd = 10
								if(src.active)
									if(!m.skill_flight || m.skill_flight && !m.skill_flight.active)
										if(!m.skill_levitation || m.skill_levitation && !m.skill_levitation.active)
											if(m.energy <= 1) call(src.act)(m,src)
											else if(m.tmp_dmg < 0) call(src.act)(m,src)
											if(m.skill_meditation && m.skill_meditation.active) call(m.skill_meditation.act)(m,m.skill_meditation)
											src.skill_exp += ((0.1-(src.skill_lvl/100))*m.mod_skill)+0.1
											if(src.skill_exp >= 100 && src.skill_lvl < 100)
												src.skill_exp = 1
												src.skill_lvl += 1
												src.skill_up(m)
											src.speed_ramp -= 0.4
											if(src.speed_ramp <= 0)
												src.speed_ramp = 0
												m.icon_state = m.state()
												if(m.skill_focus == null || m.skill_focus && m.skill_focus.active == 0) m.overlays -= /obj/effects/elec
											else if(src.speed_ramp < 6 && src.speed)
												src.speed.loc = null
												m.icon_state = "super speed"
											else
												m.icon_state = "dodge"
												m.overlays -= /obj/effects/elec
												m.overlays += /obj/effects/elec
											spd = 1
										else call(src.act)(m,src)
									else call(src.act)(m,src)
								sleep(spd)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Super_Speed
			icon_state = "Super Speed off"
			disabled_ko = 0
			info_energy_cost = 1
			info_mastery = 2
			info_point_cost = 3
			teach_energy = 1000
			info_name = "super_speed"
			info_buffs = "Attack combos"
			info_duration = "Toggleable"
			info_point_cost_type = "agility"
			cd_max = 10
			act = /obj/skills/Super_Speed/proc/activate
			hud_x = 20
			hud_y = 636
			proc
				activate(var/mob/m,var/obj/s)
					if(m.skill_super_speed == null) m.skill_super_speed = s
					if(s.active)
						s.active = 0
						s.icon_state = "Super Speed off"
						m.mod_agility /= 1.1
					else
						s.icon_state = "Super Speed"
						s.active = 1
						m.mod_agility *= 1.1
			New()
				..()
				category = list("Energy","Utility","Offence","Agility")
				spawn(10)
					src.info = text_super_speed


			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)


		/*
		Psi_Wave
			icon = 'skills.dmi'
			icon_state = "Psi Wave off"
			var/obj/wave = null
			Click(location,control,params)
				if(ismob(src.loc))
					var/mob/m = src.loc
					if("ko" in m.debuffs) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(m.charging == 0)
								m.charging = 1
								m.icon_state = "charge"
								var/obj/ranged/wave_start/s = new
								s.loc = locate(m.x+1,m.y,m.z)
								src.wave = s
			New()
				spawn(10)
					src.info = text_train


					spawn(10)
						while(src)
							if(ismob(src.loc))
								var/mob/m = src.loc
								if(src.wave && m.charging && m.charge_size <= 15)
									var/size_new = src.wave.transform*1.1
									animate(src.wave, transform = matrix()*size_new,pixel_x = src.wave.pixel_x + 1, time = 7)
									m.charge_size += 1
							sleep(7)

		*/

		//Advanced form of meditation that links user to psionic realms, so they can attune to the divine power there as if they were present.
		Meditate
			icon_state = "Meditate off"
			act = /obj/skills/Meditate/proc/activate
			info_stats = "+100% Divine Energy gathering\n\n+100% Regeneration Effectiveness\n\n+100% Recovery Effectiveness\n\nSmall xp gain in all stats\n\nUnable to move while active\n\nHalves Offence/Defence while active"
			proc
				activate(var/mob/m,var/obj/s)
					if(m.skill_sleep && m.skill_sleep.active) return
					if(m && s && m.skill_meditation == null) m.skill_meditation = s
					if(islist(m.tutorials))
						var/obj/help_topics/H = m.tutorials[2]
						if(H.seen == 0)
							H.seen = 1
							H.skill_up(m)
					if(s.active)
						s.active = 0
						m.meditating = 0
						//m.pixel_y = -8
						m.icon_state = m.state()
						s.icon_state = "Meditate off"
						var/turf/t = m.loc
						if(m.skill_focus && m.skill_focus.active || t && t.liquid) animate(m)
						/*
						if(m.pixel_y)
							animate(m,pixel_y = initial(m.pixel_y), time = 10)
							if(m.reflection) animate(m.reflection,pixel_y = initial(m.pixel_y), time = 10)
						*/
						if(m && m.client && m.started)
							m.power_sources -= "Meditation"
							m.energy_sources -= "Meditation"
							m.strength_sources -= "Meditation"
							m.endurance_sources -= "Meditation"
							m.force_sources -= "Meditation"
							m.resistance_sources -= "Meditation"
							m.agility_sources -= "Meditation"
							m.offence_sources -= "Meditation"
							m.defence_sources -= "Meditation"
							m.regen_sources -= "Meditation"
							m.recov_sources -= "Meditation"
						if(m.shadow)
							m.shadow.step_y -= 4
						m.gains_temp_off_mod += m.mod_offence
						m.gains_temp_def_mod += m.mod_defence
						m.gains_temp_off += m.offence
						m.gains_temp_def += m.defence
						m.offence *= 2
						m.defence *= 2
						m.mod_offence *= 2
						m.mod_defence *= 2
						m.metabolic_rate *= 2
						m.dehydration_rate *= 2
						m.tiredness_rate *= 2
						m.open_close_eyes(0)
					else
						if(m.skill_flight && m.skill_flight.active) call(m.skill_flight.act)(m,m.skill_flight)
						if(m.skill_levitation && m.skill_levitation.active) call(m.skill_levitation.act)(m,m.skill_levitation)
						if(m.skill_quicksilver && m.skill_quicksilver.active) call(m.skill_quicksilver.act)(m,m.skill_quicksilver)
						if(m.skill_active_meditation && m.skill_active_meditation.active) call(m.skill_active_meditation.act)(m,m.skill_active_meditation)
						for(var/obj/skills/Incubation/inc in m)
							if(inc.active) animate(m)
						m.Move(m.loc,SOUTH,m.step_x,m.step_y)
						m.meditating = 1
						m.icon_state = "meditate"
						s.icon_state = "Meditate"
						s.active = 1
						if(m.stance) //Switch off all stances
							m.disable_stances(null,1)
						if(m.grab) m.letgo()
						var/turf/t = m.loc
						if(m.skill_focus && m.skill_focus.active || t && t.liquid)
							var/pix_y = 0
							if(m.race == "Cerebroid") pix_y = -16
							animate(m,pixel_y = 10, time = 20,loop = -1,flags = ANIMATION_PARALLEL + ANIMATION_END_NOW)
							animate(pixel_y = pix_y, time = 20)
						if(m.shadow)
							m.shadow.step_y += 4
						m.gains_temp_off_mod -= m.mod_offence/2
						m.gains_temp_def_mod -= m.mod_defence/2
						m.gains_temp_off -= m.offence/2
						m.gains_temp_def -= m.defence/2
						m.offence /= 2
						m.defence /= 2
						m.mod_offence /= 2
						m.mod_defence /= 2
						m.metabolic_rate /= 2
						m.dehydration_rate /= 2
						m.tiredness_rate /= 2
						m.open_close_eyes(1)
			New()
				..()
				category = list("Energy","Regeneration","Recovery","Utility")
				spawn(10)
					src.info = text_meditation


					if(src.disable_sleep) return
					spawn(10)
						while(src)
							var/spd = 10
							if(ismob(src.loc))
								var/mob/m = src.loc
								if(src.active)
									m.icon_state = "meditate"
									m.check_quest("gen_meditate",1,1,1)
									//lvl up back muscles
									if(m.bodyparts && m.race != "Android")
										var/obj/body_related/bodyparts/torso/t = m.bodyparts[2]
										for(var/obj/body_related/bodyparts/torso/back_muscles/bm in t)
											bm.part_exp += 2
											bm.part_reward(m,1,null,0)
											break
									//Tech research
									if(m.tech_focus)
										var/obj/items/tech/sub_tech/t = m.tech_focus
										m.tech_xp[t.list_pos] += t.tech_exp_gain*m.mod_tech_potential
										if(m.tech_xp[t.list_pos] >= 100)
											t.lvl_up_tech(m)
											m.check_quest("gen_lvl_research",1,0,1)

										m.tech_xp_update()

										/*
										if(m.tech_display == t)
											if(tech_xp_bar)//if(t.xp_bar)
												var/matrix/m1 = matrix()
												m1.Translate(t.hud_x,t.hud_y)
												tech_xp_bar.transform = m1
												var/result =  round((m.tech_xp[t.list_pos]/100)*100,10)
												tech_xp_bar.icon_state = "[result]"
												if(m.hud_tech)
													var/obj/hud/menus/tech_background/b = m.hud_tech
													b.tech_holder_special.overlays = null
													b.tech_holder_special.overlays += tech_xp_bar
												//t.xp_bar.pixel_x = -22+result
										*/
									//Normal gains
									else
										var/N = 10
										//if(m.race == "Celestial") N = 20
										m.gain_stat("power",1,N,"Meditation")
										m.gain_stat("energy",1,N,"Meditation")
										m.gain_stat("strength",1,N,"Meditation")
										m.gain_stat("endurance",1,N,"Meditation")
										m.gain_stat("agility",1,N,"Meditation")
										m.gain_stat("offence",1,N,"Meditation")
										m.gain_stat("defence",1,N,"Meditation")
										m.gain_stat("resistance",1,N,"Meditation")
										m.gain_stat("force",1,N,"Meditation")
										m.gain_stat("regen",1,N,"Meditation")
										m.gain_stat("recovery",1,N,"Meditation")
										//src.skill_exp += (N/src.skill_lvl)*m.mod_skill
										src.skill_exp += (((N/4)-(src.skill_lvl/40))*m.mod_skill)+0.025
										if(src.skill_exp >= 100 && src.skill_lvl < 100)
											src.skill_exp = 1
											src.skill_lvl += 1
											src.skill_up(m)
										//if(prob(0.01*(m.mod_energy+m.mod_recovery))) m.decline+=0.2

										//var/L = length(m.buffs)
										//if(L == 0)
										if(m.energy < m.energy_max) // energy recovery while meditating
											var/gain_eng = 0
											if(m.mortal) gain_eng = 1
											else if(m.z == 2 || m.z == 6) gain_eng = 1
											if(gain_eng) m.energy += 0.01*m.energy_max*m.mod_recovery+(src.skill_lvl/100)
											else m.energy += 0.001*m.energy_max*m.mod_recovery+(src.skill_lvl/100)
											if(m.energy > m.energy_max) m.energy = m.energy_max
							sleep(spd)
			Click(location,control,params)
				//world << "[src]'s loc is [src.loc]"
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					//if(m.buffs.Find("flying")) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)

		Sleep
			icon_state = "Meditate off"
			act = /obj/skills/Sleep/proc/activate
			info_stats = "+100% Divine Energy gathering\n\n+100% Regeneration Effectiveness\n\n+100% Recovery Effectiveness\n\nSmall xp gain in all stats\n\nUnable to move while active\n\nHalves Offence/Defence while active"
			proc
				activate(var/mob/m,var/obj/s)
					if(m && s && m.skill_sleep == null) m.skill_sleep = s
					if(s.active)
						s.active = 0
						m.stunned -= 1
						m.stunned_pending -= 1
						m.icon_state = m.state()
						s.icon_state = "Meditate off"
						if(m.shadow)
							m.shadow.step_y -= 4
						m.open_close_eyes(0)
					else
						m.check_quest("tutorial_sleep",1)
						if(m.has_body == 0)
							m << output("<font color = teal>You need to have a body to sleep.","chat.system")
							m.set_alert("Need body",s.icon,s.icon_state)
							m.create_chat_entry("alerts","Need body.")
							return
						if(m.restedness > 100)//0)
							m << output("<font color = teal>You don't feel tired enough yet to sleep.","chat.system")
							m.set_alert("Not tired yet",s.icon,s.icon_state)
							m.create_chat_entry("alerts","Not tired yet.")
							return
						if(m.skill_flight && m.skill_flight.active) call(m.skill_flight.act)(m,m.skill_flight)
						if(m.skill_levitation && m.skill_levitation.active) call(m.skill_levitation.act)(m,m.skill_levitation)
						if(m.skill_quicksilver && m.skill_quicksilver.active) call(m.skill_quicksilver.act)(m,m.skill_quicksilver)
						if(m.skill_active_meditation && m.skill_active_meditation.active) call(m.skill_active_meditation.act)(m,m.skill_active_meditation)
						if(m.skill_meditation && m.skill_meditation.active) call(m.skill_meditation.act)(m,m.skill_meditation)
						for(var/obj/skills/Incubation/inc in m)
							if(inc.active) animate(m)
						m.Move(m.loc,SOUTH,m.step_x,m.step_y)
						m.icon_state = "meditate"
						s.icon_state = "Meditate"
						s.active = 1
						m.stunned += 1
						m.stunned_pending += 1
						if(m.stance) //Switch off all stances
							m.disable_stances(null,1)
						if(m.grab) m.letgo()
						if(m.shadow)
							m.shadow.step_y += 4
						m.open_close_eyes(1)
			New()
				..()
				category = list("Recovery","Utility")
				spawn(10)
					src.info = text_meditation


					if(src.disable_sleep) return
					spawn(10)
						while(src)
							var/spd = 10
							if(ismob(src.loc))
								var/mob/m = src.loc
								if(src.active)
									m.icon_state = "meditate"
									m.restedness += 0.2*m.mod_recovery
									if(m.restedness >= 100)
										m.restedness = 100
										call(src.act)(m,src)
							sleep(spd)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					//if(m.buffs.Find("flying")) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Active_Meditation
			icon_state = "Active Meditation off"
			act = /obj/skills/Active_Meditation/proc/activate
			info_stats = "+100% Divine Energy gathering\n\nSmall xp gain in all stats\n\nCan move while active\n\nProtects against eye damage\n\nHalves Offence/Defence while active"
			info = "This is a special form of meditation that allows the user to perform a wide range of movements and actions without being constrained to a meditative position. Just like in normal meditation, this form will give a small amount of xp in all stats and even allow research to be done, but at half the normal rate compared to seated meditation. Also, this form does not boost the rate at which someone heals or recovers energy, and also halves Offence and Defence. In using this, the users eyes have a measure of protection from some skills that might harm vision."
			info_point_cost_type = "energy"
			hud_x = 356
			hud_y = 636
			proc
				activate(var/mob/m,var/obj/s)
					if(m && s && m.skill_active_meditation == null) m.skill_active_meditation = s
					if(islist(m.tutorials))
						var/obj/help_topics/H = m.tutorials[2]
						if(H.seen == 0)
							H.seen = 1
							H.skill_up(m)
					if(s.active)
						s.active = 0
						m.offence *= 2
						m.defence *= 2
						m.mod_offence *= 2
						m.mod_defence *= 2
						m.icon_state = m.state()
						s.icon_state = "Active Meditation off"
						/*
						if(m.pixel_y)
							animate(m,pixel_y = initial(m.pixel_y), time = 10)
							if(m.reflection) animate(m.reflection,pixel_y = initial(m.pixel_y), time = 10)
						*/
						if(m && m.client && m.started)
							m.power_sources -= "Active Meditation"
							m.energy_sources -= "Active Meditation"
							m.strength_sources -= "Active Meditation"
							m.endurance_sources -= "Active Meditation"
							m.force_sources -= "Active Meditation"
							m.resistance_sources -= "Active Meditation"
							m.agility_sources -= "Active Meditation"
							m.offence_sources -= "Active Meditation"
							m.defence_sources -= "Active Meditation"
							m.regen_sources -= "Active Meditation"
							m.recov_sources -= "Active Meditation"
						m.open_close_eyes(0)
					else
						if(m.skill_meditation && m.skill_meditation.active) call(m.skill_meditation.act)(m,m.skill_meditation)
						s.icon_state = "Active Meditation"
						s.active = 1
						m.offence /= 2
						m.defence /= 2
						m.mod_offence /= 2
						m.mod_defence /= 2
						m.open_close_eyes(1)
			New()
				..()
				category = list("Energy","Regeneration","Recovery","Utility")
				spawn(10)


					if(src.disable_sleep) return
					spawn(10)
						while(src)
							var/spd = 10
							if(ismob(src.loc))
								var/mob/m = src.loc
								if(src.active)
									m.check_quest("gen_meditate",1,1,1)
									//Tech research
									if(m.tech_focus)
										var/obj/items/tech/sub_tech/t = m.tech_focus
										m.tech_xp[t.list_pos] += t.tech_exp_gain*m.mod_tech_potential
										if(m.tech_xp[t.list_pos] >= 100) t.lvl_up_tech(m)
										if(m.tech_display == t)
											if(t.xp_bar)
												var/result =  round((m.tech_xp[t.list_pos]/100)*22)
												t.xp_bar.pixel_x = -22+result
									//Normal gains
									else
										var/N = 5
										//if(m.race == "Celestial") N = 20
										m.gain_stat("power",1,N,"Active Meditation")
										m.gain_stat("energy",1,N,"Active Meditation")
										m.gain_stat("strength",1,N,"Active Meditation")
										m.gain_stat("endurance",1,N,"Active Meditation")
										m.gain_stat("agility",1,N,"Active Meditation")
										m.gain_stat("offence",1,N,"Active Meditation")
										m.gain_stat("defence",1,N,"Active Meditation")
										m.gain_stat("resistance",1,N,"Active Meditation")
										m.gain_stat("force",1,N,"Active Meditation")
										m.gain_stat("regen",1,N,"Active Meditation")
										m.gain_stat("recovery",1,N,"Active Meditation")
										//src.skill_exp += (N/src.skill_lvl)*m.mod_skill
										src.skill_exp += (((N/4)-(src.skill_lvl/40))*m.mod_skill)+0.025
										if(src.skill_exp >= 100 && src.skill_lvl < 100)
											src.skill_exp = 1
											src.skill_lvl += 1
											src.skill_up(m)
										//if(prob(0.01*(m.mod_energy+m.mod_recovery))) m.decline+=0.2

										//var/L = length(m.buffs)
										//if(L == 0)
							sleep(spd)
			Click(location,control,params)
				//world << "[src]'s loc is [src.loc]"
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					//if(m.buffs.Find("flying")) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Plant_Cultivation //Call this something else
				//Use this to imbue plants and herbs with energy so they grow quicker and become more potent?
				//Also make it so when you eat foods, you get seeds which you can click and replant.
		Divine_Weapon
			name = "Divine Weapon"
			info_name = "divine_weapon"
			icon_state = "divine weapon sword off"
			info_energy_cost = 4
			info_mastery = 1
			teach_energy = 3000
			info_point_cost = 5
			info = "Through the application of Divine Energy, forcefully manifest a weapon for you to command. The weapons are linked to you in some manner, either spirituality or telepathically and obey only your commands. The weapon shape can be changed by right clicking this skill. The number you can summon is based on this skills level. They have little to no regenerative capabilities and cost 25 Divine Energy to conjure. They are also destroyed when defeated."
			info_duration = "Instant"
			info_point_cost_type = "force"
			info_stats = "Energy Cost: Very High\n\nMastery: Slow"
			act = /obj/skills/Divine_Weapon/proc/activate
			hud_x = 116
			hud_y = 636
			var
				list/active_splits = list()
				max_splits = 10
				icon_og = "divine weapon sword"
				list/icons = list('divine weapon sword.dmi','divine weapon cross.dmi','divine weapon spear.dmi','divine weapon sword 1.dmi','divine weapon hammer.dmi','divine weapon axe.dmi')
				list/icon_states = list("divine weapon sword","divine weapon cross","divine weapon spear","divine weapon sword 1","divine weapon hammer","divine weapon axe")
				progress = 0;
				obj/bar = null
				obj/bar_inner = null
				tmp/mob/dw = null
				tmp/obj/g_rays = null
				tmp/list/pixs
				current_i = 1
			proc
				activate(var/mob/m,var/obj/skills/Divine_Weapon/x)
					return
					if(m && x)
						if(x.active == 0)
							if(x.dw)
								x.dw.destroy()
								x.dw = null
							if(x.g_rays)
								x.g_rays.destroy()
								x.g_rays = null
							if(x.pixs && islist(x.pixs))
								for(var/obj/o in x.pixs)
									o.destroy()
							x.pixs = list()
							if(m.stance) //Switch off all stances
								m.disable_stances(null,1)
							if(m.grab) m.letgo()

							for(var/obj/skills/Meditate/med in m)
								if(med.active) call(med.act)(m,med)
							for(var/obj/skills/Dark_Transmutation/dt in m)
								if(dt.active) call(dt.act)(m,dt)
							for(var/obj/skills/Dark_Infusion/sk in m)
								if(sk.active) call(sk.act)(m,sk)
							for(var/obj/skills/Divine_Infusion/sk in m)
								if(sk.active) call(sk.act)(m,sk)
							for(var/obj/skills/Dark_Petrifaction/sk in m)
								if(sk.active) call(sk.act)(m,sk)
							for(var/obj/skills/Incubation/inc in m)
								if(inc.active) call(inc.act)(m,inc)

							if(round(m.divine_energy) < 25)
								m << output("<font color = teal>You need at least 25 Divine Energy to manifest a Divine Weapon.","chat.system")
								m.set_alert("25 Divine Energy needed",x.icon,x.icon_state)
								m.create_chat_entry("alerts","25 Divine Energy needed.")
								return
							if(length(x.active_splits) >= x.max_splits)
								m << output("<font color = teal>You currently have the max number of Divine Weapons you can create.","chat.system")
								m.set_alert("Max weapons currently",x.icon,x.icon_state)
								m.create_chat_entry("alerts","Max weapons currently.")
								return
							if(m.energy >= m.energy_max/1.05)
								x.icon_state = "[x.icon_og]"
								x.active = 1
								m.stunned += 1
								m.stunned_pending += 1
								m.client.screen += x.bar
								m.dir = SOUTH

								m.energy -= m.energy_max/x.skill_lvl
								x.skill_exp += (100/x.skill_lvl)*m.mod_skill
								if(x.skill_exp >= 100 && x.skill_lvl < 100)
									x.skill_exp = 1
									x.skill_lvl += 1
									x.skill_up(m)
								var/mob/races/Celestial/s = new
								s.icon = x.icons[x.current_i]
								s.density_factor = 0
								s.alpha = 55
								s.dir = SOUTH
								s.tmp_lists()
								var/image/sel = image('select.dmi',s,null,10,pixel_y = 8)
								sel.appearance_flags = KEEP_APART | RESET_TRANSFORM
								s.target_img = sel

								animate(s,alpha = 255, time = 7)
								s.filters += filter(type="outline",size=1, color=rgb(204,236,255))
								s.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(204,236,255))
								s.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
								x.dw = s

								s.loc = locate(m.x,m.y-2,m.z)
								s.layer = 10
								s.step_x = m.step_x
								s.step_y = m.step_y+12
								s.bolted = 2
								s.divine_weapon = 1
								s.floats = 1
								s.hasreflect = 0
								s.attack_range = 64

								var/obj/effects/shadow/shad = new
								var/obj/effects/weapon_energy/we = new
								shad.appearance_flags = KEEP_APART | RESET_TRANSFORM
								shad.pixel_y = -8
								//shad.pixel_x = 5
								shad.loc = s.loc
								shad.step_x = s.step_x+3
								shad.step_y = s.step_y
								shad.vis_contents += we
								s.shadow = shad

								//s.create_afterimages()
								var/turf/t = s.loc
								if(!t.liquid)
									var/obj/effects/dust_medium/d = new
									d.SetCenter(s)
								s.shockwave()
								s.shockwave_huge()
								//animate(s,pixel_y = 4, color = list("#000", "#000", "#000", "#fff"),time = 12, loop = -1)
								//animate(pixel_y = 0, color = initial(m.color),time = 12)
								animate(s,transform = turn(matrix(), 120), time = 6, loop = -1)
								animate(transform = turn(matrix(), 240), time = 6)
								animate(transform = null, time = 6)

								var/obj/rays = new
								rays.icon = 'fx_ray_small.dmi'
								rays.pixel_x = -16
								rays.pixel_y = -16
								rays.loc = locate(m.x,m.y-2,m.z)
								rays.bolted = 2
								rays.step_x = m.step_x
								rays.step_y = m.step_y+10
								rays.layer = 3
								rays.filters += filter(type="rays",x=0,y=0,size=64,color=rgb(204,236,255),offset=0,density=10,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
								animate(rays.filters[1],offset = 100,time = 1500, loop = -1)
								animate(offset = 0,time = 0)
								animate(rays.filters[1],y = 4,time = 12, loop = -1, flags = ANIMATION_PARALLEL)
								animate(y = 0, time = 12)
								x.g_rays = rays

								var/p = 33
								while(p)
									if(prob(25))
										sleep(1)
									p -= 1;
									var/obj/pix = new
									pix.icon = 'fx.dmi'
									pix.icon_state = "pixel"
									pix.loc = locate(m.x,m.y-2,m.z)
									pix.step_x = m.step_x
									pix.step_y = m.step_y+12
									pix.pixel_x = rand(-200,200)
									pix.pixel_y = rand(-200,200)
									pix.bolted = 2
									animate(pix,pixel_x = 0, pixel_y = 0, time = rand(5,10), alpha = 0,loop = -1)
									animate(pixel_x = rand(-200,200), pixel_y = rand(-200,200), time = 0, alpha = 255)
									if(x.pixs && islist(x.pixs)) x.pixs += pix
									else x.pixs = list()

								sleep(3)
								if(s && m)
									//s.Celestial()
									s.vis_contents -= s.wings
									s.wings = null
									s.name = "{NPC} Divine Weapon"
									s.name_txt()
									s.icon = x.icons[x.current_i]
									s.appearance_flags = KEEP_TOGETHER
									s.mod_psionic_power = m.mod_psionic_power
									s.gains_trained_power = m.gains_trained_power
									s.gains_psiforged_power = m.gains_psiforged_power
									s.dead = m.dead
									if(s.dead) s.psionic_power /= 2
									s.strength = m.strength
									s.endurance = m.endurance
									s.force = m.force
									s.mod_agility = 10
									s.mod_str_usage = m.mod_str_usage
									s.mod_force_usage = m.mod_force_usage
									s.resistance = m.resistance
									s.mod_regeneration = 0.1
									s.mod_recovery = 0.1
									s.offence = m.offence
									s.defence = m.defence
									s.vigour = m.vigour
									s.gains_trained_energy = m.gains_trained_energy
									s.gains_psiforged_energy = m.gains_psiforged_energy

									/*
									var/obj/skills/Super_Speed/spd = new
									spd.loc = s
									s.skill_super_speed = spd
									spd.skill_lvl = 100//s.skill_super_speed.skill_lvl
									spd.active = 1
									s.mod_agility *= 1.1
									*/
									return
							else
								m << output("<font color = teal>Need more current energy.","chat.system")
								m.set_alert("Need more energy",x.icon,x.icon_state)
								m.create_chat_entry("alerts","Need more energy.")
								return
						else
							x.active = 0
							m.stunned -= 1
							m.stunned_pending -= 1
							m.icon_state = ""
							m.client.screen -= x.bar_inner
							m.client.screen -= x.bar
							x.bar_inner.screen_loc = "16:-2,10:-3"
							x.progress = 0
							x.icon_state = "[x.icon_og] off"
							if(x.g_rays)
								x.g_rays.destroy()
								x.g_rays = null
							if(x.pixs && islist(x.pixs))
								for(var/obj/o in x.pixs)
									animate(o)
									o.destroy()
									sleep(1)
								x.pixs = null
							if(x.dw)
								x.dw.destroy()
								x.dw = null
			New()
				..()
				category = list("Energy","Utility")
				spawn(10)
					bar = new /:revive_bar
					bar_inner = new /:divine_bar_inner


					if(src.disable_sleep) return
					spawn(10)
						if(src)
							while(src)
								if(src.active)
									var/mob/m = null
									if(ismob(src.loc))
										m = src.loc
										src.progress += 10//3+round(src.skill_lvl/10)
										//src.skill_exp += (10/src.skill_lvl)*m.mod_skill
										src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
										if(src.skill_exp >= 100 && src.skill_lvl < 100)
											src.skill_exp = 1
											src.skill_lvl += 1
											src.skill_up(m)

										if(m.client)
											m.client.screen -= src.bar_inner
											src.bar_inner.screen_loc  = "16:[round(src.progress/2)-2],10:-3"
											var/matrix/M = matrix()
											M.Scale(round(src.progress),1)
											src.bar_inner.transform = M
											m.client.screen += src.bar_inner

										if(round(m.divine_energy) < 25)
											call(src.act)(m,src)
											m << output("<font color = teal>You must have at least 25 divine energy to manifest a Divine Weapon.","chat.system")
											m.set_alert("25 Divine Energy needed",src.icon,src.icon_state)
											m.create_chat_entry("alerts","25 Divine Energy needed.")
										if(m.koed || m.meditating)
											call(src.act)(m,src)
										if(src.progress >= 100)
											src.progress = 100
											if(src.dw)
												animate(src.dw)
												src.dw.shockwave()
												var/obj/effects/lightning_bolt/b = new
												b.loc = src.dw.loc
												b.step_x = src.dw.step_x
												b.step_y = src.dw.step_y
												var/obj/o = src.dw
												spawn(7)
													if(o) o.shake()
											if(src.g_rays)
												src.g_rays.destroy()
												src.g_rays = null
											//sleep(10)
											//if(src && m)
											if(src.pixs && islist(src.pixs))
												for(var/obj/o in src.pixs)
													animate(o)
													o.destroy()
													sleep(1)
												src.pixs = null
											if(src.dw)
												if(src && m && src.dw)
													animate(src.dw,pixel_y = 10, time = 20,loop = -1)
													animate(pixel_y = 0, time = 20)
													src.active_splits += src.dw
													src.dw.owner = m.real_name
													//src.dw.buffs.Add("flying")
													//world << "DEBUG - Created [src.dw.skill_super_speed] for [src.dw]. Their super speed skill is now [src.dw.skill_super_speed], which has its active set to [dw.skill_super_speed.active]"
													src.dw = null
													src.icon_state = "[src.icon_og] off"
													m.divine_energy -= 25
											if(src && src.active && m) call(src.act)(m,src)
								sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(m.skill_divine_weapon == null) m.skill_divine_weapon = src
							call(src.act)(m,src)
					else if(dir == "right")
						if(src in m)
							src.current_i += 1
							if(current_i >= 7) src.current_i = 1
							if(src.active)
								src.icon_state = "[src.icon_states[current_i]]"
								src.icon_og = src.icon_states[current_i]
							else
								src.icon_state = "[src.icon_states[current_i]] off"
								src.icon_og = src.icon_states[current_i]
		Psi_Clone
			name = "Psi Clone"
			info_name = "psi_clone"
			icon_state = "Psi Clone off"
			info_energy_cost = 3
			info_mastery = 1
			teach_energy = 3000
			info_point_cost = 5
			info_buffs = "Create a copy to send against your foes"
			info_duration = "Instant"
			info_point_cost_type = "energy"
			info_stats = "Energy Cost: High\n\nMastery: Slow"
			act = /obj/skills/Psi_Clone/proc/activate
			var
				list/active_splits = list()
				max_splits = 10
			proc
				activate(var/mob/m,var/obj/skills/Psi_Clone/x)
					return
					if(m && x)
						//x.max_splits = round(1+(x.skill_lvl/11),1)
						for(var/mob/s in x.active_splits)
							if(s.loc == null)
								s.loc = get_step(m,m.dir)
								s.dir = get_dir(s,m)
								s.pixel_x = m.pixel_x
								s.pixel_y = m.pixel_y
								s.step_x = m.step_x;
								s.step_y = m.step_y;
								var/image/sel = image('select.dmi',s,null,10,pixel_y = 8)
								sel.appearance_flags = KEEP_APART | RESET_TRANSFORM
								s.target_img = sel
						if(length(x.active_splits) >= x.max_splits) return
						if(m.energy >= m.energy_max/x.skill_lvl)
							x.icon_state = "Psi Clone"

							m.energy -= m.energy_max/x.skill_lvl
							//x.skill_exp += (100/x.skill_lvl)*m.mod_skill
							x.skill_exp += ((10-(x.skill_lvl/10))*m.mod_skill)+1
							if(x.skill_exp >= 100 && x.skill_lvl < 100)
								x.skill_exp = 1
								x.skill_lvl += 1
								x.skill_up(m)
							m.create_follower(null,"Clone","Clone","Clone",x)
							return
						else
							m << output("<font color = teal>You need more energy to continue.","chat.system")
							m.set_alert("Need more energy",x.icon,x.icon_state)
							m.create_chat_entry("alerts","Need more energy.")
							return
			New()
				..()
				category = list("Energy","Utility")
				spawn(10)
					src.info = text_focus


			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(m.skill_psi_clone == null) m.skill_psi_clone = src
							call(src.act)(m,src)
		Simulacrum
		//Demon special ability, creates a clone like Psi Clone, but the player can switch between playing them instantly, and swap places.
		//Also if the player dies, they ressurect and become the Simulacrum.
		//Can have a max of 4 or so at once?
		//Costs dark matter to create
		//Stronger than normal psi clone, uses advanced combat ai when battling
		//Maybe make it cost 100 lifespan to do also?
		//Make it given as an ascension reward.
			name = "Simulacrum"
			info_name = "psi_clone"
			icon_state = "Psi Clone off"
			info_energy_cost = 3
			info_mastery = 1
			teach_energy = 3000
			info_point_cost = 5
			info_buffs = "Create a copy to send against your foes"
			info_duration = "Instant"
			info_point_cost_type = "energy"
			info_stats = "Energy Cost: High\n\nMastery: Slow"
			act = /obj/skills/Psi_Clone/proc/activate
			var
				list/active_splits = list()
				max_splits = 10
			proc
				activate(var/mob/m,var/obj/skills/Psi_Clone/x)
					if(m && x)
						//x.max_splits = round(1+(x.skill_lvl/11),1)
						for(var/mob/s in x.active_splits)
							if(s.loc == null)
								s.loc = get_step(m,m.dir)
								s.dir = get_dir(s,m)
								s.pixel_x = m.pixel_x
								s.pixel_y = m.pixel_y
								s.step_x = m.step_x;
								s.step_y = m.step_y;
								var/image/sel = image('select.dmi',s,null,10,pixel_y = 8)
								sel.appearance_flags = KEEP_APART | RESET_TRANSFORM
								s.target_img = sel
						if(length(x.active_splits) >= x.max_splits) return
						if(m.energy >= m.energy_max/x.skill_lvl)
							x.icon_state = "Psi Clone"

							m.energy -= m.energy_max/x.skill_lvl
							//x.skill_exp += (100/x.skill_lvl)*m.mod_skill
							x.skill_exp += ((10-(x.skill_lvl/10))*m.mod_skill)+1
							if(x.skill_exp >= 100 && x.skill_lvl < 100)
								x.skill_exp = 1
								x.skill_lvl += 1
								x.skill_up(m)
							var/mob/s = new m.type
							s.icon = m.icon
							s.loc = get_step(m,m.dir)
							s.dir = get_dir(s,m)
							s.pixel_x = m.pixel_x
							s.pixel_y = m.pixel_y
							s.step_x = m.step_x;
							s.step_y = m.step_y;
							s.density_factor = 0
							s.icon +=rgb(125,125,125)
							s.alpha = 55
							s.bodyparts = list(new /:head, new /:torso,new /:left_arm, new /:right_arm,new /:right_leg,new /:left_leg)
							s.dir = SOUTH
							var/image/sel = image('select.dmi',s,null,10,pixel_y = 8)
							sel.appearance_flags = KEEP_APART | RESET_TRANSFORM
							s.target_img = sel
							s.accessing = s
							animate(s,alpha = 255, time = 7)
							x.active_splits += s
							sleep(5)
							if(s && m) s.shockwave()
							sleep(3)
							if(s && m)
								x.icon_state = "Psi Clone off"
								/*
								if(m.race == "Human") s.Human()
								if(m.race == "Demon") s.Demon()
								if(m.race == "Celestial") s.Celestial()
								if(m.race == "Imp") s.Imp()
								if(m.race == "Cerebroid") s.Cerebroid()
								if(m.race == "Yukopian") s.Yukopian()
								if(m.race == "Android") s.Android()
								*/
								s.name = "{NPC} Psi Clone"
								s.name_txt()
								s.icon = m.icon
								s.appearance_flags = KEEP_TOGETHER
								s.overlays = m.overlays
								s.mod_psionic_power = m.mod_psionic_power
								s.gains_trained_power = m.gains_trained_power
								s.gains_psiforged_power = m.gains_psiforged_power
								s.dead = m.dead
								if(s.dead) s.psionic_power /= 2
								if(m.wings_hidden == 0) s.wings = m.wings
								s.halo = m.halo
								s.eyes = m.eyes
								s.eyes_white = m.eyes_white
								s.vis_contents += s.eyes
								s.vis_contents += s.eyes_white
								s.strength = m.strength
								s.endurance = m.endurance
								s.force = m.force
								s.mod_str_usage = m.mod_str_usage
								s.mod_force_usage = m.mod_force_usage
								s.mod_agility = m.mod_agility
								s.resistance = m.resistance
								s.offence = m.offence
								s.defence = m.defence
								s.vigour = m.vigour
								s.owner = m.real_name
								s.gains_trained_energy = m.gains_trained_energy
								s.gains_psiforged_energy = m.gains_psiforged_energy
								s.Move(s.loc,SOUTH,s.step_x,s.step_y)
								s.filters = m.filters
								s.set_shadow()
								var/obj/skills/Dig/d = new
								d.loc = s
								for(var/obj/skills/Flight/f in m)
									var/obj/skills/Flight/fly = new
									fly.loc = s
									fly.skill_lvl = f.skill_lvl
									if(f.active)
										call(fly.act)(s,fly)
								return
						else
							m << output("<font color = teal>You need more energy to continue.","chat.system")
							m.set_alert("Need more energy",x.icon,x.icon_state)
							m.create_chat_entry("alerts","Need more energy.")
							return
			New()
				..()
				category = list("Energy","Utility")
				spawn(10)
					src.info = text_focus


			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							if(m.skill_psi_clone == null) m.skill_psi_clone = src
							call(src.act)(m,src)
		Invisibility
			icon_state = "Invisibility off"
			info_name = "invisibility"
			act = /obj/skills/Invisibility/proc/activate
			teach_energy = 2000
			proc
				activate(var/mob/m,var/obj/s)
					if(s in m)
						if(m.skill_invis == null) m.skill_invis = s
						var/needed = (10/m.mod_recovery) + (10/s.skill_lvl)
						if(s.active)
							s.active = 0
							s.icon_state = "Invisibility off"
							if(m.submerged == 0) animate(m,alpha = 255, time = 15)
							else animate(m,alpha = 100, time = 15)
							m.appearance_flags = LONG_GLIDE | KEEP_TOGETHER
							if(m.shadow && m.skill_dig == null || m.skill_dig && m.skill_dig.active == 0) animate(m.shadow,alpha = 255, time = 15)
							//spawn(15)
								//if(m) m.appearance_flags = null
						else if(m.energy >= needed)
							s.active = 1
							s.icon_state = "Invisibility"
							animate(m,alpha = 33, time = 15)
							m.appearance_flags = LONG_GLIDE | KEEP_TOGETHER
							if(m.shadow) animate(m.shadow,alpha = 0, time = 15)
							spawn(15)
								if(m) m.appearance_flags = null
			New()
				..()
				category = list("Energy","Utility")
				spawn(10)
					src.info = text_invisibility


					if(src.disable_sleep) return
					spawn(10)
						while(src)
							var/mob/m = null
							if(ismob(src.loc))
								m = src.loc
								if(src.active)
									var/removes = (10/m.mod_recovery) + (10/src.skill_lvl)
									if(m.energy >= removes)
										//m.energy-=5+((m.energy_max/10)/src.skill_lvl)/m.mod_recovery/m.mod_energy
										m.energy -= removes
										//world << "[removes] energy removed by [src]"
										//m << output("<font color = teal>[removes] energy removed by [src]","chat.system")
										//src.skill_exp += (10/src.skill_lvl)*m.mod_skill
										//src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
										src.skill_exp += (2.5-(src.skill_lvl/40)*m.mod_skill)+0.025
										if(src.skill_exp >= 100 && src.skill_lvl < 100)
											src.skill_exp = 1
											src.skill_lvl += 1
											src.skill_up(m)
									else
										m.mouse_dir = "left"
										call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)


		Levitation
			icon_state = "Levitation off"
			info_energy_cost = 1
			info_mastery = 2
			info_point_cost = 1
			teach_energy = 2000
			info_buffs = "Levitation, mobility"
			info_duration = "Toggleable"
			info_point_cost_type = "energy"
			info_name = "levitate"
			hud_x = 404
			hud_y = 636
			act = /obj/skills/Levitation/proc/activate
			info_stats = "Energy Cost: Medium\n\nMastery: Medium\n\nToggleable\n\n+100% movement speed"
			proc
				activate(var/mob/m,var/obj/s)
					if(m.skill_levitation != s) m.skill_levitation = s
					if(s.active)
						m.overlays -= /obj/effects/superfly
						s.active = 0
						m.laymod = 1
						if(m.skill_quicksilver && m.skill_quicksilver.active)
							call(m.skill_quicksilver.act)(m,m.skill_quicksilver)
						m.density_factor = 1
						if(m.shadow) m.shadow.step_size = m.step_size
						if(m.client)
							m.power_sources -= "Levitation"
							m.energy_sources -= "Levitation"
						m.icon_state = m.state()
						s.icon_state = "Levitation off"
						if(m.loc)
							var/turf/t = m.loc
							if(!t.liquid)
								var/obj/effects/dust_medium/d = new
								d.SetCenter(m)
					else if(m.energy>=1)
						if(m.meditating) return
						if(m.skill_flight && m.skill_flight.active) call(m.skill_flight.act)(m,m.skill_flight)
						if(m.submerged)
							m.submerge(0,1,m.loc)
						if(m.client && m.bar_o2) m.client.images -= m.bar_o2
						if(m.loc)
							var/turf/t = m.loc
							if(!t.liquid)
								var/obj/effects/dust_medium/d = new
								d.SetCenter(m)
							else if(t.liquid == "psionic")
								m.submerge(1,1,m.loc)
								if(m.client && m.bar_o2) m.client.images += m.bar_o2
						m.overlays = null
						m.redraw_appearance()
						m.laymod = 1.001
						if(m.skill_quicksilver && m.skill_quicksilver.active)
							call(m.skill_quicksilver.act)(m,m.skill_quicksilver)
						m.density_factor = 0
						s.icon_state = "Levitation"
						s.active = 1
						m.icon_state = m.state()
						//for(var/mob/h in view(8,m))
							//h << sound('fly.mp3',0,0,11,100)
						if(m.shadow) m.shadow.step_size = m.step_size
			New()
				..()
				category = list("Energy","Utility","Buff")
				spawn(10)
					src.info = text_flight
					if(src.disable_sleep) return
					var/mob/m = src.loc
					spawn(10)
						while(src)
							if(ismob(src.loc))
								if(src.active)
									var/e = 5
									if(m.trait_ef) e = 1
									var/removes = (e/m.mod_recovery) + (e/src.skill_lvl)
									if(m.race == "Celestial" && m.wings_hidden == 0)
										if(m.z == 2 || m.z == 6) removes = 0
									if(m.energy >= e)
										m.gain_stat("energy",1,10,"Levitation")
										m.gain_stat("power",1,1,"Levitation")
										m.overlays -= /obj/effects/superfly
										m.energy -= removes
										src.skill_exp += (2.5-(src.skill_lvl/40)*m.mod_skill)+0.025
										if(src.skill_exp >= 100 && src.skill_lvl < 100)
											src.skill_exp = 1
											src.skill_lvl += 1
											src.skill_up(m)
									else
										m.mouse_dir = "left"
										call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
		Flight
			icon_state = "Flight off"
			info_energy_cost = 1
			info_mastery = 2
			info_point_cost = 1
			teach_energy = 2000
			info_buffs = "Flight, Faster movement"
			info_duration = "Toggleable"
			info_point_cost_type = "energy"
			info_name = "flight"
			info_prerequisite = list("Levitation")
			hud_x = 404
			hud_y = 588
			act = /obj/skills/Flight/proc/activate
			info_stats = "Energy Cost: Medium\n\nMastery: Medium\n\nToggleable\n\n+100% movement speed"
			proc
				activate(var/mob/m,var/obj/s)
					if(m.skill_flight != s) m.skill_flight = s
					if(s.active)
						m.overlays -= /obj/effects/superfly
						//m.buffs -= "flying"
						s.active = 0
						m.laymod = 1
						if(m.skill_quicksilver && m.skill_quicksilver.active)
							call(m.skill_quicksilver.act)(m,m.skill_quicksilver)
						m.step_size = 5
						m.density_factor = 1
						if(m.shadow) m.shadow.step_size = m.step_size
						if(m.client)
							m.power_sources -= "Flight"
							m.energy_sources -= "Flight"
						m.icon_state = m.state()
						s.icon_state = "Flight off"
						if(m.loc)
							var/turf/t = m.loc
							if(!t.liquid)
								var/obj/effects/dust_medium/d = new
								d.SetCenter(m)
					else if(m.energy>=1)
						if(m.meditating) return
						if(m.skill_levitation && m.skill_levitation.active) call(m.skill_levitation.act)(m,m.skill_levitation)
						if(m.submerged)
							m.submerge(0,1,m.loc)
						if(m.client && m.bar_o2) m.client.images -= m.bar_o2
						if(m.loc)
							var/turf/t = m.loc
							if(!t.liquid)
								var/obj/effects/dust_medium/d = new
								d.SetCenter(m)
							else if(t.liquid == "psionic")
								m.submerge(1,1,m.loc)
								if(m.client && m.bar_o2) m.client.images += m.bar_o2
						m.overlays -= /obj/effects/swim
						m.laymod = 1.001
						if(m.skill_quicksilver && m.skill_quicksilver.active)
							call(m.skill_quicksilver.act)(m,m.skill_quicksilver)
						m.step_size = 10
						if(m.super_fly) m.step_size = 16
						m.density_factor = 0
						s.icon_state = "Flight"
						s.active = 1
						m.icon_state = m.state()
						//for(var/mob/h in view(8,m))
							//h << sound('fly.mp3',0,0,11,100)
						if(m.shadow) m.shadow.step_size = m.step_size
			New()
				..()
				category = list("Energy","Utility","Buff")
				spawn(10)
					src.info = text_flight


					if(src.disable_sleep) return
					var/mob/m = src.loc
					spawn(10)
						while(src)
							if(ismob(src.loc))
								if(src.active)
									//if(m.submerged)
										//m.mouse_dir = "left"
										//call(src.act)(m,src)
									var/e = 10
									if(m.trait_ef) e = 1
									var/removes = (e/m.mod_recovery) + (e/src.skill_lvl)
									if(m.race == "Celestial" && m.wings_hidden == 0)
										if(m.z == 2 || m.z == 6) removes = 0
									if(m.energy >= e)
										m.gain_stat("energy",1,10,"Flight")
										m.gain_stat("power",1,1,"Flight")
										m.overlays -= /obj/effects/superfly
										//m.overlays += /obj/effects/superfly
										if(m.super_fly)
											m.energy -= removes
											//world << "[removes] energy removed by [src]"
											//m << output("<font color = teal>[removes] energy removed by [src]","chat.system")
										else
											if(m.trait_ef == null)
												//m.energy -= 1+((m.energy_max*0.25)/src.skill_lvl/m.mod_energy)
												m.energy -= removes*2
												//world << "[removes] energy removed by [src]"
												//m << output("<font color = teal>[removes] energy removed by [src]","chat.system")
										//src.skill_exp += (10/src.skill_lvl)*m.mod_skill
										//src.skill_exp += ((5-(src.skill_lvl/20))*m.mod_skill)+0.5
										src.skill_exp += (2.5-(src.skill_lvl/40)*m.mod_skill)+0.025
										if(src.skill_exp >= 100 && src.skill_lvl < 100)
											src.skill_exp = 1
											src.skill_lvl += 1
											src.skill_up(m)
									else
										m.mouse_dir = "left"
										call(src.act)(m,src)
							sleep(10)
			Click(location,control,params)
				..()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(m.koed) return
					params = params2list(params)
					winset(m,"main.map_main","focus=true")
					var/dir = null
					if(params["left"] || m.mouse_dir == "left")
						dir = "left"
					if(params["right"])
						dir = "right"
					if(dir == "left")
						if(src in m)
							call(src.act)(m,src)
					if(dir == "right")
						if(m.super_fly)
							m.super_fly = 0
							m << "Super flight deactivated"
							if(src.active)
								m.step_size = 10
								if(m.shadow) m.shadow.step_size = 10
						else
							m.super_fly = 1
							m << "Super flight active"
							if(src.active)
								m.step_size = 16
								if(m.shadow) m.shadow.step_size = 16
								var/obj/effects/hit/h = new
								h.loc = m.loc
								h.dir = m.dir
								if(m.dir == SOUTH ||m.dir == NORTH) h.pixel_x += 16
								h.step_x = m.step_x
								h.step_y = m.step_y
								spawn(10)
									if(h) h.destroy()
	proc
		dismiss_alert(var/mob/c)
			var/obj/effects/over_displays/lvl_up_overlay/o = src
			for(var/obj/effects/over_displays/lvl_up_overlay/L in c.client.screen)
				if(L != o && L.skill_y > o.skill_y)
					animate(L)
					var matrix2 = matrix().Translate(0,L.skill_y-36)
					animate(L,transform = matrix2, time = 1)
					L.skill_y -= 36
					if(L.skill_y <= -464)
						L.skill_shift(c)
			c.client.screen -= o
			o.filters = null
			o.icon = null
			o.can_click = 0
			o.help_text = null
			o.name = initial(o.name)
			o.skill_y = -464
			var/matrix = matrix().Translate(0,0)
			o.transform = matrix
			animate(o)
			o.reset_use()
			/*
			spawn(100)
				if(o) o.in_use = 0
			*/
		skill_shift(var/mob/c)
			var/obj/effects/over_displays/lvl_up_overlay/o = src
			spawn(40)
				if(c && o && o.in_use)
					animate(o,alpha = 0, time = 30)
					spawn(30)
						if(c && o && o.in_use && o.icon && c.client)
							for(var/obj/effects/over_displays/lvl_up_overlay/L in c.client.screen)
								if(L != o)
									var matrix2 = matrix().Translate(0,L.skill_y-36)
									animate(L,transform = matrix2, time = 1)
									L.skill_y -= 36
									if(L.skill_y <= -464)
										L.skill_shift(c)
							c.client.screen -= o
							//o.in_use = 0
							o.icon = null
							o.can_click = 0
							o.filters = null
							o.help_text = null
							o.name = initial(o.name)
							o.skill_y = -464
							var/matrix = matrix().Translate(0,0)
							o.transform = matrix
							animate(o)
							o.reset_use()
		skill_up(var/mob/c)
			if(c && c.client)
				var/obj/effects/over_displays/lvl_up_overlay/o
				for(var/obj/effects/over_displays/lvl_up_overlay/x in lvl_overlays)
					if(x.in_use == 0)
						x.in_use = 1
						o = x
						break
				if(src && o)
					if(src.icon)
						o.icon = src.icon
						o.icon_state = src.icon_state
						o.alpha = 255

					var/lvl
					var/tech = 0
					var/tutorial = 0
					var/alert = 0

					if(istype(src,/obj/skills/)) lvl = src.skill_lvl
					else if(istype(src,/obj/body_related/)) lvl = src.level
					else if(istype(src,/obj/items/tech/sub_tech)) tech = 1
					else if(istype(src,/obj/help_topics/Alert_Misc)) alert = 1
					else if(istype(src,/obj/help_topics/)) tutorial = 1

					if(tutorial)
						o.icon = 'question_mark.dmi'
						o.maptext = "<span style='-dm-text-outline: 1px #000000;text-align:right'>[src.name] tutorial</span>"
						//o.help_text = src.help_text//"[src.name] - [src.info]"
						o.name = src.name
						o.can_click = 1
						//c.create_chat_entry("alerts","[o.name] - [o.help_text]")
					else if(tech)
						o.maptext = "<span style='-dm-text-outline: 1px #000000;text-align:right'>[src] research finished</span>"
						c.save_alert_history("[src] research finished")
					else if(alert)
						o.maptext = "<span style='-dm-text-outline: 1px #000000;text-align:right'>[src]</span>"
						c.save_alert_history("[src]")
					else if(tech == 0)
						o.maptext = "<span style='-dm-text-outline: 1px #000000;text-align:right'>[src] leveled up to [lvl]</span>"
						c.save_alert_history("[src] leveled up to [lvl]")

					var/huds = 0
					//var/times = 10
					var/times = 8
					for(var/obj/effects/over_displays/lvl_up_overlay/L in c.client.screen)
						if(L != o)
							huds += 1
							//times -= 1
							times += 1
					o.skill_y = -464+(huds*36)
					var/matrix = matrix().Translate(0,-464+(huds*36))
					animate(o,transform = matrix, time = times)
					c.client.screen += o
					if(o.skill_y <= -464) //If its the bottom alert, make it fade over time. Also moves any others above it down a spot.
						spawn(40)
							if(src && c && o) o.skill_shift(c)
		reset_use()
			spawn(100)
				if(src)
					var/obj/effects/over_displays/lvl_up_overlay/o = src
					o.in_use = 0
mob
	proc
		check_skillbar(var/obj/o)
			//Reset a slot if it already belonged to one
			if(src.one && length(src.one) > 0 && o == src.one[1])
				src.one = null
				if(src.client) src.client.screen -= o
			if(src.two && length(src.two) > 0 && o == src.two[1])
				src.two = null
				if(src.client) src.client.screen -= o
			if(src.three && length(src.three) > 0 && o == src.three[1])
				src.three = null
				if(src.client) src.client.screen -= o
			if(src.four && length(src.four) > 0 && o == src.four[1])
				src.four = null
				if(src.client) src.client.screen -= o
			if(src.five && length(src.five) > 0 && o == src.five[1])
				src.five = null
				if(src.client) src.client.screen -= o
			if(src.six && length(src.six) > 0 && o == src.six[1])
				src.six = null
				if(src.client) src.client.screen -= o
			if(src.seven && length(src.seven) > 0 && o == src.seven[1])
				src.seven = null
				if(src.client) src.client.screen -= o
			if(src.eight && length(src.eight) > 0 && o == src.eight[1])
				src.eight = null
				if(src.client) src.client.screen -= o
			if(src.nine && length(src.nine) > 0 && o == src.nine[1])
				src.nine = null
				if(src.client) src.client.screen -= o
			if(src.zero && length(src.zero) > 0 && o == src.zero[1])
				src.zero = null
				if(src.client) src.client.screen -= o
		update_skillbar()
			for(var/obj/hud/h in src.hud_skillbar)
				var/obj/s = null
				if(istype(h,/obj/hud/buttons/skillbar/skillbar_one))
					if(src.one && length(src.one) > 0)
						s = src.one[1]
						//s.screen_loc = "10:-13,1:4"
						h.overlays = null
						h.overlays += /obj/hud/buttons/skillbar/skillbar_one_overlay
						src.client.screen += s

				else if(istype(h,/obj/hud/buttons/skillbar/skillbar_two))
					if(src.two && length(src.two) > 0)
						s = src.two[1]
						//s.screen_loc = "11:-12,1:4"
						h.overlays = null
						h.overlays += /obj/hud/buttons/skillbar/skillbar_two_overlay
						src.client.screen += s

				else if(istype(h,/obj/hud/buttons/skillbar/skillbar_three))
					if(src.three && length(src.three) > 0)
						s = src.three[1]
						//s.screen_loc = "12:-11,1:4"
						h.overlays = null
						h.overlays += /obj/hud/buttons/skillbar/skillbar_three_overlay
						src.client.screen += s

				else if(istype(h,/obj/hud/buttons/skillbar/skillbar_four))
					if(src.four && length(src.four) > 0)
						s = src.four[1]
						//s.screen_loc = "13:-10,1:4"
						h.overlays = null
						h.overlays += /obj/hud/buttons/skillbar/skillbar_four_overlay
						src.client.screen += s

				else if(istype(h,/obj/hud/buttons/skillbar/skillbar_five))
					if(src.five && length(src.five) > 0)
						s = src.five[1]
						//s.screen_loc = "14:-9,1:4"
						h.overlays = null
						h.overlays += /obj/hud/buttons/skillbar/skillbar_five_overlay
						src.client.screen += s

				else if(istype(h,/obj/hud/buttons/skillbar/skillbar_six))
					if(src.six && length(src.six) > 0)
						s = src.six[1]
						//s.screen_loc = "15:-8,1:4"
						h.overlays = null
						h.overlays += /obj/hud/buttons/skillbar/skillbar_six_overlay
						src.client.screen += s

				else if(istype(h,/obj/hud/buttons/skillbar/skillbar_seven))
					if(src.seven && length(src.seven) > 0)
						s = src.seven[1]
						//s.screen_loc = "16:-7,1:4"
						h.overlays = null
						h.overlays += /obj/hud/buttons/skillbar/skillbar_seven_overlay
						src.client.screen += s

				else if(istype(h,/obj/hud/buttons/skillbar/skillbar_eight))
					if(src.eight && length(src.eight) > 0)
						s = src.eight[1]
						//s.screen_loc = "17:-6,1:4"
						h.overlays = null
						h.overlays += /obj/hud/buttons/skillbar/skillbar_eight_overlay
						src.client.screen += s

				else if(istype(h,/obj/hud/buttons/skillbar/skillbar_nine))
					if(src.nine && length(src.nine) > 0)
						s = src.nine[1]
						//s.screen_loc = "18:-5,1:4"
						h.overlays = null
						h.overlays += /obj/hud/buttons/skillbar/skillbar_nine_overlay
						src.client.screen += s

				else if(istype(h,/obj/hud/buttons/skillbar/skillbar_zero))
					if(src.zero && length(src.zero) > 0)
						s = src.zero[1]
						//s.screen_loc = "19:-4,1:4"
						h.overlays = null
						h.overlays += /obj/hud/buttons/skillbar/skillbar_zero_overlay
						src.client.screen += s
		follower_go_dblclick(var/turf/t)
			if(src.target_follower)
				if(ismob(src.target_follower))
					var/mob/NPC/m = src.target_follower
					if(m.owner == src.real_name)
						m.idle_ticks = 0
						m.disable_skills()
						src.left_click_ref = m
						m.idle_ticks = 0
						m.function = "go"
						m.target_go = t
						m.icon_state = m.state()
						if(m.activated == 0)
							m.activated = 1
							m.follower_ai()
		dimiss_all_alerts()
			if(src.client)
				for(var/obj/effects/over_displays/lvl_up_overlay/o in src.client.screen)
					if(src.client) src.client.screen -= o
					//o.in_use = 0
					o.icon = null
					o.can_click = 0
					o.filters = null
					o.help_text = null
					o.name = initial(o.name)
					o.skill_y = -464
					var/matrix = matrix().Translate(0,0)
					o.transform = matrix
					animate(o)
					o.reset_use()

		give_skill(var/p)
			if(src.typing) return
			var/obj/x
			if(src.skill_selected && src.skill_selected.loc == null) x = src.skill_selected
			else
				for(var/obj/skills/s in learnable_skills)
					if(s.name == p)
						x = s
						break
				for(var/obj/traits/s in learnable_traits)
					if(s.name == p)
						x = s
						break
				for(var/obj/stances/st in learnable_stances)
					if(st.name == p)
						x = st
						break
			var/needed = 0
			var/found = 0
			if(x)
				for(var/obj/s in src)
					if(s.type == x.type)
						src.set_alert("Already have [p]",'alert.dmi',"alert")
						src.create_chat_entry("alerts","Already have [p].")
						return
				if(x.info_prerequisite && x.info_prerequisite.len > 0)
					needed = x.info_prerequisite.len
					for(var/obj/s in src)
						for(var/n in x.info_prerequisite)
							if(s.name == n)
								found += 1
				else
					found = 1
					needed = 1
				if(found >= needed)
					var/point_type = x.info_point_cost_type
					switch(point_type)
						if("energy")
							if(src.skill_points_energy >= x.info_point_cost)
								src.skill_points_energy -= x.info_point_cost
							else
								src.set_alert("Not enough Energy points",'alert.dmi',"alert")
								src.create_chat_entry("alerts","Not enough Energy points.")
								return
						if("agility")
							if(src.skill_points_agility >= x.info_point_cost)
								src.skill_points_agility -= x.info_point_cost
							else
								src.set_alert("Not enough Agility points",'alert.dmi',"alert")
								src.create_chat_entry("alerts","Not enough Agility points.")
								return
						if("power")
							if(src.skill_points_power >= x.info_point_cost)
								src.skill_points_power -= x.info_point_cost
							else
								src.set_alert("Not enough Power points",'alert.dmi',"alert")
								src.create_chat_entry("alerts","Not enough Power points.")
								return
						if("strength")
							if(src.skill_points_strength >= x.info_point_cost)
								src.skill_points_strength -= x.info_point_cost
							else
								src.set_alert("Not enough Strength points",'alert.dmi',"alert")
								src.create_chat_entry("alerts","Not enough Strength points.")
								return
						if("recovery")
							if(src.skill_points_recovery >= x.info_point_cost)
								src.skill_points_recovery -= x.info_point_cost
							else
								src.set_alert("Not enough Recovery points",'alert.dmi',"alert")
								src.create_chat_entry("alerts","Not enough Recovery points.")
								return
						if("regen")
							if(src.skill_points_regen >= x.info_point_cost)
								src.skill_points_regen -= x.info_point_cost
							else
								src.set_alert("Not enough Regeneration points",'alert.dmi',"alert")
								src.create_chat_entry("alerts","Not enough Regeneration points.")
								return
						if("resistance")
							if(src.skill_points_resistance >= x.info_point_cost)
								src.skill_points_resistance -= x.info_point_cost
							else
								src.set_alert("Not enough Resistance points",'alert.dmi',"alert")
								src.create_chat_entry("alerts","Not enough Resistance points.")
								return
						if("force")
							if(src.skill_points_force >= x.info_point_cost)
								src.skill_points_force -= x.info_point_cost
							else
								src.set_alert("Not enough Force points",'alert.dmi',"alert")
								src.create_chat_entry("alerts","Not enough Force points.")
								return
						if("combat")
							if(src.skill_points_combat >= x.info_point_cost)
								src.skill_points_combat -= x.info_point_cost
							else
								src.set_alert("Not enough Combat points",'alert.dmi',"alert")
								src.create_chat_entry("alerts","Not enough Combat points.")
								return
						if("endurance")
							if(src.skill_points_endurance >= x.info_point_cost)
								src.skill_points_endurance -= x.info_point_cost
							else
								src.set_alert("Not enough Endurance points",'alert.dmi',"alert")
								src.create_chat_entry("alerts","Not enough Endurance points.")
								return
						if("offence")
							if(src.skill_points_offence >= x.info_point_cost)
								src.skill_points_offence -= x.info_point_cost
							else
								src.set_alert("Not enough Offence points",'alert.dmi',"alert")
								src.create_chat_entry("alerts","Not enough Offence points.")
								return
						if("defence")
							if(src.skill_points_defence >= x.info_point_cost)
								src.skill_points_defence -= x.info_point_cost
							else
								src.set_alert("Not enough Defence points",'alert.dmi',"alert")
								src.create_chat_entry("alerts","Not enough Defence points.")
								return

					var/obj/n = new x.type(src)
					if(n.trait && n.act) call(n.act)(src,n)
					if(!x.info_name) x.info_name = p
					src.set_alert("[n] unlocked successfully",n.icon,n.icon_state)
					src.create_chat_entry("alerts","[n] unlocked successfully")
					src.check_quest("tutorial_unlock_skill",1)
					if(x.img_select) src.client.images += x.img_select
					if(src.origin && src.origin.type == /obj/origins/skilled)
						n.skill_lvl += 24
						src.set_alert("[n] leveled up to [n.skill_lvl]",n.icon,n.icon_state)
						src.create_chat_entry("alerts","[n] leveled up to [n.skill_lvl]")
				else
					src.output_msg("Unable to unlock [p], prerequisites not met.")
					src.set_alert("Prerequisites not met",'alert.dmi',"alert")
					return
		taught_skill(var/mob/teacher,var/obj/skills/s)
			//Make a check to confirm if they have skill already
			var/obj/bar = new /:revive_bar
			var/obj/bar_inner = new /:revive_bar_inner
			var/progress = 0
			src.icon_state = "meditate"
			teacher.icon_state = "meditate"
			src.client.screen += bar
			teacher.client.screen += bar
			src.stunned += 1
			src.stunned_pending += 1
			teacher.stunned += 1
			teacher.stunned_pending += 1
			while(progress < 100)
				progress += 1
				if(src && teacher)
					if(get_dist(src,teacher) <= 8)
						src.client.screen -= bar_inner
						bar_inner.screen_loc  = "15:[round(progress/2)-2],9:-6"
						var/matrix/M = matrix()
						M.Scale(round(progress),1)
						bar_inner.transform = M
						src.client.screen += bar_inner

						teacher.client.screen -= bar_inner
						teacher.client.screen += bar_inner

						progress += 1
					else progress = 100
				else progress = 100
				sleep(1)
			if(src)
				src.client.screen -= bar
				src.client.screen -= bar_inner
				src.stunned -= 1
				src.stunned_pending -= 1
				if(s)
					var/obj/skills/sk = new s.type(src)
					sk.teach_cd = year+3
			if(teacher)
				teacher.client.screen -= bar
				teacher.client.screen -= bar_inner
				teacher.stunned -= 1
				teacher.stunned_pending -= 1
				if(s) s.teach_cd = year+3

		reset_alerts() //For when player logs out, grab all their alerts in their screen and reset them, otherwise the alerts will be in perma-limbo.
			if(src.client)
				var/mob/c = src
				for(var/obj/effects/over_displays/lvl_up_overlay/o in c.client.screen)
					if(c.client) c.client.screen -= o
					o.filters = null
					o.icon = null
					o.can_click = 0
					o.help_text = null
					o.name = initial(o.name)
					o.skill_y = -464
					var matrix = matrix().Translate(0,0)
					o.transform = matrix
					animate(o)
					o.reset_use() //Sent to the obj, rather than player, because the player is about to be deleted. Has a spawn(100) in it.
		dimiss_follower(var/mob/owner)
			src.function = null
			src.disable_skills()
			src.letgo()
			src.shockwave()
			src.icon +=rgb(125,125,125)
			animate(src,alpha = 0, time = 7)
			spawn(7)
				if(owner && src)
					if(owner.skill_psi_clone)
						if(src in owner.skill_psi_clone.active_splits)
							owner.skill_psi_clone.active_splits -= src
					if(owner.skill_divine_weapon)
						if(src in owner.skill_divine_weapon.active_splits)
							owner.skill_divine_weapon.active_splits -= src
					src.dismissed = 1
					src.destroy()
		skill_cooldown(var/obj/skills/s)
			spawn(1)
				if(src && s && s.cd_state <= 32 && s.loc == src && src.client)

					if(s.clone) src.skill_cooldown(s.clone)
					s.vis_contents = null
					if(s.cd_bar == null)
						var/obj/cd_shell = new
						cd_shell.plane = s.plane
						cd_shell.layer = s.layer+1
						cd_shell.icon = 'skills_cd.dmi'
						cd_shell.mouse_opacity = 0
						s.cd_bar = cd_shell

					s.vis_contents += s.cd_bar
					while(s.cd_state > 0)
						s.cd_state -= 1
						s.cd_bar.icon_state = "[s.cd_state]"
						sleep(s.cd_max/32)
					s.cd_state = 32
					animate(s, color = list("#000", "#000", "#000", "#fff"),time = 3)
					animate(color = initial(s.color),time = 3)
					if(src && src.client) s.vis_contents -= s.cd_bar
	proc
		//Follower commands
		follower_give_proc()
			var/mob/NPC/m = src.target_follower
			if(m.owner == src.real_name)
				if(m.divine_weapon == 0)
					if(get_dist(src,m) <= 2)
						return
						winshow(src,"inven",1)
						src.refresh_inv()
						src.open_inven = 1
						src.left_click_function = "clone give"
						src.client.mouse_pointer_icon = 'mouse_left_interact.dmi'
						src.left_click_ref = m
						src.open_menus.Add(".open_inven")
						src << output("Click an item to give [m]","chat.world")
		follower_inv_proc()
			var/mob/NPC/m = src.target_follower
			if(m.owner == src.real_name)
				if(m.divine_weapon == 0)
					if(get_dist(src,m) <= 2)
						//winshow(src,"inven",1)
						src.accessing = m
						src.refresh_inv()
						src.client.screen += src.hud_inv
						src.open_inven = 1
						src.open_menus.Add(".open_inven")
		follower_stop_proc()
			var/mob/NPC/m = src.target_follower
			if(m.owner == src.real_name)
				//if(src.skill_psi_clone)
				m.function = null
				m.target = null
				m.target_follow = null
				m.target_go = null
				m.disable_skills()
				m.letgo()
				if(m.divine_weapon) m.divine_weapon_reset()
		follower_grab_proc(var/atom/tar = null)
			var/mob/NPC/m = src.target_follower
			if(m.owner == src.real_name)
				if(m.divine_weapon == 0)
					m.idle_ticks = 0
					//m.function = "grab"
					m.disable_skills()
					if(tar == null)
						src.left_click_function = "clone grab"
						src.left_click_ref = m
						src << output("Click a target for [m] to grab.","chat.world")
						src << output("Click a target for [m] to grab.","chat.local")
						src.client.mouse_pointer_icon = 'mouse_left_interact.dmi'
						winshow(src,"contacts",0)
						src.open_contacts = 0
						src.open_menus.Remove(".open_contacts")
					else
						m.idle_ticks = 0
						m.function = "grab"
						m.target_go = tar
						m.icon_state = m.state()
					if(m.activated == 0)
						m.activated = 1
						m.follower_ai()
		follower_go_proc()
			var/mob/NPC/m = src.target_follower
			if(m.owner == src.real_name)
				m.idle_ticks = 0
				//m.function = "go"
				m.disable_skills()
				src.left_click_function = "clone go"
				src.left_click_ref = m
				src << output("Click a location for [m] to travel to.","chat.world")
				src << output("Click a location for [m] to travel to.","chat.local")
				src.client.mouse_pointer_icon = 'mouse_left_interact.dmi'
				winshow(src,"contacts",0)
				src.open_contacts = 0
				src.open_menus.Remove(".open_contacts")
				if(m.activated == 0)
					m.activated = 1
					m.follower_ai()
		follower_attack_proc(var/mob/tar = null)
			var/mob/NPC/m = src.target_follower
			if(m.owner == src.real_name)
				m.idle_ticks = 0
				//m.function = "attack"
				m.disable_skills()
				if(m.skill_super_speed) m.skill_super_speed.active = 1
				m.letgo()
				if(tar == null)
					src.left_click_function = "clone attack"
					src.left_click_ref = m
					src << output("Click a target for the attack.","chat.world")
					src << output("Click a target for the attack.","chat.local")
					src.client.mouse_pointer_icon = 'mouse_left_interact.dmi'
					winshow(src,"contacts",0)
					src.open_contacts = 0
					src.open_menus.Remove(".open_contacts")
				else
					m.idle_ticks = 0
					m.function = "attack"
					m.target = tar
					m.target_follow = tar
					m.icon_state = m.state()
				if(m.activated == 0)
					m.activated = 1
					m.follower_ai()
		follower_follow_proc(var/mob/tar = null)
			var/mob/NPC/m = src.target_follower
			if(m.owner == src.real_name)
				//if(src.skill_psi_clone)
				m.idle_ticks = 0
				//m.function = "follow"
				m.disable_skills()
				if(tar == null)
					src.left_click_function = "clone follow"
					src.left_click_ref = m
					src << output("Click a target for [m] to follow.","chat.world")
					src << output("Click a target for [m] to follow.","chat.local")
					src.client.mouse_pointer_icon = 'mouse_left_interact.dmi'
					winshow(src,"contacts",0)
					src.open_contacts = 0
					src.open_menus.Remove(".open_contacts")
				else
					m.idle_ticks = 0
					m.function = "follow"
					m.target = null
					m.target_follow = tar
					m.icon_state = m.state()
				if(m.activated == 0)
					m.activated = 1
					m.follower_ai()
		follower_dismiss_proc()
			var/mob/NPC/m = src.target_follower
			if(m.owner == src.real_name)
				if(m.target_img && src.client) src.client.images -= m.target_img
				for(var/mob/p in players)
					if(m == p.target)
						if(p.client) p.client.screen -= m
						p.add_remove_target(m,1)
				src.target_follower = null
				m.dimiss_follower(src)

		follower_view_proc()
			var/mob/NPC/m = src.target_follower
			if(m.owner == src.real_name)
				if(src.client.eye != src)
					src.client.perspective = EYE_PERSPECTIVE | EDGE_PERSPECTIVE
					src.client.eye = src
				else
					src.client.perspective = EYE_PERSPECTIVE | EDGE_PERSPECTIVE
					src.client.eye = m
					//src.client.mob = m

		follower_dig_proc()
			var/mob/NPC/m = src.target_follower
			if(m.owner == src.real_name)
				if(m.divine_weapon == 0)
					m.function = null
					m.target = null
					m.target_follow = null
					m.target_go = null
					m.disable_skills()
					m.letgo()
					for(var/obj/skills/Dig/d in m)
						call(d.act)(m,d)
						return
	verb
		//Follower commands
		follower_give()
			set name = ".follower_give"
			set hidden = 1
			if(usr.target_follower)
				if(ismob(usr.target_follower))
					usr.follower_give_proc()
		follower_inv()
			set name = ".follower_inv"
			set hidden = 1
			if(usr.target_follower)
				if(ismob(usr.target_follower))
					usr.follower_inv_proc()
		follower_stop()
			set name = ".follower_stop"
			set hidden = 1
			if(usr.target_follower)
				if(ismob(usr.target_follower))
					usr.follower_stop_proc()
		follower_grab()
			set name = ".follower_grab"
			set hidden = 1
			if(usr.target_follower)
				if(ismob(usr.target_follower))
					usr.follower_grab_proc()
		follower_go()
			set name = ".follower_go"
			set hidden = 1
			if(usr.target_follower)
				if(ismob(usr.target_follower))
					usr.follower_go_proc()
		follower_attack()
			set name = ".follower_attack"
			set hidden = 1
			if(usr.target_follower)
				if(ismob(usr.target_follower))
					usr.follower_attack_proc()
		follower_follow()
			set name = ".follower_follow"
			set hidden = 1
			if(usr.target_follower)
				if(ismob(usr.target_follower))
					usr.follower_follow_proc()
		follower_dismiss()
			set name = ".follower_dismiss"
			set hidden = 1
			if(usr.target_follower)
				if(ismob(usr.target_follower))
					usr.follower_dismiss_proc()

		follower_view()
			set name = ".follower_view"
			set hidden = 1
			if(usr.target_follower)
				if(ismob(usr.target_follower))
					usr.follower_view_proc()

		follower_dig()
			set name = ".follower_dig"
			set hidden = 1
			if(usr.target_follower)
				if(ismob(usr.target_follower))
					usr.follower_dig_proc()


		teach_skill(var/p as text)
			set name = ".teach"
			set hidden = 1
			var/obj/skills/x
			var/t = winget(usr,"[p].label_name","text")
			for(var/obj/skills/s in usr)
				if(s.name == t)
					x = s
					break
			if(x) //If we find the skill inside the player that they want to teach, continue.
				if(year >= x.teach_cd) x.teach_cd = 0
				if(x.teach_cd <= 0)
					x.teach_cd = 0
					usr.left_click_function = "teach"
					usr.set_alert("Select target to teach",x.icon,x.icon_state)
					usr.left_click_ref = x
					winshow(usr,"skill_panes",0)
					usr.open_traits = 0
					usr.open_menus.Remove(".open_traits")
				else
					usr << output("<font color = teal>Skills can only be taught every 3 years. Next teaching will be available at year [x.teach_cd].","chat.system")
					usr.set_alert("Available at year [round(x.teach_cd,0.1)]",x.icon,x.icon_state)
					usr.create_chat_entry("alerts","Available at year [round(x.teach_cd,0.1)]")