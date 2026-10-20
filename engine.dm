/obj/machine/turbine
	density = 1
	name = "Turbine engine"
	icon_state = "turbine"
	alticon = "gturbine"
	var/noise = 0
/obj/machine/turbine
/obj/machine/turbine/New()
	var/T = src.loc
	spawn(1)
		T:airtight = 1
	return

/obj/machine/turbine/proc/feed(amount)

	if(prob(10))
		src.playsound('sounds/engine.wav')


	for(var/obj/wire/battery/B in range(0, src))
		B.energy += amount
		src.icon_state = "turbine_on"
		spawn(30) src.icon_state = "turbine"

/obj/cloud/proc/turbo(obj/machine/turbine/T)
	if(T:x == src.x + 1 && (T:y == src.y && T:dir == 4))
		for(var/obj/cloud/C in range(1, T))
			if(C.y == T:y && C.x == T:x + 1)
				return
		src.loc = locate(src.x + 2, src.y, src.z)
		if(prob(50))
			src.amount -= 1
			T:feed(40 + amount * 10 + round(temp * 5))
	else if(T:x == src.x - 1 && (T:y == src.y && T:dir == 8))
		for(var/obj/cloud/C in range(1, T))
			if(C.y == T:y && C.x == T:x - 1)
				return
		src.loc = locate(src.x - 2, src.y, src.z)
		if(prob(50))
			src.amount -= 1
		T:feed(40 + src.amount * 10 + round(src.temp * 5))
	else if(T:x == src.x && (T:y == src.y + 1 && T:dir == 1))
		for(var/obj/cloud/C in range(1, T))
			if(C.y == T:y + 1 && C.x == T:x)
				return
		src.loc = locate(src.x, src.y + 2, src.z)
		if(prob(50))
			src.amount -= 1
			T:feed(40 + amount * 10 + round(temp * 5))
	else if(T:x == src.x && (T:y == src.y - 1 && T:dir == 2))
		for(var/obj/cloud/C in range(1, T))
			if(C.y == T:y - 1 && C.x == T:x)
				return
		src.loc = locate(src.x, src.y - 2, src.z)
		if(prob(50))
			src.amount -= 1
			T:feed(40 + amount * 10 + round(temp * 5))

/obj/machine/solar
	density = 1
	name = "Photo-elemental pannel"
	icon_state = "solar"

/obj/machine/solar
/obj/machine/solar/attack_by(obj/I)
	if(istype(I, /obj/item/tool/screwdriver) || (istype(I, /obj/item/tool/axe) || istype(I, /obj/item/weapon/battleaxe)))
		usr << "\blue Now removing silicon plating..."
		spawn(70)
			if(usr.item == I && usr in range(1, src))
				var/MF = new /obj/machframe(src.loc)
				MF:icon_state = "machine_wired"
				MF:stage = 1
				new /obj/item/material/silicon(src.loc)
				spawn(0) del(src)

/obj/machine/solar/proc/feed(amount)
	for(var/obj/wire/battery/B in range(0, src))
		B.energy += amount
		src.dir = 1
		spawn(30) src.dir = 2
