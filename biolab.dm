/obj/machine/bebeekalkah
	var/on = 0
	icon_state = "bebeekalkah_off"
	name = "Electronic bebeekalkah"
	desc = "For some reason, this thing is able to lure amoebas around."
	anchored = 1
/obj/machine/rejuvenator
	density = 1
	icon_state = "rejuvenator"
	name = "Cell rejuvenator"
	var/cr = 0
	var/connected = 0
	var/regen = 0
	desc = "A machine for duplicating cell cores and forming cell from core's DNA."
	wrenchable = 0
	anchored = 0
/obj/machine/viral_comp{density = 1; name = "virology scanner"; desc = "A mysterious machine which can found antidote for some viruses. In some cases, antidote will stop infection without killing infected person. \blue It contains 0/50 units of infected blood and needs at lest 10."; var/blood = 0; icon_state = "virology"}
/var/aidscure = null
/obj/bio/amoeba{density = 1; icon = 'grafon/thingy.dmi'; icon_state = "amoeba"; name = "giant amoeba"; desc = "A huge mono-cellular creature."; var/permaicon; var/size = 2; var/evil = 0; var/berserk = 0; var/brute = 0; var/acid = 0; var/hepe = 50; var/aids = 0; var/regen = 0; var/food = 0; var/paralyzed = 0; var/core = "bydlo"}
/obj/bio/amoeba{anchored = 0}
/obj/bio/amoeba/proc/biodmg(dmg)
	new /obj/effect/goo_splash(src.loc)
	if(dmg >= hepe)
		if(size == 1)
			if(prob(66))
				coregen(src)
			spawn(0) del(src)
		else
			for(var/i = 0, i < size, i++)
				var/A = new /obj/bio/amoeba(src.loc)
				A:name = "young [name]"
				A:icon_state = "[icon_state]_small"
				A:size = 1
				if(istype(src, /obj/bio/amoeba/chaos))
					if(prob(12))
						A:regen++
					else
						A:brute += rand(0, 1)
						A:hepe += rand(-5, 10)
						A:evil += rand(0, 1)
						if(prob(33))
							A:acid += rand(0, 50)
						if(prob(5))
							A:aids++
				else

					A:acid = round(src.acid / 2)
					A:brute = round(src.brute / 2)
					A:hepe = round(src.hepe / 2)
					A:aids = src.aids
					A:regen = src.regen
					A:evil = src.evil
					A:berserk = src.berserk
				A:core = src.core
			spawn(0)
				del(src)
	else
		hepe -= dmg

/obj/bio/amoeba/proc/feed(nutri)
	if(nutri >= 25 - src.food)
		amoebagen(src)
		spawn(0) del(src)
	else
		src.food += nutri
/obj/bio/amoeba/attack_hand()
	if(!usr.candofun)
		usr << "\red NO"
		return
	if(prob(usr.luck + round(usr.euphoria / 4) + 40 * usr.empowered))
		for(var/mob/M in view(src))
			M << "\red [usr] [pick("kicks", "punches")] [src]!"
		usr << "\red You hit [src]!"
		src.biodmg(5 + 4 * usr.empowered)
	else
		for(var/mob/M in view(src))
			M << "\red [usr]'s fist passes through [src] without any effect!"
		usr << "\red You fail to hit [src]!"

/obj/bio/amoeba/attack_by(obj/I)


	var/crit = 0
	if(usr.clothes)
		if(istype(usr.clothes, /obj/item/clothes/military))
			crit += 10
		else if(istype(usr.clothes, /obj/item/clothes/purificator) || istype(usr.clothes, /obj/item/clothes/armor/adv))
			crit += 20
	if(usr.berserk)
		crit += 33
	if(prob(I:extracrit + crit + usr:luck + round(I:groovy / 4) + round(usr.euphoria / 3) + round(I:dmg / 5) + min(5, usr.empowered) + min(5, usr.brutality) - usr.thrill))
		src.show_message("\red \bold [usr] hits [src] REALLY hard!", "\blue \bold You hit [src] REALLY hard!")
		src.biodmg(I:dmg * 2 + round(crit / 2) + round(src.hepe / 4))
	if(prob(33))
		src.show_message("\red \bold [src] stops moving for a while!")
		src.paralyzed = 5

	if(I:veteranbane && I:dmg >= 10)
		src.show_message("\blue \bold [src] is in horror!")
		src.biodmg(1 + round(src.hepe / 2))
		if(prob(50))
			src.show_message("\red \bold [src] stops moving for a while!")
			src.paralyzed = 5
	else if(prob(I:accu) + usr.brutality * 1.5 + round(usr:luck / 2))
		for(var/mob/M in view(src))
			M << "\red [usr] hits [src] with [I]!"
		usr << "\red You hit [src] with [I]!"
		src.biodmg(I:dmg + I:dmg / 5 * usr.brutality)
	else
		for(var/mob/M in view(src))
			M << "\red [usr] misses [src]!"
		usr << "\red You miss [src]!"
