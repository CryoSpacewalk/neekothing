// Recovered from compiled neek.dmb (27 procs)

/obj/start
	invisibility = 101
	icon = 'player/start.dmi'
	icon_state = "spawn"
	name = "spawn"

/obj/start

/obj/singulo
	density = 1
	icon = 'grafon/singulo.dmi'
	name = "Swastika engine"
	icon_state = "sing"
	desc = "A literal piece of demon which can be feed with energy stuff such as blaster shots. You better be careful with this thing."
	var/energy = 0

/obj/singulo
	anchored = 0
/obj/singulo/New()
	..()
	sd_SetLuminosity(3)
/obj/singulo/stalin
	density = 0
	icon = 'grafon/perun.dmi'
	energy = 9000
	icon_state = "stalin"
	name = "Stalin"
	desc = "Comrade Stalin avatara as it is."
/obj/singulo/stalin
/obj/singulo/stalin/New()
	if(!("Infernal Stalin" in csecond))
		csecond += "Infernal Stalin"
	src.sd_SetLuminosity(10)
	spawn(0) src.Perunrage()

/obj/singulo/Cross(mob/M)
	if(src.energy > 40)
		if(M:hepe > 0)
			M:damaga(90, "burn")

/obj/singulo/Cross(W)
	if(istype(W, /obj/lazor))
		if(!(src.name == "Perun"))
			if(src.energy == 0)
				src.energy = 3

				sd_SetLuminosity(1)
				src.density = 1
				src.icon = 'grafon/singulo.dmi'
				transfer()
			else if(src.energy < 15)
				src.energy += 5
			else if(src.energy < 30)
				src.icon_state = "sing"
				src.energy += 2
				spawn(20) src.icon_state = "dead"
			else

				if(!("Slavic" in cfirst))
					cfirst += "Slavic"
				if(!("Perun" in csecond))
					csecond += "Perun"

				src.energy = 150
				sd_SetLuminosity(10)

				src.density = 0
				src.name = "Perun"
				src.icon = 'grafon/perun.dmi'
				src.icon_state = "singulo"
				src.alticon = "singulo_perun1"
				src.Perunrage()
		del(W)
		return

/obj/singulo/proc/Perunrage()
	if(prob(20))

		for(var/mob/M in view(src))
			M << "\red [src]'s eyes flashes with rageful\blue lightnings!"
			src.harm(8)

	for(var/mob/ghost/M in view(src))
		M << "\red \bold This thing's power is too much for you to bear!"
		M.smartblink(50, 49, src.loc)

	for(var/turf/wall/T in range(6, src.loc))
		T.remove()

	if(prob(20))
		for(var/obj/structure/reinforcement/R in range(8, src.loc))
			R.damage(30)

	for(var/obj/structure/window/Wi in range(8, src.loc))
		if(Wi.hardcore > 0)
			Wi.damage(8)

	for(var/turf/floor/regular/F in range(2, src.loc))
		F.spacize()

	if(prob(50))
		src.loc = locate(src.x + pick(-1, 0, 1), src.y + pick(-1, 0, 1), src.z)

	src.energy -= 1
	if(src.energy > 0)
		spawn(25) Perunrage()
	else

		src.explosion(5)
		spawn(0)
			if(src)
				del(src)


/obj/singulo/proc/transfer()
	for(var/obj/machine/solar/S in range(4, src))
		if(src.energy > 0 && prob(src.energy * 15))
			S.feed(75)
			if(prob(90))
				src.energy -= 1
			if(prob(33))
				src.harm(4)
			if(src.energy > 40)
				return
			else if(src.energy > 5)
				src.icon_state = "sing"
			else
				spawn(30) transfer()
		else
			src.icon = 'grafon/singulo.dmi'
			src.icon_state = "dead"
			density = 0

/obj/singulo/proc/harm(rangy)

	for(var/mob/M in range(rangy, src))
		if(M.mat == "flesh")
			if(M.energyprotect < src.energy && M.hepe > 0)
				M << "\red You feel a bit nervous..."
				M.damaga(src.energy - M.energyprotect, "burn")
				M.radtox += 10

				if(prob(M.epilepsy * 3) && M in viewers(src))
					M.seizure(10)

				if(M.energyprotect < 10 && prob(33))
					M << "\red The world is so blurry..."
					M.epilepsy += 4
		else
			if(!istype(M, /mob/ghost))
				M << "\red You feel a bit nervous..."
				M.damaga(80, "burn")

	for(var/obj/putin/P in range(rangy, src))
		P.biodmg(src.energy)

	for(var/obj/putin_big/P in range(rangy, src))
		P.biodmg(src.energy)

	for(var/obj/bio/amoeba/A in range(rangy, src))
		A.biodmg(src.energy)

	for(var/obj/bio/weed/W in range(rangy, src))
		W.grassdmg(src.energy)

