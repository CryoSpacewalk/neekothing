/obj/item/tbranch
	desc = "Can be applied to the cable piece."
	name = "T-branch (without cable)"
	icon_state = "tcable0"
/obj/item/warpwire
	market_price = 20
	beltable = 1
	plastic_need = 1
	silicon_need = 1
	desc = "Can be applied to the cable piece."
	name = "Electron warper (without cable)"
	icon_state = "bluecable0"
/obj/item/extinguisher{icon = 'grafon/item/gas.dmi'; dmg = 10; accu = 75; parry = 5; beltable = 1; name = "Fire extinguisher"; icon_state = "extinguisher"; var/powah = 4}
/obj/item/extinguisher/heavy{dmg = 18; size = 4; powah = 10; parry = 10; name = "Heavy extinguisher"; desc = "Heavy extinguisher for heavy fires. Or for cleaning shit up."; icon_state = "extinguisher2"}
/obj/item/extinguisher/after_attack(turf/T, mob/user)






	var/i = src.powah
	while(i)
		var/F = new /obj/foam()
		if(istype(src.loc, /turf))
			F:loc = src.loc
		else
			F:loc = src.loc.loc
		sleep(2)
		F:fly(T)
		i--

/obj/foam
	icon = null /*icon id 73: unresolved*/
	icon = 'grafon/effects/chemistry.dmi'
	icon_state = "foam"
	var/amount = 0
	alticon = "gfoam"
/obj/foam/New()
	amount = rand(4, 7)
/obj/foam/proc/fly(turf/T)
	step_to(src, T, 1)
	for(var/obj/fire/F in src.loc)
		if(F.heat > 2)
			F.heat -= 3
		if(F.heat > 2 && prob(33))
			F.heat -= 3
		if(F.amount > 0 && prob(75))
			F.amount -= 1
		if(F && prob(15))
			del(F)
	for(var/atom/A in src.loc)
		if(A.density == 1)
			del(src)
		else
			for(var/atom/OB in src.loc)
				if(istype(OB, /obj/vomit) || (istype(OB, /obj/harch) || (istype(OB, /obj/blood) || (istype(OB, /obj/jizz) || (istype(OB, /obj/melt) || istype(OB, /obj/effect/rhinestones))))))
					del(OB)
	for(var/turf/TR in src.loc)
		TR.clean()
		if(TR.density == 1)
			del(src)
	if(src.amount > 0)
		src.amount -= 1
		spawn(2) fly(T)
	else
		del(src)


/obj/fire/prespawned
	heat = 25

/obj/fire/prespawned




/obj/fire/New()



































































































































	..()
	src.sd_SetLuminosity(2)
	spawn(5) src.burn()

/obj/fire/attack_by(obj/I)

	if(istype(I, /obj/item/reagent_container/cig))
		var/C = I
		C:smoke(usr)

/obj/fire/proc/burn()
	for(var/obj/bio/weed/WD in src.loc)
		if(prob(25))
			WD.grassdmg(src.heat)
	for(var/obj/bio/amoeba/AE in src.loc)
		if(prob(33))
			AE.biodmg(src.heat)
	for(var/obj/putin/AE in src.loc)
		if(prob(25))
			AE.biodmg(round(src.heat / 4))
	for(var/obj/putin_big/PB in src.loc)
		if(prob(25))
			PB.biodmg(round(src.heat / 4))
	for(var/obj/structure/montage_foam/F in src.loc)
		if(prob(20))
			del(F)
	for(var/obj/structure/reinforcement/R in range(1, src.loc))
		R.burn_damage(rand(1, 3))
	if(prob(20))
		var/lok
		lok = locate(src.x + pick(-1, 0, 1), src.y + pick(-1, 0, 1), src.z)
		if(!(lok:airtight == 1))
			src.loc = lok
		if(src.x == 1 || (src.y == 1 || (src.x == 80 || src.y == 80)))
			del(src)
	for(var/mob/M in src.loc)
		if(M.heatprotect < src.heat)
			M << "\red \bold The fire burns you!"
			M.damaga(src.heat - M.heatprotect, "burn")
	for(var/mob/M in viewers(src))
		if(M.epilepsy && prob(10))
			M << "\red \bold The fire is too bright!"
			M.seizure(3)
	for(var/obj/chemical/sensor/fire/F in src.loc)
		F.lockdown()
	for(var/obj/cloud/C in range(1, src))
		if(C)
			if(src.heat > C.temp || prob(33))
				C.temp += 1


	for(var/obj/cloud/C in range(1, src))
		if(C.fuel)
			C.burning = 1
	for(var/obj/item/reagent_container/consumable/bumblebee_dead/BD in range(1, src))
		if(!BD.crispy)
			BD.roast()
	if(prob(10))
		var/S = new /obj/cloud/smoke(src.loc)
		S:temp = src.heat
		S:abyss_native = src.abyss_native
		src.amount -= 1
	if(src.amount > 0)
		spawn(10) burn()
	else
		sleep(0)
		del(src)
