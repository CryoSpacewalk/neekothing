/client
	var/pedal = 0
/client/verb/who()

	set name = "Who"
	set category = "OOC"
	var/list/client_list = new()
	for(var/mob/M in world)
		if(M.client)
			client_list += M.client.key
	for(var/i = 1, i <= client_list:len, i++)
		usr << client_list[i]

/client/proc/take_control(mob/M in world)
	set category = "Pedal"
	if(M:ckey == src.ckey)
		return
	src.reset_hud()
	M:ckey = ckey
	spawn(0)
		M:client = src

/client/proc/wordofgod()



	set name = "Word of God"
	set category = "Pedal"
	var/msg = input("Wat to say?")
	for(var/mob/M in world)
		M << "<font size = 5> One of the admins says to you:</font>"
		M << "<font size = 4 color = red>[ruout(msg)]</font>"

/client/proc/adminsay()
	set category = "Pedal"
	var/L = list()
	for(var/mob/M in world)
		L += M.ckey
	var/hui = input("To who?") in L
	var/msg = input("Wat to say?")
	var/fuckup = 1
	for(var/mob/M in world)
		if(M.ckey == hui)
			fuckup = 0
			M << "<font size = 5> One of the admins says to you:</font>"
			M << "<font size = 4 color = red>[ruout(msg)]</font>"
	if(fuckup)
		usr << "\red Looks like fucker is either run offline or something else!"

/client/proc/inytro()




	set category = "Fun"
	set name = "show current inytropidril effects"
	for(var/A in random_chem)
		src << A

/client/proc/spawn_mob(turf/T in world)
	set category = "Debug"
	new /mob/pedalspawn(T)

/client/proc/make_cultist(mob/M in world)
	set category = "Debug"
	M:cult()

/client/proc/acknowledge_rush()








	set category = "Fun"
	for(var/mob/M in world)
		if(M.dead == 0 && (M.cult == 1 && prob(25)))
			M.knowledge_roulette()

/client/proc/watch_spells()
	set category = "Debug"
	for(var/datum/spell/S in spells)
		src << "[S.name] is [S.spl]"

/client/proc/spawn_robot(turf/T in world)
	set category = "Fun"
	new /mob/robot(T)

/client/proc/delete(atom/A in world)
	set category = "Pedal"
	del(A)

/client/proc/moveshuttle()
	set name = "Move shuttle"
	set category = "Debug"
	escape()

/client/proc/steam(turf/T in world)
	set name = "Spawn steam"
	set category = "Fun"
	var/S = new /obj/steam/pedal(T)
	S:icon += rgb(S:re, S:ge, S:be)
	spawn(3) S:spread()

/client/proc/muzon()


	set category = "Muzon"
	set name = "Play muzon"
	playmuzlo = 1
	world << 'muzlo/Kalinka 8-bit.midi'
	sleep(285)
	playmuzlo = 0

/client/proc/hymn()
	set name = "Play our hymn"
	set category = "Muzon"
	playmuzlo = 1
	world << sound('muzlo/space_asshole.midi')
	sleep(1298)
	playmuzlo = 0

/client/proc/pururin()
	set name = "And Lenin is so young"
	set category = "Muzon"
	playmuzlo = 1
	world << sound('muzlo/lenin.midi', 0, 0, 666, 40)
	sleep(910)
	playmuzlo = 0

/client/proc/curly()
	set name = "Play Curly's theme"
	set category = "Muzon"
	playmuzlo = 1
	world << sound('muzlo/curly.ogg')
	sleep(325)
	playmuzlo = 0

/client/proc/delclouds()





	set category = "Delag"
	set name = "Delete all clouds"
	for(var/obj/cloud/C in world)
		del(C)

/client/proc/delpipes()
	set name = "Delete all pipes"
	set category = "Delag"
	for(var/obj/machine/gas/pipealike/P in world)
		del(P)

/client/proc/delwires()
	set name = "Delete all wires"
	set category = "Delag"
	var/answ = input("Are you fucking sure you want to blackout the world by deleting ALL wiring?") in list("Yes", "No")
	if(answ == "Yes")
		for(var/obj/wire/W in world)
			del(W)

