mob
	proc
		save_load(var/n)
			if(src.started == 0)
				src.sav_active = n
				//If the save slot isn't empty, load the mob
				if(src.sav[n] != null)
					//world << "DEBUG - Player's mob type before load: [src.type]"
					src.Mob_Load()
					//world << "DEBUG - Player's mob type after load: [src.type]"
					//If the save loads correctly, players started should equal 1
				else //Start a new character save
					//src.loc = null
					src.choosing_character = 1
					src.loc = locate(260,260,2)
					src.client.eye = locate(250,250,2)
					src.client.screen -= src.hud_load
					//src.Human()
					src.birth_year = year-20
					//src.new_char()
					if(src.hud_char) src.client.screen += src.hud_char
					//winset(src,"chat","pos=0,[src.scrheight/1.6]")
					src.title(1)
					//world << "[src.key] logs in"
					for(var/mob/m in players)
						if(src.client) m.create_chat_entry("system","[src.key] logs in.")
					var/obj/hud/menus/char_creation_background/b = src.hud_char
					src.switch_race("Human")
					if(b)
						//Copy the players in-game avatar icon, but save the layer/plane/transform.
						b.update_menu_avatar()
						//Update the players portrait, if they have one, to reflect the new race choice.
						b.update_portrait_transform()
		save_delete(var/n)
			if(src.started == 0)
				//src.sav_active = n
				src.left_click_ref = n
				src.hud_confirm.confirm_text(1,"Are you sure you want to delete Save [n]?",src)
				src.confirm = "confirm save delete"
				//src.left_click_ref = n
		Mob_Save(var/stop_all = 1)
			//if(src.client) if(src.can_save)
			world << "DEBUG - Saving player client."
			if(src.can_save && src.started)
				world << "DEBUG - Player can save and has started game"

				//If the player is about to logout/quit, then run this part of the save code.
				if(stop_all)
					src.letgo()
					//sleep(0.1)
					//src.clear_minigame_lift()
					//sleep(0.1)
					src.drop_tk()
					//sleep(0.1)
					//src.overlays -= /obj/effects/swim
					//src.filters -= filter(type="motion_blur", x=1, y=0)
					//src.filters = null
					//sleep(0.1)
					src.bolted = 0
					src.layer = 4
					if(src.wings) src.vis_contents -= src.wings
					//src.alpha = 255
					src.weather = null
					//Reset the location of visual indicators so they don't stay on the map when the player logs.
					if(src.mouse_over_tooltip) src.mouse_over_tooltip.loc = null
					if(src.mouse_over_visual) src.mouse_over_visual.loc = null
					if(src.build_marker) src.build_marker.loc = null
					if(src.hud_confirm_nums) src.hud_confirm_nums.clear_box()
					src.can_attack = 1
					if(src.shadow)
						src.shadow.loc = null
						src.shadow.vis_contents = null
					src.pixel_y = src.pixel_y_og
					if(src.hair) src.overlays -= src.hair
					//sleep(0.1)
					src.disable_skills()
					//sleep(0.1)
					for(var/obj/I in src)
						I.vis_contents -= global.inv_slot
						//I.filters = null
						//I.particles = null
						if(I.disable_logout) I.loc = src.loc
						for(var/obj/X in I)
							if(X.disable_logout) X.loc = src.loc
							if(istype(I,/obj/items/tech/Canister))
								I.icon_state = "empty"
					//sleep(0.1)
					src.density_factor = initial(src.density_factor)
					src.layer = initial(src.layer)
					src.reset_alerts()
					src.ambients = list()
					for(var/obj/effects/after_image/af in src.afterimages)
						af.in_use = 0
						af.loc = null
						af.alpha = 130
						af.pixel_z = 0
					if(src.cyber_selected)
						var/obj/hud/buttons/cybernetic_slot/cs = src.cyber_selected
						cs.selected = 0
						if(cs.full == 0) cs.icon_state = "empty"
						else cs.icon_state = "full"
						src.cyber_selected = null
				/*
				var/e = src.hud_energy
				var/e_c = src.hud_energy_charge
				src.client.screen -= e
				src.client.screen -= e_c
				src.hud_energy = null
				src.hud_energy_charge = null
				*/

				//Proceed with default sav code
				var/obj/itm = src.item_selected
				if(src.item_selected)
					src.item_selected.overlays -= /obj/effects/select_item
					src.item_selected = null
				if(src.skill_divine_weapon)
					for(var/mob/s in src.skill_divine_weapon.active_splits)
						if(s.grabbed_by) s.grabbed_by.letgo()
						s.particles = null
						s.filters = null
						if(s.shadow) s.shadow.vis_contents = null
				if(src.skill_psi_clone)
					for(var/mob/s in src.skill_psi_clone.active_splits)
						if(s.grabbed_by) s.grabbed_by.letgo()
						s.particles = null
						s.filters = null
						if(s.shadow) s.shadow.vis_contents = null

				src.dimiss_all_alerts()
				//src.hud_energy = null
				//src.hud_divine = null
				//src.hud_wings = null
				//src.hud_liquid = null
				src.particles = null //Keep this for a while, I think saving them makes the player crash.

				var/list/screen_mobs = list()
				if(src && src.client)
					for(var/mob/m in src.client.screen)
						src.client.screen -= m
						screen_mobs += m
					/*
					for(var/obj/o in src)
						o.filters = null
						o.particles = null
					*/

				if(world_tree)
					src.show_worldtree(0)

				//src.key_save()
				var/savefile/S = new("saves/players/[src.byond_key]/sav[src.sav_active].sav")
				//var/txtfile = file("saves/players/[src.byond_key]/sav[src.sav_active].txt")
				/*
				if(src.loc)
					S["X"] << src.x
					S["Y"] << src.y
					S["Z"] << src.z
				*/
				S["Player"] << src
				//Want to make sure these don't save, since we have a seperate save which handles this info
				//Write(S)
				S.dir.Remove("sav")
				S.dir.Remove("sav_names")
				S.dir.Remove("friends")
				//fdel(txtfile)
				//S.ExportText("/",txtfile)
				//src << "<pre>[html_encode(file2text(txtfile))]</pre>"

				src.redraw_appearance()

				for(var/mob/m in screen_mobs)
					if(src.client) src.client.screen += m
				if(src.skill_divine_weapon)
					for(var/mob/s in src.skill_divine_weapon.active_splits)
						s.filters += filter(type="outline",size=1, color=rgb(204,236,255))
						s.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(204,236,255))
						s.filters += filter(type="bloom", threshold=rgb(0,0,0), size = 6,offset=1,alpha = 175)
						if(s.shadow) s.shadow.vis_contents += new/obj/effects/weapon_energy
				if(world_tree)
					src.show_worldtree(1)

				if(itm)
					src.item_selected = itm
					src.item_selected.overlays += /obj/effects/select_item

				//world << "DEBUG - SAVE: Players icon is : [src.icon], state: [src.icon_state]"
				//world << "DEBUG - Saved player correctly."

				//world << "DEBUG - saved char [src]"

				/*
				src.hud_energy = e
				src.hud_energy_charge = e_c
				src.client.screen += src.hud_energy
				src.client.screen += src.hud_energy_charge
				*/

				//return 1
		Mob_Load()
			if(src.client)
				if(fexists("saves/players/[src.client.key]/sav[src.sav_active].sav"))
					//var/savefile/S = new("saves/players/[src.client.key]/sav[src.sav_active].sav")
					//Read(S)
					//world << "DEBUG - LOAD: Players icon is : [src.icon], state: [src.icon_state]"
					//winshow(src,"loading",0)
					src.show_ui()
					src.title(1)
					winshow(src,"login",0)
					src.client.screen -= src.hud_load
					src.client.Load("saves/players/[src.client.key]/sav[src.sav_active].sav")
					//S["Player"] >> src
					//if(!players.Find(src)) players += src
					return 1
				else
					return 0
			else
				return 0
		//This proc is called when the player loads their save
		mob_prep()
			src.disable_skills()
			src.icon_state = src.state()
			for(var/sl=1, sl<49, sl++)
				if(src.inv[sl] != null)
					src.inv[sl].vis_contents += global.inv_slot
			for(var/obj/skills/s in src)
				s.cd_bar = null
				if(s.cd_state < 32)
					src.skill_cooldown(s)
			src.online = 1
			src.can_attack = 1
			src.underlays = null
			src.bar_health = null
			src.bar_energy = null
			src.bar_o2 = null
			src.recovering = 0
			src.can_ki = 1
			src.KB = 0
			src.stunned -= src.stunned_pending
			if(src.stunned < 0) src.stunned = 0
			if(src.submerged && src.bar_o2)
				src.bar_o2.loc = null
				var/image/o2 = image('bars_o2.dmi',src,"[round(src.o2,10)]",20,pixel_x = -16)
				o2.appearance_flags = KEEP_APART
				src.bar_o2 = o2
				src.client.images += src.bar_o2
			if(src.wings) src.wings = null
			src.vis_contents = null
			src.name_txt()
			src.redraw_appearance()
			if(src.client) src.show_ui()
			//src.check_admin()
			//src.enable_planes()
			src.reset_ui_proc()
			src.tmp_lists()
			src.reset_planes()
			//src.set_icon()
			src.create_player_blip()
			src.check_wounds()
			src.update_skillbar()
			if(!players.Find(src)) players += src
			if(src.screen_text) src.client.screen += src.screen_text
			if(src.hud_hp_bar) src.client.screen += src.hud_hp_bar
			if(src.hud_eng_bar) src.client.screen += src.hud_eng_bar
			if(src.hud_hp_bar_inner) src.client.screen += src.hud_hp_bar_inner
			if(src.hud_eng_bar_inner) src.client.screen += src.hud_eng_bar_inner
			if(src.hud_pp) src.client.screen += src.hud_pp
			if(src.hud_info) src.client.screen += src.hud_info
			if(src.hud_chat) src.client.screen += src.hud_chat
			if(src.koed)
				src.koed = 0
				src.KO(1)
			if(src.hud_unlocks)
				src.hud_unlocks.check_status(src)
				src.hud_unlocks.switch_tab(src.hud_unlocks.selected,src)
			if(src.origin)
				if(istype(src.origin,/obj/origins/exalted))
					var/obj/effects/exalted_rays/rays = new
					rays.layer = src.layer-0.2
					src.vis_contents += rays
			src.check_splits()
			//if(src.client) winset(src,"stats.tab_stats","tabs=[url_encode("+")]updates")
			if(src.dead)
				src.filters -= filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
				src.filters += filter(type="drop_shadow", x=0, y=0, size=3, offset=1, color=rgb(102,0,204))
			src.setup_alert_history()
			src.save_alert_history("Loaded character")
			var/psi_realms = 0
			if(src.z == 2 || src.z == 6) psi_realms = 1
			src.age_update(psi_realms)
			src.contact_login()
			src.gain_relations()
			//src.StopMidi()
			src.ambients = list()
			if(maps_created && src.open_map)
				var/obj/hud/map/map_large/x = maps[src.z]
				if(x.build_overlay) src.client.screen += x.build_overlay
			if(src.z != 2 && src.z != 6) src.apply_afterlife_glow(0)
			if(src.z == 4 && world_tree) src.show_worldtree(1)
			if(src.origin && istype(src.origin,/obj/origins/chosen_one)) chosen_ones += 1
			src.set_decline()
			src.music_random = 1
			//src.update_tracks()
			//var/enable_music_load
			//src.play_random_music()
			//src << 'wind.mp3'
			if(src.hud_load)
				if(src.sav_active == 1) src.port = src.hud_load.port1
				else if(src.sav_active == 2) src.port = src.hud_load.port2
				else if(src.sav_active == 3) src.port = src.hud_load.port3
			if(src.port)
				for(var/obj/portrait/p in src.port)
					p.p_owner = src
				src.client.screen += src.port
			if(src.client) src.client.eye = src
			src.started = 1
			spawn(20)
				if(src)
					src.process_stats()
			if(src.loc == null)
				src.loc = locate(1,1,1)
				src << "Failed to load save location correctly, please report this error."
				src.started = 0
			else
				var/turf/t = src.loc
				src.loc.Enter(src)
				src.Move(t)
				src.grav = t.grav
		key_load()
			//world << "DEBUG - Checking if player has any saves."
			if(fexists("saves/players/[src.client.key]/[src.client.key]_info.sav"))
				//world << "DEBUG - Found player save data."
				var/savefile/S = new("saves/players/[src.client.key]/[src.client.key]_info.sav")
				S["Saves"] >> src.sav
				S["Menu"] >> src.hud_load
				S["Friends"] >> src.friends
				if(src.friends == null) src.friends = list()

				S["Save1 Name"] >> src.sav_names[1]
				S["Save1 Race"] >> src.sav_races[1]

				S["Save2 Name"] >> src.sav_names[2]
				S["Save2 Race"] >> src.sav_races[2]

				S["Save3 Name"] >> src.sav_names[3]
				S["Save3 Race"] >> src.sav_races[3]

			if(src.hud_load == null)
				var/obj/hud/menus/load_background/n1 = new
				src.hud_load = n1
				n1.menu_create()
			var/obj/hud/menus/load_background/load_menu = src.hud_load
			load_menu.vis_contents = null
			load_menu.vis_contents += load_menu.but_new_01
			load_menu.vis_contents += load_menu.but_new_02
			load_menu.vis_contents += load_menu.but_new_03
			load_menu.vis_contents += load_menu.txt_title
			if(src.sav[1] != null)
				//world << "DEBUG - Loading key data from slot 1"
				load_menu.but_new_01.maptext = "[css_outline]<font size = 1><center>Load"
				load_menu.vis_contents += load_menu.but_del_01
				load_menu.vis_contents += load_menu.port1
				load_menu.vis_contents += load_menu.sav_txt1
				if(load_menu.port1)
					var/obj/portrait/p = load_menu.port1
					//world << "DEBUG - found [p] in sav1 data"
					p.hud_x = 9
					p.hud_y = 197
					var/matrix/x = matrix()
					x.Translate(p.hud_x,p.hud_y)
					p.transform = x
					src.hud_load.vis_contents += p
					for(var/obj/o in p)
						p.vis_contents += o
				//alert(src,"Save data is currently as follows - sav(1)=[src.sav[1]]")
			else
				load_menu.but_new_01.maptext = "[css_outline]<font size = 1><center>New"

			if(src.sav[2] != null)
				//world << "DEBUG - Loading key data from slot 2"
				load_menu.but_new_02.maptext = "[css_outline]<font size = 1><center>Load"
				load_menu.vis_contents += load_menu.but_del_02
				load_menu.vis_contents += load_menu.port2
				load_menu.vis_contents += load_menu.sav_txt2
				if(load_menu.port2)
					var/obj/portrait/p = load_menu.port2
					p.hud_x = 9
					p.hud_y = 103
					var/matrix/x = matrix()
					x.Translate(p.hud_x,p.hud_y)
					p.transform = x
					src.hud_load.vis_contents += p
					for(var/obj/o in p)
						p.vis_contents += o
			else
				load_menu.but_new_02.maptext = "[css_outline]<font size = 1><center>New"

			if(src.sav[3] != null)
				//world << "DEBUG - Loading key data from slot 3"
				load_menu.but_new_03.maptext = "[css_outline]<font size = 1><center>Load"
				load_menu.vis_contents += load_menu.but_del_03
				load_menu.vis_contents += load_menu.port3
				load_menu.vis_contents += load_menu.sav_txt3
				if(load_menu.port3)
					var/obj/portrait/p = load_menu.port3
					p.hud_x = 9
					p.hud_y = 9
					var/matrix/x = matrix()
					x.Translate(p.hud_x,p.hud_y)
					p.transform = x
					src.hud_load.vis_contents += p
					for(var/obj/o in p)
						p.vis_contents += o
			else
				load_menu.but_new_03.maptext = "[css_outline]<font size = 1><center>New"
		key_save()
			//world << "DEBUG - Trying to save player key data."
			if(src.client)
				var/obj/hud/menus/load_background/load_menu = src.hud_load

				/*
				This part should only execute when the player has already loaded into a char
				As in, they would need to have an active character they are playing, with a valid sav_active
				--------------------------------------------------------------------------------------------
				*/
				//Make sure to apply save entry data, like portrait, char name, ect.
				var/T = time2text(world.realtime,"DD/MM/YYYY")
				if(src.sav_active > 0)
					src.sav_names[src.sav_active] = src.real_name
					src.sav_races[src.sav_active] = src.race
				if(src.sav_active == 1)
					src.sav[1] = 1
					load_menu.port1 = src.port
					world << "DEBUG - Save was last saved on [T]"
					load_menu.sav_txt1.maptext = "[css_outline]<font size = 1><text align=left valign=top>Save: 1\nName: [src.real_name]\nLast Played: [T]\nTime Played: 0h\nRace: [src.race]"
					world << "DEBUG - Saved character to slot 1"
				else if(src.sav_active == 2)
					src.sav[2] = 1
					load_menu.port2 = src.port
					load_menu.sav_txt2.maptext = "[css_outline]<font size = 1><text align=left valign=top>Save: 2\nName: [src.real_name]\nLast Played: [T]\nTime Played: 0h\nRace: [src.race]"
					world << "DEBUG - Saved character to slot 2"
				else if(src.sav_active == 3)
					src.sav[3] = 1
					load_menu.port3 = src.port
					load_menu.sav_txt3.maptext = "[css_outline]<font size = 1><text align=left valign=top>Save: 3\nName: [src.real_name]\nLast Played: [T]\nTime Played: 0h\nRace: [src.race]"
					world << "DEBUG - Saved character to slot 3"
				//-----------------------------------------------------------------------------------------

				/*
				This part runs, even if the player isn't logged into a character
				So they can do things like delete a save, ect.
				Then save that info seperate from the players normal saves.
				*/
				var/savefile/S = new("saves/players/[src.byond_key]/[src.byond_key]_info.sav")
				S["Saves"] << src.sav
				S["Menu"] << src.hud_load
				S["Friends"] << src.friends

				S["Save1 Name"] << src.sav_names[1]
				S["Save1 Race"] << src.sav_races[1]

				S["Save2 Name"] << src.sav_names[2]
				S["Save2 Race"] << src.sav_races[2]

				S["Save3 Name"] << src.sav_names[3]
				S["Save3 Race"] << src.sav_races[3]
		loading_screen()
			var/obj/L = new
			L.appearance_flags = PIXEL_SCALE
			if(server_loading)
				src.client.eye = null
				L.maptext = "[css_outline]<text align=center valign=middle><font size = 4>Loading"
				L.maptext_width = 320
				L.maptext_height = 64
				L.screen_loc = "1,1"
				src.client.screen += L
				var/n = 1
				var/list/dots = list("",".","..","...")
				while(server_loading && src && L)
					var/dot = dots[n]
					L.maptext = "[css_outline]<text align=left valign=middle><font size = 4>Loading[dot]"
					n += 1
					if(n == 5) n = 1
					sleep(4)
			src.client.eye = src
			src.client.screen -= L
			del(L)
