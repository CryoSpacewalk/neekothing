/obj/structure/liquid_dispenser{density = 1; name = "liquid dispenser"; desc = "A large tank for dispensing liquid."; var/chemid = "water"; var/chemname = "water"; var/amount = 0; var/transfer_amount = 5; anchored = 0}
/obj/item/reagent_container
	icon = 'grafon/item/liquid.dmi';market_price = 0.05
	var/reagent_list = list()
	var/temp = 0
	var/maxamount = 50
	var/target_transfer = 5

/obj/item/reagent_container/proc/remove_chem(rid, r_amount)
	for(var/datum/reagent/RE in src.reagent_list)
		if(RE.id == rid)
			if(RE.amount > r_amount)
				RE.amount -= r_amount
			else
				RE.amount = 0
				src.reagent_list -= RE

/obj/item/reagent_container/proc/remove_all()
	for(var/datum/reagent/RE in src.reagent_list)
		RE.amount = 0
		src.reagent_list -= RE

/obj/item/reagent_container/proc/add_chem(rid, rname, r_amount, r_temp)
	var/allamount
	spawn(0)
		var/plused = 0
		for(var/datum/reagent/RE in src.reagent_list)
			if(RE.id == rid)
				RE.amount += r_amount
				plused = 1
		spawn(0)
			if(plused == 0)
				var/RT = new /datum/reagent()
				RT:id = rid
				RT:amount = r_amount
				RT:name = rname
				src.reagent_list += RT







				spawn(0)
					for(var/datum/reagent/RE in reagent_list)
						allamount += RE.amount
						if(RE.amount == 0)
							src.reagent_list -= RE
					spawn(0)
						src.temp = (src.temp * (allamount - r_amount) + r_temp * r_amount) / allamount
						spawn(0)
							for(var/datum/reagent/HRR in reagent_list)
								HRR.in_reaction = 1
								for(var/datum/reagent/DRR in src.reagent_list)
									if(DRR.in_reaction == 0)
										src.react(HRR, DRR)
								spawn(0)
									if(HRR)
										HRR.in_reaction = 0
										HRR.on_temp(src, src.temp)

/obj/item/reagent_container/proc/transfer_mix(t_amount, obj/target)
	var/allamount
	var/reagamount = 0

	if(length(src.reagent_list))
		for(var/datum/reagent/RE in reagent_list)
			allamount += RE.amount
			reagamount += 1



		spawn(0)
			if(allamount < t_amount)
				t_amount = allamount
			if(length(src.reagent_list))
				for(var/datum/reagent/RE in reagent_list)
					spawn(0)

						target:add_chem(RE.id, RE.name, RE.amount * t_amount / allamount, src.temp)
						spawn(0) src.remove_chem(RE.id, RE.amount * t_amount / allamount)

/obj/item/reagent_container/proc/transfer_to_mob(t_amount, mob/M)
	var/allamount
	var/reagamount = 0

	if(length(src.reagent_list))
		for(var/datum/reagent/RE in reagent_list)
			allamount += RE.amount
			reagamount += 1



		sleep(0)
		if(allamount < t_amount)
			t_amount = allamount
		if(length(src.reagent_list))
			for(var/datum/reagent/RE in reagent_list)
				sleep(0)
				M:add_chem(RE.id, RE.name, RE.amount * t_amount / allamount, src.temp)
				src.remove_chem(RE.id, RE.amount * t_amount / allamount)

/obj/item/reagent_container/attack_by(obj/I)
	if(istype(I, /obj/item/tool/chemscan))
		if(istype(src, /obj/item/reagent_container/consumable/dust))
			usr << "\red \bold ERROR"
		else
			for(var/datum/reagent/R in src.reagent_list)
				usr << "\blue [R.name]: [R.amount]"
			usr << "\red Current temperature: [temp]"

/obj/item/reagent_container/proc/shake()


	for(var/datum/reagent/R in src.reagent_list)
		if(R.id == "nitroglycerin")
			var/place
			if(!istype(src.loc, /turf))
				place = src.loc.loc
			else
				place = src.loc
			spawn(0)
				if(R.amount >= 1)
					for(var/mob/M in view(src))
						M << "\red The solution explodes!"
					var/S = new /obj/effect/sparks(place)
					spawn(0)
						S:explosion(R.amount / 10)
						spawn(0)
							if(src)
								src.remove_chem("nitroglycerin", R.amount)
		else if(R.id == "nitrocellulose")
			var/place
			if(!istype(src.loc, /turf))
				place = src.loc.loc
			else
				place = src.loc
			spawn(0)
				if(R.amount >= 1)
					for(var/mob/M in view(src))
						M << "\red The solution explodes!"
					var/S = new /obj/effect/sparks(place)
					spawn(0)
						S:explosion(R.amount / 25)
						spawn(0)
							if(src)
								src.remove_chem("nitrocellulose", R.amount)
		else if(R.id == "liquid vacuum")
			var/place
			if(!istype(src.loc, /turf))
				place = src.loc.loc
			else
				place = src.loc
			spawn(0)
				if(R.amount >= 1)
					for(var/mob/M in view(src))
						M << "\red The solution sucks everything inside it!"
					var/S = new /obj/effect/warp_splash(place)
					spawn(0)
						S:antiplosion(R.amount / 10)
						spawn(0)
							if(src)
								src.remove_chem("liquid vacuum", R.amount)
		else if(R.id == "liquid steel")
			var/place
			if(!istype(src.loc, /turf))
				place = src.loc.loc
			else
				place = src.loc
			spawn(0)
				if(R.amount >= 25)
					new /obj/item/material/sheet/five(place)
					if(src)
						src.remove_chem("liquid steel", 25)
				else
					usr << "\red Looks like you have to make more of a liquid steel!"

/client/proc/scan_chem(obj/R in world)




	set name = "Scan for chemicals"
	set category = "Pedal"
	for(var/datum/reagent/RE in R:reagent_list)
		spawn(0) src << "Name: [RE.name]; id: [RE.id]; amount: [RE.amount]; color (rgb): [RE.get_red()]_[RE.get_green()]_[RE.get_blue()]"

/obj/item/tool/chemscan
	name = "chemical analyzer"
	icon_state = "chemscan"

/obj/item/tool/chemscan

/obj/item/tool/chemscan/attack(atom/A)
	if(istype(A, /obj/item))
		var/I = A
		if(I:poisons:len)
			usr << "\red The following contact poisons detected on [A:name]:"
			for(var/datum/reagent/R in I:poisons)
				usr << "\red \bold [R.id] ([R.amount] pts)"
		else
			usr << "\blue No contact poisons detected on [A:name]"

/obj/item/reagent_container/beaker
	name = "glass beaker"
	icon_state = "beaker"
	var/method = "drink"
	var/transparent = 1

/obj/item/reagent_container/beaker
/obj/item/reagent_container/beaker/attack(atom/I as obj|turf)
	if(istype(I, /obj/item/reagent_container/beaker) && !(I == src))
		var/obj/item/reagent_container/beaker/ugh = I
		var/ughamount
		var/selfamount = 0
		for(var/datum/reagent/R in ugh:reagent_list)
			ughamount += R.amount
		for(var/datum/reagent/R in src.reagent_list)
			selfamount += R.amount
		spawn(0)
			if(selfamount <= 0)
				if(istype(src, /obj/item/reagent_container/beaker/bottle))
					var/suitable = 0
					if(istype(ugh, /obj/item/reagent_container/beaker/bottle))
						for(var/datum/reagent/R in ugh:reagent_list)
							if(R.name == "water" && R.amount >= ugh:maxamount)
								suitable = 1
					sleep(0)
					if(suitable)
						usr << "\blue You stick a bottle. In the bottle. Or in a can. Yea, I know it sounds retarded, but actually your construction can be fucking useful. It still looks unfinished, however."
						new /obj/item/vodniy_unfin(usr.loc)
						del(ugh)
						usr.delitem()
					else
						usr << "\red [src] is empty! You can try to use it on something full of water for hilarity, however."
				else
					usr << "\red [src] is empty!"
			else if(ughamount < ugh:maxamount - src.target_transfer)
				usr << "\blue You transfer some liquid."
				src.transfer_mix(src.target_transfer, I)
				usr << 'sounds/water-click.wav'
			else if(ughamount >= ugh:maxamount)
				usr << "\red [ugh] is full!"
			else
				usr << "\blue You transfer some liquid."
				usr << 'sounds/water-click.wav'
				src.transfer_mix(ugh:maxamount - ughamount, I)
	else if(istype(I, /turf))
		src.shake()
		var/splash = 1
		for(var/obj/fuellamp/F in I)
			splash = 0
			if(F.charges <= 0)
				for(var/datum/reagent/R in src.reagent_list)
					if(R.id == "fuel" && R.amount >= 1)
						R.amount--
						usr << "\blue You refill the lamp"
						usr << 'sounds/water-click.wav'
						F.charges = 200
		if(splash)
			usr << "\red You splash the solution onto [I]!"
			var/snd = 0
			for(var/datum/reagent/R in src.reagent_list)
				R.on_turf(I, src.temp)
				snd = 1
			if(snd)
				for(var/mob/M in viewers(I))
					M << 'splash.wav'
			spawn(0) src.remove_all()
	else
		if(istype(I, /obj/item) && I != src)

			if(I:loc == usr)
				usr << "\red Put it on the ground or on a table first."
				return

			var/msg = 0
			var/obj/item/IT = I

			for(var/datum/reagent/R in src.reagent_list)

				if(R.id in contact_poisons_full)
					IT:add_poison(R, 1)
					msg = 1

				if(R.id in contact_poisons_half)
					IT:add_poison(R, 2)
					msg = 1

				if(R.id in contact_poisons_quad)
					IT:add_poison(R, 4)
					msg = 1

			if(msg)
				usr << "\blue You cover [I:name] with some chemicals."
				for(var/mob/M in viewers(I))
					M << 'splash.wav'
				spawn(0) src.remove_all()

/obj/item/reagent_container/beaker/attack_by(I as obj|turf)
	if(istype(I, /obj/item/reagent_container/consumable/pill) || (istype(I, /obj/item/reagent_container/consumable/track) || (istype(I, /obj/item/reagent_container/consumable/stamp) || istype(I, /obj/item/reagent_container/consumable/vtoryaki))))
		var/P = I
		var/selfamount = 0
		var/pillamount = 0
		for(var/datum/reagent/R in P:reagent_list)
			pillamount += R.amount

		for(var/datum/reagent/R in src.reagent_list)
			selfamount += R.amount
		if(selfamount >= maxamount)
			usr << "\red [src.name] is full!"
		else if(pillamount + selfamount > maxamount)
			usr << "\blue You add your [I:name] to the [src.name].)"
			usr << 'pill_drip.wav'

			P:transfer_mix(pillamount - maxamount + selfamount, src)
			if(usr.item == I)
				usr.dropitem()
			spawn(1)
				del(P)
		else
			usr << "\blue You add your [I:name] to the [src.name]."
			P:transfer_mix(pillamount, src)
			if(usr.item == I)
				usr.dropitem()
			spawn(1)
				del(P)
	else if(istype(I, /obj/item/cable) && istype(src, /obj/item/reagent_container/beaker/bottle))

		var/ant_suitable = 0

		for(var/datum/reagent/R in src.reagent_list)
			if(R.id == "red mercury" && R.amount == src.maxamount)
				ant_suitable = 1

		if(ant_suitable)

			var/C = I
			C:cminus(1)

			usr << "\blue You've assembled red mercury antennae."

			new /obj/item/device/red_mercury(usr.loc)

			spawn(0)
				del(src)
				return
		else


			usr << "\red You need full bottle of red mercury for this."
			return

	..()

