/obj/item/bong
	market_price = 12
	igniter = 1
	plastic_need = 1
	var/potency = 1
	var/weed = 0
	var/maxw = 16
	var/thc_k = 1
	var/cbd_k = 0.9
	icon_state = "bong"
	desc = "Well, I don't know who left it here."
/obj/machine/worm
	density = 1
	var/nutri = 0
	name = "Worm vat"
	desc = "A thingy for breeding delicious worms."
	icon_state = "vat"
	alticon = "gvat"
	anchored = 0
	var/drugworm = 0
	var/bioworm = 2
	var/vat
/obj/structure/tray{density = 1; icon = 'grafon/plant.dmi'; var/plantname = "nothing"; name = "hydroponics tray"; icon_state = "tray"; alticon = "gtray"; anchored = 0; var/bugs = 0; var/nutri = 5; var/tox = 0; var/timer = 0; var/growthtime = 0; var/amount = 0; var/maxamount = 0; var/stage = 0; var/image/hunger = 0; var/water = 100; var/hepe = 0; var/seedstage = 0; var/planttype = "mushroom"; var/obj/result = null; var/obj/overplant_end = null; var/obj/overplant_seed = null; var/obj/item/reagent_container/consumable/seed/seedy}
/obj/structure/tray/proc/plant(obj/S)












	src.overlays += S:overplant
	src:overplant_end = S:overplant_end
	src:overplant_seed = S:overplant_seed
	src:seedstage = S:seedstage
	src.hunger = S:hunger
	src:maxamount = S:maxamount1
	src.hepe = S:robust
	src.result = S:result
	src.growthtime = S:growthtime
	src:plantname = S:plantname
	src.timer = src.growthtime
	spawn(0)
		if(istype(src.result, /obj/item/reagent_container/consumable/plant))
			var/obj/item/reagent_container/consumable/plant/P = new src.result()
			src.seedy = P:seed
		src.stage = 1
		spawn(0)

			usr.delitem()
			src.life()
/obj/structure/tray/proc/life()
	if(src.stage > 0)
		if(src.nutri > 0)
			if(src.nutri > src.hunger)
				src.nutri -= src.hunger
			else
				src.nutri = 0
		if(src.water <= 0)
			src.hepe--
		else
			var/dryout = 3
			if(src.planttype == "mushroom")
				dryout = 2
			if(src.water > dryout)
				src.water -= dryout
			else
				src.water = 0
		if(src.nutri == 0)
			if(src.hepe > 2)
				src.hepe -= 2
			else
				src.hepe = 0
		if(prob(30))
			src.hepe -= src.tox
		if(prob(5) && src.nutri > 0)
			src.hepe += 1
		if(prob(10) && src.tox > 0)
			src.tox -= 1
		if(prob(2) && src.tox < 10)
			for(var/mob/M in hearers(src))
				if(!M.sleeps)
					M << "\red You hear insect buzzing."
			src.bugs += 1
		if(prob(20))
			src.hepe -= src.bugs
		if(prob(90 + round(src.hepe / 2) - src.tox - src.bugs) && (src.amount < src.maxamount && src.stage < 3))
			src.amount += 1
		if(src.bugs >= src.tox)
			src.bugs -= src.tox
		else
			src.bugs = 0
		if(src.stage < 3 && src.timer == 0)
			if(src.stage == 2)
				src.overlays = null
				src.overlays += src.overplant_end
			spawn(0) src.stage += 1
			src.timer = src.growthtime






	spawn(100)
		if(src.stage < 3 && src.stage > 0)
			src.timer -= 1
		if(src.hepe > 0)
			src.life()
		else if(src.stage > 0)
			for(var/mob/M in view(src))
				M << "\red [plantname] looks unhealthy."
			new /obj/item/debris/plant(loc)
			src.deplantize()
/obj/structure/tray/proc/harvest()
	if(src.stage == 3)
		for(var/i, i < src.amount, i++)
			spawn(0) new src.result(loc)



	spawn(1)
		src.deplantize()
/obj/structure/tray/proc/deplantize()
	src.amount = 0
	src.maxamount = 0
	src.seedy = null
	src.result = null
	src.stage = 0
	src.hunger = 0
	src.hepe = 0
	src.timer = 0
	src.growthtime = 0
	src.plantname = "nothing"
	src.result = null
	src.overlays = null
	src.overplant_end = null

/obj/structure/tray/proc/take_from(obj/B)









	var/list/transfered_liquids = list()
	var/allamount
	var/reagamount = 0
	if(length(B:reagent_list))
		for(var/datum/reagent/RE in B:reagent_list)
			allamount += RE.amount
			reagamount += 1
		spawn(0)
			var/t_amount
			if(length(B:reagent_list))
				for(var/datum/reagent/RE in B:reagent_list)
					spawn(0)
						if(allamount < B:target_transfer)
							t_amount = allamount
						else
							t_amount = B:target_transfer
						var/herps = new /datum/reagent()
						herps:id = RE.id
						herps:name = RE.name
						herps:amount = RE.amount * t_amount / allamount
						spawn(0)
							B:remove_chem(RE.id, RE.amount * t_amount / allamount)
							transfered_liquids.Add(herps)
			spawn(1)
				for(var/datum/reagent/R in transfered_liquids)
					switch(R.id)
						if("water")
							if(100 - water >= round(R.amount))
								water += round(R.amount)
							else
								water = 100
						if("toxin")
							src.tox += round(R.amount)
						if("phosphorus")
							src.nutri += round(R.amount * 2)
						if("antidote")
							if(src.tox >= round(R.amount))
								src.tox -= round(R.amount)
							else
								src.tox = 0
						if("chlorine")
							src.tox += round(R.amount)
						if("fluorine")
							src.tox += round(R.amount)
						if("liquid smoke")
							src.tox += round(R.amount)
						if("methanol")
							src.tox += round(R.amount / 1.5)
						if("carboxylic acid")

							src.nutri += round(R.amount * 3.3)
						if("fuel")
							src.tox += round(R.amount / 1.5)
						if("urea")
							src.tox += round(R.amount / 2)
							src.nutri += round(R.amount * 3.3)
						if("ethanol")
							src.tox += round(R.amount / 2)
						if("hydrochloric acid")
							src.tox += round(R.amount * 1.5)
						if("sulfuric acid")
							src.tox += round(R.amount * 1.5)
						if("stalkotoxin")
							src.tox += round(R.amount)
						if("pogankeepeptide")
							src.tox += round(R.amount * 1.5)
						if("nutriment")
							src.nutri += round(R.amount * 5)
						if("ammonia")
							src.nutri += round(R.amount * 5)
						if("condensed milk")
							src.nutri += round(R.amount * 5)
						if("sgushenka")
							src.nutri += round(R.amount * 5)
							src.tox += round(R.amount)
						if("lye")
							src.nutri += round(R.amount * 5)
						if("salt")
							src.tox += round(R.amount / 2)

/obj/structure/tray/attack_by(obj/I)
	if(istype(I, /obj/item/reagent_container/consumable/seed) && src.stage == 0)
		src.plant(I)



	else if(istype(I, /obj/item/fertilizer))
		src.nutri += 50
		spawn(0) del(I)
	else if(istype(I, /obj/item/bugdust))
		if(src.bugs > 4)
			src.bugs -= 5
		else
			src.bugs = 0
		spawn(0) del(I)
	else if(istype(I, /obj/item/debris/plant))
		src.nutri += 1
		spawn(0) del(I)
	else if(istype(I, /obj/item/reagent_container/beaker))
		usr << "\blue You transfer some liquid from [I] to [src]."
		src.take_from(I)

	else if(istype(I, /obj/item/device/trayscan))
		usr << "\blue \bold Current tray status:"
		usr << "\blue Now planted: [plantname]"
		usr << "\blue Number of vermins: [bugs]"
		usr << "\blue Amount of toxic chemicals: [tox]"
		usr << "\blue Amount of nutriments: [nutri]"
		usr << "\blue Amount of water: [water]"
		if(seedy)
			usr << "\red Seed: [seedy:name]"
		else
			usr << "\green Smoke weed everyday"
		if(!(stage == 0))
			usr << "\blue Current plant growth stage: [stage]"
