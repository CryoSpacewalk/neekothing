// Recovered from compiled neek.dmb (7 procs)
/datum/drug_design
	var/name = "reportitium buggenerite"
	var/dosage = 0.5
	var/euphoria_bonus = 0
	var/panic_bonus = 0
	var/psi_bonus = 0
	var/dmt = 0
	var/adrenochrome = 0
	var/serotonin = 0
	var/mephedrone = 0
	var/JWH = 0
	var/ambrosine = 0
	var/nausea = 0
	var/thrill = 0
	var/lomka = 0
	var/antidepressant = 0
	var/painkiller = 0
	var/stim_addiction = 0
	var/haste = 0
	var/heals_burn = 0
	var/heals_brute = 0
	var/heals_organ = 0
	var/heals_wounds = 0
	var/heals_epilepsy = 0
	var/hidden_reagent = "iron"
	var/requires_heat = 0
	var/cured_by_antidote = 0
	var/cured_by_benzos = 0
	var/cured_by_neuros = 0
	var/antidote = "antidote"






















/datum/drug_design/shining_powder
	name = "shining powder"
	panic_bonus = -1
/datum/drug_design/shining_powder
/datum/drug_design/shining_powder/New()
	src.dosage = rand(3, 6) / 10
	src.euphoria_bonus = 5
	src.psi_bonus = 1

	if(prob(33))
		src.serotonin = 1

	if(prob(25))
		src.mephedrone = 1
	else if(prob(50))
		src.stim_addiction = 1
		src.haste = 2
		stim_list["shining powder"] = 2

	if(prob(50))
		src.thrill = 1

	if(prob(33))
		src.lomka = 1
	if(prob(33))
		src.antidepressant = 1

	if(prob(50))
		src.heals_organ = -1

	src.hidden_reagent = pick("potassium", "aluminum", "iron", "mercury", "lithium", "sodium", "polonium")
	spawn(5)
		for(var/datum/reaction/R in reactions_avaible)
			if(R.id == "benzaldehyde+phenethylamine+mitol")
				R.r2 = src.hidden_reagent

	src.cured_by_benzos = pick(0, 1)
	src.cured_by_neuros = 1
	src.antidote = pick("potassium", "lithium", "sodium")
	return
/datum/drug_design/mysterious_powder
	name = "mysterious powder"
/datum/drug_design/mysterious_powder
/datum/drug_design/mysterious_powder/New()
	src.dosage = rand(3, 6) / 10
	src.euphoria_bonus = 5
	src.psi_bonus = 1
	src.panic_bonus = rand(-2, 0)

	src.serotonin = pick(0, 1)

	if(prob(25))
		src.adrenochrome = 1

	if(prob(25))
		src.JWH = 1

	if(prob(66))
		src.dmt = 1
	else
		var/prodrug_rand = rand(1, 3)
		switch(prodrug_rand)
			if(1)
				src.adrenochrome = 1
			if(2)
				src.serotonin = 1
			if(3)
				src.ambrosine = 1

	if(prob(50))
		src.thrill = 1

	if(prob(33))
		src.lomka = 1
	if(prob(33))
		src.antidepressant = 1
	if(prob(25))
		src.painkiller = 1

	if(prob(50))
		src.heals_organ = -1

	src.hidden_reagent = pick("potassium", "aluminum", "iron", "mercury", "lithium", "sodium", "polonium")
	if(prob(33))
		src.requires_heat = 1
	spawn(5)
		for(var/datum/reaction/R in reactions_avaible)
			if(R.id == "DiPT+mitol+piracetam")
				R.r2 = src.hidden_reagent
			if(src.requires_heat)
				R.requests_temp = 1

	src.cured_by_benzos = pick(0, 1)
	src.cured_by_neuros = 1
	antidote = pick("antidote", "manganeska", "mangadote")
	return
/datum/drug_design/gloomy_powder
	name = "gloomy powder"
