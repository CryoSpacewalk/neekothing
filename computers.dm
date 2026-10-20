/obj/comp/camera
/obj/comp/dust
/obj/comp/cognitology
/obj/comp
	dir = 1
	icon = 'grafon/comp.dmi'
	name = "PeKa";icon_state = "pc_sing";alticon = "pc_sing_alt";var/on = 0
	var/harddrive = new /obj/item/electronics/drive
	var/powered = 0
	var/fucked = 0
	var/charges = 0
	var/board;var/details
/obj/comp/cognitology
/obj/comp/verb/turnoff()
	set name = "Turn on/off"


	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to turn it on or off due to your mutation!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.fucked == 1)
		usr << "\red It is fucked up!"
	else if(src:powered == 0)
		usr << "\red Looks like it is broken or went out of power."
	else if(src.on == 1)
		set src in view(1)
		on = 0
		src.dir = 1

		src.sd_SetLuminosity(0)
		if(istype(src, /obj/comp/lights))
			for(var/obj/lamp/L in range(25, src))
				L.turnoff()
	else
		set background = 0
		on = 1
		playsound('sounds/electro.wav')
		src.dir = 2
		src.sd_SetLuminosity(1)
		for(var/mob/M in viewers(src))
			if(prob(M.epilepsy * 2))
				M.seizure(6)

/obj/comp/attack_by(obj/I)


	if(istype(I, /obj/item/tool/screwdriver))
		usr << "\blue You disconnect the monitor, detach the keyboard and remove all the hardware."
		new /obj/item/electronics/monitor(src.loc)
		var/F = new /obj/frame(src.loc)
		board:loc = src.loc
		if(src.harddrive)
			src.harddrive:loc = loc
		new /obj/item/electronics/keyboard(src.loc)
		new /obj/item/cable/single(src.loc)
		F:charges = 0
		if(istype(src, /obj/comp/lights))
			for(var/obj/lamp/L in range(25, src))
				L.turnoff()
		del(src)
	else
		if(istype(I, /obj/item/weapon/battleaxe))
			usr << "\blue [src] falls apart!"
			new /obj/item/material/compparts(src)
			new /obj/item/cable/single(src.loc)

			if(istype(src, /obj/comp/lights))
				for(var/obj/lamp/L in range(25, src))
					L.turnoff()

			sleep(0)
			del(src)
			return
		else if(istype(I, /obj/item/supplycharge) && (istype(src, /obj/comp/ordering) && (src.harddrive == 1 && src.fucked == 0)))
			usr << "\blue You load a cartridge to the ordering machine."
			if(istype(I, /obj/item/supplycharge/giant))
				charges += 5
			else if(istype(I, /obj/item/supplycharge/large))
				charges += 2
			else
				charges += 1
			spawn(0) del(I)
			return
		else if(istype(I, /obj/item/diamond) && (istype(src, /obj/comp/ordering) && (src.harddrive == 1 && src.fucked == 0)))
			usr << "\blue You put a jewel to the ordering machine."
			usr << "\blue The machine sofltly beeps to you."
			if(I:name == "emeralds")
				usr << "\blue \italic Oh, precious gems! Emeralds and are always in price! We'll give you 5 extra charges for it."
				charges += 5
			else if(I:name == "rubys")
				usr << "\blue \italic Oh, precious rubys! We'll give you 3 extra charges for it."
				charges += 3
			else
				usr << "\blue \italic Oh, precious gems! We'll give you 1 extra charge for it."
				charges++
			spawn(0) usr.delitem()
		else if(istype(I, /obj/item/electronics/synthstone) && (istype(src, /obj/comp/ordering) && (src.harddrive == 1 && src.fucked == 0)))
			usr << "\blue You load a cartridge to the ordering machine."
			usr << "\blue The machine sofltly beeps to you."
			usr << "\blue \italic Well, this jewel is synthetic. Sorry, but you need some actual precious gems to order something."
		else
			if(istype(I, /obj/item/device/consolehack))
				src.hack()
			else
				if(istype(I, /obj/item/tool/pulse) && I:charges)
					if(prob(10 + usr.energyprotect + round(usr.luck / 2) + min(0, round(usr.calm / 5)) + usr.euphoria / 10 - round(usr.thrill / 3)) && !("chromosome" in usr.mutations))
						I:charges--
						usr << "\blue \bold You overclock [src.name]!"
						src.hack()
					else
						I:charges--
						usr << "\red \bold You try to overclock [src.name], but due to your clumsiness you get shocked!"
						new /obj/effect/sparks(src.loc)
						new /obj/effect/sparks(usr.loc)
						if(usr.energyprotect < 7)
							usr.damaga(10, "burn")
							usr.stun(10)
							if(usr.thrill < 5)
								usr.thrill = 5
						else
							usr.damaga(5, "burn")
							usr.stun(1)
				else

					if(istype(src, /obj/comp/transport))
						if(src.fucked == 0)
							if(istype(I, /obj/item/device/caller) && !onhold)
								if(src.on)
									playsound('sounds/sleva_molot.ogg')
									shuttlecall()
								else
									usr << "It is off, damn it!"
							else if(istype(I, /obj/item/device/uncaller))
								if(src.on)
									if(forceshut)
										usr << "\red EÃÃ0r 0x000000001: please, contact your local FTL travel coordinator to remove the recall block"
										return
									else
										shuttlerecall()
								else
									usr << "It is off, damn it!"

