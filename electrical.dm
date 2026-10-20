// Recovered from compiled neek.dmb (4 procs)

/obj/effect/sparks/New()




	..()
	for(var/obj/cloud/C in range(1, src.loc))
		if(C.fuel > 0)
			C.burning = 1
	for(var/mob/M in viewers(src))
		if(M.epilepsy && prob(20))
			M.seizure(5)
	spawn(6) del(src)


/obj/effect/lightning/New()






	src.l_walk()

/obj/effect/lightning/proc/l_walk()
	step(src, pick(1, 2, 8, 4))
	if(prob(2))
		del(src)
	spawn(1) src.l_walk()

/obj/effect/lightning/Bump(atom/A)
	if(ismob(A))
		var/M = A
		new /obj/effect/sparks(M:loc)
		if(M:client)
			M << "\red \bold Ouch!"
		M:stun(pick(1, 2))
		if(!M:dead)
			M:damaga(30 - M:energyprotect, "burn")
		spawn(0) del(src)
	else if(istype(A, /obj/bio/amoeba))
		var/obj/bio/amoeba/M = A
		M:biodmg(pick(30, 40, 50))
		del(src)
