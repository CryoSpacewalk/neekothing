/obj/putin
	density = 1
	icon = 'grafon/thingy.dmi'
	var/dead = 0
	var/hepe = 50
	var/active = 1
	var/obj/target = null
	icon_state = "hodovochka"
	name = "hodovochka"
	desc = "A dangerous creature, known to travel via bluespace sleeves and spread dangerous diseases"
	var/mode = "roaming"
	anchored = 0
/obj/putin_big{density = 1; icon = 'grafon/putin_big.dmi'; var/dead = 0; var/hepe = 200; var/active = 0; name = "Mother of Mnogohodovochkas"; desc = "A vile creation of insane demon Vladimir, able to spawn hodovochkas and wreak havoc if awakened."; icon_state = "putin_sleep"; var/mode = "sleep"; anchored = 0}
/obj/putin/New()





	spawn(5)
		src.roaming()

/obj/putin/attack_by(atom/movable/IT)

	if(istype(IT, /obj/item))

		var/I = IT

		if(prob(I:accu + usr:luck / 2))

			usr.show_message("[usr.name] hits [src.name] with [I:name]!", "You hit [src.name] with [I:name]!")
			src.biodmg(I:dmg + usr.empowered * 5 + usr.brutality + round(usr.euphoria / 20))

			if(I:sharp)
				src.playsound(pick('sounds/chop.ogg', 'sounds/sord.ogg'))
			else
				src.playsound('sounds/bash.wav')

			if(src:active && (I:veteranbane && prob(50 + round(usr:luck / 5))))
				src.show_message("[src.name] is burnt confused due to being hit by [I:name]!", "You burn and confuse [src.name] with [I:name]!")
				src.biodmg(I:dmg + round(usr.euphoria / 20))
				src.fuckup()
				return
			else

				return
		else


			usr.show_message("[src.name] dodges [usr.name]'s attack!")
			return
	else

		src.biodmg(25)
		return



/obj/putin/examine()
	usr << "[src.desc]"
	if(src.mode == "hunting")
		if(src.target in view(usr))
			usr << "\red This thing is on the run for [src:target:name] throat."
		else
			usr << "\red This thing is on the run for some poor sod's throat."
	else if(src.mode == "roaming")
		usr << "This thing crawls around in search for victim."
	else if(src.mode == "waiting")
		usr << "\red This thing tries to ambush somebody (probably you!)"
	else
		usr << "\red \bold This thing is off the rocket!"

/obj/putin/proc/fuckup()


	show_message("\red [src.name] looks confused.")
	biodmg(5)
	step_rand(src)
	icon_state = "hodovochka2"
	active = 0
	spawn(9)
		icon_state = "hodovochka"
		active = 1
		return

/obj/putin/proc/biodmg(dmg)

	new /obj/effect/goo_splash(src.loc)

	if(hepe >= dmg)
		hepe -= dmg
		return
	else


		show_message("\blue \bold [src.name] is ripped into pieces!")

		hide(src)
		return

/obj/putin/proc/roaming()

	if(!src || (src.deleted || src.mode == "hunting"))
		return

	if(prob(33))
		src.randombite()

	var/nodiag = pick(1, 2, 8, 4)
	step(src, nodiag)

	var/mob/trgt = null
	var/mobz = list()

	if(prob(20))

		for(var/mob/M in range(world.view, src))
			if(!M.dead && ((M.class == "man" || M.class == "robot") && M.z == src.z))
				mobz += M

		if(mobz:len)
			trgt = pick(mobz)





	if(trgt)
		src.target = trgt
		src.mode = "hunting"
		src.hunting()
		return
	else


		if(!src || (src.deleted || src.mode == "hunting"))
			return
		else
			spawn(9) src.roaming()

/obj/putin/proc/hunting()

	if(!src || (src.deleted || src.mode == "roaming"))
		return

	if(prob(33))
		src.randombite()

	step_to(src, src.target)

	if(src.target in range(1, src))
		src.bite(src.target)

	if(src.target:dead || !(src.target in range(world.view, src)) && prob(25))
		src.target = null
		src.mode = "roaming"
		src.roaming()
		return

	if(!src || (src.deleted || src.mode == "roaming"))
		return
	else

		spawn(7) src.hunting()

/obj/putin/proc/bite(mob/M)

	if(M:dead)
		src.show_message("[src.name] stares at [M:name]. Looks like it isn't interested in those already dead.")
		return
	else

		if(prob(M:psi / 4))
			show_message("\red [M:name] mysteriously avoids [src.name]'s attack!")
			playsound('sounds/om.wav')
			return
		else
			if(M:class == "robot")

				if(prob(M:luck / 5))
					show_message("[M:name] dodges [src.name] hungry mouth!")
					return
				else

					src.show_message("[src.name] bites [M:name], damaging not only robot, but teeth of itself!")
					src.biodmg(5)
					M:damaga(5, "brute")
					return
			else



				if(prob(20 + M:luck / 4 + M:stim * 20 + M:euphoria / 50))
					show_message("[M:name] dodges [src.name] hungry mouth!")
					return
				else

					src.show_message("[src.name] bites [M:name]!")
					M:damaga(10 - min(8, M:armor), "brute")
					if(prob(5))
						M << "\red \bold You feel sick."
						M:syphilis = 1
					return

