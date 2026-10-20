// Recovered from compiled neek.dmb (3 procs)

/obj/item/medical
	beltable = 1
	var/fake = 0

/obj/item/medical


/obj/item/medical/toxmeter
	accu = 90
	dmg = 1
	name = "Blood analyzer"
	icon_state = "toxmeter"

/obj/item/medical/toxmeter


/obj/item/medical/toxmeter/fake
	fake = 1
	charges = 1
	name = "Blood analyzer"

/obj/item/medical/toxmeter/fake

/obj/item/medical/toxmeter/attack(mob/M, mob/user)










	..()
	if(ismob(M))
		M:show_message("\blue [user] takes a blood sample from the [M].", "\blue [user] takes your blood sample.")
		if(!src.fake)
			if(!length(M:blood_chem))
				usr << "\blue No trace chemicals detected in [M]'s bloodstream."
			else
				for(var/datum/reagent/R in M:blood_chem)
					usr << "\blue \bold \italic [R.name]: [R.amount]"
		else if(charges)
			M:add_chem("atropine", "atropine", 10, 0)
			M:add_chem("starsalve", "starsalve", 10, 0)
			src.charges--
/obj/item/medical/bodyscan{accu = 80; dmg = 0; name = "Body scanner"; icon_state = "bodyscan"}
/obj/item/medical/bodyscan/fake{accu = 95; dmg = 80; fake = 1; name = "Body scanner"}
/obj/item/medical/bodyscan/attack(mob/M, mob/user)
	..()
	if(user:processing)
		return
	if(!istype(M, /mob))
		return
	if(!(M:mat == "flesh"))
		return
	M:show_message("\blue [user] tries to scan [M]'s body.", "\blue [user] tries to scan your body.")
	if(istype(usr.item, /obj/item/medical/bodyscan/fake))
		return
	if(prob(usr.epilepsy))
		usr << "\red \bold The screen of [src.name] is too shiny!"
		usr.seizure(4)
		return
	sleep(0)
	user:processing = 1
	spawn(30)
		user:processing = 0
		if(istype(usr.item, /obj/item/medical/bodyscan) && (usr in range(1, M)))

			var/maxhepe = 100
			if(M:class == "rooster")
				maxhepe = 25
			M << "\blue [usr] scans [M:name]'s body."
			usr << "\blue Device softly beeps to you:"
			usr << "\blue \bold \italic [M]'s body condition: [maxhepe - M:brutedmg]"
			usr << "\blue \bold \italic [M]'s organs condition: [maxhepe - M:organdmg]"
			usr << "\blue \bold \italic [M]'s skin condition: [maxhepe - M:burndmg]"
			usr << ""
			if(M:radtox)
				usr << "\red This person radiation poisoning level is [M:radtox]. Use ASD to get rid of it before it is too late!"
			if(M:coughy)
				usr << "\red This is suffering from cough, caused either by inhalating gases, vapours or by the flu."
				usr << ""
			if(M:chronoclock)
				usr << "\red This person depression potencial is [M:chronoclock]. If it reaches 100, then this folk will suffer from dysthymia."
			if(M:aids)
				usr << "\red \bold \italic This guy is suffering from AIDS! I hope you know how to operate medlab machinery."
			if(M:flu > 0)
				usr << "\red \bold \italic This guy is suffering from space flu!"
			if(M:flu < 0)
				usr << "\blue \italic This guy have a flu immunity."
			if(M:syphilis)
				usr << "\red \bold \italic This guy is suffering from neurosyphilis! Feed him some mercury preparations or he will fall apart!"
			if(M:chronodepr)
				usr << "\red \bold \italic This guy is suffering from chronic depression! You should contact psychiatrist as soon as possible!"
			if(M:epilepsy)
				usr << "\red \bold \italic This guy is suffering from epilepsy! Dostoevsky factor: [M:epilepsy]. Either precipt him some anti-epileptic drugs (gabapentin, benzos, barbiturates and a bunch of others) or contact psychiatrist!"
			if(M:schizo)
				usr << "\red \bold \italic This guy is suffering from schizophrenia! You should contact psychiatrist as soon as possible!"
			if(M:ssyndrome)
				usr << "\red \bold \italic This person is suffering from serotonin syndrome! You should contact psychiatrist as soon as possible!"

