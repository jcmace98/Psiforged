#define get_opposite(x) __opposite_dirs[(x)]

var
	list/__opposite_dirs = list(2,1,null,8,null,null,null,4)    //used internally to assist with movement input keys


client
	var/tmp
		move_dir = 0
		input_dir = 0
		change = 0
		shift = 0;
		tmp/move_analog_x
		tmp/move_analog_y
	verb
		move_analog_input(X as num, Y as num)
			set hidden = TRUE,instant = TRUE
			move_analog_x = X
			move_analog_y = Y
		MoveKey(key as num,state as num)
			set hidden = 1
			set instant = 1
			if(usr.typing) return
			//usr.layer = 101 - usr.y
			. = input_dir==0
			//update the INPUT_DPAD status
			var/opposite = get_opposite(key)
			if(state)
				//if this is a keypress, turn on the key bit
				//if(usr.skill_flight && usr.skill_flight.active)
					//usr.client.screen -= usr.hud_liquid
				input_dir |= key
				move_dir |= key
				//turn off the opposite key bit
				if(opposite & input_dir)
					move_dir &= ~opposite
			else

				//if this is a keyrelease, turn off the key bit
				//usr.client.screen -= usr.hud_liquid
				//usr.client.screen += usr.hud_liquid
				input_dir &= ~key
				move_dir &= ~key
				//turn on the opposite key bit if it's being held
				if(opposite & input_dir)
					move_dir |= opposite
			if(usr.started) usr.MoveLoop()
			//usr.client.check_minigame()