mob/Write(savefile/S)
	..(S)
	S["X"] << x
	S["Y"] << y
	S["Z"] << z

//Overwrites the default Read() so vars can be changed based on the players save version.
mob/Read(savefile/S)
	..()
	loc = locate(S["X"],S["Y"],S["Z"])
	if(loc == null)
		loc = locate(1,1,1)
		src << "Failed to load save location correctly, please report this error."
client/proc/Load(filename)
	var/savefile/F = new(filename)
	F["Player"] >> src.mob
	src.mob.mob_prep()
/*
mob/Write(savefile/S)
	..()
	S["X"] << x
	S["Y"] << y
	S["Z"] << z

mob/Read(savefile/S)
	..()
	loc = locate(S["X"],S["Y"],S["Z"])
	if(loc == null | loc == null)
		loc = locate(1,1,1)
		src << "Failed to load save location correctly, please report this error."
	src.name_txt()
	if(src.hair) src.overlays += src.hair
	if(src.client)
		winshow(src,"percents",1)
		winshow(src,"chat",1)
		winset(src,"main.map_main","focus=true")
		winset(src,"percents.bar_health","bar-color=#FF0000")
		src.reset_ui_proc()
		src.tmp_lists()
		src.ui()
		var/count = 0
		for(var/obj/skills/o in src)
			src << output(o,"skills.grid_skills:[++count]")
		if(src.vision) src.client.screen += src.vision
		winset(src, "skills.grid_skills", "cells=\"[count]\"")
		update_skills_bar()
	if(src.koed)
		src.koed = 0
		src.KO(1)

mob/Write(savefile/S)
	..()
	S["X"] << x
	S["Y"] << y
	S["Z"] << z
*/
/*
client
	proc
		Save()
			var/savefile/F = new("saves/[key].sav")
			F["mob"] << mob
		Load()
			if(fexists("saves/[key].sav"))
				var/savefile/F = new("saves/[key].sav")
				F["mob"] >> mob
				loaded_in = 1
*/
/*
mob
  /* Any special handling for saving and loading goes in mob/Write() and mob/Read() */
	Write(var/savefile/F)
		..()
		//save our location
		F["x"] << x
		F["y"] << y
		F["z"] << z
	Read(var/savefile/F)
		..()
		//load our location
		var/turf/T = locate(F["x"], F["y"], F["z"])
		if(T)
			loc = T
*/