/obj/item/medical/mindscan
	accu = 80
	dmg = 0
	name = "CNS scanner"
	icon_state = "mindscan"

/obj/item/medical/mindscan


/obj/item/medical/mindscan/attack(mob/M, mob/user)



	..()
	if(user:processing)
		return
	if(!istype(M, /mob))
		return
	if(!(M:mat == "flesh"))
		return
	if(prob(usr.epilepsy))
		usr << "\red \bold The screen of [src.name] is too shiny!"
		usr.seizure(4)
		return
	M:show_message("\blue [user] tries to check [M]'s CNS condition.", "\blue [user] tries to check your CNS condition.")
	sleep(0)
	user:processing = 1
	spawn(30)
		user:processing = 0
		if(istype(usr.item, /obj/item/medical/mindscan) && (usr in range(1, M)))

			M << "\blue [usr] scans [M]'s CNS."
			usr << "\blue Device softly beeps to you:"

			usr << ""
			usr << "\red Delirium level: [M:delirium]"
			usr << "\red Visual perception enrichment: [M:see_invisible]"
			usr << "\red Tongue numbness: [M:says_xynta]"
			usr << "\red Psionic potential: [M:psi]"

			usr << ""

			usr << "\red Tension level: [M:tension]"
			usr << "\red Thrill level: [M:thrill]"
			usr << "\red Nausea: [M:nausea]"
			usr << "\red Non-chronic depression level: [M:depression]"

			usr << ""

			if(M:barbi || (M:benzo || (M:hmur || (M:stim || (M:alcho || (M:ghb || M:cigs))))))
				usr << "\bold \italic Addiction factors: "
				usr << "\italic Barbiturates addiction factor: [M:barbi] (55+ means addiction, cured by glucose)"
				usr << "\italic Benzodiazepines addiction factor: [M:benzo] (60+ means addiction, cured by glucose)"
				usr << "\italic Opiates addiction factor: [M:hmur] (70+ means addiction, cured by glucose)"
				usr << "\italic Amphetamines addiction factor: [M:stim] (50+ means addiction)"
				usr << "\italic Ethanol addiction factor: [M:alcho] (20+ means hangover, 110+ can result in delirium, cured by glucose)"
				usr << "\italic GABA derivatives addiction factor: [M:ghb] (55+ means addiction, can be cured with phenibut or pure GABA... sometimes, also cured by glucose)"
				if(M:ci_tick)
					usr << "\italic Nicotine addiction factor: [M:cigs] (he needs to smoke in [M:ci_tick] chemticks)"
				else if(M:cigs)
					usr << "\italic Nicotine addiction factor: [M:cigs] (he is currently on nicotine withdrawal)"
			else
				usr << "\green \bold \italic No addictions detected."

			usr << ""
			if(M:chronoclock)
				usr << "\red This person depression potencial is [M:chronoclock]. If it reaches 100, then this folk will suffer from dysthymia."

			usr << ""
			if(M:epilepsy)
				usr << "\red \bold \italic This person is suffering from epilepsy. Dostoevsky factor: [M:epilepsy]. Use anti-epileptic medicine (gabapentin, benzos, barbiturates, carbamazepine and a bunch of others) to make his life easier."
			else
				usr << "\blue \italic No epilepsy detected."

			usr << ""
			if(M:schizo)
				usr << "\red \bold \italic This person is suffering from schizophrenia."
				usr << "\red \bold Jacoby's factor: [M:schizo] (10+ usually requires immediate hospitalisation)"
			else
				usr << "\blue \italic No schizophrenia spectrum disorders detected."

			usr << ""
			if(M:chronodepr)
				usr << "\red \bold \italic This person is suffering from dysthymia."
				usr << "\red \bold Letov's factor: [M:chronodepr] (10+ usually requires immediate hospitalisation)"
			else
				usr << "\blue \italic No depressive disorders detected."

			usr << ""
			if(M:ssyndrome)
				usr << "\red \bold \italic This person is suffering from serotonin syndrome."
				usr << "\red \bold Castaneda's factor: [M:ssyndrome] (5+ is extremely dangerous and requires immediate hospitalisation)"
			else
				usr << "\blue \italic No serotonin intoxication detected."
