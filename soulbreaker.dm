/obj/overlay/doormelt
/obj/overlay/moustacheless
/obj/overlay/antiabyss
/obj/overlay/hach
/obj/overlay/baryga
/obj/overlay/plant
/obj/overlay/bike
/obj/overlay/mutation
/obj/overlay/collar
	layer = MOB_LAYER + 0.1
	icon = 'grafon/clothing_overlays.dmi'
	icon_state = "collar"
/obj/structure/slbrkr_engine
	var/battery = 0
	var/circuit = 0
	name = "bluespace tunnel plotter"
	icon_state = "slbrkr_engine"
	desc = "A broken engine of a bluespace-travelling spacecraft"
	var/channeling = 0
/obj/structure/slbrkr_tele{var/on = 0; name = "teleporter"; icon_state = "slbrkr_empty"; alticon = "gtele_off"}
/mob/proc/slbrkr_initiate()

	if(!("Soulbreaking" in cfirst))
		cfirst += "Soulbreaking"

	traitorism--
	slbrkr_needed = 0

	var/realfname = pick("Muhammad", "Johar", "Said", "Pharid", "Rashid", "Zurab")
	var/realsname = pick("Dudaev", "Basaev", "Kadhyrof", "Hussein", "Aidamiri", "Jamuhani", "Dhaurbekan")
	src.realname = "[realfname] [realsname]"
	src.name = src.realname

	src.update_sprite()
	src.slbrkr = 1
	prof = null
	for(var/obj/landmark/slbrkr_start/SS in world)
		src.loc = SS.loc
	src << "\red \bold OH ALMIGHTY ALLAH WHERE AM I "
	spawn(10)
		src << "\blue You're a soulbreaker, both a slaver and a slave to ungraciously Allah."
		src << "\blue You have tried to use a chain of bluespace sleeves for escape purposes."
		src << "\blue Hovewer, at some point your bluespace drive've run out of energy, so you've tried to channel some power from outer sources."
		src << "\blue It was a bad idea."
		src << "\blue One of those 'sources' was a local Shaitan, respected as a god by some of the infidels."
		src << "\blue Now all of your brothers are dead and you're trapped at a spartial pocket."
		src << "\blue \bold Your goal is to capture at least [slaves_required] slaves by the usage of your bluespace-based tele and enslavement collars as well as remake your engine using local non-bluespace teleportation technology."
		spawn(20)
			src << ""
		src << "\blue \bold There's no god but The Ungraciously One."

/mob/proc/enslave()


	src << "\red \bold OH FUCK WHAT DA FUKK IS THIS THING"
	src.collar = 1
	src.stun(2)
	var/C = new /obj/overlay/collar(src)
	C:layer = -2
	src.overlays += C

/mob/proc/deslave()

	src.collar = 0
	for(var/obj/overlay/collar/C in src.overlays)
		src.overlays -= C
	spawn(0)
		src.update_sprite()

/mob/proc/enstun()


	src << "\red \bold OH FUCK WHAT DA FUKK IS THIS THING"
	src.stuncollar = 1
	src.stun(2)
	var/C = new /obj/overlay/collar(src)
	C:layer = -2
	src.overlays += C

/mob/proc/destun()

	src.stuncollar = 0
	for(var/obj/overlay/collar/C in src.overlays)
		src.overlays -= C
	spawn(0)
		src.update_sprite()



/obj/structure/slbrkr_tele/Cross(atom/movable/A)








	..()
	if(src.on == 1)
		for(var/obj/structure/slbrkr_out/T in world)
			A:loc = locate(T.x, T.y, T.z)
			new /obj/effect/sparks(A:loc)
			if(istype(A, /mob))
				var/M = A
				if(M:slbrkr)
					break


/obj/structure/slbrkr_out/Cross(atom/movable/A)





	..()
	for(var/obj/structure/slbrkr_tele/T in world)
		A:loc = locate(T.x, T.y, T.z)
		new /obj/effect/sparks(A:loc)
		break


/obj/structure/slbrkr_console/attack_hand(mob/M)




	if(M:stunned)
		return

	var/pingas = 0

	for(var/obj/wire/battery/B in src.loc)
		if(B.energy)
			pingas = 1
			B.energy--


	if(pingas)

		M << "\blue You feel an unbearable weight of Allah's clawed hand on your shoulder."
		M:stun(5)

		if(M:slbrkr)
			spawn(50)
				for(var/obj/structure/slbrkr_tele/S in range(2, src))
					if(!S.on)
						if(prob(50))
							M << "\blue Looks like it finally works."
							S.on = 1
							S.icon_state = "slbrkr_frame"
							var/L = list()
							for(var/obj/landmark/klad/K in world)
								L += K
							spawn(0)
								var/obj/landmark/klad/KL = pick(L)
								new /obj/structure/slbrkr_out(KL:loc)
						else
							M:torment(3)
							M << "\red This thing refuses to work. Probably, you should try again."
					else

						S.on = 0
						S.icon_state = "slbrkr_empty"
						for(var/obj/structure/slbrkr_out/SO in world)
							del(SO)
							return
		else
			M << "\red \bold Suffer now, you infidel one!"
			M:torment(10)
	else

		M << "\red It is out of power!"
		return