/obj/item/reagent_container/beaker/attack_self()

	usr << "\blue You shake [src]."
	src.shake()
/obj/item/reagent_container/beaker/pedal_polytrinic
	name = "glass beaker"
/obj/item/reagent_container/beaker/pedal_polytrinic/New()
	add_chem("polytrinic acid", "polytrinic acid", 50, 0)
	..()
/obj/item/reagent_container/beaker/pedal_regia
	name = "glass beaker"
/obj/item/reagent_container/beaker/pedal_regia/New()
	add_chem("aqua regia", "aqua regia", 50, 0)
	..()
/obj/item/reagent_container/beaker/pedal_lye
	name = "glass beaker"
/obj/item/reagent_container/beaker/pedal_lye/New()
	add_chem("space gunpowder", "space gunpowder", 40, 0)
	spawn(0)
		add_chem("lye", "lye", 10, 0)
		..()
/obj/item/reagent_container/beaker/pedal_water
	name = "glass beaker"
/obj/item/reagent_container/beaker/pedal_water/New()
	add_chem("space gunpowder", "space gunpowder", 40, 0)
	spawn(0)
		add_chem("water", "water", 10, 0)
		..()
/obj/item/reagent_container/beaker/pedal_aids
	name = "glass beaker"
/obj/item/reagent_container/beaker/pedal_aids/New()
	add_chem("AIDS", "AIDS", 50, 0)
	..()
/obj/item/reagent_container/beaker/pedal_hawt
	name = "glass beaker"
/obj/item/reagent_container/beaker/pedal_hawt/New()
	add_chem("aluminum", "aluminum", 50, 6)
	..()
/obj/item/reagent_container/beaker/pedal_powder
	name = "glass beaker"
/obj/item/reagent_container/beaker/pedal_powder/New()
	add_chem("space gunpowder", "space gunpowder", 50, 0)
	..()
/obj/item/reagent_container/beaker/nutriment
	name = "nutriment beaker (25pts)"
/obj/item/reagent_container/beaker/nutriment
/obj/item/reagent_container/beaker/nutriment/New()
	add_chem("nutriment", "nutriment", 25, 0)
	..()

/obj/item/reagent_container/beaker/verb/change_transfer()
	set name = "change transfer value"
	set src in view(1)

	if(!usr.candofun)
		usr << "\red You're unable to operate any kind of stuff!"
		return

	if(istype(src, /obj/item/reagent_container/beaker/bucket))
		src.target_transfer = input("", "New transfer value:", src.target_transfer) in list(10, 20, 30)
	else if(istype(src, /obj/item/reagent_container/beaker/bottle) || istype(src, /obj/item/reagent_container/beaker/glass))
		src.target_transfer = input("", "New transfer value:", src.target_transfer) in list(5, 10, 15)
	else if(istype(src, /obj/item/reagent_container/beaker/tiny))
		src.target_transfer = input("", "New transfer value:", src.target_transfer) in list(5, 10)
	else
		src.target_transfer = input("", "New transfer value:", src.target_transfer) in list(5, 10, 15, 20, 25, 30)
/obj/item/reagent_container/beaker/verb/change_method()
	if(!istype(src, /obj/item/reagent_container/beaker/bottle))
		set name = "change interraction method"
		set src in view(1)
		switch(method)
			if("drink")
				method = "splash"
				usr << "\blue Now splashing people with chemicals."
			else
				method = "drink"
				usr << "\blue Now feeding people with chemicals."

/obj/item/reagent_container/beaker/verb/track()










	set name = "make a track"
	set src in view(1)
	var/TR = new /obj/item/reagent_container/consumable/track(usr.loc)
	var/trackeys = 0
	for(var/datum/reagent/R in src.reagent_list)
		for(var/datum/on_sniff/O in on_sniff_avaible)
			if(R.id == O.rid)
				trackeys++
	sleep(0)
	var/L = list()
	for(var/datum/on_sniff/O in on_sniff_avaible)
		L += O.rid
	sleep(0)
	for(var/datum/reagent/R in src.reagent_list)
		if(!(R.id in L))
			usr << "\red \bold You can only make tracks from nickelbags/beakers containing ONLY sniffable materials without any liquids or other non-trackable stuff."
			del(TR)
			return
	sleep(0)
	if(trackeys)
		usr << "\blue You make a track."
		for(var/datum/reagent/R in src.reagent_list)
			for(var/datum/on_sniff/O in on_sniff_avaible)
				if(R.id == O.rid)
					if(R.amount >= src:tracksize / trackeys)
						TR:add_chem(R.name, R.id, src:tracksize / trackeys, temp)
						remove_chem(R.id, src:tracksize / trackeys)
					else
						TR:add_chem(R.name, R.id, R.amount, src.temp)
						src.remove_chem(R.id, R.amount)
	else
		usr << "\red There's nothing you can snuff in this container!"
		del(TR)
		return

/obj/item/reagent_container/beaker/verb/changetrack()
	set name = "set a track size"
	set src in view(1)
	var/newsize = input("So, how fat track do you wanna to do?") in list(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 2, 3, 4)
	if(usr.item in view(1, usr))
		src:tracksize = newsize
		usr << "\blue Now making a tracks of [src:tracksize]"
/obj/item/reagent_container/beaker/tiny
	maxamount = 10
	beltable = 1
	name = "mini-beaker"
	icon_state = "beaker_tiny"
/obj/item/reagent_container/beaker
	var/tracksize = 0.2
/obj/item/reagent_container/beaker/tiny
/obj/item/reagent_container/beaker/bucket{size = 3; maxamount = 70; target_transfer = 10; transparent = 0; parry = 20; icon_state = "bucket"; name = "bucket"}
/obj/item/reagent_container/beaker/bucket/heroin{maxamount = 100; name = "huge heroin solution bottle (no kidding)"; icon_state = "canister_grim"}
/obj/item/reagent_container/beaker/bucket/heroin/New()




	add_chem("water", "water", 94, 0)
	add_chem("heroin", "heroin", 6, 0)
/obj/item/reagent_container/beaker/bucket/canister
	name = "fuel canister"
	icon_state = "canister"
/obj/item/reagent_container/beaker/bucket/canister
/obj/item/reagent_container/beaker/bucket/canister/New()
	add_chem("fuel", "fuel", 70, 0)
/obj/item/reagent_container/beaker/bucket/canister_cellulose
	name = "chemical canister (cellulose)"
	icon_state = "canister_brown"
/obj/item/reagent_container/beaker/bucket/canister_cellulose
/obj/item/reagent_container/beaker/bucket/canister_cellulose/New()
	add_chem("cellulose", "cellulose", 70, 0)
/obj/item/reagent_container/beaker/bucket/canister_empty
	name = "chemical canister (empty)"
	icon_state = "canister_white"
/obj/item/reagent_container/beaker/bucket/canister_empty
/obj/item/reagent_container/beaker/bucket/canister_ghb
	icon_state = "canister_white"
	name = "chemical canister (GHB)"
/obj/item/reagent_container/beaker/bucket/canister_ghb
/obj/item/reagent_container/beaker/bucket/canister_ghb/New()
	add_chem("GHB", "GHB", 70, 0)
/obj/item/reagent_container/beaker/bucket/canister_geo
	beltable = 1
	name = "beltable canister"
	icon_state = "canister_gray"
/obj/item/reagent_container/beaker/bucket/canister_geo
/obj/item/reagent_container/beaker/bucket/acid
	icon_state = "canister"
	name = "canister"
/obj/item/reagent_container/beaker/bucket/acid
/obj/item/reagent_container/beaker/bucket/acid/New()
	add_chem("sulfuric acid", "sulfuric acid", 70, 0)
/obj/item/reagent_container/beaker/bucket/atropine
	icon_state = "canister"
	name = "pedalish canister"
/obj/item/reagent_container/beaker/bucket/atropine
/obj/item/reagent_container/beaker/bucket/atropine/New()
	add_chem("corpse rot", "corpse rot", 70, 0)
/obj/item/reagent_container/beaker/bucket/atropine2
	icon_state = "canister"
	name = "pedalish canister"
/obj/item/reagent_container/beaker/bucket/atropine2
/obj/item/reagent_container/beaker/bucket/atropine2/New()
	add_chem("biotoxin", "biotoxin", 70, 0)
/obj/item/reagent_container/beaker/bucket/atropine_debug
/obj/item/reagent_container/beaker/bucket/atropine_debug
/obj/item/reagent_container/beaker/bucket/atropine_debug/New()
	add_chem("mitol", "mitol", 20, 0)
/obj/item/reagent_container/beaker/bucket/methanol
	icon_state = "canister"
	name = "canister"
/obj/item/reagent_container/beaker/bucket/methanol
/obj/item/reagent_container/beaker/bucket/methanol/New()
	add_chem("methanol", "methanol", 70, 0)
/obj/item/reagent_container/beaker/bucket/anhydride
	name = "fuel canister"
	icon_state = "canister"
/obj/item/reagent_container/beaker/bucket/anhydride
/obj/item/reagent_container/beaker/bucket/anhydride/New()
	add_chem("acetic anhydride", "acetic anhydride", 70, 0)
/obj/item/reagent_container/beaker/bucket/benzaldehyde
	name = "fuel canister"
	icon_state = "canister"
/obj/item/reagent_container/beaker/bucket/benzaldehyde
/obj/item/reagent_container/beaker/bucket/benzaldehyde/New()
	add_chem("benzaldehyde", "benzaldehyde", 70, 0)
/obj/item/reagent_container/beaker/bucket/amalgam
	icon_state = "canister"
	name = "canister"
/obj/item/reagent_container/beaker/bucket/amalgam
/obj/item/reagent_container/beaker/bucket/amalgam/New()
	add_chem("amalgam", "amalgam", 70, 0)
/obj/item/reagent_container/beaker/bucket/ephedrine
	icon_state = "canister"
	name = "canister"
