// Recovered from compiled neek.dmb (5 procs)

/obj/jizz/New()




	icon_state = "jizz[rand(1, 3)]"



/obj/limb
	var/health = 100
	var/ovly = /obj/overlay/body/head

/mob/verb/jackoff()











	set name = "Masturbate"
	if(usr.mat == "flesh")
		usr.fap()
	else
		usr << "\red Your body is unable to masturbate!"

/mob/verb/fuckit(M as mob)
	set name = "Fuck"
	if(M in (view(1, src) || !usr.stunned))
		var/chromo = 0
		for(var/mt in M:mutations)
			if(mt == "chromosome")
				chromo = 1
		sleep(0)
		if(chromo)
			usr << "\red \bold You can't get a boner due to this folk's disformation!"
		else if(usr:semen < 30)
			usr << "\red You can't get an erection!"
		else if(usr.dead)
			usr << "\red Nope, you're DEAD"
			return
		else if(M:mat != "flesh")
			usr << "\red Well, only living beings (and some demons) can do it!"
			return
		else if(M == usr)
			usr << "\red Nope, you can't fuck yourself."
			return
		else if(istype(M, /mob/rooster))
			if(!"[M:name] tried to fuck a rooster today" in funfacts)
				funfacts += "[M:name] tried to fuck a rooster today"
			usr << "\red No, you're not a sick fuck!"
			return
		else if(M:clothes || usr:clothes)
			src << "\red Both of yours should be naked for this."
			return
		else if(!usr.maggot)
			usr << "\red You're straight and so not into that kind of stuff."
			return
		else if(!M:maggot && !usr:grapist)
			src << "\red You're not a [reverse_text("tsipar")] and this guy surely don't want it in the ass!"
			return
		else
			usr.fuck(M)

/mob/proc/fap()

	if(src.mat != "flesh")
		src << "\red Well, only living beings can do it!"
		return
	if(src:semen >= 30)
		for(var/mob/M in viewers(src))
			M << "[src.name] strangles his weiner."
			if(exhibitionism)
				euphoria++
		if(prob(100 - src.libido / 2))
			src.jack += rand(1, 4)
		src.jack++
		src.euphoria += 3 + src.values_fuck * 2
		if(src.hunger)
			src.hunger--
		if(src.jack > 30)
			src << "\blue \bold YOU CAME AAAAAH"
			new /obj/jizz(src.loc)
			for(var/mob/M in viewers(src))
				M << "\blue [src.name] shots out a huge load!"
				if(exhibitionism)
					euphoria += 2 + values_fuck * 2
			src.euphoria += 10 + round(src.libido / 3) + src.values_fuck * 2
			src:semen = 0
			src.jack = 0
			if(src.hunger >= 10)
				src.hunger -= 10
			else
				src.hunger = 0
	else
		src << "\red \bold You can't get an erection!"

/mob/proc/fuck(mob/M)
	if(src.aids)
		M:aids = 1
	if(M:aids)
		src.aids = 1
	if(src.syphilis)
		M:syphilis = 1
	if(M:syphilis)
		src.syphilis = 1
	for(var/mob/MB in viewers(src))
		MB << "\red \bold [src.name] sticks it into [M]'s ass!"
		if(exhibitionism)
			euphoria++
	if(prob(src.libido / 2))
		src.jack += rand(1, 3)
	else
		src.jack += rand(2, 5)
	src.euphoria += rand(3, 6)
	if(src.hunger)
		src.hunger--
	if(M:maggot)
		if(M:semen)
			M << "\green Feels good man"
			if(prob(M:libido / 2))
				src.jack += rand(1, 3)
			else
				src.jack += rand(2, 5)
			if("hui" in src.mutations && prob(50))
				M << "\blue \bold SUCH A FUCKING HUGE COCK DAMN IT. It hurts a bit, but feels so fucking pleasant"
				M:damaga(rand(1, 3), "organ")
				M:euphoria += 2 + src.values_fuck * 2
			M:euphoria += rand(3, 6) + round(M:empathy / 15)
			if(src.hunger)
				src.hunger--
			if(M:jack > 30)
				M << "\blue \bold YOU CAME AAAAAH"
				new /obj/jizz(M:loc)
				for(var/mob/MB in viewers(src))
					MB << "\blue [src.name] shoots out a huge load!"
				M:euphoria += 150 + round(src.libido / 3) + round(M:empathy / 5) + src.values_fuck * 5
				M:semen = 0
				M:jack = 0
		else
			M << "\red Since you've just came, it doesn't feel like anything pleasant."
	else


		if(!"[M:name] got [reverse_text("epar")]d today" in funfacts)
			funfacts += "[M:name] got [reverse_text("epar")]d today"

		if(prob(100 - M:libido - round(M:empathy / 5)))
			M << "\red \bold FEELS BAD MAN"
			M:calm--
			M:torment(2)
			M:chronoclock += 5
			if(prob(2) || ("hui" in src.mutations) && prob(6))
				M << "\red \bold It is so horrible, the world around you fades in black and gray."
				M:chronodepr++
			if(prob(20) || ("hui" in src.mutations))
				M << "\red \bold OH FUCK IT HURTS"
				M:damaga(5, "organ")
				M:torment(2)
		else
			M << "\blue Fuck, on drugs it feels weird, but somewhat pleasant."
			M:euphoria += 2 + round(M:empathy / 20) + src.values_fuck * 2
			if(M:calm < 15)
				M:calm += pick(1, 2)
				if(prob(20))
					M << "\red \bold You're not into this stuff, however, so it hurts a bit."
					if("hui" in src.mutations)
						M:torment(3)
						M:damaga(5, "organ")
					else if(prob(50))
						M:torment(1)
						M:damaga(1, "organ")
	if(src.jack > 30)
		src << "\blue \bold YOU CAME AAAAAH"
		new /obj/jizz(src.loc)
		for(var/mob/MB in viewers(src))
			MB << "\blue [src.name] shots out a huge load!"
		src.euphoria += 5 + round(src.libido / 3) + round(M:empathy / 5) + src.values_fuck * 5
		src:semen = 0
		src.jack = 0

/mob
	var/semen = 30
	var/libido = 0
	var/jack = 0
	var/empathy = 0
	var/exhibitionism = 0
	var/sadism = 0
	var/masochism = 0
	var/maggot = 0
	var/grapist = 0
