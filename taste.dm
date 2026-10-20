// Recovered from compiled neek.dmb (2 procs)
/datum/r_taste
	var/rid = "water"
	var/btr = 0
	var/slt = 0
	var/swt = 0
	var/sour = 0
	var/tasty = 0
	var/potents = 0

/obj/item/reagent_container/proc/taste(mob/M, amt)




































































	var/slt = 0
	var/btr = 0
	var/swt = 0
	var/sour = 0
	var/tasty = 0
	var/potency = 1

	var/sum = 0


	for(var/datum/reagent/RT in src.reagent_list)
		sum += RT.amount

	for(var/datum/reagent/RT in src.reagent_list)
		for(var/datum/r_taste/R in taste_avaible)
			if(RT.id == R.rid)
				slt += R.slt * RT.amount / sum
				btr += R.btr * RT.amount / sum
				swt += R.swt * RT.amount / sum
				sour += R.sour * RT.amount / sum
				tasty += R.tasty * RT.amount / sum
				if(R:potents && RT.amount >= 0.5)
					potency++

	tasty *= potency

	M:taste(btr, slt, swt, sour, tasty)

/mob/proc/taste(btr, slt, swt, sour, tasty)


	var/gaytaste = 0

	if(btr == 0 && (slt == 0 && (swt == 0 && (sour == 0 && !tasty))))
		src << "\red It tasted kinda blank."
	else
		if(btr >= 100 && swt < 50)

			src << "\red It is bitter as hell!"
			src.euphoria -= 5
			gaytaste = 1
		else
			if(slt >= 50 && swt < 50)

				src << "\red It feels hellishly salty."
				src.euphoria -= 5
				gaytaste = 1
			else
				if(sour >= 100 && swt < 50)

					src << "\red It it infernally sour."
					src.euphoria -= 5
					gaytaste = 1
				else
					if(btr >= 50 && (swt >= 50 && (slt < 100 && sour < 100)))

						src << "\blue It tastes both sweet and bitter."
						src.euphoria++
					else
						if(swt >= 50 && (sour >= 50 && (slt < 100 && btr < 100)))

							src << "\blue It tastes both sweet and sour."
							src.euphoria++
						else
							if(swt >= 50 && (slt < 50 && (btr < 50 && slt < 50)))

								src << "\blue It tastes sweet."
								src.euphoria++


	if(tasty && !gaytaste)

		src << "\blue It feels fitting."
		src.euphoria += 5

		if(src.hunger < 200 && prob(tasty))
			src << "\green Yay, it really hits the spot!"
			src.euphoria += 10