/obj/item/reagent_container/beaker/bucket/ephedrine
/obj/item/reagent_container/beaker/bucket/ephedrine/New()
	add_chem("ephedrine", "ephedrine", 70, 0)
/obj/item/reagent_container/beaker/bucket/pseudoephedrine
	icon_state = "canister"
	name = "canister"
/obj/item/reagent_container/beaker/bucket/pseudoephedrine
/obj/item/reagent_container/beaker/bucket/pseudoephedrine/New()
	add_chem("pseudoephedrine", "pseudoephedrine", 70, 0)
/obj/item/reagent_container/beaker/bucket/pedal_boom
	icon_state = "canister"
	name = "canister"
/obj/item/reagent_container/beaker/bucket/pedal_boom
/obj/item/reagent_container/beaker/bucket/pedal_boom/New()
	add_chem("nitroglycerin", "nitroglycerin", 70, 0)
/obj/item/reagent_container/beaker/water
	name = "glass beaker"
/obj/item/reagent_container/beaker/water/New()
	add_chem("water", "water", 30, 0)
/obj/item/reagent_container/beaker/foam
	name = "glass beaker"
/obj/item/reagent_container/beaker/foam/New()
	add_chem("foam", "foam powder", 30, 0)
/obj/item/reagent_container/beaker/glass
	maxamount = 30
	icon_state = "glass"
	name = "drinking glass"
/obj/item/reagent_container/beaker/glass
/obj/item/reagent_container/beaker/glass/absenth
	transparent = 0
	name = "absenth"
	icon_state = "glass_green"
/obj/item/reagent_container/beaker/glass/absenth
/obj/item/reagent_container/beaker/glass/absenth/New()
	add_chem("water", "water", 5, 0)
	spawn(1)
		add_chem("ethanol", "ethanol", 20, 0)
		spawn(1) add_chem("MDMA", "MDMA", 5, 0)
/obj/item/reagent_container/beaker/bottle
	maxamount = 30
	beltable = 1
	name = "glass bottle (empty)"
	icon_state = "bottle"
/obj/item/reagent_container/beaker/bottle
/obj/item/reagent_container/beaker/bottle/New()
	..()
	pixel_x += rand(-4, 4)
	pixel_y += rand(-4, 4)
/obj/item/reagent_container/beaker/bottle/large
	maxamount = 50
	parry = 10
	name = "large bottle"
/obj/item/reagent_container/beaker/bottle/large
/obj/item/reagent_container/beaker/bottle/large/vodka
	transparent = 0
	name = "vodka bottle"
	icon_state = "bottle_vodka"
/obj/item/reagent_container/beaker/bottle/large/vodka
/obj/item/reagent_container/beaker/bottle/large/vodka/New()
	add_chem("water", "water", 30, 0)
	spawn(1) add_chem("ethanol", "ethanol", 20, 0)
/obj/item/reagent_container/beaker/bottle/large/oil
	name = "plant oil bottle"
	icon_state = "bottle_oil"
/obj/item/reagent_container/beaker/bottle/large/oil
/obj/item/reagent_container/beaker/bottle/large/oil/New()
	add_chem("plant oil", "plant oil", 50, 0)
/obj/item/reagent_container/beaker/bottle/large/cheating
	name = "pedalious bottle"
	icon_state = "bottle_ammonia"
/obj/item/reagent_container/beaker/bottle/large/cheating
/obj/item/reagent_container/beaker/bottle/large/cheating/New()
	add_chem("nitroglycerin", "nitroglycerin", 50, 0)
/obj/item/reagent_container/beaker/bottle/large/ammonia
	icon_state = "bottle_ammonia"
	name = "ammonia bottle"
/obj/item/reagent_container/beaker/bottle/large/ammonia
/obj/item/reagent_container/beaker/bottle/large/ammonia/New()
	add_chem("ammonia", "ammonia", 50, 0)
/obj/item/reagent_container/beaker/bottle/large/glucose
	name = "glucose bottle (addictions cure)"
	icon_state = "bottle_glucose"
/obj/item/reagent_container/beaker/bottle/large/glucose
/obj/item/reagent_container/beaker/bottle/large/glucose/New()
	add_chem("glucose", "glucose", 50, 0)
/obj/item/reagent_container/beaker/bottle/large/tri_semerki
	transparent = 0
	name = "777 bottle"
	icon_state = "bottle_777"
/obj/item/reagent_container/beaker/bottle/large/tri_semerki
/obj/item/reagent_container/beaker/bottle/large/tri_semerki/New()
	add_chem("water", "water", 7.5, 0)
	spawn(0)
		add_chem("ethanol", "ethanol", 25, 0)
		spawn(0) add_chem("fuel", "fuel", 7.5, 0)
/obj/item/reagent_container/beaker/bottle/large/salut
	name = "Sol. Ephedrini (50pts, 20%)"
	icon_state = "bottle_salut2"
/obj/item/reagent_container/beaker/bottle/large/salut
/obj/item/reagent_container/beaker/bottle/large/salut/New()
	add_chem("water", "water", 40, 0)
	spawn(0) add_chem("ephedrine", "ephedrine", 10, 0)
/obj/item/reagent_container/beaker/bottle/large/coffee
	transparent = 0
	name = "Coffee thermos"
	icon_state = "bottle_thermos"
/obj/item/reagent_container/beaker/bottle/large/coffee
/obj/item/reagent_container/beaker/bottle/large/coffee/New()
	add_chem("caffeine", "caffeine", 40, 0)
	spawn(0)
		add_chem("water", "water", 8, 0)
		add_chem("sugar", "sugar", 2, 0)

/obj/item/reagent_container/beaker/bottle/water
	name = "water bottle"
/obj/item/reagent_container/beaker/bottle/water
/obj/item/reagent_container/beaker/bottle/water/New()
	add_chem("water", "water", 30, 0)
/obj/item/reagent_container/beaker/bottle/hash
	name = "hash oil bottle"
	icon_state = "bottle_brown"
/obj/item/reagent_container/beaker/bottle/hash
/obj/item/reagent_container/beaker/bottle/hash/New()
	add_chem("hash oil", "hash oil", 30, 0)

/obj/item/reagent_container/beaker/bottle/ethanol
	name = "ethanol bottle"
/obj/item/reagent_container/beaker/bottle/ethanol
/obj/item/reagent_container/beaker/bottle/ethanol/New()
	add_chem("ethanol", "ethanol", 30, 0)

/obj/item/reagent_container/beaker/bottle/glycerol
	name = "glycerol bottle"
/obj/item/reagent_container/beaker/bottle/glycerol
/obj/item/reagent_container/beaker/bottle/glycerol/New()
	add_chem("glycerol", "glycerol", 30, 0)
/obj/item/reagent_container/beaker/bottle/starsalve
	transparent = 0
	maxamount = 70
	name = "'Zvyozdochka' starsalve bottle"
	icon_state = "bottle_starsalve"
/obj/item/reagent_container/beaker/bottle/starsalve
/obj/item/reagent_container/beaker/bottle/starsalve/New()
	add_chem("starsalve", "starsalve", 70, 0)


/obj/item/reagent_container/beaker/bottle/carbox
	name = "carboxylic acid bottle"
/obj/item/reagent_container/beaker/bottle/carbox
/obj/item/reagent_container/beaker/bottle/carbox/New()
	add_chem("carboxylic acid", "carboxylic acid", 30, 0)

/obj/item/reagent_container/beaker/bottle/benzaldehyde
	name = "benzaldehyde bottle"
/obj/item/reagent_container/beaker/bottle/benzaldehyde
/obj/item/reagent_container/beaker/bottle/benzaldehyde/New()
	add_chem("benzaldehyde", "benzaldehyde", 30, 0)

/obj/item/reagent_container/beaker/bottle/modafinil
	name = "modafinil bottle"
/obj/item/reagent_container/beaker/bottle/modafinil
/obj/item/reagent_container/beaker/bottle/modafinil/New()
	add_chem("modafinil", "modafinil", 30, 0)

/obj/item/reagent_container/beaker/bottle/ephedrine
	name = "ephedrine bottle"
/obj/item/reagent_container/beaker/bottle/ephedrine
/obj/item/reagent_container/beaker/bottle/ephedrine/New()
	add_chem("ephedrine", "ephedrine", 30, 0)

/obj/item/reagent_container/beaker/bottle/ephedrine/fake
/obj/item/reagent_container/beaker/bottle/ephedrine/fake/New()
	add_chem("pseudoephedrine", "pseudoephedrine", 30, 0)

/obj/item/reagent_container/beaker/bottle/pseudoephedrine
	name = "pseudoephedrine bottle"
/obj/item/reagent_container/beaker/bottle/pseudoephedrine
/obj/item/reagent_container/beaker/bottle/pseudoephedrine/New()
	add_chem("pseudoephedrine", "pseudoephedrine", 30, 0)

/obj/item/reagent_container/beaker/bottle/mda
	name = "MDA bottle"
/obj/item/reagent_container/beaker/bottle/mda
/obj/item/reagent_container/beaker/bottle/mda/New()
	add_chem("MDA", "MDA", 30, 0)

/obj/item/reagent_container/beaker/bottle/mdma
	name = "MDMA bottle"
/obj/item/reagent_container/beaker/bottle/mdma
/obj/item/reagent_container/beaker/bottle/mdma/New()
	add_chem("MDMA", "MDMA", 30, 0)

/obj/item/reagent_container/beaker/bottle/mdoh
	name = "MDOH bottle"
/obj/item/reagent_container/beaker/bottle/mdoh
/obj/item/reagent_container/beaker/bottle/mdoh/New()
	add_chem("MDOH", "MDOH", 30, 0)

/obj/item/reagent_container/beaker/bottle/cellulose
	name = "cellulose bottle"
/obj/item/reagent_container/beaker/bottle/cellulose
/obj/item/reagent_container/beaker/bottle/cellulose/New()
	add_chem("cellulose", "cellulose", 30, 0)
/obj/item/reagent_container/beaker/bottle/ammonia
	name = "ammonia bottle"
	icon_state = "bottle_green"
/obj/item/reagent_container/beaker/bottle/ammonia
/obj/item/reagent_container/beaker/bottle/ammonia/New()
	add_chem("ammonia", "ammonia", 30, 0)
/obj/item/reagent_container/beaker/bottle/fuel
	name = "lamps refilling fuel bottle"
	icon_state = "bottle_fuel"
/obj/item/reagent_container/beaker/bottle/fuel
/obj/item/reagent_container/beaker/bottle/fuel/New()
	add_chem("fuel", "fuel", 20, 0)
/obj/item/reagent_container/beaker/bottle/fuel/large
	name = "chemical F.U.E.L. bottle"
	icon_state = "bottle_purple"
/obj/item/reagent_container/beaker/bottle/fuel/large
/obj/item/reagent_container/beaker/bottle/fuel/large/New()
	add_chem("fuel", "fuel", 30, 0)

