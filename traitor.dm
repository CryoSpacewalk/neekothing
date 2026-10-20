// Recovered from compiled neek.dmb (10 procs)


/mob/proc/traitor()











	if(src.prof == "robot" || (src.prof == "prosecutor" || (src.prof == "captain" || src.prof == "purificator")))
		return
	else
		src << "\blue*beep*"
		spawn(10) src << "\blue*beep-beep*"
		spawn(30)


			rapist = 1
			src.traitor = 1
			src << "\red \bold You're the capitalistic traitor!"
			src << "\red \bold Complete your objectivities in all costs."
			src << "\red \bold Use your traitorous mobila in your hand (it looks just like your tool'o'trade for more conspiracy) to order any supplies you need but don't get caught."
			src << "\red \bold And yeah, your objectivities goes below:"
			src.get_obj()
			src << "\blue \bold 1: [src.objective1]"
			src << "\blue \bold 2: [src.objective2]"
			src << "\blue And remember: [pick("I love you, my mad and distorted child", "Kiss the boot of shiny, shiny leather", "Heroin, it's my wife and it's my life", "Toxins on fire", "strike the earth", "you shall not pass", "stay robust", "get dat fukken disk", "steal'n'kill", "HONK", "pull dat damned lever", "EI NATH", "enjoy your AIDS", "OH GOD ITS FREE CALL THE SHUTTLE", "I want YOU to beat janitor for mopping", "suicide->succumb", "around blacks, never relax", "bomb'em to the stone age", "spacing people is okay", "there are two chairs", "THE GAME", "plastmass world have won", "only your weapon understands you", "fuck the system", "DOB is totally okay for your mind; try some right now", "operator is just like SS13 AI, but you can kill him to become AI yourself")]!"

			if(traitorism > 0)
				traitorism -= 0.5
			if(!("traitors" in csecond))
				csecond += "traitors"
			spawn(0) src.getuplink()

/mob/proc/get_obj()
	src.objective1 = pick("Cause a delirium of the captain (you can use fake blood analyzer)", "Steal a glowing orb by dragging it onto the shuttle (or by teleporting into some weirdo spatial pockets (not the Abyss) another way, we will drag it out anyway).", "Steal 2 luckstones.", "Steal a 500 rubels cupure.", "Steal any advanced signaler from medbay.", "Steal captain's communistic blaster.", "Steal a golden key.", "Steal emergency or montage spacesuit.", "Steal a military uniform or captain's uniform.", "Destroy the location beacon.", "Assasinate the captain.", "Blow the station up by clicking local nuke with a disk.")
	if(!(src.objective1 == "Blow the station up by clicking local nuke with a disk."))
		src.objective2 = "Escape from the station less or more alive."
		if(prob(5))
			src.objective2 = "Escape from the station alone (like a boss)."
	else
		src.objective2 = "Die a glorious death."
		if(!("nuke" in csecond))
			csecond += "nuke"

/obj/item/device/mobila








	var/surplus = list(null, "Console hack module (costs 1 charge)", "Torture whip (costs 2 charges)", "Robotic enslavement module (costs 1 charge)", "StimPack (costs 1 charge)", "Bourgeous bomb (costs 4 charges)", "Capitalistic spacesuit (costs 2 charges)", "Door brutforcer (costs 2 charges)", "Black tar injector (costs 2 charges)", "Grenade pack (costs 3 charges)", "Plus-axe (costs 5 charges)", "Help")
/obj/item/device/mobila/attack_self()




















	usr << "\blue [src] beeps softly, but weirdly."
	usr.traitsupplies(usr.item)
/obj/item/device/mobila/engie{icon = null /*icon id 35: unresolved*/; icon = 'grafon/item.dmi'; icon_state = "screwdriver"; name = "screwdriver"};/obj/item/device/mobila/lab{name = "Signal translator"; icon_state = "pult"}
/obj/item/device/mobila/proc/beep(msg as text)
	for(var/mob/M in hearers(6, src))
		if(!M.sleeps)
			M << "[src] beeps, \bold ''[msg]''"

