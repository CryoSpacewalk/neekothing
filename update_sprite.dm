// Recovered from compiled neek.dmb (2 procs)

/mob/proc/update_sprite(angle)
	var/gross = 0
	var/noosed = 0

	for(var/obj/overlay/baryga/B in src.contents)
		if(B)
			src.overlays -= B

	for(var/obj/overlay/body/B in src.contents)
		if(B)
			src.overlays -= B

	if(src:limbs:len && src.mat == "flesh")
		for(var/obj/limb/L in src.limbs)
			if(L)
				var/B = new L.ovly(src.loc)
				B:layer = -3.1
				if(angle)
					var/I = new /icon(B:icon)
					I:Turn(angle)
					B:icon = I
				spawn(0)
					B:loc = src
					src.overlays += B

	for(var/obj/overlay/clothes/K in src.contents)
		src.overlays -= K

	for(var/obj/overlay/afterhang/AH in src.contents)
		gross = 1
		src.overlays -= AH

	for(var/obj/overlay/tied/N in src.contents)
		src.overlays -= N

	for(var/obj/overlay/mutation/M in src.contents)
		src.overlays -= M

	for(var/obj/overlay/collar/C in src.contents)
		gross = 1
		if(C)
			src.overlays -= C

	if(src:mutations:len)
		for(var/MT in src.mutations)
			var/M = new /obj/overlay/mutation(src.loc)
			M:icon = 'grafon/mutations.dmi'
			for(var/datum/mutation/MTS in mutations_all)
				if(MT == MTS.mid)
					M:icon_state = MTS:olay:icon_state
			M:layer = -3
			if(angle)
				var/I = new /icon(M:icon)
				I:Turn(angle)
				M:icon = I
			spawn(0)
				M:loc = src
				src.overlays += M

	if(gross)
		var/C = new /obj/overlay/afterhang(src.loc)
		C:layer = -2
		if(angle)
			var/I = new /icon(C:icon)
			I:Turn(angle)
			C:icon = I
		spawn(0)
			C:loc = src
			src.overlays += C

	if(noosed)
		var/C = new /obj/overlay/noose(src.loc)
		C:layer = -2
		if(angle)
			var/I = new /icon(C:icon)
			I:Turn(angle)
			C:icon = I
		spawn(0)
			C:loc = src
			src.overlays += C

	if(src.collar)
		var/C = new /obj/overlay/collar(loc)
		C:layer = -2
		if(angle)
			var/I = new /icon(C:icon)
			I:Turn(angle)
			C:icon = I
		spawn(0)
			C:loc = src
			src.overlays += C

	if(src.wired)
		var/C = new /obj/overlay/tied(loc)
		C:layer = -2
		if(angle)
			var/I = new /icon(C:icon)
			I:Turn(angle)
			C:icon = I
		spawn(0)
			C:loc = src
			src.overlays += C

	if(src.baryga)
		if(src:brainport)
			if(istype(src:brainport, /obj/item/device/brainport/hachmask))
				goto LAB_04D6
		var/C = new /obj/overlay/baryga(src.loc)
		C:layer = -2
		if(angle)
			var/I = new /icon(C:icon)
			I:Turn(angle)
			C:icon = I
		spawn(0)
			C:loc = src
			src.overlays += C

	LAB_04D6:

	src.overlays -= /obj/overlay/baryga
	if(src.clothes)
		var/C = new /obj/overlay/clothes(loc)
		C:icon = 'grafon/clothing_overlays.dmi'
		C:icon_state = src:clothes:playericon
		C:layer = -3
		if(angle)
			var/I = new /icon(C:icon)
			I:Turn(angle)
			C:icon = I
		spawn(0)
			C:loc = src
			src.overlays += C
	else
		spawn(0)
			for(var/obj/overlay/clothes/C in src.contents)
				src.overlays -= C

/mob/proc/check_limb(limbname)
	for(var/obj/limb/l in src.limbs)
		if(l.name == limbname)
			return l.health

	return 0
