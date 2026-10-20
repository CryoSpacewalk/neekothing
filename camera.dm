/obj/machine/op_wirer{name = "Area wiring device"; icon_state = "opwirer"; alticon = "gopwirer"; desc = "A special device for (un)wiring locals via Operation Mainframe. Can be manually refilled with cable coils."; var/wires = 10; var/wiretype = "common"}
/obj/structure/mine{density = 1; name = "space mine"; desc = "Just don't fucking touch it."; icon_state = "mine"; var/active = 1; wrenchable = 1}
/obj/structure/shocktrap{layer = 4.1; name = "stun trap"; desc = "A shock trap, deactivatable by mine activator or a command key."; icon_state = "shock_off"; var/cockicon = "shock"; var/active = 0; var/nooperate = 0; wrenchable = 1}
/obj/triwire{layer = 2.5; icon = 'grafon/wire.dmi'; var/energy = 0; name = "T-Cable"; icon_state = "twire"; alticon = "gtwire"}
/atom/var/mine_trigger = 1
/client/var/operat = 0
/client/var/camera_anchor
/obj/structure/camera/New()
	sd_SetLuminosity(1)
/obj/structure/camera/attack_by(obj/item/I)
	if(!istype(src, /obj/structure/camera/portable))
		if(istype(I, /obj/item/cable))
			var/CB = I
			usr << "\blue You attach a cable noose to the camera."
			new /obj/structure/noose(src.loc)
			CB:cminus(1)
	..()
/obj/structure/camera/portable{density = 1; desc = "A special pullable camera."; icon_state = "camera_pull"}
/obj/structure/camera/portable{anchored = 0}
/obj/structure/camera/operate(obj/W)
	if(!usr.client)
		return

	if(W:energy > 0)
		usr.client.camera_control(src)
		W:energy -= 1
	else

		usr.client.camera_anchor = null
		return


/obj/comp/camera
	wrenchable = 1













	board = new /obj/item/electronics/board/camera; name = "Cameras Observing Console";icon_state = "pc_camera"
/obj/comp/camera/attack_hand()
	if(!src.on)
		return
		if("chromosome" in usr.mutations)
			usr << "\red \bold You don't know how to operate it!"
			return
	else if(usr.candofun)
		var/LT = new /list()
		for(var/obj/structure/camera/T in world)
			LT:Add(T)
		var/targt = input("") in LT
		usr.client.observe_target(targt)
	else
		usr << "\red You're unable to operate machinery!"
		return
/obj/comp/camera/New()
	..()
	src.powercheck()


/obj/structure/mine/Cross(atom/movable/O)













	if(src:active && (O:density && O:mine_trigger))
		explosion(1.2, src.loc)
		spawn(0)
			if(src)
				del(src)
				return
/obj/structure/mine/attack_hand()
	if(icon_state == "mine")
		Cross()
/obj/structure/mine/attack_by(obj/I)
	if(istype(I, /obj/item/device/consolehack) || istype(I, /obj/item/device/mined))
		if(src.active)
			usr << "\blue Mine deactivated and can be pulled."
			src.anchored = 0
			src.active = 0
		else
			usr << "\blue Mine activated and setted in place."
			src.anchored = 1
			src.active = 1
	else if(src.icon_state == "mine")
		src.Cross()

/obj/item/device/d_mine/attack_self()


















	usr << "\blue You deploy the mine."
	new /obj/structure/mine(usr.loc)
	spawn(0) del(src)





/obj/structure/shocktrap/operator
	nooperate = 1
	active = 1
	name = "Operator fortress stun trap"
	desc = "A shock trap, deactivatable by mine activator or a command key. Operator can't use his gear to turn it on or off, however."
	icon_state = "shock_on"

/obj/structure/shocktrap/operator

/obj/structure/shocktrap/operator/New()







	new /obj/overlay/trap_marker(src.loc)

/obj/structure/shocktrap/operate(obj/W)
	if(nooperate)
		usr << "\red \bold URMOM can't operate [name]!"
		return
	if(W:energy > 0)
		if(active)
			usr << "\blue Stun trap deactivated."
			icon_state = "[cockicon]_off"
			active = 0
			for(var/obj/overlay/trap_marker/TM in src.loc)
				del(TM)
		else

			usr << "\blue Stun trap activated."
			icon_state = "[cockicon]_on"
			active = 1
			new /obj/overlay/trap_marker(src.loc)
		W:energy -= 1

/obj/structure/shocktrap/Cross(atom/movable/O)
	if(istype(O, /mob) && src.active)
		var/M = O
		M << "\red OUCH FUCK"
		M:stun(10)
		M:damaga(2, "burn")
	else
		return 1

