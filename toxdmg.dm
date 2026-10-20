/mob/var/glow = 0
/mob/var/debugend = 0
/mob/var/xom_last_used = 0
/mob/var/cult = 0
/mob/var/cultstart = 0
/mob/var/cultplayer = 0
/mob/var/cid = 0
/mob/var/baryga = 0
/mob/var/noverlay_hach = 1
/mob/var/ishach = 0;/mob/var/hachmask = 0;/mob/var/mount;/mob/var/screen_hud
/mob/proc/toxdmg()
	if(src.dead)
		return

	if(!(src.dir in list(1, 2, 8, 4)))
		src.dir = 1

	if(!src.debugend && (src.icon == null || src.icon_state == null))
		for(var/mob/M in world)
			if(M.client)
				var/C = M.client
				if(C:pedal)
					C << "\red \bold<font size = 15>[src.client.ckey] a.k.a. [src.realname] is using an invisibility bug somehow (no icon for body for some reason)<font>"
					src.debugend = 1

	if(!src.debugend && src.invisibility > 0)
		for(var/mob/M in world)
			if(M.client)
				var/C = M.client
				if(C:pedal)
					C << "\red \bold<font size = 15>[src.client.ckey] a.k.a [src.realname] is using an invisibility bug somehow (body invisibility>0)<font>"
					src.debugend = 1




	if(src.headperk == "fake Hitler" || src.headperk == "fake Stalin")
		if(src.clothes)
			var/C = src.clothes
			if(C:hitler)
				src.heal(1, "burn")
				if(prob(50))
					src.heal(1, "brute")



	if(calm <= 15)

		if(prob(1) && calm <= 0)
			usr << "\red \bold You feel HEAVILY depressed."
			src:chronodepr++

		if(prob(5))
			src.chronoclock += 2

		if(prob(35 - calm * 1))
			src << "\red Damn, you're scared."
			calm++

		if(prob(15 - calm) && thrill < 10)
			src.thrill++

		if(prob(33) && src.thrill < 5)
			src.thrill++

		if(prob(50) && src.thrill < 3)
			src.thrill++

		if(prob(25) && (calm <= 10 && thrill < 10))
			src.thrill++

		if(prob(60 - calm * 3))
			for(var/mob/M in hearers(src))
				if(!M.sleeps && M.class == "man")
					M.playsound('sounds/fast-breath.ogg')

			if(prob(66 - calm * 2))
				var/spdy = world.tick_lag * (4 - src:mov_speed) + !src.check_limb("r_leg") + !src.check_limb("l_leg")
				src << "\red HOLY LENIN WHAT TO DO WHAT TO DO"
				step(src, pick(1, 2, 8, 4))
				spawn(spdy)
					step(src, pick(1, 2, 8, 4))
					spawn(spdy)
						step(src, pick(1, 2, 8, 4))

			if(prob(10 - calm))
				src << "\red OH DAMN NO I AM TOO YOUNG TO DIE!"
				stun(pick(1, 2))
				src.calm++
	else
		if(calm > 25)

			if(prob(75) && tension)
				if(src.tension >= 2)
					src.tension -= 2
				else
					src.tension--

			if(prob(2 + calm / 3.2))
				src << "\green Well, let's just lay there and enjoy."
				src.stun(1 + min(calm / 10, 4))

				drowsy_change(1)

			if(prob(calm))
				calm--

	if(calm > 20 && prob(18 + calm))
		calm--
	if(calm < 0 && prob(66))
		calm++
	if(calm < 20 && prob(48 - calm))
		calm++
	if(calm < -10)
		calm = -10
	if(calm > 50)
		calm = 50



	if(src.hepe <= 10 && src.calm > -10)
		calm--
	if(src.hepe <= 20 && prob(70))
		calm--
	if(src.hepe <= 30 && prob(50))
		calm--
	else if(src.hepe <= 40 && prob(20))
		calm--
	else if(src.hepe <= 50 && prob(10))
		calm--



	if(src:fixlibido)
		src:semen = 666

	if(src:semen < 22)
		src:semen += 4
	else
		if(src:semen < 30)
			src:semen++

	if(prob(src.libido) && src:semen < 28)
		src:semen += 2

	if(prob(src.libido * 2) && src:semen < 30)
		src:semen++

	if(src.jack && prob(120 - src.libido))
		src.jack--

	if(src.libido > 0 && !src:fixlibido)
		if(src.libido > 10)
			src.libido -= 10
		else if(src.libido > 5)
			src.libido -= 5
		else
			src.libido--

	if(src.libido < 0)
		src.libido = 0



	if(src.empathy > 10 && prob(3 + min(round(src.empathy / 2), 20)))
		src.euphoria += 2
		if(src.calm < 20)
			src.calm += 2
		src << "\green You suddenly feel a wave of understanding of other people and kindness."
		for(var/mob/M in view(usr))
			if(M.class == "man" && M.mat == "flesh")
				src << "[M.name] is probably a kind and joyous person deep in his soul."
				src.euphoria += 5
				if(src.faggot)
					src.libido += 5
			else if(M.class == "robot")
				src << "Robots are cool folks to hang with. [M.name] is probably a nice person, he just need somebody to talk with him."
				src.euphoria += 5

		if(src.chronoclock > 50)
			src.chronoclock -= 20
		else if(src.chronoclock > 20)
			src.chronoclock -= 5
		else if(src.chronoclock > 5)
			src.chronoclock -= 2
		else if(src.chronoclock > 0)
			src.chronoclock--
		else
			src.chronoclock = 0
		if(src:chronodepr > 0 && prob(10))
			src << "\green You feel a bit less depressed."
			src:chronodepr--

	if(src.empathy >= 10)
		src.empathy -= 10
	else if(src.empathy >= 5)
		src.empathy -= 5
	else if(src.empathy > 0)
		src.empathy--
	else
		src.empathy = 0



	if(src.tieobj)
		if(src.wired)
			src.stun(3.5)
	else if(src.wired)
		src.untie()


	if(src:raped && prob(5))
		src.say(pick("МЕНЯ ПИДОРНУЛ ПОПОБАВА", "I WAS RAPED BY POPOBAVA", "А мен\green вот, кстати, Попобава ебал", "Как? Вы не слышали? Мен\green изнасиловал Попобава!"))



	if(src:chronodepr > 0)
		if(prob(15 + src:chronodepr * 5))
			if(src.euphoria > -src:chronodepr)
				src.euphoria -= 20
			else
				src.euphoria -= 5

		if(prob(5 + src:chronodepr - src.euphoria))
			usr << "\red Why did I wake up this morning? Everything is so gray and pale."
			src.drowsy_change(20)
			src.stun(3)
	else

		src:chronodepr = 0

	if(src.chronoclock >= 100 && src.mat == "flesh")
		src << "\red \bold You feel HEAVILY depressed"
		src:chronodepr++
		src.chronoclock = 0



	if(src.nauseablock > 30)
		src.nauseablock = 30
	else if(src.nauseablock > 5)
		src.nauseablock -= 5
	else if(src.nauseablock >= 2)
		src.nauseablock -= 2
	else if(src.nauseablock)
		src.nauseablock--













	if(src.protez)
		src.protez--


	if(src.wounds)
		src.woundcheck()

	if(src.epilepsy < 0)
		src.epilepsy = 0



	if(src.radtox > 10)

		if(prob(src.radtox + 40))
			src.damaga(1, pick("burn", "organ"))

		if(src.radtox > 50 && (prob(5 + src.radtox / 25) && mutations:len < 2))
			src.randommut()



	if(src.psi > 0)

		if(prob(50))
			src.psi--

		if(src.psi > 60)
			src.psi = 50

		var/sober = 1
		for(var/datum/reagent/R in src.blood_chem)
			if(R.name in psionic_drugs)
				sober = 0
		spawn(0)
			if(sober)
				if(src.psi > 20)
					src.psi -= 5
				else if(src.psi > 5)
					src.psi -= 3
				else
					src.psi--
	else
		if(src.psi < 0)
			src.psi = 0


	if(src.psychosis > 25)
		src.psychosis = 25

	if(prob(psychosis))
		show_message("\red [src.name] screams and babbles!", "\red \bold You have a psychotic outbreak!")
		calm--
		berserk_rage(1)


	if(src.euphoria > 0)

		src.euphoria--

		if(prob(src.euphoria / 1.5))
			src.euphoria--

		if(prob(src.euphoria - 20))
			src.euphoria -= 3

		if(prob(src.euphoria - 40))
			src.euphoria -= 5

		if(prob(src.euphoria - 60))
			src.euphoria -= 7

		if(prob(src.euphoria - 80))
			src.euphoria -= 10

		if(src.euphoria > 125)
			src.euphoria = 125

		if(src.euphoria < -25)
			src.euphoria = -25

		if(prob(src.euphoria - 95) && src.psi > 40)
			src.turnpsi(2 + round(src.euphoria / 33))

		if(prob(src.euphoria - 10) && src.chronoclock > 0)
			if(src.chronoclock >= 3 && prob(33))
				src.chronoclock -= 3
			else
				src.chronoclock--

		if(src.euphoria >= 15 && (prob(75) && src.depression))
			if(src.depression >= 2)
				src.depression -= 2
			else
				src.depression--
	else
		if(src.euphoria < -10)
			src.euphoria++
			if(prob(round(abs((-10 - src.euphoria) / 2))))
				src << "\red \bold The life is so meaningless and cruel. Why did I woke up this morning at the first place?"
				src.stun(4)
				if(!src:chronodepr)
					src.chronoclock += 10

	if(src.euphoria < 0)

		if(prob(8) && src:chronodepr < 2)
			src.chronoclock += 2

		if(prob(3 + abs(src.euphoria / 10)))
			src << "\red Damn, you're feeling horrible. Your hands doesn't obey you very well."
			if(src.thrill < 5)
				src.thrill = 5
			else
				src.thrill += 2

	if(src.euphoria < 0 - src:chronodepr)

		if(prob(101 - src:chronodepr))

			src.euphoria++

	if(src.euphoria < -20)
		src.euphoria = -20


	if(src.says_xynta > 60)
		src.says_xynta = 60
	else if(src.says_xynta > 2 && prob(66))
		src.says_xynta -= 2
	else if(src.says_xynta > 0)
		src.says_xynta--


	if(src.distortion > 0)

		src.distortion--

		if(prob(src.distortion / 10))
			src << src.playsound('sounds/ambience.wav')

		if(src.distortion > 5 && prob(src.distortion))
			src.distortion -= 5

		if(src.distortion > 50)
			src.distortion = 50
	else

		src.distortion = 0




	if(mutations:len)


		if(prob(50))

			if((("tumor" in mutations) || ("tumor_eye" in mutations)) && prob(1))
				src << "\red Your tumor hurts!"
				src.torment(3)

			if(("hui" in mutations) && prob(2))
				src << "\blue Your penis twitches."
				if(src.libido < 20)
					src.libido = 20
				else if(src.libido < 99)
					src.libido += 2

			if(("tumor_eye" in mutations) && psi < 10)
				src.psi++

		if("eyes0" in mutations)
			if(psi < 5)
				psi++
			if(src.see_invisible < 2)
				src.see_invisible = 2

		if("eyes1" in mutations)
			if(psi < 10)
				psi++
			if(src.see_invisible < 8)
				src.see_invisible = 8

		if(("eyes1" in mutations) && ((("tumor" in mutations) || ("tumor_eye" in mutations)) && src.psi < 20))
			src.psi++

		if("chromosome" in mutations)

			if(says_xynta < 50)
				says_xynta += 2
			src.psi = 0


		if(src.opi_block)
			src.opi_block--

		if(src.benzo_block)
			src.benzo_block--


	if(src:brainport)
		if(istype(src:brainport, /obj/item/device/brainport/tantric))
			src.euphoria--
			src.psi++


	if(src.see_invisible)
		if(prob(20 + src.see_invisible * 2))
			src.see_invisible--

	src.psychocheck()


	src.addiction()


	src.paincheck()


	src.braincheck()







	if(src.collar && !src.stunned)
		if(prob(33))
			stun(6)


	if(src.stuncollar && !src.stunned)
		stun(6)


	src.berserk_rage(0)


	if(prob(20 + src.brutality * 5))
		src.brutality--



	if(src.hunger > 0 && src.hungertick >= 1)
		src.hunger--
		src.hungertick = 0

	if(src.hunger < 30 && prob(20 - src.hunger / 2))
		src << "\red Perhaps you should eat something."







	if(src.hunger <= 0 && prob(5))
		src << "\red You're so hungry your eyelids are closing by themselves!"
		src.drowsy_change(15)
		if(prob(66))
			src << "\red Your stomach hurts!"
			src.torment(2)
			if(src.class == "rooster")
				if(src.organdmg < 10)
					src.damaga(2, "organ")
			else
				if(src.organdmg < 50)
					src.damaga(10, "organ")


	spawn(15)
		if(src.hungertick < 1)
			src.hungertick++



	src.sickcheck()



	src.speedcheck()



	if(src.prof == "purificator")

		var/mus = 0

		for(var/mob/M in range(world.view, src))

			if(M.mat == "ether")

				mus = 1

		for(var/obj/putin/P in range(world.view, src))

			if(P)
				mus = 1

		for(var/obj/putin_big/PB in range(world.view, src))

			if(PB)
				mus = 1


		if(mus)
			src << sound('muzlo/peppersteak.ogg', 0, 1, 6, 80)
		else


			src << sound(null, wait = 0, channel = 6)
















	if(src.hepe > 0 && src.mat == "flesh")





		var/buhoy = 0
		for(var/datum/reagent/R in src.blood_chem)
			if(R.id == "ethanol")
				buhoy = 1
			spawn(0) R.on_mob(src)

		spawn(30)

			if(buhoy)
				src.euphoria += pick(0, 1, 1, 1, 2, 2)

				switch(src.drunk)
					if(1)

						if(prob(90 - src.succinic * 60))
							if(src.alcho < 22)
								src.alcho += pick(2, 3)
							else
								src.alcho++
					if(2)
						if(prob(100 - src.succinic * 50))
							if(src.alcho < 40)
								src.alcho += pick(2, 3)
							else
								src.alcho += pick(1, 2)
					if(3)
						if(prob(100 - src.succinic * 40))
							if(src.alcho < 60)
								src.alcho += pick(2, 3)
							else
								src.alcho += pick(1, 2)
					if(4)
						if(prob(100 - src.succinic * 30))
							if(src.alcho < 85)
								src.alcho += rand(2, 5)
							else
								src.alcho += pick(1, 2)
					if(5)
						if(prob(100 - src.succinic * 20))
							if(src.alcho < 110)
								src.alcho += rand(2, 5)
							else
								src.alcho += pick(1, 2)
					if(6)
						if(prob(100 - src.succinic * 20))
							if(src.alcho < 125)
								src.alcho += rand(2, 5)
							else
								src.alcho += pick(2, 3)


			if(src.drunk > 0 && !buhoy)

				src.drunk -= 1







			if(src.drunk > 4 && prob(20))
				if(src.nausea < 10)
					src.nausea += 5
				else
					src.nausea += 2




			if(!src.dead)
				spawn(0) toxdmg()
	else

		spawn(30) toxdmg()