/obj/structure/tray/attack_hand()
	if(stage >= 3)
		harvest()

/obj/item/reagent_container/consumable/seed
	icon = 'grafon/plant.dmi'
	beltable = 0
	maxamount = 5
	var/maxamount1 = 1
	var/hunger = 1
	var/robust = 1
	var/growthtime = 1
	var/obj/result = null
	var/obj/overplant = null
	var/obj/overplant_end = null
	var/obj/overplant_seed = null
	var/seedstage = 0
	var/plantname = "nothing"
	var/planttype = "plant"

/obj/item/reagent_container/consumable/seed

/obj/item/reagent_container/consumable/seed/New()













	src.pixel_x = pick(-4, -2, 0, 2, 4)
	src.pixel_y = pick(-4, -2, 0, 2, 4)
	src.add_chem("nutriment", "nutriment", 0.1, 0)

/obj/item/reagent_container/consumable/seed/pogankee
	maxamount1 = 4
	hunger = 2
	robust = 120
	name = "pogankee spawn"
	icon_state = "pogankah_spawn"
	plantname = "pogankee"
	growthtime = 7
	planttype = "mushroom"
	result = /obj/item/reagent_container/consumable/plant/pogankah
	overplant = /obj/overlay/plant/pogankah
	overplant_end = /obj/overlay/plant/pogankah_end

/obj/item/reagent_container/consumable/seed/pogankee
/obj/item/reagent_container/consumable/seed/killer
	maxamount1 = 3
	hunger = 3
	robust = 160
	name = "killer pogankee spawn"
	icon_state = "killer_spawn"
	plantname = "killer pogankee"
	growthtime = 8
	planttype = "mushroom"
	result = /obj/item/reagent_container/consumable/plant/killer
	overplant = /obj/overlay/plant/killer
	overplant_end = /obj/overlay/plant/killer_end
/obj/item/reagent_container/consumable/seed/killer
/obj/item/reagent_container/consumable/seed/cucumber
	maxamount1 = 7
	hunger = 3
	robust = 80
	plantname = "cucumber"
	growthtime = 7
	result = /obj/item/reagent_container/consumable/plant/cucumber
	overplant = /obj/overlay/plant/cucumber
	overplant_end = /obj/overlay/plant/cucumber_end
	name = "cucumber seed"
	icon_state = "cucumber_seed"
/obj/item/reagent_container/consumable/seed/cucumber
/obj/item/reagent_container/consumable/seed/stalks
	maxamount1 = 5
	hunger = 3
	robust = 100
	name = "swamp stalks seed"
	icon_state = "stalks_seed"
	plantname = "swamp stalks"
	growthtime = 6
	result = /obj/item/reagent_container/consumable/plant/stalks
	overplant = /obj/overlay/plant/stalks
	overplant_end = /obj/overlay/plant/stalks_end
/obj/item/reagent_container/consumable/seed/stalks
/obj/item/reagent_container/consumable/seed/regen
	maxamount1 = 3
	hunger = 4
	robust = 100
	name = "regeneshrooms spawn"
	icon_state = "regen_spawn"
	plantname = "regeneshrooms"
	growthtime = 10
	planttype = "mushroom"
	result = /obj/item/reagent_container/consumable/plant/regen
	overplant = /obj/overlay/plant/regen
	overplant_end = /obj/overlay/plant/regen_end
/obj/item/reagent_container/consumable/seed/regen
/obj/item/reagent_container/consumable/seed/blastcumber
	maxamount1 = 2
	hunger = 4
	robust = 140
	plantname = "blastcumber"
	growthtime = 11
	result = /obj/bio/cucumber
	overplant = /obj/overlay/plant/cucumber
	overplant_end = /obj/overlay/plant/blastcumber
	name = "weird-looking seed"
	icon_state = "blastcumber_seed"
/obj/item/reagent_container/consumable/seed/blastcumber
/obj/item/reagent_container/consumable/seed/lepista
	maxamount1 = 3
	hunger = 4
	robust = 120
	planttype = "mushroom"
	name = "lepista nuda spawn"
	icon_state = "lepista_spawn"
	plantname = "lepista nuda"
	growthtime = 7
	result = /obj/item/reagent_container/consumable/plant/lepista
	overplant = /obj/overlay/plant/lepista
	overplant_end = /obj/overlay/plant/lepista_end
/obj/item/reagent_container/consumable/seed/lepista
/obj/item/reagent_container/consumable/seed/psilocybe
	maxamount1 = 8
	hunger = 3
	robust = 120
	planttype = "mushroom"
	name = "psilocybe spawn"
	icon_state = "psilo_spawn"
	plantname = "psilocybe"
	growthtime = 10
	result = /obj/item/reagent_container/consumable/plant/psilocybe
	overplant = /obj/overlay/plant/psilo
	overplant_end = /obj/overlay/plant/psilo_end
/obj/item/reagent_container/consumable/seed/psilocybe
/obj/item/reagent_container/consumable/seed/weed
	maxamount1 = 12
	hunger = 2
	robust = 120
	name = "hemp seed"
	icon_state = "weed_seed"
	plantname = "cannabis"
	growthtime = 10
	result = /obj/item/reagent_container/consumable/plant/bud
	overplant = /obj/overlay/plant/weed
	overplant_end = /obj/overlay/plant/weed_end
	overplant_seed = /obj/overlay/plant/weed_seed
	seedstage = 1
/obj/item/reagent_container/consumable/seed/weed
/obj/item/reagent_container/consumable/seed/weed/New()
	src.pixel_x = pick(-4, -2, 0, 2, 4)
	src.pixel_y = pick(-4, -2, 0, 2, 4)
	src.add_chem("nutriment", "nutriment", 0.1, 0)
	spawn(0)
		src.add_chem("hash oil", "hash oil", 0.1, 0)
/obj/item/reagent_container/consumable/seed/poppy
	maxamount1 = 7
	hunger = 3
	robust = 120
	plantname = "poppy"
	growthtime = 12
	result = /obj/item/reagent_container/consumable/plant/poppy
	overplant = /obj/overlay/plant/poppy
	overplant_end = /obj/overlay/plant/poppy_end
	name = "poppy seed"
	icon_state = "poppy_seed"
/obj/item/reagent_container/consumable/seed/poppy
/obj/item/reagent_container/consumable/seed/poppy/New()
	src.pixel_x = pick(-4, -2, 0, 2, 4)
	src.pixel_y = pick(-4, -2, 0, 2, 4)
	src.add_chem("nutriment", "nutriment", 0.1, 0)
	spawn(0)
		src.add_chem("opium", "opium", 0.03, 0)
/obj/item/reagent_container/consumable/seed/salvia
	maxamount1 = 15
	hunger = 3
	robust = 50
	icon_state = "weed_seed"
	name = "salvia divinorum seed"
	plantname = "salvia divinorum"
	growthtime = 13
	seedstage = 1
	result = /obj/item/reagent_container/consumable/plant/salvia
	overplant = /obj/overlay/plant/salvia
	overplant_end = /obj/overlay/plant/salvia_end