/obj/structure/shocktrap/attack_by(obj/I)

	if(istype(I, /obj/item/reagent_container/cig))
		var/C = I
		C:smoke(usr)

	if(istype(I, /obj/item/device/consolehack) || (istype(I, /obj/item/device/mined) || istype(I, /obj/item/key)))

		if(istype(I, /obj/item/key))
			var/okey = 0
			var/K = I
			for(var/V in K:access)
				if(V == "command")
					okey = 1
			if(!okey)
				return
		spawn(0)
			if(active)
				usr << "\blue Stun trap deactivated."
				icon_state = "[cockicon]_off"
				active = 0
				for(var/obj/overlay/trap_marker/TM in src.loc)
					del(TM)
			else
				usr << "\blue Stun trap activated."
				icon_state = "[cockicon]_on"
				active = 1
				new /obj/overlay/trap_marker(src.loc)

/obj/structure/shocktrap/abyss
	name = "Stunfield"
	desc = "A wretched device, probably driven to Abyss from somewhere else."
	cockicon = "ashock"
	active = 1
	icon_state = "ashock_on"
/obj/structure/shocktrap/abyss
/obj/structure/shocktrap/abyss/New()
	new /obj/overlay/trap_marker(src.loc)



/obj/machine/teleminer/attack_by(obj/I)





	for(var/obj/wire/battery/B in src.loc)
		if(!B || B.energy == 0)
			return
		else
			var/list/LT = list()
			for(var/obj/structure/camera/T in world)
				LT.Add(T)
			var/obj/structure/camera/targt = input("Select camera, plox") in LT
			usr.client.observe_target(targt)

			if(usr && (src && (usr.client.eye == targt:loc && I:loc == usr)))

				var/lx = list()
				var/ly = list()
				for(var/turf/T in view(targt))
					lx += T.x
					ly += T.y

				usr << "\bold Now select the coordinates of the turf to deploy <font color = red>(camera coordinates are x:[targt:x] y:[targt:y]).</font>"
				var/bx = input("Selecting x") in lx
				var/by = input("Selecting y") in ly

				if(usr && (src && (usr.client.eye == targt:loc && I:loc == usr)))
					if(istype(I, /obj/item/bomb))
						new /obj/time_bomb(locate(bx, by, src.z))
						spawn(0)
							usr.delitem()
							B.energy -= 1
					else if(istype(I, /obj/item/device/d_mine))
						new /obj/structure/mine(locate(bx, by, src.z))
						spawn(0)
							usr.delitem()
							B.energy -= 1
					else
						usr << "\red Nope, this thing can't be deployed."
						return
			else
				usr << "\red You're either too far from teleminer or the thing is broken!"

/atom/proc/operate(obj/W)





	return

/client/proc/operate_target(obj/T, obj/W)






	set category = "Pedal"

	src.perspective = 1
	src.eye = T:loc
	src.operat = 1
	src.opwire = W


/obj/machine/op_frame/attack_hand()






	var/list/LT = new /list()
	for(var/obj/structure/camera/T in world)
		LT.Add(T)
	var/targt = input("") in LT

	for(var/obj/wire/battery/B in src.loc)
		if(B)
			src.playsound('sounds/dial_up.ogg')
			usr.client.operate_target(targt, B)
			spawn(35) src.playsound(null)

/client/proc/camera_control(obj/O)



	if(O:anchored)
		src << "\red ЕГГОГ: target isn't suitable for operating via U.R.M.O.M.!"
		return

	else if(src.camera_anchor)
		src.camera_anchor = null
	else


		src.camera_anchor = O

/obj/machine/op_wirer/operate(obj/W)













	if(W:energy > 0)
		usr << "\blue Current amounts of wiring material: [wires]"

		var/wiretype_pre = input("Switching wire type", "T-wires and outlets require 2 wires instead of 1", "common") in list("common", , "outlet", "wire leech", "power sharer")

		if(usr in range(1, W))
			wiretype = wiretype_pre
		W:energy -= 1
	else
		usr << "\red Not enough energy!"
/obj/machine/op_wirer/attack_by(obj/I)
	if(istype(I, /obj/item/cable))
		var/CB = I
		usr << "\blue You refill the machine with your cable."
		src.wires += 1
		spawn(0) CB:cminus(1)
	else if(istype(I, /obj/item/tcable) || istype(I, /obj/item/caboutlet))
		usr << "\blue You refill the machine with your cable."
		src.wires += 2
		spawn(0) usr.delitem()
/obj/machine/op_wirer/attack_hand()
	usr << "\blue Current amounts of wiring material: [src.wires]"
/obj/machine/op_wirer/New()
	sd_SetLuminosity(1)

/obj/wire/operate(obj/W)
	if(W:energy > 0)
		for(var/obj/machine/op_wirer/O in view(src))
			if(O)
				usr << "\blue You cut down local wires."
				new /obj/item/cable(src.loc)
				if(istype(src, /obj/wire/battery))
					new /obj/item/outlet(src.loc)
				if(istype(src, /obj/wireleech))
					new /obj/item/bluecable(src.loc)
				if(istype(src, /obj/wireout))
					new /obj/item/sharecable(src.loc)
				for(var/obj/comp/lights/C in src.loc)
					for(var/obj/lamp/L in range(25, C))
						L.turnoff()
					C.dir = 1
					C.on = 0
					C.powered = 0

					C.sd_SetLuminosity(0)
				W:energy -= 1
				spawn(0) del(src)
	else
		usr << "\red Not enough energy!"

