/atom/movable/var/spacetravel = 1
/turf/airwall
	density = 1
	opacity = 1
	icon = 'Wall.dmi'
	airtight = 1
	icon_state = "air"
/turf/airwall
/turf/attack_by(obj/I)
	if(istype(usr.item, /obj/item/cable))
		var/W = new /obj/wire()
		W:dir = input("1 is north/south, 8 is west/east, 6 is southeast, 10 is southwest, 9 is northwest, 5 is northeast.", "Select a cable position:", "WEST") in list(1, 8, 10, 6, 9, 5)
		if((istype(usr.item, /obj/item/cable) && usr) in range(1, src))
			W:loc = src
			spawn(0)
				var/CB = usr.item
				CB:cminus(1)
				return
	else if(istype(I, /obj/item/tcable))
		var/W = new /obj/triwire()
		W:dir = input("1 is north, 2 is south, 8 is west, 4 is east:", "Select a T-cable position:", "WEST") in list(1, 2, 8, 4)
		if((istype(usr.item, /obj/item/tcable) && usr) in range(1, src))
			W:loc = src
			spawn(0)
				usr.delitem()
				return
	else if(istype(I, /obj/item/bluecable))
		var/W = new /obj/wireleech()
		W:dir = input("1 is north/south, 8 is west/east, 6 is southeast, 10 is southwest, 9 is northwest, 5 is northeast.", "Select a cable position:", "WEST") in list(1, 8, 10, 6, 9, 5)
		if((istype(usr.item, /obj/item/bluecable) && usr) in range(1, src))
			W:loc = src
			spawn(0)
				usr.delitem()
				return
	else if(istype(I, /obj/item/sharecable))
		var/W = new /obj/wireout()
		W:dir = input("1 is north/south, 8 is west/east:", "Select a power outlet position:", "WEST") in list(1, 8)
		if((istype(usr.item, /obj/item/sharecable) && usr) in range(1, src))
			W:loc = src
			spawn(0)
				usr.delitem()
				return
	else if(istype(I, /obj/item/caboutlet))
		var/W = new /obj/wire/battery()
		W:dir = input("1 is north/south, 8 is west/east:", "Select a power outlet position:", "WEST") in list(1, 8)
		if((istype(usr.item, /obj/item/caboutlet) && usr) in range(1, src))
			W:loc = src
			spawn(0)
				usr.delitem()
				return
	else if(istype(I, /obj/item/weapon/gun))
		I:after_attack(src, usr)
		..()

/turf/proc/airscan()
	switch(src.airtight)
		if(1)
			usr << "\blue The device softly beeps to you:"
			usr << "\green \bold \italic No breaches detected. Construction is airtight."
		if(0)
			usr << "\blue The device softly beeps to you:"
			usr << "\red \bold \italic A breach detected. Construction isn't airtight."
	return

/turf/verb/crawl()
	set name = "crawl"
	set src in view(1)

	if(usr.client.camera_anchor)
		usr << "\red \bold Stop staring at U.R.M.O.M. first, you nerd!"
		return

	if(!usr.parastunned && !usr.wired)
		if(prob(15 + usr.empowered * 5 + usr.luck))
			usr << "\blue You crawl at the adjacent tile."
			var/tablecrawl = 0
			for(var/obj/furniture/F in src)
				if(F)
					tablecrawl = 1
			for(var/obj/statue/S in src)
				if(S)
					tablecrawl = 1
			for(var/obj/machine/vendor/V in src)
				if(V)
					tablecrawl = 1
			for(var/obj/structure/container/C in src)
				if(C)
					tablecrawl = 1
			for(var/atom/A in src)
				if(A.density && (!istype(A, /obj/furniture) && (!istype(A, /obj/statue) && (!istype(A, /obj/machine/vendor) && !istype(A, /obj/structure/container)))))
					tablecrawl = 0
			if(tablecrawl)
				usr.loc = src
				for(var/obj/structure/container/crate/inv/IV in src)
					IV.invisibility = 0
			else
				step_to(usr, src)
		else
			usr << "\red You've failed at your pitiful attempts to crawl!"

