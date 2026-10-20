// Recovered from compiled neek.dmb (58 procs)

/obj/item/reagent_container/syringe
	maxamount = 5
	target_transfer = 5
	beltable = 1
	icon_state = "syringe"
	var/dart = 0
	var/aids = 0
	var/onetime = 0
	var/nonhuman = 0

/obj/item/reagent_container/syringe

/obj/item/reagent_container/syringe/attack(atom/I as obj|turf)

	if(istype(I, /obj/machine/chem_heater) && !istype(I, /obj/machine/chem_heater/freezer))
		if(!reagent_list:len)
			usr << "\blue You sterylize your syringe."
			if(src.aids)
				src.aids = 0
		else
			usr << "\red You can heat-sterylize only empty syringes!"
	else

		if(istype(I, /obj/item/reagent_container/consumable) || istype(I, /obj/item/reagent_container/beaker))
			var/obj/item/reagent_container/ugh = I
			var/ughamount
			var/selfamount = 0
			for(var/datum/reagent/R in ugh:reagent_list)
				ughamount += R.amount
			for(var/datum/reagent/R in src.reagent_list)
				selfamount += R.amount
			if(length(src.reagent_list))

				if(src:dart)
					usr << "\red You can't empty a dart once it is filled with something!"
					return

				if(ugh:maxamount <= 0)
					usr << "\red You can't inject anything into [I:name]!"
					return

				spawn(0)
					var/isfilled = 0
					if(selfamount <= 0)
						usr << "\red [src] is empty!"
					else if(ughamount < ugh:maxamount - src.target_transfer)
						src.transfer_mix(src.maxamount, I)

						spawn(1)
							for(var/datum/reagent/R in reagent_list)
								if(R.amount > 0)

									isfilled = 1

							if(isfilled)
								usr << "\blue You transfer some liquid, but there's something left in the syringe!"
							else
								usr << "\blue You transfer some liquid."
								src.desc = null
					else
						if(ughamount == ugh:maxamount)
							usr << "\red [ugh] is full!"
						else
							usr << "\blue You transfer some liquid."
							src.transfer_mix(ugh:maxamount - ughamount, I)

							spawn(1)
								for(var/datum/reagent/R in reagent_list)
									if(R.amount > 0)

										isfilled = 1

								if(isfilled)
									usr << "\blue You transfer some liquid, but there's something left in the syringe!"
								else
									usr << "\blue You transfer some liquid."
									src.desc = null

								if(src:onetime)
									del(src)
			else
				if(!istype(I, /obj/item/reagent_container/consumable))
					spawn(0)

						if(ughamount <= 0)
							usr << "\red [ugh] is empty!"
						else
							if(selfamount == 0)
								usr << "\blue You fill [src] with some liquid."
								ugh:transfer_mix(src.maxamount, src)

								src.desc = "A syringe, filled with something."

								spawn(0.1)
									if(src.temp >= 2 && src.aids)
										src.aids = 0
							else
								if(selfamount == src.maxamount)
									usr << "\red [src] is full!"
								else
									usr << "\blue You fill [src] with some liquid."
									ugh:transfer_mix(src.maxamount - selfamount, I)

									src.desc = "A syringe, filled with something."

									spawn(0.1)

										if(src:onetime)
											del(src)
										else
											if(src.temp >= 2 && src.aids)
												src.aids = 0











	spawn(0)
		if(src.temp >= 2 && src.aids)
			src.aids = 0

/obj/item/reagent_container/syringe/probe
	maxamount = 2
	target_transfer = 2
	name = "biolab probe"
	icon_state = "probe"
/obj/item/reagent_container/syringe/probe
/obj/item/reagent_container/syringe/dart
	dart = 1
	icon_state = "dart"
	name = "syringe gun dart (5)"
/obj/item/reagent_container/syringe/dart
/obj/item/reagent_container/syringe/dart/halo
	name = "syringe gun dart (haloperidol)"
	icon_state = "dart_halo"
