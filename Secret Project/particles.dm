particles/soul_stream
	width = 320
	height = 1280
	count = 8000    //particles num
	spawning = 64    // new particles per client tick
	bound1 = list(-20, -48, -1000)
	bound2 = list(20, 1280, 1000)   // end particles at Y=300
	lifespan = 1200  // last num client ticks max
	//fade = 100       // fade out over the last num ticks if still on screen
	fadein = 10
	//icon = 'fx_soul.dmi'
	// spawn within a certain x,y,z space
	//position = generator("sphere", -24, 24)
	//position = generator("box", 1, 3,LINEAR_RAND)
	gravity = list(0, 1) //Vector, so the first 0 is left/right and the next 0 is up/down
	velocity = generator("sphere", 0, 5)
	friction = 0
	drift = generator("sphere", -0.2, 0.2)
	color = "white"
	//transform = list(-2,-2,-2,-2, 2,2,2,2, 2,2,2,2, 1,1,1,1)
particles/afterlife_energy
    width = 1080 //Width of the particle "image" on screen. Was 1920/2, but 1080 seems to fit the screen better
    height = 600 //Height of the particle "image" on screen. Was 1080/2, but 600 seems to fit the screen better.
    count = 4000    // 4000 particles
    spawning = 600    // 200 new particles per client tick.
    bound1 = list(-1080, -600, -1000) //Max Particle display area before getting cut off
    bound2 = list(1080, 600, 1000) //Max Particle display area before getting cut off
    lifespan = 1200  // last 1200 client ticks max
    fade = 100       // fade out over the last 100 ticks if still on screen
    // spawn within a certain x,y,z space
    position = generator("box", list(-600,-350,0), list(600,-350,50))
    gravity = list(0, 100)//list(0, 0.33)
    friction = 0.4//friction = 0.4  // shed 20% of velocity and drift every client tick
    drift = generator("sphere", 0, 2)
    color = "white"

particles/world_tree_spores
    width = 2600
    height = 2000
    count = 2200    // 4000 particles
    spawning = 1    // 1 new particles per client tick
    bound1 = list(-1000, -2000, -1000)   // end particles at Y=-300
    bound2 = list(1000, 2000, 1000)   // end particles at Y=300
    lifespan = 1200  // last 600 client ticks max
    fade = 100       // fade out over the last 50 ticks if still on screen
    // spawn within a certain x,y,z space
    position = generator("box", list(-1000,0,0), list(1000,0,50))
    gravity = list(0, -0.33)
    friction = 0.4  // shed 20% of velocity and drift every client tick
    drift = generator("sphere", 0, 2)
    color = "white"

particles/divine_flecks
    width = 96
    height = 96
    count = 32    // 4000 particles
    spawning = 1    // 1 new particles per client tick
    bound1 = list(-48, -48, -10)   // end particles at Y=-300
    bound2 = list(48, 48, 10)   // end particles at Y=300
    lifespan = 600  // last 600 client ticks max
    fade = 50       // fade out over the last 50 ticks if still on screen
    // spawn within a certain x,y,z space
    position = generator("box", list(-48,-16,0), list(96,-16,50))
    gravity = list(0, 2)
    friction = 0.2  // shed 20% of velocity and drift every client tick
    drift = generator("sphere", 0, 2)
    color = "white"

particles/celestial_flecks
    width = 96
    height = 96
    count = 32    // 4000 particles
    spawning = 1    // 1 new particles per client tick
    bound1 = list(-48, -48, -10)   // end particles at Y=-300
    bound2 = list(48, 48, 10)   // end particles at Y=300
    lifespan = 600  // last 600 client ticks max
    fade = 50       // fade out over the last 50 ticks if still on screen
    // spawn within a certain x,y,z space
    position = generator("box", list(-48,-16,0), list(96,-16,50))
    gravity = list(0, 2)
    friction = 0.2  // shed 20% of velocity and drift every client tick
    drift = generator("sphere", 0, 2)
    color = "white"