/obj/item/reagent_container/consumable/seed/salvia
/obj/item/reagent_container/consumable/seed/salvia/New()
	src.pixel_x = pick(-4, -2, 0, 2, 4)
	src.pixel_y = pick(-4, -2, 0, 2, 4)
	src.add_chem("nutriment", "nutriment", 0.1, 0)
	spawn(0)
		src.add_chem("salvinorin A", "salvinorin A", 0.03, 0)
/obj/item/reagent_container/consumable/seed/woodrose
	maxamount1 = 6
	hunger = 3
	robust = 50
	name = "space woodrose seed"
	icon_state = "woodrose_seed"
	plantname = "space woodrose"
	growthtime = 10
	result = /obj/item/reagent_container/consumable/seed/woodrose
	overplant = /obj/overlay/plant/woodrose
	overplant_end = /obj/overlay/plant/woodrose_end
/obj/item/reagent_container/consumable/seed/woodrose
/obj/item/reagent_container/consumable/seed/woodrose/New()
	src.pixel_x = pick(-4, -2, 0, 2, 4)
	src.pixel_y = pick(-4, -2, 0, 2, 4)
	src.add_chem("nutriment", "nutriment", 0.1, 0)
	spawn(0)
		src.add_chem("LSA", "LSA", 0.1, 0)
		spawn(0)
			src.add_chem("toxin", "toxin", 2, 0)
/obj/item/reagent_container/consumable/seed/gaba
	maxamount1 = 6
	hunger = 3
	robust = 80
	name = "CogniTea seed"
	icon_state = "gaba_seed"
	plantname = "CogniTea"
	growthtime = 9
	result = /obj/item/reagent_container/consumable/plant/gaba
	overplant = /obj/overlay/plant/gaba
	overplant_end = /obj/overlay/plant/gaba_end
/obj/item/reagent_container/consumable/seed/gaba/New()
	src.pixel_x = pick(-4, -2, 0, 2, 4)
	src.pixel_y = pick(-4, -2, 0, 2, 4)
	src.add_chem("nutriment", "nutriment", 0.1, 0)
	spawn(0)
		src.add_chem("caffeine", "caffeine", 1, 0)
/obj/item/reagent_container/consumable/seed/ephedra
	maxamount1 = 4
	hunger = 4
	robust = 120
	plantname = "ephedra"
	growthtime = 9
	result = /obj/item/reagent_container/consumable/plant/ephedra
	overplant = /obj/overlay/plant/ephedra
	overplant_end = /obj/overlay/plant/ephedra_end
	name = "ephedra seed"
	icon_state = "ephedra_seed"
/obj/item/reagent_container/consumable/seed/ephedra
/obj/item/reagent_container/consumable/seed/ephedra/New()
	src.pixel_x = pick(-4, -2, 0, 2, 4)
	src.pixel_y = pick(-4, -2, 0, 2, 4)
	src.add_chem("nutriment", "nutriment", 0.1, 0)
	spawn(0)
		src.add_chem("pseudoephedrine", "pseudoephedrine", 0.5, 0)
/obj/item/reagent_container/consumable/seed/soybean
	maxamount1 = 10
	hunger = 3
	robust = 100
	plantname = "soybean"
	growthtime = 10
	result = /obj/item/reagent_container/consumable/seed/soybean
	overplant = /obj/overlay/plant/soybean
	overplant_end = /obj/overlay/plant/soybean_end
	name = "space soybean"
	icon_state = "soybean_seed"
/obj/item/reagent_container/consumable/seed/soybean
/obj/item/reagent_container/consumable/seed/soybean/New()
	src.pixel_x = pick(-4, -2, 0, 2, 4)
	src.pixel_y = pick(-4, -2, 0, 2, 4)
	src.add_chem("nutriment", "nutriment", pick(1, 1.5, 2, 3), 0)
	spawn(0)
		src.add_chem("plant oil", "plant oil", rand(2, 5), 0)
		spawn(0)
			src.add_chem("carboxylic acid", "carboxylic acid", 0.5, 0)

/obj/item/reagent_container/consumable/seed/lofofora
	maxamount1 = 10
	hunger = 3
	robust = 50
	name = "space lofofora seed"
	icon_state = "lofofora_seed"
	plantname = "space lofofora"
	growthtime = 13
	result = /obj/item/reagent_container/consumable/plant/lofofora
	overplant = /obj/overlay/plant/lofofora
	overplant_end = /obj/overlay/plant/lofofora_end
/obj/item/reagent_container/consumable/seed/lofofora
/obj/item/reagent_container/consumable/seed/lofofora/New()
	src.pixel_x = pick(-4, -2, 0, 2, 4)
	src.pixel_y = pick(-4, -2, 0, 2, 4)
	src.add_chem("nutriment", "nutriment", 0.1, 0)
	spawn(0)
		src.add_chem("mescaline", "mescaline", 0.005, 0)
/obj/item/reagent_container/consumable/seed/dmt
	beltable = 1
	maxamount1 = 7
	hunger = 3
	robust = 60
	name = "psychotria oecumenica stalk"
	icon_state = "dmt_seed"
	plantname = "psychotria oecumenica"
	growthtime = 15
	result = /obj/item/reagent_container/consumable/seed/dmt
	overplant = /obj/overlay/plant/dmt
	overplant_end = /obj/overlay/plant/dmt_end
/obj/item/reagent_container/consumable/seed/dmt
/obj/item/reagent_container/consumable/seed/dmt/New()
	src.pixel_x = pick(-4, -2, 0, 2, 4)
	src.pixel_y = pick(-4, -2, 0, 2, 4)
	src.add_chem("nutriment", "nutriment", 2, 0)
	spawn(0)
		src.add_chem("carboxylic acid", "carboxylic acid", 2, 0)
		spawn(0)
			src.add_chem("DMT", "DMT", pick(0.05, 0.06, 0.09), 0)
/obj/item/reagent_container/consumable/seed/maoi
	beltable = 1
	maxamount1 = 7
	hunger = 3
	robust = 60
	plantname = "ayahuasca liana"
	growthtime = 15
	result = /obj/item/reagent_container/consumable/seed/maoi
	overplant = /obj/overlay/plant/maoi
	overplant_end = /obj/overlay/plant/maoi_end
	name = "ayahuasca liana"
	icon_state = "maoi_seed"
/obj/item/reagent_container/consumable/seed/maoi
/obj/item/reagent_container/consumable/seed/maoi/New()
	src.pixel_x = pick(-4, -2, 0, 2, 4)
	src.pixel_y = pick(-4, -2, 0, 2, 4)
	src.add_chem("nutriment", "nutriment", 3, 0)
	spawn(0)
		src.add_chem("carboxylic acid", "carboxylic acid", 2, 0)
		spawn(0)
			src.add_chem("harmaline", "harmaline", pick(0.35, 0.4), 0)

/obj/item/reagent_container/consumable/plant
	icon = 'grafon/plant.dmi'
	var/obj/seed = null
	var/planttype = "plant"
	var/seedstage = 0

/obj/item/reagent_container/consumable/plant

/obj/item/reagent_container/consumable/plant/pogankah
	seed = /obj/item/reagent_container/consumable/seed/pogankee
	planttype = "mushroom"
	desc = "A large toadstool."
	icon_state = "pogankah_item"

/obj/item/reagent_container/consumable/plant/pogankah


/obj/item/reagent_container/consumable/plant/pogankah/New()

	src.add_chem("nutriment", "nutriment", 5, 0)
	spawn(1)
		src.add_chem("pogankeepeptide", "pogankeepeptide", pick(3, 3.5), 0)

/obj/item/reagent_container/consumable/plant/killer
	seed = /obj/item/reagent_container/consumable/seed/killer
	planttype = "mushroom"
	name = "killer pogankah"
	desc = "A large green toadstool."
	icon_state = "killer_item"

