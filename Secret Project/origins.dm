obj
	origins
		icon = 'new_hud_char_origins.dmi'
		icon_state = "normal"
		var/list/banned_races = list()
		var/image/sel
		var/txt_info
		plane = 24
		layer = 34
		blend_mode = BLEND_INSET_OVERLAY
		appearance_flags = KEEP_TOGETHER | TILE_BOUND | PIXEL_SCALE
		maptext_width = 120
		maptext_height = 16
		maptext_y = 3
		New()
			src.name = "[info_name]"
			var/image/s = image('skills.dmi',src,"origin selected",10)
			src.sel = s
			src.maptext = "[css_outline]<font size = 1><center>[src.info_name]"
		MouseMove(location,control,params)
			..()
			usr.update_info_box(src,src.txt_info,params)
		MouseEntered(location,control,params)
			if(usr.started == 0)
				if(src != usr.origin_selected) src.icon_state = "[initial(src.icon_state)] hover"
			if(src.txt_info && usr.info_box1)
				usr.client.screen += usr.info_box1
				usr.client.screen += usr.info_box2
				usr.client.screen += usr.info_box3
				usr.update_info_box(src,src.txt_info,params)
		MouseExited()
			if(src != usr.origin_selected) src.icon_state = "[initial(src.icon_state)]"
			if(src.txt_info && usr.info_box1)
				usr.client.screen -= usr.info_box1
				usr.client.screen -= usr.info_box2
				usr.client.screen -= usr.info_box3
				usr.info_box3.maptext = null
		Click()
			if(usr.started == 0)
				if(usr.origin_selected) usr.origin_selected.icon_state = "[initial(usr.origin_selected.icon_state)]"
				usr.origin_selected = src
				src.icon_state = "[initial(src.icon_state)] selected"
				if(usr.hud_char)
					var/obj/txt = usr.hud_char.origins_desc_txt
					txt.maptext = "[css_outline]<font size = 1><text align=center valign=top><u>[src.info_name]</u>\n<text align=left valign=top>[src.info]"

			//usr.client.images += src.sel
			//winset(usr,"char_creation.label_origin","text=\"[src.info]\"")
		MouseWheel(delta_x,delta_y,location,control,params)
			var/obj/hud/menus/char_creation_background/s = usr.hud_char
			var/obj/sc = s.scroller_origins

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
			var/scroll_y = round(700*ratio)

			for(var/obj/txt in s.origins_txt_holder.vis_contents)
				var/matrix/m2 = matrix()
				m2.Translate(txt.hud_x,txt.hud_y+scroll_y)
				txt.transform = m2
		//Mental and physical quirks all players can pick for their character, not the same as traits.
		none
			act = /obj/origins/none/proc/activate
			info_name = "None"
			info = "You don't have any particular origin, except one you create for yourself in-character."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						m.origin = s
						s.active = 1
		superpowered
			act = /obj/origins/superpowered/proc/activate
			banned_races = list("Yukopian","Cerebroid","Android","Demon","Celestial","Imp")
			info_name = "Superpowered"
			New()
				..()
				src.info = "You seem to have inherited amazing super strength, the ability to fly and shoot lasers from your eyes!\n\nPerhaps you were part of a super soldier program run by a clandestine branch of the government that somehow managed to survive the apocalypse.\n\nOr maybe some cosmic occurrence effected you directly, imbuing you with great power and responsibility.\n\nHowever you came upon these powers, either through birth or otherwise, they have gifted you with a [css_strength]Strength<font color = white> mod of 10, Flight, Laser Eyes, but a 300% weakness to radiation, and all your other stat mods are set to 1."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						m.origin = s
						s.active = 1
						m.mod_agility = 1
						m.mod_endurance = 1
						m.mod_strength = 10
						m.mod_offence = 1
						m.mod_defence = 1
						m.mod_resistance = 1
						m.mod_force = 1
						m.mod_regeneration = 1
						m.mod_recovery = 1
						m.mod_immune_rads = -3
						m.immune_rads_trained = -3
						m.gains_trained_strength_mod = 10
						m.gains_trained_endurance_mod = 1
						m.gains_trained_agility_mod = 1
						m.gains_trained_force_mod = 1
						m.gains_trained_resistance_mod = 1
						m.gains_trained_off_mod = 1
						m.gains_trained_def_mod = 1
						m.gains_trained_regen_mod = 1
						m.gains_trained_recov_mod = 1
						m.strength = 10
						m.endurance = 1
						m.offence = 1
						m.defence = 1
						m.resistance = 1
						m.force = 1
						if(!locate(/obj/skills/Flight) in m)
							new /obj/skills/Flight (m)
						if(!locate(/obj/skills/Eye_Laser) in m)
							new /obj/skills/Eye_Laser (m)
			/*
			- x10 strength mod
			- Start with fly, laser eyes and x-ray vision skills
			- 200%-300% weakness to radiation
			- 50% reduction to skill learning and psiforging times
			- 50% reduction to regen/recov
			- Human/Alien only trait
			*/
		quicksilver
			act = /obj/origins/quicksilver/proc/activate
			info_name = "Quicksilver"
			banned_races = list("Yukopian","Cerebroid","Android","Demon","Celestial","Imp")
			New()
				..()
				src.info = "Your movement speed is cataclysmically fast, allowing you to travel on foot at a rate far beyond the capabilities of even the most well trained and powerful beings.\n\nEither through some genetic quirk, a mutation, freak accident or perhaps an experiment, you were born or enhanced with quicksilver speeds.\n\nWith this origin, you start with the Super Speed and Quicksilver skills, and have an [css_agility]Agility<font color = white> mod of 10. However, all your other stat mods are set to 1, and the faster you travel the more heat damage you take. Quicksilver will not work when you're cold."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.mod_agility = 10
						m.mod_endurance = 1
						m.mod_strength = 1
						m.mod_offence = 1
						m.mod_defence = 1
						m.mod_resistance = 1
						m.mod_force = 1
						m.mod_regeneration = 1
						m.mod_recovery = 1
						if(!locate(/obj/skills/Quicksilver) in m)
							m.skill_quicksilver = new /obj/skills/Quicksilver (m)
						if(!locate(/obj/skills/Super_Speed) in m)
							new /obj/skills/Super_Speed (m)
			// Able to move very very very fast
			// Can cause damage to environment nearby
			// Sets agility to x10
			// Can get very hot and take damage if moving for too long.
			// Start with super speed, but can't be taught.
			// Can't maintain a Stance due to ADHD, lol. Moves too fast to maintain basically.
		organ_donor
			act = /obj/origins/organ_donor/proc/activate
			info_name = "Organ Donor"
			info = "You sold your left kidney to a less than scrupulous individual or corporation, but now you're rich!\n\nYou start with +20,000,000 resources, but you should probably avoid contact sports for a while."
			banned_races = list("Android","Demon","Celestial")
			proc
				activate(var/mob/m,var/obj/s)
					m.resources += 20000000
					m.update_rsc()
					m.origin = s
					s.active = 1
					for(var/obj/body_related/bodyparts/torso/trs in m.bodyparts)
						for(var/obj/body_related/bodyparts/torso/left_kidney/lk in trs)
							m.damage_limb(m,0, 1, 100,lk)
							m.hurt_limbs -= lk
							lk.destroy()
							m.total_organs -= 1
							break
			// Start with lots of resources
			// Missing a kidney
			// Can only be selected by human/alien
			// Create a save file for the player key when this origin procs, saving the origin obj itself. So they can't re-roll for different things.
		prosperous
			act = /obj/origins/prosperous/proc/activate
			info_name = "Prosperous"
			info = "Perhaps you've always had a knack for accumulating wealth, or maybe you inherited a large sum of money from someone, or perhaps you stole it.\n\nWhatever the case, you start out with +10,000,000 resources to your name."
			banned_races = list("Yukopian","Android")
			proc
				activate(var/mob/m,var/obj/s)
					m.resources += 10000000
					m.update_rsc()
					m.origin = s
					s.active = 1
			// Start with lots of resources
			// Create a save file for the player key when this origin procs, saving the origin obj itself. So they can't re-roll for different things.
		mutant
			act = /obj/origins/mutant/proc/activate
			info_name = "Mutant"
			banned_races = list("Yukopian","Android","Demon","Celestial")
			New()
				..()
				src.info = "You may have been subjected to over exposure to radioactive forces, or perhaps been the test subject of some kind of experiment.\n\nOne thing is for certain though, that extra organ didn't used to be there and you seem to now possess a healthly green glow!\n\nWith this origin, you gain a random mutation in one of your stat mods, increasing it by +1.\n\nYou also gain an extra organ in your head or torso. Not only that, but you're also immune to most forms of radiation. However, the stress on your body has lowered your [css_recov]Recovery<font color = white> stat by 50%, along with your projected lifespan."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						m.origin = s
						s.active = 1
						var/stat = pick("str","end","agil","force","res","regen","eng","off","def")
						var/part = pick("heart","liver","spleen","stomach","pancreas","intestine","lobe","thyroid")

						if(stat == "str")
							m.mod_strength += 1
							m.gains_trained_strength_mod += 1
							m.strength += 1
						else if(stat == "end")
							m.mod_endurance += 1
							m.gains_trained_endurance_mod += 1
							m.endurance += 1
						else if(stat == "agil")
							m.mod_agility += 1
							m.gains_trained_agility_mod += 1
						else if(stat == "force")
							m.mod_force += 1
							m.gains_trained_force_mod += 1
							m.force += 1
						else if(stat == "res")
							m.mod_resistance += 1
							m.gains_trained_resistance_mod += 1
							m.resistance += 1
						else if(stat == "regen")
							m.mod_regeneration += 1
							m.gains_trained_regen_mod += 1
						else if(stat == "eng")
							m.mod_energy += 1
							m.gains_trained_energy_mod += 1
							m.energy += 1
						else if(stat == "off")
							m.mod_offence += 1
							m.gains_trained_off_mod += 1
							m.offence += 1
						else if(stat == "def")
							m.mod_defence += 1
							m.gains_trained_def_mod += 1
							m.defence += 1

						var/obj/t = null
						var/obj/h = null
						for(var/obj/body_related/bodyparts/torso/trs in m.bodyparts)
							t = trs
							break
						for(var/obj/body_related/bodyparts/head/hd in m.bodyparts)
							h = hd
							break

						if(part == "heart")
							var/obj/body_related/bodyparts/torso/heart/hrt = new
							hrt.loc = t
							hrt.name = "Extra [hrt.info_name]"
						else if(part == "liver")
							var/obj/body_related/bodyparts/torso/liver/liv = new
							liv.loc = t
							liv.name = "Extra [liv.info_name]"
						else if(part == "spleen")
							var/obj/body_related/bodyparts/torso/spleen/spl = new
							spl.loc = t
							spl.name = "Extra [spl.info_name]"
						else if(part == "stomach")
							var/obj/body_related/bodyparts/torso/stomach/stm = new
							stm.loc = t
							stm.name = "Extra [stm.info_name]"
						else if(part == "pancreas")
							var/obj/body_related/bodyparts/torso/pancreas/pan = new
							pan.loc = t
							pan.name = "Extra [pan.info_name]"
						else if(part == "intestine")
							var/obj/body_related/bodyparts/torso/small_intestines/int = new
							int.loc = t
							int.name = "Extra [int.info_name]"
						else if(part == "lobe")
							m.give_extra_lobe(1)
						else if(part == "thyroid")
							var/obj/body_related/bodyparts/head/thyroid/thy = new
							thy.loc = h
							thy.name = "Extra [thy.info_name]"

						m.mod_immune_rads = 1
						m.immune_rads_trained = 1
						m.mod_recovery /= 1.5
						m.total_organs += 1
						m.lifespan /= 1.5
						//m.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(0,150,0))

						//world << "DEBUG - stat = [stat], part = [part]"
			// No radiation damage
			// One random mutated stat
			// One extra organ
			// Lower lifespan
			// Lower recov
			// Create a save file for the player key when this origin procs, saving the origin obj itself. So they can't re-roll for different things.
		reincarnated
			act = /obj/origins/reincarnated/proc/activate
			info_name = "Reincarnated"
			banned_races = list("Android")
			New()
				..()
				src.info = "Your soul is older, stronger and more developed than most for your age.\n\nUnlike younger souls which have yet to fully coalesce into a potent force, yours seems to have consolidated into a more coherant pattern.\n\nThe only reason for this must be that through some means, you managed to reincarnate into a new body. You start with +10 x your stat mods, in all your core stats, except [css_energy]Energy<font color = white> and [css_psionic_power]Psionic Power<font color = white>."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						m.gains_trained_strength += 10
						m.strength += 10*m.mod_strength
						m.gains_trained_endurance += 10
						m.endurance += 10*m.mod_endurance
						m.gains_trained_force += 10
						m.force += 10*m.mod_force
						m.gains_trained_resistance += 10
						m.resistance += 10*m.mod_resistance
						m.gains_trained_off += 10
						m.offence += 10*m.mod_offence
						m.gains_trained_def += 10
						m.defence += 10*m.mod_defence
						m.age_soul = 100
						s.active = 1
						m.origin = s
			// +10*stat_mod starting stats
		cyberpunk
			act = /obj/origins/cyberpunk/proc/activate
			info_name = "Cyberpunk"
			banned_races = list("Android","Demon","Celestial","Imp","Yukopian")
			info = "You have a fascination with cybertech and via sheer luck, clever saving, inheritance or some other means, you have acquired a few pieces of cyber hardware.\n\nNot only that, your body seems more suitable and accepting of cybernetic enhancements.\n\nWith this origin, you start with three random pieces of cybertech that you can apply to yourself. Also, each of your body parts can have one extra peice of cybertech installed."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						for(var/obj/body_related/bodyparts/b in m.bodyparts)
							for(var/obj/body_related/bodyparts/l in b)
								l.cybernetics_max += 1
						var/times = 3
						var/list/cyber_creation = cybertech.Copy()
						while(times)
							times -= 1
							var/obj/x = pick(cyber_creation)
							cyber_creation -= x
							var/obj/body_related/bodyparts/cybernetics/I = new x.type()
							I.name = I.info_name
							I.loc = m
							I.desc = "Level: [I.level]/1000 \n[initial(I.info)]"
							m.pickup(I,1)
		vampire
			act = /obj/origins/vampire/proc/activate
			info_name = "Bitten"
			banned_races = list("Yukopian","Cerebroid","Android","Demon","Celestial","Imp")
			info = "*UNFINISHED*\n\n<font color = red>This origin can be complicated and possibly not recommended for beginners.\n\n<font color = white>Something bit you! Ouch! Or was it someone?....You're not sure, was it always this bright out here?...\n\nSomethings changing within you. You feel weak, faint and feverish and it's only been a few hours. You seek shelter for now.\n\nWith this origin, you start out bitten by a creature of the night. You start out underground, hiding from the sun. Once the initial fever passes, you will become a Vampire!\n\nHowever, being a newly spawned creature of the night, you will require more blood than older Vampires.\n\nFurther more, you start out incredibly weak, with only 0.2 in every Core Statistic. As each in game year passes, you gain + 0.1 in your Core Statistics.\n\nYou can no longer eat food and the sun harms you. You take even more damage from absorbing or being near sources of Divine Energy."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						spawn(1)
							if(m) m.loc = locate(290,50,2)
						for(var/obj/body_related/bodyparts/head/h in m.bodyparts)
							for(var/obj/body_related/bodyparts/head/neck_muscles/nm in h)
								m.damage_limb(m,0, 1, 100,nm)
								break
							for(var/obj/body_related/bodyparts/head/head_skin/hs in h)
								m.damage_limb(m,0, 1, 100,hs)
								break
						m.divine_energy_mod = 0
						m.divine_energy = 0
						m.dark_matter_mod = 2

						m.need_food = "No"
						m.need_water = "Yes"
						m.need_o2 = "No"
						m.need_sleep = "Yes"
						m.tiredness_rate = 0.05
						m.metabolic_rate = 0
						m.dehydration_rate = 0.2
						m.has_stomach = 0

						m.mod_psionic_power = 1
						m.mod_energy = 2
						m.mod_strength = 0.2
						m.mod_agility = 2
						m.mod_endurance = 0.2
						m.mod_force = 0.2
						m.mod_resistance = 0.2
						m.mod_offence = 0.2
						m.mod_defence = 0.2
						m.mod_regeneration = 2
						m.mod_recovery = 2
						m.mod_sense = 1
						m.mod_tech_potential = 1
						m.mod_arcane_potential = 4

						m.gains_trained_power_mod = 1
						m.gains_trained_energy_mod = 2
						m.gains_trained_strength_mod = 0.2
						m.gains_trained_endurance_mod = 0.2
						m.gains_trained_agility_mod = 2
						m.gains_trained_force_mod = 0.2
						m.gains_trained_resistance_mod = 0.2
						m.gains_trained_off_mod = 0.2
						m.gains_trained_def_mod = 0.2
						m.gains_trained_regen_mod = 2
						m.gains_trained_recov_mod = 2

						m.mod_immune_rads = 0.5
						m.mod_immune_cold = 2
						m.mod_immune_heat = -1
						m.mod_immune_gravity = 0.25
						m.mod_immune_microwaves = 0
						m.mod_immune_toxins = 2

						m.immune_rads_trained = 0.5
						m.immune_cold_trained = 2
						m.immune_heat_trained = -1
						m.immune_gravity_trained = 0.25
						m.immune_microwaves_trained = 0
						m.immune_toxins_trained = 2

						m.lifespan = 1.#INF
						m.oldage = 1.#INF
						m.vampire = 1
					else
						m.mod_psionic_power += 0.1
						m.mod_energy += 0.1
						m.mod_strength += 0.1
						m.mod_agility += 0.1
						m.mod_endurance += 0.1
						m.mod_force += 0.1
						m.mod_resistance += 0.1
						m.mod_offence += 0.1
						m.mod_defence += 0.1
						m.mod_regeneration += 0.1
						m.mod_recovery += 0.1

						m.gains_trained_power_mod += 0.1
						m.gains_trained_energy_mod += 0.1
						m.gains_trained_strength_mod += 0.1
						m.gains_trained_endurance_mod += 0.1
						m.gains_trained_agility_mod += 0.1
						m.gains_trained_force_mod += 0.1
						m.gains_trained_resistance_mod += 0.1
						m.gains_trained_off_mod += 0.1
						m.gains_trained_def_mod += 0.1
						m.gains_trained_regen_mod += 0.1
						m.gains_trained_recov_mod += 0.1
		blessed
			act = /obj/origins/blessed/proc/activate
			info_name = "Blessed"
			banned_races = list("Android")
			info = "Via divine intervention, you seem to have been blessed. Some otherworldly force or sentience took an interest in you and changed the course of your destiny.\n\nDivine Energy flows through and around you much more easily than others, collecting and settling into your body.\n\nWith this origin, you gain +50% more Divine Energy whenever it is granted to you."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						m.divine_energy_mod = 1.5
						s.active = 1
						m.origin = s
			// +50% divine energy gains
		cursed
			act = /obj/origins/cursed/proc/activate
			info_name = "Cursed"
			banned_races = list("Android")
			info = "Malevolent forces have taken a keen interest into your soul, cursing it with unnatural potency.\n\nBaleful energies flow in and around you more easily, hexing your body with ever greater malignant intensity.\n\nWith this origin, you gain +100% more Dark Matter Energy whenever it is granted to you."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						m.dark_matter_mod = 2
						s.active = 1
						m.origin = s
			// +50% dark matter gains
		unstable
			act = /obj/origins/unstable/proc/activate
			info_name = "Unstable"
			banned_races = list("Human","Yukopian","Cerebroid","Android","Celestial","Imp")
			info = "*UNFINISHED*\n\nYour demonic ectoplasm is exceptionally unstable, causing you to sporadically shed layers of yourself with explosive fury.\n\nWith this origin, you spontaneously erupt and instantaneously mutate a new body part, or level up an older one. However, you are never sure when this might happen and it can cause you to take damage."
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Periodically gain lvls in a random bodypart
			// Sheds 10% health when doing so, mini self-destruct?
			// Demon only origin
		baleful
			act = /obj/origins/baleful/proc/activate
			info_name = "Baleful"
			banned_races = list("Human","Yukopian","Cerebroid","Android","Celestial","Imp")
			New()
				..()
				src.info = "Your demonic ectoplasm is laced with such incredibly potent spiritual anguish as to be entirely poisonous to those nearby.\n\nMalignant energy lashes off you in the likeness of a dying stars death throes, draining anyone too close of their will to live.\n\nWith this origin, you drain those around you of [css_energy]Energy<font color = white>."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						var/obj/effects/shield/o = new
						o.pixel_y = -73
						o.pixel_x = -76
						o.icon = 'baleful.dmi'
						m.vis_contents += o

			// Slowly drain energy from everyone nearby
			// Demon only trait
		exalted
			act = /obj/origins/exalted/proc/activate
			info_name = "Exalted"
			banned_races = list("Human","Yukopian","Cerebroid","Android","Demon","Imp")
			New()
				..()
				src.info = "Your brilliant celestial light shines forth for all to bare witness, whether they like it or not.\n\nLike the light from a great shining star, your righteous unbridled purity manifests itself as wondrous rays. That others are unable to withstand its intensity is proof of their spiritual shortcomings.\n\nWith this origin, anyone standing too close to you has their eyes slowly damaged, it also gives you +10% to your [css_def]Defence<font color = white> stat mod, due to the blinding brilliance of your light."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						var/dif = (m.mod_defence*1.1)-m.mod_defence
						m.mod_defence += dif
						m.gains_trained_def_mod += dif
						var/obj/effects/exalted_rays/rays = new
						rays.layer = m.layer-0.2
						m.vis_contents += rays
						//m.filters += filter(type="outline",size=1, color=rgb(204,236,255))
			// Slowly blind anyone nearby with your brilliant light
			// +10% def
			// Celestial only origin
		imperious
			act = /obj/origins/imperious/proc/activate
			info_name = "Imperious"
			banned_races = list("Human","Yukopian","Cerebroid","Android","Demon","Imp")
			info = "*UNFINISHED*\n\nSome would consider you arrogant, forceful or overbearing, but weighed up against the pure insurmountable evidence of your natural superiority, it is no wonder others are jealous of your near-god like brilliance.\n\nAlas, those who consider you condescending are below you anyway, merely souls of a less maturity and calibre.\n\nYour Celestial soul is proof of your righteousness, manifest for all to see. You're just unable to create anything better than acquaintances in regards to your contacts.\n\nBut being around those who are weaker and need your guidiance, gives you more exp in every area."
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Gain more xp in everything when near someone weaker
			// Unable to set contacts as anything better than acquaintances
			// Celestial only origin
		solar_powered
			act = /obj/origins/solar_powered/proc/activate
			info_name = "Solar Powered"
			banned_races = list("Human","Celestial","Cerebroid","Android","Demon","Imp")
			New()
				..()
				src.info = "You have a unique cellular structure, even for a Yukopian. Via the process of photosynthesis, you are able to convert light into energy.\n\nHowever, as expected, this only works while above ground. With this origin, you will passively gain [css_energy]Energy<font color = white> exp while on the surface of a planet or realm."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Gain passive energy while above ground
			// Yukopian origin only
		hale
			act = /obj/origins/hale/proc/activate
			info_name = "Hale"
			banned_races = list("Android","Demon","Celestial")
			info = "Your body is in top shape. Perhaps you were born this way, or years of looking after your body has paid off, giving you a heathly outlook on life and providing a fitness unrivaled by many.\n\nYour bones are denser and your muscles tightly wound with great potential, and each and everyone of your organs are heathly and strong.\n\nWith this origin, you gain +1 levels to all your body parts starting out."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						m.lvl_typesof_bodypart(list("Muscle","Bone","Organ"),100) //+(round(year)*100))
						s.active = 1
						m.origin = s
			// Fit, heathly and having worked out and looked after their body.
			// +1 to every bodypart
		skilled
			act = /obj/origins/skilled/proc/activate
			info_name = "Skilled"
			banned_races = list("Android")
			info = "Not many can easily rival you in time spent perfecting skills. The sky is the limit, and even then you're sure there's heights beyond heights to reach.\n\nNot only that, but you've a keen knack for learning a little faster than most.\n\nWith this origin, all skills you start with, and gain later, start at level 25. Furthermore, you earn exp in those skills 10% faster."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.mod_skill = 1.1
			// Spent/spend a lot of time perfecting skills
			// +25 levels in all skills inherently, old and new
			// +10% skill level exp
		empath
			act = /obj/origins/empath/proc/activate
			info_name = "Empath"
			banned_races = list("Android")
			info = "You understand people easier than most and not only can you sympathize with others, but also empathize with them on both an emotional and intellectual level.\n\nThis sense borders on the preternatural, experiencing others emotions as if they were your very own.\n\nDue to this, you find it easier to create and maintain relatonships with others.\n\nWith this origin, you gain +100% familiarity points towards any contacts."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Gain +100% points toward contacts
		charismatic
			act = /obj/origins/charismatic/proc/activate
			info_name = "Charismatic"
			banned_races = list("Cerebroid","Android")
			info = "*UNFINISHED*\n\nYour skills with people are solid and reliable, a truly magnetic force capable of attracting those of likemind to your cause.\n\nWhether through sheer charm, being a likable person, situation or circumstance, you begin your journey with two followers dedicated to you."
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
		intellectual
			act = /obj/origins/intellectual/proc/activate
			info_name = "Intellectual"
			banned_races = list("Android")
			info = "*UNFINISHED*\n\nYou possess a highly tuned intelligence and interest in scientific endeavours.\n\nNot only that, but you are also well versed in multiple fields of study, ranging from mechanical design to genetic modification.\n\nWith this origin, you start out with 1 x your intelliegnce mod, as levels in Engineering, Physics and Genetics."
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Start with +1*intelligence+year levels in all base research trees
			// -10% in all stat mods
		blind
			act = /obj/origins/blind/proc/activate
			info_name = "Blind"
			banned_races = list("Android")
			info = "*UNFINISHED*\n\nYour eyes don't work like they used to before. Or perhaps they never worked at all in the first place. Or maybe they were injured somehow.\n\nWhatever the case, you're unable to level up, or heal your eyes. However, your body seems to have adapted to compensate for this shortcoming.\n\nInstead, you gain x 2 stats on both ears, having learned to use them instead of your less than poor eyesight."
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Unable to level up eyes or gain them via incubation
			// x2 stats for ears
			// Slightly blurry screen? Or grey scaled at least
		deaf
			act = /obj/origins/deaf/proc/activate
			info_name = "Deaf"
			banned_races = list("Android")
			info = "*UNFINISHED*\n\nYour hearing has been lost, whether from an accident, birth defect or foul play. Distant sounds are now naught but whispers, a faint echo or like being underwater.\n\nWith this origin, you're unable to understand what anyone says, and can't level up or heal your ears, but to compensate, your body has adjusted and your eyesight is second to none. You gain x 2 stats on both eyes instead."
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Unable to level up ears or gain them via incubation
			// x2 stats for eyes
			// Unable to hear people speak
		mute
			act = /obj/origins/mute/proc/activate
			info_name = "Mute"
			banned_races = list("Android")
			info = "*UNFINISHED*\n\nWhether through trauma or neurological problems, or perhaps even the loss of your tongue, you're just unable to speak.\n\nInstead, you've learned to rely on your other perceptions, your listening and sight increasing. With this origin, you're unable to level up your tongue, but your eyes and ears gain +50% to their stats given."
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Unable to speak or lvl up throat or gain them via incubation
			// +50% stats for eyes/ears
		level_headed
			act = /obj/origins/level_headed/proc/activate
			info_name = "Level Headed"
			banned_races = list("Human","Yukopian","Cerebroid","Android","Demon","Celestial")
			New()
				..()
				src.info = "You have an incredibly calm demeanor, even for an Imp. Even during the midst of battle, your mind is as sharp as ever.\n\nYou carefully weigh your options, making sure to only act when appropriate. Others might consider you slow and ponderous until they realize that every move is at least two ahead of their own.\n\nWith this origin, you gain +100% to your [css_off]Offence<font color = white> mod, but -100% to your [css_agility]Agility<font color = white>."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.mod_offence *= 2
						m.mod_agility /= 2
			// +100% offence mod
			// -100% agility mod
			// Imp only origin
		blink
			act = /obj/origins/blink/proc/activate
			info_name = "Blink"
			banned_races = list("Human","Yukopian","Cerebroid","Android","Demon","Celestial")
			info = "*UNFINISHED*\n\nYou have a great distain and adversion to being hit by others. You just simply do not tolerate it.\n\nHowever, as an Imp, your physical ability to be agile is somewhat limted, so you have adaped in other ways. Teleportation comes second nature to your people, but you take it to another level.\n\nWhen someone tries to strike you in melee and lands a hit, you blink away in a flash of light, reappearing nearby. "
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Teleport when hit
			// Imp only origin
		berserker
			act = /obj/origins/berserker/proc/activate
			info_name = "Berserker"
			banned_races = list("Android")
			icon_state = "unfinished"
			New()
				..()
				src.info = "*UNFINISHED*\n\nYou have a legendary rage boiling within, barely contained and always simmering. When unleashed, it is a thing to behold.\n\nWith this origin, when you fall below, and remain below, 50% health, you become angry and your [css_psionic_power]Psionic Power<font color = white> increases by +50%."
			proc
				activate(var/mob/m,var/obj/s)
			// Get angry when below 50% health
		retardant
			act = /obj/origins/retardant/proc/activate
			info_name = "Retardant"
			banned_races = list("Android")
			info = "The lick of flame and lash of heat doesn't effect you nearly as much as others. Through some means only known to yourself, be it intense meditation or some quirk of your birth, you have become immune to lower forms of heat.\n\nHowever, you seem more susceptible to cold temperatures. With this origin, you gain +100% toward your heat tolerance, but -50% to your cold tolerance."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.mod_immune_heat += 1
						m.mod_immune_cold -= 0.5
						m.immune_heat_trained += 1
						m.immune_cold_trained -= 0.5
			// +100% heat resistance
			// -50% cold resistance
		cryonic
			act = /obj/origins/cryonic/proc/activate
			info_name = "Cryonic"
			banned_races = list("Android")
			info = "The cold never bothered you anyway. Either through great effort on your part, or some quirk stemming from your birth, or a cosmic blessing of kinds, you've gained immunity to lower forms of cold damage.\n\nHowever, you seem more susceptible to hot temperatures. With this origin, you gain +100% toward your cold tolerance, but -50% to your heat tolerance."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.mod_immune_heat -= 0.5
						m.mod_immune_cold += 1
						m.immune_heat_trained -= 0.5
						m.immune_cold_trained += 1
			// +100% resistance to cold
			// - 50% resistance to heat
		talented
			act = /obj/origins/talented/proc/activate
			info_name = "Talented"
			banned_races = list()
			info = "Through either hard work, sheer determination, careful planning, luck, or a combination of all these factors, you've managed to become a highly talented individual.\n\nYour raw potential in martial arts training has gifted you with wisdom and training far beyond your years. With this origin, you start with +3 trait points, which you can spend to unlock stances and traits."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.skill_points_combat += 3
		atomic
			act = /obj/origins/atomic/proc/activate
			info_name = "Atomic"
			banned_races = list("Android")
			info = "Somehow, either through some twist of fate or intense training, you've managed to become totally and utterly immune to lower and higher forms of radiation damage.\n\nWith this origin, you gain +200% radiation tolerance. Furthermore, radiation also heals you slowly over time."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.mod_immune_rads = 2
						m.immune_rads_trained = 2
			// +200% resistance to radiation
			// healed by radiation
		gravitonic
			act = /obj/origins/gravitonic/proc/activate
			info_name = "Gravitonic"
			banned_races = list("Android")
			info = "Gravitational waves and ripples in space don't seem to effect you like others. Through some strange twist of fate or bizarre scientific experiment, the notion of gravity holds little weight over you.\n\nNot only that, but you can repulse yourself into the air. With this origin, you gain +50% toward gravity tolerance, and start with the Flight ability."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.mod_immune_gravity += 0.5
						m.immune_gravity_trained += 0.5
						if(!locate(/obj/skills/Flight) in m)
							new /obj/skills/Flight (m)
			// +50% resistance to gravity
			// Start with flight
		hacker
			act = /obj/origins/hacker/proc/activate
			info_name = "Hacker"
			banned_races = list("Android","Yukopian")
			info = "*UNFINISHED*\n\nA locked door to you is just a challenge waiting to be completed, unauthorized access an exciting prospect to be realized.\n\nYour expertise in infiltration is second to none, able to see patterns in security systems with a clarity that borders on prodigious.\n\nWith this origin, you start with the hacking skill, and you're able to gain an icreasing number of clues to the nature of a locked doors password with each hacking attempt."
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Gets special hacking skill
			// Can by-pass locked doors
		rooted
			act = /obj/origins/rooted/proc/activate
			info_name = "Rooted"
			banned_races = list("Android")
			info = "*UNFINISHED*"
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			//Can't be knocked back as far while not flying
		monk
			act = /obj/origins/monk/proc/activate
			info_name = "Monk"
			banned_races = list("Android")
			info = "*UNFINISHED*\n\nYou take your meditation seriously, perhaps liking a serene and harmonious environment in which to delve into the secrets of the soul.\n\nOr maybe you are easily distracted, or work best alone. Whatever the case, you just seem to get better results when people aren't making a noise nearby.\n\nWith this origin, you gain +50% meditation gains when nobody is fighting or talking nearby."
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Meditation gains +50% when nobody nearby fighting
		mentalist
			act = /obj/origins/mentalist/proc/activate
			info_name = "Mentalist"
			banned_races = list("Android")
			info = "*UNFINISHED*"
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Able to start with mental battle technique
		lost_astronaut
			act = /obj/origins/lost_astronaut/proc/activate
			info_name = "Lost Astronaut"
			banned_races = list("Android","Yukopian","Cerebroid","Demon","Celestial","Imp")
			info = "*UNFINISHED*"
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Can choose what planet to start on
		drafter
			act = /obj/origins/drafter/proc/activate
			info_name = "Drafter"
			banned_races = list("Android","Yukopian")
			info = "*UNFINISHED*\n\nYou've a special proficiency for working with schematics, plans and diagrams, to the point you could create one simple enough for an ape to follow and complete.\n\nWith this origin, you can create one use schematics of tech items for others to use. Only one schematic can be created every 6 months, since the time invested to create one is much longer than usual, to make sure that anyone without much understanding of engineering can work with them."
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Can create one use/off plans for tech items players can use
		teacher
			act = /obj/origins/teacher/proc/activate
			info_name = "Teacher"
			banned_races = list("Android")
			info = "*UNFINISHED*\n\nYou make a superb teacher, able to explain even the most complex and intricate subjects to others with relative ease. Not only that, you're able to do so much more often than others.\n\nWith this origin, you can teach others an unlimtied number of times, instead of having to wait for a cooldown between teaching sessions."
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Can teach more often/unlimited times
		masterpiece
			act = /obj/origins/masterpiece/proc/activate
			info_name = "Masterpiece"
			banned_races = list("Alien","Human","Yukopian","Imp","Android","Demon","Celestial")
			info = "*UNFINISHED*\n\nYou awake from your cloning vat to find that someone has left a priceless piece of technology nearby. Did you make it? Was it someone else? Perhaps both are true. All you remember is how it works and a distant, blurry memory of its construction, unsure as to whether its manifestation was something you were involved in, or simply watched. With this origin, a random piece of powerful technology is left nearby for you to use, with the knowledge to operate already at hand."
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Can create/start with one super high-tech item
			// Only Cerebroid can choose this origin
			// Create a save file for the player key when this origin procs, saving the origin obj itself. So they can't re-roll for different things.
		lightning_rod
			act = /obj/origins/lightning_rod/proc/activate
			info_name = "Lightning Rod"
			banned_races = list("Android")
			info = "*UNFINISHED*"
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Is often struck by lightning
			// Start with psionic lightning skill
			// +10% resistance mod
		vim
			act = /obj/origins/vim/proc/activate
			info_name = "Vim"
			banned_races = list("Android")
			info = "Your projected lifespan is much higher than many others.\n\nBe it good genetics, luck, strange cosmic interference or some other strange occurance, your body seems destined to hang onto life no matter what.\n\nWith this origin, your lifespan is increased by +100%."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.lifespan *= 2
			// Doubles lifespan
		lucky
			act = /obj/origins/lucky/proc/activate
			info_name = "Lucky"
			banned_races = list("Android")
			info = "*UNFINISHED*\n\nNo matter what happens, you always seem to come out on top. Through fated luck-strewn chance alone do you ride the currents of probability and seem to beat the odds.\n\nWith this origin, you always roll the highest results on any luck-based random numbers."
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
			// Always rolls highest value of any random numbers
		clone
			act = /obj/origins/clone/proc/activate
			info_name = "Clone"
			banned_races = list("Android","Yukopian","Cerebroid","Demon","Celestial","Imp")
			info = "You awake within a glass tube, confused and dazed, perhaps with no memory of what transpired prior to your internment.\n\nOr maybe you retain your memory and knowledge that this is a copy of your original body. Whatever the case, you are a clone and seem to at least remember an old skill you used to make use of.\n\nFurther more, your prior experiences seem to have imparted the ability to earn skill xp +25% faster than other people. But you feel weak and all your body parts are hurt, along with a -50% life span penalty."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.mod_skill = 1.25
						m.lifespan /= 2
						for(var/obj/body_related/bodyparts/b in m.bodyparts)
							for(var/obj/body_related/bodyparts/o in b)
								m.damage_limb(m,0, 1, 50,o)
						var/obj/skills/sk = pick(learnable_skills)
						sk = sk.type
						if(!locate(sk) in m)
							new sk (m)
							//world << "DEBUG - chose [sk] as the skill. Didn't find another instance so made on"
						//else world << "DEBUG - chose [sk] as the skill. Already found an instance."
			// Short lifespan
			// +25% skill exp
			// Infertile
			// One random skill
			// One random tech
			// Start with disabled/crippled and hurt limbs
			// Create a save file for the player key when this origin procs, saving the origin obj itself. So they can't re-roll for different things.
		fruit_of_the_gods
			act = /obj/origins/fruit_of_the_gods/proc/activate
			info_name = "Fruit Of The Gods"
			banned_races = list("Android","Cerebroid")
			info = "Chance would have it that you happen upon a special fruit, saturated and overflowing with divine energy.\n\nIt seems a little too ripe, but you can sense the throbbing, undulating power within. The very skin crawls with electrostatic pulses of energy and consuming it would no doubt confer a great boon.\n\nEating the fruit grants 1 level in all your organs, but in doing so overloads them. Furthermore, you gain +10 lifespan and +10 x your divine energy mod, in divine energy."
			proc
				activate(var/mob/m,var/obj/s)
					var/obj/items/consumables/divine_fruit_overripe/fr = new
					fr.loc = m
					m.pickup(fr,1)
					m.origin = s
			// Start with a divine fruit
			// It's overripe and not as good as a real one
			// Eating it causes organ dmg and disables them all until they heal
		knight
			// Start with armour and a sword
			// Order of technological psionic knights from before the apocalypse, set out to see demon and mutants destroyed.
			// Start with banish/bind skill?
			// Lower gains when near demon/mutant? Hates them so much can't concentrate?
			// Start with a virtue or two unlocked
			act = /obj/origins/knight/proc/activate
			info_name = "Knight"
			banned_races = list("Yukopian","Cerebroid","Android","Demon","Celestial","Imp")
			info = "*UNFINISHED*"
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
		deceased
			act = /obj/origins/deceased/proc/activate
			info_name = "Deceased"
			banned_races = list("Android","Demon","Celestial","Imp")
			info = "You died, a long time ago. By what means, only you know now. But your time within the Psionic Realms hasn't been for naught, for your very soul seems to have absorbed some of that realms ambient divine energy.\n\nWith this origin, you start out dead, but gain +100 Divine Energy. Furthermore, you've finally learned to reform your body and start out with the Reformation skill."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.Death("Deceased origin",0)
						m.divine_energy = 100//*year
						if(!locate(/obj/skills/Reformation) in m)
							new /obj/skills/Reformation (m)
			// Start out dead, but with enough divine energy saved to create a body
			// + 200 or so divine energy
		abducted
			info_name = "Abducted"
			act = /obj/origins/abducted/proc/activate
			info = "*UNFINISHED*"
			banned_races = list("Android","Cerebroid")
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Start out badly hurt, koed, with all limbs, organs and bones disabled.
			// Fall to planet after having been aducted
			// Missing a kidney
			// Wake up with strange powers, telekinesis, telepathy, remote viewing
			// Unable to choose if psionic realm race
		sealed
			info_name = "Sealed"
			info = "*UNFINISHED*"
			act = /obj/origins/sealed/proc/activate
			banned_races = list("Android")
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Sealed inside a tech prison if mortal
			// Sealed inside a crystal prison if from psi realms
			// Unable to leave for 10+ years
			// Start with astral projection
			// Prison filled with gravity, water and radiation
		old_pod
			info_name = "Old Pod"
			info = "*UNFINISHED*"
			act = /obj/origins/old_pod/proc/activate
			banned_races = list("Android")
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Finds an old Cerebroid space pod
			// Can use to travel around space early, ect.
		spirit_friend
			info_name = "Spirit Friend"
			info = "*UNFINISHED*"
			act = /obj/origins/spirit_friend/proc/activate
			banned_races = list("Android")
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// A psionic manifestation follower spawns with the player
			// Shaped like the fairy from Zelda
			// Is able to fight very effectively and/or defend the player
		hypnotized
			info_name = "Hypnotized"
			info = "*UNFINISHED*"
			act = /obj/origins/hypnotized/proc/activate
			banned_races = list("Android")
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// While at 100% health, believe you're better than you are
			// +10% to all stats and mods while at 100% health
		teleporter
			info_name = "Teleporter"
			info = "*UNFINISHED*"
			act = /obj/origins/teleporter/proc/activate
			banned_races = list("Android")
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Own a device that allows the player to teleport where they want, but only once.
		terminally_ill
			info_name = "Terminally Ill"
			banned_races = list("Android")
			act = /obj/origins/terminally_ill/proc/activate
			info = "*UNFINISHED*"
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// +100% skill gains until death
			// +100% contact point gains until death
			// +100% Divine Energy mod until death
		unlucky_inventor
			info_name = "Unlucky Inventor"
			banned_races = list("Android")
			info = "*UNFINISHED*"
			act = /obj/origins/unlucky_inventor/proc/activate
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Invented something super high tech, but died while testing it.
		regeneration
			info_name = "Regeneration"
			info = "*UNFINISHED*"
			act = /obj/origins/regeneration/proc/activate
			banned_races = list("Human","Yukopian","Cerebroid","Android","Demon","Celestial","Imp")
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Alien only
			// Higher regen
			// Death regen
			// Regrow missing limbs/organs
		precognition
			info_name = "Precognition"
			info = "*UNFINISHED*"
			act = /obj/origins/precognition/proc/activate
			banned_races = list("Human","Yukopian","Cerebroid","Android","Demon","Celestial","Imp")
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Alien only
			// higher defence
			// auto-dodge energy attacks?
		matter_absorption
			info_name = "Matter Absorption"
			info = "*UNFINISHED*"
			act = /obj/origins/matter_absorption/proc/activate
			banned_races = list("Human","Yukopian","Cerebroid","Android","Demon","Celestial","Imp")
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Alien only
			// absorb others for power
		hypnotic
			info_name = "Hypnotic"
			info = "*UNFINISHED*"
			act = /obj/origins/hypnotic/proc/activate
			banned_races = list("Human","Yukopian","Cerebroid","Android","Demon","Celestial","Imp")
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Alien only
			// Freeze someone in place, force vs resis
		chameleon
			info_name = "Chameleon"
			info = "*UNFINISHED*"
			act = /obj/origins/chameleon/proc/activate
			banned_races = list("Human","Yukopian","Cerebroid","Android","Demon","Celestial","Imp")
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Alien only
			// gives skill invisiblity
			// can't be sensed from far away?
		changeling
			info_name = "Changeling"
			info = "*UNFINISHED*"
			act = /obj/origins/changeling/proc/activate
			banned_races = list("Human","Yukopian","Cerebroid","Android","Demon","Celestial","Imp")
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Alien only
			// Can switch to any other species' form
		metamorph
			info_name = "Metamorph"
			info = "*UNFINISHED*"
			act = /obj/origins/metamorph/proc/activate
			banned_races = list("Human","Yukopian","Cerebroid","Android","Demon","Celestial","Imp")
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Alien only
			// Can enter a cacoon for a year and change all their stats
		parasite
			info_name = "Parasite"
			info = "*UNFINISHED*"
			act = /obj/origins/parasite/proc/activate
			banned_races = list("Android","Demon","Celestial")
			icon_state = "unfinished"
			info = "*UNFINISHED*\n\nYou are not you, but a parasite for a host body. A symbiote. You share a parasitic symbiotic relationship with your host, having managed to wrap yourself around their spine."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// True form is a worm that wraps itself around the brain stem of a species
			// Lets you body swap with others
			// Can send special signals throughout host body that boost power but harm bodyparts
		aquatic
			info_name = "Aquatic"
			info = "*UNFINISHED*"
			act = /obj/origins/aquatic/proc/activate
			banned_races = list("Human","Yukopian","Cerebroid","Android","Demon","Celestial","Imp")
			icon_state = "unfinished"
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Alien only
			// Has gills body part
			// can survive underwater without o2
		robust
			info_name = "Robust"
			act = /obj/origins/robust/proc/activate
			banned_races = list("Android")
			info = "*UNFINISHED*\n\nYour muscles and limbs are incredibly malleable, and your organs are especially susceptible to change. Not only that, they're also much tougher compared to other people.\n\nWith this origin, your body parts gain +25% extra health, and you also gain +25% extra Psiforging exp."
			icon_state = "unfinished"
			// +25% limb health
			// +25% to pisforging xp
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
		chosen_one
			info_name = "Chosen One"
			act = /obj/origins/chosen_one/proc/activate
			banned_races = list("Android")
			New()
				..()
				src.info = "You are the Chosen One! Some cosmic force or strange nature of the universe has revealed itself to you and granted you immense power. Or at least, you would be the Chosen One, if nobody else was also chosen. With this origin, your [css_psionic_power]Psionic Power<font color = white> increases by +100%. However, the power of the Chosen One is divided amongst all other chosen. The more people who choose this origin, the weaker it becomes."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						chosen_ones += 1
		bunker_bot
			act = /obj/origins/bunker_bot/proc/activate
			info_name = "Bunker Bot"
			banned_races = list("Human","Yukopian","Cerebroid","Android","Demon","Celestial","Imp")
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
			// Android only
			// Start as an imobile super computer
			// Start with one Android body/follwer to control
			// Can upgrade self and create new bodies to control
			// Can create hologram
		adamantium_endoskeleton
			act = /obj/origins/adamantium_endoskeleton/proc/activate
			info_name = "Adamantium Endoskeleton"
			banned_races = list("Human","Yukopian","Cerebroid","Demon","Celestial","Imp")
			New()
				..()
				src.info = "Fashioned in star-fire-like heat, your internal endoskeletal structure is made entirely out of the hardest substance known to exist. With such incredible durability, you are as close to impervious from physical harm as anyone could be.\n\nThe tensile strength of your form is even enough to withstand gravity orders of magnitudes higher than any of your kind.\n\nWith this origin, you start with a 10 [css_endurance]Endurance<font color = white> mod, but all your other mods remain at 1. Further more, your Gravity Tolerance is +75%, instead of only +50%.\n\nHowever, due to the complexity of the materials you were created from, your self-repair is lacking, setting [css_regen]Regeneration<font color = white> to only 0.5."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						m.origin = s
						s.active = 1
						m.mod_agility = 1
						m.mod_endurance = 10
						m.mod_strength = 1
						m.mod_offence = 1
						m.mod_defence = 1
						m.mod_resistance = 1
						m.mod_force = 1
						m.mod_regeneration = 0.5
						m.mod_recovery = 1
		clandestine_infiltration_unit
			act = /obj/origins/clandestine_infiltration_unit/proc/activate
			info_name = "Infiltration Unit"
			banned_races = list("Human","Yukopian","Cerebroid","Demon","Celestial","Imp")
			info = "Some mysterious governmental entity before the apocalypse designed your machine body to be the perfect infiltration unit. Via some long lost metallurgy and technological processes, you were designed to better resist electromagnetic forces, including microwave radiation.\n\nFurther more, your hardware includes a state of the art cloaking device that allows you to become invisible. However, your resistance toward gravitational forces is reduced slightly due to the delicate components used in your construction.\n\nWith this origin, you have a +50% Microwave Tolerance, start with the Invisibility skill, but have a +25% gravity Tolerance instead of +50%."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.mod_immune_gravity = 0.25
						m.mod_immune_microwaves = 0.5
						m.immune_gravity_trained = 0.25
						m.immune_microwaves_trained = 0.5
		overclocked
			act = /obj/origins/overclocked/proc/activate
			info_name = "Overclocked"
			banned_races = list("Human","Yukopian","Cerebroid","Demon","Celestial","Imp")
			New()
				..()
				src.info = "Through either design flaw, accident, glitch or purposeful installation, your internal software has been calibrated to run at a much higher efficiency than others of your kind.\n\nSuch an adjustment is both a boon and a curse to your form, for even the best components accumulate wear and tear over time. With this origin, your systems produce twice as much [css_psionic_power]Psionic Power<font color = white> as other Androids, but your [css_energy]Max Energy<font color = white>, Lifespan and [css_recov]Recovery<font color = white> are halved.\n\nBecause you also overheat easily, you also have 50% less Heat Tolerance."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.mod_psionic_power *= 2
						m.mod_energy /= 2
						m.lifespan /= 2
						m.mod_recovery /= 2
						m.mod_immune_heat -= 0.5
						m.immune_heat_trained -= 0.5
						m.set_decline()
		self_learning_algorithms
			act = /obj/origins/self_learning_algorithms/proc/activate
			info_name = "Self Learning Algorithms"
			banned_races = list("Human","Yukopian","Cerebroid","Demon","Celestial","Imp")
			info = "Your artificial brain has been modified and fine-tuned to process and accommodate enormous amounts of data. The artisan-ship of your artificial intelligence is second to none, bolstering the rate at which your CPU can run.\n\nWith this origin, your Artificial Brain passively gains exp at all times, without the need for upgrades."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
		bio_processor
			//Start with ability to eat
			act = /obj/origins/bio_processor/proc/activate
			info_name = "Bio Processor"
			banned_races = list("Human","Yukopian","Cerebroid","Demon","Celestial","Imp")
			info = "You were designed with a special bio processing system that allows organic matter to be broken down into useful materials.\n\nWith this origin, you gain an extra internal component, and can now eat all foods that you find."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.has_stomach = 1
						m.metabolic_rate = 0.1
						m.dehydration_rate = 0.1
						var/obj/body_related/bodyparts/torso/t = m.bodyparts[2]
						m.total_organs += 1
						var/obj/body_related/bodyparts/torso/bio_processor/o = new
						o.name = o.info_name
						o.loc = t
		excavator
			//Start with level 100 digging
			act = /obj/origins/excavator/proc/activate
			info_name = "Excavator"
			banned_races = list("Human","Yukopian","Cerebroid","Demon","Celestial","Imp")
			info = "Built for the purposes of resource extraction, your robust design perfectly compliments the rigorous work of hauling and sifting through rock and stone.\n\nWith this origin, your digging skill starts at level 100."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						for(var/obj/skills/Dig/d in m)
							m.skill_dig = d
							d.skill_lvl = 100
							break
		advanced_research_systemizer
			//Start with higher int mod
			act = /obj/origins/advanced_research_systemizer/proc/activate
			info_name = "Advanced Research Systemizer"
			banned_races = list("Human","Yukopian","Cerebroid","Demon","Celestial","Imp")
			info = "Your artificial consciousness was designed to compute complex abstract concepts, granting a better understanding of the nature of the universe around you.\n\nAs such, you find it much easier and quicker to progress advanced technological research categories.\n\nWith this origin, your Intelligence mod is increased by +1, allowing for faster research and lower Resource cost for technology you create."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.mod_tech_potential += 1
		ultra_accelerated_reconstructive_system
			//Start with higher regen mod
			act = /obj/origins/ultra_accelerated_reconstructive_system/proc/activate
			info_name = "Ultra Accelerated Reconstructive System"
			banned_races = list("Human","Yukopian","Cerebroid","Demon","Celestial","Imp")
			New()
				..()
				src.info = "Created with special attention to your self-repair systems, you regenerate from damage much quicker than others of your kind.\n\nSophisticated diagnostic repair systems were compiled into your design, along with the installation of a special type of liquid-metal that responds to electromagnetism.\n\nWhen activated, these pseudo nanite-like micro structures begin to reconstruct damaged systems and replace broken parts at an astonishing rate.\n\nWith this origin, your [css_regen]Regeneration<font color = white> mod is set to 5, with every other mod set to 1. Also your [css_recov]Recovery<font color = white> mod is set to 0.5, and your Lifespan is doubled due to wear and tear on parts being managed more easily."
			proc
				activate(var/mob/m,var/obj/s)
					if(s.active == 0)
						s.active = 1
						m.origin = s
						m.mod_agility = 1
						m.mod_endurance = 1
						m.mod_strength = 1
						m.mod_offence = 1
						m.mod_defence = 1
						m.mod_resistance = 1
						m.mod_force = 1
						m.mod_regeneration = 5
						m.mod_recovery = 0.5
						m.lifespan *= 2