/obj/item/reagent_container/syringe/dart/halo
/obj/item/reagent_container/syringe/dart/halo/New()
	add_chem("haloperidol", "haloperidol", 5, 0)
/obj/item/reagent_container/syringe/dart/d8
	maxamount = 8
	target_transfer = 8
	name = "syringe gun dart (8)"
/obj/item/reagent_container/syringe/dart/d8
/obj/item/reagent_container/syringe/dart/d8/thiopental
	name = "syringe gun dart (sodium thiopental)"
	icon_state = "dart_sodium"
/obj/item/reagent_container/syringe/dart/d8/thiopental
/obj/item/reagent_container/syringe/dart/d8/thiopental/New()
	add_chem("sodium thiopental", "sodium thiopental", 8, 0)


/obj/item/reagent_container/syringe/micro
	maxamount = 0.1
	target_transfer = 0.1
	maxamount = 2
	target_transfer = 2
	name = "Microdropper"
	icon_state = "probe2"
/obj/item/reagent_container/syringe/micro
/obj/item/reagent_container/syringe/micro/serotonin
	name = "Serotonin injector"

/obj/item/reagent_container/syringe/micro/serotonin

/obj/item/reagent_container/syringe/micro/serotonin/New()
	add_chem("serotonin", "serotonin", 0.05, 0)


/obj/item/reagent_container/syringe/injector
	onetime = 1
	maxamount = 50
	target_transfer = 50
	name = "One-time injector"
	icon_state = "probe3"

/obj/item/reagent_container/syringe/injector

/obj/item/reagent_container/syringe/injector/nonhuman
	nonhuman = 1
	icon_state = "worm1"
	name = "One-time chem tube"

/obj/item/reagent_container/syringe/injector/nonhuman
/obj/item/reagent_container/syringe/injector/nonhuman/nutri
	name = "One-time chem tube"
/obj/item/reagent_container/syringe/injector/nonhuman/nutri
/obj/item/reagent_container/syringe/injector/nonhuman/nutri/New()
	icon_state = "worm[rand(1, 5)]"
	add_chem("nutriment", "nutriment", 7, 0)

/obj/item/reagent_container/syringe/injector/tramal
	name = "Tramal injector"
/obj/item/reagent_container/syringe/injector/tramal
/obj/item/reagent_container/syringe/injector/tramal/New()
	add_chem("tramadol", "tramadol", 0.2, 0)
/obj/item/reagent_container/syringe/injector/calypsol
	name = "Calypsol injector"
/obj/item/reagent_container/syringe/injector/calypsol
/obj/item/reagent_container/syringe/injector/calypsol/New()
	add_chem("ketamine", "ketamine", 5, 0)
/obj/item/reagent_container/syringe/injector/calypsol2
	name = "Calypsol anesthetic injector"
/obj/item/reagent_container/syringe/injector/calypsol2
/obj/item/reagent_container/syringe/injector/calypsol2/New()
	add_chem("ketamine", "ketamine", 10, 0)
/obj/item/reagent_container/syringe/injector/mindbreak
	name = "Receptors restoration injector"
	icon_state = "probe4"
/obj/item/reagent_container/syringe/injector/mindbreak
/obj/item/reagent_container/syringe/injector/mindbreak/New()
	add_chem("aminazine", "aminazine", 8, 0)
	spawn(0)
		add_chem("haloperidol", "haloperidol", 7, 0)
		spawn(0)
			add_chem("clozapine", "clozapine", 10, 0)
			spawn(0)
				add_chem("paliperidone", "paliperidone", 10, 0)
/obj/item/reagent_container/syringe/injector/lethal
	name = "Death penalty injector"
	icon_state = "probe_security"
/obj/item/reagent_container/syringe/injector/lethal
/obj/item/reagent_container/syringe/injector/lethal/New()
	add_chem("midazolam", "midazolam", 20, 0)
	spawn(0) add_chem("sodium thiopental", "sodium thiopental", 20, 0)
