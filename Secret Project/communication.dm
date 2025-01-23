proc
	say_quote(var/text)
		var/ending = copytext(text, length(text))

		if (ending == "?")
			return "asks, \"[text]\"";
		else if (ending == "!")
			return "exclaims, \"[text]\"";
		else if (ending == ")" || ending == "]" || ending == "}")
			return "oocly says, \"[text]\"";

		return "says, \"[text]\"";
	sanitize(var/t)
		var/index = findtext(t, "\n")
		while(index)
			t = copytext(t, 1, index) + "#" + copytext(t, index+1)
			index = findtext(t, "\n")

		index = findtext(t, "\t")
		while(index)
			t = copytext(t, 1, index) + "#" + copytext(t, index+1)
			index = findtext(t, "\t")

		return html_encode(t)
	replace_quotations(text, open, close)
		if(!text || !open || !close) return
		var
			const/quotation = "\""
			is_open = FALSE
			position = 0
			last_start
			result = ""
		for()
			last_start = position + 1
			position = findtext(text, quotation, last_start)
			if(!position)
				return "[result][copytext(text, last_start)]"
			else if(copytext(text, position - 1, position) == "\\")
				result = "[result][copytext(text, last_start, position + 1)]"
			else
				is_open = !is_open
				result = "[result][copytext(text, last_start, position)][is_open ? open : close]"

