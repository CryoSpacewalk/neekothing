// Recovered from compiled neek.dmb (1 procs)

/mob/proc/equip_head(headz)







	switch(headz)
		if("young recruit of the psychedelic forces")

			src.empowered = 1
			if(prob(25))
				usr.item = new /obj/item/weapon/stunner/shock/start()
		if("okkupay-narkofilyay")

			src.empowered = 1
			if(prob(25))
				usr.item = new /obj/item/weapon/baton()
		if("dorf")

			src.empowered = 1
			if(prob(75))
				usr.item = new /obj/item/tool/pickaxe()
		if("punks not dead, they're just too drunk")

			src.empowered = 1
			usr.item = new /obj/item/reagent_container/beaker/bottle/ethanol()
			src.alcho = 25
		if("pass to the panties")


			if(prob(20))
				usr.item = new /obj/item/reagent_container/beaker/tiny/rohypnol/start()
		if("emoboy")

			usr.item = new /obj/item/reagent_container/beaker/bottle/alchostim()
		if("cannibal hobo")





			src.gib_eater = 1
			usr.item = new /obj/item/reagent_container/beaker/bottle/beer()
			src.alcho = 25
		if("competent researcher")

			usr.item = new /obj/item/reagent_container/consumable/pill/ultramix()

/mob
	var/headperk = null
