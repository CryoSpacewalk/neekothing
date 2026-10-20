// Recovered from compiled neek.dmb (4 procs)

/var/list/reagents_avaible = list("foam", "water", "basic", "manganeska", "manganese", "antidote", "mangadote", "toxin", "chlorine", "fuel", "regenerite", "fibgenerite", "warnipizine", "plant oil", "stalkotoxin", "pogankeepeptide", "aluminum", "iron", "liquid steel", "lithium", "salt", "sodium", "condensed milk", "sulfuric acid", "hydrochloric acid", "nitric acid", "aqua regia", "polytrinic acid", "sgushenka", "nutriment", "ethanol", "methanol", "ammonia", "yeast", "sugar", "cellulose", "milk", "nitrogen", "hydrogen", "ammonium hydroxide", "glycerol", "nitroglycerin", "blood", "AIDS", "codeine", "opium", "heroin", "morphine", "desomorphine", "DPH", "hash oil", "THC", "CBD", "MDA", "MDMA", "toluene", "DXM", "LSD", "psilocybin", "amphetamine", "methamphetamine", "phenethylamine", "2C-B", "DOB", "barbital", "liquid smoke", "urea", "carboxylic acid", "haloperidol", "fluorine", "inytropidril", "montage powder", "nitrogen tourettide", "paracetamol", "ibuprofen", "GABA", "baclofen", "GHB", "Nuclear titbit")

/datum/reagent
	var/name = "LOLOLOLOLOL BUG DETECTED"
	var/id = "basic"
	var/in_reaction = 0
	var/amount = 0















































































	var/reacts_with = list()

/datum/reagent/proc/get_color(r, g, b)








































































	for(var/datum/chemcolor/C in colors_avaible)
		if(C.rid == src.id)
			r = C.r
			g = C.g
			b = C.b

/datum/reagent/proc/get_red()
	for(var/datum/chemcolor/C in colors_avaible)
		if(C.rid == src.id)
			return C.r
	spawn(0) return 255

/datum/reagent/proc/get_green()
	for(var/datum/chemcolor/C in colors_avaible)
		if(C.rid == src.id)
			return C.g
	spawn(0) return 255

/datum/reagent/proc/get_blue()

	for(var/datum/chemcolor/C in colors_avaible)
		if(C.rid == src.id)
			return C.b
	spawn(0) return 255