/obj/item/reagent_container/consumable/plant/killer

/obj/item/reagent_container/consumable/plant/killer/New()
	src.add_chem("nutriment", "nutriment", 5, 0)
	spawn(1)
		src.add_chem("pogankeepeptide", "pogankeepeptide", 15, 0)
		spawn(0)
			src.add_chem("atropine", "atropine", 3, 0)

/obj/item/reagent_container/consumable/plant/cucumber
	seed = /obj/item/reagent_container/consumable/seed/cucumber
	desc = "A wonderful green vegetable."
	icon_state = "cucumber_item"

/obj/item/reagent_container/consumable/plant/cucumber
/obj/item/reagent_container/consumable/plant/cucumber/New()
	src.add_chem("nutriment", "nutriment", 6, 0)
	spawn(1)
		src.add_chem("carboxylic acid", "carboxylic acid", pick(0.5, 0.7, 1, 1.5), 0)
		spawn(0) src.add_chem("glucose", "glucose", 4, 0)

/obj/item/reagent_container/consumable/plant/stalks
	seed = /obj/item/reagent_container/consumable/seed/stalks
	name = "swamp stalk"
	desc = "A toxic plant."
	icon_state = "stalks_item"

/obj/item/reagent_container/consumable/plant/stalks

/obj/item/reagent_container/consumable/plant/stalks/New()
	src.add_chem("nutriment", "nutriment", 4, 0)
	spawn(1)
		src.add_chem("stalkotoxin", "stalkotoxin", pick(5, 6, 7), 0)
		spawn(1)
			src.add_chem("carboxylic acid", "carboxylic acid", 2, 0)


/obj/item/reagent_container/consumable/plant/regen
	seed = /obj/item/reagent_container/consumable/seed/regen
	planttype = "mushroom"
	name = "regeneshroom"
	desc = "A large red mushroom."
	icon_state = "regen_item"
/obj/item/reagent_container/consumable/plant/regen
/obj/item/reagent_container/consumable/plant/regen/New()
	src.add_chem("nutriment", "nutriment", 5, 0)
	spawn(1)
		src.add_chem("regenerite", "regenerite", rand(5, 8), 0)
		spawn(1)
			src.add_chem("carboxylic acid", "carboxylic acid", 1, 0)
/obj/item/reagent_container/consumable/plant/lepista
	seed = /obj/item/reagent_container/consumable/seed/lepista
	planttype = "mushroom"
	name = "lepista nuda"
	desc = "A nutrious purple mushroom."
	icon_state = "lepista_item"
/obj/item/reagent_container/consumable/plant/lepista
/obj/item/reagent_container/consumable/plant/lepista/New()
	src.add_chem("nutriment", "nutriment", 10, 0)
	spawn(1)
		src.add_chem("carboxylic acid", "carboxylic acid", 2, 0)
		spawn(0) src.add_chem("glucose", "glucose", 2, 0)

/obj/item/reagent_container/consumable/plant/psilocybe
	seed = /obj/item/reagent_container/consumable/seed/psilocybe
	planttype = "mushroom"
	desc = "A small brown mushroom."
	icon_state = "psilo_item"

/obj/item/reagent_container/consumable/plant/psilocybe

/obj/item/reagent_container/consumable/plant/psilocybe/New()
	src.add_chem("nutriment", "nutriment", 2.5, 0)
	spawn(1)
		src.add_chem("psilocybin", "psilocybin", pick(5, 6, 7, 8), 0)
		spawn(1)
			src.add_chem("carboxylic acid", "carboxylic acid", 0.5, 0)


/obj/item/reagent_container/consumable/plant/bud
	smokeable = 1
	grun = 80
	seed = /obj/item/reagent_container/consumable/seed/weed
	seedstage = 1
	name = "bud"
	desc = "A small green bud of some plant."
	icon_state = "weed_item"
/obj/item/reagent_container/consumable/plant/bud
/obj/item/reagent_container/consumable/plant/bud/New()
	src.add_chem("nutriment", "nutriment", 0.25, 0)
	spawn(1)
		src.add_chem("hash oil", "hash oil", pick(5, 6, 7), 0)
		spawn(1)
			src.add_chem("carboxylic acid", "carboxylic acid", 0.5, 0)
/obj/item/reagent_container/consumable/plant/bud/potent
	grun = 80
	blueh = 20
	name = "synthpotented bud"
	icon_state = "weed_item2"
	desc = "A cannabis bud, extra potented with synthetic (but fully autentic!) THC-rich resin for extra high."
/obj/item/reagent_container/consumable/plant/bud/potent
/obj/item/reagent_container/consumable/plant/bud/potent/New()
	src.add_chem("nutriment", "nutriment", 0.25, 0)
	spawn(1)
		src.add_chem("hash oil", "hash oil", 10, 0)
		spawn(1)
			src.add_chem("carboxylic acid", "carboxylic acid", 0.5, 0)
/obj/item/reagent_container/consumable/plant/bud/potent/fake
	name = "synthpotented bud"
/obj/item/reagent_container/consumable/plant/bud/potent/fake/New()
	var/fakehash = pick("APICA", "JWH-250", "AB-228")
	src.add_chem("nutriment", "nutriment", 0.25, 0)
	spawn(1)
		src.add_chem("hash oil", "hash oil", pick(5, 6, 7), 0)
		spawn(1)
			src.add_chem("carboxylic acid", "carboxylic acid", 0.5, 0)
			spawn(1)
				src.add_chem(fakehash, fakehash, 0.24, 0)

/obj/item/reagent_container/consumable/plant/salvia
	smokeable = 1
	grun = 120
	seed = /obj/item/reagent_container/consumable/seed/salvia
	seedstage = 1
	name = "salvia divinorum leaf"
	desc = "A large leaf of a nasty shamanic plant."
	icon_state = "salvia_item"

/obj/item/reagent_container/consumable/plant/salvia
/obj/item/reagent_container/consumable/plant/salvia/New()
	src.add_chem("nutriment", "nutriment", 0.2, 0)
	spawn(1)
		src.add_chem("salvinorin A", "salvinorin A", rand(3, 6) / 10, 0)
		spawn(1)
			src.add_chem("carboxylic acid", "carboxylic acid", 0.5, 0)
/obj/item/reagent_container/consumable/plant/poppy
	seed = /obj/item/reagent_container/consumable/seed/poppy
	name = "poppy capsule"
	desc = "A treasure chest, filled with seeds of a beautiful flower."
	icon_state = "poppy_item"
/obj/item/reagent_container/consumable/plant/poppy
/obj/item/reagent_container/consumable/plant/poppy/New()
	src.add_chem("nutriment", "nutriment", 0.5, 0)
	spawn(1)
		src.add_chem("opium", "opium", pick(0.6, 0.8), 0)
		spawn(1)
			src.add_chem("carboxylic acid", "carboxylic acid", 0.5, 0)
			spawn(0)
				src.add_chem("thebaine", "thebaine", pick(0.25, 0.3, 0.35, 0.4), 0)
/obj/item/reagent_container/consumable/plant/gaba
	seed = /obj/item/reagent_container/consumable/seed/gaba
	name = "CogniTea shrub"
	desc = "A small shrub of space tea."
	icon_state = "gaba_item"
/obj/item/reagent_container/consumable/plant/gaba
/obj/item/reagent_container/consumable/plant/gaba/New()
	src.add_chem("nutriment", "nutriment", 2, 0)
	spawn(1)
		src.add_chem("GABA", "GABA", rand(3, 8), 0)
		spawn(1)
			src.add_chem("caffeine", "caffeine", 10, 0)
			spawn(1)
				src.add_chem("carboxylic acid", "carboxylic acid", 1.5, 0)
