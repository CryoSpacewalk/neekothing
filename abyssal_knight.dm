// Recovered from compiled neek.dmb (11 procs)

/mob/var/abyss = -1
/mob/var/mob/abyss_target = null

/mob/proc/turn_abyssal()
	src << "\red You hear slurred voices in your head."
	spawn(100)
		src << "\red \bold You're an Abyssal knight now."
		src << "\red \bold You're linked to the Powers of Abyss and can try to use them at your will."
		src << "\red \bold However, you'll have to sacrifice dead human bodies (by praying at them) and killing specific persons for restoring your power."
		for(var/V in abyss_powers)
			src.verbs += V
		src.abyss = 1

/client/proc/abyssalise(mob/M in world)
	set name = "Make Abyssal knight"
	set category = "Pedal"
	M:turn_abyssal()

/client/proc/abpoints(mob/M in world)
	set name = "Give an Abyssal Point"
	set category = "Pedal"
	if(M:abyss >= 0)
		M:abyss++

/client/proc/deabyss(mob/M in world)
	set name = "De-abyssalise"
	set category = "Pedal"
	M << "\red You've lost your linkage with Abyss!"
	for(var/V in abyss_powers)
		src.verbs -= V
	if(M:abyss >= 0)
		M:abyss = -1


















var/list/abyss_powers = list(/mob/proc/abyssal_pray, /mob/proc/brain_eating, /mob/proc/warp, /mob/proc/depart, /mob/proc/corrupt, /mob/proc/banish_escape, /mob/proc/abyss_arms)
/mob/proc/abyssal_pray()










	set name = "Pray to the Powers of Abyss"
	set category = "Abyss"
	for(var/mob/M in src.loc)
		if(M.class == "man" && (M.mat == "flesh" && M.dead))
			src << "\blue You sacrifice the dead body to the Powers of Abyss."
			src.abyss += 2
			heal(20, "burn")
			heal(20, "brute")
			heal(20, "organ")
			M.gib()

/mob/proc/brain_eating()
	set name = "Destroy the dreaming consciousness (by consuming the brain)"
	set category = "Abyss"
	for(var/obj/item/brain/B in src.loc)
		src << "\blue You consume the brain of some intelligent creature."
		src.abyss += 2
		heal(10, "burn")
		heal(10, "brute")
		heal(30, "organ")
		del(B)

/mob/proc/warp()
	set name = "Warp (1 AP)"
	set category = "Abyss"
	if(src.abyss >= 1)
		src.abyss--
		src.lesser_switch()
		src.blink(4, loc)

/mob/proc/depart()
	set name = "Depart from The Abyss (1 AP)"
	set category = "Abyss"
	if(src.z != 7)
		usr << "\red You're not even in The Abyss!"
		return
	else if(src.abyss >= 1)
		src.abyss--
		for(var/turf/floor/start/T in world)
			src.loc = T
			new /obj/effect/warp_splash(src.loc)
			break

/mob/proc/corrupt()
	set name = "Bring The Abyss into the Mid World (2 AP)"
	set category = "Abyss"
	if(src.z == 7)
		usr << "\red This place is corrupted enough!"
	else if(src.abyss >= 2)
		src.abyss -= 2
		for(var/mob/M in view(src))
			if(M != src)
				M.bashroulette()
			spawn(0)
				src.abyss_corrupt(5)
				spawn(0)
					for(var/turf/T in range(8, src))
						if(!istype(T, /turf/space) && !T.density)
							src.loc = T
							new /obj/effect/warp_splash(src)
					src << "\blue \bold Say thank you for getting you outtta there."

/mob/proc/banish_escape()
	set name = "Banish self (3 AP)"
	set category = "Abyss"
	if(src.z != 7 && src.abyss >= 3)
		src.abyss -= 3
		new /obj/effect/warp_splash(loc)
		src.banish()

/mob/proc/abyss_arms()
	set name = "Abyssal arms (5 AP)"
	set category = "Abyss"
	if(src.abyss >= 5)
		src.abyss -= 5
		new /obj/effect/warp_splash(loc)
		new /obj/item/clothes/abyss(loc)