mob
	proc
		MoveLoop()
			//var/spd = 1
			//var/controller = 0
			if(src.client)
				/*
				var/proceed = 0
				if(src.tk)
					if(istype(src.tk,/atom/movable)) proceed = 1
				if(proceed)
					var/atom/movable/a = src.tk
					if(ismob(a))
						var/mob/m = a
						if(m.afk) src.tk = null
					if(a.bolted > 2) src.tk = null
					if(src.tk && src.mouse_down)
						for(var/obj/skills/Telekinesis/t in src)
							var/steps = 0
							steps = a.step_size*1.5
							step_towards(src.tk,src.mouse_down,steps)
							a.set_shadow()
							//M.energy -= 0.01+((M.energy_max*0.25)/t.skill_lvl/M.mod_energy)
							var/removes = (0.5/src.mod_recovery) + (0.5/t.skill_lvl)
							src.energy -= removes
							//world << "[removes] removed by [t]"
							src.gain_stat("force",1,1,"Telekinesis")
							src.gain_stat("power",1,1,"Telekinesis")
							t.skill_exp += (10/t.skill_lvl)*src.mod_skill
							if(t.skill_exp >= 100)
								t.skill_exp = 1
								t.skill_lvl += 1
								t.skill_up(src)
					else src.drop_tk()
				*/
				//controller = 0
				if(src.eating) src.cancel_eat()
				if(src.projection)
					step(src.projection,src.client.move_dir,src.step_size)
					src.layer = MOB_LAYER + src.laymod - (src.y + src.step_y / 32) / world.maxy
				else if(src.koed == 0 && src.stunned == 0 && src.meditating == 0 && src.KB <= 0)
					/*
					if(src.client.move_analog_x && src.client.move_analog_y)
						controller = 1
						spd = src.step_size*2
						Translate(src.client.move_analog_x * spd,src.client.move_analog_y * spd)
						src.dir = Directions.FromOffset(src.client.move_analog_x, src.client.move_analog_y)
					*/
					if(src.client.move_dir) //if(controller == 0) if(src.client.move_dir) //if(!src.KB)
						src.face_angle = NumToAngle(src.dir)
						//Super quicksilver speed origin
						if(src.skill_quicksilver && src.skill_quicksilver.active)
							if(src.skill_quicksilver.speed_ramp < 8) src.skill_quicksilver.speed_ramp += 0.1
							var/removes = (0.5/src.mod_recovery) + (0.5/src.skill_quicksilver.skill_lvl)
							src.energy -= removes
							src.skill_quicksilver.skill_exp += (1/src.skill_quicksilver.skill_lvl)*src.mod_skill
							var/sr = round(src.skill_quicksilver.speed_ramp)
							while(sr)
								if(round(src.skill_quicksilver.speed_ramp) >= 3)
									for(var/obj/effects/after_image/af in src.afterimages)
										if(af.in_use == 0)
											af.loc = src.loc
											af.in_use = 1;
											af.icon_state = src.icon_state
											af.overlays = src.overlays
											af.alpha = 50
											af.step_x = src.step_x
											af.step_y = src.step_y
											af.dir = src.dir
											spawn(1.5)
												if(af)
													af.in_use = 0;
													af.loc = null
											break;
								step(src.client.mob,src.client.move_dir,src.step_size)
								if(round(src.skill_quicksilver.speed_ramp) >= 6)
									if(src.skill_quicksilver.speed)
										var/obj/h = src.skill_quicksilver.speed
										h.loc = src.loc
										h.dir = src.dir
										if(src.dir == SOUTH || src.dir == NORTH) h.pixel_x = -32
										else h.pixel_x = -40
										h.step_x = src.step_x
										h.step_y = src.step_y
									if(src.skill_quicksilver.speed_skip == 0)
										src.dust_and_furrows(pick(1,2,3,4,5,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0))
										src.icon_state = "dodge"
										src.skill_quicksilver.speed_skip = 1
									else src.skill_quicksilver.speed_skip = 0
								sr -= 1
							if(src.skill_quicksilver.speed_ramp <= 0)
								src.skill_quicksilver.speed_ramp = 0
								src.icon_state = src.state()
								if(src.skill_focus == null || src.skill_focus && src.skill_focus.active == 0) src.overlays -= /obj/effects/elec
						step(src.client.mob,src.client.move_dir,src.step_size)
						src.layer = MOB_LAYER + src.laymod - (src.y + src.step_y / 32) / world.maxy
						//src.set_shadow()
						src.lastloc = src.loc
						src.last_step_x = src.step_x
						src.last_step_y = src.step_y
						if(src.map_blip)
							src.map_blip.pixel_x = src.x-3
							src.map_blip.pixel_y = src.y-3
					/*
					if(!src.skill_flight || src.skill_flight && !src.skill_flight.active)
						//lvl up leg muscles
						if(src.bodyparts)
							var/obj/body_related/bodyparts/right_leg/rl = src.bodyparts[5]
							for(var/obj/body_related/bodyparts/p in rl)
								if(p.bodypart_type == "Muscle")
									p.part_exp += 0.1
									p.part_reward(src,1,null,0)
							var/obj/body_related/bodyparts/left_leg/ll = src.bodyparts[6]
							for(var/obj/body_related/bodyparts/p in ll)
								if(p.bodypart_type == "Muscle")
									p.part_exp += 0.1
									p.part_reward(src,1,null,0)
					*/
					if(src.mouse_down && src.current_attack) src.dir = get_dir(src,src.mouse_down)
					if(src.mouse_down == null && src.current_attack == null && src.target && src.target != src.grab)
						src.dir = get_dir(src,src.target)
						src.update_wings()
					//Player moves while afk
					if(src.afk)
						src.overlays -= /obj/effects/afk
						src.afk = 0
						winset(src,"chat.afk","is-checked=false")
						for(var/mob/x in view(8,src))
							x << output("[src] came back from afk.","chat.local")
					//src.build_marker.loc = locate(src.x-16,src.y-9,src.z)
					//src.build_marker.step_x = src.step_x
					//src.build_marker.step_y = src.step_y-12
					//src.build_marker.Move(locate(src.x-16,src.y-9,src.z),0,src.step_x,src.step_y-12)
