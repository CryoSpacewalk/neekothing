// Recovered from compiled neek.dmb (100 procs)

/obj/cloud/New()












	spawn(3) src.roam()

/obj/cloud/proc/heat_transfer()

	var/cloud_amt = 1
	var/sumtemp = src.temp

	for(var/obj/cloud/C in range(0, src))
		cloud_amt++
		sumtemp += C.temp

	if(cloud_amt > 1)

		var/new_temp = sumtemp / cloud_amt
		src.temp = new_temp

		for(var/obj/cloud/C in range(0, src))
			if(C)
				C.notransfer = 1
				C.temp = new_temp

/obj/cloud/proc/roam()
	var/amt; amt = src:corrosion + src.fuel + abs(src.toxin) + src:heal + src.fuel + src.amount
	for(var/obj/machine/turbine/T in range(1, src))
		src.turbo(T)

	if(prob(80))
		var/lok
		lok = locate(src.x + pick(-1, 0, 1), src.y + pick(-1, 0, 1), src.z)
		if(!(lok:airtight == 1))
			src.loc = lok
		if(src.x == 1 || (src.y == 1 || (src.x == 80 || src.y == 80)))
			del(src)
		else if(!src.notransfer)
			src.heat_transfer()
	if(src.burning == 1)
		if(src.fuel > 0)
			src.amount -= 1
			var/F = new /obj/fire(loc)
			sleep(0)
			F:heat = src.fuel
		else
			src.burning = 0
	else if(src.temp > 4)
		src.burning = 1
	for(var/obj/item/tool/torch/T in src.loc)
		if(T.charges > 0 && (fuel > 0 && prob(25)))
			src.burning = 1
	for(var/obj/fuellamp/F in src.loc)
		if(F.on == 1 && (fuel > 0 && prob(25)))
			src.burning = 1
	for(var/obj/chemical/sensor/gas/GS in src.loc)
		if(toxin > 0 || (corrosion > 0 || (fuel > 2 || temp > 1)))
			GS.lockdown()
	for(var/mob/M in src.loc)
		if(M.hepe > 0)
			if(M.opacity && prob(66))
				M.coughy += 15
			if(M.heatprotect < round(src.temp / 2))
				M.damaga(round(src.temp / 2) - M.heatprotect, "burn")
				M << "\red \bold DAMN! IT IS HOT!"
				if(prob(15))
					M.torment(5)
			if(istype(src, /obj/cloud/toxin) && (M.chemprotect < 10 && prob(50)))
				M.coughy += 5
				M.add_chem("toxin", "toxin", 3, src.temp)

				src.amount -= 1
			else if(istype(src, /obj/cloud/fuel) && (M.chemprotect < 10 && prob(50)))
				M.coughy += 5
				M.add_chem("fuel", "fuel", 3, src.temp)
				src.amount -= 1
			if(M.chemprotect < abs(toxin) && toxin < 0)
				M.add_chem("antidote", "antidote", 3, src.temp)


				src.amount -= 1
			if(M.chemprotect < src:corrosion * 4)
				M.damaga(src:corrosion * 4 - M.chemprotect, "burn")
				M << "\red \bold [src.name] burns your skin!"

				if(prob(25))
					M.coughy += 25
					M.add_chem("chlorine", "chlorine", 3, src.temp)
					src.amount -= 1
				if(prob(15))
					M.torment(5)
			if(src:heal > 0)
				if(M.chemprotect < src:heal * 2 && prob(100 - M.chemprotect * 10))
					M.add_chem("regenerite", "regenerite", 3, src.temp)










					src.amount -= 1
	for(var/obj/bio/weed/WD in src.loc)
		if((src:corrosion > 0 || src.temp > 1) && prob(50))
			WD.grassdmg(src.temp * 5 + src:corrosion * 2)
		if(round(toxin * 1.5) > 0 && prob(50))
			WD.grassdmg(round(toxin * 1.5))
	for(var/obj/bio/amoeba/AE in src.loc)
		if(src.temp > 1 || prob(50))
			AE.biodmg(round(src.temp * 1.5))
		if(src:corrosion > 0 || prob(20))
			AE.biodmg(src:corrosion)
	for(var/obj/putin/P in src.loc)
		if(src:corrosion > 0)
			P.biodmg(src:corrosion * 5)
	for(var/obj/putin_big/P in src.loc)
		if(src:corrosion > 0)
			P.biodmg(src:corrosion * 5)
		if(src.temp > 0 && prob(50))
			P.biodmg(round(src.temp * 2.5))
		if(toxin > 0)
			P.biodmg(round(toxin * 5))
		if(src:heal > 0)
			if(P.hepe < 20)
				P.hepe += 5
				if(prob(20))
					src.show_message("\red [P.name] looks healthier!")
			else if(P.hepe < 30)
				P.hepe += 2
			else if(P.hepe < 40)
				P.hepe++
	if(src.amount && amt)
		if(src)
			spawn(3)
				src.roam()
	else
		del(src)
		return


/obj/effect/liquid_splash/New()






































































































































	..()
	sleep(6)
	del(src)

/proc/postinitiate(obj/S, obj/Sold)







































































	S:re = Sold:re
	S:ge = Sold:ge
	S:be = Sold:be
	S:chemicals_carried += Sold:chemicals_carried
	S:clock = Sold:clock - 1
	S:temp = Sold:temp
	S:amount = Sold:amount
	S:icon += rgb(S:re, S:ge, S:be)
	sleep(5)
	S:spread()
