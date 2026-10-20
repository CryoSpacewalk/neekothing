/obj/wisp{density = 1; icon = 'grafon/effects/effects.dmi'; icon_state = "wisp"; var/stnd = 0; desc = "A disembodied spirit of some unlucky stranger, stuck here forever"; abyss_native = 1}
/atom/var/abyss_native = 0
var/list/abyssal_levels = list(7)
/obj/wisp/attack_by(obj/I)













	attack_hand()
/obj/wisp/attack_hand()
	usr << "\blue You distort [src.name], making it passable."
	stnd = 5
	density = 0
	icon_state = "wisp2"
/obj/wisp/New()
	src.sd_SetLuminosity(3)
	spawn(5) src.wisp_walk()
/obj/wisp/proc/wisp_walk()
	if(src.stnd)
		src.stnd--
	else
		src.density = 1
		src.icon_state = "wisp"
	step(src, pick(1, 2, 8, 4))
	spawn(20) src.wisp_walk()



/turf/var/hastent = 0
/turf/var/bombable = 1
/obj/rainbow/New()

	spawn(5) src.rainbow_walk()
/obj/rainbow/proc/rainbow_walk()
	step(src, pick(1, 2, 8, 4))
	if(prob(20))
		new /obj/effect/sparks(src.loc)
	if(prob(20))
		new /obj/effect/lightning(src.loc)
	if(prob(3))
		del(src)
	else
		spawn(20) src.rainbow_walk()
/turf/abyss
	icon = 'floor.dmi'
	name = "Void"
	desc = "A pure nothingness"
	icon_state = "void"
/turf/abyss
/turf/abyss/New()
	dir = pick(1, 2, 8, 4)
/turf/floor
	icon = 'floor.dmi'
/turf/floor/abyss
	name = "Abyss floor"
	icon_state = "abyss1"
/turf/floor/abyss/New()
	src.icon_state = "abyss[rand(1, 9)]"
	if(prob(1))
		var/T = new /obj/tentacle(src)
		T:dir = 1
/turf/abysswall
	density = 1
	opacity = 1
	icon = 'Wall.dmi'
	airtight = 1
	icon_state = "abyss1"
	name = "Abyss wall"
	desc = "It looks unstable."
/turf/abysswall
/turf/abysswall/New()
	..()
	src.sd_SetLuminosity(2)
	src.sd_lumcount = 7
	src.icon_state = "abyss[rand(1, 11)]"
	src.sd_LumUpdate()

	if(prob(3) && !src.hastent)
		for(var/turf/TF in range(1, src))
			if(!TF.density && (get_dir(src, TF) != 9 && (get_dir(src, TF) != 5 && (get_dir(src, TF) != 10 && get_dir(src, TF) != 6))))
				var/T = new /obj/tentacle(TF)
				if(TF.x < src.x && TF.y == src.y)
					T:dir = 8
					T:loc = locate(src.x - 1, src.y, src.z)
					src.hastent = 1
				if(TF.x > src.x && TF.y == src.y)
					T:dir = 4
					T:loc = locate(src.x + 1, src.y, src.z)
					src.hastent = 1
				if(TF.x == src.x && TF.y > src.y)
					T:dir = 1
					T:loc = locate(src.x, src.y + 1, src.z)
					src.hastent = 1
				if(TF.x == src.x && TF.y < src.y)
					T:dir = 2
					T:loc = locate(src.x, src.y - 1, src.z)
					src.hastent = 1

/turf/abysswall/attack_by(obj/I)
	if(istype(I, /obj/item/weapon/battleaxe) || (istype(I, /obj/item/tool/pickaxe) || (istype(I, /obj/item/tool/robot/robodrill) || (istype(I, /obj/item/tool/sonic_drill) || I:size >= 3 && prob(50)))))
		for(var/mob/M in view(5, usr))
			M << "\blue [usr] hits [src] with [I]!"
		if(prob(I:dmg))
			new /turf/floor/abyss(src)
		else
			usr << "\red [src] resists!"
	else if(istype(I, /obj/item/tool/sonic_drill))
		for(var/mob/M in hearers(usr))
			if(!M.sleeps)
				M << "\red WHEEEEW!"
		if(prob(I:dmg * 3))
			new /turf/floor/abyss(src)
		else
			usr << "\red [src] resists!"
	else if(istype(I, /obj/item/tool/airmeter))
		src.airscan()


