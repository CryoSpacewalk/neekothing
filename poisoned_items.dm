// Recovered from compiled neek.dmb (2 procs)

/obj/item
























	var/poisons = list()

/obj/item/proc/add_poison(R, amt_mod)

	var/plused = 0
	for(var/datum/reagent/RE in src.poisons)
		if(RE.id == R:id)
			RE:amount += R:amount / amt_mod
			plused = 1
	if(!plused)
		var/RT = new /datum/reagent()
		RT:id = R:id
		RT:amount = R:amount / amt_mod
		RT:name = R:name
		src.poisons += RT

/obj/item/proc/remove_poison(poison_id)
	for(var/datum/reagent/RE in src.poisons)
		if(RE.id == poison_id)
			src.poisons -= RE