/datum/drug_design/gloomy_powder
/datum/drug_design/gloomy_powder/New()
	src.dosage = rand(3, 6) / 10
	src.euphoria_bonus = 2
	src.panic_bonus = rand(1, 5)

	if(prob(20))
		src.ambrosine = 1

	if(prob(50))
		src.thrill = -1

	if(prob(33))
		src.lomka = 1
	if(prob(33))
		src.antidepressant = 1
	if(prob(33))
		src.painkiller = 1

	src.nausea = rand(-1, 1)

	src.heals_organ = rand(-1, 1)
	src.heals_brute = rand(0, 1)
	src.heals_burn = rand(0, 1)
	src.heals_wounds = rand(0, 1)
	src.heals_epilepsy = rand(0, 1)

	src.hidden_reagent = pick("aluminum", "iron", "mercury", "lithium", "sodium", "polonium")
	if(prob(33))
		src.requires_heat = 1
	spawn(5)
		for(var/datum/reaction/R in reactions_avaible)
			if(R.id == "benzodiazepine+mitol+benzaldehyde")
				R.r2 = src.hidden_reagent
			if(src.requires_heat)
				R.requests_temp = 1

	antidote = pick("antidote", "manganeska", "mangadote")
	return
/datum/drug_design/powder_of_wonders
	name = "powder of wonders"
/datum/drug_design/powder_of_wonders
/datum/drug_design/powder_of_wonders/New()
	src.dosage = rand(3, 6) / 10

	if(prob(33))
		src.ambrosine = 1
	if(prob(50))
		src.dmt = 1
	if(prob(50))
		src.serotonin = 1
	if(prob(50))
		src.adrenochrome = 1
	if(prob(50))
		src.JWH = 1
	if(prob(50))
		src.mephedrone = 1

	if(!src.mephedrone && (!src.JWH && (!src.dmt && !src.serotonin)))
		src.dmt = 1
		src.JWH = 1
		src.serotonin = 1
		src.mephedrone = 1

	src.hidden_reagent = pick("fibgenerite", "mangadote")
	if(prob(33))
		src.requires_heat = 1
	spawn(5)
		for(var/datum/reaction/R in reactions_avaible)
			if(R.id == "ambrosine+mitol+DMT")
				R.r2 = src.hidden_reagent
			if(src.requires_heat)
				R.requests_temp = 1

	antidote = pick("antidote", "manganeska", "mangadote")
	return
/datum/drug_design/eldritch_powder
	name = "eldritch powder"
/datum/drug_design/eldritch_powder
/datum/drug_design/eldritch_powder/New()
	src.dosage = rand(1, 3) / 20

	src.euphoria_bonus = rand(-10, 10)
	src.panic_bonus = rand(-2, 2)
	src.psi_bonus = pick(0, 1)

	if(prob(25))
		src.dmt = 1
	if(prob(25))
		src.adrenochrome = 1
	if(prob(25))
		src.mephedrone = 1
	if(prob(25))
		src.serotonin = 1
	if(prob(25))
		src.JWH = 1
	if(prob(25))
		src.ambrosine = pick(0, 1)

	src.nausea = rand(-1, 1)
	src.thrill = rand(-1, 1)
	if(prob(25))
		src.lomka = 1
	if(prob(25))
		src.antidepressant = 1
	if(prob(25))
		src.dmt = pick(0, 1)
	src.painkiller = pick(0, 1)

	if(prob(33))
		src.heals_burn = 1
	if(prob(33))
		src.heals_brute = 1
	if(prob(33))
		src.heals_organ = 1
	else
		src.heals_organ = -1
	if(prob(33))
		src.heals_wounds = 1
	if(prob(33))
		src.heals_epilepsy = 1

	src.hidden_reagent = pick("biotoxin", "corpse rot", "atropine", "aqua regia")
	spawn(5)
		for(var/datum/reaction/R in reactions_avaible)
			if(R.id == "Nuclear titbit+mitol")
				R.r2 = src.hidden_reagent

	src.cured_by_antidote = pick(0, 1)
	src.cured_by_benzos = pick(0, 1)
	src.cured_by_neuros = pick(0, 1)
	src.antidote = "warpotoxin"
	return


