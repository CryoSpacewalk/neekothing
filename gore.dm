// Recovered from compiled neek.dmb (6 procs)

/obj/overlay/head_blood

/obj/overlay/body
	layer = MOB_LAYER + 0.1
	icon = 'grafon/clothing_overlays.dmi'




































































































































/mob/proc/limb_damage(damage as num, sharp, groovy, limbname = null)

	if(src.limbs:len == 0)
		return

	var/l
	if(limbname)
		for(var/obj/limb/LB in src.limbs)
			if(limbname == LB.name)
				l = LB
	else
		l = pick(src.limbs)
	if(l:name == "head" && prob(5))
		src << "\red Ouch, my head!"
		src.epilepsy += rand(1, min(round(damage / 6), 6))

	if(prob(110 - l:health + damage / 4 + round(groovy / 2) - src:luck) && sharp)

		src.remove_limb(l:name)
	return

/mob/proc/legs_damage(damage as num, sharp)
	if(src:limbs:len == 0)
		return
	for(var/obj/limb/LB in src.limbs)
		var/l = LB
		if(l:name == "r_leg" || l:name == "r_leg")
			l:health -= damage
		if(prob(110 - l:health + damage / 4 - src:luck) && sharp)
			src.remove_limb(l:name)
		return

/mob/proc/remove_limb(limbname)

	if(istype(src, /mob/rooster))

		if(limbname == "head")
			src.damaga(100, "brute")
			return

		src << "\red \bold OH FUCK WHERES MY LIMB"
		src.bleed(2)

		if(src.painless)
			src.painless--
		if(src.pain < 5)
			src.torment(4)
		else
			src.torment(3)

		switch(limbname)
			if("r_hand")
				new /obj/item/reagent_container/consumable/chicken/wing(src.loc)
			if("l_hand")
				new /obj/item/reagent_container/consumable/chicken/wing(src.loc)
			if("r_leg")
				new /obj/item/reagent_container/consumable/chicken(src.loc)
			if("l_leg")
				new /obj/item/reagent_container/consumable/chicken(src.loc)
			else
				world << "\red \bold ROOSTER GORING IS BROKEN"
	else


		if(limbname == "head")

			src.decapitate()
			sleep(0)
			src.damaga(90000)
			return
		src << "\red \bold OH FUCK WHERES MY LIMB"
		src.bleed(2)

		if(src.painless)
			src.painless--
		if(src.pain < 5)
			src.torment(4)
		else
			src.torment(3)
		if(prob(50))
			src.wound()

		var/l = new /obj/item/limb(src.loc)
		l:limbroot = limbname
		switch(limbname)
			if("r_hand")
				l:name = "right arm"
				l:icon_state = "gibs2"
				spawn(0)
					if(r_hand)
						r_hand:loc = src.loc
					spawn(0) r_hand = null
			if("l_hand")
				l:name = "left arm"
				l:icon_state = "gibs2"
				spawn(0)
					if(l_hand)
						l_hand:loc = src.loc
					spawn(0) l_hand = null
			if("r_leg")
				l:name = "right leg"
				l:icon_state = "gibs3"
			if("l_leg")
				l:name = "left leg"
				l:icon_state = "gibs3"
			if("r_hand1")
				l:name = "right arm"
				l:icon_state = "gibs21"
				spawn(0)
					if(r_hand)
						r_hand:loc = src.loc
					spawn(0) r_hand = null
			if("l_hand1")
				l:name = "left arm"
				l:icon_state = "gibs21"
				spawn(0)
					if(l_hand)
						l_hand:loc = src.loc
					spawn(0) l_hand = null
			if("r_hand_robo")
				var/I = r_hand
				I:merged = 0
				I:loc = src.loc
				spawn(0)
					r_hand = null
					spawn(0) del(l)
			if("l_hand_robo")
				var/I = l_hand
				I:merged = 0
				I:loc = src.loc
				spawn(0)
					l_hand = null
					spawn(0) del(l)
			if("r_leg1")
				l:name = "right leg"
				l:icon_state = "gibs31"
			if("l_leg1")
				l:name = "left leg"
				l:icon_state = "gibs31"
			if("l_leg1")
			else
				world << "\red \bold HUMAN GORING IS BROKEN"

	for(var/obj/limb/chunk in src.limbs)
		if(chunk.name == limbname)
			src.limbs -= chunk
			src.update_sprite()
			return

/mob/proc/decapitate()






	for(var/obj/limb/l in src.limbs)
		if(l.name == "head")

			src.mutcure_target("tumor")
			src.mutcure_target("tumor_eye")
			src.mutcure_target("chromosome")
			src.mutcure_target("horns")

			sleep(0)

			src.brainremoval_forced()
			beheaded++
			var/datum/h = new /obj/item/limb/head(loc)
			var/ovly_ht = pick(typesof(l.ovly))
			var/ovly_h = new ovly_ht()
			h:icon = ovly_h:icon
			h:icon_state = ovly_h:icon_state
			src.limbs -= l

			del(ovly_h)
			h:pixel_y -= 11
			h:pixel_x++
			var/gory = new /obj/overlay/head_blood()
			h:overlays += gory
			h:desc = "[src.realname]'s head. Either just cut the brain out and drag it around or cut the brain out and make this guy into the robot!"
			h:headkey = src.realkey
			h:traitor = src.traitor_corpse
			h:cultplayer = src.cultplayer
			h:first_objective = src.objective1
			h:second_objective = src.objective2
			src.view_obj = h
			src.reset_view()
			sleep(0)
			src.update_sprite()
			return 1
	return 0

/mob/proc/gib()







	if(src.mat == "ether")
		return

	if(src.dead)
		if(limbs:len)
			for(var/obj/limb/LB in src.limbs)
				if(prob(20))
					new /obj/item/gib(src.loc)
				var/limbname = LB.name
				src.remove_limb(limbname)
		new /obj/item/gib(src.loc)
		spawn(1)
			if(src)
				del(src)
	else

		src.damaga(99999, "brute")
		spawn(1) src.gib()

/proc/return_limbname(limbname)







































































































	var/bpart_name = "body"

	switch(limbname)
		if("head")
			bpart_name = "head"
		if("r_leg")
			bpart_name = "right leg"
		if("l_leg")
			bpart_name = "left leg"
		if("r_arm")
			bpart_name = "right arm"
		if("l_arm")
			bpart_name = "left arm"

	sleep(0)



	return bpart_name