/obj/landmark/blink
/obj/landmark/blink/Cross(atom/movable/A)
	A:smartblink(20, 2, src.loc)

/mob/proc/abyss_check()

	if(src.z == 7)

		if(src.see_invisible && prob(33))
			var/D = new /obj/drugged/dobman(src.loc)
			D:invisibility = 0
			D:clock *= 2
			D:laggy /= 2

		var/pity = 66
		if(src.cult)
			pity -= 50
		if(src.clothes)
			pity -= clothes:energyprotect
			pity -= src.clothes:size * 4
			if(istype(src.clothes, /obj/item/clothes/purificator))
				pity = 10
			else if(istype(src.clothes, /obj/item/clothes/abyss) || clothes:evil)
				pity = 0

		if(istype(src.loc, /turf/abyss))
			abyss_switch()
		else if(prob(pity * (see_invisible + 1)))
			abyss_switch()
		spawn(20) src.abyss_check()
	else

		return

/turf/proc/abyss_wipe()




	for(var/obj/overlay/antiabyss/A in src)
		if(A)
			return

	if(prob(50))
		new /turf/floor/abyss(src)
	else if(prob(50))
		for(var/obj/A in src)
			if(A.abyss_native)
				del(A)
		new /turf/abysswall(src)
	else if(prob(20))
		src.spacize(src)
	else if(prob(25))
		for(var/obj/A in src)
			if(A.abyss_native)
				del(A)
		new /turf/ice(src)
	else
		new /turf/floor/abyss(src)

/turf/proc/feature_gen()
	for(var/obj/overlay/antiabyss/A in src)
		if(A)
			return
	if(!src.density)
		if(prob(20))
			var/D = new /obj/item/diamond(src)
			D:abyss_native = 1
		if(prob(2))
			if(prob(33))
				var/obj/overlay/antiabyss/A = new /obj/item/readable/cult(src)
				A:abyss_native = 1
			else if(prob(50))
				var/obj/overlay/antiabyss/A = new /obj/item/collar(src)
				A:abyss_native = 1
			else if(prob(66))
				var/obj/overlay/antiabyss/A = new /obj/item/weapon/battleaxe/cutter(src)
				A:abyss_native = 1
			else
				var/obj/overlay/antiabyss/A = new /obj/item/weapon/battleaxe/abyss(src)
				A:abyss_native = 1
		if(prob(20))
			var/obj/overlay/antiabyss/A = new /obj/statue/abyss(src)
			A:abyss_native = 1
		else if(prob(25))
			var/obj/overlay/antiabyss/A = new /obj/effect/warp_splash(src)
			A:abyss_native = 1
		else if(prob(33))
			if(prob(25))
				var/obj/overlay/antiabyss/A = new /obj/cult/stalin_portrait(src)
				A:abyss_native = 1
			else if(prob(33))
				var/obj/overlay/antiabyss/A = new /obj/eye/orb/wicked(src)
				A:abyss_native = 1
			else if(prob(80))
				var/obj/overlay/antiabyss/A = new /obj/cult/haunt(src)
				A:abyss_native = 1
			else if(prob(50))
				var/obj/overlay/antiabyss/A = new /obj/cult/escape(src)
				A:abyss_native = 1
			else if(prob(80))
				var/obj/overlay/antiabyss/A = new /mob/ghost/wraith(src)
				A:abyss_native = 1
			else
				var/obj/overlay/antiabyss/A = new /mob/stalin/veteran(src)
				A:abyss_native = 1
		else if(prob(50))
			if(prob(25))
				var/obj/overlay/antiabyss/A = new /obj/fire/prespawned(src)
				A:abyss_native = 1
			else if(prob(33))
				src.bash_toxic()
			else if(prob(50))
				src.bash_caustic()
			else
				var/obj/overlay/antiabyss/A = new /obj/rainbow(src)
				A:abyss_native = 1
		else if(prob(50))
			new /obj/wisp(src)
		else if(prob(50))
			var/obj/overlay/antiabyss/A = new /obj/radio/speaker(src)
			A:abyss_native = 1
		else if(prob(50))
			var/obj/overlay/antiabyss/A = new /obj/bio/amoeba/evil(src)
			A:abyss_native = 1
		else if(prob(20))
			var/obj/overlay/antiabyss/A = new /obj/abyss_altar(src)
			A:abyss_native = 1
		else if(prob(50))
			var/obj/overlay/antiabyss/A = new /obj/structure/mine(src)
			A:abyss_native = 1
		else if(prob(50))
			var/obj/overlay/antiabyss/A = new /obj/steam/pedal/abyss(src)
			A:abyss_native = 1
		else if(prob(1))

			var/obj/overlay/antiabyss/A = new /obj/onewaytele(src)
			A:abyss_native = 1
		else if(prob(1))
			var/obj/overlay/antiabyss/A = new /obj/item/weapon/gun/curser(src)
			A:abyss_native = 1


		if(prob(1))
			var/H = new /obj/putin(src)
			H:abyss_native = 1
		if(prob(1))
			var/H = new /obj/structure/shocktrap/abyss(src)
			H:abyss_native = 1
		if(prob(5))
			var/LBS = new /obj/cult/lesser_banish(src)
			LBS:abyss_native = 1
	else

		if(prob(80))
			new /obj/drugged/dob_eye/abyss(src)
		else if(prob(1))
			var/obj/overlay/antiabyss/A = new /obj/machine/turret/abyss(src)
			A:abyss_native = 1