/obj/item/reagent_container/syringe/injector/blacktar
	name = "Suspicious injector"
	icon_state = "probe_blacktar"
/obj/item/reagent_container/syringe/injector/blacktar
/obj/item/reagent_container/syringe/injector/blacktar/New()
	add_chem("black tar", "black tar", 0.06, 0)
/obj/item/reagent_container/syringe/injector/glintsyn
	name = "Suspicious injector"
	icon_state = "probe_blacktar"
/obj/item/reagent_container/syringe/injector/glintsyn
/obj/item/reagent_container/syringe/injector/glintsyn/New()
	add_chem("glintsyn", "glintsyn", 0.2, 0)
/obj/item/reagent_container/syringe/injector/sulfur
	name = "Sulfur injector"
	icon_state = "probe_sulfur"
/obj/item/reagent_container/syringe/injector/sulfur
/obj/item/reagent_container/syringe/injector/sulfur/New()
	add_chem("sulfur", "sulfur", 5, 0)
/obj/item/reagent_container/syringe/injector/naloxone
	name = "Naloxone injector (\"anti-opioid\")"
	icon_state = "probe_nalox"
/obj/item/reagent_container/syringe/injector/naloxone
/obj/item/reagent_container/syringe/injector/naloxone/New()
	add_chem("naloxone", "naloxone", 6, 0)
/obj/item/reagent_container/syringe/injector/flumazenil
	name = "Flumazenil injector (\"anti-benzo\")"
	icon_state = "probe_fluma"
/obj/item/reagent_container/syringe/injector/flumazenil
/obj/item/reagent_container/syringe/injector/flumazenil/New()
	add_chem("flumazenil", "flumazenil", 6, 0)
/obj/item/reagent_container/syringe/injector/gaba
	icon_state = "probe4"
	name = "gabalon solution (for IV usage)"
/obj/item/reagent_container/syringe/injector/gaba
/obj/item/reagent_container/syringe/injector/gaba/New()
	add_chem("GABA", "GABA", 4, 0)
	spawn(0)
		add_chem("water", "water", 1, 0)
/obj/item/reagent_container/syringe/injector/heroin
	icon_state = "probe4"
	name = "some injector"
/obj/item/reagent_container/syringe/injector/heroin
/obj/item/reagent_container/syringe/injector/heroin/New()
	add_chem("heroin", "heroin", 0.2, 0)
/obj/item/reagent_container/syringe/injector/adrenochrome
	name = "One-time injector"
/obj/item/reagent_container/syringe/injector/adrenochrome/New()
	add_chem("adrenochrome", "adrenochrome", 5, 0)
/obj/item/reagent_container/syringe/injector/cigs
	name = "IV chainsmoking nicotine injector (approved as an alternative to cigarettes in USSR-4)"
/obj/item/reagent_container/syringe/injector/cigs
/obj/item/reagent_container/syringe/injector/cigs/New()
	add_chem("nicotine", "nicotine", 0.2, 0)

/obj/item/reagent_container/syringe/emergency
	name = "emergency mixture syringe"
	icon_state = "syringe_red"
/obj/item/reagent_container/syringe/emergency
/obj/item/reagent_container/syringe/emergency/New()
	add_chem("antidote", "antidote", 2.5, 0)
	spawn(1) add_chem("regenerite", "regenerite", 2.5, 0)
/obj/item/reagent_container/syringe/trank
	name = "emergency calming syringe"
	icon_state = "syringe_trank"
/obj/item/reagent_container/syringe/trank
/obj/item/reagent_container/syringe/trank/New()
	add_chem("phenazepam", "phenazepam", 1.5, 0)
	spawn(0)
		add_chem("alprazolam", "alprazolam", 1, 0)
		spawn(0)
			add_chem("barbital", "barbital", 1.5, 0)
			spawn(0)
				add_chem("phenobarbital", "phenobarbital", 1, 0)
