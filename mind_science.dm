/mob/var/see_dead_cooldown = 600
/mob/var/see_dead_last_used = -600
/mob/var/mindbreak_cooldown = 1000
/mob/var/mindbreak_last_used = -1000
/mob/var/oppression_cooldown = 1000
/mob/var/oppression_last_used = -1000
/mob/var/brutality = 0
/mob/var/overdrive_cooldown = 1660
/mob/var/overdrive_last_used = -1660
/mob/var/shiftspam = 0
/mob/var/voices_cooldown = 100;/mob/var/voices_last_used = -100;/mob/var/terror_cooldown = 500;/mob/var/terror_last_used = -500;/mob/var/dofamine_cooldown = 500;/mob/var/dofamine_last_used = -500;/mob/var/psidelirium_cooldown = 1250;/mob/var/psidelirium_last_used = -1250;/mob/var/observing = 0;/mob/var/canpull = 1;/mob/var/canstrip = 1;/mob/var/canspeak = 1;/mob/var/candofun = 1;/mob/var/depthui = 0;/mob/var/tempora = 0;/mob/var/fieldterror_cooldown = 100;/mob/var/fieldterror_last_used = -100;/mob/var/master;/mob/var/stuncollar = 0;/mob/var/traitor = 0;/mob/var/traitor_corpse = 0;/mob/var/objective1;/mob/var/objective2;/mob/var/armok = -1
/mob/proc/mindbreak(howstrong, allergic)
	if(howstrong < 0)
		src << "\blue Your feel clear-minded and stable."
	switch(allergic)
		if(1)
			src.deli += howstrong
			if(howstrong >= 1.5)
				src << "\red Something is clicking inside your head."
		if(2)
			src.dofa += howstrong
			if(howstrong >= 1.5)
				src << "\red Your mind is fading away."
		if(3)
			src.sero += howstrong
			if(howstrong >= 1.5)
				src << "\red You suddenly suffer a short wave of fear, then feel a strong pleasure for a second."
		if(4)
			src.adreno += howstrong
			if(howstrong >= 1.5)
				src << "\red Your suddenly lost an ability to think for a second."
		if(5)
			src.nmda += howstrong
			if(howstrong >= 1.5)
				src << "\red You have an out-of-body experience for a second."
		if(6)
			src.soul += howstrong
			if(howstrong >= 0.2)
				src << "\red You suffer a strong wave of weird, undescriptable emotions."

/mob/proc/braincheck()





	if(src.deli > 20 && (prob(src.deli * 1.5) && src.client))
		client:view = 1
		spawn(100) client:view = src.client.true_view

	if(src.dofa > 20 && prob(min(round(src.dofa / 2), 17)))
		if(prob(10))
			src << "\red What the fuck?"
			stun(min(src.deli / 10, 4))
		if(prob(5))
			src.depression++
		else if(prob(7))
			src.depression++
		if(prob(5))
			src.thrill++

	if(src.sero > 30 && prob(min(round(src.sero / 2), 17)))

		if(prob(10))
			src.ssyndrome++

		if(prob(25))
			if(src.painless)
				src.painless--
			src.torment(5)
		else

			if(prob(33))
				src.calm += pick(1, 2, 3, -1, -2, -3, -4)
			else if(prob(50))
				src << "\red What the fuck?"
				stun(3)

	if(src.adreno >= 25 && prob(min(round(src.adreno / 2), 17)))
		if(prob(25))
			if(src.painless)
				src.painless--
			src.torment(5)
		else

			if(prob(33))
				src.calm += pick(1, 2, 3, -1, -2, -3, -4)
			else if(prob(50))
				src << "\red What the fuck?"
				stun(3)





	if(src.ssyndrome >= 5 && prob(140 - src.luck))

		var/halynee = new /obj/hud_effect/heck()
		var/kislota = new /obj/hud_effect/acid()

		if(prob(33))
			src.stun(src.sero * 5 + round(src.ssyndrome / 2))
			src.damaga(5, "organ")
		else
			if(prob(50))
				src << "\red Your twitch hardly."
				if(item)
					src.dropitem(src.item)
				src.damaga(rand(3, 10), "organ")
				if(prob(20))
					src.torment(3)

		if(prob(33))
			src.vomit()

		if(prob(15))
			src << "\red \bold You feel completely fucked up."
			if(src.euphoria > 0)
				src.euphoria += pick(-20, 20)
			else
				src.euphoria += 10
			src.delirium += 4

		if(prob(src.ssyndrome * 10) && src.client)
			client:screen += halynee
			spawn(50) client:screen -= halynee
		else if(prob(src.ssyndrome * 5) && src.client)
			client:screen += kislota
			spawn(src.ssyndrome * 5) client:screen -= kislota

	if(src.ssyndrome && prob(33))
		src.ssyndrome--

