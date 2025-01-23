/*

Player login/logout cheat sheet

Login()
	THREE KNOWN LOGIN SITUATIONS SO FAR

	- Player logs in RAW, i.e, first time connecting to client
		- which is detected by the "started" and "choosing character" vars to make sure its a fresh client
		- NEW players SHOULD always have
			- "started = 0"
			- "choosing character = 0"

	- Player SWITCHES to new race when selecting new character
		- Which is checked by the "choosing character" vars to make sure
		- Players CHOOSING new character should always have
			- "started = 0"
			- "choosing_character = 1"

	- Player LOADING a save
		- Which is checked by looking at the players "started" var
		- "started = 1"
		- "choosing_character = 0"
Logout()
	- Player logs out via "Quit Game"
		- which should del(src) them, due to checking their "started" var. Should also be the case if they crash, ect.
		- expected vars
			- "started = 1"
			- "choosing_character = 0"

	- Player logs out while choosing a character
		- which is checked by the "started" var
		- expected vars
			- "started = 0"
			- "choosing_character = 1"

	- Player logs out via the "Logout" option
		- which creates a new mob and forces them to connect to it. (Then del(src) their old mob? Not 100%, should do though.)
		- expected vars
			- "started = 1"
			- "choosing_character = 0"

*/
mob
	//NOTE - Make sure the new/load character screen shows when a player logs in, even if they already have a character in the game world.
	//Make a new save slot system, and/or make it so when creating a new char, the old one is saved and removed from the game world.
	Logout()
		//world << "DEBUG - [src] logout with [src.type] mob"
		if(src.started)
			src.online = 0
			//if(src.client)
			//if(src.icon && src.client) //world << "[src.key] logs out"
			//winshow(src,"resolution",0)
			//src.client.Save()
			src.remove_player_blip() //Put this here so blips are not deleted on player save, only on logout.
			if(src.origin && istype(src.origin,/obj/origins/chosen_one)) chosen_ones -= 1
			for(var/mob/m in players)
				if(src.icon && src.client) m.create_chat_entry("system","[src.key] logs out.")
				if(m.target == src) m.add_remove_target(src,1)
			if(src.hud_unlocks)
				var/obj/hud/menus/unlocks_background/h = src.hud_unlocks
				h.holder_special.vis_contents = null
			src.Mob_Save(1)
			src.contact_logout()
			src.overlays -= /obj/effects/offline
			src.overlays += /obj/effects/offline
			//Make a check later to determine if the player wants to stay in the game world, or logout to main menu.
			//winset(src, null, "command=.quit")
			//world << "DEBUG - LOGOUT: Players icon is : [src.icon], state: [src.icon_state]"
			players -= src
			src.key_save()
			del(src)
		else
			//If the player logs out while creating a char, or changes race, should throw that char back into the available mobs pools.
			//world << "DEBUG - Called logout proc for player with started=0"
			src.apply_afterlife_glow(0)
			src.loc = null
			src.clear_portrait()
			src.eyes = null
			src.eyes_white = null
			src.mouse_saved_loc = null
			switch(src.race)
				if("Human")
					races_humans += src
					//world << "DEBUG - Pre-mature logout: detected player was previously Human"
				if("Demon")
					races_demons += src
					//world << "DEBUG - Pre-mature logout: detected player was previously Demon"
				if("Celestial")
					races_celestials += src
					//world << "DEBUG - Pre-mature logout: detected player was previously Celestial"
				if("Android")
					races_androids += src
					//world << "DEBUG - Pre-mature logout: detected player was previously Android"
				if("Cerebroid")
					races_cerebroids += src
					//world << "DEBUG - Pre-mature logout: detected player was previously Cerebroid"
				if("Imp")
					races_imps += src
					//world << "DEBUG - Pre-mature logout: detected player was previously Imp"
				if("Yukopian")
					races_yukopians += src
					//world << "DEBUG - Pre-mature logout: detected player was previously Yukopian"
			/*
			spawn(6)
				if(src)
					world << "DEBUG - [src] is around still."
					var/V
					for(V in src.vars)
						if(ismovable(src.vars[V]))
							world << "DEBUG - [src:] [V] = [src.vars[V]]"
							var/atom/a = src.vars[V]
							for(var/V2 in a.vars)
								if(ismovable(a.vars[V2]))
									world << "    [V2] = [a.vars[V2]]"
			*/
	Login()
		//world << "DEBUG - [src] login with [src.type] mob"
		var/canplay = 1
		//src.check_admin()
		//if(world.internet_address) shutdown()
		//var/enable_music_main
		//src << Dystopic_Technology
		/*
		if(src.client.computer_id == "490575922") canplay = 1
		if(src.client?.credentials["steam_passport"] >= 1) canplay = 1
		if(canplay < 1)
			alert(src,"Please consider supporting Psiforged on Patreon, thank you.","Unable to authenticate","Ok")
			del(src)
		*/
		//src.appearance_flags = KEEP_TOGETHER
		if(src.client) winset(src,"main","pos=0,0")

		var/obj/hud/planes/plane_hud/hd = new
		src.hud_hud = hd
		src.client.screen += hd
		/*
		winset(src,"res","pos=0,0")
		winset(src,"res","size=1920x1080")
		src.scrwidth = getWinX("res")
		src.scrheight = getWinY("res")
		winshow(src,"res",0)
		//world << "Window X: [getWinX("res")], Window Y: [getWinY("res")]"
		*/
		/*
		//Use this version for debugging.
		winset(src, "main", "is-maximized=false;can-resize=true;titlebar=true;menu=false") //Reset to not maximized and turn off titlebar.
		winset(src, "main", "is-maximized=true") //Now set to maximized. We have to do this separately, so that the taskbar is appropriately covered
		*/

		if(canplay)
			if(src.started == 0)
				//if(src.client) src.client.SteamAuthentication()
				//if(src.client) src.client.Authenticate()
				//winset(src, null, "command=\".configure graphics-hwmode off\"")
				//winset(src, null, "command=\".configure graphics-hwmode on\"")
				//src<<browse(version_notes)
				//winset(src, null, "reset=true")
				//if(src.client.byond_version >= world.byond_version)
				/*
				if(winget(src, null, "hwmode") == "true")
					src << "Hardware mode active"
				else
					src << "Software mode active"
					//winshow(src,"resolution",0)
				*/
				//if(!testers.Find(src.key))
					//del(src)
					//return
				//winset(src,"main","size=1920x1080")
				//winset(src,"main","is-maximized=true")
				//winset(src,"main.map_main","is-maximized=true")
				//winset(src,"main.map_main","size=1920x1080")
				//src.loading_screen()
				/*
				var/n = 0
				for(var/mob/m in races_humans)
					n += 1
				world << "DEBUG - Number of mobs inside races_humans is [n]."

				n = 0
				for(var/mob/m in races_demons)
					n += 1
				world << "DEBUG - Number of mobs inside races_demons is [n]."

				n = 0
				for(var/mob/m in races_celestials)
					n += 1
				world << "DEBUG - Number of mobs inside races_celestials is [n]."

				n = 0
				for(var/mob/m in races_androids)
					n += 1
				world << "DEBUG - Number of mobs inside races_androids is [n]."

				n = 0
				for(var/mob/m in races_cerebroids)
					n += 1
				world << "DEBUG - Number of mobs inside races_cerebroids is [n]."

				n = 0
				for(var/mob/m in races_imps)
					n += 1
				world << "DEBUG - Number of mobs inside races_imps is [n]."

				n = 0
				for(var/mob/m in races_yukopians)
					n += 1
				world << "DEBUG - Number of mobs inside races_yukopians is [n]."
				*/

				//winshow(src,"chat",1)

				//src.grab_clipboard()
				src.key_load()
				if(src.choosing_character == 0)
					//Logged in for the first time

					//Use this one to activate full screen.
					if(src.client) winset(src, "main", "is-maximized=false;can-resize=false;titlebar=false;menu=false") //Reset to not maximized and turn off titlebar.
					if(src.client) winset(src, "main", "is-maximized=true") //Now set to maximized. We have to do this separately, so that the taskbar is appropriately covered.
					if(src.client) winset(src,"main","size=4000x4000")
					if(src.client) winset(src,"main.map_main","size=[winget(src,"main","inner-size")]")
					if(src.client) winset(src, "main", "is-maximized=false;can-resize=false;titlebar=false;menu=false") //Reset to not maximized and turn off titlebar.
					if(src.client) winset(src, "main", "is-maximized=true") //Now set to maximized. We have to do this separately, so that the taskbar is appropriately covered.
					if(src.client) winset(src,"login","pos=100,100")

					src.set_info_box()
					src.create_login_menus()
					//v.alpha = 255
					src.title(0)
					src.loc = locate(250,250,2)
					//spawn(10)
					if(src)
						if(src.z == 2 || src.z == 6)
							src.apply_afterlife_glow(1)
						//sleep(7)
						//animate(src.vision,alpha = 0,time = 20)
					//src.loading_screen()
				else if(src.hud_char)
					//Logged in from switching race in character creator
					src.client.screen += src.hud_char
			else
				//Logged in from loading a character
				for(var/mob/m in players)
					if(src.client) m.create_chat_entry("system","[src.key] logs in.")
				src.overlays -= /obj/effects/offline
				src.show_ui()
				//winshow(src,"login",0)

mob
	proc
		create_login_menus()
			var/obj/hud/menus/char_creation_background/char = new
			src.hud_char = char
			char.loc = src
			char.menu_create()

			var/obj/hud/menus/confirm_menu_background/confirm = new
			src.hud_confirm = confirm
			confirm.loc = src

			var/obj/hud/menus/confirm_menu_numbers_background/confirm_num = new
			src.hud_confirm_nums = confirm_num
			confirm_num.loc = src

			var/obj/effects/vision/v = new
			src.vision = v
			if(src.client) src.client.screen += v

			var/obj/hud/menus/updates_background/updates = new
			src.hud_updates = updates
			updates.loc = src
			updates.menu_create()