/obj/item/reagent_container/syringe/sleep
	icon_state = "syringe_red"
	name = "drowsyringe"
/obj/item/reagent_container/syringe/sleep
/obj/item/reagent_container/syringe/sleep/New()
	add_chem("sodium thiopental", "sodium thiopental", 5, 0)
/obj/item/reagent_container/syringe/stimpack
	name = "emergency mixture syringe"
	icon_state = "syringe_red"
/obj/item/reagent_container/syringe/stimpack
/obj/item/reagent_container/syringe/stimpack/New()
	add_chem("adrenaline", "adrenaline", 3.7, 0)
	spawn(1)
		add_chem("mutagenerite", "mutagenerite", 1, 0)
		spawn(1)
			add_chem("heroin", "heroin", 0.3, 0)

/obj/item/reagent_container/syringe/mutagenerite
	name = "suspicious syringe"
	icon_state = "syringe_traitor"

/obj/item/reagent_container/syringe/mutagenerite

/obj/item/reagent_container/syringe/mutagenerite/New()





	add_chem("mutagenerite", "mutagenerite", 5, 0)

/obj/item/reagent_container/syringe/halo
	name = "anti-psychotic syringe"
/obj/item/reagent_container/syringe/halo
/obj/item/reagent_container/syringe/halo/New()
	add_chem("haloperidol", "haloperidol", 5, 0)
/obj/item/reagent_container/syringe/vint
	name = "mysterious syringe"
/obj/item/reagent_container/syringe/vint
/obj/item/reagent_container/syringe/vint/New()
	add_chem("dextromethamphetamine", "dextromethamphetamine", 4, 0)
/obj/item/reagent_container/syringe/krok
	name = "mysterious syringe"
/obj/item/reagent_container/syringe/krok
/obj/item/reagent_container/syringe/krok/New()
	add_chem("desomorphine", "desomorphine", 0.25, 0)


/obj/item/reagent_container/syringe/aids
	aids = 1
	name = "syringe"
/obj/item/reagent_container/syringe/aids
/obj/item/reagent_container/syringe/tzar
	maxamount = 15
	target_transfer = 15
	parry = 10
	name = "suspiciously-looking syringe"
	icon_state = "syringe_huge"
/obj/item/reagent_container/syringe/tzar
/obj/item/reagent_container/syringe/attack(mob/M, mob/user)
	if(istype(M, /mob))

		if(src:dart)
			usr << "\red You can't inject people with darts, use syringe gun!"
			return

		if(src:nonhuman)
			usr << "\red It is not suited for human consumption nor injection, transfer it to syringe or bottle first!"
			return


		if(prob(50 - usr.luck / 2 + usr.thrill * 2) && !((usr.ckey in donat_profi) && (usr.prof in list("doctor", "cognitologist", "psychiatrist", "project director", "researcher", "baryga", "chemist"))))

			src.show_message("[usr.name] misses [M:name]'s vein!")
		else


			var/bpart_affected = pick(M:limbs)

			if(src.aids)
				M:aids = 1

			if(!length(src.reagent_list))
				for(var/mob/V in viewers(M))
					V << "\red [usr] takes [M]'s blood sample with [src]."
				switch(M:aids)
					if(1)
						src.add_chem("AIDS", "AIDS", src.target_transfer, 0)
						src.aids = 1
					else
						src.add_chem("blood", "blood", src.target_transfer, 0)
				M:damaga(2, "organ")
				src.desc = "A syringe, filled with something."
			else


				var/bpart_name = "body"

				switch(bpart_affected:name)
					if("head")
						bpart_name = "head"
					if("r_leg")
						bpart_name = "right leg"
					if("l_leg")
						bpart_name = "left leg"
					if("r_arm")
						bpart_name = "right arm"
					if("l_arm")
						bpart_name = "left arm"

				src.show_message("[usr] shoots something into the vein on [M:name]'s [bpart_name]!")



				for(var/datum/reagent/R in reagent_list)
					R.on_iv(R:amount, M, bpart_affected:name)
				src.transfer_to_mob(src.target_transfer, M)
				src.desc = null
				if(src:onetime)
					spawn(0) usr.delitem()
	else
		..()












































