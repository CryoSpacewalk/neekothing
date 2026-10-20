/obj/item/material
	icon = 'grafon/item/material.dmi'
	dmg = 3
	size = 2
	parry = 20
	accu = 50
	charges = 1
	var/stackable = 0
	var/maxstack = 1
/obj/item/material/examine()
	if(src.stackable)
		usr << "[src.charges] [src.desc]"
	else
		..()

/obj/item/material/rod
	dmg = 9
	accu = 80
	parry = 10
	stackable = 1
	maxstack = 50
	groovy = 5
	icon_state = "iron"
	name = "Iron rod"
	desc = "rods of low-carbon steel, good for both constructing barricades and bashing one's head."

/obj/item/material/rod

/obj/item/material/silicon
	dmg = 8
	accu = 40
	stackable = 1
	maxstack = 25
	name = "Silicon sheet"
	desc = "lists of refined silicon, used in solar collectors and production of electronics."
	icon_state = "silicon"

/obj/item/material/silicon

/obj/item/material/glass
	dmg = 8
	accu = 40
	stackable = 1
	maxstack = 15
	name = "Glass pannel"
	icon_state = "glass"
	desc = "pannels of dense glass. Yep, dense enough to bash some poor bastard by his head."

/obj/item/material/glass


/obj/item/material/glass/attack_self()




























































	usr << "\blue You raise the pannel."
	var/T = new /obj/structure/window(usr.loc)
	switch(usr.dir)
		if(1)
			T:dir = 2
		if(2)
			T:dir = 2
		if(8)
			T:dir = 4
		if(4)
			T:dir = 4
	var/M = usr.item
	M:changecharge(-1)
	return
/obj/item/material/wallbase
	dmg = 10
	accu = 40
	stackable = 1
	maxstack = 10
	name = "Wall base parts"
	icon_state = "wallbase"
	desc = "wall base parts: just stick them together and add a sheet of metal to finish the wall"
/obj/item/material/wallbase
/obj/item/material/wallbase/prespawned
	charges = 5
	name = "Wall base parts"
/obj/item/material/wallbase/prespawned
/obj/item/material/wallbase/attack_self()
	usr << "\blue Now constructing wall base..."
	var/oldloc = usr.loc
	spawn(100)
		if(usr.loc == oldloc && istype(usr.item, /obj/item/material/wallbase))
			usr << "\blue You finish your wall base."
			new /obj/structure/reinforcement/afterwall(usr.loc)
			usr.delitem()
			return

/obj/item/material/doormech
	beltable = 1
	parry = 2
	metal_need = 1
	plastic_need = 1
	name = "Door mechanisms"
	icon_state = "doormech"
/obj/item/material/doormech
/obj/item/material/ice
	dmg = 8
	accu = 75
	parry = 5
	beltable = 1
	name = "Ice chunk"
	icon_state = "ice"
/obj/item/material/ice
/obj/item/material
/obj/item/material/machine
	size = 3
	dmg = 8
	metal_need = 4
	name = "machinery parts"
	icon_state = "machine"
/obj/item/material/machine
/obj/item/material/machine/attack_self()
	usr << "\blue You place the machine frame."
	new /obj/machframe(usr.loc)
	usr.delitem()
	return
/obj/item/material/compparts
	size = 3
	dmg = 8
	name = "Computer frame parts"
	icon_state = "compparts"
/obj/item/material/compparts
/obj/item/material/compparts/attack_self()
	usr << "\blue You place the computer frame."
	new /obj/frame(usr.loc)
	usr.delitem()
	return

/obj/item/material/radioframe
	size = 3
	dmg = 8
	name = "Broadcasting station frame parts"
	icon_state = "radioparts"
/obj/item/material/radioframe
/obj/item/material/radioframe/attack_self()
	usr << "\blue You place the broadcasting station frame."
	new /obj/structure/radioframe(usr.loc)
	usr.delitem()
	return

/obj/item/material/board
	size = 3
	dmg = 6
	stackable = 1
	maxstack = 25
	name = "Wooden board"
	icon_state = "board"
	desc = "tower cap boards. Used for construction of floors, furniture and barricades."
/obj/item/material/board
/obj/item/material/board/prespawned
	charges = 10
	name = "Wooden board"
/obj/item/material/board/prespawned
/obj/item/material/board/attack_by(atom/I, mob/user)
	if(istype(I, /obj/item/tool/hammer))

		var/choice = input("What do you want to construct?") in list("shkonka", "chair", "table part", "small table")

		if(I:loc != user || !(src in range(1, user)))
			return

		switch(choice)
			if("table part")
				if(src.charges >= 2)
					new /obj/furniture/table(user:loc)
					src.changecharge(-2)
				else
					user << "\red Not enough boards!"
			if("small table")
				if(src.charges >= 2)
					var/T = new /obj/furniture/table(user:loc)
					T:icon_state = "table_single"
					src.changecharge(-2)
				else
					user << "\red Not enough boards!"
			if("chair")
				var/C = new /obj/capspawn(user:loc)
				C:name = "chair"
				src.changecharge(-1)
			if("shkonka")
				new /obj/furniture/shkonka(user:loc)
				src.changecharge(-1)
			else

				user << "\red Nope."

/obj/item/material/core
	beltable = 1
	parry = 2
	name = "power storage unit core"
	icon_state = "core"
/obj/item/material/core
/obj/item/material/proc/changecharge(q)
	if(src.charges + q > src.maxstack)
		src.charges = src.maxstack
	else if(src.charges + q <= 0)
		src.charges = 0
		spawn(0) del(src)
	else
		src.charges += q

/obj/item/material/attack_hand(mob/user)
	src.pickup(user)

/obj/item/material/attack_by(obj/object, mob/user)

	if(src.stackable)

		if(istype(object, type))

			var/M = object
			if(src.charges + M:charges < src.maxstack)
				src.charges += M:charges
				usr.delitem()
			else
				if(src.charges < src.maxstack)
					var/diffak = src.maxstack - src.charges
					src.changecharge(diffak)
					M:changecharge(-diffak)
				else

					user << "\red You can't stack it for any more!"
/obj/item/material/rod/prespawned{charges = 10; name = "Iron rod"}
/obj/item/material/rod/attack_self()

	if(src.charges > 1)
		usr << "\blue Now constructing barricade..."
		spawn(50)
			if(usr.item == src)
				usr << "\blue You've finished your construction."
				new /obj/structure/reinforcement/weak/barricade(usr.loc)



				src.changecharge(-2)
				return

/obj/item/material/board/attack_self()

	if(src.charges > 1)
		usr << "\blue Now constructing barricade..."
		spawn(50)
			if(usr.item == src)
				usr << "\blue You've finished your construction."
				new /obj/structure/reinforcement/wooden/barricade(usr.loc)



				src.changecharge(-2)
				return

/obj/item/material/ice/attack_by(obj/object, mob/user)
	if(istype(object, /obj/item/tool/torch) || (istype(object, /obj/item/weapon/gun/blaster) || istype(object, /obj/item/device/igniter)))
		usr << "\blue You melt the ice."
		if(prob(33))
			usr << "\blue Looks like this ice chunk was containing something."
			new /obj/item/reagent_container/consumable/dust(src.loc)
		del(src)