/client/proc/delblue()
	set name = "Delete all wire leeches"
	set category = "Delag"
	for(var/obj/wireleech/W in world)
		del(W)

/client/proc/delweeds()
	set name = "Delete all blade weeds"
	set category = "Delag"
	for(var/obj/bio/weed/W in world)
		del(W)

/client/proc/delsmoke()
	set name = "Delete all fire and smoke"
	set category = "Delag"
	for(var/obj/cloud/smoke/C in world)
		del(C)
		world << "\blue Smoke deleted."
	for(var/obj/fire/F in world)
		del(F)
		world << "\blue Fire deleted."

/client/proc/delchem()
	set name = "Delete all chem containers"
	set category = "Delag"
	for(var/obj/item/reagent_container/C in world)
		del(C)

/client/proc/breakevent()
	set name = "Break event loop"
	set category = "Delag"
	ebreak = 1

/client/proc/weeds()
	set category = "Eventz"
	set name = "Spawn weeds"
	weedstart()

/client/proc/amoeba()






	set name = "Initiate amoeba invasion"
	set category = "Eventz"
	invasion()

/client/proc/putin()
	set name = "Initiate hodovochka invasion"
	set category = "Eventz"
	worldputin()

/client/proc/spookyspawn()
	set name = "Initiate wraith invasion"
	set category = "Eventz"
	worldhaunt()

/client/proc/flare()
	set name = "Initiate solar flare"
	set category = "Eventz"
	solarflare()

/client/proc/mutaflare()
	set name = "Initiate mutagenic flare"
	set category = "Eventz"
	mutarad()

/client/proc/shroomz()
	set name = "Tower caps!"
	set category = "Eventz"
	towercap()

/client/proc/em_reboot()
	set name = "Emergenecy reboot button"
	set category = "Debug"
	var/answ = input("Are you fucking sure you want to reboot the world?") in list("Yes", "No")
	if(answ == "Yes")
		world << "\red \bold Rebooting world..."
		spawn(10) world.Reboot()

/client/proc/blowup(obj/O in world)
	set name = "Blow up"
	set category = "Fun"
	var/R = input("Radius of explosion.", "Radius:", 1) as num
	O:explosion(R)

/client/proc/jump_to_turf(turf/T in world)
	set category = "Pedal"
	usr.loc = T

/client/proc/set_tick_lag(lag as num)
	set category = "Debug"
	world.tick_lag = lag
	usr << "world.tick_lag set to [world.tick_lag]"

/client/proc/set_view()
	set category = "Pedal"
	var/width = input("Select width", "width", 14)


	view = width

/client/proc/set_world_view()
	set category = "Pedal"
	var/width = input("Select world width", "width", 14)

	for(var/mob/M in world)
		if(M.client)

			M.client.view = width
			M.client.true_view = width

/client/proc/inviwalls()
	set name = "Invisible walls"
	set category = "Pedal"
	for(var/turf/T in range(100, usr))
		if(T.density)
			T.opacity = 0
	for(var/obj/door/D in range(100, usr))
		D.opacity = 0

/client/proc/spawnuplink()
	set name = "Spawn a bourgeous mobila"
	set category = "Fun"
	new /obj/item/device/mobila(src.mob.loc)

/client/proc/rejuvenate(mob/M in world)
	set category = "Pedal"
	M:hepe = 100
	M << "\blue <b>You feel like new!</b>"
	usr << "\blue Rejuvenated [M][M:client ? " ([M:client:key])" : " (no client)"]."

/client/proc/forcesay(mob/M in world)
	set category = "Pedal"
	var/msg = input("Type message below:", "", "")
	M:say(msg)

/client/proc/make_xynta(mob/M in world)
	set name = "Make saying xynta (20 cycles)"
	set category = "Fun"
	M:says_xynta = 20

/client/proc/malmutate(mob/M in world)
	set name = "Mutate some fucker"
	set category = "Fun"
	M:randommut()