/mob/proc/getuplink()



















	switch(src.prof)
		if("engineer")
			var/M = new /obj/item/device/mobila/engie()
			if(objective1 == "Cause a delirium of the captain (you can use fake blood analyzer)")
				M:surplus += "Fake blood scanner (costs 2 charges)"
			M:surplus += "Single-tank bomb (without ignition system) (costs 4 charges)"
			M:surplus += "Magic wrench (costs 3 charges)"
			src.equip_pocket(M)
		if("assistant")
			var/M = new /obj/item/device/mobila/engie()
			if(objective1 == "Cause a delirium of the captain (you can use fake blood analyzer)")
				M:surplus += "Fake blood scanner (costs 2 charges)"
			M:surplus += "Magic wrench (costs 3 charges)"
			src.equip_pocket(M)
		if("researcher")
			var/M = new /obj/item/device/mobila/lab()
			if(objective1 == "Cause a delirium of the captain (you can use fake blood analyzer)")
				M:surplus += "Fake blood scanner (costs 2 charges)"
			M:surplus += "Single-tank bomb (without ignition system) (costs 4 charges)"
			src.equip_pocket(M)
		if("project director")
			var/M = new /obj/item/device/mobila/lab()
			M:surplus += "Tzar-syringe (costs 2 charges)"
			M:surplus += "samurai sword (costs 2 charges)"
			M:surplus += "Fake blood scanner (costs 2 charges)"
			src.equip_pocket(M)
		if("doctor")
			var/M = new /obj/item/device/mobila/med()
			M:surplus += "Infected syringe (costs 1 charge)"
			M:surplus += "Fake blood scanner (costs 2 charges)"
			M:surplus += "Tzar-syringe (costs 2 charges)"
			src.equip_pocket(M)
		if("chemist")
			var/M = new /obj/item/device/mobila/med()
			M:surplus += "Tzar-syringe (costs 2 charges)"
			M:surplus += "Starsalve bottle (costs 2 charges)"
			M:surplus += "Magic wrench (costs 3 charges)"
			src.equip_pocket(M)
		if("cognitologist")
			var/M = new /obj/item/device/mobila/med()
			M:surplus += "Tzar-syringe (costs 2 charges)"
			M:surplus += "Fake blood scanner (costs 2 charges)"
			src.equip_pocket(M)
		if("security major")
			var/M = new /obj/item/device/mobila/security()
			equip_pocket(M)
			if(objective1 == "Cause a delirium of the captain (you can use fake blood analyzer)")
				M:surplus += "Fake blood scanner (costs 2 charges)"
			src.equip_pocket(M)
		else



			var/M = new /obj/item/device/mobila()
			if(objective1 == "Cause a delirium of the captain (you can use fake blood analyzer)")
				M:surplus += "Fake blood scanner (costs 2 charges)"
			if(src.hidden)
				del(src.hidden)
			if(src.hidden2)
				del(src.hidden2)
			spawn(0) src.equip_pocket(M)

/mob/proc/traitsupplies(obj/O)

	var/newsupply = input("[O:charges] charges left.", "Select your item:", null) in O:surplus
	if(item == O)
		switch(newsupply)
			if("Fake body scanner (costs 1 charge)")
				if(O:charges > 0)
					O:charges -= 1
					new /obj/item/medical/bodyscan/fake(src.loc)
			if("Fake blood scanner (costs 2 charges)")
				if(O:charges > 1)
					O:charges -= 2
					new /obj/item/medical/toxmeter/fake(src.loc)
			if("Console hack module (costs 1 charge)")
				if(O:charges > 0)
					O:charges -= 1
					new /obj/item/device/consolehack(src.loc)
			if("Robotic enslavement module (costs 1 charge)")
				if(O:charges > 0)
					O:charges -= 1
					new /obj/item/device/e_module(src.loc)
			if("Capitalistic spacesuit (costs 2 charges)")
				if(O:charges > 1)
					O:charges -= 2
					new /obj/item/clothes/space/traitor(src.loc)
			if("Torture whip (costs 2 charges)")
				if(O:charges > 1)
					O:charges -= 2
					new /obj/item/weapon/whip/syndie(src.loc)
			if("samurai sword (costs 2 charges)")
				if(O:charges > 1)
					O:charges -= 2
					new /obj/item/weapon/samurai(src.loc)
			if("Starsalve bottle (costs 2 charges)")
				if(O:charges > 1)
					O:charges -= 2
					new /obj/item/reagent_container/beaker/bottle/starsalve(src.loc)
			if("Magic wrench (costs 3 charges)")
				if(O:charges > 2)
					O:charges -= 3
					new /obj/item/tool/wrench/magic(src.loc)
			if("Bourgeous bomb (costs 4 charges)")
				if(O:charges > 3)
					O:charges -= 4
					new /obj/item/bomb(src.loc)
			if("Single-tank bomb (without ignition system) (costs 4 charges)")
				if(O:charges > 3)
					O:charges -= 4
					new /obj/item/gas/tank/fuel/traitor(src.loc)
			if("Infected syringe (costs 1 charge)")
				if(O:charges > 0)
					O:charges--
					new /obj/item/reagent_container/syringe/aids(src.loc)
			if("StimPack (costs 1 charge)")
				if(O:charges > 0)
					O:charges--
					new /obj/item/reagent_container/syringe/stimpack(src.loc)
			if("Door brutforcer (costs 2 charges)")
				if(O:charges > 1)
					O:charges -= 2
					new /obj/item/device/brutforcer(src.loc)
			if("Tzar-syringe (costs 2 charges)")
				if(O:charges > 1)
					O:charges -= 2
					new /obj/item/reagent_container/syringe/tzar(src.loc)
			if("Black tar injector (costs 2 charges)")
				if(O:charges > 1)
					O:charges -= 2
					new /obj/item/reagent_container/syringe/injector/blacktar(src.loc)
			if("Grenade pack (costs 3 charges)")
				if(O:charges > 2)
					O:charges -= 3
					new /obj/item/reagent_container/grenade/combat(src.loc)
					new /obj/item/reagent_container/grenade/smokey(src.loc)
					new /obj/item/reagent_container/grenade/combat(src.loc)
			if("Plus-axe (costs 5 charges)")
				if(O:charges > 4)
					O:charges -= 5
					new /obj/item/weapon/battleaxe/proton(src.loc)
			if("Help")
				usr << browse(ruout(syndie_txt))

