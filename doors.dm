// Recovered from compiled neek.dmb (17 procs)

/obj/door
	density = 1
	opacity = 1
	icon = 'grafon/door.dmi'
	icon_state = "common"
	var/icon_state_basic = null
	alticon = "generic"
	wrenchable = 1
	var/alticon_basic = null
	var/material = "IRON"
	var/closed = 1
	var/blocked = 0
	var/fucked = 0
	var/access
	var/id
	var/lockstage = 3
	var/hepe = 200
	var/lures_vermin = 0
	var/obj/signal = null
	var/obj/melt_o = null

/obj/door


/obj/door/New()
	if(!src.icon_state_basic)
		src.icon_state_basic = src.icon_state
	if(!src.alticon_basic)
		src.alticon_basic = src.alticon
	if(!src.fsticon)
		src.fsticon = src.icon_state
	if(src.closed == 1)
		var/T = src.loc
		spawn(1)
			T:airtight = 1
		return
/obj/door/proc/open()
	set name = "Open/Close"
	if(blocked && !usr.unblock)
		usr << "\red It is blocked!"
	else if(src.fucked)
		usr << "\blue Looks like you even don't need to open this thing to pass."
	else if(src.closed)


		opened()
	else


		closed()

/obj/door/proc/bolt()
	blocked = 1
	if(alted)
		icon_state = "[alticon_basic]_bolt"
	else
		icon_state = "[icon_state_basic]_bolt"
	fsticon = "[icon_state_basic]_bolt"
	alticon = "[alticon_basic]_bolt"
	return

/obj/door/proc/unbolt()
	blocked = 0
	if(alted)
		icon_state = alticon
	else
		icon_state = icon_state_basic
	fsticon = icon_state_basic
	alticon = alticon_basic
	return

/obj/door/proc/opened()
	src.density = 0
	src.opacity = 0
	closed = 0
	if(src.melt_o)
		src.overlays -= src.melt_o
	if(src.alted)
		src.icon_state = "[src.alticon_basic]_open"
	else
		src.icon_state = "[src.icon_state_basic]_open"
	fsticon = "[icon_state_basic]_open"
	alticon = "[alticon_basic]_open"
	var/T = src.loc
	T:airtight = 0
	spawn(0)
		for(var/obj/structure/window/W in T)
			if(W.killed == 0)
				T:airtight = 1
		for(var/obj/door/D in T)
			if(D.fucked == 0 && (D.closed == 1 && !(src == D)))
				T:airtight = 1
		for(var/mob/M in hearers(src))
			if(prob(M.distortion * 1.5))
				M.playsound(pick('sounds/just_what.ogg', 'sounds/flute1.wav', 'sounds/flute2.wav', 'sounds/hoot.wav'))
			else
				M.playsound('sounds/door_open.wav')

/obj/door/proc/closed()

	set src in view(1)
	src.density = 1
	if(!(material == "GLASS" || material == "PLASTIC"))
		src.opacity = 1
	src.closed = 1
	if(melt_o)
		overlays += melt_o
	if(src.alted)
		src.icon_state = src.alticon_basic
	else
		src.icon_state = src.icon_state_basic
	src.fsticon = src.icon_state_basic
	src.alticon = src.alticon_basic
	var/T = loc
	spawn(1)
		T:airtight = 1
		for(var/mob/M in hearers(src))
			M.playsound('sounds/door_close.wav')
			if(prob(M.distortion))
				M.playsound(pick('sounds/just_what.ogg', 'sounds/flute1.wav', 'sounds/flute2.wav', 'sounds/hoot.wav'))

/obj/door/proc/fuckup()





	density = 0
	opacity = 0
	fucked = 1
	blocked = 0
	if(melt_o)
		overlays -= melt_o
	if(alted)
		icon_state = "[alticon_basic]_fucked"
	else
		icon_state = "[icon_state_basic]_fucked"
	fsticon = "[icon_state_basic]_fucked"
	alticon = "[alticon_basic]_fucked"
	var/T = src.loc
	spawn(1)
		T:airtight = 0
	return
