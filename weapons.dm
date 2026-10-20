// Recovered from compiled neek.dmb (23 procs)

/obj/item/weapon/syringe_gun
	icon = 'grafon/item/liquid.dmi'
	dmg = 6
	desc = "A device for shooting syringes at the most difficult patients. Yes, captain is especially difficult one."
	icon_state = "syringe_gun"
	var/S

/obj/item/weapon/syringe_gun

/obj/item/weapon/gun

/obj/item/weapon/gun;/obj/item/weapon{icon = 'grafon/item/weapons.dmi'}

/obj/item/weapon/baton
	dmg = 7
	market_price = 50
	parry = 10
	name = "rubber baton"
	icon_state = "baton"

/obj/item/weapon/baton

/obj/item/weapon/whip
	dmg = 3
	painful = 10
	market_price = 80
	warpy = 1
	name = "neurowhip"
	desc = "A very special device for either neutralizing or torturing criminal scum. Oh, and it uses bluespace to hit further and penetrate such things as windows and barricades if you're psionic!"
	icon_state = "whip"

/obj/item/weapon/whip

/obj/item/weapon/samurai
	dmg = 34
	size = 3
	sharp = 1
	groovy = 50
	parry = 25
	market_price = 146
	name = "powersword"
	icon_state = "samurai"

/obj/item/weapon/samurai



/obj/item/weapon/samurai/attack(atom/A, mob/user)




	if(ismob(A))
		var/M = A
		if(M == user)
			M:can_move = 0
			M << "<font size=2 color=#[num2hex(160)][num2hex(20)][num2hex(120)]><b>The engine is off, assistants are fools</br>On shuttle lies plus-axe untouched</br>The traitor on station</b></font>"
			spawn(15)
				src.playsound('sounds/chop.ogg')
				M:damaga(101)
		else


			M:show_message("\red [user:name] swings katana right through [M:name]'s flesh!")
			M:playsound('sounds/chop.ogg')
			M:damaga(15 - rand(0, round(M:luck / 10)), "brute")
			M:limb_damage(25, 1, 100)
			..()

/obj/item/weapon/bat
	dmg = 20
	accu = 100
	size = 3
	extracrit = 5
	veteranbane = 1
	groovy = 20
	parry = 10
	market_price = 400
	name = "purification bat"
	icon_state = "bat"
	desc = "A very special piece of gear, designed for purging out veterans, spectres and cultists."

/obj/item/weapon/bat

/obj/item/weapon/battleaxe
	beltable = 1
	dmg = 26
	accu = 80
	size = 3
	sharp = 1
	extracrit = 5
	market_price = 300
	groovy = 30
	parry = 20
	icon_state = "axe"
	name = "combat axe"
/obj/item/weapon/battleaxe

/obj/item/weapon/battleaxe/abyss
	market_price = 600
	name = "exotic matter axe"
	icon_state = "axe_abyss"
	desc = "A weapon forged by somebody's (probably, yours) mind in the neverborn realm of Abyss, coated in a some kind exotic matter. Very powerful as a weapon and can cut walls as well."

/obj/item/weapon/battleaxe/abyss

/obj/item/weapon/battleaxe/slbrkr
	name = "rusty battleaxe"
	desc = "This piece of stuff've seen a better times"
	icon_state = "axe_slbrkr"

/obj/item/weapon/battleaxe/slbrkr


/obj/item/weapon/battleaxe/cutter
	dmg = 1
	groovy = 9001
	name = "delimbizer"

/obj/item/weapon/battleaxe/cutter

/obj/item/weapon/battleaxe/beheader
	dmg = 1
	groovy = 0
	name = "beheader"
/obj/item/weapon/battleaxe/beheader
/obj/item/weapon/battleaxe/beheader/attack(atom/A)
	if(istype(A, /mob))
		var/M = A
		M:decapitate()
	else
		..()


/obj/item/weapon/stunner
	stuntime = 1
	accu = 85

/obj/item/weapon/stunner

/obj/item/weapon/stunner/shock
	dmg = 1
	stuntime = 10
	market_price = 80
	igniter = 1
	name = "electric shock"
	icon_state = "shock"

/obj/item/weapon/stunner/shock

/obj/item/weapon/stunner/baton
	dmg = 5
	painful = 3
	stuntime = 15
	market_price = 180
	igniter = 1
	parry = 15
	name = "electric stick"
	icon_state = "stick"

/obj/item/weapon/stunner/baton