/obj/item/reagent_container/beaker/bottle/phenethylamine
	name = "phenethylamine bottle"
/obj/item/reagent_container/beaker/bottle/phenethylamine
/obj/item/reagent_container/beaker/bottle/phenethylamine/New()
	add_chem("phenethylamine", "phenethylamine", 30, 0)

/obj/item/reagent_container/beaker/bottle/yeast
	name = "yeast bottle"
/obj/item/reagent_container/beaker/bottle/yeast
/obj/item/reagent_container/beaker/bottle/yeast/New()
	add_chem("yeast", "yeast", 30, 0)
/obj/item/reagent_container/beaker/bottle/manganeska
	icon_state = "bottle_purple"
	name = "manganeska bottle"
/obj/item/reagent_container/beaker/bottle/manganeska
/obj/item/reagent_container/beaker/bottle/manganeska/New()
	add_chem("manganeska", "manganeska", 30, 0)
/obj/item/reagent_container/beaker/bottle/condensed_milk
	transparent = 0
	name = "condensed milk bottle"
	icon_state = "bottle_white"
/obj/item/reagent_container/beaker/bottle/condensed_milk
/obj/item/reagent_container/beaker/bottle/condensed_milk/New()
	add_chem("condensed milk", "condensed milk", 30, 0)
/obj/item/reagent_container/beaker/bottle/syrup
	name = "Cough syrup"
	icon_state = "bottle_syrup"
/obj/item/reagent_container/beaker/bottle/syrup
/obj/item/reagent_container/beaker/bottle/syrup/New()
	add_chem("water", "water", 10, 0)
	add_chem("paracetamol", "paracetamol", 15, 0)
	spawn(1)
		add_chem("sugar", "sugar", 1.5, 0)
		spawn(1)
			add_chem("DXM", "DXM", 3.5, 0)
/obj/item/reagent_container/beaker/bottle/salut
	name = "Sol. Ephedrini (30pts, 20%)"
	icon_state = "bottle_salut"
/obj/item/reagent_container/beaker/bottle/salut
/obj/item/reagent_container/beaker/bottle/salut/New()
	add_chem("water", "water", 24, 0)
	spawn(0)
		add_chem("ephedrine", "ephedrine", 6, 0)

/obj/item/reagent_container/beaker/bottle/glucose
	name = "Glucose"
/obj/item/reagent_container/beaker/bottle/glucose
/obj/item/reagent_container/beaker/bottle/glucose/New()
	add_chem("glucose", "glucose", 30, 0)
/obj/item/reagent_container/beaker/bottle/stim_med
	icon_state = "bottle_brown"
	name = "Medical stimulation bottle (caffeine 24, ephedrine 6)"
/obj/item/reagent_container/beaker/bottle/stim_med
/obj/item/reagent_container/beaker/bottle/stim_med/New()
	add_chem("caffeine", "caffeine", 24, 0)
	spawn(0) add_chem("ephedrine", "ephedrine", 6, 0)

/obj/item/reagent_container/beaker/bottle/dex
	name = "Pure DXM bottle"
/obj/item/reagent_container/beaker/bottle/dex
/obj/item/reagent_container/beaker/bottle/dex/New()
	add_chem("DXM", "DXM", 30, 0)

/obj/item/reagent_container/beaker/bottle/morphine
	name = "morphine solution bottle"
/obj/item/reagent_container/beaker/bottle/morphine
/obj/item/reagent_container/beaker/bottle/morphine/New()
	add_chem("morphine", "morphine", 10, 0)
	spawn(0) add_chem("water", "water", 20, 0)

/obj/item/reagent_container/beaker/bottle/k
	name = "ketamine solution (20pts) bottle"
/obj/item/reagent_container/beaker/bottle/k
/obj/item/reagent_container/beaker/bottle/k/New()
	add_chem("ketamine", "ketamine", 20, 0)
	spawn(0) add_chem("water", "water", 10, 0)
/obj/item/reagent_container/beaker/tiny/DXM
	tracksize = 2.5
	name = "DXM crystals nickelbag"
	icon_state = "beaker_drug"
/obj/item/reagent_container/beaker/tiny/DXM
/obj/item/reagent_container/beaker/tiny/DXM/New()
	add_chem("DXM", "DXM", 10, 0)
/obj/item/reagent_container/beaker/tiny/DXM/small
	name = "DXM crystals nickelbag"
/obj/item/reagent_container/beaker/tiny/DXM/small/New()
	add_chem("DXM", "DXM", 5, 0)
/obj/item/reagent_container/beaker/tiny/pcp
	tracksize = 4
	name = "phencyclidine nickelbag"
	icon_state = "beaker_pcp"
/obj/item/reagent_container/beaker/tiny/pcp
/obj/item/reagent_container/beaker/tiny/pcp/New()
	add_chem("phencyclidine", "phencyclidine", 10, 0)
/obj/item/reagent_container/beaker/tiny/pcp/half
	name = "phencyclidine nickelbag"
/obj/item/reagent_container/beaker/tiny/pcp/half/New()
	add_chem("phencyclidine", "phencyclidine", 5, 0)
/obj/item/reagent_container/beaker/tiny/k
	tracksize = 4
	icon_state = "beaker_drug"
	name = "ketamine nickelbag"
/obj/item/reagent_container/beaker/tiny/k
/obj/item/reagent_container/beaker/tiny/k/New()
	add_chem("ketamine", "ketamine", 10, 0)

/obj/item/reagent_container/beaker/tiny/k/half
/obj/item/reagent_container/beaker/tiny/k/half/New()
	add_chem("ketamine", "ketamine", 5, 0)
/obj/item/reagent_container/beaker/tiny/mxe
	tracksize = 4
	icon_state = "beaker_drug"
	name = "MXE nickelbag"
/obj/item/reagent_container/beaker/tiny/mxe
/obj/item/reagent_container/beaker/tiny/mxe/New()
	add_chem("MXE", "MXE", 10, 0)

/obj/item/reagent_container/beaker/tiny/mxe/half
/obj/item/reagent_container/beaker/tiny/mxe/half/New()
	add_chem("MXE", "MXE", 5, 0)
/obj/item/reagent_container/beaker/tiny/heroin
	icon_state = "beaker_drug"
	name = "Heroin nickelbag"
/obj/item/reagent_container/beaker/tiny/heroin
/obj/item/reagent_container/beaker/tiny/heroin/New()
	add_chem("heroin", "heroin", 2.4, 0)


/obj/item/reagent_container/beaker/tiny/heroin/half

/obj/item/reagent_container/beaker/tiny/heroin/half/New()
	add_chem("heroin", "heroin", 1.2, 0)

/obj/item/reagent_container/beaker/tiny/heroin/small

/obj/item/reagent_container/beaker/tiny/heroin/small/New()

	add_chem("heroin", "heroin", 0.4, 0)

/obj/item/reagent_container/beaker/tiny/heroin/dose
	name = "Heroin nickelbag (1 injection)"
/obj/item/reagent_container/beaker/tiny/heroin/dose
/obj/item/reagent_container/beaker/tiny/heroin/dose/New()
	add_chem("heroin", "heroin", 0.21, 0)
/obj/item/reagent_container/beaker/tiny/fentanyl
	tracksize = 0.1
	icon_state = "beaker_drug"
	name = "Fentanyl nickelbag"
/obj/item/reagent_container/beaker/tiny/fentanyl
/obj/item/reagent_container/beaker/tiny/fentanyl/New()
	add_chem("fentanyl", "fentanyl", 0.12, 0)

/obj/item/reagent_container/beaker/tiny/fentanyl/half
/obj/item/reagent_container/beaker/tiny/fentanyl/half/New()
	add_chem("fentanyl", "fentanyl", 0.06, 0)

/obj/item/reagent_container/beaker/tiny/fentanyl/small
/obj/item/reagent_container/beaker/tiny/fentanyl/small/New()
	add_chem("fentanyl", "fentanyl", 0.02, 0)
/obj/item/reagent_container/beaker/tiny/methadone
	icon_state = "beaker_drug"
	name = "Methadone nickelbag"
/obj/item/reagent_container/beaker/tiny/methadone
/obj/item/reagent_container/beaker/tiny/methadone/New()
	add_chem("methadone", "methadone", 2.4, 0)

/obj/item/reagent_container/beaker/tiny/methadone/half

/obj/item/reagent_container/beaker/tiny/methadone/half/New()

	add_chem("methadone", "methadone", 1.2, 0)

/obj/item/reagent_container/beaker/tiny/methadone/small

/obj/item/reagent_container/beaker/tiny/methadone/small/New()

	add_chem("methadone", "methadone", 0.4, 0)
/obj/item/reagent_container/beaker/tiny/buprik
	icon_state = "beaker_drug"
	name = "Buprenorphine nickelbag"
/obj/item/reagent_container/beaker/tiny/buprik
/obj/item/reagent_container/beaker/tiny/buprik/New()
	add_chem("buprenorphine", "buprenorphine", 2.4, 0)

/obj/item/reagent_container/beaker/tiny/buprik/half
/obj/item/reagent_container/beaker/tiny/buprik/half/New()
	add_chem("buprenorphine", "buprenorphine", 1.2, 0)

/obj/item/reagent_container/beaker/tiny/buprik/small
/obj/item/reagent_container/beaker/tiny/buprik/small/New()
	add_chem("buprenorphine", "buprenorphine", 0.4, 0)
/obj/item/reagent_container/beaker/tiny/rohypnol
	icon_state = "beaker_drug"
	name = "flunitrazepam nickelbag"
/obj/item/reagent_container/beaker/tiny/rohypnol
/obj/item/reagent_container/beaker/tiny/rohypnol/New()
	add_chem("flunitrazepam", "flunitrazepam", 10, 0)

/obj/item/reagent_container/beaker/tiny/rohypnol/two
/obj/item/reagent_container/beaker/tiny/rohypnol/two/New()
	add_chem("flunitrazepam", "flunitrazepam", 2, 0)

/obj/item/reagent_container/beaker/tiny/rohypnol/start
/obj/item/reagent_container/beaker/tiny/rohypnol/start/New()
	add_chem("flunitrazepam", "flunitrazepam", 4, 0)
/obj/item/reagent_container/beaker/tiny/speed
	tracksize = 2
	icon_state = "beaker_drug"
	name = "Amphetamine nickelbag"
/obj/item/reagent_container/beaker/tiny/speed
/obj/item/reagent_container/beaker/tiny/speed/New()
	add_chem("amphetamine", "amphetamine", 10, 0)

/obj/item/reagent_container/beaker/tiny/speed/faked
/obj/item/reagent_container/beaker/tiny/speed/faked/New()
	var/bodyaga = rand(1, 4)
	add_chem("amphetamine", "amphetamine", 10 - bodyaga, 0)
	spawn(0) add_chem("sugar", "sugar", bodyaga, 0)

