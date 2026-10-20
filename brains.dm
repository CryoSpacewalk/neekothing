/obj/harch{icon = null /*icon id 73: unresolved*/; icon = 'grafon/effects/chemistry.dmi'; name = "mokrotah"; desc = "Well, looks like some guy needs to swallow a bit of cough syrup right now."; icon_state = "mokrotah1"; alticon = "gharch1"; var/sick = 0}
/mob/verb/checkmood()






	set name = "check mood"



	if(src.tension > 2)
		usr << "\red Your body hurts as heck"
	if(src.nausea > 2)
		usr << "\red You have an urge to vomit"
	if(src.thrill > 2)
		usr << "\red You're shaking for some reason"
	if(src.depression > 1)
		usr << "\red The world around you is wicked and cruel"
	if(src.delirium > 2)
		usr << "\red [pick("Your roof is on fire", "You're a little teapot", "The world is blurry", "You're a lizard king", "You can't feel your head")]"

	usr << " "

	if(!src.class == "man")
		usr << "\blue You don't give a single damn"
	else if(berserk)
		usr << "\red You feel furious!"
	else if(calm <= 0)
		usr << "\red \bold OH FUCK WHAT TO DO OH FUCK NO"
	else if(calm < 10)
		usr << "\red \bold You're in panic!"
	else if(calm < 15)
		usr << "\red You feel nervous"
	else if(calm < 20)
		usr << "\blue You feel nervous, but only a bit"
	else if(calm > 20)
		usr << "\green You feel rela-a-axed"
	else
		usr << "\blue You feel less or more okay"

	usr << " "

	if(euphoria > 100)
		usr << "\blue DAMN AWESOME"
	else if(euphoria > 50)
		usr << "\blue You feel a strong euphoria."
	else if(euphoria > 10)
		usr << "\blue You feel a mild euphoria."

	if(src.empowered)
		usr << " "
		usr << "\blue Your fists are fucking huge"

	if(src.brutality)
		usr << " "
		if(src.brutality >= 10)
			usr << "\blue You're extremely mighty!"
		else if(src.brutality >= 5)
			usr << "\blue You're mighty!"
		else if(src.brutality >= 3)
			usr << "\blue You're very strong"






	if(pain > painless)
		switch(pain)
			if(1 to 3)
				usr << "\red You feel an annoying pain."
			if(4 to 8)
				usr << "\red You feel a strong pain."
			else
				usr << "\red \bold You're in agony!"
	else
		if(painless >= 6)
			usr << ""
			usr << "\blue Your body feels numb. And damn, you like it."
		else
			if(painless >= 3)
				usr << ""
				usr << "\blue Your body feels numb a bit."

/mob/verb/checkout()
	label1


	if(src.hunger > 300)
		usr << "\blue you're full of food"
	else if(src.hunger > 200)
		usr << "\blue you're far from starvation, but still should eat a bit"
	else if(src.hunger > 100)
		usr << "\blue you're hungry"
	else if(src.hunger > 50)
		usr << "\blue you're very hungry"
	else
		usr << "\red \bold FRECKING DINNING TIME, YOU'RE NEAR STARVING"
	if(src.cultplayer)
		usr << ""
		usr << "\red You're an infernal stalinist! Uh-oh! \n"
	usr << "\red Amount of goddamn spiders in head: [delirium]"
	usr << "\red Eyes goggling from eyelids (in mm): [see_invisible]"
	usr << "\red Tongue numbness: [says_xynta]"
	usr << "\red Feel of inner power: [psi]"
	if(chronodepr)
		usr << "\red Dullness and gloom of the world around you: [chronodepr]"
	if(chronoclock)
		usr << "\red Steps done down to depression (in USSR-4 standart depression factor metric): [chronoclock]"
	if(psiactive)
		usr << "\red Depth of the world around you (in psionic nanometers): [depthui]"
		usr << "\red Depth of the world around you (in 'turfs'): [psi_radius]"

/mob/proc/paincheck()






	if(pain > 0 && prob(40 + pain * 3 - painless * 9))
		src.thrill += 2

	if(pain - painless > 0 && prob(60 - max(10, luck / 2)))
		chronoclock += pain - painless

	if(prob((pain - painless) * 5))
		src << "\red \bold Your hand convulses in pain!"
		if(item)
			src.dropitem(src.item)

	if(pain && prob(5 + pain * 3))
		src.damaga(1, "organ")
		src << "\red \bold Your pain is unbearable! You convulse!"
		if(!src.stunned)
			step(src, pick(1, 2, 8, 4))
			if(prob(50))
				spawn(0) src.stun(1)

	if(prob((pain - painless) * 10))
		src << "\red [pick("OUCH FUCK", "Damn, it hurts!", "Goddamn it, let's take some painkillers.")]"
		src.calm--
		src.euphoria -= rand(1, 1 + round(src.pain / 3))
		if(src.pain >= 7 && prob(50) || prob(pain * 3 - painless * 1.5 - 5))
			src.stun(3)
		if(pain - painless > 8 && prob(4))
			src << "\red \bold Due to the ungodly pain, you'll have a troubles enjoying the life from now and on."
			if(src:chronodepr < 15)
				src:chronodepr++

	if(pain > 0 && prob(66 + painless * 5 + luck))
		pain--

	if(src.painless > 0 && prob(90))
		src.painless--

