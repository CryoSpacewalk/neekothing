/obj/structure
	icon = 'grafon/structure.dmi'
	var/hardcore = 1
	var/killed = 0
/obj/structure/window
	density = 1
	icon = 'grafon/window.dmi'
	icon_state = "basic"
	alticon = "gbasic"
	fsticon = "basic"
	hardcore = 8
	wrenchable = 1
/obj/structure/window
/obj/structure/window/thin
	hardcore = 4
	name = "glass pannel"
	icon_state = "thin"
/obj/structure/window/New()
	var/T = src.loc
	spawn(1)
		T:airtight = 1
	return

/obj/structure/window/thrown_at_with(atom/A, speed)
	if(ismob(A) && speed >= 4)
		src.damage(10)

/obj/structure/window/attack_by(obj/I)





	if(usr.dead == 0 && src in range(1, usr))
		if(usr.item == null)
			usr << "\blue You knock to the [src.name]."
			for(var/mob/M in view(src))
				M << "\blue [usr] knocks to the [src.name]."
			if(prob(5))
				usr << "You damage [src] a bit."
				damage(1)
		else if(istype(usr.item, /obj/item/tool/airmeter))
			var/T = src.loc
			T:airscan()
		else
			usr << "\red You smash the [src.name] with your [usr.item]!"
			for(var/mob/M in view(src))
				M << "\red [usr] smashes the [src.name] with his [usr.item]!"

			if((usr.profi && usr.prof in prof_engi) || istype(usr.item, /obj/item/tool/torch))
				usr << "\red \bold You remove the window."
				new /obj/item/material/glass(src.loc)
				spawn(1)
					var/T = src.loc
					T:airtight = 0
					spawn(0)
						del(src)
						return
			else
				if(prob(round(I:accu) + I:dmg + usr.brutality * 3 + round(usr.luck / 2)))
					if(I:dmg > 0)
						src.damage(round(I:dmg / 2) + round(I:dmg * usr.brutality / 10) + 3)
						usr << "\red \bold You give the [src.name] serious damage!"
						if(!(/obj/overlay/structure/windamage in overlays))
							var/W = new /obj/overlay/structure/windamage(src)
							overlays += W
					else if(prob(10 + usr.brutality * 5))
						usr << "You damage [src] a bit."
						damage(pick(1, 2))
				else
					if(prob(10 + I:dmg + usr.brutality * 5))
						usr << "You damage [src] a bit."
						damage(rand(1, 3))

/obj/structure/reinforcement
	density = 1
	name = "Steel grille"
	icon_state = "grille"
	alticon = "ggrille"
	hardcore = 25
	wrenchable = 1
/obj/structure/reinforcement

/obj/structure/reinforcement/attack_hand()








	if(!usr.candofun)
		usr << "\red NO"
		return
	usr << "You kick the grille."
	if(prob(5 + round(usr.luck / 2)))
		usr << "You kick out some of the grille's rods!"
		var/bonus_dmg = 0
		if((usr.profi && usr.prof) in prof_engi)
			bonus_dmg += 2
		if(usr.empowered)
			bonus_dmg += usr.empowered * 2
		if(usr.brutality)
			bonus_dmg += usr.brutality
		src.damage(max(1, bonus_dmg))

