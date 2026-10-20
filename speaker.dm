/obj/radio{icon = 'grafon/structure.dmi'; var/on = 1; var/channel = "1"; icon_state = "speaker"; desc = "Some kind of radio thingy."; var/open = 0}
/obj/radio/speaker{alticon = "gspeaker"; desc = "A radio speaker."}
/obj/radio/operate(obj/W)





	if(W:energy > 0)
		W:energy -= 1
		src.attack_hand()
	else
		usr << "\red Not enough energy!"
		return

/obj/radio/proc/buzz(speech)





	for(var/mob/M in hearers(src))
		if(!M.sleeps)
			M << "[src] buzzes, \bold ''[html_decode(speech)]''"

/obj/radio/station
	on = 0
	name = "Broadcasting Station"
	icon_state = "station"
/obj/radio/station
/obj/radio/bourgeous
	on = 1
	icon_state = "bourgeous"
	name = "Bourgeous CommStation"
/obj/radio/bourgeous
/obj/radio/bourgeous/verb/messaga()
	set name = "Send a message"
	set src in view(1)

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	src.sendmessage()

/obj/radio/bourgeous/proc/sendmessage(msg as text)
	msg = input("Type a message.", "Message:", " ")
	for(var/obj/item/device/mobila/M in world)
		M.beep(msg)


/obj/radio/attack_hand()
	if(src.open == 0)
		switch(src.on)
			if(0)
				usr << "\blue You turn broadcasting on."
				src.on = 1
			if(1)
				usr << "\blue You turn broadcasting off."
				src.on = 0
	else
		src.channel = input("Choose a new channel for device (station default is 1):", "New channel.", channel)
		return

/obj/radio/attack_by(obj/I)
	if(istype(I, /obj/item/tool/screwdriver))
		switch(src.open)
			if(0)
				usr << "\blue You open [src]'s controls."
				src.open = 1
			if(1)
				usr << "\blue You lock [src]'s controls."
				src.open = 0

/obj/radio/station/proc/broadcast(speech)
	if(src.on == 1)
		for(var/obj/wire/battery/W in src.loc)
			if(W.energy > 0)
				W.energy -= 1
				for(var/obj/radio/S in world)
					if(S.channel == src.channel && S.on == 1)
						S.buzz(speech)
			else
				for(var/mob/M in hearers(src))
					if(!M.sleeps)
						M << "[src] buzzes sadly."
	else
		return
/obj/structure/liquid_dispenser
/obj/structure/camera{desc = "A thing for observing locations via Cameras Console."; icon_state = "camera"}
/obj/structure/camera{wrenchable = 1; mine_trigger = 0}
/obj/structure/mine
/obj/structure/shocktrap
/obj/structure/op_bomb{density = 1; closet_ok = 1; anchored = 0; name = "operator-controlled explosive device"; desc = "A bomb. Can be activated by operator. Uh-oh. Also, can be put into a closet."; icon_state = "op_bomb"}
/obj/structure/hellraiser{icon = 'grafon/cult.dmi'; name = "Hellraiser"; icon_state = "hellraiser"; desc = "An artifact of alien nature, this thing allows you to grab some things right from spatial pockets!"};/obj/structure/tray;/obj/structure/beacon{name = "spaceship beacon"; desc = "A beacon used in spasecraft navigation."; icon_state = "beacon"};/obj/structure/teleexp;/obj/structure/slbrkr_tele;/obj/structure/slbrkr_out{alticon = "gtele_off"; name = "bluespace tunnel gate"; desc = "A hole to the so called 'bluespace': one of the many ways to create spartial shortcuts."; icon_state = "slbrkr_space"};/obj/structure/slbrkr_console{name = "teleporter console"; icon_state = "slbrkr_console"};/obj/structure/slbrkr_engine;/obj/structure/noose{icon_state = "noose"; name = "cable noose"; desc = "Oh, Lord loves the hanging!"};/obj/structure/noose{wrenchable = 1};/obj/structure/radioframe{name = "Broadcast Station Frame"; icon_state = "radioframe"; var/stage = 0};/obj/structure/radioframe{wrenchable = 1}
/obj/structure/radioframe/attack_by(obj/I)
	if(src in view(1, usr))
		if(src.stage == 0 && istype(I, /obj/item/electronics/radio))
			usr << "\blue You install some electronics inside the frame."
			src.dir = 10
			src.stage = 1
			usr.delitem()
		else if(src.stage == 0 && istype(I, /obj/item/tool/wrench))
			usr.processing = 1
			usr << "\blue Now deconstructing the frame..."
			spawn(20)
				usr.processing = 0
				new /obj/item/material/radioframe(src.loc)
				spawn(0) del(src)
		else if(src.stage == 1 && istype(I, /obj/item/material/rod))
			usr << "\blue You add an antenna."
			src.dir = 4
			src.stage = 2
			var/M = I
			M:changecharge(-1)
		else if(src.stage == 2 && istype(I, /obj/item/electronics/buzzer))
			usr << "\blue You add a buzzer."
			src.dir = 8
			src.stage = 3
			usr.delitem()
		else if(src.stage == 3 && (istype(I, /obj/item/cable) && usr.processing == 0))
			usr << "\blue You begin to wire up the frame."
			usr.processing = 1
			spawn(50)
				usr.processing = 0
				if((usr in view(1, src)) && istype(usr.item, /obj/item/cable))
					usr << "\blue You wire up the frame."
					src.dir = 6
					src.stage = 4
					var/CB = I
					CB:cminus(1)
		else if(src.stage == 4 && istype(I, /obj/item/material/board))
			usr << "\blue You cover your construction."
			var/M = I
			M:changecharge(-1)
			new /obj/radio/station(src.loc)
			spawn(0)
				del(I)
				spawn(0)
					del(src)



/obj/structure/speaker
	name = "A.S.S."
	desc = "Announcement Speech Synthesiser. An odd device for translating messages in synthesied voice to your fellow comrades."
	icon_state = "a.s.s."
	var/cooldown = 5
	var/last_used = 0
	var/language = "en-us"
/obj/structure/speaker
	wrenchable = 1
/obj/structure/speaker/proc/change_language()
	set src in view()
	if(src.language == "en-us")
		src.language = "ru"
		usr << "Switched to Russian"
	else
		src.language = "en-us"
		usr << "Switched to Bourgeois"

/obj/structure/speaker/attack_hand(mob/user)
	if(src.last_used + src.cooldown > world.time)
		user << "\red Patience, comrade."
		return
	src.last_used = world.time
	var/msg = input(user, "What would you like to announce, comrade?", "A.S.S.") as text
	if(!msg)
		return
	if(length_char(msg) > 100)
		user << "\red Brevity is a sister of talent."
		return
	// eSpeak reads the message from a UTF-8 text file (-b 1 -f) instead of the command line:
	// on Windows, Russian text passed on the command line arrives garbled, and player text
	// inside a shell command could inject extra commands. On Windows the path needs
	// backslashes, or shell() cannot start the program.
	fdel("speech.txt")
	text2file(msg, "speech.txt")
	var/espeak = world.system_type == MS_WINDOWS ? "eSpeak\\command_line\\espeak.exe" : "eSpeak/command_line/espeak"
	shell("[espeak] -b 1 -f speech.txt -w sound.wav -p 30 -s 200 -g 2 -v [src.language]")
	for(var/mob/M in world)
		if(M.client)
			M << sound("sound.wav")
