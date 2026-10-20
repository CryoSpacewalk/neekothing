/obj/proc/emp_blast(radius)
	for(var/mob/M in range(radius, loc))
		if(M.class == "robot")
			M.damaga((radius + 1) * 20)
			M.stun((radius + 1) * 5)
		for(var/obj/item/weapon/gun/B in M)
			if(B.charges)
				B.charges = 0
			if(B.btr)
				B:btr:energy = 0
			new /obj/effect/sparks(M.loc)
	for(var/mob/M in range(radius * 1.5, loc))
		if(M.class == "robot")
			M.damaga((radius + 1) * 5, loc)
	for(var/mob/M in range(radius * 2))
		if(M.class == "robot")
			M.damaga((radius + 1) * 2, loc)
			new /obj/effect/sparks(M.loc)
	for(var/obj/structure/mine/MN in range(radius))
		if(prob(20))
			MN.anchored = 0
			MN.active = 0
		else
			MN.Cross()
	for(var/obj/comp/C in range(radius, loc))
		for(var/mob/M in view(2, C))
			M << "SPARK SMASH BOOM"
		if(istype(C, /obj/comp/lights))
			for(var/obj/lamp/L in range(25, C))
				L.turnoff()
		C.fuckup()