/obj/item/reagent_container/consumable/plant/ephedra
	seed = /obj/item/reagent_container/consumable/seed/ephedra
	name = "ephedra weed"
	desc = "A herb, used in production of stimulants and anti-cough stuff."
	icon_state = "ephedra_item"
/obj/item/reagent_container/consumable/plant/ephedra
/obj/item/reagent_container/consumable/plant/ephedra/New()
	src.add_chem("nutriment", "nutriment", 1, 0)
	spawn(0)
		src.add_chem("pseudoephedrine", "pseudoephedrine", rand(8, 11), 0)
		spawn(0)
			src.add_chem("carboxylic acid", "carboxylic acid", 1, 0)
			spawn(0)
				src.add_chem("ephedrine", "ephedrine", rand(6, 8), 0)
/obj/item/reagent_container/consumable/plant/lofofora
	seed = /obj/item/reagent_container/consumable/seed/lofofora
	name = "space lofofora cactus"
	desc = "A cactus with a beautiful flower on top of it."
	icon_state = "lofofora_item"
/obj/item/reagent_container/consumable/plant/lofofora
/obj/item/reagent_container/consumable/plant/lofofora/New()
	src.add_chem("nutriment", "nutriment", 3, 0)
	spawn(0)
		src.add_chem("mescaline", "mescaline", pick(2, 3), 0)
		spawn(0)
			src.add_chem("carboxylic acid", "carboxylic acid", 1, 0)

/atom/proc/extract(obj/P, atom/M)






















































































































	if(!P:seedstage)
		new P:seed(M:loc)

/obj/machine/extractor
	density = 1
	var/tox = 0
	var/nutri = 0
	name = "Plant extraction unit"
	icon_state = "extractor"








	var/list/prod = new(); anchored = 0
/obj/machine/extractor/proc/extraction(obj/item/P)
	for(var/mob/M in view(src))
		M << "\blue The machine processes [P]."



	for(var/datum/reagent/R in P:reagent_list)
		if(R.id == "nutriment")
			src.nutri += round(R.amount * 1.5)
		if(R.id == "glucose")
			src.nutri += round(R.amount * 1.5)
		if(R.id == "regenerite")
			src.nutri += round(R.amount)
		if(R.id == "toxin")
			src.tox += round(R.amount)
		if(R.id == "stalkotoxin")
			src.tox += round(R.amount * 1.5)
		if(R.id == "pogankeepeptide")
			src.tox += round(R.amount * 2)
		if(R.id == "hash oil")
			src.nutri += round(R.amount * 1.3)
			src.tox += round(R.amount * 1.3)
		if(R.id == "carboxylic acid")
			src.nutri += round(R.amount * 5)
		if(R.id == "GABA")
			src.nutri += round(R.amount * 2)
		if(R.id == "THC")
			src.nutri += round(R.amount * 1.5)
			src.tox += round(R.amount * 1.5)
		if(R.id == "CBD")
			src.nutri += round(R.amount)
		if(R.id == "caffeine")
			src.nutri += round(R.amount / 3)
		if(R.id == "ephedrine")
			src.nutri += round(R.amount / 2)
		if(R.id == "pseudoephedrine")
			src.nutri += round(R.amount / 3)
		if(R.id == "plant oil")
			src.nutri += round(R.amount * 2.5)
	if(istype(P, /obj/item/reagent_container/consumable/plant))
		var/PL = P
		src.extract(PL, src)
	spawn(0) del(P)
/obj/machine/extractor/New()
	prod.Add("vermin dust (6 toxin, 5 nutriment)", "plant fertilizer (10 nutriment)", "antidote (15 nutriment, 15 toxin)", "toxin bottle (30 toxin)", "glucose (30 nutriment)", "cellulose (10 nutriment)")




/obj/machine/extractor/attack_by(obj/I)


	if(istype(I, /obj/item/reagent_container/consumable))
		src.extraction(I)
	else if(istype(I, /obj/item/device/consolehack))
		for(var/mob/M in hearers(src))
			if(!M.sleeps)
				M << "\blue [src] beeps weirdly."
		src.prod.Add("special seeds (50 nutriment, 5 toxin)")

/obj/machine/extractor/attack_hand()
	if(!usr.candofun)
		usr << "\red NO"
		return
	switch(alert("What do you want?", , "watch contents", "make chemicals"))
		if("watch contents")
			if(usr in range(1, src))
				usr << "\blue The machine softly beeps to you:"
				usr << "\blue Extracted toxic substation: [tox]"
				usr << "\blue Extracted nutriments: [nutri]"
		else
			if(usr in range(1, src))
				var/kydax = input("") in src.prod
				switch(kydax)
					if("toxin bottle (30 toxin)")
						if(tox > 29)
							new /obj/item/reagent_container/beaker/bottle/toxin(src.loc)
							tox -= 30
						else
							usr << "\red Not enough chemicals to process your order."
					if("plant fertilizer (10 nutriment)")
						if(nutri > 14)
							new /obj/item/fertilizer(src.loc)
							nutri -= 15
						else
							usr << "\red Not enough chemicals to process your order."
					if("antidote (15 nutriment, 15 toxin)")
						if(nutri >= 15 && tox >= 15)
							new /obj/item/reagent_container/beaker/bottle/antidote(src.loc)
							nutri -= 20
							tox -= 20
						else
							usr << "\red Not enough chemicals to process your order."
					if("cellulose (10 nutriment)")
						if(nutri > 9)
							var/B = new /obj/item/reagent_container/beaker/bottle(src.loc)
							nutri -= 10
							spawn(0) B:add_chem("cellulose", "cellulose", 30, 0)
						else
							usr << "\red Not enough chemicals to process your order."
					if("vermin dust (6 toxin, 5 nutriment)")
						if(nutri > 4 && tox > 9)
							new /obj/item/bugdust(src.loc)
							nutri -= 5
							tox -= 10
						else
							usr << "\red Not enough chemicals to process your order."
					if("glucose (30 nutriment)")
						if(nutri > 29)
							new /obj/item/reagent_container/beaker/bottle/glucose(src.loc)
							nutri -= 30
						else
							usr << "\red Not enough chemicals to process your order."
					if("special seeds (50 nutriment, 5 toxin)")
						if(nutri > 59 && tox > 4)
							new /obj/item/reagent_container/consumable/seed/killer(src.loc)
							new /obj/item/reagent_container/consumable/seed/blastcumber(src.loc)
							new /obj/item/reagent_container/consumable/seed/blastcumber(src.loc)
							new /obj/item/reagent_container/consumable/seed/blastcumber(src.loc)
							new /obj/item/reagent_container/consumable/seed/blastcumber(src.loc)
							nutri -= 60
							tox -= 5
						else
							usr << "\red Not enough chemicals to process your order."
/obj/bio/amoebaspawn
	invisibility = 100
	icon = 'player/start.dmi'
	icon_state = "blue"
/obj/bio/weedstart
	invisibility = 100
	icon = 'player/start.dmi'
	icon_state = "green"
/obj/bio/cucumber
	density = 1
	name = "blastcumber"
	desc = "A huge vegetable. It is hot on touch."
	icon_state = "bomb_cucumber"
	var/ready = 0