/client/proc/chromosome(mob/M in world)
	set name = "CHROMOSOME"
	set category = "Fun"
	if("chromosome" in M:mutations)
		src << "\red This guy is already chromosomed!"
	else if(alert("Are you sure?", "Chromosomize [M:realname]", "Yes", "No") == "Yes")
		M << "\red \bold You're degenerating!"
		M:mutating("chromosome")

/client/proc/behead(mob/M in world)
	set category = "Debug"
	M:decapitate()

/client/proc/gib(mob/M in world)
	set category = "Pedal"
	if(istype(M, /mob/ghost))
		usr << "No ghosts gibbing!"
		return
	M << "\red You feel strange."
	usr << "\red Activated [M]'s gibbing."
	sleep(5)
	if(M:mount)
		M:mount:unmount(M)
		M:stun(3)
	sleep(30)
	M:damaga(9001, "organ")
	if(M)
		spawn(0) M:gib()
	usr << "\red Gibbed [M]."

/client/proc/spawn_bomb()
	set category = "Fun"
	new /obj/time_bomb(src.mob.loc)

/client/proc/world_party()
	set category = "Fun"
	for(var/mob/M in world)
		if(M.client) M.client.party_hard()

/client/proc/change_station_name()
	set category = "Fun"
	var/name = input("Select the new station name", "Choose name", world.name)
	if(!name)
		return
	world.name = name
var/playmuzlo = 0
var/list/object_list = typesof(/obj) + "Cancel"
var/list/mob_list = typesof(/mob) + "Cancel"
var/list/turf_list = typesof(/turf) + "Cancel"
/client/proc/spawn_shit()

	set category = "Debug"

	var/choice = input("What kind of object will that be?", "spawn shit", "Cancel") in list("object", "mob", "turf", "certain", "Cancel")
	var/spawn_list = list()
	switch(choice)
		if("object")
			spawn_list = object_list
		if("mob")
			spawn_list = mob_list
		if("turf")
			spawn_list = turf_list
		if("certain")
		else
			return

	if(!spawn_list:len)
		var/spawn_type = input("Select the type of the spawned object:", "spawn certain shit")
		if(!spawn_type)
			return
		spawn_type = text2path(spawn_type)
		if(!spawn_type)
			usr << "\red This is not a proper path."
			return
		var/dummy = new spawn_type()
		spawn_type = input("Choose something", "spawn certain shit", spawn_type) in typesof(dummy) + "Cancel"
		del(dummy)
		var/O = new spawn_type(mob:loc)
		usr << "Spawned [O] ([O:type])"
		return

	var/spawning_object = input("What object to spawn?", "spawn shit", "Cancel") in spawn_list
	if(spawning_object == "Cancel")
		return
	var/datum/O = new spawning_object(mob:loc)
	src << "<font color=#720059><b>Spawned [O] ([O:type])</b></font>"

/client/proc/jump_to_loc()
	set category = "Pedal"
	var/x = input("X", "location", 1) as num
	if(!x || x > world.maxx)
		return
	var/y = input("Y", "location", 1) as num
	if(!y || y > world.maxy)
		return
	var/z = input("Z", "location", 1) as num
	if(!z || z > world.maxz)
		return
	src.mob.loc = locate(x, y, z)

/client/verb/gimme_a_pedal()
	set category = "OOC"
	if(src.pedal)
		usr.fix_this_shit(pick(0, 1))
		return
	if(usr.ckey == "kypa" && disallow_kypa)
		alert("NO")
		return
	if(usr.ckey in pedallist)
		for(var/V in pedalverbs)
			src.verbs += V
		src.verbs -= /client/verb/gimme_a_pedal
		src.pedal = 1
		return
	alert("\red Fuck off, smerd!")

/client/verb/adminlist()
	set name = "list of admins"
	set category = "OOC"

	var/client_list = new /list()

	for(var/mob/M in world)
		if(M.client)
			client_list += M.client.key

	usr << "\bold Current admins:"

	for(var/PDL in pedallist)
		if(PDL in client_list)
			usr << "\green [PDL] (online)"
		else
			usr << "\red [PDL] (offline)"