particles/eye_flecks
    width = 8
    height = 16
    count = 32    // 4000 particles
    spawning = 1    // 1 new particles per client tick
    bound1 = list(-24, -24, -10)   // end particles at Y=-300
    bound2 = list(32, 32, 10)   // end particles at Y=300
    lifespan = 600  // last 600 client ticks max
    fade = 50       // fade out over the last 50 ticks if still on screen
    // spawn within a certain x,y,z space
    position = generator("box", list(8,-2,0), list(14,-2,50))
    gravity = list(0, 0.5)
    color = "white"

particles/dark_flecks
    width = 96
    height = 96
    count = 32    // 4000 particles
    spawning = 1    // 1 new particles per client tick
    bound1 = list(-24, -24, -10)   // end particles at Y=-300
    bound2 = list(24, 32, 10)   // end particles at Y=300
    lifespan = 600  // last 600 client ticks max
    fade = 50       // fade out over the last 50 ticks if still on screen
    // spawn within a certain x,y,z space
    position = generator("box", list(-24,-5,0), list(24,-5,50))
    gravity = list(0, 2)
    friction = 0.2  // shed 20% of velocity and drift every client tick
    drift = generator("sphere", 0, 2)
    color = "white"

particles/divine_flecks_weapon
    width = 64
    height = 128
    count = 15
    spawning = 0.5    // 1 new particles per client tick
    bound1 = list(-12, 2, -10)   // end particles at Y=-300
    bound2 = list(12, 60, 10)   // end particles at Y=300
    lifespan = 25  // last 600 client ticks max
    fade = 25       // fade out over the last 50 ticks if still on screen
    fadein = 5
    // spawn within a certain x,y,z space
    position = generator("box", list(-12,2,0), list(12,2,10))
    gravity = list(0, 1)
    friction = 0.2  // shed 20% of velocity and drift every client tick
    drift = generator("sphere", 0, 1)
    color = "white"

particles/waterfall
    width = 32
    height = 320
    count = 3333    // 3333 particles
    spawning = 300    // 1 new particles per client tick
    //bound1 = list(-16, -700, -1000)   // end particles at Y=-300
    //bound2 = list(4000, 600, 1000)   // end particles at Y=300
    lifespan = 600  // last 600 client ticks max
    fade = 50       // fade out over the last 50 ticks if still on screen
    // spawn within a certain x,y,z space
    position = generator("box", list(16,16,0), list(32,32,50))
    gravity = list(0, -1)
    //friction = 0.2  // shed 20% of velocity and drift every client tick
    drift = generator("sphere", 0, -1)
    color = "blue"
obj/effects/industrial_smoke
	invisibility = 1
	particles = new/particles/smoke
	pixel_x = 32
	pixel_y = 36
	layer = 10
	vis_flags = VIS_INHERIT_PLANE
obj/effects/digging
	particles = new/particles/dust
	appearance_flags = KEEP_APART
	layer = 10
	vis_flags = VIS_INHERIT_PLANE
obj/effects/digging_ash
	particles = new/particles/dig_ash
	appearance_flags = KEEP_APART
	layer = 10
	vis_flags = VIS_INHERIT_PLANE
obj/effects/digging_snow
	particles = new/particles/dig_snow
	appearance_flags = KEEP_APART
	layer = 10
	vis_flags = VIS_INHERIT_PLANE
obj/effects/weapon_energy
	particles = new/particles/divine_flecks_weapon
	appearance_flags = KEEP_APART
	vis_flags = VIS_INHERIT_PLANE
	New()
		src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
		//src.filters += filter(type="outline",size=1, color=rgb(204,236,255))
		src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(204,236,255))
obj/effects/soul_energy
	particles = new/particles/soul_stream
	plane = 1;
	mouse_opacity = 0;
	vis_flags = VIS_INHERIT_PLANE
	/*
	New()
		src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
		src.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
	*/