/mob/New()



	src.verbs -= powahs
	..()

/mob/verb/tumble1()













	set category = "Cognitology powers"
	set name = "Tumble"
	tumble()

/mob/verb/flurry1()
	set name = "Flurry"
	set category = "Cognitology powers"
	roundhouse_kick()

/mob/verb/combat_throw1()
	set name = "Combat throw"
	set category = "Cognitology powers"
	combat_throw()

/mob/verb/see_dead()













	set name = "Look into the spatial pockets"
	set category = "Cognitology powers"
	if(world.time - src.see_dead_last_used < src.see_dead_cooldown)
		return
	if(src.euphoria < 25)
		usr << "\red \bold You have to feel awesome to do things like this!"
		return
	src.euphoria -= 25
	src.see_dead_last_used = world.time
	var/txt

	for(var/mob/M in world)
		if(istype(M, /mob/ghost))
			if(istype(M, /mob/ghost/observer))
				txt += "<font color = red>[M.realname] (a cursed One)</font><BR>"
			if(istype(M, /mob/ghost/wraith))
				txt += "<font color = purple>a[pick("n insane", " wicked", " rampaging", " omnicidal", " furious")] wraith</font><BR>"
			else
				txt += "<font color = blue>[M.realname] (a dead One)</font><BR>"

	spawn(0)
		usr << browse(txt)

		var/elist = list()
		for(var/obj/landmark/heck/H in world)
			elist += H
		var/HK
		if(elist:len)
			HK = pick(elist)
		else
			usr << "\red KUROKOKO"
		spawn(0)
			if(src.client)
				client:perspective = 1
				src.client.eye = HK:loc
				spawn(40)
					if(src.client)
						client:eye = src

/mob/verb/mindbreaker()




	set name = "Mind break"
	set category = "Cognitology powers"
	if(world.time - src.mindbreak_last_used < src.mindbreak_cooldown)
		return
	if(src.euphoria < 35)
		usr << "\red \bold You have to feel completely awesome to do things like this!"
		return
	src.euphoria -= 35
	src.mindbreak_last_used = world.time
	for(var/mob/M in view(src))
		if(M != src)
			M << "\red You feel weird"
			M.delirium += 5
			if(prob(50))
				M.stun(1)
			else

				if(prob(75) && src.client)
					M.client.party()
			if(prob(25))
				M.delirium += 5
			if(prob(50))
				M.thrill += 5
			if(prob(33))
				M.deli += 0.1
			M:chronodepr++

/mob/verb/oppression()



	set name = "Oppression"
	set category = "Cognitology powers"
	if(world.time - src.oppression_last_used < src.oppression_cooldown)
		return
	if(src.euphoria < 25)
		usr << "\red \bold You have to feel awesome to do things like this!"
		return
	src.euphoria -= 25
	src.oppression_last_used = world.time
	for(var/mob/M in view(src))
		if(M != src)
			var/oppress = rand(2, 7)
			spawn(0) M.stun(oppress)

/mob/proc/brutalize(qqq)



	brutality += qqq
	var/oldbrut = brutality - qqq
	spawn(0)
		if(brutality >= 10)
			src << "\blue You feel extremely mighty!"
			spawn(100)
				brutality = oldbrut

/mob/verb/overdrive()



	set name = "Overdrive"
	set category = "Cognitology powers"
	if(world.time - src.overdrive_last_used < src.overdrive_cooldown)
		return
	if(src.euphoria < 25)
		usr << "\red \bold You have to feel awesome to do things like this!"
		return
	src.euphoria -= 25
	src.overdrive_last_used = world.time
	usr << "\blue Please mind the sliding doors, next station is Hell!"
	src.painless = 10
	src.add_chem("adrenaline", "adrenaline", 1.5, 0)
	src.brutalize(11)
	src.empowered++
	src.calm = 15
	spawn(200) src.empowered--

/mob/verb/shift()


	set name = "Shift"
	set category = "Cognitology powers"
	if(src.euphoria < 10)
		usr << "\red \bold You have to feel good to do things like this!"
		return
	src.euphoria -= 10
	spawn(0)
		usr.blink(3)
		usr.shiftspam++

		if(prob(1))
			usr.shiftspam = 0
		if(usr.shiftspam > 15)
			usr << "\red \bold OH FUCK YOU'VE OVERUSED OUR BLUESPACE SLEEVE"
			spawn(0)
				usr.damaga(5, "burn")
				usr.blink(30)
				usr.shiftspam = 0
				spawn(5)
					usr.blink(10)
					spawn(5)
						usr.blink(10)
		if(usr.shiftspam > 7)
			usr << "\red Looks like you're overusing bluespace! Be careful!"
			if(prob(5))
				usr.shiftspam = 0