/obj/structure/reinforcement/attack_by(obj/I)

	if(usr.dead == 0)
		if(usr in range(1, src))

			var/bonus_dmg = 0
			if(usr.profi && usr.prof in prof_engi)
				bonus_dmg += 5
			if(usr.empowered)
				bonus_dmg += usr.empowered * 2
			if(usr.brutality)
				bonus_dmg += usr.brutality
			if(usr.euphoria)
				bonus_dmg += round(usr.euphoria / 30)


			if(istype(src, /obj/structure/reinforcement/weak/barricade) && istype(usr.item, /obj/item/material/rod))
				usr << "Now reinforcing barricade..."
				var/oldloc = usr.loc
				if(usr.profi && usr.prof in prof_engi)
					sleep(10)
				else
					sleep(50)
				if(usr.loc == oldloc && usr.item == I)
					src.name = "Iron grille"
					src.icon_state = "weakgrille"
					src.alticon = "gweakgrille"
					src.hardcore += 10
					var/M = I
					M:changecharge(-1)
					return
			if(istype(src, /obj/structure/reinforcement/wooden/barricade) && istype(usr.item, /obj/item/material/board))
				usr << "Now reinforcing barricade..."
				var/oldloc = usr.loc
				if(usr.profi && usr.prof in prof_engi)
					sleep(10)
				else
					sleep(50)
				if(usr.loc == oldloc && usr.item == I)
					src.name = "Wooden grille"
					icon_state = "woodgrille"
					alticon = "gwoodgrille"
					hardcore = 6
					var/M = I
					M:changecharge(-1)
					return
			if(istype(src, /obj/structure/reinforcement/weak) && (istype(usr.item, /obj/item/material/sheet) || istype(usr.item, /obj/item/material/plastic)))
				usr << "Now reinforcing grille..."
				var/oldloc = usr.loc

				var/tospawn

				if(usr.profi && usr.prof in prof_engi)
					tospawn = 10
				else
					tospawn = 50

				spawn(tospawn) if(usr.loc == oldloc && usr.item == I)
					new /obj/structure/reinforcement(src.loc)
					var/M = I
					M:changecharge(-1)
					sleep(0)
					del(src)
					return
			else if(istype(src, /obj/structure/reinforcement/afterwall) && istype(I, /obj/item/material/sheet))
				usr << "Now finishing the wall..."
				var/oldloc = usr.loc

				var/tospawn

				if(usr.profi && usr.prof in prof_engi)
					tospawn = 10
				else
					tospawn = 50

				spawn(tospawn) if(usr.loc == oldloc && usr.item == I)
					var/M = I
					M:changecharge(-1)
					var/W = new /turf/wall(src.loc)
					W:icon_state = src.icon_state
					sleep(0)
					del(src)
					return
			else if(istype(src, /obj/structure/reinforcement/afterwall) && istype(I, /obj/item/tool/wrench))
				usr.processing = 1
				usr << "\blue Now removing wall base..."

				var/tospawn

				if(usr.profi && usr.prof in prof_engi)
					tospawn = 5
				else
					tospawn = 15

				spawn(tospawn)
					usr.processing = 0
					if(usr in range(1, src) && usr.item == I)
						usr << "\blue You deconstruct [src]."
						new /obj/item/material/wallbase(src.loc)
						sleep(0)
						del(src)
						return
			else

				if(I:sharp)

					usr << "You attack the grille!"
					if(prob(30 + round(I:accu / 2) + round(I:dmg / 5) + round(I:groovy / 3) + usr.brutality * 2))
						usr << "You cut out some of the grille's rods!"
						damage(rand(2, 4) + round(I:dmg / 2) + round(I:groovy / 4) + bonus_dmg)
					else
						usr << "You scratch grille a bit."
						damage(rand(1, 5) + round(bonus_dmg / 2))
				else if(prob(20 + usr.brutality * 1.5 + round(I:dmg / 8) + I:groovy / 3 + bonus_dmg))
					usr << "You attack the grille!"
					usr << "You manage to damage some of the grille's rods!"
					damage(rand(1, 3) + round(I:dmg / 3) + round(I:groovy / 3) + bonus_dmg)
				else
					usr << "You scratch grille a bit."
					damage(rand(1, 3))
	else
		usr << "Ghosts cannot into breaking stuff!"

/obj/structure/proc/damage(damamount)






























	if(src.hardcore > damamount)
		src.hardcore -= damamount
	else
		src.icon_state = "[icon_state]_broken"
		src.fsticon = "[icon_state]_broken"
		src.alticon = "[alticon]_broken"
		src.density = 0
		if(src.killed == 0)
			src.name = "[src.name]'s remains"
		if(istype(src, /obj/structure/window))
			var/T = src.loc
			spawn(1)
				T:airtight = 0
			src.playsound('sounds/window_break.ogg')
			spawn(0)
				for(var/obj/overlay/structure/windamage/W in contents)
					src.overlays -= W
				for(var/obj/structure/window/W in T)
					if(W.killed == 0 && !(src == W))
						T:airtight = 1
				for(var/obj/structure/montage_foam/F in T)
					if(F)
						T:airtight = 1
				for(var/obj/door/D in T)
					if(D.fucked == 0 && D.closed == 1)
						T:airtight = 1
		src.killed = 1
		return

/obj/structure/proc/burn_damage(damamount)
	if(src.hardcore > damamount)
		src.hardcore -= damamount
	else
		src.icon_state = "[icon_state]_burnt"
		src.fsticon = "[icon_state]_burnt"
		src.alticon = "[alticon]_broken"
		src.density = 0
		if(src.killed == 0)
			src.name = "[src.name]'s burned remains"
		src.killed = 1
		return