/obj/structure/slbrkr_engine/attack_hand()














	if(!src.battery)
		usr << "\red This thing requires some kind of power storage"
	else
		if(!src.circuit)
			usr << "\red This thing requires some kind of non-bluespace 'teleportation' circuitry. Maybe a motherboard of one of those infidels teleporter comp?"
		else
			if(!src.channeling)
				usr << "\red This thing requires some kind of bait for local Jinns, Daevas or Shaitans. Infidels sometimes bear weird devices (sometimes they even hotwire them into their foolish brains!) working on pleasure. You have to use one of this strange artifacts"
			else


				if(usr.client)
					var/B = new /obj/hud_effect/blues()
					usr.client.screen += B
					usr << "\blue Now... prepare for a ride!"

				ragnarok()

/obj/structure/slbrkr_engine/attack_by(obj/I)

	if(!src.battery && (istype(I, /obj/item/battery) || (istype(I, /obj/item/tool/pulse) || istype(I, /obj/item/material/core))))

		usr << "\blue Well, now your engine have a power storage unit"
		src.battery = 1
		spawn(0) usr.delitem()

	if(!src.circuit && istype(I, /obj/item/electronics/board/tele))

		usr << "\blue Well, now your engine have some kind of circuitry"
		src.circuit = 1
		spawn(0) usr.delitem()

	if(!src.channeling && (istype(I, /obj/item/device/seeker_raw) || (istype(I, /obj/item/device/brainport/seeker) || (istype(I, /obj/item/device/brainport/tantric) || istype(I, /obj/item/electronics/tantric)))))

		usr << "\blue Well, now you're able to channel energy of local Jinns straight into your engine. Some of the locals use those weird things hotwiring into one's brain. I think they'll fit"
		src.channeling = 1
		spawn(0) usr.delitem()





/obj/item/key/slbrkr/New()



	src:access:Add("slbrkr")

/obj/item/key/slbrkr_main/New()



	src:access:Add("primary", "engineer", "command", "external", "circuit")



/obj/item/collar/attack(atom/A)













	if(istype(A, /mob))
		if(A == usr && usr.slbrkr)
			A << "\red No, you can't enslave yourself. You're only slave to the Ungrateful"
			return
		var/M = A
		if(M:mat == "flesh" && (M:class == "man" && (M:stunned && !M:dead)))
			M:show_message("\red [usr.name] tries to put [src.name] on [M:name] neck!", "\red \bold OH NO NONONONONO")
			if("chromosome" in M:mutations)
				M:show_message("\red \bold Looks like [M:name] is resistant to stuff like this, however.")
				return
			spawn(40)
				usr << "\red You enslave some infidel with the collar!"
				if((usr in range(1, M)) && src == usr.item)
					M:enslave()
					src.loc = M
					usr.delitem()

/obj/item/stuncollar/attack(atom/A)












	if(istype(A, /mob))
		if(A == usr)
			A << "\red Nope."
			return
		var/M = A
		if(M:mat == "flesh" && (M:class == "man" && !M:dead))



			M:show_message("\red [usr.name] tries to put [src.name] on [M:name] neck!", "\red \bold OH NO NONONONONO")
			usr << "\red You try to put a stuncollar on some criminal scum!"
			spawn(30)
				usr << "\red You put the stuncollar on [M:name] neck!"
				if((usr in range(1, M)) && src == usr.item)
					src.loc = M
					M:enstun()
					M:stun(1)
					usr.delitem()

/mob/verb/remove_collar()
	set name = "Remove stuncollar"
	set category = "Commands"
	for(var/mob/M in view(1, usr))
		if(M != src && (M.stuncollar || M.collar))
			usr.show_message("\blue [usr.name] removes collar from [M.name]!")
			if(M.stuncollar)
				src << "\blue \bold OH FUCK YEA FREEDOM"
				show_message("\blue [src.name] is no longer enslaved!")
				M.destun()
			else
				src << "\blue \bold OH FUCK YEA FREEDOM"
				show_message("\blue [src.name] is no longer enslaved!")
				M.deslave()

/proc/ragnarok()
















	invasion()
	worldhaunt()
	worldputin()
	popobawa()

	bluespace_shifted = 1

	if(!("Bluespace-rape" in csecond))
		csecond += "Bluespace-rape"

	spawn(50)

		for(var/obj/landmark/dobspawn/L in world)
			new /mob/stalin/veteran(L.loc)

		for(var/obj/landmark/klad/L in world)
			new /mob/stalin/veteran(L.loc)

		for(var/obj/landmark/eye/L in world)
			new /mob/stalin/veteran(L.loc)


		for(var/mob/M in world)
			M << "\red \bold<font size = 5>MASSIVE BLUESPACE SLEEVE VERMINATION INCOMING. PLEASE STAY CALM</font>"
			M << "\red \bold<font size = 5>MASSIVE DEMONIC INTERVENTION INCOMING. PLEASE STAY CALM</font>"
			M << "\red \bold<font size = 5>OH FUCK FUCK FUCK</font>"




		spawn(10)
			roundend()