/obj/item/device/crusher
	icon = 'grafon/device.dmi'
	size = 3
	beltable = 1
	name = "Cell devastator"
	icon_state = "devastator"
	desc = "A special device for destroying monocellular creatures with thick cell membrane. It damage user as well, but not too heavily."
	var/inert = 0
/obj/item/device/mined
	icon = 'grafon/device.dmi'
	beltable = 1
	metal_need = 3
	plastic_need = 3
	silicon_need = 4
	name = "mine deactivator"
	desc = "A device for deactivating space and hull mines."
	icon_state = "mined"
/obj/item/device/d_mine
	icon = 'grafon/device.dmi'
	market_price = 100
	metal_need = 3
	silicon_need = 1
	name = "deployable mine"
	desc = "Leaves an active space mine when unpacked."
	icon_state = "package_mine"
/obj/item/device/hachtele
	icon = 'grafon/device.dmi'
	metal_need = 1
	silicon_need = 4
	name = "Abyssal tele"
	desc = "Returns you to The Abyss then used while staying onto arrivial teleporter or onto an abyssal-alike floor (no matter how did you manage to find it)."
	icon_state = "abysstele"
/obj/item/device/communicator
	icon = 'grafon/device.dmi'
	silicon_need = 8
	plastic_need = 3
	icon_state = "communicator"
	name = "bluespace encryptor"
	desc = "This device usually used for ordering stuff via tradeplaces based somewhere very-very-very faraway. Don't ask me how it works."
	var/money = 30
	var/svetov = 5
	var/baryga = 0
/obj/item/device/trayscan
	icon = null /*icon id 35: unresolved*/
	icon = 'grafon/item.dmi'
	beltable = 1
	name = "tray scanner"
	icon_state = "trayscan"
/obj/item/device/brainpod
	icon = 'grafon/device.dmi'
	market_price = 50
	name = "brain pod"
	icon_state = "brainpod_empty"
/obj/item/device/jet{icon = 'grafon/device.dmi'; plastic_need = 4; icon_state = "jet"; name = "robotic jets"; desc = "Robots can move around with those things."}
/obj/item/device/e_module{icon = 'grafon/device.dmi'; beltable = 1; market_price = 350; metal_need = 2; silicon_need = 5; name = "enslavement module"; icon_state = "e_module"; desc = "An eerie-looking device."; var/master = "Wasiliy Kotov"}
/obj/item/device/caller{beltable = 1; silicon_need = 2; plastic_need = 1; name = "Evacuation initiator"; icon_state = "caller"}
/obj/item/device/uncaller
	beltable = 1;market_price = 200;silicon_need = 2;plastic_need = 1
	name = "Evacuation deinitiator"
	icon_state = "uncaller"
/obj/item/device/tele{icon = null /*icon id 35: unresolved*/; icon = 'grafon/item.dmi'; name = "hand tele"; icon_state = "tele"; desc = "An odd device for sending one somewhere else."};/obj/item/device/abyss_tele{icon = 'grafon/device.dmi'; icon_state = "tele"; name = "abyssal tele"; desc = "A VERY odd device for sending one somewhere else. It utilises The Abyss due to its unborn nature which leads to distorted distations, so you will have to stay there for a while. There's a theory what it can be used in The Abyss as well."};/obj/item/device/mobila{charges = 5; beltable = 1; metal_need = 10; plastic_need = 15; silicon_need = 15; wood_need = 1; name = "Capitalistic mobile phone"; icon_state = "mobila"};/obj/item/device/brutforcer{icon = null /*icon id 35: unresolved*/; icon = 'grafon/item.dmi'; dmg = 5; accu = 70; beltable = 1; market_price = 500; metal_need = 10; plastic_need = 2; silicon_need = 8; name = "Primary maintenance key"; icon_state = "key_copper"};/obj/item/device/consolehack{beltable = 1; market_price = 200; metal_need = 4; silicon_need = 6; name = "console module"; icon_state = "consolehack"};/obj/item/device/krokodil{beltable = 1; plastic_need = 1; name = "Electronic ''Krokodil'' magazine"; desc = "An electronic magazine full of humor and satire. Also contains some fresh news."; icon_state = "krokodil"};/obj/item/device/mask{icon = 'grafon/item/gas.dmi'; plastic_need = 1; name = "Gas mask"; icon_state = "mask_item"};/obj/item/device/seeker_raw{icon = 'grafon/device.dmi'; name = "unfinished seeker module"; icon_state = "seeker_raw"};/obj/item/device/signaler{charges = 1; silicon_need = 1; name = "Signal translator"; icon_state = "pult"};/obj/item/device/signaler/adv{name = "Advanced signal translator"}
/obj/item/device/signaler/proc/signal()
	for(var/obj/chemical/gastank/C in world)
		if(C.channel == src.charges && !(C.channel == null))
			if(C.opened == 0)
				C.opened = 1
				spawn(10) C.release()
			else if(C.opened == 1)
				C.opened = 0
	for(var/obj/item/device/signiter/S in world)
		if(S.charges == src.charges && !(S.charges == null))
			S.ignite()
	for(var/obj/door/S in world)
		if(S.signal)
			if(S.signal:charges == src.charges)
				if(S.blocked)
					S.unbolt()
				else
					S.bolt()
	for(var/obj/chemical/sensor/S in world)
		if(S.channel == src.charges && !(S.channel == null))
			S.lockdown()
	for(var/obj/item/gas/tube/T in world)
		if(T.channel == src.charges && !(T.channel == null))
			T.valve()
	for(var/obj/item/gas/tank/T in world)
		if(T.igniter_channel == src.charges && !(T.igniter_channel == null))
			T.ignite()
	for(var/obj/item/amoebabox/A in world)
		if(A.S)
			if(A.S:charges == src.charges)
				A.deploy()
				spawn(0) del(A)


	for(var/obj/wire/W in world)
		if(W.SG && W.SG:charges == src.charges)
			if(W.alpha)
				W.alpha = 0
			else
				W.alpha = 1

	for(var/obj/wireleech/W in world)
		if(W.SG && W.SG:charges == src.charges)
			W.id = "alpha"

	for(var/obj/wireout/W in world)
		if(W.SG && W.SG:charges == src.charges)
			W.id = "alpha"