/obj/machine/dispenser
	density = 1
	name = "One-way tank storage unit"
	icon_state = "dispenser"
	var/empty = 10
	var/fuel = 10
	var/tox = 5
	var/anti = 5
	var/regen = 0





	var/tanks = list("empty", "fuel", "toxin", "antidote")
/obj/machine/dispenser/operate(obj/W)
	if(W:energy > 0)
		W:energy -= 1
		src.attack_hand()
	else
		usr << "\red Not enough energy!"
		return

/obj/machine/dispenser/proc/dispense()
	if(!usr.candofun)
		usr << "\red NO"
		return
	var/tank = input("Select the tank to dispense.", "Tank type:", "empty") in tanks
	switch(tank)
		if("empty")
			if(empty > 0)
				empty -= 1
				new /obj/item/gas/tank(src.loc)
		if("toxin")
			if(tox > 0)
				tox -= 1
				new /obj/item/gas/tank/toxin(src.loc)
		if("antidote")
			if(anti > 0)
				anti -= 1
				new /obj/item/gas/tank/antidote(src.loc)
		if("fuel")
			if(fuel > 0)
				fuel -= 1
				new /obj/item/gas/tank/fuel(src.loc)
		if("regenerite")
			if(regen > 0)
				regen -= 1
				new /obj/item/gas/tank/regenerite(src.loc)

/obj/machine/dispenser/Click()
	if(!usr.candofun)
		usr << "\red NO"
		return
	if(usr in range(1, src))
		src.dispense()

/obj/machine/dispenser/medical
	empty = 1
	fuel = 0
	tox = 1
	anti = 5
	regen = 5


	tanks = list("empty", "antidote", "toxin", "regenerite")
	name = "Medical tank storage unit"
	icon_state = "dispenser_med"
/obj/machframe/attack_by(obj/item/I)




	if(usr.processing == 0)
		if(src.stage == 0 && istype(I, /obj/item/cable))
			usr.processing = 1
			usr << "\blue Now wiring up the frame..."
			spawn(20)
				usr.processing = 0
				src.stage = 1
				src.icon_state = "machine_wired"
				var/CB = I
				CB:cminus(1)
				return
		else if(src.stage == 0 && istype(I, /obj/item/tool/wrench))
			usr.processing = 1
			usr << "\blue Now deconstructing the frame..."
			spawn(20)
				usr.processing = 0
				new /obj/item/material/machine(src.loc)
				spawn(0) del(src)
		else if(src.stage == 1 && (istype(I, /obj/item/tool/wirecutters) || istype(I, /obj/item/tool/hydraulic_cutters)))
			src.stage = 0
			src.icon_state = "machine"
			var/CB = new /obj/item/cable(loc)
			CB:cminus(9)
			return
		else if(src.stage == 1 && istype(I, /obj/item/material/silicon))
			usr.processing = 1
			usr << "\blue Now finishing solar pannel..."
			spawn(20)
				usr.processing = 0
				new /obj/machine/solar(src.loc)
				var/M = I
				M:changecharge(-1)
				del(src)
				return
		else if(src.stage == 1 && (istype(I, /obj/item/tool/wirecutters) || istype(I, /obj/item/tool/hydraulic_cutters)))
			usr.processing = 1
			usr << "\blue Now cutting wiring..."
			spawn(20)
				usr.processing = 0
				var/CB = new /obj/item/cable(src.loc)
				CB:cminus(9)
				src.stage = 0
				src.icon_state = "machine"
				return
		else if(src.stage == 1 && istype(I, /obj/item/material/core))
			usr << "\blue You install [I] inside your construction."
			src.stage = 2
			src.icon_state = "machine_cored"
			spawn(0) del(I)
		else if(src.stage == 2 && istype(I, /obj/item/material/plastic))
			usr.processing = 1
			usr << "\blue Now finishing power storage unit..."
			spawn(20)
				usr.processing = 0
				new /obj/structure/battery(src.loc)
				spawn(0)
					var/M = I
					M:changecharge(-1)
					spawn(0) del(src)
		else if(src.stage == 1 && istype(I, /obj/item/electronics/jetbike))
			usr.processing = 1
			usr << "\blue Now finishing your jetbike..."
			spawn(20)
				usr.processing = 0
				new /obj/bike/jetbike(src.loc)
				spawn(0)
					del(I)
					spawn(0) del(src)
		else if(src.stage == 0 && istype(I, /obj/item/electronics/jetbike))
			usr << "\red \bold Wire your machine frame first, you idiot!"

