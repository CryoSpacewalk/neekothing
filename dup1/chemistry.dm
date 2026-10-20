/obj/chemical
	density = 1
	var/channel
	var/amount = 0
	var/class
/obj/item/var/igniter = 0
/obj/chemical/gastank
	icon = 'grafon/structure.dmi'
	wrenchable = 1
	amount = 150
	name = "Gas tank"
	var/cloud = /obj/cloud/prespawned
	var/opened = 0
	var/press = 1
	var/connected = 0
	icon_state = "sgas"
/obj/chemical/gastank/operate(obj/W)
	if(W:energy > 0)
		if(!src.opened)
			src.vent_open()
			usr << "\blue [src] releasement vent opened."
		else
			src.vent_close()
			usr << "\blue [src] releasement vent closed."
		W:energy -= 1
	else
		usr << "\red Not enough energy!"
/obj/chemical/gastank/verb/vent_open()
	set name = "Open vent"

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.opened == 0)
		set src in view(1)
		opened = 1
		spawn(10) release()
/obj/chemical/gastank/verb/vent_close()
	set name = "Close vent"

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.opened == 1)
		set src in view(1)
		opened = 0
/obj/chemical/gastank/verb/changepress()
	set name = "Change releasement pressure"
	set src in view(1)

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	src.pressurechange()
	usr << "\blue You set [src] releasement pressure to [src.press]."
/obj/chemical/gastank/proc/connector_feed(obj/P)
	if(src.connected == 1)
		switch(src.class)
			if("cl")
				if(src.press <= src.amount)
					P:add("cl", src.press, 0)
					src.amount -= src.press
				else
					P:add("cl", src.amount, 0)
					src.amount = 0
			if("tox")
				if(src.press <= src.amount)
					P:add("tox", src.press, 0)
				else
					P:add("tox", src.amount, 0)
					src.amount = 0
			if("smk")
				if(src.press <= src.amount)
					P:add("smk", src.press, 0)
					src.amount -= src.press
				else
					P:add("smk", src.amount, 0)
					src.amount = 0
			if("fuel")
				if(src.press <= src.amount)
					P:add("fuel", src.press, 0)
					src.amount -= src.press
				else
					P:add("fuel", src.amount, 0)
					src.amount = 0
			if("anti")
				if(src.press <= src.amount)
					P:add("anti", src.press, 0)
					src.amount -= src.press
				else
					P:add("anti", src.amount, 0)
					src.amount = 0
			if("regen")
				if(src.press <= src.amount)
					P:add("regen", src.press, 0)
					src.amount -= src.press
				else
					P:add("regen", src.amount, 0)
					src.amount = 0
		spawn(10) src.connector_feed(P)
	else
		return

/obj/chemical/gastank/proc/release()
	if(src.amount >= src.press)
		for(var/count = 0, count < src.press, count++)
			new src.cloud(src.loc)
			amount -= 1
			sleep(0)
		if(src.amount > 0 && src.opened == 1)
			spawn(10) src.release()
		else
			return
	else
		for(var/count = 0, count < src.amount, count++)
			new src.cloud(src.loc)
			amount -= 1
			sleep(0)
		if(src.amount > 0 && src.opened == 1)
			spawn(10) src.release()
		else
			return

/obj/chemical/gastank/proc/pressurechange()
	if(src.press < 7)
		src.press += 1
	else
		src.press = 1

