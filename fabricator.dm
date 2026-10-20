/obj/machine/fabricator/robotics
	name = "Robotics PFU"
	icon_state = "fabricator_med"
	hackicon = "fabricator_med_hacked"
/obj/machine/fabricator
	density = 1
	name = "PFU (portable fabricator unit)"
	icon_state = "fabricator"
	var/hackicon = "fabricator_hacked"
	var/metal = 0
	var/silicon = 0
	var/wood = 0
	var/plastic = 0;var/processing = 0;var/hacked = 0
	var/list/things = new(); anchored = 0
/obj/machine/fabricator/New()
	things.Add("metal sheet", "metal sheet (10x)", "metal rod", "metal rod (10x)", "wooden board", "wooden board (10x)", "signal translator", "electron translator", "keyboard", "monitor", "console parts", "wall parts", "wall parts (5x)", "broadcasting station frame parts", "machine frame parts", "wooden door frame", "metal door frame")

/obj/machine/fabricator/operate(obj/W)
















	if(W:energy > 0)
		W:energy -= 1
		src.attack_hand()
	else
		usr << "\red Not enough energy!"
		return

/obj/machine/fabricator/examine()
	usr << "[desc]"
	usr << "<BR><B>Materials left:</B>"
	usr << "Metal: [metal]"
	usr << "Plastic: [plastic]"
	usr << "Silicon: [silicon]"
	usr << "Non-plastic organics: [wood]"
	var/T = "<B>Current fabricator products include:</B><HR><BR>"
	for(var/obj/O in src.things)
		T = addtext(T, "<I>[O.name]</I><BR>")
	for(var/TXT in src.things)
		if(!istype(TXT, /atom))
			T = addtext(T, "<I>[TXT]</I><BR>")
	usr << browse(ruout(T))

/obj/machine/fabricator/attack_by(obj/item/M)
	if(istype(M, /obj/item/material/sheet))
		usr << "You load [M] in the PFU."
		src.metal += M:charges * 2
		spawn(0) usr.delitem()
		return
	else if(istype(M, /obj/item/material/rod))
		usr << "You load [M] in the PFU."
		src.metal += M:charges
		spawn(0) usr.delitem()
		return
	else if(istype(M, /obj/item/material/plastic))
		usr << "You load [M] in the PFU."
		src.plastic += M:charges * 2
		spawn(0) usr.delitem()
		return
	else if(istype(M, /obj/item/material/board))
		usr << "You load [M] in the PFU."
		src.wood += M:charges * 2
		spawn(0) usr.delitem()
		return
	else if(istype(M, /obj/item/material/silicon))
		usr << "You load [M] in the PFU."
		src.silicon += M:charges * 2
		spawn(0) usr.delitem()
		return
	else if(istype(M, /obj/item/device/consolehack) && src.hacked == 0)
		usr << "\blue Beep-beep-beep."
		if(istype(src, /obj/machine/fabricator/robotics))
			src.things.Add("robotic blaster", "enslavement module")
		else if(!istype(src, /obj/machine/fabricator/pipe))
			src.things.Add("signal translator", "igniter", "door mechanisms", "harm baton", "combat axe")
		else
			src.things.Add("Gas tank", "signal translator", "igniter")
		src.icon_state = src.hackicon
	else if(istype(M, /obj/item/electronics/datadisk) && istype(src, /obj/machine/fabricator/electronics))
		var/EFB = src
		EFB:readwrite(M)