/obj/comp/attack_hand()
	if(usr.psi_radius > 1)

		src.turnoff()

/obj/comp/proc/hack(mob/MB)
	if(src.fucked)
		MB << "\red It is fucked up and can't be overclocked!"
		return

	if(istype(src, /obj/comp/lights))
		for(var/mob/M in view(2, src))
			M << "SPARK SMASH BOOM"
		for(var/obj/lamp/L in range(25, src))
			L.turnoff()
		src.fuckup()
	else if(istype(src, /obj/comp/singpc))
		for(var/mob/M in view(2, src))
			M << "SPARK SMASH BOOM"
		for(var/obj/dest/emitter/E in range(25, src))
			E.pewpew()
		src.fuckup()
	else if(istype(src, /obj/comp/transport))
		if(onhold == 0)
			shuttlecall()

		else if(forceshut)
			usr << "\red EÃÃ0r 0x000000001: please, contact your local FTL travel coordinator to remove the recall block"
			return
		else
			shuttlerecall()
	else if(istype(src, /obj/comp/gas))
		for(var/mob/M in view(2, src))
			M << "SPARK SMASH BOOM"
		for(var/obj/door/airlock/A in range(15, src))
			if(A.closed == 1)
				A.bolt()
			else
				A.closed()
				A.bolt()
		for(var/obj/chemical/gastank/G in range(15, src))
			if(!istype(G, /obj/chemical/gastank/portable))
				G.opened = 1
				spawn(5) G.release()
		src.fuckup()
/obj/comp/ordering
/obj/comp/ordering/proc/hack_special()
	usr << "\red The computer beeps softly to you:"
	usr << "\blue \bold Special supplies unlocked."
	src.L += "Special supplies (5 charges)"
	return

/obj/comp/proc/fuckup()
	src.fucked = 1
	src.on = 0
	src.dir = 4

/obj/comp/singpc
	harddrive = 0




	board = new /obj/item/electronics/board/singpc
	var/auto = 0;name = "Emitter Control Console"
/obj/comp/singpc/verb/emitting()
	set name = "Emission"

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(fucked == 1)
		usr << "It is fucked up!"
	else if(on == 1)
		set src in view(1)
		usr << "Now emitting."
		for(var/obj/dest/emitter/M in range(4, src))
			M.pewpew()
	else











		usr << "It is off, damn it!"
/obj/comp/singpc/verb/autoemitt()
	set name = "Autoemission"


	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(fucked)
		usr << "It is fucked up!"
	else if(on)
		set src in view(1)
		if(src.auto)
			src.auto = 0
			spawn(0) usr << "Autoemisson is now off."
		else
			src.auto = 1
			spawn(0) usr << "Autoemission is now on."
		spawn(0)
			src.autoshoot()
/obj/comp/singpc/proc/autoshoot()
	if(src.fucked || (!src.on || !src.auto))
		return
	else
		for(var/obj/dest/emitter/E in range(4, src))
			E.pewpew()
		spawn(0)
			spawn(31) src.autoshoot()
/obj/comp/singpc/New()
	..()
	powercheck()
/obj/comp/singpc/operate(obj/W)
	if(W:energy > 0)
		var/meth = input("What to do?", "", "Turn on/off") in list("Turn on/off", "Toggle autoemission")
		switch(meth)
			if("Turn on/off")
				src.turnoff()
			if("Toggle autoemission")
				src.autoemitt()
				W:energy -= 1
	else
		usr << "\red Not enough energy!"

