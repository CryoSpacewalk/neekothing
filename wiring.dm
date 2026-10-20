// Recovered from compiled neek.dmb (20 procs)
/obj/wire
	layer = 2.4
	icon = 'grafon/wire.dmi'
	icon_state = "cable"
	name = "Cable"
	alticon = "gcable"
	var/SG = null
	var/energy = 0
	var/alpha_c = 0
/obj/wire/prespawned
	energy = 5
/obj/wire/New()
	src.powernet()

/obj/wire/attack_hand()
	if(src.SG)
		usr << "You disconnect the signaler."
		src:SG:loc = usr.loc
		spawn(0) src.SG = null

/obj/wire/attack_by(obj/item/I)
	if(src in view(1, usr))

		if(istype(I, /obj/item/device/signaler) && !src.SG)
			src.SG = I
			I:loc = src
			spawn(0)
				usr.delitem()
				return

		if(istype(I, /obj/item/reagent_container/cig) && istype(src, /obj/wire/battery))
			if(energy <= 0)
				usr << "\red It is outta power so you can't use it for smoking!"
			else
				var/C = I
				C:smoke(usr)

		if(istype(I, /obj/item/tool/meter))
			usr << "\blue Wire energy: [energy]"
		else if(istype(I, /obj/item/weapon/gun/blaster/blindster))
			if(I:charges == 0)
				if(energy > 0)
					energy -= 1
					I:charges = I:maxcharges
					usr << "\blue You charge your [usr.item]'s battery."
				else
					usr << "\red The outlet is power-dry!"
			else
				usr << "\red Your [usr.item]'s battery isn't empty!"
		else if(istype(I, /obj/item/battery))
			var/B = new /obj/item/battery()
			B = I
			if(B:energy < B:maxenergy)
				if(energy >= B:maxenergy - B:energy)
					energy -= B:maxenergy - B:energy
					B:energy = B:maxenergy
					usr << "\blue You charge your [usr.item]."
				else
					usr << "\red The outlet is power-dry!"
			else
				usr << "\red Your [usr.item]'s battery isn't empty!"
		else if(istype(usr.item, /obj/item/weapon/gun/blaster) && istype(src, /obj/wire/battery))
			if(I:charges < I:maxcharges)
				if(energy > I:maxcharges - I:charges)
					energy -= I:maxcharges - I:charges
					I:charges = I:maxcharges
					usr << "\blue You charge your [usr.item]'s battery."
				else if(energy > 0)
					I:charges += energy
					energy = 0
					usr << "\blue You charge your [usr.item]'s battery ([I:charges] out of [I:maxcharges] shots)."
				else
					usr << "\red The outlet is power-dry!"
			else
				usr << "\red Your [usr.item]'s battery already full!"
		else if(istype(I, /obj/item/tool/pulse))
			if(istype(src, /obj/wire/battery))
				if(I:charges < 10 && energy > 0)
					usr << "\blue You recharge your [usr.item]."
					if(energy < 10 - I:charges)
						I:charges += energy
						spawn(0) energy = 0
					else
						I:charges = 10
						energy -= 10 - I:charges
				else if(I:charges == 10)
					usr << "\red [usr.item] battery already fully charged!"
				else
					usr << "\red The outlet is power-dry!"
			else if(I:charges > 0)
				var/P = I
				usr << "\blue You pulse [src] with your [I]."
				if(I:charges < P:pulsemode)
					energy += I:charges
					spawn(0) I:charges = 0
				else
					energy += P:pulsemode
					spawn(0) I:charges -= P:pulsemode
			spawn(0) I:desc = "A rechargable tool for pulsing wires. [I:charges]/10 charge left."
		else if((istype(I, /obj/item/tool/wirecutters) || istype(I, /obj/item/tool/hydraulic_cutters)) && !istype(src, /obj/wire/battery) || (istype(I, /obj/item/tool/axe) || istype(usr.item, /obj/item/weapon/battleaxe)) && istype(src, /obj/wire/battery))
			usr << "\blue You cut down local wires."
			var/CB = new /obj/item/cable(src.loc)
			CB:cminus(9)
			if(istype(src, /obj/wire/battery))
				if(prob(20 + I:accu))
					new /obj/item/outlet(src.loc)
				else
					usr << "\red You cut the power outlet apart!"
				for(var/obj/comp/lights/C in src.loc)
					for(var/obj/lamp/L in range(25, C))
						L.turnoff()
					C.dir = 1
					C.on = 0
					C.powered = 0

					C.sd_SetLuminosity(0)
			if(energy > 0 && usr.energyprotect < energy * 2)
				usr << "\red \bold SPARK!"
				usr.damaga(energy * 2 - usr.energyprotect, "burn")
				usr.stun(round(energy / 2) - usr.painless)
				new /obj/effect/sparks(src.loc)
				spawn(0) del(src)
			else
				del(src)
				return