/obj/machframe/attack_hand()

	if(src.stage == 2)
		usr << "\blue You remove the core from [src]."
		src.stage = 1
		src.icon_state = "machine_wired"
		new /obj/item/material/core(loc)

/obj/things/suitstorage
	density = 1
	icon = 'grafon/structure.dmi'
	icon_state = "spacesuit"
	name = "space suit stand"
	var/emptystate = "spacesuit_empty"
	var/openstate = "spacesuit_open"
	var/locked = 1
	var/content = /obj/item/clothes/space/gagarin
	var/full = 1
	var/access = "EVA"
	desc = "A stand with space suit inside."

/obj/things/suitstorage



/obj/things/suitstorage/attack_hand()
	if(src.locked == 1)
		for(var/obj/item/key/K in usr)
			if(src.access == null || (src.access in K.access))
				usr << "\blue You unlock the [src]."
				src.locked = 0
				src.icon_state = src:openstate
	else if(src.full == 1)
		usr << "\blue You remove the suit from the stand."
		src.full = 0
		new content(src.loc)
		src.icon_state = src.emptystate

/obj/effect/blood_spring
	icon = null /*icon id 73: unresolved*/
	icon = 'grafon/effects/chemistry.dmi'
	name = "blood spring"
	icon_state = "blood_spring"

/obj/effect/blood_spring

/obj/effect/target
	icon_state = "target"

/obj/effect/target

/obj/effect/target/New()
	spawn(5) del(src)


/obj/machine/turret/abyss
	density = 0
	id = "abyss"
	robustness = 30
	name = "distorted turret"
	desc = "Some truly fucked up piece of machinery."
	icon_state = "turret_abyss"
/obj/machine/turret/abyss
/obj/machine/turret/New()
	src.aggro()
/obj/machine/turret/proc/aggro()
	if(src.on == 1)
		var/LS = list()
		for(var/mob/M in hearers(src))
			if(!istype(M, /mob/ghost))
				LS += M
		if(LS:len)
			for(var/mob/M in LS)
				if(M.x > src.x && M.y > src.y)
					src.dir = 5
				else if(M.x < src.x && M.y < src.y)
					src.dir = 10
				else if(M.x < src.x && M.y > src.y)
					src.dir = 9
				else if(M.x > src.x && M.y < src.y)
					src.dir = 6
				else if(M.x > src.x && M.y == src.y)
					src.dir = 4
				else if(M.x < src.x && M.y == src.y)
					src.dir = 8
				else if(M.x == src.x && M.y > src.y)
					src.dir = 1
				else if(M.x == src.x && M.y < src.y)
					src.dir = 2
				var/L = new /obj/lazor(src.loc)
				new /obj/effect/target(M.loc)
				L:target_x = M.x - src.x
				L:target_y = M.y - src.y
				L:process()
	spawn(30) src.aggro()


/obj/machine/turret/attack_by(obj/I)






	for(var/mob/M in view(src))
		M << "\red [usr] hits [src] with [I]!"
	if(istype(I, /obj/item/device/consolehack))
		for(var/i = 0, i < 5, i++)
			new /obj/item/debris/machine(locate(src.x + pick(1, 0, -1), src.y + pick(1, 0, -1), src.z))
		for(var/mob/M in view(src))
			M << "\red Boom!"
		src.explosion(0.5)
		spawn(0) del(src)
	else if(src:robustness > I:dmg)
		src:robustness -= I:dmg
	else if(src.dying == 0)
		for(var/i = 0, i < 5, i++)
			new /obj/item/debris/machine(locate(src.x + pick(1, 0, -1), src.y + pick(1, 0, -1), src.z))
		src.dying = 1
		if(prob(50))
			for(var/mob/M in hearers(src))
				if(!M.sleeps)
					M << "\red Boom!"
			src.explosion(0.5)
		spawn(0) del(src)



/obj/machine/turret_button/attack_hand()








	for(var/obj/machine/turret/T in world)
		if(T.id == src.id)
			if(T.on == 1)
				T.on = 0
				T.icon_state = "turret_off"
				src.icon_state = "t_button_off"
			else
				T.on = 1
				T.icon_state = "turret_on"
				src.icon_state = "t_button_on"

