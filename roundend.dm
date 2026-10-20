var/onhold = 0
var/secsleft = 300
var/capdead = 0
var/nuked = 0
var/forceshut = 0
var/slbrkr_needed = 1;var/slaves_required = 2
/proc/escape()
	spawn(0)
		for(var/atom/movable/M in locate(/area/escape))
			M.loc = locate(M.x - 7, M.y + 20, 2)
	for(var/turf/T in locate(/area/escape))
		T.spacize()
	spawn(5)
		world << "\blue \bold The escape shuttle has moved!"
		spawn(15) roundend()
var/bluespace_shifted = 0;var/traitorism = 2;var/capdelirium = 0;var/nukebot_needed = 1;var/collector = /obj
/proc/shuttlecall()
	world << "\blue \bold Emergency evacuation initiated. You have ten minutes to get to the shuttle."
	onhold = 1
	spawn(10)
		shuttlecount()

/proc/shuttlecount()
	if(onhold == 0)
		secsleft = 300
		return
	else if(secsleft == 0)
		escape()
		return
	else
		secsleft -= 1
		sleep(10)
		spawn(0) shuttlecount()
		return

/proc/shuttlerecall()
	world << "\blue \bold Emergency evacuation cancelled."
	onhold = 0

/proc/roundend()


















	playmuzlo = 1
	if(prob(50))
		world << sound('shuttle.midi', 0, 0, 666, 40)
	else
		world << sound('Ren and Stimpy - Ending.midi', 0, 0, 666, 40)
	var/clt = 0
	for(var/mob/M in world)
		if(M.cultplayer && M.mat == "flesh")
			world << "\red \bold The infernal stalinist was [M.name]."
			clt = 1
	if(clt)
		world << ""
		if(stalin_summoned)
			world << "\green This personality cult successed!"
		else
			world << "\red This personality cult fails to assemble comrade Stalin avatara in the midworld!"

	for(var/mob/M in world)

		if(M:client)

			if(M:client:mule)

				var/h_amt = 0

				for(var/obj/item/reagent_container/RC in M)

					if(RC)

						for(var/datum/reagent/RE in RC.reagent_list)
							if(RE.name == "heroin")
								h_amt += RE.amount
								world << "[h_amt]"

				world << ""
				world << "\red \bold [M.name] was drug mule in disguise!"
				if(M:z != 2 || M:dead)
					world << "\red \bold The guy've failed to escape on the shuttle!"
				else if(h_amt >= 2.4)
					world << "\green \bold The guy have successfully delivered 2.4pts of heroin onto evacuation point!"
				else if(h_amt > 0)
					world << "\red \bold [M.name] have delivered only [h_amt]pts of heroin instead of 2.4! The guy is fucked!"
				else
					world << "\red \bold [M.name] have lost, sold or used all of his heroin! The guy is fucked!"

		if(M:baryga)
			world << ""
			world << "\red \bold The abyssal-crawling drugdealer (a.k.a. baryga) was [M.name]."

			for(var/obj/item/device/communicator/baryga/B in world)
				if(B.money >= 1500)
					world << "\green \bold The baryga amassed [B.money] cherenkovs (which is a lot!) and thinks what this station complex is a good partner in trading (or a good raiding point)."
				else
					world << "\red \bold The baryga amassed only [B.money] cherenkovs, which is not enough for him to be swaggy all around. In short, HE FAILED."


		if(M:slbrkr)
			var/slavez = 0
			for(var/mob/MB in world)
				if(MB:collar && (MB:z == 2 && MB:class == "man"))
					slavez++
			world << ""
			world << "\red \bold The soulbreaker was [M.name]."
			world << "\red \bold He captured [slavez] slaves."
			if(bluespace_shifted)
				if(slavez >= slaves_required)
					world << "\green He is on his way back to his galaxy cluster with enough slaves to trade for spaceship repair! Lucky one!"
				else
					world << "\red While soulbreaker has finished his engine, he has failed to capture enough (at least [slaves_required]) slaves! Shame on him!"
			else
				world << "\red The soulbreaker has failed to finish his warp engine!"

		if(M:traitor)
			world << ""
			world << "\red \bold The traitor was [M.name] (played by [M:ckey])!"
			world << "\blue \bold His/her/its objectives were:"
			world << "\blue \bold 1. [M:objective1]"
			world << "\blue \bold 2. [M:objective2]"
			switch(M:objective1)
				if("Steal a glowing orb by dragging it onto the shuttle (or by teleporting into some weirdo spatial pockets (not the Abyss) another way, we will drag it out anyway).")
					for(var/obj/glower/G in world)
						if(G.z == 2)
							M:objective1 = 1
				if("Destroy the location beacon.")
					for(var/obj/beacon/B in world)
						if(B:captain >= 666)
							M:objective1 = 1
				if("Cause a delirium of the captain (you can use fake blood analyzer)")
					if(capdelirium)
						M:objective1 = 1
				if("Steal any advanced signaler from medbay.")
					for(var/obj/item/device/signaler/adv/A in M)
						if(A)
							M:objective1 = 1
				if("Steal captain's communistic blaster.")
					for(var/obj/item/weapon/gun/blaster/red/captain/C in M)
						if(C)
							M:objective1 = 1
				if("Steal a golden key.")
					for(var/obj/item/key/captain/C in M)
						if(C)
							M:objective1 = 1
				if("Steal emergency or montage spacesuit.")
					if(istype(M:clothes, /obj/item/clothes/space/tech) || (istype(M:r_hand, /obj/item/clothes/space/tech) || (istype(M:l_hand, /obj/item/clothes/space/tech) || (istype(M:clothes, /obj/item/clothes/space) || (istype(M:r_hand, /obj/item/clothes/space) || istype(M:l_hand, /obj/item/clothes/space))))))
						M:objective1 = 1
				if("Steal a military uniform or captain's uniform.")
					if(istype(M:clothes, /obj/item/clothes/military) || (istype(M:r_hand, /obj/item/clothes/military) || istype(M:l_hand, /obj/item/clothes/military)))
						M:objective1 = 1
				if("Steal a 500 rubels cupure.")
					for(var/obj/item/cash/fivehut/F in M)
						if(F)
							M:objective1 = 1
				if("Steal 2 luckstones.")
					var/lcount = 0
					for(var/obj/item/reagent_container/consumable/pill/luckstone/L in M)
						if(L)
							lcount++
					if(lcount >= 2)
						M:objective1 = 1
				if("Assasinate the captain.")
					if(capdead == 1)
						M:objective1 = 1
				if("Blow the station up by clicking local nuke with a disk.")
					if(nuked == 1)
						M:objective1 = 1
			switch(M:objective2)
				if("Escape from the station less or more alive.")
					if(M:z == 2 && M:dead == 0)
						M:objective2 = 1
				if("Escape from the station alone (like a boss).")
					for(var/mob/E in world)
						if((!(E.z == 2) || E.dead == 0) && (!(E == M) && (M:z == 2 && !(M:dead == 0))))
							M:objective2 = 1
				if("Die a glorious death.")
					if(M:dead == 1)
						M:objective2 = 1
			world << ""
			switch(M:objective1)
				if(1)
					world << "\green First objective was accomplished."
				if(0)
					world << "\red First objective was failed!"
			world << ""
			switch(M:objective2)
				if(1)
					world << "\green Second objective was accomplished."
				if(0)
					world << "\red Second objective was failed!"
			world << ""
			if(M:objective1 == 1 && M:objective2 == 1)
				world << "\green \bold The traitor was successful!"
			else
				world << "\red \bold The traitor has failed one ore more of his/her objectives!"
		if(istype(M, /mob/angel))
			var/MB = M
			world << ""
			world << "\red \bold The Malformed Angel was [M.name] (played by [M:ckey])!"
			world << ""
			if(MB:bodiez <= bodycount)
				world << "\green \bold Either by luck, by brute force or by its cunning, the Angel have accomplished its objective ([bodycount] sinners are dead)."
			else
				world << "\red \bold It've failed its objective to murder [bodycount] people!"
	creditgen()
	world << "\red Rebooting in 60 seconds..."
	spawn(700) world.Reboot()
