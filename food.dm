// Recovered from compiled neek.dmb (27 procs)
/mob/var/antidoubling = 0
/mob/var/surrounded = 0
/mob/verb/eat()
	set name = "Consume"
	set category = "Item interraction"
	if(world.time - usr.antidoubling < 5)
		return
	if(usr.mat == "flesh")
		usr.antidoubling = world.time
		if(istype(usr.item, /obj/item/reagent_container/consumable) || (istype(usr.item, /obj/item/reagent_container/beaker) || istype(usr.item, /obj/item/blister)))

			if(istype(usr.item, /obj/item/reagent_container/consumable) && usr.item:size > 2)
				if(src.gib_eater)
					usr << "\blue You greedily chew into [usr.item]"
					consume(usr.item)
				else
					usr << "\red \bold [usr.item] is too large: cook or grind this thing first!"
					return
			else

				consume(usr.item)
		else
			if(src.gib_eater)
				if(istype(usr.item, /obj/item/limb/head))
					var/H = usr.item
					src << "\blue You chew into [usr.item]."
					usr.add_chem("nutriment", "nutriment", 6, 0)
					new /obj/item/reagent_container/consumable/gland(usr.loc)
					new /obj/item/gib(usr.loc)
					var/B = new /obj/item/brain(usr.loc)
					B:cultplayer = H:cultplayer
					B:headkey = H:headkey
					B:traitor = H:traitor
					B:first_objective = H:first_objective
					B:second_objective = H:second_objective
					sleep(0)
					usr.delitem()
				else if(istype(usr.item, /obj/item/limb))
					var/L = usr.item
					if(L:robo)
						usr << "\red You can't eat metal!"
						return
					else
						src << "\blue You chew into [usr.item]."
						usr.add_chem("nutriment", "nutriment", 6, 0)
						sleep(0)
						usr.delitem()
				else if(istype(usr.item, /obj/item/gib))
					src << "\blue You chew into [usr.item]."
					usr.add_chem("nutriment", "nutriment", 6, 0)
					sleep(0)
					usr.delitem()
			else

				usr << "\red You're unable to consume that!"
				return
	else
		usr << "\red You're unable to consume anything!"
		return

/mob/proc/consume(obj/IT)
	var/chemsum = 0
	if(istype(IT, /obj/item/reagent_container/consumable))
		var/I = IT
		for(var/datum/reagent/R in I:reagent_list)
			chemsum += R.amount
		if(istype(I, /obj/item/reagent_container/consumable/plant))
			src.extract(I, src)
		sleep(0)
		I:transfer_to_mob(chemsum, src)
		src << "\blue You consume [usr.item]."






		sleep(0)
		usr.delitem()
	else
		if(istype(IT, /obj/item/reagent_container/beaker))
			var/B = IT
			if(B:reagent_list:len)
				src << "\blue You make a gulp from [B]."
				B:transfer_to_mob(5, src)
			else
				src << "\red It is empty!"
		else

			var/B = IT
			if(B:tabs_left > 0)
				var/I = new B:P(src.loc)
				if(!istype(I, /obj/item/reagent_container/consumable))
					del(I)
					return
				del(I)
				B:tabs_left--
				var/PL = new B:P(src.loc)
				spawn(1)
					for(var/datum/reagent/R in PL:reagent_list)
						chemsum += R.amount
					sleep(0)
					PL:transfer_to_mob(chemsum, src)
					src << "\blue You consume [PL:name]."
					spawn(0)
						if(B:tabs_left == 5)
							B:icon_state = "[B:icon_state]_some"
						else if(!B:tabs_left)
							B:icon_state = B:icon_empty
						B:desc = "[B:tabs_left] [B:pillname] left"
						spawn(0) del(PL)

