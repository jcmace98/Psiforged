var global/regex/ScreenLocParser = regex("^(?:(?!\[0-9]+:)(\\w+):)?(\\d+)(?::(\\d+))?,(\\d+)(?::(\\d+))?$")

client
	show_popup_menus = 0
	//mouse_pointer_icon = 'mouse.dmi'
	control_freak  = CONTROL_FREAK_ALL// | CONTROL_FREAK_MACROS
	//preload_rsc = 1
	fps = 60
	mouse_pointer_icon = 'mouse.dmi'
	authenticate = 0
	perspective = MOB_PERSPECTIVE | EDGE_PERSPECTIVE
	/*
	MouseMove(object,location,control,params)
		params = params2list(params)
		var/pos = params["screen-loc"]
	*/
	Click(object,location,control,params)
		if(usr.koed) return
		..()
	MouseUp(object,location,control,params)
		usr.client.dragging = 0
		usr.client.drag_x = 0
		usr.client.drag_y = 0
		if(usr.info_box1)
			usr.client.screen -= usr.info_box1
			usr.client.screen -= usr.info_box2
			usr.client.screen -= usr.info_box3
			usr.info_box3.maptext = null
		..()
	var
		client_mouse_x
		client_mouse_y
		client_mouse_screen_x
		client_mouse_screen_y
		prev_mouse_x
		prev_mouse_y
		client_mouse_screen_loc
		TILE_WIDTH = 32
		TILE_HEIGHT = 32
		loaded_in = 0
		dragging = 0
		drag_x = 0 //location x of where player where player started dragging map from
		drag_y = 0
	proc
		update(params)

			if(!params) return

			params = params2list(params)

			if(!("screen-loc" in params)) return

			// parse out the values in the "screen-loc" parameter
			var/pos = params["screen-loc"]

			if(!pos) return

			var/comma = findtext(pos, ",")
			var/colon = findtext(pos, ":")

			if(comma < 1) return
			if(colon < 1) return

			var/tx = text2num(copytext(pos, 1, colon))
			var/px = text2num(copytext(pos, colon + 1, comma))

			colon = findtext(pos, ":", comma)

			if(colon < 1) return

			var/ty = text2num(copytext(pos, comma + 1, colon))
			var/py = text2num(copytext(pos, colon + 1))


			var/new_x = (tx*32)+px
			var/new_y = (ty*32)+py
			//px = px-16
			//py = py-16
			//var/xx = (16*32)+16//+usr.step_x
			//var/yy = (9.5*32)+16//+usr.step_y
			var/xx = (17*32)+16//+usr.step_x
			var/yy = (10.5*32)+16//+usr.step_y

			//new_x += (px/32)
			//new_y += (py/32)
			var/degrees=usr.atan2(new_x - xx, new_y - yy)

			degrees = (360-degrees)
			degrees = round(degrees)

			//client.MouseUpdate(tx, px, ty, py)
			//usr << output("[xx],[yy] vs [new_x],[new_y] - [degrees]", "chat.system")

			usr.mouse_degree = degrees
			//src.client.mouse_screen_x = xx
			//src.client.mouse_screen_y = yy

			//client.MouseUpdate(tx, px, ty, py)
		MousePosition(params)
			var/s
			if(islist(params)) s = params["screen-loc"]
			else s = params2list(params)["screen-loc"]

			var/x = 0
			var/y = 0

			var/s1 = copytext(s,1,findtext(s,",",1,0))
			var/s2 = copytext(s,length(s1)+2,0)

			var/colon1 = findtext(s1,":",1,0)
			var/colon2 = findtext(s1,":",colon1+1,0)

			if(colon2)
				x = (text2num(copytext(s1,colon1+1,colon2))-1) *TILE_WIDTH
				x += text2num(copytext(s1,colon2+1,0))-1

			else
				x = (text2num(copytext(s1,1,colon1))-1) * TILE_WIDTH
				x += text2num(copytext(s1,colon1+1,0))-1

			colon2 = findtext(s2,":",1,0)
			y = (text2num(copytext(s2,1,colon2))-1) * TILE_HEIGHT
			y += text2num(copytext(s2,colon2+1,0))-1


			client_mouse_screen_loc = s
			client_mouse_x = x
			client_mouse_y = y

			if(client_mouse_x > 1023) client_mouse_x = 1023;
			if(client_mouse_y > 575) client_mouse_y = 575;