/obj/chemical/attack_by(obj/item/I)
	if(istype(I, /obj/item/device/signaler) && (src.channel == null && !istype(I, /obj/item/device/signaler/adv)))
		usr << "\blue You apply your [I] to the [src]."
		src.channel = I:charges
		spawn(0) del(I)
	else if(istype(I, /obj/item/tool/screwdriver) && !(src.channel == null))
		usr << "\blue You remove the signaler from [src]."
		var/S = new /obj/item/device/signaler(src.loc)
		S:charges = src.channel
		src.channel = null
		return
	else if(istype(I, /obj/item/tool/torch) && (istype(src, /obj/chemical/gastank/fuel) || istype(src, /obj/chemical/gastank/portable/fuel)))
		if(I:charges < 6)
			if(src.amount < 6 - I:charges)
				I:fuel(src.amount)
				spawn(0) src.amount = 0
			else
				src.amount -= 6 - I:charges
				I:fuel(6 - I:charges)
			usr << "\green You refill [I]."
		else
			usr << "\red [I] fuel storage is full!"
	else if(istype(I, /obj/item/gas/tank))
		src.tanktransfer(I, usr)
	else if(istype(I, /obj/item/weapon/spray))
		var/S = I
		src.tanktransfer(S:tank, usr)
	else if(istype(I, /obj/item/tool/wrench) && istype(src, /obj/chemical/gastank/portable))
		var/GT = src
		for(var/obj/machine/gas/pipealike/pipe/connector/P in GT:loc)
			if(P)
				if(GT:connected == 0)
					GT:connected = 1
					GT:anchored = 1
					GT:break_pull()
					usr << "You connect [GT] to [P]."
					spawn(0) GT:connector_feed(P)
				else
					GT:connected = 0
					GT:anchored = 0
					usr << "You disconnect [GT] from [P]."

/obj/chemical/proc/tanktransfer(obj/T, mob/user)
	var/sum = T:cl + T:smk + T:tox + T:fuel + T:anti + T:regen
	if(sum < 7 && (src.amount > 0 && src.class))
		user << "You load your [T] with some of the contents of [src] ."
		T:add(src.class, 1, 0)
		src.amount -= 1




/obj/chemical/filter
	density = 0
	layer = 2.2
	icon = 'grafon/structure.dmi'
	name = "Gas filter"
	desc = "A thing which removes gases from atmosphere."
	icon_state = "filter"
	var/iconka = "filter"
	var/on = 0
	var/value = 250











































































































	var/targets = list("cl", "tox", "smk", "anti", "fuel", "regen")

/obj/chemical/filter
/obj/chemical/filter/attack_hand()
	if(!usr.candofun)
		usr << "\red NO"
		return
	if(src.on == 0)
		on = 1
		icon_state = "[iconka]_on"
		spawn(10) filt()
	else
		on = 0

/obj/chemical/filter/verb/turnon()
	set name = "Turn filter on/off"
	set src in view(1)

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(on == 0)
		src.on = 1
		src.icon_state = "[src.iconka]_on"
		spawn(10) src.filt()
	else
		src.on = 0

/obj/chemical/filter/operate(obj/item/W)
	if(W:energy > 0)
		attack_hand()
		W:energy -= 1

/obj/chemical/filter/proc/filt()
	for(var/obj/cloud/C in src.loc)
		if(C.id in src.targets)
			del(C)
			src:value -= 1
	for(var/obj/steam/S in src.loc)
		del(S)
		src:value -= 1
	if(src:value > 0 && src.on == 1)
		spawn(5) src.filt()
	else if(src:value > 0)
		icon_state = "[iconka]"
		return
	else if(src.anchored && src.layer < 3)
		src.icon_state = "filter_full"
		return
	else
		src.icon_state = "filter_port_full"
		return


/obj/chemical/filter/selective
	name = "selective gas filter"
	iconka = "filter_s"
	targets = list("tox")
	icon_state = "filter_s"
/obj/chemical/filter/selective/attack_hand()
	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	switch(alert("Turn it on/off or change its settings?", , "Setup", "On/Off"))
		if("Setup")
			if(usr in range(1, src))
				switch(input("Select gas to filter:", , "toxin") in list("toxin", "gas fuel", "chlorine", "burn product", "regenerite", "antidote"))
					if("toxin")
						src.targets = null
						spawn(0) src.targets = list("tox")
					if("gas fuel")
						src.targets = null
						spawn(0) src.targets = list("fuel")
					if("chlorine")
						src.targets = null
						spawn(0) src.targets = list("cl")
					if("burn product")
						src.targets = null
						spawn(0) src.targets = list("smk")
					if("regenerite")
						src.targets = null
						spawn(0) src.targets = list("regen")
					if("antidote")
						src.targets = null
						spawn(0) src.targets = list("anti")
		else
			src.turnon()