/obj/item/gas{icon = 'grafon/item/gas.dmi'; beltable = 1; var/cl = 0; var/tox = 0; var/smk = 0; var/anti = 0; var/fuel = 0; var/regen = 0; var/heat = 0}
/obj/item/gas/tank{dmg = 10; accu = 70; parry = 5; name = "Gas tank"; icon_state = "unknown"; var/o_right = /obj/overlay/tube/unknownright; var/o_left = /obj/overlay/tube/unknownleft; var/igniter_channel; var/used = 0}
/obj/item/gas/tank/toxin{tox = 3; o_right = /obj/overlay/tube/toxright; o_left = /obj/overlay/tube/toxleft; icon_state = "tox"; name = "Gas tank (toxin)"}
/obj/item/gas/tank/antidote{anti = 3; o_right = /obj/overlay/tube/antiright; o_left = /obj/overlay/tube/antileft; icon_state = "anti"; name = "Gas tank (antidote)"}
/obj/item/gas/tank/fuel{fuel = 3; o_right = /obj/overlay/tube/fuelright; o_left = /obj/overlay/tube/fuelleft; icon_state = "fuel"; name = "Gas tank (fuel)"}
/obj/item/gas/tank/regenerite{regen = 3; o_right = /obj/overlay/tube/regenright; o_left = /obj/overlay/tube/regenleft; icon_state = "regen"; name = "Gas tank (regenerite)"}
/obj/item/gas/tank/chlorine{heat = 4; cl = 5; o_right = /obj/overlay/tube/chlorineright; o_left = /obj/overlay/tube/chlorineleft; icon_state = "chlorine"; name = "Gas tank (purification gas)"}
/obj/item/gas/tank/debug{smk = 7; heat = 22; name = "Debuggy tank"}
/obj/item/gas/tank/proc/add(G, A, GH)






	var/sum = cl + tox + smk + anti + fuel + regen
	if(A > 6 && sum > 6)
		explosion(round(A / 4 + sum / 4 + src.heat / 20))
		spawn(0) del(src)
	else if(A > 3 && sum > 6 || sum > 9)
		for(var/mob/M in range(1, src))
			if(src.loc == M)
				M.dropitem()
			M << "\red You see [src] breaking!"
		spawn(0)
			src.open()
			spawn(0) del(src)
	else if(A > 0)
		switch(G)
			if("cl")
				cl += A
			if("tox")
				tox += A
			if("smk")
				smk += A
			if("anti")
				anti += A
			if("fuel")
				fuel += A
			if("regen")
				regen += A
		src.heat = (src.heat * sum + GH * A) / (A + sum)
	src.inner_burn()

/obj/item/gas/tank/proc/inner_burn()
	if(src.heat > 4 && src.fuel > 0)







		src.heat += src.fuel
		var/oldfuel = src.fuel
		spawn(0)
			src.add("smk", oldfuel * 2, 22)
			spawn(1) src.fuel = 0
		if(src.heat > 4 && src.fuel > 0)
			spawn(5) src.inner_burn()

/obj/item/gas/tank/proc/open(turf/T)
	var/i = 0
	if(src.cl > 0)
		for(, i < src.cl, i++)
			spawn(0)
				var/C = new /obj/cloud/prespawned(T)
				C:temp = src.heat
	if(src.tox > 0)
		for(, i < src.tox, i++)
			spawn(0)
				var/C = new /obj/cloud/toxin(T)
				C:temp = src.heat
	if(src.smk > 0)
		for(, i < src.smk, i++)
			spawn(0)
				var/C = new /obj/cloud/smoke(T)
				C:temp = src.heat
	if(src.anti > 0)
		for(, i < src.anti, i++)
			spawn(0)
				var/C = new /obj/cloud/antidote(T)
				C:temp = src.heat
	if(src.regen > 0)
		for(, i < src.regen, i++)
			spawn(0)
				var/C = new /obj/cloud/regenerite(T)
				C:temp = src.heat
	if(src.fuel > 0)
		if(src.heat > 4)
			for(, i < src.fuel, i++)
				spawn(0)
					var/F = new /obj/fire(T)
					F:amount = 1
					F:heat = src.heat
		else
			for(, i < src.fuel, i++)
				spawn(0)
					var/C = new /obj/cloud/fuel(T)
					C:temp = src.heat
	src.cl = 0
	src.tox = 0
	src.smk = 0
	src.anti = 0
	src.fuel = 0
	src.regen = 0