/obj/item/reagent_container/beaker/tiny/meow5
	tracksize = 2
	icon_state = "beaker_drug"
	name = "Meowing nickelbag"
/obj/item/reagent_container/beaker/tiny/meow5
/obj/item/reagent_container/beaker/tiny/meow5/New()
	add_chem("mephedrone", "mephedrone", 5, 0)
/obj/item/reagent_container/beaker/tiny/meow10
	tracksize = 2
	icon_state = "beaker_drug"
	name = "Meowing nickelbag"
/obj/item/reagent_container/beaker/tiny/meow10
/obj/item/reagent_container/beaker/tiny/meow10/New()
	add_chem("mephedrone", "mephedrone", 10, 0)
/obj/item/reagent_container/beaker/tiny/cocaine6
	tracksize = 2
	icon_state = "beaker_drug"
	name = "Cocaine nickelbag"
/obj/item/reagent_container/beaker/tiny/cocaine6
/obj/item/reagent_container/beaker/tiny/cocaine6/New()
	add_chem("cocaine", "cocaine", 6, 0)
/obj/item/reagent_container/beaker/tiny/cocaine12
	tracksize = 2
	icon_state = "beaker_drug"
	name = "Cocaine nickelbag"
/obj/item/reagent_container/beaker/tiny/cocaine12
/obj/item/reagent_container/beaker/tiny/cocaine12/New()
	add_chem("cocaine", "cocaine", 12, 0)
/obj/item/reagent_container/beaker/tiny/mdpv
	icon_state = "beaker_drug"
	name = "MDPV nickelbag"
/obj/item/reagent_container/beaker/tiny/mdpv
/obj/item/reagent_container/beaker/tiny/mdpv/New()
	add_chem("MDPV", "MDPV", 10, 0)
/obj/item/reagent_container/beaker/tiny/DOB
	icon_state = "beaker_drug"
	name = "DOB nickelbag"
/obj/item/reagent_container/beaker/tiny/DOB
/obj/item/reagent_container/beaker/tiny/DOB/New()
	add_chem("DOB", "DOB", 0.84, 0)
	spawn(0) add_chem("glucose", "glucose", 1.16, 0)
/obj/item/reagent_container/beaker/tiny/DOI
	icon_state = "beaker_drug"
	name = "DOI nickelbag"
/obj/item/reagent_container/beaker/tiny/DOI
/obj/item/reagent_container/beaker/tiny/DOI/New()
	add_chem("DOI", "DOI", 1.2, 0)
	spawn(0) add_chem("glucose", "glucose", 0.8, 0)
/obj/item/reagent_container/beaker/tiny/DOC
	icon_state = "beaker_drug"
	name = "DOC nickelbag"
/obj/item/reagent_container/beaker/tiny/DOC
/obj/item/reagent_container/beaker/tiny/DOC/New()
	add_chem("DOC", "DOC", 1.2, 0)
	spawn(0) add_chem("glucose", "glucose", 0.8, 0)
/obj/item/reagent_container/beaker/tiny/DOM
	icon_state = "beaker_drug"
	name = "DOM nickelbag"
/obj/item/reagent_container/beaker/tiny/DOM
/obj/item/reagent_container/beaker/tiny/DOM/New()
	add_chem("DOM", "DOM", 1.2, 0)
	spawn(0) add_chem("glucose", "glucose", 0.8, 0)
/obj/item/reagent_container/beaker/tiny/meth
	tracksize = 2
	icon_state = "beaker_drug"
	name = "Methamphetamine nickelbag"
/obj/item/reagent_container/beaker/tiny/meth
/obj/item/reagent_container/beaker/tiny/meth/New()
	add_chem("methamphetamine", "methamphetamine", 10, 0)

/obj/item/reagent_container/beaker/tiny/meth/faked
/obj/item/reagent_container/beaker/tiny/meth/faked/New()
	add_chem("methamphetamine", "methamphetamine", 7.5, 0)
	spawn(0) add_chem("MDPV", "MDPV", 2.5, 0)

/obj/item/reagent_container/beaker/tiny/nexus
	tracksize = 2
	icon_state = "beaker_drug"
	name = "2C-B nickelbag"
/obj/item/reagent_container/beaker/tiny/nexus
/obj/item/reagent_container/beaker/tiny/nexus/New()
	add_chem("2C-B", "2C-B", 10, 0)
/obj/item/reagent_container/beaker/tiny/nbome
	icon_state = "beaker_drug"
	name = "25i-NBOMe nickelbag"
/obj/item/reagent_container/beaker/tiny/nbome
/obj/item/reagent_container/beaker/tiny/nbome/New()
	add_chem("25i-NBOMe", "25i-NBOMe", 10, 0)
/obj/item/reagent_container/beaker/tiny/lsa
	icon_state = "beaker_drug"
	name = "LSA nickelbag"
/obj/item/reagent_container/beaker/tiny/lsa
/obj/item/reagent_container/beaker/tiny/lsa/New()
	add_chem("LSA", "LSA", 3, 0)
	spawn(0) add_chem("water", "water", 7, 0)

/obj/item/reagent_container/beaker/tiny/lsa/great
/obj/item/reagent_container/beaker/tiny/lsa/great/New()
	add_chem("LSA", "LSA", 6, 0)
	spawn(0) add_chem("water", "water", 4, 0)
/obj/item/reagent_container/beaker/tiny/dmt
	icon_state = "beaker_drug"
	name = "DMT nickelbag"
/obj/item/reagent_container/beaker/tiny/dmt
/obj/item/reagent_container/beaker/tiny/dmt/New()
	add_chem("DMT", "DMT", 10, 0)

/obj/item/reagent_container/beaker/tiny/dmt/faked
/obj/item/reagent_container/beaker/tiny/dmt/faked/New()
	add_chem("DMT", "DMT", 5, 0)
	spawn(0) add_chem("5-MeO-DMT", "5-MeO-DMT", 5, 0)

/obj/item/reagent_container/beaker/tiny/dmt/half
/obj/item/reagent_container/beaker/tiny/dmt/half/New()
	add_chem("DMT", "DMT", 5, 0)

/obj/item/reagent_container/beaker/tiny/dmt/half/faked
/obj/item/reagent_container/beaker/tiny/dmt/half/faked/New()
	add_chem("DMT", "DMT", 3, 0)
	spawn(0) add_chem("5-MeO-DMT", "5-MeO-DMT", 2, 0)

/obj/item/reagent_container/beaker/tiny/fivemeo
	icon_state = "beaker_drug"
	name = "5-MeO-DMT nickelbag"
/obj/item/reagent_container/beaker/tiny/fivemeo
/obj/item/reagent_container/beaker/tiny/fivemeo/New()
	add_chem("5-MeO-DMT", "5-MeO-DMT", 10, 0)
/obj/item/reagent_container/beaker/tiny/dipt
	icon_state = "beaker_drug"
	name = "DiPT nickelbag"
/obj/item/reagent_container/beaker/tiny/dipt
/obj/item/reagent_container/beaker/tiny/dipt/New()
	add_chem("DiPT", "DiPT", 10, 0)
/obj/item/reagent_container/beaker/tiny/homet
	icon_state = "beaker_drug"
	name = "4-HO-MET nickelbag"
/obj/item/reagent_container/beaker/tiny/homet
/obj/item/reagent_container/beaker/tiny/homet/New()
	add_chem("4-HO-MET", "4-HO-MET", 10, 0)

/obj/item/reagent_container/beaker/tiny/nexus/half

/obj/item/reagent_container/beaker/tiny/nexus/half/New()

	add_chem("2C-B", "2C-B", 5, 0)
/obj/item/reagent_container/beaker/tiny/starsalve
	transparent = 0
	name = "'Zvyozdochka' starsalve"
	icon_state = "beaker_starsalve"
/obj/item/reagent_container/beaker/tiny/starsalve
/obj/item/reagent_container/beaker/tiny/starsalve/New()
	add_chem("starsalve", "starsalve", 10, 0)
/obj/item/reagent_container/beaker/tiny/gaba
	name = "GABA mini-beaker"
	icon_state = "beaker_gaba"
/obj/item/reagent_container/beaker/tiny/gaba
/obj/item/reagent_container/beaker/tiny/gaba/New()
	add_chem("GABA", "GABA", 10, 0)
/obj/item/reagent_container/beaker/tiny/iodine
	name = "iodine solution one-time bottle"
	icon_state = "beaker_iodine"
/obj/item/reagent_container/beaker/tiny/iodine
/obj/item/reagent_container/beaker/tiny/iodine/New()
	add_chem("iodine", "iodine", 8, 0)
	spawn(0)
		add_chem("ethanol", "ethanol", 1, 0)
		spawn(0)
			add_chem("water", "water", 1, 0)
/obj/item/reagent_container/beaker/tiny/dextroamitriptine
	name = "stim/smoking addiction cure bottle"
	icon_state = "bottle_security"
/obj/item/reagent_container/beaker/tiny/dextroamitriptine
/obj/item/reagent_container/beaker/tiny/dextroamitriptine/New()
	add_chem("dextroamitriptine", "dextroamitriptine", 8, 0)
	add_chem("water", "water", 2, 0)

/obj/item/reagent_container/beaker/tiny/phosphorus
	name = "phosphorus fertiliser bottle"
	icon_state = "beaker_phosphorus"
/obj/item/reagent_container/beaker/tiny/phosphorus
/obj/item/reagent_container/beaker/tiny/phosphorus/New()
	add_chem("phosphorus", "phosphorus", 10, 0)
/obj/item/reagent_container/beaker/tiny/novichok
	tracksize = 0.1
	icon_state = "beaker_drug"
	name = "Novichok nickelbag"
/obj/item/reagent_container/beaker/tiny/novichok
/obj/item/reagent_container/beaker/tiny/novichok/New()
	add_chem("novichok", "novichok", 1, 0)
/obj/item/reagent_container/beaker/speed
	icon_state = "bottle"
	name = "amphetamine beaker"
/obj/item/reagent_container/beaker/speed
/obj/item/reagent_container/beaker/speed/New()
	add_chem("amphetamine", "amphetamine", 50, 0)

/obj/item/reagent_container/beaker/speed/faked
/obj/item/reagent_container/beaker/speed/faked/New()
	var/bodyaga = rand(5, 10)
	add_chem("amphetamine", "amphetamine", 50 - bodyaga, 0)
	spawn(0) add_chem("MDPV", "MDPV", bodyaga, 0)

/obj/item/reagent_container/beaker/meth
	name = "methamphetamine beaker"
/obj/item/reagent_container/beaker/meth
/obj/item/reagent_container/beaker/meth/New()
	add_chem("methamphetamine", "methamphetamine", 50, 0)

/obj/item/reagent_container/beaker/meow50
	name = "mephedrone beaker"
