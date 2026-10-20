/obj/structure/teleexp
	icon = 'door.dmi'
	name = "expedition teleporter"
	icon_state = "teleexp"
	desc = "A one-way non-bluespace teleportation device which uses abandoned spacecraft navigation beacons as a droppoints. Use at your VERY risk."
	var/on = 0
	var/id = 666
/obj/teleporter{icon = 'grafon/door.dmi'; var/on = 0; var/id = 666; alticon = "gtele_off"; icon_state = "tele_off"}
/obj/teleporter/Cross(atom/movable/A)
	..()
	if(src.on == 1)
		for(var/obj/teleporter/T in world)
			if(T.id == src.id && T != src)
				A:loc = locate(T.x, T.y, T.z)
				new /obj/effect/sparks(A:loc)
				if(istype(A, /mob))
					var/M = A
					if(M:epilepsy && prob(50))
						M << "\red Non-bluespace teleportation is a harsh thing for epileptics."
						M:seizure(5)
				break

/obj/teleporter/attack_hand()
	if(on == 0)
		on = 1
		if(alted)
			icon_state = "gtele_on"
		else
			icon_state = "tele_on"
		alticon = "gtele_on"
		fsticon = "tele_on"
	else
		on = 0
		if(alted)
			icon_state = "gtele_off"
		else
			icon_state = "tele_off"
		alticon = "gtele_off"
		fsticon = "tele_off"

/turf/staircase
	icon = 'structure.dmi'
	var/direction = 1
	var/id = 0
	name = "stair"
	icon_state = "staircase"

/turf/staircase
/turf/staircase/Entered(atom/movable/A, atom/prevloc)
	..()
	if(src.direction)
		A:loc = locate(src.x, src.y, src.z + src.direction)
	else if(src.id)
		for(var/turf/staircase/S in world)
			if(S.id == src.id && S != src)
				A:loc = locate(S.x, S.y, S.z)

/turf/air
	icon = 'floor.dmi'
	icon_state = "wormhole"
	name = "wormhole"
/turf/air
/turf/air/Entered(atom/movable/A, atom/prevloc)
	..()
	var/zed = 1
	var/turf/ground = locate(A:x, A:y, A:z + zed)
	if(A:z + zed > 8)
		if(ismob(A) && A:client)
			A << "\red <b>You fall into the chasm!"
		A:loc = locate(4, 5, 2)
		return
	while(istype(ground, /turf/air))
		zed++
		ground = locate(A:x, A:y, A:z + zed)
		if(A:z + zed > 8)
			if(ismob(A) && A:client)
				A << "\red <b>Space and time warps in a weird ways..."
			A:loc = locate(4, 5, 2)
			return
	A:loc = ground
	if(ismob(A))
		A:damaga(zed * 10, "brute")
		A:stun(1)
		A << "\red Ouch! You fall."



/obj/onewaytele/Cross(atom/movable/A)



	..()
	for(var/turf/floor/start/T in world)
		A:loc = T
		new /obj/effect/sparks(A:loc)
		if(istype(A, /mob))
			var/M = A
			if(M:epilepsy && prob(50))
				M << "\red Non-bluespace teleportation is a harsh thing for epileptics."
				M:seizure(5)
		break


/obj/item/device/tele/attack_self()





	if(prob(40))
		usr.blink(6)
	else
		usr << "\red Your [src.name] beeps."

/obj/item/device/tele/after_attack(turf/T, mob/user)
	if(prob(35))
		user:blink(4, T)
	else
		user << "\red Your [src.name] beeps."

/atom/movable/proc/blink(radius, turf/centur)
	if(src.z == 7)
		radius = radius * 2
	var/list/blinklist = list()
	for(var/turf/T in range(radius, centur))
		if(!istype(T, /turf/rock))
			blinklist += T
	if(blinklist.len)
		var/turf/S = blinklist[rand(1, blinklist.len)]
		src.loc = S
		spawn(0) new /obj/effect/sparks(loc)

/atom/movable/proc/smartblink(radius, nono, turf/centur)

	if(src.z == 7)
		radius = radius * 2
	var/list/blinklist = list()
	for(var/turf/T in range(radius, centur))
		if(!istype(T, /turf/rock) && !(T in range(nono)))
			blinklist += T
	if(blinklist.len)
		var/turf/S = blinklist[rand(1, blinklist.len)]
		src.loc = S

		spawn(0) new /obj/effect/sparks(loc)


/obj/item/device/abyss_tele/attack_self()






	if(usr.z == 7)
		var/blinklist = list()
		for(var/turf/T in range(8, usr.loc))
			if(!istype(T, /turf/rock))
				blinklist += T
		if(blinklist:len)
			var/S = blinklist[rand(1, blinklist:len)]
			usr.loc = S
	else
		usr << "\red Nothing happens."

/obj/item/device/abyss_tele/after_attack(turf/T, mob/user)
	if(prob(66))
		user:abyssblink(T)
	else
		user << "\red Your [src.name] beeps."

/atom/movable/proc/abyssblink(turf/centur)

	if(src.z == 7)
		var/list/blinklist = list()
		for(var/turf/T in range(8, centur))
			if(!istype(T, /turf/rock))
				blinklist += T
		if(blinklist.len)
			var/turf/S = blinklist[rand(1, blinklist.len)]
			src.loc = S
	else
		src.banish()
		spawn(0)
			usr.abyss_switch()
			spawn(100)
				src.loc = centur
				spawn(0)
					new /obj/effect/warp_splash(src.loc)