/obj/door/airlock
	name = "Gas floodgate"
	icon_state = "airlock"
	alticon = "g_airlock"
	var/shutter = 0
/obj/door/airlock
/obj/door/airlock/operate(obj/W)
	if(W:energy > 0)
		var/inp = input("Select method", "", "open/close") in list("open/close", "block/unblock")
		switch(inp)
			if("open/close")
				src.attack_hand()
			if("block/unblock")
				if(src.blocked)
					src.unbolt()
				else
					src.closed()
					src.bolt()
	else
		usr << "\red Not enough energy!"
		return

/obj/door/proc/lockdown()















	src.blocked = 0
	src.dir = 2
	src.closed = 1

/obj/door/proc/unlockdown()
	src.blocked = 1
	src.dir = 1
	src.closed = 0
/obj/door/heavy{name = "steel door"; icon_state = "steel"; alticon = "g_military"; hepe = 500; material = "STEEL"; desc = "This door is fucking heavy so you have to open it with empty hand."}
/obj/door/attack_hand(mob/user)

	if(!src.access)
		open()
		return

	for(var/obj/item/key/K in user)
		if(!K)
			user << "\red Damn, it is locked!"
			return
		else
			if(src.access in K.access)
				open()
			else
				user << "\red Damn, it is locked!"