/obj/bio/amoeba/New()
	permaicon = icon_state
	spawn(5) life()

/obj/bio/amoeba/small
	size = 1
	hepe = 25
	name = "young giant amoeba"
	icon_state = "amoeba_small"

/obj/bio/amoeba/small

/obj/bio/amoeba/evil
	evil = 1
	core = "evil"
	name = "killer amoeba"
	desc = "A huge mono-cellular creature. It looks angry."

/obj/bio/amoeba/evil

/obj/bio/amoeba/hard
	hepe = 250
	brute = 5
	name = "cellulose amoeba"
	icon_state = "amoeba_hardcore"
	desc = "A huge mono-cellular creature. It looks kinda tough."
	core = "hard"

/obj/bio/amoeba/hard

/obj/bio/amoeba/acid
	acid = 80
	core = "acid"
	name = "greenish amoeba"
	icon_state = "amoeba_green"
	desc = "A huge mono-cellular creature. It drops with nasty liquid."

/obj/bio/amoeba/acid

/obj/bio/amoeba/regen
	regen = 1
	core = "regen"
	icon_state = "amoeba_regen"
	name = "cozy amoeba"
	desc = "A huge mono-cellular creature. It looks warm, pleasant and not aggressive at all."
/obj/bio/amoeba/regen
/obj/bio/amoeba/chaos
	icon_state = "amoeba_chaos"
	name = "chaotic amoeba"
	desc = "A huge mono-cellular creature. It looks rather unpredictable."
	core = "chaos"
/obj/bio/amoeba/chaos
/obj/bio/amoeba/chaos/New()
	brute += rand(0, 4)
	hepe += rand(-20, 50)
	evil += rand(0, 1)
	if(prob(33))
		acid += rand(0, 50)
	if(prob(10))
		aids++
	else if(prob(12))
		regen++
	..()


/obj/bio/amoeba/proc/life()

	if(src.paralyzed)
		src.paralyzed--
	else


		if(!src.berserk && (src.evil && prob(5)))
			berserk = 1
			icon_state = "[permaicon]_evil"
		else if(berserk && prob(1))
			berserk = 0
			icon_state = "[permaicon]"
		if(size == 1)
			for(var/obj/item/reagent_container/consumable/C in src.loc)

				for(var/mob/MB in view(C))
					MB << "\red [src] consumes [C]!"
				for(var/datum/reagent/R in C.reagent_list)
					if(R.id == "nutriment" || R.id == "fuel")
						feed(R.amount * 2)
					else if(R.id == "brain rot" || R.id == "toxin")
						feed(R.amount)
					else
						feed(round(R.amount / 2))
				spawn(0) del(C)
			for(var/obj/item/limb/L in loc)
				for(var/mob/MB in view(L))
					MB << "\red [src] consumes [L]!"
				feed(5)
				spawn(0) del(L)
			for(var/obj/item/limb2/L in loc)
				for(var/mob/MB in view(L))
					MB << "\red [src] consumes [L]!"
				feed(5)
				spawn(0) del(L)
			for(var/obj/item/gib/G in loc)
				for(var/mob/MB in view(G))
					MB << "\red [src] consumes [G]!"
				feed(6)
				spawn(0) del(G)
			for(var/obj/cult/C in range(1, loc))
				for(var/mob/MB in view(C))
					MB << "\red [C] is earsed away by [name]!"
				spawn(0) del(C)
		if(prob(5 * berserk + acid))
			for(var/turf/wall/T in range(1, src))
				if(!istype(T, /turf/wall/brick) && prob(10) || prob(2))
					for(var/mob/MB in view(src))
						MB << "[src] corrodes [T]!"
					spawn(0) T.remove()




		if(prob(50 + 40 * berserk))
			if(!berserk)
				step(src, pick(1, 2, 8, 4))
			else
				src.stalk(66, 1, 1, 1, 0, 0)
		for(var/mob/M in range(1, src))
			if(prob(50 + 40 * berserk))
				if(regen)
					for(var/mob/MB in view(M))
						MB << "\blue [src] carefully hugs [M]!"
					M << "\green \bold^____^"
					M.heal(rand(2, 5), "brute")
					M.heal(pick(2, 4), "burn")
					if(prob(33))
						M.heal(5, "organ")
				else
					if(M.armor < size * 5)
						if(prob(psi / 4))
							show_message("\red [M.name] mysteriously avoids [src] pseudopod!")
							playsound('sounds/om.wav')
							return
						for(var/mob/MB in view(M))
							MB << "\red [src] hits [M]!"
						if(aids && prob(100 - M.chemprotect * 5))
							M.aids = 1
							M << "\red You feel sick."
						M.damaga(size * 5 + brute - M.armor, "brute")
						if(prob(20))
							M.torment(2)
					if(M.chemprotect < size * 3 && prob(25))
						if(prob(psi / 4))
							show_message("\red [M.name] mysteriously avoids [src] acid!")
							playsound('sounds/om.wav')
							return
						for(var/mob/MB in view(M))
							MB << "\red [src] drips something on [M]!"
						M << "\red \bold It burns!"
						M.torment(3)
					M.damaga(size * 3 + round(acid / 10) - M.chemprotect, "burn")
	spawn(5) life()

