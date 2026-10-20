// Recovered from compiled neek.dmb (15 procs)

/obj/machine/chem_syntheser
	density = 1
	name = "chemical syntheser"
	desc = "A wonder machine used for making chemicals using nothing but electrical energy."
	icon_state = "synth_empty"
	var/beaker = null
/obj/machine/chem_syntheser
	bomb_proof = 100
/obj/machine/chem_syntheser/verb/remove_beaker()
	set name = "Remove beaker"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(!beaker)
		usr << "\red There's no beaker here!"
	else
		icon_state = "synth_empty"
		beaker:loc = src.loc
		spawn(0) beaker = null
/obj/machine/chem_syntheser/attack_by(obj/I)
	if(istype(I, /obj/item/reagent_container/beaker) && (!istype(I, /obj/item/reagent_container/beaker/bottle) && (!istype(I, /obj/item/reagent_container/beaker/bucket) && src.beaker == null)))
		src.beaker = I
		src.icon_state = "synth_full"
		I:loc = src
		spawn(0) usr.delitem()
/obj/machine/chem_syntheser/attack_hand()
	if(beaker == null)
		usr << "\red Insert beaker first!"
	else
		var/powered = 0
		for(var/obj/wire/battery/B in src.loc)
			if(!B)
				usr << "\red [src] is unpowered!"
				return
			else
				powered = 1
				var/chemsort = input("What to transfer?", "", "water") in list("water", "potassium", "chlorine", "fluorine", "hydrogen", "nitrogen", "phosphorus", "carbon", "lithium", "sodium", "aluminum", "iron", "sulfuric acid", "hydrochloric acid", "nitric acid", "manganese", "mercury", "sugar", "iodine", "bromine", "polonium", "cancel")
				switch(chemsort)
					if("cancel")
						return
					else if(B.energy > 0)
						var/bamount
						for(var/datum/reagent/RE in beaker:reagent_list)
							bamount += RE.amount
						if(beaker && (usr in range(1, src)))
							if(bamount == beaker:maxamount)
								usr << "\red The beaker is full!"
							else if(bamount + 10 >= beaker:maxamount)
								B.energy -= 1
								beaker:add_chem(chemsort, chemsort, beaker:maxamount - bamount, 0)
								src.playsound('sounds/water-click.wav')
							else
								B.energy -= 1
								beaker:add_chem(chemsort, chemsort, 10, 0)
								src.playsound('sounds/water-click.wav')
						else
							return
		if(!powered)
			usr << "\red [src] is unpowered!"

/obj/machine/chem_separator
	var/beaker
	name = "chemical separator"
	desc = "A special machinery for separating chemical reagents. Can also make pills."
	icon_state = "separator_empty"

/obj/machine/chem_separator
	bomb_proof = 100
/obj/machine/chem_separator/verb/remove_beaker()


	set name = "Remove beaker"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(!beaker)
		usr << "\red There's no beaker here!"
	else
		beaker:loc = src.loc
		src.icon_state = "separator_empty"
		spawn(0) src.beaker = null
/obj/machine/chem_separator/attack_by(obj/I)
	if(istype(I, /obj/item/reagent_container/beaker) && (!istype(I, /obj/item/reagent_container/beaker/bucket) && src.beaker == null))
		src.beaker = I
		I:loc = src
		src.icon_state = "separator_full"
		spawn(0) usr.delitem()