atom/movable
	Cross(atom/movable/o)
		//Player moves into door
		if(istype(src,/obj/items/tech/doors/))
			if(src.density_factor >= 1)
				if(ismob(o))
					var/mob/m = o
					var/obj/items/tech/doors/d = src
					if(d.pass == null || d.pass == "")
						d.icon_state = "opening"
						d.density_factor = 0
						d.opacity = 0
						spawn(60)
							if(d)
								d.icon_state = "closing"
								d.density_factor = 2
								d.opacity = 1
					else if(m.client)
						winset(m,"numbers.label_numbers","text=\"Enter door password.\"")
						winshow(m,"numbers",1)
						m.numbers_text = "door password"
						m.left_click_ref = d
						return
		//Player moves into warper
		if(src.go_x && src.go_y && src.go_z) if(o in players)
			o.loc = locate(src.go_x,src.go_y,src.go_z)
			if(ismob(o))
				var/mob/m = o
				spawn(10)
					if(m) m.map_update_overlays()

		//Player moves over/through bush or long grass
		if(src.shudders) if(o.density_factor)
			src.shudders = 0;
			animate(src,transform = turn(matrix(), 3), time = 1)
			animate(transform = turn(matrix(), -3), time = 1)
			animate(transform = turn(matrix(), 0), time = 1)
			spawn(3)
				if(src) src.shudders = 1;

		//Code for when a beam hits an obj or mob.
		if(istype(o,/obj/ranged/checker))
			if(src.density || src.density_factor > 0)
				var/obj/ranged/checker/b = o
				if(b && b.origin)
					if(ismob(src))
						var/mob/M = src
						//var/Damage=(b.ki_force/2)/(M.resistance)
						var/Damage=((b.ki_force*b.force_usage)*b.ki_power)/(M.resistance*M.psionic_power)
						//world << "DEBUG - Beam dmg = [Damage]"
						if(M.afk == 0)
							if(Damage > 0)
								if(M.eating) M.cancel_eat()
								M.percent_health -= Damage
							M.gain_stat("resistance",1,1,"Attacked by skill",1)
							M.gain_stat("defence",1,1,"Defending from ranged",1)
							if(b && b.origin)
								if(!M.remembers_force.Find(b.origin.id)) M.remembers_force += b.origin.id
								if(!b.origin.remembers_resistance.Find(M.id)) b.origin.remembers_resistance += M.id
								b.origin.gain_stat("force",1,1,"Using skill",1)
								b.origin.gain_stat("offence",1,1,"Attacking ranged",1)
							if(!M.client && !M.target)
								M.target = b.origin
								var/mob/NPC/N = M
								N.npc_ai()
							if(M.koed)
								var/killer = null
								if(b) killer = b.ki_owner
								spawn(3)
									if(M)
										M.Death("[killer]",0)
							else if(M.percent_health <= 0)
								M.KO()
					else if(src.immune_dmg == 0)
						src.hp -= 10
						if(src.hp <= 0)
							var/turf/t = locate(src.x,src.y+1,src.z)
							if(t)
								//If a cliff part is destroyed and its the lower section of a cliff, make sure to dig/adjust the cliff.
								if(src.type == /obj/map/cliffs/c1 || src.type == /obj/map/cliffs/c2 || src.type == /obj/map/cliffs/c3)
									for(var/obj/map/cliffs/c in t)
										c.destroy()
									t.set_destroyed()
									world.edges_solid_rock(t.x-1,t.y+1,t.x+1,t.y-1,t.z)
								if(src.type == /obj/items/tech/Gravity_Machine)
									var/obj/items/tech/Gravity_Machine/gm = src
									gm.turn_off()
							if(istype(src,/obj/items/tech/))
								for(var/turf/trf in src.locs)
									for(var/obj/items/tech/Power_Line/p in trf)
										spawn(0)
											if(p) p.reconnect_power()
							src.destroy()
				if(o) o.loc = null
		//Code for when a blast or charge hits a obj or mob.
		else if(istype(o,/obj/ranged/))
			var/obj/ranged/b = o
			if(b.fired)// && b.ki_owner.active_attack) // || b.ki_owner.current_attack) //Check if the owner of this attack has an active/current attack set
				if(src.density || src.density_factor > 0)
					if(src.ki_owner != b.ki_owner && src != b.ki_owner)
						//If a blast crosses paths with a mob, apply the damage to them.
						if(ismob(src))
							var/mob/M = src
							if(M.eating) M.cancel_eat()
							if(M.afk == 0)
								var/Block=(b.ki_power*(b.ki_offence+(b.ki_agility*0.2)))/(M.psionic_power*(M.defence+(M.mod_agility*0.22)))
								if(!prob(Block*33))
									if(M.koed == 0 && M.stunned == 0)
										b.ang = rand(0,360)
										b.travel = 40
										if(b.type == /obj/ranged/blast)
											var/matrix/mat = matrix()
											mat.Turn(b.ang)
											b.transform = mat
										flick(pick("punch","kick"),M)
										return
								else
									//var/Damage=(b.ki_force)/(M.resistance)
									var/Damage=((b.ki_force*b.force_usage)*(b.ki_power))/(M.resistance*M.psionic_power)
									//world << "DEBUG - Beam dmg = [Damage]"
									//var/Damage=(b.ki_force)/(M.resistance)*rand(1,2)
									if(Damage > 0) M.percent_health -= Damage
									M.gain_stat("resistance",1,10,"Attacked by skill",1)
									M.gain_stat("defence",1,10,"Defending from ranged",1)
									M.gain_stat("power",1,1,"Attacked by skill",1)
									if(b.ki_owner)
										if(!M.remembers_force.Find(b.ki_owner.id)) M.remembers_force += b.ki_owner.id
										if(!b.ki_owner.remembers_resistance.Find(M.id)) b.ki_owner.remembers_resistance += M.id
										b.ki_owner.gain_stat("force",1,10,"Using skill",1)
										b.ki_owner.gain_stat("offence",1,10,"Attacking ranged",1)
										if(!M.client && !M.target)
											M.target = b.ki_owner
											var/mob/NPC/N = M
											N.npc_ai()
									if(M.koed)
										var/killer = null
										if(b) killer = b.ki_owner
										spawn(3)
											if(M)
												M.Death("[killer]",0)
									else if(M.percent_health <= 0)
										M.KO()
						if(istype(src,/obj/ranged/)) //b hits src, which is another blast.
							var/obj/ranged/r = src;
							var/obj/ranged/enemy_ball = r.ki_owner.active_attack
							if(enemy_ball)
								r.ki_force = (r.ki_owner.force/10)
								r.force_usage = r.ki_owner.mod_force_usage
							if(b.ki_force > r.ki_force) //Check which is stronger.
								r.loc = null
							else
								b.loc = null
						if(b.explode_impact == 1)
							b.explode_impact = 2
							var/turf/t = src.loc
							var/c_l = b.charge_lvl-1
							for(var/mob/M in view(c_l,src.loc))
								if(M.afk == 0)
									var/Damage=((b.ki_force*b.force_usage)*(b.ki_power))/(M.resistance*M.psionic_power)
									var/mob/attacker = b.ki_owner
									var/dd = get_dir(src.loc,M)
									spawn(1)
										if(M && M != src && M != attacker)
											//Make anyone near the explosion take half the damage of the attack, and knock them back.
											if(Damage > 0)
												Damage/=2
												if(M.eating) M.cancel_eat()
												M.percent_health -= Damage
											M.gain_stat("resistance",1,10,"Attacked by skill",1)
											M.gain_stat("defence",1,10,"Defending from ranged",1)
											M.gain_stat("power",1,1,"Attacked by skill",1)
											if(attacker)
												attacker.gain_stat("force",1,10,"Using skill",1)
												attacker.gain_stat("offence",1,10,"Attacking ranged",1)
												if(!M.client && !M.target)
													M.target = attacker
													var/mob/NPC/N = M
													N.npc_ai()
											M.KB_furrow = 1
											M.KB = 50
											M.KnockBack(dd)
							//if(istype(b,/obj/ranged/blast)) b.loc = null
							//else del(b)
							if(src && !ismob(src))
								if(src.immune_dmg == 0)
									//var/Damage=b.ki_force
									var/Damage = (b.ki_force*b.force_usage)*b.ki_power
									src.hp -= Damage
									if(src.hp <= 0)
										if(istype(src,/obj/items/tech/))
											for(var/turf/trf in src.locs)
												for(var/obj/items/tech/Power_Line/p in trf)
													spawn(0)
														if(p) p.reconnect_power()
										src.destroy()
							b.expired = 1
							b.destroy()
							if(t) t.explosion(round(c_l))
						//world << output("[b] tried to cross [src] but was prohibited. (cross ranged)", "chat.system")
						else b.loc = null
						return
		else if(src.density_factor >= 1 && o.density_factor >= 1) if(o.lobber != src) if(!istype(src,/obj/ranged/)) //if(src.ki_owner != o)
			if(o.KB)
				o.KB = 0
				if(o.thrown_str) if(ismob(src))
					var/Damage=o.thrown_str/src.endurance*rand(2,4)
					src.percent_health -= Damage
				//if(create_dust) src.dust_explosion(33,1)
				if(src.loc)
					var/turf/x = src.loc
					if(x.liquid == null)
						var/obj/effects/craters/crater_small/c = new
						c.loc = src.loc
						c.step_x = src.step_x
						c.step_y = src.step_y
				//if(o.explode_impact) o.explode_impact = 2
				if(isobj(src)) if(src.hp)
					if(src.immune_dmg == 0)
						src.hp -= 34
						if(src.hp <= 0)
							if(istype(src,/obj/items/tech/))
								for(var/turf/trf in src.locs)
									for(var/obj/items/tech/Power_Line/p in trf)
										spawn(0)
											if(p) p.reconnect_power()
							src.destroy() //del(src)
			//if(o.explode_impact) del(o)
			//del(o)
			if(ismob(o))
				var/mob/m = o
				//if(!m.client) m.dir = rand(1,8)
				if(m.skill_quicksilver && m.skill_quicksilver.active)
					if(m.skill_quicksilver.speed) m.skill_quicksilver.speed.loc = null
					if(m.skill_quicksilver.speed_ramp >= 6)
						m.skill_quicksilver.speed_ramp = 0 // We have this twice, once here and once below, due to the delay sleep() with explosion.
						m.loc.explosion(6)
					m.skill_quicksilver.speed_ramp = 0
			return
		return 1