/obj/item/reagent_container/beaker/meow50
/obj/item/reagent_container/beaker/meow50/New()
	add_chem("mephedrone", "mephedrone", 50, 0)
/obj/item/reagent_container/beaker/psilo
	icon_state = "bottle"
	name = "psilocybin beaker"
/obj/item/reagent_container/beaker/psilo
/obj/item/reagent_container/beaker/psilo/New()
	add_chem("psilocybin", "psilocybin", 20, 0)

/obj/item/reagent_container/beaker/designer_shining
	icon_state = "bottle"
/obj/item/reagent_container/beaker/designer_shining
/obj/item/reagent_container/beaker/designer_shining/New()
	add_chem("eldritch powder", "eldritch powder", 20, 0)
/obj/item/reagent_container/beaker/bottle/trank
	name = "emergency calming bottle"
	icon_state = "bottle_darkgreen"
/obj/item/reagent_container/beaker/bottle/trank
/obj/item/reagent_container/beaker/bottle/trank/New()
	add_chem("phenazepam", "phenazepam", 9, 0)
	spawn(0)
		add_chem("alprazolam", "alprazolam", 6, 0)
		spawn(0)
			add_chem("barbital", "barbital", 9, 0)
			spawn(0)
				add_chem("phenobarbital", "phenobarbital", 6, 0)
/obj/item/reagent_container/beaker/bottle/korvalol
	name = "Korvalol bottle"
	icon_state = "bottle_dark"
/obj/item/reagent_container/beaker/bottle/korvalol
/obj/item/reagent_container/beaker/bottle/korvalol/New()
	add_chem("water", "water", 12, 0)
	add_chem("sugar", "sugar", 6, 0)
	add_chem("ethanol", "ethanol", 6, 0)
	add_chem("phenobarbital", "phenobarbital", 6, 0)
/obj/item/reagent_container/beaker/bottle/midaz
	icon_state = "bottle_white"
	name = "midazolam solution bottle"
/obj/item/reagent_container/beaker/bottle/midaz
/obj/item/reagent_container/beaker/bottle/midaz/New()
	add_chem("midazolam", "midazolam", 24, 0)
	spawn(0) add_chem("water", "water", 6, 0)
/obj/item/reagent_container/beaker/bottle/antidote
	name = "antidote bottle"
	icon_state = "bottle_blue"
/obj/item/reagent_container/beaker/bottle/antidote
/obj/item/reagent_container/beaker/bottle/antidote/New()
	add_chem("antidote", "antidote", 30, 0)
/obj/item/reagent_container/beaker/bottle/regen
	name = "regenerite bottle"
	icon_state = "bottle_red"
/obj/item/reagent_container/beaker/bottle/regen
/obj/item/reagent_container/beaker/bottle/regen/New()
	add_chem("regenerite", "regenerite", 30, 0)
/obj/item/reagent_container/beaker/bottle/regen/solut
	name = "soluted regenerite (10 pts) bottle"
/obj/item/reagent_container/beaker/bottle/regen/solut
/obj/item/reagent_container/beaker/bottle/regen/solut/New()
	add_chem("regenerite", "regenerite", 10, 0)
	add_chem("water", "water", 10, 0)
/obj/item/reagent_container/beaker/bottle/prothesine
	name = "prothesine bottle"
	icon_state = "bottle_prothesine"
/obj/item/reagent_container/beaker/bottle/prothesine
/obj/item/reagent_container/beaker/bottle/prothesine/New()
	add_chem("prothesine", "prothesine", 30, 0)
/obj/item/reagent_container/beaker/bottle/warnipizine
	icon_state = "bottle_prothesine"
	name = "pure warnpinizine bottle"
/obj/item/reagent_container/beaker/bottle/warnipizine
/obj/item/reagent_container/beaker/bottle/warnipizine/New()
	add_chem("warnipizine", "warnipizine", 30, 0)
/obj/item/reagent_container/beaker/bottle/ambro
	icon_state = "bottle_purple"
	name = "ambrosine bottle"
/obj/item/reagent_container/beaker/bottle/ambro
/obj/item/reagent_container/beaker/bottle/ambro/New()
	add_chem("ambrosine", "ambrosine", 30, 0)
/obj/item/reagent_container/beaker/bottle/ambro_plus
	name = "ambrobene+ bottle"
	icon_state = "bottle_syrup2"
/obj/item/reagent_container/beaker/bottle/ambro_plus
/obj/item/reagent_container/beaker/bottle/ambro_plus/New()
	add_chem("ambrosine", "ambrosine", 25, 0)
	spawn(0)
		add_chem("codeine", "codeine", 5, 0)
/obj/item/reagent_container/beaker/bottle/fibgen
	name = "fibgenerite bottle"
	icon_state = "bottle_yellow"
/obj/item/reagent_container/beaker/bottle/fibgen
/obj/item/reagent_container/beaker/bottle/fibgen/New()
	add_chem("fibgenerite", "fibgenerite", 30, 0)
/obj/item/reagent_container/beaker/bottle/ssanina
	icon_state = "bottle_yellow"
	name = "-3 -5 left-ssaninamine (urea) bottle"
/obj/item/reagent_container/beaker/bottle/ssanina
/obj/item/reagent_container/beaker/bottle/ssanina/New()
	add_chem("urea", "urea", 30, 0)
/obj/item/reagent_container/beaker/bottle/toxin
	icon_state = "bottle_green"
	name = "toxin bottle"
/obj/item/reagent_container/beaker/bottle/toxin
/obj/item/reagent_container/beaker/bottle/toxin/New()
	add_chem("toxin", "toxin", 30, 0)

/obj/item/reagent_container/beaker/bottle/haloperidol
	name = "haloperidol bottle"
/obj/item/reagent_container/beaker/bottle/haloperidol
/obj/item/reagent_container/beaker/bottle/haloperidol/New()
	add_chem("haloperidol", "haloperidol", 30, 0)
/obj/item/reagent_container/beaker/bottle/thiopental
	icon_state = "bottle_security"
	name = "thiopental solution bottle (for interrogation, don't use more than 1 syringe)"
/obj/item/reagent_container/beaker/bottle/thiopental
/obj/item/reagent_container/beaker/bottle/thiopental/New()
	add_chem("sodium thiopental", "sodium thiopental", 6, 0)
	spawn(0) add_chem("water", "water", 24, 0)
/obj/item/reagent_container/beaker/bottle/thiopental_big
	name = "pure thiopental bottle (for immobilization)"
	icon_state = "bottle_security2"
/obj/item/reagent_container/beaker/bottle/thiopental_big
/obj/item/reagent_container/beaker/bottle/thiopental_big/New()
	add_chem("sodium thiopental", "sodium thiopental", 30, 0)
/obj/item/reagent_container/beaker/bottle/halo_security
	icon_state = "bottle_security2"
	name = "haloperidol bottle (for immobilization)"
/obj/item/reagent_container/beaker/bottle/halo_security
/obj/item/reagent_container/beaker/bottle/halo_security/New()
	add_chem("haloperidol", "haloperidol", 15, 0)
/obj/item/reagent_container/beaker/bottle/amobarbital
	icon_state = "bottle_security"
	name = "amobarbital bottle (for interrogation)"
/obj/item/reagent_container/beaker/bottle/amobarbital
/obj/item/reagent_container/beaker/bottle/amobarbital/New()
	add_chem("amobarbital", "amobarbital", 24, 0)
	spawn(0) add_chem("water", "water", 6, 0)

/obj/item/reagent_container/beaker/bottle/beer
	transparent = 0
	name = "jigulevskoe beer can"
	icon_state = "beer"
/obj/item/reagent_container/beaker/bottle/beer
/obj/item/reagent_container/beaker/bottle/beer/New()
	add_chem("water", "water", 21, 0)
	spawn(0)
		add_chem("ethanol", "ethanol", 5, 0)
		spawn(0) add_chem("nutriment", "nutriment", 4, 0)
/obj/item/reagent_container/beaker/bottle/tea
	transparent = 0
	name = "space chifeer can"
	icon_state = "tea"
/obj/item/reagent_container/beaker/bottle/tea
/obj/item/reagent_container/beaker/bottle/tea/New()
	add_chem("water", "water", 15, 0)
	spawn(0)
		add_chem("GABA", "GABA", 2, 0)
		spawn(0)
			add_chem("caffeine", "caffeine", 10, 0)
			spawn(0) add_chem("nutriment", "nutriment", 3, 0)
/obj/item/reagent_container/beaker/bottle/stim
	transparent = 0
	name = "Soulstorm softdrink can"
	icon_state = "stim"
/obj/item/reagent_container/beaker/bottle/stim
/obj/item/reagent_container/beaker/bottle/stim/New()
	add_chem("water", "water", 15, 0)
	spawn(0)
		add_chem("caffeine", "caffeine", 6, 0)
		spawn(0)
			add_chem("pseudoephedrine", "pseudoephedrine", 1.98, 0)
			spawn(0)
				add_chem("sugar", "sugar", 2, 0)
/obj/item/reagent_container/beaker/bottle/stim2
	transparent = 0
	name = "Soulstorm+ harddrink can"
	icon_state = "stim2"
/obj/item/reagent_container/beaker/bottle/stim2
/obj/item/reagent_container/beaker/bottle/stim2/New()
	add_chem("water", "water", 12.4, 0)
	spawn(0)
		add_chem("MDPV", "MDPV", 3.6, 0)
		spawn(0)
			add_chem("ephedrine", "ephedrine", 3, 0)
			spawn(0)
				add_chem("sugar", "sugar", 6, 0)
/obj/item/reagent_container/beaker/bottle/titbit
	transparent = 0
	name = "Nuclear titbit can"
	icon_state = "titbeat"
/obj/item/reagent_container/beaker/bottle/titbit
/obj/item/reagent_container/beaker/bottle/titbit/New()
	add_chem("Nuclear titbit", "Nuclear titbit", 30, 0)
/obj/item/reagent_container/beaker/bottle/tuborg
	transparent = 0
	name = "spess tuborg can"
	icon_state = "tuborg"
/obj/item/reagent_container/beaker/bottle/tuborg
/obj/item/reagent_container/beaker/bottle/tuborg/New()
	add_chem("water", "water", 15, 0)
	spawn(0)
		add_chem("ethanol", "ethanol", 8, 0)
		spawn(0) add_chem("nutriment", "nutriment", 7, 0)
/obj/item/reagent_container/beaker/bottle/tuborg/empty
	name = "old can"
	icon_state = "tuborg_empty"
/obj/item/reagent_container/beaker/bottle/tuborg/empty
/obj/item/reagent_container/beaker/bottle/tuborg/empty/New()
	add_chem("water", "water", 1.5, 0)
	spawn(0)
		add_chem("ethanol", "ethanol", 0.8, 0)
/obj/item/reagent_container/beaker/bottle/alchostim
	name = "Cheetah low alchohol drink (keep away from children!)"
	icon_state = "bottle_jaguar"