/obj/item/gas/tank/attack_self()

	usr << "\blue You open [src]."
	for(var/mob/M in view(usr))
		M << "\red [usr] opens [src]!"
	src.open(usr.loc)

/mob/proc/breathe(obj/I)


	var/sum = I:cl + I:tox + I:smk + I:anti + I:fuel + I:regen
	if(sum <= 0)
		return
	else
		if(I:cl > 0)
			src << "\red \bold Your throat burns."
			src.damaga(6, "organ")
			src.toxins += 5
			I:cl -= 1
		if(I:heat > 0)
			src << "\red \bold You feel a heat in your throat!"
			src.damaga(I:heat, "organ")
		if(I:tox > 0)
			src.toxins += 10
			I:tox -= 1
		if(I:fuel > 0)
			src.toxins += 1
			I:fuel -= 1
		if(I:smk > 0)
			src.toxins += 1
			I:smk -= 1
		if(I:anti > 0)
			if(src.toxins > 10)
				src.toxins -= 10
			else
				src.toxins = 0
			I:anti -= 1
		if(I:regen > 0)
			if(src.hepe < 100)
				src.hepe += 10
			I:regen -= 1
		spawn(0) src.breathe(I)

/obj/item/gas/tank/attack_by(obj/I)













	if(istype(I, /obj/item/device/mask))
		usr << "\blue You connect [I] to the [src]."
		var/M = new /obj/item/gas/mask(usr.loc)
		M:cl = cl
		M:tox = tox
		M:smk = smk
		M:anti = anti
		M:fuel = fuel
		M:regen = regen
		M:heat = heat
		M:icon_state = src.icon_state
		M:overlays += /obj/overlays/mask
		spawn(0)
			del(I)
			spawn(0)
				del(src)
	else if(istype(I, /obj/item/device/signiter))
		if(src.igniter_channel == null)
			src.igniter_channel = I:charges
			src.overlays += /obj/overlay/signiter
			spawn(0) del(I)
	else
		if(istype(I, /obj/item/cable))

			if(src.igniter_channel)

				var/C = I
				C:cminus(1)
				usr << "\blue You wire up your gas tank. Alas, but now you will be unable to blow it up via signaller."
				src.igniter_channel = null
				var/TW = new /obj/item/gas/tripwire(usr.loc)
				TW:tank_charge = src
				usr.change_hands()
				usr.dropitem()
				src.loc = TW
				spawn(0) return
			else

				usr << "\red \bold You have to connect igniter first!"
				return
		else
			if(istype(I, /obj/item/tool/airmeter))
				var/sum = cl + tox + smk + anti + fuel + regen
				usr << "\blue Amount of gas: [sum]</br> Amount of chlorine: [cl]</br> Amount of toxin: [tox]</br> Amount of burn product: [smk]</br> Amount of antidote: [anti]</br> Amount of gas fuel: [fuel]</br> Amount of regenerite: [regen]</br> Temperature: [heat]"
/obj/item/gas/mask{name = "Gas tank (with mask)"}
/obj/item/gas/mask/attack_self()
	var/ml["Open"]
	ml += list("Breathe", "Remove mask")
	var/method = input("What you want to do now?", "", "Breathe") in ml
	switch(method)
		if("Breathe")
			usr.breathe(usr.item)
		else
			new /obj/item/device/mask(usr.loc)
			var/T = new /obj/item/gas/tank(usr.loc)
			T:cl = src.cl
			T:tox = src.tox
			T:smk = src.smk
			T:anti = src.anti
			T:fuel = src.fuel
			T:regen = src.regen
			T:heat = src.heat
			T:icon_state = src.icon_state
			spawn(0)
				del(src)


/obj/item/gas/tube
	name = "Tank transfer tube"
	icon_state = "tube"
	var/obj/item/gas/tank/left
	var/obj/item/gas/tank/right
	var/channel
	var/obj/signaler = null

/obj/item/gas/tube
/obj/item/gas/tube/proc/connection(obj/I)
	if(src.left == null)
		src.left = I
		src.overlays += I:o_left
		spawn(0)
			usr.dropitem()
			I:loc = src
	else if(src.right == null)
		src.right = I
		src.overlays += I:o_right
		spawn(0)
			usr.dropitem()
			I:loc = src