/mob/proc/abyss_switch()



	for(var/turf/T in range(src.client.view, src))
		if(istype(T, /turf/abyss))
			T.abyss_wipe()
		else
			var/abyss_protected = 0
			for(var/obj/overlay/antiabyss/A in src)
				if(A)
					abyss_protected = 1
			if(prob(10) && !abyss_protected)
				T.abyss_wipe()

	spawn(0)
		for(var/atom/A in view(src))
			if(A.abyss_native && prob(1 + 5 * A.anchored))
				del(A)
		for(var/atom/movable/A in view(src))
			if(istype(A.loc, /turf))
				for(var/obj/overlay/antiabyss/AA in src.loc)
					if(AA)
						return
				if(prob(10 - A.anchored * 8))
					A.blink(5)
		spawn(0)
			for(var/turf/T in view(src))
				for(var/obj/overlay/antiabyss/A in T)
					if(A)
						return
				if(prob(5) && !(src.loc == T))
					T.feature_gen()

/mob/proc/lesser_switch()
	for(var/turf/T in range(src.client.true_view, src))
		if(istype(T, /turf/abyss))
			T.abyss_wipe()
		else
			if(prob(3))
				T.abyss_wipe()
	spawn(0)
		for(var/turf/T in view(src))
			if(prob(1) && !(src.loc == T))
				T.feature_gen()

/atom/proc/abyss_corrupt(rangey)


	if(src.z == 7)
		return

	for(var/turf/T in range(rangey, src))

		var/abyss_protected = 0
		for(var/obj/overlay/antiabyss/A in T)
			if(A)
				abyss_protected = 1
		if(prob(50) && !abyss_protected)
			T.abyss_wipe()

	for(var/turf/TF in range(round(rangey * 1.5), src))

		if((istype(TF, /turf/floor) || (istype(TF, /turf/ice) || istype(TF, /turf/ground))) && prob(25))
			var/TC = new /obj/tentacle(TF)
			TC:dir = 1

/atom/movable/proc/banish()







	if(src.z != 7)
		if(istype(src, /mob))
			var/M = src
			M << "\red You fall into the waves of chaos"
			spawn(0) M:abyss_check()
		src.x = 43
		src.y = 43
		src.z = 7

/client/proc/banish_others(mob/M in world)
	set name = "Banish some fuckers"
	set category = "Pedal"
	M:banish()

/turf/proc/bash_toxic()



	for(var/turf/T in range(1, src))
		if(T != src)
			if(prob(20))
				var/C = new /obj/cloud/toxin(T)
				C:abyss_native = 1
	var/C = new /obj/cloud/toxin(src)
	C:abyss_native = 1

/turf/proc/bash_caustic()
	for(var/turf/T in range(1, src))
		if(T != src)
			if(prob(20))
				var/C = new /obj/cloud/prespawned(T)
				C:abyss_native = 1
	var/C = new /obj/cloud/prespawned(src)
	C:abyss_native = 1