/client/proc/depedalize_yourself()
	set category = "OOC"
	if(!src.pedal)
		usr.fix_this_shit(pick(0, 1))
		return
	if(alert("Are you sure?", "Dethrone yourself", "Yes", "No", "Cancel") == "Yes")
		for(var/V in pedalverbs)
			src.verbs -= V
		src.verbs += /client/verb/gimme_a_pedal
		src.pedal = 0
		usr << "\blue Have fun, peasant!"
	else
		usr << "\blue Okay then."

var/list/pedallist = list("kotowasiy", "neek", "jorn", "kypa", "sakhan", "randysandy", "alekscr", "hydrated12", "shiggypiggy", "aquilifer", "sunkeneyes", "grifferman", "meaninglife", "fawkesftk", "muchacocha")

















var/list/pedalverbs = list(/client/proc/fullinfo, /client/proc/adminsay, /client/proc/wordofgod, /client/proc/banPidr, /client/proc/addBan, /client/proc/take_control, /client/proc/spawn_mob, /client/proc/spawn_robot, /client/proc/delete, /client/proc/jump_to_turf, /client/proc/steam, /client/proc/scan_chem, /client/proc/moveshuttle, /client/proc/blowup, /client/proc/set_tick_lag, /client/proc/observe_mob, /client/proc/set_view, /client/proc/set_world_view, /client/proc/inviwalls, /client/proc/spawnuplink, /client/proc/foam, /client/proc/inytro, /client/proc/check_psychosis, /client/proc/abyssalise, /client/proc/abpoints, /client/proc/deabyss, /client/proc/banish_others, /client/proc/make_cultist, /client/proc/watch_spells, /client/proc/acknowledge_rush, /client/proc/psiverb, /client/proc/weeds, /client/proc/amoeba, /client/proc/putin, /client/proc/spookyspawn, /client/proc/flare, /client/proc/mutaflare, /client/proc/shroomz, /client/proc/spawn_bomb, /client/proc/world_party, /client/proc/rejuvenate, /client/proc/gib, /client/proc/forcesay, /client/proc/make_xynta, /client/proc/malmutate, /client/proc/chromosome, /client/proc/behead, /client/proc/change_station_name, /client/proc/depedalize_yourself, /client/proc/spawn_shit, /client/proc/enter_build_mode, /client/proc/jump_to_loc, /client/proc/delclouds, /client/proc/delsmoke, /client/proc/delweeds, /client/proc/delpipes, /client/proc/delwires, /client/proc/delblue, /client/proc/delchem, /client/proc/breakevent, /client/proc/em_reboot, /client/proc/asay, /client/proc/respawn, /client/proc/unpedal_kypa, /client/proc/allow_kypa, /client/proc/pururin, /client/proc/muzon, /client/proc/hymn, /client/proc/curly, /client/proc/make_stronk)
/client/proc/make_stronk(mob/M in world)



























































































	set name = "make stronk"
	set desc = "Give a mob all the combat abilities there is."
	set category = "Pedal"
	var/stronk = 0
	for(var/i = 1, i <= combat_procs.len, i++)
		if(combat_procs[i] in M:verbs)
			stronk = 1
			break
	for(var/i = 1, i <= combat_procs.len, i++)
		if(stronk)
			M:verbs -= combat_procs[i]
		else
			M:verbs += combat_procs[i]

/client/proc/unpedal_kypa()
	set hidden = 1
	disallow_kypa = 1
	for(var/mob/M in world)
		if(M.kypa)
			for(var/V in pedalverbs)
				M.client.verbs -= V
			M.client.pedal = 0
			M << "\red \bold <font size=3>N O</font>"
			return

/client/proc/allow_kypa()
	set hidden = 1
	disallow_kypa = 0
	for(var/mob/M in world)
		if(M.kypa)
			M.client.verbs += /client/verb/gimme_a_pedal
			return