/obj/item/weapon/stunner/taser
	dmg = 4
	stuntime = 5
	name = "security taser"
	desc = "A special device for stunning criminal scum from a short distance."
	icon_state = "taser"

/obj/item/weapon/stunner/taser


/obj/item/weapon/stunner/taser/after_attack(A as mob|obj|turf, mob/user)


































	if(!istype(A, /turf) && sqrt((A:x - user:x) * (A:x - user:x) + (A:y - user:y) * (A:y - user:y)) == 1)
		A:attack_by(src, user, nurgaliev = 1)
	else if(sqrt((A:x - user:x) * (A:x - user:x) + (A:y - user:y) * (A:y - user:y)) < 3)
		var/T = new /obj/taser_dart(user:loc)
		step_towards(T, A:loc)
		spawn(1)
			if(T:loc:density)
				del(T)
				return
			else
				spawn(1)
					step_towards(T, A:loc)
				if(T:loc:density)
					del(T)
					return
				else
					for(var/mob/M in T:loc)
						for(var/mob/V in view(A))
							V << "\red [A] has been tasered by [user:name]!"
						if(round(M.armor / 5 + M.energyprotect / 3) < 6)
							M.stun(6 - round(M.armor / 5 + M.energyprotect / 3 + M.painless / 3))
						spawn(3)
							del(T)
							return
	else
		user << "\red It is too far!"


/obj/item/weapon/gun/blaster










/obj/item/weapon/gun
	accu = 70
	maxcharges = 1
	charges = 1
	var/firearm = 0
	var/obj/ammo_class = null
	var/obj/ammo = null
	var/obj/btr = null
	var/obj/projectile_type = /obj/lazor
	var/hunger = 0
	var/eupho_drain = 0
	var/chargeful = 1

/obj/item/weapon/gun/plasma
	igniter = 1
	maxcharges = 2
	charges = 0
	hunger = 5
	size = 4
	market_price = 600
	projectile_type = /obj/lazor/plasma
	name = "'Åucalyptus'-class plasma rifle"
	desc = "A heavy-duty weapon for dealing with massive crap."
	icon_state = "plasmagun_off"
	var/icon_basic = "plasmagun"

/obj/item/weapon/gun/plasma

/obj/item/weapon/gun/plasma/attack_by(obj/I)







	if(istype(I, /obj/item/battery))
		icon_state = "[icon_basic]_on"
		usr << "\blue You load the battery"
		var/B = new /obj/item/battery()
		B = I
		B:loc = src
		src.btr = B

		if(B:energy >= src.hunger)
			src.charges = round(B:energy / src.hunger)
		spawn(0) usr.delitem()
/obj/item/weapon/gun/plasma/verb/remove_btr()
	set name = "remove battery"
	set src in view(1)
	if(btr)
		icon_state = "[icon_basic]_off"
		var/B = new /obj/item/battery()
		B = btr
		B:loc = usr.loc
		usr << "\blue You remove the battery"
		charges = 0
		spawn(0) btr = null


/obj/hud

/obj/button
	icon = 'grafon/neekoUI.dmi'
	// ^ icon match was partial

/obj/button

/obj/hud_indicator
	icon = 'grafon/neekoUI.dmi'
	// ^ icon match was partial

/obj/hud_indicator

/obj/morda


/obj/time_bomb

/obj/taser_dart
	icon = 'grafon/thingy.dmi'
	// ^ icon match was partial
	icon_state = "dart"

/obj/taser_dart

/obj/blindzer
	icon = 'grafon/item/weapons.dmi'
	icon_state = "dart"
	name = "blinding dart"

/obj/blindzer



/obj/blindzer/proc/ruun()







	walk(src, src.dir, 0, 32)
	spawn(2)
		ruun()

/obj/item/weapon/gun/after_attack(A as mob|obj|turf, mob/user)
















	if(src.class == "robot" && user:class != "robot")
		user << "\red You have no idea how to use this thing."
		return
	if(src.chargeful)
		if(!charges)
			user << "\red Your gun beeps."
			return
		src.charges--
	if(!src:firearm)
		src.playsound('muzlo/pew.wav')
	if(src.btr)
		if(btr:energy >= src.hunger)
			btr:energy -= src.hunger
	if(src.eupho_drain)
		if(user:euphoria - src.eupho_drain < -10)
			user << "\red You're too unhappy to use this thing!"
			return
		user:euphoria -= src.eupho_drain
	var/L = new src.projectile_type(user:loc)

	L:target_x = A:x - user:x

	L:target_y = A:y - user:y

	L:process()