/obj/item/reagent_container/beaker/bottle/alchostim
/obj/item/reagent_container/beaker/bottle/alchostim/New()
	add_chem("water", "water", 20, 0)
	add_chem("pseudoephedrine", "pseudoephedrine", 2, 0)
	add_chem("ethanol", "ethanol", 8, 0)


/obj/item/reagent_container/beaker/bottle/tourette
	name = "mysterious bottle"
/obj/item/reagent_container/beaker/bottle/tourette
/obj/item/reagent_container/beaker/bottle/tourette/New()
	add_chem("nitrogen tourettinide", "nitrogen tourettinide", 30, 0)

/obj/item/reagent_container/beaker/bottle/mind
	name = "cognitology bottle"
	icon_state = "bottle_mind"

/obj/item/reagent_container/beaker/bottle/mind

/obj/item/reagent_container/beaker/bottle/mind/New()



	var/wut = rand(1, 4)
	switch(wut)
		if(1)
			add_chem("psilocybin", "psilocybin", 30, 0)
		if(2)
			add_chem("LSD", "LSD", 0.5, 0)
			spawn(0) add_chem("water", "water", 29.5, 0)
		if(3)
			add_chem("DOB", "DOB", 0.14, 0)
			spawn(0) add_chem("water", "water", 29.86, 0)
		if(4)



			add_chem("DXM", "DXM", 18, 0)
			spawn(0) add_chem("water", "water", 12, 0)


/obj/item/reagent_container/beaker/bottle/LSD
	name = "LSD-25 bottle"

/obj/item/reagent_container/beaker/bottle/LSD
/obj/item/reagent_container/beaker/bottle/LSD/New()
	add_chem("LSD", "LSD", 3, 0)
	spawn(0) add_chem("water", "water", 27, 0)

/obj/item/reagent_container/beaker/bottle/pedal
	icon_state = "bottle_green"
	name = "test stuff bottle"
/obj/item/reagent_container/beaker/bottle/pedal
/obj/item/reagent_container/beaker/bottle/pedal/New()
	add_chem("inytropidril", "inytropidril", 30, 0)
/obj/item/reagent_container/beaker/bottle/rot
	icon_state = "bottle_white"
	name = "suspicious bottle"
/obj/item/reagent_container/beaker/bottle/rot
/obj/item/reagent_container/beaker/bottle/rot/New()
	add_chem("corpse rot", "corpse rot", 30, 0)


/obj/structure/liquid_dispenser/attack_by(obj/item/I)










	if(amount > 0)
		if(istype(I, /obj/item/reagent_container/beaker))
			var/obj/item/reagent_container/beaker/B = I
			var/bamount
			for(var/datum/reagent/RE in B:reagent_list)
				bamount += RE.amount
			usr << "\blue You transfer some liquid from [src]."
			if(transfer_amount <= amount)
				if(bamount == B:maxamount)
					usr << "\red The beaker is full!"
				else if(bamount + transfer_amount >= B:maxamount)
					var/derps = B:maxamount - bamount
					B:add_chem(chemid, chemid, derps, 0)
					amount -= derps
				else
					B:add_chem(chemid, chemname, transfer_amount, 0)
					amount -= transfer_amount
			else
				if(bamount == B:maxamount)
					usr << "\red The beaker is full!"
				else if(bamount + amount >= B:maxamount)
					var/derps = B:maxamount - bamount
					B:add_chem(chemid, chemid, derps, 0)
					amount -= derps
				else
					B:add_chem(chemid, chemname, amount, 0)
					spawn(0) amount = 0
		else if(istype(I, /obj/item/tool/torch) && (I:charges < 7 && chemid == "fuel"))
			usr << "\blue You refill your welder."
			if(transfer_amount <= 7 - I:charges)
				I:fuel(transfer_amount)
				if(transfer_amount <= amount)
					amount -= transfer_amount
				else
					spawn(0) amount = 0
			else
				I:fuel(7 - I:charges)
				if(amount >= 7 - I:charges)
					amount -= 7 - I:charges
				else
					spawn(0) amount = 0
		spawn(0)
			if(amount > 50)
				return
			else if(amount > 35)
				icon_state = "dispenser_[chemname]_half"
			else if(amount > 0)
				icon_state = "dispenser_[chemname]_some"
			else
				icon_state = "dispenser_[chemname]_empty"
	else
		usr << "\red Damn, it is empty!"

/obj/item/reagent_container/grenade
	maxamount = 999
	beltable = 1
	metal_need = 2
	icon_state = "grenade"
	var/obj/beaker1 = null
	var/obj/beaker2 = null
	var/secured = 0
	var/traitor = 0

/obj/item/reagent_container/grenade

/obj/item/reagent_container/grenade/attack_by(obj/I)


































	if(istype(I, /obj/item/tool/chemscan))
		usr << "\red Current temperature: [src.temp]"
		for(var/datum/reagent/R in src.reagent_list)
			usr << "\blue [R.name]: [R.amount]"
	else if(src.secured)
		usr << "\red The grenade is secured!"
		return
	else if(istype(I, /obj/item/reagent_container/beaker) && (src.traitor || !istype(I, /obj/item/reagent_container/beaker/bucket) && !istype(I, /obj/item/reagent_container/beaker/bottle/large)))
		usr << "\blue You add the [I] to your construction."
		src.add_beaker(I)
	else if(istype(I, /obj/item/tool/screwdriver))
		usr << "\blue You secure the grenade."
		src.secured = 1
		src.icon_state = "grenade_secured"
/obj/item/reagent_container/grenade/proc/add_beaker(obj/I)
	if(src.beaker1 == null)
		src.beaker1 = I
		spawn(0)
			if(usr)
				usr.dropitem()
			I:loc = src
	else if(src.beaker2 == null)
		src.beaker2 = I
		spawn(0)
			if(usr)
				usr.dropitem()
			I:loc = src


/obj/item/reagent_container/grenade/after_attack(A as mob|obj|turf, mob/user)
	if(src.secured)
		var/g = new /obj/grenade_bullet(user:loc)
		g:target_x = A:x - user:x
		g:target_y = A:y - user:y
		g:icon_state = src.icon_state
		g:gr = src
		spawn(0)
			user:dropitem()
			src.loc = g
			spawn(0) g:process()

/obj/grenade_bullet/process()









	spawn(0)
		while(src)
			if(!src.current)
				src.current = locate(x + src.target_x, y + src.target_y, src.z)
			step_towards(src, src.current)
			if(loc == src.current)
				src.Bump(src.loc)
				return
			for(var/obj/A as obj in loc)
				if(A.density || istype(A, /obj/bio/amoeba))
					src.Bump(A)
					return
			for(var/mob/M in loc)
				src.Bump(M)
				return
			if(loc:density)
				Bump(loc)
				return
			sleep(0.4 / world.tick_lag)

/obj/grenade_bullet/Bump(atom/A)
	gr:loc = src.loc
	for(var/mob/M in hearers(src))
		if(!M.sleeps)
			M << "\red crack"
	spawn(0)
		if(src.gr:beaker1)
			gr:beaker1:transfer_mix(src.gr:beaker1:maxamount, src.gr)
			spawn(0)
				if(src.gr:beaker2)
					gr:beaker2:transfer_mix(src.gr:beaker2:maxamount, src.gr)
		spawn(1)
			if(src.gr)
				gr:shake()
				spawn(1)
					if(src.gr)
						del(src.gr)
					spawn(0) del(src)
/obj/item/reagent_container/grenade/combat
	secured = 1
	metal_need = 8
	wood_need = 2
	plastic_need = 2
	name = "limonka-class grenade"
	desc = "A military hand-grenade."
	icon_state = "limonka"
/obj/item/reagent_container/grenade/combat
/obj/item/reagent_container/grenade/combat/New()
	var/b = new /obj/item/reagent_container/beaker(src.loc)
	b:add_chem("nitroglycerin", "nitroglycerin", 5, 0)
	spawn(0)
		add_beaker(b)
		spawn(0)
			var/b1 = new /obj/item/reagent_container/beaker(src.loc)
			b1:add_chem("nitroglycerin", "nitroglycerin", 5, 0)
			spawn(0) src.add_beaker(b1)
/obj/item/reagent_container/grenade/combat/pedal
	name = "limonka-class grenade"
/obj/item/reagent_container/grenade/combat/pedal/New()
	var/b = new /obj/item/reagent_container/beaker(src.loc)
	b:add_chem("nitroglycerin", "nitroglycerin", 50, 0)
	spawn(0)
		add_beaker(b)
		spawn(0)
			var/b1 = new /obj/item/reagent_container/beaker(src.loc)
			b1:add_chem("nitroglycerin", "nitroglycerin", 50, 0)
			spawn(0) src.add_beaker(b1)
/obj/item/reagent_container/grenade/security
	secured = 1
	metal_need = 6
	plastic_need = 23
	name = "security grenade"
	desc = "A light security hand-grenade."
	icon_state = "weak_boom"
/obj/item/reagent_container/grenade/security
/obj/item/reagent_container/grenade/security/New()
	var/b = new /obj/item/reagent_container/beaker(src.loc)
	b:add_chem("water", "water", 20, 0)
	spawn(0)
		add_beaker(b)
		spawn(0)
			var/b1 = new /obj/item/reagent_container/beaker(src.loc)
			b1:add_chem("lithium", "lithium", 20, 0)
			spawn(0) src.add_beaker(b1)
/obj/item/reagent_container/grenade/foam
	secured = 1
	metal_need = 2
	silicon_need = 2
	icon_state = "grenade_secured"
	name = "firefighting foam grenade"
	desc = "For especially lazy firefighters."
/obj/item/reagent_container/grenade/foam
/obj/item/reagent_container/grenade/foam/New()
	var/b = new /obj/item/reagent_container/beaker(src.loc)
	b:add_chem("foam", "foam", 30, 0)
	spawn(0)
		add_beaker(b)
		spawn(0)
			var/b1 = new /obj/item/reagent_container/beaker(src.loc)
			b1:add_chem("water", "water", 30, 0)
			spawn(0) src.add_beaker(b1)
/obj/item/reagent_container/grenade/montage
	secured = 1
	metal_need = 2
	silicon_need = 2
	icon_state = "grenade_secured"
	name = "montage grenade"
	desc = "For rapid fixing of holes in station hull."
/obj/item/reagent_container/grenade/montage
/obj/item/reagent_container/grenade/montage/New()
	var/b = new /obj/item/reagent_container/beaker(src.loc)
	b:add_chem("montage powder", "montage powder", 30, 0)
	spawn(0)
		add_beaker(b)
		spawn(0)
			var/b1 = new /obj/item/reagent_container/beaker(src.loc)
			b1:add_chem("water", "water", 30, 0)
			spawn(0) src.add_beaker(b1)