/proc/design_on_mob(quaziamt, mob/M, D)







	if(D:euphoria_bonus)
		M:euphoria += D:euphoria_bonus
	if(D:panic_bonus)
		M:calm += D:panic_bonus
	if(D:psi_bonus)
		M:psi += D:psi_bonus

	if(D:dmt)
		M:add_chem("DMT", "DMT", 0.03, 0)
	if(D:adrenochrome)
		M:add_chem("adrenochrome", "adrenochrome", 0.066, 0)
	if(D:serotonin)
		M:add_chem("serotonin", "serotonin", 0.005, 0)
	if(D:mephedrone)
		M:add_chem("mephedrone", "mephedrone", 0.06, 0)
	if(D:JWH)
		M:add_chem("JWH-018", "JWH-018", 0.16, 0)
	if(D:ambrosine)
		M:add_chem("ambrosine", "ambrosine", 1, 0)

	if(D:nausea)
		M:nausea++
		if(prob(25))
			M << "\red You feel nauseous."
	else if(D:nausea < 0 && M:nausea)
		M:nausea--
		if(prob(25))
			M << "\green You feel less nauseous."

	if(D:thrill)
		M:thrill++
		if(prob(25))
			M << "\red You feel jittery."
	else if(D:thrill < 0 && M:thrill)
		M:thrill--
		if(prob(25))
			M << "\red You feel less jittery."

	if(D:lomka)
		if(M:tension)
			M:tension--
			if(prob(25))
				M << "\green You feel a bit better."
		if(M:depression)
			M:depression--
			if(prob(25))
				M << "\green You cheer up by a tiny bit."

	if(D:antidepressant)
		if(M:chronoclock > 10)
			M:chronoclock -= 10
			if(prob(25))
				M << "\green Looks like you're less likely to get dysthimia."
		else if(M:chronoclock)
			M:chronoclock--
		if(M:chronodepr && prob(10 + quaziamt / D:dosage))
			M:chronodepr--
			M << "\green \bold You feel your dysthimia weakening. Hell yea!"

	if(D:painkiller)
		M:pain = 0
		if(M:painless < 5)
			M:painless++

	if(D:stim_addiction)
		M:stim++

	if(D:heals_brute)
		M:heal(2, "brute")
	if(D:heals_burn)
		M:heal(2, "burn")
	if(D:heals_organ)
		M:heal(2, "organ")
	else if(D:heals_organ < 0)
		M:damaga(2, "organ")
	if(D:heals_wounds)
		if(M:wounds && prob(33))
			M:woundcure(1)
			M << "\green One of your wounds mysteriously dissappears."
	if(D:heals_epilepsy)
		if(M:epilepsy)
			M:epilepsy--

	var/antidoted = 0
	for(var/datum/reagent/R in M:blood_chem)
		if(D:cured_by_antidote && R.name == "antidote")
			antidoted = 1
		if(D:cured_by_benzos && R.name in world_benzos)
			antidoted = 1
		if(D:cured_by_neuros && R.name in world_neuros)
			antidoted = 1
		if(D:antidote == R.name)
			antidoted = 1

	if(antidoted)
		M:remove_chem(D:name, quaziamt / 2)

	spawn(0)
		if(D:stim_addiction)
			M:st_tick = 5

		M:remove_chem(D:name, D:dosage)

/mob/proc/checkout_eldritch()
	set name = "checkout eldritch powder"
	set category = "debug"
	for(var/datum/reaction/eldritch_powder/E in reactions_avaible)
		usr << "[E.r2]"
	for(var/datum/drug_design/D in designer_drugs)
		usr << "[D.name] [D.hidden_reagent]"