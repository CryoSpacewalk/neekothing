// Recovered from compiled neek.dmb (4 procs)

/mob/var/fixlibido = 0

/mob/var/raped = 0
/mob/var/casts_shadow = 1
/mob/popobava
	icon = 'grafon/popobawa_new.dmi'
	realname = "Popobava"
	hepe = 150
	cult = 1
	mat = "ether"
	rapist = 1
	faggot = 1
	empowered = 4
	fixlibido = 1
	libido = 90
	semen = 666
	limbs = list()
	casts_shadow = 0;name = "Popobava";icon_state = "popobawa_erect"
/mob/popobava/New()
	src.toxdmg()
	spawn(3) src.popo_live()

/mob/popobava/proc/pentablink(rng)
	var/PL = list()
	for(var/turf/T in rng)
		var/yeah = 1
		for(var/obj/cult/penta/P in range(3, T))
			if(P)
				yeah = 0
		sleep(0)
		if(yeah && !T.density)
			PL += T

	if(PL:len)
		var/turf/goodT = pick(PL)
		show_message("\blue \bold [src.name] teleports away in fear of pentacle!")
		spawn(0)
			src.loc = goodT
			return 1
	else
		if(prob(5))
			show_message("\blue \bold [src.name] is trapped!")
			return 0

/mob/popobava/proc/popo_live()

	if(hepe <= 0)
		src << "\red \bold You're banished to the Hell!"
		show_message("\red \bold [src.name] is banished!")
		spawn(1)
			z = 2
			sleep(0)
			x = 5
			sleep(0)
			y = 5
			sleep(0)

	for(var/obj/cult/penta/P in range(3, src))
		if(P)
			step_away(src, P)
			if(prob(5))
				show_message("\blue \bold [src.name] steps away in fear of pentacle, hissing as it burns him!")
			src.damaga(10, "burn")
			sleep(2)
			step_away(src, P)
			sleep(2)
			step_away(src, P)
			sleep(5)
			src.popo_live()

	sleep(0)

	if(prob(80))

		sleep(0)
		for(var/mob/M in range(1, src))
			if(!M.psiactive && (!M.cult && M.mat != "ether"))
				var/chromo = 0
				if(M.mutations:len)
					for(var/MT in M.mutations)
						if(MT == "chromosome")
							chromo = 1
				sleep(0)
				if(chromo)
					src.say("[ruout("I will never visit such a... creature. Sorry.")]")
					new /obj/cloud/smoke/popo(loc)
					new /obj/cloud/smoke/popo(loc)
					new /obj/cloud/smoke/popo(loc)
					smartblink(20, 10, loc)
				else if(M:raped)
					src.say("[ruout("Looks like I've already... visited this folk. Goodbye.")]")
					new /obj/cloud/smoke/popo(loc)
					new /obj/cloud/smoke/popo(loc)
					new /obj/cloud/smoke/popo(loc)
					smartblink(20, 10, loc)
				else
					src.rape(M)
	sleep(0)
	for(var/mob/M in hearers(src))
		if(!M.psiactive && (!M.cult && (M.mat != "ether" && (!M:raped && prob(2)))))
			new /obj/effect/warp_splash(loc)
			spawn(0)
				loc = M.loc
				new /obj/effect/warp_splash(loc)
				if(!M.sleeps)
					M << "\red [src.name] appears before your eyes!"
	for(var/mob/M in view(src))
		if(prob(3) && (!M.cult && (!M.psiactive && (M.mat != "ether" && !M:raped))))
			M.smite()
	src.stalk(95, 0, 1, 1, 0, 0)
	spawn(2) src.popo_live()

/mob/popobava/proc/rape(mob/M)
	if(M:clothes)
		if(istype(M:clothes, /obj/item/clothes/purificator))
			if(prob(10))
				M:show_message("\blue \bold [src] trembles in fear in sight of [M]!", "\blue Your blessed clothes protects you from unholy influence!")
			return
		else
			M:stun(3)
			spawn(1)
				spawn(1)
					if(M in view(1, src))
						for(var/mob/MB in viewers(M))
							MB << "\bold [usr.name] strips [M:name]!"
						M:clothes:loc = M:loc
						M:unwearclothes()
	else
		M:stun(15)
		M << "\red \bold You feel a tiny prick. Very tiny, yes. Nanoprick."
		var/raeptime = 10
		while(raeptime)

			if(M in view(1, src))
				src.fuckit(M)
			else
				step_to(src, M)
			raeptime--
			sleep(5)
		spawn(0)
			src.say("[ruout("Thanks for the good company, [M:realname].")]")
			smartblink(20, 10, loc)
			M:raped = 1

	sleep(1)


/mob
	var/wounds = 0
/mob
	var/flu = 0
/mob
	var/syphilis = 0
/mob
	var/coughy = 0
/mob
	var/aids_potency = 0
