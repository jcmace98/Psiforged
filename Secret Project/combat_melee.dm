mob
	verb
		Button_Attack()
			set popup_menu = 0
			set hidden = 1
			usr.attack_state = "melee"
	proc
		set_dir(var/d)
			//Sets the mobs direction based on another mob, so they face them
			if(d == 0) src.dir = WEST
			if(d == 45) src.dir = NORTHWEST
			if(d == 90) src.dir = NORTH
			if(d == 135) src.dir = NORTHEAST
			if(d == 180) src.dir = EAST
			if(d == 225) src.dir = SOUTHEAST
			if(d == 270) src.dir = SOUTH
			if(d == 315) src.dir = SOUTHWEST
		evasion(var/mob/attacker,var/mob/defender)
			var/Evasion=(attacker.psionic_power*(attacker.offence+(attacker.mod_agility*0.2)))/(defender.psionic_power*(defender.defence+(defender.mod_agility*0.22)))
			if(defender.koed == 0 && defender.stunned == 0) if(!prob(Evasion*33))
				flick("dodge",defender)
				//for(var/mob/h in view(8,defender))
					//h << sound(pick(dodges),0,0,2,100)
				if(defender.target == attacker)
					if(!defender.remembers_offence.Find(attacker.id)) defender.remembers_offence += attacker.id
				if(attacker.target == defender)
					if(!attacker.remembers_defence.Find(defender.id)) attacker.remembers_defence += defender.id
				return 1 //1 sucessful dodge
			return 0
		speed_image_reverse(var/turf/start,var/s_step_x,var/s_step_y,var/s_step_z)
			var/obj/img = new
			img.density_factor = 0
			img.density = 0
			img.loc = src.loc
			img.step_x = src.step_x
			img.step_y = src.step_y
			img.pixel_z = s_step_z
			img.dir = src.dir
			var/a = 130
			var/steps = 0
			var/ang = img.GetAngleStep(start)
			var/b_dist = round(bounds_dist(start,src))
			var/steps_total = round(b_dist/8)
			//var/sound/s = sound(pick(speed),0,0,12,100)
			//for(var/mob/h in view(8,src))
				//h << s
			while(b_dist > 0)
				a -= 1
				img.MoveAng(ang,8,0,0,src)
				steps += 1
				b_dist -= 8
				if(steps > 160)
					img.loc = null
					return
				for(var/obj/effects/after_image/af in src.afterimages)
					if(af.in_use == 0)
						af.loc = img.loc
						af.in_use = 1;
						af.icon = src.icon
						af.icon_state = src.icon_state
						af.overlays = src.overlays
						af.alpha = a
						af.step_x = img.step_x
						af.step_y = img.step_y
						af.pixel_z = img.pixel_z
						af.dir = src.dir
						spawn(steps_total/8)
							if(af)
								af.in_use = 0;
								af.loc = null
								af.pixel_z = 0
								af.alpha = 130
						steps_total -= 1
						break;
			//world << "DEBUG - steps total = [steps_total]"
			img.loc = null
		speed_image(var/atom/target,var/time = 2)
			if(src.skill_super_speed.using == 0)
				src.skill_super_speed.using = 1
				var/ds = src.density_factor
				src.density_factor = 0
				src.appearance_flags = LONG_GLIDE | KEEP_TOGETHER
				var/a = 50
				//if(ismovable(target)) times = 4.5
				var/steps = (get_dist(src,target)*5)
				//steps += 2
				//var/steps = bounds_dist(src,target)
				//src << output("[src] and [target] are [steps] pixels away from one another. This would take [round(steps/8)] steps to reach.","chat.system")
				//steps = round(steps/8)
				var/steps_max = steps
				src.filters += filter(type="motion_blur", x=1, y=0)
				//src.icon_state = "super speed"
				var/ang = src.GetAngleStep(target)
				src.dir = get_dir(src,target) //Was inside the while() statement, maybe move back if looks bad?
				//var/sound/s = sound(pick(speed),0,0,12,100)
				//for(var/mob/h in view(8,src))
					//h << s
				while(steps > 0)
					steps -= 1
					for(var/obj/effects/after_image/af in src.afterimages)
						if(af.in_use == 0)
							af.loc = src.loc
							af.in_use = 1;
							af.icon_state = src.icon_state
							af.overlays = src.overlays
							af.alpha = a
							af.step_x = src.step_x
							af.step_y = src.step_y
							//af.dir = get_dir(src,target)
							af.dir = src.dir
							spawn((steps_max/10) - (steps/10))
								if(af)
									af.in_use = 0;
									af.loc = null
							break;
					a += 1
					var/xx = src.step_x
					var/yy = src.step_y
					src.MoveAng(ang,8,0,0,target)
					if(src.step_x == xx && src.step_y == yy)
						steps = 0
						src << output("Aborted super speed movement for [src], ran into solid.","chat.system")
					if(bounds_dist(src,target) <= -0) steps = 0
				src.density_factor = ds
				spawn(time)
					if(src)
						src.filters -= filter(type="motion_blur", x=1, y=0)
						//src.appearance_flags = null
						src.skill_super_speed.using = 0
						src.icon_state = src.state()
		damage_limb(var/mob/attacker,var/random = 1, var/show_msg = 1, var/Damage = 0.1,var/obj/body_related/limb = null)
			if(random)
				if(length(src.bodyparts) > 0)
					var/obj/body_related/part = pick(src.bodyparts)
					if(length(part.contents) > 0)
						var/obj/body_related/hit_part = pick(part.contents)
						hit_part.hp -= Damage*2
						if(src.hurt_limbs == null || islist(src.hurt_limbs) == 0) src.hurt_limbs = list()
						if(!src.hurt_limbs.Find(hit_part)) src.hurt_limbs += hit_part
						//Part is damaged or broken, so now it needs time to heal.
						if(hit_part.hp <= 0)
							var/msg = "Damaged"
							if(hit_part.bodypart_type == "Bone") msg = "Broken"
							hit_part.hp = 0
							src.damage_part(hit_part,1,msg,show_msg)
							//If its a bone, find all the parts connected to it and disable them also.
							if(hit_part.bodypart_type == "Bone")
								var/list/extensions = list()
								for(var/obj/body_related/p in part)
									if(p.part_hierarchy < hit_part.part_hierarchy)
										extensions += p
								src.disable_parts(extensions,0,1,show_msg,"[msg]:<font color = red> [hit_part]")
						if(src.client)
							if(show_msg) src << output("Hit by [attacker] in the [part], hurting your [hit_part] for [round(Damage*2,0.1)]%","chat.system")
							if(hit_part == src.part_selected)
								winset(src,"body.bar_hp","value=[hit_part.hp]")
						if(show_msg && attacker.client) attacker << output("Hit [src] in the [part], hurting their [hit_part] for [round(Damage*2,0.1)]%","chat.system")
			else if(limb)
				limb.hp -= Damage*2
				if(!src.hurt_limbs.Find(limb)) src.hurt_limbs += limb
				//Part is damaged or broken, so now it needs time to heal.
				if(limb.hp <= 0)
					var/msg = "Damaged"
					if(limb.bodypart_type == "Bone") msg = "Broken"
					limb.hp = 0
					src.damage_part(limb,1,msg,show_msg)
					//If its a bone, find all the parts connected to it and disable them also.
					if(limb.bodypart_type == "Bone")
						var/list/extensions = list()
						for(var/obj/body_related/p in limb.loc)
							if(p.part_hierarchy < limb.part_hierarchy)
								extensions += p
						src.disable_parts(extensions,0,1,show_msg,"[msg]:<font color = red> [limb]")
				if(src.client)
					//if(show_msg) src << output("Hit by [attacker] in the [limb.loc], hurting your [limb] for [round(Damage*2,0.1)]%","chat.system")
					if(limb == src.part_selected)
						winset(src,"body.bar_hp","value=[limb.hp]")
				//if(show_msg && attacker && attacker.client) attacker << output("Hit [src] in the [limb.loc], hurting their [limb] for [round(Damage*2,0.1)]%","chat.system")
		Death(var/reason,var/make_body = 1)
			//src.KB = 0;
			var/already_dead = src.dead //Save this so we know if they were already dead or not, before applying their dead = 1. Just so things like bodyparts aren't disabled twice.
			if(islist(src.tutorials))
				var/obj/help_topics/H = src.tutorials[5]
				if(H.seen == 0)
					H.seen = 1
					H.skill_up(src)
			if(src.eating) src.cancel_eat()
			src.letgo()
			src.dead = 1;
			src.toxicity = 0
			src.hunger = 0
			src.thirst = 0
			src.restedness = 0
			src.disable_skills()
			src.clear_drugs()
			src.energy = 1
			src.percent_health = 1
			for(var/mob/m in players)
				if(m.target == src) m.add_remove_target(src,1)
			//src.KB_furrow = 0;
			//src.icon_state = src.state()
			if(src.charging)
				var/obj/ranged/c = src.charging
				c.remove()
				src.charging = null
			var/chance = 100
			if(src.trait_ur) chance = 50
			if(prob(chance))
				for(var/mob/m in view(18,src))
					m.create_chat_entry("alerts","[src] is killed by [reason]!")
				if(src.grabbed_by)
					var/mob/X = src.grabbed_by
					X.letgo()
				var/turf/t = src.loc
				//Create the body
				if(src.has_body && make_body)
					var/obj/items/misc/body/b = new
					b.appearance = src.appearance
					b.loc = src.loc
					b.step_x = src.step_x
					b.step_y = src.step_y
					b.icon_state = "ko"
					b.owner = src.real_name
					items += b
					b.hp = src.psionic_power*src.endurance
				var/obj/items/misc/item_container/ic = new
				ic.name = "[src]'s items"
				ic.loc = src.loc
				ic.step_x = src.step_x
				ic.step_y = src.step_y
				//Drop cybertech
				src.drop_cybertech()
				//Drop items
				for(var/obj/items/i in src)
					src.drop(i)
					i.loc = ic
				//if(src.keep_body == 0) src.has_body = 0;
				src.has_body = 0;
				src.alpha = 0;
				if(src.client)
					if(src.shadow) src.shadow.loc = null
					var/mob/clone = null;
					var/obj/stone = null
					for(var/obj/items/consumables/spirit_stone/i in items)
						if(i.fused_name == src.real_name && i.fused_key == src.key && i.fused_id == src.id)
							stone = i
							break
					for(var/mob/m in world)
						for(var/i in src.clones)
							//world << output("Debug - Found clone id [i].", "chat.system")
						//if(m.id in src.clones)
							if(i == m.id && m.being_grown == 0)
								//world << output("Debug - Found clone.", "chat.system")
								clone = m
								break;
					/*
					if(src.vat)
						var/obj/items/tech/Vat/v = src.vat
						if(v.set_for == src.id) clone = v
					*/
					if(clone)
						src.loc = clone.loc
						src.step_x = clone.step_x
						src.step_y = clone.step_y//+14
						src.dead = 0;
						src.has_body = 1
						src.icon_state = "meditate"
						src.copy_mob_genetics(clone,0,0,0,0,"copy clone")
						clone.give_extra_organs(null,src)
						clone.vat.set_for = null
						clone.vat.in_use = null;
						clone.vat.growth_percent = 0
						clone.vat = null
						//del(clone)
						//src.layer = clone.layer + 1;
						//src.transform = matrix()*0.1
						//src.stunned += 1
						//src.being_cloned = 1;
					else if(stone)
						src.loc = locate(stone.x,stone.y-1,stone.z)
						if(src.map_blip)
							src.map_blip.pixel_x = src.x-3
							src.map_blip.pixel_y = src.y-3
						src.step_x = stone.step_x
						src.step_y = stone.step_y
						src.dead = 0;
						src.has_body = 1
						for(var/obj/body_related/bodyparts/b in src.bodyparts)
							for(var/obj/body_related/bodyparts/o in b)
								src.damage_limb(src,0, 0, 100,o)
						if(src.skill_meditation) call(src.skill_meditation.act)(src,src.skill_meditation)
					else
						if(src.debuff_dead && src.debuff_dead.active == 0) call(src.debuff_dead.act)(src,src.debuff_dead)
						src.loc = locate(288,231,2)
						if(src.map_blip)
							src.map_blip.pixel_x = src.x-3
							src.map_blip.pixel_y = src.y-3
						src.step_x = 0;
						src.step_y = 0;
						src.in_oldage = 0
						src.vigour = 100
						src.apply_afterlife_glow(1)
						if(already_dead == 0) src.disable_parts(null,1,1,1,"Death")
					src.client.perspective = EYE_PERSPECTIVE | EDGE_PERSPECTIVE
					src.client.eye = t
					src.screen_text.maptext = "<font size = 6><center>You have died"
					animate(src.screen_text,alpha = 255,time = 30)
					//winset(src,null,"stats_other.label_dead.text=\"Dead: Yes\"")
					//winset(src,null,"stats_other.label_has_body.text=\"Has Body: No\"")
					sleep(60)
					if(src) animate(src.vision,alpha = 255,time = 30)
					sleep(30)
					if(src)
						src.client.perspective = MOB_PERSPECTIVE | EDGE_PERSPECTIVE //initial(src.client.perspective)
						src.client.eye = src
						src.screen_text.alpha = 0;
						src.dir = SOUTH
						animate(src.vision,alpha = 0,time = 30)
						animate(src,alpha = 200,time = 10)
						if(clone == null && stone == null)
							src.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
							src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
						else
							src.alpha = 255
							del(clone)
						/*
						else
							animate(transform = matrix()*1,time = 600)
							src.cloning()
						*/
				else src.loc = null
		KnockBack(var/KB_dir)
			if(src.eating) src.cancel_eat()
			if(src.charging && src.KB > 1)
				src.stop_charging()
			var/skip = 0
			var/obj/plume = null
			for(var/obj/p in plumes)
				if(p.loc == null)
					plume = p
					break
			plume.dir = src.dir
			while(src && src.KB)
				if(!src.skill_flight || src.skill_flight && src.skill_flight.active == 0)
					if(!src.skill_levitation || src.skill_levitation && src.skill_levitation.active == 0)
						if(isturf(src.loc))
							var/turf/t = src.loc
							if(t.tmp_dmg < 0) plume.icon = 'fx_dust_plume_snow.dmi'
							else if(istype(t,/turf/lava_cooled) || istype(t,/turf/lava_cooling)) plume.icon = 'fx_ash_plume.dmi'
							else plume.icon = 'fx_dust_plume.dmi'
							if(t.fragile)
								if(skip == 0)
									skip += 1
									src.dust_and_furrows()
									plume.loc = get_step(src,src.dir)
									plume.step_x = src.step_x
									if(plume.dir == SOUTHWEST) plume.step_y = src.step_y+24
									else if(plume.dir == NORTHEAST) plume.step_y = src.step_y-24
									else if(plume.dir == NORTHWEST) plume.step_y = src.step_y-24
									else if(plume.dir == SOUTHEAST)
										plume.step_y = src.step_y+24
										plume.step_x = src.step_x-6
									else plume.step_y = src.step_y
								else
									skip = 0
				src.icon_state = "kb"
				src.KB -= 1
				step(src,KB_dir,src.step_size)
				src.set_shadow()
				src.layer = MOB_LAYER + src.laymod - (src.y + src.step_y / 32) / world.maxy
				src.update_wings()
				sleep(0.1)
			if(src)
				src.impact_cd = 0
				src.KB_furrow = 0
				src.recovering = 1
				spawn(src.attack_rate)
					if(src) src.recovering = 0
				src.icon_state = src.state()
				src.update_wings()
			if(plume) plume.remove_obj(0.1)
		Body()
			if(src.has_body == 0)
				animate(src,alpha = 255, time = 30)
				src.icon_state = ""
				src.screen_text.maptext = "<font size = 6><center>Body reformed"
				src.has_body = 1;
				animate(src.screen_text,alpha = 255,time = 60)
				animate(alpha = 0,time = 60)
				src.disable_parts(null,1,0)
				winset(src,null,"stats_other.label_has_body.text=\"Has Body: Yes\"")
		Revive()
			src.dead = 0;
			animate(src,alpha = 255, time = 30)
			src.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
			src.screen_text.maptext = "<font size = 6><center>Soul restored"
			animate(src.screen_text,alpha = 255,time = 60)
			animate(alpha = 0,time = 60)
			//winset(src,null,"stats_other.label_dead.text=\"Dead: No\"")
			var/list/soul_related = list()
			for(var/obj/body_related/b in src.ascensions)
				if(b.needs_soul) soul_related += b
			for(var/obj/body_related/b in src.soul)
				soul_related += b
			src.disable_parts(soul_related,0, 0,1)
			//if(src.debuff_dead && src.debuff_dead.active) call(src.debuff_dead.act)(src,src.debuff_dead)
		KO(var/loggedin = 0)
			if(src.koed) return
			if(src.eating) src.cancel_eat()
			if(src.charging)
				var/obj/ranged/c = src.charging
				c.remove()
				src.charging = null
			src.letgo()
			src.disable_skills()
			if(src.client) src.client.color = list(0.30,0.30,0.30,0, 0.60,0.60,0.60,0, 0.10,0.10,0.10,0, 0,0,0,1, 0,0,0,0)
			src.koed = 1
			if(src.client) src.client.images += src.bar_ko
			if(src.power_percent > 100) src.power_percent = 100;
			src.icon_state = "ko"
			src.percent_health = 0
			src.lifeforce = 100
			src.recovering = 0;
			src.stunned = 0
			if(src.hair) src.overlays -= src.hair
			src.idle_state = "ko"
			view() << output("[src] is knocked out.","chat.local")
			var/time = 240/src.mod_regeneration
			if(src.trait_wos) time = time/2
			src.ko_time = time
			src.ko_time_max = time
			if(src.divine_weapon)
				for(var/mob/m in players)
					if(src.owner == m.real_name)
						src.dimiss_follower(m)
						return
			spawn(time)
				if(src)
					src.koed = 0
					src.redraw_appearance()
					src.idle_state = null
					src.lifeforce = 100;
					src.stunned = 0;
					src.can_attack = 1;
					src.recovering = 0;
					src.icon_state = src.state()
					if(src.client)
						src.client.color = null
						src.client.images -= src.bar_ko
					/*
					else
						var/mob/NPC/N = src
						N.returning = 1
						if(N.skill_flight && N.skill_flight.active == 0) call(N.skill_flight.act)(N,N.skill_flight)
						if(N.skill_super_speed) N.skill_super_speed.active = 1
						N.npc_ai()
					*/
					if(src.percent_health < 0) src.percent_health = 0
					view() << output("[src] regains consciousness.","chat.local")
		Attack()
			if(src.koed || src.stunned || src.recovering) //If the player is ko, stunned, ect, they can't attack.
				//world << output("unable to attack - KO'ed, stunned, ect.","chat.local")
				return
			if(src.target)
				if(src.target.loc == null)
					if(src.target.target == src) src.target.target = null
					src.target = null
					return
				if(src.KB <= 0) src.dir = get_dir(src,src.target)
			if(src.can_attack <= 0)
				//world << output("unable to attack - can_attack = [src.can_attack]","chat.local")
				return
			if(src.energy <= 1)
				//world << output("unable to attack - no energy","chat.local")
				return
			if(src.psionic_power < 0)
				//world << output("unable to attack - psi power = 0","chat.local")
				return
			src.can_attack = 0
			spawn(src.attack_rate)
				if(src)
					src.can_attack = 1
					src.last_attacked = null
			if(src.eating) src.cancel_eat()
			/*
			if(src.target == null)
				for(var/mob/M in get_step(src,src.dir))
					if(bounds_dist(src, M) <= 32) if(M.can_harm) if(M != src)
						src.target = M
						if(M.target == null)
							M.dir = get_dir(M,src)
							M.target = src
						break
			*/
			if(src.target && src.target.z == src.z && src.target.afk == 0)
				if(src.target.KB > 0)
					//world << output("unable to attack - target knocked back","chat.local")
					return
				var/mob/M = src.target
				if(M.target == null && M.koed == 0)
					M.target = src
					/*
					if(M.client == null && M.byond_key == null)
						var/mob/NPC/N = M
						N.npc_ai()
					*/
				//Set the can_attack to 0, and set it on a cd based on speed
				src.can_attack = 0
				//Warp toward our target with super speed if possible
				if(src.skill_super_speed && src.skill_super_speed.active)
					//world << "DEBUG - Has super speed and is active"
					if(src.icon_state != "kb")
						//world << "DEBUG - Not in KB icon_state"
						if(get_dist(src,M) <= 18) //This is in tiles, not pixels.
							//world << "DEBUG - Not too far away"
							var/turf/s = src.loc
							var/s_x = src.step_x
							var/s_y = src.step_y
							var/s_z = src.pixel_z

							var/D = pick(0,45,90,135,180,225,270,315)
							//src.MoveAng(D,16,0,0,null)
							var/move_x = 18 * cos(D)
							var/move_y = 18 * sin(D)
							src.Move(M.loc, 0, M.step_x + move_x, M.step_y - move_y)
							src.layer = MOB_LAYER + src.laymod - (src.y + src.step_y / 32) / world.maxy
							src.filters -= filter(type="motion_blur", x=1, y=0)
							src.filters += filter(type="motion_blur", x=1, y=0)
							spawn(2)
								if(src) src.filters -= filter(type="motion_blur", x=1, y=0)
							src.set_shadow()
							src.set_dir(D)
							src.update_wings()
							var/removes = (1/src.mod_recovery) + (1/src.skill_super_speed.skill_lvl)
							src.energy -= removes
							src.skill_super_speed.skill_exp += ((5-(src.skill_super_speed.skill_lvl/20))*src.mod_skill)+0.5
							src.gain_stat("agility",1,1,"Super Speed",1)
							if(src.skill_super_speed.skill_exp >= 100 && src.skill_super_speed.skill_lvl < 100)
								src.skill_super_speed.skill_exp = 1
								src.skill_super_speed.skill_lvl += 1
							src.speed_image_reverse(s,s_x,s_y,s_z)
				/*
				spawn(src.attack_rate)
					if(src) src.can_attack = 1
				*/
				if(bounds_dist(src, src.target) <= src.attack_range)
					src.energy-=1
					if(src.skill_touch_of_death && src.skill_touch_of_death.active)
						var/removes = (10/src.mod_recovery) + (10/src.skill_touch_of_death.skill_lvl)
						if(src.energy < removes) call(src.skill_touch_of_death.act)(src,src.skill_touch_of_death)
						else src.energy -= removes
					if(src.skill_attack)
						var/obj/skills/att = src.skill_attack
						att.skill_exp += ((5-(att.skill_lvl/20))*src.mod_skill)+0.5
						if(att.skill_exp >= 100 && att.skill_lvl < 100)
							att.skill_exp = 1
							att.skill_lvl += 1
							att.skill_up(src)
					//src << output("<font color = teal>1 energy removed from attacking","chat.system")
					flick(pick("punch","kick"),src)
					src.last_attacked = M
					var/Damage=((strength*mod_str_usage)*(psionic_power))/(M.endurance*M.psionic_power)//*rand(2,4)
					if(src.divine_weapon && M.divine_weapon) Damage=Damage*4
					//if(super_spd == 1) Damage*=0.5 //Super speed lets us attack at max speed, but do half dmg
					if(Damage <= 0) Damage = 0.1
					//var/Evasion=(M.defence*(1+(M.mod_agility/10)))/(offence*(1+(mod_agility/10)))
					if(M && M != src)
						//If both the attacker and defender went to hurt one another recently, give them gains. This is here to avoid players hitting other players who are fighting someone else.
						if(M.last_attacked == src)
							var/multi = 1
							if(src.skill_super_speed && src.skill_super_speed.active) multi = src.mod_agility
							src.gain_stat("offence",1,20/multi,"Attacking in melee",1)
							src.gain_stat("strength",1,20/multi,"Attacking in melee",1)
							src.gain_stat("power",1,1/multi,"Attacking in melee",1)
							M.gain_stat("defence",1,20/multi,"Defending in melee",1)
							M.gain_stat("endurance",1,20/multi,"Taking melee damage",1)
							M.gain_stat("power",1,1/multi,"Taking melee damage",1)
					var/Evasion=src.evasion(src,M)//(src.psionic_power*(src.offence+(src.mod_agility*0.2)))/(M.psionic_power*(M.defence+(M.mod_agility*0.22)))
					if(Evasion)
						if(src.skill_touch_of_death && src.skill_touch_of_death.active)
							src.skill_touch_of_death.hits = 0
							call(src.skill_touch_of_death.act)(src,src.skill_touch_of_death)
							src.skill_cooldown(src.skill_touch_of_death)
						return
					else if(src.skill_touch_of_death && src.skill_touch_of_death.active)
						src.skill_touch_of_death.hits += 1
						M.flash_red()
						if(src.skill_touch_of_death.hits >= 5)
							src.skill_touch_of_death.hits = 0
							for(var/obj/body_related/bodyparts/torso/t in M.bodyparts)
								for(var/obj/body_related/bodyparts/torso/heart/h in t)
									M.damage_limb(src,0, 1, 100,h)
							call(src.skill_touch_of_death.act)(src,src.skill_touch_of_death)
							src.skill_cooldown(src.skill_touch_of_death)
					if(M.trait_cn) if(prob(10))
						return
					if(src.trait_ci) if(prob(25)) Damage*=1.5

					//Do the actual damage.
					M.percent_health -= Damage
					if(M.eating) M.cancel_eat()
					//for(var/mob/h in view(8,M))
						//h << sound(pick(hits),0,0,2,100)

					//Pick a random limb and damage it.
					M.damage_limb(src,1, 1, Damage) //Normal
					//M.damage_limb(src,1, 1, 100) //100%

					if(M.skill_sleep && M.skill_sleep.active) call(M.skill_sleep.act)(M,M.skill_sleep)

					if(M.client) M << output("[round(Damage,0.1)]% health removed from [src]'s melee attack.","chat.system")
					if(src.client) src << output("[round(Damage,0.1)]% health removed from [M].","chat.system")
					//M.dmg_nums("<font color = red>[round(Damage,0.1)]%")
					if(M.trait_aa) M.percent_energy += Damage/2
					if(M.grab)
						if(M.trait_ig == null) M.letgo()
						else if(prob(25)) M.letgo()
					if(M && src) //Do a check here because letgo() has the reconnect_power() proc inside it, which itself has sleep() calls inside it.
						if(M.target == src)
							if(M.remembers_strength && M.remembers_strength.Find(src.id) == 0) M.remembers_strength += src.id
							if(M.remembers_agility && M.remembers_agility.Find(src.id) == 0) M.remembers_agility += src.id
						if(src.target == M)
							if(src.remembers_endurance && src.remembers_endurance.Find(M.id) == 0) src.remembers_endurance += M.id
							if(src.remembers_agility && src.remembers_agility.Find(M.id) == 0) src.remembers_agility += M.id
							if(src.remembers_regeneration && src.remembers_regeneration.Find(M.id) == 0) src.remembers_regeneration += M.id
						if(M.icon_state=="kb") M.icon_state=M.state()
						if(M != src && src.mod_str_usage > 0.5)
							var/kb_mod = (100-M.percent_health)/2
							M.KB=round(Damage+kb_mod)
							if(M.KB>50) M.KB=50
							if(M.KB > 5)
								if(M.KB_furrow == 0)
									//if(M.loc)
										/*
										var/turf/t = M.loc
										if(t.liquid == null)
											if(!M.skill_flight || M.skill_flight && M.skill_flight.active == 0)
												if(!M.skill_levitation || M.skill_levitation && M.skill_levitation.active == 0)
													for(var/mob/h in view(12,M))
														h << sound('rumble.mp3',0,0,13,100)
										*/
									new /obj/effects/shockwave_small (M.loc)
									var/obj/effects/hit/h = new
									h.loc = src.loc
									h.dir = src.dir
									if(src.dir == SOUTH ||src.dir == NORTH) h.pixel_x += 16
									h.step_x = src.step_x
									h.step_y = src.step_y
									var/KB_dir = src.dir//get_dir(src.loc,M.loc)
									//KB_dir = src.dir
									M.KB_furrow = 1
									M.dir = KB_dir
									M.KnockBack(KB_dir)
							else M.KB = 0 //Not far enough to make them slide back, so reset it to avoid them not being able to be attacked again.
							if(M.koed == 0) M.icon_state=M.state()
							if(M.KB == 0)
								M.dir = get_dir(M,src)
								//Reset rumble noise from knockback, but first check nobody else is being knocked back first.
								var/list/mobs = list()
								var/found_kb = 0
								for(var/mob/h in view(12,M))
									mobs += h
									if(h.KB > 0) found_kb = 1
								if(found_kb == 0)
									for(var/mob/h in mobs)
										h << sound(null,channel = 13)

							//Check if enemy is koed by attack, or harmed if they are already koed
							if(M.percent_health < 0) M.KO()
					/*
					if(src.super_jumps)
						var/list/turfs = list()
						for(var/turf/t in view(8,src))
							turfs += t
						src.speed_image(pick(turfs))
					*/
					return
			else// if(src.can_attack >= 1)
				for(var/obj/items/i in get_step(src,src.dir))
					if(bounds_dist(src,i) <= 16 && i.invul_melee == 0)
						//Set the can_attack to 0, and set it on a cd based on speed
						src.energy -= 1
						flick(pick("punch","kick"),src)
						//world << "[src] Attacked [i]"
						i.flash_red()
						i.shake()
						var/dmg = src.strength/2
						i.hp -= dmg
						if(istype(i,/obj/items/tech/Black_Hole_Generator))
							var/obj/items/tech/Black_Hole_Generator/b = i
							b.Activate()
						if(i.hp <= 0)
							if(i.type == /obj/items/tech/Gravity_Machine)
								var/obj/items/tech/Gravity_Machine/gm = i
								gm.turn_off()
							if(i.type == /obj/items/tech/Power_Line)
								var/obj/items/tech/Power_Line/p = i
								p.check_connections()
							i.destroy()
						break
			/*
			for(var/obj/items/O in get_step(src,dir))
				src.can_attack = 0
				spawn(src.attack_rate)
					if(src) src.can_attack = 1
				src.energy-=1
				flick("punch",src)
				var/dmg = src.strength/2
				O.hp -= dmg
				O.shake()
				if(O.hp <= 0)
					del(O)
				break
			*/
		rsc_nums(var/txt)
			for(var/obj/effects/over_displays/dmg_num/dn in global.rsc_nums)
				if(dn.loc == null)
					dn.loc = src.loc
					dn.stay_with = src
					dn.maptext = "[txt]"
					animate(dn, pixel_y = 112, time = 15)
					dn.remove()
					dn.activate()
					break
		charge_nums(var/txt)
			for(var/obj/effects/over_displays/dmg_num/dn in global.charge_nums)
				if(dn.loc == null)
					dn.loc = src.loc
					dn.stay_with = src
					dn.maptext = "[txt]"
					animate(dn, pixel_y = 112, time = 10)
					dn.remove()
					dn.activate()
					break
		dmg_nums(var/txt)
			return
			for(var/obj/effects/over_displays/dmg_num/dn in global.dmg_nums)
				if(dn.loc == null)
					dn.loc = src.loc
					dn.stay_with = src
					dn.maptext = "[css_outline][txt]"
					animate(dn, pixel_y = 96, time = 10)
					dn.remove()
					dn.activate()
					break
		state()
			if(src.started || src.client == null)
				//world << "DEBUG - [src] has started or isn't a client."
				var/return_state = ""
				var/flying = null
				var/attack = null
				if(src.skill_flight && src.skill_flight.active) flying = "fly"
				if(src.skill_levitation && src.skill_levitation.active) flying = "levitate"
				if(src.current_attack && src.current_attack.active && src.active_attack) attack = src.current_attack.attack_state
				if(src.submerged) flying = "fly"

				if(flying)
					if(attack) return_state = "fly [attack]"
					else if(src.grab) return_state = "fly beam"
					else return_state = flying
				else if(attack) return_state = "[attack]"
				else if(src.grab) return_state = "beam"
				if(src.KB) return_state = "kb"
				if(src.koed) return_state = "ko"
				return return_state