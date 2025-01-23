world
	proc
		Save_All()
			set background = 1
			spawn(1)
				world.Save_Year()
				sleep(0.1)
				world.Save_Contacts()
				sleep(0.1)
				world.Save_objs()
				sleep(0.1)
				world.Save_World_Tree()
				sleep(0.1)
				world.Save_Map()
				sleep(0.1)
		Initialize()
			world.Load_Year()
			world.Load_Contacts()
			spawn(60) Load_Map()
		Save_World_Tree()
			set background = 1
			if(world_tree)
				var/obj/items/tech/world_tree/wt = world_tree
				wt.loc = null
				//var/old_vis = wt.vis_contents
				var/old_rays = wt.wt_rays
				//wt.vis_contents = null
				wt.wt_rays = null
				wt.particles = null
				//wt.cleanse_all_vars()
				var/savefile/S = new("saves/world/world_tree.sav")
				S["TREE"] << world_tree
				world_tree.loc = locate(250,250,4)
				//wt.vis_contents = old_vis
				wt.wt_rays = old_rays
				//world << "DEBUG - Saved [world_tree]"
		Load_World_Tree()
			if(fexists("saves/world/world_tree.sav"))
				var/savefile/S = new("saves/world/world_tree.sav")
				S["TREE"] >> world_tree
				if(world_tree)
					world_tree.loc = locate(250,250,4)
					//world << "DEBUG - Loaded [world_tree]"
		Save_Year()
			set background = 1
			var/savefile/S = new("saves/world/year.sav")
			S["YEAR"] << global.year
			S["PSIONIC YEAR"] << global.psi_year
			S["YEAR COUNTER"] << global.counter
		Load_Year()
			if(fexists("saves/world/year.sav"))
				var/savefile/S = new("saves/world/year.sav")
				S["YEAR"] >> global.year
				S["PSIONIC YEAR"] >> global.psi_year
				S["YEAR COUNTER"] >> global.counter
		Save_Contacts()
			set background = 1
			var/savefile/S = new("saves/world/contacts.sav")
			S["CONTACTS"] << contacts
			S["NAMES"] << names_taken

			var/txtfile = file("saves/world/contacts.txt")
			S.ExportText("/",txtfile)
		Load_Contacts()
			if(fexists("saves/world/contacts.sav"))
				var/savefile/S = new("saves/world/contacts.sav")
				if(S["CONTACTS"]) S["CONTACTS"] >> contacts
				if(S["NAMES"]) S["NAMES"] >> names_taken
				//if(global.contacts == null || length(global.contacts) <= 0 || islist(global.contacts) == 0) global.contacts = list()
				//if(global.names_taken == null || length(global.names_taken) <= 0 || islist(global.names_taken) == 0) global.names_taken = list()