/obj/item/reagent_container/consumable/attack(mob/M, mob/user)
	if(istype(M, /mob))
		user << "\blue You try to feed [M] [src]."
		for(var/mob/V in view(user))
			V << "\red [usr] tries to feed [M] [src]!"
		spawn(40)
			if((user in range(1, M)) && user:item == src)
				usr << "\blue You feed [M] [src]."
				for(var/mob/V in view(user))
					V << "\red [usr] feeds [M] with [src]."
				M:consume(src)
	else
		..()

/obj/item/reagent_container/consumable/bread
	icon_state = "bread"
	desc = "Necessary for any good dinner."

/obj/item/reagent_container/consumable/bread


/obj/item/reagent_container/consumable/bread/New()







	src.add_chem("nutriment", "nutriment", 5, 0)

/obj/item/reagent_container/consumable/bread/attack_by(obj/I)


	if(istype(I, /obj/item/gib))
		usr << "\blue You place a piece of deformed raw flesh on top of bread slice."
		new /obj/item/reagent_container/consumable/sandwich/gibs(usr.loc)
		del(I)
		del(src)
		return
/obj/item/reagent_container/consumable/donut
	icon_state = "donut"
	desc = "Some sort of edible station map."
/obj/item/reagent_container/consumable/donut
/obj/item/reagent_container/consumable/donut/New()
	src.add_chem("nutriment", "nutriment", 5, 0)

/obj/item/reagent_container/consumable/sandwich
	icon_state = "sandwich"
	name = "buterbrood"
	desc = "A delicious cheese buterbrood."
/obj/item/reagent_container/consumable/sandwich
/obj/item/reagent_container/consumable/sandwich/New()
	src.add_chem("nutriment", "nutriment", 8, 0)

/obj/item/reagent_container/consumable/sandwich/rotten
	icon_state = "oldsandwich"
	name = "old buterbrood"
	desc = "A not-so-delicious cheese buterbrood."

/obj/item/reagent_container/consumable/sandwich/rotten
/obj/item/reagent_container/consumable/sandwich/rotten/New()
	src.add_chem("nutriment", "nutriment", 8, 0)
	spawn(1) src.add_chem("toxin", "toxin", 2, 0)
/obj/item/reagent_container/consumable/sandwich/poisoned
	name = "buterbrood"
/obj/item/reagent_container/consumable/sandwich/poisoned
/obj/item/reagent_container/consumable/sandwich/poisoned/New()
	src.add_chem("nutriment", "nutriment", 8, 0)
	spawn(1) src.add_chem("toxin", "toxin", 10, 0)

/obj/item/reagent_container/consumable/sandwich/gibs
	icon_state = "gibsandwich"
	name = "gibsandwich"
	desc = "A delicious meat buterbrood. Please, don't ask the chef where meat came from."
/obj/item/reagent_container/consumable/sandwich/gibs
/obj/item/reagent_container/consumable/sandwich/gibs/New()
	src.add_chem("nutriment", "nutriment", 12, 0)
	spawn(1) src.add_chem("regenerite", "regenerite", 1, 0)

/obj/item/reagent_container/consumable/chicken
	icon_state = "chicken"
	name = "rooster's leg"
	desc = "A delicious leg of rooster."
/obj/item/reagent_container/consumable/chicken
/obj/item/reagent_container/consumable/chicken/New()
	src.add_chem("nutriment", "nutriment", 8, 0)
	spawn(0) src.add_chem("condensed milk", "condensed milk", 1, 0)
/obj/item/reagent_container/consumable/chicken/wing
	icon_state = "chicken2"
	name = "rooster's wing"
	desc = "A delicious wing of rooster."
/obj/item/reagent_container/consumable/chicken/wing
/obj/item/reagent_container/consumable/chicken/wing/New()
	src.add_chem("nutriment", "nutriment", 5, 0)
	spawn(0) src.add_chem("condensed milk", "condensed milk", 1, 0)
/obj/item/reagent_container/consumable/chicken/poisoned
	name = "rooster's leg"