/obj/item/reagent_container/consumable/amoeba
	icon_state = "amoeba"
	name = "amoeba food supply"
	desc = "A special food for amoebas. Do not consume it if you aren't one."
/obj/item/reagent_container/consumable/amoeba
/obj/item/reagent_container/consumable/amoeba/New()
	src.add_chem("nutriment", "nutriment", 5, 0)
	spawn(1)
		src.add_chem("corpse rot", "corpse rot", 2, 0)
		spawn(1) src.add_chem("fuel", "fuel", 3, 0)


/obj/item/amoebacore
	market_price = 100




	var/obj/A = new /obj/bio/amoeba
	icon_state = "amoeba"
	name = "amoeba core";desc = "A core of young giant amoeba."
/obj/item/amoebacore/evil
	A = new /obj/bio/amoeba/evil
	market_price = 170
	name = "amoeba core"
	icon_state = "amoeba_evil"
/obj/item/amoebacore/hard
	A = new /obj/bio/amoeba/hard
	market_price = 250
	name = "amoeba core"
	icon_state = "amoeba_hard"
/obj/item/amoebacore/regen
	A = new /obj/bio/amoeba/regen
	market_price = 250
	name = "amoeba core"
	icon_state = "amoeba_regen"
/obj/item/amoebacore/acid
	A = new /obj/bio/amoeba/acid
	market_price = 200
	name = "amoeba core"
	icon_state = "amoeba_acid"
/obj/item/amoebacore/chaos
	A = new /obj/bio/amoeba/chaos
	market_price = 250
	name = "amoeba core"
	icon_state = "amoeba_chaos"
/proc/coregen(obj/A)


	switch(A:core)
		if("bydlo")

			return new /obj/item/amoebacore(A:loc)
		if("evil")

			return new /obj/item/amoebacore/evil(A:loc)
		if("acid")

			return new /obj/item/amoebacore/acid(A:loc)
		if("regen")

			return new /obj/item/amoebacore/regen(A:loc)
		if("hard")

			return new /obj/item/amoebacore/hard(A:loc)
		if("chaos")

			return new /obj/item/amoebacore/chaos(A:loc)

/proc/amoebagen(obj/A)

	switch(A:core)
		if("bydlo")

			return new /obj/bio/amoeba(A:loc)
		if("evil")

			return new /obj/bio/amoeba/evil(A:loc)
		if("acid")

			return new /obj/bio/amoeba/acid(A:loc)
		if("regen")

			return new /obj/bio/amoeba/regen(A:loc)
		if("hard")

			return new /obj/bio/amoeba/hard(A:loc)
		if("chaos")

			return new /obj/bio/amoeba/chaos(A:loc)

/proc/clonemeba(obj/A, obj/cloned)









































	A:name = cloned:name
	A:icon_state = cloned:icon_state
	if(istype(A, /obj/bio/amoeba/chaos))
		if(prob(12))
			A:regen++
		else
			A:brute += rand(0, 4)
			A:hepe += rand(-20, 50)
			A:evil += rand(0, 1)
			if(prob(33))
				A:acid += rand(0, 50)
			if(prob(5))
				A:aids++
	else
		A:acid = cloned:acid
		A:brute = cloned:brute
		A:hepe = cloned:hepe
		A:aids = cloned:aids
		A:regen = cloned:regen
		A:evil = cloned:evil
		A:berserk = cloned:berserk
	A:core = cloned:core

/obj/machine/rejuvenator/proc/suck_regen()













	if(src.connected == 1)
		for(var/obj/machine/gas/pipealike/pipe/connector/P in src.loc)
			if(P.regen > 0)
				src.regen += 1
				P.regen -= 1
		spawn(10) src.suck_regen()
	else
		return

/obj/machine/rejuvenator/attack_hand()
	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	if(!usr.candofun)
		usr << "\red NO"
		return

	switch(alert("Select your option.", , "Remove core", "Watch contents", "Core operations"))
		if("Remove core")
			switch(cr)
				if(null)
					usr << "\blue The machine softly beeps to you:"
					usr << "\red No core detected."
				else
					usr << "\blue You remove core from the [src]."
					cr:loc = src.loc
					spawn(0) cr = 0
		if("Watch contents")
			usr << "\blue \italic Current amounts of regenerite: [regen]"
			switch(cr)
				if(0)
					usr << "\red \italic No core detected."
				else
					usr << "\blue \italic A core is loaded."
		if("Core operations")
			switch(alert("Select your option.", , "Duplicate core (requests regenerite)", "Rejuvinate cell from core (requests regenerite)"))
				if("Duplicate core (requests regenerite)")
					if(cr)
						if(regen < 2)
							usr << "\red Not enough regenerite!"
							return
						regen -= 2
						if(prob(75 + usr.luck))
							usr << "\blue Duplication went successful."
							var/AM = new /obj/bio/amoeba()
							var/coru = new /obj/item/amoebacore()
							coru:icon_state = cr:icon_state
							clonemeba(AM, cr:A)
							coru:A = AM
							spawn(8)
								coru:loc = src.loc
						else
							usr << "\red Core was destroyed while duplicating due to its chromosomes or covering damage."
							spawn(0) cr = 0
					else
						usr << "\red \bold ERROR"
				if("Rejuvinate cell from core (requests regenerite)")
					if(cr && regen)
						if(regen < 4)
							usr << "\red Not enough regenerite!"
							return
						var/AB = new /obj/item/amoebabox(src.loc)
						AB:A = cr:A
						regen -= 5
						usr << "\blue Rejuvination went successful."
						spawn(0) cr = 0
					else

						usr << "\red \bold ERROR"