/obj/structure/container
	density = 1
	icon = 'grafon/containers.dmi'
	name = "closet"
	desc = "A container for holding stuff."
	icon_state = "container"
	alticon = "container1"
	anchored = 0
	var/alticon_open = "container_open1"
	var/alticon_closed = "container1"
	var/iconopen = "container_open"
	var/iconclosed = "container"
	var/welded = 0
	var/hold_mobs = 1
	var/opened = 0
/obj/structure/container

/obj/structure/container/New()








	fsticon = icon_state
/obj/structure/container/proc/opclose()
	switch(src.opened)
		if(0)
			src.opened = 1
			if(src.hold_mobs == 1)
				src.density = 0
			src.icon_state = src.iconopen
			src.alticon = src.alticon_open
			src.fsticon = src.iconopen
			if(contents:len)
				for(var/obj/A in src.contents)
					A.loc = src.loc
					src.contents -= A
				for(var/mob/A in src.contents)
					A.loc = src.loc
					src.contents -= A
		if(1)

			src.density = 1
			src.opened = 0
			src.icon_state = src.iconclosed
			src.alticon = src.alticon_closed
			src.fsticon = src.iconclosed
			for(var/obj/A in loc)
				if(A.closet_ok)
					A.loc = src
			if(src.hold_mobs == 1)
				for(var/mob/M in loc)
					M.loc = src
/obj/structure/container/attack_hand()
	if(src.welded == 0)
		src.opclose()
	else
		usr << "\red It is welded shut!"
/obj/structure/container/New()
	alticon_closed = alticon
	spawn(2)
		for(var/obj/I in loc)
			if(I.closet_ok)
				I.loc = src
/obj/structure/container/attack_by(obj/I)
	if(src:opened == 0 && (istype(I, /obj/item/tool/torch) && I:charges > 0))
		switch(src.welded)
			if(1)
				usr << "\blue You unweld [src]."
				for(var/mob/M in view(src))
					M << "\blue [usr] unwelds [src]."
				src.welded = 0
			else
				usr << "\blue You weld [src]."
				for(var/mob/M in view(src))
					M << "\red [usr] welds [src]."
				src.welded = 1
		I:fuel(-1)
	else if(src.density == 1 && src.opened == 1)
		spawn(0)
			usr.dropitem()
			I:loc = src.loc
/obj/structure/container/science
	icon_state = "science"
	name = "research division container"
	iconopen = "science_open"
	iconclosed = "science"
	alticon = "science1"
	alticon_open = "science_open1"
	hold_mobs = 0

/obj/structure/container/science

/obj/structure/container/crate
	icon_state = "crate"
	name = "crate"
	iconopen = "crate_open"
	iconclosed = "crate"
	alticon = "crate1"
	alticon_open = "crate_open1"
	hold_mobs = 0

/obj/structure/container/crate


/obj/structure/container/cabinet
	icon_state = "cabinet"
	name = "cabinet"
	iconopen = "cabinet_open"
	iconclosed = "cabinet"
	alticon = "cabinet1"
	alticon_open = "cabinet_open1"
	hold_mobs = 0

/obj/structure/container/cabinet


/obj/structure/container/fire
	icon_state = "fire"
	name = "firefighter's closet"
	iconopen = "fire_open"
	iconclosed = "fire"
	alticon = "fire1"
	alticon_open = "fire_open1"

/obj/structure/container/fire



/obj/structure/container/fire/New()













	contents.Add(new /obj/item/extinguisher())
	if(prob(50))
		contents.Add(new /obj/item/extinguisher())
	if(prob(33))
		contents.Add(new /obj/item/extinguisher())
	if(prob(66))
		contents.Add(new /obj/item/clothes/fire())
	if(prob(50))
		contents.Add(new /obj/item/tool/hammer())
/obj/structure/container/emergency
	name = "emergency closet"
	icon_state = "emergency"
	iconopen = "emergency_open"
	iconclosed = "emergency"
	alticon = "emergency1"
	alticon_open = "emergency_open1"
/obj/structure/container/emergency
/obj/structure/container/emergency/New()
	contents.Add(new /obj/item/medical/bandage/single())
	if(prob(66))
		contents.Add(new /obj/item/reagent_container/syringe/trank())
	if(prob(66))
		contents.Add(new /obj/item/reagent_container/beaker/tiny/iodine())
	if(prob(66))
		contents.Add(new /obj/item/reagent_container/syringe/emergency())
	if(prob(50))
		contents.Add(new /obj/item/medical/bodyscan())
	if(prob(33))
		contents.Add(new /obj/item/extinguisher())
	if(prob(20))
		contents.Add(new /obj/item/device/brainport/radio())
	if(prob(20))
		contents.Add(new /obj/item/tool/hammer())