/obj/machine/fabricator/attack_hand()
	if(!usr.candofun)
		usr << "\red NO"
		return
	var/obj/thing = input("\bold Materials left:\font metal: [metal]; silicon: [silicon]; biological structures: [wood]; plastic: [plastic]", "Please, make your selection.", "") in src.things
	if(src.processing == 0)
		switch(thing)
			if("metal sheet")
				if(metal > 1)
					processing = 1
					metal -= 2
					spawn(50)
						processing = 0
						new /obj/item/material/sheet(src.loc)
				else
					usr << "\red Not enough materials to process your order (2 metal needed)."
			if("metal sheet (10x)")
				if(metal > 19)
					processing = 1
					metal -= 20
					spawn(50)
						processing = 0
						new /obj/item/material/sheet(src.loc)
				else
					usr << "\red Not enough materials to process your order (20 metal needed)."
			if("metal rod")
				if(metal > 0)
					processing = 1
					metal -= 10
					spawn(30)
						processing = 0
						new /obj/item/material/rod(src.loc)
				else
					usr << "\red Not enough materials to process your order (1 metal needed)."
			if("metal rod (10x)")
				if(metal > 9)
					processing = 1
					metal -= 10
					spawn(60)
						processing = 0
						new /obj/item/material/rod/prespawned(src.loc)
				else
					usr << "\red Not enough materials to process your order (10 metal needed)."
			if("wooden board")
				if(wood > 0)
					processing = 1
					wood--
					spawn(30)
						processing = 0
						new /obj/item/material/board(src.loc)
				else
					usr << "\red Not enough materials to process your order."
			if("wooden board (10x)")
				if(wood > 9)
					processing = 1
					wood -= 10
					spawn(60)
						processing = 0
						new /obj/item/material/board/prespawned(src.loc)
				else
					usr << "\red Not enough materials to process your order (10 wood needed)."
			if("signal translator")
				if(silicon > 0)
					processing = 1
					silicon -= 1
					spawn(70)
						processing = 0
						new /obj/item/device/signaler(src.loc)
				else
					usr << "\red Not enough materials to process your order (1 silicon needed)."
			if("Electron translator")
				if(plastic > 1)
					processing = 1
					plastic -= 2
					spawn(50)
						processing = 0
						new /obj/item/warpwire(src.loc)
				else
					usr << "\red Not enough materials to process your order (2 plastic needed)."
			if("keyboard")
				if(plastic > 0)
					processing = 1
					plastic -= 1
					spawn(70)
						processing = 0
						new /obj/item/electronics/keyboard(src.loc)
				else
					usr << "\red Not enough materials to process your order (1 plastic needed)."
			if("igniter")
				if(metal > 0)
					processing = 1

					metal -= 1
					spawn(70)
						processing = 0
						new /obj/item/device/igniter(src.loc)
				else
					usr << "\red Not enough materials to process your order. (1 metal needed)"
			if("monitor")
				if(plastic > 1)
					processing = 1
					plastic -= 2
					spawn(70)
						processing = 0
						new /obj/item/electronics/monitor(src.loc)
				else
					usr << "\red Not enough materials to process your order (2 plastic needed)."
			if("console parts")
				if(plastic > 0 && metal > 0)
					src.processing = 1
					src.plastic -= 1
					src.metal -= 1
					spawn(70)
						src.processing = 0
						new /obj/item/material/compparts(loc)
				else
					usr << "\red Not enough materials to process your order (1 plastic and 1 metal needed) ."
			if("wall parts")
				if(metal > 2)
					processing = 1
					metal -= 3
					spawn(60)
						processing = 0
						new /obj/item/material/wallbase(src.loc)
				else
					usr << "\red Not enough materials to process your order (3 metal needed)."
			if("wall parts (5x)")
				if(metal > 14)
					processing = 1
					metal -= 15
					spawn(90)
						processing = 0
						new /obj/item/material/wallbase/prespawned(src.loc)
				else
					usr << "\red Not enough materials to process your order (15 metal needed)."
			if("harm baton")
				if(plastic > 3)
					processing = 1
					plastic -= 4
					spawn(100)
						processing = 0
						new /obj/item/weapon/baton(src.loc)
				else
					usr << "\red Not enough materials to process your order (4 plastic needed)."
			if("door mechanisms")
				if(metal > 2)
					processing = 1
					metal -= 3
					spawn(100)
						processing = 0
						new /obj/item/material/doormech(src.loc)
				else
					usr << "\red Not enough materials to process your order (3 metal needed)."
			if("combat axe")
				if(metal > 4 && (plastic > 0 && wood > 0))
					src.processing = 1
					src.metal -= 5
					src.plastic -= 1
					src.wood -= 1
					spawn(100)
						src.processing = 0
						new /obj/item/weapon/battleaxe(loc)
				else
					usr << "\red Not enough materials to process your order (1 plastic, 1 wood and 5 metal needed)."
			if("brain pod")
				if(metal > 2 && plastic > 2)
					src.processing = 1
					src.metal -= 3
					src.plastic -= 3
					spawn(100)
						src.processing = 0
						new /obj/item/device/brainpod(loc)
				else
					usr << "\red Not enough materials to process your order (3 metal and 3 plastic needed)."
			if("pod stand")
				if(metal > 0 && plastic > 1)
					src.processing = 1
					src.metal -= 1
					src.plastic -= 2
					spawn(100)
						src.processing = 0
						new /obj/machine/podstand(loc)
				else
					usr << "\red Not enough materials to process your order (1 metal and 2 plastic needed)."
			if("robotic saw")
				if(metal > 1)
					processing = 1
					metal -= 2
					spawn(80)
						processing = 0
						new /obj/item/tool/robot/robosaw(src.loc)
				else
					usr << "\red Not enough materials to process your order (2 metal needed)."
			if("robotic drill")
				if(metal > 1)
					processing = 1
					metal -= 2
					spawn(80)
						processing = 0
						new /obj/item/tool/robot/robodrill(src.loc)
				else
					usr << "\red Not enough materials to process your order (2 metal needed)."
			if("robotic jet")
				if(metal > 0 && plastic > 0)
					src.processing = 1
					src.metal -= 1
					src.plastic -= 1
					spawn(70)
						src.processing = 0
						new /obj/item/device/jet(loc)
				else
					usr << "\red Not enough materials to process your order (1 metal and 1 plastic needed)."
			if("constructing module charge")
				if(metal > 1)
					processing = 1
					metal -= 2
					spawn(80)
						processing = 0
						new /obj/item/tool/robot/constructing_module_charge(src.loc)
				else
					usr << "\red Not enough materials to process your order (2 metal needed)."
			if("constructing module")
				if(metal > 2 && silicon > 0)
					src.processing = 1
					src.metal -= 3
					src.silicon -= 1
					spawn(100)
						src.processing = 0
						new /obj/item/tool/robot/constructing_module(loc)
				else
					usr << "\red Not enough materials to process your order (3 metal and 1 silicon needed)."
			if("broadcasting station frame parts")
				if(wood > 2)
					processing = 1
					wood -= 3
					spawn(50)
						processing = 0
						new /obj/item/material/radioframe(src.loc)
				else
					usr << "\red Not enough materials to process your order (3 wood needed)."
			if("machine frame parts")
				if(metal > 1)
					processing = 1
					metal -= 2
					spawn(30)
						processing = 0
						new /obj/item/material/machine(src.loc)
				else
					usr << "\red Not enough materials to process your order (2 wood needed)."
			if("2 pipe fragments")
				if(metal > 0)
					processing = 1
					metal -= 1
					spawn(50)
						processing = 0
						new /obj/item/pipe(src.loc)
						new /obj/item/pipe(src.loc)
				else
					usr << "\red Not enough materials to process your order. (1 metal needed)"
			if("2 bent pipe fragments")
				if(metal > 0)
					processing = 1
					metal -= 1
					spawn(50)
						processing = 0
						for(var/i = 0, i < 2, i++)
							var/P = new /obj/item/pipe(src.loc)
							P:dir = pick(6, 10, 5, 9)
				else
					usr << "\red Not enough materials to process your order (1 metal needed)."
			if("Pipe with pump")
				if(metal > 0)
					processing = 1
					metal -= 1
					spawn(50)
						processing = 0
						new /obj/item/pipe/pump(src.loc)
				else
					usr << "\red Not enough materials to process your order (1 metal needed)."
			if("Pipe with vent outlet")
				if(metal > 0)
					processing = 1
					metal -= 1
					spawn(50)
						processing = 0
						new /obj/item/pipe/vent(src.loc)
				else
					usr << "\red Not enough materials to process your order (1 metal needed)."
			if("connector port")
				if(metal > 0)
					processing = 1
					metal -= 1
					spawn(50)
						processing = 0
						new /obj/item/pipe/connector(src.loc)
				else
					usr << "\red Not enough materials to process your order (1 metal needed)."
			if("T-pipe fragment")
				if(metal > 0)
					processing = 1
					metal -= 1
					spawn(50)
						processing = 0
						new /obj/item/pipe/t(src.loc)
				else
					usr << "\red Not enough materials to process your order (1 metal needed)."
			if("Gas tank")
				if(metal > 0)
					processing = 1
					metal -= 1
					spawn(60)
						processing = 0
						new /obj/item/gas/tank(src.loc)
				else
					usr << "\red Not enough materials to process your order."
			if("2 heat transfer pipe fragments")
				if(plastic > 0)
					processing = 1
					plastic -= 1
					spawn(50)
						processing = 0
						new /obj/item/pipe/heat(src.loc)
						new /obj/item/pipe/heat(src.loc)
				else
					usr << "\red Not enough materials to process your order (1 plastic needed)."
			if("2 bent heat transfer pipe fragments")
				if(plastic > 0)
					processing = 1
					plastic -= 1
					spawn(50)
						processing = 0
						for(var/i = 0, i < 2, i++)
							var/P = new /obj/item/pipe/heat(src.loc)
							P:dir = pick(6, 10, 5, 9)
				else
					usr << "\red Not enough materials to process your order (1 plastic needed)."
			if("robotic blaster")
				if(plastic > 0 && (metal > 1 && silicon > 0))
					src.processing = 1
					src.plastic -= 1
					src.metal -= 2
					src.silicon -= 1
					spawn(100)
						src.processing = 0
						new /obj/item/weapon/gun/blaster/robot(loc)
				else
					usr << "\red Not enough materials to process your order (2 metal, 1 silicon and 1 1 plastic needed)."
			if("enslavement module")
				if(metal >= 10 && silicon > 4)
					src.processing = 1
					src.silicon -= 5
					src.metal -= 10
					spawn(100)
						src.processing = 0
						new /obj/item/device/e_module(loc)
				else
					usr << "\red Not enough materials to process your order (10 metal and 5 silicon needed)."
			if("device frame")
				if(plastic > 0)
					processing = 1
					plastic -= 1
					spawn(70)
						processing = 0
						new /obj/item/electronics/deviceframe(src.loc)
				else
					usr << "\red Not enough materials to process your order (1 plastic needed)."
			if("a pair of cyberarms")




















































































































































































				if(metal > 0)
					processing = 1
					metal--
					spawn(50)
						processing = 0
						new /obj/item/limb/l_hand/lhand1(src.loc)
						new /obj/item/limb/r_hand/rhand1(src.loc)
				else
					usr << "\red Not enough materials to process your order (1 metal needed)."
			if("a pair of cyberlegs")
				if(metal > 0)
					processing = 1
					metal--
					spawn(50)
						processing = 0
						new /obj/item/limb/l_leg/lleg1(src.loc)
						new /obj/item/limb/r_leg/rleg1(src.loc)
				else
					usr << "\red Not enough materials to process your order (1 metal needed)."
			if("metal door frame")

				if(metal > 2)
					processing = 1
					metal -= 3
					spawn(50)
						processing = 0
						new /obj/item/material/doorframe(src.loc)
				else
					usr << "\red Not enough materials to process your order (1 metal needed)."
			if("wooden door frame")

				if(wood > 2)
					processing = 1
					wood -= 3
					spawn(50)
						processing = 0
						new /obj/item/material/doorframe/wooden(src.loc)
				else
					usr << "\red Not enough materials to process your order (1 metal needed)."




/obj/machine/fabricator/engie
	name = "Engineering PFU"
	icon_state = "fabricator_engie"
	hackicon = "fabricator_engie_hacked"
/obj/machine/fabricator/engie
/obj/machine/fabricator/engie/New()
	things.Add("metal sheet", "metal sheet (10x)", "metal rod", "metal rod (10x)", "wooden board", "wooden board (10x)", "signal translator", "keyboard", "monitor", "console parts", "wall parts", "wall parts (5x)", "door mechanisms", "broadcasting station frame parts", "igniter", "wooden door frame", "metal door frame")


/obj/machine/fabricator/pipe
	name = "Atmospherics PFU"

/obj/machine/fabricator/pipe


/obj/machine/fabricator/pipe/New()











	things.Add("2 pipe fragments", "2 bent pipe fragments", "2 heat transfer pipe fragments", "2 bent heat transfer pipe fragments", "T-pipe fragment", "Pipe with pump", "Pipe with vent outlet", "connector port")