/mob/proc/awakening()


	if(src.adreno >= 15)
		src << "\blue You feel flexible"
		src.verbs += /mob/verb/tumble1
	if(src.adreno >= 10 && src.sero >= 10)
		src << "\blue You feel cooler"
		src.verbs += /mob/verb/combat_throw1
	if(src.adreno >= 15 && (src.sero >= 10 || src.nmda >= 16))
		src << "\blue You feel mighty"
		src.verbs += /mob/verb/overdrive
	if(src.adreno >= 15)
		src << "\blue Your fists wanna find some fight!"
		src.verbs += /mob/verb/flurry1
	if(src.adreno >= 10 || src.dofa >= 15)
		src << "\blue Your legs feel stronger"
		src.verbs += /mob/proc/roundhouse_kick
	if(src.sero >= 15 && (src.nmda >= 15 || src.dofa >= 10))
		src << "\blue You feel powerful"
		src.verbs += /mob/verb/oppression
	if(src.deli >= 15 && src.dofa >= 8)
		src << "\blue You feel weird"
		src.verbs += /mob/verb/mindbreaker
	if(src.deli >= 10 || src.nmda >= 10)
		src << "\blue You feel awaken"
		src.verbs += /mob/verb/see_dead
	if(src.sero >= 15 && (src.deli >= 15 || src.dofa >= 10))
		src << "\blue You feel unstable"
		src.verbs += /mob/verb/shift
	if(src.sero >= 15 && (src.deli >= 15 && (src.dofa >= 15 && src.adreno >= 15)))
		src << "\blue You feel a power over other people's minds"
		src.verbs += /mob/verb/voices
		src.verbs += /mob/verb/psiterror
		src.verbs += /mob/verb/dofamine
		src.verbs += /mob/verb/psidelirium

/obj/machine/activator/proc/awake()







	for(var/obj/wire/W in src.loc)
		if(W.energy >= 1)
			W.energy--
			for(var/mob/M in src.loc)
				M.awakening()


/obj/machine/brainscan/proc/scan(mob/U)




	for(var/obj/wire/W in src.loc)
		if(W.energy >= 1)
			W.energy--
			for(var/mob/M in src.loc)
				U << "\blue Damage ratio of cholinergic receptors: [M.deli]"
				if(M.deli > 20)
					U << "\red It is dangerous!"
				U << "\blue Damage ratio of dopamine receptors: [M.dofa]"
				if(M.dofa >= 25)
					U << "\red It is dangerous!"
				U << "\blue Damage ratio of serotonin receptors: [M.sero]"
				if(M.sero > 30)
					U << "\red It is dangerous!"
				U << "\blue Damage ratio of adrenoceptors: [M.adreno]"
				if(M.adreno > 25)
					U << "\red It is dangerous!"
				U << "\blue Damage ratio of NMDA receptors: [M.nmda]"
				if(M.soul > 0)
					U << "\blue Damage ratio of thin body (???): [M.soul]"


/obj/comp/cognitology







	board = new /obj/item/electronics/board/cognitology
	icon_state = "cogni";name = "Cognitology Mainframe"
/obj/comp/cognitology/verb/awake()
	set name = "Begin awakening"
	set src in view(2)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	for(var/obj/machine/activator/S in range(10, src.loc))
		S.awake()
		return
/obj/comp/cognitology/verb/scan()
	set name = "Begin brain spectroscopy"
	set src in view(2)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	for(var/obj/machine/brainscan/B in range(10, src.loc))
		B.scan(usr)
		return
/obj/comp/cognitology/New()
	src.powercheck()
/obj/comp/cognitology/operate(obj/W)
	src.turnoff()

/mob/verb/voices()















	set category = "Psiterror"
	set name = "Voices in the head"
	if(src.euphoria < 5)
		src << "\red You have to feel good to do things like this!"
		return
	src.euphoria -= 5
	var/L = list()
	for(var/mob/M in world)
		if(M.mat == "flesh")
			L += M
	var/M = input("Well, who'll hear you?", "", src) in L
	if(!M:client || (M:dead || (M:z != usr.z || M:z == 2)))
		src << "\red It is pointless since [M:name] will not hear you anyway."
		return

	if("chomosome" in src.mutations || clothes:nopsi)
		src << "\red Damn! Something is blocking your psionic abilities!"
		return

	var/voicetxt = input("And what to say?", "", "")

	if(world.time - src.voices_last_used < src.voices_cooldown)
		src << "\red You're spamming your power too much."
		return

	if("chromosome" in M:mutations)
		usr << "\red \bold This folk's mind is too disformed to use your powers on it!"
		return

	if(M:clothes:nopsi)
		usr << "\red \bold This folk uses some kind of psionic protection."
		return

	src.voices_last_used = world.time
	M << "\red There's a voice in your head!"
	M << "\red It says:"
	M << "[voicetxt]"