/obj/triwire/operate(obj/W)
	if(W:energy > 0)
		for(var/obj/machine/op_wirer/O in view(src))
			if(O)
				usr << "\blue You cut down local wires."
				new /obj/item/tcable(src.loc)
				W:energy -= 1
				spawn(0) del(src)
	else
		usr << "\red Not enough energy!"

/turf/operate(obj/WR)

	var/wirerz = list()
	var/O = null

	for(var/obj/machine/op_wirer/O2 in range(20, src))
		wirerz += O2

	if(wirerz:len)
		O = pick(wirerz)

	if(O)
		switch(O:wiretype)
			if("common")
				if(O:wires > 0)
					O:wires -= 1
				var/W = new /obj/wire()
				W:dir = input("1 is north/south, 8 is west/east, 6 is southeast, 10 is southwest, 9 is northwest, 5 is northeast.", "Select a cable position:", "WEST") in list(1, 8, 10, 6, 9, 5)
				if(usr in range(1, WR))
					spawn(0)
						W:loc = src
						spawn(0) new /obj/effect/sparks(src)
			if("T-wire")
				if(O:wires > 1)
					O:wires -= 2
					var/W = new /obj/triwire()
					W:dir = input("1 is north, 2 is south, 8 is west, 4 is east:", "Select a T-cable position:", "WEST") in list(1, 2, 8, 4)
					if(usr in range(1, WR))
						spawn(0)
							W:loc = src
							spawn(0) new /obj/effect/sparks(src)
			if("outlet")
				if(O:wires > 1)
					O:wires -= 2
					var/W = new /obj/wire/battery()
					W:dir = input("1 is north/south, 8 is west/east, 6 is southeast, 10 is southwest, 9 is northwest, 5 is northeast.", "Select a cable position:", "WEST") in list(1, 8, 10, 6, 9, 5)
					if(usr in range(1, WR))
						spawn(0)
							W:loc = src
							spawn(0) new /obj/effect/sparks(src)
			if("wire leech")
				if(O:wires > 1)
					O:wires -= 2
					var/W = new /obj/wireleech()
					W:dir = input("1 is north/south, 8 is west/east, 6 is southeast, 10 is southwest, 9 is northwest, 5 is northeast.", "Select a cable position:", "WEST") in list(1, 8, 10, 6, 9, 5)
					if(usr in range(1, WR))
						spawn(0)
							W:loc = src
							spawn(0) new /obj/effect/sparks(src)
			if("wire sharer")
				if(O:wires > 1)
					O:wires -= 2
					var/W = new /obj/wireout()
					W:dir = input("1 is north/south, 8 is west/east, 6 is southeast, 10 is southwest, 9 is northwest, 5 is northeast.", "Select a cable position:", "WEST") in list(1, 8, 10, 6, 9, 5)
					if(usr in range(1, WR))
						spawn(0)
							W:loc = src
							spawn(0) new /obj/effect/sparks(src)

/obj/structure/op_bomb/operate(obj/W)










	if(W:energy > 0)

		usr.client.camera_control(src)
		W:energy -= 1

		usr << "\red Bomb activated. Five seconds to move it where you want it to blow the fuck up!"
		src.icon_state = "op_bomb_on"
		spawn(50)
			usr.client.camera_anchor = null
			spawn(0)
				explosion(2, src.loc)
				if(src)
					del(src)
					return
	else
		usr << "\red Not enough energy!"
/obj/lamp/floor{luminosity = 0; layer = 2.2; tough = 50; icon_state = "flooroff"; name = "floor light"};/obj/lamp/lava{luminosity = 0; layer = 3; name = "lava lamp"; icon_state = "lava"; alticon = "glava"; tough = 15};/obj/lamp/strong{luminosity = 0; icon_state = "strongoff"; name = "strong lamp"; alticon = "gstrong"; tough = 20}
/obj/lamp/operate(obj/W)
	if(W:energy > 1)
		src.turnon_temp(80)
		usr << "\blue You turn this lamp for 8 seconds."
		W:energy -= 2
	else
		usr << "\red Not enough energy!"

/obj/dest/emitter/operate(obj/W)
	if(W:energy > 0)
		W:energy -= 1
		usr << "\blue Pew-pew!"
		src.pewpew()
	else
		usr << "\red Not enough energy!"
		return

/turf/floor/operate(obj/W)
	if(W:energy > 0)

		var/have_cameras = 0
		for(var/obj/structure/camera/CMR in src)
			if(CMR)
				have_cameras = 1

		if(have_cameras)
			W:energy -= 1
			usr << "\blue You lit the floor for 5 seconds. Don't ask me how."
			var/oldlum = luminosity
			sd_SetLuminosity(4)
			spawn(53)
				sd_SetLuminosity(oldlum)
		else
			..()
	else

		usr << "\red Not enough energy!"