/datum/reagent/proc/on_iv(quaziamt, mob/M, limbname = null)
	var/q_sum = 0
	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == src.id)
			q_sum += RE.amount
	for(var/datum/on_iv/R in on_iv_avaible)
		if(src.id == R.rid)
			R.react(quaziamt, src, M, q_sum, limbname)



/datum/on_iv/proc/react(quaziamt, R, mob/M, q_sum, limbname = null)
	world << "\red <font size = 5>ON_IV IS BROKEN, HURR DURR</font>"
/datum/on_iv/speed
	rid = "ampetamine"
/datum/on_iv/speed
/datum/on_iv/speed/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(q_sum >= 1.9)
		M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
		M:euphoria++
	else
		if(quaziamt >= 2.25)

			M << "\blue You feel a rush of energy!"
			if(M:calm > 15)
				if(prob(66))
					M:calm = 15
				else
					M:calm -= 2
			if(M:stuntime)
				M:stuntime = 0
			if(M:drowsy)
				M:drowsy = 0
			M:euphoria += 15
/datum/on_iv/dextrospeed
	rid = "dextroampetamine"
/datum/on_iv/dextrospeed
/datum/on_iv/dextrospeed/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(q_sum >= 1.9)
		M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
		M:euphoria++
	else
		if(quaziamt >= 2.25)

			M << "\blue You feel a rush of energy!"
			if(M:calm > 15)
				if(prob(66))
					M:calm = 15
				else
					M:calm -= 2
			if(M:stuntime)
				M:stuntime = 0
			if(M:drowsy)
				M:drowsy = 0
			M:euphoria += 15
/datum/on_iv/meth
	rid = "methamphetamine"
/datum/on_iv/meth
/datum/on_iv/meth/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(q_sum > 1.5)
		M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
		M:euphoria += 2
	else
		if(quaziamt >= 1.85)
			M << "\blue You feel a rush of energy!"
			if(M:calm > 15)
				if(prob(66))
					M:calm = 15
				else
					M:calm -= 2
			if(M:stuntime)
				M:stuntime = 0
			if(M:drowsy)
				M:drowsy = 0
			M:euphoria += 18
/datum/on_iv/dextrometh
	rid = "dextromethamphetamine"
/datum/on_iv/dextrometh
/datum/on_iv/dextrometh/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(q_sum > 1.6)
		M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
		M:euphoria += 2
	else
		if(quaziamt >= 1.85)
			M << "\blue You feel a rush of energy!"
			if(M:calm > 15)
				M:calm = 15
			if(M:stuntime)
				M:stuntime = 0
			if(M:drowsy)
				M:drowsy = 0
			M:euphoria += 20
/datum/on_iv/mdpv
	rid = "MDPV"
/datum/on_iv/mdpv
/datum/on_iv/mdpv/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(q_sum > 2)
		M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
		M:euphoria++
	else
		if(quaziamt >= 2.23)
			M << "\blue You feel a rush of energy!"
			if(M:calm > 15)
				if(prob(50))
					M:calm = 15
				else
					M:calm -= 2
			if(M:stuntime)
				M:stuntime = 0
			if(M:drowsy)
				M:drowsy = 0
			M:euphoria += 10
/datum/on_iv/methcathinone
	rid = "methcathinone"
/datum/on_iv/methcathinone
/datum/on_iv/methcathinone/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(q_sum > 1.5)
		M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
		M:euphoria += 2
	else
		if(quaziamt >= 2)
			M << "\blue You feel a rush of energy!"
			if(M:calm > 15)
				if(prob(66))
					M:calm = 15
				else
					M:calm -= 2
			if(M:stuntime)
				M:stuntime = 0
			if(M:drowsy)
				M:drowsy = 0
			M:euphoria += 20