/obj/putin/proc/randombite()

	if(!src || src.deleted)
		return

	for(var/obj/structure/window/W in range(1, src))
		if(W && prob(25))
			src.show_message("[src.name] claws [W.name]!")
			W.damage(4)

	for(var/obj/structure/reinforcement/R in range(1, src))
		if(R && prob(25))
			src.show_message("[src.name] claws [R.name]!")
			R.damage(5)

	for(var/obj/door/D in range(1, src))
		if(D && prob(25))

			if(D.material == "STEEL")
				if(prob(25))
					src.show_message("[src.name] tears out [D.name] reinforcement!")
					D.remove_reinforcement()
				else
					src.show_message("[src.name] claws [D.name] without any result!")
			else

				if(src.hepe > 20)
					for(var/mob/M in view(src))
						src.show_message("[src.name] claws [D.name]!")
						D.hepe -= 20
				else
					src.show_message("[src.name] rips [D.name] apart!")
					D.fuckup()

	var/L = list()
	for(var/mob/M in range(1, src))
		L += M

	var/victiM

	if(L:len)
		victiM = pick(L)

	if(victiM)
		src.bite(victiM)
	else
		return
/obj/machine/extractor
/obj/machine/worm
/obj/machine/activator
	icon_state = "activator"
	name = "Mind Potentor"
	desc = "A thing for awakening some potential inside of your tiny, drug-filled brain"
/obj/machine/brainscan
	icon_state = "brainscan"
	name = "Brain Spectroscope"
	desc = "For looking into one's brain"
/obj/machine/putinbeacon{icon = 'grafon/cult.dmi'; anchored = 0; bomb_proof = 10; closet_ok = 1; name = "Hodovochka disorientation beacon"; desc = "A result of USSR-4 biologists and engineers hard work, this thing will cause lesser hodovochkas to go insane in radius of 8 turfs as well as damage (alas, quite a weak) all kind of hodovochkas turfs when set up with either wrench or screwdriwer and activated."; icon_state = "off"; var/on = 0}
/obj/machine/putinbeacon/attack_hand()




	if(src.anchored)
		if(!src.on)
			usr << "\blue You activate disorientation beacon."
			src.sd_SetLuminosity(3)
			src.on = 1
			src.icon_state = "on_sec"
			src.madness()
		else
			usr << "\blue You disactivate disorientation beacon."
			src.sd_SetLuminosity(0)
			src.icon_state = "off_sec"
			src.on = 0
	else
		usr << "\red Set it first!"

/obj/machine/putinbeacon/attack_by(atom/movable/I)
	if(istype(src.loc, /turf/space))
		usr << "\red There's no surface to set up a beacon!"
	if(istype(I, /obj/item/tool/wrench) || istype(I, /obj/item/tool/screwdriver))
		if(!src.anchored)
			src.anchored = 1
			usr.break_pull()
			src.icon_state = "off_sec"
			usr << "You set up a beacon. Now activate it."
		else
			src.anchored = 0
			src.on = 0
			src.icon_state = "off"
			usr << "You unwrench the beacon."
		return

/obj/machine/putinbeacon/proc/madness()

	for(var/obj/putin_big/PB in range(6, src))
		if(prob(10))
			PB.hybernation()

	for(var/obj/putin/H in range(8, src))
		if(prob(80))
			H.fuckup()

		H.biodmg(rand(1, 3))

	if(prob(10))
		for(var/turf/T in range(2, src))
			new /obj/overlay/gaylight(T)
		for(var/mob/M in range(2, src))
			if(M.epilepsy > 2)
				M << "\red These flashes are too bright!"
				M.seizure(6)

	if(src.on)
		sleep(10)
		src.madness()
	else

		return


/obj/putin_big/New()


























	spawn(5)
		src.dreaming()

/obj/putin_big/attack_by(atom/movable/IT)

	if(istype(IT, /obj/item))

		var/I = IT

		if(prob(I:accu + usr:luck / 2))

			usr.show_message("[usr.name] hits [src.name] with [I:name]!", "You hit [src.name] with [I:name]!")
			src.biodmg(I:dmg + usr.empowered * 5 + usr.brutality + round(usr.euphoria / 20))

			if(I:sharp)
				src.playsound(pick('sounds/chop.ogg', 'sounds/sord.ogg'))
			else
				src.playsound('sounds/bash.wav')

			if(src:active && (I:veteranbane && prob(50 + round(usr:luck / 5))))
				show_message("\red \bold [I:name] burns [src.name]!")
				src.biodmg(I:dmg + usr.euphoria / 8)
				return
			else

				return
		else


			src.awakening()
			usr.show_message("[name] dodges [usr.name]'s attack!")
			return
	else

		src.biodmg(25)
		return