/turf/proc/bash_firy()
	for(var/turf/T in range(1, src))
		if(T != src)
			if(prob(10))
				var/F = new /obj/fire/prespawned(T)
				F:abyss_native = 1
	var/F = new /obj/fire/prespawned(src)
	F:abyss_native = 1

/turf/proc/bash_shock()
	for(var/turf/T in range(1, src))
		if(T != src)
			if(prob(10))
				var/L = new /obj/effect/lightning(T)
				L:abyss_native = 1
	var/R = new /obj/rainbow(src)
	R:abyss_native = 1

/obj/effect/smite/New()



	..()
	spawn(10) del(src)


/mob/proc/smite()
	src << "\red \bold Something smites you!"
	new /obj/effect/smite(src.loc)

	var/muhsuit = 0
	if(clothes)
		if(src.clothes:evil_proof)
			muhsuit = 1

	if(muhsuit)
		src.damaga(rand(5, 8), "brute")
	else
		src.damaga(pick(5, 10, 15), "brute")
		if(prob(33))
			src.stun(rand(1, 4))

/mob/proc/bashroulette()

	var/muhsuit = 0
	if(src.clothes)
		if(clothes:evil_proof)
			muhsuit = 1

	if(src.abyss >= 0)
		src << "\blue The Powers of Abyss protects you from harmful abyssal effects."
		return
	else
		if(src.cult)
			src << "\blue Your belief in infernal stalinism protects you from harmful abyssal effects."
			return
		else
			if(prob(60 + src.luck) && muhsuit)
				src << "\blue Your purification suit protects you from harmful abyssal effects."
			else

				src << "\red A gate to the Abyss opens before your eyes for a second."
				var/T = src.loc
				var/bash_hui = pick(1, 2, 3, 4, 5)
				switch(bash_hui)
					if(1)
						T:bash_toxic()
					if(2)
						T:bash_caustic()
					if(3)
						T:bash_firy()
					if(4)
						T:bash_shock()
					if(5)
						src.smite()


/mob/ghost

/mob/ghost/wraith
	name = "Wraith"
	icon_state = "wraith"
	alticon = "gwraith"
	var/dis_prob = 0
/mob/ghost/wraith
/mob/ghost/wraith/proc/wraith_wrath()
	if(!src.stalk_target)
		step(src, pick(1, 2, 8, 4))

	if(prob(20))

		for(var/mob/M in range(1, src))
			if(M.mat == "flesh")
				var/skoschuha = 0
				if(M.clothes)
					if(M.clothes:evil)
						skoschuha += 25
					if(M.clothes:evil_proof)
						skoschuha += 50
				if(prob(skoschuha + round(M.euphoria / 2) + round(M.luck / 2)))
					M << "\blue You manage to resist [name]'s unholy influence!"
				else
					M << "\red The wraith touches you!"
					if(prob(50))
						M << "\red [src] fills you with chilling horror!"
						M.calm -= rand(1, 3)
					if(prob(25))
						M << "\red \bold [src.name] freezes your skin!"
						M.damaga(3, "burn")

	for(var/atom/movable/A in range(1, src))
		if(prob(2))
			if(!A.anchored)
				src.pulling = A
	if(prob(2))
		src.break_pull()
	if(prob(src.dis_prob))
		for(var/mob/M in view(src))
			M << "\blue [src] suddenly disappears"
			new /obj/effect/warp_splash(src.loc)
			spawn(0) del(src)
	spawn(0)
		src.stalk(80, 1, 1, 0, 0, 0)
		spawn(3.5) src.wraith_wrath()

/mob/ghost/wraith/New()
	wraith_wrath()

/mob/stalin
	realname = "Infernal Stalin"
	hepe = 666
	cult = 1
	mat = "ether"
	empowered = 5
	casts_shadow = 0
	name = "Infernal Stalin"
	icon_state = "hell"
	var/prophet = 0
	var/srulen = 1