/obj/machine/rejuvenator/attack_by(obj/I)
	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	if(istype(I, /obj/item/tool/wrench))
		if(src.connected == 0)
			for(var/obj/machine/gas/pipealike/pipe/connector/P in loc)
				if(P)
					usr << "\blue You connect [src] to port."
					src.connected = 1
					src.anchored = 1
					break_pull()
					spawn(10) src.suck_regen()
		else
			usr << "\blue You disconnect [src] from the port."
			src.connected = 0
			src.anchored = 0
	else if(istype(I, /obj/item/amoebacore))
		if(src.cr)
			usr << "\blue The machine softly beeps to you:"
			usr << "\red Core already loaded."
		else
			usr << "\blue You install [I] inside [src]."
			src.cr = I
			I:loc = src
			spawn(0) usr.delitem()





/obj/item/amoebabox
	market_price = 200
	icon_state = "amoebabox"
	name = "contained amoeba"
	desc = "A container with a large mono-cellular creature sleeping inside."
	var/spread = 0





	var/obj/A = new /obj/bio/amoeba
	var/S
/obj/item/amoebabox/spready
	spread = 1
	name = "contained amoeba"
	desc = "A weird-looking amoeba container."
/obj/item/amoebabox/acidy
	spread = 1

	A = new /obj/bio/amoeba/acid
	name = "contained amoeba"
/obj/item/amoebabox/examine()
	usr << "\blue It contains [src:A:name]."
	if(src.spread)
		usr << "It contains some weird electronics attached to it."
	if(src.S)
		usr << "It has a signaller attached to it."

/obj/item/amoebabox/attack_by(obj/I)
	if(istype(I, /obj/item/electronics/amoeba) && !src.spread)
		usr << "\blue You potent your [name] a bit."
		spread = 1
		spawn(0) usr.delitem()
	else if(istype(I, /obj/item/device/signaler))
		if(!S)
			usr << "\blue You attach the signaler to to the [src.name]."
			S = I
			src:S:loc = src
			spawn(0) usr.delitem()
		else
			usr << "\red It is alreasy signaled!"
			return
	else if(istype(I, /obj/item/tool/screwdriver) && src.S)
		usr << "\blue You detach signaler from [src.name]."
		src:S:loc = usr.loc
		src.S = null

/obj/item/amoebabox/attack_self()
	usr << "\blue You deploy amoeba."
	var/A = usr.item
	A:deploy()
	spawn(0) usr.delitem()
/obj/item/amoebabox/acidy
/obj/item/amoebabox/proc/deploy()
	if(src.spread)
		src.uberdeploy()
		return
	if(istype(src.loc, /turf))
		src:A:loc = src.loc
	else
		src:A:loc = src.loc.loc

/obj/item/amoebabox/proc/uberdeploy()
	if(istype(src.loc, /turf))
		src:A:loc = src.loc
	else
		src:A:loc = src.loc.loc
	for(var/turf/T in range(1, src.loc))
		if(!T.density)
			var/An = new /obj/bio/amoeba(T)
			An:name = src:A:name
			An:size = 2
			An:icon_state = src:A:icon_state
			An:desc = src:A:desc
			An:hepe = src:A:hepe
			An:food = 0
			An:evil = src:A:evil
			An:berserk = src:A:berserk
			An:brute = src:A:brute
			An:acid = src:A:acid
			An:aids = src:A:aids
			An:regen = src:A:regen
			An:paralyzed = src:A:paralyzed



