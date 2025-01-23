/var
	STEAM_APP_ID = 0
	SUB_PASSPORT = 0 //Just set to 0 for now, unless we use byond subs.
	//ALLOWED_IDS = list()

// We do all of this on ye olde client object
client
    // We store everything in an associated list for easy access later
	var/tmp
		credentials[] = list(
			"byond_member"      = FALSE,
			"byond_subscriber"  = FALSE,
			"steam_name"        = FALSE,
			"steam_id"          = FALSE,
			"steam_passport"    = FALSE
		)

	proc
        // We can call this proc to do a full authentication of permission levels
		Authenticate()
			//BYONDAuthentication()
			SteamAuthentication()
			//return BYONDAuthentication() | SteamAuthentication()

        // Let's say we want to give BYOND Members and Hub Subscribers the same authentication level
		BYONDAuthentication()
			credentials["byond_member"]     = IsByondMember()
			credentials["byond_subscriber"] = CheckPassport(SUB_PASSPORT)

			spawn(60)
				if(mob && mob.started)
					mob.create_chat_entry("system","byond_member: [credentials["byond_member"]]")
					mob.create_chat_entry("system","byond_subscriber: [credentials["byond_subscriber"]]")

            // Either a valid membership or subscription will be considered authenticated
			//return credentials["byond_member"] || credentials["byond_subscriber"]

        // Here we can grab and store values for our various Steam info
		SteamAuthentication()
			if(mob.client) mob.client.credentials["steam_name"] = GetAPI("steam", "name")
			if(mob.client) mob.client.credentials["steam_id"] = GetAPI("steam", "id")
			//if(mob.client) mob.client.credentials["steam_passport"] = CheckPassport("steam:[STEAM_APP_ID]")

			spawn(60)
				if(mob && mob.started)
					mob.create_chat_entry("system","steam_name: [credentials["steam_name"]]")
					mob.create_chat_entry("system","steam_id: [credentials["steam_id"]]")
					//mob.create_chat_entry("system","steam_passport: [credentials["steam_passport"]]")

            // If they don't have their Steam Passport, we consider them not authenticated
			//return credentials["steam_passport"]