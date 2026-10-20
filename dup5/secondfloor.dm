/obj/structure/teleexp/Cross(atom/movable/A)














































































































































































































	..()
	for(var/obj/wire/battery/BT in src.loc)
		if(BT && BT.energy > 0)
			for(var/mob/M in view(src))
				M << "\blue [A:name] passes through the teleporter."
			var/BC = null

			var/blist = list()
			for(var/obj/structure/beacon/B in world)
				blist += B

			if(blist:len)
				BC = pick(blist)

				if(BC)
					A:loc = locate(BC:x, BC:y, BC:z)
					new /obj/effect/sparks(A:loc)
					if(istype(A, /mob))
						var/M = A
						if(M:epilepsy && prob(50))
							M << "\red Non-bluespace teleportation is a harsh thing for epileptics."
							M:seizure(5)
		else
			for(var/mob/M in view(src))
				M << "\red [src.name] beeps."