obj/effects/afterlife_energy
	screen_loc = "CENTER"
	particles = new/particles/afterlife_energy
	filters = filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
	plane = -2;
	mouse_opacity = 0;
	invisibility = 1
	vis_flags = VIS_INHERIT_PLANE
	//layer = 0.1
	//pixel_x = 596
	//pixel_y = 300

obj/effects/divine_energy
    screen_loc = "CENTER"
    particles = new/particles/divine_flecks
    filters = filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(255,255,170))
    mouse_opacity = 0;
    appearance_flags = KEEP_APART
    vis_flags = VIS_INHERIT_PLANE


obj/effects/dark_matter_energy
    screen_loc = "CENTER"
    particles = new/particles/dark_flecks
    filters = filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
    mouse_opacity = 0;
    layer = 10
    vis_flags = VIS_INHERIT_PLANE

obj/effects/celestial_energy
    screen_loc = "CENTER"
    particles = new/particles/celestial_flecks
    //filters = filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,204,170))
    mouse_opacity = 0;
    vis_flags = VIS_INHERIT_PLANE

obj/effects/waterfall
	particles = new/particles/waterfall
mob
	proc
		slow_afterlife_glow()
			if(src && src.client && src.afterlife_effect)
				for(var/obj/effects/afterlife_energy/ae in world)
					src.client.screen -= ae
					world << "DEBUG - found [ae] in world"
				for(var/obj/effects/afterlife_energy/ae in src.client.screen)
					src.client.screen -= ae
					world << "DEBUG - found [ae] in players screen and removed it"
				src.afterlife_effect.particles.gravity = list(0,0.33)
				src.afterlife_effect.particles.spawning = 2
				world << "DEBUG - slowed particles"
		apply_afterlife_glow(var/add,var/time = 6)
			if(src.client)
				if(src.afterlife_effect == null) src.afterlife_effect = new/obj/effects/afterlife_energy
				if(add)
					for(var/obj/effects/afterlife_energy/ae in src.client.screen)
						src.client.screen -= ae
					src.client.screen += src.afterlife_effect
					src.client.screen -= psi_realm_background
					src.client.screen += psi_realm_background
					//if(src.z == 2 || src.z == 6) src << sound('wind.mp3',1,0,8,40)
					spawn(time)
						if(src && src.client)
							src.afterlife_effect.particles.gravity = list(0,0.33)
							src.afterlife_effect.particles.spawning = 2
				else
					for(var/obj/effects/afterlife_energy/ae in src.client.screen)
						src.client.screen -= ae
					//src.afterlife_effect.particles.gravity = list(0,100)
					//src.afterlife_effect.particles.spawning = 600
					src.client.screen -= psi_realm_background
					src << sound(null,channel = 8)
					src << sound(null,channel = 5)




particles/fire
	width = 500
	height = 500
	count = 3000
	spawning = 60
	lifespan = 20
	fade = 10
	position = list(0,0)
	gravity = list(0,1.5)
	friction = 0.27
	drift = generator("circle", 0, 2)
	color = "white"
particles/fizzle
	width = 64
	height = 64
	count = 5000
	spawning = 60
	lifespan = 20
	fade = 10
	position = list(0,0)
	gravity = list(0,0)
	friction = 0.2
	drift = generator("circle", 0, 2)
	color = "white"
particles/smoke
	width = 500
	height = 1200
	count = 300
	spawning = 1
	lifespan = 60
	fade = 150
	position = generator("box", list(6,8,0), list(10,8,0))
	velocity = generator("box", list(-1,10,0), list(1,10,0))
	spin = 0.25
	friction = 0
	icon = 'fx_dust.dmi'
	icon_state = list("1","2","3","4","5","6","7","8")
particles/dust
	width = 500
	height = 800
	count = 300
	spawning = 0.5
	lifespan = 30
	fade = 40
	position = generator("box", list(4,8,0), list(8,8,0))
	velocity = generator("box", list(-1,6,0), list(1,6,0))
	spin = 0.25
	friction = 0
	gravity = 0
	icon = 'fx_dust_dirt.dmi'
	icon_state = list("1","2","3","4","5","6","7","8")