turf
	Enter(atom/movable/o, atom/oldloc)
		..()
		if(ismob(o))
			var/mob/m = o
			if(m.started)
				m.tmp_dmg = src.tmp_dmg
				if(m.skill_quicksilver && m.skill_quicksilver.active && m.tmp_dmg >= 0 && m.skill_quicksilver.speed_ramp >= 3) m.tmp_dmg = 1
				m.grav = src.grav
				m.microwaves = src.microwaves
				//Underwater
				if(m.submerged && src.liquid == null)
					m.submerge(0,1,src)
					if(m.client && m.bar_o2) m.client.images -= m.bar_o2
				//If turf is a kind of liquid or has no air, and mob isn't already submerged, then continue.
				if(src.liquid && m.submerged == 0)
					var/flying = 0
					if(m.skill_flight && m.skill_flight.active) flying = 1
					if(m.skill_levitation && m.skill_levitation.active) flying = 1
					if(flying == 0 || src.liquid == "psionic")
						m.submerge(1,1,src)
						if(m.client && m.bar_o2) m.client.images += m.bar_o2
		if(src.density_factor >= 1)
			//If a charge or blast hits a solid turf, check if it should explode.
			if(istype(o,/obj/ranged/))
				if(src.immune_dmg == 0)
					var/obj/ranged/b = o
					src.hp -= 0.1
					/*
					if(src.glow == null)
						var/obj/g = new
						g.icon = 'fx_glow.dmi'
						g.layer = 5
						g.loc = src
						g.alpha = 35
						g.icon += rgb(35,0,0)
						g.name = "glow"
						g.immune_dmg = 1
						g.mouse_opacity = 0
						g.bolted = 2
						src.glow = g
					if(src.red < 255)
						src.red += 1
						src.glow.icon += rgb(1,0,0)
						if(src.glow.alpha < 100) src.glow.alpha += 1
					src.set_damage_glow()
					*/
					if(src.damage == null)
						var/obj/effects/damage_roof/d = new
						src.vis_contents += d
						src.damage = d
					else
						var/obj/d = src.damage
						if(src.hp <= src.hp_max/6) d.icon_state = "6"
						else if(src.hp <= src.hp_max/5) d.icon_state = "5"
						else if(src.hp <= src.hp_max/4) d.icon_state = "4"
						else if(src.hp <= src.hp_max/3) d.icon_state = "3"
						else if(src.hp <= src.hp_max/2) d.icon_state = "2"
						else if(src.hp <= src.hp_max/1.1) d.icon_state = "1"
						else d.icon_state = "0"
					if(src.hp <= 0)
						src.filters = null
						if(src.red > 0)
							src.icon -= rgb(src.red,0,0)
							src.red = 0
						var/obj/effects/hit/h = new
						h.loc = o.loc
						h.dir = o.dir
						if(o.dir == SOUTH || o.dir == NORTH) h.pixel_x += 16
						h.step_x = o.step_x
						h.step_y = o.step_y
						spawn(10)
							if(h) h.destroy()
						src.remove_worldmap_building()
						src.set_destroyed()
						for(var/obj/map/cliffs/c in src)
							c.destroy()
						for(var/obj/map/cliffs/c in locate(src.x,src.y-1,src.z))
							c.destroy()
						world.edges_solid_rock(src.x-1,src.y+1,src.x+1,src.y-1,src.z)
						src.og_type = null
					if(b.explode_impact == 1)
						b.explode_impact = 2
						var/c_l = b.charge_lvl-1
						if(istype(b,/obj/ranged/blast)) b.loc = null
						else del(b)
						src.explosion(round(c_l))
						return
					if(o.name == "beam checker")
						o.loc = null
						return 1
			else if(o.density_factor >= 1)
				if(o.KB)
					if(src.immune_dmg == 0)
						src.hp -= o.KB
						if(src.damage == null)
							var/obj/effects/damage_roof/d = new
							src.vis_contents += d
							src.damage = d
						else
							var/obj/d = src.damage
							if(src.hp <= src.hp_max/6) d.icon_state = "6"
							else if(src.hp <= src.hp_max/5) d.icon_state = "5"
							else if(src.hp <= src.hp_max/4) d.icon_state = "4"
							else if(src.hp <= src.hp_max/3) d.icon_state = "3"
							else if(src.hp <= src.hp_max/2) d.icon_state = "2"
							else if(src.hp <= src.hp_max/1.1) d.icon_state = "1"
							else d.icon_state = "0"
						if(src.hp <= 0)
							src.filters = null
							if(src.red > 0)
								src.icon -= rgb(src.red,0,0)
								src.red = 0
							var/obj/effects/hit/h = new
							h.loc = o.loc
							h.dir = o.dir
							if(o.dir == SOUTH ||o.dir == NORTH) h.pixel_x += 16
							h.step_x = o.step_x
							h.step_y = o.step_y
							spawn(10)
								if(h) h.destroy()
							src.set_destroyed()
							src.og_type = null
				else if(ismob(o))
					var/mob/m = o
					if(m.skill_quicksilver && m.skill_quicksilver.active)
						if(m.skill_quicksilver.speed) m.skill_quicksilver.speed.loc = null
						if(m.skill_quicksilver.speed_ramp >= 6)
							m.skill_quicksilver.speed_ramp = 0 // We have this twice, once here and once below, due to the delay sleep() with explosion.
							m.loc.explosion(7)
						m.skill_quicksilver.speed_ramp = 0
				return
			/*
			if(o.density_factor >= 1)
				if(o.ki_owner == null) //If someone tries to walk through or into a ki attack, let them, otherwise all other movement shold be prohibited.
					//world << output("[o] tried to enter [src] but was prohibited. (enter)", "chat.system")
					return
			*/
		if(src.density_factor == 2 && o.density_factor != -1)
			if(ismob(o))
				var/mob/m = o
				if(m.skill_quicksilver && m.skill_quicksilver.active)
					if(m.skill_quicksilver.speed) m.skill_quicksilver.speed.loc = null
					if(m.skill_quicksilver.speed_ramp >= 6)
						m.skill_quicksilver.speed_ramp = 0 // We have this twice, once here and once below, due to the delay sleep() with explosion.
						m.loc.explosion(6)
					m.skill_quicksilver.speed_ramp = 0
			return
		return 1