/obj/bio/cucumber{anchored = 0}
/obj/bio/cucumber/attack_hand()
	if(!usr.candofun)
		usr << "\red NO"
		return
	if(src.ready == 1)
		return
	for(var/mob/M in view(src))
		M << "\red [src] shrivers violently!"
	src.icon_state = "bomb_cucumber_ready"
	src.ready = 1
	spawn(50)
		new /obj/item/reagent_container/consumable/seed/blastcumber(locate(x + pick(0, 1, -1), src.y + pick(0, 1, -1), src.z))
		new /obj/item/reagent_container/consumable/seed/blastcumber(locate(src.x + pick(0, 1, -1), src.y + pick(0, 1, -1), src.z))
		new /obj/item/debris/plant(locate(src.x + pick(0, 1, -1), src.y + pick(0, 1, -1), src.z))
		new /obj/item/debris/plant(locate(src.x + pick(0, 1, -1), src.y + pick(0, 1, -1), src.z))
		new /obj/item/debris/plant(locate(src.x + pick(0, 1, -1), src.y + pick(0, 1, -1), src.z))
		if(prob(33))
			new /obj/item/reagent_container/consumable/seed/blastcumber(locate(src.x + pick(0, 1, -1), src.y + pick(0, 1, -1), src.z))
		if(prob(33))
			new /obj/item/reagent_container/consumable/seed/blastcumber(locate(src.x + pick(0, 1, -1), src.y + pick(0, 1, -1), src.z))
		src.explosion(1)
		for(var/mob/M in range(3, src))
			if(prob(66))
				M << "\red Pieces of blastcubmer hard peel wounds you!"
				M.wound()
		spawn(0) del(src)

/obj/bio/weed
	var/stage = 1
	name = "blade weed"
	icon_state = "weed_young"
	desc = "A very sharp and dense green weed."
	var/grassy = 15
	var/generation = 5
/obj/bio/weed
	anchored = 1
/obj/bio/weed/proc/grassdmg(dmg)
	if(dmg >= src.grassy)
		spawn(0) del(src)
	else
		src.grassy -= dmg
/obj/bio/weed/New()
	for(var/obj/bio/weed/W in src.loc)
		if(!(W == src))
			del(src)

	spawn(17) src.life()

/obj/bio/weed/attack_hand()
	if(!usr.candofun)
		usr << "\red NO"
		return
	for(var/mob/M in view(src))
		M << "\red [usr] smashes [src] with bare hands!"
	if(usr.armor + usr.chemprotect < 10 && prob(30 * src.stage))
		usr << "\red You cut your hands!"
		usr.damaga(10 - usr.armor - usr.chemprotect, "brute")
	if(prob(src.stage * 20))
		return
	else
		usr << "\red You manage to damage [src] a bit!"
		src.grassdmg(rand(1, 5) + round(usr.brutality / 2) + usr.empowered * 2)

/obj/bio/weed/attack_by(obj/item/I)


	if(istype(I, /obj/item/tool/torch) && I:charges > 0)
		for(var/mob/M in view(src))
			M << "\red [usr] burns [src] with [I]!"
		usr << "\red You burn [src] with [I]!"
		src.grassdmg(15)
		I:fuel(-1)
	else
		if(istype(I, /obj/item/bugdust))
			usr.show_message("\red \bold [usr.name] poisons weeds with some pesticides!", "\blue You poison blade weeds with pesticides!")
			for(var/obj/bio/weed/W in range(10, src))
				if(W != src)
					del(W)
			spawn(0)
				for(var/obj/bio/weed/W in range(20, src))
					if(W != src)
						W.grassdmg(rand(10, 120))
				spawn(0)
					del(src)
		else
			if(istype(I, /obj/item/tool/robot/robosaw) || (istype(I, /obj/item/tool/saw) || (istype(I, /obj/item/tool/axe) || istype(I, /obj/item/weapon/battleaxe))))
				src.show_message("\red CHOP CHOP CHOP WROOOOOOOOOOM")
				usr << "\blue You cut blade weeds for good!"
				for(var/obj/bio/weed/WD in range(1, usr))
					switch(usr.dir)
						if(1)
							if(WD.y >= usr.y)
								if(prob(50))
									del(WD)
								else
									WD.grassdmg(35)
						if(2)
							if(WD.y <= usr.y)
								if(prob(50))
									del(WD)
								else
									WD.grassdmg(35)
						if(4)
							if(WD.x >= usr.x)
								if(prob(50))
									del(WD)
								else
									WD.grassdmg(35)
						if(8)
							if(WD.x <= usr.x)
								if(prob(50))
									del(WD)
								else
									WD.grassdmg(35)
				spawn(0)
					if(src)
						src.grassdmg(50)
			else
				if(I:sharp)
					for(var/mob/M in view(src))
						M << "\red [usr] cuts [src] with [I]!"
					usr << "\red You cut [src] with [I]!"
					src.grassdmg(round(I:dmg / 2) + round(I:dmg * usr.brutality / 3))
				else

					for(var/mob/M in view(src))
						M << "\red [usr] hits [src] with [I]!"
					usr << "\red You hit [src] with [I]!"
					if(prob(src.stage * 15) - usr.brutality * 2)
						usr << "\red [I] bounces out!"
					else
						src.grassdmg(round((I:dmg + round(I:dmg * usr.brutality / 5)) / 3))


/obj/bio/weed/proc/life()
	if(src.generation)
		for(var/turf/T in range(1, src))
			if(!istype(T, /turf/space) && (T.airtight == 0 && (T.density == 0 && prob(25))))
				spawn(0)
					var/W = new /obj/bio/weed(T)
					W:generation = src.generation - 1

	if(prob(15 - src.stage * 5))
		switch(src.stage)
			if(1)
				src.stage = 2
				src.icon_state = "weed_adult"
				src.grassy += 15
				for(var/mob/M in loc)
					if(!(M.mat == "ether") && (M.dead == 0 && 20 > M.armor - round(M.chemprotect / 2) - round(M.heatprotect / 2)))
						M << "\red Blade weed leaves pierce you!"
						M.damaga(20 - M.armor - round(M.chemprotect / 2) - round(M.heatprotect / 2), "brute")
						M.torment(5)
			if(2)
				src.stage = 3
				src.icon_state = "weed_old"
				src.grassy += 15
				src.density = 1
				for(var/mob/M in loc)
					if(!(M.mat == "ether") && (M.dead == 0 && 30 > M.armor - round(M.chemprotect / 2) - round(M.heatprotect / 2)))
						M << "\red Blade weed leaves pierce you!"
						M.damaga(30 - M.armor - round(M.chemprotect / 2) - round(M.heatprotect / 2), "brute")
						M.torment(5)
			else
				if(src.grassy < 45)
					grassy++
	spawn(150) src.life()

/obj/bio/pogankah
	name = "wild pogankah"
	icon_state = "pogankee_wild1"
	desc = "Some kind of space toadstool."
	var/obj/shroom = /obj/item/reagent_container/consumable/plant/pogankah
	var/obj/seed = /obj/item/reagent_container/consumable/seed/pogankee
/obj/bio/pogankah
/obj/bio/pogankah/attack_hand()
	if(!usr.candofun)
		usr << "\red NO"
		return
	if(prob(80))
		usr << "\blue You harvest [src]."
		new src.shroom(loc)
		spawn(0) del(src)
	else
		usr << "\blue You try to harvest [src], but only manage to take some spawn. Shame on you!"
		new src.seed(loc)
		spawn(0) del(src)
/obj/bio/pogankah/New()
	icon_state = pick("pogankee_wild1", "pogankee_wild2", "pogankee_wild3")
	pixel_x = pick(-5, 0, 5)
	pixel_y = pick(-5, 0, 5)
/obj/bio/pogankah/regeneshroom
	shroom = /obj/item/reagent_container/consumable/plant/regen
	seed = /obj/item/reagent_container/consumable/seed/regen
	name = "wild regeneshroom"
	icon_state = "regen_wild1"
	desc = "Some red mushrooms. You have no idea how did they grow here."
