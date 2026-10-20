// Recovered from compiled neek.dmb (7 procs)

/proc/encryptor_message(msg)

	for(var/obj/item/device/communicator/C in world)
		C.playsound('sounds/engine.wav')
		C.show_message("Encryptor beeps:")
		C.show_message(msg)
	for(var/obj/item/device/krokodil/K in world)
		K.playsound('sounds/engine.wav')
		K.show_message("[K.name] beeps:")
		K.show_message(msg)
	for(var/obj/comp/alert/A in world)
		A.playsound('sounds/engine.wav')
		A.show_message("\blue The console softly beeps to you:")
		A.show_message(msg)
		A.messages += msg

/proc/svetov_up(perc)
	encryptor_message("\blue Svetovs are up by [perc]%!")
	svetov_value += svetov_value * perc / 100

/proc/cherenkov_up(perc)
	encryptor_message("\blue Cherenkovs are up by [perc]%!")
	cherenkov_value += cherenkov_value * perc / 100

/proc/market_meltdown()
	encryptor_message("\red Cryptocurrency market meltdown! Price of all cryptocurrency is halvened!")
	cherenkov_value /= 2
	svetov_value /= 2

/proc/opiates_meltdown(perc)
	encryptor_message("\blue BREAKING NEWS! A new bluespace well leading to 'Palladium triangle' opium poppy plantations and methadone factories is discovered! All of the opiates are now [perc]% cheaper! Expect minor (+[perc / 2]%) cryptoccurency value changes as well.")
	svetov_value += svetov_value * perc / 200
	cherenkov_value += cherenkov_value * perc / 200
	var/opium_price = 1 - perc / 100

	for(var/datum/baryga/B in barygas)
		for(var/datum/tovar/T in B.goods)
			if(T.opy)
				T.price *= opium_price

	for(var/datum/goodlist/G in markets)
		for(var/datum/tovar/T in G)
			if(T.opy)
				T.price *= opium_price

/proc/opiates_deflation(perc)
	encryptor_message("\red BREAKING NEWS! Due to USSR-4 opioid prohibicionism, all of the opiates are now [perc]% more expensive! Expect minor (-[perc / 2]%) cryptoccurency value changes as well.")
	svetov_value -= svetov_value * perc / 200
	cherenkov_value -= cherenkov_value * perc / 200
	var/opium_price = 1 + perc / 100

	for(var/datum/baryga/B in barygas)
		for(var/datum/tovar/T in B.goods)
			if(T.opy)
				T.price *= opium_price

	for(var/datum/goodlist/G in markets)
		for(var/datum/tovar/T in G)
			if(T.opy)
				T.price *= opium_price

/proc/economical_events()

	var/d10 = rand(1, 10)

	switch(d10)
		if(1 to 3)
			svetov_up(rand(10, 50))
		if(4 to 6)

			cherenkov_up(rand(10, 50))
		if(8)

			market_meltdown()
		if(9)

			opiates_meltdown(rand(10, 25))
		if(10)

			opiates_deflation(rand(10, 25))