/datum/on_iv/ffa
	rid = "4-FA"
/datum/on_iv/ffa
/datum/on_iv/ffa/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(q_sum > 1.5)
		M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
		M:euphoria += 2
	else
		if(quaziamt >= 2)
			M << "\blue You feel a rush of energy!"
			if(M:calm > 15)
				if(prob(50))
					M:calm = 15
				else
					M:calm -= 2
			if(M:stuntime)
				M:stuntime = 0
			if(M:drowsy)
				M:drowsy = 0
			M:euphoria += 18
/datum/on_iv/meow
	rid = "mephedrone"
/datum/on_iv/meow
/datum/on_iv/meow/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(q_sum > 1.5)
		M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
		M:euphoria += 2
	else
		if(quaziamt >= 2)
			M << "\blue You feel a rush of energy!"
			if(M:calm > 15)
				if(prob(50))
					M:calm = 15
				else
					M:calm -= 2
			if(M:stuntime)
				M:stuntime = 0
			if(M:drowsy)
				M:drowsy = 0
			M:euphoria += 25
/datum/on_iv/cocaine
	rid = "cocaine"
/datum/on_iv/cocaine
/datum/on_iv/cocaine/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(q_sum > 1.5)
		M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
		M:euphoria += 2
	else
		if(quaziamt >= 4)
			M << "\blue You feel a rush of energy!"
			if(M:calm > 15)
				if(prob(50))
					M:calm = 15
				else
					M:calm -= 2
			if(M:stuntime)
				M:stuntime = 0
			if(M:drowsy)
				M:drowsy = 0
			M:euphoria += 25

/datum/on_iv/opium
	rid = "opium"
/datum/on_iv/opium
/datum/on_iv/opium/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "codeine" || RE.id == "morphie")
			q_sum += RE.amount

	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.25)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.3)

				M:damaga(5, "organ")

				M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
				M:euphoria += 40

				if(M:calm < 20)
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"

/datum/on_iv/morphine
	rid = "morphine"
/datum/on_iv/morphine
/datum/on_iv/morphine/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.25)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.3)

				M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
				M:euphoria += 40

				if(M:calm < 20)
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"
/datum/on_iv/codeine
	rid = "codeine"
/datum/on_iv/codeine
/datum/on_iv/codeine/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)


	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.3)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.35)
				M << "\green \bold [pick("Da-a-amn, you feel good", "This is just awesome", "Fu-uck, so much of a goodness")]"
				M:euphoria += 25

				if(M:calm < 20)
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"
/datum/on_iv/tramadol
	rid = "tramadol"
/datum/on_iv/tramadol
/datum/on_iv/tramadol/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.3)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.35)
				M << "\green \bold [pick("Da-a-amn, you feel good", "This is just awesome", "Fu-uck, so much of a goodness")]"
				M:euphoria += 35

				if(M:calm < 20)
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"
/datum/on_iv/buprenorphine
	rid = "buprenorphine"
/datum/on_iv/buprenorphine
/datum/on_iv/buprenorphine/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(q_sum > 0.3)
		M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
		M:euphoria += 2
	else
		if(quaziamt >= 0.35)
			M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
			M:euphoria += 45

			if(M:calm < 20)
				M:calm = 20
				M:show_message("\red \bold [M:name] closes \his eyes and smiles")
			else
				M:calm += 5

			for(var/mob/V in hearers(M))
				if(!V.sleeps)
					V << "\red \bold [M:name] moans in pleasure!"
/datum/on_iv/heroin
	rid = "heroin"
/datum/on_iv/heroin
/datum/on_iv/heroin/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.15)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.2)

				M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
				M:euphoria += 70

				if(M:calm < 20)
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"
/datum/on_iv/methadone
	rid = "methadone"