/mob/proc/acid_dream(potency)




















	if(prob(potency))
		usr << "\blue \bold [pick("You see", "You feel like", "You smell", "You hear")] [pick("one of those", "a pair of", "a legion of", "a bunch of", "a trinity of", "")] [pick("", "huge", "big", "small", "tiny", "strange", "common", "weird", "nondescriptable", "floating")] [pick("nameless creatures", "dark figures", "blurry things", "sub-spaces", "universes", "sub-universes", "fractals", "mushrooms", "hippies", "chemists", "communists", "capitalists", "ideologists", "wizards", "women", "officers", "negros", "horns", "kings", "clowns", "New Year trees", "penises", "towers", "Freuds", "vaginas", "pushers")] [pick("", "", "", "relaxing", "fighting", "hanging out", "talking to you", "bathing in oil", "speaking", "consuming you", "watching you", "speaking your name", "hopping around", "flying around", "protecting the station", "resisting interraction", "having sex", "taking drugs", "playing weird music")]"
		if(prob(potency))
			usr << "\blue It is kinda [pick("weird", "unsetting", "strange", "uncommon", "common", "pleasant", "enjoyable", "funny")] to you"

/mob/proc/berserk_rage(dongs)



	if(src.berserk > 0 || dongs == 1)
		if(prob(10))
			if(src.calm > 15)
				src.calm--
		if(prob(5))
			for(var/mob/M in hearers(src))
				if(!M.sleeps)
					M << "\red \bold [src.name] roars loudly!"
		for(var/mob/M in orange(1, src))
			if(prob(80))
				if(src.item)
					M.attack_by(src.item, src)
				else
					M.attack_hand(src)
		if(prob(10) && src.client)
			var/raeg = new /obj/hud_effect/acid()
			src.client.screen += raeg
			spawn(5) src.client.screen -= raeg

/proc/psychogen(pstring)


	var/i = rand(1, 10)

	pstring = rand("a", "z")
	while(i)
		var/dong = rand("a", "z")
		pstring += dong
		i--

/mob/proc/psychocheck()
	var/pstring1, pstring2, pstring3
	psychogen(pstring1)
	psychogen(pstring2)
	psychogen(pstring3)
	if(prob(src.psychosis - 20))
		src << "[pick(realname, name, "?^2ls", "dp19qqq", "Your mom", "Eerie voice", pstring1, pstring2, pstring3)] says, \bold''[pick(pstring1, pstring2, pstring3)][pick("", " [pstring1]", " [pstring2]", " [pstring3]")][pick("", " [pstring1]", " [pstring2]", " [pstring3]")][pick("", " [pstring1]", " [pstring2]", " [pstring3]")]''"
	if(prob(src.psychosis - 100))
		stun(round(src.psychosis / 20))
		src << "\red [pstring1]"
	if(src.psychosis > 0)
		src.psychosis--

/datum/synergy
	var/rid
	var/percent = 1
/mob



































	var/list/datum/synergy = new/list()
/mob/proc/syn_add(rid, perc)


	var/exist = 0
	for(var/datum/synergy/S in src.synergy)
		if(S.rid == rid)
			exist = 1
			var/gay = 0

			if(perc > S.percent)
				gay = 1
			else if(perc < S.percent)
				gay = -1


			S.percent += round((perc - S.percent) / 5) + gay

	if(!exist)
		var/datum/synergy/S = new /datum/synergy(src.synergy)
		S.rid = rid
		S.percent = 100 + round((perc - S.percent) / 5)

/mob/proc/syncheck()



	for(var/datum/synergy/S in src.synergy)

		if((S.rid < 95 || S.rid > 105) && prob(100 - abs(S.rid - 100) * 2))
			src.synergy -= S
		else
			if(S.rid < 100)
				S.rid++
			else
				if(S.rid > 100)
					S.rid--

/mob/proc/delirium()













	if(prob(80))
		src.drowsy_change(-2)

	if(prob(delirium / 1.5))
		for(var/turf/T in view(src))
			if(T.density && (!(T in range(4, src)) && prob(delirium)))
				new /obj/drugged/lazor(T)
			if(T.density && prob(delirium / 3))
				new /obj/drugged/dob_eye(T)
			if(T.density && prob(1))
				new /obj/drugged/traitor(T)
			if(!T.density && prob(delirium / 5))
				new /obj/drugged/dobman(T)
			if(!T.density && prob(delirium / 6))
				new /obj/drugged/volga(T)

			if(!("delirium" in csecond))
				csecond += "delirium"

	if(prob(delirium * 3) && client)
		for(var/turf/T in range(src.client.view + 3, src))

			if(!(T in view(src.client)) && prob(15))
				var/D = new /obj/drugged/delirium(T)
				var/Ideli = image(D:icon, T, D:icon_state, D:layer)
				src << Ideli
				spawn(0)
					del(D)
					spawn(rand(10, 60)) del(Ideli)

	var/channel = new /obj/hud_effect/channel1()
	if(prob(delirium * 6) && client)
		var/doshit = 1
		for(var/obj/hud_effect/channel1/C in src.client.screen)
			if(C)
				doshit = 0
		if(doshit)
			src.client.screen += channel
			spawn(42)
				if(channel && src.client)
					src.client.screen -= channel

	if(prob(delirium * 4))

		for(var/obj/item/I in view(src))
			if(prob(15))
				for(var/turf/T in range(2, I))
					if(prob(50))
						var/Ideli = image(I.icon, T, I.icon_state, I.layer)
						src << Ideli
						spawn(rand(10, 60)) del(Ideli)