/obj/lamp
	layer = 4.1
	icon = 'grafon/light.dmi'
	var/fucked = 0
	icon_state = "off"
	alticon = "gcommon"
	var/tough = 5

/obj/lamp
/obj/lamp
/obj/lamp/attack_by(obj/I)
	if(istype(I, /obj/item/reagent_container/cig))

		if(fucked)
			usr << "\red This lamp is fucked up!"
			return

		if(!src.luminosity)
			usr << "\red This lamp is off!"
			return

		var/C = I
		C:smoke(usr)
	else


		usr.show_message("\red \bold [usr.name] breaks the lamp.", "\red You break the lamp.")
		src.fuckup()

/obj/lamp/proc/turnon()
	if(src.luminosity == 0 && !(src.fucked == 1))
		if(!istype(src, /obj/lamp/floor))
			if(istype(src, /obj/lamp/lava))
				src.sd_SetLuminosity(2)
			else if(!istype(src, /obj/lamp/strong))

				src.sd_SetLuminosity(2)
				icon_state = "common"
			else

				src.sd_SetLuminosity(6)
				icon_state = "strong"
		else

			src.sd_SetLuminosity(2)
			icon_state = "floor"
		for(var/mob/M in viewers(src))
			if(prob(M.epilepsy))
				M.seizure(9)

/obj/lamp/proc/turnoff()
	if(src.luminosity > 0 && !(src.fucked == 1))
		if(!istype(src, /obj/lamp/floor))
			if(istype(src, /obj/lamp/lava))
				src.sd_SetLuminosity(0)
			else if(!istype(src, /obj/lamp/strong))

				src.sd_SetLuminosity(0)
				icon_state = "off"
			else

				src.sd_SetLuminosity(0)
				icon_state = "strongoff"
		else

			src.sd_SetLuminosity(0)
			icon_state = "flooroff"

/obj/lamp/proc/turnon_temp(delay)
	src.turnon()
	spawn(delay)
		for(var/obj/comp/lights/L in range(25, src))
			if(L)
				if(L.on && L.powered)
					src.turnon()

/obj/lamp/proc/turnoff_temp(delay)
	src.turnoff()
	spawn(delay)
		for(var/obj/comp/lights/L in range(25, src))
			if(L)
				if(L.on && L.powered)
					src.turnon()

/obj/lamp/proc/fuckup()
	src.fucked = 1
	src.sd_SetLuminosity(0)
	if(istype(src, /obj/lamp/strong))
		src.icon_state = "strongbroken"
	else if(istype(src, /obj/lamp/lava))
		src.icon_state = "lavabroken"
	else if(istype(src, /obj/lamp/floor))
		src.icon_state = "floorbroken"
	else
		src.icon_state = "broken"

/obj/dest
	bomb_proof = 75
/obj/dest/emitter
	luminosity = 0
	density = 1
	icon = 'grafon/singulo.dmi'
	var/on = 0
	name = "Console-controlled emitter"
	icon_state = "gun"
	alticon = "ggun"
	anchored = 0
/obj/dest/emitter

/obj/dest/emitter/verb/rotate()






























	set name = "Rotate"
	if(src.on == 0)
		set src in view(1)
		switch(dir)
			if(1)
				dir = 4
			if(4)
				dir = 2
			if(2)
				dir = 8
			if(8)
				dir = 1
	else
		usr << "\red Turn it off first!"

/obj/dest/emitter/proc/pewpew()
	if(src.on == 0)
		for(var/obj/wire/W in loc)
			if(W.energy > 0)
				W.energy -= 1
				src.on = 1
				src.icon_state = "gunon"
				alticon = "ggunon"
				var/L = new /obj/lazor(src.loc)
				switch(src.dir)
					if(1)
						L:target_x = 0
						L:target_y = 10
					if(2)
						L:target_x = 0
						L:target_y = -10
					if(8)
						L:target_x = -10
						L:target_y = 0
					if(4)
						L:target_x = 10
						L:target_y = 0
					else
						world << "\red \bold EMITTERS ARE BROKEN, KOKOKOK"
				spawn(0) L:process()
				range(6, src) << src.playsound('muzlo/pew.wav')
				spawn(30)
					src.icon_state = "gun"
					src.alticon = "ggun"
					on = 0
/obj/dest/diggy_emitter
	density = 1
	icon = 'grafon/singulo.dmi'
	var/charge = 0
	name = "Mining emitter"
	desc = "A heavy-duty industrial laser."
	icon_state = "cgun"
	alticon = "gcgun"
	anchored = 0
	var/charge_lim = 50