/obj/item/device/signaler/attack_by(obj/I)


	if(src in view(1, usr))
		if(istype(I, /obj/item/tool/screwdriver))
			src.charges = input("Select new channel for your signaler.", "New channel:", src.charges)
		if(istype(I, /obj/item/device/igniter))
			var/S = new /obj/item/device/signiter(usr.loc)
			S:charges = src.charges
			spawn(0)
				del(I)
				del(src)

/obj/item/device/signaler/attack_self()











	usr << "\blue *Beep-beep*"
	src.signal()

/obj/item/device/igniter
	igniter = 1
	metal_need = 1
	icon_state = "igniter"
	name = "electrical igniter"
	desc = "A hand-held ignition device."

/obj/item/device/igniter

/obj/item/device/igniter/attack_self()
	usr << "\blue You spark with your igniter."
	for(var/mob/M in view(4, usr))
		M << "\blue Spark-spark."
	new /obj/effect/sparks(usr.loc)

/obj/item/device/signiter
	charges = 1
	name = "radio-applied igniter"
	icon_state = "signiter"
/obj/item/device/signiter
/obj/item/device/signiter/proc/ignite()
	for(var/mob/M in view(4, src))
		M << "\blue Spark-spark."



	new /obj/effect/sparks(src.loc)
/obj/machine/snek{density = 1; name = "Tic-tac-toe"; icon_state = "zmeyka"; desc = "A fascinating game for bored personnel! I have no idea how this thing works even without power supply."}
/obj/machine/statigniter{icon_state = "igniter"; name = "stationary igniter"; desc = "Massive, console-controlled big brother of the hand ignition device."}
/obj/machine/statigniter/operate(obj/W)



	if(W:energy > 0)
		src.spark()
		usr << "\blue Spark-spark."
		W:energy -= 1
	else
		usr << "\red Not enough energy!"

/obj/machine/statigniter/attack_by(obj/I)

	if(istype(I, /obj/item/reagent_container/cig))
		var/C = I
		C:smoke(usr)

/obj/machine/statigniter/proc/spark()
	for(var/mob/M in view(6, src))
		M << "\blue Spark-spark."



	new /obj/effect/sparks(src.loc)

/obj/machine/gas
	density = 1
	var/cl = 0
	var/tox = 0
	var/smk = 0
	var/anti = 0
	var/fuel = 0
	var/regen = 0
	var/heat = 0
	var/free = 50
	var/maxfree = 50
	var/press = 1
	var/air = 10
























































































































	var/L = list()
/obj/machine/gas{anchored = 0}
/obj/machine/gas/proc/add(G, A, GH)
	var/sum = cl + tox + smk + anti + fuel + regen
	if(A > 0)
		switch(G)
			if("cl")
				src.cl += A
			if("tox")
				src.tox += A
			if("smk")
				src.smk += A
			if("anti")
				src.anti += A
			if("fuel")
				src.fuel += A
			if("regen")
				src.regen += A
		if(A + sum != 0)
			src.heat = (src.heat * sum + GH * A) / (A + sum)
		src.inner_burn()

/obj/machine/gas/proc/inner_burn()
	if(src.heat > 4 && src.fuel > 0)
		var/sum = cl + tox + smk + anti + fuel + regen
		if(round(sum / 2) < src.fuel)
			src.heat += round(sum / 2)
			src.fuel -= round(sum / 2)
			src.add("smk", round(sum / 2) * 2, 22)
		else
			src.heat += src.fuel
			var/oldfuel = src.fuel
			src.fuel = 0
			src.add("smk", oldfuel * 2, 22)
		if(src.heat > 4 && src.fuel > 0)
			spawn(5) src.inner_burn()
	else
		return
/obj/machine/gas/pump
	var/connected = 0
	var/on = 0
	name = "Gas pump"
	desc = "A piece of machinery for pumping gases from atmosphere/connectors to tanks."
	icon_state = "pump_off"
	alticon = "gpump"
	var/method = "IN"
	var/sucks = 1
/obj/machine/gas/pump
/obj/machine/gas/pump/verb/turnon()
	set name = "Turn on/off"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(on == 0)
		icon_state = "pump_on"
		on = 1
		spawn(0) operation()
	else
		on = 0
		icon_state = "pump_off"
/obj/machine/gas/pump/verb/change_method()
	set name = "Change connector operation method"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(method == "IN")
		method = "OUT"
		usr << "[src] now will transfer to connector."
	else
		method = "IN"
		usr << "[src] now will pump gases from connector."
