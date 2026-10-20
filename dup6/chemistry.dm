
































































































































































































































































































































































































/obj/steam{icon = null; icon = 'grafon/effects/chemistry.dmi'; var/amount = 0; var/temp = 0; icon_state = "steam"; var/clock = 0; var/re = 255; var/ge = 255; var/be = 255; var/chemicals_carried = list()}

/obj/steam/proc/initiate()




	src.icon += rgb(src:re, src:ge, src:be)
	sleep(2)
	src.spread()

/obj/steam/proc/spread()

	src.clock -= 1
	for(var/turf/TE in range(0, loc))
		for(var/datum/reagent/R in src.chemicals_carried)
			if(prob(80))
				R.on_turf(TE, src.temp)
	for(var/mob/M in src.loc)
		if(M)
			if(prob(10 - M.chemprotect) || M.chemprotect + round(M.heatprotect / 8) < src.amount)
				for(var/datum/reagent/R in src.chemicals_carried)
					R.on_touch(round(R.amount / 2), M, "all")
					if(prob(70) && M.chemprotect * 5 < R.amount)
						M.add_chem(R.name, R.id, round(R.amount / 5) - M.chemprotect, src.temp)
					if(prob(80) && src.temp > round(M.heatprotect / 1.5))
						M << "\red DAMN, IT IS HOT!"
						M.damaga(src.temp - round(M.heatprotect / 1.5), "burn")
	spawn(0)
		for(var/turf/T in orange(1, src.loc))
			var/yea = 1
			for(var/obj/steam/S in T)
				if(S)
					yea = 0
			if(!T.airtight && (src.clock > 0 && yea))
				var/S = new /obj/steam(T)
				postinitiate(S, src)
		spawn(0)
			if(src.clock > 0)
				spawn(2) src.spread()
			else
				spawn(0) del(src)
/obj/steam/pedal
	amount = 20
	temp = 3
	clock = 5
	re = 0
	ge = 0
	be = 255
/obj/steam/pedal
/obj/steam/pedal/New()
	var/R = new /datum/reagent()
	R:id = "aqua regia"
	R:name = R:id
	R:amount = 20
	spawn(0)
		src.chemicals_carried += R
		spawn(0) src.initiate()



/obj/chemical/sensor
	layer = 2.2
	var/broken = 0
	var/opened = 0

/obj/chemical/sensor
	bomb_proof = 15

/obj/chemical/sensor/operate(obj/W)













































































































































	if(W:energy > 0)
		var/method = input("What to do?", "", "Alarm") in list("Alarm", "Fix", "Disable", "Open controls")
		switch(method)
			if("Alarm")
				src.lockdown()
			if("Fix")
				usr << "\blue [src.name] re-enabled."
				broken = 0
			if("Disable")
				usr << "\red [src.name] disabled."
			if("Open controls")
				usr << "\blue [src.name]'s wires exposed."
				opened = 1
				overlays += /obj/overlay/sensor
		W:energy -= 1
	else
		usr << "\red Not enough energy!"
/obj/chemical/sensor/fire{density = 0; icon = 'grafon/structure.dmi'; name = "Fire sensor"; desc = "A floor-mounted sensor which detects fire and closes fire-proof airlocks then."; icon_state = "sensor"};/obj/chemical/sensor/fire{anchored = 1}
/obj/chemical/sensor/attack_by(obj/I)
	if(istype(I, /obj/item/tool/screwdriver) && src.broken == 0)
		if(src.opened == 0)
			usr << "\blue You pry [src]'s wiring open."
			src.opened = 1
			src.overlays += /obj/overlay/sensor
		else
			usr << "\blue You hide [src]'s wiring."
			src.opened = 0
			src.overlays = null
	else if((istype(I, /obj/item/tool/wirecutters) || istype(I, /obj/item/tool/hydraulic_cutters)) && (src.opened == 1 && src.broken == 0))
		usr << "\blue You cut [src]'s wires."
		src.broken = 1
		src.overlays = null

/obj/chemical/sensor/gas
	density = 0
	icon = 'grafon/structure.dmi'
	name = "Gas sensor"
	desc = "A floor-mounted sensor which detects dangerous gases and closes gas-proof airlocks then."
	icon_state = "sensor_green"

/obj/chemical/sensor/gas
	anchored = 1
/obj/chemical/sensor/proc/lockdown()







	if(src.broken == 0)
		for(var/obj/door/airlock/A in range(1, src))
			A.closed()
		for(var/mob/M in hearers(src))
			if(!M.sleeps)
				M << "\red WHEEEEEEW WHEEEEEEEW"

/obj/chemical/button
	density = 0
	layer = 3.1
	icon = 'grafon/structure.dmi'
	icon_state = "button"
	name = "Gas alarm button"

/obj/chemical/button
	anchored = 1
/obj/chemical/button/attack_hand()




	if(!usr.candofun)
		usr << "\red NO"
		return
	for(var/obj/chemical/filter/F in range(5, src))
		if(F.on == 0)
			F.on = 1
			F.icon_state = "[F.iconka]_on"
			spawn(10) F.filt()
	for(var/obj/door/airlock/A in range(5, src))
		A.closed()
	for(var/obj/machine/gas/pipealike/pipe/pump/P in range(5, src))
		if(P.on == 0)
			P.on = 1
			P.icon_state = "pump_on"
			P.suck()



/obj/set_tripwire/New()













































































































































	new /obj/overlay/trap_marker(src.loc)
/obj/set_tripwire/prespawned
/obj/set_tripwire/prespawned
/obj/set_tripwire/Crossed(atom/A)
	if(istype(A, /mob) && (!istype(A, /mob/ghost) && !istype(A, /mob/ghostalike)) || (istype(A, /obj/bio/amoeba) || (istype(A, /obj/bio/toad) || (istype(A, /obj/bio/bumblebee) || (istype(A, /obj/bio/tick_swarm) || istype(A, /atom/movable) && A:density > 0)))))

		if(istype(A, /mob))
			A << "\red \bold You have triggered tripwire! FUCKFUCKFUCKFUCKBLYAT"

		for(var/obj/overlay/trap_marker/T in src.loc)
			del(T)

		TNK:loc = src.loc
		spawn(0)
			src:TNK:heat += 5
			src:TNK:inner_burn()
			spawn(0) del(src)
/obj/set_tripwire/prespawned


	TNK = new /obj/item/gas/tank/fuel/deathsquad