mob
	proc
		create_chat_entry(var/chosen_tab,var/text)
			if(src.client == null) return
			var/obj/hud/menus/chat_background/c = src.hud_chat
			var/raw_string = null
			var/speaker = null

			if(chosen_tab == "local")
				speaker = "<b>[src.real_name]</b>: "
			else if(chosen_tab == "world")
				speaker = "<b>[src.key]</b>: "
			else if(chosen_tab == "alerts")
				speaker = "<b>Alert</b>: "
			else if(chosen_tab == "system")
				speaker = "<b>System</b>: "

			var/obj/hud/o = src.typing
			if(o == null) o = c.input

			if(text == null)
				raw_string = c.input.string_full
			else raw_string = text

			if(o == c.input)
				//If the length of the text the player sends is too large, prevent it from happening. Should help stop lag from huge spam/posts.
				if(length(raw_string) >= 1000)
					src.set_alert("Message too long",'alert.dmi',"alert")
					src.create_chat_entry("alerts","Message too long.")
					return
				var/string = "[css_outline]<font size = 1><left>[speaker][raw_string]"
				var/L = src.client.MeasureText(string,width = 300)

				//Calculate how big the new entries maptext_width should be based on the x axis of the text and MeasureText()
				var/x_pos = findtext(L, "x")
				var/L_x = copytext(L, 1, x_pos)
				L_x = text2num(L_x)
				if(L_x <= 0)
					return

				//Calculate how big the new entries maptext_height should be based on the y axis of the text and MeasureText()
				var/y_pos = findtext(L, "x")
				var/L_y = copytext(L, y_pos+1, 0)
				L_y = text2num(L_y)
				if(L_y <= 0)
					return

				//Adjust the local text
				if(chosen_tab == "local")
					for(var/mob/m in view(18,src))
						if(m.client && m.hud_chat)
							var/obj/hud/menus/chat_background/h_chat = m.hud_chat
							var/obj/hud/menus/chat_background/scroller = h_chat.scroller_local
							var/obj/hud/menus/chat_background/chat_entry/entry = h_chat.entry_local
							h_chat.local_size += (L_y+13)
							entry.maptext_height += (L_y+13)
							entry.maptext_y -= (L_y+13)
							entry.maptext += "\n\n[string]"
							if(scroller && h_chat.local_size > 0)
								if(scroller.translated_y == -62)
									//If the player is already scrolled down to the bottom of the chat, make sure to keep moving the chat/scroller down for them.
									var/matrix/m_scroller = matrix()
									m_scroller.Translate(0,scroller.translated_y)
									scroller.transform = m_scroller
									scroller.local_scroll_y = h_chat.local_size

									var/matrix/mat_local = matrix()
									mat_local.Translate(entry.hud_x,entry.hud_y+h_chat.local_size)
									entry.translated_y = scroller.local_scroll_y
									entry.transform = mat_local
				//Adjust the world/global text
				else if(chosen_tab == "world")
					for(var/mob/m in players)
						if(m.hud_chat)
							var/obj/hud/menus/chat_background/h_chat = m.hud_chat
							var/obj/hud/menus/chat_background/scroller = h_chat.scroller_global
							var/obj/hud/menus/chat_background/chat_entry/entry = h_chat.entry_global
							h_chat.global_size += (L_y+13)
							entry.maptext_height += (L_y+13)
							entry.maptext_y -= (L_y+13)
							entry.maptext += "\n\n[string]"
							if(scroller && h_chat.global_size > 0)
								if(scroller.translated_y == -62)
									//If the player is already scrolled down to the bottom of the chat, make sure to keep moving the chat/scroller down for them.
									var/matrix/m_scroller = matrix()
									m_scroller.Translate(0,scroller.translated_y)
									scroller.transform = m_scroller
									scroller.global_scroll_y = h_chat.global_size

									var/matrix/mat_global = matrix()
									mat_global.Translate(entry.hud_x,entry.hud_y+h_chat.global_size)
									entry.translated_y = scroller.global_scroll_y
									entry.transform = mat_global
				//Adjust the alerts text
				else if(chosen_tab == "alerts")
					var/mob/m = src
					if(m.hud_chat)
						var/obj/hud/menus/chat_background/h_chat = m.hud_chat
						var/obj/hud/menus/chat_background/scroller = h_chat.scroller_alerts
						var/obj/hud/menus/chat_background/chat_entry/entry = h_chat.entry_alerts
						h_chat.alerts_size += (L_y+13)
						entry.maptext_height += (L_y+13)
						entry.maptext_y -= (L_y+13)
						entry.maptext += "\n\n[string]"
						if(scroller && h_chat.alerts_size > 0)
							if(scroller.translated_y == -62)
								//If the player is already scrolled down to the bottom of the chat, make sure to keep moving the chat/scroller down for them.
								var/matrix/m_scroller = matrix()
								m_scroller.Translate(0,scroller.translated_y)
								scroller.transform = m_scroller
								scroller.alerts_scroll_y = h_chat.alerts_size

								var/matrix/mat_alerts = matrix()
								mat_alerts.Translate(entry.hud_x,entry.hud_y+h_chat.alerts_size)
								entry.translated_y = scroller.alerts_scroll_y
								entry.transform = mat_alerts
				//Adjust the system text
				else if(chosen_tab == "system")
					var/mob/m = src
					if(m.hud_chat)
						var/obj/hud/menus/chat_background/h_chat = m.hud_chat
						var/obj/hud/menus/chat_background/scroller = h_chat.scroller_system
						var/obj/hud/menus/chat_background/chat_entry/entry = h_chat.entry_system
						h_chat.system_size += (L_y+13)
						entry.maptext_height += (L_y+13)
						entry.maptext_y -= (L_y+13)
						entry.maptext += "\n\n[string]"
						if(scroller && h_chat.system_size > 0)
							if(scroller.translated_y == -62)
								//If the player is already scrolled down to the bottom of the chat, make sure to keep moving the chat/scroller down for them.
								var/matrix/m_scroller = matrix()
								m_scroller.Translate(0,scroller.translated_y)
								scroller.transform = m_scroller
								scroller.system_scroll_y = h_chat.system_size

								var/matrix/mat_system = matrix()
								mat_system.Translate(entry.hud_x,entry.hud_y+h_chat.system_size)
								entry.translated_y = scroller.system_scroll_y
								entry.transform = mat_system
		/*
		create_chat_entry(var/chosen_tab,var/text)
			if(src.client == null) return
			var/obj/hud/menus/chat_background/c = src.hud_chat
			var/obj/hud/menus/chat_background/tab = null
			var/raw_string = null
			var/speaker = null

			if(chosen_tab == "local")
				tab = c.tab_local
				speaker = "<b>[src.real_name]</b>: "
			else if(chosen_tab == "world")
				tab = c.tab_global
				speaker = "<b>[src.key]</b>: "
			else if(chosen_tab == "alerts")
				tab = c.tab_alerts
				speaker = "<b>Alert</b>: "
			else if(chosen_tab == "system")
				tab = c.tab_system
				speaker = "<b>System</b>: "

			var/obj/hud/o = src.typing
			if(o == null) o = c.input

			if(text == null)
				raw_string = c.input.string_full
			else raw_string = text

			if(o == c.input)
				//If the length of the text the player sends is too large, prevent it from happening. Should help stop lag from huge spam/posts.
				if(length(raw_string) >= 1000)
					src.set_alert("Message too long",'alert.dmi',"alert")
					src.create_chat_entry("alerts","Message too long.")
					return
				var/scroll_y = 0
				var/entry_x = 0
				var/entry_y = 0
				var/string = "[css_outline]<font size = 1><left>[speaker][raw_string]"
				var/L = src.client.MeasureText(string,width = 300)

				//Calculate how big the new entries maptext_width should be based on the x axis of the text and MeasureText()
				var/x_pos = findtext(L, "x")
				var/L_x = copytext(L, 1, x_pos)
				L_x = text2num(L_x)
				if(L_x <= 0)
					return

				//Calculate how big the new entries maptext_height should be based on the y axis of the text and MeasureText()
				var/y_pos = findtext(L, "x")
				var/L_y = copytext(L, y_pos+1, 0)
				L_y = text2num(L_y)
				if(L_y <= 0)
					return

				//Adjust the local text
				if(tab == c.tab_local)
					for(var/mob/m in view(18,src))
						if(m.client && m.hud_chat)
							var/obj/hud/menus/chat_background/h_chat = m.hud_chat
							var/obj/hud/menus/chat_background/scroller = h_chat.scroller_local
							entry_x = h_chat.local_x
							entry_y = h_chat.local_y
							scroll_y = h_chat.local_scroll_y
							h_chat.local_y -= (L_y+6)
							h_chat.local_size += (L_y+6)
							//Create an chat entry for every player nearby and give them a copy
							var/obj/hud/menus/chat_background/chat_entry/entry = new
							entry.hud_x = entry_x
							entry.hud_y = entry_y
							entry.entry_size_y = L_y
							var/matrix/mat = matrix()
							mat.Translate(entry.hud_x,entry.hud_y+scroll_y)
							entry.transform = mat
							entry.maptext_height = L_y
							entry.maptext_y -= (L_y+6)
							entry.maptext = string
							//Display text to all players nearby, then put the entry into the holders entries list so it can be reloaded.
							if(h_chat.txt_display_local)
								h_chat.txt_display_local.vis_contents += entry
								h_chat.txt_display_local.entries_local += entry
							if(scroller && h_chat.local_size > 0)
								if(scroller.translated_y == -62)
									//If the player is already scrolled down to the bottom of the chat, make sure to keep moving the chat/scroller down for them.
									var/matrix/m_scroller = matrix()
									m_scroller.Translate(0,scroller.translated_y)
									scroller.transform = m_scroller
									scroller.local_scroll_y = h_chat.local_size
									//Move all the text down too, if the scroller is set to track the chat.
									for(var/obj/txt in h_chat.txt_display_local.vis_contents)
										var/matrix/mat_local = matrix()
										mat_local.Translate(txt.hud_x,txt.hud_y+h_chat.local_size)
										txt.translated_y = scroller.local_scroll_y
										txt.transform = mat_local
				//Adjust the world/global text
				else if(tab == c.tab_global)
					for(var/mob/m in players)
						if(m.hud_chat)
							var/obj/hud/menus/chat_background/h_chat = m.hud_chat
							var/obj/hud/menus/chat_background/scroller = h_chat.scroller_global
							entry_x = h_chat.global_x
							entry_y = h_chat.global_y
							scroll_y = h_chat.global_scroll_y
							h_chat.global_y -= (L_y+6)
							h_chat.global_size += (L_y+6)
							//Create an chat entry for every player nearby and give them a copy
							var/obj/hud/menus/chat_background/chat_entry/entry = new
							entry.hud_x = entry_x
							entry.hud_y = entry_y
							entry.entry_size_y = L_y
							var/matrix/mat = matrix()
							mat.Translate(entry.hud_x,entry.hud_y+scroll_y)
							entry.transform = mat
							entry.maptext_height = L_y
							entry.maptext_y -= (L_y+6)
							entry.maptext = string
							//Display text to all players nearby, then put the entry into the holders entries list so it can be reloaded.
							if(h_chat.txt_display_global)
								h_chat.txt_display_global.vis_contents += entry
								h_chat.txt_display_global.entries_global += entry
							if(scroller && h_chat.global_size > 0)
								if(scroller.translated_y == -62)
									//If the player is already scrolled down to the bottom of the chat, make sure to keep moving the chat/scroller down for them.
									var/matrix/m_scroller = matrix()
									m_scroller.Translate(0,scroller.translated_y)
									scroller.transform = m_scroller
									scroller.global_scroll_y = h_chat.global_size
									//Move all the text down too, if the scroller is set to track the chat.
									for(var/obj/txt in h_chat.txt_display_global.vis_contents)
										var/matrix/mat_global = matrix()
										mat_global.Translate(txt.hud_x,txt.hud_y+h_chat.global_size)
										txt.translated_y = scroller.global_scroll_y
										txt.transform = mat_global
				//Adjust the alerts text
				else if(tab == c.tab_alerts)
					var/mob/m = src
					if(m.hud_chat)
						var/obj/hud/menus/chat_background/h_chat = m.hud_chat
						var/obj/hud/menus/chat_background/scroller = h_chat.scroller_alerts
						entry_x = h_chat.alerts_x
						entry_y = h_chat.alerts_y
						scroll_y = h_chat.alerts_scroll_y
						h_chat.alerts_y -= (L_y+6)
						h_chat.alerts_size += (L_y+6)
						//Create an chat entry for every player nearby and give them a copy
						var/obj/hud/menus/chat_background/chat_entry/entry = new
						entry.hud_x = entry_x
						entry.hud_y = entry_y
						entry.entry_size_y = L_y
						var/matrix/mat = matrix()
						mat.Translate(entry.hud_x,entry.hud_y+scroll_y)
						entry.transform = mat
						entry.maptext_height = L_y
						entry.maptext_y -= (L_y+6)
						entry.maptext = string
						//Display text to player, then put the entry into the holders entries list so it can be reloaded.
						if(h_chat.txt_display_alerts)
							h_chat.txt_display_alerts.vis_contents += entry
							h_chat.txt_display_alerts.entries_alerts += entry
						if(scroller && c.alerts_size > 0)
							if(scroller.translated_y == -62)
								//If the player is already scrolled down to the bottom of the chat, make sure to keep moving the chat/scroller down for them.
								var/matrix/m_scroller = matrix()
								m_scroller.Translate(0,scroller.translated_y)
								scroller.transform = m_scroller
								scroller.alerts_scroll_y = c.alerts_size
								//Move all the text down too, if the scroller is set to track the chat.
								for(var/obj/txt in c.txt_display_alerts.vis_contents)
									var/matrix/mat_alerts = matrix()
									mat_alerts.Translate(txt.hud_x,txt.hud_y+c.alerts_size)
									txt.translated_y = scroller.alerts_scroll_y
									txt.transform = mat_alerts
				//Adjust the system text
				else if(tab == c.tab_system)
					var/mob/m = src
					if(m.hud_chat)
						var/obj/hud/menus/chat_background/h_chat = m.hud_chat
						var/obj/hud/menus/chat_background/scroller = h_chat.scroller_system
						entry_x = h_chat.system_x
						entry_y = h_chat.system_y
						scroll_y = h_chat.system_scroll_y
						h_chat.system_y -= (L_y+6)
						h_chat.system_size += (L_y+6)
						//Create an chat entry for every player nearby and give them a copy
						var/obj/hud/menus/chat_background/chat_entry/entry = new
						entry.hud_x = entry_x
						entry.hud_y = entry_y
						entry.entry_size_y = L_y
						var/matrix/mat = matrix()
						mat.Translate(entry.hud_x,entry.hud_y+scroll_y)
						entry.transform = mat
						entry.maptext_height = L_y
						entry.maptext_y -= (L_y+6)
						entry.maptext = string
						//Display text to player, then put the entry into the holders entries list so it can be reloaded.
						if(h_chat.txt_display_system)
							h_chat.txt_display_system.vis_contents += entry
							h_chat.txt_display_system.entries_system += entry
						if(scroller && c.system_size > 0)
							if(scroller.translated_y == -62)
								//If the player is already scrolled down to the bottom of the chat, make sure to keep moving the chat/scroller down for them.
								var/matrix/m_scroller = matrix()
								m_scroller.Translate(0,scroller.translated_y)
								scroller.transform = m_scroller
								scroller.system_scroll_y = c.system_size
								//Move all the text down too, if the scroller is set to track the chat.
								for(var/obj/txt in c.txt_display_alerts.vis_contents)
									var/matrix/mat_system = matrix()
									mat_system.Translate(txt.hud_x,txt.hud_y+c.system_size)
									txt.translated_y = scroller.system_scroll_y
									txt.transform = mat_system
				c.cull_entries()
			*/
		save_alert_history(var/text)
			if(!(text || src))
				return
			var/logfile = "saves/players/[src.client.key]/Logs/[src.real_name]_alert_history.log"
			file(logfile) << "Year: [round(year)], Month: [round((year-round(year))*10)] - [text] <p>"
			src << output("Year [round(year)], Month [round((year-round(year))*10)]: [text] <p>","chat.output_alerts")
		saveToLog(var/text)
			if(!(text || src))
				return
			var/logfile = "saves/players/[src.client.key]/Logs/[usr.real_name].log"
			file(logfile) << "Year - [round(year)], Time - [time2text(world.timeofday, "YYYY-MM-DDThh:mm:ss")] [text]"
		setup_alert_history()
			if(src.client)
				var/logfile = "saves/players/[src.client.key]/Logs/[src.real_name]_alert_history.log"
				var/siz = File_Size(file(logfile))
				if(siz == "MB") fdel("saves/players/[src.client.key]/Logs/[src.real_name]_alert_history.log")
				else src << output(file2text(logfile),"chat.output_alerts")
		Say_Spark()
			var/image/A=image(icon='Say Spark.dmi',pixel_y=6)
			A.icon-=rgb(255,255,255)
			A.icon+=rgb(100,200,250)
			overlays+=A
			spawn(20) if(src) overlays-=A
		Check_RP(var/msg,var/num,var/seconds,var/type)
			if(msg) if(!findtext(msg,"oocly says"))

				/*
				//Give a rp bonus if this emote and the previous were an hour apart.
				var/T = world.timeofday
				T = time2text(T,"hh")
				var/RP = text2num(T) //Current hour in the day rp was written
				var/Player_RP = text2num(src.RP_Last) //Hour in the day previous rp was written
				if(!src.RP_Last)
					src.RP_Last = T
				if(Player_RP != RP) //Compar the time the current and previous rp were written, if not the same, give bonus rp.
					if(src.RP_Earned < 0)
						src.RP_Points += num*10
						src.RP_Earned += num*10
						src.RP_Total += num*10
				src.RP_Last = T
				*/

				var/TextLength = length(msg)
				src.RP_Length = TextLength
				var/divide = 40
				var/MinTime = TextLength / divide
				if(seconds) if(MinTime >= seconds)
					src << "Possible pre-typed RP detected. If you are typing your emote elsewhere and pasting it here, please make sure to leave the emote window open while you do so."
					for (var/mob/M in players)
						if (M.admin)
							M << "<font color=[M.text_color_ic]><b><font color=red> </font>[src.key]</b> has created a possible pre-typed Emote.</font>"
					return
				src.RPs += 1
				var/Bonus = 0.001
				var/speaker = src
				if(src.projection) speaker = src.projection
				for(var/mob/p in oview(7,speaker))
					if(p.afk == 0) Bonus += 0.001

				if(src.RP_Earned < 0)
					var/Rested = 0
					if(src.RP_Rested > 0)
						Rested = src.RP_Rested/10000
						src.RP_Rested -= Rested*TextLength
					src.RP_Points += (num + Rested + Bonus)*TextLength
					src.RP_Earned += (num + Rested + Bonus)*TextLength
					src.RP_Total += (num + Rested + Bonus)*TextLength

				/*
				while(TextLength)
					TextLength -= 1
					if(src.RP_Earned < 0)
						var/Rested = 0
						if(src.RP_Rested > 0)
							Rested = src.RP_Rested/10000
							src.RP_Rested -= Rested
						src.RP_Points += num + Rested + Bonus
						src.RP_Earned += num + Rested + Bonus
						src.RP_Total += num + Rested + Bonus
				*/
	verb
		resize_window(var/t as text)
			set hidden = 1
			set name = ".resize"
			if(usr.typing) return
			if(winget(usr,"[t].resize","is-checked") == "true") winset(usr,"[t]","can-resize=true")
			else winset(usr,"[t]","can-resize=false")
		Alpha_Change(var/t as text)
			set hidden = 1
			set name = ".alpha"
			if(usr.typing) return
			var/v = winget(usr,"[t].alpha","value")
			v = text2num(v)
			v = 255-v
			winset(usr,"[t]","alpha=[v]")
		open_emote()
			set name = ".open_emote"
			set hidden = 1
			if(usr.typing) return
			if(usr.open_emote == 0)
				winshow(usr,"emote",1)
				winset(usr,"emote.input_emote","focus=true")
				usr.open_emote = 1;
				usr.RP_open_time = world.time / 10
				overlays -= 'Typing.dmi'
				overlays += 'Typing.dmi'
				usr.open_menus.Add(".open_emote")
				while(usr.open_emote)
					var/T = winget(usr,"emote.input_emote","text")
					var/L = length(T)
					winset(usr,"emote.chars","text=\"Characters: [L]\"")
					var/RP = 0.001*L
					winset(usr,"emote.rpp","text=\"Estimated RPP reward: [RP]\"")
					sleep(10)
			else
				winshow(usr,"emote",0)
				usr.open_emote = 0
				overlays -= 'Typing.dmi'
				usr.open_menus.Remove(".open_emote")
				return
		emote()
			set hidden = 1
			set name = ".emote"
			if(usr.typing) return
			var/msg = winget(usr,"emote.input_emote","text")
			var/speaker = usr
			if(usr.projection) speaker = usr.projection
			for(var/mob/M in hearers(ViewX,speaker))
				if(M.client)
					M.saveToLog("<br> | [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [M.client.key] ::<br> *[usr] starts typing an emote.\n")
			if(!msg)
				overlays -= 'Typing.dmi'
				for(var/mob/M in hearers(ViewX,speaker))
					if(M.client)
						M.saveToLog("<br> | [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [M.client.key] ::<br> *[usr] cancels their emote.*\n")
				return
			var/Old_Sight=see_invisible
			see_invisible=101
			usr.RP_close_time = world.time / 10
			//var/Secs_Close = usr.RP_close_time - usr.RP_open_time
			usr.RP_copy = msg
			var/RP = 0.001
			msg = replace_quotations(msg, "\"<font color=[usr.text_color_ic]>", "</font>\"")
			//msg = FilterString(msg)
			//usr.count_words(msg,"\"<font color=[usr.text_color_ic]>", "</font>\"")
			//world << "DEBUG words = [count_words(msg,"\"<font color=[usr.text_color_ic]>", "</font>\"")]"
			for(var/mob/M in hearers(ViewX,speaker))
				if(M.ref && ismob(M.ref))
					var/mob/x = M.ref
					M = x
				if(M.client)
					if(RP < 0.005)
						RP += 0.0005
					M << output("<font color = yellow><BIG>\icon[usr.icon]</BIG><font size=[M.text_size]>*[usr] [msg]*","chat.local")
					spawn(1)
						if(M && M.client && M.chat != "local" && M.show_flash_local)
							if(M.client) winset(M,"main","flash=10")
							var/times = 6
							while(times)
								times -= 1
								if(M && M.client) winset(M,"chat.button_local","background-color=#FFFF00")
								sleep(2)
								if(M && M.client) winset(M,"chat.button_local","background-color=#000000")
								sleep(2)
					M.saveToLog("<br> | [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [M.client.key]:<br> *[usr] [msg]*\n")
			//First check if any common English words were found.
			//if(usr.common_word_count > 0)
				//Then make sure they're not the same rp's being pasted and spammed in a row.
				//if(usr.check_rp_spam(msg) == 0)
					//If everything seems fine, start to process the emote for rp points.
					//usr.Check_RP(msg,RP,Secs_Close,"Emote")
				//else usr << "Possible copy and paste of previous emote detected."
			//else usr << "Possible nonsensical emote detected, or lack of English."
			usr.see_invisible=Old_Sight
			usr.Say_Spark()
			usr.overlays -= 'Typing.dmi'
			winshow(usr,"emote",0)
			winset(usr,"emote.input_emote","text=")
			usr.open_emote = 0
			if(length(usr.RP_last) > 10) usr.RP_last = list()
			if(length(usr.RP_word_count) > 10) usr.RP_word_count = list()
			//world << "DEBUG - found [usr.check_rp_matches(msg)]% matches from last 10 rp's and last 100 words."
			usr.RP_last += msg
			usr.RP_word_count += length(msg)

		emote_cancel()
			set name = ".emote_cancel"
			set hidden = 1
			if(usr.typing) return
			if(usr.started == 0) return
			winset(usr,"main.map_main","focus=true")
			winset(usr,"emote.input_emote","text=")
			winshow(usr,"emote",0)
			usr.open_emote = 0
			usr.overlays -= 'Typing.dmi'
			for(var/mob/M in hearers(ViewX,usr))
				if(M.client)
					M.saveToLog("<br> | [M.client.address ? (M.client.address) : "IP not found"] | ([M.x], [M.y], [M.z]) | [M.client.key] ::<br>*[usr] cancels their emote.*\n")
			return

		Say(var/msg as text)
			set name = ".say"
			set hidden = 1
			if(usr.typing) return

			msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
			if(!msg)	return

			var/Old_Sight=see_invisible
			see_invisible=101

			//world << "DEBUG words = [count_words(msg,"\"<font color=[usr.text_color_ic]>", "</font>\"")]"
			//usr.count_words(msg,"\"<font color=[usr.text_color_ic]>", "</font>\"")
			//usr.RP_word_count += length(msg)
			/*
			for(var/i = 1,i < usr.RP_last_100.len + 1,i++)
				//world << "DEBUG - found [usr.RP_last_100[i]]"
			for(var/i = 1,i < usr.RP_word_count.len + 1,i++)
				//world << "DEBUG - found last rp word count lengths [usr.RP_word_count[i]]"
			*/

			msg=say_quote(msg)	//Moved to after stutter

			if(!findtext(msg,"oocly")) if(usr.critical_throat)
				msg = "*Mumbles incoherently*..."

			var/speaker = usr
			if(usr.projection) speaker = usr.projection
			//msg = FilterString(msg)
			//usr.ai_previous_msg = "[usr.name]: [msg]"
			for(var/mob/M in hearers(14,speaker))
				if(M.ref && ismob(M.ref))
					var/mob/x = M.ref
					M = x
				if(M.client)
					var/Hear = 1
					if(M.critical_hearing)
						Hear = 0
					if(findtext(msg,"oocly"))
						Hear = 1
					if(Hear)
						M << output("<BIG>\icon[usr.icon]</BIG><font size=[M.text_size] color=[usr.text_color_ic]>[usr.name] [msg]","chat.local")
						M.saveToLog("[usr]([key]): [msg]\n")
						spawn(1)
							if(M && M.client && M != usr && M.show_flash_local && M.show_flash_local_say)
								winset(M,"main","flash=10")
								var/times = 6
								while(times)
									times -= 1
									if(M && M.client) winset(M,"chat.button_local","background-color=#FFFF00")
									sleep(2)
									if(M && M.client) winset(M,"chat.button_local","background-color=#000000")
									sleep(2)
					else
						M << output("<i>You hear a distant noise...</i>","chat.local")
				//else
					//spawn(10)
						//if(M && usr) M.ai(msg,usr)
					/*
					if(usr.skill_psi_clone)
						if(M.owner == usr.real_name && findtext(msg,M.ai_name))
							spawn(6)
								if(M && usr) M.command_ai("[msg]",usr)
							break
					*/
			/*
			if(usr.common_word_count > 0)
				if(usr.check_rp_spam(msg) == 0) usr.Check_RP(msg,0.00005*length(msg),Secs_Close,"Say")
				else usr << "Possible copy and paste of previous emote detected."
			*/
			see_invisible=Old_Sight
			winset(usr,"main.map_main","focus=true")
			//world << "DEBUG - words common found [usr.common_word_count]"