/obj/machine/gas/pump/verb/change_mode()
	set name = "Change pump mode"
	set src in view(1)

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.sucks)
		src.sucks = 0
		usr << "You change [src] pumping mode to OUT."
	else
		src.sucks = 1
		usr << "You change [src] pumping mode to IN."
/obj/machine/gas/pump/verb/changepress()
	set name = "Change releasement pressure"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	src.pressurechange()
	usr << "\blue You set [src] releasement pressure to [src.press]."
/obj/machine/gas/pump/proc/take_from_pipe(obj/P)
	if(P:cl > 0)
		src.add("cl", round(P:cl / 2), P:heat)
		spawn(0) P:cl -= round(P:cl / 2)
	if(P:tox > 0)
		src.add("tox", round(P:tox / 2), P:heat)
		spawn(0) P:tox -= round(P:tox / 2)
	if(P:smk > 0)
		src.add("smk", round(P:smk / 2), P:heat)
		spawn(0) P:smk -= round(P:smk / 2)
	if(P:fuel > 0)
		src.add("fuel", round(P:fuel / 2), P:heat)
		spawn(0) P:fuel -= round(P:fuel / 2)
	if(P:anti > 0)
		src.add("anti", round(P:anti / 2), P:heat)
		spawn(0) P:anti -= round(P:anti / 2)
	if(P:regen > 0)
		src.add("regen", round(P:regen / 2), P:heat)
		spawn(0) P:regen -= round(P:regen / 2)
/obj/machine/gas/pump/proc/transfer_to_pipe(obj/P)
	if(cl > 0)
		P:add("cl", round(cl / 2), heat)
		spawn(0) cl -= round(cl / 2)
	if(tox > 0)
		P:add("tox", round(tox / 2), heat)
		spawn(0) tox -= round(tox / 2)
	if(smk > 0)
		P:add("smk", round(smk / 2), heat)
		spawn(0) smk -= round(smk / 2)
	if(fuel > 0)
		P:add("fuel", round(fuel / 2), heat)
		spawn(0) fuel -= round(fuel / 2)
	if(anti > 0)
		P:add("anti", round(anti / 2), heat)
		spawn(0) anti -= round(anti / 2)
	if(regen > 0)
		P:add("regen", round(regen / 2), heat)
		spawn(0) regen -= round(regen / 2)
/obj/machine/gas/pump/proc/connector_processing(obj/P)
	if(src.connected == 1)
		switch(src.method)
			if("IN")
				src.take_from_pipe(P)
			else
				src.transfer_to_pipe(P)
		spawn(20) src.connector_processing(P)
	else
		return
/obj/machine/gas/pump/proc/operation()
	if(src.sucks == 1)
		src.suck()
	else
		src.release()
	if(src.on == 1)
		spawn(5) operation()
/obj/machine/gas/pump/hot
	heat = 8
	smk = 60
	name = "suspicious gas pump"

/obj/machine/gas/pump/hot
/obj/machine/gas/pump/proc/suck()
	if(src.free > 0)
		for(var/obj/cloud/C in loc)
			var/K = pick(C)
			if(istype(K, /obj/cloud/prespawned))
				src.add("cl", 1, K:temp)
			else if(istype(K, /obj/cloud/toxin))
				src.add("tox", 1, K:temp)
			else if(istype(C, /obj/cloud/smoke))
				src.add("smk", 1, K:temp)
			else if(istype(C, /obj/cloud/fuel))
				src.add("fuel", 1, K:temp)
			else if(istype(C, /obj/cloud/antidote))
				src.add("anti", 1, K:temp)
			else if(istype(C, /obj/cloud/regenerite))
				src.add("regen", 1, K:temp)
			src.free -= 1
			spawn(0) del(K)

/obj/machine/gas/proc/pressurechange()
	if(src.press < 7)
		src.press += 1
	else
		src.press = 1

/obj/machine/gas/proc/transfer_to(obj/item/gas/tank/G)


	var/sumtank = G:cl + G:fuel + G:smk + G:tox + G:regen + G:anti
	if(sumtank < 7)
		var/gr = pick("cl", "tox", "smk", "fuel", "anti", "regen")
		var/sum = cl + fuel + smk + tox + regen + anti
		if(sum > 0)














			spawn(0)
				switch(gr)
					if("cl")
						if(src.cl > 0)
							usr << "\blue You load some of the [src] contents in your tank."
							if(src.cl > src.press)
								G:add("cl", src.press, src.heat)
								cl -= src.press
								free += src.press
							else
								G:add("cl", src.cl, src.heat)
								cl = 0
								free += src.press
						else
							gr = pick("tox", "smk", "fuel", "anti", "regen")
							spawn(0) src.transfer_to(G)
					if("tox")
						if(src.tox > 0)
							usr << "\blue You load your tank with some of the [src] contents."
							if(src.tox > src.press)
								G:add("tox", src.press, src.heat)
								tox -= src.press
								free += src.press
							else
								G:add("tox", src.tox, src.heat)
								tox = 0
								free += src.press
						else
							gr = pick("cl", "smk", "fuel", "anti", "regen")
							spawn(0) src.transfer_to(G)
					if("smk")
						if(src.smk > 0)
							usr << "\blue You load your tank with some of the [src] contents."
							if(src.smk > src.press)
								G:add("smk", src.press, src.heat)
								smk -= src.press
								free += src.press
							else
								G:add("smk", src.smk, src.heat)
								smk = 0
								free += src.press
						else
							gr = pick("cl", "tox", "fuel", "anti", "regen")
							spawn(0) src.transfer_to(G)
					if("fuel")
						if(src.fuel > 0)
							usr << "\blue You load your tank with some of the [src] contents."
							if(src.fuel > src.press)
								G:add("fuel", src.press, src.heat)
								fuel -= src.press
								free += src.press
							else
								G:add("fuel", src.fuel, src.heat)
								fuel = 0
								free += src.press
						else
							gr = pick("cl", "tox", "smk", "anti", "regen")
							spawn(0) src.transfer_to(G)
					if("anti")
						if(src.anti > 0)
							usr << "\blue You load your tank with some of the [src] contents."
							if(src.anti > src.press)
								G:add("anti", src.press, src.heat)
								anti -= src.press
								free += src.press
							else
								G:add("anti", src.anti, src.heat)
								anti = 0
								free += src.press
						else
							gr = pick("cl", "smk", "tox", "fuel", "regen")
							spawn(0) src.transfer_to(G)
					if("regen")
						if(src.regen > 0)
							usr << "\blue You load your tank with some of the [src] contents."
							if(src.regen > src.press)
								G:add("regen", src.press, src.heat)
								regen -= src.press
								free += src.press
							else
								G:add("regen", src.regen, src.heat)
								regen = 0
								free += src.press
						else
							gr = pick("cl", "tox", "smk", "fuel", "anti")
							spawn(0) src.transfer_to(G)
					if("hui")
						world << "\red \bold FIX THIS SHIT"
						return
		else
			return