/obj/item/reagent_container/consumable/chicken/poisoned
/obj/item/reagent_container/consumable/chicken/poisoned/New()
	src.add_chem("nutriment", "nutriment", 8, 0)
	spawn(0)
		src.add_chem("condensed milk", "condensed milk", 1, 0)
		spawn(0) src.add_chem("toxin", "toxin", 10, 0)

/obj/item/reagent_container/consumable/stamp
	maxamount = 0.5
	chem_capacity = 0.5
	beltable = 0
	icon_state = "stamp"
	name = "mail stamp"
	desc = "A common mail stamp."
/obj/item/reagent_container/consumable/stamp
/obj/item/reagent_container/consumable/stamp/LSD
	icon_state = "stamp_plane"
	desc = "A common mail stamp. There's a picture of an airplane on it."
/obj/item/reagent_container/consumable/stamp/LSD
/obj/item/reagent_container/consumable/stamp/LSD/New()
	src.add_chem("LSD", "LSD", 0.5, 0)


/obj/item/reagent_container/consumable/stamp/DOB
	name = "mail stamp"
/obj/item/reagent_container/consumable/stamp/DOB
/obj/item/reagent_container/consumable/stamp/DOB/New()
	src.add_chem("DOB", "DOB", 0.2, 0)

/obj/item/reagent_container/consumable/stamp/blotter
	icon_state = "blotter"
	name = "blotter tab (Lysergic acid diethylamide)"
	desc = "A tiny piece of paper."
/obj/item/reagent_container/consumable/stamp/blotter
/obj/item/reagent_container/consumable/stamp/blotter/New()
	src.pixel_x = pick(-5, -2, 0, 2, 5)
	src.pixel_y = pick(-5, -2, 0, 2, 5)
	src.add_chem("LSD", "LSD", 0.3, 0)


/obj/item/reagent_container/consumable/stamp/blotter/faked
	name = "blotter tab (Lysergic acid diethylamide)"
/obj/item/reagent_container/consumable/stamp/blotter/faked
/obj/item/reagent_container/consumable/stamp/blotter/faked/New()
	src.pixel_x = pick(-5, -2, 0, 2, 5)
	src.pixel_y = pick(-5, -2, 0, 2, 5)
	src.add_chem("25i-NBOMe", "25i-NBOMe", 0.9, 0)
/obj/item/reagent_container/consumable/stamp/blotter_nbome
	icon_state = "blotter"
	desc = "A tiny piece of paper."
	name = "blotter tab (25i-NBOMe)"
/obj/item/reagent_container/consumable/stamp/blotter_nbome
/obj/item/reagent_container/consumable/stamp/blotter_nbome/New()
	src.pixel_x = pick(-5, -2, 0, 2, 5)
	src.pixel_y = pick(-5, -2, 0, 2, 5)
	src.add_chem("25i-NBOMe", "25i-NBOMe", 0.9, 0)
/obj/item/reagent_container/consumable/stamp/blotter_DOB
	desc = "A tiny piece of paper."
	icon_state = "blotter_heavy"
	name = "blotter tab (2,5-Dimethoxy-4-bromoamphetamine)"
/obj/item/reagent_container/consumable/stamp/blotter_DOB
/obj/item/reagent_container/consumable/stamp/blotter_DOB/New()
	src.pixel_x = pick(-5, -2, 0, 2, 5)
	src.pixel_y = pick(-5, -2, 0, 2, 5)
	src.add_chem("DOB", "DOB", 0.084, 0)
/obj/item/reagent_container/consumable/stamp/blotter_DOI
	desc = "A tiny piece of paper."
	icon_state = "blotter_heavy"
	name = "blotter tab"
/obj/item/reagent_container/consumable/stamp/blotter_DOI
/obj/item/reagent_container/consumable/stamp/blotter_DOI/New()
	src.pixel_x = pick(-5, -2, 0, 2, 5)
	src.pixel_y = pick(-5, -2, 0, 2, 5)
	src.add_chem("DOI", "DOI", 0.12, 0)
