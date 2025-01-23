//Used to catch local/distant html/javascript/href calls and process their contents.
mob/Topic(href,href_list)
	/*
	src<<href_list["minutes"]
	src<<href_list["os"]
	src<<href_list["agent"]
	src<<href_list["resx"] + "x" + href_list["resy"]
	src<<href_list["hours"] + ":" + href_list["minutes"]
	src<<href_list["os"]
	src<<href_list["clip"]
	*/
	src.clipboard = href_list["clip"]
	/*
	if(src.typing)
		var/obj/i = src.typing
		i.caret_pos = length(i.string_full)+1
	*/
	//var/set_focus_back_later_below
	//winset(src,"main.map_main","focus=true")
	src << browse(null)
	winshow(src,"browser",0)