/datum/on_iv/methadone
/datum/on_iv/methadone/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.15)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.2)

				M << "\green \bold [pick("Da-a-amn, you feel good", "This is just awesome", "Fu-uck, so much of a goodness")]"
				M:euphoria += 45

				if(M:calm < 20)
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"
/datum/on_iv/desomorphine
	rid = "desomorphine"
/datum/on_iv/desomorphine
/datum/on_iv/desomorphine/react(datum/quaziamt, R, mob/M as mob, q_sum, limbname = null)

	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.2)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.25)

				M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
				M:euphoria += 50

				if(M:calm < 20)
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"

	if(limbname && prob(20))

		var/truelimb = return_limbname(limbname)

		if(limbname != "body")

			M:limb_damage(10, 1, 0, limbname)
		else


			M:damaga(5, "organ")

		M:show_message("\red Oh my Marx, [M:name]'s [truelimb] is rotting!")
		M << "\red Probably, you shouldn't do such a dirty drugs."
/datum/on_iv/oxycodone
	rid = "oxycodone"
/datum/on_iv/oxycodone
/datum/on_iv/oxycodone/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.08)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.1)

				M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
				M:euphoria += 55

				if(M:calm < 20)
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"
/datum/on_iv/fentanyl
	rid = "fentanyl"
/datum/on_iv/fentanyl
/datum/on_iv/fentanyl/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.008)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.01)

				M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
				M:euphoria += 70

				if(M:calm < 20)
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"
/datum/on_iv/acetylfentanyl
	rid = "acetylfentanyl"
/datum/on_iv/acetylfentanyl
/datum/on_iv/acetylfentanyl/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.012)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.015)

				M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
				M:euphoria += 70

				if(M:calm < 20)
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"
/datum/on_iv/hydrocodone
	rid = "hydrocodone"
/datum/on_iv/hydrocodone
/datum/on_iv/hydrocodone/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)


	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.1)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.15)
				M << "\green \bold [pick("Da-a-amn, you feel good", "This is just awesome", "Fu-uck, so much of a goodness")]"
				M:euphoria += 55

				if(M:calm < 20)
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"

/datum/on_iv/aluminum
	rid = "aluminum"

/datum/on_iv/aluminum
/datum/on_iv/aluminum/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(quaziamt > 5)
		M << "\red \bold Damn, it hurts as fuck."
		M:torment(5)
		M:stun(3)
		M:chronoclock += 20
		M:damaga(10, "organ")
	else
		if(quaziamt >= 0.5)
			M << "\red \bold Damn, it hurts as fuck."
			M:torment(5)
			M:stun(3)
			M:chronoclock += 20
			M:damaga(rand(1, 6), "organ")

	if(limbname && prob(20))

		var/truelimb = return_limbname(limbname)

		if(limbname != "body")

			M:limb_damage(10, 1, 0, limbname)
		else


			M:damaga(5, "organ")

		M:show_message("\red Oh my Marx, [M:name]'s [truelimb] is rotting!")
/datum/on_iv/carbon
	rid = "carbon"
/datum/on_iv/carbon
/datum/on_iv/carbon/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(quaziamt > 5)
		M << "\red \bold Damn, it hurts as fuck."
		M:torment(5)
		M:stun(3)
		M:chronoclock += 20
		M:damaga(10, "organ")
	else
		if(quaziamt >= 1)
			M << "\red \bold Damn, it hurts as fuck."
			M:torment(5)
			M:stun(3)
			M:chronoclock += 20
			M:damaga(rand(1, 6), "organ")

	if(limbname && prob(20))

		var/truelimb = return_limbname(limbname)

		if(limbname != "body")

			M:limb_damage(10, 1, 0, limbname)
		else


			M:damaga(5, "organ")

		M:show_message("\red Oh my Marx, [M:name]'s [truelimb] is rotting!")
/datum/on_iv/salt
	rid = "salt"