/obj/putin_big/examine()

	usr << "[src.desc]"
	if(src.mode == "sleep")
		usr << "\red This thing is asleep... for a while"
	else if(src.mode == "awake")
		usr << "This thing crawls around, spawning hodovochkas."
	else
		usr << "\red \bold This thing is off the rocket!"

/obj/putin_big/proc/awakening()




	if(src && (!src.deleted && src.mode == "sleep"))
		show_message("\red \bold [src.name] is awakened!")
		icon_state = "putin_big"
		mode = "awake"
		playsound('sounds/veteran.wav')
		roaming()
		return
	else
		return


/obj/putin_big/proc/biodmg(dmg)
	new /obj/effect/goo_splash(src.loc)

	if(hepe >= dmg)
		hepe -= dmg

		awakening()

		return
	else

		show_message("\blue \bold [src.name] is ripped into pieces!")
		hide(src)
		return

/obj/putin_big/proc/dreaming()


	if(!src || (src.deleted || src.mode == "awake"))
		return

	for(var/mob/M in range(world.view, src))

		if(!M.dead)

			if(prob(80))
				if(src in view(M))
					M << "\red [src.name] breathes deeply, but looks like it is still asleep. Anyway, this thing is fucking creepy and you should get outta here."
					M.calm--
				else

					M << "You can hear something breathing deeply. Damn, it gives you creeps."
					M.calm--

				src.playsound('sounds/hell_demon.ogg')
			else

				if(src in viewers(M))
					M << "\red \bold You've awakened [src.name]!"
				else
					M << "\red \bold Something is roaring in the darkness!"
				show_message("\red \bold [src.name] is awakened!")
				icon_state = "putin_big"
				mode = "awake"
				playsound('sounds/veteran.wav')
				roaming()
				return


	if(!src || (src.deleted || src.mode == "awake"))
		return
	else

		spawn(50) src.dreaming()

/obj/putin_big/proc/roaming()



	if(!src || (src.deleted || src.mode == "sleep"))
		return




	var/nodiag = pick(1, 2, 8, 4)
	step(src, nodiag)

	for(var/obj/furniture/F in range(1, src))
		F.show_message("\red [F.name] is toppled down!")
		var/B = new /obj/item/material/board(F.loc)
		B:charges = F.mat
		spawn(0)
			src.hide(F)

	if(prob(5))

		show_message("\red \bold [src.name]'s abdomen pulsates!")

		if(prob(50))
			show_message("Nothing happens.")
		else
			show_message("\red \bold A new hodovochka is born!")
			new /obj/putin(src.loc)

	if(!src || (src.deleted || src.mode == "sleep"))
		return
	else

		spawn(10) src.roaming()

/obj/putin_big/proc/randombite()


	if(!src || src.deleted)
		return

	for(var/obj/structure/window/W in range(1, src))
		if(W && prob(25))
			src.show_message("[src.name] claws [W.name]!")
			W.damage(8)

	for(var/obj/structure/reinforcement/R in range(1, src))
		if(R && prob(25))
			src.show_message("[src.name] claws [R.name]!")
			R.damage(10)

	for(var/obj/door/D in range(1, src))
		if(D && prob(25))

			if(D.material == "STEEL")
				if(prob(50))
					src.show_message("[src.name] tears out [D.name] reinforcement!")
					D.remove_reinforcement()
				else
					src.show_message("[src.name] claws [D.name] without any result!")
			else

				if(src.hepe > 50)
					for(var/mob/M in view(src))
						src.show_message("[src.name] claws [D.name]!")
						D.hepe -= 50
				else
					src.show_message("[src.name] rips [D.name] apart!")
					D.fuckup()

	var/L = list()
	for(var/mob/M in range(1, src))
		L += M

	var/victiM

	if(L:len)
		victiM = pick(L)

	if(victiM)
		src.bite(victiM)
	else
		return

/obj/putin_big/proc/bite(mob/M)



	if(M:dead)
		src.show_message("[src.name] stares at [M:name]. Looks like it isn't interested in those already dead.")
		return
	else
		if(prob(M:psi / 4))
			show_message("\red [M:name] mysteriously avoids [src.name]'s attack!")
			playsound('sounds/om.wav')
			return
		else
			if(M:class == "robot")

				if(prob(M:luck / 5))
					show_message("[M:name] dodges [src.name] hungry mouth!")
					return
				else

					src.show_message("[src.name] bites [M:name], damaging not only robot, but teeth of itself!")
					src.biodmg(15)
					M:damaga(5, "brute")
					return
			else



				if(prob(M:luck / 5))
					show_message("[M:name] dodges [src.name] hungry mouth!")
					return
				else

					src.show_message("[src.name] bites [M:name]!")
					M:damaga(18 - min(8, M:armor), "brute", sharp = 1)
					if(prob(15))
						M << "\red \bold You feel sick."
						M:syphilis = 1
						if(prob(33))
							M << "\red \bold Like, VERY sick."
							M:aids = 1
					return
