// Recovered from compiled neek.dmb (15 procs)


/obj/item/device/brainpod
	market_price = 90
	plastic_need = 8
	var/brainkey = null
	var/traitor = 0
	var/cultplayer = 0
	var/first_objective
	var/second_objective

/obj/machine/gibber/proc/gib()



	for(var/mob/M in src.loc)
		if(M.mat == "flesh")
			if(M.dead == 1)
				spawn(0) M.gib()
			else
				for(var/mob/MM in hearers(src))
					if(!MM.sleeps)
						MM << "\red \bold SMASH SPLASH CHEW"
				spawn(0) M.damaga(40 - M.armor, "brute")
		else
			for(var/mob/MM in hearers(src))
				if(!MM.sleeps)
					MM << "\red \bold Beep."
/obj/machine/gibber/verb/activate()
	set src in view(1)

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	src.gib()

/obj/machine/fabricator/robotics/New()




	things.Add("metal sheet", "metal rod", "brain pod", "pod stand", "robotic jet", "robotic saw", "robotic drill", "constructing module", "constructing module charge", "a pair of cyberarms", "a pair of cyberlegs")


/obj/machine/podstand/attack_by(obj/I)







	var/B, R; if(istype(I, /obj/item/device/brainpod))
		B = I
		usr << "\blue You set [B] in the frame."
		R = new /mob/robot(src.loc)
		R:traitor = B:traitor
		R:cultplayer = B:cultplayer
		R:cult = B:cultplayer
		R:objective1 = B:first_objective
		R:objective2 = B:second_objective
		R:ckey = B:brainkey
		for(var/mob/ghost/M in world)
			if(M.realkey == R:ckey)
				del(M)
		R:name = pick("Elektronik", "Terminator", "R2D2", "Brobot", "Optimus Primo", "Megatron X", "Pobeda", "Salut")
		R:realname = R:name
		spawn(0) del(B)
		spawn(0) del(src)
	return



/obj/item/device/brainpod/attack_by(obj/B)











	for(var/mob/M in world)
		if(M.realkey == B:headkey)

			if(!M.client)
				usr << "\red This brain is inactive for some reason!"
				return
			usr << "You put the [B] inside the [src]."
			src.name = "brain pod (with brain)"
			src.brainkey = B:headkey
			src:traitor = B:traitor
			src.cultplayer = B:cultplayer
			src.first_objective = B:first_objective
			src.second_objective = B:second_objective
			src.icon_state = "brainpod_full"
			spawn(0) del(B)
			return










/obj/item/limb/head
	limbroot = "head"
	size = 2
	name = "head"
	icon_state = "gibs"
	var/headkey
	var/cultplayer = 0
	var/traitor = 0
	var/first_objective
	var/second_objective
/obj/item/limb/head
/obj/item/limb/head/attack_by(obj/I)
	if(istype(I, /obj/item/tool/scalpel) || (istype(I, /obj/item/tool/robot/robosaw) || istype(I, /obj/item/tool/saw)))
		new /obj/item/reagent_container/consumable/gland(usr.loc)
		new /obj/item/gib(usr.loc)
		usr << "\blue You cut the [src] apart!"
		var/B = new /obj/item/brain(usr.loc)
		B:cultplayer = src.cultplayer
		B:headkey = src.headkey
		B:traitor = src:traitor
		B:first_objective = src.first_objective
		B:second_objective = src.second_objective
		spawn(0) del(src)
		return

/obj/item/tool/robot
	class = "robot"

/obj/item/tool/robot

/obj/item/tool/robot/robosaw
	icon = 'grafon/device.dmi'
	dmg = 15
	accu = 60
	sharp = 1
	name = "robotic hand saw"
	icon_state = "saw"
	desc = "A special circular saw. Can only be used by robots."

/obj/item/tool/robot/robosaw

/obj/item/tool/robot/robodrill
	icon = 'grafon/device.dmi'
	dmg = 18
	accu = 75
	sharp = 1
	parry = 10
	name = "robotic mining drill"
	icon_state = "drill"
	desc = "A special mining drill. Can only be used by robots."

/obj/item/tool/robot/robodrill

/obj/item/tool/robot/constructing_module
	icon = 'grafon/device.dmi'
	dmg = 8
	accu = 50
	charges = 20
	plastic_need = 5
	metal_need = 5
	name = "robotic constructing module"
	icon_state = "construct"
	desc = "A weird-looking constructing (and deconstructing) device. Can only be used by robots."

/obj/item/tool/robot/constructing_module




/obj/item/tool/robot/constructing_module/attack_by(obj/I)













































	if(istype(I, /obj/item/tool/robot/constructing_module_charge))
		charges += 5
		usr << "\blue [src] now contains [src.charges] charges."
		spawn(0) del(I)

/obj/item/device/e_module/attack_self()































	src.master = input("Type the name of robot's master below:", "Change master", "[usr.name]")


/mob/robot/verb/show_master()






	set name = "Show my master"
	if(usr.master)
		usr << "\red \bold Your current master is [usr.master]. Obey his/her/its commands and don't kill him/her/it if he/she/it don't say you to do so ."
	else
		usr << "\blue \bold You have no master. Enjoy your freedom, damn it!"

/mob/proc/enslavement(obj/E)
	src.master = E:master
	src << "\red<font size = 5>You've been enslaved by [master]!</font>"
	src << "\red<font size = 5>Obey [master]'s commands!</font>"
	src << "\green<font size = 5>Obey [master]'s commands!</font>"
	src << "\blue<font size = 5>Obey [master]'s commands!</font>"
	src << "\yellow<font size = 5>Obey [master]'s commands!</font>"
	src << "\red<font size = 5>Don't kill [master] without [master]'s order, fuck you!</font>"