/datum/on_iv/salt
/datum/on_iv/salt/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(quaziamt > 5)
		M << "\red \bold Damn, it hurts as fuck."
		M:torment(5)
		M:stun(3)
		M:chronoclock += 20
		M:damaga(10, "organ")
	else
		if(quaziamt >= 0.5)
			M << "\red \bold Damn, it hurts as fuck."
			M:torment(5)
			M:stun(3)
			M:chronoclock += 20
			M:damaga(rand(1, 6), "organ")

	if(limbname && prob(20))

		var/truelimb = return_limbname(limbname)

		if(limbname != "body")

			M:limb_damage(10, 1, 0, limbname)
		else


			M:damaga(5, "organ")

		M:show_message("\red Oh my Marx, [M:name]'s [truelimb] is rotting!")
/datum/on_iv/cellulose
	rid = "cellulose"
/datum/on_iv/cellulose
/datum/on_iv/cellulose/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(quaziamt > 5)
		M << "\red \bold Damn, it hurts as fuck."
		M:torment(5)
		M:stun(3)
		M:chronoclock += 20
		M:damaga(10, "organ")
	else
		if(quaziamt >= 0.5)
			M << "\red \bold Damn, it hurts as fuck."
			M:torment(5)
			M:stun(3)
			M:chronoclock += 20
			M:damaga(rand(1, 6), "organ")

	if(limbname && prob(20))

		var/truelimb = return_limbname(limbname)

		if(limbname != "body")

			M:limb_damage(10, 1, 0, limbname)
		else


			M:damaga(5, "organ")

		M:show_message("\red Oh my Marx, [M:name]'s [truelimb] is rotting!")
/datum/on_iv/rhinestones
	rid = "rhinestones"
/datum/on_iv/rhinestones
/datum/on_iv/rhinestones/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(quaziamt > 5)
		M << "\red \bold Damn, it hurts as fuck."
		M:torment(5)
		M:stun(3)
		M:chronoclock += 20
		M:damaga(10, "organ")
	else
		if(quaziamt >= 0.5)
			M << "\red \bold Damn, it hurts as fuck."
			M:torment(5)
			M:stun(3)
			M:chronoclock += 20
			M:damaga(rand(1, 6), "organ")

	if(limbname && prob(20))

		var/truelimb = return_limbname(limbname)

		if(limbname != "body")

			M:limb_damage(10, 1, 0, limbname)
		else


			M:damaga(5, "organ")

		M:show_message("\red Oh my Marx, [M:name]'s [truelimb] is rotting!")
	M << "\red Nope, shooting rhinestones is not as awesome as it sounds."
/datum/on_iv/silicon
	rid = "silicon"
/datum/on_iv/silicon
/datum/on_iv/silicon/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(quaziamt > 5)
		M << "\red \bold Damn, it hurts as fuck."
		M:torment(5)
		M:stun(3)
		M:chronoclock += 20
		M:damaga(10, "organ")
	else
		if(quaziamt >= 0.5)
			M << "\red \bold Damn, it hurts as fuck."
			M:torment(5)
			M:stun(3)
			M:chronoclock += 20
			M:damaga(rand(1, 6), "organ")

	if(limbname && prob(20))

		var/truelimb = return_limbname(limbname)

		if(limbname != "body")

			M:limb_damage(10, 1, 0, limbname)
		else


			M:damaga(5, "organ")

		M:show_message("\red Oh my Marx, [M:name]'s [truelimb] is rotting!")
/datum/on_iv/sulfur
	rid = "sulfur"
/datum/on_iv/sulfur
/datum/on_iv/sulfur/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	if(quaziamt > 4)
		M << "\red \bold FUCKING KRUPSKAYA THE PAIN THE PAIN"
		M:torment(10)
		M:stun(6)
		M:chronoclock += 20
		M:damaga(2, "organ")
	else
		if(quaziamt >= 0.5)
			M << "\red \bold Damn, it hurts as fuck."
			M:torment(5)
			M:stun(3)
			M:chronoclock += 15
			M:damaga(1, "organ")