/obj/triwire/New()

























	src.trinet()

/obj/triwire/attack_by(obj/I)

	if(istype(I, /obj/item/tool/meter))
		usr << "\blue T-Wire energy: [energy]"
	else if(istype(I, /obj/item/tool/screwdriver))
		usr << "\blue You remove t-branch from the cables"
		new /obj/item/tbranch(src.loc)
		var/wier = new /obj/wire(src.loc)
		wier:energy = src.energy
		switch(src.dir)
			if(1)
				wier:dir = 8
			if(8)
				wier:dir = 1
		del(src)
		return
	else if(istype(I, /obj/item/tool/axe) || istype(I, /obj/item/weapon/battleaxe))
		usr << "\blue You chop down local T-wires."
		new /obj/item/cable(src.loc)
		new /obj/item/tbranch(src.loc)
		if(src.energy > 0)
			usr << "\red \bold SPARK!"
			usr.damaga(src.energy - usr.energyprotect, "burn")
			usr.torment(3)
			if(round(energy / 2) - usr.painless > 0)
				usr.stun(round(energy / 2) - usr.painless)
			new /obj/effect/sparks(src.loc)
		spawn(0) del(src)
/obj/wireleech
	layer = 2.5
	icon = 'grafon/wire.dmi'
	var/SG
	var/id = 1
	var/energy = 0
	name = "electron leech"
	icon_state = "wire_evil"
/obj/wireleech
/obj/wireleech/New()
	src.bluenet()
/obj/wireleech/examine()
	usr << "A maaaaagical device for distant power translation. Sucks energy harder than a libertarian whore on GHB."
	usr << "\bold Its ID is [id]"

/obj/wireleech/proc/bluenet()

	if(src.id != "alpha")

		for(var/obj/wire/W in orange(1, src))
			if(W.energy > 0)
				if((src.dir == 2 || src.dir == 1) && ((W.dir == 1 || (W.dir == 2 || (W.dir == 9 || W.dir == 5))) && (src.x == W.x && src.y == W.y + 1) || (W.dir == 1 || (W.dir == 2 || (W.dir == 10 || W.dir == 6))) && (src.x == W.x && src.y == W.y - 1)) || ((src.dir == 8 || src.dir == 4) && ((W.dir == 8 || (W.dir == 4 || (W.dir == 9 || W.dir == 10))) && (src.y == W.y && src.x == W.x - 1) || (W.dir == 8 || (W.dir == 4 || (W.dir == 5 || W.dir == 6))) && (src.y == W.y && src.x == W.x + 1)) || (src.dir == 6 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 9 || W.dir == 5))) && (src.y == W.y + 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 9 || W.dir == 10))) && (src.y == W.y && src.x == W.x - 1)) || (src.dir == 5 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 10 || W.dir == 6))) && (src.y == W.y - 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 9 || W.dir == 10))) && (src.y == W.y && src.x == W.x - 1)) || (src.dir == 10 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 5 || W.dir == 9))) && (src.y == W.y + 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 5 || W.dir == 6))) && (src.y == W.y && src.x == W.x + 1)) || src.dir == 9 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 6 || W.dir == 10))) && (src.y == W.y - 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 6 || W.dir == 5))) && (src.y == W.y && src.x == W.x + 1)))))))
					if(W.energy > 500)
						W.melt()
					else
						if(W.energy >= 10)
							W.energy -= 10
							src.energy += 10
						else if(W.energy >= 5)
							W.energy -= 5
							src.energy += 5
						else if(W.energy >= 3)
							W.energy -= 3
							src.energy += 3
						else if(W.energy)
							W.energy--
							src.energy++

		if(src.energy > 50)
			for(var/obj/wireout/W in orange(100, src))
				if(W.id == src.id)
					if(prob(5))
						show_message("\blue [src.name] glows!")
						for(var/mob/M in viewers(src))
							if(M.epilepsy && prob(33))
								M.seizure(5)
					if(W.energy < 10 && src.energy >= 10)
						W.energy += 10
						src.energy -= 10
					if(W.energy < 5 && src.energy >= 5)
						W.energy += 5
						src.energy -= 5
					else if(W.energy < 3 && src.energy >= 3)
						W.energy += 3
						src.energy -= 3
					else if(src.energy)
						W.energy = W.energy + 1
						src.energy = src.energy - 1

	spawn(20) src.bluenet()

