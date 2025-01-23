atom
	proc
		destroy()
			if(ismovable(src))
				var/atom/movable/o = src
				for(var/obj/x in o)
					if(x.can_pocket)
						x.loc = o.loc
						x.step_x = o.step_x
						x.step_y = o.step_y
					else x.destroy()
				if(ismob(o.loc))
					var/mob/m = o.loc
					if(o == m.item_selected) m.item_selected = null
					if(o == m.mouse_down) m.mouse_down = null
					if(o == m.mouse_over) m.mouse_over = null
					if(o == m.left_click_ref) m.left_click_ref = null
					if(o == m.right_click_ref) m.right_click_ref = null
				else if(ismob(src))
					var/mob/m = src
					m.ref = null
					m.target = null
				else if(isobj(o))
					var/obj/ob = o
					ob.on = 0
				o.Move(null)
				o.loc = null
				o.used_by = null
				o.tag = null
				o.ki_owner = null
				o.owner = null
				o.particles = null
				o.vis_contents = null
			src.overlays = null
			src.underlays = null
			src.grabbed_by = null
			if(src.shadow)
				src.shadow.loc = null
				src.shadow = null
			if(src.reflection)
				src.reflection.loc = null
				src.reflection = null
			if(src in items) items -= src
		/*
		cleanse_all_vars()
			for(var/V in src.vars)
				var/atom/VV = src.vars[V]
				if(ismovable(VV))
					var/atom/movable/o = VV
					o.filters = null
					o.particles = null
					//world << "Found [o]"
					for(var/V2 in o.vars)
						var/atom/VV2 = o.vars[V2]
						if(ismovable(VV2))
							var/atom/movable/o2 = VV2
							//world << "Found2 [o2]"
							o2.filters = null
							o2.particles = null
		*/
		throwing(var/atom/dest,var/mob/thrower,var/degree,var/turf/t)
			var/atom/movable/A = src
			var/DIR = thrower.dir
			A.dir = DIR
			thrower.gain_stat("strength",1,1,"Throwing")
			thrower.gain_stat("power",1,2,"Throwing")
			var/DIST = round(get_dist(thrower,t)*3)
			if(tk) DIST = A.travel
			A.KB = DIST
			A.density_factor = 2
			A.thrown_str = thrower.strength*thrower.mod_str_usage
			A.thrown_offence = thrower.offence
			A.lobber = thrower
			if(A.weight > 1) A.KB_furrow = 1
			if(thrower.trait_pt)
				DIST*=2
				A.thrown_str*=2
			if(A.grabbed_by)
				var/mob/m = A.grabbed_by
				m.grab = null
				m.grab_part = null
				m.wrestle_stage = null
				A.grabbed_by = null
			while(A.KB)
				A.KB -= 1
				if(ismob(A))
					var/mob/M = A
					M.icon_state = "kb"
				A.MoveAngInstant(degree,12,0,0,t)
				//A.density_factor = 2
				if(A.KB == round(DIST/2)) animate(A, pixel_z = 0, time = 1)
				if(A.KB < round(DIST/2)) if(A.weight) A.dust_and_furrows()
				sleep(0.1)
			if(A.pixel_z > 0) animate(A, pixel_z = 0, time = 1)
			A.lobber = null
			if(ismob(src))
				var/mob/M = src
				M.icon_state = M.state()
				M.set_shadow()
				M.layer = MOB_LAYER + M.laymod - (M.y + M.step_y / 32) / world.maxy
				if(M.skill_flight && M.skill_flight.active) M.density_factor = initial(M.density_factor)
				else if(M.skill_levitation && M.skill_levitation.active) M.density_factor = initial(M.density_factor)
			else
				src.density_factor = initial(src.density_factor)
				if(istype(src,/obj/items/tech/))
					for(var/obj/items/tech/Power_Line/p in src.loc)
						p.reconnect_power()
				if(src.loc && isturf(src.loc))
					var/turf/trf = src.loc
					if(trf.liquid) src.submerge(1,5,trf)
			/*
			while(src.pixel_z > 0)
				//src.dust_and_furrows()
				var/z_remove = rand(1,2)
				animate(src, pixel_z = src.pixel_z-z_remove, time = 0.1)
				//step(src,src.dir,8)
				src.MoveAngInstant(degree,6,0,0,t)
				sleep(0.1)
			*/
		submerge(var/go_under,var/t,var/turf/L)
			if(go_under)
				var/a = 100;
				if(L.liquid == "psionic") a = 255
				else
					src << sound(null,channel = 8)
					//src << sound('underwater.mp3',1,0,6,100)
				src.submerged = 1
				src.underlays -= src.reflection
				if(src.reflection) src.reflection.loc = null
				if(ismob(src))
					var/mob/m = src
					if(m.started)
						if(L.liquid != "psionic")
							if(m.skill_invis)
								if(m.skill_invis.active == 0) animate(m, alpha = a,pixel_z = -15, time = t)
							else animate(m, alpha = a,pixel_z = -15, time = t)
						m.icon_state = m.state()
				else
					animate(src, alpha = a,pixel_z = -15, time = t,flags = ANIMATION_PARALLEL)

				if(src.shadow) src.shadow.alpha = 0
				return
			else
				src << sound(null,channel = 6)
				//if(src.z == 2 || src.z == 6) src << sound('wind.mp3',1,0,8,40)
				src.underlays -= src.reflection
				src.underlays += src.reflection
				src.submerged = 0
				if(src.shadow) src.shadow.alpha = 255
				if(ismob(src))
					var/mob/m = src
					if(m.started)
						m.icon_state = m.state()
						if(m.client)
							if(m.endurance_sources) m.endurance_sources -= "Underwater pressure"
							if(m.power_sources) m.power_sources -= "Underwater pressure"
							m.client.images -= m.bar_o2
						if(L.liquid != "psionic")
							if(m.skill_invis)
								if(m.skill_invis.active == 0) animate(m, alpha = 255,pixel_z = 0, time = t)
							else animate(m, alpha = 255,pixel_z = 0, time = t)
				else animate(src, alpha = 255,pixel_z = 0, time = t,flags = ANIMATION_PARALLEL)
				return
		bounce()
			var/turf/t = src.loc
			for(var/obj/items/tech/x in t)
				if(x != src) if(istype(src,/obj/items/tech/)) if(!istype(x,/obj/items/tech/Power_Line)) if(!istype(x,/obj/items/tech/Canister))
					var/obj/o = src
					var/list/turfs = list()
					for(var/turf/t2 in orange(1,o))
						turfs += t2
					o.loc = pick(turfs)
					if(o.shadow) o.shadow.loc = o.loc
		/*
		lift_delay_proc()
			spawn(0.1)
				if(src) src.lift_delay = 0
		*/
		flash_red()
			if(src.flashing == 0)
				src.flashing = 1;
				animate(src,color = "red", time = 2,flags = ANIMATION_PARALLEL)
				animate(color = null, time = 2)
				spawn(8)
					if(src) src.flashing = 0;
		shake()
			if(src.shakes && src.shaking == 0)
				src.shaking = 1
				var/og_px = src.pixel_x
				animate(src, pixel_x = og_px+3, time = 1,flags = ANIMATION_PARALLEL)
				animate(pixel_x = og_px-3, time = 1)
				animate(pixel_x = og_px, time = 1)

				if(src.shadow)
					animate(src.shadow, pixel_x = og_px+3, time = 1,flags = ANIMATION_PARALLEL)
					animate(pixel_x = og_px-3, time = 1)
					animate(pixel_x = og_px, time = 1)
				spawn(6)
					if(src) src.shaking = 0
		waves()
			var/start = filters.len
			var/i,f
			for(i=1, i<=WAVE_COUNT, ++i)
				filters += filter(type="wave", x=20, y=20, size=1, offset=1)
			for(i=1, i<=WAVE_COUNT, ++i)
				// animate phase of each wave from its original phase to phase-1 and then reset;
				// this moves the wave forward in the X,Y direction
				f = filters[start+i]
				animate(f, offset=f:offset, time=0, loop=-1, flags=ANIMATION_PARALLEL)
				animate(offset=f:offset-1, time=33)
		/*
		vibrate()
			var/x_og = src.pixel_x
			animate(src, pixel_x = x_og+3, time = 1,easing = ELASTIC_EASING)
			sleep(0.3)
			animate(src, pixel_x = x_og, time = 1,easing = ELASTIC_EASING)
			sleep(0.3)
			animate(src, pixel_x = x_og-3, time = 1,easing = ELASTIC_EASING)
			sleep(0.3)
			animate(src, pixel_x = x_og, time = 1,easing = ELASTIC_EASING)
		*/
		levitate()
			var/Z = src.pixel_z
			animate(src,pixel_z = Z+10, time = 10)
			spawn(10)
				animate(src,pixel_z = Z, time = 10)
				spawn(10)
					src.levitate()
		cloud_circle()
			set background = 1
			var/atom/movable/a = src
			var/list/wave_one = list()
			var/list/wave_two = list()
			var/list/wave_three = list()
			var/list/wave_four = list()
			var/list/all_dusts = list()
			var/obj/cs = new
			cs.icon = 'fx_lightning_shadow.dmi'
			cs.appearance_flags = KEEP_TOGETHER
			cs.loc = a.loc
			cs.step_x = a.step_x
			cs.step_y = a.step_y+170
			cs.layer = 10
			animate(cs,pixel_y = cs.pixel_y + 1, time = 20, loop = -1)
			animate(pixel_y = cs.pixel_y - 1, time = 20)

			src.icon_state = "meditate"
			animate(src,pixel_y = cs.pixel_y + 2, time = 20, loop = -1)
			animate(pixel_y = cs.pixel_y - 4, time = 20)

			var/obj/shad = new
			shad.icon = 'fx_shadow_player.dmi'
			shad.loc = a.loc
			shad.step_x = a.step_x
			shad.step_y = a.step_y
			shad.bolted = 2


			if(ismob(a))
				var/mob/m = a
				m.stunned += 1
				m.stunned_pending += 1

				var/steps = 144
				while(steps)
					steps -= 1
					step(a,NORTH,2)
					sleep(0.1)
				spawn(80)
					if(m)
						steps = 144
						while(steps)
							steps -= 1
							step(a,SOUTH,2)
							sleep(0.1)
						m.stunned -= 1
						m.stunned_pending -= 1
						animate(m)
						m.icon_state = ""
						if(shad) shad.destroy()

			var/p = 200
			while(p)
				if(prob(25))
					sleep(1)
				p -= 1;
				var/obj/pix = new
				pix.icon = 'fx_dust.dmi'
				pix.icon_state = "[pick(1,2,3,4,5,6,7,8)]"
				pix.loc = locate(a.x,a.y,a.z)
				pix.step_x = a.step_x
				pix.step_y = a.step_y
				pix.pixel_x = rand(-300,300)
				pix.pixel_y = rand(-200,-500)
				pix.bolted = 2
				animate(pix,pixel_x = 0, pixel_y = 0, time = rand(5,10), alpha = 0,loop = -1)
				animate(pixel_x = rand(-300,300), pixel_y = rand(-200,-500), time = 0, alpha = 255)
				all_dusts += pix

			a.shockwave()
			var/wave = 1
			while(wave)
				var/dusts = 120
				var/deg = 360
				while(dusts)
					for(var/obj/effects/dust/d in global.dusts)
						if(d.loc == null)
							d.SetCenter(src)
							d.loc = locate(a.x,a.y,a.z)
							d.step_x = a.step_x
							d.step_y = a.step_y-12
							//d.pixel_x = -36
							//d.pixel_y = 12
							d.icon = 'fx_dust.dmi'
							var/px = cos(deg)
							var/py = sin(deg)
							animate(d, pixel_x = px*120, pixel_y = py*60, time = 5)
							animate(d,pixel_y = d.pixel_y + 2, time = 20, loop = -1, flags = ANIMATION_PARALLEL)
							animate(pixel_y = d.pixel_y - 4, time = 20)
							wave_one += d
							spawn(1000)
								if(d)
									d.pixel_y = 0
									d.pixel_x = -20
									d.alpha = 255
									d.loc = null
									d.layer = 3
							break
					dusts -= 1
					deg -= 3
				wave -= 1

			var/icon/I = icon(cs.icon)
			for(var/obj/c in wave_one)
				var/icon/I_C = icon(c.icon,c.icon_state)
				I.Blend(I_C,ICON_OVERLAY,300+c.pixel_x,300+c.pixel_y)
			cs.icon = I
			cs.icon -= rgb(255,255,255)
			cs.alpha = 100
			cs.pixel_x = -300
			cs.pixel_y = -500

			sleep(5)

			wave = 1

			a.shockwave()
			while(wave)
				var/dusts = 140
				var/deg = 360
				while(dusts)
					for(var/obj/effects/dust/d in global.dusts)
						if(d.loc == null)
							d.SetCenter(src)
							d.loc = locate(a.x,a.y,a.z)
							d.step_x = a.step_x
							d.step_y = a.step_y-12
							d.icon = 'fx_dust.dmi'
							var/px = cos(deg)
							var/py = sin(deg)
							animate(d, pixel_x = px*200, pixel_y = py*100, time = 6)
							animate(d,pixel_y = d.pixel_y + 2, time = 20, loop = -1, flags = ANIMATION_PARALLEL)
							animate(pixel_y = d.pixel_y - 4, time = 20)
							wave_two += d
							spawn(995)
								if(d)
									d.pixel_y = 0
									d.pixel_x = -20
									d.alpha = 255
									d.loc = null
									d.layer = 3
							break
					dusts -= 1
					deg -= 3
				wave -= 1

			for(var/obj/c in wave_two)
				var/icon/I_C = icon(c.icon,c.icon_state)
				I.Blend(I_C,ICON_OVERLAY,300+c.pixel_x,300+c.pixel_y)
			cs.icon = I
			cs.icon -= rgb(255,255,255)
			cs.alpha = 100
			cs.pixel_x = -300
			cs.pixel_y = -500

			sleep(6)

			wave = 1

			a.shockwave()
			while(wave)
				var/dusts = 200
				var/deg = 360
				while(dusts)
					for(var/obj/effects/dust/d in global.dusts)
						if(d.loc == null)
							d.SetCenter(src)
							d.loc = locate(a.x,a.y,a.z)
							d.step_x = a.step_x
							d.step_y = a.step_y-12
							d.icon = 'fx_dust.dmi'
							var/px = cos(deg)
							var/py = sin(deg)
							animate(d, pixel_x = px*250, pixel_y = py*150, time = 7)
							animate(d,pixel_y = d.pixel_y + 2, time = 20, loop = -1, flags = ANIMATION_PARALLEL)
							animate(pixel_y = d.pixel_y - 4, time = 20)
							wave_three += d
							spawn(989)
								if(d)
									d.pixel_y = 0
									d.pixel_x = -20
									d.alpha = 255
									d.loc = null
									d.layer = 3
							break
					dusts -= 1
					deg -= 3
				wave -= 1

			for(var/obj/c in wave_three)
				var/icon/I_C = icon(c.icon,c.icon_state)
				I.Blend(I_C,ICON_OVERLAY,300+c.pixel_x,300+c.pixel_y)
			cs.icon = I
			cs.icon -= rgb(255,255,255)
			cs.alpha = 100
			cs.pixel_x = -300
			cs.pixel_y = -500

			sleep(7)

			wave = 1

			a.shockwave()
			while(wave)
				var/dusts = 250
				var/deg = 360
				while(dusts)
					for(var/obj/effects/dust/d in global.dusts)
						if(d.loc == null)
							d.SetCenter(src)
							d.loc = locate(a.x,a.y-1,a.z)
							d.step_x = a.step_x
							d.step_y = a.step_y+14
							d.icon = 'fx_dust.dmi'
							var/px = cos(deg)
							var/py = sin(deg)
							animate(d, pixel_x = px*300, pixel_y = py*200, time = 8)
							animate(d,pixel_y = d.pixel_y + 2, time = 20, loop = -1, flags = ANIMATION_PARALLEL)
							animate(pixel_y = d.pixel_y - 4, time = 20)
							wave_four += d
							spawn(982)
								if(d)
									d.pixel_y = 0
									d.pixel_x = -20
									d.alpha = 255
									d.loc = null
									d.layer = 3
							break
					dusts -= 1
					deg -= 3
				wave -= 1

			sleep(8)

			for(var/obj/c in wave_four)
				var/icon/I_C = icon(c.icon,c.icon_state)
				I.Blend(I_C,ICON_OVERLAY,300+c.pixel_x,300+c.pixel_y)
			cs.icon = I
			cs.icon -= rgb(255,255,255)
			cs.alpha = 100
			cs.pixel_x = -300
			cs.pixel_y = -500

			spawn(974)
				if(cs)
					cs.destroy()
					for(var/obj/o in all_dusts)
						all_dusts -= o
						o.destroy()
		shockwave_huge()
			var/obj/effects/dust_medium/d_m = new
			d_m.SetCenter(src)
			var wave = 1
			while(wave)
				var/dusts = 140
				var/deg = 360
				while(dusts)
					for(var/obj/effects/dust/d in global.dusts)
						if(d.loc == null)
							d.SetCenter(src)
							if(src.loc.tmp_dmg < 0 && prob(50)) d.icon = 'fx_dust.dmi'
							else if(src.loc.tmp_dmg > 0 || istype(src.loc,/turf/lava_cooled)) d.icon = 'fx_ash.dmi'
							else d.icon = 'fx_dust_dirt.dmi'
							var/px = cos(deg)
							var/py = sin(deg)
							var/multi = 320
							animate(d, pixel_x = px*400, pixel_y = py*multi,alpha = 0, time = 10)
							spawn(10)
								if(d)
									d.pixel_y = 0
									d.pixel_x = -20
									d.alpha = 255
									d.loc = null
									d.layer = 3
							break
					dusts -= 1
					deg -= 3
				wave -= 1
		shockwave_inverse(var/extra = 0)
			var/obj/effects/shockwave_inverse/b = new
			if(isturf(src)) b.loc = src
			else b.loc = src.loc
			if(isobj(src) || ismob(src))
				var/atom/movable/x = src
				b.SetCenter(x)
				b.step_y += 10
				b.step_y += extra
			//b.transform *= 0.1
			animate(b, transform = matrix()*0.1, alpha = 0, time = 9)
			spawn(9)
				if(src && b)
					b.destroy()
		shockwave(var/extra = 0)
			//Normal shockwave 1st
			var/obj/effects/shockwave_medium/b = new
			if(isturf(src)) b.loc = src
			else b.loc = src.loc
			if(isobj(src) || ismob(src))
				var/atom/movable/x = src
				b.SetCenter(x)
				b.step_y += 10
				b.step_y += extra
			b.transform *= 0.1
			animate(b, transform = matrix()*1, alpha = 0, time = 3)
			/*
			//Water shockwave 1st
			var/obj/effects/ripple_water/w = new
			if(isturf(src)) w.loc = src
			else w.loc = src.loc
			if(isobj(src) || ismob(src))
				var/atom/movable/x = src
				w.SetCenter(x)
				w.step_y += 10
				w.step_y += extra
			w.transform *= 0.1
			animate(w, transform = matrix()*3, alpha = 0, time = 3)
			*/
			spawn(3)
				if(src && b)
					b.destroy() //del(b)
					/*
					var/obj/effects/shockwave_medium/b2 = new
					if(isturf(src)) b2.loc = src
					else b2.loc = src.loc
					if(isobj(src) || ismob(src))
						var/atom/movable/x = src
						b2.SetCenter(x)
						b2.step_y += 10
						b2.step_y += extra
						b2.transform *= 0.1
					animate(b2, transform = matrix()*1.25, alpha = 0, time = 3)
					if(b) b.destroy() //del(b)
					b.destroy() //del(b2)
					*/
		creation()
			var/turf/t1 = locate(src.x-1,src.y-1,src.z)
			var/turf/t2 = locate(src.x,src.y-1,src.z)
			var/turf/t3 = locate(src.x+1,src.y-1,src.z)
			var/turf/t4 = locate(src.x-1,src.y,src.z)
			var/turf/t6 = locate(src.x+1,src.y,src.z)
			var/turf/t7 = locate(src.x-1,src.y+1,src.z)
			var/turf/t8 = locate(src.x,src.y+1,src.z)
			var/turf/t9 = locate(src.x+1,src.y+1,src.z)
			if(t1)
				t1.overlays = null
				t1.overlays += /turf/dirts/dirt1
			if(t2)
				t2.overlays = null
				t2.overlays += /turf/dirts/dirt2
			if(t3)
				t3.overlays = null
				t3.overlays += /turf/dirts/dirt3
			if(t4)
				t4.overlays = null
				t4.overlays += /turf/dirts/dirt4
			if(t6)
				t6.overlays = null
				t6.overlays += /turf/dirts/dirt6
			if(t7)
				t7.overlays = null
				t7.overlays += /turf/dirts/dirt7
			if(t8)
				t8.overlays = null
				t8.overlays += /turf/dirts/dirt8
			if(t9)
				t9.overlays = null
				t9.overlays += /turf/dirts/dirt9
		wave_effect()
			//src.filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=1, color=rgb(102,0,0))
			//src.filters += filter(type="motion_blur", x=1, y=0)
			var/start = filters.len
			var/i,f
			for(i=1, i<=WAVE_COUNT, ++i)
				/*
				// choose a wave with a random direction and a period between 10 and 30 pixels
				do
					X = 60*rand() - 30
					Y = 60*rand() - 30
					rsq = X*X + Y*Y
				while(rsq<100 || rsq>900)
				// keep distortion small, from 0.5 to 3 pixels
				// choose a random phase
				*/
				filters += filter(type="wave", x=20, y=20, size=1, offset=1)
			for(i=1, i<=WAVE_COUNT, ++i)
				// animate phase of each wave from its original phase to phase-1 and then reset;
				// this moves the wave forward in the X,Y direction
				f = filters[start+i]
				animate(f, offset=f:offset, time=0, loop=-1, flags=ANIMATION_PARALLEL)
				animate(offset=f:offset-1, time=33)
		explosion_small()
			var/obj/o_dust = new
			if(isturf(src)) o_dust.loc = src
			else if(ismovable(src))
				var/atom/movable/a = src
				o_dust.loc = a.loc
				o_dust.step_x = a.step_x
				o_dust.step_y = a.step_y
			o_dust.layer = 201
			o_dust.bolted = 2
			var/snow = 0
			if(isturf(src))
				var/turf/t = src
				if(t.tmp_dmg < 0) snow = 1
			else if(ismovable(src))
				if(src.loc)
					var/turf/t = src.loc
					if(t.tmp_dmg < 0) snow = 1
			if(snow) o_dust.particles = new/particles/explosion_dust_snow_small
			else o_dust.particles = new/particles/explosion_dust_dirt_small
			sleep(1)
			if(o_dust && o_dust.particles) o_dust.particles.spawning = 0
			spawn(15)
				if(o_dust && o_dust && o_dust.particles)
					o_dust.particles = null
					o_dust.loc = null
		waves_slow()
			var/start = filters.len
			var/i,f
			for(i=1, i<=WAVE_COUNT, ++i)
				filters += filter(type="wave", x=20, y=20, size=1, offset=1)
			for(i=1, i<=WAVE_COUNT, ++i)
				// animate phase of each wave from its original phase to phase-1 and then reset;
				// this moves the wave forward in the X,Y direction
				f = filters[start+i]
				animate(f, offset=f:offset, time=0, loop=-1, flags=ANIMATION_PARALLEL)
				animate(offset=f:offset-1, time=33)
		getCircle(turf/origin,radius)
			var/ox = origin.x, oy = origin.y, oz = origin.z
			var/lx = max(ox-radius,1), hx = min(ox+radius,world.maxx)
			var/ly = max(oy-radius,1), hy = min(oy+radius,world.maxy)
			var/list/turfs = block(locate(lx,ly,oz),locate(hx,hy,oz))
			lx -= ox
			hx -= ox
			ly -= oy
			hy -= oy
			var/list/l = list()
			var/mdist = radius*radius, count = 1, x, y
			for(y in hy to ly step -1)
				for(x in hx to lx step -1)
					if(x*x + y*y<=mdist)
						l += turfs[count++]
					else
						count++
			return l
		explosion(var/spins = 7)
			if(spins > 7) spins = 7
			var/turf/LOC
			if(isturf(src)) LOC = src
			else if(src.loc) LOC = src.loc
			if(LOC == null) return

			if(LOC.z == 3 || LOC.z == 6 || LOC.z == 7 || LOC.z == 8)
				var/list/turfs = getCircle(LOC,spins)
				for(var/turf/stone_roof/t in turfs)
					t.set_destroyed()
					for(var/obj/map/cliffs/c in t)
						c.destroy()
					for(var/obj/map/cliffs/c in locate(t.x,t.y-1,t.z))
						c.destroy()
				world.edges_solid_rock(LOC.x-(spins+1),LOC.y+(spins+1),LOC.x+(spins+1),LOC.y-(spins+1),LOC.z)

			//for(var/mob/h in view(8,LOC))
				//h << sound('explosion2.mp3',0,0,4,100)
			var/obj/effects/shockwave_medium/b = new
			b.loc = LOC
			b.pixel_x -= 79
			b.pixel_y -= 79
			b.transform *= 0.1
			animate(b, transform = matrix()*1, alpha = 0, time = 3)

			var/obj/effects/dust_medium/wav = new
			wav.SetCenter(LOC)

			if(spins > 0.5)
				var/obj/o_fire = new
				o_fire.loc = LOC
				o_fire.layer = 202
				o_fire.bolted = 2
				o_fire.particles = new/particles/fire_particles

				var/obj/o_dust = new
				o_dust.loc = LOC
				o_dust.layer = 201
				o_dust.bolted = 2
				if(LOC.tmp_dmg < 0) o_dust.particles = new/particles/explosion_dust_snow
				else if(LOC.tmp_dmg > 0 || istype(LOC,/turf/lava_cooled)) o_dust.particles = new/particles/explosion_ash
				else o_dust.particles = new/particles/explosion_dust_dirt

				src.shockwave_huge()

				if(spins >= 1.5)
					if(LOC)
						var/turf/x = LOC
						if(x.liquid == null)
							var/obj/effects/craters/crater_medium/c = new
							c.pixel_x = -64
							c.loc = LOC
							c.transform *= 0.1
							animate(c, transform = matrix()*1, time = 3)
				else if(LOC)
					var/turf/x = LOC
					if(x.liquid == null)
						var/obj/effects/craters/crater_small/c = new
						c.pixel_x = -8
						c.pixel_y = -8
						c.loc = LOC

				src.shockwave_huge()
				sleep(2)

				if(LOC && LOC.z != 3 && LOC.z != 6 && LOC.z != 7 && LOC.z != 8)
					//var/turf/tt = LOC
					if(LOC.liquid == null)
						var/obj/effects/furrow/ff = furrows[1]
						furrows -= ff
						ff.loc = LOC
						if(istype(ff.loc,/turf/lava_cooled) || istype(ff.loc,/turf/lava_cooling)) ff.icon = 'fx_furrow_ash_large.dmi'
						else if(istype(ff.loc,/turf/dirts/)) ff.icon = 'fx_furrow_dirt_large.dmi'
						spawn(600)
							ff.loc = null
							furrows += ff
							ff.icon = initial(ff.icon)
						var/obj/effects/furrow/ff2 = furrows[1]
						furrows -= ff2
						ff2.loc = LOC
						if(istype(ff2.loc,/turf/lava_cooled) || istype(ff2.loc,/turf/lava_cooling)) ff.icon = 'fx_furrow_ash_large.dmi'
						else if(istype(ff2.loc,/turf/dirts/)) ff2.icon = 'fx_furrow_dirt_large.dmi'
						ff2.pixel_x += 16
						spawn(600)
							ff2.loc = null
							furrows += ff2
							ff2.icon = initial(ff2.icon)
						var/obj/effects/furrow/ff3 = furrows[1]
						furrows -= ff3
						ff3.loc = LOC
						if(istype(ff3.loc,/turf/lava_cooled) || istype(ff3.loc,/turf/lava_cooling)) ff.icon = 'fx_furrow_ash_large.dmi'
						else if(istype(ff3.loc,/turf/dirts/)) ff3.icon = 'fx_furrow_dirt_large.dmi'
						ff3.pixel_x -= 16
						spawn(600)
							ff3.loc = null
							furrows += ff3
							ff3.icon = initial(ff3.icon)
					var/pix = 40
					var/deg_ring = 360
					var/obj/q = new
					q.loc = LOC
					while(spins)
						while(deg_ring)
							var/x=(pix+40)*(cos(deg_ring)); var/y=pix*(sin(deg_ring));
							var/movesx=round((x)/32);var/movesy=round((y)/32)
							x-=movesx*32; y-=movesy*32;
							var/turf/begin=locate(LOC.x+movesx,LOC.y+movesy,LOC.z)
							if(begin && begin.liquid) begin = null
							else if(begin)
								q.Move(begin,,x,y)
								var/obj/effects/furrow/f = furrows[1]
								furrows -= f
								f.loc = q.loc
								if(istype(f.loc,/turf/lava_cooled) || istype(f.loc,/turf/lava_cooling)) f.icon = 'fx_furrow_ash_large.dmi'
								else if(istype(f.loc,/turf/dirts/)) f.icon = 'fx_furrow_dirt_large.dmi'
								f.step_x = q.step_x
								f.step_y = q.step_y
								for(var/turf/t in f.locs)
									for(var/obj/items/plants/p in t)
										if(p.immune_dmg == 0)
											p.destroy()
									for(var/obj/items/consumables/cn in t)
										cn.destroy()
								spawn(600)
									f.loc = null;
									furrows += f;
									f.icon = initial(f.icon)
							deg_ring -= 10
						pix += 40
						deg_ring = 360
						spins -= 1
						sleep(0.1)
				sleep(1)
				if(o_dust && o_dust.particles) o_dust.particles.spawning = 0
				if(o_fire && o_fire.particles) o_fire.particles.spawning = 0
				spawn(15)
					if(o_dust && o_dust.particles)
						o_dust.particles = null
						o_dust.loc = null
					if(o_fire && o_fire.particles)
						o_fire.particles = null
						o_fire.loc = null