/turf
	var/sd_light_spill = 0
	var/tmp/sd_lumcount = 0
	var/wired = 0
	var/airtight = 0
	var/atmos = 3
	var/icon_vars = 0









/turf/ground
	icon = 'floor.dmi'
	icon_state = "shit"

/turf/ground



/turf/ground/grass
	icon_state = "grass"

/turf/ground/grass

/turf/ground/asphalt
	icon_state = "asphalt"

/turf/ground/asphalt

/turf/ground/New()

























	dir = pick(1, 2, 8, 4)

/turf/rock
	density = 1
	opacity = 1
	icon = 'Wall.dmi'
	name = "spatial pocket edge"
	icon_state = "rock"
	alticon = "rock2"
	airtight = 1
	desc = "Impassable even by spirits, this thing can be destroyed somehow, however."

/turf/rock
/turf/rock/New()
	dir = pick(1, 2, 8, 4)

/turf/rock/edge
	bombable = 0
	name = "spatial pocket uberedge"
	icon_state = "rock_start"
	desc = "This things is impassable even by spirits and invulnerable even to the explosions!"
/turf/rock/Enter(mob/M)

	return

/turf/floor/New()


	if(src.icon_vars)
		src.icon_state = "[src.icon_state][rand(0, src.icon_vars)]"
/turf/floor/air
	icon_state = "airfloor"
/turf/floor/hellish{name = "Hellish floor"; icon_state = "hfloor1"; alticon = "ghell"}
/turf/floor/hellish/New()


	icon_state = "hfloor[rand(1, 11)]"
	..()


/turf/floor/regular
	name = "Floor"
	icon_state = "common_old"
	alticon = "generic1"

/turf/floor/regular


/turf/floor/start
	icon = 'start.dmi'
	bombable = 0
	name = "Arrival teleport"

/turf/floor/start

/turf/floor/capstart
	name = "Floor"
	icon_state = "red_secure"

/turf/floor/capstart

/turf/floor/fucked
	icon_state = "fucked"
	name = "Damaged floor"

/turf/floor/fucked

/turf/floor/icy
	name = "Icy floor"
	icon_state = "icy"
/turf/floor/icy
/turf/floor/icy/New()
	dir = pick(1, 2, 8, 4)

/turf/floor/icy/Entered(atom/movable/A)

	..()

	if(A:spacetravel && (A:y == 1 || (A:y == 85 || (A:x == 1 || A:x == 85))))

		var/L = list()

		for(var/obj/landmark/asteroidovo/ASS in world)
			L += ASS

		if(L:len)
			if(istype(A, /mob/ghost))
				return
			var/SP = pick(L)
			A:loc = SP:loc
			if(istype(A, /mob))
				var/M = A
				M << "\red Where the fuck am I?"


/turf/floor/base
	name = "station base"
	icon_state = "base"
	alticon = "gbase"

/turf/floor/base
/turf/floor/attack_by(obj/I)
	if(!I)
		return
	if(!src.bombable)
		usr << "\red It is too tough to be cutten apart!"
		return
	else
		if(istype(I, /obj/item/tool/torch) && (I:charges > 0 && (!istype(src, /turf/floor/base) && (!istype(src, /turf/floor/start) && !istype(src, /turf/floor/icy)))))
			usr << "\blue Now cutting floor cover..."
			var/oldloc = usr.loc
			spawn(50)
				if(usr.loc == oldloc && usr.item == I)
					usr << "\blue You cut floor cover apart."
					I:fuel(-1)
					if(src.abyss_native)
						spawn(0) src.spacize(src)
					else
						spawn(0) new /turf/floor/base(src)
		else
			if(istype(I, /obj/item/tool/wrench) && istype(src, /turf/floor/base))
				usr << "\blue Now deconstructing station base..."
				var/oldloc = usr.loc
				spawn(50)
					if(usr.loc == oldloc && usr.item == I)
						usr << "\blue You deconstruct station base."
						new /obj/structure/floorbase(src)
						new /obj/item/material/sheet(src)
						spawn(0) src.spacize(src)
			else
				if(istype(I, /obj/item/tool/robot/constructing_module) && I:charges > 0)

					if(usr.class != "robot")
						usr << "\red This device can only be used by robots."
						return
					else
						if(istype(src, /turf/floor/base))
							new /obj/effect/sparks(src)
							I:charges -= 1
							usr << "\blue Floor base removed."
							spawn(0) src.spacize(src)
						else
							if(!istype(src, /turf/floor/start) && !istype(src, /turf/floor/icy))
								new /obj/effect/sparks(src)
								I:charges -= 1
								usr << "\blue Floor covering removed."
								spawn(0) new /turf/floor/base(src)
				else

					..()

