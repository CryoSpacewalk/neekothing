// Recovered from compiled neek.dmb (26 procs)

/obj/tick
	icon = null /*icon id 75: unresolved*/
	icon = 'grafon/hud_effects.dmi'
	name = "caphopper tick"
	desc = "OH NO THEY'RE IN MY EYES"
	icon_state = "tick"
	var/obj/t_host = null
/obj/tick/Click()
	var/M = src.loc
	var/hands = 0
	var/legs = 0
	for(var/obj/limb/LB in M:limbs)
		if(LB.name == "r_leg" || LB.name == "r_leg")
			legs = 1
		if(LB.name == "r_hand" || LB.name == "l_hand")
			hands++

	if(prob(33 * hands))
		M << "You carefully remove the tick from your eye."
		src.death()
	else if(!hands && (legs && prob(25)))
		M << "\red You kick yourself in the eye, removing tick in proccess!"
		M:damaga(10, "brute")
		src.death()
	else

		M << "\red You fail to remove the tick!"
		return



/obj/tick/proc/plant(mob/M)

	if(M:client)
		M:client:screen += src
		src.t_host = M
		src.screen_loc = "[rand(2, 12)],[rand(2, 12)]"
		spawn(10) src.life()
	else
		return

/obj/tick/proc/death()
	if(src.t_host)
		src.t_host << "\green The tick falls off your eyes! What a relief!"
	spawn(0)
		del(src)
		return

/obj/tick/proc/bite_victim(mob/vctm)

	vctm << "\red The tick bites you in the eye and sucks some of your blood! Ouch!"
	vctm:damaga(1, "brute")
	vctm:damaga(4, "organ")

	if(prob(5))
		vctm << "\red \bold You feel sick."
		vctm:syphilis = 1

/obj/tick/proc/life()


	if(prob(10))
		src.bite_victim(src.t_host)

	spawn(10)
		if(src)
			src.life()

/mob/proc/infest()

	var/tick_amt = rand(5, 12)


	src << "\red \bold Caphopper ticks are crawling into your eyes! Take them out!"
	src.calm--

	if(calm < 0)
		src << "\red \bold [pick("THEY'RE IN MY EYES", "OH DAMN REMOVE IT")]"

	for(var/i = 0, i < tick_amt, i++)
		var/T = new /obj/tick(src)
		T:plant(src)

/obj/bio/tick_swarm
	icon = 'grafon/thingy.dmi'
	// ^ icon match was partial
	icon_state = "tick"
	name = "caphopper tick swarm"
	desc = "A swarm of caphopper ticks, which are among the most dangerous parasites known to USSR-4."

/obj/bio/tick_swarm
	anchored = 0

/obj/bio/tick_swarm/Crossed(atom/movable/O)




	..()

	sleep(0)

	for(var/obj/fire/F in src.loc)
		if(F)
			src.show_message(msg = "\red [src.name] burns!")
			spawn(0)
				del(src)
	for(var/obj/cloud/C in src.loc)
		if(!istype(C, /obj/cloud/regenerite) && !istype(C, /obj/cloud/antidote))
			src.show_message(msg = "\red [src.name] is poisoned!")
			spawn(0)
				del(src)
	if(istype(O, /mob))
		if(prob(5))
			src.show_message(msg = "\red \bold [O:name] steps on [src.name], killing bloodsucking fuckers for good!")
			spawn(0)
				del(src)
		else
			src.show_message(msg = "\red [O:name] steps on [src.name], but it looks like those ticks are too damn tough to be stomped that easy!")

/obj/bio/tick_swarm/attack_hand(mob/user)

	var/legs = 0
	for(var/obj/limb/LB in user:limbs)
		if(LB.name == "r_leg" || LB.name == "r_leg")
			legs++

	if(prob(25 * legs))

		user:show_message(msg = "\red [user:name] stomps on the swarm of ticks, killing bloodsucking fuckers for good!", selfmsg = "You stomp on the swarm of ticks!")
		spawn(0)
			del(src)
			return
	else
		if(!legs && prob(20))

			user:show_message(msg = "\red [user:name] crushes the swarm of ticks with his bare hands, killing bloodsucking fuckers for good!", selfmsg = "You crush the swarm of ticks!")
			spawn(0)
				del(src)
				return
		else

			user << "\red You try to destroy [name], but miss!"
			return