/obj/door/attack_by(obj/I, mob/user)






	if(!src.signal && istype(I, /obj/item/device/signaler))
		user << "\blue You add a signal translator."
		src.signal = I
		I:loc = src
		spawn(0) user:delitem()

	else if(src.signal && istype(I, /obj/item/tool/screwdriver))
		user << "\blue You remove signal translator."
		src:signal:loc = src.loc
		spawn(0) src.signal = null

	else if(istype(I, /obj/item/device/brutforcer))
		if(src.fucked == 0 && (src.blocked == 0 && usr.processing == 0))
			usr << "\blue Now brutforcing door's lock mechanisms..."
			var/oldeloc = usr.loc
			usr.processing = 1
			spawn(80)
				usr.processing = 0
				if(usr.loc == oldeloc && istype(usr.item, /obj/item/device/brutforcer))
					if(prob(56 + usr.luck))
						usr << "\blue You brutforce the lock mechanisms and reset the access!"
						src.access = null
						return
					else
						usr << "\red You fail to brutforce the lock mechanisms."

	else if(src.material == "STEEL" && (usr:item:charges && istype(usr.item, /obj/item/tool/torch) || (istype(usr.item, /obj/item/tool/hydraulic_cutters) || (istype(usr.item, /obj/item/tool/axe) || (istype(usr.item, /obj/item/weapon/battleaxe) || istype(usr.item, /obj/item/tool/robot/robosaw))))))
		usr.show_message("\red \bold [usr.name] removes [src.name] reinforcements!", "\blue You remove [src.name] reinforcements, turning it into a common door!")
		new /obj/item/material/sheet(src.loc)
		src.desc = "This door reinforcements is removed, so its lock can be [reverse_text("epar")]d and you don't need an empty hand to open it."
		src.material = "IRON"
		src.melt_o = new /obj/overlay/doormelt()
		if(closed)
			src.overlays += melt_o

	else if(src.material != "STEEL" && ((istype(I, /obj/item/weapon/battleaxe/proton) || (istype(usr.item, /obj/item/weapon/battleaxe/electron) || istype(usr.item, /obj/item/tool/robot/robosaw))) && !src.blocked))
		usr.show_message("\red \bold [usr.name] breaks [src.name] lock!", "\blue \bold You break [src.name] lock!")
		src.access = null
		src.opened()
		return

	else if(src.lockstage == 3 && (istype(usr.item, /obj/item/tool/screwdriver) && usr.processing == 0))
		usr << "\blue Now opening door lock up..."
		var/oldeloc = usr.loc
		usr.processing = 1
		spawn(80)
			usr.processing = 0
			if(usr.loc == oldeloc && istype(usr.item, /obj/item/tool/screwdriver))
				if(prob(40 + usr.luck))
					usr << "\blue You open the lock mechanisms!"
					src.lockstage = 2
					return
				else
					usr << "\red You fail to open the lock mechanisms."

	else if(src.lockstage < 3 && istype(I, /obj/item/tool/screwdriver))
		usr << "\blue You close door lock and screw it down."
		spawn(0) src.lockstage = 3

	else if(src.lockstage < 3 && istype(I, /obj/item/tool/wrench))
		if(src.blocked)
			usr.unblock = 1
			usr << "\blue Now rising door bolts..."
			var/oldeloc = usr.loc
			usr.processing = 1
			spawn(50)
				usr.processing = 0
				if(usr.loc == oldeloc && (istype(usr.item, /obj/item/tool/wrench) || (istype(usr.item, /obj/item/tool/axe) || (istype(usr.item, /obj/item/weapon/battleaxe) || istype(usr.item, /obj/item/tool/hydraulic_cutters)))))
					if(prob(60 + usr:luck + usr:item:dmg))
						usr.unblock = 1
						usr << "\blue You unblock the door."
						src.unbolt()
						usr.unblock = 0
						return
					else
						usr << "\red You fail to unblock the door."
		else

			usr << "\blue Now blocking door..."
			var/oldeloc = usr.loc
			usr.processing = 1
			spawn(40)
				usr.processing = 0
				if(usr.loc == oldeloc && istype(usr.item, /obj/item/tool/wrench))
					if(prob(60 + usr.luck))
						usr << "\blue You block the door."
						src.bolt()
						return
					else
						usr << "\red You fail to block the door."

	else if(src.lockstage == 2 && (istype(usr.item, /obj/item/tool/hammer) || istype(usr.item, /obj/item/tool/wirecutters)))
		usr << "\blue You begin to robust lock mechanisms trying to move them!"
		var/oldeloc = usr.loc
		spawn(80) if(usr.loc == oldeloc && (istype(usr.item, /obj/item/tool/hammer) || istype(usr.item, /obj/item/tool/wirecutters)))
			usr << "\blue You manage to move a bit some of the [src] lock mechanisms."
			src.lockstage = 1

	else if(src.lockstage == 1 && istype(usr.item, /obj/item/material/doormech))
		usr << "\blue You begin to insert new lock mechanisms between old ones."
		var/oldeloc = usr.loc
		spawn(80) if(usr.loc == oldeloc && istype(usr.item, /obj/item/material/doormech))
			usr << "\blue You place new mechanisms, resetting the access."
			src.lockstage = 0
			usr.delitem()
			src.access = null

	else if(src.lockstage == 1 && (istype(usr.item, /obj/item/tool/hammer) || (istype(usr.item, /obj/item/tool/axe) || istype(usr.item, /obj/item/weapon/battleaxe))))
		usr << "\blue You begin to smash the door aggresively!"
		for(var/mob/M in view(usr))
			M << "\red [usr] smashes [src] with [I]!"
		var/oldeloc = usr.loc
		spawn(100) if(usr.loc == oldeloc && (istype(usr.item, /obj/item/tool/hammer) || (istype(usr.item, /obj/item/tool/axe) || istype(usr.item, /obj/item/weapon/battleaxe))))
			usr << "\blue You manage to pry door open!"
			src.opened()

	else if(src.lockstage == 0 && istype(usr.item, /obj/item/key))
		usr << "\blue You set the new access."
		var/K = usr.item
		access = pick(K:access)
		usr << "\blue \bold Now its access is '[access]'."
		src.lockstage = 1

	else if(I:size > 2 && src.material == "GLASS")
		if(src.hepe > I:dmg)
			for(var/mob/M in view(src))
				M << "\red \bold [usr] smashes [src] with the [usr.item]!"
				src.hepe -= I:dmg
		else
			for(var/mob/M in view(src))
				M << "\red \bold [usr] breaks [src] with the [usr.item]!"
				src.fuckup()

	else if(istype(I, /obj/item/key))
		var/K = I
		if(access in K:access)
			src.open()
		else
			user << "\red Damn, locked!"
		return

	else if(user:pocket)
		for(var/obj/item/key/K in user)
			if(access in K.access)
				src.open()
			else if(!access)
				src.open()
			else
				user << "\red Damn, it is locked!"
	else

		src.attack_hand(user)