/turf/proc/spacize()
	if(src.z == 7 || src.z == 2)
		new /turf/space/red(src)
	else
		new /turf/space(src)

/turf/wall
	density = 1
	opacity = 1
	icon = 'Wall.dmi'
	name = "metal wall"
	alticon = "wall1"
	airtight = 1
	icon_state = "graymetal"
	var/deconstruct = 0
	var/removable = 1
	var/basecolor = "gray"
	var/material = /obj/item/material/sheet
/turf/wall
/turf/wall/hell
	basecolor = "blue"
	name = "infernal wall"
	icon_state = "hell1"
/turf/wall/hell
/turf/wall/hell/New()
	icon_state = "hell[rand(1, 31)]"
	..()

/turf/space
	icon = 'floor.dmi'
	icon_state = "space"
	alticon = "generic_space"

/turf/space



/turf/space/New()









	..()
	sd_lumcount = 7
	sd_LumUpdate()

	dir = pick(1, 2, 8, 4, 9, 5, 10, 6)
/turf/space/attack_by(obj/I)
	if(istype(I, /obj/item/material/rod))
		for(var/obj/structure/floorbase/F in src)
			if(F)
				return
		spawn(0)
			usr << "\blue Now constructing frame for floor base..."
			var/oldloc = usr.loc
			spawn(50)
				if(usr.loc == oldloc && usr.item == I)
					for(var/obj/structure/floorbase/F in src)
						if(F)
							return
					usr << "\blue You construct frame for floor base."
					new /obj/structure/floorbase(src)
					var/M = I
					M:changecharge(-1)
	else
		..()


/turf/space/Entered(atom/movable/A)
	..()

	if(A:spacetravel && (A:y == 1 || (A:y == world.maxy || (A:x == 1 || A:x == world.maxx))))

		var/L = list()

		for(var/obj/landmark/spacespawn/S in world)
			L += S

		if(L:len)
			if(istype(A, /mob/ghost))
				return
			var/SP = pick(L)
			A:loc = SP:loc
			if(istype(A, /mob))
				var/M = A
				M << "\red Where the fuck am I?"
	else
		var/atom_d = 0
		for(var/atom/movable/M in src)
			M.Cross(A)
			if(M.density)
				atom_d = 1
		if(atom_d && A:density)
			return 0
		else
			return 1


/turf/space/warp_beacon
	desc = "A mysterious structure, floating in space"
	icon_state = "warp"
/turf/space/red
	name = "???"
	icon_state = "space_deep"
	desc = "It glowls eerily."
/turf/proc/check_density()




	var/denshui = 1
	for(var/atom/movable/A in src)
		if(A.density)
			denshui = 0
	spawn(0) return denshui

/turf/wall/brick
	icon_state = "brick"
	name = "brick wall"
	alticon = "brick1"

/turf/wall/brick


