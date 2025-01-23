world
	proc
		years()
			spawn(30)
			//spawn(3600)
				var/new_year = 0
				global.counter += 1
				if(global.counter >= 10)
					global.year += 0.1
					new_year = 1
				else
					global.psi_year += 0.1
				for(var/mob/m in players)
					if(m.started)
						var/psi_realm = 0
						if(m.z == 2 || m.z == 6)
							if(global.counter < 10) psi_realm = 1
						m.age_update(psi_realm,new_year)
				if(global.counter >= 10)
					global.counter = 0
					world.Repop()
					world.Save_All()
				else world.Save_Year()
				//if(global.counter == 3 || global.counter == 6 || global.counter == 9)
					//world.respawn_items()
				spawn(10)
				//spawn(3600)
					world.years()
mob
	proc
		age_update(var/psi_realm = 0,var/new_year = 0)
			src.age_soul += year-src.log_year //This will be 0 if they log out straight after a month ticks over.
			if(psi_realm) src.age_soul += psi_year-src.log_psi_year //This will be 0 if they log out straight after a month ticks over.
			if(src.has_body)
				src.age += year-src.log_year
				if(src.mortal && psi_realm) src.age += psi_year-src.log_psi_year
				if(src.in_oldage) src.vigour -= (src.lifespan-src.oldage)/120 //Put this one in the actual aging flow process
			if(new_year)
				src.set_alert("Month [round((year-round(year))*10)], Year [round(year)]",'alert.dmi',"alert")
				src.create_chat_entry("alerts","Month [round((year-round(year))*10)], Year [round(year)].")
				if(src.screen_text)
					src.screen_text.maptext = "<font size = 6><center>Month [round((year-round(year))*10)], Year [round(year)]"
					animate(src.screen_text,alpha = 255,time = 60)
					animate(alpha = 0,time = 60)
				if(src.vampire)
					var/obj/origins/o = src.origin
					call(o.act)(src,o)
			else if(psi_realm && src.mortal)
				src.set_alert("You are [round(src.age)] years and [round((src.age-round(src.age))*10)] months old",'alert.dmi',"alert")
				src.create_chat_entry("alerts","You are [round(src.age)] years and [round((src.age-round(src.age))*10)] months old.")
			if(src.age >= src.oldage)
				if(src.in_oldage == 0)
					//src << output("You are now old.","chat.system")
					src.in_oldage = 1
				src.grey_hair += 1
				src.grey_hair = clamp(src.grey_hair,0,100)
				if(src.hair)
					src.overlays -= src.hair
					src.hair.icon = src.hair_icon
					src.hair += rgb(src.grey_hair,src.grey_hair,src.grey_hair)
					src.redraw_appearance()
			src.check_quest_availability()
			//src << output("You are [round(src.age)] years and [round((src.age-round(src.age))*10)] months old.","chat.system")
			src.log_year = year
			src.log_psi_year = psi_year //This needs to be set too for when a player enters psi realm from mortal realms.
			//world << "Log year = [year]"
			//world << "Log psi year = [psi_year]"

		//Arrived at psi realm aged 20.5

		/*
		Logs off at year 10 in psi realms
		5 psi realm months pass
		Player logs on
		age + will be 0 for mortal world time, because they logged off between months, at log_year 10
		age + will be 5 months because they logged off at psi_year 0.5, and their log_psi_year was 0
		Player logs off
		Player logs on
		age + will be 0 for mortal world time, because they logged off between months, at log_year 10
		age + will be 0 months because they logged off at psi_year 0.5, and their log_psi_year was 0.5
		*/

		/*
		Logs off at year 10 in psi realms
		10 mortal realm years pass
		Player logs on
		age + will be 10 for mortal world time, because they logged off between months, at log_year 10
		age + will be 100 years because they logged off at psi_year 200, and their log_psi_year was 100
		Player logs off
		Player logs on
		age + will be 0 for mortal world time, because they logged off between months, at log_year 20
		age + will be 0 months because they logged off at psi_year 200, and their log_psi_year was 200
		*/