/mob/stalin
/mob/stalin/proc/stalin_wrath()
	var/door2hit = list()
	for(var/obj/door/D in range(1, src))
		if(!D:fucked)
			var/nopenta = 1
			for(var/obj/cult/penta/P in D:loc)
				if(P)
					nopenta = 0
			for(var/obj/cult/lesser_banish/LB in D:loc)
				if(LB)
					nopenta = 0
			if(nopenta)
				door2hit += D


	if(!src.stalk_target && prob(50))
		step(src, pick(1, 2, 8, 4))

	if(src.z == 10 && (prob(50) && !src.stalk_target))
		for(var/obj/onewaytele/D in range(100, src))
			if(D)
				step_to(src, D)

	if(door2hit:len)
		var/obj/door/D = pick(door2hit)
		show_message("\red \bold [name] claws [D:name]!")
		if(D:hepe > 25)
			D:hepe -= 25
		else
			show_message("\red \bold [name] tears [D:name] apart!")
			D:fuckup()

	for(var/obj/furniture/F in range(1, src))
		F.show_message("\red [F.name] is toppled down!")
		var/B = new /obj/item/material/board(F.loc)
		B:charges = F.mat
		spawn(0)
			src.hide(F)

	if(prob(src:prophet * 5))
		src.say(pick("Do you hear the voices, too?", "Stalin is always glad to newcomers.", "Kill the faschist, burn the liberal, liberate the oppressed.", "Join infernostalinistic armed forces right now or die!", "Marxism-leninism is the only way to true liberation.", "For us, death is just the beginning."))

	if(prob(1))
		src.playsound('sounds/veteran.wav')

	if(prob(25))
		for(var/mob/M in range(1, src))
			if(!M.psiactive && (!M.cult && M.mat != "ether"))

				M.attack_hand(src)

	for(var/mob/M in hearers(src))
		if(!M.psiactive && (!M.cult && (M.mat != "ether" && (prob(2) && src:srulen))))
			new /obj/effect/warp_splash(loc)
			spawn(0)
				loc = M:loc
				new /obj/effect/warp_splash(loc)
				if(!M:sleeps)
					M << "\red [src.name] appears before your eyes!"

	for(var/mob/M in view(src))
		if(!M.psiactive && (!M.cult && (M.mat != "ether" && prob(src.empowered - 2))))
			src.say(pick("Hui!", "Pizdah!", "Jopa!", "Taste the Socialism in One Country, motherfucker!", "For the Motherland!"))

			M:smite()
	if(hepe <= 0)
		src << "\red \bold You're banished to the Hell!"
		ghostcount++
		show_message("\red \bold [src.name] is banished!")
		spawn(1)
			z = 2
			sleep(0)
			x = 5
			sleep(0)
			y = 5
			sleep(0)
			var/W = new /mob/ghost/wraith(src.loc)
			if(ckey)
				W:ckey = ckey
			W:name = "Shard of a Stalin's force"
			W:icon_state = "wraith2"
			spawn(0) del(src)
	else
		spawn(rand(3, 4))
			stalk(95, 0, 1, 1, 0, 0)
			stalin_wrath()

/mob/stalin/proc/vetericon()

	var/I_base = new /icon('grafon/player.dmi', "veteran_body[rand(1, 3)]")
	var/I_larm = new /icon('grafon/player.dmi', "veteran_larm[rand(1, 2)]")
	var/I_rarm = new /icon('grafon/player.dmi', "veteran_rarm[rand(1, 2)]")
	var/I_head = new /icon('grafon/player.dmi', "veteran_head[rand(1, 4)]")
	I_base:Blend(I_larm, 3, 1, 1)
	I_base:Blend(I_rarm, 3, 1, 1)
	I_base:Blend(I_head, 3, 1, 1)

	src.icon = I_base

/mob/stalin/New()
	if(!src:srulen)
		src.vetericon()
		src.toxdmg()
	src.realname = src.name
	src.stalin_wrath()
/mob/stalin/veteran
	srulen = 0
	hepe = 100
	empowered = 3
	icon_state = "veteran"
	name = "ancient veteran"
	desc = "A stalinistic veteran, damned to haunt Abyss forever."
/obj/landmark/abyss_gate
	icon_state = "abyss"
/mob/stalin/veteran/speaking
	prophet = 1
	brainport = new /obj/item/device/brainport/radio
	name = "ancient veteran"

/obj/landmark/abyss_gate/New()






	if(prob(33))
		new /obj/structure/abyss_gate(src.loc)
/obj/structure/abyss_gate
	icon_state = "abyss_gate"
	name = "Abyssal Gateway"
	desc = "This one-way gate leads to the Abyss: the source of primordial protomatter, the chtonic realm where nameless horrors reside. Beware, young one: once you enter The Gateway, it will be not so easy to return!"
/obj/structure/abyss_gate
	wrenchable = 1
