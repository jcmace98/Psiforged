obj
	proc
		microwave_field()
			var/obj/items/tech/Microwave_Generator/gm = src
			//Otherwise continue
			if(src.setting)
				for(var/turf/t in view(src.radius,src))
					t.microwaves = src.setting
					gm.trfs += t
					for(var/mob/m in t)
						m.microwaves = src.setting
		pulsate_field()
			var/obj/items/tech/Gravity_Machine/gm = src
			//If we're dealing with a black hole.
			var/hole = 0
			if(src.icon == 'blackhole.dmi')
				hole = 1
				src.setting = 1
			//Otherwise continue
			if(src.setting)
				if(hole == 0)
					if(gm.field == null)
						var/obj/effects/shield/o = new
						o.appearance_flags = PIXEL_SCALE
						gm.field = o
				var/obj/s = gm.field
				s.loc = src.loc
				s.step_x = src.step_x
				s.step_y = src.step_y
				//for(var/mob/m in range(src.radius,src))
				for(var/turf/t in view(src.radius,src))
					//if(bounds_dist(src, m) < round(src.radius*32))
					if(hole) src.setting = 100
					t.grav = src.setting
					gm.trfs += t
					for(var/mob/m in t)
						m.grav = src.setting
				//sleep(5)
				//animate(o, transform = matrix()*1, alpha = 0, time = 20)
		furrow_fade()
			for(var/obj/items/plants/p in src.loc)
				if(p.bolted) p.destroy()//del(p)
			animate(src,alpha = 0, time = 2000)
			spawn(2000)
				if(src)
					src.loc = null
					src.alpha = 255
		display_gain_reset()
			spawn(1)
				if(src)
					animate(src,pixel_y = src.pixel_y+48,alpha = 10,time=15)
					spawn(15)
						if(src) src.loc = null
		del_obj(var/time)
			spawn(time)
				if(src) del(src)
		remove_obj(var/time)
			spawn(time)
				if(src) src.loc = null
		create_css_ref(var/action,var/ref,var/txt,var/size = 1,var/align)
			//var/result = {"<style> a { color: white; text-decoration: none; } a:link { color: white; } a:hover { color: red; } </style> <a href='?src=\ref[ref];action=[action]'>[txt]</a>"}
			var/result = {"<style> body { font-size: [size]px; text-align: [align]; } a { color: white; text-decoration: none; } a:link { color: white; } a:hover { color: red; } </style><body><a href='?src=\ref[ref];action=[action]'>[txt]</a></body>"}
			return result
		create_stack_display()
			var/display = src.stacks
			if(src.stacks < 0) display = 1
			var/image/dis = image(null,src,null,src.layer+35,0)
			dis.appearance_flags = PIXEL_SCALE | KEEP_APART
			dis.maptext_width = 32
			dis.maptext_height = 32
			//dis.maptext_y = -18
			dis.maptext_x = -2
			dis.maptext = "[css_outline]<font size = 1><text align=right valign=bottom>[display]"
			src.stack_display = dis
		use_obj(var/mob/m)
			if(src.loc != null)
				src.stacks -= 1
				src.stack_display.maptext = "[css_outline]<font size = 1><text align=right valign=bottom>[src.stacks]"
				if(src.rarity >= 3) m.check_quest("needs_rare_food",1,0,1)
				if(src.stacks == 0 || src.stacks == -2)
					if(src.slot)
						if(m.hud_inv) m.hud_inv.vis_contents -= src
						if(src == m.item_selected)
							m.item_selected = null
							m.hud_inv.item_desc.maptext = null
						m.inv[src.slot] = null
						src.slot = -1
					src.destroy()
		apply_skillbar(var/mob/m,var/obj/skill, var/remove = 0)
			src.overlays = null
			if(skill)
				if(remove == 0)
					src.overlays += skill
					src.skill_taken = skill
					if(src.name == "1")
						m.one = list(skill)
					if(src.name == "2")
						m.two = list(skill)
					if(src.name == "3")
						m.three = list(skill)
					if(src.name == "4")
						m.four = list(skill)
					if(src.name == "5")
						m.five = list(skill)
					if(src.name == "6")
						m.six = list(skill)
					if(src.name == "7")
						m.seven = list(skill)
					if(src.name == "8")
						m.eight = list(skill)
					if(src.name == "9")
						m.nine = list(skill)
					if(src.name == "0")
						m.zero = list(skill)
					if(src.name == "-")
						m.minus = list(skill)
					if(src.name == "=")
						m.equal = list(skill)
				else
					src.skill_taken = null
					if(src.name == "1")
						m.one = null
					if(src.name == "2")
						m.two = null
					if(src.name == "3")
						m.three = null
					if(src.name == "4")
						m.four = null
					if(src.name == "5")
						m.five = null
					if(src.name == "6")
						m.six = null
					if(src.name == "7")
						m.seven = null
					if(src.name == "8")
						m.eight = null
					if(src.name == "9")
						m.nine = null
					if(src.name == "0")
						m.zero = null
					if(src.name == "-")
						m.minus = null
					if(src.name == "=")
						m.equal = null
		/*
		check_connection(var/delete = 0)
			var/obj/items/tech/the_bat = src
			var/list/bats = list()
			for(var/obj/items/tech/btry in the_bat.batteries)
				bats += btry
				for(var/obj/items/tech/lines in btry.connections)
					lines.batteries = new()
					lines.checked = new()
					//lines.overlays -= /obj/items/tech/flow
				btry.connections = new()
				if(delete) src.bolted = 0
			for(var/obj/items/tech/Battery/b in bats)
				b.check_power_lines("battery movement")
		check_power_lines(var/check_type = null)
			var/obj/items/tech/the_src = src
			if(check_type == "battery movement")
				for(var/obj/items/tech/Power_Line/p in range(1,src))
					if(bounds_dist(src, p) < 3)
						if(p.bolted) if(!src.grabbed_by) if(!src.tk) if(!p.checked.Find(src))
							p.checked += src
							p.batteries += src
							the_src.connections += p
							p.check_power_lines()
			else
				var/lines = list()
				for(var/obj/items/tech/Power_Line/p in locate(src.x+1,src.y,src.z))
					lines += p
				for(var/obj/items/tech/Power_Line/p in locate(src.x-1,src.y,src.z))
					lines += p
				for(var/obj/items/tech/Power_Line/p in locate(src.x,src.y+1,src.z))
					lines += p
				for(var/obj/items/tech/Power_Line/p in locate(src.x,src.y-1,src.z))
					lines += p
				for(var/obj/items/tech/o in lines)
					if(o.bolted)
						for(var/obj/items/tech/btry in the_src.batteries)
							if(!o.checked.Find(btry))
								o.batteries += btry
								o.checked += btry
								btry.connections += o
								o.overlays = null
								//o.overlays += /obj/items/tech/flow
								o.check_power_lines()
		*/
		/*
		check_belt(var/mob/m)
			var/obj/found_north = null
			var/obj/found_south = null
			var/obj/found_east = null
			var/obj/found_west = null
			for(var/obj/items/tech/Conveyor_Belt/p in locate(src.x+1,src.y,src.z))
				found_east = p
			for(var/obj/items/tech/Conveyor_Belt/p in locate(src.x-1,src.y,src.z))
				found_west = p
			for(var/obj/items/tech/Conveyor_Belt/p in locate(src.x,src.y+1,src.z))
				found_north = p
			for(var/obj/items/tech/Conveyor_Belt/p in locate(src.x,src.y-1,src.z))
				found_south = p
			if(found_north)
				if(m.dir == EAST)
					var/obj/o = new
					o.icon = 'conveyor_belt.dmi'
					o.icon_state = "bottom left east"
					o.layer = 4.9
					src.overlays += o
			if(found_west)
				if(m.dir == NORTH)
					var/obj/o = new
					o.icon = 'conveyor_belt.dmi'
					o.icon_state = "bottom right north"
					o.layer = 4.9
					src.overlays += o
			if(found_south)
				if(m.dir == WEST)
					var/obj/o = new
					o.icon = 'conveyor_belt.dmi'
					o.icon_state = "top right west"
					o.layer = 4.9
					src.overlays += o
			if(found_east)
				if(m.dir == SOUTH)
					var/obj/o = new
					o.icon = 'conveyor_belt.dmi'
					o.icon_state = "top left south"
					o.layer = 4.9
					src.overlays += o
		*/
		compress(var/mouse_side,var/mob/m,var/dist = 1,var/breaks = 1)
			if(mouse_side == "right") if(src in range(1,m)) if(isturf(src.loc))
				if(src.icon_state == "empty")
					var/turf/og_loc = m.loc
					for(var/obj/items/I in orange(dist,src))
						if(I.bolted == 0) if(I.type != src.type) if(I.legendary == 0)
							if(get_dist(m,og_loc) > 3)
								break
							var/den = I.density_factor
							I.density_factor = 0
							if(istype(I,/obj/items/tech/))
								for(var/turf/trf in I.locs)
									for(var/obj/items/tech/Power_Line/p in trf)
										spawn(2)
											if(p) p.reconnect_power()
							while(bounds_dist(I,src) > 0 && isturf(src.loc))
								step_towards(I,src,6)
								//I.step_x = src.step_x
								//I.step_y = src.step_y
								sleep(0.1)
							I.density_factor = den
							src.shockwave()
							var/obj/o = new
							o.icon = I.icon
							o.icon_state = I.icon_state
							o.layer = I.layer
							o.loc = src.loc
							o.overlays = I.overlays
							o.pixel_x = I.pixel_x
							o.pixel_y = I.pixel_y
							o.step_x = src.step_x
							o.step_y = src.step_y
							spawn(2)
								if(o) o.loc = null
							var/matrix/M = matrix()
							M.Scale(-1, -1)
							animate(o, transform = M, alpha = 0,pixel_y = o.pixel_y-16, time = 5)
							I.Move(src)
							if(I.shadow) I.shadow.loc = I.loc
							/*
							for(var/obj/x in line_checks)
								x.check_connection()
							*/
							src.icon_state = "full"
							if(breaks) break
				else
					var/create_dusts = 100
					var/make_smoke = 0
					for(var/obj/items/I in src)
						make_smoke = 1
						I.loc = src.loc
						I.set_shadow()
						if(istype(I,/obj/items/tech/))
							for(var/obj/items/tech/Power_Line/p in src.loc)
								p.reconnect_power()
					if(make_smoke)
						var/obj/effects/dust_rock_medium/x = new
						x.loc = src.loc
						x.step_x = src.step_x
						x.step_y = src.step_y
						while(create_dusts)
							create_dusts -= 1
							var/X = rand(-200,200)
							var/Y = rand(-200,200)
							var/t = rand(15,30)
							for(var/obj/d in smokes)
								d.pixel_x = -8
								d.loc = locate(src.x,src.y,src.z)
								d.step_x = src.step_x
								d.step_y = src.step_y
								animate(d, pixel_y = Y,pixel_x = X,alpha = 0, time = t)
								smokes -= d
								spawn(t)
									smokes += d
									d.pixel_x = -8
									d.pixel_y = -15
									d.alpha = 255
									d.loc = null
								break
						src.icon_state = "empty"
		explode_rock()
			if(src.suffix != "exploding")
				src.density_factor = 0
				src.suffix = "exploding"
				var/list/rocks = list()
				//CHECK_TICK
				sleep(1)
				src.icon = null
				if(src.shadow) del(src.shadow)
				for(var/obj/o in rocks)
					var/pixel_x_up = rand(-64,64)
					var/pixel_y_up = rand(0,96)
					animate(o, pixel_x = pixel_x_up,pixel_y = pixel_y_up, time = 3,easing = QUAD_EASING)
				//CHECK_TICK
				sleep(3)
				for(var/obj/o in rocks)
					var/pixel_y_down = rand(-32,0)
					animate(o, pixel_y = pixel_y_down, time = 3)
				//CHECK_TICK
				sleep(3)