//	This library is a set of procs for finding, setting,
//	and shifting the absolute pixel positions of atoms.

//	(1, 1) is the bottom-left pixel of the map.

#ifndef TILE_WIDTH
#define TILE_WIDTH 32
#endif

#ifndef TILE_HEIGHT
#define TILE_HEIGHT 32
#endif

atom
	proc
		/* Get the pixel width of this atom's bounding box.
		*/
		Width_lib()  . = TILE_WIDTH

		/* Get the pixel height of this atom's bounding box.
		*/
		Height_lib() . = TILE_HEIGHT

		/* Get the absolute pixel-x-coordinate of the bounding box's left edge.
		*/
		Px(P) . = 1 + (x - 1 + P) * TILE_WIDTH

		/* Get the absolute pixel-y-coordinate of the bounding box's bottom edge.
		*/
		Py(P) . = 1 + (y - 1 + P) * TILE_HEIGHT

		/* Get the absolute pixel-x-coordinate of the bounding box's center.
		*/
		Cx() . = Px(1 / 2)

		/* Get the absolute pixel-y-coordinate of the bounding box's center.
		*/
		Cy() . = Py(1 / 2)

atom/movable
	Width_lib()  . = bound_width
	Height_lib() . = bound_height
	Px(P) . = 1 + bound_x + step_x + (x - 1) * TILE_WIDTH  + P * bound_width
	Py(P) . = 1 + bound_y + step_y + (y - 1) * TILE_HEIGHT + P * bound_height

	var
		/* Accumulates the fractional part of movements in the x-axis.
		*/
		fractional_x

		/* Accumulates the fractional part of movements in the y-axis.
		*/
		fractional_y

	proc
		/* Directly sets the loc and step offsets to the given arguments.

		Best to use a proc for this in case you want to add side effects, which
		you can't have if you're just setting variables directly in code.
		*/
		SetLoc(Loc, StepX = 0, StepY = 0)
			loc = Loc
			step_x = StepX
			step_y = StepY

		/* Directly sets the loc and step offsets in order for the bottom-left
		of the bounding box to be at a given absolute pixel coordinate, or
		to the bottom-left of a given atom.

		Format: SetPosition(atom/Atom)
		Parameters:
		* Atom: The object to align bounding box bottom-left corners with.

		Format: SetPosition(Px, Py, Z)
		Parameters:
		* Px: The desired resulting left x-coordinate.
		* Py: bottom y-coordinate.
		* Z: z-level.
		*/
		SetPosition(Px, Py, Z)
			if(isloc(Px))
				var atom/a = Px
				Px = a.Px()
				Py = a.Py()
				Z = a.z
			SetLoc(
				Loc = locate(
					1 + (Px-1)/TILE_WIDTH,
					1 + (Py-1)/TILE_HEIGHT,
					isnull(Z) ? z : Z),
				StepX = (Px-1) % TILE_WIDTH  - bound_x,
				StepY = (Py-1) % TILE_HEIGHT - bound_y)

		/* Directly sets the loc and step offsets in order for the center of the
		bounding box to be at a given absolute pixel coordinate, or at the
		center of a given atom.

		Behaves kinda screwy (i.e. sends you to the void) at map edges.

		Format: SetCenter(atom/Atom)
		Parameters:
		* Atom: The atom to align bounding box centers with.

		Format: SetCenter(Cx, Cy, Z)
		Parameters:
		* Cx: The desired resulting center x-coordinate.
		* Cy: y-coordinate.
		* Z: z-level.
		*/
		SetCenter(Cx, Cy, Z)
			if(isloc(Cx))
				var atom/a = Cx
				Cx = a.Cx()
				Cy = a.Cy()
				Z = a.z
			SetPosition(Cx - Width_lib()/2, Cy - Height_lib()/2, Z)

		/* Slides this movable atom by a given offset in pixels.

		Fractional movements are preserved in the fractional_x/y variables.
		Preserved, as in successive calls to Translate(0.1, 0) will
		eventually add up to a single-pixel movement to the right.

		Parameters:
		* X: Distance to move along the x-axis in pixels.
		* Y: Distance to move along the y-axis in pixels.

		Returns:
		* null if both arguments are false.
		* TRUE if only the fractional values changed.
		* The result of Move() for a successful whole-pixel movement.
		*/
		Translate(X, Y)
			if(!(X || Y)) return
			var rx, ry
			if(X)
				fractional_x += X
				rx = round(fractional_x, 1)
				fractional_x -= rx
			if(Y)
				fractional_y += Y
				ry = round(fractional_y, 1)
				fractional_y -= ry
			var s = step_size
			step_size = max(abs(rx), abs(ry)) + 1
			. = (rx || ry) ? Move(loc, dir, step_x + rx, step_y + ry) : TRUE
			step_size = s

		/* Slides this movable atom by a given polar vector.

		Uses Translate(), so fractional movements are preserved.

		Parameters:
		* Distance: Distance to move in pixels.
		* Angle: Direction to move in degrees clockwise from NORTH.

		Returns:
		* Whatever Translate() returns.
		*/
		Project(Distance, Angle)
			. = Translate(Distance * sin(Angle), Distance * cos(Angle))