atom/movable
	proc
		set_shadow()
			//return
			src.hasreflect = 0
			if(src.hasreflect && src.loc && src.reflection == null)
				var/obj/r = new
				/*
				r.appearance = src.appearance
				var/matrix/m = matrix()
				m.Turn(-180)
				r.transform = m
				if(ismob(src))
					var/mob/m = src
					r.overlays -= m.halo;
				*/
				r.plane = -1
				//r.blend_mode = BLEND_MULTIPLY
				var/icon/I = new(src.icon)
				I.Shift(WEST,src.pixel_x)
				I.Flip(NORTH)
				r.icon = I
				r.icon += rgb(0,0,55)
				r.alpha = 200
				src.reflection = r
				r.pixel_x = src.pixel_x
				r.pixel_y = src.pixel_y
				r.pixel_y -= 34
				r.vis_flags = VIS_INHERIT_ICON_STATE | VIS_INHERIT_DIR
				r.filters = src.filters
				src.vis_contents += src.reflection
				//src.underlays += src.reflection
			if(src.shadow == null)
				if(src.hashadow)
					if(ismob(src))
						var/mob/m = src
						var/obj/s = new
						s.icon = 'fx_shadow_player.dmi'
						s.pixel_y = -4
						if(m.race == "Cerebroid") s.pixel_y = -12
						s.bounds = src.bounds
						s.step_size = src.step_size
						s.appearance_flags = LONG_GLIDE
						s.bolted = 2
						s.hp = 1.#INF
						src.shadow = s
						return
					else src.create_shadow()
			else
				src.shadow.loc = src.loc
				src.shadow.step_x = src.step_x
				src.shadow.step_y = src.step_y
				if(src.shadow.icon != 'fx.dmi')
					src.shadow.icon_state = src.icon_state
					src.shadow.dir = src.dir
		gravity_well()
			var/wait = 10;
			for(var/atom/movable/a in range(src.radius,src))
				if(a.bolted == 0)
					wait = 1;
					var/di = a.GetAngleStep(src.loc)
					a.MoveAng(di,2,0,0,null)
			spawn(wait)
				if(src) src.gravity_well()
		divine_field()
			spawn(10)
				if(src)
					while(src)
						for(var/mob/m in range(src.radius,src))
							m.gain_stat("divine",1,10,"World Tree")
							//m.divine_energy_max += 0.003*m.divine_energy_mod
							m.divine_energy += 0.01*m.divine_energy_mod
							if(islist(m.tutorials))
								var/obj/help_topics/H = m.tutorials[7]
								if(H.seen == 0)
									H.seen = 1
									H.skill_up(m)
							//spawn(10)
								//if(m) m.energy_sources -= "Soul Stream"
						sleep(10)
		energy_field()
			spawn(10)
				if(src)
					while(src)
						for(var/mob/m in range(src.radius,src))
							if(m.started)
								//m.gaining_energy = 1;
								//if(m.debuff_radiation && m.debuff_radiation.active == 0) call(m.debuff_radiation.act)(m,m.debuff_radiation)
								//if(m.percent_health > 10)
									//m.percent_health -= 1;
								m.gain_stat("energy",1,10,"Soul Stream",1)
								//spawn(10)
									//if(m) if(m.energy_sources && islist(m.energy_sources)) m.energy_sources -= "Soul Stream"
						sleep(10)
		rad_field()
			spawn(10)
				if(src)
					while(src)
						for(var/mob/m in range(src.radius,src))
							if(m.mod_immune_rads < 1 && m.has_body && m.afk == 0) //If not totally immune, apply some damage and debuffs.
								m.check_quest("tutorial_environmentals",1)
								m.check_quest("env_rads",1,1,1)
								m.in_rads = 2;
								if(m.debuff_radiation && m.debuff_radiation.active == 0) call(m.debuff_radiation.act)(m,m.debuff_radiation)
								if(m.percent_health > 10)
									var/dmg = 1-m.mod_immune_rads
									if(dmg > 0) m.percent_health -= dmg;
							if(m.percent_health > 10 && m != src) m.gain_stat("resistance",1,100,"Radiation",1)
						sleep(10)
		heat_field()
			spawn(10)
				if(src)
					while(src)
						for(var/mob/m in range(src.radius,src))
							if(m.tmp_dmg == 0) m.tmp_dmg = 1
						sleep(10)
		create_shadow()
			if(src.shadow == null)
				var/obj/shad = new
				shad.appearance_flags = TILE_BOUND
				var/icon/I = new(src.icon,src.icon_state,src.dir)
				I.icon -= rgb(255,255,255)
				shad.icon = I
				shad.alpha = 100
				shad.loc = src.loc
				shad.pixel_x = src.pixel_x
				shad.pixel_y = src.pixel_y
				shad.pixel_y = shad.pixel_y-(I.Height()/20)
				shad.layer = 2.1
				shad.bolted = 2
				shad.hp = 1.#INF
				src.shadow = shad
				del(I)
		reset_tk()
			src.filters -= filter(type="drop_shadow", x=0, y=0, size=5, offset=0, color=rgb(102,0,204))
			src.tk = 0
			animate(src, pixel_z = initial(src.pixel_z), time = 2, easing = BOUNCE_EASING)
			src.layer = initial(src.layer)
			src.density_factor = initial(src.density_factor)
			src.mouse_opacity = initial(src.mouse_opacity)
			src.tk = null
			//src.recycle()
			src.set_shadow()
		dust_and_furrows(var/n = rand(3,6))
			if(src.loc == null) return

			for(var/turf/x in range(1,src))
			//for(var/turf/x in bounds(src,0))
				if(x.liquid) return
				//for(var/turf/x2 in range(1,x))
					//if(x2.liquid) return
			var/turf/t = src.loc
			if(src.KB_furrow && furrow && t.furrowed <= 6)
				var/obj/o = furrow
				o.pixel_x = src.step_x
				o.pixel_y = src.step_y
				if(istype(t,/turf/grass)) o.icon = 'fx_furrow_grass.dmi'
				else if(istype(t,/turf/lava_cooled) || istype(t,/turf/lava_cooling)) o.icon = 'fx_furrow_ash.dmi'
				else o.icon = 'fx_furrow_dirt.dmi'
				t.overlays += o
				t.furrowed += 1
				t.furrow_remove()
			for(var/obj/items/plants/p in t)
				if(p.immune_dmg == 0)
					if(istype(p,/obj/items/plants/plant))
						p.destroy() //del(p)
					if(istype(p,/obj/items/plants/flower))
						p.destroy() //del(p)
			var/dust = n
			while(dust)
				dust -= 1
				var/X = rand(-16,16)
				var/Y = rand(50,100)
				for(var/obj/d in dusts)
					if(d.loc == null)
						d.loc = locate(t.x,t.y,t.z)
						//d.loc = src.loc
						if(t.tmp_dmg < 0 && prob(50)) d.icon = 'fx_dust.dmi'
						else if(istype(t,/turf/lava_cooled) || istype(t,/turf/lava_cooling)) d.icon = 'fx_ash.dmi'
						else d.icon = 'fx_dust_dirt.dmi'
						//d.pixel_x -= Width(src.icon)/3
						d.step_x = src.step_x //- Width(src.icon)/3
						d.step_y = src.step_y
						//if(Width(src.icon) > 32) d.pixel_x -= 32
						//if(src.dir == EAST || src.dir == WEST) d.pixel_y += 12
						animate(d, pixel_y = Y,pixel_x = X,alpha = 0, time = 20)
						/*
						spawn(10)
							d.layer = src.layer+1
						*/
						spawn(20)
							//d.pixel_x = rand(-10,10)
							if(d)
								d.pixel_y = 0
								d.alpha = 255
								d.loc = null
								d.layer = 3
						break