/obj/dest/diggy_emitter
/obj/dest/diggy_emitter/verb/charge_wire()
	set name = "charge emitter from the wires"
	set src in view(1)
	for(var/obj/wire/W in src.loc)
		if(!W)
			usr << "\red There's no cable beneath the emitter!"
			return
		else
			if(W.energy > 0)
				usr << "\blue You charge your emitter from wiring."
				if(charge + W.energy < src.charge_lim)
					charge += W.energy
					spawn(0) W.energy = 0
				else
					W.energy -= 50 - src.charge
					spawn(0) charge = 50
/obj/dest/diggy_emitter/attack_by(obj/I)
	if(istype(I, /obj/item/battery))
		var/B = I
		if(B:energy > 0)
			usr << "\blue You transfer some charge from the battery to emitter."
			if(charge + B:energy < src.charge_lim)
				charge += B:energy
				spawn(0)
					B:energy = 0
			else
				B:energy -= 50 - src.charge
				spawn(0) charge = 50
/obj/dest/diggy_emitter/attack_hand()
	if(src.charge > 0)
		usr << "\blue You turn on the lasers."
		src.anchored = 1
		src.woohoo()
	else
		usr << "\red Recharge the emitter first!"
/obj/dest/diggy_emitter/proc/woohoo()
	if(src.charge > 0)
		var/L = new /obj/lazor/diggy(loc)
		switch(dir)
			if(1)
				L:target_x = 0
				L:target_y = 10
			if(2)
				L:target_x = 0
				L:target_y = -10
			if(8)
				L:target_x = -10
				L:target_y = 0
			if(4)
				L:target_x = 10
				L:target_y = 0
			else
				world << "\red \bold MINING EMITTERS ARE BROKEN, KOKOKOK"
		spawn(0)
			L:process()
			src.charge--
			spawn(3) src.woohoo()
	else
		src.anchored = 0
		spawn(0) return

/obj/perunbeacon
	icon = 'grafon/singulo.dmi'
	icon_state = "beacon"
	name = "Perun beacon"
	desc = "A weird machine, covered in runes."

/obj/perunbeacon
	bomb_proof = 10
	anchored = 0
/obj/perunbeacon/attack_hand()

	usr << "\red You activate the beacon."
	src.icon_state = "beacon_on"
	src.anchored = 1
	src.sd_SetLuminosity(1)
	spawn(0) src.beacon()

/obj/perunbeacon/attack_by(obj/I)
	if(istype(I, /obj/item/tool/axe) || istype(I, /obj/item/weapon/battleaxe))
		usr << "\red You destroy the beacon!"
		del(src)

/obj/perunbeacon/proc/beacon()
	for(var/obj/singulo/S in range(85, src))
		if(S.energy > 100)
			step_towards(S, src)
	spawn(5)
		if(src)
			src.show_message("beep")
			src.beacon()
/obj/fuellamp
	layer = 4.1
	icon = 'grafon/light.dmi'
	var/charges = 200
	var/on = 0
	name = "F.U.E.L. lamp"
	desc = "It works on fuel, obviously. Use any liquid cannister, beaker or bottle containing F.U.E.L. to refill it if it is off."
	icon_state = "fuellamp_on"
/obj/fuellamp/weak{charges = 5; name = "F.U.E.L. lamp"}
/obj/fuellamp/off{charges = 0; name = "F.U.E.L. lamp"; icon_state = "fuellamp_off"}
/obj/fuellamp/New()

	src.lampcheck()


/obj/fuellamp/attack_by(obj/I)






	if(istype(I, /obj/item/reagent_container/beaker) && src.charges <= 0)

		var/B = I
		for(var/datum/reagent/R in B:reagent_list)
			if(R.id == "fuel" && R.amount >= 1)
				R.amount--
				usr << "\blue You refill the lamp"
				src.charges = 200

	if(istype(I, /obj/item/reagent_container/cig))
		if(!src.on)
			usr << "\red This lamp is not burning!"
			return
		var/C = I
		C:smoke(usr)

/obj/fuellamp/proc/turnon()
	if(src.luminosity <= 0)
		sd_SetLuminosity(4)
		src.icon_state = "fuellamp_on"
		on = 1
		for(var/mob/M in viewers(src))
			if(prob(M.epilepsy * 5))
				M.seizure(9)

/obj/fuellamp/proc/turnoff()
	if(src.luminosity > 0)
		sd_SetLuminosity(0)
		on = 0
		src.icon_state = "fuellamp_off"
		sd_SetLuminosity(0)

/obj/fuellamp/proc/lampcheck()
	if(src.charges)
		src.charges--
	if(!src.charges && src.on)
		src.turnoff()
	if(src.charges && !src.on)
		src.turnon()
	spawn(10) src.lampcheck()