/obj/machine/chem_separator/attack_hand()
	if(src.beaker == null)
		usr << "\red Insert beaker first!"

	else if(!length(src:beaker:reagent_list))
		usr << "\red The beaker is empty!"
		return
	else
		var/namelist = list()
		for(var/datum/reagent/R in src:beaker:reagent_list)
			namelist += R.name
			usr << "\blue [R.name] [R.amount]"
		var/method = input("", "What to do?", "filter reagent") in list("filter reagent", "make pills", "make combi-pills")
		spawn(0) switch(method)
			if("filter reagent")
				namelist += "cancel"
				var/target_reagent = input("", "That reagent?", "cancel") in namelist
				if(target_reagent == "cancel")
					return
				else
					var/target_amount = input("", "How many?", 1) in list(1, 2, 3, 4, 5, 10)
					spawn(0)
						if(src.beaker && (usr in range(1, src)))
							var/T = new /obj/item/reagent_container/beaker/tiny()
							for(var/datum/reagent/RE in src:beaker:reagent_list)
								if(RE.name == target_reagent)
									if(RE.amount < target_amount)
										target_amount = RE.amount
									spawn(0)
										T:add_chem(RE.id, RE.name, target_amount, src:beaker:temp)
										src:beaker:remove_chem(RE.id, target_amount)
							spawn(0) T:loc = src.loc
						else
							return
			if("make pills")
				namelist += "cancel"
				var/target_reagent = input("", "From that reagent?", "cancel") in namelist
				if(target_reagent == "cancel")
					return
				else
					var/pillname = input("", "How do you want to name your pill?", "[target_reagent] pill")
					var/target_amount = input("", "From how many?", 1) in list(1, 5, 10, 15, 20, 25, 30)
					spawn(0)
						if(src.beaker && (usr in range(1, src)))
							var/P = new /obj/item/reagent_container/consumable/pill()
							P:name = pillname
							for(var/datum/reagent/RE in src:beaker:reagent_list)
								if(RE.name == target_reagent)
									if(RE.amount < target_amount)
										target_amount = RE.amount
									spawn(0)
										P:add_chem(RE.id, RE.name, target_amount, src:beaker:temp)
										src:beaker:remove_chem(RE.id, target_amount)
							spawn(0) P:loc = src.loc
						else
							return
			if("make combi-pills")
				var/pillname = input("", "How do you want to name your pill?", "combi-pill")
				var/target_amount = input("", "From how many?", 1) in list(1, 5, 10, 15, 20, 25, 30, "cancel")
				spawn(0)
					if(target_amount == "cancel")
						return

					if(src.beaker && (usr in range(1, src)))
						var/regsamt = 0
						var/realamt = 0

						var/P = new /obj/item/reagent_container/consumable/pill()
						P:name = pillname

						for(var/datum/reagent/RE in src:beaker:reagent_list)
							regsamt++
						realamt = target_amount / regsamt

						for(var/datum/reagent/RE in src:beaker:reagent_list)
							if(RE.amount >= realamt)
								P:add_chem(RE.id, RE.name, realamt, src:beaker:temp)
								src:beaker:remove_chem(RE.id, realamt)
							else
								P:add_chem(RE.id, RE.name, RE.amount, src:beaker:temp)
								src:beaker:remove_chem(RE.id, RE.amount)
							spawn(0) P:loc = src.loc
					else
						return
/obj/machine/chem_heater
	name = "chemical heater"
	desc = "A special machinery for heating or cooling chemical reagents."
	var/icon_empty = "heater_empty"
	icon_state = "heater_empty"
	var/icon_full = "heater_full"
	var/obj/item/reagent_container/beaker/beaker
	var/speed = 5
	var/able = "omni"
/obj/machine/chem_heater
	bomb_proof = 100
/obj/machine/chem_heater/verb/remove_beaker()
	set name = "Remove beaker"
	set src in view(1)

	if("chromosome" in usr.mutations && src.able == "omni")
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(!beaker)
		usr << "\red There's no beaker here!"
	else
		beaker:loc = src.loc
		src.icon_state = src.icon_empty
		spawn(0) src.beaker = null
/obj/machine/chem_heater/attack_by(obj/I)
	if(istype(I, /obj/item/reagent_container/beaker) && (!istype(I, /obj/item/reagent_container/beaker/bucket) && src.beaker == null))
		src.beaker = I
		I:loc = src
		src.icon_state = src.icon_full
		spawn(0) usr.delitem()