var/list/polydeus_chem = list("pogankeepeptide", "stalkotoxin", "amphetamine", "MDPV", "AB-228", "APICA", "APINACA", "aqua regia", "polytrinic acid", "corpse rot", "biotoxin", "botox", "desomorphine", "paracetamol", "sodium thiopental", "liquid smoke", "napalm", "haloperidol", "aminazine", "cellulose", "montage powder", "amalgam", "benzodiazepine", "phenazepam", "clonazepam", "nitrazepam", "cosmozepam", "cognitozepam", "triazolam", "diazepam", "midazolam", "opium", "codeine", "tramadol", "buprenorphine", "heroin", "hydrocodone", "oxycodone", "methadone", "fentanyl", "barbital", "amobarbital", "phenobarbital", "pentobarbital", "dextromethamphetamine", "methamphetamine", "ambrosine", "magnadote", "alprazolam", "GABA", "gabapentin", "CBD", "THC", "hash oil", "clozapine", "carbamazepine", "fibgenerite", "glucose", "prothesine", "MDA", "MDMA", "MDOH", "succinic acid", "flumazenil", "naloxone", "phenethylamine", "atropine", "GHB", "phenibut", "baclofen", "pregabalin", "DOB", "DXM", "DOM", "DOC", "DOI", "25i-NBOMe", "25b-NBOMe", "2C-B", "2C-I", "2C-H", "2C-P", "dicyclomine", "tropicamide", "trihexyphenidyl", "DMT", "psilocybin", "5-MeO-DMT", "DiPT", "5-MeO-DiPT", "AMT", "5-AcO-DMT", "4-HO-MET", "MXE", "MXP", "ketamine", "adrenochrome", "mephedrone", "cocaine", "fagenerite", "serotonin")
var/text_blaster = "Either find finished primary targeting system or assemble one yourself by screwing targeting system core into device frame.<BR>\nNow add synthjewel or diamond to your device and wire it up."
var/text_plasma = "Assemble primary targeting system and plasma generator by screwing respective device cores into device frames.<BR>\n	Wire up your assembly and install battery to finish plasma gun.<BR>\n	There're rumors of extremely powerful modifications of common 'Eucaliptus' plasmagun: don't be afraid to experiment."
var/text_euphogun = "Find a primary targeting system or assemble it from respective core and device frame.<BR>\nNow add tantric device to finish euphogun."
var/text_jetbike = "Let's get ready for a ride!<BR>\nScavenge jetbike assembly, machine frame and some wires. Wire up your jetbike (if it isn't already), then add tantric either assembly or tantric brainport to it.<BR>\nNow construct the machine frame, wire it up and put jetbike assembly inside of it.<BR>\n"
var/text_spreader = "Assemble a tantric brainmodule by using screwdriver on tantric device.<BR>\nNow fuck with resulting module by using screwdriver again.<BR>\nAdd a gastank to your assembly. Regenerite or antidote tanks are preferrable, but empty tank will work too.<BR>\nNow make, steal or scavenge a boxed amoeba. Add your spreader to it.<BR>\n"
var/text_xom = "Find a 'weird-looking system core' (don't ask me how) and screw it into device frame.<BR>\nNow just add tantric brainport to this... thing.<BR>\nNota bene: this thing allows you to communicate with powerful demon. Use it with caution.<BR>\n"
var/stalin_summoned = 0
var/cult_needed = 1
/obj/machine/polydeus/attack_hand()


















































































































	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this weird thing!"
		return

	if(!usr.delirium && (!usr.psi && !(usr.headperk == "competent researcher (yes, at least one head shouldn't be marginal crap)")))
		usr << "\red \bold It feeds not on your body, but on your madness. Get some trippy stuff before operating it!"
		return

	if(!src.A || !src.S)
		usr << "\red \bold Load an contained amoeba and a syringe first!"
		return
	else

		usr << "\blue You inject your amoeba with some chemicals."

		var/doshit = 0

		if(src.S:reagent_list:len)
			for(var/datum/reagent/RE in src.S:reagent_list)
				for(var/idz in polydeus_chem)
					if(idz == RE.id && RE.amount >= 1)
						doshit = 1

		spawn(0)
			if(doshit)
				usr << "\bold Your amoeba is changing..."
			else
				usr << "\red Nothing happens."

			A:inject(src.S)


/obj/machine/polydeus/attack_by(obj/I)
	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this weird thing!"
		return

	if(istype(I, /obj/item/amoebabox))
		if(src.A)
			usr << "\red The machine deeply beeps to you:"
			usr << "\red Amoeba is already loaded."
		else
			usr << "\blue You install [I] inside [src]."
			src.A = I
			I:loc = src
			spawn(0) usr.delitem()
	else if(istype(I, /obj/item/reagent_container/syringe))
		if(src.S)
			usr << "\red The machine deeply beeps to you:"
			usr << "\red Syringe is already loaded."
		else
			usr << "\blue You install [I] inside [src]."
			src.S = I
			I:loc = src
			spawn(0) usr.delitem()

/obj/machine/polydeus/verb/reject()
	set name = "Reject contents"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this weird thing!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	usr << "You reject syringe and box from the machine."
	if(src.A)
		src.A:loc = loc
		spawn(0) src.A = null
	if(src.S)
		src.S:loc = loc
		spawn(0) src.S = null

