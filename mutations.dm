// Recovered from compiled neek.dmb (5 procs)

/mob
/mob/proc/mutating(mutid)




	if(src.mat != "flesh" && src.type != "man")
		show_message("\blue [src.name] warps for a second, then returns to normal.", "\blue Your body is not suitable for mutations!")
		return
	else


		for(var/datum/mutation/M in mutations_all)
			if(M.mid == mutid)
				if(!(M.mid in mutations))
					switch(mutid)
						if("hui")
							src << "\red \bold Your genitals are bloating!"
						if("eyes0")
							src << "\red \bold Tiny eyes grow on your body!"
						if("eyes1")
							src << "\red \bold The eyes on your body is now larger."
							mutations -= "eyes0"
						if("tumor")
							src << "\red \bold Huge tumor grows on your head!"
						if("tumor_eye")
							src << "\red \bold A pack of eyes grows on your tumor!"
							mutations -= "tumor"
						if("horns")
							src << "\red \bold A pair of eerie horns grows on your head!"
						if("chromosome")
							if(!("[src.realname] was degenerating into something disgusting this round" in funfacts))
								funfacts += "[src.realname] was degenerating into something disgusting this round"
							src << "\red \bold You're turning into a freak!"
					sleep(0)
					mutations += mutid
					sleep(0)
					update_sprite()
					sleep(0)
					stun(3)

/mob/proc/randommut()
	var/L = list()
	for(var/datum/mutation/MT in mutations_all)
		L += MT.mid
	sleep(0)
	for(var/midz in L)
		if(midz == "tumor_eye" && !("tumor" in src.mutations) || midz == "eyes1" && !("eyes0" in src.mutations))
			L -= midz
		if(midz == "tumor" && ("tumor_eye" in src.mutations) || midz == "eyes0" && ("eyes1" in src.mutations))
			L -= midz
		if(midz in src.mutations)
			L -= midz

		var/beheadz = 1
		for(var/obj/limb/l in src.limbs)
			if(l.name == "head")
				beheadz = 0

		if(beheadz && (midz == "tumor" || (midz == "chromosome" || midz == "horns")))
			L -= midz
	sleep(0)
	if(L:len)
		var/newmut = pick(L)

		src.mutating(newmut)

/mob/proc/curemut()
	var/L = list()
	for(var/midz in mutations)
		L += midz
	if(L:len)
		var/mutcure = pick(L)
		sleep(0)
		for(var/datum/mutation/M in mutations_all)
			if(mutcure == M.mid)
				show_message("\blue [src.name] is cured of some mutations!", "\blue You're cured of some mutations!")
				sleep(0)
				mutations -= mutcure
			sleep(0)
			src.update_sprite()
			sleep(0)
			src.stun(3)

/mob/proc/mutcure_target(mutcure)
	for(var/M in mutations)
		if(mutcure == M)
			show_message("\blue [src.name] is cured of some mutations!", "\blue You're cured of some mutations!")
			sleep(0)
			mutations -= mutcure
			sleep(0)
			update_sprite()

/mob/proc/mutation_translation(mut_name)

	switch(mut_name)
		if("hui")

			return "hui"
		if("body eyes")

			return "eyes0"
		if("brain tumor")

			return "tumor"
		if("horns")

			return "horns"
		if("chromosome")

			return "chromosome"
		else

			return 0
/datum/mutation/hui
	mid = "hui"























	olay = new /obj/overlay/mutation/hui
/datum/mutation/eye
	mid = "eyes0"

	olay = new /obj/overlay/mutation/eye
/datum/mutation/eye_big
	mid = "eyes1"

	olay = new /obj/overlay/mutation/eye_big
/datum/mutation/tumor
	mid = "tumor"

	olay = new /obj/overlay/mutation/tumor
/datum/mutation/tumor_eye
	mid = "tumor_eye"

	olay = new /obj/overlay/mutation/tumor_eye
/datum/mutation/horns
	mid = "horns"

	olay = new /obj/overlay/mutation/horns
/datum/mutation/chromosome
	mid = "chromosome"

	olay = new /obj/overlay/mutation/chromosome