/obj/wireleech/attack_by(obj/I)

	if(istype(I, /obj/item/device/signaler) && !SG)
		SG = I
		I:loc = src
		spawn(0)
			usr.delitem()
			return

	if(istype(I, /obj/item/tool/meter))
		usr << "\blue Translator energy: [energy]"
	else
		if(istype(I, /obj/item/tool/pulse))

			var/P = I
			if(P:charges)
				var/msg
				if(id == "alpha")
					msg = "Translator is locked. Input new ID for unlock"
				else
					msg = "Current translator ID is [id]. Input new ID, please"
				var/newid = input(msg, "New ID", id)
				spawn(0)
					if(P:charges && usr in range(1, src))
						P:charges--
						id = newid
		else
			if(istype(I, /obj/item/tool/screwdriver))
				usr << "\blue You remove translator from the cables"
				new /obj/item/warpwire(src.loc)
				var/wier = new /obj/wire(src.loc)
				wier:energy = src.energy
				switch(dir)
					if(1)
						wier:dir = 8
					if(8)
						wier:dir = 1
				del(src)
				return
			else if(istype(I, /obj/item/tool/axe) || (istype(I, /obj/item/weapon/battleaxe) || (istype(I, /obj/item/tool/saw) || istype(I, /obj/item/tool/hydraulic_cutters))))
				usr << "\blue You chop down the translator."
				new /obj/item/cable(loc)
				new /obj/item/warpwire(loc)
				if(energy > 0)
					usr << "\red \bold SPARK!"
					usr.damaga(energy - usr.energyprotect, "burn")
					usr.torment(3)
					if(round(energy / 2) - usr.painless > 0)
						usr.stun(round(energy / 2) - usr.painless)
					new /obj/effect/sparks(loc)
				spawn(0) del(src)
/obj/wireout
	layer = 2.5
	icon = 'grafon/wire.dmi'
	var/id = 1
	var/energy = 0
	var/SG
	name = "Power sharer"
	icon_state = "wire_blue"
/obj/wireout
/obj/wireout/New()
	src.bluenet()
/obj/wireout/examine()
	usr << "A maaaaagical device for distant power translation. Shares energy taken from charged electron leech."
	usr << "\bold Its ID is [src.id]"

/obj/wireout/proc/bluenet()

	if(src.id != "alpha")

		for(var/obj/wire/W in orange(1, src))
			if(W.energy < src.energy && src.energy > 0)
				if((src.dir == 2 || src.dir == 1) && ((W.dir == 1 || (W.dir == 2 || (W.dir == 9 || W.dir == 5))) && (src.x == W.x && src.y == W.y + 1) || (W.dir == 1 || (W.dir == 2 || (W.dir == 10 || W.dir == 6))) && (src.x == W.x && src.y == W.y - 1)) || ((src.dir == 8 || src.dir == 4) && ((W.dir == 8 || (W.dir == 4 || (W.dir == 9 || W.dir == 10))) && (src.y == W.y && src.x == W.x - 1) || (W.dir == 8 || (W.dir == 4 || (W.dir == 5 || W.dir == 6))) && (src.y == W.y && src.x == W.x + 1)) || (src.dir == 6 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 9 || W.dir == 5))) && (src.y == W.y + 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 9 || W.dir == 10))) && (src.y == W.y && src.x == W.x - 1)) || (src.dir == 5 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 10 || W.dir == 6))) && (src.y == W.y - 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 9 || W.dir == 10))) && (src.y == W.y && src.x == W.x - 1)) || (src.dir == 10 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 5 || W.dir == 9))) && (src.y == W.y + 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 5 || W.dir == 6))) && (src.y == W.y && src.x == W.x + 1)) || src.dir == 9 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 6 || W.dir == 10))) && (src.y == W.y - 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 6 || W.dir == 5))) && (src.y == W.y && src.x == W.x + 1)))))))
					if(W.energy > 500)
						W.melt()
					else
						if(src.energy >= 10)
							W.energy += 10
							src.energy -= 10
						if(src.energy >= 5)
							W.energy += 5
							src.energy -= 5
						else if(src.energy >= 3)
							W.energy += 3
							src.energy -= 3
						else
							W.energy = W.energy + 1
							src.energy = src.energy - 1

	spawn(6) src.bluenet()