/obj/item/amoebabox/proc/inject(obj/S)

	var/LS = list()
	var/mutaR = null

	if(S:reagent_list:len)
		for(var/datum/reagent/RE in S:reagent_list)
			for(var/idz in polydeus_chem)
				if(idz == RE.id && RE.amount >= 1)
					LS += RE.id

	if(LS:len)
		mutaR = pick(LS)


	if(mutaR)

		switch(mutaR)
			if("pogankeepeptide")








				A = new /obj/bio/amoeba/evil()
			if("stalkotoxin")


				A = new /obj/bio/amoeba/evil()
			if("amphetamine")


				A = new /obj/bio/amoeba/evil()
			if("MDPV")


				A = new /obj/bio/amoeba/evil()
			if("AB-228")


				A = new /obj/bio/amoeba/evil()
			if("APICA")
			if("APINACA")




				A = new /obj/bio/amoeba/evil()
			if("aqua regia")






				A = new /obj/bio/amoeba/acid()
			if("polytrinic acid")


				A = new /obj/bio/amoeba/acid()
			if("corpse rot")


				A = new /obj/bio/amoeba/acid()
			if("biotoxin")


				A = new /obj/bio/amoeba/acid()
			if("botox")


				A = new /obj/bio/amoeba/acid()
			if("desomorphine")


				A = new /obj/bio/amoeba/acid()
			if("paracetamol")


				A = new /obj/bio/amoeba/acid()
			if("sodium thiopental")


				A = new /obj/bio/amoeba/acid()
			if("liquid smoke")


				A = new /obj/bio/amoeba/acid()
			if("napalm")


				A = new /obj/bio/amoeba/acid()
			if("haloperidol")


				A = new /obj/bio/amoeba/acid()
			if("aminazine")


				A = new /obj/bio/amoeba/acid()
			if("cellulose")






				A = new /obj/bio/amoeba/hard()
			if("montage powder")


				A = new /obj/bio/amoeba/hard()
			if("amalgam")


				A = new /obj/bio/amoeba/hard()
			if("benzodiazepine")


				A = new /obj/bio/amoeba/hard()
			if("phenazepam")


				A = new /obj/bio/amoeba/hard()
			if("clonazepam")


				A = new /obj/bio/amoeba/hard()
			if("benzodiazepine")


				A = new /obj/bio/amoeba/hard()
			if("phenazepam")


				A = new /obj/bio/amoeba/hard()
			if("nitrazepam")


				A = new /obj/bio/amoeba/hard()
			if("cosmozepam")


				A = new /obj/bio/amoeba/hard()
			if("cognitozepam")


				A = new /obj/bio/amoeba/hard()
			if("triazolam")


				A = new /obj/bio/amoeba/hard()
			if("diazepam")


				A = new /obj/bio/amoeba/hard()
			if("midazolam")


				A = new /obj/bio/amoeba/hard()
			if("opium")


				A = new /obj/bio/amoeba/hard()
			if("codeine")


				A = new /obj/bio/amoeba/hard()
			if("tramadol")


				A = new /obj/bio/amoeba/hard()
			if("buprenorphine")


				A = new /obj/bio/amoeba/hard()
			if("heroin")


				A = new /obj/bio/amoeba/hard()
			if("hydrocodone")


				A = new /obj/bio/amoeba/hard()
			if("oxycodone")


				A = new /obj/bio/amoeba/hard()
			if("methadone")


				A = new /obj/bio/amoeba/hard()
			if("fentanyl")


				A = new /obj/bio/amoeba/hard()
			if("barbital")


				A = new /obj/bio/amoeba/hard()
			if("amobarbital")


				A = new /obj/bio/amoeba/hard()
			if("phenobarbital")


				A = new /obj/bio/amoeba/hard()
			if("pentobarbital")


				A = new /obj/bio/amoeba/hard()
			if("methamphetamine")


				A = new /obj/bio/amoeba/hard()
			if("dextromethamphetamine")


				A = new /obj/bio/amoeba/hard()
			if("ambrosine")






				A = new /obj/bio/amoeba/regen()
			if("mangadote")














				A = new /obj/bio/amoeba/regen()
			if("alprazolam")


				A = new /obj/bio/amoeba/regen()
			if("GABA")


				A = new /obj/bio/amoeba/regen()
			if("gabapentin")


				A = new /obj/bio/amoeba/regen()
			if("clozapine")


				A = new /obj/bio/amoeba/regen()
			if("carbamazepine")


				A = new /obj/bio/amoeba/regen()
			if("CBD")


				A = new /obj/bio/amoeba/regen()
			if("THC")


				A = new /obj/bio/amoeba/regen()
			if("hash oil")


				A = new /obj/bio/amoeba/regen()
			if("fibgenerite")


				A = new /obj/bio/amoeba/regen()
			if("glucose")


				A = new /obj/bio/amoeba/regen()
			if("prothesine")


				A = new /obj/bio/amoeba/regen()
			if("succinic acid")


				A = new /obj/bio/amoeba/regen()
			if("flumazenil")


				A = new /obj/bio/amoeba/regen()
			if("naloxone")


				A = new /obj/bio/amoeba/regen()
			if("trihexyphenidyl")


				A = new /obj/bio/amoeba/regen()
			if("phenethylamine")






				A = new /obj/bio/amoeba/chaos()
			if("atropine")


				A = new /obj/bio/amoeba/chaos()
			if("GHB")


				A = new /obj/bio/amoeba/chaos()
			if("baclofen")


				A = new /obj/bio/amoeba/chaos()
			if("pregabalin")


				A = new /obj/bio/amoeba/chaos()
			if("DOB")


				A = new /obj/bio/amoeba/chaos()
			if("DXM")


				A = new /obj/bio/amoeba/chaos()
			if("DOM")


				A = new /obj/bio/amoeba/chaos()
			if("DOC")


				A = new /obj/bio/amoeba/chaos()
			if("DOI")


				A = new /obj/bio/amoeba/chaos()
			if("25i-NBOMe")


				A = new /obj/bio/amoeba/chaos()
			if("25b-NBOMe")


				A = new /obj/bio/amoeba/chaos()
			if("2C-B")


				A = new /obj/bio/amoeba/chaos()
			if("2C-P")


				A = new /obj/bio/amoeba/chaos()
			if("2C-I")


				A = new /obj/bio/amoeba/chaos()
			if("2C-H")


				A = new /obj/bio/amoeba/chaos()
			if("dicyclomine")


				A = new /obj/bio/amoeba/chaos()
			if("tropicamide")


				A = new /obj/bio/amoeba/chaos()
			if("psilocybin")


				A = new /obj/bio/amoeba/chaos()
			if("5-MeO-DMT")


				A = new /obj/bio/amoeba/chaos()
			if("DiPT")


				A = new /obj/bio/amoeba/chaos()
			if("5-MeO-DiPT")


				A = new /obj/bio/amoeba/chaos()
			if("5-AcO-DMT")


				A = new /obj/bio/amoeba/chaos()
			if("4-HO-MET")


				A = new /obj/bio/amoeba/chaos()
			if("MXE")


				A = new /obj/bio/amoeba/chaos()
			if("MXP")


				A = new /obj/bio/amoeba/chaos()
			if("salvinorin A")


				A = new /obj/bio/amoeba/chaos()
			if("ketamine")


				A = new /obj/bio/amoeba/chaos()
			if("adrenochrome")


				A = new /obj/bio/amoeba/chaos()
			if("mephedrone")


				A = new /obj/bio/amoeba/chaos()
			if("cocaine")


				A = new /obj/bio/amoeba/chaos()
			if("adrenochrome")


				A = new /obj/bio/amoeba/chaos()
			if("fagenerite")


				A = new /obj/bio/amoeba/chaos()
			if("serotonin")


				A = new /obj/bio/amoeba/chaos()