/obj/item/gas/tube/proc/apply(obj/S)
	if(src.signaler == null)
		src:channel = S:charges
		src.signaler = S
		spawn(0)
			usr.dropitem()
			S:loc = src
/obj/item/gas/tube/radio{channel = 1; name = "Tank transfer tube"}
/obj/item/gas/tube/attack_by(obj/I)
	if(istype(I, /obj/item/gas/tank))
		usr << "\blue You connect [I] to the [src]."
		src.connection(I)
	else if(istype(I, /obj/item/device/signaler))
		usr << "\blue You connect [I] to the [src]."
		src.apply(I)

/obj/item/gas/tube/attack_self()




	var/ml["Open"]
	if(src.left)
		ml += list("Open", "Remove tanks")
	var/method = input("What you want to do now?", "", "Open") in ml
	switch(method)
		if("Remove tanks")
			if(usr.item == src)
				src.overlays = null
				if(src.right)
					src.right:loc = usr.loc
					spawn(0) src.right = null
				if(src.left)
					src.left:loc = usr.loc
					spawn(0) src.left = null
		if("Open")
			if(usr.item == src)
				usr << "\blue You open tube's valve."
				valve()

/obj/item/gas/tube/proc/valve()
	if(src.right && src.left)
		var/l_sum = left:cl + left:smk + left:tox + left:fuel + left:anti + left:regen
		var/r_sum = src:right:cl + src:right:smk + src:right:tox + src:right:fuel + src:right:anti + src:right:regen
		src.heat = (src:left:heat * l_sum + src:right:heat * r_sum) / (l_sum + r_sum)
		src.cl += src:left:cl
		src:left:cl = 0
		src.cl += src:right:cl
		src:right:cl = 0
		src.tox += src:left:tox
		src:left:tox = 0
		src.tox += src:right:tox
		src:right:tox = 0
		src.smk += src:left:smk
		src:left:smk = 0
		src.smk += src:right:smk
		src:right:smk = 0
		src.fuel += src:left:fuel
		src:left:fuel = 0
		src.fuel += src:right:fuel
		src:right:fuel = 0
		src.anti += src:left:anti
		src:left:anti = 0
		src.anti += src:right:anti
		src:right:anti = 0
		src.regen += src:left:regen
		src:left:regen = 0
		src.regen += src:right:regen
		src:right:regen = 0
		src.raspr()

/obj/item/gas/tube/proc/raspr()
	left:cl += round(src.cl / 2)
	right:cl += src.cl - round(src.cl / 2)
	left:fuel += round(src.fuel / 2)
	right:fuel += src.fuel - round(src.fuel / 2)
	left:tox += round(src.tox / 2)
	right:tox += src.tox - round(src.tox / 2)
	left:smk += round(src.smk / 2)
	right:smk += src.smk - round(src.smk / 2)
	left:anti += round(src.anti / 2)
	right:anti += src.anti - round(src.anti / 2)
	left:regen += round(src.regen / 2)
	right:regen += src.regen - round(src.regen / 2)
	right:heat = src.heat
	left:heat = src.heat
	src.cl = 0
	src.tox = 0
	src.smk = 0
	src.fuel = 0
	src.anti = 0
	src.regen = 0
	spawn(0)
		src.overlays = null
		if(istype(loc, /mob))
			src.right:loc = src.loc.loc
			src.left:loc = src.loc.loc
		else
			src.right:loc = loc
			left:loc = src.loc
		spawn(0)
			src.left:inner_burn()
			src.right:inner_burn()
			src.left = null
			src.right = null

/obj/item/gas/tank/proc/ignite()





















































	if(src.used == 0)
		src.used = 1
		src.heat += 2
		inner_burn()
		for(var/mob/M in view(src))
			M << "\blue Spark-spark."
	else
		for(var/mob/M in view(src))
			M << "\red The igniter hisses without sparking."




/obj/item/gas/loader
	parry = 10
	dmg = 7
	accu = 70
	name = "gastank loader (0)"
	var/realicon = "loader"
	icon_state = "loader0"
	desc = "Allows you to spread gases at the rapid speed."
	var/tanks = list()
	var/maxtanks = 3
	var/tankcount = 0

/obj/item/gas/loader