/obj/bio/tick_swarm/attack_by(obj/item/I, mob/user)


	if(prob(I:extracrit + user:luck + round(I:groovy / 4) + round(user:euphoria / 3) + round(I:dmg / 5) + min(5, user:empowered) + min(5, user:brutality) - user:thrill))

		user:show_message(msg = "\red [user:name] smashes swarm of ticks with his [I:name], killing bloodsucking fuckers for good!", selfmsg = "You smash the swarm of ticks with your [I:name]!")
		spawn(0)
			del(src)
			return
	else

		user << "\red You try to destroy [src.name], but miss!"
		return

/obj/bio/tick_swarm/New()
	spawn(10) src.life()

/obj/bio/tick_swarm/proc/life()



	if(prob(50))
		src.density = 1
		step_rand(src)
		sleep(0)
		src.density = 0

	if(prob(10))
		var/lap_targets = list()
		for(var/mob/M in range(1, src))
			if(!M.dead && M.mat == "flesh")
				lap_targets += M
		if(lap_targets:len)
			var/mob/trgt = pick(lap_targets)
			src.lap(trgt)

	spawn(5)
		if(src)
			src.life()

/obj/bio/tick_swarm/proc/lap(mob/M)


	step(src, M:loc)
	M:infest()

	spawn(0)
		del(src)
		return

/obj/bio/bumblebee
	density = 1
	layer = 4
	icon = 'grafon/thingy.dmi'
	// ^ icon match was partial
	var/hepe = 23
	name = "bombus lucidum"
	icon_state = "bumblebee"
	desc = "A huge glowing bumblebee, slowly floating through the darkness of Baikonur-5."
	var/last_milked = -500

/obj/bio/bumblebee
	anchored = 0
/obj/bio/bumblebee/New()


	src.sd_SetLuminosity(3)
	src.life()

/obj/bio/bumblebee/proc/life()

	if(prob(66))
		step_rand(src)

	if(prob(66))
		src.consume()

	if(prob(2))
		src.playsound('sounds/Bombus_buzz.ogg', loudness = 33)

	for(var/mob/M in range(1, src))
		if(M.mat == "flesh" && !M.dead)
			if(prob(10))
				M.show_message("\red [src.name] stings [M.name]!", "\red [src.name] stings you!")
				M.add_chem("toxin", "toxin", rand(1, 5), 0)
				src.playsound('sounds/Bombus_buzz.ogg', loudness = 50)

	spawn(8)
		if(src && !src.deleted)
			src.life()

/obj/bio/bumblebee/proc/bee_damage(amt)

	if(src.hepe > amt)
		src.hepe -= amt
	else
		src.death()

/obj/bio/bumblebee/proc/milk(obj/RC)

	if(world.time - src.last_milked < 500)
		usr << "\red You're milking your bumblebee too frequently! Give it some time to rest!"
		return
	else
		if(istype(RC, /obj/item/reagent_container/beaker))

			if(RC:maxamount < 30)
				usr << "\red \bold This vial is too small!"
				return

			for(var/datum/reagent/R in RC)
				if(R)
					usr << "\red You need an empty vial to milk bumblebees!"
					return

			sleep(0)

			usr << "\green You carefully milk [src.name]"
			src.last_milked = world.time
			RC:add_chem("toxin", "toxin", rand(5, 10))
			RC:add_chem("sugar", "sugar", 10)
			if(prob(5 + usr.luck))
				RC:add_chem("Nuclear titbit", "Nuclear titbit", 5)

/obj/bio/bumblebee/proc/death()
	src.sd_SetLuminosity(0)
	new /obj/item/reagent_container/consumable/bumblebee_dead(loc)
	spawn(0) src.hide(src)

/obj/bio/bumblebee/Crossed(atom/movable/O)

	..()

	sleep(0)

	for(var/obj/fire/F in src.loc)
		if(F)
			src.show_message(msg = "\red [src.name] burns!")
			spawn(0)
				death()
	for(var/obj/cloud/C in src.loc)
		if(!istype(C, /obj/cloud/regenerite) && !istype(C, /obj/cloud/antidote))
			src.show_message(msg = "\red [src.name] is poisoned!")
			spawn(0)
				death()

	if(istype(O, /obj/lazor))
		src.show_message(msg = "\red [src.name] is shot!")
		spawn(0)
			var/L = O
			src.bee_damage(L:p_powah)