/obj/comp/lights
	luminosity = 0
	on = 0
	powered = 0



	board = new /obj/item/electronics/board/lightpc; name = "Local Lights Control";icon_state = "pc_lights"
/obj/comp/lights/verb/lightson()
	set name = "Turn lights on"

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return


	if(fucked == 0)
		if(on == 1)
			set src in view(1)
			usr << "You turn local lights on."
			for(var/obj/lamp/L in range(25, src))
				L.turnon()
		else
			usr << "It is off, damn it!"
	else
		usr << "It is fucked up!"


		usr << "\blue \bold No external memory storage unit detected. Please, install one before operating."
/obj/comp/lights/verb/lightsoff()
	set name = "Turn lights off"

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.on == 1)
		set src in view(1)
		usr << "You turn local lights off."
		for(var/obj/lamp/L in range(25, src))
			L.turnoff()
	else
		usr << "It is off, damn it!"
/obj/comp/lights/New()
	src.lightcheck()
/obj/comp/lights/operate(obj/W)
	if(W:energy > 0)
		W:energy -= 1
		src.turnoff()
		spawn(0)
			if(src.on)
				src.lightson()
	else
		usr << "\red Not enough energy!"
		return

/obj/comp/proc/powercheck()
	for(var/obj/wire/battery/B in src.loc)
		if(!(B in src.loc) || B.energy <= 0)
			src.dir = 1
			src.on = 0
			src:powered = 0
			sd_SetLuminosity(0)
		else
			src:powered = 1
			if(prob(20))
				B.energy--
	spawn(15) src.powercheck()

/obj/comp/lights/proc/lightcheck()
	for(var/obj/wire/battery/B in src.loc)
		if(!(B in src.loc))
			for(var/obj/lamp/L in range(25, src))
				L.turnoff()
			src.dir = 1
			src.on = 0
			src.powered = 0

			sd_SetLuminosity(0)
		if(B.energy > 0)
			if(src.powered == 0)
				src.on = 1
				src.powered = 1
				src.dir = 2

				sd_SetLuminosity(1)
				for(var/obj/lamp/L in range(25, src))
					L.turnon()
			if(src.on == 1)
				B.energy -= 1
		else
			for(var/obj/lamp/L in range(25, src))
				L.turnoff()
			src.dir = 1
			src.on = 0
			src.powered = 0

			sd_SetLuminosity(0)
	spawn(15) src.lightcheck()

/obj/comp/ordering





	board = new /obj/item/electronics/board/ordering
	name = "Communications and Supply Control"
	icon_state = "pc_ordering";var/supplies;var/i = 0
	var/obj/L = new /list
/obj/comp/ordering/New()
	..()
	src.L = list("Cables (1 charge)", "Pieces of bread supply (1 charge)", "Hydro supply (1 charge)", "Nutriment supply (1 charge)", "Water tank (1 charge)", "Primary tools (1 charge)", "Adv. tools (2 charges)", "Fuel tank (2 charges)", "Engine fuel supply (3 charges)", "Seed and spawn supply (2 charges)", "Electronics (3 charges)", "Medical supplies (2 charges)", "Psychiatry supplies (3 charges)", "Cognitology supplies (3 charges)", "30 metal sheets (1 charge)", "30 plastic sheets (2 charges)", "30 silicon sheets (2 charges)", "Primary material sheets (3 charges)", "Chemical supplies (2 charges)", "Spacesuits (4 charges)")
	src.powercheck()