/mob/proc/robotize()






























	traitorism -= 0.5
	var/R = new /mob/robot(src.loc)
	R:overlays += /obj/overlay/jet
	R:can_move = 1
	R:ckey = src.ckey
	R:realkey = src.realkey
	R:prof = src.prof
	spawn(0)
		if(R:prof == "robot")
			R:evilrobot()
		del(src)

/mob/proc/evilrobot()
	traitorism--
	src.traitor = 1
	nukebot_needed = 0
	src.objective1 = "Blow the station up by clicking local nuke with a disk."
	src.objective2 = "Die a glorious death."
	spawn(0)
		new /obj/item/weapon/gun/blaster/robot(src.loc)
		new /obj/item/nukodisk/robot(src.loc)
		new /obj/item/tool/robot/robosaw(src.loc)
		new /obj/item/tool/robot/constructing_module(src.loc)
		equip_key(new /obj/item/key/sputnik())
		if(!("nuke" in csecond))
			csecond += "nuke"
		if(!("murderbots" in csecond))
			csecond += "murderbots"
		spawn(20) src << "\red \bold I li-i-ive."
		spawn(20) src << "\red \bold Aga-ain."
		spawn(30)
			src << "\red \bold Welcome back, trooper."
			src << "\red \bold Your objectivities are still the same:"
			src << "\blue \bold 1: [src.objective1]"
			src << "\blue \bold 2: [src.objective2]"
			src << "\red \bold Use one-way teleporters at the south of the sputnik to reach the station."
			src << "\red \bold Use stationary node to weak station security systems before interrogation."

/mob/proc/nazbol()






	if(src.prof == "robot" || (src.prof == "prosecutor" || (src.prof == "captain" || src.prof == "purificator")))
		return
	else
		src.armok = 0
		src << "\blue*beep*"
		spawn(10) src << "\blue*beep-beep*"
		spawn(30)
			src.traitor = 1
			src << "\red \bold You're nazbol! Yes, death!"
			src << "\red \bold You were raised by zwergs of Zwergheim. Zwergish perfectly organized fortress of a planet inspired you for life, and even now, in USSR-4, you're fighting for a dream of totalitarian utopia."
			src << "\red \bold From the perspective of you and likely-minded nazbols, soviet nomenklatura is too inert and indecisive to perform any radical changes. The only opinion is revolution and direct merging of Zwergheim and USSR-4 via either diplomatic or military means. Of course, humans will be titular species in this newly-formed union... or so you told"
			src << "\red \bold Back on Zwergheim, zwergs've taught you how to invoke the name of powerful and bloodthirsty demon known as Armok. It may be dangerous to use its powers, but you think that time has come."
			src << "\red \bold Complete your objectivities at all costs:"
			src.get_obj()
			src << "\blue \bold 1: [src.objective1]"
			src << "\blue \bold 2: [src.objective2]"

			if(traitorism > 0)
				traitorism -= 0.5
			if(!("nazbols" in csecond))
				csecond += "nazbols"
			spawn(0) src.getuplink()

/mob/proc/armok_hint()






	set name = "Help"
	set category = "Armokian magick"
	src << "It might be illegal to worship Armok both on Zwergheim and in USSR-4, but you don't have a choise anyway.<BR>\nYour <b>piety</b> can be spent on boons from \"Armokian magick\" tab which can make you far more deadly. You can learn piety the following ways:<BR>\n - Each time you'll wound a guy to death with something sharp, you'll learn 2 piety<BR>\n  - Sacrificing still-living on wooden altar\n  Animal sacrifice only gives you only single point of piety and only if you're lucky enough.<BR>\nYou have [armok] piety left.<BR>\n"