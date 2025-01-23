obj
	//biome //placed inside players lists and activated once they step foot on this planet.
	/*
	proc
		power(var/list/params,var/mob/m)
			if(bounds_dist(src, m)  <= 10)
				if(params["left"])
					if(src.icon_state == "on")
						src.icon_state = "off"
						src.on = 0
						return
	*/
	/*
	interiors
		hp = 1.#INF
		block_halfdense
			density_factor = 1
			icon = 'red.dmi'
			layer = 100
			bolted = 2
			New()
				spawn(10)
					src.icon = null
		block_dense
			density_factor = 2
			icon = 'red.dmi'
			layer = 100
			bolted = 2
			New()
				spawn(10)
					src.icon = null
		ship_parts
			ship_core
				icon = 'ship_inside.dmi'
				icon_state = "core layer"
				pixel_x = -8
				layer = 4
				mouse_opacity = 0
			ship_chair
				icon = 'ship_inside.dmi'
				icon_state = "chair"
				pixel_x = -8
				layer = 4
				mouse_opacity = 0
			ship_console
				icon = 'ship_inside.dmi'
				icon_state = "console"
				pixel_x = -8
				Click()
					if(usr.open_ship == 0)
						if(usr in range(11,src))
							usr.open_ship = src
							winshow(usr,"ship",1)
							for(var/obj/items/tech/Ship/s in world)
								if(s.loc)
									usr.client.perspective = EYE_PERSPECTIVE | EDGE_PERSPECTIVE
									usr.client.eye = s
									usr.client.view += 5
					else
						usr.open_ship = 0
			ship_inside
				icon = 'ship_inside.dmi'
				icon_state = "inside"
				pixel_x = -8
				layer = 2
				mouse_opacity = 0
	*/
	warpers
		var/goes_x = null
		var/goes_y = null
		var/goes_z = null
		bolted = 2
		density = 0
		density_factor = 0
		opacity = 0
		tree_exit
			//icon = 'terrain.dmi'
			//icon_state = "blank"
			goes_x = 250
			goes_y = 254
			goes_z = 4
			//Enter(atom/movable/O, atom/oldloc)
			Cross(atom/movable/O)
				if(src.goes_x)
					O.loc = locate(src.goes_x,src.goes_y,src.goes_z)
					if(ismob(O))
						var/mob/M = O
						M << sound(null,channel = 9)
						if(M.ambients) M.ambients -= "yuk tree heart beat"
						if(M.client) M.apply_afterlife_glow(0)
		tree_entrance
			//icon = 'grass_yukopian.dmi'
			goes_x = 250
			goes_y = 256
			goes_z = 7
			//Enter(atom/movable/O, atom/oldloc)
			Cross(atom/movable/O)
				if(src.goes_x)
					O.loc = locate(src.goes_x,src.goes_y,src.goes_z)
					if(ismob(O))
						var/mob/M = O
						if(M.client) M.apply_afterlife_glow(0)
		cave_entrance_01
			icon = 'terrain.dmi'
			icon_state = "cave entrance"
			goes_x = 291
			goes_y = 43
			goes_z = 3
			//Enter(atom/movable/O, atom/oldloc)
			Cross(atom/movable/O)
				if(src.goes_x)
					O.loc = locate(src.goes_x,src.goes_y,src.goes_z)
					if(ismob(O))
						var/mob/M = O
						if(M.client) M.apply_afterlife_glow(0)
		cave_exit_01
			icon = 'cave_exit.dmi'
			goes_x = 291
			goes_y = 41
			goes_z = 1
			//Enter(atom/movable/O, atom/oldloc)
			Cross(atom/movable/O)
				if(src.goes_x)
					O.loc = locate(src.goes_x,src.goes_y,src.goes_z)
					if(ismob(O))
						var/mob/M = O
						if(M.client) M.apply_afterlife_glow(1)
		cave_entrance_02
			icon = 'terrain.dmi'
			icon_state = "door cliff 1"
			goes_x = 38
			goes_y = 203
			goes_z = 3
			//Enter(atom/movable/O, atom/oldloc)
			Cross(atom/movable/O)
				if(src.goes_x)
					O.loc = locate(src.goes_x,src.goes_y,src.goes_z)
					if(ismob(O))
						var/mob/M = O
						if(M.client) M.apply_afterlife_glow(0)
		cave_exit_02
			icon = 'cave_exit.dmi'
			goes_x = 38
			goes_y = 201
			goes_z = 1
			//Enter(atom/movable/O, atom/oldloc)
			Cross(atom/movable/O)
				if(src.goes_x)
					O.loc = locate(src.goes_x,src.goes_y,src.goes_z)
					if(ismob(O))
						var/mob/M = O
						if(M.client) M.apply_afterlife_glow(0)
		cave_entrance_03
			icon = 'terrain.dmi'
			icon_state = "cave entrance"
			goes_x = 146
			goes_y = 485
			goes_z = 3
			//Enter(atom/movable/O, atom/oldloc)
			Cross(atom/movable/O)
				if(src.goes_x)
					O.loc = locate(src.goes_x,src.goes_y,src.goes_z)
					if(ismob(O))
						var/mob/M = O
						if(M.client) M.apply_afterlife_glow(0)
		cave_exit_03
			icon = 'cave_exit.dmi'
			goes_x = 146
			goes_y = 483
			goes_z = 1
			//Enter(atom/movable/O, atom/oldloc)
			Cross(atom/movable/O)
				if(src.goes_x)
					O.loc = locate(src.goes_x,src.goes_y,src.goes_z)
					if(ismob(O))
						var/mob/M = O
						if(M.client) M.apply_afterlife_glow(0)
		cave_entrance_04
			icon = 'terrain.dmi'
			icon_state = "cave entrance"
			goes_x = 419
			goes_y = 358
			goes_z = 3
			//Enter(atom/movable/O, atom/oldloc)
			Cross(atom/movable/O)
				if(src.goes_x)
					O.loc = locate(src.goes_x,src.goes_y,src.goes_z)
					if(ismob(O))
						var/mob/M = O
						if(M.client) M.apply_afterlife_glow(0)
		cave_exit_04
			icon = 'cave_exit.dmi'
			goes_x = 419
			goes_y = 356
			goes_z = 1
			//Enter(atom/movable/O, atom/oldloc)
			Cross(atom/movable/O)
				if(src.goes_x)
					O.loc = locate(src.goes_x,src.goes_y,src.goes_z)
					if(ismob(O))
						var/mob/M = O
						if(M.client) M.apply_afterlife_glow(0)
		volcano_entrance_01
			icon = 'terrain.dmi'
			icon_state = "cave entrance"
			goes_x = 458
			goes_y = 163
			goes_z = 3
			//Enter(atom/movable/O, atom/oldloc)
			Cross(atom/movable/O)
				if(src.goes_x)
					O.loc = locate(src.goes_x,src.goes_y,src.goes_z)
					if(ismob(O))
						var/mob/M = O
						if(M.client) M.apply_afterlife_glow(0)
		volcano_exit_01
			icon = 'cave_exit.dmi'
			goes_x = 458
			goes_y = 161
			goes_z = 1
			//Enter(atom/movable/O, atom/oldloc)
			Cross(atom/movable/O)
				if(src.goes_x)
					O.loc = locate(src.goes_x,src.goes_y,src.goes_z)
					if(ismob(O))
						var/mob/M = O
						if(M.client) M.apply_afterlife_glow(0)
	effects
		bolted = 2
		density_factor = 0
		stunned
			icon = 'stunned.dmi'
			pixel_y = 8
			appearance_flags = KEEP_APART
		stack_num
			appearance_flags = PIXEL_SCALE
			vis_flags = VIS_INHERIT_ID | VIS_INHERIT_LAYER | VIS_INHERIT_PLANE
		inv_slot
			icon = 'inv_slot.dmi'
			alpha = 60
			appearance_flags = PIXEL_SCALE | KEEP_APART
			vis_flags = VIS_INHERIT_ID | VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_UNDERLAY
		eyes_white
			icon = 'humanoid_eyes_white.dmi'
			vis_flags = VIS_INHERIT_ICON_STATE | VIS_INHERIT_DIR | VIS_INHERIT_LAYER
			hasreflect = 0
			hashadow = 0
			//layer = 10
		eyes_iris
			icon = 'humanoid_eyes_iris.dmi'
			vis_flags = VIS_INHERIT_ICON_STATE | VIS_INHERIT_DIR | VIS_INHERIT_LAYER
			hasreflect = 0
			hashadow = 0
			//layer = 11
		eyes_lich
			icon = 'Lich_Eyes.dmi'
			appearance_flags = KEEP_APART
			hasreflect = 0
			hashadow = 0
			plane = 2
			/*
			New()
				src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
				src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
			*/
		eyes_focus
			icon = 'humanoid_eyes_iris_white.dmi'
			appearance_flags = KEEP_APART
			vis_flags = VIS_INHERIT_DIR | VIS_INHERIT_LAYER | VIS_INHERIT_ICON_STATE
			hasreflect = 0
			hashadow = 0
			New()
				src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 100)
				src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(51,203,247))
		eyes_focus_celestial
			icon = 'humanoid_eyes_iris_android.dmi'
			appearance_flags = KEEP_APART
			vis_flags = VIS_INHERIT_DIR | VIS_INHERIT_LAYER | VIS_INHERIT_ICON_STATE
			hasreflect = 0
			hashadow = 0
			New()
				src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 55)
				src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(255,255,255))
		eyes_divine
			icon = 'humanoid_eyes_iris_white.dmi'
			appearance_flags = KEEP_APART
			vis_flags = VIS_INHERIT_DIR | VIS_INHERIT_LAYER | VIS_INHERIT_ICON_STATE
			hasreflect = 0
			hashadow = 0
			New()
				src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 100)
				src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(255,204,0))
		eyes_wide
			icon = 'humanoid_eyes_iris_android.dmi'
			appearance_flags = KEEP_APART
			vis_flags = VIS_INHERIT_DIR | VIS_INHERIT_LAYER | VIS_INHERIT_ICON_STATE
			hasreflect = 0
			hashadow = 0
			New()
				src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 100)
				src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(51,203,247))

		offline
			icon = 'offline.dmi'
			layer = 20
			pixel_x = 4
			pixel_y = 4
			appearance_flags = KEEP_APART
		orb_dark
			icon = 'fx.dmi'
			icon_state = "orb"
			New()
				src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
				src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
		orb_divine
			icon = 'fx.dmi'
			icon_state = "orb"
			New()
				src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(255,255,170))
				src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
		orb
			icon = 'fx.dmi'
			icon_state = "orb"
			New()
				src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
				src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
			//plane = 1;
		wing_pixel
			icon = 'fx.dmi'
			icon_state = "pixel"
			appearance_flags = KEEP_TOGETHER
			vis_flags = VIS_INHERIT_ID | VIS_INHERIT_DIR
			//New()
				//src.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(102,204,255))
			var/timing = 0
			var/o_y = 0
			var/t_y = 0
		bubble
			icon = 'bubble.dmi'
			layer = 100
		txt
			maptext_width = 128
			maptext_height = 256
			maptext_y = 52
			layer = 30
		over_displays
			var/in_use = 0
			var/can_click = 0
			var/fading = 0
			lvl_up_overlay
				maptext_width = 500
				//maptext_width = 192
				maptext_height = 64
				maptext_x = -502
				maptext_y = 8
				layer = 30
				screen_loc = "32,18"
				MouseEntered(location,control,params)
					if(src.can_click)
						src.filters = filter(type="outline", size=1, color=rgb(255,255,255))
				MouseExited(location,control,params)
					if(src.can_click)
						src.filters = null
				Click(location,control,params)
					params = params2list(params)
					if(params["left"])
						if(src.help_text)
							if(usr.open_help == 0)
								usr.open_help = 1
								usr.open_menus.Add(".open_help")
								usr.client.screen += usr.hud_help
							var/obj/hud/menus/help_background/s = usr.hud_help
							var/obj/hud/menus/help_background/txt_raw/txt = s.txt_raw
							txt.maptext = "[css_outline]<font size = 1><text align=center valign=top><u>[src.name]</u>\n<text align=left valign=top>[src.help_text]"
							return
					if(params["right"])
						src.dismiss_alert(usr)
						return
				//filters = filter(type="outline", size=1, color=rgb(0,0,0))
			dmg_num
				pixel_y = 16
				maptext_x = 9
				maptext_width = 96
				maptext_height = 64
				filters = filter(type="outline", size=1, color=rgb(0,0,0))
				layer = 30
				var/mob/stay_with = null
				proc
					activate()
						if(src.loc && src.stay_with)
							src.loc = stay_with.loc
							src.step_x = stay_with.step_x
							src.step_y = stay_with.step_y
						else return
						spawn(1)
							if(src) src.activate()
					remove()
						spawn(10)
							if(src)
								loc = null
								alpha = 255
								pixel_y = 16
		minigames
			tk_ring
				icon = 'tk_ring.dmi'
				pixel_x = -48
				pixel_y = -60
				bounds = "-47,-59 to 112,100"
				layer = 101
				alpha = 50
				mouse_opacity = 0
				//transform = 0.5
				var/tmp/mob/tether = null
				New()
					..()
					spawn(1)
						src.transform *= 1.33
						src.filters += filter(type="drop_shadow", x=0, y=0,\
						size=5, offset=2, color=rgb(150,150,225))
		black_hole
			icon = 'black_hole.dmi'
			bounds = "17,17 to 48,48"
			var/mob/follow
			/*
			New()
				spawn(1)
					if(src) if(src.follow)
						while(src && src.follow)
							if(get_dist(src,src.follow) < 2)
								src.SetCenter(src.follow)
								src.step_y += 20
							sleep(0.1)
			*/
		aura
			icon = 'fx_aura_psionic.dmi'
			density_factor = 0
			density = 0
			alpha = 150
			plane = 3;
			layer = 10;
			pixel_x = -16
			pixel_y = -8
			New()
				src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
				src.filters += filter(type="motion_blur", x=1, y=0)
		lightning_bolt_psi_temp
			icon = 'fx_psi_lightening.dmi'
			layer = 12
			alpha = 255
			pixel_x = -55
			pixel_y = 20
			bolted = 2
			//plane = -1
			New()
				spawn(1)
					if(src)
						src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
						src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
						var/matrix/m = matrix()//*rand(0.1,1)
						var/s = rand(0.1,1)
						m.Scale(s, s)
						m.Turn(rand(0,360))
						src.transform = m
						src.alpha = 200
						src.icon_state = pick("3","4","5","6")
						sleep(8)
						if(src) animate(src,alpha = 0, time = 6)
						sleep(6)
						if(src) src.destroy()
		lightning_bolt_psi
			icon = 'fx_psi_lightening.dmi'
			layer = 12
			alpha = 255
			pixel_x = -55
			pixel_y = 20
			bolted = 2
			//plane = -1
			New()
				src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
				src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
				var/matrix/m = matrix()//*rand(0.1,1)
				var/s = rand(0.1,1)
				m.Scale(s, s)
				m.Turn(rand(0,360))
				src.transform = m
				src.alpha = 200
				spawn(rand(10,100))
					if(src)
						while(src)
							src.icon_state = pick("3","4","5","6")
							sleep(8)
							if(src) animate(src,alpha = 0, time = 6)
							sleep(6)
							if(src)
								src.loc = locate(rand(1,500),rand(1,500),2)
								src.icon_state = ""
								sleep(rand(6,60))
								if(src)
									src.alpha = 200
									//src.transform = initial(src.transform)
		lightning_bolt
			icon = 'fx_lightening.dmi'
			icon_state = "bolt"
			layer = 335
			alpha = 200
			pixel_x = -55
			pixel_y = 20
			New()
				//src.icon_state = "10"
				src.icon_state = pick("6","7","8","9")
				src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(0,160,230))
				src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
				spawn(1)
					if(isturf(src.loc))
						var/turf/t = src.loc
						spawn(1.5)
							if(src)
								for(var/atom/movable/a in t)
									if(a != src)
										if(isobj(a))
											var/obj/o = a
											o.shake()
										else if(ismob(a))
											var/mob/m = a
											m.gain_stat("resistance",1,10,"Lightning")
											m.gain_stat("force",1,10,"Lightning")
								if(t.liquid == null)
									var/obj/effects/dust_medium/d = new
									d.pixel_y-=5
									d.loc = t
									d.SetCenter(src)
									src.shockwave()
								animate(src,alpha = 0, time = 6)
								spawn(7)
									if(src) src.destroy()
		tech
			blade
				icon = 'turbine_blade.dmi'
				icon_state = "blade spin"
				pixel_x = -48
				pixel_y = 21
				layer = 100
			regen_overlay
				icon = 'New regen tank.dmi'
				icon_state = "overlay"
				layer = 5
			bubbles
				icon = 'New regen tank.dmi'
				icon_state = "bubbles"
				layer = 10
			solar_overlay
				icon = 'solar_power.dmi'
				icon_state = "overlay"
				layer = 4.9
				bolted = 2
			battery_overlay
				icon = 'battery.dmi'
				icon_state = "0"
				layer = 40
			flow
				icon = 'power_lines.dmi'
				icon_state = "flow"
				layer = 100
		missing_grass
			icon = 'terrain.dmi'
			icon_state = "missing grass"
			mouse_opacity = 0
			layer = 2
			pixel_y = -10
			New()
				spawn(1)
					animate(src,alpha = 0, time = 2000)
					spawn(1000)
						if(src) del(src)
		damage_roof
			icon = 'damage_roof.dmi'
			icon_state = "0"
			layer = 3.3
			New()
				src.icon = pick('damage_roof.dmi','damage_roof2.dmi')
		after_image
			mouse_opacity = 0
			pixel_x = -16
			pixel_y = -8
			step_size = 5
			appearance_flags = KEEP_TOGETHER
			filters = filter(type="motion_blur", x=1, y=0)
			var in_use = 0;
			proc
				enable(var/mob/m)
					src.icon = m.icon
					src.pixel_x = m.pixel_x
					src.pixel_y = m.pixel_y
			New()
				spawn(1)
					animate(src,alpha = 0, time = 10)
		explosions
			layer = 100
			explosion_medium
				icon = 'fx_explosion_medium.dmi'
				pixel_x = -16
				pixel_y = -16
				New()
					src.transform *= 0.1
					animate(src, transform = matrix()*2,alpha = 0, time = 3)
					spawn(3)
						del(src)
		scorch
			icon = 'fx_scorch.dmi'
			layer = 2
			pixel_x = -16
			pixel_y = -16
			//alpha = 200
			mouse_opacity = 0
			New()
				src.icon_state = pick("1","2")
				animate(src, alpha = 0, time = 333)
				spawn(333)
					if(src) src.destroy()//del(src)
		zoom
			appearance_flags = PLANE_MASTER
			screen_loc = "1,1"
		screen_text
			screen_loc = "16,12"
			mouse_opacity = 0
			maptext_x = -304
			//maptext_y = 336
			maptext_width = 700
			maptext_height = 111
			maptext = "<font size = 6><center>You have died"
			filters = filter(type="outline", size=1, color=rgb(0,0,0))
			alpha = 0;
		vision
			icon = 'fx.dmi'
			icon_state = "vision"
			screen_loc = "1,1 to 32,18"
			layer = 500
			alpha = 0
			mouse_opacity = 0
		snow
			icon = 'fx.dmi'
			icon_state = "snow"
			alpha = 100
			layer = 334
		rain
			icon = 'fx.dmi'
			icon_state = "rain2"
			//alpha = 100
			layer = 100
			mouse_opacity = 0
			New()
				src.icon_state = "rain[rand(1,3)]"
		weather
			mouse_opacity = 0
			icon = 'fx.dmi'
			icon_state = "weather"
			layer = 333
		swim
			icon = 'fx_swim.dmi'
			layer = 1000
			blend_mode = BLEND_MULTIPLY
		shadow_ship
			icon = 'ship.dmi'
			alpha = 175
			icon_state = "closed"
			pixel_y = -128
			layer = 99
			New()
				src.icon -= rgb(255,255,255)
		shadow
			icon = 'fx.dmi'
			icon_state = "shadow med"
			mouse_opacity = 0
			bolted = 2
		shadow_small
			icon = 'fx.dmi'
			icon_state = "shadow"
			mouse_opacity = 0
			bolted = 2
			var/atom/movable/attached = null
			New()
				..()
				spawn(7)
					if(src)
						if(src.attached) src.attached.overlays -= src
						del(src)
		shadow_large
			icon = 'fx_shadow_large.dmi'
			icon_state = "large"
			mouse_opacity = 0
			bolted = 2
			pixel_y = -16
			pixel_x = 16
		shadow_tree
			icon = 'fx_shadow_tree.dmi'
			mouse_opacity = 0
			bolted = 2
			pixel_y = -8
			pixel_x = -15
		shield
			icon = 'shield_small.dmi'
			icon_state = "shield large"
			mouse_opacity = 0
			pixel_x = -78
			pixel_y = -64
			layer = 100
			New()
				spawn(10)
					if(src)
						src.transform *= 0.25
						animate(src, transform = matrix()*1, alpha = 0, time = 20,loop = -1)
						animate(transform = matrix()*0.25, alpha = 255, time = 0)
			/*
			New()
				..()
				spawn(40)
					if(src) del(src)
			*/
		shockwave_inverse
			icon = 'shockwave_inverse.dmi'
			mouse_opacity = 0
			bounds = "81,82 to 112,113"
			layer = 100
		shockwave_medium
			icon = 'shockwave.dmi'
			mouse_opacity = 0
			bounds = "81,82 to 112,113"
			layer = 100
		ripple_water
			icon = 'fx_ripple.dmi'
			mouse_opacity = 0
			bounds = "81,82 to 112,113"
			layer = 2
			plane = -1
		progress_bar
			icon = 'bars_progress.dmi'
			icon_state = "0"
			layer = 110
		misc
			help_overlay
				icon = 'question_mark.dmi'
				icon_state = "over"
			trait_overlay
				icon = 'traits.dmi'
				icon_state = "locked in"
			trait_select
				icon = 'traits.dmi'
				icon_state = "select"
		craters
			shakes = 0
			crater_small
				icon = 'fx_crater_small_dirt.dmi'
				bolted = 2
				layer = TURF_LAYER+0.2
				//pixel_x = -4
				//pixel_y = -12
				bounds = "9,9 to 40,40"
				appearance_flags = TILE_BOUND
				New()
					..()
					var/map_spawned = 0
					if(isturf(src.loc)) map_spawned = 1
					spawn(0.1)
						if(istype(src.loc,/turf/grass))
							src.icon = 'fx_crater_small.dmi'
						else if(istype(src.loc,/turf/lava_cooled) || istype(src.loc,/turf/lava_cooling)) src.icon = 'fx_crater_small_ash.dmi'
						for(var/obj/items/plants/p in range(1,src))
							if(bounds_dist(p,src) < 0) p.destroy() //del(p)
						spawn(600)
							if(src && map_spawned == 0)
								animate(src,alpha = 0, time = 10)
								spawn(10)
									if(src) src.destroy()
			crater_medium
				icon = 'fx_crater_medium_dirt.dmi'
				bolted = 2
				pixel_x = -48
				pixel_y = -58
				bounds = "-47,-57 to 112,102"
				layer = TURF_LAYER+0.2
				appearance_flags = TILE_BOUND
				New()
					..()
					var/map_spawned = 0
					if(isturf(src.loc)) map_spawned = 1
					spawn(0.1)
						if(istype(src.loc,/turf/grass))
							src.icon = 'fx_crater_medium.dmi'
						for(var/obj/items/plants/p in range(5,src))
							if(bounds_dist(p,src) < 0) p.destroy()//del(p)
						for(var/obj/effects/craters/c in range(5,src))
							if(c != src) if(bounds_dist(c,src) < -64) c.destroy()//del(c)
						spawn(600)
							if(src && map_spawned == 0)
								animate(src,alpha = 0, time = 10)
								spawn(10)
									if(src) src.destroy()
		exalted_rays
			icon = 'fx_ray_large.dmi'
			pixel_x = -284
			pixel_y = -285
			bolted = 2
			alpha = 155
			appearance_flags = KEEP_APART
			New()
				src.filters += filter(type="rays",x=0,y=0,size=300,color=rgb(255,255,255),offset=0,density=15,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
				animate(src.filters[1],offset = 100,time = 4000, loop = -1)
				animate(offset = 0,time = 0)
		profusion_underlay
			icon = 'profusion_underlay.dmi'
			layer = 3
		profusion_overlay
			icon = 'profusion_overlay.dmi'
			layer = 6
		ground
			icon = 'ground_damage.dmi'
			icon_state = "middle"
			pixel_y = -42
			icon_state = "end left"
		particle
			icon = 'fx_particles.dmi'
			New()
				src.icon_state = "[pick(1,2,3,4)]"
		furrow
			icon = 'fx_furrow_grass_large.dmi'
			mouse_opacity = 0
			layer = 2.1
			pixel_x = -16
			pixel_y = -16
			appearance_flags = TILE_BOUND
		shockwave_smaller
			icon = 'shockwave_smaller.dmi'
			layer = 105
			alpha = 100
			New()
				src.pixel_x = rand(-10,10)
				src.pixel_y = rand(-10,10)
				animate(src,alpha = 0, time = 6)
				spawn(3.6) del(src)
		shockwave_small
			icon = 'shockwave_small.dmi'
			layer = 105
			pixel_x = -16
			pixel_y = -16
			mouse_opacity = 0
			New()
				src.pixel_x = rand(-10,10)
				src.pixel_y = rand(-10,10)
				animate(src, transform = matrix()*2, alpha = 100, time = 6)
				spawn(3.6) del(src)
		plume_ground
			icon = 'fx_dust_plume.dmi'
			layer = 3.1
			mouse_opacity = 0
			bounds = "3,26 to 31,60"
			//pixel_y = -10
		hit
			icon = 'fx_hit.dmi'
			layer = 100
			alpha = 175
			pixel_x = -44
			mouse_opacity = 0
			pixel_y = -24
			New()
				spawn(4)
					if(src) del(src)
		speed_shockwave
			icon = 'fx_speed_shockwave.dmi'
			layer = 100
			alpha = 175
			pixel_x = -44
			mouse_opacity = 0
			pixel_y = -24
			bolted = 2
			immune_dmg = 1
		disturb_air
			icon = 'fx_disturb_air.dmi'
			layer = 100
			alpha = 175
			pixel_x = -44
			mouse_opacity = 0
			pixel_y = -24
		dust_explosive
			icon = 'fx_dust_explosive.dmi'
			icon_state = "1"
			alpha = 200
			layer = 200
			layer = 3
			mouse_opacity = 0
			bounds = "1,1 to 32,32"
			pixel_x = -20
			pixel_y = -10
			New()
				src.icon_state = "[pick(1,2,3,4,5,6,7,8)]"
				//src.pixel_x = rand(-10,10)
		dust
			icon = 'fx_dust_dirt.dmi'
			icon_state = "1"
			alpha = 200
			//layer = 200
			plane = 7
			mouse_opacity = 0
			bounds = "1,1 to 32,32"
			pixel_x = -20
			pixel_y = -16
			invisibility = 1
			var/trans_x
			var/trans_y
			var/deg
			var/og_layer
			proc
				strip_grass()
					spawn(0.1)
						while(src.loc)
							var/obj/d = new
							d.icon = 'fx_furrow_grass.dmi'
							d.loc = src.loc
							d.step_x = src.step_x
							d.step_y = src.step_y
							sleep(0.5)
			New()
				src.icon_state = "[pick(1,2,3,4,5,6,7,8)]"
				//src.pixel_x = rand(-10,10)
		dust_rock_medium
			icon = 'fx_dust_medium.dmi'
			layer = 2.1
			pixel_x = -47
			pixel_y = -53
			alpha = 200
			mouse_opacity = 0
			appearance_flags = TILE_BOUND
			New()
				//animate(src, alpha = 200, time = 5)
				spawn(5)
					if(src) del(src)
		dust_medium
			icon = 'fx_dust_medium_dirt.dmi'
			layer = 2.1
			//pixel_x = -48
			//pixel_y = -50
			bounds = "48,49 to 79,80"
			alpha = 200
			mouse_opacity = 0
			appearance_flags = TILE_BOUND
			New()
				spawn(0.1)
					var/turf/t = src.loc
					if(istype(t,/turf/snows/))
						src.icon = 'fx_dust_medium.dmi'
					else if(istype(t,/turf/lava_cooled/) || istype(t,/turf/lava_cooling/))
						src.icon = 'fx_ash_medium.dmi'
					if(istype(t,/turf/water/))
						del(src)
						return
				spawn(5)
					if(src) src.destroy() //del(src)
		explosion_fire_small
			icon = 'fx.dmi'
			icon_state = "explosion"
			layer = 100
			alpha = 200
			mouse_opacity = 0
			New()
				spawn(1)
					if(src) if(prob(75)) src.shockwave()
					spawn(4)
						if(src) del(src)
		fire
			icon = 'fx_medium.dmi'
			icon_state = "fire"
			layer = 100
			alpha = 200
			pixel_x = -32
			pixel_y = -32
			New()
				src.icon_state = "fire[pick(1,2,3,4)]"
				spawn(33)
					if(src) del(src)
		afk
			appearance_flags = KEEP_APART
			icon = 'afk.dmi'
			layer = 20
		elec_cerebroid
			icon = 'blue elec.dmi'
			pixel_x = 16
			pixel_y = 12
			layer = 20
			appearance_flags = KEEP_APART
		elec
			icon = 'blue elec.dmi'
			//pixel_x = 16
			//pixel_y = 12
			layer = 20
			appearance_flags = KEEP_APART
		elec_green
			icon = 'green elec.dmi'
			//pixel_x = 16
			//pixel_y = 12
			layer = 20
		select_item
			icon = 'fx.dmi'
			icon_state = "select item"
			plane = 22
			layer = 35
			appearance_flags = KEEP_APART
			//vis_flags = VIS_INHERIT_ID | VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_UNDERLAY
		tk
			icon = 'fx.dmi'
			icon_state = "tk"
		superfly
			icon = 'superfly.dmi'
			layer = 200
			alpha = 200
			pixel_y = -32
			pixel_x = -68
			mouse_opacity = 0
	items
		var/o_color = "#ffffff"
		var
			psi_gain = 0
			eng_gain = 0
			str_gain = 0
			end_gain = 0
			spd_gain = 0
			res_gain = 0
			force_gain = 0
			off_gain = 0
			def_gain = 0
			regen_gain = 0
			recov_gain = 0
			int_gain = 0
			lifespan_gain = 0
			rads_gain = 0
			cold_gain = 0
			heat_gain = 0
			toxin_gain = 0
			gravity_gain = 0
			divine_eng_gain = 0
			dark_matter_gain = 0
			divine_mod_gain = 0
			dark_matter_mod_gain = 0
			o2_gain = 0
			eng_mod_gain = 0
			psi_mod_gain = 0
			metab_gain = 0
			hydro_gain = 0
			tiredness_gain = 0
			lvl_rand_part = 0 // Whether this item lvls random parts or not
			lvl_rand_num = 0 //How many times this item lvls up a rand part
			list/lvl_parts = null //List of parts to lvl
			lvl_parts_num = 0 //How many levels to give the parts in lvl_parts list

			psi_gain_temp = 0
			eng_gain_temp = 0
			str_gain_temp = 0
			end_gain_temp = 0
			spd_gain_temp = 0
			res_gain_temp = 0
			force_gain_temp = 0
			off_gain_temp = 0
			def_gain_temp = 0
			regen_gain_temp = 0
			recov_gain_temp = 0
			int_gain_temp = 0
			rads_gain_temp = 0
			cold_gain_temp = 0
			heat_gain_temp = 0
			toxin_gain_temp = 0
			gravity_gain_temp = 0
			divine_mod_gain_temp = 0
			dark_matter_mod_gain_temp = 0
			eng_mod_gain_temp = 0
			psi_mod_gain_temp = 0
			metab_gain_temp = 0
			hydro_gain_temp = 0
			tiredness_gain_temp = 0

			psi_loss_temp = 0
			eng_loss_temp = 0
			str_loss_temp = 0
			end_loss_temp = 0
			spd_loss_temp = 0
			res_loss_temp = 0
			force_loss_temp = 0
			off_loss_temp = 0
			def_loss_temp = 0
			regen_loss_temp = 0
			recov_loss_temp = 0
			int_loss_temp = 0
			rads_loss_temp = 0
			cold_loss_temp = 0
			heat_loss_temp = 0
			toxin_loss_temp = 0
			gravity_loss_temp = 0
			divine_mod_loss_temp = 0
			dark_matter_mod_loss_temp = 0
			eng_mod_loss_temp = 0
			psi_mod_loss_temp = 0
			metab_loss_temp = 0
			hydro_loss_temp = 0
			tiredness_loss_temp = 0

			time_eaten = 0
			extra_info = null
			duration = 0
			comedown_duration = 0
			comedown = 1
			toxic = 0

			has_subtech = 0
			is_subtech = 0
		vis_flags = VIS_INHERIT_PLANE | VIS_INHERIT_LAYER
		//vis_flags = VIS_INHERIT_PLANE
		/*
		"#ffffff" = White - common
		"#1eff00" = Green - Uncommon
		"#0070dd" = Blue - Rare
		"#a335ee" = Purple - Epic
		"#ff8000" = Orange - legendary
		*/
		//hasreflect = 0
		proc
			apply_item_stats(var/mob/m,var/ID,var/skip_sleep = 0,var/skip_eat = 0)
				var/multi = 1
				if(skip_eat == 0 && m.eating) return
				m.eating = src
				src.time_eaten = ID
				//world << "DEBUG - Time trying to consume = [world.time]"
				if(istype(src,/obj/items/consumables/) == 1 || istype(src,/obj/items/drugs/) == 1) m.eat()
				if(skip_sleep == 0) sleep(global.eat_time)
				if(src && m && m.eating == src && src.loc == m && src.stacks > 0 && src.time_eaten == ID)
					m.icon_state = m.state()
					if(m.hud_eat)
						m.vis_contents -= m.hud_eat
						m.stunned -= 1
						m.stunned_pending -= 1
					if(src.toxic)
						if(m.toxicity >= 85)
							multi = 2
							m.lifespan -= abs(src.lifespan_gain)
							m.set_decline()
						else if(src.lifespan_gain != 0)
							m.lifespan += src.lifespan_gain*multi
							m.check_quest("tutorial_lifespan",1)
							m.set_decline()
					else if(src.lifespan_gain != 0)
						m.lifespan += src.lifespan_gain*multi
						m.check_quest("tutorial_lifespan",1)
						m.set_decline()
					if(src.lvl_rand_part)
						while(src.lvl_rand_num)
							src.lvl_rand_num -= 1
							m.lvl_rand_bodypart()
					if(src.lvl_parts != null)
						m.lvl_typesof_bodypart(src.lvl_parts,src.lvl_parts_num*100,0,0,1)
					if(src.toxicity != 0) m.toxicity += src.toxicity*multi
					if(src.psi_mod_gain != 0)
						m.gains_items_power_mod += src.psi_mod_gain
						m.mod_psionic_power += src.psi_mod_gain
					if(src.psi_gain != 0)
						m.gains_items_power += src.psi_gain*multi
					if(src.eng_mod_gain != 0)
						m.gains_items_energy_mod += src.eng_mod_gain
						m.mod_energy += src.eng_mod_gain
					if(src.eng_gain != 0)
						m.gains_items_energy += src.eng_gain*multi
					if(src.divine_eng_gain != 0)
						m.divine_energy += (src.divine_eng_gain*m.divine_energy_mod)*multi
						if(islist(m.tutorials))
							var/obj/help_topics/H = m.tutorials[7]
							if(H.seen == 0)
								H.seen = 1
								H.skill_up(m)
					if(src.dark_matter_gain != 0)
						m.dark_matter += (src.dark_matter_gain*m.dark_matter_mod)*multi
						if(islist(m.tutorials))
							var/obj/help_topics/H = m.tutorials[15]
							if(H.seen == 0)
								H.seen = 1
								H.skill_up(m)
					if(src.str_gain != 0)
						m.gains_items_strength += src.str_gain*multi
						m.strength += (src.str_gain*m.mod_strength)*multi
					if(src.spd_gain != 0)
						m.gains_items_agility_mod += src.spd_gain*multi
						m.mod_agility += src.spd_gain*multi
					if(src.end_gain != 0)
						m.gains_items_endurance += src.end_gain*multi
						m.endurance += (src.end_gain*m.mod_endurance)*multi
					if(src.res_gain != 0)
						m.gains_items_resistance += src.res_gain*multi
						m.resistance += (src.res_gain*m.mod_resistance)*multi
					if(src.force_gain != 0)
						m.gains_items_force += src.force_gain*multi
						m.force += (src.force_gain*m.mod_force)*multi
					if(src.off_gain != 0)
						m.gains_items_off += src.off_gain*multi
						m.offence += (src.off_gain*m.mod_offence)*multi
					if(src.def_gain != 0)
						m.gains_items_def += src.def_gain*multi
						m.defence += (src.def_gain*m.mod_defence)*multi
					if(src.regen_gain != 0)
						m.gains_items_regen_mod += src.regen_gain*multi
						m.mod_regeneration += src.regen_gain*multi
					if(src.recov_gain != 0)
						m.gains_items_recov_mod += src.recov_gain*multi
						m.mod_recovery += src.recov_gain*multi
					if(src.rads_gain != 0)
						m.mod_immune_rads += src.rads_gain*multi
						m.immune_rads_items += src.rads_gain*multi
					if(src.cold_gain != 0)
						m.mod_immune_cold += src.cold_gain*multi
						m.immune_cold_items += src.cold_gain*multi
					if(src.heat_gain != 0)
						m.mod_immune_heat += src.heat_gain*multi
						m.immune_heat_items += src.heat_gain*multi
					if(src.gravity_gain != 0)
						m.mod_immune_gravity += src.gravity_gain*multi
						m.immune_gravity_items += src.gravity_gain*multi
					if(src.toxin_gain != 0)
						m.mod_immune_toxins += src.toxin_gain
						m.immune_toxins_items += src.toxin_gain
					if(src.divine_mod_gain != 0) m.divine_energy_mod += src.divine_mod_gain*multi
					if(src.dark_matter_mod_gain != 0) m.dark_matter_mod += src.dark_matter_mod_gain*multi
					if(src.o2_gain != 0)
						m.o2_max += src.o2_gain*multi
						m.gains_items_o2 += src.o2_gain*multi
					if(src.metab_gain != 0)
						m.hunger += src.metab_gain*multi
						m.check_quest("tutorial_eat",1)
					if(src.hydro_gain != 0)
						m.thirst += src.hydro_gain*multi
						m.check_quest("tutorial_drink",1)
					if(src.tiredness_gain != 0)
						m.restedness += src.tiredness_gain*multi
			create_item_desc()
				var/txt = "Permanent Effects: "
				var/txt_c = null
				var/txt_green = "<font color = green>+"
				var/txt_red = "<font color = red>"
				if(src.psi_mod_gain != 0)
					if(src.psi_mod_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.psi_mod_gain] Psionic Power Mod</font>"
				if(src.psi_gain != 0)
					if(src.psi_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.psi_gain] Psionic Power</font>"
				if(src.eng_mod_gain != 0)
					if(src.eng_mod_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.eng_mod_gain] Energy Mod</font>"
				if(src.eng_gain != 0)
					if(src.eng_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.eng_gain] Max Energy</font>"
				if(src.str_gain != 0)
					if(src.str_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.str_gain] Strength</font>"
				if(src.spd_gain != 0)
					if(src.spd_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.spd_gain] Agility Mod</font>"
				if(src.end_gain != 0)
					if(src.end_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.end_gain] Endurance</font>"
				if(src.res_gain != 0)
					if(src.res_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.res_gain] Resistance</font>"
				if(src.force_gain != 0)
					if(src.force_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.force_gain] Force</font>"
				if(src.off_gain != 0)
					if(src.off_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.off_gain] Offence</font>"
				if(src.def_gain != 0)
					if(src.def_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.def_gain] Defence</font>"
				if(src.regen_gain != 0)
					if(src.regen_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.regen_gain] Regeneration Mod</font>"
				if(src.recov_gain != 0)
					if(src.recov_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.recov_gain] Recovery Mod</font>"
				if(src.rads_gain != 0)
					if(src.rads_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.rads_gain] Radiation Tolerance</font>"
				if(src.cold_gain != 0)
					if(src.cold_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.cold_gain] Cold Tolerance</font>"
				if(src.heat_gain != 0)
					if(src.heat_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.heat_gain] Heat Tolerance</font>"
				if(src.gravity_gain != 0)
					if(src.gravity_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.gravity_gain] Gravity Tolerance</font>"
				if(src.toxin_gain != 0)
					if(src.toxin_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.toxin_gain] Toxin Tolerance</font>"
				if(src.divine_mod_gain != 0)
					if(src.divine_mod_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.divine_mod_gain] Divine Energy Mod</font>"
				if(src.dark_matter_mod_gain != 0)
					if(src.dark_matter_mod_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.dark_matter_mod_gain] Dark Matter Mod</font>"
				if(src.lifespan_gain != 0)
					if(src.lifespan_gain > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.lifespan_gain] Lifespan</font>"
				if(src.metab_gain != 0)
					if(src.metab_gain > 0) txt_c = "<font color = green>+"
					else txt_c = "<font color = red>"
					txt = "[txt]\n[txt_c][src.metab_gain]% Satiation</font>"
				if(src.hydro_gain != 0)
					if(src.hydro_gain > 0) txt_c = "<font color = green>+"
					else txt_c = "<font color = red>"
					txt = "[txt]\n[txt_c][src.hydro_gain]% Hydration</font>"
				if(src.tiredness_gain != 0)
					if(src.tiredness_gain > 0) txt_c = "<font color = green>+"
					else txt_c = "<font color = red>"
					txt = "[txt]\n[txt_c][src.tiredness_gain]% Restedness</font>"
				if(src.lvl_rand_part != 0)
					if(src.lvl_rand_num > 0) txt_c = "<font color = green>+"
					else txt_c = "<font color = red>"
					txt = "[txt]\n[txt_c]1 lvl in [src.lvl_rand_num] random body parts</font>"
				if(src.lvl_parts != null)
					if(src.lvl_parts_num > 0) txt_c = "<font color = green>+"
					else txt_c = "<font color = red>"
					for(var/t in src.lvl_parts)
						txt = "[txt]\n[txt_c][src.lvl_parts_num] lvl in [t]s </font>"
				txt = "[txt]\n\nTemporarily Effects: "
				if(src.psi_mod_gain_temp != 0)
					if(src.psi_mod_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.psi_mod_gain_temp] Psionic Power Mod</font>"
				if(src.psi_gain_temp != 0)
					if(src.psi_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.psi_gain_temp] Psionic Power</font>"
				if(src.eng_mod_gain_temp != 0)
					if(src.eng_mod_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.eng_mod_gain_temp] Energy Mod</font>"
				if(src.eng_gain_temp != 0)
					if(src.eng_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.eng_gain_temp] Max Energy</font>"
				if(src.str_gain_temp != 0)
					if(src.str_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.str_gain_temp] Strength</font>"
				if(src.spd_gain_temp != 0)
					if(src.spd_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.spd_gain_temp] Agility Mod</font>"
				if(src.end_gain_temp != 0)
					if(src.end_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.end_gain_temp] Endurance</font>"
				if(src.res_gain_temp != 0)
					if(src.res_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.res_gain_temp] Resistance</font>"
				if(src.force_gain_temp != 0)
					if(src.force_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.force_gain_temp] Force</font>"
				if(src.off_gain_temp != 0)
					if(src.off_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.off_gain_temp] Offence</font>"
				if(src.def_gain_temp != 0)
					if(src.def_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.def_gain_temp] Defence</font>"
				if(src.regen_gain_temp != 0)
					if(src.regen_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.regen_gain_temp] Regeneration Mod</font>"
				if(src.recov_gain_temp != 0)
					if(src.recov_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.recov_gain_temp] Recovery Mod</font>"
				if(src.rads_gain_temp != 0)
					if(src.rads_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.rads_gain_temp] Radiation Tolerance</font>"
				if(src.cold_gain_temp != 0)
					if(src.cold_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.cold_gain_temp] Cold Tolerance</font>"
				if(src.heat_gain_temp != 0)
					if(src.heat_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.heat_gain_temp] Heat Tolerance</font>"
				if(src.gravity_gain_temp != 0)
					if(src.gravity_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.gravity_gain_temp] Gravity Tolerance</font>"
				if(src.toxin_gain_temp != 0)
					if(src.toxin_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.toxin_gain_temp] Toxin Tolerance</font>"
				if(src.divine_mod_gain_temp != 0)
					if(src.divine_mod_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.divine_mod_gain_temp] Divine Energy Mod</font>"
				if(src.dark_matter_mod_gain_temp != 0)
					if(src.dark_matter_mod_gain_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.dark_matter_mod_gain_temp] Dark Matter Mod</font>"
				if(src.metab_gain_temp != 0)
					if(src.metab_gain_temp > 0) txt_c = "<font color = red>+"
					else txt_c = "<font color = green>-"
					txt = "[txt]\n[txt_c][src.metab_gain_temp] Metabolic Rate</font>"
				if(src.hydro_gain_temp != 0)
					if(src.hydro_gain_temp > 0) txt_c = "<font color = red>+"
					else txt_c = "<font color = green>-"
					txt = "[txt]\n[txt_c][src.hydro_gain_temp] Dehydration Rate</font>"
				if(src.tiredness_gain_temp != 0)
					if(src.tiredness_gain_temp > 0) txt_c = "<font color = red>+"
					else txt_c = "<font color = green>-"
					txt = "[txt]\n[txt_c][src.tiredness_gain_temp] Tiredness Rate</font>"
				txt = "[txt]\n\nComedown Effects: "
				if(src.psi_mod_loss_temp != 0)
					if(src.psi_mod_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.psi_mod_loss_temp] Psionic Power Mod</font>"
				if(src.psi_loss_temp != 0)
					if(src.psi_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.psi_loss_temp] Psionic Power</font>"
				if(src.eng_mod_loss_temp != 0)
					if(src.eng_mod_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.eng_mod_loss_temp] Energy Mod</font>"
				if(src.eng_loss_temp != 0)
					if(src.eng_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.eng_loss_temp] Max Energy</font>"
				if(src.str_loss_temp != 0)
					if(src.str_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.str_loss_temp] Strength</font>"
				if(src.spd_loss_temp != 0)
					if(src.spd_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.spd_loss_temp] Agility Mod</font>"
				if(src.end_loss_temp != 0)
					if(src.end_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.end_loss_temp] Endurance</font>"
				if(src.res_loss_temp != 0)
					if(src.res_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.res_loss_temp] Resistance</font>"
				if(src.force_loss_temp != 0)
					if(src.force_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.force_loss_temp] Force</font>"
				if(src.off_loss_temp != 0)
					if(src.off_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c]+[src.off_loss_temp] Offence</font>"
				if(src.def_loss_temp != 0)
					if(src.def_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.def_loss_temp] Defence</font>"
				if(src.regen_loss_temp != 0)
					if(src.regen_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.regen_loss_temp] Regeneration Mod</font>"
				if(src.recov_loss_temp != 0)
					if(src.recov_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.recov_loss_temp] Recovery Mod</font>"
				if(src.rads_loss_temp != 0)
					if(src.rads_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.rads_loss_temp] Radiation Tolerance</font>"
				if(src.cold_loss_temp != 0)
					if(src.cold_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.cold_loss_temp] Cold Tolerance</font>"
				if(src.heat_loss_temp != 0)
					if(src.heat_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.heat_loss_temp] Heat Tolerance</font>"
				if(src.gravity_loss_temp != 0)
					if(src.gravity_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.gravity_loss_temp] Gravity Tolerance</font>"
				if(src.toxin_loss_temp != 0)
					if(src.toxin_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.toxin_loss_temp] Toxin Tolerance</font>"
				if(src.divine_mod_loss_temp != 0)
					if(src.divine_mod_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.divine_mod_loss_temp] Divine Energy Mod</font>"
				if(src.dark_matter_mod_loss_temp != 0)
					if(src.dark_matter_mod_loss_temp > 0) txt_c = txt_green
					else txt_c = txt_red
					txt = "[txt]\n[txt_c][src.dark_matter_mod_loss_temp] Dark Matter Mod</font>"
				if(src.metab_loss_temp != 0)
					if(src.metab_loss_temp > 0) txt_c = "<font color = red>+"
					else txt_c = "<font color = green>-"
					txt = "[txt]\n[txt_c][src.metab_loss_temp] Metabolic Rate</font>"
				if(src.hydro_loss_temp != 0)
					if(src.hydro_loss_temp > 0) txt_c = "<font color = red>+"
					else txt_c = "<font color = green>-"
					txt = "[txt]\n[txt_c][src.hydro_loss_temp] Dehydration Rate</font>"
				if(src.tiredness_loss_temp != 0)
					if(src.tiredness_loss_temp > 0) txt_c = "<font color = red>+"
					else txt_c = "<font color = green>-"
					txt = "[txt]\n[txt_c][src.tiredness_loss_temp] Tiredness Rate</font>"
				return txt
			create_drug_buff(var/mob/m)
				var/obj/buffs_and_debuffs/timed/b = new
				b.psi_gain = src.psi_gain_temp*src.tech_lvl
				b.eng_gain = src.eng_gain_temp*src.tech_lvl
				b.str_gain = src.str_gain_temp*src.tech_lvl
				b.end_gain = src.end_gain_temp*src.tech_lvl
				b.spd_gain = src.spd_gain_temp*src.tech_lvl
				b.res_gain = src.res_gain_temp*src.tech_lvl
				b.force_gain = src.force_gain_temp*src.tech_lvl
				b.off_gain = src.off_gain_temp*src.tech_lvl
				b.def_gain = src.def_gain_temp*src.tech_lvl
				b.regen_gain = src.regen_gain_temp*src.tech_lvl
				b.recov_gain = src.recov_gain_temp*src.tech_lvl
				b.int_gain = src.int_gain_temp*src.tech_lvl
				b.rads_gain = src.rads_gain_temp*src.tech_lvl
				b.cold_gain = src.cold_gain_temp*src.tech_lvl
				b.heat_gain = src.heat_gain_temp*src.tech_lvl
				b.toxin_gain = src.toxin_gain_temp*src.tech_lvl
				b.gravity_gain = src.gravity_gain_temp*src.tech_lvl
				b.divine_mod_gain = src.divine_mod_gain_temp*src.tech_lvl
				b.dark_matter_mod_gain = src.dark_matter_mod_gain_temp*src.tech_lvl
				b.eng_mod_gain = src.eng_mod_gain_temp*src.tech_lvl
				b.psi_mod_gain = src.psi_mod_gain_temp*src.tech_lvl
				b.metab_gain = src.metab_gain_temp*src.tech_lvl
				b.hydro_gain = src.hydro_gain_temp*src.tech_lvl
				b.tiredness_gain = src.tiredness_gain_temp*src.tech_lvl

				b.psi_loss = src.psi_loss_temp*src.tech_lvl
				b.eng_loss = src.eng_loss_temp*src.tech_lvl
				b.str_loss = src.str_loss_temp*src.tech_lvl
				b.end_loss = src.end_loss_temp*src.tech_lvl
				b.spd_loss = src.spd_loss_temp*src.tech_lvl
				b.res_loss = src.res_loss_temp*src.tech_lvl
				b.force_loss = src.force_loss_temp*src.tech_lvl
				b.off_loss = src.off_loss_temp*src.tech_lvl
				b.def_loss = src.def_loss_temp*src.tech_lvl
				b.regen_loss = src.regen_loss_temp*src.tech_lvl
				b.recov_loss = src.recov_loss_temp*src.tech_lvl
				b.int_loss = src.int_loss_temp*src.tech_lvl
				b.rads_loss = src.rads_loss_temp*src.tech_lvl
				b.cold_loss = src.cold_loss_temp*src.tech_lvl
				b.heat_loss = src.heat_loss_temp*src.tech_lvl
				b.toxin_loss = src.toxin_loss_temp*src.tech_lvl
				b.gravity_loss = src.gravity_loss_temp*src.tech_lvl
				b.divine_mod_loss = src.divine_mod_loss_temp*src.tech_lvl
				b.dark_matter_mod_loss = src.dark_matter_mod_loss_temp*src.tech_lvl
				b.eng_mod_loss = src.eng_mod_loss_temp*src.tech_lvl
				b.psi_mod_loss = src.psi_mod_loss_temp*src.tech_lvl
				b.metab_loss = src.metab_loss_temp*src.tech_lvl
				b.hydro_loss = src.hydro_loss_temp*src.tech_lvl
				b.tiredness_loss = src.tiredness_loss_temp*src.tech_lvl

				b.buff_type = "drug buff"
				b.icon_state = "drug buff"
				b.type_path = src.type
				b.buff_name = "[src.name] metabolization"
				b.origin_name = src.name
				b.comedown = src.comedown
				b.comedown_timer = src.comedown_duration

				b.timer = src.duration
				b.apply_buff(m,b)
				b.loc = m

			apply_same_drug(var/mob/m)
				var/found_same = 0
				for(var/obj/buffs_and_debuffs/b in m)
					if(b.origin_name == src.name)
						//if(b.name != "[b.origin_name] comedown") b.timer = src.duration
						found_same = 1
						break
				return found_same
		MouseEntered(location,control,params)
			//..()
			//Mouse name box code
			/*
			usr.client.MousePosition(params)
			usr.mouse_txt_over = src // For the name box that appears for items.
			usr.mouse_saved_loc = params
			spawn(7)
				if(usr.mouse_txt_over == src)
					usr.client.MousePosition(usr.mouse_saved_loc)
					usr.create_map_box(params,src) // For the name box that appears for items.
					usr.mouse_txt_confirm = src
			*/
			//End mouse name box code
			/*
			if(src.loc != null)
				if(usr.build_mouse && usr.build_tech)
					usr.place_percise(params)
			*/

			usr.mouse_over = src
			if(usr.hud_info) usr.hud_info.maptext = "<span style='-dm-text-outline: 1px #000000;text-align:right'>[src]</span>"
			if(src.stack_display == null) src.create_stack_display()
			if(src.stacks > 1 && src.stack_exempt == 0) usr.client.images += src.stack_display
			if(usr.toggled_info)
				if(istype(src,/obj/items/tech/))
					usr.show_info_tech(src)
			/*
			if(usr.open_inven && usr.accessing && src.loc == usr.accessing && usr.hud_inv)
				//usr.hud_inv.item_name.maptext = "[css_outline]<font size = 1><center>[src.name]"
				usr.hud_inv.item_desc.maptext = "[css_outline]<font size = 1><text align=center valign=top>[src.name]<text align=left valign=top>\n\nRarity: [global.rarity_color[src.rarity]]\n\n[src.desc_extra][src.desc]"
				winset(usr,null,"inven.label_name.text=\"[src.name]\"")
				winset(usr,null,"inven.label_desc.text=\"[src.desc]\"")
				winset(usr,null,"inven.label_info.text=\"[src.desc_extra]\"")
			*/
			/*
			spawn(8)
				if(usr && src && usr.mouse_over == src)
					if(src.item_info == null)
						if(usr.hud_namebar && src.loc)
							var/obj/h = usr.hud_namebar
							h.loc = src.loc
							h.step_x = src.step_x
							h.step_y = src.step_y

							h.txt_i.maptext = "<center>[src.name]"
							if(!usr.client.images.Find(h.txt_i)) usr.client.images += h.txt_i

							//h.transform = matrix()*0.1
							//animate(h,transform = matrix()*1,time = 1)
					else if(usr.hud_info && src.loc)
						var/obj/h = usr.hud_info
						h.loc = src.loc
						h.step_x = src.step_x
						h.step_y = src.step_y

						//h.txt_i.maptext = "<center><p><u>[src.name]</u></p>[src.item_info]"
						h.txt_i.maptext = "<text align=center valign=top><p><u>[src.name]</u></p>[src.item_info]"
						if(!usr.client.images.Find(h.txt_i))  usr.client.images += h.txt_i

						//h.transform = matrix()*0.1
						//animate(h,transform = matrix()*1,time = 1)
			*/
			var/proceed = 1
			if(src.bolted && usr.trait_hm == null) proceed = 0
			if(src.bolted > 1) proceed = 0
			if(proceed) if(src.loc) if(!usr.left_click_function) usr.client.mouse_pointer_icon = 'mouse_grab.dmi'
			if(src.can_pocket || src.can_activate)
				if(!usr.left_click_function) usr.client.mouse_pointer_icon = 'mouse_interact.dmi'
				if(src.over == null)
					var/image/sel = image(src.icon,src)
					//sel.appearance = src.appearance
					//sel.override = 1
					//sel.mouse_opacity = 0
					sel.loc = src
					//sel.mouse_opacity = 0
					src.over = sel
					src.over.filters = filter(type="outline", size=1, color=src.o_color)
				if(ismob(src.loc) == 0 && isobj(src.loc) == 0)
					usr.client.images += src.over
					while(usr && usr.mouse_over && usr.mouse_over == src && src.over)
						//src.over.appearance = src.appearance
						src.over.icon = src.icon
						src.over.icon_state = src.icon_state
						//src.over.pixel_x = src.pixel_x
						//src.over.pixel_y = src.pixel_y
						src.over.overlays = src.overlays
						src.over.underlays = src.underlays
						//src.over.override = 1
						if(src.grabbed_by || src.tk) src.over.pixel_z = src.pixel_z-16
						//src.over.transform = src.transform
						src.over.dir = src.dir
						sleep(0.1)
				else if(length(src.filters) <= 0) src.filters += filter(type="outline", size=1, color=src.o_color)
		MouseExited(location,control,params)
			if(!isturf(src.loc))
				if(length(src.filters) <= 1) src.filters -= filter(type="outline", size=1, color=src.o_color)
			else usr.client.images -= src.stack_display
			if(usr.mouse_txt) usr.client.screen -= usr.mouse_txt // For the name box that appears for items.
			usr.mouse_txt_confirm = null // For the name box that appears for items.
			usr.mouse_txt_over = null // For the name box that appears for items.
			usr.client.images -= src.over
			usr.mouse_over = null
			if(!usr.left_click_function) usr.client.mouse_pointer_icon = 'mouse.dmi'

			if(usr.hud_namebar)
				usr.hud_namebar.loc = null
				usr.hud_info.loc = null
				/*
				var/obj/h = usr.hud_namebar
				h.loc = src.loc
				h.step_x = src.step_x
				h.step_y = src.step_y

				h.txt_i.maptext = "[src.name]"
				usr.client.images += h.txt_i
				*/
		Click(location,control,params)
			//src.flash_red()
			//src.shake()
			winset(usr,"main.map_main","focus=true")
			params = params2list(params)
			if(params["right"])
				if(usr.left_click_function) //Dismiss any left click functions
					usr.left_click_function = null
					usr.left_click_ref = null
					//world << "DEBUG - left_click_ref rendered null"
					usr.client.mouse_pointer_icon = 'mouse.dmi'
					return
				if(usr.skill_remote_viewing && usr.skill_remote_viewing.active)
					call(usr.skill_remote_viewing.act)(usr,usr.skill_remote_viewing)
					usr.map_proc(1)
				if(usr.active_attack) usr.active_attack = null //Cancel the energy attack current being fired or charged.

				/*
				//Drop an item by right clicking it
				if(usr.accessing in range(1,usr))
					var/mob/m = usr.accessing
					if(ismob(src.loc))
						var/mob/x = src.loc
						x.overlays -= src
						x.underlays -= src
						src.loc = m.loc
						src.underlays = null
						src.step_x = m.step_x
						src.step_y = m.step_y
						src.layer = initial(src.layer)
						usr.client.screen -= src
						src.set_shadow()
						if(src.floor_state)
							src.icon_state = src.floor_state
						usr.refresh_inv()
						return
				*/
			else if(params["left"])
				if(istype(src,/obj/items/))
					if(src.loc == usr.accessing) usr.hud_inv.item_desc.maptext = "[css_outline]<font size = 1><text align=center valign=top>[src.name]<text align=left valign=top>\n\nRarity: [global.rarity_color[src.rarity]]\n\n[src.desc_extra][src.desc]"
				if(istype(src,/obj/items/tech/))
					if(src.loc == null)
						for(var/obj/t in global.tech)//usr.technology_researched)
							usr.client.images -= t.img_select
						if(usr.tech_unlocked.Find(src.type))//src))
							//usr.build_tech = src
							if(usr.build_tech_selected)
								var/obj/t = usr.build_tech_selected
								t.filters -= filter(type="outline", size=4, color=rgb(255,255,255))
							usr.build_tech_selected = src;
							src.filters += filter(type="outline", size=4, color=rgb(255,255,255))
							if(istype(src,/obj/items/tech/weights/)) src.value = src.weight*100
							//winset(usr,"tech.label_cost","text=\"Cost: [Commas(src.value)]\"")
							//winset(usr,"tech.label_name","text=\"[src.name]\"")
							//winset(usr,"tech.label_desc","text=\"[src.desc]\"")
							//winset(usr,"tech.label_info","text=\"[src.desc_extra]\"")
							//var/icon/I = icon(src.icon,src.icon_state,SOUTH,1,0)
							//I.Scale(src.scale_x,src.scale_y)
							//var/Z = fcopy_rsc(I)

							if(usr.hud_tech)
								var/obj/I = usr.hud_tech.txt
								var/power_needed = ""
								var/power_produced = ""
								var/can_upgrade = "No"
								var/can_move = "Yes"
								if(src.bolted > 1) can_move = "No"
								if(src.tech_upgradable > 0) can_upgrade = "Yes"
								if(src.uses > 0) power_needed = "Power Requirement: [src.uses]\n\n"
								if(src.generates > 0) power_produced = "Power Generated: [src.generates]\n\n"
								I.maptext = "[css_outline]<font size = 1><text align=center valign=top>[src.name]<text align=left valign=top>\n\nCost: [src.value]\n\nTech Tree: [src.tech_tree]\n\nSubtech: [src.tech_subtech]\n\nCan Upgrade: [can_upgrade]\n\nMoveable: [can_move]\n\n[power_needed][power_produced][src.desc]"
								//winset(usr,"tech.label_img","image=\ref[Z]")
							//winshow(usr,"tech_panes",0)
							//winset(usr,"tech.label_tech","text=\"[src.name] - [src.desc]\"")
							//usr.client.images += src.img_select
							if(usr.build_mouse)
								usr.build_mouse.loc = null
								usr.build_mouse = null
								//del(usr.build_mouse)
					else if(usr.build_mouse && usr.build_tech)
						if(usr.mouse_far)
							usr << "Unable to place. [usr.mouse_far]"
							return
						usr.build_tech(usr.build_tech,usr.build_marker)
						if(usr) usr.mouse_down = null
						return
				//Player activates TK on target
				if(usr.left_click_function == "tk")
					if(usr.skill_tk && src.bolted < 2)
						if(src.tk == 0)
							src.mouse_opacity  = 0
							animate(src, pixel_z = 16, time = 1)
							src.density_factor = 0
							src.layer += 100
							src.filters += filter(type="drop_shadow", x=0, y=0, size=5, offset=0, color=rgb(102,0,204))
							var/obj/effects/dust_medium/d = new
							d.SetCenter(src)
							if(src.generator == 1 && src.can_generate == 1 || src.icon_state == "battery")
								for(var/turf/trf in src.locs)
									for(var/obj/items/tech/Power_Line/p in trf)
										spawn(2)
											if(p)
												p.reconnect_power()

							spawn(1)
								if(usr && src)
									animate(src,pixel_y = 4, time = 10,loop = -1)
									animate(pixel_y = 0, time = 10)
						//usr.energy -= 0.01+((usr.energy_max*0.25)/proceed.skill_lvl/usr.mod_energy)
						usr.energy -= 1.1-(usr.skill_tk.skill_lvl/100)
						usr.gain_stat("force",1,1,"Telekinesis")
						usr.skill_tk.skill_exp += (10/usr.skill_tk.skill_lvl)*usr.mod_skill
						if(usr.skill_tk.skill_exp >= 100 && usr.skill_tk.skill_lvl < 100)
							usr.skill_tk.skill_exp = 1
							usr.skill_tk.skill_lvl += 1
						src.tk = 1
						usr.tk = src
					usr.left_click_function = null
					usr.client.mouse_pointer_icon = 'mouse.dmi'
					return
				//Follower go
				else if(usr.left_click_function == "clone grab")
					if(usr.left_click_ref)
						var/mob/NPC/m = usr.left_click_ref
						usr << output("Selected [src] as target for [usr.left_click_ref] to grab.","chat.world")
						usr << output("Selected [src] as target for [usr.left_click_ref] to grab.","chat.local")
						m.idle_ticks = 0
						m.function = "grab"
						m.target_go = src
						m.icon_state = m.state()
						usr.left_click_function = null
						usr.left_click_ref = null
						usr.client.mouse_pointer_icon = 'mouse.dmi'
						winshow(usr,"contacts",1)
						usr.open_contacts = 1
						usr.open_menus.Add(".open_contacts")
						if(m.activated == 0)
							m.activated = 1
							m.follower_ai()
						return
				//Follower give
				else if(usr.left_click_function == "clone give")
					if(usr.left_click_ref)
						if(get_dist(usr,usr.left_click_ref) <= 2)
							if(src.suffix == "worn" || src.suffix == "equipped")
								usr.set_alert("Can't transfer worn items",'alert.dmi',"alert")
								usr.create_chat_entry("alerts","Can't transfer worn items.")
								return
							if(src in usr)
								usr.client.mouse_pointer_icon = 'mouse.dmi'
								winshow(usr,"contacts",1)
								usr.open_contacts = 1
								usr.open_menus.Add(".open_contacts")
								src.loc = usr.left_click_ref
								usr.refresh_inv()
								usr.left_click_function = null
								usr.left_click_ref = null
								if(src == usr.item_selected)
									usr.item_selected = null
									src.overlays -= /obj/effects/select_item
							else if(src in usr.left_click_ref)
								usr.client.mouse_pointer_icon = 'mouse.dmi'
								winshow(usr,"contacts",1)
								usr.open_contacts = 1
								usr.open_menus.Add(".open_contacts")
								src.loc = usr
								usr.refresh_inv()
								usr.left_click_function = null
								usr.left_click_ref = null
						return
				//Follower go
				else if(usr.left_click_function == "clone go")
					if(usr.left_click_ref)
						usr << output("Selected [src] as target for [usr.left_click_ref] to travel to.","chat.world")
						usr << output("Selected [src] as target for [usr.left_click_ref] to travel to.","chat.local")
						usr.left_click_ref.function = "go"
						usr.left_click_ref.target_go = src
						usr.left_click_function = null
						usr.left_click_ref = null
						usr.client.mouse_pointer_icon = 'mouse.dmi'
						winshow(usr,"contacts",1)
						usr.open_contacts = 1
						usr.open_menus.Add(".open_contacts")
						return
				else if(usr.left_click_function == "change object icon")
					if(usr.icon_stored)
						if(src.change_icon)
							src.icon = usr.icon_stored
							usr.left_click_function = null
							usr.icon_stored = null
						else
							usr.set_alert("None applicable object",'alert.dmi',"alert")
							usr.create_chat_entry("alerts","None applicable object.")
							usr.left_click_function = null
							usr.icon_stored = null
							return
					return
				else if(usr.left_click_function == "reset object icon")
					src.icon = initial(src.icon)
					usr.left_click_function = null
					usr.icon_stored = null
					return
				if(isturf(src.loc))
					if(usr.build_mouse && usr.build_tech)
						if(usr.mouse_far)
							usr << "Unable to place. [usr.mouse_far]"
							return
						if(istype(usr.build_tech,/obj/items/tech/)) usr.build_tech(usr.build_tech,usr.build_marker)
						else if(istype(usr.build_tech,/obj/buildings/)) usr.build(usr.build_tech,usr.build_marker)
						//usr.build_tech(usr.build_tech,usr.build_marker)
						usr.mouse_down = null
					/*
					if(src in range(1,usr))
						if(!src.bolted)
							if(src.can_pocket)
								src.loc = usr
								if(src.shadow) src.shadow.loc = null
								if(src.inven_state)
									src.icon_state = src.inven_state
								src.overlays -= /obj/effects/select_item
								usr.mouse_down = null
								usr.mouse_over = null
								usr.refresh_inv()
								return
					*/
		environmental
			invul_melee = 1
			tornado
			gravitational_anomaly //Make these randomly teleport about the map for players to find, last for a while before moving again.
			psionic_storm //Same as grav anomaly, gives force when you sit inside it.
			psi_realm_flux_point
				bolted = 2
				radius = 9;
				New()
					var/obj/O = new(src.loc)
					O.particles = new
					O.particles.position = generator("box", list(-100, -100, 5), list(100,100,5), UNIFORM_RAND)
					O.particles.transform = list(1, 0, 0, 0,   0, 1, 0, 0,   0, 0, -1, -1,   0, 0, 0, 0)
					O.particles.count = 1000
					O.particles.spawning = 10
					O.particles.lifespan = 100
					O.particles.gravity = list(0,0,-0.002)
					O.particles.width = 32 * 6 * 2
					O.particles.height = 32 * 6 * 2
					O.particles.fadein = 50
					O.particles.fade = 10
					O.invisibility = 1
					O.plane = 1

					var/obj/rays = new
					rays.icon = 'fx_ray_large.dmi'
					rays.pixel_x = -284
					rays.pixel_y = -284
					rays.loc = src.loc
					rays.bolted = 2
					rays.filters += filter(type="rays",x=0,y=0,size=300,color=rgb(102,0,204),offset=0,density=15,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
					animate(rays.filters[1],offset = 100,time = 1000, loop = -1)
					animate(offset = 0,time = 0)

					var/obj/effects/soul_energy/s = new
					s.loc = src.loc
					s.invisibility = 1
					spawn(15)
						if(src) src.energy_field()
			neutron_field
				icon = 'neutron_field.dmi'
				density_factor = 0
				density = 0;
				pixel_x = -144;
				pixel_y = -144;
				bounds = "-144,-144,176,176"
				bolted = 2
				//plane = 3;
				radius = 5;
				i_width = 320;
				i_height = 320;
				mouse_opacity = 0;
				hp = 1.#INF
				appearance_flags = KEEP_TOGETHER
				New()
					..()
					src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(155,255,255))
					src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
					animate(src, transform = matrix()*1.1, time = 10, loop = -1)
					animate(transform = matrix()*1, time = 10)
			neutron_sphere
				icon = 'neutron_something.dmi'
				density_factor = 0
				density = 0;
				pixel_x = -144;
				pixel_y = -144;
				bounds = "-144,-144,176,176"
				bolted = 2
				//plane = 3;
				radius = 7;
				i_width = 320;
				i_height = 320;
				mouse_opacity = 0;
				hp = 1.#INF
				appearance_flags = KEEP_TOGETHER
				New()
					..()
					src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(155,255,255))
					src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
					animate(src, transform = matrix()*1.1, time = 10, loop = -1)
					animate(transform = matrix()*1, time = 10)

					animate(transform = turn(matrix(), 120), time = 2, loop = -1,flags = ANIMATION_PARALLEL)
					animate(transform = turn(matrix(), 240), time = 2)
					animate(transform = null, time = 2)
					spawn(10)
						if(src)
							for(var/turf/t in range(src.radius,src))
								t.microwaves = -1
							var/obj/rays = new
							rays.icon = 'fx_ray_large.dmi'
							rays.pixel_x = -284
							rays.pixel_y = -284
							rays.loc = src.loc
							rays.bolted = 2
							rays.filters += filter(type="rays",x=0,y=0,size=300,color=rgb(200,255,255),offset=0,density=15,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
							animate(rays.filters[1],offset = 100,time = 1000, loop = -1)
							animate(offset = 0,time = 0)

							while(src)
								for(var/obj/items/tech/Regeneration_Tank/tnk in range(src.radius,src))
									tnk.flash_red()
									tnk.shake()
									tnk.hp -= 5
									if(tnk.hp <= 0) tnk.destroy()
								for(var/mob/x in view(src.radius,src))
									if(x.debuff_exalted)
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
								sleep(10)

					//animate(transform = turn(matrix(), 120), time = 4,loop = -1, flags = ANIMATION_PARALLEL)
					//animate(transform = turn(matrix(), 240), time = 4)
			portals
				New()
					..()
					src.waves()
					spawn(100)
						if(src)
							animate(src, transform = matrix()*1.075, time = 10, loop = -1,flags=ANIMATION_PARALLEL)
							animate(transform = matrix()*1, time = 10)

							var/obj/t = new
							t.bolted = 2
							t.loc = src.loc
							t.step_x = -16;
							t.step_y = -16;

							var/xx = src.go_x
							var/yy = src.go_y
							var/zz = src.go_z
							t.vis_contents += locate(xx,yy,zz)
							t.vis_contents += locate(xx+1,yy,zz)
							t.vis_contents += locate(xx,yy+1,zz)
							t.vis_contents += locate(xx+1,yy+1,zz)
							//t.layer = 300;

							var/obj/i = new
							i.icon = 'portal.dmi'
							i.icon_state = "solid"
							i.loc = src.loc
							i.bolted = 2;
							i.pixel_x = -48;
							i.pixel_y = -48;
							i.alpha = 100
							i.transform *= 0.1
							animate(i, transform = matrix()*1.75,alpha = 0, time = 10, loop = -1)
				portal_wastes_to_hell
					icon = 'portal.dmi'
					icon_state = "ring"
					density_factor = 0
					density = 0;
					bolted = 2
					pixel_x = -48;
					pixel_y = -48;
					bounds = "-48,-48 to 80,80"
					plane = 1;
					radius = 5;
					go_x = 360;
					go_y = 433;
					go_z = 2;
				portal_wastes_to_heaven
					icon = 'portal.dmi'
					icon_state = "ring"
					density_factor = 0
					density = 0;
					bolted = 2
					pixel_x = -48;
					pixel_y = -48;
					bounds = "-48,-48 to 80,80"
					plane = 1;
					radius = 5;
					go_x = 380;
					go_y = 15;
					go_z = 2;
				portal_hell_to_wastes
					icon = 'portal.dmi'
					icon_state = "ring"
					density_factor = 0
					density = 0;
					bolted = 2
					pixel_x = -48;
					pixel_y = -48;
					bounds = "-48,-48 to 80,80"
					plane = 1;
					radius = 5;
					go_x = 95;
					go_y = 311;
					go_z = 2;
				portal_heaven_to_wastes
					icon = 'portal.dmi'
					icon_state = "ring"
					density_factor = 0
					density = 0;
					bolted = 2
					pixel_x = -48;
					pixel_y = -48;
					bounds = "-48,-48 to 80,80"
					plane = 1;
					radius = 5;
					go_x = 115;
					go_y = 229;
					go_z = 2;
				portal_wastes_to_earth
					icon = 'portal.dmi'
					icon_state = "ring"
					density_factor = 0
					density = 0;
					bolted = 2
					pixel_x = -48;
					pixel_y = -48;
					bounds = "-48,-48 to 80,80"
					plane = 1;
					radius = 5;
					go_x = 100;
					go_y = 100;
					go_z = 1;
			psionic_ring
				icon = 'psionic_portal.dmi'
				icon_state = "ring"
				density_factor = 0
				density = 0;
				bolted = 2
				pixel_x = -48;
				pixel_y = -48;
				bounds = "-48,-48 to 80,80"
				plane = 1;
				radius = 5;
				New()
					animate(src, transform = matrix()*1.1, time = 10, loop = -1)
					animate(transform = matrix()*1, time = 10)
					//animate(transform = turn(matrix(), 120), time = 4,loop = -1, flags = ANIMATION_PARALLEL)
					//animate(transform = turn(matrix(), 240), time = 4)
			psionic_crystal
				icon = 'psionic_portal.dmi'
				icon_state = "crystal"
				density_factor = 0
				density = 0;
				bolted = 2
				pixel_x = -48;
				pixel_y = -48;
				bounds = "-48,-48 to 80,80"
				plane = 2;
				radius = 5;
				New()
					animate(src, transform = matrix()*1.1, time = 10, loop = -1)
					animate(transform = matrix()*1, time = 10)
					//animate(transform = turn(matrix(), 120), time = 4,loop = -1, flags = ANIMATION_PARALLEL)
					//animate(transform = turn(matrix(), 240), time = 4)
			blackhole
				icon = 'blackhole.dmi'
				density_factor = 0
				density = 0;
				bolted = 2
				pixel_x = -48;
				pixel_y = -48;
				bounds = "-48,-48 to 80,80"
				//plane = 1;
				radius = 5;
				appearance_flags = TILE_BOUND
				hp = 1.#INF
				var/grown = 1
				proc
					spin()
						animate(src, transform = matrix()*1.1, time = 10, loop = -1, flags = ANIMATION_PARALLEL)
						animate(transform = matrix()*1, time = 10)
						animate(transform = turn(matrix(), 120), time = 4,loop = -1, flags = ANIMATION_PARALLEL)
						animate(transform = turn(matrix(), 240), time = 4)
						animate(transform = null, time = 4)
				New()
					spawn(10)
						src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
						src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
						if(src)
							for(var/turf/t in range(src.radius,src))
								t.grav = -1
							if(src.grown)
								animate(src, transform = matrix()*1.1, time = 10, loop = -1)
								animate(transform = matrix()*1, time = 10)
								animate(transform = turn(matrix(), 120), time = 4,loop = -1, flags = ANIMATION_PARALLEL)
								animate(transform = turn(matrix(), 240), time = 4)
								animate(transform = null, time = 4)
								var/p = 33
								while(p)
									if(prob(25))
										sleep(1)
									p -= 1;
									var/obj/pix = new
									pix.icon = 'fx.dmi'
									pix.icon_state = "pixel"
									pix.loc = src.loc
									pix.step_x = src.step_x
									pix.step_y = src.step_y
									pix.pixel_x = rand(-200,200)
									pix.pixel_y = rand(-200,200)
									pix.bolted = 2
									animate(pix,pixel_x = 0, pixel_y = 0, time = rand(5,10), alpha = 0,loop = -1)
									animate(pixel_x = rand(-200,200), pixel_y = rand(-200,200), time = 0, alpha = 255)
							while(src)
								for(var/obj/items/tech/tch in range(src.radius,src))
									tch.flash_red()
									tch.shake()
									tch.hp -= 5
									if(tch.hp <= 0) tch.destroy()
								sleep(10)
					/*
					spawn(10)
						if(src)
							if(src.density_factor == 0) src.gravity_well()
							while(src)
								src.pulsate_field()
								sleep(10)
					*/
		drugs
			//Add Kidney dialysis and stomach pumps, as well as nasal ejectors to treat overdose.
			icon = 'drugs.dmi'
			icon_state = "pills"
			stacks = 1
			can_pocket = 1
			toxic = 1
			value = 100000
			tech_parent_path = /obj/items/tech/sub_tech/Genetics/Drug_Synthesis
			Click(location,control,params)
				..()
				//Removes this item from the global Items list.
				if(items)
					if(src in items) items -= src
				params = params2list(params)
				if(params["left"])
					if(isturf(src.loc))
						usr.pickup(src)
					else if(ismob(src.loc))
						if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
						usr.item_selected = src
						src.overlays -= /obj/effects/select_item
						src.overlays += /obj/effects/select_item
					else if(src.loc == null)
						var/v = 10000
						src.tech_lvl = 1
						for(var/obj/items/tech/Drug_Synthesization/DS in global.tech)//usr.technology_researched)
							if(usr.tech_unlocked[DS.list_pos] == DS.type)
							//if(usr.tech_unlocked.Find(DS.type))
								src.tech_lvl = usr.tech_lvls[DS.list_pos]//DS.tech_lvl
								v = 10000*DS.tech_lvl
								world << "DEBUG - Found [DS], setting drug cost to [1000*DS.tech_lvl] based on level: [DS.tech_lvl]"
								break
						src.value = v
						winset(usr,"tech.label_cost","text=\"Cost: [Commas(src.value)]\"")
						winset(usr,"tech.label_name","text=\"[src.name]\"")
						winset(usr,"tech.label_desc","text=\"[src.desc]\"")
						winset(usr,"tech.label_info","text=\"[src.desc_extra]\"")
						usr.build_tech_selected = src


			//Drug Synthesis items

			Chemotherapeutic_Agent //Helps with rad sickness
			Penicillin //Helps with regen, helps reduce time of infections/disease
			Acetaminophen //Helps with recovery, helps reduce time of infections/disease.
			Ibuprofen //Helps with regen and limb healing
			Acetylsalicylic_Acid //Helps with regen and limb healing (Aspirin)
			Activated_Charcoal //Helps with drug overdose
			Diazepam //Help with recovery, helps with toxicity/addiction build up
			Ferrous_Salt //Iron supplements, helps with strength
			Silver_Sulfadiazine //Helps with heat tolerance and microwave tolerance
			Vaccine
			Ascorbic_Acid //Vitim C supplement, levels up organs when used
			Calcium_Supplement //Levels up bones when used
			Colecalciferol //Vitim D supplement, levels up skin
			Retinol //Levels eyes, skin
			Riboflavin //Increases energy
			Iloprost //Help with cold tolerance
			Ayahuasca //Increases divine energy, makes you trip out.
			Energy_Drink
			Psi_X //Super drug
			Alcohol
			Citrulline_Malate //Supplement, helps with heart and muscles.
			Tranexamic_Acid //Used to help stop bleeding.


			//Un-safe drugs
			Steroids //Strength. Too much hurts heart, lowers lifespan.
				name = "Steroids"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Steroids/proc/use
				act_drop = /obj/items/drugs/Steroids/proc/drop

				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10


				New()
					..()
					spawn(0)
						if(src)
							src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity Buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
							src.desc_extra = "Potency: [src.tech_lvl]%\n\nDuration: [(src.duration/10)/60] minutes\n\nToxicity Buildup: <font color = red>+ [src.toxicity]%</font>\n\n[src.create_item_desc()]\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"

				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								var/repeat = i.apply_same_drug(m)
								if(repeat == 0) i.create_drug_buff(m)
								if(m.toxicity >= 85)
									m.flash_red()
									for(var/obj/body_related/bodyparts/torso/t in m.bodyparts)
										for(var/obj/body_related/bodyparts/torso/heart/h in t)
											m.damage_limb(i,0, 1, 100,h)
											break
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Creatine //Strength, increase muscle levels.
				name = "Creatine"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Creatine/proc/use
				act_drop = /obj/items/drugs/Creatine/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.str_gain] level in Strength</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Beta_Blocker //Strength, too much hurts heart and lowers lifespan
				name = "Beta Blockers"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Beta_Blocker/proc/use
				act_drop = /obj/items/drugs/Beta_Blocker/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.str_gain] level in Strength</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Methamphetamine //Agility/Energy. Higher int gains for a while. Less hunger. Too much hurts heart, lowers lifespan.
				name = "Methamphetamine"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Methamphetamine/proc/use
				act_drop = /obj/items/drugs/Methamphetamine/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.eng_gain] level in Energy</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Potassium_Iodide //Rad tolerance. Too much hurts all organs, lowers lifespan.
				name = "Potassium Iodide"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Potassium_Iodide/proc/use
				act_drop = /obj/items/drugs/Potassium_Iodide/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.rads_gain]% Radiation Tolerance</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Cocaine //Endurance/Energy. Hurts heart, lowers lifespan.
				name = "Cocaine"
				rarity = 2
				desc = ""
				act = /obj/items/drugs/Cocaine/proc/use
				act_drop = /obj/items/drugs/Cocaine/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.eng_gain] level in Energy</font>\n\n<font color = green>+ [src.end_gain] level in Endurance</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.create_drug_buff(m)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Cannabis //Lower int gains for a while. More hunger. Too much ko's you.
				name = "Cannabis"
				rarity = 2
				desc = ""
				act = /obj/items/drugs/Cannabis/proc/use
				act_drop = /obj/items/drugs/Cannabis/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken


				//Changed temporarily when taken
				metab_gain_temp = 1
				hydro_gain_temp = 1

				//Changed temporarily when wears off

				New()
					..()
					spawn(0)
						if(src)
							src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity Buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
							src.desc_extra = "Potency: [src.tech_lvl]%\n\nDuration: [(src.duration/10)/60] minutes\n\nToxicity Buildup: <font color = red>+ [src.toxicity]%</font>\n\n[src.create_item_desc()]\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"

				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								var/repeat = i.apply_same_drug(m)
								if(repeat == 0) i.create_drug_buff(m)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Calcium_Carbonate //Increase bones. Too much lowers lifespan.
				name = "Calcium Carbonate"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Calcium_Carbonate/proc/use
				act_drop = /obj/items/drugs/Calcium_Carbonate/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.str_gain] level in Strength</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Lysergic_Acid_Diethylamide ///Increases Energy, Divine Energy
				name = "Lysergic Acid Diethylamide"
				rarity = 3
				desc = ""
				act = /obj/items/drugs/Lysergic_Acid_Diethylamide/proc/use
				act_drop = /obj/items/drugs/Lysergic_Acid_Diethylamide/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.eng_gain] level in Energy</font>\n\n<font color = green>+ [src.divine_eng_gain] level in Divine Energy</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Agaric //Magic shrooms. Increase int levels. Increase divine energy.
				name = "Agaric"
				rarity = 3
				desc = ""
				act = /obj/items/drugs/Agaric/proc/use
				act_drop = /obj/items/drugs/Agaric/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.divine_eng_gain] level in Divine Energy</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Diacetylmorphine //Heroin.
				name = "Diacetylmorphine"
				rarity = 3
				desc = ""
				act = /obj/items/drugs/Diacetylmorphine/proc/use
				act_drop = /obj/items/drugs/Diacetylmorphine/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.str_gain] level in Strength</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Ketamine //Endurance
				name = "Ketamine"
				rarity = 2
				desc = ""
				act = /obj/items/drugs/Ketamine/proc/use
				act_drop = /obj/items/drugs/Ketamine/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.end_gain] level in Endurance</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			MDMA //Increase agility?
				name = "Ecstasy"
				rarity = 2
				desc = ""
				act = /obj/items/drugs/MDMA/proc/use
				act_drop = /obj/items/drugs/MDMA/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.str_gain] level in Strength</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Morphine //Endurance. Hurts kidney?
				icon_state = "syringe"
				name = "Morphine"
				rarity = 2
				desc = ""
				act = /obj/items/drugs/Morphine/proc/use
				act_drop = /obj/items/drugs/Morphine/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.end_gain] level in Endurance</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Caffeine //Increases force. Too much hurts heart.
				name = "Caffeine"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Caffeine/proc/use
				act_drop = /obj/items/drugs/Caffeine/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.force_gain] level in Force</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Nicotine //Increases force
				name = "Nicotine"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Nicotine/proc/use
				act_drop = /obj/items/drugs/Nicotine/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.force_gain] level in Force</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Chondroitin_Sulphate //Increases regen
				name = "Chondroitin Sulphate"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Chondroitin_Sulphate/proc/use
				act_drop = /obj/items/drugs/Chondroitin_Sulphate/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.str_gain] level in Strength</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Hyaluronic_Acid //Increases regen
				name = "Hyaluronic Acid"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Hyaluronic_Acid/proc/use
				act_drop = /obj/items/drugs/Hyaluronic_Acid/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.str_gain] level in Strength</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Insulin //Increase energy, recovery. Too much hurts pancreas and ko's you.
				name = "Insulin"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Insulin/proc/use
				act_drop = /obj/items/drugs/Insulin/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.eng_gain] level in Energy</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Propofol //Increase psionic power, ko's you.
				name = "Propofol"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Propofol/proc/use
				act_drop = /obj/items/drugs/Propofol/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.psi_gain] level in Psionic Power</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Anaesthetic //ko's user
				name = "Anaesthetic"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Anaesthetic/proc/use
				act_drop = /obj/items/drugs/Anaesthetic/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.str_gain] level in Strength</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Epinephrine //(Adrenalin) , Increase heart, strength, energy. Too much hurts heart, lowers lifespan.
				icon_state = "syringe"
				name = "Epinephrine"
				rarity = 3
				desc = ""
				act = /obj/items/drugs/Epinephrine/proc/use
				act_drop = /obj/items/drugs/Epinephrine/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.end_gain] level in Endurance</font>\n\n<font color = green>+ [src.str_gain] level in Strength</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Methylmercury //Very dangerous, can be taken by androids too. Increases dark matter, reduces lifespan. Hurts organs if organic.
				name = "Methylmercury"
				rarity = 3
				desc = ""
				act = /obj/items/drugs/Methylmercury/proc/use
				act_drop = /obj/items/drugs/Methylmercury/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.str_gain] level in Strength</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Sirolimus //Increase lifespan.
				name = "Sirolimus"
				rarity = 2
				desc = ""
				act = /obj/items/drugs/Sirolimus/proc/use
				act_drop = /obj/items/drugs/Sirolimus/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.str_gain] level in Strength</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Sodium_Cyanide //Kills user
				name = "Sodium Cyanide"
				rarity = 3
				desc = ""
				act = /obj/items/drugs/Sodium_Cyanide/proc/use
				act_drop = /obj/items/drugs/Sodium_Cyanide/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.str_gain] level in Strength</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Polonium_210 //Kills the user if their radiation tolerance is too low. Increases resistance and radiation tolerance.
				name = "Polonium-210"
				rarity = 3
				desc = ""
				act = /obj/items/drugs/Polonium_210/proc/use
				act_drop = /obj/items/drugs/Polonium_210/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.str_gain] level in Strength</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			//Fictional drugs
			Psiamphetamine //Special drug used to increase brain wave activity, gives Psionic power.
				name = "Psiamphetamine"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Psiamphetamine/proc/use
				act_drop = /obj/items/drugs/Psiamphetamine/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.psi_gain] level in Psionic Power</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Psidexasulphate //Special drug used to increase brain wave activity, gives Psionic Power.
				name = "Psidexasulphate"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Psidexasulphate/proc/use
				act_drop = /obj/items/drugs/Psidexasulphate/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.psi_gain] level in Psionic Power</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			Super_Soldier_Serum //Increases all mods by 10%-20%, increases lifespan by 10%-20%
				icon_state = "syringe"
				name = "Super Soldier Serum"
				rarity = 1
				desc = ""
				act = /obj/items/drugs/Super_Soldier_Serum/proc/use
				act_drop = /obj/items/drugs/Super_Soldier_Serum/proc/drop
				//Toxic buildup from taking drug
				toxin_gain = 0.0001
				toxicity = 10
				lifespan_gain = -10

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last
				comedown = 1
				comedown_duration = 6000

				//Changed permanently when taken
				str_gain = 1

				//Changed temporarily when taken
				str_gain_temp = 10

				//Changed temporarily when wears off
				str_loss_temp = -10
				New()
					..()
					src.extra_info = "<font color = red>- Heart Damage</font>\n\n<font color = red>+ [src.toxicity*2]% Toxicity buildup</font>\n\n<font color = red>- [abs(lifespan_gain)] Lifespan</font>\n\n<font color = green>- Double benefits</font>"
					src.desc_extra = "When Taken:\n\n<font color = red>+ [src.toxicity]% Toxicity buildup</font>\n\n<font color = green>+ [src.str_gain] level in Strength</font>\n\n<font color = green>+ [src.toxin_gain] Toxin Tolerance</font>\n\nTaken at 85%+ Toxicity:\n\n[src.extra_info]"
				proc
					use(var/mob/m,var/obj/items/drugs/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to metabolize this",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to metabolize this.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m.toxicity >= 200)
									m.set_alert("You overdose on [i]!",'alert.dmi',"alert")
									m.create_chat_entry("alerts","You overdose on [i]!")
									m.Death("[i] overdose")
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
		consumables
			can_pocket = 1;
			icon = 'consumables.dmi'
			bounds = "8,6 to 25,24"

			var/infused = 0
			solar_infusion
			dragon_faeces
			dragon_bone
			thousand_year_old_dragon_bone
			thousand_year_old_dragon_faeces
			thousand_year_old_ginseng
			divine_feather
			void_droplet
			scarlet_crystal

			ambrosia //Increases max divine energy and life span
				name = "Ambrosia"
				icon = 'artifacts_small.dmi'
				icon_state = "ambrosia"
				rarity = 3
				hashadow = 1
				act = /obj/items/consumables/ambrosia/proc/use
				act_drop = /obj/items/consumables/ambrosia/proc/drop
				//Toxic buildup from taking drug

				//Duration in 1/10 seconds

				//Does the drug have a comedown or not, and how long does it last

				//Changed permanently when taken
				lifespan_gain = 1
				divine_eng_gain = 1
				lvl_rand_part = 1
				lvl_rand_num = 1

				//Changed temporarily when taken

				//Changed temporarily when wears off

				New()
					..()
					src.desc_extra = "[src.create_item_desc()]\n\n"
				proc
					use(var/mob/m,var/obj/items/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to eat food",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to eat food.")
								return
							if(m.hunger > 90)
								m.set_alert("Already full",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already full.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								if(islist(m.tutorials))
									var/obj/help_topics/H = m.tutorials[7]
									if(H.seen == 0)
										H.seen = 1
										H.skill_up(m)
								i.use_obj(m)
								m.refresh_inv()
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				//plane = 4
					fall()
						spawn(1)
							if(src)
								src.pixel_y = 1000
								if(src.shadow) src.shadow.pixel_y = 0
								while(src.pixel_y > 0)
									src.pixel_y -= 8
									if(src.pixel_y < 0) src.pixel_y = 0
									sleep(0.1)
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			water
				coffee
					name = "Coffee"
					icon_state = "coffee"
					rarity = 1
					desc = "Darkly colored, bitter, and slightly acidic, coffee has a stimulating effect on people, primarily due to its caffeine content."
					act = /obj/items/consumables/water/coffee/proc/use
					act_drop = /obj/items/consumables/water/coffee/proc/drop
					//Toxic buildup from taking drug

					//Duration in 1/10 seconds

					//Does the drug have a comedown or not, and how long does it last

					//Changed permanently when taken
					hydro_gain = 25

					//Changed temporarily when taken

					//Changed temporarily when wears off
					proc
						use(var/mob/m,var/obj/items/i)
							if(i in m)
								if(m.has_stomach == 0 || m.has_body == 0)
									m.set_alert("Unable to drink liquids",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Unable to drink liquids.")
									return
								if(m.thirst > 90)
									m.set_alert("Already full",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Already full.")
									return
								if(m.eating)
									m.set_alert("Already drinking",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Already drinking.")
									return
								var/T = world.time
								i.apply_item_stats(m,T)
								if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
									i.use_obj(m)
									m.refresh_inv()
									if(m) m.eating = null
						drop(var/mob/m,var/obj/items/i)
							m.drop(i)
					New()
						..()
						src.desc_extra = "[src.create_item_desc()]\n\n"
					Click(location,control,params)
						..()
						//Removes this item from the global Items list.
						if(items)
							if(src in items) items -= src
						params = params2list(params)
						if(params["left"])
							if(isturf(src.loc))
								usr.pickup(src)
							else if(ismob(src.loc))
								if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
								usr.item_selected = src
								src.overlays -= /obj/effects/select_item
								src.overlays += /obj/effects/select_item
				energy_drink
					name = "Energy Drink"
					icon_state = "energy drink"
					rarity = 1
					desc = "Mental and physical stimulation in a can!"
					act = /obj/items/consumables/water/energy_drink/proc/use
					act_drop = /obj/items/consumables/water/energy_drink/proc/drop
					//Toxic buildup from taking drug

					//Duration in 1/10 seconds

					//Does the drug have a comedown or not, and how long does it last

					//Changed permanently when taken
					hydro_gain = 25

					//Changed temporarily when taken

					//Changed temporarily when wears off
					proc
						use(var/mob/m,var/obj/items/i)
							if(i in m)
								if(m.has_stomach == 0 || m.has_body == 0)
									m.set_alert("Unable to drink liquids",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Unable to drink liquids.")
									return
								if(m.thirst > 90)
									m.set_alert("Already full",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Already full.")
									return
								if(m.eating)
									m.set_alert("Already drinking",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Already drinking.")
									return
								var/T = world.time
								i.apply_item_stats(m,T)
								if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
									i.use_obj(m)
									m.refresh_inv()
									if(m) m.eating = null
						drop(var/mob/m,var/obj/items/i)
							m.drop(i)
					New()
						..()
						src.desc_extra = "[src.create_item_desc()]\n\n"
					Click(location,control,params)
						..()
						//Removes this item from the global Items list.
						if(items)
							if(src in items) items -= src
						params = params2list(params)
						if(params["left"])
							if(isturf(src.loc))
								usr.pickup(src)
							else if(ismob(src.loc))
								if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
								usr.item_selected = src
								src.overlays -= /obj/effects/select_item
								src.overlays += /obj/effects/select_item
				cola
					name = "Cola"
					icon_state = "cola"
					rarity = 1
					desc = "A caramel and spice combination drink that derives it's name from the original source of caffeine: the Kola nut."
					act = /obj/items/consumables/water/cola/proc/use
					act_drop = /obj/items/consumables/water/cola/proc/drop
					//Toxic buildup from taking drug

					//Duration in 1/10 seconds

					//Does the drug have a comedown or not, and how long does it last

					//Changed permanently when taken
					hydro_gain = 25

					//Changed temporarily when taken

					//Changed temporarily when wears off
					proc
						use(var/mob/m,var/obj/items/i)
							if(i in m)
								if(m.has_stomach == 0 || m.has_body == 0)
									m.set_alert("Unable to drink liquids",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Unable to drink liquids.")
									return
								if(m.thirst > 90)
									m.set_alert("Already full",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Already full.")
									return
								if(m.eating)
									m.set_alert("Already drinking",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Already drinking.")
									return
								var/T = world.time
								i.apply_item_stats(m,T)
								if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
									i.use_obj(m)
									m.refresh_inv()
									if(m) m.eating = null
						drop(var/mob/m,var/obj/items/i)
							m.drop(i)
					New()
						..()
						src.desc_extra = "[src.create_item_desc()]\n\n"
					Click(location,control,params)
						..()
						//Removes this item from the global Items list.
						if(items)
							if(src in items) items -= src
						params = params2list(params)
						if(params["left"])
							if(isturf(src.loc))
								usr.pickup(src)
							else if(ismob(src.loc))
								if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
								usr.item_selected = src
								src.overlays -= /obj/effects/select_item
								src.overlays += /obj/effects/select_item
				water_bottle_dirty
					name = "Bottle of Dirty Water"
					icon_state = "water bottle dirty"
					rarity = 1
					desc = "Water is an inorganic compound with the chemical formula H2O. It is a transparent, tasteless, odorless, and nearly colorless chemical substance."
					act = /obj/items/consumables/water/water_bottle_dirty/proc/use
					act_drop = /obj/items/consumables/water/water_bottle_dirty/proc/drop
					//Toxic buildup from taking drug

					//Duration in 1/10 seconds

					//Does the drug have a comedown or not, and how long does it last

					//Changed permanently when taken
					hydro_gain = 50

					//Changed temporarily when taken

					//Changed temporarily when wears off
					proc
						use(var/mob/m,var/obj/items/i)
							if(i in m)
								if(m.has_stomach == 0 || m.has_body == 0)
									m.set_alert("Unable to drink liquids",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Unable to drink liquids.")
									return
								if(m.thirst > 90)
									m.set_alert("Already full",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Already full.")
									return
								if(m.eating)
									m.set_alert("Already drinking",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Already drinking.")
									return
								var/T = world.time
								i.apply_item_stats(m,T)
								if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
									i.use_obj(m)
									m.refresh_inv()
									if(m) m.eating = null
						drop(var/mob/m,var/obj/items/i)
							m.drop(i)
					New()
						..()
						src.desc_extra = "[src.create_item_desc()]\n\n"
					Click(location,control,params)
						..()
						//Removes this item from the global Items list.
						if(items)
							if(src in items) items -= src
						params = params2list(params)
						if(params["left"])
							if(isturf(src.loc))
								usr.pickup(src)
							else if(ismob(src.loc))
								if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
								usr.item_selected = src
								src.overlays -= /obj/effects/select_item
								src.overlays += /obj/effects/select_item
				water_bottle_sea
					name = "Bottle of Water"
					icon_state = "water bottle"
					rarity = 1
					desc = "Water is an inorganic compound with the chemical formula H2O. It is a transparent, tasteless, odorless, and nearly colorless chemical substance. This one tastes salty."
					act = /obj/items/consumables/water/water_bottle_sea/proc/use
					act_drop = /obj/items/consumables/water/water_bottle_sea/proc/drop
					//Toxic buildup from taking drug

					//Duration in 1/10 seconds
					duration = 6000

					//Does the drug have a comedown or not, and how long does it last

					//Changed permanently when taken
					hydro_gain = 25

					//Changed temporarily when taken
					hydro_gain_temp = 1

					//Changed temporarily when wears off
					proc
						use(var/mob/m,var/obj/items/i)
							if(i in m)
								if(m.has_stomach == 0 || m.has_body == 0)
									m.set_alert("Unable to drink liquids",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Unable to drink liquids.")
									return
								if(m.thirst > 90)
									m.set_alert("Already full",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Already full.")
									return
								if(m.eating)
									m.set_alert("Already drinking",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Already drinking.")
									return
								var/T = world.time
								i.apply_item_stats(m,T)
								if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
									for(var/obj/body_related/bodyparts/torso/t in m.bodyparts)
										for(var/obj/body_related/bodyparts/torso/left_kidney/lk in t)
											m.damage_limb(i,0, 1, 25,lk)
											break
										for(var/obj/body_related/bodyparts/torso/right_kidney/rk in t)
											m.damage_limb(i,0, 1, 25,rk)
											break
									var/obj/items/consumables/water/water_bottle_empty/b = new
									b.loc = m
									m.pickup(b,1)
									var/repeat = i.apply_same_drug(m)
									if(repeat == 0) i.create_drug_buff(m)
									i.use_obj(m)
									m.refresh_inv()
									if(m) m.eating = null
						drop(var/mob/m,var/obj/items/i)
							m.drop(i)
					New()
						..()
						src.desc_extra = "[src.create_item_desc()]\n\n"
					Click(location,control,params)
						..()
						//Removes this item from the global Items list.
						if(items)
							if(src in items) items -= src
						params = params2list(params)
						if(params["left"])
							if(isturf(src.loc))
								usr.pickup(src)
							else if(ismob(src.loc))
								if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
								usr.item_selected = src
								src.overlays -= /obj/effects/select_item
								src.overlays += /obj/effects/select_item
				water_bottle_empty
					name = "Empty Bottle"
					icon_state = "water bottle empty"
					rarity = 1
					desc = "Empty plastic bottle, can be filled by standing near or over liquid or snow."
					act = /obj/items/consumables/water/water_bottle_empty/proc/use
					act_drop = /obj/items/consumables/water/water_bottle_empty/proc/drop
					//Toxic buildup from taking drug

					//Duration in 1/10 seconds

					//Does the drug have a comedown or not, and how long does it last

					//Changed permanently when taken

					//Changed temporarily when taken

					//Changed temporarily when wears off
					proc
						use(var/mob/m,var/obj/items/i)
							if(i in m)
								var/found_water = 0
								for(var/turf/t in m.locs)
									if(t.type == /turf/water/water5)
										var/obj/items/consumables/water/water_bottle/b = new
										b.loc = m
										m.pickup(b,1)
										found_water = 1
										break
									if(t.type == /turf/water/water_ocean)
										var/obj/items/consumables/water/water_bottle_sea/b = new
										b.loc = m
										m.pickup(b,1)
										found_water = 1
										break
									if(istype(t,/turf/snows/))
										var/obj/items/consumables/water/water_bottle/b = new
										b.loc = m
										m.pickup(b,1)
										found_water = 1
										break
								if(found_water)
									i.use_obj(m)
									m.refresh_inv()
						drop(var/mob/m,var/obj/items/i)
							m.drop(i)
					New()
						..()
						src.desc_extra = "[src.create_item_desc()]\n\n"
					Click(location,control,params)
						..()
						//Removes this item from the global Items list.
						if(items)
							if(src in items) items -= src
						params = params2list(params)
						if(params["left"])
							if(isturf(src.loc))
								usr.pickup(src)
							else if(ismob(src.loc))
								if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
								usr.item_selected = src
								src.overlays -= /obj/effects/select_item
								src.overlays += /obj/effects/select_item
				water_bottle
					name = "Bottle of Water"
					icon_state = "water bottle"
					rarity = 1
					desc = "Water is an inorganic compound with the chemical formula H2O. It is a transparent, tasteless, odorless, and nearly colorless chemical substance."
					act = /obj/items/consumables/water/water_bottle/proc/use
					act_drop = /obj/items/consumables/water/water_bottle/proc/drop
					//Toxic buildup from taking drug

					//Duration in 1/10 seconds

					//Does the drug have a comedown or not, and how long does it last

					//Changed permanently when taken
					hydro_gain = 50

					//Changed temporarily when taken

					//Changed temporarily when wears off
					proc
						use(var/mob/m,var/obj/items/i)
							if(i in m)
								if(m.has_stomach == 0 || m.has_body == 0)
									m.set_alert("Unable to drink liquids",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Unable to drink liquids.")
									return
								if(m.thirst > 90)
									m.set_alert("Already full",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Already full.")
									return
								if(m.eating)
									m.set_alert("Already drinking",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Already drinking.")
									return
								var/T = world.time
								i.apply_item_stats(m,T)
								if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
									var/obj/items/consumables/water/water_bottle_empty/b = new
									b.loc = m
									m.pickup(b,1)
									i.use_obj(m)
									m.refresh_inv()
									if(m) m.eating = null
						drop(var/mob/m,var/obj/items/i)
							m.drop(i)
					New()
						..()
						src.desc_extra = "[src.create_item_desc()]\n\n"
					Click(location,control,params)
						..()
						//Removes this item from the global Items list.
						if(items)
							if(src in items) items -= src
						params = params2list(params)
						if(params["left"])
							if(isturf(src.loc))
								usr.pickup(src)
							else if(ismob(src.loc))
								if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
								usr.item_selected = src
								src.overlays -= /obj/effects/select_item
								src.overlays += /obj/effects/select_item
			ginseng //boosts Max Energy and recovers Energy (Little herbs in the ground you can click to remove)
				name = "Ginseng"
				icon_state = "ginseng ground1"
				bolted = 1;
				//o_color = "#1eff00"
				rarity = 2
				desc = "A great source of Energy, Ginseng typically only grows on planet Earth. Consuming this herb guarantees a level up in your Energy stat. Androids are not able to consume this food."
				act = /obj/items/consumables/ginseng/proc/use
				act_drop = /obj/items/consumables/ginseng/proc/drop
				//Toxic buildup from taking drug

				//Duration in 1/10 seconds

				//Does the drug have a comedown or not, and how long does it last

				//Changed permanently when taken
				eng_gain = 1
				metab_gain = 5

				//Changed temporarily when taken

				//Changed temporarily when wears off
				proc
					use(var/mob/m,var/obj/items/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to eat food",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to eat food.")
								return
							if(m.hunger > 90)
								m.set_alert("Already full",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already full.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				New()
					..()
					src.icon_state = "ginseng ground[rand(1,2)]"
					src.desc_extra = "[src.create_item_desc()]\n\n"
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(src.bolted)
							if(src in range(1,usr))
								src.icon_state = "ginseng"
								src.bolted = 0;
								animate(src,pixel_y = 32,time = 2,easing = BOUNCE_EASING)
								animate(pixel_y = 0, time = 2)
								animate(src,transform = turn(src.transform, 90), time = 2, flags = ANIMATION_PARALLEL)
								var/obj/h = new
								h.loc = src.loc
								h.step_x = src.step_x;
								h.step_y = src.step_y;
								h.icon = src.icon
								h.icon_state = "ginseng hole"
								return
						else if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			ectoplasm_negative // gives Strength, lowers lifespan
				name = "Negative Ectoplasm"
				icon_state = "ectoplasm negative"
				act = /obj/items/consumables/ectoplasm_negative/proc/use
				act_drop = /obj/items/consumables/ectoplasm_negative/proc/drop
				proc
					use(var/mob/m,var/obj/items/i)
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				New()
					..()
					spawn(rand(1,10))
						if(src)
							animate(src,pixel_y = 2,time = 10,loop = -1)
							animate(pixel_y = 0, time = 10)
			ectoplasm_positive//, gives Force, lowers lifespan
				name = "Positive Ectoplasm"
				icon_state = "ectoplasm positive"
				act = /obj/items/consumables/ectoplasm_positive/proc/use
				act_drop = /obj/items/consumables/ectoplasm_positive/proc/drop
				proc
					use(var/mob/m,var/obj/items/i)
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				New()
					..()
					spawn(rand(1,10))
						if(src)
							animate(src,pixel_y = 2,time = 10,loop = -1)
							animate(pixel_y = 0, time = 10)
			ectoplasm_pure //gives Endurance and resistance, lowers lifespan
				name = "Pure Ectoplasm"
				icon_state = "ectoplasm pure"
				act = /obj/items/consumables/ectoplasm_pure/proc/use
				act_drop = /obj/items/consumables/ectoplasm_pure/proc/drop
				proc
					use(var/mob/m,var/obj/items/i)
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				New()
					..()
					spawn(rand(1,10))
						if(src)
							animate(src,pixel_y = 2,time = 10,loop = -1)
							animate(pixel_y = 0, time = 10)
			turnip //increases Endurance when eaten
				name = "Turnip"
				icon_state = "turnip ground"
				bolted = 1;
				//o_color = "#1eff00"
				rarity = 2
				act = /obj/items/consumables/turnip/proc/use
				act_drop = /obj/items/consumables/turnip/proc/drop
				//Toxic buildup from taking drug

				//Duration in 1/10 seconds

				//Does the drug have a comedown or not, and how long does it last

				//Changed permanently when taken
				end_gain = 1
				metab_gain = 10

				//Changed temporarily when taken

				//Changed temporarily when wears off

				New()
					..()
					src.desc_extra = "[src.create_item_desc()]\n\n"
				proc
					use(var/mob/m,var/obj/items/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to eat food",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to eat food.")
								return
							if(m.hunger > 90)
								m.set_alert("Already full",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already full.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(src.bolted)
							if(src in range(1,usr))
								src.icon_state = "turnip"
								src.bolted = 0;
								animate(src,pixel_y = 32,time = 2,easing = BOUNCE_EASING)
								animate(pixel_y = 0, time = 2)
								animate(transform = turn(matrix(), 90), time = 2, flags = ANIMATION_PARALLEL)
								var/obj/h = new
								h.loc = src.loc
								h.step_x = src.step_x;
								h.step_y = src.step_y;
								h.icon = src.icon
								h.icon_state = "turnip hole"
								return
						else if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			spinach //increases Strength.
				name = "Spinach"
				icon_state = ""
				act = /obj/items/consumables/spinach/proc/use
				act_drop = /obj/items/consumables/spinach/proc/drop
				proc
					use(var/mob/m,var/obj/items/i)
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			sage //Gives Force
				name = "Sage"
				icon_state = ""
				act = /obj/items/consumables/sage/proc/use
				act_drop = /obj/items/consumables/sage/proc/drop
				proc
					use(var/mob/m,var/obj/items/i)
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			kelp //Gives Resistance
				name = "Kelp"
				icon_state = ""
				act = /obj/items/consumables/kelp/proc/use
				act_drop = /obj/items/consumables/kelp/proc/drop
				proc
					use(var/mob/m,var/obj/items/i)
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			divine_fruit_overripe
				name = "Overripe Divine Fruit"
				icon_state = "divine fruit grown"
				//o_color = "#a335ee"
				rarity = 4
				desc_extra = "When Eaten:\n\n<font color = green>+ 10 Divine Energy</font>\n\n<font color = green>+ 10 Lifespan</font>\n\n<font color = green>+ 1 levels in all organs</font>\n\n"
				act = /obj/items/consumables/divine_fruit_overripe/proc/use
				act_drop = /obj/items/consumables/divine_fruit_overripe/proc/drop
				//Toxic buildup from taking drug

				//Duration in 1/10 seconds

				//Does the drug have a comedown or not, and how long does it last

				//Changed permanently when taken
				divine_eng_gain = 10
				metab_gain = 100
				hydro_gain = 100
				tiredness_gain = 100
				lifespan_gain = 10
				lvl_parts = list("Organ")
				lvl_parts_num = 1

				//Changed temporarily when taken

				//Changed temporarily when wears off

				New()
					..()
					src.desc_extra = "[src.create_item_desc()]\n\n"
				proc
					use(var/mob/m,var/obj/items/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to eat food",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to eat food.")
								return
							if(m.hunger > 90)
								m.set_alert("Already full",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already full.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								for(var/obj/body_related/bodyparts/torso/trs in m.bodyparts)
									for(var/obj/body_related/bodyparts/torso/stomach/stm in trs)
										m.damage_limb(m,0, 1, 100,stm)
										break
									for(var/obj/body_related/bodyparts/torso/large_intestines/int in trs)
										m.damage_limb(m,0, 1, 100,int)
									for(var/obj/body_related/bodyparts/torso/small_intestines/int in trs)
										m.damage_limb(m,0, 1, 100,int)
										break
								i.use_obj(m)
								m.refresh_inv()
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			divine_fruit //increases Force and Max Divine Energy
				name = "Divine Fruit"
				icon_state = "divine fruit grown"
				//o_color = "#ff8000"
				rarity = 5
				desc_extra = "When Eaten:\n\n<font color = green>+ 50 Divine Energy</font>\n\n<font color = green>+ 100 Lifespan</font>\n\n<font color = green>+ 10 levels in all bodyparts</font>\n\n"
				act = /obj/items/consumables/divine_fruit/proc/use
				act_drop = /obj/items/consumables/divine_fruit/proc/drop
				//Toxic buildup from taking drug

				//Duration in 1/10 seconds

				//Does the drug have a comedown or not, and how long does it last

				//Changed permanently when taken
				divine_eng_gain = 50
				metab_gain = 200
				hydro_gain = 200
				tiredness_gain = 200
				lifespan_gain = 100
				lvl_parts = list("Muscle","Bone","Organ")
				lvl_parts_num = 10

				//Changed temporarily when taken

				//Changed temporarily when wears off

				New()
					..()
					src.desc_extra = "[src.create_item_desc()]\n\n"
				proc
					use(var/mob/m,var/obj/items/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to eat food",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to eat food.")
								return
							if(m.hunger > 90)
								m.set_alert("Already full",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already full.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			spirit_stone
				icon = 'artifacts_small.dmi'
				name = "Spirit Stone"
				rarity = 2
				hp = 1.#INF
				icon_state = "spirit stone1"
				act = /obj/items/consumables/spirit_stone/proc/use
				act_drop = /obj/items/consumables/spirit_stone/proc/drop
				act_load = /obj/items/consumables/spirit_stone/proc/load
				var/fused_key = null
				var/fused_name = null
				var/fused_id = null
				//Toxic buildup from taking drug

				//Duration in 1/10 seconds

				//Does the drug have a comedown or not, and how long does it last

				//Changed permanently when taken
				tiredness_gain = 1
				eng_gain = 1

				//Changed temporarily when taken

				//Changed temporarily when wears off
				proc
					load(var/obj/items/consumables/spirit_stone/i)
						i.vis_contents = null
						i.filters = null
						if(i.infused == 2 || i.infused == 3)
							i.filters += filter(type="outline",size=1, color=rgb(204,236,255))
							i.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(102,0,204))

							animate(i.filters[2], size = 2,offset = 2, time = 15, loop = -1)
							animate(size = 0,offset = 0, time = 15, loop = -1)

							i.vis_contents += new/obj/effects/dark_matter_energy
					use(var/mob/m,var/obj/items/consumables/i)
						if(i in m)
							if(i.infused == 3) return
							if(m.eating)
								m.set_alert("Already absorbing",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already absorbing.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				New()
					..()
					spawn(10)
						if(src)
							if(ismob(src.loc) || isobj(src.loc)) return
							src.icon_state = "spirit stone[rand(1,5)]"
							src.filters = null
							var/proceed = 0
							if(src.infused == 1) proceed = 1
							else if(src.infused == 2) proceed = 2
							else if(src.infused == 3) proceed = 3
							else if(prob(5)) proceed = 1
							else if(prob(0.5)) proceed = 2
							if(proceed >= 2)
								src.filters += filter(type="outline",size=1, color=rgb(204,236,255))
								src.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(102,0,204))

								animate(src.filters[2], size = 2,offset = 2, time = 15, loop = -1)
								animate(size = 0,offset = 0, time = 15, loop = -1)

								//src.stacks = -1
								src.tech_lvl = 3
								src.vis_contents += new/obj/effects/dark_matter_energy
								src.name = "Black Spirit Stone"
								src.icon_state = "black spirit stone"
								src.infused = 2
								src.rarity = 5
								src.tiredness_gain = 100
								src.eng_gain = 10
								src.lifespan_gain = 100
								src.dark_matter_gain = 50
								src.lvl_parts = list("Muscle","Bone","Organ")
								src.lvl_parts_num = 10
								src.desc_extra = "When absorbed:\n\n<font color = green>+ 100 Lifespan</font>\n\n<font color = green>+ 50 Dark Matter</font>\n\n+ <font color = green>10 Levels in all bodyparts</font>\n\nUsed in: Lichdom ritual\n\n"
								src.desc = "Description: An exceedingly rare spirit stone which has managed to absorb a large quantity of Dark Matter. Their already unique crystal lattices seem to vibrate on a primordial level, creating a higher dimensional hyper tesseract capable of housing anything from normal matter to more exotic substances, such as anima. These particular stones are often used in extremely powerful scientific experiments or as a ritual material for certain ascensions, such as Lichdom."
							else if(proceed == 1)
								//src.stacks = -1
								src.tech_lvl = 2
								src.icon_state = "spirit stone[rand(1,5)]"
								src.filters += filter(type="outline",size=1, color=rgb(204,236,255))
								src.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(0,160,230))

								animate(src.filters[2], size = 2,offset = 2, time = 15, loop = -1)
								animate(size = 0,offset = 0, time = 15, loop = -1)

								src.infused = 1
								src.tiredness_gain = 10
								src.eng_gain = 10
								src.desc_extra = "<font color = green>+ 10 Max Energy</font>\n\n<font color = green>+ 10% Energy</font>\n\n"
								src.name = "Infused Spirit Stone"
								src.rarity = 3
							src.desc_extra = "[src.create_item_desc()]\n\n"
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			lotus_flower //increases Force and Max Divine Energy
				name = "Lotus Flower"
				rarity = 3
				icon_state = "lotus flower"
				act = /obj/items/consumables/lotus_flower/proc/use
				act_drop = /obj/items/consumables/lotus_flower/proc/drop
				//Toxic buildup from taking drug

				//Duration in 1/10 seconds

				//Does the drug have a comedown or not, and how long does it last

				//Changed permanently when taken
				force_gain = 1
				divine_eng_gain = 1
				metab_gain = 1
				hydro_gain = 1

				//Changed temporarily when taken

				//Changed temporarily when wears off
				proc
					use(var/mob/m,var/obj/items/consumables/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to eat food",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to eat food.")
								return
							if(m.hunger > 90)
								m.set_alert("Already full",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already full.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				New()
					..()
					spawn(10)
						if(src)
							if(ismob(src.loc) || isobj(src.loc)) return
							var/proceed = 0
							if(src.infused) proceed = 1
							else if(prob(10)) proceed = 1
							if(proceed)
								src.infused = 1
								//src.stacks = -1
								src.tech_lvl = 2
								src.force_gain = 10
								src.divine_eng_gain = 10
								src.filters += filter(type="outline",size=1, color=rgb(255,255,170))
								src.vis_contents += new/obj/effects/divine_energy
								src.name = "Divine Lotus Flower"
								src.rarity = 4
								src.desc_extra = "When Eaten:\n\n<font color = green>+ 10 levels in Force</font>\n\n<font color = green>+ 10 Divine Energy</font>\n\n"
							src.desc_extra = "[src.create_item_desc()]\n\n"
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			milk //Gives endurance and bone exp
				name = "Milk"
				icon_state = ""
				act = /obj/items/consumables/milk/proc/use
				act_drop = /obj/items/consumables/milk/proc/drop
				proc
					use(var/mob/m,var/obj/items/i)
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
			ancient_bone
				name = "Ancient Bone"
				rarity = 1
				icon_state = "ancient bone"
				desc = "Old bones from a time long forgotten, sat dormant and slowly turning to stone. Grinding them into powder and consuming them would grant a boost in ones Endurance, but at the cost of Lifespan. Sometimes these are so old as to be saturated in dark energy, overflowing with power."
				desc_extra = "When Eaten:\n\n<font color = green>+ 1 level in Endurance</font>\n\n-<font color = red> 1 Lifespan</font>\n\n"
				act = /obj/items/consumables/ancient_bone/proc/use
				act_drop = /obj/items/consumables/ancient_bone/proc/drop
				//Toxic buildup from taking drug

				//Duration in 1/10 seconds

				//Does the drug have a comedown or not, and how long does it last

				//Changed permanently when taken
				end_gain = 1
				lifespan_gain = -1
				hydro_gain = -1

				//Changed temporarily when taken

				//Changed temporarily when wears off
				New()
					..()
					src.desc_extra = "[src.create_item_desc()]\n\n"
				proc
					use(var/mob/m,var/obj/items/consumables/i)
						if(i in m)
							if(m.eating)
								m.set_alert("Already absorbing",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already absorbing.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							src.pixel_x = 0
							src.pixel_y = 0
							usr.pickup(src,2)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			shroom_psi //Gives Max Psionic Power
				name = "Psi Mushroom"
				rarity = 3
				icon_state = "psi shroom"
				desc = "Mushrooms have been known to absorb the properties of their surroundings, even going as far as soaking up ambient radioactive material. In the case of the Psi Shroom, an oversaturation of Psionic Power seems to have caused it to grow.\n\nWhether its morphology is derived from an already known species of fungus, which happened to absorb Psionic Energy, or an entirely new organism, is unknown. What is known is when consumed, this fungus seems to grant Psionic Power and enhances the body."
				desc_extra = "When Eaten:\n\n<font color = green>+ 1 level in Psionic Power</font>\n\n<font color = green>+ 1 level in random bodypart</font>\n\n"
				act = /obj/items/consumables/shroom_psi/proc/use
				act_drop = /obj/items/consumables/shroom_psi/proc/drop
				//Toxic buildup from taking drug

				//Duration in 1/10 seconds

				//Does the drug have a comedown or not, and how long does it last

				//Changed permanently when taken
				psi_gain = 1
				metab_gain = 5
				lvl_rand_part = 1
				lvl_rand_num = 1

				//Changed temporarily when taken

				//Changed temporarily when wears off
				proc
					use(var/mob/m,var/obj/items/consumables/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to eat food",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to eat food.")
								return
							if(m.hunger > 90)
								m.set_alert("Already full",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already full.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				New()
					..()
					spawn(10)
						if(src)
							if(ismob(src.loc) || isobj(src.loc)) return

							var/obj/shad = new
							shad.icon = src.icon
							shad.icon_state = "shad"
							shad.loc = src.loc
							shad.bolted = 2
							src.shadow = shad

							var/proceed = 0
							if(src.infused) proceed = 1
							else if(prob(5)) proceed = 1
							if(proceed)
								//src.stacks = -1
								src.tech_lvl = 2
								src.infused = 1
								src.psi_gain = 10
								src.lvl_rand_num = 10
								src.filters += filter(type="outline",size=1, color=rgb(204,236,255))
								src.filters += filter(type="outline",size=1, color=rgb(102,0,204))
								src.vis_contents += new/obj/effects/dark_matter_energy
								src.rarity = 4
								src.name = "Infused Psi Mushroom"
								src.desc_extra = "When Eaten:\n\n<font color = green>+ 10 levels in Psionic Power</font>\n\n<font color = green>+ 1 level in 10 random bodyparts</font>\n\n"
							src.desc_extra = "[src.create_item_desc()]\n\n"

				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			fossilized_part //Consumed by Demon/Celestial to gain a bodypart
				icon = 'consumables.dmi'
				icon_state = "fossilized organ"
				name = "fossilized part"
				rarity = 2
				hashadow = 0
				stacks = -1
				desc = "A fossilized part from some long dead eldritch creature or being, left to ossify over aeons. It seems to consist of pure concentrated ectoplasm and thrums with power."
				act = /obj/items/consumables/fossilized_part/proc/use
				act_drop = /obj/items/consumables/fossilized_part/proc/drop
				var/part_type_path
				var/part_infusion
				//Toxic buildup from taking drug

				//Duration in 1/10 seconds

				//Does the drug have a comedown or not, and how long does it last

				//Changed permanently when taken

				//Changed temporarily when taken

				//Changed temporarily when wears off
				proc
					slide(var/obj/items/misc/bonepile/b)
						spawn(1)
							if(src && b)
								var/steps = 10
								var/d = pick(b.ang)
								b.ang -= d
								while(steps)
									steps -= 1
									src.MoveAng(d,4,0,0,null)
									sleep(0.3)
					use(var/mob/m,var/obj/items/consumables/fossilized_part/i)
						if(i in m)
							if(m.race != "Demon" && m.race != "Celestial")
								m.set_alert("Must be Demon or Celestial",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Must be a Demon or Celestial.")
								return
							if(m.has_body == 0)
								m.set_alert("Need body first",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Need body first.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							if(m.organ_grow >= m.total_organs+1)
								m << "All bodyparts grown."
								m.set_alert("All bodyparts gained already",'alert.dmi',"alert")
								m.create_chat_entry("alerts","All bodyparts gained already.")
								return
							var/dupe = 0
							var/obj/body_related/bodyparts/part
							var/obj/body_related/bodyparts/part_dest
							if(i.part_type_path)

								//Head
								if(ispath(i.part_type_path,/obj/body_related/bodyparts/head/))
									var/obj/body_related/bodyparts/head/h = m.bodyparts[1]
									for(var/obj/body_related/bodyparts/b in h)
										if(i.part_type_path == b.type)
											dupe = 1
											break
									if(dupe == 0)
										part_dest = h
										part = new i.part_type_path
									else
										m.set_alert("Already have this part",'alert.dmi',"alert")
										m.create_chat_entry("alerts","Already have this part.")
										return

								//Torso
								if(ispath(i.part_type_path,/obj/body_related/bodyparts/torso/))
									var/obj/body_related/bodyparts/torso/h = m.bodyparts[2]
									for(var/obj/body_related/bodyparts/b in h)
										if(i.part_type_path == b.type)
											dupe = 1
											break
									if(dupe == 0)
										part_dest = h
										part = new i.part_type_path
									else
										m.set_alert("Already have this part",'alert.dmi',"alert")
										m.create_chat_entry("alerts","Already have this part.")
										return

								//Left Arm
								if(ispath(i.part_type_path,/obj/body_related/bodyparts/left_arm/))
									var/obj/body_related/bodyparts/left_arm/t = m.bodyparts[3]
									for(var/obj/body_related/bodyparts/b in t)
										if(i.part_type_path == b.type)
											dupe = 1
											break
									if(dupe == 0)
										part_dest = t
										part = new i.part_type_path
									else
										m.set_alert("Already have this part",'alert.dmi',"alert")
										m.create_chat_entry("alerts","Already have this part.")
										return

								//Right Arm
								if(ispath(i.part_type_path,/obj/body_related/bodyparts/right_arm/))
									var/obj/body_related/bodyparts/right_arm/t = m.bodyparts[4]
									for(var/obj/body_related/bodyparts/b in t)
										if(i.part_type_path == b.type)
											dupe = 1
											break
									if(dupe == 0)
										part_dest = t
										part = new i.part_type_path
									else
										m.set_alert("Already have this part",'alert.dmi',"alert")
										m.create_chat_entry("alerts","Already have this part.")
										return

								//Right Leg
								if(ispath(i.part_type_path,/obj/body_related/bodyparts/right_leg/))
									var/obj/body_related/bodyparts/right_leg/t = m.bodyparts[5]
									for(var/obj/body_related/bodyparts/b in t)
										if(i.part_type_path == b.type)
											dupe = 1
											break
									if(dupe == 0)
										part_dest = t
										part = new i.part_type_path
									else
										m.set_alert("Already have this part",'alert.dmi',"alert")
										m.create_chat_entry("alerts","Already have this part.")
										return

								//Left Leg
								if(ispath(i.part_type_path,/obj/body_related/bodyparts/left_leg/))
									var/obj/body_related/bodyparts/left_leg/t = m.bodyparts[6]
									for(var/obj/body_related/bodyparts/b in t)
										if(i.part_type_path == b.type)
											dupe = 1
											break
									if(dupe == 0)
										part_dest = t
										part = new i.part_type_path
									else
										m.set_alert("Already have this part",'alert.dmi',"alert")
										m.create_chat_entry("alerts","Already have this part.")
										return

							var/T = world.time
							m.eating = i
							i.time_eaten = T
							m.eat()
							sleep(global.eat_time)
							if(i && m && m.eating == i && i.loc == m && i.time_eaten == T)
								m.icon_state = m.state()
								if(m.hud_eat)
									m.vis_contents -= m.hud_eat
									m.stunned -= 1
									m.stunned_pending -= 1

								if(part && dupe == 0 && part_dest)
									part.loc = part_dest
									part.name = part.info_name
									part.i_state = part.icon_state
									part.part_exp = 500
									part.part_reward(m,1)
									if(part.type == /obj/body_related/bodyparts/torso/stomach) m.has_stomach = 1
									m.screen_text.maptext = "<font size = 6><center>[part] absorbed"
									animate(m.screen_text,alpha = 255,time = 60)
									animate(alpha = 0,time = 60)
									if(i.part_infusion == "dark")
										part.i_state = "[initial(part.icon_state)] dark"
										part.icon_state = part.i_state
										part.infused_dark = 1
										part.part_exp = 1000
										part.part_reward(m,1)
										if(i.rarity >= 4)
											part.part_exp = 1500
											part.part_reward(m,1)
										if(i.rarity == 5)
											part.part_exp = 3000
											part.part_reward(m,1)

								if(i && m && i.loc == m && i == m.eating && i.time_eaten == T)
									i.use_obj(m)
									m.refresh_inv()
									if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				New()
					..()
					spawn(10)
						if(src)
							if(ismob(src.loc)) return// || isobj(src.loc)) return

							var/obj/shad = new
							shad.icon = 'fx.dmi'
							shad.icon_state = "shadow"
							shad.loc = src.loc
							shad.bolted = 2
							//shad.appearance_flags = RESET_TRANSFORM | KEEP_APART
							//src.vis_contents += shad
							src.shadow = shad

							var/obj/body_related/p = pick(global.grow_order)
							src.part_type_path = p.type
							if(p.bodypart_type == "Organ") src.icon_state = "fossilized organ"
							else if(p.bodypart_type == "Muscle") src.icon_state = "fossilized muscle"
							else if(p.bodypart_type == "Bone") src.icon_state = "fossilized bone"
							src.name = "Fossilized [p.info_name]"
							spawn(rand(0,60))
								if(src)
									animate(src, pixel_y = 6, time = 10, loop = -1,easing= ANIMATION_RELATIVE, flags = BACK_EASING)
									animate(pixel_y = 4, time = 10)
							if(prob(10))
								src.rarity = 3
								if(prob(10))
									src.rarity = 4
							if(src.rarity >= 3)
								src.part_infusion = "dark"
								src.filters = null
								src.filters += filter(type="outline",size=1, color=rgb(204,236,255))
								src.filters += filter(type="outline",size=1, color=rgb(102,0,204))
								src.name = "Ancient Fossilized [p.info_name]"
							if(src.rarity >= 4)
								src.name = "Primordial Fossilized [p.info_name]"
								src.filters += filter(type="drop_shadow", x=0, y=0, size=0, offset=1, color=rgb(0,0,0))
								animate(src.filters[src.filters.len], size = 3,offset = 1, time = 20, loop = -1)
								animate(size = 0,offset = 1, time = 20)
								src.vis_contents += new/obj/effects/dark_matter_energy

								var/obj/rays = new
								rays.icon = 'fx_ray_small.dmi'
								rays.pixel_x = -16
								rays.pixel_y = -17
								rays.bolted = 2
								rays.step_y = 12
								rays.layer = src.layer-1
								rays.filters += filter(type="rays",x=0,y=0,size=64,color=rgb(0,0,0),offset=0,density=10,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
								animate(rays.filters[1],offset = 100,time = 3333, loop = -1)
								animate(offset = 0,time = 0)
								src.vis_contents += rays

							src.desc_extra = "When Absorbed:\n\n<font color = green>Gain [p.info_name]</font>\n\n"

				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			crystallized_part //Consumed by Demon/Celestial to gain a bodypart
				icon = 'consumables.dmi'
				icon_state = "crystallized organ"
				name = "crystallized part"
				rarity = 2
				hashadow = 0
				stacks = -1
				desc = "A crystallized part from a long-since deceased being or entity. It seems to consist of pure concentrated ectoplasm and thrums with power."
				act = /obj/items/consumables/crystallized_part/proc/use
				act_drop = /obj/items/consumables/crystallized_part/proc/drop
				var/part_type_path
				var/part_infusion
				//Toxic buildup from taking drug

				//Duration in 1/10 seconds

				//Does the drug have a comedown or not, and how long does it last

				//Changed permanently when taken

				//Changed temporarily when taken

				//Changed temporarily when wears off
				proc
					use(var/mob/m,var/obj/items/consumables/crystallized_part/i)
						if(i in m)
							if(m.race != "Demon" && m.race != "Celestial")
								m.set_alert("Must be Demon or Celestial",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Must be a Demon or Celestial.")
								return
							if(m.has_body == 0)
								m.set_alert("Need body first",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Need body first.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							if(m.organ_grow >= m.total_organs+1)
								m << "All bodyparts grown."
								m.set_alert("All bodyparts gained already",'alert.dmi',"alert")
								m.create_chat_entry("alerts","All bodyparts gained already.")
								return
							var/dupe = 0
							var/obj/body_related/bodyparts/part
							var/obj/body_related/bodyparts/part_dest
							if(i.part_type_path)

								//Head
								if(ispath(i.part_type_path,/obj/body_related/bodyparts/head/))
									var/obj/body_related/bodyparts/head/h = m.bodyparts[1]
									for(var/obj/body_related/bodyparts/b in h)
										if(i.part_type_path == b.type)
											dupe = 1
											break
									if(dupe == 0)
										part_dest = h
										part = new i.part_type_path
									else
										m.set_alert("Already have this part",'alert.dmi',"alert")
										m.create_chat_entry("alerts","Already have this part.")
										return

								//Torso
								if(ispath(i.part_type_path,/obj/body_related/bodyparts/torso/))
									var/obj/body_related/bodyparts/torso/h = m.bodyparts[2]
									for(var/obj/body_related/bodyparts/b in h)
										if(i.part_type_path == b.type)
											dupe = 1
											break
									if(dupe == 0)
										part_dest = h
										part = new i.part_type_path
									else
										m.set_alert("Already have this part",'alert.dmi',"alert")
										m.create_chat_entry("alerts","Already have this part.")
										return

								//Left Arm
								if(ispath(i.part_type_path,/obj/body_related/bodyparts/left_arm/))
									var/obj/body_related/bodyparts/left_arm/t = m.bodyparts[3]
									for(var/obj/body_related/bodyparts/b in t)
										if(i.part_type_path == b.type)
											dupe = 1
											break
									if(dupe == 0)
										part_dest = t
										part = new i.part_type_path
									else
										m.set_alert("Already have this part",'alert.dmi',"alert")
										m.create_chat_entry("alerts","Already have this part.")
										return

								//Right Arm
								if(ispath(i.part_type_path,/obj/body_related/bodyparts/right_arm/))
									var/obj/body_related/bodyparts/right_arm/t = m.bodyparts[4]
									for(var/obj/body_related/bodyparts/b in t)
										if(i.part_type_path == b.type)
											dupe = 1
											break
									if(dupe == 0)
										part_dest = t
										part = new i.part_type_path
									else
										m.set_alert("Already have this part",'alert.dmi',"alert")
										m.create_chat_entry("alerts","Already have this part.")
										return

								//Right Leg
								if(ispath(i.part_type_path,/obj/body_related/bodyparts/right_leg/))
									var/obj/body_related/bodyparts/right_leg/t = m.bodyparts[5]
									for(var/obj/body_related/bodyparts/b in t)
										if(i.part_type_path == b.type)
											dupe = 1
											break
									if(dupe == 0)
										part_dest = t
										part = new i.part_type_path
									else
										m.set_alert("Already have this part",'alert.dmi',"alert")
										m.create_chat_entry("alerts","Already have this part.")
										return

								//Left Leg
								if(ispath(i.part_type_path,/obj/body_related/bodyparts/left_leg/))
									var/obj/body_related/bodyparts/left_leg/t = m.bodyparts[6]
									for(var/obj/body_related/bodyparts/b in t)
										if(i.part_type_path == b.type)
											dupe = 1
											break
									if(dupe == 0)
										part_dest = t
										part = new i.part_type_path
									else
										m.set_alert("Already have this part",'alert.dmi',"alert")
										m.create_chat_entry("alerts","Already have this part.")
										return

							var/T = world.time
							m.eating = i
							i.time_eaten = T
							m.eat()
							sleep(global.eat_time)
							if(i && m && m.eating == i && i.loc == m && i.time_eaten == T)
								m.icon_state = m.state()
								if(m.hud_eat)
									m.vis_contents -= m.hud_eat
									m.stunned -= 1
									m.stunned_pending -= 1

								if(part && dupe == 0 && part_dest)
									part.loc = part_dest
									part.name = part.info_name
									part.i_state = part.icon_state
									part.part_exp = 500
									part.part_reward(m,1)
									if(part.type == /obj/body_related/bodyparts/torso/stomach) m.has_stomach = 1
									m.screen_text.maptext = "<font size = 6><center>[part] absorbed"
									animate(m.screen_text,alpha = 255,time = 60)
									animate(alpha = 0,time = 60)
									if(i.part_infusion == "divine")
										part.i_state = "[initial(part.icon_state)] divine"
										part.icon_state = part.i_state
										part.infused_dark = 1
										part.part_exp = 1000
										part.part_reward(m,1)

								if(i && m && i.loc == m && i == m.eating && i.time_eaten == T)
									i.use_obj(m)
									m.refresh_inv()
									if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				New()
					..()
					spawn(10)
						if(src)
							if(ismob(src.loc)) return// || isobj(src.loc)) return

							var/obj/shad = new
							shad.icon = 'fx.dmi'
							shad.icon_state = "shadow"
							shad.loc = src.loc
							shad.bolted = 2
							src.shadow = shad

							var/obj/body_related/p = pick(global.grow_order)
							src.part_type_path = p.type
							if(p.bodypart_type == "Organ") src.icon_state = "crystallized organ"
							else if(p.bodypart_type == "Muscle") src.icon_state = "crystallized muscle"
							else if(p.bodypart_type == "Bone") src.icon_state = "crystallized bone"
							src.name = "Crystallized [p.info_name]"
							spawn(rand(0,60))
								if(src)
									animate(src, pixel_y = 6, time = 10, loop = -1,flags = BACK_EASING)
									animate(pixel_y = 4, time = 10)
							if(prob(10))
								src.rarity = 3
								if(prob(10))
									src.rarity = 4
							if(src.rarity >= 3)
								src.part_infusion = "divine"
								src.filters = null
								src.filters += filter(type="outline",size=1, color=rgb(255,255,255))
								src.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(102,204,255))
								src.name = "Ancient Crystallized [p.info_name]"
							if(src.rarity >= 4)
								src.name = "Primordial Crystallized [p.info_name]"
								src.vis_contents += new/obj/effects/divine_energy

								var/obj/rays = new
								rays.icon = 'fx_ray_small.dmi'
								rays.pixel_x = -16
								rays.pixel_y = -17
								rays.bolted = 2
								rays.step_y = 12
								rays.layer = src.layer-1
								rays.filters += filter(type="rays",x=0,y=0,size=64,color=rgb(255,255,255),offset=0,density=10,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
								animate(rays.filters[1],offset = 100,time = 3333, loop = -1)
								animate(offset = 0,time = 0)
								src.vis_contents += rays


							src.desc_extra = "When Absorbed:\n\n<font color = green>Gain [p.info_name]</font>\n\n"

				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			shroom_red //Gives resistance
				name = "Amanita muscaria"
				icon_state = "redcap"
				//o_color = "#1eff00"
				rarity = 2
				desc = "Amanita muscaria, commonly known as the fly agaric or fly amanita, is a poisonous mushroom, granting a level in resistance when consumed. Be wary, as eating it will also remove 1% of your health."
				desc_extra = "When Eaten:\n\n<font color = green>+ 1 level in Resistance</font>\n\n-<font color = red> 1% health</font>\n\n"
				act = /obj/items/consumables/shroom_red/proc/use
				act_drop = /obj/items/consumables/shroom_red/proc/drop
				//Toxic buildup from taking drug
				toxic = 1
				toxin_gain = 0.0001
				toxicity = 50

				//Duration in 1/10 seconds
				duration = 6000

				//Does the drug have a comedown or not, and how long does it last

				//Changed permanently when taken
				res_gain = 1
				metab_gain = 5
				lifespan_gain = -1

				//Changed temporarily when taken
				recov_gain_temp = -1
				regen_gain_temp = -1


				//Changed temporarily when wears off

				New()
					..()
					src.desc_extra = "[src.create_item_desc()]\n\n"
				proc
					use(var/mob/m,var/obj/items/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to eat food",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to eat food.")
								return
							if(m.hunger > 90)
								m.set_alert("Already full",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already full.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							if(i.toxic)
								var/repeat = i.apply_same_drug(m)
								if(repeat == 0) i.create_drug_buff(m)
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			bean_arabica //Gives Max Energy and boosts Recovery
				name = "Arabica Bean"
				icon_state = "bean"
				//o_color = "#1eff00"
				rarity = 2
				act = /obj/items/consumables/bean_arabica/proc/use
				act_drop = /obj/items/consumables/bean_arabica/proc/drop
				//Toxic buildup from taking drug

				//Duration in 1/10 seconds

				//Does the drug have a comedown or not, and how long does it last

				//Changed permanently when taken
				metab_gain = 5
				lvl_parts = list("Heart")
				lvl_parts_num = 0.1

				//Changed temporarily when taken

				//Changed temporarily when wears off

				New()
					..()
					src.desc_extra = "[src.create_item_desc()]\n\n"
				proc
					use(var/mob/m,var/obj/items/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to eat food",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to eat food.")
								return
							if(m.hunger > 90)
								m.set_alert("Already full",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already full.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			shroom_truffle //Gives Strength, Endurance and Max Energy
				name = "Truffle"
				icon_state = "truffle"
				//o_color = "#0070dd"
				rarity = 3
				desc = "These very rare types of fungus are potent and useful for someone seeking a strong and endurant body. Eating one not only heals you slightly, but also gives a level in Strength, Endurance and Energy."
				desc_extra = "When Eaten:\n\n<font color = green>+ 1 level in Energy</font>\n\n<font color = green>+ 1 level in Strength</font>\n\n<font color = green>+ 1 level in Endurance</font>\n\n<font color = green>+ 1% health</font>\n\n"
				act = /obj/items/consumables/shroom_truffle/proc/use
				act_drop = /obj/items/consumables/shroom_truffle/proc/drop
				//Toxic buildup from taking drug

				//Duration in 1/10 seconds

				//Does the drug have a comedown or not, and how long does it last

				//Changed permanently when taken
				metab_gain = 10
				eng_gain = 1
				str_gain = 1
				end_gain = 1

				//Changed temporarily when taken

				//Changed temporarily when wears off

				New()
					..()
					src.desc_extra = "[src.create_item_desc()]\n\n"
				proc
					use(var/mob/m,var/obj/items/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to eat food",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to eat food.")
								return
							if(m.hunger > 90)
								m.set_alert("Already full",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already full.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			manuka_honey //boosts Regen for a while, increase lifespan. (Little bee nests in trees you can womp)
				name = "Manuka Honey"
				icon_state = "honey 1"
				act = /obj/items/consumables/manuka_honey/proc/use
				act_drop = /obj/items/consumables/manuka_honey/proc/drop
				proc
					use(var/mob/m,var/obj/items/i)
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				New()
					..()
					src.icon_state = "honey [rand(1,2)]"
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			honeydew //boosts Recovery for a while. (Created each day, can harvest it by walking through longrass)
				name = "Honeydew"
				icon_state = "honeydew"
				act = /obj/items/consumables/honeydew/proc/use
				act_drop = /obj/items/consumables/honeydew/proc/drop
				proc
					use(var/mob/m,var/obj/items/i)
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			zarberry //increases all stats slightly, boosts regen for a while.
				name = "Zarberry"
				icon = 'artifacts_small.dmi'
				icon_state = "zarberry"
				//o_color = "#a335ee"
				rarity = 4
				act = /obj/items/consumables/zarberry/proc/use
				act_drop = /obj/items/consumables/zarberry/proc/drop
				desc_extra = "When Eaten:\n\n<font color = green>+ 1 level in all organs</font>\n\n"
				//Toxic buildup from taking drug

				//Duration in 1/10 seconds

				//Does the drug have a comedown or not, and how long does it last

				//Changed permanently when taken
				metab_gain = 25
				hydro_gain = 25
				lvl_parts = list("Organ")
				lvl_parts_num = 1

				//Changed temporarily when taken

				//Changed temporarily when wears off

				New()
					..()
					src.desc_extra = "[src.create_item_desc()]\n\n"
				proc
					use(var/mob/m,var/obj/items/i)
						if(i in m)
							if(m.has_stomach == 0 || m.has_body == 0)
								m.set_alert("Unable to eat food",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Unable to eat food.")
								return
							if(m.hunger > 90)
								m.set_alert("Already full",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already full.")
								return
							if(m.eating)
								m.set_alert("Already eating",'alert.dmi',"alert")
								m.create_chat_entry("alerts","Already eating.")
								return
							var/T = world.time
							i.apply_item_stats(m,T)
							if(i && m && i.loc == m && i.stacks > 0 && i == m.eating && i.time_eaten == T)
								i.use_obj(m)
								m.refresh_inv()
								if(m) m.eating = null
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
		artifacts
			invul_melee = 1
			mouse_over_pointer = MOUSE_ACTIVE_POINTER
			hashadow = 1
			hp = 1.#INF
			legendary = 1
			rarity = 5
				/*
				New()
					..()
					spawn(rand(10,20))
						if(src)
							src.waves()
							src.filters += filter(type="drop_shadow", x=0, y=0,size=5, offset=2, color=rgb(255,255,170))
							src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)

							animate(src,pixel_y = 6,time = 15, loop = -1, flags = ANIMATION_PARALLEL)
							animate(pixel_y = 0,time = 15)
							animate(src, transform = matrix()*1.5, time = 10, loop = -1,flags=ANIMATION_PARALLEL)
							animate(transform = matrix()*1, time = 10)
				*/
			/*
			Shards for each enviromental effect that makes you immune when holding them.

			Fire Shard
				- Grants immunity to heat while held
				- Looks like a shard of crystal, red/orange with a white outline and pulsating orange/red light. Has a ember particle effect attached to it.
				- Found inside the heart of Earth's volcano? Or maybe found underground, inside the heart of the Demonic portion of the psi realm.
			Ice Shard
				- Grants immunity to cold while held
				- Looks like a shard of Ice/Black Ice, glows slightly with a faint outline, like the shard in the psi realm. Has a snow particle effect attached to it.
				- Found underground either on Earth, or perhaps in the Celestial portion of the psi realm.
			Gravity Shard
				- Grants immunity to gravity while held
				- Looks like a diamond shaped crystal, like a mini black hole.
				- Found inside Dark Matter Realm, so players can't use it to enter the realm, since you need high/inf grav mastered to enter that realm.
			Radiation Shard
				- Grants immunity to radiation while held
				- Looks like a dodecahedron, glows like the radiation crystals.
				- Maybe found locked inside a lab/power plant on Earth
			Microwave Shard
				- Grants immunity to microwaves while held
				- Looks like a shard of crystal, and has ligthning crackling around it.
				- Found on Yukopia
			Toxin Shard
				- Grants immunity to toxins while held
				- Looks like a green spikey crystal shard with an aura of toxic around it.
				- Found inside a sentient super rare plant that attacks players when they are near.
			*/
			immunity_shards
				heat_shard
				cold_shard
				gravity_shard
				radiation_shard
				microwave_shard
				toxin_shard
			continuum_gems
				//These are dropped by bosses
				power_gem
					//increases power mod
					//gives passive xp toward power
					//age quicker, since it takes more energy from the body to function.
				agility_gem
					//increases agility mod
					//gives passive xp toward agility
					//age quicker, since you move quicker through time and space.
				regeneration_gem
					//increases regen mod
					//makes you hungry quicker, since it takes more energy from the body to function.
				awareness_gem
					//Lets you see everyone, everywhere, at all times
					//Adds everyone to your contacts list
					//Gives contact exp, even if not near contacts
				defence_gem
					//increases def mod
					//gives passive xp toward def
				intelligence_gem
					//increases int mod
					//gives passive xp toward skill levels
					//Makes you sleepy quicker, since it takes more energy from the body to function.
				strength_gem
					//increases str mod
					//gives passive xp toward str
				energy_gem
					//increases eng mod
					//gives passive xp toward eng
					//Stops the Dantian from being leveled as quickly, or at all.
				force_gem
					//increases force mod
					//gives passive xp toward force
				offence_gem
					//increases off mod
					//gives passive xp toward off
				resistance_gem
					//increases res mod
					//gives passive xp toward res
				endurance_gem
					//increases end mod
					//gives passive xp toward end
				vitality_gem
					//increases lifespan
				equilibrium_gem
					//increases your divine energy and dark matter mods
				recovery_gem
					//increases recovery mod
					//makes you thirsty quicker, since it takes more energy from the body to function.
				paradise_forever
					//All the gems combined spell Paradise Forever
					//Lets you do something completely insane, like make a wish, for example
					//Also gives you the effects of all the gems
					//Unlocks a special ascension of its namesake that basically makes you a god and/or "Psiforged" instantly.
					//Or unlocks a special realm instead
					//When combined, could play a cool animation of all the gems lining up, and as each one does, the letters of their names appear above them, spelling out Paradise Forever.
					//Or could have the letters appear on the screen slowly as the gems line up

			phylactery
				icon = 'artifacts_small.dmi'
				icon_state = "dark matter ball"
				name = "Phylactery"
				can_pocket = 1
				density_factor = 0
				density = 0;
				//plane = 2;
				radius = 5;
				layer = 10
				New()
					spawn(10)
						if(src)
							src.step_y = 12
							src.filters += filter(type="outline",size=1, color=rgb(204,236,255))
							src.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(102,0,204))

							animate(src,pixel_y = 4, time = 15, loop = -1)
							animate(pixel_y = 0, time = 15)
							animate(src.filters[2], size = 2,offset = 2, time = 15, loop = -1,flags = ANIMATION_PARALLEL)
							animate(size = 0,offset = 0, time = 15, loop = -1)

							var/obj/rays = new
							rays.icon = 'fx_ray_small.dmi'
							rays.pixel_x = -16
							rays.pixel_y = -16
							rays.loc = src.loc
							rays.bolted = 2
							rays.step_y = 12
							rays.layer = 9
							rays.filters += filter(type="rays",x=0,y=0,size=56,color=rgb(25,25,25),offset=0,density=10,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
							animate(rays.filters[1],offset = 100,time = 1500, loop = -1)
							animate(offset = 0,time = 0)
							animate(rays.filters[1],y = 4,time = 15, loop = -1, flags = ANIMATION_PARALLEL)
							animate(y = 0, time = 15)


							src.vis_contents += new/obj/effects/dark_matter_energy
			blueprint
				icon = 'artifacts_small.dmi'
				icon_state = "blueprints"
				can_pocket = 1;
			skillbook
				icon = 'artifacts_small.dmi'
				icon_state = "skillbook"
				can_pocket = 1;
				var/contains = null
				New()
					spawn(30)
						if(src)
							var/obj/skills/s = pick(learnable_skills)
							contains = s.type
							src.name = "Skillbook: [s.name]"
				Click(location, control, params)
					..()
					params = params2list(params)
					if(params["right"])
						if(src in usr)
							var/has = 0
							for(var/obj/skills/s in usr)
								if(s.type == src.contains)
									has = 1
									break
							var/obj/I = new src.contains()
							if(has == 0)
								I.loc = usr
								usr.set_alert("Learned new skill: [I.name]",I.icon,I.icon_state)
								usr.create_chat_entry("alerts","Learned new skill: [I.name].")
								src.loc = null
							else
								usr.set_alert("[I.name] already known",src.icon,src.icon_state)
								usr.create_chat_entry("alerts","[I.name] already known.")
								I.loc = null
							usr.refresh_inv()
			psi_orb
				name = "Psi Orb"
				icon = 'artifacts_small.dmi'
				icon_state = "psi orb"
				can_pocket = 1
				disable_logout = 1
				hp = 1.#INF
				act = /obj/items/artifacts/psi_orb/proc/use
				act_drop = /obj/items/artifacts/psi_orb/proc/drop
				var
					tmp/obj/twin = null
				proc
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
					use(var/mob/m,var/obj/items/artifacts/psi_orb/i)
						if(i in range(1,usr))
							if(i.active)
								i.icon_state = "psi orb"
								i.twin.icon_state = "psi orb"
								i.active = 0
								i.twin.active = 0
								i.overlays = null
								i.twin.overlays = null
								i.can_pocket = 1
								i.twin.can_pocket = 1
							else
								if(ismob(i.loc))
									var/mob/x = i.loc
									i.loc = x.loc
								if(ismob(i.twin.loc))
									var/mob/x = i.twin.loc
									i.twin.loc = x.loc
								i.shake()
								i.twin.shake()
								i.shockwave()
								i.twin.shockwave()
								i.icon_state = "psi orb on"
								i.twin.icon_state = "psi orb on"
								i.active = 1
								i.twin.active = 1
								i.can_pocket = 0
								i.twin.can_pocket = 0

								var/obj/p = new
								p.icon = 'fx_portal.dmi'
								p.pixel_x = -50
								p.pixel_y = -52
								p.layer = 50
								p.alpha = 240
								i.overlays += p

								var/obj/p2 = new
								p2.icon = 'fx_portal.dmi'
								p2.pixel_x = -50
								p2.pixel_y = -52
								p2.layer = 50
								p2.alpha = 240
								twin.overlays += p2
				New()
					spawn(10)
						if(src.twin == null)
							var/obj/items/artifacts/psi_orb/o = new
							o.loc = locate(rand(1,500),rand(1,500),1)
							src.twin = o
							o.twin = src
						src.filters += filter(type="drop_shadow", x=0, y=0,\
						size=5, offset=2, color=rgb(100,0,200))
						spawn(10)
							while(src)
								if(ismob(src.loc))
									var/mob/m = src.loc
									for(var/obj/skills/Telekinesis/T in m)
										T.skill_exp += (5/T.skill_lvl)*m.mod_skill
										if(T.skill_exp >= 100 && T.skill_lvl < 100)
											T.skill_exp = 1
											T.skill_lvl += 1
									for(var/obj/skills/Sense/S in m)
										S.skill_exp += (5/S.skill_lvl)*m.mod_skill
										if(S.skill_exp >= 100 && S.skill_lvl < 100)
											S.skill_exp = 1
											S.skill_lvl += 1
								if(src.active)
									for(var/mob/m in range(0,src))
										m.loc = locate(src.twin.x,src.twin.y-1,src.twin.z)
								sleep(1)
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item

			everfrost
				name = "Everfrost"
				icon = 'artifacts_large.dmi'
				icon_state = "frost shard"
				bolted = 3
				hp = 1.#INF
				pixel_x = -16
				pixel_y = -16
				New()
					spawn(10)
						if(src)
							//src.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(102,204,255))


							//src.filters += filter(type="outline",size=1, color=rgb(204,236,255))
							src.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(102,204,255))

							animate(src.filters[1], size = 2,offset = 2, time = 15, loop = -1)
							animate(size = 0,offset = 0, time = 15, loop = -1)

							animate(src,pixel_y = 4,time = 20,loop = -1,flags = ANIMATION_PARALLEL)
							animate(pixel_y = -4, time = 20)
				/*
				proc
					glow()
						animate(src.filters[src.filters.len], offset = 4, time = 5, loop = -1)
						animate(src.filters[src.filters.len], offset = 2, time = 5)

				New()
					spawn(50)
						src.filters += filter(type="drop_shadow", x=0, y=0,\
						size=5, offset=2, color=rgb(255,255,170))
						spawn(50)
							if(src) src.glow()

				Click(location,control,params)
					..()
					params = params2list(params)
					if(params["right"])
						src.compress("right",usr,4,0)
				*/
			tesseract_matrix
				name = "Tesseract Matrix"
				icon = 'artifacts_small.dmi'
				icon_state = "empty"
				disable_logout = 1
				can_activate = 1
				hp = 1.#INF
				proc
					glow()
						animate(src.filters[src.filters.len], offset = 4, time = 5, loop = -1)
						animate(src.filters[src.filters.len], offset = 2, time = 5)

				New()
					spawn(50)
						src.filters += filter(type="drop_shadow", x=0, y=0,\
						size=5, offset=2, color=rgb(255,255,170))
						spawn(50)
							if(src) src.glow()

				Click(location,control,params)
					..()
					params = params2list(params)
					if(params["right"])
						src.compress("right",usr,4,0)
			psionic_shard
				name = "Psionic Shard"
				icon = 'artifacts_small.dmi'
				icon_state = "shard main"
				can_pocket = 1
				proc
					glow()
						while(src)
							animate(src.filters[src.filters.len], offset = 4, time = 5)
							animate(src.filters[src.filters.len], offset = 2, time = 5)
							sleep(10)
				New()
					spawn(50)
						src.filters += filter(type="drop_shadow", x=0, y=0,\
						size=5, offset=2, color=rgb(47,172,255))
						spawn(50)
							src.glow()
				Click(location,control,params)
					..()
					params = params2list(params)
					if(params["right"])
						if(src in range(1,usr))
							if(src.can_pocket == 0) return
							//src.loc = locate(usr.x,usr.y-1,usr.z)
							var/shards = 25
							var/list/shard_bits = list()
							src.can_pocket = 0
							src.shake()
							src.shockwave()
							while(shards)
								shards -= 1
								var/obj/s = new
								s.icon = src.icon
								s.icon_state = pick("shard1","shard2","shard3","shard4")
								s.loc = src.loc
								s.layer = 333
								shard_bits += s
							src.loc = null
							for(var/obj/x in shard_bits)
								var/X = rand(-224,224)
								var/X_continue
								if(X > 0) X_continue=X+33
								else	X_continue=X-33
								animate(x,pixel_y = rand(-224,224),pixel_x = X,transform = turn(matrix(), 240), time = 3,easing = QUAD_EASING)
								animate(pixel_y = x.pixel_y/1.5,pixel_x = X_continue, time = 6,easing = QUAD_EASING,flags = ANIMATION_PARALLEL)
								animate(alpha = 0,time = 100)
							usr.skill_points_combat += 1
							sleep(6)
							for(var/obj/x in shard_bits)
								x.layer = initial(x.layer)
							del(src)
		plants
			hp = 100
			dust = 0
			hashadow = 1
			appearance_flags = TILE_BOUND
			/*
			Cross(atom/movable/O)
				..()
				if(src.shudders) if(O.density_factor)
					animate(src,transform = turn(matrix(), 5), time = 1)
					animate(transform = turn(matrix(), -5), time = 1)
					animate(transform = turn(matrix(), 0), time = 1)
				if(src.density_factor == 0)
					return 1
				if(O.density_factor == 0)
					return 1
			*/
			beanstalk
				name = "Beanstalk"
				icon = 'beanstalk.dmi'
				icon_state = "beanstalk 4"
				bolted = 1
				disable_logout = 1
				hashadow = 0
				hp = 100
				bounds = "14,1 to 19,8"
				density_factor = 1
				can_activate = 1
				var
					berries = 4
				New()
					..()
					spawn(10)
						if(src)
							var/obj/shad = new
							shad.icon = src.icon
							shad.icon_state = "shad"
							shad.pixel_y = -3
							shad.loc = src.loc
							shad.bolted = 2
							src.shadow = shad
							/*
							while(src)
								if(src.berries < 4)
									src.berries += 4
									src.icon_state = "beanstalk [src.berries]"
								sleep(3333)
							*/
				Click(location,control,params)
					..()
					usr.mouse_down = null
					params = params2list(params)
					if(params["left"])
						if(src in range(1,usr))
							if(src.berries > 0)
								src.berries -= 1
								src.icon_state = "beanstalk [src.berries]"
								var/obj/items/consumables/bean_arabica/bean = new
								bean.loc = usr
								usr.pickup(bean)
								usr.refresh_inv()
								spawn(3333)
									if(src && src.berries < 4)
										src.berries += 1
										src.icon_state = "beanstalk [src.berries]"
			zarberry_plant
				name = "Zarberry Plant"
				icon = 'zarberry_plant.dmi'
				icon_state = "zarberry plant 5"
				bolted = 1
				disable_logout = 1
				hashadow = 0
				hp = 100
				bounds = "10,1 to 22,8"
				density_factor = 1
				can_activate = 1
				var
					berries = 5
				New()
					..()
					spawn(10)
						var/obj/shad = new
						shad.icon = src.icon
						shad.icon_state = "shadow"
						shad.alpha = 100
						shad.pixel_y = -3
						shad.loc = src.loc
						shad.bolted = 2
						src.shadow = shad
						/*
						while(src)
							if(src.berries < 5)
								src.berries += 1
								src.icon_state = "zarberry plant [src.berries]"
							sleep(3333)
						*/
				Click(location,control,params)
					..()
					usr.mouse_down = null
					params = params2list(params)
					if(params["left"])
						if(src in range(1,usr))
							if(src.berries > 0)
								src.berries -= 1
								src.icon_state = "zarberry plant [src.berries]"
								var/obj/items/consumables/zarberry/z = new
								z.loc = usr
								usr.pickup(z)
								usr.refresh_inv()
								spawn(3333)
									if(src && src.berries < 5)
										src.berries += 1
										src.icon_state = "zarberry plant [src.berries]"
			tuff
				icon = 'plants.dmi'
				bolted = 1
				icon_state = "tuff1"
				hashadow = 0
				New()
					src.icon_state = "tuff[rand(1,6)]"
					src.pixel_x = rand(-4,4)
					src.pixel_y = rand(-4,4)
			rockgrass
				icon = 'plants.dmi'
				bolted = 1
				icon_state = "rock1"
				hashadow = 0
				New()
					src.icon_state = "rock[rand(1,4)]"
			twig
				icon = 'plants.dmi'
				bolted = 1
				icon_state = "twig1"
				hashadow = 0
				New()
					src.icon_state = "twig[rand(1,2)]"
			lily
				icon = 'plants.dmi'
				bolted = 1
				icon_state = "pad1"
				hashadow = 0
				New()
					var/n = rand(1,4)
					src.icon_state = "pad[n]"
					src.step_x = rand(-16,16)
					src.step_y = rand(-16,16)
					if(n <= 2) if(prob(25))
						var/obj/items/consumables/lotus_flower/l = new
						l.loc = src.loc
						l.step_x = src.step_x
						l.step_y = src.step_y
			reeds
				icon = 'plants.dmi'
				bolted = 1
				icon_state = "reeds1"
				hashadow = 0
				New()
					src.icon_state = "reeds[rand(1,3)]"
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
			flower
				icon = 'plants.dmi'
				bolted = 1
				icon_state = "flower2"
				hashadow = 1
				filters = filter(type="outline", size=1, color=rgb(84,107,60))
				New()
					src.icon_state = "flower[rand(1,5)]"
			crystal_plant1
				icon = 'plants.dmi'
				bolted = 1
				icon_state = "crystal plant1"
				hashadow = 1
			crystal_tuff
				icon = 'plants.dmi'
				bolted = 1
				icon_state = "crystal tuff"
				hashadow = 0
			plant
				icon = 'plants.dmi'
				bolted = 1
				icon_state = "plant2"
				hashadow = 1
				filters = filter(type="outline", size=1, color=rgb(84,107,60))
				New()
					src.icon_state = "plant[rand(1,5)]"
			divine_tree1
				icon = 'tree_divine.dmi'
				bolted = 1
				icon_state = "tree1"
				shudders = 1
				New()
					..()
					src.filters += filter(type="outline",size=1, color=rgb(204,236,255))
					src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(204,236,255))
					src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
			crystal_bush_large1
				icon = 'bush_large.dmi'
				bolted = 1
				icon_state = "crystal bush1"
				shudders = 1
				pixel_x = -32
				bounds = "-7,1 to 40,24"
				New()
					..()
					//src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
					var/t = rand(10,20)
					var/obj/i = new
					i.appearance = src.appearance
					src.vis_contents += i
					i.alpha = 155
					i.bolted = 2
					i.pixel_x = 0
					animate(i, transform = matrix()*1.5,alpha = 0, time = t, loop = -1)
					animate(transform = matrix()*1,alpha = 155,time = 0)
			crystal_bush_large2
				icon = 'bush_large.dmi'
				bolted = 1
				icon_state = "crystal bush2"
				shudders = 1
				pixel_x = -32
				bounds = "-7,1 to 40,24"
				New()
					..()
					//src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
					var/t = rand(10,20)
					var/obj/i = new
					i.appearance = src.appearance
					src.vis_contents += i
					i.alpha = 155
					i.bolted = 2
					i.pixel_x = 0
					animate(i, transform = matrix()*1.5,alpha = 0, time = t, loop = -1)
					animate(transform = matrix()*1,alpha = 155,time = 0)
			crystal_bush_small1
				icon = 'bush_small.dmi'
				bolted = 1
				icon_state = "crystal bush"
				shudders = 1
				New()
					..()
					//src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
					var/t = rand(10,20)
					var/obj/i = new
					i.appearance = src.appearance
					src.vis_contents += i
					i.alpha = 155
					i.bolted = 2
					animate(i, transform = matrix()*1.5,alpha = 0, time = t, loop = -1)
					animate(transform = matrix()*1,alpha = 155,time = 0)
			crystal_bush_small2
				icon = 'bush_small.dmi'
				bolted = 1
				icon_state = "crystal bush2"
				shudders = 1
				New()
					..()
					//src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
					var/t = rand(10,20)
					var/obj/i = new
					i.appearance = src.appearance
					src.vis_contents += i
					i.alpha = 155
					i.bolted = 2
					animate(i, transform = matrix()*1.5,alpha = 0, time = t, loop = -1)
					animate(transform = matrix()*1,alpha = 155,time = 0)
			tree_yuk_1
				icon = 'tree_yuk.dmi'
				bolted = 1
				//icon_state = "1"
				//shudders = 1
				//hashadow = 1
				bounds = "9,8 to 39,21"
				density_factor = 1
			plant_small_yuk_1
				icon = 'bush_small_yuk.dmi'
				bolted = 1
				icon_state = "4"
				shudders = 1
				hashadow = 0
			bush_small_yuk_1
				icon = 'bush_small_yuk.dmi'
				bolted = 1
				icon_state = "1"
				shudders = 1
				hashadow = 0
			bush_small_yuk_2
				icon = 'bush_small_yuk.dmi'
				bolted = 1
				icon_state = "2"
				shudders = 1
				hashadow = 0
			bush_small_yuk_3
				icon = 'bush_small_yuk.dmi'
				bolted = 1
				icon_state = "3"
				shudders = 1
				hashadow = 0
			bush_small1
				icon = 'bush_small.dmi'
				bolted = 1
				icon_state = "bare"
				shudders = 1
				New()
					src.icon_state = pick("bare","berries")
			bush_small2
				icon = 'bush_small.dmi'
				bolted = 1
				icon_state = "bush2"
				shudders = 1
			bush_small3
				icon = 'bush_small.dmi'
				bolted = 1
				icon_state = "bush3"
				shudders = 1
			bush_large1
				icon = 'bush_large.dmi'
				bolted = 1
				icon_state = "bare"
				shudders = 1
				pixel_x = -32
				bounds = "-7,1 to 40,24"
				New()
					..()
					src.icon_state = pick("bare","berries")
			bush_large2
				icon = 'bush_large.dmi'
				bolted = 1
				icon_state = "bush2"
				shudders = 1
				pixel_x = -32
				bounds = "-7,1 to 40,24"
			bush_large3
				icon = 'bush_large.dmi'
				bolted = 1
				icon_state = "bush3"
				shudders = 1
				pixel_x = -32
				bounds = "-7,1 to 40,24"
			tree_oak
				icon = 'tree_oak.dmi'
				icon_state = "tree leaves"
				density_factor = 1
				pixel_x = -32
				bolted = 1
				bounds = "-14,10 to 47,35"
				hashadow = 0
				weight = 2
				/*
				New()
					..()
					spawn(10)
						if(src)
							var/obj/L = new
							L.icon = src.icon
							L.icon_state = "top leaves"
							L.hashadow = 0
							L.pixel_y = 2
							L.layer = src.layer + 0.1
							L.appearance_flags = PIXEL_SCALE
							src.vis_contents += L
							var/matrix/m1 = matrix()
							m1.Turn(2)
							m1.Translate(2,2)

							var/matrix/m2 = matrix()
							m2.Turn(2)
							m2.Translate(-2,-2)

							animate(L,transform = m1, time = 20, loop = -1)
							animate(transform = m2, time = 20)
				*/
			tree_oak_dead
				icon = 'tree_oak.dmi'
				icon_state = "tree bare"
				density_factor = 1
				pixel_x = -32
				bolted = 1
				bounds = "-14,10 to 47,35"
				hashadow = 0
				weight = 2
			tree_chestnut
				icon = 'trees_smaller.dmi'
				icon_state = "chestnut"
				density_factor = 1
				pixel_x = -32
				bolted = 1
				bounds = "-14,10 to 47,35"
				hashadow = 0
				weight = 2
			tree_maple
				icon = 'trees_smaller.dmi'
				icon_state = "maple"
				density_factor = 1
				pixel_x = -32
				bolted = 1
				bounds = "-14,10 to 47,35"
				hashadow = 0
				weight = 2
			tree_birch
				icon = 'trees_smaller.dmi'
				icon_state = "birch"
				density_factor = 1
				pixel_x = -32
				bolted = 1
				bounds = "-14,10 to 47,35"
				hashadow = 0
				weight = 2
			tree_crystal
				icon = 'tree_oak.dmi'
				icon_state = "tree crystal"
				density_factor = 1
				pixel_x = -32
				bolted = 1
				bounds = "-14,10 to 47,35"
				hashadow = 0
				weight = 2
				New()
					..()
					src.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(155,255,255))
					src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
				/*
				New()
					..()
					var/obj/s = new
					s.icon = 'tree_oak.dmi'
					s.icon_state = "shadow"
					var/icon/I = new(src.icon)
					I.icon -= rgb(255,255,255)
					//I.Flip(NORTH)
					s.icon = I
					s.alpha = 100
					s.pixel_y = -36
					src.underlays += s
				*/
			tall_grass
				icon = 'tall_grass.dmi'
				icon_state = "1"
				//pixel_x = -16;
				bolted = 1;
				hashadow = 0
				shudders = 1;
				New()
					..()
					icon_state = "[rand(1,4)]"
		misc
			item_container
				icon = 'misc.dmi'
				icon_state = "players items"
				hp = 1.#INF
				can_pocket = 1
				can_activate = 0
				hashadow = 0
				Click()
					..()
					if(src in range(2,usr))
						for(var/obj/items/I in src)
							I.loc = src.loc
							usr.pickup(I,2)
						src.destroy()
			body
				icon = 'Human_Base_Male.dmi'
				icon_state = "ko"
				hashadow = 0
				var/spoiled = 0
				New()
					..()
					spawn(3600)
						if(src) src.spoiled = 1
				Click(location,control,params)
					..()
					usr.mouse_down = null
					params = params2list(params)
					if(params["left"])
						//Player uses defib to revive
						if(usr.left_click_function == "revive defibrillator")
							if(get_dist(usr,src) <= 2)
								if(usr.left_click_ref)
									var/obj/d = usr.left_click_ref
									if(d in usr.accessing)
										if(src.spoiled)
											usr.set_alert("Body lifeless",d.icon,d.icon_state)
											usr.create_chat_entry("alerts","Body lifeless.")
											usr << output("Defibrillation failed, body has been dead too long.","chat.system")
											return
										usr.left_click_function = null
										usr.left_click_ref = null
										var/found_body_owner = 0
										for(var/mob/m in world)
											if(m.client && m.real_name == src.owner)
												m.loc = src.loc
												m.step_x = src.step_x
												m.step_y = src.step_y
												m.Body()
												m.Revive()
												m.energy = 1
												m.KO()
												d.use_obj(usr)
												found_body_owner = 1
												spawn(1)
													if(src) src.destroy()
												return
										if(found_body_owner == 0)
											usr.set_alert("Defibrillation failed",d.icon,d.icon_state)
											usr.create_chat_entry("alerts","Defibrillation failed.")
											usr << output("Defibrillation failed, wasn't able to locate owner of the corpse and rejoin their soul with their body.","chat.system")
			yuk_tree_heart
				icon = 'tree_heart.dmi'
				icon_state = "heart"
				bolted = 2
				shudders = 1
				pixel_x = -32
				//step_x = 2
				bounds = "-7,1 to 40,24"
				immune_dmg = 1
				hp = 1.#INF
				can_activate = 1
				/*
				Yukopians can click the heart that opens a menu that displays its stats.
				Button for linking up with heart as a yukopian
				Displays heart hp, energy, divine energy, general status/condition. How many plants/grass tiles maybe? And also how much power heart has.
				Send/Take energy button
				Send/Take divine energy button
				Send/Take hp button
				Taking too much of any stat makes the heart slowly wither until it dies and becomes black
				Once it becomes black, it pumps out dark matter instead
				Giving energy/divine/hp helps the tree grow more plants, become stronger and thus give Yukopians linked to it more power as a whole

				Stage 1 - Link to Yukopian "hive mind"
				Stage 2 - Linking ritual to tree

				*/
				New()
					spawn(10)
						if(src)
							src.layer = 10

							var/obj/o = new
							o.plane = 4
							o.icon = src.icon
							o.icon_state = "overlay"
							o.appearance_flags = 0
							o.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(155,255,255))
							src.vis_contents += o

							var/obj/rays = new
							rays.icon = 'fx_ray_large.dmi'
							rays.pixel_x = -286
							rays.pixel_y = -256
							rays.loc = src.loc
							rays.step_x = src.step_x
							rays.step_y = src.step_y
							rays.bolted = 2
							rays.layer = src.layer-0.2
							rays.filters += filter(type="rays",x=0,y=0,size=300,color=rgb(255,255,255),offset=0,density=15,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
							animate(rays.filters[1],offset = 100,time = 1000, loop = -1)
							animate(offset = 0,time = 0)

							var/obj/i = new
							i.icon = src.icon
							i.icon_state = "heart"
							i.loc = src.loc
							i.step_x = src.step_x
							i.step_y = src.step_y
							i.pixel_x = src.pixel_x
							i.pixel_y = src.pixel_y
							i.layer = src.layer+1;
							i.alpha = 155
							animate(i, transform = matrix()*1.4,alpha = 0, time = 20, loop = -1)
							animate(transform = matrix()*1,alpha = 155,time = 0)

							var/p = 33
							while(p)
								if(prob(25))
									sleep(1)
								p -= 1;
								var/obj/pix = new
								pix.icon = 'fx.dmi'
								pix.icon_state = "pixel"
								pix.loc = locate(src.x,src.y,src.z)
								pix.step_x = src.step_x-4
								pix.step_y = src.step_y+20
								pix.pixel_x = rand(-200,200)
								pix.pixel_y = rand(-200,200)
								pix.bolted = 2
								animate(pix,pixel_x = 0, pixel_y = 0, time = rand(5,10), alpha = 0,loop = -1)
								animate(pixel_x = rand(-200,200), pixel_y = rand(-200,200), time = 0, alpha = 255)
								//s.pixs += pix

							var/obj/effects/shockwave_medium/b = new
							b.loc = src.loc
							b.step_x = src.step_x
							b.step_y = src.step_y
							b.pixel_x = -82
							b.pixel_y = -44
							b.transform *= 0.1
							animate(b, transform = matrix()*1, alpha = 0, time = 3, loop = -1)
							animate(layer = b.layer, time = 7)
							animate(transform = matrix()*0.1,alpha = 255,time = 0)
							while(src)
								/*
								var/obj/effects/shockwave_medium/b = new
								b.loc = src.loc
								b.step_x = src.step_x
								b.step_y = src.step_y
								b.pixel_x = -82
								b.pixel_y = -44
								b.transform *= 0.1
								animate(b, transform = matrix()*1, alpha = 0, time = 3)
								spawn(10)
									if(b) b.destroy()
									*/
								for(var/mob/m in view(4,src))
									m.gain_stat("divine",1,10,"World Tree Heart",1)
									//m.divine_energy_max += 0.003*m.divine_energy_mod
									m.divine_energy += 0.01*m.divine_energy_mod
									if(m.ambients == null) m.ambients = list()
									/*
									if(m.ambients.Find("yuk tree heart beat") == 0)
										m << sound('heart2.mp3',1,0,9,100)
										m.ambients += "yuk tree heart beat"
									*/
								sleep(10)
			beehive
				name = "Beehive"
				icon = 'consumables.dmi'
				icon_state = "beehive"
				density_factor = 1
				//bounds = "10,9 to 22,25"
				hashadow = 1
				weight = 1
				bolted = 1;
				can_activate = 1;
				pixel_y = -8;
				Click(location,control,params)
					..()
					usr.mouse_down = null
					params = params2list(params)
					if(params["left"])
						if(src in range(1,usr))
							//Make the hive expand slightly twice, like it's about to burst, then make it explode into honey combs.
							//Make an NPC bee-swarm spawn and attack the player.
							animate(src,transform = matrix()*1.05,time = 2)
							animate(transform = matrix()*1,time = 2)
							animate(transform = matrix()*1.1,time = 2)
							animate(transform = matrix()*1,time = 2)
							animate(transform = matrix()*1.2,time = 2)
							sleep(10)
							src.alpha = 0;
							src.shadow.alpha = 0;
							if(src)
								var/h = 2
								var/pos = list(src.x-1,src.x+1)
								while(h)
									var/obj/items/consumables/manuka_honey/hon = new
									var/n = pos[h]
									hon.loc = locate(n,src.y,src.z)
									var/p_x = 0;
									if(n > src.x) p_x = -16;
									if(n < src.x) p_x = 16;
									hon.pixel_x = p_x;
									animate(hon,pixel_y = 16,pixel_x = p_x/2,time = 2)
									animate(pixel_y = -8,pixel_x = 0,time = 2)
									h -= 1
							sleep(10)
							if(src) del(src)
			rad_rock_1
				name = "Rock"
				icon = 'rocks.dmi'
				icon_state = "rad rock 1"
				density_factor = 1
				bounds = "-10,1 to 46,19"
				hashadow = 1
				pixel_x = -16;
				weight = 1
				radius = 4
				New()
					..()
					spawn(10)
						if(src)
							src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(0,150,0))
							animate(src.filters[src.filters.len], offset = 4, time = 10,loop = -1)
							animate(offset = 1, time = 10)
							src.rad_field()
				Del()
					src.explode_rock()
					sleep(3)
					..()
			rad_rock_2
				name = "Rock"
				icon = 'rocks.dmi'
				icon_state = "rad rock 2"
				density_factor = 1
				bounds = "-3,1 to 40,19"
				hashadow = 1
				pixel_x = -16;
				weight = 1
				radius = 4
				New()
					..()
					spawn(10)
						if(src)
							src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(0,150,0))
							animate(src.filters[src.filters.len], offset = 4, time = 10,loop = -1)
							animate(offset = 1, time = 10)
							src.rad_field()
				Del()
					src.explode_rock()
					sleep(3)
					..()
			rad_rock_3
				name = "Rock"
				icon = 'rocks.dmi'
				icon_state = "rad rock 3"
				density_factor = 1
				bounds = "3,1 to 29,15"
				pixel_x = -16
				hashadow = 1
				weight = 1
				radius = 4
				New()
					..()
					spawn(10)
						if(src)
							src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(0,150,0))
							animate(src.filters[src.filters.len], offset = 4, time = 10,loop = -1)
							animate(offset = 1, time = 10)
							src.rad_field()
				Del()
					src.explode_rock()
					sleep(3)
					..()
			rock_larger
				name = "Rock"
				icon = 'rocks.dmi'
				icon_state = "larger rock 1"
				density_factor = 1
				bounds = "-3,6 to 34,23"
				hashadow = 1
				pixel_x = -16
				weight = 1
				Del()
					src.explode_rock()
					sleep(3)
					..()
			rock_lava
				name = "Rock"
				icon = 'terrain.dmi'
				icon_state = "lava rock 1"
				density_factor = 1
				bounds = "1,1 to 32,16"
				hashadow = 1
				weight = 1
				Del()
					src.explode_rock()
					sleep(3)
					..()
				New()
					..()
					src.icon_state = "lava rock [rand(1,3)]"
			rock_desert
				name = "Rock"
				icon = 'terrain.dmi'
				icon_state = "rock1"
				density_factor = 1
				bounds = "1,1 to 32,16"
				hashadow = 1
				weight = 1
				New()
					..()
					src.icon_state = "rock[rand(1,3)]"
				Click(location,control,params)
					..()
					params = params2list(params)
					if(params["left"])
						if(src in range(1,usr))
							if(src.can_activate)
								flick(pick("punch","kick"),usr)
								src.flash_red()
								src.shake()
								spawn(3)
									if(src && usr)
										if(src.loc)
											var/turf/x = src.loc
											if(x.liquid == null)
												var/obj/effects/craters/crater_small/cs = new
												cs.loc = src.loc
												cs.step_x = src.step_x
												cs.step_y = src.step_y

										src.explosion_small()

										usr.resources += round(src.resources)
										usr.update_rsc()
										usr.rsc_nums("<font color = green>+[src.resources] resources")

										src.resources = 0
										src.destroy()
			world_tree_overlay
				icon = 'world_tree.dmi'
				icon_state = "overlay"
				bolted = 2
				hashadow = 0
				plane = 4
				immune_dmg = 1
				layer = 30
				New()
					..()
					src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(155,255,255))
			world_tree_inside
				icon = 'tree_inside.dmi'
				bolted = 2
				hashadow = 0
				pixel_x = -119
				pixel_y = -32
				layer = 2.1
				immune_dmg = 1
				New()
					spawn(10)
						if(src) src.layer = 2.1
			divine_cache
				name = "Divine Cache"
				icon = 'containers.dmi'
				icon_state = "psi cache2"
				density_factor = 1
				bounds = "1,1 to 32,16"
				hashadow = 1
				weight = 1
				bolted = 2
				can_activate = 1
				var/obj/orb = null
				var/obj/ray = null
				Click(location,control,params)
					..()
					params = params2list(params)
					if(params["left"])
						if(src in range(1,usr))
							if(src.can_activate)
								flick(pick("punch","kick"),usr)
								src.flash_red()
								src.shake()
								spawn(3)
									if(src && usr && src.resources > 0)
										if(src.loc)
											var/turf/x = src.loc
											if(x.liquid == null)
												var/obj/effects/craters/crater_small/cs = new
												cs.loc = src.loc
												cs.step_x = src.step_x
												cs.step_y = src.step_y

										src.explosion_small()

										if(src.icon_state == "psi cache1")
											usr.dark_matter += src.resources;
											usr.rsc_nums("<font color = green>+[Commas(src.resources)] dark matter energy")
										if(src.icon_state == "psi cache2")
											//usr.psionic_power_base += src.resources;
											usr.rsc_nums("<font color = green>+[Commas(src.resources)] psionic power")
										if(src.icon_state == "psi cache3")
											usr.divine_energy += src.resources*usr.divine_energy_mod;
											usr.rsc_nums("<font color = green>+[Commas(src.resources)] divine energy")
											if(islist(usr.tutorials))
												var/obj/help_topics/H = usr.tutorials[7]
												if(H.seen == 0)
													H.seen = 1
													H.skill_up(usr)

										src.resources = 0
										if(src.orb) src.orb.destroy()
										if(src.ray) src.ray.destroy()
										src.destroy()
				New()
					src.icon_state = "psi cache[rand(1,3)]"
					spawn(10)
						if(src && src.loc)
							if(src.icon_state == "psi cache1")
								var/obj/ball = new
								ball.loc = src.loc
								ball.layer = 10
								ball.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
								ball.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
								ball.step_y = 12
								ball.icon = src.icon
								ball.icon_state = "dark matter ball"
								ball.bolted = 2
								animate(ball,pixel_y = 4, time = 12, loop = -1)
								animate(pixel_y = 0, time = 12)
								src.orb = ball

								var/obj/rays = new
								rays.icon = 'fx_ray_small.dmi'
								rays.pixel_x = -16
								rays.pixel_y = -16
								rays.loc = src.loc
								rays.bolted = 2
								rays.step_y = 12
								rays.layer = 9
								rays.filters += filter(type="rays",x=0,y=0,size=56,color=rgb(25,25,25),offset=0,density=10,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
								animate(rays.filters[1],offset = 100,time = 1500, loop = -1)
								animate(offset = 0,time = 0)
								animate(rays.filters[1],y = 4,time = 12, loop = -1, flags = ANIMATION_PARALLEL)
								animate(y = 0, time = 12)
								src.ray = rays
							if(src.icon_state == "psi cache2")
								var/obj/ball = new
								ball.loc = src.loc
								ball.layer = 10
								ball.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
								ball.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
								ball.step_y = 12
								ball.icon = src.icon
								ball.icon_state = "psi ball"
								ball.bolted = 2
								animate(ball,pixel_y = 4, time = 12, loop = -1)
								animate(pixel_y = 0, time = 12)
								src.orb = ball

								var/obj/rays = new
								rays.icon = 'fx_ray_small.dmi'
								rays.pixel_x = -16
								rays.pixel_y = -16
								rays.loc = src.loc
								rays.bolted = 2
								rays.step_y = 12
								rays.layer = 9
								rays.filters += filter(type="rays",x=0,y=0,size=64,color=rgb(255,255,255),offset=0,density=10,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
								animate(rays.filters[1],offset = 100,time = 1500, loop = -1)
								animate(offset = 0,time = 0)
								animate(rays.filters[1],y = 4,time = 12, loop = -1, flags = ANIMATION_PARALLEL)
								animate(y = 0, time = 12)
								src.ray = rays
							if(src.icon_state == "psi cache3")
								var/obj/ball = new
								ball.loc = src.loc
								ball.layer = 10
								ball.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(255,255,170))
								ball.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
								ball.step_y = 12
								ball.icon = src.icon
								ball.icon_state = "divine energy ball"
								ball.bolted = 2
								animate(ball,pixel_y = 4, time = 12, loop = -1)
								animate(pixel_y = 0, time = 12)
								src.orb = ball

								var/obj/rays = new
								rays.icon = 'fx_ray_small.dmi'
								rays.pixel_x = -16
								rays.pixel_y = -16
								rays.loc = src.loc
								rays.bolted = 2
								rays.step_y = 12
								rays.layer = 9
								rays.filters += filter(type="rays",x=0,y=0,size=64,color=rgb(255,255,170),offset=0,density=10,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
								animate(rays.filters[1],offset = 100,time = 1500, loop = -1)
								animate(offset = 0,time = 0)
								animate(rays.filters[1],y = 4,time = 12, loop = -1, flags = ANIMATION_PARALLEL)
								animate(y = 0, time = 12)
								src.ray = rays

							if(prob(25)) src.resources = 10
							else if(prob(25)) src.resources = 25
							else if(prob(25)) src.resources = 100
							else if(prob(25)) src.resources = 250
							else if(prob(10)) src.resources = 500
							if(src.resources == 10) o_color="#ffffff"
							else if(src.resources == 25) o_color="#1eff00"
							else if(src.resources == 100) o_color="#0070dd"
							else if(src.resources == 250) o_color="#a335ee"
							else if(src.resources == 500) o_color="#ff8000"
					..()
			resource_cache
				name = "Resource Cache"
				icon = 'containers.dmi'
				icon_state = "resource cache2"
				density_factor = 1
				bounds = "1,1 to 32,16"
				hashadow = 1
				weight = 1
				can_pocket = 1
				stacks = -1
				hp = 1.#INF
				var/preset = 0
				desc = "Long lost ancient cache of resources left over from a bygone era."
				act = /obj/items/misc/resource_cache/proc/use
				act_drop = /obj/items/misc/resource_cache/proc/drop
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
				proc
					use(var/mob/m,var/obj/items/misc/resource_cache/i)
						if(i in m)
							m.resources += round(i.resources)
							m.update_rsc()
							i.use_obj(m)
							m.refresh_inv()
					drop(var/mob/m,var/obj/items/i)
						m.drop(i)
				New()
					spawn(0.1)
						if(isturf(src.loc))
							if(src.preset == 0) src.icon_state = "resource cache[rand(1,4)]"
							if(prob(25)) src.resources = 1000
							else if(prob(25)) src.resources = 10000
							else if(prob(25)) src.resources = 1000000
							else if(prob(10)) src.resources = 25000000
							else if(prob(5)) src.resources = 50000000
							if(src.resources == 1000)
								//o_color="#ffffff"
								src.rarity = 1
							else if(src.resources == 10000)
								//o_color="#1eff00"
								src.rarity = 2
							else if(src.resources == 1000000)
								//o_color="#0070dd"
								src.rarity = 3
							else if(src.resources == 25000000)
								//o_color="#a335ee"
								src.rarity = 4
							else if(src.resources == 50000000)
								//o_color="#ff8000"
								src.rarity = 5
							src.desc_extra = "When Used:\n\n<font color = green>+ [Commas(src.resources)] Resources</font>\n\n"
						..()
			water_pot
				name = "Endlessly Refilling Water Pot"
				icon = 'consumables.dmi'
				icon_state = "pot water"
				density_factor = 1
				bounds = "9,7 to 25,16"
				//hashadow = 1
				weight = 1
				can_activate = 1
				var/infused = 0
				var/full = 1
				var/refill_timer = 6000
				Click(location,control,params)
					..()
					params = params2list(params)
					if(params["left"])
						if(src in range(1,usr))
							if(src.can_activate)
								if(src.full)
									src.icon_state = "pot"
									src.full = 0
									usr.thirst += 100
									if(src.bolted > 0) src.refill_timer = 3000
									spawn(src.refill_timer)
										if(src)
											src.full = 1
											src.icon_state = "pot water"
			bonepile
				name = "Bonepile"
				icon = 'consumables.dmi'
				icon_state = "bonepile1"
				density_factor = 1
				bounds = "1,1 to 32,16"
				hashadow = 1
				weight = 1
				can_activate = 1
				var/infused = 0
				var/list/ang
				New()
					..()
					src.icon_state = "bonepile[rand(1,6)]"
					if(prob(10))
						src.infused = 1
						src.filters += filter(type="outline",size=1, color=rgb(204,236,255))
						src.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(102,0,204))

						animate(src.filters[2], size = 2,offset = 2, time = 15, loop = -1)
						animate(size = 0,offset = 0, time = 15, loop = -1)

						src.vis_contents += new/obj/effects/dark_matter_energy

					src.ang = list(0,90,180,270,45,135,225,315)
					var/parts = 0
					if(prob(20))
						parts += 1
						if(prob(20))
							parts += 1
					while(parts)
						parts -= 1
						var/obj/items/consumables/fossilized_part/p = new
						p.loc = src
				Click(location,control,params)
					..()
					params = params2list(params)
					if(params["left"])
						if(src in range(1,usr))
							if(src.can_activate)
								if(src.shadow)
									src.shadow.loc = null
									src.shadow = null
								flick(pick("punch","kick"),usr)
								src.flash_red()
								src.shake()
								spawn(3)
									if(src && usr)
										if(src.loc)
											var/bones = rand(2,4)
											while(bones)
												bones -= 1
												var/obj/items/consumables/ancient_bone/b = new
												b.loc = src.loc
												animate(b,transform = turn(matrix(), 120), time = 2)
												animate(transform = turn(matrix(), 240), time = 2)
												animate(b,pixel_x = rand(-48,48),pixel_y = rand(32,64),transform = turn(matrix(), 360), time = 2,flags = ANIMATION_PARALLEL)
												animate(pixel_y = rand(-8,8), time = 2)

												if(src.infused)
													b.rarity = 3
													b.desc_extra = "When Eaten:\n\n<font color = green>+ 1 level in Endurance</font>\n\n<font color = green>+ 1 Lifespan</font>\n\n<font color = green>+ 1 Dark Matter</font>\n\n"
													b.name = "Thousand Year Bone"
													b.infused = 1
													b.tech_lvl = 2
													b.lifespan_gain = 1
													b.dark_matter_gain = 1
													b.filters += filter(type="outline",size=1, color=rgb(204,236,255))
													b.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(102,0,204))
													animate(b.filters[2], size = 1,offset = 1, time = 15, loop = -1,flags = ANIMATION_PARALLEL)
													animate(size = 0,offset = 0, time = 15, loop = -1)

											for(var/obj/items/consumables/fossilized_part/p in src)
												p.loc = src.loc
												p.slide(src)
												if(p.shadow)
													world << "DEBUG - [p] has a shadow -_-"

											src.destroy()
											animate(src)
											src.filters = null
											src.particles = null
			rock
				name = "Rock"
				icon = 'terrain.dmi'
				icon_state = "solid rock1"
				density_factor = 1
				bounds = "1,1 to 32,16"
				hashadow = 1
				weight = 1
				Click(location,control,params)
					..()
					params = params2list(params)
					if(params["left"])
						if(src in range(1,usr))
							if(src.can_activate)
								flick(pick("punch","kick"),usr)
								src.flash_red()
								src.shake()
								spawn(3)
									if(src && usr)
										if(src.loc)
											var/turf/x = src.loc
											if(x.liquid == null)
												var/obj/effects/craters/crater_small/cs = new
												cs.loc = src.loc
												cs.step_x = src.step_x
												cs.step_y = src.step_y

										src.explosion_small()

										usr.resources += round(src.resources)
										usr.update_rsc()
										usr.rsc_nums("<font color = green>+[src.resources] resources")

										src.resources = 0
										src.destroy()
				New()
					..()
					src.icon_state = "solid rock[rand(1,3)]"
					/*
					if(prob(33))
						src.icon_state = "resource rock[rand(1,3)]"
						src.mouse_over_pointer = MOUSE_ACTIVE_POINTER
						src.can_activate = 1
					*/
					/*
					if(prob(10))
						var/obj/x = new
						x.icon = src.icon
						x.layer = src.layer+1
						x.icon_state = pick("resource1","resource2")
						src.overlays += x
					*/
					//src.layer = src.lay - src.y
				/*
				Click()
					if(src in range(1,usr))
						src.loc = usr.loc
						src.layer = src.layer+100
						usr.icon_state = "hold"
						animate(src, pixel_z = 19,pixel_x = 15, time = 2)
						sleep(10)
						usr.icon_state = "hold"
						var/n = 5
						while(n)
							sleep(5)
							animate(src, pixel_z = 25, time = 1)
							usr.icon_state = "lift"
							sleep(5)
							animate(src, pixel_z = 19, time = 1)
							sleep(1)
							usr.icon_state = "hold"
							n-=1
						animate(src, pixel_z = 0, time = 2,easing = BOUNCE_EASING)
						src.layer = src.layer-100
						usr.icon_state = "hold"
						sleep(5)
						usr.icon_state = usr.state()
				*/
		/*
		resources
			icon = 'misc.dmi'
			icon_state = "uncommon resources2"
			name = "0 Resources"
			density_factor = 0
			bounds = "7,11 to 27,18"
			can_pocket = 1
			stacks = -1
			stack_exempt = 1
			mouse_over_pointer = MOUSE_ACTIVE_POINTER
			//act = /obj/items/resources/proc/use
			act_drop = /obj/items/resources/proc/drop
			proc
				drop(var/mob/m,var/obj/items/i)
					if(i in m.accessing)
						if(m.numbers_accessing == null)
							//winset(m,"numbers.label_numbers","text=\"How many resources? Press enter to confirm.\"")
							//winset(m,"numbers","pos=960,400")
							//winshow(m,"numbers",1)
							m.numbers_accessing = m
							//winset(m,"numbers.input_number","focus=true")
							m.hud_confirm_nums.confirm_text(1,"How many resources? Press enter to confirm.",m)
			Click()
				..()
				if(ismob(src.loc))
					if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
					usr.item_selected = src
					src.overlays -= /obj/effects/select_item
					src.overlays += /obj/effects/select_item
				else if(isturf(src.loc))
					usr.mouse_down = null
					if(src in range(2,usr))
						for(var/obj/items/resources/r in usr)
							r.value += round(src.value)
							r.name = "[Commas(r.value)] Resources"
						src.destroy()
			*/
			/*
			Click()
				if(isturf(src.loc))
					usr.mouse_down = null
					if(src in range(2,usr))
						//for(var/obj/items/resources/x in range(2,src))
						for(var/obj/items/resources/r in usr)
							r.value += round(src.value)
							r.name = "[Commas(r.value)] Resources"
							//if(x != src) del(x)
						src.destroy()
				else if(src in usr.accessing)
					usr.hud_inv.item_desc.maptext = "[css_outline]<font size = 1><text align=center valign=top>[src.name]<text align=left valign=top>\n\nRarity: [global.rarity_color[src.rarity]]\n\n[src.desc_extra][src.desc]"


						//del(src)
				else if(usr.accessing in range(1,usr))
					if(src in usr.accessing) if(usr.numbers_accessing == null)
						var/mob/m = usr.accessing
						winset(usr,"numbers.label_numbers","text=\"How many resources? Press enter to confirm.\"")
						winset(usr,"numbers","pos=960,400")
						winshow(usr,"numbers",1)
						usr.numbers_accessing = m
						winset(usr,"numbers.input_number","focus=true")
				*/
		clothing
			change_icon = 1
			Click(location,control,params)
				params = params2list(params)
				if(params["left"])
					if(isturf(src.loc))
						if(src in range(1,usr))
							src.loc = usr
							return
				if(params["right"])
					if(src.loc == usr)
						if(src.suffix == "worn")
							usr.overlays -= src
							src.icon_state = "ground"
							src.layer = 3
							src.suffix = null
						else
							src.icon_state = ""
							src.layer = usr.layer + 0.1
							src.suffix = "worn"
							usr.overlays += src
				..()
			armour
				armour1
					icon = 'armour1.dmi'
					name = "Armour"
					value = 1000
					layer = ARMOUR_LAYER
					density_factor = 0
					appearance_flags = KEEP_TOGETHER
					New()
						var/image/sel = image('fx_medium.dmi',src,"select item",1000)
						src.img_select = sel
						name = "[src.name] ([src.value])"
						spawn(1)
							if(src) if(isturf(src.loc))
								src.icon_state = "ground"
								src.name = "Armour"
		tech
			hashadow = 1
			layer = 4
			weight = 2
			appearance_flags = TILE_BOUND
			stacks = -1
			var
				list/category = null //The category this tech is in.
				list/tech_give //A list of type paths that this tech will give on completion.
				list/tech_prerequisites //List of techs needed to unlock this one
				tmp/list/batteries //Set to the battery connected to this line, even if its not got energy stored.
				tmp/list/connections
				tmp/list/checked //Set to 1 for a second after being checked as a power line that is powered or not.
				organic = 0
				list_pos = 0 //The position of this tech inside the world.tech list. Used to make a comparison with the players tech lvls/xp

			MouseEntered(location,control,params)
				..()
				//if(src.loc == null && usr.build_tech == null)
					//usr.client.images += src.img_select
					//winset(usr,"tech.label_tech","text=\"[src.name] - [src.desc]\"")
					//src.mouse_opacity = 0;

			MouseExited(location,control,params)
				..()
				//if(src.loc == null)
					//usr.client.images -= src.img_select
					//src.mouse_opacity = 1;
			proc
				lvl_up_tech(var/mob/m)
					m.tech_xp[src.list_pos] = 100
					//src.tech_exp = 100
					//src.tech_exp_gain /= 1.25
					//var/time = round((100/src.tech_exp_gain)/60,0.1)
					//winset(m,"[src.info_path].label_research_time","text=\"Research Time: [round(time/m.mod_intelligence,0.1)] minutes\"")
					//src.tech_lvl += 1
					m.tech_lvls[src.list_pos] += 1
					//m.technology -= src
					m.tech_unlocked[src.list_pos] = src.type//src
					if(src.type == /obj/items/tech/sub_tech/Engineering/Structural_Engineering) m.tech_pos_se = src.list_pos
					src.skill_up(m)
					if(src.act) call(src,src.act)(m)
					for(var/obj/items/tech/o in global.tech) //m.technology)
						for(var/x in src.tech_give)
							if(o.type == x)
								if(m.tech_unlocked.Find(o.type) == 0)
									//m.technology -= o
									//m.technology_researched += o
									m.tech_unlocked[o.list_pos] = o.type
									m.output_msg("[o] technology unlocked!")
					if(src.tech_repeatable) m.tech_xp[src.list_pos] = 0//src.tech_exp = 0
					else
						m.tech_focus = null
						m.hud_tech.vis_contents -= m.hud_tech.button_research
						//if(m.tech_focus == m.tech_display) winset(m,"[src.info_path].button_research","is-disabled = true")
			sub_tech
				// Add 336 to all the y coords.
				tech_display = 0;
				layer = 36
				plane = 34
				blend_mode = BLEND_INSET_OVERLAY
				appearance_flags = KEEP_TOGETHER | PIXEL_SCALE | TILE_BOUND
				var/obj/xp_bar
				MouseEntered(location,control,params)
					usr.client.images += src.img_over
				MouseExited(location,control,params)
					usr.client.images -= src.img_over
				Click()
					if(usr.tech_display)
						var/obj/items/tech/t = usr.tech_display
						usr.client.images -= t.img_over
					usr.tech_display = src
					usr.client.images += src.img_over
					if(usr.hud_tech)
						usr.hud_tech.vis_contents -= usr.hud_tech.button_use
						usr.hud_tech.vis_contents += usr.hud_tech.button_research

						//If the tech isn't repeatable and already researched, no need to display the research button
						if(src.tech_repeatable == 0 && usr.tech_lvls[src.list_pos] > 0) usr.hud_tech.vis_contents -= usr.hud_tech.button_research

						if(src == usr.tech_focus) usr.hud_tech.button_research.maptext = "[css_outline]<font size = 1><center>Pause"
						else usr.hud_tech.button_research.maptext = "[css_outline]<font size = 1><center>Research"

						//Finish setting the tech info up
						if(usr.hud_tech.txt)
							var/repeats = "No"
							if(src.tech_repeatable) repeats = "Yes"
							usr.hud_tech.txt.maptext = "[css_outline]<font size = 1><text align=center valign=top>[src.name]<text align=left valign=top>\n\n\n\n\n\nTech Tree: [src.tech_tree]\n\nTechnology Prerequisites: [src.tech_needed_txt]\n\nUnlocks Technology: [src.tech_give_txt]\n\nRepeatable: [repeats]\n\n[src.desc]"
				MouseWheel(delta_x,delta_y,location,control,params)
					if(usr.hud_tech)
						var/obj/hud/menus/tech_background/s = usr.hud_tech
						var/obj/hud/menus/tech_background/tech_scroller/sc = s.tech_tree_scroller1
						usr.check_mouse_loc(params)
						var/true_y = ((usr.mouse_y-1)*32)+usr.mouse_pix_y
						usr.mouse_y_true = true_y
						var/wheel_move = 0
						if(delta_y > 0) wheel_move = 16
						else if(delta_y < 0) wheel_move = -16
						var/result = sc.translated_y+wheel_move
						result = clamp(result,0,-227)
						var/matrix/m = matrix()
						m.Translate(0,result)
						sc.transform = m
						sc.translated_y = result

						s.scrl_transform[s.selected] = m

						var/ratio = -1 + ((-227 + result) / -227)
						ratio = clamp(ratio,0,1)
						var/scroll_y = round(200*ratio)

						s.bar_pos_y[s.selected] = scroll_y

						var/matrix/m2 = matrix()
						m2.Translate(s.tech_holder_special.hud_x-s.bar_pos_x_hori[s.selected],s.tech_holder_special.hud_y+s.bar_pos_y[s.selected])
						s.tech_holder_special.transform = m2
				Genetics //Unlocks item that lets you change your hair, skin, ect.
					icon = 'tech_tree_buttons_genetics.dmi'
					tech_repeatable = 1
					tech_tree = "Genetics"
					info_path = "tech_research_genetics"
					//tech_exp_gain = 0.333;
					tech_exp_gain = 10
					info_name = "Genetics"
					hud_x = 136
					hud_y = 628//292
					New()
						var/matrix/m = matrix()
						m.Translate(src.hud_x,src.hud_y)
						src.transform = m

						category = list("Primary Research")
						tag = name

						var/image/over = image('tech_tree_buttons_over.dmi',src,"hover",100)
						over.pixel_x = -1
						over.pixel_y = -1
						src.img_over = over
						..()
					Gene_Mapping
						info_name = "Gene_Mapping"
						tech_repeatable = 0
						tech_needed_txt = "Gene Egineering"
						hud_x = 136
						hud_y = 528//192
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Genetics/Gene_Egineering)
					Gene_Manipulation //Lets you create syringe that allows you to respec
						hud_x = 136
						hud_y = 474//138
					Gene_Egineering
						info_name = "Gene_Egineering"
						tech_repeatable = 0
						hud_x = 136
						hud_y = 582//246
						tech_needed_txt = "Genetics"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Genetics)
					Gene_Splicing
						hud_x = 136
						hud_y = 420//84
					Microbiology //Viruses, Bacteria
						info_name = "Microbiology"
						tech_repeatable = 0
						hud_x = 46
						hud_y = 582//246
						tech_needed_txt = "Genetics"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Genetics)
					Biomolecular_Engineering //Allow the creation of custom organs
						info_name = "Biomolecular_Engineering"
						tech_repeatable = 0
						hud_x = 67
						hud_y = 528//192
						tech_needed_txt = "Microbiology"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Genetics/Microbiology)
					Biomolecular_Perfection //Create the perfect biological warrior
						hud_x = 67
						hud_y = 358//22
					Cloning
						info_name = "Cloning"
						tech_repeatable = 0
						hud_x = 101
						hud_y = 528//192
						tech_needed_txt = "Gene Mapping"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Genetics/Biomolecular_Engineering,/obj/items/tech/sub_tech/Genetics/Gene_Mapping)
					Cloning_Expertise
						info_name = "Cloning_Expertise"
						tech_repeatable = 1
						tech_give_txt = "+0.1 Multiplier Limit \n\n\ +0.1 Stat Limit"
						act = /obj/items/tech/sub_tech/Genetics/Cloning_Expertise/proc/activate
						hud_x = 101
						hud_y = 420//84
						tech_needed_txt = "Cloning"
						proc
							activate(var/mob/m,var/obj/t)
								if(m.gene_limit <= 3) m.gene_limit += 0.1
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Genetics/Biomolecular_Engineering,/obj/items/tech/sub_tech/Genetics/Cloning)
					Artifical_DNA
						hud_x = 67
						hud_y = 474//138
					Synthetics //Allows the creation of bio warriors.
						hud_x = 67
						hud_y = 420//84
					Mutagen_Synthesis
						hud_x = 91
						hud_y = 582//246

					Medical_Theories
						hud_x = 299
						hud_y = 582//246
					/*
					- Lets you use a kind of reverse Injury skill, where you can click a doctoring skill, then click on someone, which brings up a menu of the bodyparts. Like when you using Infusion.
					- Clicking a part helps heal it, based on your medical skill?
					*/
					Drug_Synthesis
						tech_repeatable = 1
						info_name = "Drug_Synthesis"
						hud_x = 204
						hud_y = 582//246
					Regenerators
						hud_x = 209
						hud_y = 537//201
					Medical_Equipment //Bandages, splints, casts, masks, bio-suits, ect
						hud_x = 239
						hud_y = 537//201
					Bio_Scanners //Lets you check someone for diasese, mutations, stats, health, ect ect.
						hud_x = 269
						hud_y = 537//201
					Psychology
						hud_x = 299
						hud_y = 537//201
					Psionics
						hud_x = 253
						hud_y = 474//138
					Psi_Supressors
						hud_x = 231
						hud_y = 415//79
					Psi_Amplifiers
						hud_x = 275
						hud_y = 415//79
					Hypnosis //Alter states of mind to enhance or supress psionic powers
						hud_x = 328
						hud_y = 474//138
					Psi_Ectoplasm //Deals with the creation of pure psionic energy in physical form, basically scientific mana.
						hud_x = 253
						hud_y = 358//22
				Physics
					tech_repeatable = 1
					//tech_exp_gain = 0.333;
					tech_exp_gain = 10
					info_path = "tech_research_physics"
					icon = 'tech_tree_buttons_physics.dmi'
					hud_x = 136
					hud_y = 628//292
					//tech_exp_gain = 10;
					New()
						/*
						var/obj/bar = new
						bar.icon = 'tech_tree_bar.dmi'
						bar.icon_state = "100"
						bar.plane = 22
						bar.layer = 40
						bar.pixel_x = -22
						bar.blend_mode = BLEND_INSET_OVERLAY
						src.vis_contents += bar
						src.xp_bar = bar
						*/

						var/matrix/m = matrix()
						m.Translate(src.hud_x,src.hud_y)
						src.transform = m

						category = list("Primary Research")
						tag = name

						var/image/over = image('tech_tree_buttons_over.dmi',src,"hover",100)
						over.pixel_x = -1
						over.pixel_y = -1
						src.img_over = over
						..()

					Electromagnetism //One component of scanners
						hud_x = 191
						hud_y = 582//246
					Energy_Scanners
						tech_repeatable = 1
						info_name = "Energy Scanners"
						hud_x = 191
						hud_y = 542//206
					Electrochemistry
						tech_give = list(/obj/items/tech/Battery)
						tech_give_txt = "Batteries"
						hud_x = 63
						hud_y = 582//246
					Thermodynamics
						hud_x = 121
						hud_y = 582//246
					Clean_Energy
						hud_x = 128
						hud_y = 537//201
					Nuclear_Energy
						hud_x = 63
						hud_y = 425//89
					Fossil_Fuels //Needed for fueled generators
						hud_x = 15
						hud_y = 559//223
					Wind_Generators
						tech_give = list(/obj/items/tech/Wind_Turbine)
						tech_give_txt = "Wind Turbines"
						hud_x = 142
						hud_y = 492//156
					Nuclear_Generators
						hud_x = 63
						hud_y = 392//56
					Fueld_Generators
						hud_x = 15
						hud_y = 511//175
					Solar_Generators
						tech_give = list(/obj/items/tech/Solar_Generator)
						tech_give_txt = "Solar Generators"
						hud_x = 170
						hud_y = 492//156
					Hydroelectric_Generators
						hud_x = 114
						hud_y = 492//156
					Geothermal_Generators
						hud_x = 86
						hud_y = 492//156
					Quantum_Mechanics //Needed for gravity machine
						hud_x = 345
						hud_y = 582//246
					Gravitational_Fields
						hud_x = 345
						hud_y = 542//206
					Gravity_Machine //Sit inside, gain strength and endurance
						hud_x = 345
						hud_y = 494//158
					Weather_Manipulation
						hud_x = 238
						hud_y = 582//246
					Microwave_Domes //Sit inside, get electricuted, gain resis
						hud_x = 269
						hud_y = 582//246
					Weather_Control_Machine //Sets the weather in the area to whatever you want
						hud_x = 238
						hud_y = 520//184
					Terraforming //Help reverse global fuckery of the weather-kind
						hud_x = 238
						hud_y = 442//106
					Atomic_Physics //Needed for Nuclear energy
						hud_x = 63
						hud_y = 458//122
					Radiation_Domes //Sit inside, gain force, but slowly become sick and/or hurt
						hud_x = 130
						hud_y = 425//89
					Radiation_Protection
						hud_x = 130
						hud_y = 458//122
					Nuclear_Weapons
						hud_x = 130
						hud_y = 392//56
					Advanced_Energy_Studies
						hud_x = 296
						hud_y = 409//73
					Zero_Point_Energy
						hud_x = 165
						hud_y = 347//11
				Engineering
					icon = 'tech_tree_buttons_engineering.dmi'
					icon_state = "main"
					tech_repeatable = 1
					tech_tree = "Engineering"
					info_path = "tech_research_engineering"
					//tech_exp_gain = 0.333;
					tech_exp_gain = 3//10;
					info_name = "Engineering"
					desc = "Engineering, a vital catalyst for innovation, expertly applies scientific and mathematical principles to devise ingenious solutions to an array of complex challenges. As one delves into this intricate discipline, a veritable cornucopia of diverse subfields materializes, spanning the realms of civil, electrical, aerospace, and beyond. The pursuit of engineering research yields the invaluable benefits of pioneering technologies and bolstered infrastructure, resulting in a heightened level of efficiency and resilience. This ceaseless quest for knowledge fosters sustainable development and drives progress across myriad domains, ultimately refining and advancing the integration of engineering marvels into diverse environments and systems."
					hud_y = 628//292
					hud_x = 136
					New()
						/*
						var/obj/bar = new
						bar.icon = 'tech_tree_bar.dmi'
						bar.icon_state = "100"
						bar.plane = 22
						bar.layer = 40
						bar.pixel_x = -22
						bar.blend_mode = BLEND_INSET_OVERLAY
						src.vis_contents += bar
						src.xp_bar = bar
						*/

						var/matrix/m = matrix()
						m.Translate(src.hud_x,src.hud_y)
						src.transform = m

						category = list("Primary Research")
						tag = name
						tech_give = list(/obj/items/tech/Drug_Synthesization,/obj/items/tech/Microwave_Generator,/obj/items/tech/Cybertech,/obj/items/tech/Canister,/obj/items/tech/Defibrillator,/obj/items/tech/Scanner,/obj/items/tech/weights/wrist_bands,/obj/items/tech/doors/Security_Door_MKI,/obj/items/tech/digging/Drill,/obj/items/tech/digging/Shovel,/obj/items/tech/Power_Line,/obj/items/tech/Mechanical_Upgrade_Kit,/obj/items/tech/Automated_Drill_Tower,/obj/items/tech/Battery,/obj/items/tech/Geothermal_Generator,/obj/items/tech/Gravity_Machine,/obj/items/tech/Regeneration_Tank,/obj/items/tech/Solar_Generator,/obj/items/tech/Vat,/obj/items/tech/Wind_Turbine)
						tech_give_txt = "Power Lines"

						var/image/over = image('tech_tree_buttons_over.dmi',src,"hover",100)
						over.pixel_x = -1
						over.pixel_y = -1
						src.img_over = over
						..()
					Shovels
						info_name = "Shovels"
						tech_repeatable = 0
						hud_x = 15
						hud_y = 574//238
						tech_give_txt = "Buildable Shovels"
						tech_needed_txt = "Mining"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Mining)
							tech_give_txt = "Shovels"
					Pneumatic_Drill
						info_name = "Pneumatic_Drill"
						tech_repeatable = 0
						hud_x = 15
						hud_y = 536//200
						tech_give_txt = "Buildable Pneumatic Drills"
						tech_needed_txt = "Resource Extractions"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Resource_Extractions)
					Mining
						info_name = "Mining"
						tech_repeatable = 0
						hud_x = 46
						hud_y = 574//238
						desc = "Mining, an indispensable component in resource extraction, employs sophisticated techniques and state-of-the-art technologies to delve into the planet's depths, unearthing precious minerals and geological treasures. As an interdisciplinary field, mining encompasses geochemistry, geophysics, and geomechanics, fostering comprehensive understanding of complex subterranean processes. Research in mining propels advancements in excavation methods, ore processing, and environmental remediation, optimizing the sustainability and efficiency of operations. By unlocking resources vital for technological innovation and infrastructural development, mining research contributes to a flourishing ecosystem of ingenuity and progress, expanding the horizons of possibility across multifarious domains, fostering resilience and adaptability in the face of ever-evolving challenges."
						tech_give_txt = "Leads to Resource Extractions"
						tech_needed_txt = "Engineering"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering)
					Advanced_Resource_Extractions
						info_name = "Advanced_Resource_Extractions"
						tech_repeatable = 0
						hud_x = 46
						hud_y = 498//162
						tech_give_txt = "Leads to Automated Drill Towers"
						tech_needed_txt = "Resource Extractions"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Resource_Extractions)
					Resource_Extractions
						info_name = "Resource_Extractions"
						tech_repeatable = 0
						hud_x = 46
						hud_y = 536//200
						tech_needed_txt = "Mining"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Mining)
					Automated_Drill_Towers
						info_name = "Automated_Drill_Towers"
						tech_give = list(/obj/items/tech/Automated_Drill_Tower)
						tech_give_txt = "Automated Drill Towers"
						tech_repeatable = 1
						tech_give_txt = "Buildable Automated Drill Towers"
						tech_needed_txt = "Advanced Resource Extractions"
						hud_x = 15
						hud_y = 498//162
						New()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Advanced_Resource_Extractions)
					Material_Theories
						info_name = "Material_Theories"
						//icon_state = "material theories"
						tech_repeatable = 0
						hud_x = 121
						hud_y = 574//238
						tech_needed_txt = "Engineering"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering)
					Molecular_Engineering
						info_name = "Molecular_Engineering"
						tech_repeatable = 0
						hud_x = 121
						hud_y = 506//170
						tech_needed_txt = "Material Theories"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Material_Theories)
					Weights
						tech_repeatable = 1
						info_name = "Weights"
						hud_x = 90
						hud_y = 574//238
						tech_needed_txt = "Material Theories"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Material_Theories)
					Armors
						tech_repeatable = 1
						info_name = "Armors"
						hud_x = 140
						tech_needed_txt = "Material Theories"
						hud_y = 541//205
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Material_Theories)
					Swords
						tech_repeatable = 1
						info_name = "Swords"
						hud_x = 102
						hud_y = 541//205
						tech_needed_txt = "Material Theories"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Material_Theories)
					Structural_Engineering
						tech_repeatable = 1
						info_name = "Structural_Engineering"
						hud_x = 152
						hud_y = 574//238
						tech_needed_txt = "Material Theories"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Material_Theories)
					Mechatronics_Theory //Theory of robotics, electronics, ect.
						info_name = "Mechatronics_Theory"
						tech_repeatable = 0
						hud_x = 390
						hud_y = 574//238
						tech_needed_txt = "Engineering"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering)
					Robotics
						tech_repeatable = 1
						info_name = "Robotics"
						hud_x = 371
						hud_y = 532//196
						tech_needed_txt = "Mechatronics Theory"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Mechatronics_Theory)
					Cybernetics
						tech_repeatable = 1
						info_name = "Cybernetics"
						hud_x = 403
						hud_y = 532//196
						tech_needed_txt = "Mechatronics Theory"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Mechatronics_Theory)
					Artifical_Inteligence
						info_name = "Artifical_Inteligence"
						tech_repeatable = 0
						hud_x = 371
						hud_y = 499//163
						tech_needed_txt = "Robotics"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Robotics)
					Nanites
						info_name = "Nanites"
						tech_repeatable = 0
						hud_x = 371
						hud_y = 466//130
						tech_needed_txt = "Artifical Inteligence"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Artifical_Inteligence)
					Aerospace_Theories //Spaceship stuff
						info_name = "Aerospace_Theories"
						tech_repeatable = 0
						hud_x = 226
						hud_y = 574//238
						tech_needed_txt = "Engineering"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering)
					Spacecraft_Hulls
						info_name = "Spacecraft_Hulls"
						tech_repeatable = 0
						hud_x = 226
						hud_y = 529//193
						tech_needed_txt = "Aerospace Theories"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Aerospace_Theories)
					Spacecraft_Propulsion
						info_name = "Spacecraft_Propulsion"
						tech_repeatable = 0
						hud_x = 196
						hud_y = 529//193
						tech_needed_txt = "Aerospace Theories"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Aerospace_Theories)
					Spacecraft_Enviromentals
						info_name = "Spacecraft_Enviromentals"
						tech_repeatable = 0
						hud_x = 256
						hud_y = 529//193
						tech_needed_txt = "Aerospace Theories"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Aerospace_Theories)
					Space_Pods
						info_name = "Space_Pods"
						tech_repeatable = 0
						hud_x = 226
						hud_y = 484//148
						tech_needed_txt = "Spacecraft Hulls, Spacecraft Enviromentals, Spacecraft Propulsion"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Spacecraft_Hulls,/obj/items/tech/sub_tech/Engineering/Spacecraft_Enviromentals,/obj/items/tech/sub_tech/Engineering/Spacecraft_Propulsion)
					Space_Ships
						tech_give = list(/obj/items/tech/Ship)
						tech_give_txt = "Ships"
						info_name = "Space_Ships"
						tech_repeatable = 0
						hud_x = 226
						hud_y = 448//112
						tech_needed_txt = "Space Pods"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Space_Pods)
					Storage_Theories
						info_name = "Storage_Theories"
						tech_repeatable = 0
						hud_x = 327
						hud_y = 574//238
						tech_needed_txt = "Engineering"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering)
					Basic_Storage
						info_name = "Basic_Storage"
						tech_repeatable = 0
						hud_x = 327
						hud_y = 541//205
						tech_needed_txt = "Storage Theories"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Storage_Theories)
					Advanced_Storage
						info_name = "Advanced_Storage"
						tech_repeatable = 0
						hud_x = 327
						hud_y = 508//172
						tech_needed_txt = "Basic Storage"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Basic_Storage)
					Compression_Techniques
						tech_give = list(/obj/items/tech/Canister)
						tech_give_txt = "Canisters"
						info_name = "Compression_Techniques"
						tech_repeatable = 0
						hud_x = 300
						hud_y = 508//172
						tech_needed_txt = "Advanced Storage"
						New()
							..()
							tech_prerequisites = list(/obj/items/tech/sub_tech/Engineering/Advanced_Storage)
			Drug_Synthesization
				icon = 'drugs.dmi'
				icon_state = "pills"
				info_name = "Drug_Synthesization"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				value = 100000
				desc = ""
				stacks = 1
				tech_tree = "Genetics"
				tech_subtech = "Drug Synthesis"
				tech_parent_path = /obj/items/tech/sub_tech/Genetics/Drug_Synthesis
				tech_upgradable = 1
				has_subtech = 1
				Click()
					..()
					for(var/obj/items/tech/sub_tech/Genetics/Drug_Synthesis/DS in global.tech)//usr.technology_researched)
						if(usr.tech_unlocked[DS.list_pos] == DS.type)
							src.tech_lvl = usr.tech_lvls[DS.list_pos]//DS.tech_lvl
							break

			Cybertech
				icon = 'bodybits.dmi'
				icon_state = "cybertech"
				info_name = "Cybertech"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				value = 1000000
				desc = ""
				stacks = -1
				tech_tree = "Engineering"
				tech_subtech = "Cybernetics"
				tech_parent_path = /obj/items/tech/sub_tech/Engineering/Cybernetics
				tech_upgradable = 1
				has_subtech = 1
				Click()
					..()
					if(usr.client) usr << output(null,"tech_customization.grid_type")
					var/techs = 0
					for(var/obj/O in cybertech)
						if(usr.client) usr << output(O,"tech_customization.grid_type:[++techs]")
					if(usr.client) winset(usr, "tech_customization.grid_type", "cells=\"[techs]\"")
			Ship
				info_name = "Ship"
				icon = 'ship.dmi'
				icon_state = "open"
				pixel_x = -250
				pixel_y = -200
				hp = 1000
				layer = 3
				fuel = 100
				bolted = 2
				hashadow = 0
				density_factor = 1
				weight = 10
				bounds = "-249,-199 to 285,126"
				var
					landing = 0
					tmp/mob/pilot = null
					tmp/obj/tele = null

				New()
					tag = name
					spawn(10)
						if(src.loc)
							var/obj/shad = new
							var/icon/I = new(src.icon)
							I.icon -= rgb(255,255,255)
							//I.Flip(NORTH)
							shad.icon = I
							shad.alpha = 100
							shad.pixel_y = -9
							src.underlays += shad
							while(src)
								if(src.loc == null) return
								if(src.active)
									animate(src, pixel_z = 134, time = 6)
									animate(transform = turn(matrix(), 1), time = 4)
									animate(pixel_z = 128, time = 6)
									animate(transform = turn(matrix(), -1), time = 4)
									var/found_someone = 0
									for(var/mob/m in range(6,src))
										animate(alpha = 175, time = 1)
										found_someone = 1
										break
									if(found_someone == 0) animate(alpha = 255, time = 1)
								sleep(20)

			Lightning_Rod
				info_name = "Lightning_Rod"
				icon = 'lightening_rod.dmi'
				icon_state = ""
				value = 1000
				density_factor = 1
				hashadow = 0
				bounds = "11,1 to 21,16"
				desc = "The lightning rod can be useful in support of solar panels or other power generators that aren't entirely reliable. Once a storm begins, there is around a 10% chance per every 10 seconds that a bolt of lightning will strike this rod, increasing the capacity of a near by battery by 25%"
				tech_tree = "Engineering"
				tech_subtech = ""
				New()
					..()
					tag = name
					category = list("Power Generation")
					var/image/sel = image('fx_large.dmi',src,"select item",1000)
					src.img_select = sel
					spawn(1)
						if(src.loc)
							var/obj/shad = new
							shad.icon = src.icon
							shad.icon_state = "shadow"
							shad.alpha = 100
							shad.pixel_y = -3
							shad.loc = src.loc
							shad.bolted = 2
							src.shadow = shad
			world_tree
				icon = 'world_tree.dmi'
				icon_state = "stump"
				name = "Yukka Tree"
				bolted = 2
				hashadow = 0
				pixel_x = -1226 //moved 8
				density_factor = 2
				generator = 1;
				generates = 10000
				appearance_flags = 0
				organic = 1
				bounds = "-90,184 to 121,250"
				immune_dmg = 1
				invul_melee = 1
				mouse_opacity = 0
				//hashadow = 1
				var/image/wt_trunk
				var/image/wt_trunk_opaque
				var/image/wt_top
				var/list/wt_rays
				var/obj/wt_overlay
				var/setup = 0
				New()
					src.layer = 4.484
					spawn(10) //Make it spawn, so it doesn't land up creating things in 0,0,0
						if(src)
							if(src.setup) return

							src.setup = 1

							if(src.wt_overlay) src.wt_overlay.loc = src.loc

							src.wt_top = null
							src.wt_trunk = null
							src.wt_rays = null
							src.overlays = null
							src.underlays = null
							src.particles = null
							src.vis_contents = null


							var/image/top = image('world_tree.dmi',src,"tree top",src.layer+1)
							//top.filters = filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
							src.wt_top = top
							top.mouse_opacity = 0

							var/image/trunk = image('world_tree.dmi',src,"trunk",4.484)
							src.wt_trunk = trunk
							trunk.mouse_opacity = 0

							var/image/trunk_opaque = image('world_tree.dmi',src,"trunk",4.484)
							trunk_opaque.alpha = 200
							src.wt_trunk_opaque = trunk_opaque
							trunk_opaque.mouse_opacity = 0

							//Creates the divine golden overlay for the tree top
							var/obj/items/misc/world_tree_overlay/o = new
							o.layer = src.layer+11;
							o.loc = src.loc
							o.pixel_x = src.pixel_x
							o.mouse_opacity = 0
							src.wt_overlay = o

							//Pulsates the world tree top, with some alpha. Makes it look like it's thrumming with power.
							var/obj/i = new
							i.icon = src.icon
							i.icon_state = "tree top"
							i.loc = src.loc
							i.step_x = src.step_x
							i.step_y = src.step_y
							i.pixel_x = src.pixel_x
							i.pixel_y = src.pixel_y
							i.layer = src.layer+10;
							i.alpha = 155
							i.mouse_opacity = 0
							animate(i, transform = matrix()*1.1,alpha = 0, time = 20, loop = -1)
							animate(transform = matrix()*1,alpha = 155,time = 0)

							//Creates spores infused with divine energy slowly drift from the tree. Makes use of particles and filters.
							var/obj/spores = new
							spores.icon = src.icon
							spores.icon_state = "empty"
							spores.loc = src.loc
							spores.pixel_x = src.pixel_x
							spores.layer = src.layer+11;
							spores.particles = new/particles/world_tree_spores
							spores.filters += filter(type="drop_shadow", x=0, y=0, size=2, offset=1, color=rgb(155,255,255))
							spores.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
							spores.invisibility = 1

							src.wt_rays = list()

							//----------------------------------------------------------------------------------------------------------
							//Creates a series of massive light rays that shine down from the tree tops like a divine beam of energy.
							var/image/rays = image('world_tree.dmi',src,"empty",2.1)
							rays.pixel_x = 833
							rays.pixel_y = 200
							rays.layer = 5
							rays.filters += filter(type="rays",x=0,y=0,size=1000,color=rgb(255,255,255),offset=0,density=15,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
							animate(rays.filters[1],offset = 100,time = 10000, loop = -1)
							animate(offset = 0,time = 0)
							src.wt_rays += rays
							//----------------------------------------------------------------------------------------------------------
							var/image/rays2 = image('world_tree.dmi',src,"empty",2.1)
							rays2.pixel_x = -833
							rays2.pixel_y = 200
							//rays2.loc = src.loc
							rays2.layer = 5
							rays2.filters += filter(type="rays",x=0,y=0,size=1000,color=rgb(255,255,255),offset=0,density=15,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
							animate(rays2.filters[1],offset = 200,time = 10000, loop = -1)
							animate(offset = 0,time = 0)
							src.wt_rays += rays2
							//----------------------------------------------------------------------------------------------------------
							var/image/rays3 = image('world_tree.dmi',src,"empty",2.1)
							rays3.pixel_x = 0
							rays3.pixel_y = 264
							//rays3.loc = src.loc
							rays3.layer = 4.3
							rays3.filters += filter(type="rays",x=0,y=0,size=1000,color=rgb(255,255,255),offset=0,density=15,threshold=0.5,factor=0,flags=FILTER_OVERLAY)
							animate(rays3.filters[1],offset = 300,time = 10000, loop = -1)
							animate(offset = 0,time = 0)
							src.wt_rays += rays3
							//----------------------------------------------------------------------------------------------------------
							for(var/mob/m in players)
								if(m.client && m.z == 4)
									m.show_worldtree(1)
			Conveyor_Belt
				info_name = "Conveyor_Belt"
				icon = 'conveyor_belt.dmi'
				icon_state = "move"
				value = 200
				bolted = 2
				hashadow = 0
				density_factor = 0
				dir = SOUTH
				New()
					..()
					tag = name
					var/image/sel = image('fx.dmi',src,"select item",1000)
					src.img_select = sel
					name = "[src.name] ([src.value])"
					spawn(10)
						layer = 2
						while(src)
							if(src.loc)
								for(var/atom/movable/a in src.loc)
									if(bounds_dist(a, src) < -14 )
										if(a != src)
											if(a.bolted == 0)
												//a.step_x = 0
												//a.step_y = 0
												step(a,src.dir,16)
												//Move(NewLoc,Dir=0,step_x=0,step_y=0)
												a.set_shadow()
							sleep(2)
						/*
						while(src)
							if(src.powered == null)
								for(var/obj/items/tech/Power_Line/p in range(0,src))
									if(p.powered) src.powered = p.powered
							if(src.powered == null)
								src.icon_state = "stop"
							if(src.powered)
								src.icon_state = "move"
								src.check_power_belts()
								var/n = 0
								for(var/atom/a in src.loc)
									if(!a.bolted)
										var/moves = 1
										n += 1
										if(n >= 50)
											return
										if(isobj(a))
											a.pixel_x = 0
											a.pixel_y = 0
										if(ismob(a))
											var/mob/m = a
											if(m.state == "fly")
												moves = 0
										if(moves) step(a,src.dir)
										for(var/obj/items/tech/t in a.loc)
											if(t.silo) if(istype(a,/obj/items/resources))
												t.value += a.value
												del(a)
												break
							sleep(3)
						*/
			weights
				change_icon = 0
				can_pocket = 1;
				stacks = -1
				weight = 1
				desc = "Weighted clothing can be very useful for increasing your Strength and Psionic Power. So long as you wear weights that are as heavy as half your Lift, you will gain benefit from using them.\n\nKeep in mind that wearing these will decrease your Agility slightly, making you slower in combat. And will also force your Psionic Power to half while worn, due to the strain of wearing them.\n\nRight clicking these in their creation menu will allow you to set their weight. The higher their weight, the higher the cost for their production."
				act = /obj/items/tech/weights/proc/use
				act_drop = /obj/items/tech/weights/proc/drop
				floor_state = "ground"
				appearance_flags = KEEP_TOGETHER
				has_subtech = 1
				proc
					use(var/mob/m,var/obj/items/tech/weights/i)
						if(i in m.accessing)
							var/mob/x = m.accessing
							//Remove
							if(i.suffix == "worn")
								i.overlays -= /obj/effects/select_item
								i.icon_state = "ground"
								i.layer = 3
								i.suffix = null
								i.name = "[initial(i.name)] ([i.weight] pounds)"
								x.update_weight()
								x.redraw_appearance()
								i.overlays += /obj/effects/select_item
								x.refresh_inv()
								return
							else
								//Wear
								var/w_num = 0
								var/w_current = i.weight
								for(var/obj/items/tech/weights/wgt in x)
									if(wgt.suffix == "worn")
										w_num += 1
										w_current += wgt.weight
								if(w_num >= 3)
									m << "[x] cannot wear more than 3 sets of weighted clothing or items."
									m.set_alert("Too many weights",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Too many weights.")
									return
								if(w_current > ((x.strength+x.endurance)*2))
									m << "Putting this on would exceed [x]'s maximum lift of [Commas(round((x.strength+x.endurance)*2))] pounds. You cannot use it."
									m.set_alert("Exceeds max lift",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Exceeds max lift.")
									return
								i.overlays -= /obj/effects/select_item
								i.icon_state = ""
								i.layer = FLOAT_LAYER
								i.suffix = "worn"
								i.name = "[i.name] *worn*"
								x.update_weight()
								x.redraw_appearance()
								i.overlays += /obj/effects/select_item
								x.refresh_inv()
								return
					drop(var/mob/m,var/obj/items/tech/weights/i)
						//Drop
						if(i in m.accessing)
							var/mob/x = m.accessing
							//Remove first
							if(i.suffix == "worn")
								i.icon_state = "ground"
								i.layer = 3
								i.suffix = null
								i.name = "[initial(i.name)] ([i.weight] pounds)"
								i.desc_extra = "- [i.weight] pound weights"
								x.update_weight()
								x.redraw_appearance()
							m.drop(i)
							return
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
					else if(params["right"])
						if(src.loc == null)
							//winset(usr,"numbers.label_numbers","text=\"How heavy do you want to make these weights? Higher weights cost more.\"")
							//winshow(usr,"numbers",1)
							usr.numbers_text = "tech weights"
							usr.left_click_ref = src
							//winset(usr,"numbers.input_number","focus=true")
							usr.hud_confirm_nums.confirm_text(1,"How heavy do you want to make these weights?",usr)
				wrist_bands
					icon = 'weights_wrist.dmi'
					icon_state = "ground"
					name = "Wrist Weights"
					value = 1000
					layer = 3
					density_factor = 0
					appearance_flags = KEEP_TOGETHER
					New()
						var/image/sel = image('fx_medium.dmi',src,"select item",1000)
						src.img_select = sel
						spawn(6)
							if(src && src.spawned == 0) if(isturf(src.loc))
								src.icon_state = "ground"
								src.name = "[src.name] ([src.weight] pounds)"
								src.desc_extra = "- [src.weight] pound weights"
								src.spawned = 1
			digging
				stacks = -1
				Drill
					info_name = "Drill"
					mouse_over_pointer = MOUSE_ACTIVE_POINTER
					icon = 'drill.dmi'
					value = 1000
					can_pocket = 1
					density_factor = 0
					weight = 1
					desc = "Drills operate much faster than other tools, and faster still than digging with bare hands. The amount dug up by these compared to basic digging is thrice times."
					tech_tree = "Engineering"
					act = /obj/items/tech/digging/Drill/proc/use
					act_drop = /obj/items/tech/digging/Drill/proc/drop
					appearance_flags = KEEP_TOGETHER
					has_subtech = 1
					proc
						use(var/mob/m,var/obj/items/tech/i)
							if(i in m.accessing)
								var/mob/x = m.accessing
								for(var/obj/items/tech/digging/A in x) if(A!=i && A.suffix)
									m << "Already have a tool equipped."
									m.set_alert("Another tool already equipped.",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Another tool already equipped.")
									return
								if(!i.suffix)
									i.suffix = "equipped"
									i.name = "Drill *equipped*"
									if(m.skill_dig && m.skill_dig.active)
										m.skill_dig.dig_mod = 3
										m.overlays += 'drill_dig.dmi'
										m.icon_state = "drill"
									m.refresh_inv()
									return
								else
									i.suffix = null
									i.name = "Drill"
									if(m.skill_dig)
										m.skill_dig.dig_mod = 1
										m.overlays -= 'drill_dig.dmi'
										if(m.skill_dig.active) m.icon_state = "dig"
									m.refresh_inv()
									return
						drop(var/mob/m,var/obj/items/tech/i)
							if(i in m.accessing)
								if(i.suffix)
									i.suffix = null
									i.name = "Drill"
									if(m.skill_dig)
										m.skill_dig.dig_mod = 1
										m.overlays -= 'drill_dig.dmi'
										if(m.skill_dig.active) m.icon_state = "dig"
								m.drop(i)
					New()
						tag = name
						category = list("Resource Extraction")
						var/image/sel = image('fx.dmi',src,"select item",1000)
						src.img_select = sel
					Click(location,control,params)
						..()
						//Removes this item from the global Items list.
						if(items)
							if(src in items) items -= src
						params = params2list(params)
						if(params["left"])
							if(isturf(src.loc))
								usr.pickup(src)
							else if(ismob(src.loc))
								if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
								usr.item_selected = src
								src.overlays -= /obj/effects/select_item
								src.overlays += /obj/effects/select_item
				Shovel
					info_name = "Shovel"
					mouse_over_pointer = MOUSE_ACTIVE_POINTER
					icon = 'spade.dmi'
					value = 1000
					can_pocket = 1
					density_factor = 0
					weight = 1
					desc = "Shovels will help with manual digging quite a bit, helping you extract more resources faster. They are twice as good as digging with bare hands."
					tech_tree = "Engineering"
					act = /obj/items/tech/digging/Shovel/proc/use
					act_drop = /obj/items/tech/digging/Shovel/proc/drop
					appearance_flags = KEEP_TOGETHER
					proc
						use(var/mob/m,var/obj/items/tech/i)
							if(i in m)
								for(var/obj/items/tech/digging/A in m) if(A!=i && A.suffix)
									m << "You already have a tool equipped."
									m.set_alert("Another tool already equipped.",'alert.dmi',"alert")
									m.create_chat_entry("alerts","Another tool already equipped.")
									return
								if(!i.suffix)
									i.suffix = "equipped"
									i.name = "Shovel *equipped*"
									if(m.skill_dig && m.skill_dig.active)
										m.skill_dig.dig_mod = 2
										m.overlays += 'spade_dig.dmi'
										m.icon_state = "dig"
									m.refresh_inv()
									return
								else
									i.suffix = null
									i.name = "Shovel"
									if(m.skill_dig)
										m.skill_dig.dig_mod = 1
										m.overlays -= 'spade_dig.dmi'
										if(m.skill_dig.active) m.icon_state = "dig"
									m.refresh_inv()
									return
						drop(var/mob/m,var/obj/items/tech/i)
							if(i in m.accessing)
								if(i.suffix)
									i.suffix = null
									i.name = "Shovel"
									if(m.skill_dig)
										m.skill_dig.dig_mod = 1
										m.overlays -= 'spade_dig.dmi'
										if(m.skill_dig.active) m.icon_state = "dig"
								m.drop(i)
					New()
						tag = name
						category = list("Resource Extraction")
						var/image/sel = image('fx.dmi',src,"select item",1000)
						src.img_select = sel
					Click(location,control,params)
						..()
						//Removes this item from the global Items list.
						if(items)
							if(src in items) items -= src
						params = params2list(params)
						if(params["left"])
							if(isturf(src.loc))
								usr.pickup(src)
							else if(ismob(src.loc))
								if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
								usr.item_selected = src
								src.overlays -= /obj/effects/select_item
								src.overlays += /obj/effects/select_item
			doors
				opacity = 1
				var/pass = null
				Security_Door_MKI
					info_name = "Security Door Mk I"
					mouse_over_pointer = MOUSE_ACTIVE_POINTER
					icon = 'door_tech_01.dmi'
					icon_state = "closed"
					value = 0
					can_pocket = 0
					density_factor = 2
					bolted = 2
					hashadow = 0
					weight = 1
					desc = ""
					tech_tree = "Engineering"
					has_subtech = 1
					var/icons = list('door_tech_01.dmi','door_tech_02.dmi','door_tech_03.dmi','door_tech_04.dmi')
					var/I = 1
					New()
						tag = name
						category = list("Resource Extraction")
						var/image/sel = image('fx.dmi',src,"select item",1000)
						src.img_select = sel
					Click(location,control,params)
						..()
						winset(usr,"main.map_main","focus=true")
						params = params2list(params)
						if(params["right"])
							if(src.loc == null)
								var/L = length(src.icons)
								if(I+1 > L) I = 1
								else I += 1
								src.icon = src.icons[I]
								if(usr.build_tech_selected == src)
									var/icon/I = icon(src.icon,src.icon_state,SOUTH,1,0)
									I.Scale(src.scale_x,src.scale_y)
									var/Z = fcopy_rsc(I)
									winset(usr,"tech.label_img","image=\ref[Z]")
							else if(src.density_factor >= 1)
								if(src.pass != null)
									if(winget(usr,"confirm","is-visible") == "false")
										winset(usr,"numbers.label_numbers","text=\"Enter door password.\"")
										winshow(usr,"numbers",1)
										usr.numbers_text = "door password"
										usr.left_click_ref = src
										winset(usr,"numbers.input_number","focus=true")
								else
									src.icon_state = "opening"
									src.density_factor = 0
									sleep(60)
									src.icon_state = "closing"
									src.density_factor = 2
						else if(src.loc)
							if(get_dist(src,usr) <= 1)
								for(var/mob/m in range(8,src))
									m << output("There is a loud knock on the door!","chat.local")
			Canister
				info_name = "Canister"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				icon = 'canister.dmi'
				icon_state = "empty"
				value = 1000
				can_pocket = 1
				density_factor = 0
				weight = 1
				desc = "This handy portable container will let you store items inside that are far in excess the size of this device. It can fit just about anything within itself, so long as an item isn't bolted to the ground. To use the device, place it near something you want stored and then right click the canister. To unload it, simply right click again."
				tech_tree = "Engineering"
				tech_subtech = "Compression Techniques"
				act = /obj/items/tech/Canister/proc/use
				act_drop = /obj/items/tech/Canister/proc/drop
				appearance_flags = KEEP_TOGETHER
				stacks = -1
				proc
					use(var/mob/m,var/obj/items/tech/i)
						if(i in m.accessing)
							var/mob/x = m.accessing
							x.drop(i)
							i.compress("right",x)
							i.overlays -= /obj/effects/select_item
							x.refresh_inv()
					drop(var/mob/m,var/obj/items/tech/i)
						m.drop(i)
				New()
					tag = name
					category = list("Storage")
					var/image/sel = image('fx.dmi',src,"select item",1000)
					src.img_select = sel
				Click(location,control,params)
					..()
					winset(usr,"main.map_main","focus=true")
					params = params2list(params)
					if(params["left"])
						if(isturf(src.loc))
							usr.pickup(src)
							return
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
					if(params["right"])
						if(isturf(src.loc))
							src.compress("right",usr)
							return
			Scanner
				info_name = "Scanner"
				icon = 'scanner.dmi'
				icon_state = "floor"
				floor_state = "floor"
				value = 1000
				layer = 3.1
				density_factor = 0
				hashadow = 0
				can_pocket = 1;
				stacks = -1
				desc = "Used to scan stuff."
				desc_extra = "- Maximum scan threshold: 1000"
				tech_tree = "Physics"
				tech_subtech = "Scanners"
				tech_parent_path = /obj/items/tech/sub_tech/Physics/Energy_Scanners
				tech_upgradable = 1
				act = /obj/items/tech/Scanner/proc/use
				act_drop = /obj/items/tech/Scanner/proc/drop
				appearance_flags = KEEP_TOGETHER
				proc
					use(var/mob/m,var/obj/items/tech/i)
						if(i in m.accessing)
							var/mob/x = m.accessing
							for(var/obj/items/tech/Scanner/A in x) if(A!=i && A.suffix)
								m << "Already have a tool equipped."
								return
							if(!i.suffix)
								i.overlays -= /obj/effects/select_item
								i.suffix = "worn"
								i.name = "Scanner *worn*"
								i.icon_state = ""
								i.layer = 13
								x.redraw_appearance()
								i.overlays += /obj/effects/select_item
								return
							else
								i.icon_state = "floor"
								i.suffix = null
								i.name = "Scanner"
								i.layer = initial(i.layer)
								x.redraw_appearance()
								return
					drop(var/mob/m,var/obj/items/tech/i)
						if(i in m.accessing)
							var/mob/x = m.accessing
							if(i.suffix)
								i.overlays -= /obj/effects/select_item
								i.icon_state = "floor"
								i.suffix = null
								i.name = "Scanner"
								i.layer = initial(i.layer)
								x.redraw_appearance()
							m.drop(i)
				Click(location,control,params)
					..()
					//Removes this item from the global Items list.
					if(items)
						if(src in items) items -= src
					params = params2list(params)
					if(params["left"])
						//Upgrade scanner
						if(usr.left_click_function == "upgrade scanner")
							if(src.loc)
								if(src in range(2,usr))
									usr.left_click_function = null
									for(var/obj/items/tech/sub_tech/Physics/Energy_Scanners/SE in global.tech)//usr.technology_researched)
										if(usr.tech_unlocked[SE.list_pos] == SE.type)
											if(usr.tech_lvls[SE.list_pos] > 0)
												src.level = usr.tech_lvls[SE.list_pos]
												src.desc_extra = "- Maximum scan threshold: [src.level*1000]"
												usr << output("Upgraded Scanner to level [src.level].", "chat.system")
												usr.set_alert("Upgraded scanner",SE.icon,SE.icon_state)
												usr.create_chat_entry("alerts","Upgraded scanner.")
												animate(SE, color = list("#000", "#000", "#000", "#fff"),time = 4)
												animate(color = initial(SE.color),time = 4)
												break
											else
												usr << output("Need at least one level in Scanners.", "chat.system")
												usr.set_alert("Need Scanners technology",'alert.dmi',"alert")
												usr.create_chat_entry("alerts","Need Scanners technology.")
												return
									return
								else
									usr << output("[src] is out of range for upgrading.", "chat.system")
									usr.set_alert("Out of range",'alert.dmi',"alert")
									usr.create_chat_entry("alerts","Out of range.")
									return
							else
								usr << output("[src] is out of range for upgrading.", "chat.system")
								usr.set_alert("Out of range",'alert.dmi',"alert")
								usr.create_chat_entry("alerts","Out of range.")
								return
						else if(isturf(src.loc))
							usr.pickup(src)
						else if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
			Defibrillator
				info_name = "Defibrillator"
				icon = 'artifacts_small.dmi'
				icon_state = "defibrillator"
				value = 100000
				layer = 3.1
				density_factor = 0
				hashadow = 1
				can_pocket = 1;
				stacks = -1
				desc = "This device is used to jump-start the heart of an organic being after it has stopped beating. \n\nIt only has one use, and only works on people who have been dead for less than 6 minutes. And only on bodies which haven't been destroyed. \n\nIt is also worth noting that a person revived in this manner will be in a weakened state, drained of energy and health until fully recovered."
				desc_extra = "- One use only\n\n- Revive recently deceased\n\n- Dead less than 6 minutes"
				tech_tree = "Genetics"
				tech_subtech = "Medical Equipment"
				act = /obj/items/tech/Defibrillator/proc/use
				act_drop = /obj/items/tech/Defibrillator/proc/drop
				appearance_flags = KEEP_TOGETHER
				proc
					use(var/mob/m,var/obj/items/tech/i)
						if(i in m.accessing)
							m.left_click_function = "revive defibrillator"
							m.left_click_ref = i
							m.set_alert("Select target to zap",i.icon,i.icon_state)
					drop(var/mob/m,var/obj/items/tech/i)
						m.drop(i)
				Click(location,control,params)
					..()
					params = params2list(params)
					if(params["left"])
						if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
						else if(isturf(src.loc))
							usr.pickup(src)
			Mechanical_Upgrade_Kit
				info_name = "Mechanical_Upgrade_Kit"
				icon = 'artifacts_small.dmi'
				icon_state = "android upgrade"
				value = 1000000
				layer = 3.1
				density_factor = 0
				hashadow = 0
				can_pocket = 1;
				desc = "This assortment of complicated tools is used to enhance, change and upgrade a mechanical bodypart. Able to interface with nearly any machine, the Upgrade Kit is of vital importance to Androids and Cyborgs seeking to have their forms optimized. This device can even be used by artifical beings on themselves and others.\n\nEach use of this device grants 10 levels in a mechanical bodypart, enhancing it up and beyond its normal operating parameters."
				desc_extra = "+10 levels to Mechanical parts"
				tech_tree = "Engineering"
				tech_subtech = "Robotics"
				Click(location,control,params)
					..()
					params = params2list(params)
					if(params["left"])
						if(ismob(src.loc))
							if(usr.item_selected) usr.item_selected.overlays -= /obj/effects/select_item
							usr.item_selected = src
							src.overlays -= /obj/effects/select_item
							src.overlays += /obj/effects/select_item
						else if(isturf(src.loc))
							usr.pickup(src)
			Power_Line
				info_name = "Power_Line"
				icon = 'power_lines_off.dmi'
				icon_state = "manifold"
				value = 100
				bolted = 1
				layer = 3.1
				density_factor = 0
				//plane = 0
				hashadow = 0
				tech_water = 1
				//appearance_flags = PIXEL_SCALE
				desc = "Power lines can be placed along the ground and linked together to form an energy network. Most technological structures require that these be under them. Its also very important to remember that a battery must be connected along the energy network, along with some form of power producing structure. Otherwise, anything connected to these lines won't function."
				tech_tree = "Engineering"
				tech_subtech = "None"
				var/damaged = 0
				var/grow_dir
				var/area/network = null
				var/built = 0
				var/skip = 0
				proc
					reconnect_power()
						var/pow_produced = 0 //Total power produced by all the tech connected to this network
						var/pow_used = 0 //Total power used on this network by the machines connected to it
						var/pow_excess = 0 //What's not being used currently
						var/pow_stored = 0 //How much power is stored inside batteries connected to this network. Used only when active power isn't enough.
						var/list/techs = list()

						if(src.network)
							src.network.bats_list = list()
							//----------Work out power used and whats left---------------
							for(var/obj/items/tech/tch in src.network)
								if(tch.type != /obj/items/tech/Power_Line)
									if(tch.grabbed_by == null)
										techs += tch
										if(tch.generator == 1 && tch.can_generate == 1)
											pow_produced += tch.generates;
										if(tch.type == /obj/items/tech/Battery)
											pow_stored += tch.capacity
											src.network.bats_list += tch
										if(tch.uses > 0 && tch.on == 1)
											pow_used += tch.uses;
											if(tch.on_always && tch.act) call(tch.act)(tch,src.network) //Will only change the visuals. (Although icon_state is important for checks)
							//-----------------------------------------------------------

							pow_excess = pow_produced - pow_used

							//----------Work out what to turn off, if needed-------------
							if(pow_excess < 0 && pow_stored <= 0)
								for(var/obj/items/tech/tch in techs)
									if(tch.on_always == 0 && tch.on && tch.act)
										pow_used -= tch.uses;
										call(tch.act)(tch) //These calls should shut down the machine
							//-----------------------------------------------------------

							pow_excess = pow_produced - pow_used
							src.network.currents_grid = pow_produced
							src.network.excess_grid = pow_excess
							src.network.used_grid = pow_used
							src.network.stored_grid = pow_stored

							var/power = 1
							var/I = 'power_lines.dmi'
							if(pow_produced <= 0) src.network.currents_grid = pow_stored
							if(pow_produced <= 0 && pow_stored <= 0)
								I = 'power_lines_off.dmi'
								power = 0
							src.network.power_grid = power

							for(var/obj/items/tech/Power_Line/p in src.network)
								p.icon = I
				MouseEntered()
					..()
					if(usr.toggled_info) usr.show_info(src.loc)
				proc
					check_lines(var/change = 0)
						var/obj/items/tech/Power_Line/found_north = null
						var/obj/items/tech/Power_Line/found_south = null
						var/obj/items/tech/Power_Line/found_east = null
						var/obj/items/tech/Power_Line/found_west = null
						src.icon_state = "dirs"
						for(var/obj/items/tech/Power_Line/p in locate(src.x+1,src.y,src.z))
							if(p.damaged == 0)
								found_east = p
								src.dir = EAST
								if(change) p.check_lines()
								break
						for(var/obj/items/tech/Power_Line/p in locate(src.x-1,src.y,src.z))
							if(p.damaged == 0)
								found_west = p
								src.dir = WEST
								if(change) p.check_lines()
								break
						for(var/obj/items/tech/Power_Line/p in locate(src.x,src.y+1,src.z))
							if(p.damaged == 0)
								found_north = p
								src.dir = NORTH
								if(change) p.check_lines()
								break
						for(var/obj/items/tech/Power_Line/p in locate(src.x,src.y-1,src.z))
							if(p.damaged == 0)
								found_south = p
								src.dir = SOUTH
								if(change) p.check_lines()
								break
						if(found_west && found_north)
							src.icon_state = "bottom left"
						if(found_east && found_north)
							src.icon_state = "bottom right"
						if(found_west && found_south)
							src.icon_state = "top right"
						if(found_east && found_south)
							src.icon_state = "top left"
						if(found_north && found_south && found_east)
							src.icon_state = "manifold left"
						if(found_north && found_south && found_west)
							src.icon_state = "manifold right"
						if(found_north && found_east && found_west)
							src.icon_state = "manifold bottom"
						if(found_south && found_east && found_west)
							src.icon_state = "manifold top"
						if(found_north && found_south && found_west && found_east)
							src.icon_state = "manifold"
						src.bounds = "1,1 to 32,32"
						if(src.icon_state == "dirs")
							if(dir == NORTH || dir == SOUTH)
								src.bounds = "12,1 to 21,32"
							if(dir == EAST || dir == WEST)
								src.bounds = "1,12 to 32,21"
						var/n = 0
						for(var/obj/items/tech/Power_Line/p in range(1,src))
							if(p != src) n += 1
						if(n < 2) src.icon_state = "dirs end"
					check_connections()
						if(src.network)
							var/list/lines = list()
							var/list/areas = list()
							for(var/obj/items/tech/Power_Line/pow in src.network)
								if(pow != src)
									src.network.contents -= pow.loc
									pow.network = null
									lines += pow
							src.network.contents -= src.loc
							src.network = null

							new /area (src.loc)
							src.damaged = 1
							for(var/obj/items/tech/Power_Line/p in range(1,src))
								p.check_lines(1)
							//var/this_needs_removing_later_IMPORTANT
							//src.loc = null

							for(var/obj/items/tech/Power_Line/pow in lines)
								pow.setting = 1
								pow.New()
							spawn(6)
								for(var/obj/items/tech/Power_Line/pow in lines)
									if(pow.network)
										if(areas.Find(pow.network) == 0) areas += pow.network
								spawn(0)
									for(var/area/a in areas)
										for(var/obj/items/tech/Power_Line/pow in a)
											pow.reconnect_power()
											break
				Click()
					..()
					//if(src.loc) src.check_connections()
				New()
					if(src.loc == null)
						tag = name
						category = list("Power Transference")
						var/image/sel = image('fx.dmi',src,"select item",1000)
						src.img_select = sel
					spawn(0)
						if(src.loc != null)
							if(src.setting == 0) src.check_lines(1)
							spawn(0)
								src.spawning = 0;
								if(src.network == null)
									var/create_new = 1
									var/list/networks = list()
									for(var/obj/items/tech/Power_Line/p in orange(1,src))
										if(p.network)
											if(networks.Find(p.network) == 0)
												networks += p.network
											create_new = 0
									var/area/main = null
									for(var/area/a in networks)
										if(main == null)
											main = a
											src.network = main
											main.contents += src.loc
										else
											for(var/obj/items/tech/Power_Line/p in a)
												p.network = main
												main.contents += p.loc
									if(create_new)
										var/area/new_network = new(null)
										//new_network.icon = 'terrain.dmi'
										//new_network.icon_state = "n[rand(1,8)]"
										new_network.power_grid = 1
										new_network.layer = 2.1
										src.network = new_network
										new_network.contents += src.loc
										//network_psionica.contents += src.loc
								//var/turf/t = src.loc
								//t.icon = null
								if(src.built) src.reconnect_power()
								if(src.organic)
									src.icon = 'power_lines_vines.dmi'
									src.layer = 3
									//src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(155,255,255))
			/*
			Cage_Tech
				name = "Cage"
				icon = 'cages.dmi'
				icon_state = "cage tech closed"
				value = 1000
				pixel_x = -16
				desc = "This item is useful for locking away others so you may transport them, deal with them later or even use your technology on them. Whatever the intention, the cage will hold a single prisoner. Before dropping someone inside, they must be rendered unconscious first. Right clicking the cage opens and closes it."
				var
					tmp/mob/prisoner = null
				New()
					..()
					var/image/sel = image('fx.dmi',src,"select item",1000)
					src.img_select = sel
					name = "[src.name] ([src.value])"
					spawn(1)
						while(src)
							if(src.icon_state == "cage tech closed")
								if(src.prisoner)
									var/mob/m = src.prisoner
									m.loc = src.loc
									m.pixel_z = src.pixel_z
									m.layer = 2.1
									m.density_factor = 0
									m.building = 1
									m.can_attack = 0
									if(m.client) m.disable_skills(list(/obj/skills/Meditate))
							sleep(0.1)
				Click(location,control,params)
					if("ko" in usr.debuffs) return
					if(src in range(2,usr))
						params = params2list(params)
						winset(usr,"main.map_main","focus=true")
						if(usr == src.prisoner)
							return
						if(params["right"])
							if(src.icon_state == "cage tech closed")
								src.icon_state = "cage tech open"
								if(src.prisoner)
									var/mob/m = src.prisoner
									m.density_factor = initial(m.density_factor)
									m.layer = initial(m.layer)
									m.bolted = 0
									m.can_attack = 1
									m.building = 0
								src.prisoner = null
								return
							if(src.icon_state == "cage tech open")
								src.icon_state = "cage tech closed"
								for(var/mob/m in range(0,src))
									//if("ko" in m.debuffs)
									src.prisoner = m
									m.bolted = 1
								return
					..()
			*/
			Printer
				info_name = "Printer"
				name = "Printer"
				icon = 'droid_printer.dmi'
				icon_state = "off"
				value = 1000
				weight = 1
				hashadow = 0
				on = 1;
				bounds = "-7,2 to 38,18"
				density_factor = 1;
				pixel_x = -36;
				uses = 100
				var
					set_for = null;
					mob/in_use = null;
					growth_percent = 0
					points = 10;
					points_assigned = 0;
					points_limit = 2;
					cost = 0;
					lowest = 0;
					clone_type = "Clone"
					on_grid = 0;

					tech_psi_base = 1;
					tech_energy_base = 1
					tech_strength_base = 1
					tech_endurance_base = 1
					tech_agility_base = 1
					tech_force_base = 1
					tech_resistance_base = 1
					tech_offence_base = 1
					tech_defence_base = 1
					tech_regeneration_base = 1
					tech_recovery_base = 1

					tech_psi_mod_base = 1;
					tech_energy_mod_base = 1
					tech_strength_mod_base = 1
					tech_endurance_mod_base = 1
					tech_agility_mod_base = 1
					tech_force_mod_base = 1
					tech_resistance_mod_base = 1
					tech_offence_mod_base = 1
					tech_defence_mod_base = 1
					tech_regeneration_mod_base = 1
					tech_recovery_mod_base = 1

					tech_psi = 1;
					tech_energy = 1
					tech_strength = 1
					tech_endurance = 1
					tech_agility = 1
					tech_force = 1
					tech_resistance = 1
					tech_offence = 1
					tech_defence = 1
					tech_regeneration = 1
					tech_recovery = 1

					tech_psi_stat = 1;
					tech_energy_stat = 1
					tech_strength_stat = 1
					tech_endurance_stat = 1
					tech_agility_stat = 1
					tech_force_stat = 1
					tech_resistance_stat = 1
					tech_offence_stat = 1
					tech_defence_stat = 1
					tech_regeneration_stat = 1
					tech_recovery_stat = 1

					tech_stat_cap = 1;
					tech_total_stats = 0;
				Del()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
				New()
					..()
					tag = name
					category = list("Robotics")
					var/image/sel = image('fx.dmi',src,"select item",1000)
					src.img_select = sel
					src.icon_state = "off"
					src.desc_extra = "Power usage: [src.uses] \n\nProcess: Activated \n\nCan be toggled on or off"
					spawn(1)
						if(src)
							for(var/turf/trf in src.locs)
								for(var/obj/items/tech/Power_Line/p in trf)
									p.reconnect_power()
								//if(power_grid[trf.x][trf.y][trf.z] == 1)
								if(trf.power_grid == 1)
									if(trf.excess_grid >= 0 || trf.stored_grid > 0) src.icon_state = "tank on"
									//if(excess_grid[trf.x][trf.y][trf.z] >= 0 || stored_grid[trf.x][trf.y][trf.z] > 0) src.icon_state = "tank on"
							while(src)
								if(src.loc == null) return
								if(src.on)
									var/powered = 0;
									if(src.grabbed_by == null && src.tk == 0)
										for(var/turf/trf in src.locs)
											//if(power_grid[trf.x][trf.y][trf.z] == 1)
											if(trf.power_grid == 1)
												if(trf.excess_grid >= 0 || trf.stored_grid > 0) powered = 1;
												//if(excess_grid[trf.x][trf.y][trf.z] >= 0 || stored_grid[trf.x][trf.y][trf.z] > 0) powered = 1;
									if(powered) src.icon_state = "on"
									else src.icon_state = "off"
								sleep(60)
				Move()
					..()
					if(src.in_use)
						//src.in_use.SetCenter(src)
						src.in_use.loc = src.loc;
						src.in_use.step_x = src.step_x//+36;
						src.in_use.step_y = src.step_y+24;
						src.in_use.layer = src.layer+1
						/*
						for(var/turf/trf in src.locs)
							for(var/obj/items/tech/Power_Line/p in trf)
								p.reconnect_power()
						*/
				Click(location,control,params)
					..()
					return
					usr.mouse_down = null
					params = params2list(params)
					if(params["right"])
						if(src in range(1,usr))
							if(src.on)
								src.on = 0;
								src.icon_state = "off"
								if(usr.tech_using == src)
									winshow(usr,"robotics",0)
									usr.tech_using = null;
									src.used_by = null
							else src.on = 1;

							var/powered = 0;
							if(src.grabbed_by == null && src.tk == 0)
								for(var/turf/trf in src.locs)
									for(var/obj/items/tech/Power_Line/p in trf)
										p.reconnect_power()
									//if(power_grid[trf.x][trf.y][trf.z] == 1)
									if(trf.power_grid == 1)
										if(trf.excess_grid >= 0 || trf.stored_grid > 0) powered = 1;
										//if(excess_grid[trf.x][trf.y][trf.z] >= 0 || stored_grid[trf.x][trf.y][trf.z] > 0) powered = 1;
							if(powered && src.on) src.icon_state = "on"
							else src.icon_state = "off"
					if(params["left"])
						if(src.on == 0) return
						if(src in range(1,usr))
							var/power_on = 0
							for(var/turf/trf in src.locs)
								//if(power_grid[trf.x][trf.y][trf.z] == 1)
								if(trf.power_grid == 1)
									if(trf.excess_grid >= 0 || trf.stored_grid > 0) power_on = 1;
									//if(excess_grid[trf.x][trf.y][trf.z] >= 0 || stored_grid[trf.x][trf.y][trf.z] > 0) power_on = 1;
							if(power_on == 1)
								//Reset any tech we might be using first.
								if(usr.tech_using)
									var/obj/t = usr.tech_using
									if(t.used_by == usr) t.used_by = null
									usr.tech_using = null
								if(src.used_by) return

								//if(usr.tech_using != src)
								usr.tech_using = src;
								src.used_by = usr;
								//usr.disable_skills()
								winshow(usr,"robotics",1)
								if(src.in_use)
									winset(usr,"genetics.button_grow","is-disabled=true")
									winset(usr,"genetics.button_terminate","is-disabled=false")
									winset(usr,"genetics.button_clone","is-disabled=true")
									winset(usr,"genetics.button_new","is-disabled=true")
									if(src.growth_percent >= 100) winset(usr,"genetics.button_power","is-disabled=false")
									else winset(usr,"genetics.button_power","is-disabled=true")
									if(src.generator) winset(usr,"genetics.button_power","is-checked=true")
									else winset(usr,"genetics.button_power","is-checked=false")
									//usr.adjust_buttons_robotics(1,1)
									var/mob/m = src.in_use
									var/icon/I = icon(m.icon,"",SOUTH,1,0)
									I.Scale(128,128)
									var/X = fcopy_rsc(I)
									winset(usr,"genetics.creation_portrait","image=\ref[X]")
								else
									//usr.adjust_buttons_robotics(0,0)
									winset(usr,"genetics.button_grow","is-disabled=false")
									winset(usr,"genetics.button_terminate","is-disabled=true")
									winset(usr,"genetics.button_clone","is-disabled=false")
									winset(usr,"genetics.button_new","is-disabled=false")
									winset(usr,"genetics.button_reset","is-disabled=false")
									winset(usr,"genetics.button_power","is-disabled=true")
									winset(usr,"genetics.button_power","is-checked=false")
									var/icon/I = icon(usr.icon,"",SOUTH,1,0)
									I.Scale(128,128)
									var/X = fcopy_rsc(I)
									winset(usr,"genetics.creation_portrait","image=\ref[X]")
									if(winget(usr,"genetics.button_clone","is-checked") == "true")
										src.set_vat_stats(0,usr)
									else
										src.set_vat_stats(1,usr)
			Vat
				info_name = "Vat"
				name = "Vat"
				icon = 'vat.dmi'
				icon_state = "tank off"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				value = 1000
				weight = 1
				hashadow = 1
				on = 1;
				on_always = 1
				bounds = "-7,2 to 39,18"
				density_factor = 1;
				pixel_x = -36;
				uses = 50
				can_activate = 1
				var
					set_for = null;
					mob/in_use = null;
					belongs = null
					growth_percent = 0
					points = 10;
					points_assigned = 0;
					points_limit = 2;
					cost = 0;
					lowest = 0;
					clone_type = "Clone"
					on_grid = 0;

					vat_psi_base = 1;
					vat_energy_base = 1
					vat_strength_base = 1
					vat_endurance_base = 1
					vat_agility_base = 1
					vat_force_base = 1
					vat_resistance_base = 1
					vat_offence_base = 1
					vat_defence_base = 1
					vat_regeneration_base = 1
					vat_recovery_base = 1

					vat_psi_mod_base = 1;
					vat_energy_mod_base = 1
					vat_strength_mod_base = 1
					vat_endurance_mod_base = 1
					vat_agility_mod_base = 1
					vat_force_mod_base = 1
					vat_resistance_mod_base = 1
					vat_offence_mod_base = 1
					vat_defence_mod_base = 1
					vat_regeneration_mod_base = 1
					vat_recovery_mod_base = 1

					vat_psi = 1;
					vat_energy = 1
					vat_strength = 1
					vat_endurance = 1
					vat_agility = 1
					vat_force = 1
					vat_resistance = 1
					vat_offence = 1
					vat_defence = 1
					vat_regeneration = 1
					vat_recovery = 1

					vat_psi_stat = 1;
					vat_energy_stat = 1
					vat_strength_stat = 1
					vat_endurance_stat = 1
					vat_agility_stat = 1
					vat_force_stat = 1
					vat_resistance_stat = 1
					vat_offence_stat = 1
					vat_defence_stat = 1
					vat_regeneration_stat = 1
					vat_recovery_stat = 1

					vat_stat_cap = 1;
					vat_total_stats = 0;

					vat_extra_heart = 0;
					vat_extra_kidneys = 0;
					vat_extra_lungs = 0;
					vat_extra_adrenal = 0;
					vat_extra_growth = 0;
					vat_extra_regen = 0;
					vat_extra_lobe = 0;
					vat_extra_spleen = 0;
					vat_extra_liver = 0;
					vat_extra_skin = 0;
					vat_has_hair = 0;
					vat_hair = 0;
					vat_hair_c = 0;
					vat_gen = 0;
					vat_ear = 0;
					vat_horn = 0;
					vat_skin = 0;
					vat_race = null;
					vat_clone_icon = null;
				proc
					round_mods()
						src.vat_psi = round(src.vat_psi,0.1)
						src.vat_energy = round(src.vat_energy,0.1)
						src.vat_strength = round(src.vat_strength,0.1)
						src.vat_agility = round(src.vat_agility,0.1)
						src.vat_endurance = round(src.vat_endurance,0.1)
						src.vat_force = round(src.vat_force,0.1)
						src.vat_resistance = round(src.vat_resistance,0.1)
						src.vat_offence = round(src.vat_offence,0.1)
						src.vat_defence = round(src.vat_defence,0.1)
						src.vat_regeneration = round(src.vat_regeneration,0.1)
						src.vat_recovery = round(src.vat_recovery,0.1)

						src.vat_psi_stat = round(src.vat_psi_stat,0.1)
						src.vat_energy_stat = round(src.vat_energy_stat,0.1)
						src.vat_strength_stat = round(src.vat_strength_stat,0.1)
						src.vat_endurance_stat = round(src.vat_endurance_stat,0.1)
						src.vat_agility_stat = round(src.vat_agility_stat,0.1)
						src.vat_force_stat = round(src.vat_force_stat,0.1)
						src.vat_resistance_stat = round(src.vat_resistance_stat,0.1)
						src.vat_offence_stat = round(src.vat_offence_stat,0.1)
						src.vat_defence_stat = round(src.vat_defence_stat,0.1)
						src.vat_regeneration_stat = round(src.vat_regeneration_stat,0.1)
						src.vat_recovery_stat = round(src.vat_recovery_stat,0.1)

						if(src.vat_psi_stat < 1) src.vat_psi_stat = 1;
						if(src.vat_energy_stat < 1) src.vat_energy_stat = 1;
						if(src.vat_endurance_stat < 1) src.vat_endurance_stat = 1;
						if(src.vat_strength_stat < 1) src.vat_strength_stat = 1;
						if(src.vat_resistance_stat < 1) src.vat_resistance_stat = 1;
						if(src.vat_force_stat < 1) src.vat_force_stat = 1;
						if(src.vat_offence_stat < 1) src.vat_offence_stat = 1;
						if(src.vat_defence_stat < 1) src.vat_defence_stat = 1;
					vat_grow(var/t = 100)
						if(t <= 0 || src.in_use == null) return
						t -= 1
						src.growth_percent += 1;
						spawn(1)
							if(src) src.vat_grow(t)
				Del()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
				New()
					..()
					tag = name
					category = list("Cloning")
					var/image/sel = image('fx.dmi',src,"select item",32)
					src.img_select = sel
					src.icon_state = "tank off"
					src.overlays += image('vat.dmi',src,"glass",32)
					src.desc_extra = "Power usage: [src.uses] \n\nProcess: Activated \n\nCan be toggled on or off"

					var/obj/hp_shell = new
					hp_shell.icon = 'bars_health.dmi'
					hp_shell.icon_state = "shell"
					hp_shell.pixel_y = 32
					hp_shell.plane = 6
					hp_shell.appearance_flags = KEEP_TOGETHER | TILE_BOUND
					hp_shell.loc = src

					spawn(1)
						if(src)
							if(src.in_use)
								var/mob/m = src.in_use
								m.loc = src.loc
								animate(m,pixel_y = 1,time = 10, loop = -1,flags = ANIMATION_PARALLEL)
								animate(pixel_y = 0,time = 10)
							if(src.organic) src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(155,255,255))
							for(var/turf/trf in src.locs)
								for(var/obj/items/tech/Power_Line/p in trf)
									p.reconnect_power()
								//if(power_grid[trf.x][trf.y][trf.z] == 1)
								if(trf.power_grid == 1)
									if(trf.excess_grid >= 0 || trf.stored_grid > 0) src.icon_state = "tank on"
									//if(excess_grid[trf.x][trf.y][trf.z] >= 0 || stored_grid[trf.x][trf.y][trf.z] > 0) src.icon_state = "tank on"
							var/dying = 0;
							while(src)
								if(src.loc == null) return
								if(src.on)
									var/powered = 0;
									if(src.grabbed_by == null && src.tk == 0)
										for(var/turf/trf in src.locs)
											//if(power_grid[trf.x][trf.y][trf.z] == 1)
											if(trf.power_grid == 1)
												if(trf.excess_grid >= 0 || trf.stored_grid > 0)  powered = 1;
												//if(excess_grid[trf.x][trf.y][trf.z] >= 0 || stored_grid[trf.x][trf.y][trf.z] > 0) powered = 1;
									if(powered)
										src.icon_state = "tank on"
										dying = 0;
									else
										src.icon_state = "tank off"
										if(src.in_use) dying = 1;

								else if(src.in_use) dying = 1;

								if(src.in_use)
									var/mob/m = src.in_use;

									if(m.hp_bar_clone == null)
										var/obj/hp = new
										hp.icon = 'bars_health.dmi'
										hp.icon_state = "bar"
										hp.pixel_y = 32
										hp.plane = 6
										hp.appearance_flags = KEEP_TOGETHER
										m.hp_bar_clone = hp

										var/obj/hp_slice = new
										hp_slice.icon = 'bars_health.dmi'
										hp_slice.icon_state = "bar hp"
										hp_slice.pixel_x = 1
										hp_slice.loc = hp
										hp_slice.plane = FLOAT_PLANE
										hp_slice.layer = FLOAT_LAYER
										hp_slice.blend_mode = BLEND_INSET_OVERLAY
										hp_slice.appearance_flags = KEEP_TOGETHER | TILE_BOUND

										hp.vis_contents += hp_slice
									if(dying)
										if(m.being_grown == 0)
											m.vis_contents += m.hp_bar_clone
											m.vis_contents += hp_shell
											var/obj/hp_slice = m.hp_bar_clone.contents[1]
											m.percent_health -= 10;
											hp_slice.pixel_x = (m.percent_health/3)-33
											if(m.percent_health <= 0)
												src.clone_die()
												dying = 0;
									else if(m.percent_health < 100)
										m.percent_health += 10;
										var/obj/hp_slice = m.hp_bar_clone.contents[1]
										m.percent_health -= 10;
										hp_slice.pixel_x = (m.percent_health/3)-33
									if(m.percent_health >= 100)
										m.vis_contents -= m.hp_bar_clone
										m.vis_contents -= hp_shell
									//world << output("Percent hp is - [m.percent_health]", "chat.system")
								sleep(60)
				Move()
					..()
					if(src.in_use)
						//src.in_use.SetCenter(src)
						src.in_use.loc = src.loc;
						if(src.organic)
							src.in_use.step_x = src.step_x-16
							src.in_use.step_y = src.step_y+10;
						else
							src.in_use.step_y = src.step_y+24;
							src.in_use.step_x = src.step_x//+36;
							src.in_use.layer = src.layer+1
					/*
					if(src)
						for(var/turf/trf in src.locs)
							for(var/obj/items/tech/Power_Line/p in trf)
								p.reconnect_power()
					*/
				Click(location,control,params)
					..()
					//var/enable_vats_later
					return
					usr.mouse_down = null
					params = params2list(params)
					if(src.organic)
						if(src.belongs == usr.real_name)
							if(src in range(1,usr))
								var/power_on = 0
								for(var/turf/trf in src.locs)
									//if(power_grid[trf.x][trf.y][trf.z] == 1)
									if(trf.power_grid == 1)
										if(trf.excess_grid >= 0 || trf.stored_grid > 0) power_on = 1;
										//if(excess_grid[trf.x][trf.y][trf.z] >= 0 || stored_grid[trf.x][trf.y][trf.z] > 0) power_on = 1;
								if(power_on == 1)
									if(src.in_use == null)
										usr.tech_using = src
										usr.grow_clones()
										usr.tech_using = null
										usr.part_selected = null
						return
					if(params["right"])
						if(src in range(1,usr))
							if(src.on)
								src.on = 0;
								src.icon_state = "tank off"
								if(usr.tech_using == src)
									winshow(usr,"genetics",0)
									usr.tech_using = null;
									src.used_by = null
							else src.on = 1;

							var/powered = 0;
							if(src.grabbed_by == null && src.tk == 0)
								for(var/turf/trf in src.locs)
									for(var/obj/items/tech/Power_Line/p in trf)
										p.reconnect_power()
									//if(power_grid[trf.x][trf.y][trf.z] == 1)
									if(trf.power_grid == 1)
										if(trf.excess_grid >= 0 || trf.stored_grid > 0) powered = 1;
										//if(excess_grid[trf.x][trf.y][trf.z] >= 0 || stored_grid[trf.x][trf.y][trf.z] > 0) powered = 1;
							if(powered && src.on) src.icon_state = "tank on"
							else src.icon_state = "tank off"
					if(params["left"])
						if(src.on == 0) return
						if(src in range(1,usr))
							var/power_on = 0
							for(var/turf/trf in src.locs)
								//if(power_grid[trf.x][trf.y][trf.z] == 1)
								if(trf.power_grid == 1)
									if(trf.excess_grid >= 0 || trf.stored_grid > 0) power_on = 1;
									//if(excess_grid[trf.x][trf.y][trf.z] >= 0 || stored_grid[trf.x][trf.y][trf.z] > 0) power_on = 1;
							if(power_on == 1)
								//Reset any tech we might be using first.
								if(usr.tech_using)
									var/obj/t = usr.tech_using
									if(t.used_by == usr) t.used_by = null
									usr.tech_using = null
								if(src.used_by)
									usr.set_alert("Already in use.",'alert.dmi',"alert")
									return

								//if(usr.tech_using != src)
								usr.tech_using = src;
								src.used_by = usr;
								//usr.disable_skills()
								winshow(usr,"genetics",1)
								if(src.clone_type == "Clone")
									winset(usr,"genetics.button_clone","is-checked=true")
									winset(usr,"genetics.button_new","is-checked=false")
								if(src.clone_type == "New")
									winset(usr,"genetics.button_clone","is-checked=false")
									winset(usr,"genetics.button_new","is-checked=true")
								if(src.in_use)
									winset(usr,"genetics.button_grow","is-disabled=true")
									winset(usr,"genetics.button_terminate","is-disabled=false")
									winset(usr,"genetics.button_clone","is-disabled=true")
									winset(usr,"genetics.button_new","is-disabled=true")
									if(src.growth_percent >= 100) winset(usr,"genetics.button_power","is-disabled=false")
									else winset(usr,"genetics.button_power","is-disabled=true")
									if(src.generator) winset(usr,"genetics.button_power","is-checked=true")
									else winset(usr,"genetics.button_power","is-checked=false")
									var/mob/m = src.in_use
									var/icon/I = icon(m.icon,"",SOUTH,1,0)
									I.Scale(128,128)
									if(m.race == "Demon")
										var/icon/C = icon('Demon_Base_Male_Black.dmi',"",SOUTH,1,0)
										C.Scale(128,128)
										C.Blend(m.hair_c)
										I.Blend(C,ICON_OVERLAY)
									if(m.hair)
										var/icon/E = icon(m.hair.icon,"",SOUTH,1,0)
										E.Scale(128,128)

										I.Blend(E,ICON_OVERLAY,1,10)

									//I.Shift(NORTH,5)
									var/X = fcopy_rsc(I)
									winset(usr,"genetics.creation_portrait","image=\ref[X]")
									winset(usr,"genetics.hair_color","background-color=[src.vat_hair_c]")
								else
									winset(usr,"genetics.hair_color","background-color=#5F5F5F")
									winset(usr,"genetics.button_grow","is-disabled=false")
									winset(usr,"genetics.button_terminate","is-disabled=true")
									winset(usr,"genetics.button_clone","is-disabled=false")
									winset(usr,"genetics.button_new","is-disabled=false")
									winset(usr,"genetics.button_reset","is-disabled=false")
									winset(usr,"genetics.button_power","is-disabled=true")
									winset(usr,"genetics.button_power","is-checked=false")

									var/icon/I = icon(usr.icon,"",SOUTH,1,0)
									I.Scale(128,128)

									if(usr.hair)
										var/icon/E = icon(usr.hair.icon,"",SOUTH,1,0)
										E.Scale(128,128)

										I.Blend(E,ICON_OVERLAY,1,10)

									//I.Shift(NORTH,5)

									var/X = fcopy_rsc(I)
									winset(usr,"genetics.creation_portrait","image=\ref[X]")
									winset(usr,"genetics.hair_color","background-color=[usr.hair_c]")

									if(winget(usr,"genetics.button_clone","is-checked") == "true")
										src.set_vat_stats(0,usr)
									else
										src.set_vat_stats(1,usr)
								winset(usr,"genetics.growth_percent","text=\"Growth Percent: [round(src.growth_percent)]%\"")
								winset(usr,"genetics.growth","value=[round(src.growth_percent)]")
								usr.show_info_vat(src)
			Container_Tech
				info_name = "Container_Tech"
				name = "Container"
				icon = 'containers.dmi'
				icon_state = "container tech closed"
				value = 1000
				weight = 1
				New()
					..()
					tag = name
					category = list("Storage")
					var/image/sel = image('fx.dmi',src,"select item",1000)
					src.img_select = sel
					name = "[src.name] ([src.value])"
			Silo
				info_name = "Silo"
				icon = 'silo.dmi'
				pixel_x = -32
				value = 2000
				density_factor = 1
				silo = 1
				New()
					..()
					tag = name
					var/image/sel = image('fx_large.dmi',src,"select item",1000)
					src.img_select = sel
					name = "[src.name] ([src.value])"
					spawn(1)
						if(src.loc == null) return
						else src.value = 0
			Resource_Cache
				info_name = "Resource_Cache"
				icon = 'crate.dmi'
				value = 10000
				density_factor = 1
				pixel_x = -16
				pixel_y = -10
				New()
					..()
					tag = name
					var/image/sel = image('fx_large.dmi',src,"select item",1000)
					src.img_select = sel
			Battery
				info_name = "Battery"
				icon = 'battery.dmi'
				icon_state = "battery"
				pixel_x = -32
				p_x = -32
				value = 2000
				density_factor = 1
				capacity = 0
				bounds = "-7,1 to 40,24"
				desc = "The battery vigilantly regulates the flow of electricity through all connected power lines. Its unwavering vigilance ensures that the entire network functions seamlessly, delivering power exactly where it's needed. A crucial element of modern technology, the battery is the cornerstone of countless machines and systems, and must always remain firmly connected to a power line in order to operate."
				tech_tree = "Physics"
				tech_subtech = "Electrochemistry"
				tech_upgradable = 1
				proc
					battery_power()
						for(var/turf/t in src.locs)
							for(var/obj/items/tech/Power_Line/p in t)
								if(p.network)
									var/area/a = p.network
									var/excess = a.excess_grid
									if(excess != null)
										var/bat_num = 0
										//If the battery is draining power
										if(excess < 0)
											for(var/obj/b in a.bats_list)
												if(b.capacity > 0) bat_num += 1
											if(bat_num > 0)
												src.capacity += excess/bat_num
												if(src.capacity <= 0) src.capacity = 0
											p.reconnect_power()
											break
										//If the battery is storing power
										if(excess > 0)
											for(var/obj/b in a.bats_list)
												if(b.capacity < b.capacity_max) bat_num += 1
											if(bat_num > 0)
												src.capacity += excess/bat_num
												if(src.capacity > src.capacity_max) src.capacity = src.capacity_max
											break
						src.overlays -= src.overlay_special
						src.overlay_special.icon_state = "[round(src.capacity/src.capacity_max*100,10)]"
						src.overlays += src.overlay_special
				New()
					..()
					category = list("Energy Storage")
					connections = list()
					var/image/sel = image('fx_large.dmi',src,"select item",1000)
					src.img_select = sel
					tag = name
					src.desc_extra = "Max capacity: [src.capacity_max]"
					spawn(1)
						if(src.loc == null)
							return
						for(var/turf/trf in src.locs)
							for(var/obj/items/tech/Power_Line/p in trf)
								p.reconnect_power()
								break
						var/obj/effects/tech/battery_overlay/o = new
						src.overlay_special = o
						src.overlays += src.overlay_special
						while(src)
							if(src.loc == null) return
							src.battery_power()
							sleep(100)
				Del()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
			Wind_Turbine
				icon = 'turbine_wind.dmi'
				icon_state = "turbine"
				info_name = "Wind_Turbine"
				pixel_y = 10
				density_factor = 1
				bounds = "7,11 to 27,19"
				value = 2000
				hashadow = 0
				generator = 1;
				generates = 50;
				scale_x = 32;
				scale_y = 64;
				desc = "This technological structure is very important for the production of clean power. It produces energy at a modest rate, depending on the weather, which is then sent to the nearest available battery. Like many technlogical structures, it must remain over a power line to send power to a battery."
				tech_tree = "Physics"
				tech_subtech = "Wind Generators"
				/*
				Move()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
				*/
				Del()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
				New()
					..()
					tag = name
					category = list("Power Generation")
					var/image/sel = image('fx_large.dmi',src,"select item",5)
					src.img_select = sel
					spawn(1)
						if(src.loc)
							var/obj/effects/tech/blade/o = new
							src.overlays += o
						spawn(10)
							for(var/turf/trf in src.locs)
								for(var/obj/items/tech/Power_Line/p in trf)
									p.reconnect_power()
						var/obj/shad = new
						shad.icon = src.icon
						shad.icon_state = "shadow"
						shad.alpha = 100
						shad.pixel_y = -3
						shad.loc = src.loc
						shad.bolted = 2
						src.shadow = shad
						while(src)
							if(src.loc == null) return
							for(var/obj/items/tech/Power_Line/p in range(1,src))
								if(bounds_dist(src, p) < 3)
									if(!src.grabbed_by) if(!src.tk)
										for(var/obj/b in p.batteries)
											if(b.capacity < b.capacity_max)
												b.capacity += 1
												if(b.capacity > b.capacity_max)
													b.capacity = b.capacity_max
												break
							sleep(10)
			Nuclear_Power_Plant
				info_name = "Nuclear_Power_Plant"
				icon = 'nuclear_plant.dmi'
				icon_state = "core"
				pixel_x = -110
				pixel_y = -32
				density_factor = 1
				bolted = 2
				bounds = "-15,24 to 48,69"
				generator = 1;
				generates = 3000;
				hashadow = 0;
				value = 20000
				scale_x = 80;
				scale_y = 32;
				radius = 4;
				desc = "This technological structure is very important for the production of clean power. At day, it will produce energy at a modest rate and send it into the nearest available battery. Like many technlogical structures, it must remain over a power line to send power to a battery."
				tech_tree = "Engineering"
				Del()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
				New()
					..()
					//src.icon = null
					src.invisibility = 100
					src.pixel_y = 16
					spawn(10)
						if(src)
							//sleep(0.1)
							var/obj/base = new
							base.icon = 'nuclear_plant.dmi'
							base.icon_state = "base"
							base.layer = 2.1 //src.layer - 0.1
							base.loc = src.loc
							base.pixel_x = src.pixel_x
							base.pixel_y = 16
							base.bolted = 2
							animate(base, pixel_y = -32 ,time = 2, easing = BOUNCE_EASING)
							sleep(2.1)
							//src.icon = 'nuclear_plant.dmi'
							src.invisibility = 0
							animate(src, pixel_y = -32 ,time = 2, easing = BOUNCE_EASING)
							src.layer = MOB_LAYER + src.laymod - ((src.y+1) + src.step_y / 32) / world.maxy
							sleep(2.1)
							//src.pixel_y = -32
							var/obj/coolant1 = new
							coolant1.icon = 'nuclear_plant.dmi'
							coolant1.icon_state = "coolant1"
							//coolant1.layer = src.layer + 0.2
							coolant1.loc = src.loc
							coolant1.pixel_x = src.pixel_x
							coolant1.pixel_y = 16
							coolant1.bolted = 2
							coolant1.layer = MOB_LAYER + src.laymod - ((src.y+2) + src.step_y / 32) / world.maxy
							animate(coolant1, pixel_y = -32 ,time = 2, easing = BOUNCE_EASING)
							sleep(2.1)
							var/obj/coolant2 = new
							coolant2.icon = 'nuclear_plant.dmi'
							coolant2.icon_state = "coolant2"
							//coolant2.layer = src.layer + 0.2
							coolant2.loc = src.loc
							coolant2.pixel_x = src.pixel_x
							coolant2.pixel_y = 16
							coolant2.bolted = 2
							coolant2.layer = MOB_LAYER + src.laymod - ((src.y+2) + src.step_y / 32) / world.maxy
							animate(coolant2, pixel_y = -32 ,time = 2, easing = BOUNCE_EASING)
							sleep(2.1)
							var/obj/fence_left_vert = new
							fence_left_vert.icon = 'nuclear_plant.dmi'
							fence_left_vert.icon_state = "left fence vert"
							fence_left_vert.layer = src.layer
							fence_left_vert.loc = src.loc
							fence_left_vert.pixel_x = src.pixel_x
							fence_left_vert.pixel_y = 16
							fence_left_vert.bounds = "-110,-32 to -106,150"
							fence_left_vert.density = 1
							fence_left_vert.bolted = 2
							fence_left_vert.density_factor = 2
							animate(fence_left_vert, pixel_y = -32 ,time = 2, easing = BOUNCE_EASING)
							sleep(2.1)
							var/obj/fence_right_vert = new
							fence_right_vert.icon = 'nuclear_plant.dmi'
							fence_right_vert.icon_state = "right fence vert"
							fence_right_vert.layer = src.layer
							fence_right_vert.loc = src.loc
							fence_right_vert.pixel_x = src.pixel_x
							fence_right_vert.pixel_y = 16
							fence_right_vert.bounds = "139,-32 to 143,150"
							fence_right_vert.density = 1
							fence_right_vert.bolted = 2
							fence_right_vert.density_factor = 2
							animate(fence_right_vert, pixel_y = -32 ,time = 2, easing = BOUNCE_EASING)
							sleep(2.1)
							var/obj/fence_top_left = new
							fence_top_left.icon = 'nuclear_plant.dmi'
							fence_top_left.icon_state = "tl"
							//fence_top_left.layer = src.layer - 0.01
							fence_top_left.loc = src.loc
							fence_top_left.pixel_x = src.pixel_x
							fence_top_left.pixel_y = 16
							fence_top_left.bounds = "-110,150 to 2,155"
							fence_top_left.density = 1
							fence_top_left.bolted = 2
							fence_top_left.density_factor = 2
							fence_top_left.layer = MOB_LAYER + src.laymod - ((src.y+5) + src.step_y / 32) / world.maxy
							animate(fence_top_left, pixel_y = -32 ,time = 2, easing = BOUNCE_EASING)
							sleep(2.1)
							var/obj/fence_top_right = new
							fence_top_right.icon = 'nuclear_plant.dmi'
							fence_top_right.icon_state = "tr"
							//fence_top_right.layer = src.layer - 0.01
							fence_top_right.loc = src.loc
							fence_top_right.pixel_x = src.pixel_x
							fence_top_right.pixel_y = 16
							fence_top_right.bounds = "31,150 to 142,155"
							fence_top_right.density = 1
							fence_top_right.bolted = 2
							fence_top_right.density_factor = 2
							fence_top_right.layer = MOB_LAYER + src.laymod - ((src.y+5) + src.step_y / 32) / world.maxy
							animate(fence_top_right, pixel_y = -32 ,time = 2, easing = BOUNCE_EASING)
							sleep(2.1)
							var/obj/fence_bottom_left = new
							fence_bottom_left.icon = 'nuclear_plant.dmi'
							fence_bottom_left.icon_state = "bl"
							//fence_bottom_left.layer = src.layer + 0.002
							fence_bottom_left.loc = src.loc
							fence_bottom_left.pixel_x = src.pixel_x
							fence_bottom_left.pixel_y = 16
							fence_bottom_left.bounds = "-110,-32 to 6,-26"
							fence_bottom_left.density = 1
							fence_bottom_left.bolted = 2
							fence_bottom_left.density_factor = 2
							fence_bottom_left.layer = MOB_LAYER + src.laymod - ((src.y-1) + src.step_y / 32) / world.maxy
							animate(fence_bottom_left, pixel_y = -32 ,time = 2, easing = BOUNCE_EASING)
							sleep(2.1)
							var/obj/fence_bottom_right = new
							fence_bottom_right.icon = 'nuclear_plant.dmi'
							fence_bottom_right.icon_state = "br"
							fence_bottom_right.loc = src.loc
							fence_bottom_right.pixel_x = src.pixel_x
							fence_bottom_right.pixel_y = 16
							fence_bottom_right.bounds = "27,-32 to 142,-26"
							fence_bottom_right.density = 1
							fence_bottom_right.bolted = 2
							fence_bottom_right.density_factor = 2
							fence_bottom_right.layer = MOB_LAYER + src.laymod - ((src.y-1) + src.step_y / 32) / world.maxy
							animate(fence_bottom_right, pixel_y = -32 ,time = 2, easing = BOUNCE_EASING)
			Hydroelectric_Generator
				info_name = "Hydroelectric_Generator"
				icon = 'hydro.dmi'
				pixel_x = -104
				pixel_y = -16
				density_factor = 1
				bolted = 2
				bounds = "-72,-14 to 98,6"
				generator = 1;
				generates = 10000;
				hashadow = 0;
				value = 20000
				scale_x = 80;
				scale_y = 32;
				radius = 4;
				desc = "This technological structure is very important for the production of clean power. At day, it will produce energy at a modest rate and send it into the nearest available battery. Like many technlogical structures, it must remain over a power line to send power to a battery."
				tech_tree = "Engineering"
				Del()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
				New()
					..()
					tag = name
					category = list("Power Generation")
					var/image/sel = image('fx_large.dmi',src,"select item",5)
					src.img_select = sel
					src.desc_extra = "Power generated: [src.generates] \n\nGeneration conditions: None \n\nGenerates heat"
					spawn(10)
						if(src.loc != null)
							for(var/turf/trf in src.locs)
								for(var/obj/items/tech/Power_Line/p in trf)
									p.reconnect_power()
			Fusion_Generator
				info_name = "Fusion_Generator"
				icon = 'fusion.dmi'
				pixel_x = -32
				density_factor = 1
				//bolted = 2
				bounds = "-21,1 to 54,64"
				generator = 1;
				generates = 100000000000;
				hashadow = 0;
				value = 20000
				scale_x = 80;
				scale_y = 32;
				radius = 4;
				desc = "This technological structure is very important for the production of clean power. At day, it will produce energy at a modest rate and send it into the nearest available battery. Like many technlogical structures, it must remain over a power line to send power to a battery."
				tech_tree = "Engineering"
				Del()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
				New()
					..()
					tag = name
					category = list("Power Generation")
					var/image/sel = image('fx_large.dmi',src,"select item",5)
					src.img_select = sel
					src.desc_extra = "Power generated: [src.generates] \n\nGeneration conditions: None \n\nGenerates heat"
					spawn(10)
						if(src.loc != null)
							for(var/turf/trf in src.locs)
								for(var/obj/items/tech/Power_Line/p in trf)
									p.reconnect_power()
			Geothermal_Generator
				info_name = "Geothermal_Generator"
				icon = 'Geothermal.dmi'
				icon_state = "main"
				pixel_x = -140
				pixel_y = -32
				density_factor = 1
				bolted = 2
				bounds = "-105,-30 to 140,50"
				generator = 1;
				generates = 1000;
				hashadow = 0;
				value = 20000
				scale_x = 80;
				scale_y = 32;
				radius = 4;
				desc = "A Geothermal Generator is a marvel of modern engineering that harnesses the power of a planets internal heat to produce electricity. The generator utilizes a process called binary cycle geothermal power, where a heat exchanger transfers thermal energy from hot geothermal fluids to a secondary fluid that vaporizes and drives a turbine. This ingenious system allows the generator to operate day and night, providing a constant stream of clean and sustainable energy. With its ability to convert natural geothermal energy into electrical power, the Geothermal Generator is the future of sustainable energy and a testament to human ingenuity."
				tech_tree = "Physics"
				tech_subtech = "Geothermal Generators"
				Del()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
				/*
				Move()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
				*/
				New()
					..()
					tag = name
					category = list("Power Generation")
					var/image/sel = image('fx_large.dmi',src,"select item",5)
					src.img_select = sel
					src.desc_extra = "Power generated: [src.generates] \n\nGeneration conditions: None \n\nGenerates heat"

					var/obj/light = new
					light.icon = src.icon
					light.icon_state = "lights"
					light.filters += filter(type="drop_shadow", x=0, y=0,size=5, offset=2, color=rgb(200,0,0))
					light.layer = src.layer+5;
					light.bolted = 2
					src.vis_contents += light
					spawn(10)
						if(src.loc != null)
							var/obj/i = new
							i.icon = src.icon
							i.icon_state = "lights"
							i.layer = src.layer+10;
							i.bolted = 2
							i.alpha = 155
							animate(i, transform = matrix()*1.1,alpha = 0, time = 10, loop = -1)
							animate(transform = matrix()*1,alpha = 155,time = 0)
							src.vis_contents += i
							for(var/turf/trf in src.locs)
								for(var/obj/items/tech/Power_Line/p in trf)
									p.reconnect_power()
									break
						src.heat_field()
			Solar_Generator
				info_name = "Solar_Generator"
				icon = 'solar_power.dmi'
				icon_state = "base"
				pixel_x = -32
				density_factor = 1
				bounds = "-12,1 to 44,20"
				generator = 1;
				generates = 100;
				value = 2000
				desc = "This technological structure is very important for the production of clean power. At day, it will produce energy at a modest rate and send it into the nearest available battery. Like many technlogical structures, it must remain over a power line to send power to a battery."
				tech_tree = "Physics"
				tech_subtech = "Solar Generators"
				Del()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
				/*
				Move()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
				*/
				New()
					..()
					tag = name
					category = list("Power Generation")
					var/image/sel = image('fx_large.dmi',src,"select item",5)
					src.img_select = sel
					src.item_info = "<p>Generator</p> <p>Power Generated: [src.generates]"
					src.desc_extra = "Power generated: [src.generates] \n\nGeneration conditions: Daylight"
					spawn(10)
						if(src.loc != null)
							//src.power_pulse(src.x,src.y)
							for(var/turf/trf in src.locs)
								for(var/obj/items/tech/Power_Line/p in trf)
									p.reconnect_power()
			Robot_Factory
				info_name = "Robot_Factory"
				icon = 'tech_robot_factory.dmi'
				pixel_x = -32
				value = 2000
				density_factor = 1
				icon_state = "open"
				New()
					..()
					tag = name
					var/image/sel = image('fx_large.dmi',src,"select item",1000)
					src.img_select = sel
			Recycler
				info_name = "Recycler"
				icon = 'tech_recycler.dmi'
				value = 2000
				density_factor = 1
				pixel_x = -32
				value = 2000
				bounds = "-21,1 to 54,64"
				icon_state = "open"
				desc = "The recycler can be used to break down and destroy anything into raw resources, including other tech items, rocks, plants, even living beings.. To do so, drop anything over the top of it whilst the machine is powered."
				tech_tree = "Engineering"
				New()
					..()
					tag = name
					category = list("Recycling")
					var/image/sel = image('fx_large.dmi',src,"select item",1000)
					src.img_select = sel
					spawn(1)
						if(src.loc == null) return
						while(src)
							if(src.loc == null) return
							src.on = 0
							var/obj/stay_on = null
							for(var/obj/items/tech/Power_Line/p in range(1,src))
								if(bounds_dist(src, p) < 3)
									if(!src.grabbed_by) if(!src.tk)
										for(var/obj/x in p.batteries)
											if(x.capacity > 0)
												stay_on = x
												break
							if(stay_on)
								stay_on.capacity -= 1
								src.on = 1
							sleep(10)
			Black_Hole_Generator_Underlay
				info_name = "Black_Hole_Generator_Underlay"
				icon = 'black_hole_generator_under.dmi'
				icon_state = "underlay"
				density_factor = 0
				bolted = 1
				bounds = "-21,1 to 54,64"
			Black_Hole_Generator
				info_name = "Black_Hole_Generator"
				icon = 'black_hole_generator.dmi'
				icon_state = "off"
				pixel_x = -80
				pixel_y = -80
				value = 20000
				density_factor = 1
				appearance_flags = TILE_BOUND
				//plane = 5
				on = 0
				bolted = 1
				generator = 1;
				generates = 0;
				hashadow = 0
				bounds = "-40,-20 to 73,35"
				desc = "The drill, once connected to a power network, will begin to extract resources from deep underground. These resources are then disgarded near for collection. The drill ceases to function if too many digarded resources are near. Like many technlogical structures, it must remain over a power line to function."
				tech_tree = "Engineering"
				proc
					Activate()
						src.icon_state = "overlay"
						src.plane = 5
						src.density_factor = 0
						src.generates = 1000;
						src.underlays += /obj/items/tech/Black_Hole_Generator_Underlay

						animate(src,pixel_y = -78, time = 10, loop = -1)
						animate(pixel_y = -82,time = 10)

						var/obj/o = new
						o.loc = src.loc
						o.icon = 'blackhole.dmi'
						o.plane = 1
						o.bolted = 2
						o.pixel_x = -48;
						o.pixel_y = -48;
						o.bounds = "-48,-48 to 80,80"
						o.transform = matrix()*0.1
						animate(o, transform = matrix()*1, time = 10)
						src.loc.explosion(6)
						sleep(10)
						var/obj/items/environmental/blackhole/b = new
						b.density_factor = 1
						b.loc = src.loc
						src.shockwave_huge()
						del(o)
				Click()
					if(src.icon_state != "overlay") src.Activate()
				/*
				Move()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
				*/
				Del()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
				New()
					..()
					tag = name
					category = list("Resource Extraction")
					var/image/sel = image('fx_large.dmi',src,"select item",1000)
					src.img_select = sel
					src.desc_extra = "Power usage: [src.uses] \n\nProcess: Passive \n\nCan be toggled on or off"
					spawn(1)
						if(src.loc == null) return
						//mouse_opacity = 0;
						for(var/turf/trf in src.locs)
							for(var/obj/items/tech/Power_Line/p in trf)
								p.reconnect_power()
			Automated_Drill_Tower
				info_name = "Drilling_Machine"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				icon = 'tech_drill.dmi'
				icon_state = "off"
				pixel_x = -32
				value = 2000
				density_factor = 1
				can_activate = 1
				p_x = -32
				on = 1
				on_always = 1
				uses = 50
				stacks = -1
				bounds = "-21,1 to 54,64"
				desc = "The drill, once connected to a power network, will begin to extract resources from deep underground. These resources are then stored inside the machine for collection. Like many technlogical structures, it must remain over a power line to function."
				tech_tree = "Engineering"
				tech_subtech = "Automated Drill Towers"
				tech_upgradable = 1
				tech_parent_path = /obj/items/tech/sub_tech/Engineering/Automated_Drill_Towers
				act = /obj/items/tech/Automated_Drill_Tower/proc/activate
				has_subtech = 0
				var/lvl = 1
				var/last_clicked = 0
				proc
					activate(var/obj/items/tech/Automated_Drill_Tower/d,var/area/a)
						spawn(0)
							if(d && a)
								var/powered = 0
								if(a.excess_grid >= 0 || a.stored_grid > 0) powered = 1
								if(powered == 0)
									if(d.last_clicked > 0)
										d.vis_contents -= industrial_smoke
										d.resources += (world.timeofday-d.last_clicked)*(1+d.tech_lvl)
										d.last_clicked = -1 //-1 means its not powered
								else
									d.vis_contents += industrial_smoke
									d.last_clicked = world.timeofday
				Move()
					if(src)
						if(src.grabbed_by == null && src.tk == 0)
							var/powered = 0;
							for(var/turf/trf in src.locs)
								for(var/obj/items/tech/Power_Line/p in trf)
									if(p.network)
										var/area/a = p.network
										if(a.excess_grid >= 0 || a.stored_grid > 0) powered = 1;
										break
							if(powered == 0)
								src.vis_contents -= industrial_smoke
							else
								src.vis_contents -= industrial_smoke
								src.vis_contents += industrial_smoke
						else
							src.vis_contents -= industrial_smoke
					..()
				Click(location,control,params)
					..()
					/*
					Idea here is to track the time between clicks.
					Issue atm is that when the drill is turned off, it needs to account for its down time. It would store the current seconds*tech_lvl in last_clicked and reset it to 0,
					before storing it inside resources var.
					Resources would be something like seconds*tech_lvl
					*/
					//world << "Time is [world.timeofday]. Last clicked at [src.last_clicked]. Seconds passed [world.timeofday-src.last_clicked]"
					if(src.last_clicked >= 0)
						if((world.timeofday-src.last_clicked)*(1+src.tech_lvl) > 0)
							usr.resources += (world.timeofday-src.last_clicked)*(1+src.tech_lvl)
							usr.update_rsc()
						src.last_clicked = world.timeofday
					if(src.grabbed_by) return
					if(src.loc)
						winset(usr,"main.map_main","focus=true")
						params = params2list(params)
						if(params["left"])
							if(usr.left_click_function == "upgrade drill")
								if(usr.hud_tech) usr.client.screen += usr.hud_tech
								if(src.loc)
									if(src in range(2,usr))
										usr.left_click_function = null
										for(var/obj/items/tech/sub_tech/Engineering/Automated_Drill_Towers/SE in global.tech)//usr.technology_researched)
											if(usr.tech_unlocked[SE.list_pos] == SE.type)
												if(usr.tech_lvls[SE.list_pos] > 0)
													src.level = usr.tech_lvls[SE.list_pos]
													usr << output("Upgraded Drill to level [src.level].", "chat.system")
													usr.set_alert("Upgraded drill",SE.icon,SE.icon_state)
													usr.create_chat_entry("alerts","Upgraded drill.")
													break
												else
													usr << output("Need at least one level in Automated Drill Towers.", "chat.system")
													usr.set_alert("Need Automated Drill Towers technology",'alert.dmi',"alert")
													usr.create_chat_entry("alerts","Need Automated Drill Towers technology.")
													return
										return
									else
										usr << output("[src] is out of range for upgrading.", "chat.system")
										usr.set_alert("Out of range",'alert.dmi',"alert")
										usr.create_chat_entry("alerts","Out of range.")
										return
								else
									usr << output("[src] is out of range for upgrading.", "chat.system")
									usr.set_alert("Out of range",'alert.dmi',"alert")
									usr.create_chat_entry("alerts","Out of range.")
									return

				New()
					..()
					tag = name
					category = list("Resource Extraction")
					var/image/sel = image('fx_large.dmi',src,"select item",1000)
					src.img_select = sel
					src.desc_extra = "Power usage: [src.uses] \n\nProcess: Passive \n\nCan be toggled on or off"
					if(src.loc == null) return
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
							break
			Regeneration_Tank
				info_name = "Regeneration_Tank"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				//appearance_flags = KEEP_TOGETHER
				icon = 'New regen tank.dmi'
				icon_state = "off"
				value = 3000
				pixel_x = -31
				pixel_y = -14
				uses = 50;
				on = 1
				on_always = 1
				bounds = "-11,5 to 46,53"
				desc = "The regeneration tank is a state-of-the-art medical technology designed to rapidly heal the body and mind. By entering a meditative state inside the tank, you can activate its advanced healing capabilities, which vary depending on its level of technology. It requires a steady power source to operate, much like other technological structures."
				var/obj/glass
				var/obj/bubbles
				can_activate = 1
				tech_tree = "Genetics"
				tech_subtech = "Regenerators"
				tech_parent_path = /obj/items/tech/sub_tech/Genetics/Regenerators
				act = /obj/items/tech/Regeneration_Tank/proc/activate
				tech_upgradable = 1
				proc
					activate(var/obj/items/tech/Regeneration_Tank/d,var/area/a)
						spawn(0)
							if(d && a)
								var/stacked = 0
								for(var/obj/items/tech/Regeneration_Tank/rm in range(1,d))
									if(rm != d)
										if(bounds_dist(d, rm) <= 0)
											stacked = 1
											break
								if(stacked == 0)
									var/powered = 0
									if(a.excess_grid >= 0 || a.stored_grid > 0) powered = 1
									if(powered == 0)
										d.icon_state = "off"
										d.layer = initial(src.layer)
										d.overlays -= d.bubbles
									else
										d.icon_state = "on"
										d.overlays -= d.bubbles
										d.overlays += d.bubbles
				New()
					..()
					tag = name
					category = list("Healing")
					src.glass = new /obj/effects/tech/regen_overlay
					src.bubbles = new /obj/effects/tech/bubbles
					src.overlays += src.glass
					var/image/sel = image('fx_large.dmi',src,"select item",1000)
					src.img_select = sel
					src.desc_extra = "Power usage: [src.uses] \n\nProcess: Activated \n\nCan be toggled on or off"
					spawn(10)
						if(src.loc == null) return
						for(var/turf/trf in src.locs)
							for(var/obj/items/tech/Power_Line/p in trf)
								p.reconnect_power()
								break
						//var/stay_on = 0;
						while(src)
							if(src.loc == null) return

							if(src.icon_state == "on")
								for(var/mob/m in range(1,src))
									if(bounds_dist(src, m) <= 8 && m.icon_state == "meditate")
										if(m.skill_flight == null || m.skill_flight && m.skill_flight.active == 0)
											if(m.skill_levitation == null || m.skill_levitation && m.skill_levitation.active == 0)
												m.set_shadow()
												m.percent_health += 1+(src.level/4)
												src.overlays -= src.glass
												src.glass.layer = m.layer+1
												src.overlays += src.glass
												if(m.stunned || m.koed || m.meditating)
													m.loc = src.loc
													m.step_x = src.step_x//+(src.pixel_x/2)
													m.step_y = src.step_y+6
													m.layer = src.layer+0.1
													m.icon_state = "meditate"
													break
												else
													src.layer = initial(src.layer)

							var/turf/t = src.loc
							if(t.tmp_dmg >= 2)
								src.flash_red()
								src.shake()
								src.hp -= 5
								if(src.hp <= 0) src.destroy()

							sleep(10)
				Del()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
							break
					..()
				Move()
					src.icon_state = "off"
					src.overlays -= src.bubbles
					..()
				/*
				Click(location,control,params)
					if(src.grabbed_by) return
					if(src.loc)
						winset(usr,"main.map_main","focus=true")
						params = params2list(params)
						if(params["left"])
							if(src in range(1,usr))
								if(src.on == 0)
									var/power_on = 0
									for(var/turf/trf in src.locs)
										if(power_grid[trf.x][trf.y][trf.z] == 1)
											if(excess_grid[trf.x][trf.y][trf.z] >= 0 || stored_grid[trf.x][trf.y][trf.z] > 0) power_on = 1;
									if(power_on)
										src.on = 1
										src.icon_state = "on"
										src.overlays += src.bubbles
										for(var/turf/trf in src.locs)
											for(var/obj/items/tech/Power_Line/p in trf)
												p.reconnect_power()
								else
									src.on = 0
									src.icon_state = "off"
									src.layer = initial(src.layer)
									src.overlays -= src.bubbles
									for(var/turf/trf in src.locs)
										for(var/obj/items/tech/Power_Line/p in trf)
											p.reconnect_power()
							return
					..()
				*/
			Microwave_Generator
				info_name = "Microwave_Generator"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				icon = 'glass_orb.dmi'
				icon_state = "whole"
				value = 1000
				pixel_x = -31
				density_factor = 1
				radius = 1;
				hashadow = 0
				setting = 0
				uses = 100 //How much power needed to run this tech
				bounds = "-25,1 to 60,75"
				desc = "A Microwave Generator is a powerful and hazardous machine that emits intense electromagnetic radiation, which is precisely tuned to stimulate and train your character's energy-based abilities. The Generator works by subjecting your character to a controlled stream of high-frequency waves, which are able to penetrate deeply into their physical and spiritual body, enhancing their ability to harness and control energy. As your character undergoes this rigorous training, their resistance to energy-based attacks increases, and their own energy-based attacks become more potent and destructive. But be warned, the intense radiation emitted by the Microwave Generator can be harmful to those unprepared for its power"
				can_activate = 1
				tech_tree = "Physics"
				tech_subtech = "Thermodynamics"
				tech_upgradable = 1
				act = /obj/items/tech/Microwave_Generator/proc/turn_off
				var/obj/back
				var/obj/orb
				var/obj/elec
				var/obj/pulse
				var/obj/outline
				var/tmp/list/trfs = list()
				proc
					turn_off(var/obj/items/tech/Microwave_Generator/d)
						d.icon_state = "whole"
						d.setting = 0
						d.on = 0;
						d.vis_contents -= d.back
						d.vis_contents -= d.orb
						d.vis_contents -= d.elec
						d.vis_contents -= d.pulse
						d.vis_contents -= d.outline
						for(var/turf/t in d.trfs)
							t.microwaves = initial(t.og_microwaves)
							for(var/mob/m in t)
								m.microwaves = t.microwaves
							d.trfs -= t
				New()
					..()
					spawn(1)
						if(src.loc == null)
							return
						var/obj/back = new
						back.icon = src.icon
						back.icon_state = "back"
						back.layer = 3.2
						//g.vis_contents += back
						src.back = back

						var/obj/elec = new
						elec.icon = 'orb_elec.dmi'
						elec.icon_state = "elec"
						elec.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(0,160,230))
						elec.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
						elec.layer = 10
						elec.pixel_x = -16
						elec.pixel_y = -4
						elec.appearance_flags = KEEP_APART
						src.elec = elec
						//g.vis_contents += elec

						var/obj/o = new
						o.icon = src.icon
						o.icon_state = "overlay"
						o.layer = src.layer+1
						o.appearance_flags = KEEP_TOGETHER
						src.orb = o
						//g.vis_contents += o

						var/obj/outline = new
						outline.icon = src.icon
						outline.icon_state = "outline"
						outline.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(0,160,230))
						animate(outline.filters[1], size = 2,offset = 2, time = 15, loop = -1)
						animate(size = 0,offset = 0, time = 15, loop = -1)
						outline.layer = 9
						src.outline = outline
						//g.vis_contents += outline

						var/obj/pulse = new
						pulse.icon = 'orb_pulsate.dmi'
						pulse.pixel_x = -41
						pulse.appearance_flags = PIXEL_SCALE
						pulse.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=1, color=rgb(0,160,230))
						//g.vis_contents += pulse
						src.pulse = pulse
						pulse.transform *= 0.8
						animate(pulse, transform = matrix()*2, alpha = 0, time = 20,loop = -1)//,flags = ANIMATION_PARALLEL)
						animate(transform = matrix()*0.8, alpha = 255, time = 0)

						tag = name
						category = list("Artifical Training")
						var/image/sel = image('fx_large.dmi',src,"select item",1000)
						src.img_select = sel
						src.desc_extra = "Power usage: [src.uses] \n\nProcess: Activated \n\nCan be toggled on or off"
						//var/stay_on = 0;
						while(src)
							if(src.loc == null)
								return
							if(src.icon_state == "front")
								for(var/obj/items/tech/Regeneration_Tank/tnk in range(2,src))
									tnk.flash_red()
									tnk.shake()
									tnk.hp -= 5
									if(tnk.hp <= 0) tnk.destroy()
							sleep(10)
				Del()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
				Move()
					if(src.icon_state == "front")
						var/stay_on = 0;
						for(var/turf/trf in src.locs)
							for(var/obj/items/tech/Power_Line/p in trf)
								if(p.network)
									var/area/a = p.network
									if(a.excess_grid >= 0 || a.stored_grid > 0) stay_on = 1;
									break
						if(src.grabbed_by || src.tk) stay_on = 0;
						if(stay_on == 0)
							src.icon_state = "whole"
							src.setting = 0
							src.on = 0;
							src.vis_contents -= src.back
							src.vis_contents -= src.orb
							src.vis_contents -= src.elec
							src.vis_contents -= src.pulse
							src.vis_contents -= src.outline
							for(var/turf/t in src.trfs)
								t.microwaves = initial(t.og_microwaves)
								for(var/mob/m in t)
									m.microwaves = t.microwaves
								src.trfs -= t
					..()
				Click(location,control,params)
					..()
					//usr << "test"
					if(src.grabbed_by) return
					if(src.loc)
						winset(usr,"main.map_main","focus=true")
						params = params2list(params)
						if(params["left"])
							if(src in range(2,usr))
								//world << "DEBUG - Clicked [src]"
								if(src.setting == 0)
									//world << "DEBUG - Setting = [src.setting]"
									var/power_on = 0
									for(var/turf/trf in src.locs)
										for(var/obj/items/tech/Power_Line/p in trf)
											if(p.network)
												var/area/a = p.network
												if(a.excess_grid >= 0 || a.stored_grid > 0) power_on = 1;
												break
									if(power_on == 1)
										for(var/obj/items/tech/Microwave_Generator/g in range(4,src))
											if(g != src)
												usr << "Unable to activate two microwave generators so near to one another."
												usr.set_alert("Too close to another generator",'alert.dmi',"alert")
												usr.create_chat_entry("alerts","Too close to another generator.")
												return
										//winset(usr,"numbers.label_numbers","text=\"Set microwave level of this machine.\"")
										//winset(usr,"numbers","pos=960,400")
										//winshow(usr,"numbers",1)
										usr.numbers_text = src
										//winset(usr,"numbers.input_number","focus=true")
										usr.hud_confirm_nums.confirm_text(1,"Set microwave level of this machine.",usr)
								else
									src.icon_state = "whole"
									src.setting = 0
									src.on = 0;
									src.vis_contents -= src.back
									src.vis_contents -= src.orb
									src.vis_contents -= src.elec
									src.vis_contents -= src.pulse
									src.vis_contents -= src.outline
									for(var/turf/t in src.trfs)
										t.microwaves = initial(t.og_microwaves)
										for(var/mob/m in t)
											m.microwaves = t.microwaves
										src.trfs -= t
									for(var/turf/trf in src.locs)
										for(var/obj/items/tech/Power_Line/p in trf)
											p.reconnect_power()
							return
			Gravity_Machine
				info_name = "Gravity_Machine"
				mouse_over_pointer = MOUSE_ACTIVE_POINTER
				icon = 'tech_gravity.dmi'
				icon_state = "off"
				value = 1000
				pixel_x = -31
				density_factor = 1
				radius = 2;
				setting = 0
				uses = 100 //How much power needed to run this tech
				bounds = "-5,1 to 38,17"
				desc = "This device is very advanced and complex, producing a field of graviy waves that pulsate out in rhythmic paces. By clicking it, you are able to set the desired level of gravity within the confines of its radius. Once inside the field, you will become much stronger and more endurant over time, depending on the gravity setting. Whilst active, the gravity will slowly harm you. Like many technlogical structures, it must remain over a power line to function."
				can_activate = 1
				tech_tree = "Physics"
				tech_subtech = "Gravitational Fields"
				tech_parent_path = /obj/items/tech/sub_tech/Physics/Gravitational_Fields
				act = /obj/items/tech/Gravity_Machine/proc/turn_off
				tech_upgradable = 1
				var/obj/field
				var/tmp/list/trfs = list()
				proc
					turn_off(var/obj/items/tech/Gravity_Machine/d)
						if(d)
							d.icon_state = "off"
							d.setting = 0
							d.on = 0;
							if(d.field) d.field.loc = null
							for(var/turf/t in d.trfs)
								t.grav = initial(t.og_grav)
								for(var/mob/m in t)
									m.grav = t.grav
								d.trfs -= t
					/*
					---TEMPLATE---
					activate(var/obj/items/tech/Gravity_Machine/d,var/area/a)
						spawn(0)
							if(d && a)
								var/powered = 0
								if(a.excess_grid >= 0 || a.stored_grid > 0) powered = 1
								if(powered == 0)
									//Not powered
									return
								else
									//Powered
									return
					*/
				New()
					..()
					tag = name
					category = list("Artifical Training")
					var/image/sel = image('fx_large.dmi',src,"select item",1000)
					src.img_select = sel
					src.desc_extra = "Power usage: [src.uses] \n\nProcess: Activated \n\nCan be toggled on or off"
					spawn(1)
						if(src.loc == null)
							if(src.field) src.field.loc = null
							return
						while(src)
							if(src.loc == null)
								if(src.field) src.field.loc = null
								return
							if(src.icon_state == "on")
								for(var/obj/items/tech/Regeneration_Tank/tnk in range(2,src))
									tnk.flash_red()
									tnk.shake()
									tnk.hp -= 5
									if(tnk.hp <= 0) tnk.destroy()
							sleep(10)
				Del()
					for(var/turf/trf in src.locs)
						for(var/obj/items/tech/Power_Line/p in trf)
							p.reconnect_power()
					..()
				Move()
					if(src.icon_state == "on")
						var/stay_on = 0;
						for(var/turf/trf in src.locs)
							for(var/obj/items/tech/Power_Line/p in trf)
								if(p.network)
									var/area/a = p.network
									if(a.excess_grid >= 0 || a.stored_grid > 0) stay_on = 1;
									break
						if(src.grabbed_by || src.tk) stay_on = 0;
						if(stay_on == 0)
							src.icon_state = "off"
							src.setting = 0
							src.on = 0;
							if(src.field) src.field.loc = null
							for(var/turf/t in src.trfs)
								t.grav = initial(t.og_grav)
								for(var/mob/m in t)
									m.grav = t.grav
								src.trfs -= t
					..()
				Click(location,control,params)
					..()
					//usr << "test"
					if(src.grabbed_by) return
					if(src.loc)
						winset(usr,"main.map_main","focus=true")
						params = params2list(params)
						if(params["left"])
							if(src in range(1,usr))
								if(src.setting == 0)
									var/power_on = 0
									for(var/turf/trf in src.locs)
										for(var/obj/items/tech/Power_Line/p in trf)
											if(p.network)
												var/area/a = p.network
												if(a.excess_grid >= 0 || a.stored_grid > 0) power_on = 1;
												break
									if(power_on == 1)
										for(var/obj/items/tech/Gravity_Machine/g in range(4,src))
											if(g != src)
												usr << "Unable to activate two gravity machines so near to one another."
												usr.set_alert("Too close to another Gravity Machine",'alert.dmi',"alert")
												usr.create_chat_entry("alerts","Too close to another Gravity Machine.")
												return
										usr.numbers_text = src
										usr.hud_confirm_nums.confirm_text(1,"Set the gravity level of this machine.",usr)
										winset(usr,"numbers.label_numbers","text=\"Set gravity level of this machine.\"")
										winset(usr,"numbers","pos=960,400")
										winshow(usr,"numbers",1)
										winset(usr,"numbers.input_number","focus=true")
										for(var/turf/trf in src.locs)
											for(var/obj/items/tech/Power_Line/p in trf)
												p.reconnect_power()
								else
									src.icon_state = "off"
									src.setting = 0
									src.on = 0;
									if(src.field) src.field.loc = null
									for(var/turf/t in src.trfs)
										t.grav = initial(t.og_grav)
										for(var/mob/m in t)
											m.grav = t.grav
										src.trfs -= t
							return
	horns
		layer = HAIR_LAYER
		density_factor = 0
		appearance_flags = KEEP_TOGETHER
		yuk
			yuk_horns1
				icon = 'horns_yukopian_01.dmi'
			yuk_horns2
				icon = 'horns_yukopian_02.dmi'
			yuk_horns3
				icon = 'horns_yukopian_03.dmi'
			yuk_horns4
				icon = 'horns_yukopian_04.dmi'
			yuk_none
	portrait
		var/tmp/mob/p_owner
		var/obj/portrait/port_eyes
		var/obj/portrait/port_iris
		var/state_og
		appearance_flags = KEEP_TOGETHER | PIXEL_SCALE | TILE_BOUND
		plane = 25
		body
			//appearance_flags = PIXEL_SCALE
			layer = 5
			screen_loc = "1:1,16:13"
		eyes
			//appearance_flags = PIXEL_SCALE
			layer = 5.1
			plane = 25
			New()
				spawn(120)
					if(src)
						if(src.state_og == null && src.icon) src.state_og = src.icon_state
						if(src.p_owner == null) return
						else if(src.p_owner.race == "Android" && src.p_owner.skin_pos == 1) return
						else if(src.p_owner.race == "Android" && src.p_owner.skin_pos == 2) return
						else if(src.p_owner.race == "Cerebroid") return
						else src.blink(src.p_owner)
			proc/blink(var/mob/m)
				var/obj/portrait/p
				if(isobj(src.loc)) p = src.loc
				if(src.state_og == null && src.icon) src.state_og = src.icon_state
				if(src.p_owner && p)
					var/proceed = 1
					if(m.skill_active_meditation && m.skill_active_meditation.active) proceed = 0
					if(m.skill_meditation && m.skill_meditation.active) proceed = 0
					if(proceed)
						src.icon_state = "[src.state_og] blink"
						if(p.port_iris) p.vis_contents -= p.port_iris
						if(src.p_owner.eyes)
							src.p_owner.vis_contents -= src.p_owner.eyes
						if(src.p_owner.eyes_white)
							src.p_owner.vis_contents -= src.p_owner.eyes_white
				else
					src.destroy()
					return
				sleep(1.5)
				if(src)
					if(src.p_owner && p)
						var/proceed = 1
						if(m.skill_active_meditation && m.skill_active_meditation.active) proceed = 0
						if(m.skill_meditation && m.skill_meditation.active) proceed = 0
						if(proceed)
							src.icon_state = "[src.state_og]"
							if(p.port_iris) p.vis_contents += p.port_iris
							if(src.p_owner.eyes_white)
								src.p_owner.vis_contents += src.p_owner.eyes_white
							if(src.p_owner.eyes)
								src.p_owner.vis_contents += src.p_owner.eyes
					else
						src.destroy()
						return
					spawn(rand(40,70))
						if(src) src.blink(m)
		portrait_part
			//appearance_flags = PIXEL_SCALE
			layer = 5.1
			plane = 25
		border
			icon = 'portrait_human_male.dmi'
			icon_state = "border"
			plane = 25
			layer = 5.2
			//appearance_flags = PIXEL_SCALE
		background
			icon = 'portrait_human_male.dmi'
			icon_state = "background"
			plane = 25
			layer = 4.9
			//appearance_flags = PIXEL_SCALE
		demon
			icon = 'portrait_demon_female.dmi'
			female
				eyes
					portrait_female_demon_eyes1
						icon_state = "eyes1"
		android
			male
				icon = 'portrait_android_male.dmi'
				eyes
					android_male_eyes1
						icon_state = "eyes1"
					android_male_eyes2
						icon_state = "eyes2"
			female
				icon = 'portrait_android_female.dmi'
				eyes
					android_female_eyes1
						icon_state = "eyes1"
					android_female_eyes2
						icon_state = "eyes2"
					android_female_eyes3
						icon_state = "eyes3"
		cerebroid
			icon = 'portrait_cerebroid.dmi'
			eyes
				portrait_cerebroid_eyes1
					icon_state = "eyes1"
		yukopian
			icon = 'portrait_yukopian.dmi'
			eyes
				portrait_yuk_eyes1
					icon_state = "eyes1"
			horns
				horns1_yuk
					icon_state = "horns1"
				horns2_yuk
					icon_state = "horns2"
				horns3_yuk
					icon_state = "horns3"
				horns4_yuk
					icon_state = "horns4"
		male
			icon = 'portrait_human_male.dmi'
			mouths
				portrait_mouth1_male
					icon_state = "mouth1"
				portrait_mouth2_male
					icon_state = "mouth2"
				portrait_mouth3_male
					icon_state = "mouth3"
				portrait_mouth4_male
					icon_state = "mouth4"
			eyes
				portrait_eyes1_male
					icon_state = "eyes1"
				portrait_eyes2_male
					icon_state = "eyes2"
			noses
				portrait_nose1_male
					icon_state = "nose1"
				portrait_nose2_male
					icon_state = "nose2"
			hairs
				portrait_Hair1_male
					icon_state = "hair1"
				portrait_Hair2_male
					icon_state = "hair2"
				portrait_Hair3_male
					icon_state = "hair3"
				portrait_Hair4_male
					icon_state = "hair4"
				portrait_Hair5_male
					icon_state = "hair5"
				portrait_Hair6_male
					icon_state = "hair6"
				portrait_Hair7_male
					icon_state = "hair7"
				portrait_Hair8_male
					icon_state = "hair8"
				portrait_Hair9_male
					icon_state = "hair9"
				portrait_Hair10_male
					icon_state = "hair10"
		female
			icon = 'portrait_human_female.dmi'
			mouths
				portrait_mouth1_female
					icon_state = "mouth1"
				portrait_mouth2_female
					icon_state = "mouth2"
				portrait_mouth3_female
					icon_state = "mouth3"
				portrait_mouth4_female
					icon_state = "mouth4"
				portrait_mouth5_female
					icon_state = "mouth5"
			eyes
				portrait_eyes1_female
					icon_state = "eyes1"
				portrait_eyes2_female
					icon_state = "eyes2"
				portrait_eyes3_female
					icon_state = "eyes3"
			noses
				portrait_nose1_female
					icon_state = "nose1"
				portrait_nose2_female
					icon_state = "nose2"
			hairs
				portrait_Hair1_female
					icon_state = "hair1"
				portrait_Hair2_female
					icon_state = "hair2"
				portrait_Hair3_female
					icon_state = "hair3"
				portrait_Hair4_female
					icon_state = "hair4"
				portrait_Hair5_female
					icon_state = "hair5"
				portrait_Hair6_female
					icon_state = "hair6"
				portrait_Hair7_female
					icon_state = "hair7"
				portrait_Hair8_female
					icon_state = "hair8"
	hairs
		layer = HAIR_LAYER
		density_factor = 0
		//appearance_flags = KEEP_TOGETHER
		female
			Hair1_female
				icon = 'hair_01_female.dmi'
				name = "Hair1"
			Hair2_female
				icon = 'hair_02_female.dmi'
				name = "Hair2"
			Hair3_female
				icon = 'hair_03_female.dmi'
				name = "Hair3"
			Hair4_female
				icon = 'hair_04_female.dmi'
				name = "Hair4"
			Hair5_female
				icon = 'hair_05_female.dmi'
				name = "Hair5"
			Hair6_female
				icon = 'hair_06_female.dmi'
				name = "Hair6"
			Hair7_female
				icon = 'hair_07_female.dmi'
				name = "Hair7"
			Hair8_female
				icon = 'hair_08_female.dmi'
				name = "Hair8"
		male
			Hair1
				icon = 'hair_01_male.dmi'
			Hair2
				icon = 'hair_02_male.dmi'
			Hair3
				icon = 'hair_03_male.dmi'
			Hair4
				icon = 'hair_04_male.dmi'
			Hair5
				icon = 'hair_05_male.dmi'
			Hair6
				icon = 'hair_06_male.dmi'
			Hair7
				icon = 'hair_07_male.dmi'
			Hair8
				icon = 'hair_08_male.dmi'
			Hair9
				icon = 'hair_09_male.dmi'
			Hair10
				icon = 'hair_10_male.dmi'
			None