/obj/structure/floorbase
	layer = 2
	name = "floor frame"
	icon_state = "floorbase"
	bomb_proof = 15
	alticon = "gfloorbase"
/obj/structure/floorbase

/obj/structure/floorbase/attack_by(obj/I)

	if(istype(I, /obj/item/tool/axe) || (istype(I, /obj/item/tool/hydraulic_cutters) || (ispath(I, /obj/item/weapon/battleaxe) || (istype(I, /obj/item/tool/robot/robosaw) || istype(I, /obj/item/tool/wirecutters) && !istype(src, /obj/structure/reinforcement/wooden)))))
		usr << "\blue You cut [src] apart."
		new /obj/item/material/rod(src.loc)
		spawn(0) del(src)
	else if(istype(I, /obj/item/material/sheet))
		usr << "Now finishing the floor..."
		var/oldloc = usr.loc
		spawn(50) if(usr.loc == oldloc && (istype(usr.item, /obj/item/material/sheet) && src))
			var/M = I
			M:changecharge(-1)
			new /turf/floor/base(src.loc)
			spawn(0) del(src)


/obj/structure/airtunnel
	layer = 2
	name = "air tunnel"
	var/sort = "floor"
	icon_state = "airtunnel_floor"

/obj/structure/airtunnel
	bomb_proof = 15

/obj/structure/airtunnel/proc/construct()












	if(istype(src.loc, /turf/space))
		switch(sort)
			if("floor")
				new /turf/floor/air(src.loc)
			if("wall")
				new /turf/airwall(src.loc)
	else if(istype(src.loc, /turf/floor/air) && sort == "floor" || istype(src.loc, /turf/airwall) && sort == "wall")
		var/T = src.loc
		T:spacize()

/obj/machine/airbutton/attack_hand()



	src.icon_state = "t_button_off"
	for(var/obj/structure/airtunnel/A in range(10, src))
		A.construct()
	spawn(15) src.icon_state = "t_button_on"
/obj/machine/airbutton/operate(obj/W)
	if(W:energy > 0)
		W:energy -= 1
		src.attack_hand()
	else
		usr << "\red Not enough energy!"
		return

/obj/machine/vendor
	density = 1
	var/hacked = 0
	name = "Goods dispenser"
	desc = "A machine for dispensing misc useful in spaceman's damned tough life crap."
	icon_state = "vend_default"
	bomb_proof = 50
	alticon = "gvend_default"
	var/default_crap = "donut"






	var/items = list(/obj/item/reagent_container/consumable/donut, /obj/item/reagent_container/beaker/bottle/beer, /obj/item/extinguisher)
	var/list/item_names = list("donut", "jigulevskoe beer", "fire extinguisher", "cancel")
	var/amts = list(7, 5, 1)
	var/items_secret = list(/obj/item/reagent_container/beaker/bottle/tuborg)
	var/item_names_secret = list("spess tuborg beer")
	var/amts_secret = list(5)
/obj/machine/vendor/attack_by(obj/I)
	if(istype(I, /obj/item/device/consolehack) && !src.hacked)
		src.hack(usr)
	if(istype(I, /obj/item/tool/pulse) && I:charges)
		if(prob(23 + usr.luck - usr.thrill + usr.energyprotect) && !("chromosome" in usr.mutations))
			I:charges--
			usr << "\blue You successfully burn out secure wires, allowing public access to special supplies."
			src.hack(usr)
		else
			I:charges--
			usr << "\red \bold You try to hack [src.name], but your [I:name] slips to the power supply wire, shocking you!"
			if(usr.energyprotect < 7)
				usr.stun(10)
				usr.damaga(5, "burn")
				usr.torment(3)
				if(prob(50))
					usr.epilepsy += 2
			else
				usr.stun(2)
				usr.damaga(2, "burn")

/obj/machine/vendor/attack_hand()
	var/target_item = input("", "", default_crap) in item_names


	if(target_item == "cancel")
		return
	var/itemnum = item_names.Find(target_item, 0, item_names.len)
	if(amts[itemnum] > 0)
		var/I = items[itemnum]
		new I(src.loc)
		spawn(0) amts[itemnum] -= 1
	else
		usr << "\red Sorry, out of stocks!"