/obj/machine/gas/pump/attack_hand()

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	src.turnon()

/obj/machine/gas/pump/attack_by(obj/I)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	if(istype(I, /obj/item/gas/tank))
		transfer_to(I)
	else if(istype(I, /obj/item/tool/airmeter))
		var/sum = cl + tox + smk + anti + fuel + regen
		usr << "\blue Amount of gas: [sum]</br> Amount of chlorine: [cl]</br> Amount of toxin: [tox]</br> Amount of burn product: [smk]</br> Amount of antidote: [anti]</br> Amount of gas fuel: [fuel]</br> Amount of regenerite: [regen]</br> Temperature: [heat]"
	else if(istype(I, /obj/item/tool/wrench))
		if(connected == 0)
			for(var/obj/machine/gas/pipealike/pipe/connector/P in src.loc)
				if(P)
					usr << "\blue You connect [src] to port."
					connected = 1
					anchored = 1
					src.break_pull()
					spawn(10) connector_processing(P)
		else
			usr << "\blue You disconnect [src] from the port."
			connected = 0
			anchored = 0


/obj/machine/gas/pipealike
	free = 9999999
	maxfree = 9999999
	anchored = 1
	desc = "A pipe thingy."
	var/obj/product = /obj/item/pipe
	var/heat_transfer = 0
	var/valve_open = 1
/obj/machine/gas/pipealike
/obj/machine/gas/pipealike/operate(obj/W)
	if(W:energy > 0)
		W:energy -= 1
		src.attack_hand()
	else
		usr << "\red Not enough energy!"
		return
/obj/machine/gas/pipealike/pipe
	density = 0
	layer = 2.3
	icon = 'grafon/pipe.dmi'
	var/on = 0
	icon_state = "pipe"
	alticon = "gpipe"
/obj/machine/gas/pipealike/pipe
/obj/machine/gas/pipealike/pipe/New()
	src.gasworks()

/obj/machine/gas/pipealike/proc/gasselect(obj/W)



	if(cl > 0 || cl && press > W:press)
		W:add("cl", 1, src.heat)
		cl -= 1



	if(tox > 0 || tox && press > W:press)
		W:add("tox", 1, src.heat)
		tox -= 1



	if(smk > 0 || smk && press > W:press)
		W:add("smk", 1, src.heat)
		smk -= 1



	if(fuel > 0 || fuel && press > W:press)
		W:add("fuel", 1, src.heat)
		fuel -= 1



	if(anti > 0 || anti && press > W:press)
		W:add("anti", 1, src.heat)
		anti -= 1



	if(regen > 0 || regen && press > W:press)
		W:add("regen", 1, src.heat)
		regen -= 1
	if(src.air > 0)
		W:air += 1
		src.air -= 1

/obj/machine/gas/pipealike/proc/gasselect_all(obj/W)


	if(W:press < src:press)
		if(src.cl > 0)
			W:add("cl", src.cl, src.heat)
			spawn(0) cl = 0
		if(tox > 0)
			W:add("tox", tox, heat)
			spawn(0) tox = 0
		if(smk > 0)
			W:add("smk", smk, heat)
			spawn(0) smk = 0
		if(fuel > 0)
			W:add("fuel", fuel, heat)
			spawn(0) fuel = 0
		if(anti > 0)
			W:add("anti", anti, heat)
			spawn(0) anti = 0
		if(regen > 0)
			W:add("regen", regen, heat)
			spawn(0) regen = 0
		if(src.air > 0)
			W:air += src.air
			spawn(0) src.air = 0

/obj/machine/gas/pipealike/proc/gassteal(obj/W)
	if(W:press < src:press)
		if(W:cl > 0)
			src.add("cl", 1, W:heat)
			W:cl -= 1
		if(W:tox > 0)
			src.add("tox", 1, W:heat)
			W:tox -= 1
		if(W:smk > 0)
			src.add("smk", 1, W:heat)
			W:smk -= 1
		if(W:fuel > 0)
			src.add("fuel", 1, W:heat)
			W:fuel -= 1
		if(W:anti > 0)
			src.add("anti", 1, W:heat)
			W:anti -= 1
		if(W:regen > 0)
			src.add("regen", 1, W:heat)
			W:regen -= 1