/obj/bio/pogankah/regeneshroom
/obj/bio/pogankah/regeneshroom/New()
	icon_state = pick("regen_wild1", "regen_wild2", "regen_wild3")
	pixel_x = pick(-5, 0, 5)
	pixel_y = pick(-5, 0, 5)

/obj/bio/pogankah/psilo
	shroom = /obj/item/reagent_container/consumable/plant/psilocybe
	seed = /obj/item/reagent_container/consumable/seed/psilocybe
	name = "wild psilocybe"
	icon_state = "psilo_wild"
	desc = "Some weird-looking mushrooms with a cone cap. You have no idea how did they grow here."

/obj/bio/pogankah/psilo
/obj/bio/pogankah/psilo/New()
	pixel_x = pick(-5, 0, 5)
	pixel_y = pick(-5, 0, 5)
/obj/bio/pogankah/killer
	shroom = /obj/item/reagent_container/consumable/plant/killer
	seed = /obj/item/reagent_container/consumable/seed/killer
	name = "wild killer pogankah"
	icon_state = "killer_wild"
	desc = "Some kind of space toadstool. It looks somewhat weird, however."
/obj/bio/pogankah/killer
/obj/bio/pogankah/killer/New()
	pixel_x = pick(-5, 0, 5)
	pixel_y = pick(-5, 0, 5)
/obj/bio/pogankah/lepista
	shroom = /obj/item/reagent_container/consumable/plant/lepista
	seed = /obj/item/reagent_container/consumable/seed/lepista
	name = "wild lepista nuda"
	icon_state = "lepista_wild"
	desc = "A juicy and delicious edible mushroom."
/obj/bio/pogankah/lepista
/obj/bio/pogankah/lepista/New()
	pixel_x = pick(-2, 0, 2)
	pixel_y = pick(-2, 0, 2)



/obj/item/reagent_container/consumable/hash
	maxamount = 0
	chem_capacity = 0
	smokeable = 1
	ret = 20
	name = "hash (hui)"
	desc = "A small piece of pure goodness."
	icon_state = "hash_small"
	var/target_chem = "hash oil"
	var/target_name = "hash"
	var/pluha_size = 4
	var/piece = 0

/obj/item/reagent_container/consumable/hash

/obj/item/reagent_container/consumable/hash/proc/cut_piece()




	if(piece > pluha_size)
		name = "[target_name] ([piece - pluha_size]pts)"
		var/H = new /obj/item/reagent_container/consumable/hash(usr.loc)
		H:piece = pluha_size
		H:name = "[target_name] ([pluha_size]pts)"
		H:add_chem(target_chem, target_chem, pluha_size, 0)
		H:icon_state = "[target_name]_small"
		spawn(0)
			piece -= pluha_size
			remove_chem(target_chem, pluha_size)
			spawn(0)
				if(piece <= pluha_size * 2)
					icon_state = "[target_name]_small"
				else if(piece <= pluha_size * 3)
					icon_state = "[target_name]_medium"
	else

		usr << "\red This piece of [target_name] is too small! You can't nip off anything from it!"

/obj/item/reagent_container/consumable/hash/attack_self()
	cut_piece()
/obj/item/reagent_container/consumable/hash/edinichka
	piece = 20
	icon_state = "hash_medium"
	name = "hash (20pts)"
/obj/item/reagent_container/consumable/hash/edinichka
/obj/item/reagent_container/consumable/hash/edinichka/New()
	src.add_chem("hash oil", "hash oil", 20, 0)
/obj/item/reagent_container/consumable/hash/dohuya
	piece = 5
	icon_state = "hash_big"
	name = "hash (100pts)"
/obj/item/reagent_container/consumable/hash/dohuya/New()
	src.add_chem("hash oil", "hash oil", 100, 0)
/obj/item/reagent_container/consumable/hash/pluha
	piece = 0.2
	name = "hash (4pts)"
/obj/item/reagent_container/consumable/hash/pluha
/obj/item/reagent_container/consumable/hash/pluha/New()
	src.add_chem("hash oil", "hash oil", 4, 0)
/obj/item/reagent_container/consumable/hash/pluha_big
	piece = 0.4
	icon_state = "hash_med"
	name = "hash (8pts)"
/obj/item/reagent_container/consumable/hash/pluha_big/New()
	src.add_chem("hash oil", "hash oil", 8, 0)


/obj/item/reagent_container/consumable/hash/crack
	piece = 4
	icon_state = "crack_small"
	name = "crack (4pts)"
	target_chem = "cocaine"
	target_name = "crack"
/obj/item/reagent_container/consumable/hash/crack
/obj/item/reagent_container/consumable/hash/crack/New()
	src.add_chem("cocaine", "cocaine", 4, 0)
/obj/item/reagent_container/consumable/hash/crack/crack_med
	piece = 8
	icon_state = "crack_med"
	name = "crack (8pts)"
/obj/item/reagent_container/consumable/hash/crack/crack_med
/obj/item/reagent_container/consumable/hash/crack/crack_med/New()
	src.add_chem("cocaine", "cocaine", 8, 0)
/obj/item/reagent_container/consumable/vtoryaki
	smokeable = 1
	beltable = 0
	name = "Vtoryaki"
	icon_state = "vtoryaki"
	desc = "Some gooey mass left after smoking a bong."
/obj/item/reagent_container/consumable/vtoryaki
/obj/item/reagent_container/consumable/vtoryaki/weed
	grun = 80
	maxamount = 0
	chem_capacity = 10
	name = "Weed"
	desc = "Just some healing herbs or something. No, seriously!"
/obj/item/reagent_container/consumable/vtoryaki/weed
/obj/item/reagent_container/consumable/vtoryaki/weed/New()
	src.icon += rgb(src.ret, src.grun, src.blueh)
	src.add_chem("hash oil", "hash oil", 8, 0)


/obj/item/bong/attack_by(obj/item/reagent_container/consumable/R)













	if(!istype(R, /obj/item/reagent_container/consumable))
		return
	var/isblazed = 0
	if(R:smokeable)
		var/obj/item/reagent_container/consumable/vtoryaki/VT = new /obj/item/reagent_container/consumable/vtoryaki(usr.loc)
		if(prob(76 - src:potency * 10))
			del(VT)
		for(var/datum/reagent/RE in R:reagent_list)
			if(RE.id == "hash oil")
				if(VT)
					VT:add_chem("hash oil", "hash oil", RE.amount / 4, 0)
				isblazed = 1
				src.weed += RE.amount
				if(src.weed > src.maxw)
					usr << "\red \bold [R:name] is too fucking big for this pot! You just lost some of the stuff!"
					src.weed = src.maxw
				spawn(0)
					if(src.weed > 0)
						var/S = new /obj/steam(usr.loc)
						spawn(0)
							var/R1 = new /datum/reagent()
							var/R2 = new /datum/reagent()
							R1:id = "THC"
							R1:name = R1:id
							R1:amount = src.weed / 2
							R2:id = "CBD"
							R2:name = R2:id
							R2:amount = src.weed / 3
							spawn(0)
								S:chemicals_carried += R1
								S:chemicals_carried += R2
								spawn(0) S:initiate()
							usr << "\green You breathe the smoke."
							usr.euphoria += min(src.weed, 10)
							usr.add_chem("THC", "THC", src.thc_k * src.weed / 1.5, 0)
							usr.add_chem("CBD", "CBD", src.cbd_k * src.weed, 0)
							spawn(0) src.weed = 0
			else
				for(var/datum/on_smoke/smk in on_smoke_avaible)
					if(RE.id == smk.rid)
						RE.on_smoke(RE.amount, usr)
						isblazed = 1
						usr << "\green You breathe the vapours."
						if(VT)
							VT:add_chem(RE.name, RE.id, RE.amount / (6 - src:potency), 0)
						usr.add_chem(RE.id, RE.id, RE.amount, 1.5)
		if(isblazed)
			del(R)
			return
	else
		usr << "\red You can't smoke this!"

	spawn(0)
		if(isblazed)
			usr.delitem()

