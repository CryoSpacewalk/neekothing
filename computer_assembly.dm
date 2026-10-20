/obj/foam
/obj/overlays
/obj/set_tripwire
	icon = 'grafon/item/gas.dmi'
	var/TNK
	icon_state = "set_tripwire"
/obj/light_emitter
/obj/glower{icon = 'grafon/cult.dmi'; name = "Glowing orb"; icon_state = "glower"; desc = "Nobody knows how this thing is working, but it glows perpentually."}
/obj/glower{anchored = 0; bomb_proof = 100}
/obj/jizz{icon = null /*icon id 73: unresolved*/; icon = 'grafon/effects/chemistry.dmi'; icon_state = "jizz1"}
/obj/limb
/obj/blood{icon = null /*icon id 73: unresolved*/; icon = 'grafon/effects/chemistry.dmi'; icon_state = "blood1"}
/obj/chemical
/obj/frame{icon = 'grafon/comp.dmi'; var/harddrive; var/K; var/details; name = "Empty Computer Frame"; icon_state = "pc_empty"; alticon = "pc_empty_alt"; var/wired = 0; var/board; var/moni; var/olddir = 1; var/charges = 0}
/obj/frame/attack_hand()
	if(!src:moni && (src.K && src:wired == 0))
		usr << "\blue You detach the keyboard."
		K:loc = src.loc
		src.dir = 2
		K = null

/obj/frame/attack_by(obj/O)







	if(istype(O, /obj/item/tool/screwdriver))
		world << "test"
		if(!src:moni)
			if(src.harddrive)
				usr << "\blue You remove the hard drive from your construction."
				src.harddrive:loc = loc
				src.charges = 0
				src.harddrive = null
				src.dir = 8
			if(src.board)
				usr << "\blue You remove the motherboard from your construction."
				src.board:loc = usr.loc
				src.board = null
				src.dir = 4
			else
				usr << "\red You have no idea how to connect it here."
		else if(!src.board)
			usr << "\red This console lacks motherboard, so you detach the monitor to install one."
			src:moni:loc = loc
			src:moni = null
			icon_state = "pc_empty"
			return
		else if(src.board)
			usr << "\blue You connect the monitor."
			if(istype(board, /obj/item/electronics/board/lightpc))
				var/C = new /obj/comp/lights(loc)
				C:harddrive = harddrive
				C:details = src:details
				usr.delitem()
				spawn(0)
					del(src)
					return
			else if(istype(board, /obj/item/electronics/board/singpc))
				var/C = new /obj/comp/singpc(loc)
				sync(C)
				usr.delitem()
				spawn(0)
					del(src)
					return
			else if(istype(board, /obj/item/electronics/board/ordering))
				if(src.harddrive)
					var/C = new /obj/comp/ordering(loc)
					sync(C)
					usr.delitem()
					spawn(0)
						del(src)
						return
				else
					usr << "\red \bold This console needs hard drive to work!"
					return
			else if(istype(board, /obj/item/electronics/board/transport))
				var/C = new /obj/comp/transport(loc)
				sync(C)
				spawn(0)
					del(src)
					return
			else if(istype(board, /obj/item/electronics/board/dust))
				var/C = new /obj/comp/dust(loc)
				sync(C)
				spawn(0)
					del(src)
					return
			else if(istype(board, /obj/item/electronics/board/tele))
				var/C = new /obj/comp/tele(loc)
				sync(C)
				spawn(0)
					del(src)
					return
			else if(istype(board, /obj/item/electronics/board/alert))
				var/C = new /obj/comp/alert(loc)
				sync(C)
				spawn(0)
					del(src)
					return
			else if(istype(board, /obj/item/electronics/board/gas))
				var/C = new /obj/comp/gas(loc)
				sync(C)
				spawn(0)
					del(src)
					return
			else if(istype(board, /obj/item/electronics/board/prosecutor))
				var/C = new /obj/comp/prosecutor(loc)
				sync(C)
				spawn(0)
					del(src)
					return
			else if(istype(board, /obj/item/electronics/board/cognitology))
				var/C = new /obj/comp/cognitology(loc)
				sync(C)
				spawn(0)
					del(src)
					return
			else
				usr << "\red \bold It doesn't have any motherboard installed!"

	if(!src:moni)
		if(istype(O, /obj/item/electronics/keyboard) && !src.K)
			usr << "\blue You connect the keyboard to the frame."
			src.K = O
			usr.dropitem()
			O:loc = src
			src.dir = 1
			return
		else if(!src.K && istype(O, /obj/item/tool/wrench))
			usr.processing = 1
			usr << "\blue Now deconstructing the frame..."
			spawn(20)
				usr.processing = 0
				new /obj/item/material/compparts(src.loc)
				spawn(0) del(src)
		else if(istype(O, /obj/item/cable) && (!src.wired && src.K))
			usr << "\blue You begin to wire up frame's parts..."
			spawn(50)
				if(istype(usr.item, /obj/item/cable) && usr in range(1, src))
					var/CB = O
					usr << "\blue You wire up the frame."
					src.wired = 1
					src.dir = 4
					spawn(0) CB:cminus(1)
					return
		else if(istype(O, /obj/item/electronics/board) && (src.wired == 1 && src.board == null))
			usr << "\blue You connect the motherboard to the frame."
			src.board = O
			usr.dropitem()
			O:loc = src
			src.dir = 8
			return
		else if(istype(O, /obj/item/electronics/drive) && (!src.harddrive && src.board))
			usr << "\blue You add a hard drive to the construction."
			src.harddrive = O
			src.charges = O:charges
			usr.dropitem()
			O:loc = src
			src.dir = 6
			return
		else if((istype(O, /obj/item/tool/wirecutters) || (istype(O, /obj/item/tool/hydraulic_cutters) || istype(O, /obj/item/tool/scalpel))) && (!src.board && (!src.harddrive && (!src:moni && wired))))
			usr << "\blue You cut the wiring."
			src.wired = 0
			src.dir = 1
			return
		else

			if(istype(O, /obj/item/electronics/monitor) && src.wired == 1)
				usr << "\blue You cover computer's electronics with the monitor."
				src:moni = O
				usr.dropitem()
				O:loc = src
				src.icon_state = "pc"


/obj/frame/finished
/obj/frame/proc/sync(obj/C)
	C:harddrive = new src.harddrive()
	C:details = new src:details()
	C:charges = src.charges


/obj/frame/finished
	harddrive = null

	K = new /obj/item/electronics/keyboard
	details = null
	wired = 1
	board = null
	moni = new /obj/item/electronics/monitor
	olddir = 1
	icon_state = "pc"
	name = "Computer Frame"