/obj/bio/bumblebee/attack_hand(mob/user)
	show_message("\red [user:name] punches [src.name]!", "\red You punch [src.name]!")
	src.playsound(pick('sounds/punch1.ogg', 'sounds/punch2.ogg'))
	src.bee_damage(5 + user:empowered * 5 + user:berserk * 5)

	if(!src)
		return

	if(user:mat == "flesh" && !user:dead)

		if(prob(50 - user:luck / 2))
			src.playsound('sounds/Bombus_buzz.ogg')
			src.show_message(msg = "\red [src.name] counterstrikes!")
			user << "\red Ouch!"
			user:add_chem("toxin", "toxin", 3, 0)



/obj/bio/bumblebee/attack_by(obj/I, mob/user)
	if(istype(I, /obj/item/reagent_container/beaker))
		src.milk(I)
	else


		src.show_message("\red [user:name] bashes [src.name] with [I:name]!", "\red You bash [src.name] with [I:name]!")
		playsound('sounds/bash.wav')
		src.bee_damage(I:dmg + user:empowered * 2 + user:berserk * 2)

		if(!src)
			return

		if(user:mat == "flesh" && !user:dead)

			if(prob(50 - user:luck / 2))
				src.playsound('sounds/Bombus_buzz.ogg')
				src.show_message(msg = "\red [src.name] counterstrikes!")
				user << "\red Ouch!"
				user:add_chem("toxin", "toxin", 3, 0)

/obj/bio/bumblebee/proc/consume()
	var/shroomlist = list()
	for(var/obj/item/reagent_container/consumable/plant/P in src.loc)
		if(P.planttype == "mushroom")
			shroomlist += P

	var/P_to_eat = null

	if(shroomlist:len)
		P_to_eat = pick(shroomlist)
	else
		return

	src.show_message("[src.name] consumes [P_to_eat:name] and produces some honey.")
	var/H = new /obj/item/reagent_container/consumable/honey(loc)

	spawn(0)
		for(var/datum/reagent/R in P_to_eat:reagent_list)
			H:add_chem(R.id, R.name, R:amount / 2, 0)
		spawn(0)
			del(P_to_eat)
/obj/item/reagent_container/consumable/honey
	name = "bombus lucidum honey"
	icon_state = "honey"
	desc = "Delicious and nutrious honey of Baikonur-5 bumblebee."
/obj/item/reagent_container/consumable/honey
/obj/item/reagent_container/consumable/honey/New()
	src.add_chem("nutriment", "nutriment", 2, 0)
	src.add_chem("sugar", "sugar", 5, 0)
	src.add_chem("glucose", "glucose", 2, 0)
/obj/item/reagent_container/consumable/honey/randomized
	name = "bombus lucidum honey"
/obj/item/reagent_container/consumable/honey/randomized/New()
	src.add_chem("nutriment", "nutriment", rand(2, 5), 0)
	src.add_chem("sugar", "sugar", rand(5, 7), 0)
	src.add_chem("glucose", "glucose", rand(2, 3), 0)
	if(prob(25))
		src.add_chem("pogankeepeptide", "pogankeepeptide", 1.5, 0)
	else if(prob(50))
		src.add_chem("psilocybin", "psilocybin", 3.5, 0)
		src.add_chem("carboxylic acid", "carboxylic acid", 0.25, 0)

/obj/item/reagent_container/consumable/bumblebee_dead
	icon = 'grafon/thingy.dmi'
	// ^ icon match was partial
	size = 3
	anchored = 0
	market_price = 150
	name = "dead bombus lucidum"
	icon_state = "bumblebee_dead"
	var/crispy = 0
	desc = "You can grind this poor creature in extractor to get some precious chemicals or roast it on open fire."
/obj/item/reagent_container/consumable/bumblebee_dead
/obj/item/reagent_container/consumable/bumblebee_dead/New()
	src.add_chem("nutriment", "nutriment", 1, 0)
	src.add_chem("sugar", "sugar", 5, 0)
	src.add_chem("toxin", "toxin", 5, 0)
	src.add_chem("Nuclear titbit", "Nuclear titbit", 5, 0)

/obj/item/reagent_container/consumable/bumblebee_dead/Cross(atom/movable/O)

	if(istype(O, /obj/lazor))
		src.roast()

/obj/item/reagent_container/consumable/bumblebee_dead/proc/roast()
	if(src.crispy)
		return
	crispy = 1
	market_price = 200
	density = 0
	src.show_message(msg = "\red [src.name] roasts.")
	src.playsound('sounds/roast.wav')
	size = 1
	icon_state = "bumblebee_roasted"
	add_chem("nutriment", "nutriment", 5, 0)
	remove_chem("toxin", 5)
	desc = "A risky delicacy: roasted bombus lucidum."

	//..()
