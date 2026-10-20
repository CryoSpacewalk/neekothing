/mob/var/barbi = 0
/mob/var/benzo = 0
/mob/var/hmur = 0
/mob/var/stim = 0
/mob/var/alcho = 0
/mob/var/ghb = 0
/mob/var/cigs = 0
/mob/var/ba_tick = 0
/mob/var/be_tick = 0
/mob/var/hm_tick = 0
/mob/var/st_tick = 0
/mob/var/al_tick = 0
/mob/var/ghb_tick = 0
/mob/var/ci_tick = 0
/mob/var/tension = 0
/mob/var/nausea = 0
/mob/var/thrill = 0
/mob/var/depression = 0
/mob/var/delirium = 0
/mob/var/chronodepr = 0
/mob/var/chronoclock = 0
/mob/var/nauseablock = 0
/mob/var/enable_delirium = 0
/mob/var/calm = 20
/mob/var/euphoria = 0
/mob/var/painless = 0
/mob/var/distortion = 0
/mob/var/berserk = 0
/mob/var/ssyndrome = 0
/mob/var/opi_block = 0
/mob/var/benzo_block = 0
/mob/var/succinic = 0
/mob/var/cyclodol = 0
/mob/var/epilepsy = 0;/mob/var/adapt = 0;/mob/var/cetamed = 0;/mob/var/immune = 0;/mob/var/radtox = 0
/mob/proc/addiction()
	if(src.tension > 0)
		if(src.calm > 0)
			src.calm--
		if(prob(50))
			src << "\red OUCH"
			src.damaga(1, "organ")
		src.chronoclock += 5

		src.tension--
		if(src.tension > 10)
			src.tension = 10
	else

		src.tension = 0


	if(src.nausea > 0)
		if(prob(src.nauseablock))
			return
		if(prob(10 + src.nausea * 20))
			vomit()
		if(prob(20))
			src.vomit_red()
			if(prob(50))
				src.damaga(2, "organ")

		src.nausea--
		if(src.nausea > 10)
			src.nausea = 10
	else

		src.nausea = 0



	if(src.thrill > 0)

		if(prob(src.thrill * 5))
			src << "\red Your hands doesn't obey you!"
			if(src.item)
				dropitem(item)

		src.thrill--
		if(src.thrill > 10)
			src.thrill = 10
	else

		src.thrill = 0



	if(src.depression > 0)
		if(src.calm > 0)
			src.calm--
		if(src.euphoria >= 3)
			src.euphoria -= 3
		else if(src.euphoria)
			src.euphoria--
		if(prob(25))
			src << "\red [pick("World is cruel", "Nobody likes me", "Life is so full of pain", "I don't have a reason to live")]"
		if(src:chronodepr < 5)
			src.chronoclock += 10

		src.depression--
		if(src.depression > 10)
			src.depression = 10
	else

		src.depression = 0



	if(delirium > 0)

		if(prof == "captain")
			capdelirium = 1

		if(prob(50 - src.calm))
			src.chronoclock += 3

		if(delirium > 5)
			delirium()









		if(prob(10) && src.client)
			var/NM = new /obj/hud_effect/nightmare()
			var/MW_top = new /obj/hud_effect/mesc_wicked()
			var/MW_bottom = new /obj/hud_effect/mesc_wicked()
			MW_top:screen_loc = "WEST,NORTH to EAST,NORTH-1"
			MW_bottom:screen_loc = "WEST,SOUTH to EAST,SOUTH"
			src.client.screen += NM
			src.client.screen += MW_top
			src.client.screen += MW_bottom
			spawn(40)
				src.client.screen -= NM
				src.client.screen -= MW_top
				src.client.screen -= MW_bottom
		else
			if(prob(delirium * 0.75) && client)
				var/HF = new /obj/hud_effect/heavy_fog()
				spawn(90) src.client.screen -= HF

		if(src.see_invisible < 13)
			src.see_invisible += 2

		if(src.see_invisible < 14)
			src.see_invisible++

		src.euphoria--

		if(prob(src.delirium))

			src.euphoria--
			src.thrill++
			src.calm -= pick(1, 1, 1, 1, 2, 3)

		if(prob(delirium * 1.5))
			dir = 2
			spawn(5)
				dir = 8
				spawn(10)
					dir = 4
					spawn(20)
						dir = 1
		if(prob(delirium / 2))
			src.mindbreak(1, 1)
		if(delirium > 40)
			delirium = 40
		else if(prob(60))
			delirium--

		src.spacevisions(90)
	else

		delirium = 0







	if(src.barbi > 0)
		if(src.ba_tick == 0 && src.barbi > 55)
			src << "\blue Let's get some barbital"
			src.tension += 2
			src.thrill += 2
			src.depression += 2
			if(src.euphoria >= 3)
				src.euphoria -= 3
			src.barbi--
		if(prob(4 + src.succinic * 13))
			src.barbi--

		if(src.barbi > 100)
			src.barbi = 100

	if(src.ba_tick)
		src.ba_tick--

	if(src.benzo > 0)
		if(src.be_tick == 0 && (src.benzo > 60 && prob(25)))
			src << "\blue Let's get some benzos"
			src.tension += 2
			src.thrill += 2
			src.depression += 2
			if(src.euphoria >= 3)
				src.euphoria -= 3
			src.benzo--
		if(prob(6 + src.succinic * 17))
			src.benzo--

		if(src.benzo > 80)
			src.benzo = 80

	if(src.be_tick)
		src.be_tick--
	else if(src.benzo)
		src.benzo--

	if(src.ghb > 0)
		if(src.ghb_tick == 0 && (src.ghb > 55 && prob(25)))
			src << "\blue You're staying out of GABAs for too long! It is horrible!"
			src.tension++
			if(prob(50))
				src.nausea += 2
			src.thrill += 2
			src.depression += 2
			if(src.euphoria >= 3)
				src.euphoria -= 3
			src.ghb--
		if(prob(5 + src.succinic * 17))
			src.ghb--

		if(src.ghb > 80)
			src.ghb = 80

	if(src.ghb_tick)
		src.ghb_tick--
	else if(src.ghb)
		src.ghb--

	if(src.hmur > 0)
		if(src.hm_tick == 0 && src.hmur > 70)
			if(!"[src.realname] was an opiate junkie" in funfacts)
				funfacts += "[src.realname] was an opiate junkie"
			src << "\red \bold YOU NEED TO GET SOME OPIATES RIGHT NOW"
			src.thrill += 2
			src.depression += 2
			src.tension += 2

			if(prob(10))
				src.torment(3)
			if(src.euphoria >= 3)
				src.euphoria -= 3
			else
				src.euphoria--
			if(prob(1 + src.succinic))
				src.hmur--


			if(src.hmur > 90)
				src.hmur = 90

	if(src.hm_tick)
		src.hm_tick--
	else if(src.hmur)
		src.hmur--

	if(src.stim > 0)
		if(src.st_tick == 0)

			if(prob(33))
				if(src.stim >= 2)
					src.stim -= 2
				else
					src.stim--

			if(src.stim > 50)
				src << "\blue You have a strong urge to speed up"
				src.tension++
				src.thrill += pick(1, 2)
				src.stim -= rand(2, 5)
				if(prob(50))
					src.depression++
				if(src.euphoria >= 3)
					src.euphoria -= 3
			if(prob(88 + src.succinic * 12))
				if(src.stim > 10)
					src.stim -= 2
				else
					src.stim--

			if(src.stim > 60)
				src.stim = 60

	if(src.st_tick)
		src.st_tick--
	else if(src.stim)
		src.stim--

	if(src.alcho > 0)
		if(src.al_tick == 0 && src.alcho > 20)
			src << "\red Damn, let's get some cure for your head"
			if(prob(10))
				src.tension += 2
			src.thrill++
			src.depression++
			if(src.euphoria >= 3)
				src.euphoria -= 3
			src.alcho -= rand(2 + src.succinic, 4 + src.succinic * 2)

			if(src.alcho > 30)
				src.alcho = 30

			if(src.enable_delirium && prob(2))
				if(!("[src.realname] drank himself to delirium this round" in funfacts))
					funfacts += "[src.realname] drank himself to delirium this round"
				if(delirium < 10 && prob(25))
					delirium = 10
				else if(delirium < 10)
					delirium += 6
				src.alcho -= 4
				src.enable_delirium = 0

		if(src.alcho > 20)
			src.alcho -= rand(1 + src.succinic, 2 + src.succinic * 2)

	if(src.al_tick)
		src.al_tick--
	else if(src.alcho)
		src.alcho--

	if(src.ci_tick == 20)
		src << "\bold Time to smoke!"

	if(src.ci_tick <= 0)
		if(src.cigs >= 10)
			src << "\red You want to smoke, damn it!"
			src.thrill++
			src.depression++
		if(src.cigs > 15)
			src.cigs = 15
		else if(src.cigs > 0)
			src.cigs--
		else
			src.cigs = 0
	else
		src.ci_tick--