/obj/machine/vendor/proc/hack(mob/M)
	M << "\red Special supplies are now avaible."
	spawn(0)
		src.hacked = 1
		src:items:Insert(src:items:len + 1, src.items_secret)
		src:item_names:Insert(src:item_names:len, src.item_names_secret)
		src:amts:Insert(src:amts:len + 1, src.amts_secret)

/obj/structure/montage_foam
	density = 1
	opacity = 1
	icon_state = "foam"
	var/hepe = 10
	var/amt = 0
	alticon = "gfoam"
	bomb_proof = 4
	wrenchable = 1
/obj/structure/montage_foam


/obj/machine/vendor/booze
	name = "Alcohol dispenser"
	desc = "A very important dispenser."
	icon_state = "vend_booze"
	alticon = "gvend_booze"
	default_crap = "jigulevskoe beer"


































	items = list(/obj/item/reagent_container/beaker/bottle/beer, /obj/item/reagent_container/beaker/bottle/large/vodka, /obj/item/reagent_container/beaker/glass)
	item_names = list("beer", "vodka", "empty glass", "cancel")
	amts = list(5, 1, 5)
	items_secret = list(/obj/item/reagent_container/beaker/bottle/tuborg, /obj/item/reagent_container/beaker/bottle/large/tri_semerki, /obj/item/reagent_container/beaker/bottle/toxin, /obj/item/reagent_container/beaker/glass/absenth, /obj/item/reagent_container/beaker/bottle/titbit)
	amts_secret = list(5, 2, 2, 2, 1)
	item_names_secret = list("spess tuborg beer", "Three Axes special wine supply", "toxin", "Absenth", "Nuclear Titbit can")
/obj/machine/vendor/food
	name = "Food supply dispenser"
	desc = "An important dispenser, second after booze vendomat."
	icon_state = "vend_food"
	alticon = "gvend_food"
	default_crap = "donut"

	items = list(/obj/item/reagent_container/consumable/bread, /obj/item/reagent_container/consumable/donut, /obj/item/reagent_container/consumable/chicken)
	item_names = list("bread", "donut", "rooster leg", "cancel")
	amts = list(6, 5, 4)
	items_secret = list(/obj/item/reagent_container/consumable/pill/speed, /obj/item/reagent_container/beaker/bottle/condensed_milk, /obj/item/reagent_container/consumable/tobacco/ASD)
	amts_secret = list(5, 2, 5)
	item_names_secret = list("speed-up pill", "condensed milk", "counter-mutagenic chewing gum")
/obj/machine/vendor/drink
	name = "Softdrink dispenser"
	desc = "A machine full of precious caffeine."
	icon_state = "vend_drink"
	alticon = "gvend_drink"
	default_crap = "pickaxe"

	items = list(/obj/item/reagent_container/beaker/bottle/stim, /obj/item/reagent_container/beaker/bottle/tea, /obj/item/reagent_container/consumable/tobacco/ASD)
	item_names = list("Soulstorm can", "CogniTea mug", "counter-mutagenic chewing gum", "cancel")
	amts = list(4, 4, 3)
	items_secret = list(/obj/item/reagent_container/beaker/bottle/stim2, /obj/item/reagent_container/beaker/bottle/titbit)
	amts_secret = list(3, 1)
	item_names_secret = list("Soulstorm+ can", "Nuclear Titbit can")
/obj/machine/vendor/mining
	name = "Geology bay dispenser"
	desc = "A machine stuffed with tools for shit-digging."
	icon_state = "vend_mining"
	alticon = "gvend_mining"
	default_crap = "pickaxe"

	items = list(/obj/item/tool/pickaxe, /obj/item/clothes/miner, /obj/item/clothes/space/mining)
	item_names = list("pickaxe", "geology uniform", "spacesuit", "cancel")
	amts = list(3, 2, 2)
	items_secret = list(/obj/item/tool/sonic_drill, /obj/time_bomb/quake)
	amts_secret = list(2, 1)
	item_names_secret = list("sonic drill", "M.O.P.E.D.")