/obj/wireout/attack_by(obj/I)
	if(istype(I, /obj/item/tool/meter))
		usr << "\blue Translator energy: [energy]"
	else
		if(istype(I, /obj/item/tool/pulse))

			var/P = I
			if(P:charges)
				var/msg
				if(id == "alpha")
					msg = "Translator is locked. Input new ID for unlock"
				else
					msg = "Current translator ID is [id]. Input new ID, please"
				var/newid = input(msg, "New ID", id)
				spawn(0)
					if(P:charges && usr in range(1, src))
						P:charges--
						id = newid
		else
			if(I:sharp)
				usr << "\blue You chop down the translator."
				new /obj/item/cable(loc)
				new /obj/item/warpwire(loc)
				if(energy > 0)
					usr << "\red \bold SPARK!"
					usr.damaga(energy - usr.energyprotect, "burn")
					usr.torment(3)
					if(round(energy / 2) - usr.painless > 0)
						usr.stun(round(energy / 2) - usr.painless)
					new /obj/effect/sparks(loc)
				spawn(0) del(src)

/obj/wire/battery
	icon_state = "battery"
	name = "Power outlet"

/obj/wire/battery

/obj/wire/battery/attack_hand()
	usr << "\red You stick two fingers right into power outlet."
	if(!src.energy)
		usr << "\red Nothing happens."
	else
		usr << "\red \bold SPARK!"
		usr.damaga(energy - usr.energyprotect, "burn")
		usr.torment(3)
/obj/wire/battery/prespawned
	energy = 5
/obj/wire/battery/emergency
	energy = 500
	name = "Emergenecy power storage cable"
	icon_state = "e-battery"
/obj/wire/battery/emergency/New()
	src.powernet()


/obj/wire/proc/powernet()
	if(!src.alpha_c)

		for(var/obj/wire/W in orange(1, src))
			if(W.energy < src.energy && src.energy > 0)
				if((src.dir == 2 || src.dir == 1) && ((W.dir == 1 || (W.dir == 2 || (W.dir == 9 || W.dir == 5))) && (src.x == W.x && src.y == W.y + 1) || (W.dir == 1 || (W.dir == 2 || (W.dir == 10 || W.dir == 6))) && (src.x == W.x && src.y == W.y - 1)) || ((src.dir == 8 || src.dir == 4) && ((W.dir == 8 || (W.dir == 4 || (W.dir == 9 || W.dir == 10))) && (src.y == W.y && src.x == W.x - 1) || (W.dir == 8 || (W.dir == 4 || (W.dir == 5 || W.dir == 6))) && (src.y == W.y && src.x == W.x + 1)) || (src.dir == 6 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 9 || W.dir == 5))) && (src.y == W.y + 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 9 || W.dir == 10))) && (src.y == W.y && src.x == W.x - 1)) || (src.dir == 5 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 10 || W.dir == 6))) && (src.y == W.y - 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 9 || W.dir == 10))) && (src.y == W.y && src.x == W.x - 1)) || (src.dir == 10 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 5 || W.dir == 9))) && (src.y == W.y + 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 5 || W.dir == 6))) && (src.y == W.y && src.x == W.x + 1)) || src.dir == 9 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 6 || W.dir == 10))) && (src.y == W.y - 1 && src.x == W.x) || (W.dir == 8 || (W.dir == 4 || (W.dir == 6 || W.dir == 5))) && (src.y == W.y && src.x == W.x + 1)))))))
					if(W.energy > 500)
						W.melt()
					else
						if(src.energy >= 5)
							W.energy += 5
							src.energy -= 5
						if(src.energy >= 3)
							W.energy += 3
							src.energy -= 3
						else
							W.energy = W.energy + 1
							src.energy = src.energy - 1

	spawn(2) src.powernet()