/obj/machine/node
	density = 1
	var/hacked = 0
	var/charges = 1
	name = "Robotic connection point"
	desc = "A robot-only operating node for accessing station machinery."
	icon_state = "robot_console"







	var/list/oper = new()
/obj/machine/node/New()
	oper.Add("Lights economy (1 charge)", "Close gas tanks (1 charge)", "Close all doors (1 charge)", "Repair (1 charge)", "Station lockdown (2 charges)")
/obj/machine/node/proc/hack()
	if(!hacked)
		hacked = 1
		icon_state = "robot_console_hacked"
		oper.Add("Hack station nodes (1 charge)", "Open all doors (2 charges)", "Disable weapons (2 charges)", "Disable turrets (2 charges)", "Destroy turrets (3 charges)", "Recharge station nodes (4 charges)")
/obj/machine/node/attack_by(obj/item/I)
	if(istype(I, /obj/item/device/consolehack))
		hack()
/obj/machine/node/attack_hand(mob/usr)
	if(!(usr:mat == "plastic"))
		usr << "\red Only robots are able to operate this thing!"
	else


		var/opera = input("What operation would you like to select?", "[charges] charges left", "Lights economy (1 charge)") in oper
		switch(opera)
			if("Lights economy (1 charge)")
				if(charges == 0)
					usr << "\red Not enough charges."
				else
					usr << "\blue Station light consoles are off."
					for(var/obj/comp/lights/L in world)
						if(L.z == 1)
							L.turnoff()
					charges -= 1
			if("Close gas tanks (1 charge)")
				if(charges == 0)
					usr << "\red Not enough charges."
				else
					usr << "\blue Stationary gas tanks are closed."
					for(var/obj/chemical/gastank/G in world)
						if(G.z == 1)
							G.vent_close()
					charges -= 1
			if("Close all doors (1 charge)")
				if(charges == 0)
					usr << "\red Not enough charges."
				else
					usr << "\blue Station doors are closed."
					for(var/obj/door/D in world)
						if(D.z == 1 && (!D.fucked && !istype(D, /obj/door/airlock)))
							D.closed()
					charges -= 1
			if("Repair (1 charge)")
				if(charges == 0)
					usr << "\red Not enough charges."
				else
					usr << "\blue You feel fine."
					usr:heal(100, "brute")
					usr:heal(100, "burn")
					usr:heal(100, "organ")
					charges -= 1
			if("Station lockdown (2 charges)")
				if(charges <= 1)
					usr << "\red Not enough charges."
				else
					for(var/obj/door/D in world)
						if(D.z == 1 && (!D.fucked && !istype(D, /obj/door/airlock)))
							D.closed()
							spawn(0) D.bolt()
					charges -= 2
			if("Station lockdown (2 charges)")
				if(charges <= 1)
					usr << "\red Not enough charges."
				else
					usr << "\blue Emergenecy lockdown protocols activated."
					for(var/obj/door/D in world)
						if(D.z == 1 && (!D.fucked && istype(D, /obj/door/airlock)))
							D.closed()
							spawn(0) D.bolt()
					for(var/obj/chemical/filter/F in world)
						if(F.on == 0)
							F.on = 1
							F.dir = 1
							spawn(10) F.filt()
					charges -= 2
			if("Hack station nodes (1 charge)")
				if(charges == 0)
					usr << "\red Not enough charges."
				else
					usr << "\blue Special protocols enabled for all of the station nodes."
					for(var/obj/machine/node/N in world)
						if(!N.hacked)
							N.hack()
					charges -= 1
			if("Open all doors (2 charges)")
				if(charges <= 1)
					usr << "\red Not enough charges."
				else
					usr << "\blue Station doors are unbolted and opened."
					for(var/obj/door/D in world)
						if(D.z == 1 && !D.fucked)
							if(D.blocked)
								D.unbolt()
							spawn(0)
								if(D.closed)
									D.opened()
					charges -= 2
			if("Disable weapons (2 charges)")
				if(charges <= 1)
					usr << "\red Not enough charges."
				else
					usr << "\blue All non-robotic lethal weapons are out of charge now."
					for(var/obj/item/weapon/gun/blaster/W in world)
						if(!istype(W, /obj/item/weapon/gun/blaster/robot))
							W.charges = 0
					charges -= 2
			if("Disable turrets (2 charges)")
				if(charges <= 1)
					usr << "\red Not enough charges."
				else
					usr << "\blue All station turrets turned off."
					for(var/obj/machine/turret/T in world)
						if(T.z == 1)
							T.on = 0
							T.icon_state = "turret_off"
							icon_state = "t_button_off"
					charges -= 2
			if("Destroy turrets (3 charges)")
				if(charges <= 1)
					usr << "\red Not enough charges."
				else
					usr << "\blue Turrets self-destruction protocols enabled."
					for(var/obj/machine/turret/T in world)
						if(T.z == 1)
							for(var/i = 0, i < 5, i++)
								new /obj/item/debris/machine(locate(T.x + pick(1, 0, -1), T.y + pick(1, 0, -1), z))
							for(var/mob/M in viewers(T))
								M << "\red Boom!"
							T.explosion(0.5)
							spawn(0)
								if(T)
									del(T)

					charges -= 3
			if("Recharge station nodes (4 charges)")
				if(charges <= 3)
					usr << "\red Not enough charges."
				else
					usr << "\blue Some of the node charges transfered to the station nodes."
					for(var/obj/machine/node/N in world)
						if(N.z == 1)
							N.charges += 2
					charges -= 4
/obj/machine/node/hacked
	charges = 5
	name = "Robotic connection point"
/obj/machine/node/hacked/New()
	spawn(0) hack()