/obj/machine/gas/pipealike/pipe/proc/gasworks()
	var/realgases = cl + smk + tox + fuel + anti + regen
	if(air + realgases > realgases)
		if(air - realgases > 3)
			air -= 2
		else if(air - realgases > 5)
			air -= 4
		else if(air > 0)
			air--
	src.press = src.cl + src.smk + src.tox + src.fuel + src.anti + src.regen + src.air
	for(var/obj/machine/gas/pipealike/pipe/W in range(1, src))
		if(W:valve_open == 1)
			if(W.press < src.press && src.press > 0)
				if((src.dir == 2 || src.dir == 1) && ((W.dir == 1 || (W.dir == 2 || (W.dir == 9 || W.dir == 5))) && (src.x == W.x && src.y == W.y + 1) || (W.dir == 1 || (W.dir == 2 || (W.dir == 10 || W.dir == 6))) && (src.x == W.x && src.y == W.y - 1)) || ((src.dir == 8 || src.dir == 4) && ((W.dir == 8 || (W.dir == 4 || (W.dir == 9 || W.dir == 10))) && (src.y == W.y && src.x == W.x - 1) || (W.dir == 8 || (W.dir == 4 || (W.dir == 5 || W.dir == 6))) && (src.y == W.y && src.x == W.x + 1)) || (src.dir == 6 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 9 || W.dir == 5))) && (src.y == W.y + 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 9 || W.dir == 10))) && (src.y == W.y && src.x == W.x - 1)) || (src.dir == 5 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 10 || W.dir == 6))) && (src.y == W.y - 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 9 || W.dir == 10))) && (src.y == W.y && src.x == W.x - 1)) || (src.dir == 10 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 5 || W.dir == 9))) && (src.y == W.y + 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 5 || W.dir == 6))) && (src.y == W.y && src.x == W.x + 1)) || src.dir == 9 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 6 || W.dir == 10))) && (src.y == W.y - 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 6 || W.dir == 5))) && (src.y == W.y && src.x == W.x + 1)))))))
					spawn(0) src.gasselect(W)
	if(istype(src, /obj/machine/gas/pipealike/pipe/pump))
		src.suck()
	if(istype(src, /obj/machine/gas/pipealike/pipe/outlet))
		src.release()
	if(prob(src:heat_transfer * 50))
		for(var/obj/cloud/C in src.loc)
			var/sheat = src.heat + C.temp
			C.temp = sheat / 2
			src.heat = sheat / 2
	spawn(5) src.gasworks()
/obj/machine/gas/pipealike/pipe/pump
	alticon = "gpump"
	product = /obj/item/pipe/pump
	name = "gas pump"
	icon_state = "pump"
/obj/machine/gas/pipealike/pipe/pump
/obj/machine/gas/pipealike/pipe/pump/verb/turnon()
	set name = "Turn on/off"
	set src in view(1)

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(on == 0)
		on = 1

		if(alted)
			icon_state = "gpump_on"
		else

			icon_state = "pump_on"

		src.alticon = "gpump_on"
		src.suck()
	else
		on = 0

		if(alted)
			icon_state = "gpump"
		else

			icon_state = "pump"

		src.alticon = "gpump"

/obj/machine/gas/pipealike/pipe/pump/attack_hand()

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	src.turnon()

/obj/machine/gas/pipealike/pipe/proc/suck()
	if(src.on == 1)
		for(var/obj/cloud/K in loc)
			var/C = pick(K)
			if(istype(C, /obj/cloud/prespawned))
				src.add("cl", 1, C:temp)
			else if(istype(C, /obj/cloud/toxin))
				src.add("tox", 1, C:temp)
			else if(istype(C, /obj/cloud/smoke))
				src.add("smk", 1, C:temp)
			else if(istype(C, /obj/cloud/fuel))
				src.add("fuel", 1, C:temp)
			else if(istype(C, /obj/cloud/antidote))
				src.add("anti", 1, C:temp)
			else if(istype(C, /obj/cloud/regenerite))
				src.add("regen", 1, C:temp)
			spawn(0) del(C)
/obj/machine/gas/pipealike/t_pipe
	density = 0
	layer = 2.3
	icon = 'grafon/pipe.dmi'
	icon_state = "t_pipe"
	alticon = "gt_pipe"
	product = /obj/item/pipe/t
/obj/machine/gas/pipealike/t_pipe
/obj/machine/gas/pipealike/t_pipe/New()
	src.t_works()

