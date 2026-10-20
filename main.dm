// Recovered from compiled neek.dmb (12 procs)

/obj/item/proc/pickthefuckup()



























	set name = "Forced pick up"
	set category = "Item interraction"
	if(!usr.item && (usr.hepe > 0 && (usr.class == src.class && !usr.stunned)))
		set src in view(1)
		src.pickup(usr)
/obj/item/verb/pickup_verb()
	set name = "Pick up"
	set category = "Item interraction"
	set src in view(1)
	if(!usr.item && (usr.hepe > 0 && (usr.class == src.class && !usr.stunned)))
		usr.client.Click(src)
/obj/item/proc/pickup(mob/user)
	user:update_contents(src)
	if(src.loc == user && (cursed || merged))
		return


	if(user:hand)
		if(user:r_hand == src) user:r_hand = null
		user:l_hand = src
	else
		if(user:l_hand == src) user:l_hand = null
		user:r_hand = src
	user:item = src
	src.loc = user

	if(poisons:len)
		for(var/datum/reagent/R in src.poisons)
			var/q = 1 + user:chemprotect / 5
			R.on_touch(R.amount / q, user, "all")
			src.remove_poison(R.id)

	return

/obj/item/attack_hand(mob/user)
	if(user:stunned == 0)
		src.pickup(user)

/obj/item/attack_self(mob/user)
	return

/mob/verb/use()
	set name = "Use"
	set category = "Item interraction"
	if(!(usr.item == null))
























































		usr.item:attack_self(usr)

/atom/proc/spawn_limbs(rooot)











/obj/item/limb/r_hand
/obj/item/limb/l_hand
/obj/item/limb/r_leg
/obj/item/limb/l_leg
/obj/item/limb{dmg = 3; size = 2; name = "limb"; var/limbroot; var/robo = 0; var/robosaw = 0; var/chainhand = 0; icon_state = "gibs2"}
/obj/item/limb/l_hand
/obj/item/limb/attack(atom/A, mob/user)




	if(ismob(A))
		var/M = A
		if(M:protez)
			switch(src.limbroot)
				if("r_hand")
					for(var/obj/limb/L in M:limbs)
						if(istype(L, /obj/limb/r_hand) || (istype(L, /obj/limb/r_hand1) || istype(L, /obj/limb/r_hand_robo)))
							return
					if(src.robo)
						M:limbs += new /obj/limb/r_hand1()
						spawn(0) user:delitem()
					else if(src.robosaw)
						if(user == M)
							user << "\red Alas, but this thing is too complex for self-implanting!"
							return
						M:limbs += new /obj/limb/r_hand_robo()
						spawn(0)
							var/R = new /obj/item/tool/robot/robosaw(M:loc)
							R:merged = 1
							if(M:hand)
								M:swap_hands()
							sleep(0)
							R:pickup(M)
							spawn(0)
								user:delitem()
					else
						M:limbs += new /obj/limb/r_hand()
						spawn(0) user:delitem()
					usr << "\blue You successfully stick [name] at the place."
				if("l_hand")
					for(var/obj/limb/L in M:limbs)
						if(istype(L, /obj/limb/l_hand) || (istype(L, /obj/limb/l_hand1) || istype(L, /obj/limb/l_hand_robo)))
							return
					if(src.robo)
						M:limbs += new /obj/limb/l_hand1()
						spawn(0) user:delitem()
					else if(src.robosaw)
						if(user == M)
							user << "\red Alas, but this thing is too complex for self-implanting!"
							return
						M:limbs += new /obj/limb/l_hand_robo()
						spawn(0)
							var/R = new /obj/item/tool/robot/robosaw(M:loc)
							R:merged = 1
							if(!M:hand)
								M:swap_hands()
							sleep(0)
							R:pickup(M)
							spawn(0)
								user:delitem()
					else
						M:limbs += new /obj/limb/l_hand()
						spawn(0) user:delitem()
					usr << "\blue You successfully stick [name] at the place."
				if("r_leg")
					for(var/obj/limb/L in M:limbs)
						if(istype(L, /obj/limb/r_leg) || istype(L, /obj/limb/r_leg1))
							return
					if(src.robo)
						M:limbs += new /obj/limb/r_leg1()
					else
						M:limbs += new /obj/limb/r_leg()
					usr << "\blue You successfully stick [name] at the place."
					spawn(0) user:delitem()
				if("l_leg")
					for(var/obj/limb/L in M:limbs)
						if(istype(L, /obj/limb/l_leg) || istype(L, /obj/limb/l_leg1))
							return
					if(src.robo)
						M:limbs += new /obj/limb/l_leg1()
					else
						M:limbs += new /obj/limb/l_leg()
					usr << "\blue You successfully stick [name] at the place."
					spawn(0) user:delitem()
		else
			usr << "\red Looks like this prosthesis will be rejected by [A:name] body!"
		M:update_sprite()
	else
		..()


/obj/item/brain
	size = 2
	market_price = 400
	var/headkey
	var/traitor = 0
	var/cultplayer = 0
	var/first_objective
	var/second_objective
	icon_state = "brain"

/obj/item/device/krokodil/attack_self()















	usr << "\bold You begin to read magazine carefully..."
	if(onhold == 0)
		usr << "\red No evacuation initiated."
	else
		usr << "\red Evacuation initiated. [secsleft] seconds left. Run to the shuttle as fast as possible!"
	spawn(10)
		usr << ""
		usr << "\blue \bold BREAKING NEWS"
		usr << "\blue \bold All [pick("bourgeous", "dissidents", "capitalists", "spies", "traitors", "bloggers")] are [pick("[reverse_text("toggaf")]s", "swine", "roosters", "gay", "fuckers", "liberals")]!"
/obj/item/gib
	size = 2
	name = "bloody mess"
	icon_state = "gib"
/obj/item/limb2
	dmg = 3
	size = 2
	name = "limb"
	icon_state = "gibs3"
/obj/item/nukodisk
	name = "Kuzka's mother authorisation disk"
	desc = "Captain should hide it in some safe place."
	icon_state = "nukodisk"
/obj/item/soap{plastic_need = 1; desc = "A chunk of soap, perfectly good for cleaning vomit, blood, shit, piss and melted wire insulation."; icon_state = "soap"}
/obj/item/soap/attack(O as obj|turf)


	if(istype(O, /turf))
		var/T = O
		T:clean()
		usr << "\blue You clean [O]."
		for(var/obj/OB in O)
			if(istype(OB, /obj/vomit) || (istype(OB, /obj/melt) || istype(OB, /obj/effect/rhinestones)))
				del(OB)
	else if(istype(O, /obj))
		var/T = O:loc
		T:clean()
		usr << "\blue You clean [T]."

/obj/item/soap/Crossed(atom/movable/A)
	if(istype(A, /mob))
		var/M = A
		M << "\red You slipped on the [src]."

		spawn(0)
			M:stun(3)

/turf/proc/clean()
	for(var/obj/OB in src)
		if(istype(OB, /obj/cult) || (istype(OB, /obj/vomit) || (istype(OB, /obj/melt) || (istype(OB, /obj/effect/rhinestones) || (istype(OB, /obj/harch) || (istype(OB, /obj/jizz) || istype(OB, /obj/blood)))))))
			del(OB)