/obj/lazor

/obj/lazor
	icon = 'grafon/singulo.dmi'
	icon_state = "pewpew"
	alticon = "gpewpew"
	anchored = 0
	var/diggy = 0
	var/p_powah = 1
	var/target_x = 0
	var/target_y = 0
	var/p_bang = 0
	var/empwave = 0
	var/stunner = 0
	var/randomstun = 0
	var/op_pass = 1
	var/obj/current = null
/obj/lazor/New()
	..()
	sd_SetLuminosity(1)












/obj/lazor/process()





























	var/maxdistance = 40
	var/travdistance = 0
	spawn(0)
		while(src)
			if(!current || src.loc == current)
				current = locate(src.x + target_x, src.y + target_y, z)
			if(travdistance >= maxdistance || z != src.current:z)
				del(src)
				return
			travdistance++
			step_towards(src, current)
			for(var/obj/A as obj in src.loc)
				if(A.opacity && src.op_pass || (A.density && !src.op_pass || (istype(A, /obj/putin) || (istype(A, /obj/putin_big) || istype(A, /obj/bio/amoeba)))))
					src.Bump(A)
					return
			for(var/mob/M in loc)
				src.Bump(M)
				return
			for(var/obj/bio/weed/WD in loc)
				if(prob(20 + src.p_powah * 33))
					WD.grassdmg(30 * src.p_powah)
			if(loc:density)
				Bump(loc)
				return
			for(var/obj/cloud/C in loc)
				if(C.temp <= 25)
					C.temp += src.p_powah
				else if(C.temp < 26)
					C.temp = 26
			sleep(0.2 / world.tick_lag)
/obj/lazor/emp{empwave = 1; p_powah = 0.5; icon_state = "emp"}
/obj/lazor/Bump(atom/A)
	if(src:empwave)
		src.emp_blast(src:empwave - 1)
	if(src:p_bang)
		src.explosion(src:p_bang)
	else
		new /obj/effect/sparks(src.loc)
	if(src:diggy)
		if(istype(A, /turf/ice))
			var/turf/IC = A
			if(IC:hepe > round(src.p_powah * 4))
				IC:hepe -= round(src.p_powah * 4)
			else
				IC:digout()
	if(ismob(A))
		var/M = A
		if(M:item)
			if(prob(M:item:parry / 5))
				src.show_message("\red \bold [M:name] blocks [src] with his [M:item]! Fantastic!")
				del(src)
				return
		if(prob(src.psi / 6))
			src.show_message("\red [M:name] mysteriously avoids [src]!")
			src.playsound('sounds/om.wav')
			del(src)
			return
		if(prob(src:randomstun))
			M:stun(6)
		if(src.p_powah)
			new /obj/effect/blood_splash(M:loc)
			if(M:client)
				M << "\red \bold Ouch!"
		if(src.stunner)
			M:stun(src.stunner)
		if(!M:dead)
			M:damaga(src.p_powah * 60 - M:energyprotect, "burn")
	else if(istype(A, /obj/bio/amoeba))
		var/M = A
		M:biodmg(src.p_powah * 50)
	else if(istype(A, /obj/putin))
		var/M = A
		M:biodmg(src.p_powah * 40)
	else if(istype(A, /obj/putin_big))
		var/M = A
		M:biodmg(src.p_powah * 40)
	del(src)
/obj/lazor/diggy{diggy = 1; icon_state = "diggy_lazor"; alticon = "gdiggy_lazor"; p_powah = 0.5}
/obj/lazor/sol{alticon = "sol"; p_powah = 0.25; randomstun = 33; icon_state = "sol"}
/obj/lazor/plasma{icon_state = "plasma"; alticon = "gplasma"; p_powah = 2; p_bang = 1; op_pass = 0}
/obj/lazor/blindzer{icon = 'grafon/item/weapons.dmi'; icon_state = "dart"; name = "blinding dart"}
/obj/lazor/blindzer/Bump(atom/A)


	if(ismob(A))
		var/M = A
		if(prob(src.psi / 4))
			src.show_message("\red [M:name] mysteriously avoids [src]!")
			src.playsound('sounds/om.wav')
			return
		if(M:dead || M:sight == 1)
			del(src)
			return
		if(prob(50))
			if(M:client)
				M << "\red Ouch!"
			M:damaga(5 - M:energyprotect, "burn")
		if(M:client)
			M << "\red \bold Your eyes hurt!"
		M:sight = 1
		spawn(10)
			if(M)
				M:sight = 0
		M:dropitem(M:item)
	del(src)