/mob/proc/addiction_old()



	if(src.tension > 0)
		if(prob(20 + src.tension * 5))
			src.calm--
		if(prob(20 + src.tension * 2))
			src << "\red OUCH"
			damaga(1, "organ")
			if(prob(50))
				stun(3)
		src.chronoclock += 5
		if(src.tension > 20)
			src.tension = 20
		else if(prob(33))
			src.tension--
	else
		src.tension = 0

	if(src.nausea > 0)
		if(prob(src.nauseablock))
			return
		if(prob(10 + src.nausea * 20))
			vomit()
		if(prob(20))
			src.vomit_red()
			if(prob(50))
				src.damaga(2, "organ")

		if(src.nausea > 20)
			src.nausea = 20
		else if(prob(50))
			src.nausea--
	else
		src.nausea = 0

	if(src.thrill > 0)

		if(prob(src.thrill * 5))
			src << "\red Your hands doesn't obey you!"
			if(src.item)
				dropitem(item)
		if(prob(80))
			src.thrill--
	else
		src.thrill = 0

	if(src.depression > 0)
		if(prob(src.depression * 5))
			src.calm--
			if(src.euphoria >= 3)
				src.euphoria -= 3
			else if(src.euphoria)
				src.euphoria--
			if(prob(25))
				src << "\red [pick("World is cruel", "Nobody likes me", "Life is so full of pain", "I don't have a reason to live")]"
		if(src:chronodepr < 5)
			src.chronoclock += 10
		if(src.depression > 20)
			src.depression = 20
		else if(prob(33))
			src.depression--
	else
		src.depression = 0

	if(delirium > 0)

		if(prof == "captain")
			capdelirium = 1

		if(prob(50 - src.calm))
			src.chronoclock += 3

		if(delirium > 5)
			delirium()









		if(prob(10) && src.client)
			var/NM = new /obj/hud_effect/nightmare()
			var/MW_top = new /obj/hud_effect/mesc_wicked()
			var/MW_bottom = new /obj/hud_effect/mesc_wicked()
			MW_top:screen_loc = "WEST,NORTH to EAST,NORTH-1"
			MW_bottom:screen_loc = "WEST,SOUTH to EAST,SOUTH"
			src.client.screen += NM
			src.client.screen += MW_top
			src.client.screen += MW_bottom
			spawn(40)
				src.client.screen -= NM
				src.client.screen -= MW_top
				src.client.screen -= MW_bottom
		else
			if(prob(delirium * 0.75) && client)
				var/HF = new /obj/hud_effect/heavy_fog()
				spawn(90) src.client.screen -= HF

		if(src.see_invisible < 13)
			src.see_invisible += 2

		if(src.see_invisible < 14)
			src.see_invisible++

		src.euphoria--

		if(prob(src.delirium))

			src.euphoria--
			src.thrill++
			src.calm -= pick(1, 1, 1, 1, 2, 3)

		if(prob(delirium * 1.5))
			dir = 2
			spawn(5)
				dir = 8
				spawn(10)
					dir = 4
					spawn(20)
						dir = 1
		if(prob(delirium / 2))
			src.mindbreak(1, 1)
		if(delirium > 40)
			delirium = 40
		else if(prob(60))
			delirium--

		src.spacevisions(90)
	else

		delirium = 0


	if(src.barbi > 0)
		if(src.ba_tick == 0 && (src.barbi > 55 && prob(40)))
			src << "\blue Let's get some barbital"
			src.tension++
			src.thrill += rand(1, 3)
			src.depression += pick(1, 2)
			if(src.euphoria >= 3)
				src.euphoria -= 3
			src.barbi--
		if(prob(4 + src.succinic * 13))
			src.barbi--
	if(src.ba_tick)
		src.ba_tick--

	if(src.benzo > 0)
		if(src.be_tick == 0 && (src.benzo > 60 && prob(25)))
			src << "\blue Let's get some benzos"
			src.tension++
			src.thrill += pick(1, 2)
			src.depression++
			if(src.euphoria >= 3)
				src.euphoria -= 3
			src.benzo--
		if(prob(6 + src.succinic * 17))
			src.benzo--
	if(src.be_tick)
		src.be_tick--

	if(src.ghb > 0)
		if(src.ghb_tick == 0 && (src.ghb > 55 && prob(25)))
			src << "\blue You're staying out of GABAs for too long! It is horrible!"
			src.tension++
			if(prob(50))
				src.nausea++
			src.thrill += pick(1, 2)
			src.depression++
			if(src.euphoria >= 3)
				src.euphoria -= 3
			src.ghb--
		if(prob(5 + src.succinic * 17))
			src.ghb--
	if(src.ghb_tick)
		src.ghb_tick--

	if(src.hmur > 0)
		if(src.hm_tick == 0 && (src.hmur > 70 && prob(45)))
			if(!"[src.realname] was an opiate junkie" in funfacts)
				funfacts += "[src.realname] was an opiate junkie"
			src << "\red \bold YOU NEED TO GET SOME OPIATES RIGHT NOW"
			src.tension += 2
			src.nausea += 2
			if(prob(10))
				src.torment(3)
			src.thrill += pick(1, 2)
			src.depression += pick(1, 2)
			if(src.euphoria >= 3)
				src.euphoria -= 3
			else
				src.euphoria--
			if(prob(1 + src.succinic))
				src.hmur--
		if(prob(2.5))
			src.hmur--
	if(src.hm_tick)
		src.hm_tick--

	if(src.stim > 0)
		if(src.st_tick == 0)

			if(prob(33))
				if(src.stim >= 2)
					src.stim -= 2
				else
					src.stim--

			if(src.stim > 50 && prob(33))
				src << "\blue You have a strong urge to speed up"
				src.tension++
				src.thrill += pick(1, 2)
				src.stim -= rand(2, 5)
				if(prob(50))
					src.depression++
				if(src.euphoria >= 3)
					src.euphoria -= 3
			if(prob(88 + src.succinic * 12))
				if(src.stim > 10)
					src.stim -= 2
				else
					src.stim--
	if(src.st_tick)
		src.st_tick--

	if(src.alcho > 0)
		if(src.al_tick == 0 && (src.alcho > 20 && prob(33)))
			src << "\red Damn, let's get some cure for your head"
			if(prob(10))
				src.tension += 2
			src.thrill++
			src.nausea++
			src.depression++
			if(src.euphoria >= 3)
				src.euphoria -= 3
			src.alcho -= rand(2 + src.succinic, 4 + src.succinic * 2)
		if(src.al_tick == 0 && (src.alcho > 110 && prob(2)))
			if(!("[src.realname] drank himself to delirium this round" in funfacts))
				funfacts += "[src.realname] drank himself to delirium this round"
			if(delirium < 10 && prob(25))
				delirium = 10
			else if(delirium < 10)
				delirium += 6
			src.alcho -= 4
	if(src.alcho > 20)
		src.alcho -= rand(1 + src.succinic, 2 + src.succinic * 2)
	else if(src.alcho && prob(88))
		src.alcho--
	if(src.al_tick)
		src.al_tick--

	if(src.ci_tick == 20)
		src << "\bold Time to smoke!"

	if(src.ci_tick <= 0)
		if(prob(src.cigs * 5))
			src << "\red You want to smoke, damn it!"
			src.thrill += pick(1, 2)
			if(prob(50))
				src.depression++
		if(src.cigs > 0)
			src.cigs--
		else
			src.cigs = 0
	else
		src.ci_tick--