/obj/item/gas/loader/attack_by(obj/A)
	if(istype(A, /obj/item/gas/tank))
		if(tankcount >= maxtanks)
			usr << "\red It is full!"
		else
			var/T = A
			if(T:igniter || T:igniter_channel)
				usr << "\red This tank is assembled with some kind of device and doesn't fit into loader!"
			else if(T:cl || (T:tox || (T:smk || (T:anti || (T:fuel || T:regen)))))
				A:loc = src
				tanks += A
				tankcount++
				icon_state = "[realicon][tankcount]"
				name = "gastank loader ([tankcount])"
				spawn(0) usr.delitem()
			else
				usr << "\red It is pointless to load this thing with empty tanks. Fill it with something first, please!"

/obj/item/gas/loader/after_attack(A as mob|obj|turf, mob/user)
	if(tanks:len)

		var/T = pick(tanks)
		if(T)
			show_message("\red [user:name] shoots some compressed gas from his gastank loader!", "\blue You shoot some compressed gas from your gastank loader.")
			var/G = new /obj/lazor/gas(user:loc)
			G:T = T
			T:loc = G
			tankcount--
			icon_state = "[realicon][tankcount]"
			name = "gastank loader ([tankcount])"
			tanks -= T
			G:target_x = A:x - user:x
			G:target_y = A:y - user:y
			G:process()
	else

		usr << "\red It is out of tanks!"
/obj/item/gas/loader/combat
	realicon = "loader_big"
	parry = 15
	dmg = 10
	market_price = 300
	icon_state = "loader_big4"
	name = "gastank loader (4)"
	desc = "A heavier version of common gastank launcher, already patched with some hot chlorine."
/obj/item/gas/loader/combat
/obj/item/gas/loader/combat/New()
	while(src.tankcount <= src.maxtanks)
		var/PR = new /obj/item/gas/tank/chlorine(src)
		src.tanks += PR
		src.tankcount++
		sleep(0)


/obj/item/gas/tripwire
	var/B
	name = "unfinished tripwire"
	icon_state = "tripwire_raw"
	var/obj/item/gas/tank/tank_charge

/obj/item/gas/tripwire
/obj/item/gas/tripwire/examine()
	if(src.B)
		usr << "This tripwire has a battery."
	else
		usr << "This tripwire lacks battery!"
	if(src.tank_charge)
		usr << "This tripwire has [tank_charge:name] as a charge."
	else
		usr << "This tripwire lacks charge!"

/obj/item/gas/tripwire/attack_by(obj/I)
	if(istype(I, /obj/item/battery))
		var/BT = I
		if(BT:energy < 10)
			usr << "\red \bold You need a fully-charged battery or your tripwire wouldn't detonate!"
			return
		else
			src.icon_state = "tripwire"
			usr.dropitem()
			src.B = BT
			BT:loc = src
			src.desc = "A tripwire. Install it somewhere and wait for the victim to trip on it. It will heat the contents of gastank by <b>5pts</b>, which (if you've done everything right) will cause detonation."

/obj/item/gas/tripwire/attack_self()
	if(!src.B || !src.tank_charge)
		return
	for(var/obj/structure/shocktrap/ST in usr.loc)
		if(ST)
			usr << "\red You can't set tripwires over stun traps!"
			return
	var/tripdir = input("Do you want it vertical or horisontal?") in list(1, 8)
	if(usr in range(1, src))
		var/TW = new /obj/set_tripwire(usr.loc)
		usr.dropitem()
		TW:dir = tripdir
		TW:TNK = src.tank_charge
		src.tank_charge:loc = TW
		usr << "\blue You carefully set your tripwire. Don't you step on it by accident, young terrorist!"
		spawn(0) del(src)

/obj/item/pipe
	icon = 'grafon/item/gas.dmi'
	size = 3
	dmg = 9
	parry = 10
	accu = 75
	icon_state = "pipe"
	var/obj/result = /obj/machine/gas/pipealike/pipe

/obj/item/pipe


/obj/item/pipe/verb/rotate()



















































































































































































































































































































































































































































































































































































	set src in range(1)

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.dir in list(1, 2, 8, 4))
		if(dir == 1 || dir == 2)
			src.dir = 4
		else
			src.dir = 1
	else
		if(dir == 6)
			dir = 10
		else if(dir == 10)
			dir = 9
		else if(dir == 9)
			dir = 5
		else
			dir = 6
/obj/item/pipe/attack_by(obj/I)
	if(istype(I, /obj/item/tool/torch) && I:charges > 0)
		usr << "\blue You weld the pipe fragment."
		I:fuel(-1)
		if(src in usr)
			var/O = new src.result(usr.loc)
			O:dir = src.dir
		else
			var/O = new src.result(loc)
			O:dir = dir
		spawn(0) del(src)

/obj/item/pipe/attack_self()
	rotate()