/turf/wall/attack_by(obj/I)






	if(usr.dead == 0)

		if(usr in range(1, src))

			if(istype(I, /obj/item/tool/robot/constructing_module) && I:charges > 2)
				if(usr.class != "robot")
					usr << "\red This device can only be used by robots."
					return
				if(src.removable)
					new /obj/effect/sparks(src)
					remove()
					I:charges -= 3
					usr << "\blue Wall covering removed."
					return
				else
					src << "\red This wall is too tough for your module!"
			else
				if(!istype(src, /turf/wall/brick))

					if((istype(I, /obj/item/weapon/battleaxe/proton) || (istype(I, /obj/item/weapon/battleaxe/abyss) || (istype(I, /obj/item/tool/hydraulic_cutters) || istype(I, /obj/item/tool/torch) && I:charges > 1))) && src.deconstruct == 0)
						if(src.removable)
							for(var/mob/M in view(5, usr))
								M << "\red \bold [usr] begins to cut the [src] apart!"
							src.deconstruct = 1
							spawn(200)
								if(src)
									src.deconstruct = 0
									for(var/obj/item/A in usr)
										if((istype(A, /obj/item/weapon/battleaxe/proton) || (istype(A, /obj/item/tool/hydraulic_cutters) || istype(A, /obj/item/tool/torch) && A.charges > 1)) && usr in range(1, src))
											usr << "\blue You cut the wall cover apart."
											src.remove()
											if(istype(A, /obj/item/tool/torch))
												spawn(0) I:fuel(-2)
						else
							usr << "\red This wall is too tough for removing!"
				else

					if(src.deconstruct == 0 && (istype(usr.item, /obj/item/weapon/battleaxe/proton) || (istype(usr.item, /obj/item/tool/hammer) || istype(usr.item, /obj/item/tool/axe))))
						for(var/mob/M in view(5, usr))
						usr << "\red \bold [usr] begins to smash [src] with [usr.item]!"
						src.deconstruct = 1
						spawn(150)
							if(src)
								src.deconstruct = 0
								if((istype(usr.item, /obj/item/weapon/battleaxe/proton) || (istype(usr.item, /obj/item/tool/hammer) || istype(usr.item, /obj/item/tool/axe))) && usr in range(1, src))
									usr << "\blue You smash the wall down."
									src.remove()
		if(usr.item == /obj/item/tool/airmeter)
			src.airscan()
		..()

/turf/wall/proc/remove()
	if(istype(src, /turf/wall/brick))
		new /obj/structure/reinforcement/wooden(src)
		new /turf/floor/regular(src)
	else
		var/AW = new /obj/structure/reinforcement/afterwall(src)
		AW:icon_state = src:basecolor
		new src.material(src)
		new /turf/floor/base(src)

/turf/wall/proc/remove_without_mat()

	if(istype(src, /turf/wall/brick))
		new /obj/structure/reinforcement/wooden(src)
		new /turf/floor/regular(src)
	else
		var/A = new /obj/structure/reinforcement/afterwall(src)
		A:icon_state = src:basecolor
		new /turf/floor/base(src)

/obj/item/diamond
	market_price = 100
	sharp = 1
	dmg = 6
	accu = 100
	beltable = 1
	icon_state = "bone opal"
	desc = "A piece shi-i-i-iny stuff. Can be used as a supply cartridge. Also, it is very sharp."

/obj/item/diamond

/obj/item/diamond/New()


	var/kamen = pick("emerald", "ruby", "pink garnet", "bone opal")
	switch(kamen)
		if("emerald")
			icon_state = "emerald"
			market_price = 550
		if("ruby")
			icon_state = "ruby"
			market_price = 300
		if("pink garnet")
			icon_state = "opal"
			market_price = 200
		if("bone opal")
			icon_state = "diamond"
	name = kamen
/obj/item/diamond/attack_by(obj/I)
	if(istype(I, /obj/item/electronics/targeting))
		usr << "\blue You connect your targeting system to the gem."
		new /obj/item/electronics/blaster_raw(usr.loc)
		spawn(0)
			usr.delitem()
			spawn(0) del(src)
	else
		..()
/obj/item/diamond/opal
	name = "bone opal"
	icon_state = "diamond"
/obj/item/diamond/opal
/obj/item/diamond/opal/New()
	src.show_message("/green Oh, the gem!")


/turf/ice
	density = 1
	opacity = 1
	icon = 'Wall.dmi'
	icon_state = "ice"
	name = "Ice"
	var/ore
	var/simple = 1
	var/hepe = 10
	alticon = "rock1"
	airtight = 1

/turf/ice

/turf/ice/empty
	simple = 0