/obj/wire/proc/melt()














	if(istype(src, /obj/wire/battery))
		if(src.energy > 900)
			for(var/mob/M in view(src))
				M << "\red [src] melts!"
			new /obj/melt(src.loc)
			new /obj/item/outlet(src.loc)
			for(var/obj/cloud/C in loc)
				C.temp += 5
			spawn(0)
				del(src)
				return
		else
			return
	else if(src.energy > 666)
		for(var/mob/M in view(src))
			M << "\red [src] melts!"
		new /obj/melt(src.loc)
		for(var/obj/cloud/C in loc)
			C.temp += 5
		spawn(0)
			del(src)
			return

/obj/triwire/proc/trinet()
	var/obj/hueviy = null
	for(var/obj/wire/W in orange(1, src))
		hueviy = W
		if(src.dir == 2 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 10 || W.dir == 6))) && (W.y == src.y - 1 && W.x == src.x) || ((W.dir == 8 || (W.dir == 4 || (W.dir == 10 || W.dir == 9))) && (W.x == src.x + 1 && W.y == src.y) || (W.dir == 8 || (W.dir == 4 || (W.dir == 6 || W.dir == 5))) && (W.x == src.x - 1 && W.y == src.y))))
			src.quantum(W)
		else if(src.dir == 1 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 9 || W.dir == 5))) && (W.x == src.x && W.y == src.y + 1) || ((W.dir == 8 || (W.dir == 4 || (W.dir == 10 || W.dir == 9))) && (W.y == src.y && W.x == src.x + 1) || (W.dir == 8 || (W.dir == 4 || (W.dir == 6 || W.dir == 5))) && (W.y == src.y && W.x == src.x - 1))))
			src.quantum(W)
		else if(src.dir == 4 && ((W.dir == 4 || (W.dir == 8 || (W.dir == 10 || W.dir == 9))) && (W.x == src.x + 1 && W.y == src.y) || ((W.dir == 1 || (W.dir == 2 || (W.dir == 6 || W.dir == 10))) && (W.y == src.y + 1 && W.x == src.x) || (W.dir == 1 || (W.dir == 2 || (W.dir == 5 || W.dir == 9))) && (W.y == src.y - 1 && W.x == src.x))))
			src.quantum(W)
		else if(src.dir == 8 && ((W.dir == 4 || (W.dir == 8 || (W.dir == 6 || W.dir == 5))) && (W.x == src.x - 1 && W.y == src.y) || ((W.dir == 1 || (W.dir == 2 || (W.dir == 6 || W.dir == 10))) && (W.y == src.y + 1 && W.x == src.x) || (W.dir == 1 || (W.dir == 2 || (W.dir == 5 || W.dir == 9))) && (W.y == src.y - 1 && W.x == src.x))))
			src.quantum(W)
	for(var/obj/wire/W in orange(1, src))
		if(!(W == hueviy))
			if(src.dir == 2 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 10 || W.dir == 6))) && (W.y == src.y - 1 && W.x == src.x) || ((W.dir == 8 || (W.dir == 4 || (W.dir == 10 || W.dir == 9))) && (W.x == src.x + 1 && W.y == src.y) || (W.dir == 8 || (W.dir == 4 || (W.dir == 6 || W.dir == 5))) && (W.x == src.x - 1 && W.y == src.y))))
				src.quantum(W)
			else if(src.dir == 1 && ((W.dir == 1 || (W.dir == 2 || (W.dir == 9 || W.dir == 5))) && (W.x == src.x && W.y == src.y + 1) || ((W.dir == 8 || (W.dir == 4 || (W.dir == 10 || W.dir == 9))) && (W.y == src.y && W.x == src.x + 1) || (W.dir == 8 || (W.dir == 4 || (W.dir == 6 || W.dir == 5))) && (W.y == src.y && W.x == src.x - 1))))
				src.quantum(W)
			else if(src.dir == 4 && ((W.dir == 4 || (W.dir == 8 || (W.dir == 10 || W.dir == 9))) && (W.x == src.x + 1 && W.y == src.y) || ((W.dir == 1 || (W.dir == 2 || (W.dir == 6 || W.dir == 10))) && (W.y == src.y + 1 && W.x == src.x) || (W.dir == 1 || (W.dir == 2 || (W.dir == 5 || W.dir == 9))) && (W.y == src.y - 1 && W.x == src.x))))
				src.quantum(W)
			else if(src.dir == 8 && ((W.dir == 4 || (W.dir == 8 || (W.dir == 6 || W.dir == 5))) && (W.x == src.x - 1 && W.y == src.y) || ((W.dir == 1 || (W.dir == 2 || (W.dir == 6 || W.dir == 10))) && (W.y == src.y + 1 && W.x == src.x) || (W.dir == 1 || (W.dir == 2 || (W.dir == 5 || W.dir == 9))) && (W.y == src.y - 1 && W.x == src.x))))
				src.quantum(W)
	for(var/obj/triwire/T in orange(1, src))
		hueviy = T
		if(src.dir == 2 && (!(T.dir == 8) && (T.x == src.x - 1 && T.y == src.y) || (!(T.dir == 4) && (T.x == src.x + 1 && T.y == src.y) || !(T.dir == 2) && (T.x == src.x && T.y == src.y - 1))))
			src.triquantum(T)
		else if(src.dir == 1 && (!(T.dir == 8) && (T.x == src.x - 1 && T.y == src.y) || (!(T.dir == 4) && (T.x == src.x + 1 && T.y == src.y) || !(T.dir == 1) && (T.x == src.x && T.y == src.y + 1))))
			src.triquantum(T)
		else if(src.dir == 8 && (!(T.dir == 8) && (T.x == src.x - 1 && T.y == src.y) || (!(T.dir == 2) && (T.x == src.x && T.y == src.y - 1) || !(T.dir == 1) && (T.x == src.x && T.y == src.y + 1))))
			src.triquantum(T)
		else if(src.dir == 4 && (!(T.dir == 4) && (T.x == src.x + 1 && T.y == src.y) || (!(T.dir == 2) && (T.x == src.x && T.y == src.y - 1) || !(T.dir == 1) && (T.x == src.x && T.y == src.y + 1))))
			src.triquantum(T)
	for(var/obj/triwire/T in orange(1, src))
		if(!(T == hueviy))
			if(src.dir == 2 && (!(T.dir == 8) && (T.x == src.x - 1 && T.y == src.y) || (!(T.dir == 4) && (T.x == src.x + 1 && T.y == src.y) || !(T.dir == 2) && (T.x == src.x && T.y == src.y - 1))))
				src.triquantum(T)
			else if(src.dir == 1 && (!(T.dir == 8) && (T.x == src.x - 1 && T.y == src.y) || (!(T.dir == 4) && (T.x == src.x + 1 && T.y == src.y) || !(T.dir == 1) && (T.x == src.x && T.y == src.y + 1))))
				src.triquantum(T)
			else if(src.dir == 8 && (!(T.dir == 8) && (T.x == src.x - 1 && T.y == src.y) || (!(T.dir == 2) && (T.x == src.x && T.y == src.y - 1) || !(T.dir == 1) && (T.x == src.x && T.y == src.y + 1))))
				src.triquantum(T)
			else if(src.dir == 4 && (!(T.dir == 4) && (T.x == src.x + 1 && T.y == src.y) || (!(T.dir == 2) && (T.x == src.x && T.y == src.y - 1) || !(T.dir == 1) && (T.x == src.x && T.y == src.y + 1))))
				src.triquantum(T)
	spawn(2) src.trinet()

/obj/triwire/proc/quantum(obj/Wier)
	sleep(0)
	if(Wier:energy > src.energy && Wier:energy > 0)
		Wier:energy -= 1
		src.energy += 1
	else if(Wier:energy < src.energy && src.energy > 0)
		Wier:energy += 1
		src.energy -= 1

/obj/triwire/proc/triquantum(obj/Wier)
	sleep(0)
	if(Wier:energy > src.energy && Wier:energy > 0)
		Wier:energy -= 1
		src.energy += 1
	else if(Wier:energy < src.energy && src.energy > 0)
		Wier:energy += 1
		src.energy -= 1