/obj/structure/abyss_gate/Cross(mob/M)
	..()
	new /obj/effect/warp_splash(M:loc)
	M:banish()


/obj/abyssbeacon/New()











	src.sd_SetLuminosity(2)
	for(var/turf/T in range(4, src))
		var/A = new /obj/overlay/antiabyss(T)
		A:master = src

/obj/abyssbeacon/Move(NewLoc, Dir = 0, step_x = 0, step_y = 0)
	..()
	for(var/obj/overlay/antiabyss/A in range(4, src))
		if(A.master == src)
			del(A)
	for(var/turf/T in range(3, src))
		var/obj/overlay/antiabyss/A = new /obj/overlay/antiabyss(T)
		A:master = src

/obj/abyssbeacon/attack_by(obj/I)
	if(istype(I, /obj/item/reagent_container/cig))
		var/C = I
		C:smoke(usr)

/obj/abyss_altar/verb/pray()


















	set name = "Pray at the altar"
	set src in view(1)

	if(istype(usr, /mob/ghost))
		usr << "\blue You can't pray at the abyssal altars. It has a gateway out of Abyss for folks such as you, however."
		spawn(20)
			new /obj/effect/warp_splash(usr.loc)
			var/S
			for(var/turf/floor/start/ST in world)
				S = ST
			spawn(0)
				usr.loc = S
				new /obj/effect/warp_splash(usr.loc)
				return

	else if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to pray on such a thing!"
	else if(usr.cultplayer)
		usr << "\red Your bond to the Infernal Stalinism is too strong to end it that easy"
	else if(usr.abyss >= 0)
		usr << "\red You're already linked with the powers of Abyss!"
	else if(prob(33))
		usr << "\blue You hear a voice in your head:"
		usr << "\red \bold Яise up and dЯown trotskists and bouЯgeouses in their own blood! GloЯy to the deeds of the now-Ethernal comrade Stalin! Victory is ouЯs!"
		spawn(10)
			usr.cult()
	else
		usr << "\blue You hear a voice in your head:"
		usr << "\red \bold Look into the Abyss, my child"
		spawn(10)
			usr.turn_abyssal()



/obj/tentacle/proc/tentick()



	if(src.thp <= 0)
		del(src)
		return
	for(var/mob/M in range(1, src))
		if(!M.dead && prob(80))
			M << "You get slapped, ouch!"
			var/holey = 0
			if(M.clothes)
				if(istype(M.clothes, /obj/item/clothes/purificator))
					holey = 1
				if(M:clothes:evil)
					holey = 1
			if(holey)
				M << "\blue Due to your mystic armor, [name] only slightly scratches you!"
				M.damaga(pick(0, 1), "brute")
			else
				M.damaga(11 - rand(round(M.armor / 2), M.armor), "brute")
			spawn(0)
				if(M.dead)
					for(var/mob/MA in world)
						if(MA.abyss >= 0)
							MA.show_message("\blue \bold The Abyss somehow grants you with a bit of power.")
							MA.abyss++
	spawn(40)
		src.tentick()

/obj/tentacle/New()
	tentick()

/obj/tentacle/attack_hand(mob/M)
	if(("horns" in usr.mutations) && prob(15))
		usr.show_message("\red \bold [usr.name] headbutts [src.name] with his sharp horns!", "\red You headbutt [src.name] with your horns!")
		src.thp -= 5

	if(("hui" in usr.mutations) && prob(10))
		usr.show_message("\red \bold [usr.name] lashes [src.name] with his bloated penis!", "\red You lash [src.name] with your cock! So much fun!")
		usr.libido += 10
		src.thp -= 5

	if(prob(60 - usr.thrill + usr.euphoria + round(usr.luck / 2)))
		src.show_message("\blue [M:name] hits the tentacle!")
		src.thp -= rand(2, 6) + M:empowered
	else

		src.show_message("\red [M:name] misses the tentacle with his fists!")

	spawn(0)
		if(src.thp <= 0)
			del(src)
			return

/mob
	var/doubles_shift_turf = 0
/mob
	var/doubles_shift_obj = 0
/mob
	var/sinus_obj = 0
/mob
	var/turf_morphing = 0
/mob
	var/kaleido_morphing = 0
/mob
	var/quad_morphing = 0
/mob
	var/glitch_morphing = 0