/obj/machine/gas/pipealike/t_pipe/proc/t_works()
	var/realgases = src.cl + src.smk + src.tox + src.fuel + src.anti + src.regen
	if(src.air + realgases > realgases)
		if(src.air - realgases > 3)
			src.air -= 2
		else if(src.air - realgases > 5)
			src.air -= 4
		else if(src.air > 0)
			src.air--
	for(var/obj/machine/gas/pipealike/pipe/W in range(1, src))
		if(W:valve_open == 1)
			var/sum = src.cl + src.smk + src.tox + src.fuel + src.anti + src.regen + src.air
			var/W_sum = W.cl + W.smk + W.tox + W.fuel + W.anti + W.regen + W.air
			if(W_sum != sum && (sum > 0 || W_sum > 0))
				if(src.dir == 2 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 10 || W.dir == 6))) && (W.y == src.y - 1 && W.x == src.x) || ((W.dir == 8 || (W.dir == 4 || (W.dir == 10 || W.dir == 9))) && (W.x == src.x + 1 && W.y == src.y) || (W.dir == 8 || (W.dir == 4 || (W.dir == 6 || W.dir == 5))) && (W.x == src.x - 1 && W.y == src.y))))
					if(W_sum < sum)
						src.gasselect(W)
					else
						src.gassteal(W)
				else if(src.dir == 1 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 9 || W.dir == 5))) && (W.x == src.x && W.y == src.y + 1) || ((W.dir == 8 || (W.dir == 4 || (W.dir == 10 || W.dir == 9))) && (W.y == src.y && W.x == src.x + 1) || (W.dir == 8 || (W.dir == 4 || (W.dir == 6 || W.dir == 5))) && (W.y == src.y && W.x == src.x - 1))))
					if(W_sum < sum)
						src.gasselect(W)
					else
						src.gassteal(W)
				else if(src.dir == 4 && ((W.dir == 4 || (W.dir == 8 || (W.dir == 10 || W.dir == 9))) && (W.x == src.x + 1 && W.y == src.y) || ((W.dir == 1 || (W.dir == 2 || (W.dir == 5 || W.dir == 9))) && (W.y == src.y - 1 && W.x == src.x) || (W.dir == 1 || (W.dir == 2 || (W.dir == 6 || W.dir == 10))) && (W.y == src.y + 1 && W.x == src.x))))
					if(W_sum < sum)
						src.gasselect(W)
					else
						src.gassteal(W)
				else if(src.dir == 8 && ((W.dir == 4 || (W.dir == 8 || (W.dir == 6 || W.dir == 5))) && (W.x == src.x - 1 && W.y == src.y) || ((W.dir == 1 || (W.dir == 2 || (W.dir == 5 || W.dir == 9))) && (W.y == src.y - 1 && W.x == src.x) || (W.dir == 1 || (W.dir == 2 || (W.dir == 6 || W.dir == 10))) && (W.y == src.y + 1 && W.x == src.x))))
					if(W_sum < sum)
						src.gasselect(W)
					else
						src.gassteal(W)
	for(var/obj/machine/gas/pipealike/t_pipe/T in range(1, src))
		var/sum = src.cl + src.smk + src.tox + src.fuel + src.anti + src.regen + src.air
		var/T_sum = T.cl + T.smk + T.tox + T.fuel + T.anti + T.regen + T.air
		if(T_sum != sum && (sum > 0 || T_sum > 0))
			if(src.dir == 2 && (!(T.dir == 8) && (T.x == src.x - 1 && T.y == src.y) || (!(T.dir == 4) && (T.x == src.x + 1 && T.y == src.y) || !(T.dir == 2) && (T.x == src.x && T.y == src.y - 1))))
				if(T_sum < sum)
					src.gasselect(T)
				else
					src.gassteal(T)
			else if(src.dir == 1 && (!(T.dir == 8) && (T.x == src.x - 1 && T.y == src.y) || (!(T.dir == 4) && (T.x == src.x + 1 && T.y == src.y) || !(T.dir == 1) && (T.x == src.x && T.y == src.y + 1))))
				if(T_sum < sum)
					src.gasselect(T)
				else
					src.gassteal(T)
			else if(src.dir == 8 && (!(T.dir == 8) && (T.x == src.x - 1 && T.y == src.y) || (!(T.dir == 2) && (T.x == src.x && T.y == src.y - 1) || !(T.dir == 1) && (T.x == src.x && T.y == src.y + 1))))
				if(T_sum < sum)
					src.gasselect(T)
				else
					src.gassteal(T)
			else if(src.dir == 4 && (!(T.dir == 4) && (T.x == src.x + 1 && T.y == src.y) || (!(T.dir == 2) && (T.x == src.x && T.y == src.y - 1) || !(T.dir == 1) && (T.x == src.x && T.y == src.y + 1))))
				if(T_sum < sum)
					src.gasselect(T)
				else
					src.gassteal(T)
	spawn(5)
		src.t_works()

/obj/machine/gas/proc/release()






	var/i = 0
	if(src.cl > 0)
		for(, i < src.cl, i++)
			spawn(0)
				var/C = new /obj/cloud/prespawned(src.loc)
				C:temp = src.heat
	if(src.tox > 0)
		for(, i < src.tox, i++)
			spawn(0)
				var/C = new /obj/cloud/toxin(src.loc)
				C:temp = src.heat
	if(src.smk > 0)
		for(, i < src.smk, i++)
			spawn(0)
				var/C = new /obj/cloud/smoke(src.loc)
				C:temp = src.heat
	if(src.anti > 0)
		for(, i < src.anti, i++)
			spawn(0)
				var/C = new /obj/cloud/antidote(src.loc)
				C:temp = src.heat
	if(src.regen > 0)
		for(, i < src.regen, i++)
			spawn(0)
				var/C = new /obj/cloud/regenerite(src.loc)
				C:temp = src.heat
	if(src.fuel > 0)
		for(, i < src.fuel, i++)
			spawn(0)
				var/C = new /obj/cloud/fuel(src.loc)
				C:temp = src.heat
	src.cl = 0
	src.tox = 0
	src.smk = 0
	src.anti = 0
	src.fuel = 0
	src.regen = 0
	src:free = src:maxfree