particles/dig_snow
	width = 500
	height = 800
	count = 300
	spawning = 0.5
	lifespan = 30
	fade = 40
	position = generator("box", list(4,8,0), list(8,8,0))
	velocity = generator("box", list(-1,6,0), list(1,6,0))
	spin = 0.25
	friction = 0
	gravity = 0
	icon = list('fx_dust_dirt.dmi','fx_dust.dmi')
	icon_state = list("1","2","3","4","5","6","7","8")
particles/dig_ash
	width = 500
	height = 800
	count = 300
	spawning = 0.5
	lifespan = 30
	fade = 40
	position = generator("box", list(4,8,0), list(8,8,0))
	velocity = generator("box", list(-1,6,0), list(1,6,0))
	spin = 0.25
	friction = 0
	gravity = 0
	icon = 'fx_ash.dmi'
	icon_state = list("1","2","3","4","5","6","7","8")
particles/fire_particles
	width = 1000
	height = 1000
	count = 100
	lifespan = 3
	fade = 2
	spawning = 100
	position = 0
	velocity = generator("circle",-70,70)
	icon = 'fx_dust_explosive.dmi'
	icon_state = list("1","2","3","4","5","6","7","8")
particles/fire_particles_small
	width = 1000
	height = 1000
	count = 50
	lifespan = 3
	fade = 2
	spawning = 50
	position = 0
	velocity = generator("circle",-70,70)
	icon = 'fx_dust_explosive.dmi'
	icon_state = list("1","2","3","4","5","6","7","8")
particles/explosion_dust_dirt
	width = 1000
	height = 1000
	count = 150
	lifespan = 10
	fade = 5
	spawning = 150
	position = 0
	velocity = generator("circle",-75,75)
	icon = 'fx_dust_dirt.dmi'
	icon_state = list("1","2","3","4","5","6","7","8")
particles/explosion_dust_dirt_small
	width = 1000
	height = 1000
	count = 75
	lifespan = 10
	fade = 5
	spawning = 75
	position = 0
	velocity = generator("circle",-30,30)
	icon = 'fx_dust_dirt.dmi'
	icon_state = list("1","2","3","4","5","6","7","8")
particles/explosion_dust_snow
	width = 1000
	height = 1000
	count = 150
	lifespan = 10
	fade = 5
	spawning = 150
	position = 0
	velocity = generator("circle",-75,75)
	icon = list('fx_dust.dmi','fx_dust_dirt.dmi')
	icon_state = list("1","2","3","4","5","6","7","8")
particles/explosion_ash
	width = 1000
	height = 1000
	count = 150
	lifespan = 10
	fade = 5
	spawning = 150
	position = 0
	velocity = generator("circle",-75,75)
	icon = 'fx_ash.dmi'
	icon_state = list("1","2","3","4","5","6","7","8")
particles/explosion_dust_snow_small
	width = 1000
	height = 1000
	count = 75
	lifespan = 10
	fade = 5
	spawning = 75
	position = 0
	velocity = generator("circle",-75,75)
	icon = list('fx_dust.dmi','fx_dust_dirt.dmi')
	icon_state = list("1","2","3","4","5","6","7","8")
particles/rain
	width = 1000
	height = 500
	count = 5500
	spawning = 15
	bound1 = list(-1000, -300, -1000)
	lifespan = 600
	fade = 50
	position = generator("box", list(-300,250,0), list(300,300,100))
	gravity = list(-4.3,-9.7)
	friction = 0.1
	drift = generator("vector", 0, 2)
	color = "#afc3cc"
/*
I use the following filters in conjunction with the fire particles on my fireball emitter. It makes a nice realistic fire effect.
 filters = list(filter(type = "blur", size = 2),
  filter(type = "outline", size = 1, color = "yellow"),
   filter(type = "outline", size = 1, color = "#FFA500"),
    filter(type = "outline", size = 1, color = "red"),
     filter(type = "bloom", rgb(0,0,0), size = 4, offset = 2, alpha = 255))
*/