/turf/ice/empty

/turf/ice/New()












	src.dir = pick(1, 2, 8, 4, 9, 5, 10, 6)
	src.hepe = pick(4, 5, 6, 7, 8)
	if(src.simple)
		if(prob(10))
			new /turf/ice/silicon(src)
		else if(prob(15))
			new /turf/ice/iron(src)
		else if(prob(10))
			new /turf/ice/gas(src)
		else if(prob(6))
			new /turf/ice/ferro(src)
		if(prob(1))
			new /turf/ice/jewel(src)

/obj/machframe
	icon = 'grafon/structure.dmi'
	icon_state = "machine"
	var/stage = 0
	name = "machinery frame"

/obj/machframe

/obj/things

/obj
	var/closet_ok = 0


/obj/gasspawn

/obj/gasspawn/New()




























	var/i = rand(5, 10)
	for(, i > 0, i--)
		new /obj/cloud/fuel(src.loc)
	spawn(0) del(src)

/obj/jewelspawn
/obj/jewelspawn/New()
	var/i = rand(1, 5)
	for(, i < 7, i++)
		if(prob(5))
			new /obj/item/reagent_container/consumable/pill/luckstone(src.loc)
		else
			new /obj/item/diamond(src.loc)
	spawn(0) del(src)
/turf/ice/engraved
	simple = 0
	name = "=detailed= ice wall"
	desc = "Those engravings look somewhat weird."
	icon_state = "ice_detailed"
/turf/ice/engraved_good
	simple = 0
	name = "*detailed* ice wall"
	desc = "Those engravings give you creeps."
	icon_state = "ice_detailed2"
/turf/ice/iron{icon_state = "ice_iron"; name = "ice with hematite"; alticon = "rock_iron"; ore = /obj/item/ore/iron; simple = 0}
/turf/ice/ferro{icon_state = "ice_ferro"; name = "ice with ferrosilicon"; alticon = "rock_ferro"; ore = /obj/item/ore/ferro; simple = 0}
/turf/ice/silicon{icon_state = "ice_silicon"; name = "ice with silicon dyoxide"; alticon = "rock_silicon"; ore = /obj/item/ore/silicon; simple = 0}
/turf/ice/gas{icon_state = "ice_gas"; name = "ice with fuel deposit"; alticon = "rock_gas"; ore = /obj/gasspawn; simple = 0}
/turf/ice/jewel{icon_state = "ice_jewel"; name = "ice with jewels"; alticon = "rock_jewel"; ore = /obj/jewelspawn; simple = 0}
/turf/ice/attack_by(obj/I)



	if(istype(I, /obj/item/weapon/battleaxe) || istype(I, /obj/item/tool/pickaxe))
		for(var/mob/M in view(5, usr))
			M << "\blue [usr] digs through the [src]!"
		if(src.hepe > 1)
			src.hepe -= 1
			spawn(10) return
		else
			src.digout()
	else if(istype(I, /obj/item/tool/sonic_drill) || istype(I, /obj/item/tool/robot/robodrill) && I:class == usr.class)
		for(var/mob/M in hearers(usr))
			if(!M.sleeps)
				M << "\red WHEEEEW!"
		if(src.hepe > 3)
			src.hepe -= 3
			spawn(10) return
		else
			var/lucky_bastard = 0
			if(usr.profi && usr.prof in list("geologist", "Geology robot"))
				lucky_bastard += 2
			if(usr.luck)
				lucky_bastard += round(usr.luck / 33)
			src.digout(lucky_bastard)
	else
		if(istype(I, /obj/item/tool/fuel_extractor) && istype(src, /turf/ice/gas))
			if(istype(usr.belt, /obj/item/reagent_container/beaker/bucket/canister_geo))
				var/C = usr.belt
				usr << "\red DRR DRR DRR"
				var/hardrock = src.hepe
				C:add_chem("fuel", "fuel", 10, 0)
				spawn(0)
					var/empty_ice = new /turf/ice/empty(src)
					empty_ice:hepe = hardrock
					spawn(0) return
			else
				usr << "\red \bold You don't have a beltable canister on your belt!"
				return
		else
			if(istype(I, /obj/item/tool/airmeter))
				src.airscan()