/obj/comp/ordering/verb/lightson()
	set name = "Order supplies"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.on == 1)
		supplies = input("Please, make your selection:", "[src.charges] charges left", "Cables (1 charge)") in L
		switch(supplies)
			if("Cables (1 charge)")
				if(src.charges > 0)
					src.charges -= 1
					for(i = 0, src.i <= 12, src.i++)
						new /obj/item/cable(usr.loc)
					for(src.i = 0, src.i <= 4, src.i++)
						new /obj/item/outlet(usr.loc)
					new /obj/structure/container/crate(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("Pieces of bread supply (1 charge)")
				if(src.charges > 0)
					src.charges -= 1
					for(i = 0, src.i <= 8, src.i++)
						new /obj/item/reagent_container/consumable/bread(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("Water tank (1 charge)")
				if(src.charges > 0)
					src.charges -= 1
					new /obj/structure/liquid_dispenser/water(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("Fuel tank (2 charges)")
				if(src.charges > 0)
					src.charges -= 1
					new /obj/structure/liquid_dispenser/fuel(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("Engine fuel supply (3 charges)")
				if(src.charges > 2)
					src.charges -= 3
					new /obj/chemical/gastank/portable/fuel/engine(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("Primary tools (1 charge)")
				if(src.charges > 0)
					src.charges -= 1
					new /obj/item/tool/meter(usr.loc)
					new /obj/item/tool/airmeter(usr.loc)
					new /obj/item/tool/torch(usr.loc)
					new /obj/item/tool/screwdriver(usr.loc)
					new /obj/item/tool/hammer(usr.loc)
					new /obj/item/tool/wirecutters(usr.loc)
					new /obj/item/tool/pulse(usr.loc)
					new /obj/structure/container/crate(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("Adv. tools (2 charges)")
				if(src.charges > 1)
					src.charges -= 2
					new /obj/item/tool/sonic_drill(usr.loc)
					new /obj/item/tool/hydraulic_cutters(usr.loc)
					new /obj/item/tool/axe(usr.loc)
					new /obj/item/tool/axe(usr.loc)
					new /obj/item/tool/saw(usr.loc)
					new /obj/item/tool/pulse(usr.loc)
					new /obj/structure/container/crate(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("Electronics (3 charges)")
				if(src.charges > 2)
					src.charges -= 3
					new /obj/item/electronics/drive(usr.loc)
					new /obj/item/electronics/drive(usr.loc)
					new /obj/item/electronics/board/lightpc(usr.loc)
					new /obj/item/electronics/board/singpc(usr.loc)
					new /obj/item/electronics/board/tele(usr.loc)
					new /obj/item/electronics/core/targeting(usr.loc)
					new /obj/item/electronics/core/plasma(usr.loc)
					new /obj/item/electronics/spreader_unfinished(usr.loc)
					new /obj/item/electronics/core/xom(usr.loc)
					new /obj/structure/container/crate(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("Hydro supply (1 charge)")
				if(src.charges > 0)
					src.charges -= 1
					new /obj/structure/tray(usr.loc)
					new /obj/item/fertilizer(usr.loc)
					new /obj/item/fertilizer(usr.loc)
					new /obj/item/fertilizer(usr.loc)
					new /obj/item/fertilizer(usr.loc)
					new /obj/item/fertilizer(usr.loc)
					new /obj/item/bugdust(usr.loc)
					new /obj/item/bugdust(usr.loc)
					new /obj/item/bugdust(usr.loc)
					new /obj/structure/container/crate(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("Nutriment supply (1 charge)")
				if(src.charges > 0)
					src.charges -= 1
					new /obj/item/reagent_container/consumable/donut(usr.loc)
					new /obj/item/reagent_container/consumable/sandwich(usr.loc)
					new /obj/item/reagent_container/consumable/sandwich(usr.loc)
					new /obj/item/reagent_container/consumable/sandwich(usr.loc)
					new /obj/item/reagent_container/consumable/sandwich(usr.loc)
					new /obj/item/reagent_container/consumable/sandwich(usr.loc)
					new /obj/item/reagent_container/consumable/sandwich(usr.loc)
					new /obj/item/reagent_container/consumable/sandwich(usr.loc)
					new /obj/item/reagent_container/consumable/sandwich(usr.loc)
					new /obj/item/reagent_container/consumable/sandwich(usr.loc)
					new /obj/item/reagent_container/consumable/sandwich(usr.loc)
					new /obj/structure/container/crate(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("Seed and spawn supply (2 charges)")
				if(src.charges > 1)
					src.charges -= 2
					new /obj/item/reagent_container/consumable/seed/pogankee(usr.loc)
					new /obj/item/reagent_container/consumable/seed/lepista(usr.loc)
					new /obj/item/reagent_container/consumable/seed/regen(usr.loc)
					new /obj/item/reagent_container/consumable/seed/cucumber(usr.loc)
					new /obj/item/reagent_container/consumable/seed/stalks(usr.loc)
					new /obj/item/reagent_container/consumable/seed/weed(usr.loc)
					new /obj/structure/container/crate(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("Medical supplies (2 charges)")
				if(src.charges > 1)
					src.charges -= 2
					new /obj/item/reagent_container/beaker/bottle/toxin(usr.loc)
					new /obj/item/reagent_container/beaker/bottle/antidote(usr.loc)
					new /obj/item/reagent_container/beaker/bottle/regen(usr.loc)
					new /obj/item/reagent_container/beaker/bottle/manganeska(usr.loc)
					new /obj/item/reagent_container/beaker/bottle/syrup(usr.loc)
					new /obj/item/blister/phenazepam(usr.loc)
					new /obj/item/tool/scalpel(usr.loc)
					new /obj/structure/container/crate(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("Psychiatry supplies (3 charges)")
				if(src.charges > 2)
					src.charges -= 3
					new /obj/item/reagent_container/beaker/bottle/midaz(usr.loc)
					new /obj/item/reagent_container/beaker/bottle/haloperidol(usr.loc)
					new /obj/item/reagent_container/beaker/bottle/stim_med(usr.loc)
					new /obj/item/blister/fluoxetine(usr.loc)
					new /obj/item/blister/glucose(usr.loc)
					new /obj/item/blister/risperidone(usr.loc)
					new /obj/item/blister/cetam(usr.loc)
					new /obj/item/blister/phenazepam(usr.loc)
					new /obj/item/blister/cyclodol(usr.loc)
					new /obj/item/blister/sel(usr.loc)
					new /obj/item/blister/aminazine(usr.loc)
					new /obj/item/blister/gabapentin(usr.loc)
					new /obj/item/reagent_container/consumable/pill/methadone(usr.loc)
					new /obj/structure/container/crate(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("Chemical supplies (2 charges)")
				if(src.charges > 1)
					src.charges -= 2
					new /obj/item/reagent_container/beaker/bottle/toxin(usr.loc)
					new /obj/item/reagent_container/beaker/bottle/yeast(usr.loc)
					new /obj/item/reagent_container/beaker/bottle/antidote(usr.loc)
					new /obj/item/reagent_container/beaker/bottle/fuel/large(usr.loc)

					new /obj/item/reagent_container/beaker/bucket/canister_cellulose(usr.loc)
					new /obj/item/reagent_container/beaker/bottle/carbox(usr.loc)
					new /obj/item/reagent_container/beaker/bottle/benzaldehyde(usr.loc)
					new /obj/item/reagent_container/grenade(usr.loc)
					new /obj/item/reagent_container/grenade(usr.loc)
					new /obj/structure/container/crate(usr.loc)
				else

					usr << "\red Not enough charges!"
					return
			if("30 metal sheets (1 charge)")
				if(src.charges > 0)
					src.charges--
					for(i = 0, src.i <= 1, src.i++)
						new /obj/item/material/sheet/order(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("30 plastic sheets (1 charge)")
				if(src.charges > 0)
					src.charges--
					for(i = 0, src.i <= 1, src.i++)
						new /obj/item/material/plastic(usr.loc)
						new /obj/item/material/plastic/order(usr.loc)
						new /obj/structure/container/crate(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("30 silicon sheets (2 charges)")
				if(src.charges > 1)
				else
					usr << "\red Not enough charges!"
					return
					src.charges -= 2
					for(i = 0, src.i <= 1, src.i++)
						new /obj/item/material/silicon/prespawned(usr.loc)
					new /obj/structure/container/crate(usr.loc)
			if("Primary material sheets (3 charges)")
				if(src.charges > 2)
					src.charges -= 3
					for(i = 0, src.i <= 3, src.i++)
						new /obj/item/material/plastic/order(usr.loc)
						new /obj/item/material/sheet/prespawned(usr.loc)
						new /obj/item/material/silicon/prespawned(usr.loc)
						new /obj/item/material/silicon/prespawned(usr.loc)
						new /obj/item/material/board/prespawned(usr.loc)
						new /obj/structure/container/crate(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("Spacesuits (4 charges)")
				if(src.charges > 3)
					src.charges -= 4
					new /obj/item/clothes/space(usr.loc)
					new /obj/item/clothes/space(usr.loc)
					new /obj/item/clothes/space(usr.loc)
					new /obj/item/clothes/space(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
			if("Cognitology supplies (3 charges)")
				if(src.charges > 2)
					src.charges -= 3
					new /obj/item/reagent_container/beaker/bottle/mind(usr.loc)
					new /obj/item/reagent_container/beaker/bottle/mind(usr.loc)
					new /obj/item/reagent_container/beaker/bottle/mind(usr.loc)
					new /obj/item/reagent_container/beaker/bottle/mind(usr.loc)
					new /obj/item/blister/cetam(usr.loc)
					new /obj/structure/container/crate(usr.loc)
				else




					usr << "\red Not enough charges!"
					return
			if("Special supplies (5 charges)")
				if(src.charges > 4)
					src.charges -= 5
					new /obj/item/reagent_container/syringe/mutagenerite(usr.loc)
					new /obj/item/reagent_container/syringe/stimpack(usr.loc)
					new /obj/item/device/brutforcer(usr.loc)
					new /obj/item/clothes/space/traitor(usr.loc)
				else
					usr << "\red Not enough charges!"
					return
	else
		usr << "It is off, damn it!"





/obj/comp/transport












	board = new /obj/item/electronics/board/transport
	name = "Kosmoflot Transport Communications Console";icon_state = "transport"
/obj/comp/transport/New()
	powercheck()
/obj/comp/transport/operate(obj/W)
	turnoff()

/obj/comp/transport/verb/count()
	set name = "Calculate a probablity of infiltration by a hostile elements"
	set src in view(1)


	if(src.on && !src.fucked)

		usr << "\bold \italic Please, wait for a few seconds for calculation..."
		sleep(50)
		if((usr in view(1, src)) && (src.on && !src.fucked))
			usr.counttraitors()
	else

		usr << "It is off, damn it!"

/obj/comp/gas

	board = new /obj/item/electronics/board/gas
	name = "Local Gas Control Console";icon_state = "gas"
/obj/comp/gas/New()
	powercheck()

/obj/comp/gas/verb/bolt()
	set name = "Block gas floodgates"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.on == 1)
		for(var/obj/wire/battery/B in loc)
			if(B.energy > 0)
				B.energy -= 1
				for(var/obj/door/airlock/A in range(8, src.loc))
					if(A.closed == 1 && A.fucked == 0)
						A.bolt()
				usr << "\blue \bold Local floodgates blocked."
			else
				usr << "\blue The console softly beeps to you:"
				usr << "\blue \bold Not enough energy to process your order. Please, re-check local power and try again."
	else
		usr << "\red It is off, damn it!"
/obj/comp/gas/verb/unbolt()
	set name = "Unblock gas floodgates"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.on == 1)
		for(var/obj/wire/battery/B in loc)
			if(B.energy > 0)
				B.energy -= 1
				for(var/obj/door/airlock/A in range(8, src.loc))
					if(A.blocked == 1)
						A.unbolt()
				usr << "\blue \bold Local floodgates unblocked."
			else
				usr << "\blue The console softly beeps to you:"
				usr << "\blue \bold Not enough energy to process your order. Please, re-check local power and try again."
	else
		usr << "\red It is off, damn it!"
/obj/comp/gas/verb/close()
	set name = "Close gas floodgates"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.on == 1)
		for(var/obj/door/airlock/A in range(8, loc))
			if(A.closed == 0 && (A.fucked == 0 && A.blocked == 0))
				A.closed()
		usr << "\blue \bold Local floodgates closed."
	else
		usr << "\red It is off, damn it!"
/obj/comp/gas/verb/open()
	if(src.on == 1)
		set name = "Open gas floodgates"
		set src in view(1)
	else

		usr << "\red It is off, damn it!"
		return

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	for(var/obj/door/airlock/A in range(8, src.loc))
		if(A.closed == 1 && (A.fucked == 0 && A.blocked == 0))
			A.opened()
	usr << "\blue \bold Local floodgates opened."

/obj/comp/gas/verb/filton()
	set name = "Turn local gas filters on"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(on == 1)
		for(var/obj/wire/battery/B in src.loc)
			if(B.energy > 0)
				B.energy -= 1
				for(var/obj/chemical/filter/F in range(8, src.loc))
					if(F.on == 0)
						F.on = 1
						F.dir = 1
						spawn(10) F.filt()
				usr << "\blue \bold Now filtering."
			else
				usr << "\blue The console softly beeps to you:"
				usr << "\blue \bold Not enough energy to process your order. Please, re-check local power and try again."
	else
		usr << "\red It is off, damn it!"
/obj/comp/gas/verb/filtoff()
	set name = "Turn local gas filters off"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.on == 1)
		for(var/obj/wire/battery/B in loc)
			if(B.energy > 0)
				B.energy -= 1
				for(var/obj/chemical/filter/F in range(8, src.loc))
					if(F.on == 1)
						F.on = 0
						F.dir = 2
				usr << "\blue \bold Now stopped filtering."
			else
				usr << "\blue The console softly beeps to you:"
				usr << "\blue \bold Not enough energy to process your order. Please, re-check local power and try again."
	else
		usr << "\red It is off, damn it!"

/obj/comp/gas/verb/pumpon()
	set name = "Turn local gas pump pipes on"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(on == 1)
		for(var/obj/wire/battery/B in src.loc)
			if(B.energy > 0)
				B.energy -= 1
				for(var/obj/machine/gas/pipealike/pipe/pump/F in range(8, src.loc))
					if(F.on == 0)
						F.on = 1
						F.icon_state = "pump_on"
						F.suck()
				usr << "\blue \bold Now setting pump pipes on."
			else
				usr << "\blue The console softly beeps to you:"
				usr << "\blue \bold Not enough energy to process your order. Please, re-check local power and try again."
	else
		usr << "\red It is off, damn it!"

/obj/comp/gas/verb/pumpoff()
	set name = "Turn local gas pump pipes off"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.on == 1)
		for(var/obj/wire/battery/B in loc)
			if(B.energy > 0)
				B.energy -= 1
				for(var/obj/machine/gas/pipealike/pipe/pump/F in range(8, src.loc))
					if(F.on == 1)
						F.on = 0
						F.icon_state = "pump"
				usr << "\blue \bold Now setting pump pipes off."
			else
				usr << "\blue The console softly beeps to you:"
				usr << "\blue \bold Not enough energy to process your order. Please, re-check local power and try again."
	else
		usr << "\red It is off, damn it!"

/obj/comp/gas/verb/gasopen()
	set name = "Open local stationary gas tanks"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.on == 1)
		for(var/obj/wire/battery/B in loc)
			if(B.energy > 0)
				B.energy -= 1
				for(var/obj/chemical/gastank/G in range(8, src.loc))
					if(G.opened == 0 && G.anchored == 1)
						G.opened = 1
						spawn(5) G.release()
				usr << "\blue \bold Gas supply activated."
			else
				usr << "\blue The console softly beeps to you:"
				usr << "\blue \bold Not enough energy to process your order. Please, re-check local power and try again."
	else
		usr << "\red It is off, damn it!"
/obj/comp/gas/verb/gasclose()
	set name = "Close local stationary gas tanks"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.on == 1)
		for(var/obj/wire/battery/B in loc)
			if(B.energy > 0)
				B.energy -= 1
				for(var/obj/chemical/gastank/G in range(8, src.loc))
					if(G.opened == 1 && G.anchored == 1)
						G.opened = 0
				usr << "\blue \bold Gas supply deactivated."
			else
				usr << "\blue The console softly beeps to you:"
				usr << "\blue \bold Not enough energy to process your order. Please, re-check local power and try again."
	else
		usr << "\red It is off, damn it!"
/obj/comp/gas/verb/spark()
	set name = "Activate local stationary igniters"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.on == 1)
		for(var/obj/wire/battery/B in loc)
			if(B.energy > 0)
				B.energy -= 1
				for(var/obj/machine/statigniter/I in range(8, src.loc))
					I.spark()
					usr << "\blue The console softly beeps to you:"
					usr << "\blue \bold Spark,spark,spark. Beep."
			else
				usr << "\blue The console softly beeps to you:"
				usr << "\blue \bold Not enough energy to process your order. Please, re-check local power and try again."
	else
		usr << "\red It is off, damn it!"

/obj/comp/tele

	board = new /obj/item/electronics/board/tele
	icon_state = "tele"
	name = "Teleporter Control Console"
/obj/comp/tele/verb/changeid()
	set name = "Change nearly teleporters IDs"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.on == 1)
		for(var/obj/wire/battery/B in loc)
			if(B.energy > 0)
				B.energy -= 1
				for(var/obj/teleporter/A in range(1, src.loc))
					A.id = input("New ID:", "ID selection", A.id)
			else
				usr << "\blue The console softly beeps to you:"
				usr << "\blue \bold Not enough energy to process your order. Please, re-check local power and try again."
	else
		usr << "\red It is off, damn it!"
/obj/comp/tele/New()
	powercheck()
/obj/comp/tele/operate(obj/W)
	turnoff()


/obj/comp/alert

	board = new /obj/item/electronics/board/alert; icon_state = "pc_scan";name = "Station Alerts Console"
	var/list/messages = list(); var/msgnum = 1
/obj/comp/alert/New()

	powercheck()
/obj/comp/alert/proc/add_message(msg as text)
	src.messages.Add("[src.msgnum]. [msg]")
	src.msgnum += 1

/obj/comp/alert/verb/checklights()
	set name = "Check station lights"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(src.on == 1)
		for(var/obj/comp/lights/L in world)
			if(L.z == src.z)
				var/direc = "northern"
				if(L.x > src.x + 8 && L.y > src.y + 8)
					direc = "northeastern"
				else if(L.x < src.x - 8 && L.y < src.y - 8)
					direc = "southwestern"
				else if(L.x > src.x + 8 && L.y < src.y - 8)
					direc = "southeastern"
				else if(L.x < src.x - 8 && L.y > src.y + 8)
					direc = "southeastern"
				else if(L.y < src.y - 8)
					direc = "southern"
				else if(L.y > src.y + 8)
					direc = "northern"
				else if(L.x > src.x + 8)
					direc = "eastern"
				else if(L.x < src.x - 8)
					direc = "western"
				else
					direc = "central"
				spawn(0)
					if(L.fucked == 1)
						usr << "\blue The machine softly beeps to you:"
						usr << "\red The [direc] light control console is broken."
					else if(L.powered == 0)
						usr << "\blue The machine softly beeps to you:"
						usr << "\red The [direc] light control console stays power-dry."
					else if(L.on == 0)
						usr << "\blue The machine softly beeps to you:"
						usr << "\red The [direc] light control stays turned off."
	else
		usr << "It is off, damn it!"
/obj/comp/alert/verb/read_msg()
	set name = "Read messages"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to read messages from this machine!"
		return

	if(src.on && !src.fucked)
		if(messages:len)
			for(var/T in messages)
				usr << "\bold [T]"
		else
			usr << "\blue No messages received for now."
	else
		usr << "It is off, damn it!"
/obj/comp/alert/verb/send_msg()
	set name = "Make telepathy message for security"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to send messages from this machine!"
		return

	if(src.on && !src.fucked)
		var/msg = input("What message?")
		if((src in view(1, usr)) && (src.on && !src.fucked))
			for(var/mob/M in world)
				if(M.prof == "security major")
					M << "\bold You receive a telepathy message:"
					M << "<font color = magenta size = 4> [ruout(msg)] </font>"
	else
		usr << "It is off, damn it!"
/obj/comp/alert/operate(obj/W)
	turnoff()





/obj/comp/prosecutor
	board = new /obj/item/electronics/board/prosecutor
	var/messages = list()
	var/msgnum = 1;icon_state = "pc_security";name = "Security Control Console"
/obj/comp/prosecutor/New()
	powercheck()

/obj/comp/prosecutor/verb/shock()
	set name = "Electrocute disobeying security member"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(on == 1)
		var/L = list()
		for(var/mob/M in world)
			if(M.prof == "security major")
				L += M
		if(L:len)
			var/M = input("What erring soul you wanna to electrocute?") in L
			if(M)
				M:show_message("\red [M:name] falls in pain!", "\red \bold You fall in pain! Looks like prosecutor (or operator) is very angry on you!")
				M:stun(10)
				M:damaga(5, "burn")
				M:torment(10)
		else
			usr << "\red \bold Looks like you're the only security member on board. Try to keep at least some sort of order on complex. Oh, and Lenin bless your soul."
	else

		usr << "It is off, damn it!"

/obj/comp/prosecutor/verb/count()
	set name = "Calculate a probablity of infiltration by a hostile elements"
	set src in view(1)

	if(src.on && !src.fucked)

		usr << "\bold \italic Please, wait for a few seconds for calculation..."
		sleep(50)
		if((usr in view(1, src)) && (src.on && !src.fucked))
			usr.counttraitors()
	else

		usr << "It is off, damn it!"

/obj/comp/prosecutor/verb/read_msg()
	set name = "Read latest alert messages"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to read messages from this machine!"
		return

	if(src.on && !src.fucked)
		if(messages:len)
			for(var/T in messages)
				usr << "\bold [T]"
		else
			usr << "\blue No messages received for now."
	else
		usr << "It is off, damn it!"

/obj/comp/prosecutor/verb/send_msg()
	set name = "Make telepathy message for security"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to send messages from this machine!"
		return

	if(src.on && !src.fucked)
		var/msg = input("What message?")
		if((src in view(1, usr)) && (src.on && !src.fucked))
			for(var/mob/M in world)
				if(M.prof == "security major")
					M << "\bold You receive a telepathy message:"
					M << "<font color = magenta size = 4> [ruout(msg)] </font>"
	else
		usr << "It is off, damn it!"