/obj/door/proc/remove_reinforcement()


















	if(src.material != "STEEL" && !src)
		return

	new /obj/item/material/sheet(src.loc)
	src.desc = "This door reinforcements is removed, so its lock can be [reverse_text("epar")]d and you don't need an empty hand to open it."
	src.material = "IRON"
	src.melt_o = new /obj/overlay/doormelt()
	if(closed)
		src.overlays += melt_o

/obj/brokendoor
	icon = 'grafon/door.dmi'
	icon_state = "fucked"
	name = "Broken door"

/obj/brokendoor
/obj/overlay
/obj/item
/obj/item/material
/obj/item/material/doorframe
	metal_need = 3
	name = "door frame"
	icon_state = "dframe1"
	desc = "Used for setting up new doors."
/obj/item/material/doorframe
/obj/item/material/doorframe/wooden
	metal_need = 0
	wood_need = 3
	name = "wooden door frame"
	icon_state = "dframe2"
	desc = "Used for setting up new doors. Does not differs from a common frame, since you use a metal in construction of door shells anyway."
/obj/item/material/doorframe/wooden
/obj/item/material/doorframe/attack_self()
	usr << "\blue You set the door frame."
	new /obj/structure/door_unfin(usr.loc)
	usr.delitem()

/obj/structure
/obj/structure/door_unfin
	icon = 'grafon/door.dmi'
	name = "unfinished door"
	icon_state = "unfinished1"
	desc = "A frame of unfinished door"
	var/stagey = 1
/obj/structure/door_unfin
/obj/structure/door_unfin/attack_by(atom/I)
	if(istype(I, /obj/item/material/sheet) && src.stagey == 1)

		var/S = I
		usr << "\blue You set up a shells for your door."
		src.icon_state = "unfinished2"
		S:changecharge(-1)
		src.stagey = 2
	else
		if(istype(I, /obj/item/material/doormech) && src.stagey == 2)

			usr << "\blue You set up a door with its door mechanics opened to anybody. Use your key to set up some access."

			var/D = new /obj/door(src.loc)
			D:icon = 'grafon/door.dmi'
			D:lockstage = 0

			spawn(0)
				usr.delitem()
				del(src)

/obj/machine
	icon = 'grafon/structure.dmi'
/obj/machine
	wrenchable = 1
	bomb_proof = 80
/obj/machine/shutter_button
	var/on = 0
	name = "Shutters locker"
	icon_state = "s_button_off"
/obj/machine/shutter_button
/obj/machine/shutter_button/attack_hand()
	for(var/obj/door/airlock/D in range(7, src))

		if(D.shutter)
			if(src.on)
				D.unbolt()
			else

				D.closed()
				D.bolt()


	if(!usr.candofun)
		usr << "\red NO"
		return
	else if(src.on)
		src.on = 0
		src.icon_state = "s_button_off"
	else
		src.on = 1
		src.icon_state = "s_button_on"
/obj/machine/shutter_opener
	var/on = 0
	name = "Shutters opening button"
	icon_state = "o_button_off"
/obj/machine/shutter_opener
/obj/machine/shutter_opener/attack_hand()
	for(var/obj/door/airlock/D in range(7, src))

		if(D.shutter)
			D.unbolt()
			D.opened()

	if(!usr.candofun)
		usr << "\red NO"
		return
	if(src.on)
		src.on = 0
		src.icon_state = "o_button_off"
	else
		src.on = 1
		src.icon_state = "o_button_on"


/area;/area/dark;/area/escape;/area/light;/area/var/sd_lighting = 1;/area/var/sd_outside = 0;/area/var/sd_light_level = 0;/area/var/sd_darkimage