/turf/ice/proc/digout(lucky = 0)
	if(src.ore)
		new src.ore(src)
		if(prob(lucky * 5))
			src.show_message("\blue \bold You're either lucky or truly skilled, but you've managed to extract twice as many minerals as usual!")
			new src.ore(src)
	else if(prob(25 + lucky))
		new /obj/item/material/ice(src)
	if(prob(1 + lucky))
		var/L = new /obj/item/reagent_container/consumable/pill/luckstone(src.loc)
		for(var/mob/M in viewers(L))
			M << "\blue \bold You've struck luckstone! Praise the geologists!"
	new /turf/floor/icy(src)
/turf
	var/mirror = 0
/obj/machine/dispenser
/obj/machine/turret
	density = 1
	var/on = 1
	desc = "A huge goddamned blaster mounted in the floor."
	icon_state = "turret_on"
	var/id = "west"
	var/robustness = 80
	var/dying = 0
/obj/machine/turret_button
	var/id = "west"
	name = "Turret (de)activation control"
	icon_state = "t_button_on"
/obj/machine/airbutton
	icon_state = "t_button_on"
	name = "air tunnel button"
/obj/machine/vendor
/obj/machine/caller_button
	name = "Purificator calling button"
	icon_state = "pbutton_off"
	var/canpress = 1
/obj/machine/smelter{density = 1; name = "Electric smelter"; icon_state = "smelter"; desc = "Стране нужны паровозы, стране нужен металл!"}
/obj/machine/smelter/attack_by(obj/item/I)

	for(var/obj/wire/battery/B in src.loc)
		if(!B || B.energy == 0)
			return
		else if(istype(I, /obj/item/ore))
			var/ORE = I
			new ORE:result(src.loc)
			spawn(0)
				B.energy -= 1
				usr.delitem()
		else if(istype(I, /obj/item/reagent_container/consumable/bumblebee_dead))
			var/beez = I
			beez:roast()
			usr << "\blue Bumblebee kebab anyone?"
			spawn(0)
				B.energy -= 1

/obj/machine/plastic_synth
	density = 1
	var/connected = 0
	var/fuel = 0
	icon_state = "plastic_synth"
	name = "plastic syntheser"
	desc = "A thing for... Uh... Making plastic."
/obj/machine/plastic_synth
	anchored = 0
/obj/machine/plastic_synth/proc/suck()
	if(src.connected == 1)
		for(var/obj/machine/gas/pipealike/pipe/connector/P in src.loc)
			if(P.fuel > 0)
				src.fuel += 3
				P.fuel -= 1
		spawn(10) src.suck()
	else
		return
/obj/machine/plastic_synth/attack_hand()
	if(!usr.candofun)
		usr << "\red NO"
		return
	if(fuel >= 5)
		usr << "\blue Beep."
		new /obj/item/material/plastic/fromgas(src.loc)
		spawn(0) fuel -= 5
	else
		usr << "\red Not enough fuel!"
/obj/machine/plastic_synth/attack_by(obj/I)
	if(istype(I, /obj/item/tool/wrench))
		if(connected == 0)
			for(var/obj/machine/gas/pipealike/pipe/connector/P in src.loc)
				if(P)
					usr << "\blue You connect [src] to port."
					connected = 1
					anchored = 1
					src.break_pull()
					spawn(10) suck()
	if(istype(I, /obj/item/reagent_container/beaker))
		var/B = I
		for(var/datum/reagent/RE in B:reagent_list)
			if(RE.id == "fuel" && RE.amount >= 1)
				fuel += round(RE.amount)
				usr << "\blue You transfer [round(RE.amount)] of [RE.name] to the [name]"
				B:remove_chem(RE.id, round(RE.amount))
	else
		if(istype(I, /obj/item/tool/airmeter))
			usr << "\blue Current amount of fuel avaible: [fuel]."

/obj/item/ore
	dmg = 8
	beltable = 1
	var/obj/result = null

/obj/item/ore