/obj/item/weapon/gun/hand
	maxcharges = 10
	charges = 10
	hunger = 1
	size = 2
	market_price = 300
	projectile_type = /obj/lazor/sol
	name = "'Moonlight'-class battery handgun"
	desc = "A relatively weak handgun which sometimes stuns people."
	icon_state = "sol_off"
	var/icon_basic = "sol"
/obj/item/weapon/gun/hand
/obj/item/weapon/gun/hand/attack_by(obj/I)
	if(istype(I, /obj/item/battery))
		src.icon_state = "[src.icon_basic]_on"
		usr << "\blue You load the battery"
		var/B = new /obj/item/battery()
		B = I
		B:loc = src
		src.btr = B

		if(B:energy >= src.hunger)
			src.charges = round(B:energy / src.hunger)
		spawn(0) usr.delitem()
/obj/item/weapon/gun/hand/verb/remove_btr()
	set name = "remove battery"
	set src in view(1)
	if(btr)
		icon_state = "[icon_basic]_off"
		var/B = new /obj/item/battery()
		B = btr
		B:loc = usr.loc
		usr << "\blue You remove the battery"
		charges = 0
		spawn(0) btr = null



/obj/lazor/gas
	op_pass = 0
	icon_state = "gasbullet"
	var/spr
	var/obj/item/gas/tank/T

/obj/lazor/gas

/obj/lazor/gas/process()
	var/maxdistance = 35
	var/travdistance = 0
	var/prevloc = src.loc
	spawn(0)
		while(src)
			if(!current || src.loc == current)
				current = locate(src.x + target_x, src.y + target_y, z)
			if(travdistance >= maxdistance)
				del(src)
				return
			travdistance++
			step_towards(src, current)
			for(var/obj/A as obj in src.loc)
				if(istype(A, /obj/bio/amoeba) || (istype(A, /obj/putin) || istype(A, /obj/putin_big)))
					src.Bump(A)
					return
			for(var/mob/M in loc)
				src.Bump(M)
				return
			var/T = loc
			if(T:airtight)
				step_towards(src, prevloc)
				Bump(loc)
				return
			prevloc = loc
			sleep(0.2 / world.tick_lag)

/obj/lazor/gas/Bump(atom/A)

	if(src.T)
		src.T:open(loc)
		sleep(0)
		T:loc = src.loc
	else
		if(src.spr)

			src.spr:tank:open(loc)

			sleep(0)
			if(src.spr:igniter)
				for(var/obj/cloud/C in range(1, src))
					if(istype(C, /obj/cloud/fuel))
						C.burning = 1
						C.temp += 5
					else
						C.temp += 4

	if(istype(A, /mob))
		var/M = A
		if(M:armor > 5)
			M:damaga(2, "brute")
		else
			M:damaga(5, "brute")
		M << "\red A ball of compressed gas hits you!"

	if(istype(A, /obj/putin))
		var/P = A
		P:biodmg(5)
		src.show_message("\red A ball of compressed gas hits hodovochka!")
		if(prob(33))
			src.show_message("\red A hodovochka is shell-shocked!")
			P:fuckup()

	if(istype(A, /obj/putin_big))
		var/P = A
		P:biodmg(10)
		src.show_message("\red A ball of compressed gas hits Mother of Mnogohodovochkas!")
		if(prob(33))
			src.show_message("\red Looks like this creature is knocked out.")
			P:hybernation()

	if(istype(A, /obj/bio/amoeba))
		var/P = A
		P:biodmg(5)
		src.show_message("\red A ball of compressed gas hits giant amoeba! It is bounded down!")
		P:paralyzed = 10









	spawn(1) del(src)

/obj/item/weapon/spray
	dmg = 10
	accu = 70
	size = 2
	igniter = 0
	name = "gas spray"
	desc = "Creates a jet of gas from connected tank."
	icon_state = "spray"
	var/obj/item/gas/tank/tank = null
/obj/item/weapon/spray
/obj/item/weapon/spray/attack_self()
	if(src.tank)
		usr << "\blue You disconnect gas tank from your construction."
		src:tank:loc = usr.loc
		src.overlays = null
		spawn(0) src.tank = null
	else if(src.igniter)
		usr << "\blue You disconnect igniter from your construction."
		new /obj/item/device/igniter(usr.loc)
		src.igniter = 0
		src.icon_state = "spray"