/obj/item/vodniy_unfin/attack_by(obj/I)














	if(istype(I, /obj/item/material/plastic))
		var/P = I
		P:changecharge(-1)
		usr << "\blue You wrap some plastic around the top of your assembly and make a bit of holes in it."
		new /obj/item/bong/vodniy(usr.loc)
		spawn(0) del(src)
	else
		if(istype(I, /obj/item/material/sheet))
			var/M = I
			M:changecharge(-1)
			usr << "\blue You wrap some metal around the top of your assembly and make a bit of holes. Fuck you, man, it is steel sheet, hard as hell! It surely wasn't easy!"
			new /obj/item/bong/vodniy(usr.loc)
			spawn(0) del(src)
		else
			if(istype(I, /obj/item/recipe))
				usr << "\blue You wrap a recipe card around the top of your assembly and make a bit of holes. Do you know what recipe cards are expensive stuff?"
				new /obj/item/bong/vodniy(usr.loc)
				usr.delitem()
				spawn(0) del(src)
			else
				if(istype(I, /obj/item/outlet))
					usr << "\blue You screw a power outlet at the top of your assembly. Damn, this thing even have holes from the beginning!"
					new /obj/item/bong/vodniy(usr.loc)
					usr.delitem()
					spawn(0) del(src)
				else
					if(istype(I, /obj/item/blister))
						var/B = I
						if(B:tabs_left)
							usr << "\red Nope, this thing still have some tabs in it."
						else if(istype(B, /obj/item/blister/bakla) || (istype(B, /obj/item/blister/bakla25) || istype(B, /obj/item/blister/hydro)))
							usr << "\red Damn, man, this is thick can, not blister. This thing is not suitable for the assembly you're trying to construct!"
						else
							usr << "\blue You wrap an empty blister around the top of your assembly and make a bit of holes. Probably the only good use for empty blisters, lol."
							new /obj/item/bong/vodniy(usr.loc)
							usr.delitem()
							spawn(0) del(src)
					else

						..()







/obj/machine/worm/New()










	..()
	src.breed()
/obj/machine/worm/attack_by(obj/I)
	if(istype(I, /obj/item/reagent_container/beaker) && vat == null)
		vat = I
		I:loc = src
		spawn(0) usr.delitem()
	else if(istype(I, /obj/item/reagent_container/consumable/worm) && src.drugworm < 50)
		usr << "\blue You drop a worm into vat."
		src.drugworm++
		spawn(0) usr.delitem()

/obj/machine/worm/attack_hand()
	if(drugworm >= 0 || bioworm >= 0)
		usr << "\blue Proteine worms: [bioworm]"
		usr << "\blue Other worms: [drugworm]"
		usr << "\blue Nutrious crap for worms left: [nutri]"
		var/answ = input("Are you sure you want to kill some worms (2 of each type)?") in list("Yes", "No")
		if(answ == "Yes" && (drugworm >= 2 || bioworm >= 2))

			src.wormkill()
	else
		usr << "\red \bold OH SNAP ALL THE WORMS ARE DEAD"

/obj/machine/worm/proc/wormkill()

	var/T = new /obj/item/reagent_container/syringe/injector/nonhuman(src.loc)
	T:icon_state = "worm[rand(1, 5)]"
	if(src.bioworm >= 2)
		src.bioworm -= 2
		T:add_chem("nutriment", "nutriment", rand(10, 15), 0)
		if(prob(10))
			spawn(0) T:add_chem("carboxylic acid", "carboxylic acid", rand(3, 5), 0)
	if(src.drugworm >= 2)
		src.drugworm -= 2
		T:add_chem("5-MeO-DMT", "5-MeO-DMT", 0.09, 0)
		spawn(0) T:add_chem("nutriment", "nutriment", pick(1, 2), 0)
/obj/machine/worm/proc/breed()
	if(src.bioworm > 0 && (src.bioworm < 50 && (src.nutri > src.bioworm && prob(25))))
		src.nutri--
		src.bioworm++
	sleep(0)
	if(src.drugworm > 0 && (src.drugworm < 50 && (src.nutri > src.drugworm && prob(12))))
		src.nutri--
		src.drugworm++
	if(src.vat)
		for(var/datum/reagent/R in src:vat:reagent_list)
			if(R.name == "ammonia")
				src.nutri += R.amount
				src:vat:remove_chem(R.name, R:amount)
			if(R.name == "nutriment")
				src.nutri += round(R.amount * 1.5)
				src:vat:remove_chem(R.name, R:amount)
			if(R.name == "sugar")
				src.nutri += R.amount
				src:vat:remove_chem(R.name, R:amount)
			if(R.name == "glucose")
				src.nutri += round(R.amount * 1.5)
				src:vat:remove_chem(R.name, R:amount)
			if(R.name == "plant oil")
				src.nutri += round(R.amount * 2.5)
	spawn(10) src.breed()

/obj/machine/worm/verb/remove_beaker()
	set name = "Remove beaker"
	set src in view(1)

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(!src.vat)
		usr << "\red There's no beaker here!"
	else
		src.vat:loc = loc
		spawn(0) src.vat = null
/obj/bio/pogankeespawn
	invisibility = 100
	icon = 'player/start.dmi'
	icon_state = "gray"
/obj/bio/sponge{name = "Smenospongia spatium"; desc = "A large sponge which managed to adapt to the harsh conditions of Baikonur-5"; var/hp = 30; icon_state = "sponge"}
/obj/bio/sponge/attack_hand()



	if(src.hp > 0)
		usr << "\red You try to pull the sponge out!"
		src.hp -= rand(2, 4 + usr.empowered * 3)
	else

		usr << "\green You've successfully removed sponge!"
		src.remove_spng()


/obj/bio/sponge/attack_by(obj/I)
	if(I:sharp || istype(I, /obj/item/tool/hammer))

		if(src.hp > 0)
			usr << "\red You try to hack the sponge apart!"
			src.hp -= I:dmg
		else

			usr << "\green You've successfully removed sponge!"
			src.remove_spng()

/obj/bio/sponge/proc/remove_spng()
	new /obj/item/reagent_container/consumable/sponge(src.loc)
	spawn(0) hide(src)

/obj/item/reagent_container/consumable/sponge
	icon = 'grafon/plant.dmi'
	name = "Smenospongia spatium chunk"
	desc = "A chunk of psychedelic sponge."
	icon_state = "sponge_hacked"
/obj/item/reagent_container/consumable/sponge
/obj/item/reagent_container/consumable/sponge/New()
	src.add_chem("nutriment", "nutriment", 1, 0)
	src.add_chem("5-Bromo-DMT", "5-Bromo-DMT", 1.8, 0)


/obj/furniture/towercap
	density = 1
	mat = 5
	name = "tower-cap"
	desc = "A fuckhuge mushroom, sometimes found all around our bluespace sleeve holes. I don't know how it is possible for mushroom to grow on metal floor or ice, but this is how it rolls."
	icon_state = "tower_cap"

/obj/furniture/towercap


/obj/furniture/towercap/nether
	glows = 1
	name = "nether-cap"
	icon_state = "tower_cap2"
	desc = "A relatively rare breed of tower-cap, glowing softly in the darkness of Baikonur-5."
/obj/furniture/towercap/nether
/obj/furniture/towercap/New()
	if(glows)
		sd_SetLuminosity(2)
	if(prob(10))
		infested = 1
	..()