/obj/machine/viral_comp/attack_by(obj/I, mob/user)










	if(istype(I, /obj/item/reagent_container/syringe))
		usr << "The machine gently transfers all of the infected blood from the syringe to its storage."
		for(var/datum/reagent/RE in I:reagent_list)
			if(RE.id == "AIDS")
				var/to_rm = 0
				if(RE.amount > 50 - src.blood)
					to_rm = RE.amount + 50 - src.blood
				else if(src.blood < 50)
					to_rm = RE.amount
				else
					usr << "\red The storage is full!"
					return
				spawn(0)
					src.blood += to_rm
					spawn(0)
						I:remove_chem("AIDS", to_rm)
						desc = "A mysterious machine which can found antidote for some viruses. In some cases, antidote will stop infection without killing infected person. \blue It contains [blood]/50 units of infected blood and needs at lest 10."
	else
		user << "\red You need a syringe to load it with blood."
/obj/machine/viral_comp/attack_hand(mob/user)
	user << "\blue Now analysing samples..."
	spawn(15)
		if(src.blood < 5)
			user << "\red Not enough samples!"
		else
			src.blood -= 5
			var/ruletka = pick(1, 2, 3, 4)
			switch(ruletka)
				if(1)
					usr << "[pick(possibcure)] is a cure with probablity of [rand(1, 20)]%"
				if(2)
					var/hui = pick(possibcure)
					var/pizda = pick(possibcure)
					var/jeegurda = pick(possibcure)
					usr << "[pick(hui, pizda, jeegurda, aidscure)] is a cure with probablity of [rand(10, 50)]%"
				if(3)
					var/hui = pick(possibcure)
					var/pizda = pick(possibcure)
					usr << "[pick(hui, pizda, aidscure)] is a cure with probablity of [rand(40, 70)]%"
				if(4)
					var/jeegurda = pick(possibcure)
					usr << "[pick(jeegurda, aidscure)] is a cure with probablity of [rand(60, 90)]%"


/obj/item/reagent_container/consumable/toad
	icon_state = "toad"
	name = "dead toad"
	desc = "A corpse of a large toad."

/obj/item/reagent_container/consumable/toad
/obj/item/reagent_container/consumable/toad/New()
	src.add_chem("nutriment", "nutriment", 1, 0)
	spawn(0)
		src.add_chem("5-MeO-DMT", "5-MeO-DMT", 1, 0)

/obj/item/reagent_container/consumable/worm
	icon_state = "worm"
	desc = "A weird-colored worm."