/obj/item/weapon/spray/attack_by(obj/I)
	if(istype(I, /obj/item/gas/tank) && tank == null)
		src.connect(I)
		usr << "\blue You add a tank."
		spawn(0) usr.delitem()
	else if(istype(I, /obj/item/device/igniter) && igniter == 0)
		usr << "\blue You add an igniter."
		igniter = 1
		icon_state = "spray_i"
		spawn(0) usr.delitem()
/obj/item/weapon/spray/proc/connect(obj/T)
	src.tank = T
	src.overlays += T:o_left
	T:loc = src
/obj/item/weapon/spray/patched
	igniter = 1
	name = "gas spray"
	icon_state = "spray_i"
/obj/item/weapon/spray/patched/New()
	var/T = new /obj/item/gas/tank/fuel/deathsquad(src)
	src.connect(T)

/obj/item/weapon/spray/after_attack(A as mob|obj|turf, mob/user)
	if(src:tank && (src:tank:cl || (src:tank:tox || (src:tank:smk || (src:tank:anti || (src:tank:fuel || src:tank:regen))))))
		src.show_message("\red [user:name] shoots some compressed gas from his spray!", "\blue You shoot some compressed gas from your spray.")
		var/G = new /obj/lazor/gas(user:loc)
		G:spr = src
		G:target_x = A:x - user:x
		G:target_y = A:y - user:y
		G:process()

/obj/lazor/curser

/obj/lazor/curser/Bump(atom/A)

































	new /obj/effect/blood_splash(src.loc)
	if(ismob(A))
		var/M = A

		if(M:clothes:evil_proof)
			M << "\blue Your clothes protect you from unholy influence!"
			del(src)
			return
		else


			for(var/obj/item/I in M:contents)
				if(!I.veteranbane)
					if(istype(I, /obj/item/clothes))
						var/C = I
						if(!C:evil_proof)
							C:cursed = 1
					else
						I:cursed = 1
			del(src)

/obj/lazor/eupho
	icon_state = "eupho"
	alticon = "geupho"

/obj/lazor/eupho


/obj/lazor/eupho/Bump(atom/A)









	new /obj/effect/blood_splash(src.loc)
	if(ismob(A))
		var/M = A
		if(prob(src.psi / 4))
			show_message("\red [M:name] mysteriously avoids [src]!")
			playsound('sounds/om.wav')
			return
		if(M:cult)
			M << "\red IT BURNS"
			M:damaga(25, "burn")
			if(prob(50))
				M:stun(3)
		M:delirium += rand(2, 5)
		M:calm--
		M:euphoria -= rand(2, 5)
		M:psi++
		if(M:client)
			M << "\red \bold Ouch!"
		if(prob(10 - M:energyprotect))
			M:stun(2)
		if(!M:dead)
			M:damaga(8 - rand(1, M:energyprotect), "burn")
		M:says_xynta += rand(10, 40)
		if(prob(10))
			M:client:party()
		if(prob(5))
			M:blind(3)
	else if(istype(A, /obj/bio/amoeba))
		var/M = A
		M:biodmg(20)
	else if(istype(A, /obj/putin))
		var/obj/putin/M = A
		M:biodmg(45)
		show_message("\blue [M:name] looks completely fucked up!")
		M:fuckup()
	else if(istype(A, /obj/putin_big))
		var/PB = A
		PB:biodmg(45)
	del(src)
/obj/item/weapon/gun/curser
	projectile_type = /obj/lazor/curser
	cursed = 1
	market_price = 666
	eupho_drain = 20
	chargeful = 0
	icon_state = "curser"
	desc = "This skull on a stick gives you a chill..."
/obj/item/weapon/gun/eupho
	projectile_type = /obj/lazor/eupho
	market_price = 260
	eupho_drain = 5
	chargeful = 0
	name = "EuphoGun"
	desc = "A mysterious tantric device, draining user's euphoria after every shot. While not having a devastating firepower of blasters, its shots will have some funny side-effects on its victims."
	icon_state = "eupho"
/obj/item/weapon/gun/firearm{firearm = 1; charges = 0}
/obj/item/weapon/gun/firearm/attack_by(obj/I)

	if(istype(I, /obj/item/ammo) && I == src.ammo_class)
		usr << "\blue You reload your [src.name]"
		src.ammo:loc = usr.loc
		spawn(0)
			src.ammo = null
			var/A = new /obj/item/ammo()
			A = I
			A:loc = src
			src.ammo = A


		spawn(0) usr.delitem()