// is screen_loc a valid screen_loc?
atom/movable/proc/check_screen_loc()
	if(ScreenLocParser.Find(src.screen_loc))
		// just by calling regex.Find(), the regex.group variable now contains the relevant pieces:
		// (if any of the optional parts are missing, they'll be null here)
		//var map_id = ScreenLocParser.group[1]
		var tile_x = text2num(ScreenLocParser.group[2])
		var step_x = text2num(ScreenLocParser.group[3])
		var tile_y = text2num(ScreenLocParser.group[4])
		var step_y = text2num(ScreenLocParser.group[5])
		if(tile_x) src.screen_x = tile_x
		if(tile_y) src.screen_y = tile_y
		if(step_x) src.screen_step_x = step_x
		if(step_y) src.screen_step_y = step_y
		//world << "[map_id]:[tile_x]:[step_x],[tile_y]:[step_y]"

atom/movable/proc/set_screen_loc()
	if(src.screen_step_x || src.screen_step_x > 0)
		src.screen_step_x = ":[src.screen_step_x]"
	else src.screen_step_x = null
	if(src.screen_step_y || src.screen_step_y > 0)
		src.screen_step_y = ":[src.screen_step_y]"
	else src.screen_step_y = null
	src.screen_loc = "[src.screen_x][src.screen_step_x],[src.screen_y][src.screen_step_y]"