/mob/proc/drowsy_change(amt)












	if(src.drowsy + amt > 0)
		src.drowsy += amt
	else
		src.drowsy = 0

	if(amt > 0 && (src.drowsy > 20 && prob(src.drowsy)))
		src << "\blue You feel sleepy."

		if(src.drowsy > 25 && (prob(src.drowsy * 2) && !src.sleeps))
			src << "\blue You fall asleep."
			src.sleepfall(round(src.drowsy * 1.5))

/mob/proc/sleepfall(ticks)


	src.sleeps = 1
	src.stun(round(ticks / 5))
	src.blind(ticks * 2 + 10, 0)

	while(src.drowsy)
		src.drowsy_change(-1)
		if(src.pain && prob(50))
			src.pain--
		sleep(2)

	if(!src.drowsy)
		src.sleeps = 0

/mob/proc/torment(tormt)







	if(src.sleeps)
		return

	if(src.mat != "flesh")
		return

	for(var/obj/item/I in src)
		if(istype(I, /obj/item/weapon/battleaxe/proton))
			show_message("\red \bold [src.name] avoids pain with help of proton axe!", "Your proton axe protects you from pain!")
			return

	if(prob((tormt - src.painless) * 25))

		src << "\red Ouch, it hurts!"
		src.pain = min(src.pain + tormt - src.painless, 10)
	else
		if(src.painless >= tormt)

			src << "\blue It, probably, should hurt as hell, but you don't give a fuck."

/obj/harch/New()


































	icon_state = "mokrotah[rand(1, 6)]"
	alticon = "gharch[pick(1, 2)]"
/obj/harch/sick{sick = 1; name = "mokrotah"}
/obj/harch/Crossed(atom/movable/A)
	if(istype(A, /mob) && (src:sick && prob(2)))
		var/M = A
		if(M:mat == "flesh" && !M:immune)
			M << "\red You feel sick. Looks like it wasn't a good idea to run over over people sputum!"
			M:flu = 1
		else
			M << "\blue Looks like there's some flu patient (or other diseased creature) sputum here. Good thing you can't get sick!"


/mob/proc/seizure(tiem)








	if(src.mat == "flesh")
		if(prob(src.luck / 2 + min(src.psi, 33)))
			src << "\green You was just about to have a seizure, but avoided it somehow!"
			return
		src << "\red You're having a seizure!"
		for(var/mob/M in viewers(src))
			M << "\red \bold [M.name] is having a seizure!"
























		src.stun(round(tiem / 3))

/mob/proc/bodyshift(ddir, pixl)



	var/Ik = new /icon(src.icon)
	Ik:Shift(ddir, pixl)
	src.icon = Ik

	for(var/obj/overlay/body/B in contents)
		if(B)
			src.overlays -= B
	for(var/obj/limb/L in src.limbs)
		var/obj/overlay/body/B = new L.ovly(src.loc)
		B:layer = -3.1
		if(ddir && pixl)
			var/I = new /icon(B:icon)
			I:Shift(ddir, pixl)
			B:icon = I
		spawn(0)
			B:loc = src
			src.overlays += B

	for(var/obj/overlay/clothes/K in src.contents)
		src.overlays -= K

	for(var/obj/overlay/mutation/M in src.contents)
		src.overlays -= M

	if(src.mutations:len)
		for(var/datum/mutation/MT in src.mutations)
			var/M = new /obj/overlay/mutation(src.loc)
			M:icon = 'grafon/clothing_overlays.dmi'
			M:icon_state = src.clothes:playericon
			M:layer = -3
			if(ddir && pixl)
				var/I = new /icon(M:icon)
				I:Shift(ddir, pixl)
				M:icon = I
			spawn(0)
				M:loc = src
				src.overlays += M

	if(src.clothes)
		var/C = new /obj/overlay/clothes(loc)
		C:icon = 'grafon/clothing_overlays.dmi'
		C:icon_state = src.clothes:playericon
		C:layer = -3
		if(ddir && pixl)
			var/I = new /icon(C:icon)
			I:Shift(ddir, pixl)
			C:icon = I
		spawn(0)
			C:loc = src
			src.overlays += C

/obj/item/reagent_container/consumable/gland/New()













	src.add_chem("nutriment", "nutriment", 1, 0)
	spawn(0)
		src.add_chem("adrenochrome", "adrenochrome", 4, 0)

/mob
	var/drowsy = 0
	var/sleeps = 0
	var/pain = 0
	var/seizurin = 0
	var/schizo = 0
