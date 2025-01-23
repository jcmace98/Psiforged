mob
	var
		list/attacked_text
		list/attack_text
		task
		function = null;
		active = 0
		tmp/idle_ticks = 0
	proc
		speech_bubble(var/list/x)
			var/t = pick(x)
			var/obj/effects/txt/s = new
			s.pixel_y = 16
			s.pixel_x = -12
			s.filters += filter(type="outline", size=1, color=rgb(0,0,0))
			s.filters += filter(type="drop_shadow", size=1, offset = 8, color=rgb(255,255,255))
			s.maptext = "[src.name]: [t]"
			var/image/I = new(s,src)
			for(var/mob/m in range(8,src))
				if(m.client)
					m << I
			src.txt_say = I
			I.pixel_z = -100
			I.alpha = 0
			animate(I, pixel_z = 0, alpha = 225, time = 10, easing = ELASTIC_EASING)
			spawn(length(s.maptext)+10)
				if(I) animate(I,alpha = 0,25)
		reset_dialogue(var/mob/m = null)
			if(m) src.talk_to = m
			winset(src,"dialogue.continue","is-visible=false")
			winset(src,"dialogue.option1","is-visible=false")
			winset(src,"dialogue.option2","is-visible=false")
			winset(src,"dialogue.option3","is-visible=false")
			winset(src,"dialogue.option4","is-visible=false")
			winset(src,"dialogue.option5","is-visible=false")
			winset(src,"dialogue.option6","is-visible=false")
			winset(src,"dialogue.option7","is-visible=false")
			winset(src,"dialogue.option8","is-visible=false")
			winset(src,"dialogue.option9","is-visible=false")
			winset(src,"dialogue.option10","is-visible=false")
			winset(src,"dialogue.option11","is-visible=false")
			winset(src,"dialogue.option12","is-visible=false")
			src.topic = null
			src << output(null,"dialogue.dialogue")
		follower_ai(var/n = rand(1111,9999))
			/*
			Some new ideas for the npc ai.
			So give the npc a list of commands
			Then once they finish one command, move onto another.
			For instances like attack others, followed by a grab command. Make it intelligent in that, it waits until the enemy is koed before grabbing them.
			For instances like "search an area", ect. Make a hidden timer for the max time they will spend doing that task before moving onto the next.
			If any of the commands don't make sense, skip it.
			*/

			//world << "DEBUG - running [n]"
			if(src.dismissed) return
			if(src.activated)
				//world << "[src] activated"
				var/T = 10
				if(src.loc == null)
					src.function = null
					src.bar_health = null
					src.bar_energy = null
					src.vis_contents = null
					if(src.owner)
						for(var/mob/m in players)
							if(m.real_name == src.owner)
								src.loc = m.loc
								src.filters = m.filters
								break
				else if(src.koed)
					T = 10
					src.function = null
					//world << "DEBUG - koed"
				else if(src.function == "follow" || src.function == "attack")
					if(src.target_follow)
						//world << "DEBUG - following/attacking"
						T = 0.5
						var/dist = bounds_dist(src, src.target_follow)
						if(dist >= 16 && src.orbiting == 0) if(!src.target_follow.KB && !src.KB) step_towards(src,src.target_follow)
						if(dist >= 640 || src.target_follow.koed) src.target_follow = null
						if(function == "attack" && src.target)
							if(src.divine_weapon == 0) src.Attack()
							else if(src.orbiting == 0)
								if(dist <= 16)
									src.orbiting = 1
									var/d = src.GetAngle(src.target.loc)
									src.orbiting(src,src.target, 0.1,192,d,"attack")
									animate(src,transform = turn(matrix(), 120), time = 6, loop = -1)
									animate(transform = turn(matrix(), 240), time = 6)
									animate(transform = null, time = 6)
									//world << "DEBUG - trying to orbit [src.target]"
								else
									step_towards(src,src.target_follow)
							else if(dist <= 24) src.Attack()
					else src.function = null
				else if(src.function == "go" || src.function == "grab")
					//world << "DEBUG - going/grabbing"
					if(src.target_go)
						T = 0.5
						if(!src.KB)
							step_towards(src,src.target_go)
							var/dist = bounds_dist(src, src.target_go)
							if(dist <= 0)
								if(src.function == "grab" && ismovable(src.target_go))
									src.grab_something(src.target_go)//src.pickup(src.target_go)
									T = 30
								else if(src.function == "go") src.function = null
					else src.function = null
				//src.icon_state = src.state()
				if(src.function == null && src.grab == null)
					src.idle_ticks += 10
					//world << "DEBUG - doing nothing"
					if(src.idle_ticks > 100)
						if(src.divine_weapon == 0)
							if(src.skill_dig)
								if(src.skill_dig.active == 0) src.icon_state = "meditate"
							else src.icon_state = "meditate"
						src.idle_ticks = 0
						src.activated = 0
						//world << "[src] deactivated"
						return
				spawn(T)
					if(src && src.activated)
						if(src.shadow)
							src.set_shadow()
							/*
							src.shadow.loc = src.loc
							src.shadow.step_x = src.step_x+3
							src.shadow.step_y = src.step_y
							*/
						src.follower_ai(n)
			else
				if(src.divine_weapon == 0)
					if(src.skill_dig)
						if(src.skill_dig.active == 0) src.icon_state = "meditate"
					else src.icon_state = "meditate"
				src.idle_ticks = 0
				src.activated = 0
				//world << "[src] deactivated"
				return
	NPC
		/*
		Spawn some NPC in the game that act like players.
		They will decide from a list what to do.
		Make it so if they decide to do something mundane like meditate, they might do it for ages. Put them to sleep so their procs don't bog things, make the sleep/spawn higher.

		.:Actions:.
		Some might start digging
		Explore
		Meditate
		Search for items
		Steal items
		Search for fights
		Fight one another
		Fight player
		Build a house
		Build tech
		Gather/use divine energy
		Gather/use dark matter
		Gift players items
		Practice buffs like Focus, expand, ect.
		Telepath people
		*/
		hashadow = 1
		var
			tmp/track_ko = null
			tmp/returning = 0
			tmp/list/commands = list()
			prob_ki_atk = 5
			prob_stop_charge = 5
			prob_stop_atk = 5
			test_num = 0
		proc
			npc_ai()
				//Make it so npc can make a choice to use different skills
				//Maybe one buff skill chosen?
				//If high energy, use flight?
				//Drops random items, like resources, consumables, and very rarely things like skillbooks, when koed.
				spawn(1)
					if(src)
						if(src.active) return
						else src.active = 1
						while(src.active)
							var/spd = 10
							var/home_dis = get_dist(src,src.start_loc)
							if(src.koed)
								src.target = null //If koed, reset everything
								src.returning = 0
								src.active_attack = null
								src.active = 0
								src.mouse_down = null
							else if(src.stunned)
								src.active_attack = null
								src.mouse_down = null
							else if(src.returning) //If already returning home, make the steps.
								step_towards(src,src.start_loc)
								spd = 0.5
								if(home_dis < 2)
									src.returning = 0
									src.active = 0
									src.active_attack = null
									src.target = null
									src.mouse_down = null
									src.dir = SOUTH
									if(src.skill_flight.active) call(src.skill_flight.act)(src,src.skill_flight)
							else if(home_dis > 32) //If too far away from start loc, return home.
								src.target = null
								src.mouse_down = null
								src.returning = 1
								if(src.skill_flight && src.skill_flight.active == 0) call(src.skill_flight.act)(src,src.skill_flight)
								spd = 0.5
							else if(src.target) //If they actually have a target, process this code.
								if(src.target.koed)
									src.target = null //If the target is koed, reset target.
									src.returning = 1
									src.active_attack = null
									src.mouse_down = null
									if(src.skill_flight && src.skill_flight.active == 0) call(src.skill_flight.act)(src,src.skill_flight)
								else if(src.grabbed_by && src.target != src.grabbed_by) src.target = src.grabbed_by //Otherwise if  being grabbed by a player, reset target to that player.
								//If npc is not using or charging an attack.
								else if(src.active_attack == null && prob(src.prob_ki_atk) && src.energy >= 11)
									var/s = pick(src.skill_charge,src.skill_beam,src.skill_blast)
									//Choose to use blast
									if(s == src.skill_blast && src.skill_blast)
										spd = 0.5
										spawn(0.1)
											if(src)
												src.mouse_down = src.target.loc
												src.current_attack = src.skill_blast
												//src.skill_blast.active = 1
												call(src.skill_blast,src.skill_blast.act)(src)
									//Choose to use charge
									else if(s == src.skill_charge && src.skill_charge)
										spd = 0.5
										spawn(0.1)
											if(src)
												src.mouse_down = src.target.loc
												src.current_attack = src.skill_charge
												src.skill_charge.active = 1
												call(src.skill_charge,src.skill_charge.act)(src)
									//Choose to use beam
									else if(s == src.skill_beam && src.skill_beam)
										spd = 0.5
										spawn(0.1)
											if(src)
												src.mouse_down = src.target.loc
												src.current_attack = src.skill_beam
												src.skill_beam.active = 1
												call(src.skill_beam,src.skill_beam.act)(src)
								//If charging or using an attack
								else if(src.active_attack)
									spd = 2
									if(src.mouse_down)
										if(prob(src.prob_stop_charge))
											src.mouse_down = null
											if(src.skill_charge && src.current_attack == src.skill_charge) spd = 10 //Small delay when using charge, to stop npc warping into their own attack.
									else if(prob(src.prob_stop_atk))
										src.active_attack = null
										spd = 10
								else if(src.skill_flight && src.skill_flight.active == 0 && src.energy > 1000 && prob(10)) call(src.skill_flight.act)(src,src.skill_flight)
								else if(src.skill_super_speed) //Otherwise should make them super speed to target and attack them
									src.Attack()
									spd = 2
								else if(bounds_dist(src,src.target) > 16) //Otherwise if far away, walk toward them.
									step_towards(src,src.target,4)
									spd = 0.5
									if(src.prob_ki_atk > 0)
										var/p_atk = src.prob_ki_atk
										src.prob_ki_atk = 0
										spawn(20)
											if(src) src.prob_ki_atk = p_atk
								else if(bounds_dist(src,src.target) <= 16)//Otherwise attack them in melee when this close.
									src.Attack()
									spd = 2
								//If charging attack, back away from target.
								if(src.mouse_down || src.active_attack)
									if(src.energy <= 10)
										src.active_attack = null
										src.mouse_down = null
									else if(bounds_dist(src,src.target) <= 64)
										var/d = get_dir(src.target,src)
										step(src,d,8)
										spd = 0.4
							src.get_mouse_pos()
							sleep(spd)
							/*
							else if(src.energy < src.energy_max || src.percent_health < 100)
								src.icon_state = "meditate"
								src.healing()
								spd = 10
							else
								src.icon_state = ""
								src.dir = SOUTH
								spd = 60
							*/
							//sleep(spd)
		Robots
			Android
				icon = 'android.dmi'
				name = "{NPC} Android"
				gender = "neuter"
				agressive = 1
				race = "Android"
				appearance_flags = KEEP_TOGETHER

				attacked_text = "-.. . ..-. . -. -.-. .     .- .-.. --. --- .-. .. - .... -- ...         .- -.-. - .. ...- .- - . -.. �-�-�-"
				attack_text = ".--. .-. . .--. .- .-. .     - ---     -... .     .--. .-. --- -.-. . ... ... . -..     .- -. -..     .--. ..- .-. --. . -.. �-�-�-"
				Click(location,control,params)
					..()
					params = params2list(params)
					if(params["right"])
						usr.open_dialogue = 1
						usr.open_menus.Add(".close_dialogue")
						if(get_dist(usr,src) < 3)
							usr.talk_to = src
							winshow(usr, "dialogue", 1)

							winset(usr,"dialogue.label_title","text=\"[src.name]\"")
							winset(usr,"dialogue.age_text","text=\"[src.age]\"")
							winset(usr,"dialogue.gender_text","text=\"[src.gender]\"")


							var/icon/I = icon(src.icon,"",EAST,1,0)
							I.Scale(128,128)

							if(src.hair)
								var/icon/E = icon(src.hair.icon,"",EAST,1,0)
								E.Scale(128,128)

								//var/obj/Z = new
								I.Blend(E,ICON_OVERLAY)
							//Z.icon = E

							var/X = fcopy_rsc(I)
							winset(usr,"dialogue.portrait","image=\ref[X]")
				New()
					..()
					src.set_lists()
					sleep(100)
					//src.Android()
					set_stats(33,3333,33,100,33,100,50,50)
					src.name_txt()

					src.faction = factions[4]

					if(src.shadow) src.shadow.loc = src.loc
					while(src)
						if(src.koed == 0 && src.stunned == 0)
							if(src.village) if(!src.target)
								if(get_dist(src,src.village) < 40)
									if(src.task == null)
										if(prob(1)) src.task = "wait"
										else if(prob(99)) step_rand(src)
										else src.dir = rand(1,8)
									else if(prob(0.25))
										src.task = null ; src.icon_state = src.state()
								else step_towards(src,src.village)
							if(src.target)
								var/dist = bounds_dist(src, src.target)
								if(dist >= 32) step_towards(src,src.target)
								if(dist >= 320 || src.target.koed) src.target = null
							//else if(prob(0.1)) src.hate_list = list()
						sleep(0.5)
		Bosses
			Elder_One
				//Ancient being, like a C'tan shard or Chutchulu creature
				icon = 'Human_Base_Male.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} Elder One"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					sleep(100)
					src.start_loc = src.loc
					//src.Demon()
					src.name_txt()

					src.energy = 1000
					src.energy_max = 1000
					src.strength = 1
					src.endurance = 1
					src.force = 1
					src.resistance = 1
					src.offence = 1
					src.defence = 1

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src
			Celestial_Bull
				//Gives you the Heart of the Bull (Fire/Ice resistance)
				icon = 'imp_brown_ears_curled.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} Celestial Dragon"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					sleep(100)
					src.start_loc = src.loc
					//src.Demon()
					src.name_txt()

					src.energy = 1000
					src.energy_max = 1000
					src.strength = 1
					src.endurance = 1
					src.force = 1
					src.resistance = 1
					src.offence = 1
					src.defence = 1

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src
			Celestial_Dragon
				//Great, giant mythical chinese dragon that flies around the psionic realms
				icon = 'imp_brown_ears_curled.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} Celestial Dragon"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					sleep(100)
					src.start_loc = src.loc
					//src.Demon()
					src.name_txt()

					src.energy = 1000
					src.energy_max = 1000
					src.strength = 1
					src.endurance = 1
					src.force = 1
					src.resistance = 1
					src.offence = 1
					src.defence = 1

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src
			The_Spinx
				//Desert boss idea. Ancient monk who is dead and mumified. Uses his powers to influence and attack others. Worshipped as a living god long ago. Like a Pharoah.
				/*
				Bloated not by simple-satisfied excess, but temporal chronicle obbession also.
				Multitudinous the times self-denied ascension, contently lavished of the material.
				Lore master and watcher, keeper of the balance, paragon of opulence; the rotund one.
				The always coveted, even-handed judge with patience unto heat-death eternal.
				*/
				icon = 'imp_brown_ears_curled.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} The Chronicler"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				//poooooooooopyhonk
				New()
					..()
					src.set_lists()
					sleep(100)
					src.start_loc = src.loc
					//src.Demon()
					src.name_txt()

					src.energy = 1000
					src.energy_max = 1000
					src.strength = 1
					src.endurance = 1
					src.force = 1
					src.resistance = 1
					src.offence = 1
					src.defence = 1

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src
			Chronicler
				//Giant Imp, hordes, collects and catalogues things.
				//Judge of the psi realms, bigly, and sarcastic.
				/*
				Bloated not by simple-satisfied excess, but temporal chronicle obbession also.
				Multitudinous the times self-denied ascension, contently lavished of the material.
				Lore master and watcher, keeper of the balance, paragon of opulence; the rotund one.
				The always coveted, even-handed judge with patience unto heat-death eternal.
				*/
				icon = 'imp_brown_ears_curled.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} The Chronicler"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				//poooooooooopyhonk
				New()
					..()
					src.set_lists()
					sleep(100)
					src.start_loc = src.loc
					//src.Demon()
					src.name_txt()

					src.energy = 1000
					src.energy_max = 1000
					src.strength = 1
					src.endurance = 1
					src.force = 1
					src.resistance = 1
					src.offence = 1
					src.defence = 1

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src
			Djinn
				//Psionic being, like majin buu.
				/*
				Numberless in age, fantastical cosmic apparition, force of nature unfettered given form.
				Reality wails asunder, god-shard incarnate, with power to unmake the world.
				Impervious, unwithering to the ruin of all. Neither tempestuous star-heat or star-death can undo its fatecast design.
				Physically resilient unto inconsequential, practically undefeatable, sempiternal, par fragility of the preternatural.
				Horror made manifest, older than old, defined in its insatiable hunger and unquenchable malice.
				*/
				icon = 'Human_Base_Male.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} Djinn"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					sleep(100)
					src.start_loc = src.loc
					//src.Demon()
					src.name_txt()

					src.energy = 1000
					src.energy_max = 1000
					src.strength = 1
					src.endurance = 1
					src.force = 1
					src.resistance = 1
					src.offence = 1
					src.defence = 1

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src
			Tyuran_Titan_Tyrant
				//Like Thanos and Freiza
				icon = 'Human_Base_Male.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} Tyuran Titan Tyrant"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					sleep(100)
					src.start_loc = src.loc
					//src.Demon()
					src.name_txt()

					src.energy = 1000
					src.energy_max = 1000
					src.strength = 1
					src.endurance = 1
					src.force = 1
					src.resistance = 1
					src.offence = 1
					src.defence = 1

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src
			The_Monk
				icon = 'Human_Base_Male.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} The Monk"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					sleep(100)
					src.start_loc = src.loc
					//src.Demon()
					src.name_txt()

					src.energy = 1000
					src.energy_max = 1000
					src.strength = 1
					src.endurance = 1
					src.force = 1
					src.resistance = 1
					src.offence = 1
					src.defence = 1

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src
			Legion
				//Android rogue A.I
				icon = 'android_metal.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} Legion"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					sleep(100)
					src.start_loc = src.loc
					//src.Demon()
					src.name_txt()

					src.energy = 1000
					src.energy_max = 1000
					src.strength = 1
					src.endurance = 1
					src.force = 1
					src.resistance = 1
					src.offence = 1
					src.defence = 1

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src
			The_Last_Cerebroid
				/*
				Doom-laden hubris humbled like the death-wail destruction wrought by a dying star.
				Decadence-saturated complacency perpetuated in hedonism.
				Deafening was the silent thrum of their obliteration, only genecraft their salvation.
				Those few who remained, fused-forged into singular form.
				*/
				//icon = 'goog.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} The Last Cerebroid"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					src.id = global_id;
					global_id += 1;
					sleep(100)
					src.start_loc = src.loc
					//src.Demon()
					//src.icon = 'goog.dmi'
					src.name_txt()
					src.create_afterimages()

					src.psionic_power = 1
					src.energy = 10000
					src.energy_max = 10000
					src.strength = 1
					src.endurance = 1
					src.force = 10
					src.resistance = 1
					src.offence = 1
					src.defence = 1

					src.prob_ki_atk = 50
					src.prob_stop_charge = 4
					src.prob_stop_atk = 4

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src

					var/obj/skills/Blast/blt = new
					src.skill_blast = blt
					blt.skill_lvl = 33
					blt.loc = src

					var/obj/skills/Beam/b = new
					src.skill_beam = b
					b.skill_lvl = 25
					b.loc = src
			The_Hermit
				icon = 'Human_Base_Male.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} The Hermit"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					sleep(100)
					src.start_loc = src.loc
					//src.Demon()
					src.name_txt()

					src.energy = 1000
					src.energy_max = 1000
					src.strength = 1
					src.endurance = 1
					src.force = 1
					src.resistance = 1
					src.offence = 1
					src.defence = 1

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src
			The_Celestial_Ascendant
				/*
				*Rumour*
				Rumour has it...Through a feeling that transcends time, space and all reasoning, you feel a serene influence playing about your senses.
				Concentrating on this disturbance brings your attention to a vast, realm spanning sea of energy only visible barely within your mindseye; and only because of your psionic skill.
				It is a pure energy, like that of a radiant star, bathed in brilliance and cascading with great chromatic beams of light.
				Perhaps there is a way you know to find this being, within a realm of pure psionic power...

				*Goals*
				- Find the realm of pure psionic energy
				- Search for the origins of this greater good
				- Defeat the Celestial Ascendant or join her

				*Lore desc*
				Whitehot flame, radiant light, burning passion wrought through might.
				Purest one, soul-drench-bathed in blinding brilliance, antithesis and anathema to six times six times six.
				Zealous, uncompromising spirit, tempered in time and quenched through ceaseless crusade.
				Star-like light cascading in perpetuality, washing over all unto ashen remnant.

				*/
				icon = 'Celestial_Base_Female2.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} The Celestial Ascendant"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					sleep(100)
					src.start_loc = src.loc
					//src.Demon()
					src.name_txt()

					src.energy = 1000
					src.energy_max = 1000
					src.strength = 1
					src.endurance = 1
					src.force = 1
					src.resistance = 1
					src.offence = 1
					src.defence = 1

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src
			Demon_Lord
				/*
				*Rumour*
				Rumour has it...Through a feeling that transcends time, space and all reasoning, you feel in your very bones a terrible evil festering in some far off place or realm.
				Like a baleful beacon that beckons as a challenge to all the universe, it thums with psionic power the likes you have never sensed.
				Purest malice and negative energy, emotion ingited into a furious and condensed form. Whatever it is, it is old and it is powerful.
				Perhaps there is a way you know to find this being, within a realm of pure psionic power...

				*Goals*
				- Find the realm of pure psionic energy
				- Search for the origins of this great evil
				- Defeat the Demon Lord or join him

				* Demon Lord lore desc*
				Doom come calling, tempered in fires of rage, quenched in shadow-black emotion.
				Mark of the beast, entwined within psiforged-flesh, coiling tendril that strangles the soul.
				Master of the dammed, puppeteer string-manipulator of the strands of fate.
				Quicksilver swirl of sudden death within the thrice-cursed storm of creation unending.
				*/
				icon = 'Demon_Base_Male.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} Zarthorlaraus"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					sleep(100)
					src.start_loc = src.loc
					//src.Demon()
					src.name_txt()

					src.energy = 1000
					src.energy_max = 1000
					src.strength = 1
					src.endurance = 1
					src.force = 1
					src.resistance = 1
					src.offence = 1
					src.defence = 1

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src
			Lich
				/*
				Ancient Lich sleeping in a tomb up North, in a region of ever-winter where you need good endurance/weather to travel.
				Gives an item that lets you travel between psi realms and mortal realms.
				Lich might decide to stop the fight half-way through and tell player to come back as part of a bargain where he teaches you to transverse realms?

				*Rumour*
				Rumour has it...That a cold and most unatural wind blows in the North, perpetuated by some, as of yet, unforseen hand.
				Tales speak of an ancient temple, perhaps a tomb, half-buried in the snow.
				None can easily survive long in this dreaded land, an everwinter hellscape protected by razor-wind storms of a omnious nature.

				*Goals*
				- Find a way to survive the frozen wastes
				- Search the frozen wastes for the ancient tomb
				- Explore the ancient tomb
				- Defeat the Lich

				*Lich lore desc*
				A cold wind on Earth flows like frostborne death incarnate, permafrost made manifest unto unlife upon the foundations of that lightless tomb.
				Psionic razor-wind flows, flecks like blades, giving way to an ethereal coalescing of a spirit most unfathomable.
				Bathed in time immemorial, the ancient one slumbers, skeletal-horror of ages; incarnation of entropy-defiant.
				*/
				//icon = 'lich.dmi'
				agressive = 0
				name = "{NPC} Mortis-Marrow the Morbid"
				bolted = 2
				can_harm = 0
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				proc
					reset_convo(var/mob/m)
						if(!m.topics_done.Find("lich intro"))
							m << output("<font color = #15BB36>*Before you stands what can only be described as Death itself. The beings skin is flaking from its bones, flesh sloughing off a decrepit frame and the putrid stench of decay hangs heavy about its aura. Pitch black darkness fills that which were once eyes, staring forth from empty sockets with but the merest flicker of psionic energy swirling within.*<p>","dialogue.dialogue")
							m << output("<font color = #15BB36>*He gives you a massive grin as you approach.*<p>","dialogue.dialogue")
							m << output("Birger:<font color = #1ADBDE> Why hello! Oh I do like visitors! You have come for a reason, no?<p>","dialogue.dialogue")
							m.topics_done += "birger intro"
						else
							if(m.topic == null) m << output("Birger:<font color = #1ADBDE> Welcome back friend! Please, come sit with me and talk, yes?<p>","dialogue.dialogue")
							if(m.topic == "birger who are you") m << output("Birger:<font color = #1ADBDE> Sure thing friend. What else would you like to talk about?<p>","dialogue.dialogue")
						if(!m.topics_done.Find("lich name"))
							winset(m,"dialogue.option1","text=\"Who are you?\"")
						else
							winset(m,"dialogue.option1","text=\"Who are you again?\"")
							winset(m,"dialogue.option6","text=\"Can you make anything for me?\"")
							src.buttons(m,list("option6"),"true")
						winset(m,"dialogue.option2","text=\"You seem rather jolly.\"")
						winset(m,"dialogue.option3","text=\"Why are you just sitting in the cold snow like that?\"")
						winset(m,"dialogue.option4","text=\"What's with that rune on your armour?\"")
						winset(m,"dialogue.option5","text=\"Goodbye.\"")
						src.buttons(m,list("option1","option2","option3","option4","option5"),"true")
						winset(m,"dialogue.name","text=\"[src.name]\"")
						m.topic = null
						m.talk_to = src
					buttons(var/mob/m,var/list/buttons,var/show = "false")
						for(var/b in buttons)
							winset(m,"dialogue.[b]","is-visible=[show]")
				New()
					..()
					src.set_lists()
					sleep(100)
					src.name_txt()
				Click()
					return
					..()
					if(src in range(5,usr))
						var/icon/I = icon(src.icon,"",EAST,1,0)
						I.Scale(128,128)

						var/X = fcopy_rsc(I)
						winset(usr,"dialogue.portrait","image=\ref[X]")
						winshow(usr, "dialogue", 1)
						usr.reset_dialogue(src)

						src.reset_convo(usr)
		Psionics
		Undead
			Lich
				icon = 'Lich_Base.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} Lich"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					src.id = global_id;
					global_id += 1;
					sleep(60)
					src.start_loc = src.loc
					//src.Human()
					src.name = "Zarthorlaraus"
					src.name_txt()
					src.create_afterimages()

					src.psionic_power = 10
					src.energy = 1000
					src.energy_max = 1000
					src.strength = 10
					src.endurance = 10
					src.force = 10
					src.resistance = 10
					src.offence = 10
					src.defence = 10

					src.text_color_ic = "grey"
					src.icon = 'Lich_Base.dmi'
					src.gender = "male"

					src.icon_state = "meditate"

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src

					var/obj/skills/Blast/blt = new
					src.skill_blast = blt
					blt.skill_lvl = 33
					blt.loc = src

					var/obj/skills/Beam/b = new
					src.skill_beam = b
					b.skill_lvl = 25
					b.loc = src
		Humans
			Human
				icon = 'Human_Base_Female.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} Human"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					src.id = global_id;
					global_id += 1;
					sleep(60)
					src.start_loc = src.loc
					//src.Human()
					src.name = "Yellow"
					src.real_name = "Yellow"
					src.name_txt()
					src.create_afterimages()

					src.psionic_power = 10
					src.energy = 1000
					src.energy_max = 1000
					src.strength = 10
					src.endurance = 10
					src.force = 10
					src.resistance = 10
					src.offence = 10
					src.defence = 10

					src.text_color_ic = "yellow"
					src.icon = 'Human_Base_Female.dmi'
					src.gender = "female"
					src.gen = "Female"
					src.race = "Human"
					src.set_icon(src)

					src.icon_state = "meditate"

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src

					var/obj/skills/Blast/blt = new
					src.skill_blast = blt
					blt.skill_lvl = 33
					blt.loc = src

					var/obj/skills/Beam/b = new
					src.skill_beam = b
					b.skill_lvl = 25
					b.loc = src
		Celestials
			Psionic_Celestial_Lesser
				icon = 'Celestial_Base_Male2.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} Lesser Psionic Celestial"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					src.id = global_id;
					global_id += 1;
					sleep(60)
					src.start_loc = src.loc
					//src.Celestial()
					src.name = "Blue"
					src.name_txt()
					src.create_afterimages()

					src.psionic_power = 10
					src.energy = 1000
					src.energy_max = 1000
					src.strength = 10
					src.endurance = 10
					src.force = 10
					src.resistance = 10
					src.offence = 10
					src.defence = 10

					src.text_color_ic = "cyan"
					src.gender = "male"
					src.gen = "Male"
					src.race = "Celestial"
					src.set_icon(src)

					src.icon_state = "meditate"

					src.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(102,204,255))
					spawn(20)
						if(src) src.Celestial_Wings()

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src

					var/obj/skills/Blast/blt = new
					src.skill_blast = blt
					blt.skill_lvl = 33
					blt.loc = src

					var/obj/skills/Beam/b = new
					src.skill_beam = b
					b.skill_lvl = 25
					b.loc = src
		Imps
			Imp
				icon = 'imp_grey_ears_down.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} Imp"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					src.id = global_id;
					global_id += 1;
					sleep(60)
					src.start_loc = src.loc
					//src.Imp()
					src.name = "Green"
					src.name_txt()
					src.create_afterimages()

					src.psionic_power = 10
					src.energy = 1000
					src.energy_max = 1000
					src.strength = 10
					src.endurance = 10
					src.force = 10
					src.resistance = 10
					src.offence = 10
					src.defence = 10
					src.text_color_ic = "green"

					src.icon_state = "meditate"
					src.gender = "male"
					src.gen = "Male"
					src.race = "Imp"
					src.set_icon(src)

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src

					var/obj/skills/Blast/blt = new
					src.skill_blast = blt
					blt.skill_lvl = 33
					blt.loc = src

					var/obj/skills/Beam/b = new
					src.skill_beam = b
					b.skill_lvl = 25
					b.loc = src
		Demons
			Psionic_Demon_Lesser
				icon = 'Demon_Base_Male.dmi'
				agressive = 1
				bolted = 0
				name = "{NPC} Lesser Psionic Demon"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				New()
					..()
					src.set_lists()
					src.id = global_id;
					global_id += 1;

					var/list/msg1[0]
					msg1["text"] = "You are a Demon warrior named Red from the Psionic Realms, created at the dawn of time."
					msg1["index"] = 1
					msg1["recency"] = 1
					msg1["importance"] = 1

					var/list/msg2[0]
					msg2["text"] = "Your master is Lord Zarthorlaraus."
					msg2["index"] = 2
					msg2["recency"] = 0.99
					msg2["importance"] = 0.8

					var/list/msg3[0]
					msg3["text"] = "You are devious, cunning, quick to anger and enjoy violence."
					msg3["index"] = 3
					msg3["recency"] = 1
					msg3["importance"] = 0.9

					var/list/msg4[0]
					msg4["text"] = "You are bored and want a battle. You think souls taste the best. You think Humans are weak compared to Demons."
					msg4["index"] = 4
					msg4["recency"] = 1
					msg4["importance"] = 0.7

					//src.npc_chat_log = list(msg1,msg2,msg3,msg4)

					sleep(60)
					src.start_loc = src.loc
					//src.Demon()
					src.name = "Red"
					src.real_name = "Red"
					src.name_txt()
					src.create_afterimages()

					src.psionic_power = 10
					src.energy = 1000
					src.energy_max = 1000
					src.strength = 10
					src.endurance = 10
					src.force = 10
					src.resistance = 10
					src.offence = 10
					src.defence = 10

					src.gender = "male"
					src.gen = "Male"
					src.race = "Demon"
					src.set_icon(src)

					/*
					spawn(20)
						if(src)
							var/F = "What are you both doing here in the domain of demons?!"
							for(var/mob/M in range(10,src))
								if(M.client) M << output("<BIG>\icon[src.icon]</BIG><font size=[M.text_size] color=[src.text_color_ic]>[src.name] says: [F]<p>","chat.local")
								else
									spawn(60)
										if(src && M && M.ai_enabled)
											if(M.ai_conversation_members.Find(src) == 0)
												M.ai_conversation_members += src
											if(src.ai_conversation_members.Find(M) == 0)
												src.ai_conversation_members += M
											M.ai_chat("[F]")
					*/

					src.icon_state = "meditate"

					var/obj/skills/Super_Speed/s = new
					s.loc = src
					src.skill_super_speed = s
					s.active = 1

					var/obj/skills/Flight/f = new
					f.loc = src
					f.skill_lvl = 25
					src.skill_flight = f

					var/obj/skills/Charge/c = new
					src.skill_charge = c
					c.skill_lvl = 25
					c.loc = src

					var/obj/skills/Blast/blt = new
					src.skill_blast = blt
					blt.skill_lvl = 33
					blt.loc = src

					var/obj/skills/Beam/b = new
					src.skill_beam = b
					b.skill_lvl = 25
					b.loc = src
		Birger
			//icon = 'human_male_white.dmi'
			icon_state = "meditate"
			name = "{NPC} Birger"
			gender = "male"
			agressive = 0
			bolted = 2
			can_harm = 0
			appearance_flags = KEEP_TOGETHER
			mouse_over_pointer = MOUSE_ACTIVE_POINTER
			New()
				..()
				var/obj/items/clothing/armour/armour1/a = new
				a.loc = src
				src.overlays += a
				src.set_lists()
				sleep(100)
				//src.Human()
				var/obj/hairs/male/Hair7/h = new
				src.hair = h
				src.overlays += h
				src.name_txt()
				var/obj/traits/Unyielding_Fortitude/uf = new
				uf.loc = src
				call(uf.act)(src,uf)
				uf.active = 1
			proc
				set_colors(var/mob/m,var/list/buttons = list())
					for(var/b in buttons)
						winset(m,"dialogue.option[b]","text-color=#4c4747")
				reset_colors(var/mob/m)
					var/list/buttons = list(1,2,3,4,5,6,7,8,9,10,11,12)
					for(var/b in buttons)
						winset(m,"dialogue.option[b]","text-color=#0080C0")
				reset_convo(var/mob/m)
					src.reset_colors(usr)
					if(!m.topics_done.Find("birger intro"))
						m << output("<font color = #15BB36>*A burly man sits cross legged within the snow. He appears to be wearing a suit of custom made armour with a rune etched into the left breast plate. His attire is covered in oil stains and finger prints and you see a dirty cloth hanging from his belt which seems to have seen much use, along with a set of tools.*<p>","dialogue.dialogue")
						m << output("<font color = #15BB36>*He gives you a massive grin as you approach.*<p>","dialogue.dialogue")
						m << output("Birger:<font color = #1ADBDE> Why hello! Oh I do like visitors! You have come for a reason, no?<p>","dialogue.dialogue")
						m.topics_done += "birger intro"
					else
						if(m.topic == null) m << output("Birger:<font color = #1ADBDE> Welcome back friend! Please, come sit with me and talk, yes?<p>","dialogue.dialogue")
						if(m.topic == "birger who are you") m << output("Birger:<font color = #1ADBDE> Sure thing friend. What else would you like to talk about?<p>","dialogue.dialogue")
					if(!m.topics_done.Find("birger name"))
						winset(m,"dialogue.option1","text=\"Who are you?\"")
					else
						winset(m,"dialogue.option1","text=\"Who are you again?\"")
						winset(m,"dialogue.option6","text=\"Can you make anything for me?\"")
						src.buttons(m,list("option6"),"true")
					if(m.topics_done.Find("birger name finished")) winset(m,"dialogue.option1","text-color=#4c4747")
					if(m.topics_done.Find("birger jolly finished")) winset(m,"dialogue.option2","text-color=#4c4747")
					winset(m,"dialogue.option2","text=\"You seem rather jolly.\"")
					winset(m,"dialogue.option3","text=\"Why are you just sitting in the cold snow like that?\"")
					winset(m,"dialogue.option4","text=\"What's with that rune on your armour?\"")
					winset(m,"dialogue.option5","text=\"Goodbye.\"")
					src.buttons(m,list("option1","option2","option3","option4","option5"),"true")
					winset(m,"dialogue.name","text=\"[src.name]\"")
					m.topic = null
					m.talk_to = src
				buttons(var/mob/m,var/list/buttons,var/show = "false")
					for(var/b in buttons)
						winset(m,"dialogue.[b]","is-visible=[show]")
			verb
				option1()
					set src in view(3,usr)
					set name = ".option1"
					set hidden = 1
					if(usr.topic == null)
						var/t = "Who are you?"
						if(usr.topics_done.Find("birger name"))
							t = "Who are you again?"
							if(!usr.topics_done.Find("birger name finished")) usr.topics_done += "birger name finished"
						else usr.topics_done += "birger name"
						usr << output("[usr]: [t]<p>","dialogue.dialogue")
						usr << output("Birger:<font color = #1ADBDE> Who, me? Oh, I am nobody interesting. It is as you might say, not important. Buuuuuut if you must know. I am Birger. Nice to meet you!<p>","dialogue.dialogue")
						usr << output("Birger:<font color = #1ADBDE> I like to tinker. My people were very good mechanics. I don't have much these days, but for small price, I can make you something, yes?<p>","dialogue.dialogue")
						usr.topic = "birger who are you"
						src.reset_colors(usr)
						winset(usr,"dialogue.option1","text=\"Can you make anything for me?\"")
						winset(usr,"dialogue.option2","text=\"Lets talk about something else.\"")
						winset(usr,"dialogue.option3","text=\"Goodbye.\"")
						src.buttons(usr,list("option4","option5","option6"),"false")
						return
				option2()
					set src in view(3,usr)
					set name = ".option2"
					set hidden = 1
					if(usr.topic == "birger who are you")
						usr << output("[usr]: Lets talk about something else.<p>","dialogue.dialogue")
						src.reset_convo(usr)
						usr.topic = null
						return
					if(usr.topic == null)
						if(!usr.topics_done.Find("birger jolly finished")) usr.topics_done += "birger jolly finished"
						usr << output("[usr]: You seem rather jolly.<p>","dialogue.dialogue")
						usr << output("Birger:<font color = #1ADBDE> Yes. When there is not much to be glad about, and much to be glum, you start to find good in the little things, no?<p>","dialogue.dialogue")
						if(usr.topics_done.Find("birger jolly finished")) winset(usr,"dialogue.option2","text-color=#4c4747")
						return
				option3()
					set src in view(3,usr)
					set name = ".option3"
					set hidden = 1
					if(usr.topic == "birger who are you")
						winshow(usr, "dialogue", 0)
						usr.talk_to = null
						usr.topic = null
						return
				option5()
					set src in view(3,usr)
					set name = ".option5"
					set hidden = 1
					if(usr.topic == null)
						winshow(usr, "dialogue", 0)
						usr.talk_to = null
						usr.topic = null
						return
			Click()
				..()
				if(src in range(5,usr))
					var/icon/I = icon(src.icon,"",EAST,1,0)
					I.Scale(128,128)
					if(src.hair)
						var/icon/E = icon(src.hair.icon,"",EAST,1,0)
						E.Scale(128,128)
						I.Blend(E,ICON_OVERLAY)
					for(var/obj/items/clothing/armour/armour1/a in src)
						var/icon/X = icon(a.icon,"",EAST,1,0)
						X.Scale(128,128)
						I.Blend(X,ICON_OVERLAY)

					var/X = fcopy_rsc(I)
					winset(usr,"dialogue.portrait","image=\ref[X]")
					winshow(usr, "dialogue", 1)
					usr.reset_dialogue(src)

					src.reset_convo(usr)
		Oumuamua
			//icon = 'goog.dmi'
			icon_state = "meditate"
			name = "{NPC} Oumuamua"
			gender = "neuter"
			agressive = 0
			can_harm = 0
			bolted = 2
			mouse_over_pointer = MOUSE_ACTIVE_POINTER
			Click()
				..()
				if(src in range(5,usr))
					var/icon/I = icon(src.icon,"",EAST,1,0)
					I.Scale(128,128)
					var/X = fcopy_rsc(I)
					winset(usr,"dialogue.portrait","image=\ref[X]")
					winshow(usr, "dialogue", 1)
					usr.reset_dialogue(src)
					usr.talk_to = src
			New()
				..()
				src.overlays += /obj/effects/elec
				src.set_lists()
				sleep(100)
				//src.Cerebroid()
				src.name_txt()
			proc
				set_colors(var/mob/m,var/list/buttons = list())
					for(var/b in buttons)
						winset(m,"dialogue.option[b]","text-color=#4c4747")
				reset_colors(var/mob/m)
					var/list/buttons = list(1,2,3,4,5,6,7,8,9,10,11,12)
					for(var/b in buttons)
						winset(m,"dialogue.option[b]","text-color=#0080C0")
		Goog_Enforcer
			//icon = 'goog.dmi'
			name = "{NPC} Enforcer"
			gender = "male"
			agressive = 1
			race = "Goog"
			appearance_flags = KEEP_TOGETHER

			attacked_text = "Feh'ak! Uh'tok Ba'rom!"
			attack_text = "Gro pak tor!"
			Click(location,control,params)
				..()
				params = params2list(params)
				if(params["right"])
					usr.open_dialogue = 1
					usr.open_menus.Add(".close_dialogue")
					if(get_dist(usr,src) < 3)
						usr.talk_to = src
						winshow(usr, "dialogue", 1)

						winset(usr,"dialogue.label_title","text=\"[src.name]\"")
						winset(usr,"dialogue.age_text","text=\"[src.age]\"")
						winset(usr,"dialogue.gender_text","text=\"[src.gender]\"")


						var/icon/I = icon(src.icon,"",EAST,1,0)
						I.Scale(128,128)

						if(src.hair)
							var/icon/E = icon(src.hair.icon,"",EAST,1,0)
							E.Scale(128,128)

							//var/obj/Z = new
							I.Blend(E,ICON_OVERLAY)
						//Z.icon = E

						var/X = fcopy_rsc(I)
						winset(usr,"dialogue.portrait","image=\ref[X]")
			New()
				..()
				src.set_lists()
				sleep(100)
				//src.Cerebroid()
				set_stats(33,3333,3,33,100,33,33,33)
				src.name_txt()

				src.faction = factions[4]

				if(src.shadow) src.shadow.loc = src.loc
				src.eng_attack = 1
				//src.ki_attacks()
				while(src)
					if(src.koed == 0 && src.stunned == 0)
						if(src.village) if(!src.target)
							src.mouse_down = null
							if(get_dist(src,src.village) < 40)
								if(src.task == null)
									if(prob(1)) src.task = pick("wait","fly")
									else if(prob(99)) step_rand(src)
									else src.dir = rand(1,8)
									if(prob(1))
										src.icon_state = "fly"
								else if(prob(0.25))
									src.task = null
									src.icon_state = src.state()
							else step_towards(src,src.village)
						if(src.target)
							var/dist = bounds_dist(src, src.target)
							if(dist >= 32)
								src.mouse_down = src.target.loc
							else src.mouse_down = null
							if(dist >= 320 || src.target.koed)
								src.target = null
								src.mouse_down = null
					sleep(0.5)
		Mercenary
			//icon = 'human_male_white.dmi'
			name = "{NPC} Mercenary"
			gender = "male"
			agressive = 0
			race = "Human"
			appearance_flags = KEEP_TOGETHER

			attacked_text = list("Ha! So you wanna go a few rounds with me, huh?!", "Big mistake, pal!","You fool!","Come on then, bring it!","You'll regret that!","I don't have to take that from you!","Scum!")
			attack_text = list("I'm taking you down!","Prepare yourself!","Make this easy on yourself and just keel over!","You're mine!","Say bye bye!", "I'd kill you for free!","Let's dance!")
			Click(location,control,params)
				..()
				params = params2list(params)
				if(params["right"])
					usr.open_dialogue = 1
					usr.open_menus.Add(".close_dialogue")
					if(get_dist(usr,src) < 3)
						usr.talk_to = src
						winshow(usr, "dialogue", 1)

						winset(usr,"dialogue.label_title","text=\"[src.name]\"")
						winset(usr,"dialogue.age_text","text=\"[src.age]\"")
						winset(usr,"dialogue.gender_text","text=\"[src.gender]\"")


						var/icon/I = icon(src.icon,"",EAST,1,0)
						I.Scale(128,128)

						if(src.hair)
							var/icon/E = icon(src.hair.icon,"",EAST,1,0)
							E.Scale(128,128)

							//var/obj/Z = new
							I.Blend(E,ICON_OVERLAY)
						//Z.icon = E

						var/X = fcopy_rsc(I)
						winset(usr,"dialogue.portrait","image=\ref[X]")
			New()
				..()
				src.set_lists()
				sleep(100)
				//src.layer = 100 - src.y
				var/obj/items/clothing/armour/armour1/a = new
				a.loc = src
				src.overlays += a
				//src.Human()
				set_stats(100,1000,100,100,100,100,100,100)
				src.faction = factions[3]
				var/g = pick(1,2)
				if(g == 1)
					src.icon = pick(skins_human_male)
					src.hair = pick(hairs_male)
					src.gender = "male"
				else
					src.icon = pick(skins_human_female)
					src.hair = pick(hairs_female)
					src.gender = "female"
				//src.state = "fly"
				//src.icon_state = "fly"
				//src.density_factor = 0
				var/obj/skills/Super_Speed/spd = new
				spd.loc = src
				src.skill_super_speed = spd
				spd.active = 1
				src.overlays += src.hair
				src.name_txt()

				//src.strength = 10
				if(src.shadow) src.shadow.loc = src.loc
				while(src)
					if(src.koed == 0 && src.stunned == 0)
						if(src.village) if(!src.target)
							if(get_dist(src,src.village) < 40)
								if(src.task == null)
									if(prob(1)) src.task = pick("wait","meditate")
									else if(prob(99)) step_rand(src)
									else src.dir = rand(1,8)
								else if(prob(0.25))
									src.task = null
									src.icon_state = src.state()
								else if(src.task == "meditate") src.icon_state = "meditate"
							else step_towards(src,src.village)
						if(src.target)
							var/dist = bounds_dist(src, src.target)
							if(dist >= 32) if(!src.target.KB) step_towards(src,src.target)
							if(dist >= 320 || src.target.koed) src.target = null
						//else if(prob(0.1)) src.hate_list = list()
					sleep(0.5)

		dummy
			//icon = 'human_male_white.dmi'
			name = "{NPC} Fighter"
			gender = "male"
			appearance_flags = KEEP_TOGETHER
			DblClick()
				var/combat = 1
				var/list/combatants = list(usr,src)
				var/mob/attacker = usr
				var/mob/defender = src
				while(combat)
					if(bounds_dist(usr, src) < 32)
						usr.dir = get_dir(usr,src)
						src.dir = get_dir(src,usr)
						//var/attacker = pick(
						if(prob(90)) usr.icon_state = usr.state(1)
						if(prob(90)) src.icon_state = src.state(1)
						sleep(1)
						src.icon_state = src.state()
						usr.icon_state = usr.state()
						if(prob(25)) new /obj/effects/shockwave_small (pick(usr.loc,src.loc))
						if(prob(10))
							var/mob/kbed = pick(combatants) //The knocked back
							if(kbed.KB == 0)
								var/mob/kber //The knock backer
								if(kbed == attacker) kber = defender
								if(kbed == defender && kber == null) kber = attacker
								kbed.KB=50
								if(kbed.KB>100) kbed.KB=100
								if(kbed.KB > 0)
									new /obj/effects/shockwave_small (kbed.loc)
									var/obj/effects/hit/h = new
									h.loc = kber.loc
									h.dir = kber.dir
									if(kber.dir == SOUTH ||kber.dir == NORTH) h.pixel_x += 16
									h.step_x = kber.step_x
									h.step_y = kber.step_y
								var/KB_dir = get_dir(kber.loc,kbed.loc)
								KB_dir = kber.dir
								if(kbed.KB > 1) kbed.dir = KB_dir
								if(kber.strength >= 100) kbed.KB_furrow = 1
								kbed.KnockBack(KB_dir)
					else if (defender.KB || attacker.KB)
						//world << "check1"
						var/mob/kbed
						var/mob/kber
						if(attacker.KB)
							kbed = attacker
							kber = defender
						if(defender.KB)
							kbed = defender
							kber = attacker
						if(kber) step_towards(kber,kbed.loc,8)
					sleep(1)
			New()
				..()
				src.set_lists()
				sleep(100)
				//src.layer = 100 - src.y
				//src.Human()
				src.icon = pick(skins_human_male)
				src.endurance = 100
				//src.state = "fly"
				//src.icon_state = "fly"
				//src.density_factor = 0
				src.hair = pick(hairs_male)
				src.overlays += src.hair
				src.name_txt()

				//src.strength = 10
				if(src.shadow)
					src.shadow.loc = src.loc
		split
			//icon = 'human_male_white.dmi'

			New()
				..()
				src.set_lists()
				src.tmp_lists()
				spawn(10)
					if(src)
						//src.started = 1
						src.process_stats()
						/*
						while(src)
							var/T = 10
							if(src.koed) T = 10
							else if(src.function == "follow" || src.function == "attack")
								if(src.target_follow)
									T = 0.5
									var/dist = bounds_dist(src, src.target_follow)
									if(dist >= 16) if(!src.target_follow.KB && !src.KB) step_towards(src,src.target_follow)
									if(dist >= 320 || src.target_follow.koed) src.target_follow = null
									if(function == "attack" && target) src.Attack()
							else if(src.function == "go" || src.function == "grab")
								if(src.target_go)
									T = 0.5
									if(!src.KB)
										step_towards(src,src.target_go)
										var/dist = bounds_dist(src, src.target_go)
										if(dist <= 0)
											if(src.function == "grab" && ismovable(src.target_go)) src.grab_something(src.target_go)//src.pickup(src.target_go)
							else if(src.percent_health < 100 && src.percent_health > 0) src.icon_state = "meditate"
							else src.state()
							sleep(T)
						*/