/obj/machine/gas/pipealike/attack_by(obj/I)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate pipes!"
		return

	if(istype(I, /obj/item/tool/airmeter))
		var/sum = cl + tox + smk + anti + fuel + regen
		usr << "\blue Amount of gas: [sum]</br> Amount of chlorine: [cl]</br> Amount of toxin: [tox]</br> Amount of burn product: [smk]</br> Amount of antidote: [anti]</br> Amount of gas fuel: [fuel]</br> Amount of regenerite: [regen]</br> Temperature: [heat]</br> Pressure: [press]"
	else if(istype(I, /obj/item/tool/torch) && (I:charges > 0 && !istype(src, /obj/machine/gas/pipealike/pipe/tank)))
		usr << "\blue You cut pipe fragment out."
		I:fuel(-1)
		deconstruct(product)

/obj/machine/gas/pipealike/proc/deconstruct(obj/product)
	var/O = new product(src.loc)
	O:dir = src.dir
	src.release()
	spawn(0) del(src)

/obj/machine/gas/pipealike/pipe/outlet
	icon_state = "outlet"
	alticon = "goutlet"
	product = /obj/item/pipe/vent
	name = "gas outlet"

/obj/machine/gas/pipealike/pipe/outlet

/obj/machine/gas/pipealike/pipe/heat
	name = "heat transfer pipe"
	icon_state = "h_pipe"
	alticon = "gh_pipe"
	product = /obj/item/pipe/heat
	heat_transfer = 2

/obj/machine/gas/pipealike/pipe/heat

/obj/machine/gas/pipealike/pipe/gate
	name = "gas gate"
	icon_state = "gate"
	alticon = "ggate"
	product = /obj/item/pipe/gate
	desc = "A machinery whith pumps gas in its direction."

/obj/machine/gas/pipealike/pipe/gate



/obj/machine/gas/pipealike/pipe/gate/New()





































































	src.pump_to()
/obj/machine/gas/pipealike/pipe/gate/proc/pump_to()
	for(var/obj/machine/gas/pipealike/pipe/W in range(1, src))
		if(prob(10))
			if(src.dir == 2 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 10 || W.dir == 6))) && (W.y == src.y - 1 && W.x == src.x)))
				src.gasselect_all(W)
			else if(src.dir == 1 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 9 || W.dir == 5))) && (W.x == src.x && W.y == src.y + 1)))
				src.gasselect_all(W)
			else if(src.dir == 4 && ((W.dir == 4 || (W.dir == 8 || (W.dir == 10 || W.dir == 9))) && (W.x == src.x + 1 && W.y == src.y)))
				src.gasselect_all(W)
			else if(src.dir == 8 && ((W.dir == 4 || (W.dir == 8 || (W.dir == 6 || W.dir == 5))) && (W.x == src.x - 1 && W.y == src.y)))
				src.gasselect_all(W)
	if(src)
		spawn(10) src.pump_to()
/obj/machine/gas/pipealike/pipe/valve
	icon_state = "valve_closed"
	alticon = "gvalve_closed"
	valve_open = 0
	product = /obj/item/pipe/valve
/obj/machine/gas/pipealike/pipe/valve
/obj/machine/gas/pipealike/pipe/valve/attack_hand()
	switch(valve_open)
		if(0)
			usr << "\blue You open [src]."

			if(alted)
				icon_state = "gvalve_open"
			else

				icon_state = "valve_open"

			src.alticon = "gvalve_open"

			src.valve_open = 1
		else
			usr << "\blue You close [src]."

			if(alted)
				icon_state = "gvalve_closed"
			else

				icon_state = "valve_closed"

			src.alticon = "gvalve_closed"
			src.valve_open = 0

/obj/machine/gas/pipealike/pipe/connector
	name = "connection port"
	icon_state = "connector"
	alticon = "gconnector"
	product = /obj/item/pipe/connector
/obj/machine/gas/pipealike/pipe/connector
/obj/machine/gas/pipealike/pipe/compressor
	name = "atmos compressor"
	icon_state = "compressor_off"
	alticon = "gcompressor_off"
	product = /obj/item/pipe/compressor
	desc = "A thing that can magically change pipe pressure without adding any gases."
	var/act = 0
	var/target_p = 25
/obj/machine/gas/pipealike/pipe/compressor
/obj/machine/gas/pipealike/pipe/compressor/attack_hand()
	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	switch(src.act)
		if(0)
			usr << "\blue You activate [src]."

			if(src.alted)
				src.icon_state = "gcompressor_on"
			else
				src.icon_state = "compressor_on"

			src.alticon = "gcompressor_on"
			src.act = 1
			spawn(0) src.press_work()
		else
			usr << "\blue You turn [src] off."

			if(src.alted)
				src.icon_state = "gcompressor_off"
			else
				src.icon_state = "compressor_off"

			src.alticon = "gcompressor_off"
			src.act = 0
/obj/machine/gas/pipealike/pipe/compressor/proc/press_work()
	if(src.air < src.target_p)
		src.air += round(src.target_p / 2) || src.air++
	else if(src.target_p < src.air)
		src.air--
	spawn(5)
		if(src.act)
			spawn(0) src.press_work()
/obj/machine/gas/pipealike/pipe/compressor/verb/changepress()
	set name = "change target pressure"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	target_p = input("Current target pressure is [target_p]", "Change target pressure to what?", target_p) in list(0, 1, 2, 3, 5, 10, 15, 20, 25, 50, 75, 90, 100)
