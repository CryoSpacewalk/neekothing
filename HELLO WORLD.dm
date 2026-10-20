// Recovered from compiled neek.dmb (15 procs)

/obj/beacon
	icon = 'grafon/structure.dmi'
	name = "location beacon"
	desc = "A communication beacon, used to locate a station in the void of Heart of Fours."
	icon_state = "capbeacon"
	var/captain = 0
	var/director = 0
	var/chief = 0
	var/operator = 0
	var/psychiatrist = 0
	var/purificator = 0
	var/prosecutor = 0
	var/hepe = 50

/obj/beacon

/obj/beacon/attack_by(obj/I)





















	for(var/mob/M in view(src))
		M << "\red [usr] smashes [src] with [I]!"
	if(I:dmg >= src.hepe)
		if(!"[usr.realname] fucks up the employment beacon with his [I:name]" in funfacts)
			funfacts += "[usr.realname] fucks up the employment beacon with his [I:name]"
	src.damage(I:dmg)

/obj/beacon/proc/damage(dmg)
	if(dmg >= src.hepe)
		src.hepe = 0
		src.malf()
	else
		src.hepe -= dmg

/obj/beacon/proc/malf()
	if(0 in funfacts)
		funfacts += "the employment beacon was fucked this round"
	for(var/mob/M in viewers(src))
		M << "\red [src]'s behavior goes weird...."
	src.captain = 666
	src.director = 666
	src.chief = 666
	for(var/obj/comp/ordering/O in world)
		O.show_message("\red \bold [O.name] explodes!")
		spawn(0)
			O.fuckup()
			spawn(0)
				O.explosion(1)
	for(var/obj/item/device/caller/CR in world)
		CR.show_message("\red \bold [CR.name] behaves itself weird...")
		spawn(0)
			CR.blink(8)
	src.icon_state = "capbeacon_broken"
	src.desc = "It looks broken."

	sleep(0)
	station_alert("Due to location beacon malfunction, we are starting to loose a track of your station complex. Evacuation procedures are initiated.")
	spawn(30)
		shuttlecall()
		forceshut = 1

/obj/capspawn
	icon = 'grafon/structure.dmi'
	var/captain = 0
	name = "Captain's chair"
	icon_state = "capchair"

/obj/capspawn


/obj/capspawn/attack_by(obj/A, mob/user)
	if(istype(A, /obj/item/tool/hammer))

		user << "You change the direction of [src]."
		src.dir = turn(src.dir, 90)
/obj/furniture
	icon = 'grafon/furniture.dmi'
	var/mat = 1
	var/infested = 0
	var/glows = 0
/obj/furniture
	anchored = 1
	bomb_proof = 20
	wrenchable = 1
/obj/furniture/table
	density = 1
	layer = 2.6
	icon_state = "table"
	alticon = "gtable"
	mat = 2
	var/altar = 0
/obj/furniture/shkonka{icon_state = "shkonka"; desc = "A cozy shkonar for crawling under it."}
/obj/furniture/attack_by(obj/I, mob/user)

	if(istype(I, /obj/item/cable))
		src.tieto(I, user)
	else if(istype(I, /obj/item/tool/hydraulic_cutters) || (istype(I, /obj/item/tool/axe) || (istype(I, /obj/item/weapon/battleaxe) || (istype(I, /obj/item/tool/saw) || istype(I, /obj/item/tool/robot/robosaw)))))
		user << "\blue You cut [src.name] apart!"

		if(infested)
			show_message("\red \bold A swarm of caphopper ticks emerges from [src.name]!")
			new /obj/bio/tick_swarm(src.loc)

		if(src:glows)
			src.sd_SetLuminosity(0)

		var/B = new /obj/item/material/board(src.loc)
		B:charges = mat
		spawn(0)
			del(src)
			return
	else if(istype(I, /obj/item/tool/hammer))

		user << "You change the direction of [src]."
		src.dir = turn(src.dir, 90)
	else

		user:dropitem()
		I:loc = src.loc

/obj/nuka
	density = 1
	icon = 'grafon/structure.dmi'
	name = "Kuzka's mother"
	icon_state = "nuka"

/obj/nuka
	wrenchable = 1
/obj/nuka/main
	name = "Kuzka"
	icon_state = "nuka_2"

/obj/nuka/main