/obj/machine/vendor/cigs
	density = 0
	alticon = "gvend_drink"
	default_crap = "chewing synthtobacco"





	items = list(/obj/item/blister/cigs, /obj/item/reagent_container/consumable/tobacco, /obj/item/reagent_container/syringe/injector/cigs, /obj/item/reagent_container/beaker/bottle/beer, /obj/item/reagent_container/consumable/tobacco/ASD, /obj/item/reagent_container/consumable/pill/antismoke); name = "Approved drugs dispenser";desc = "A dispenser full of drugs approved for public use, such as nicotine.";icon_state = "vend_drug"
	item_names = list("cigarette package", "chewing synthtobacco", "IV chainsmoking nicotine injector (approved as an alternative to cigarettes in USSR-4)", "jigulevskoe beer can", "counter-mutagenic chewing gum", "Smoke/stim addiction cure", "cancel")
	amts = list(5, 10, 3, 3, 3, 8, 8)
	items_secret = list(/obj/item/reagent_container/beaker/tiny/DXM, /obj/item/reagent_container/beaker/glass/absenth, /obj/item/reagent_container/beaker/bottle/titbit)
	amts_secret = list(2, 3, 1)
	item_names_secret = list("DXM crystals nickelbag", "Absenth", "Nuclear Titbit can")
/obj/machine/vendor/cure
	alticon = "gvend_drink"
	default_crap = "emergency mixture syringe"
	name = "'Cure yourself' vendor"
	desc = "Since the docs are lazy and syringes are sparce."
	icon_state = "vend_cure"



	items = list(/obj/item/reagent_container/syringe/emergency, /obj/item/reagent_container/consumable/pill/ultramix, /obj/item/reagent_container/consumable/pill/glucose, null, /obj/item/reagent_container/consumable/pill/antismoke, /obj/item/reagent_container/consumable/pill/rimantadine, /obj/item/reagent_container/consumable/pill/mercury)
	item_names = list("emergency mixture syringe", "multi-curing pill (regen, fibgen, antidote)", "glucose pill", "Smoke/stim addiction cure", "rimantadine pill (flu cure)", "mercury pill (antibiotics, toxic)", "cancel")
	amts = list(2, 1, 1, 1, 1, 1)
	items_secret = list(/obj/item/reagent_container/syringe/vint)
	amts_secret = list(3)
	item_names_secret = list("Vint!")
/obj/structure/montage_foam/New()













	spawn(0)
		var/T = src.loc
		if(T:airtight)
			spawn(0) del(src)
		else
			spawn(0)
				T:airtight = 1
			for(var/obj/door/D in src.loc)
				if(D && src)
					spawn(0) del(src)
			for(var/obj/structure/montage_foam/F in src.loc)
				if(F && (src && F != src))
					spawn(0) del(src)
			spawn(3)
				for(var/turf/U in range(1, src))
					if(src.amt && !U.airtight)
						for(var/obj/structure/montage_foam/MF in U)
							if(MF && MF != src)
								return
						spawn(0)
							var/M = new /obj/structure/montage_foam(U)
							M:amt = src.amt - 1

/obj/structure/montage_foam/attack_hand()
	if(usr.dead != 0 && src in range(1, usr))
		usr << "\red You kick the [src.name]!"
		for(var/mob/M in view(src))
			M << "\red [usr] kicks the [src.name]!"
		if(src.hepe > 1 + usr.empowered + round(usr.brutality / 3))
			src.hepe -= 1 + usr.empowered + round(usr.brutality / 3)
		else
			usr << "You clean your way."
			var/T = src.loc
			spawn(1)
				T:airtight = 0
				spawn(0) del(src)

/obj/structure/montage_foam/attack_by(obj/I)
	if(usr.dead == 0 && src in range(1, usr))
		usr << "\red You smash the [src.name] with your [usr.item]!"
		for(var/mob/M in view(src))
			M << "\red [usr] smashes the [src.name] with his [usr.item]!"
		if(src.hepe > I:dmg + round(I:dmg * usr.brutality / 5))
			src.hepe -= I:dmg + round(I:dmg * usr.brutality / 5)
		else
			usr << "You clean your way."
			var/T = src.loc
			spawn(1)
				T:airtight = 0
				spawn(0) del(src)

/client/proc/foam(turf/T)
	set name = "spawn a fucking foam"
	set category = "Pedal"
	var/F = new /obj/structure/montage_foam(T)
	F:amt = 10


/obj/machine/caller_button/attack_hand()








	var/nopuri = 1
	if(src.canpress)



		for(var/mob/M in world)
			if(M.prof == "purificator")
				nopuri = 0
				M << "<font size = 10 color = red>THE STATION NEEDS YOUR HELP</font>"

		if(nopuri)
			usr << "\red Alas, but there's no purificator on the station complex!"
		else
			src.canpress = 0
			src.icon_state = "pbutton_on"
			spawn(100)
				src.icon_state = "pbutton_off"
				src.canpress = 1
	else

		usr << "\red Purificator is already knowing what you need help!"