/mob/verb/psiterror()



	set name = "Cause Terror"
	set category = "Psiterror"
	if(src.euphoria < 25)
		src << "\red You have to feel awesome to do things like this!"
		return
	src.euphoria -= 25
	var/L = list()
	for(var/mob/M in world)
		if(M.mat == "flesh")
			L += M
	var/M = input("Well, who'll be your victim?", "", src) in L

	if("chomosome" in src.mutations || clothes:nopsi)
		src << "\red Damn! Something is blocking your psionic abilities!"
		return

	if(M:z != usr.z || M:z == 2)
		src << "\red [M:name] is out of your reach for some reason!"
		return

	if(world.time - src.terror_last_used < src.terror_cooldown)
		src << "\red You're spamming your power too much."
		return

	if("chromosome" in M:mutations)
		usr << "\red \bold This folk's mind is too disformed to use your powers on it!"
		return

	if(M:clothes:nopsi)
		usr << "\red \bold This folk uses some kind of psionic protection."
		return

	src.terror_last_used = world.time
	M << "\red There's a voice in your head!"
	M << "\red It tells you horrible things."
	M << "\red \bold You're scared as fuck."
	if(M:calm >= 10)
		M:calm -= 20
	else
		M:calm -= 15
	M:euphoria -= 10
	if(prob(66))
		M:thrill += 4
	if(prob(50))
		M:stun(2)

	if(prob(20))
		usr << "\red \bold Your power backfires at you!"
		usr.calm -= 10
		usr.euphoria -= 10
		usr.thrill += 2
		usr.damaga(5, "organ")

/mob/verb/dofamine()



	set name = "Dofamine agony"
	set category = "Psiterror"
	if(src.euphoria < 25)
		src << "\red You have to feel awesome to do things like this!"
		return
	src.euphoria -= 25
	var/L = list()
	for(var/mob/M in world)
		if(M.mat == "flesh")
			L += M
	var/M = input("Well, who'll be your victim?", "", src) in L

	if("chomosome" in src.mutations || clothes:nopsi)
		src << "\red Damn! Something is blocking your psionic abilities!"
		return

	if(M:z != usr.z || M:z == 2)
		src << "\red [M:name] is out of your reach for some reason!"
		return

	if(M == src)
		src << "\red You can't do this stuff on yourself, only on others!"
		return

	if(world.time - src.dofamine_last_used < src.dofamine_cooldown)
		src << "\red You're spamming your power too much."
		return

	if("chromosome" in M:mutations)
		usr << "\red \bold This folk's mind is too disformed to use your powers on it!"
		return

	if(M:clothes:nopsi)
		usr << "\red \bold This folk uses some kind of psionic protection."
		return

	src.dofamine_last_used = world.time
	M << "\red There's a voice in your head!"
	M << "\green It tells you pleasant things."
	M << "\green \bold Feels good man."
	M:calm += 5
	M:euphoria += 70

/mob/verb/psidelirium()



	set name = "Cause delirium"
	set category = "Psiterror"
	if(src.euphoria < 25)
		src << "\red You have to feel awesome to do things like this!"
		return
	src.euphoria -= 25
	var/L = list()
	for(var/mob/M in world)
		if(M.mat == "flesh")
			L += M
	var/M = input("Well, who'll be your victim?", "", src) in L

	if("chomosome" in src.mutations || clothes:nopsi)
		src << "\red Damn! Something is blocking your psionic abilities!"
		return

	if(M:z != usr.z || M:z == 2)
		src << "\red [M:name] is out of your reach for some reason!"
		return

	if(world.time - src.psidelirium_last_used < src.psidelirium_cooldown)
		src << "\red You're spamming your power too much."
		return

	if("chromosome" in M:mutations)
		usr << "\red \bold This folk's mind is too malformed to use your powers on it!"
		return

	if(M:clothes:nopsi)
		usr << "\red \bold This folk uses some kind of psionic protection."
		return

	src.psidelirium_last_used = world.time
	M << "\red \bold You feel fucked up."
	M:delirium += 15
	if(prob(66))
		M:stun(2)

	if(prob(20))
		usr << "\red \bold Your power backfires at you!"
		usr.delirium += 10
		usr.calm -= 5
		usr.damaga(5, "organ")