/obj/nuka/attack_by(obj/I)

	if(istype(I, /obj/item/nukodisk) || istype(I, /obj/item/nukodisk/robot))

		if(!"[usr.realname] blew up a nuke this round" in funfacts)
			funfacts += "[usr.realname] blew up a nuke this round"

		usr << "\red You activate the nuke."
		src.explosion(25)
		nuked = 1
		world << "\red Boom."
		src.invisibility = 101

		sleep(80)
		for(var/turf/T in range(80, src))
			if(prob(5))
				var/R = new /obj/effect/rad(T)
				for(var/mob/M in viewers(R))
					M << "\blue Those lights looks so weird."
					if(prob(100 - M.energyprotect * 8))
						if(("eye0" in M.mutations || "tumor_eye") in M.mutations)
							M << "\red \bold Your mutation-grown eyes hurt!"
							M.damaga(2, pick("burn", "organ"))
							if(prob(50))
								M.torment(3)
						if("eye1" in M.mutations)
							M << "\red \bold Your mutation-grown eyes hurt a lot!"
							M.damaga(8, pick("burn", "organ"))
							M.torment(4)
						if(M.mat == "flesh" && (M.class == "man" && prob(66)))
							spawn(3) M.randommut()
						sleep(50)
						if(M.mat == "flesh" && (M.class == "man" && prob(40)))
							M.randommut()

		sleep(0)
		station_alert("An unexpected usage of nuclear charge is detected on your station complex. Evacuation procedures are initiated.")
		spawn(30)
			forceshut = 1
			shuttlecall()

		sleep(0)
		del(src)





/client/Move(durr)
	if(src.camera_anchor)

		var/anchor_dir = get_dir(mob:loc, durr)

		step(src.camera_anchor, anchor_dir)
		if(istype(src.camera_anchor, /obj/structure/camera))
			src.observe_target(src.camera_anchor)
		if(!(src.camera_anchor in view(src.eye)))
			src << "\red ЕГГОГ: OUT OF CAMERA REACH"
			src.camera_anchor = null
		return 1



	if(src.controlsfuck && !src.reversd)
		src.reversd = 1
		src.reversal(durr)

	src.reversd = 0

	if(mob:stunned == 0)


		if(src.mob.collar)
			src << "\red Your collar reacts to your attempts to move."
			src.mob.stun(1)
		else
			if(("hui" in mob:mutations) && prob(1))
				src.mob << "\red You stumble on your giant [reverse_text("sinep")] and fall!"
				mob:stun(1)
			else
				if(prob((src.mob.drunk - 1) * 15))
					step(src.mob, pick(1, 2, 8, 4))
				else

					src.mob.Move(durr)
	else
		return

/client/Northeast()
	return
/client/Northwest()
	return
/client/Southeast()
	return
/client/Southwest()
	return

/mob/robot
	icon = 'grafon/robot.dmi'
	mat = "plastic"
	can_move = 0
	class = "robot"
	chemprotect = 5
	heatprotect = 10
	energyprotect = 8
	empowered = 2


	limbs = list(new /obj/limb/robot/r_hand, new /obj/limb/robot/l_hand, new /obj/limb/robot/r_leg, new /obj/limb/robot/l_leg); name = "Spess crawler";icon_state = "pod"
/mob/robot/New()
	src.name = pick("S.H.O.D.A.N.", "M.A.L.F.", "G.L.A.D.O.S.", "Skynet", "ЯМ", "T-34", "Hoborg", "Klaymen", "Big robot Bill")
	src.realname = src.name
	src.verbs -= powahs
/mob/robot/attack_by(obj/I)

	if(istype(I, /obj/item/device/jet) && src.can_move == 0)
		usr << "\blue You connect some jets to the robotic frame."
		src.can_move = 1
		src.overlays += /obj/overlay/jet
		spawn(0) del(I)

/obj/statue
	density = 1
	icon = 'grafon/structure.dmi'
	name = "=statue="
	icon_state = "statue"
	desc = "An ice statue of a short beardy humanoid."

/obj/statue
	bomb_proof = 75
	wrenchable = 1
/obj/statue/New()





	name = pick("-statue-", "=statue=", "*statue*")

/obj/statue/abyss
	desc = "An ice statue of... what?"
	icon_state = "statue_abyss0"

/obj/statue/abyss