/obj/item/reagent_container/consumable/stamp/blotter_DOC
	desc = "A tiny piece of paper."
	icon_state = "blotter_heavy"
	name = "blotter tab"
/obj/item/reagent_container/consumable/stamp/blotter_DOC
/obj/item/reagent_container/consumable/stamp/blotter_DOC/New()
	src.pixel_x = pick(-5, -2, 0, 2, 5)
	src.pixel_y = pick(-5, -2, 0, 2, 5)
	src.add_chem("DOC", "DOC", 0.12, 0)
/obj/item/reagent_container/consumable/stamp/blotter_DOM
	desc = "A tiny piece of paper."
	icon_state = "blotter_heavy"
	name = "blotter tab"
/obj/item/reagent_container/consumable/stamp/blotter_DOM
/obj/item/reagent_container/consumable/stamp/blotter_DOM/New()
	src.pixel_x = pick(-5, -2, 0, 2, 5)
	src.pixel_y = pick(-5, -2, 0, 2, 5)
	src.add_chem("DOM", "DOM", 0.12, 0)
/obj/item/reagent_container/consumable/stamp/blotter_hard
	name = "blotter tab (Lysergic acid diethylamide)"
	desc = "A tiny piece of paper."
	icon_state = "blotter_heavy"
/obj/item/reagent_container/consumable/stamp/blotter_hard
/obj/item/reagent_container/consumable/stamp/blotter_hard/New()
	src.pixel_x = pick(-5, -2, 0, 2, 5)
	src.pixel_y = pick(-5, -2, 0, 2, 5)
	src.add_chem("LSD", "LSD", 0.6, 0)
/obj/item/reagent_container/consumable/stamp/blotter_dragon
	desc = "A tiny piece of paper."
	icon_state = "blotter_heavy"
	name = "blotter tab"
/obj/item/reagent_container/consumable/stamp/blotter_dragon
/obj/item/reagent_container/consumable/stamp/blotter_dragon/New()
	src.pixel_x = pick(-5, -2, 0, 2, 5)
	src.pixel_y = pick(-5, -2, 0, 2, 5)
	src.add_chem("Bromo-DragonFLY", "Bromo-DragonFLY", 0.1, 0)
/obj/item/reagent_container/consumable/stamp/blotter_mix
	name = "blotter tab (Lysergic acid diethylamide)"
	icon_state = "blotter_mix"
	desc = "A tiny piece of paper. You have an uncanny feeling about it."
/obj/item/reagent_container/consumable/stamp/blotter_mix
/obj/item/reagent_container/consumable/stamp/blotter_mix/New()
	src.pixel_x = pick(-5, -2, 0, 2, 5)
	src.pixel_y = pick(-5, -2, 0, 2, 5)
	src.add_chem("LSD", "LSD", 0.3, 0)
	src.add_chem("DOB", "DOB", 0.3, 0)

/obj/item/reagent_container/consumable/tobacco
	smokeable = 1
	size = 1
	icon_state = "tobacco"
	name = "chewing synthtobacco"
	desc = "A precious gum with synthetic nicotine. DANGER: very cancerogenic and addictive! Do not smoke!"
/obj/item/reagent_container/consumable/tobacco
/obj/item/reagent_container/consumable/tobacco/New()
	src.add_chem("sugar", "sugar", 1, 0)
	spawn(0) src.add_chem("nicotine", "nicotine", 0.1, 0)

/obj/item/reagent_container/consumable/tobacco/ASD
	smokeable = 0
	name = "anti-cancerous cheming gum"
	icon_state = "tobacco2"
	desc = "A precious gum filled with anti-cancirogenic agent. Very useful for smokers, since nicotine is a potent cancerogen (and even mutagen!)."
/obj/item/reagent_container/consumable/tobacco/ASD
/obj/item/reagent_container/consumable/tobacco/ASD/New()
	src.add_chem("sugar", "sugar", 2, 0)
	spawn(0) src.add_chem("ASD", "ASD", 4, 0)