/obj/item/reagent_container/grenade/smokey
	secured = 1
	metal_need = 10
	plastic_need = 10
	icon_state = "grenade_secured"
	name = "hot gas grenade"
	desc = "Especially effective in closed areas."
/obj/item/reagent_container/grenade/smokey
/obj/item/reagent_container/grenade/smokey/New()
	var/b = new /obj/item/reagent_container/beaker(src.loc)
	b:add_chem("liquid smoke", "liquid smoke", 30, 0)
	spawn(0)
		add_beaker(b)
		spawn(0)
			var/b1 = new /obj/item/reagent_container/beaker(src.loc)
			b1:add_chem("water", "water", 30, 0)
			spawn(0) src.add_beaker(b1)
/obj/item/reagent_container/grenade/napalm
	secured = 1
	metal_need = 8
	wood_need = 2
	plastic_need = 2
	icon_state = "grenade_secured"
	name = "ignition grenade"
	desc = "Mother of Jesus."
/obj/item/reagent_container/grenade/napalm
/obj/item/reagent_container/grenade/napalm/New()
	var/b = new /obj/item/reagent_container/beaker(src.loc)
	b:add_chem("liquid smoke", "liquid smoke", 30, 0)
	spawn(0)
		add_beaker(b)
		spawn(0)
			var/b1 = new /obj/item/reagent_container/beaker(src.loc)
			b1:add_chem("fuel", "fuel", 30, 0)
			spawn(0) src.add_beaker(b1)

/obj/syringe_bullet/process()















	var/maxdistance = 35
	var/travdistance = 0
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
				if(A.density || istype(A, /obj/bio/amoeba))
					src.Bump(A)
					return
			for(var/mob/M in loc)
				src.Bump(M)
				return
			if(loc:density)
				Bump(loc)
				return
			sleep(0.2 / world.tick_lag)
/obj/syringe_bullet/Bump(atom/A)
	S:loc = src.loc
	if(istype(A, /mob))
		src.S:transfer_to_mob(src.S:maxamount, A)
	spawn(1)
		if(src.S)
			del(src.S)
		spawn(1) del(src)






/obj/item/weapon/syringe_gun/attack_by(obj/I)


	if(istype(I, /obj/item/reagent_container/syringe) && !src.S)

		var/SR = I

		if(SR:onetime)
			usr << "\red Nope, you can't load it with injectors."
			return

		usr << "You load your [src] with [I]."
		src.S = I
		src.icon_state = "syringe_gun_loaded"
		spawn(0)
			if(usr)
				usr.dropitem()
			I:loc = src
/obj/item/weapon/syringe_gun/after_attack(A as mob|obj|turf, mob/user)
	if(!src.S)
		return
	var/sb = new /obj/syringe_bullet(user:loc)
	sb:target_x = A:x - user:x
	sb:target_y = A:y - user:y
	sb:S = src:S
	spawn(0)
		sb:process()
		spawn(0)
			src.S = null
			src.icon_state = "syringe_gun"

/obj/item/reagent_container/consumable/spice/New()














	src.add_chem("JWH-018", "JWH-018", 0.5, 0)
/obj/item/reagent_container/consumable/spice/gold
	ret = 30
	grun = 60
	name = "spice gold"
	icon_state = "spice_gold"
/obj/item/reagent_container/consumable/spice/gold
/obj/item/reagent_container/consumable/spice/gold/New()
	src.add_chem("JWH-018", "JWH-018", 0.9, 0)
/obj/item/reagent_container/consumable/spice/diamond
	ret = 30
	grun = 80
	name = "spice diamond"
	icon_state = "spice_diamond"
/obj/item/reagent_container/consumable/spice/diamond
/obj/item/reagent_container/consumable/spice/diamond/New()
	src.add_chem("JWH-018", "JWH-018", 1.3, 0)
/obj/item/reagent_container/consumable/spice/widow
	ret = 80
	grun = 80
	name = "White Widow research chemical"
	icon_state = "widow"
/obj/item/reagent_container/consumable/spice/widow
/obj/item/reagent_container/consumable/spice/widow/New()
	src.add_chem("white widow", "white widow", 1.8, 0)
/obj/item/reagent_container/consumable/spice/fenta
	ret = 80
	grun = 80
	name = "spice silver"
/obj/item/reagent_container/consumable/spice/fenta/New()
	src.add_chem("acetylfentanyl", "acetylfentanyl", 0.015, 0)
/obj/item/reagent_container/consumable/spice/trippy
	ret = 30
	blueh = 100
	name = "fish food"
	icon_state = "fishy"
/obj/item/reagent_container/consumable/spice/trippy
/obj/item/reagent_container/consumable/spice/trippy/New()
	src.add_chem("JWH-018", "JWH-018", 0.9, 0)
	spawn(0) src.add_chem("5-MeO-DMT", "5-MeO-DMT", 0.6, 0)
/obj/item/reagent_container/consumable/spice/DMT
	blueh = 100
	icon_state = "dmt"
	name = "OBELISK(tm) premium smokeable DMT"
/obj/item/reagent_container/consumable/spice/DMT
/obj/item/reagent_container/consumable/spice/DMT/New()
	src.add_chem("DMT", "DMT", 0.27, 0)
/obj/item/reagent_container/consumable/spice/salvia
	blueh = 20
	grun = 70
	name = "2x salvia extract"
	icon_state = "salvia2"
/obj/item/reagent_container/consumable/spice/salvia
/obj/item/reagent_container/consumable/spice/salvia/New()
	src.add_chem("salvinorin A", "salvinorin A", 1.2, 0)
/obj/item/reagent_container/consumable/spice/salvia_strong
	blueh = 50
	grun = 70
	name = "10x salvia extract"
	icon_state = "salvia10"
/obj/item/reagent_container/consumable/spice/salvia_strong
/obj/item/reagent_container/consumable/spice/salvia_strong/New()
	src.add_chem("salvinorin A", "salvinorin A", 6, 0)

/obj/item/reagent_container/cig
	beltable = 1
	name = "empty cigarette"
	desc = "Yup, you can smoke it, if you fill it with something smokeable. Nope, you can't eat it."
	icon_state = "reefer_empty"
	var/stomped = 0

/obj/item/reagent_container/cig


/obj/item/reagent_container/cig/proc/smoke(mob/M)
	M << "\blue You smoke your cig."
	var/weed = 0
	for(var/datum/reagent/RE in src.reagent_list)
		if(RE.id == "hash oil")
			weed += RE.amount
			if(weed > 0)
				usr << "\green The smoke feels somewhat funny."
				usr.add_chem("THC", "THC", weed / 1.5, 0)
				usr.add_chem("CBD", "CBD", weed * 0.9, 0)
		else
			if(RE.id != "nicotine")
				usr << "\blue The smoke feels somewhat weird."
			for(var/datum/on_smoke/smk in on_smoke_avaible)
				if(RE.id == smk.rid)
					RE.on_smoke(RE.amount, usr)
					usr << "\green You breathe the vapours."
					usr.add_chem(RE.id, RE.id, RE.amount, 1.5)
	spawn(0) del(src)

/obj/item/reagent_container/cig/attack_by(obj/I)
	if(I:igniter)
		src.smoke(usr)

	if(istype(I, /obj/item/reagent_container/consumable))

		if(src.stomped)
			usr << "\red Nope, this is already a fully-packed reefer."
			return

		var/success = 0

		var/C = I

		if(!C:smokeable)
			usr << "\red This is not a suitable stuff for smoking!"
			return

		if(istype(I, /obj/item/reagent_container/consumable/hash))
			var/H = I
			if(H:piece >= 1)
				usr << "\red This piece of hash is too large for your reefer!"
				return

		for(var/datum/reagent/R in C:reagent_list)

			for(var/datum/on_smoke/O in on_smoke_avaible)
				if(R.id == O.rid)

					src.icon += rgb(I:ret, I:grun, I:blueh)
					src:ret = I:ret
					src:grun = I:grun
					src:blueh = I:blueh
					src.add_chem(R.name, R.id, R.amount, 0)
					success = 1

		if(success)
			usr << "\blue You make a reefer."
			src.icon_state = "reefer"
			src.stomped = 1
			spawn(0) del(I)

/obj/item/reagent_container/cig/attack_self()

	if(src.reagent_list:len)

		usr << "\blue You remove [src.name] contents."
		var/V = new /obj/item/reagent_container/consumable/vtoryaki(usr.loc)
		V:name = "A pile of some stuff"
		V:desc = "This stuff usually comes from some cig or reefer threshed out."
		V:icon += rgb(src.ret, src.grun, src.blueh)
		V:ret = src.ret
		V:grun = src.grun
		V:blueh = src.blueh
		for(var/datum/reagent/R in src.reagent_list)
			V:add_chem(R.name, R.id, R.amount, 0)
			sleep(0)
			src.remove_chem(R.id, R.amount)
		sleep(0)
		src.ret = 0
		src.grun = 0
		src.blueh = 0
		src.name = "empty cigarette"
		src.desc = "Yup, you can smoke it, if you fill it with something smokeable. Nope, you can't eat it."
		src.icon = 'grafon/item/liquid.dmi'
		src.icon_state = "reefer_empty"
		src.stomped = 0
	else


		usr << "\red It is empty!"
/obj/item/reagent_container/cig/tobacco
	name = "cigarette"
	desc = "Also known as cancer stick. Any nicotine addict will kill you for a pack of this shit."
	icon_state = "cig"
/obj/item/reagent_container/cig/tobacco
/obj/item/reagent_container/cig/tobacco/New()
	add_chem("nicotine", "nicotine", 0.2, 0)
/obj/item/reagent_container/cig/cigar
	name = "Cigar"
	desc = "A common cheap cigar. Contains some MDPV."
	icon_state = "cig1"
/obj/item/reagent_container/cig/cigar
/obj/item/reagent_container/cig/cigar/New()
	add_chem("nicotine", "nicotine", 0.3, 0)
	add_chem("MDPV", "MDPV", 0.25, 0)
/obj/item/reagent_container/cig/cigar/speed
	name = "Advanced Cigar"
	desc = "A somewhat expensive cigar with some speed in it."
	icon_state = "cig2"
/obj/item/reagent_container/cig/cigar/speed
/obj/item/reagent_container/cig/cigar/speed/New()
	add_chem("nicotine", "nicotine", 0.5, 0)
	add_chem("amphetamine", "amphetamine", 1.6, 0)
/obj/item/reagent_container/cig/cigar/heroin
	icon_state = "cig2"
	name = "Expensive cigar"
	desc = "An expensive cigar."
/obj/item/reagent_container/cig/cigar/heroin
/obj/item/reagent_container/cig/cigar/heroin/New()
	add_chem("nicotine", "nicotine", 0.5, 0)
	add_chem("heroin", "heroin", 0.35, 0)