/obj/machine/chem_heater/attack_hand()
	if("chromosome" in usr.mutations && src.able == "omni")
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	if(beaker == null)
		usr << "\red Insert beaker first!"
	else
		if(!length(src.beaker:reagent_list))
			usr << "\red The beaker is empty!"
		else



			var/L = list()
			switch(src.able)
				if("omni")
					L = list(-1, 0, 1, 2, 3, 4, 5, 6)
				if("heat")
					L = list(min(beaker:temp + 1, 6), min(beaker:temp + 2, 6))
				if("cool")
					L = list(max(beaker:temp - 1, -1), min(beaker:temp - 2, -1))
				else
					L = list(0, 1)
			var/target_temp = input("Change temp to what?", "Current temperature is [beaker:temp].", 0) in L
			if(beaker && usr in range(1, src))
				beaker:changetemp(target_temp)





/obj/machine/chem_heater/plitka
	name = "electric range"
	desc = "An electric stove."
	icon_empty = "plitka_empty"
	icon_state = "plitka_empty"
	icon_full = "plitka_full"
	able = "heat"
/obj/machine/chem_heater/plitka
/obj/machine/chem_heater/plitka/attack_by(obj/item/I)
	if(istype(I, /obj/item/reagent_container/consumable/bumblebee_dead))
		var/beez = I
		usr << "\blue Bumblebee kebab anyone?"
		beez:roast()
		return
	else
		..()

/obj/machine/chem_extractor
	density = 1
	name = "chemical extraction unit"
	desc = "A device for juicing, grinding and powdering plants, pills, foods and other chemical-containing stuff. <br> It is loaded with nothing."
	icon_state = "extract_empty"
	var/sample
	var/beaker

/obj/machine/chem_extractor
	bomb_proof = 100

/obj/machine/chem_extractor/verb/remove_beaker()





	set name = "Remove beaker"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if(!beaker)
		usr << "\red There's no beaker here!"
	else
		icon_state = "extract_empty"
		beaker:loc = src.loc
		spawn(0) beaker = null

/obj/machine/chem_extractor/verb/remove_sample_from_the_machine()
	set src in view(1)

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	if(!src.sample)
		usr << "\red There's no beaker here!"
	else
		src.sample:loc = loc
		spawn(0) src.sample = null

/obj/machine/chem_extractor/verb/extract_sample()
	set src in view(1)

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	if(!beaker || !sample)
		usr << "\red Load it with both beaker and sample first!"
	else

		var/selfamount = 0
		var/sampamount = 0
		for(var/datum/reagent/R in sample:reagent_list)
			sampamount += R.amount
		for(var/datum/reagent/R in beaker:reagent_list)
			selfamount += R.amount
		if(sampamount > beaker:maxamount - selfamount)

			usr << "\red The beaker is too full!"
			return

		usr << "\blue You process the sample."
		for(var/datum/reagent/R in sample:reagent_list)
			beaker:add_chem(R.name, R.id, R.amount, 0)
		spawn(0)
			src.desc = "A device for juicing, grinding and powdering plants, pills and foods. <br> It is loaded with nothing."
			spawn(0)
				del(src.sample)
				spawn(0) src.sample = null

/obj/machine/chem_extractor/attack_by(obj/item/I)
	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this kind of machinery!"
		return

	if(istype(I, /obj/item/reagent_container/beaker) && (!istype(I, /obj/item/reagent_container/beaker/bottle) && (!istype(I, /obj/item/reagent_container/beaker/bucket) && src.beaker == null)))
		src.beaker = I
		src.icon_state = "extract_full"
		I:loc = src
		spawn(0) usr.delitem()
	else if(istype(I, /obj/item/reagent_container/consumable))
		if(sample)
			usr << "\red It is already loaded with sample!"
		else
			sample = I
			I:loc = src
			desc = "A device for juicing, grinding and powdering plants, pills and foods. <br> It is loaded with [I:name]."
			spawn(0) usr.delitem()
/obj/machine/chem_extractor/attack_hand()
	extract_sample()