/obj/item/reagent_container/consumable/worm
/obj/item/reagent_container/consumable/worm/New()
	src.add_chem("nutriment", "nutriment", 0.33, 0)
	spawn(0)
		src.add_chem("5-MeO-DMT", "5-MeO-DMT", 0.002, 0)
/obj/bio/toad
	icon = 'grafon/thingy.dmi'
	var/dmt = 0
	var/hepe = 10
	icon_state = "toad"
	var/food = 5
	name = "space toad"
	desc = "A large river toad."
/obj/bio/toad
	anchored = 0
/obj/bio/toad/attack_hand()
	if(!usr.candofun)
		usr << "\red NO"
		return
	if(src.dmt >= 1)
		for(var/mob/M in view(src))
			M << "\red [usr] licks [src]!"
		usr << "\red You lick [src]. You're disgusting, you know?"
		usr.add_chem("5-MeO-DMT", "5-MeO-DMT", 1, 0)
		src.dmt--
	else
		for(var/mob/M in view(src))
			M << "\red [src]'s skin is dry!"
/obj/bio/toad/New()
	spawn(5) src.life()
/obj/bio/toad/proc/life()
	if(prob(33) && src.food < 10)
		for(var/obj/item/reagent_container/consumable/worm/L in src.loc)
			for(var/mob/MB in view(L))
				MB << "\red [src] consumes [L]!"
			src.food += 5
			spawn(0) del(L)
	if(prob(50))
		var/k = 0
		var/L = list()
		for(var/turf/T in view(1, src))
			k++
			var/de = 0
			for(var/obj/O in T)
				if(O.density)
					de = 1
			if(!de && !T.density)

				L += T
		if(prob(20 + k * 3) && L:len)

			var/turf/TT = pick(L)
			spawn(0) src.Move(TT)

	if(src.dmt < 6 && (src.food > 0 && prob(30 - src.dmt * 2)))
		src.dmt++
		src.food--
	if(prob(1))
		src.food--
	if(src.food == 0 && prob(5))
		for(var/mob/M in view(src))
			M << "\red [src] looks hungry."
		if(prob(5))
			if(src.hepe > 1)
				src.hepe--
			else
				new /obj/item/reagent_container/consumable/toad(loc)
				spawn(0) del(src)
	else if(src.food > 0 && src.hepe < 10)
		src.hepe++
	spawn(10) src.life()

/obj/bio/toad/attack_by(obj/item/R)
	if(istype(R, /obj/item/reagent_container/consumable/worm))
		usr << "\blue You feed [src] with [R]."
		src.food += 5
		spawn(0) usr.delitem()
	else if(istype(R, /obj/item/reagent_container/syringe/probe))
		var/obj/item/reagent_container/syringe/probe/P = R
		var/isempt = 1
		for(var/datum/reagent/RE in P:reagent_list)
			if(RE)
				isempt = 0
		spawn(0)
			if(dmt >= 2 & isempt == 1)
				usr << "\blue You collect some of the toad extract with your [P:name]"
				P:add_chem("5-MeO-DMT", "5-MeO-DMT", 2, 0)
				src.dmt--
			else if(dmt < 2)
				usr << "\red [src.name] skin is too dry!"
			else if(!isempt)
				usr << "\red The probe is full!"
			spawn(0)
				src.dmt = 0

/obj/machine/bebeekalkah/attack_hand()









	src.playsound('sounds/electro.wav')
	if(src.on)
		src.on = 0
		src.icon_state = "bebeekalkah_off"
	else
		src.on = 1
		src.icon_state = "bebeekalkah_on"
		src.beep_beep()

/obj/machine/bebeekalkah/proc/beep_beep()
	src.playsound('sounds/electro.wav')
	for(var/obj/bio/amoeba/A in range(15, src))
		if(prob(75))
			step_to(A, src)
	if(src.on)
		spawn(5) src.beep_beep()




/obj/machine/amoebaengine/attack_by(obj/item/I)


	for(var/obj/wire/battery/B in src.loc)
		if(!B)
			usr << "The machine is not wired with power plug!"
			return
	if(istype(I, /obj/item/amoebacore))
		var/AC = I
		src.show_message("\bold The engine swallows some amoeba core.")
		for(var/obj/wire/battery/B in src.loc)
			B.energy += round(AC:market_price * 2)
		spawn(0) del(I)


/obj/item/device/crusher/attack_self()











	if(src.inert)
		return

	src.inert = 1

	usr.euphoria--

	usr.damaga(4, "burn")
	if(prob(20))
		usr.damaga(6, "organ")
	var/amoebarange = rand(2, 5)
	for(var/turf/T in range(amoebarange))
		new /obj/anti(T)

	var/opasniy = 0

	for(var/obj/bio/amoeba/A in range(amoebarange))
		A.biodmg(A.hepe)

		if(A)
			opasniy = 1

	if(opasniy)
		src.loc.show_message("\red \bold Looks like some amoebas have a bad day here!")

	spawn(20) src.inert = 0



/obj/anti/New()







	spawn(10)
		del(src)
