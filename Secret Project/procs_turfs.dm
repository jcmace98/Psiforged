turf
	proc
		Autotile_World() //Supposed to be the fastest auto-tiler on byond
			for(var/turf/t in world)
				if(!t.autotile){continue}
				t.icon_state = "[initial(t.icon_state)] [\
					(get_step(t,NORTH)?.type == t.type ? 1 : 0) + \
					(get_step(t,SOUTH)?.type == t.type ? 2 : 0) + \
					(get_step(t,EAST)?.type == t.type ? 4 : 0) + \
					(get_step(t,WEST)?.type == t.type ? 8 : 0) + \
					(get_step(t,NORTHEAST)?.type == t.type ? 16 : 0) + \
					(get_step(t,NORTHWEST)?.type == t.type ? 32 : 0) + \
					(get_step(t,SOUTHEAST)?.type == t.type ? 64 : 0) + \
					(get_step(t,SOUTHWEST)?.type == t.type ? 128 : 0)]"
		update_worldmap_buildings(var/icon/I)
			if(istype(src,/turf/buildables/roofs/))
				I.DrawBox(rgb(63,63,63),src.x,src.y,src.x,src.y)
			else if(istype(src,/turf/buildables/walls/))
				I.DrawBox(rgb(127,127,127),src.x,src.y,src.x,src.y)
			else if(istype(src,/turf/buildables/floors/))
				I.DrawBox(rgb(191,191,191),src.x,src.y,src.x,src.y)
		create_worldmap_building()
			return
			if(maps_created)
				var/obj/hud/map/map_large/map_obj = maps[src.z]
				var/obj/map_o = map_obj.build_overlay
				var/icon/I_overlay = new(map_o.icon)
				map_obj.overlays -= map_o
				if(istype(src,/turf/buildables/roofs/))
					I_overlay.DrawBox(rgb(63,63,63),src.x,src.y,src.x,src.y)
				else if(istype(src,/turf/buildables/walls/))
					I_overlay.DrawBox(rgb(127,127,127),src.x,src.y,src.x,src.y)
				else if(istype(src,/turf/buildables/floors/))
					I_overlay.DrawBox(rgb(191,191,191),src.x,src.y,src.x,src.y)
				else if(istype(src,/turf/grass))
					var/icon/I = new(map_obj.icon)
					I.DrawBox(rgb(10,139,53),src.x,src.y,src.x,src.y)
					I_overlay.DrawBox(null,src.x,src.y,src.x,src.y)
					map_obj.icon = I
				else if(istype(src,/turf/dirts/))
					var/icon/I = new(map_obj.icon)
					I.DrawBox(rgb(153,102,51),src.x,src.y,src.x,src.y)
					I_overlay.DrawBox(null,src.x,src.y,src.x,src.y)
					map_obj.icon = I
				else if(istype(src,/turf/sands/))
					var/icon/I = new(map_obj.icon)
					I.DrawBox(rgb(239,199,79),src.x,src.y,src.x,src.y)
					I_overlay.DrawBox(null,src.x,src.y,src.x,src.y)
					map_obj.icon = I
				else if(istype(src,/turf/snows/))
					var/icon/I = new(map_obj.icon)
					I.DrawBox(rgb(234,234,234),src.x,src.y,src.x,src.y)
					I_overlay.DrawBox(null,src.x,src.y,src.x,src.y)
					map_obj.icon = I
				else if(istype(src,/turf/ice))
					var/icon/I = new(map_obj.icon)
					I.DrawBox(rgb(153,204,255),src.x,src.y,src.x,src.y)
					I_overlay.DrawBox(null,src.x,src.y,src.x,src.y)
					map_obj.icon = I
				map_o.icon = I_overlay
				map_obj.overlays += map_o
		remove_worldmap_building()
			if(maps_created)
				if(istype(src,/turf/buildables/))
					var/obj/hud/map/map_large/map_obj = maps[src.z]
					var/obj/map_o = map_obj.build_overlay
					if(map_o)
						map_obj.overlays -= map_o
						var/icon/I = new(map_o.icon)
						I.DrawBox(null,src.x,src.y,src.x,src.y)
						map_o.icon = I
						map_obj.overlays += map_o
		storm_psionic()
			var/s = 100
			while(s)
				s -= 1
				for(var/turf/t in range(6,src))
					if(prob(2))
						var/obj/effects/lightning_bolt/b = new
						b.loc = t
				sleep(10)
		furrow_remove()
			spawn(1000)
				src.overlays = null
				src.furrowed = 0
		set_area_water()
			set background = 1
			new /area/water(src)
			//var/area/water=new(src)
		set_destroyed()
			src.vis_contents = null
			if(src.damage)
				src.damage.destroy()
				src.damage = null
			if(src.z == 3 || src.z == 6 || src.z == 7 || src.z == 8) //if(istype(src,/turf/stone_roof))
				new /turf/stone_floor (src)
				if(src.z == 3)
					if(prob(0.5))
						var/obj/items/misc/resource_cache/rsc = new
						rsc.loc = src
					else if(prob(0.1))
						var/obj/items/tech/Mechanical_Upgrade_Kit/muk = new
						muk.loc = src
				else if(src.z == 6)
					if(prob(0.5))
						var/obj/items/misc/resource_cache/rsc = new
						rsc.preset = 1
						rsc.icon_state = "resource cache3"
						rsc.loc = src
					else if(prob(0.5))
						var/obj/items/consumables/spirit_stone/st = new
						st.loc = src
			else
				src.icon = 'terrain.dmi'
				src.icon_state = "dirt5"
				src.density_factor = 0
				src.opacity = 0
				src.density = 0
				src.layer = 2
			if(turfs[1][src.z].Find(src) == 0) turfs[1][src.z] += src
		set_damage_glow()
			if(src.damaged) return
			else
				src.damaged = 1
				//Add a melting/warping effect to the turf being attacked by an energy attack
				if(length(src.filters) <= 0)
					var/start = src.filters.len
					var/i,f
					for(i=1, i<=WAVE_COUNT, ++i)
						src.filters += filter(type="wave", x=20, y=20, size=1, offset=1)
					for(i=1, i<=WAVE_COUNT, ++i)
						f = src.filters[start+i]
						animate(f, offset=f:offset, time=0, loop=-1, flags=ANIMATION_PARALLEL)
						animate(offset=f:offset-1, time=33)
				spawn(1)
					if(src.glow)
						while(src.red > 0)
							src.glow.icon -= rgb(1,0,0)
							if(prob(50)) src.glow.alpha -= 1
							src.red -= 1
							sleep(1)
						src.red = 0
						src.damaged = 0
						src.filters = null
					if(src.glow)
						src.glow.destroy()
						src.glow = null
					//world << "DEBUG - called destroy glow"