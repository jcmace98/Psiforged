obj/var/savedX = 0
obj/var/savedY = 0
obj/var/savedZ = 0
world
	proc
		Load_Server()
			//Wipe all the default map items so the saved ones can be loaded in sucessfully without duping.
			for(var/obj/items/I in world)
				if(isturf(I.loc))
					del(I)
		Save_objs()
			set background = 1
			var/savefile/S = new("saves/world/items.sav")
			for(var/obj/o in items)
				if(o.loc && isturf(o.loc))
					o.savedX = o.x
					o.savedY = o.y
					o.savedZ = o.z
					//o.filters = null
					//o.particles = null
					o.loc = null
					//o.cleanse_all_vars()
			S["ITEMS"] << items
			S["VINES"] << vines
			for(var/obj/o in items)
				if(o.savedX && o.loc == null) o.loc = locate(o.savedX,o.savedY,o.savedZ)
				else items -= o
		Load_objs()
			if(fexists("saves/world/items.sav"))
				var/savefile/S = new("saves/world/items.sav")
				if(S["ITEMS"]) S["ITEMS"] >> items
				if(S["VINES"]) S["VINES"] >> vines
				for(var/obj/o in items)
					o.loc = locate(o.savedX,o.savedY,o.savedZ)
					if(o.act_load) call(o.act_load)(o)