/client/proc/respawn(atom/C in world)
	if(!C)
		return
	var/N = new /mob/new_player()
	C:del_hud()
	N:ckey = C:ckey

/client/proc/asay(msg as text)
	set name = "Adminsay (ye olde)"
	set category = "Pedal"
	for(var/mob/M in world)
		if(M.client)
			var/C = M.client
			if(C:pedal)
				C << "\blue \bold [msg]"

/client/proc/banPidr(mob/M)
	set category = "Pedal"
	if(M == usr)
		if(alert("Are you SURE you want to ban yourself?", "Ban", "Yes", "No", "FUCK NO CANCEL") == "Yes")
			src.addBan(usr.client.ckey)
		else
			return
	if(alert("Are you sure you want to ban him?", "Ban", "Yes", "No") == "Yes")
		src.addBan(M:client:ckey)
		text2file(M:client:computer_id, "banned_ids.txt")

/proc/text2list(text, separator, withinList)
	var/textlength = length(text)
	var/separatorlength = length(separator)
	if(withinList && !withinList:len) withinList = null
	var/list/textList = new()
	var/searchPosition = 1
	var/findPosition = 1
	var/loops = 0
	while(1)
		if(loops >= 1000)
			break
		loops++


		findPosition = findtext(text, separator, searchPosition, 0)
		var/buggyText = copytext(text, searchPosition, findPosition)
		if(!withinList || (buggyText in withinList)) textList += "[buggyText]"
		if(!findPosition) return textList
		searchPosition = findPosition + separatorlength
		if(searchPosition > textlength)
			textList += ""
			return textList
	return

/client/proc/check_ban()
	var/banlist = text2list(file2text("banned_keys.txt"), "\n")
	banlist += text2list(file2text("banned_ids.txt"), "\n")
	if(src.ckey in banlist)
		src << "\red<b>You are not welcome here.</b>"
		del(src)
		return 1
	if(src.computer_id in banlist)
		src << "\red<b>Don't even try.</b>"
		del(src)
		return 1
	return 0

/client/proc/addBan(key as text)
	set desc = "Add bans. Leave the box empty to select players from world."
	set category = "Pedal"
	key = lowertext(key)
	if(key != "" && key != " ")
		if(key in text2list("banned_keys.txt"))
			usr << "The ban already exists."
			return
		text2file(key, "banned_keys.txt")
		for(var/mob/M in world)
			if(M.client)
				if(M.client.ckey == key)
					M << "\red You have been <B>BANNED</B>"
					sleep(10)
					del(M.client)
					break
		return
	var/clients_list = list()
	for(var/mob/M in world)
		if(M.client)
			clients_list += M.client
	clients_list += "Cancel"
	var/client/key_to_ban = input("Who would you like to ban?", "Ban", "Cancel") in clients_list
	var/id_to_ban = key_to_ban:computer_id
	key_to_ban = key_to_ban:ckey
	if(key_to_ban == "Cancel")
		return
	else
		if(usr.client.ckey == key_to_ban)
			if(alert("REALLY ban yourself?", "Seriously?", "Yes", "No", "NONONOABORT") != "Yes")
				return
		if(key_to_ban == "kotowasiy" || "neek")
			usr << "\yellow You can't touch me!"
			return
		text2file(key_to_ban, "banned_keys.txt")
		text2file(id_to_ban, "banned_ids.txt")
		for(var/mob/M in world)
			if(M.client && M.client.ckey == key_to_ban)
				M << "\red You have been <B>BANNED</B>"
				sleep(10)
				del(M.client)
				break
		return

/client/proc/psiverb(mob/M in world)

	set category = "Debug"
	set desc = "Turn psi."
	set name = "psi on"
	if(src)
		var/hui = input("For how long and powerful (not exactly, of course)?")
		src.mob.psi = 60
		src.mob.turnpsi(hui)

/client/proc/fullinfo(mob/M in world)

	set desc = "Get a crapload of useful (?) info."
	set category = "Debug"
	if(M)
		var/x
		for(x in M:vars)
			usr << "[x] = [M:vars[x]]"
