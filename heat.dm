// Recovered from compiled neek.dmb (53 procs)

/obj/item/reagent_container/proc/changetemp(heatamount)
















	src.temp = heatamount
	if(istype(src, /obj/item/reagent_container/syringe))
		var/S = src
		if(src.temp >= 2 && S:aids)
			S:aids = 0
	for(var/datum/reagent/R in src.reagent_list)
		R.on_temp(src, src.temp)
	sleep(0)
	src.add_chem("dummy", "dummy", 0, src.temp)

/datum

/datum/synergy

/datum/synergy

/datum/drug_design

/datum/drug_design


/datum/reagent



/datum/reagent/proc/on_temp(obj/location, hawt)











































	if(istype(location, /obj/item/reagent_container/consumable) && location:temp < 0)
		return
	for(var/datum/on_temp/R in on_temp_avaible)
		var/T
		if(istype(location:loc, /turf))
			T = location:loc
		else
			T = location:loc:loc
		if(src.id == R.rid)
			R.react(src, T, location)
/datum/on_temp
	var/rid = "nothing to see here, folks"
/datum/on_temp{rid = "nitrocellulose"; rid = "space gunpowder"}
/datum/on_temp/proc/react(R, turf/T, obj/location)
	world << "\red <font size = 5>ON_TEMP IS BROKEN, HURR DURR</font>"
/datum/on_temp/proc/evapourate(datum/reagent/R, turf/T, obj/location)


	var/S = new /obj/steam(T)
	S:temp = location:temp
	S:amount = round(R:amount)
	S:clock = round(R:amount / 3)




	spawn(0)
		var/datum/reagent/fume = new /datum/reagent()
		fume:amount = R:amount
		fume:id = R:id
		fume:name = R:name
		fume:reacts_with += R:reacts_with
		fume:in_reaction = R:in_reaction
		S:chemicals_carried += fume
		S:re = R:get_red()
		S:ge = R:get_green()
		S:be = R:get_blue()
		spawn(0)
			S:initiate()
			spawn(0)
				if(location)
					location:remove_chem(R:id, R:amount)
/datum/on_temp/chlorine
	rid = "chlorine"
/datum/on_temp/chlorine
/datum/on_temp/chlorine/react(R, turf/T, obj/location)
	if(location:temp >= 2)
		var/howmany = 0
		if(R:amount >= 3)
			howmany = round(R:amount / 3)
		else if(R:amount >= 2.8)
			howmany = 1
		spawn(0)
			for(, howmany > 0, howmany--)
				var/C = new /obj/cloud/prespawned(T)
				C:temp = location:temp
				spawn(0) howmany -= 1
			spawn(0)
				if(location)
					location:remove_chem(R:id, R:amount)
/datum/on_temp/regenerite
	rid = "regenerite"
/datum/on_temp/regenerite/react(R, turf/T, obj/location)
	if(location:temp >= 5)
		var/howmany = 0
		if(R:amount >= 3)
			howmany = round(R:amount / 3)
		else if(R:amount >= 2.8)
			howmany = 1
		spawn(0)
			for(, howmany > 0, howmany--)
				var/C = new /obj/cloud/regenerite(T)
				C:temp = location:temp
				spawn(0) howmany -= 1
			spawn(0)
				if(location)
					location:remove_chem(R:id, R:amount)
/datum/on_temp/antidote
	rid = "antidote"
/datum/on_temp/antidote
/datum/on_temp/antidote/react(R, turf/T, obj/location)
	if(location:temp >= 5)
		var/howmany = 0
		if(R:amount >= 3)
			howmany = round(R:amount / 3)
		else if(R:amount >= 2.8)
			howmany = 1
		spawn(0)
			for(, howmany > 0, howmany--)
				var/C = new /obj/cloud/antidote(T)
				C:temp = location:temp
				spawn(0) howmany -= 1
			spawn(0)
				if(location)
					location:remove_chem(R:id, R:amount)
/datum/on_temp/toxin
	rid = "toxin"
/datum/on_temp/toxin
/datum/on_temp/toxin/react(R, turf/T, obj/location)
	if(location:temp >= 5)
		var/howmany = 0
		if(R:amount >= 3)
			howmany = round(R:amount / 3)
		else if(R:amount >= 2.8)
			howmany = 1
		spawn(0)
			for(, howmany > 0, howmany--)
				var/C = new /obj/cloud/toxin(T)
				C:temp = location:temp
				spawn(0) howmany -= 1
			spawn(0)
				if(location)
					location:remove_chem(R:id, R:amount)
/datum/on_temp/fuel
	rid = "fuel"
/datum/on_temp/fuel/react(R, turf/T, obj/location)
	if(location:temp >= 2)
		var/howmany = 0
		if(R:amount >= 3)
			howmany = round(R:amount / 3)
		else if(R:amount >= 2.8)
			howmany = 1
		spawn(0)
			for(, howmany > 0, howmany--)
				var/C = new /obj/cloud/fuel(T)
				C:temp = location:temp
				spawn(0) howmany -= 1
			spawn(0) location:remove_chem(R:id, R:amount)
/datum/on_temp/nitroglycerin
	rid = "nitroglycerin"
/datum/on_temp/nitroglycerin
/datum/on_temp/nitroglycerin/react(R, turf/T, obj/location)
	if(location:temp >= 1)


		var/S = new /obj/effect/sparks(T)
		spawn(0)
			S:explosion(R:amount / 10)
			spawn(0)
				if(location)
					location:remove_chem("nitroglycerin", R:amount)
/datum/on_temp/water
	rid = "water"
/datum/on_temp/water
/datum/on_temp/water/react(R, turf/T, obj/location)
	if(location:temp >= 2)
		evapourate(R, T, location)

/datum/on_temp/fibgenerite
	rid = "fibgenerite"
/datum/on_temp/fibgenerite
/datum/on_temp/fibgenerite/react(R, turf/T, obj/location)
	if(location:temp >= 2)
		evapourate(R, T, location)

/datum/on_temp/manganeska
	rid = "manganeska"
/datum/on_temp/manganeska
/datum/on_temp/manganeska/react(R, turf/T, obj/location)
	if(location:temp >= 2)
		evapourate(R, T, location)

/datum/on_temp/mangadote
	rid = "mangadote"
/datum/on_temp/mangadote
/datum/on_temp/mangadote/react(R, turf/T, obj/location)
	if(location:temp >= 2)
		evapourate(R, T, location)

/datum/on_temp/ethanol
	rid = "ethanol"
/datum/on_temp/ethanol
/datum/on_temp/ethanol/react(R, turf/T, obj/location)
	if(location:temp >= 1.8)
		evapourate(R, T, location)
/datum/on_temp/methanol
	rid = "methanol"
/datum/on_temp/methanol
/datum/on_temp/methanol/react(R, turf/T, obj/location)
	if(location:temp >= 1.8)
		evapourate(R, T, location)
/datum/on_temp/milk
	rid = "milk"
/datum/on_temp/milk
/datum/on_temp/milk/react(R, turf/T, obj/location)
	if(location:temp >= 2.5)
		evapourate(R, T, location)
/datum/on_temp/condensed_milk
	rid = "condensed milk"
/datum/on_temp/condensed_milk
/datum/on_temp/condensed_milk/react(R, turf/T, obj/location)
	if(location:temp >= 2.5)
		evapourate(R, T, location)
/datum/on_temp/stalkotoxin
	rid = "stalkotoxin"
/datum/on_temp/stalkotoxin
/datum/on_temp/stalkotoxin/react(R, turf/T, obj/location)
	if(location:temp >= 2)
		evapourate(R, T, location)
/datum/on_temp/sulfuric_acid
	rid = "sulfuric acid"
/datum/on_temp/sulfuric_acid
/datum/on_temp/sulfuric_acid/react(R, turf/T, obj/location)
	if(location:temp >= 2)
		evapourate(R, T, location)
/datum/on_temp/hydrochloric_acid
	rid = "hydrochloric acid"
/datum/on_temp/hydrochloric_acid
/datum/on_temp/hydrochloric_acid/react(R, turf/T, obj/location)
	if(location:temp >= 1.6)
		evapourate(R, T, location)
/datum/on_temp/nitric_acid
	rid = "nitric acid"
/datum/on_temp/nitric_acid
/datum/on_temp/nitric_acid/react(R, turf/T, obj/location)
	if(location:temp >= 1.5)
		evapourate(R, T, location)
/datum/on_temp/aqua_regia
	rid = "aqua regia"
/datum/on_temp/aqua_regia
/datum/on_temp/aqua_regia/react(R, turf/T, obj/location)
	if(location:temp >= 2.5)
		evapourate(R, T, location)
/datum/on_temp/polytrinic_acid
	rid = "polytrinic acid"
/datum/on_temp/polytrinic_acid
/datum/on_temp/polytrinic_acid/react(R, turf/T, obj/location)
	if(location:temp >= 3)
		evapourate(R, T, location)

/datum/on_temp/biotoxin
	rid = "biotoxin"
/datum/on_temp/biotoxin
/datum/on_temp/biotoxin/react(R, turf/T, obj/location)
	if(location:temp >= 2)
		evapourate(R, T, location)
/datum/on_temp/rot
	rid = "corpse rot"
/datum/on_temp/rot
/datum/on_temp/rot/react(R, turf/T, obj/location)
	if(location:temp >= 2)
		evapourate(R, T, location)
/datum/on_temp/botox
	rid = "botox"
/datum/on_temp/botox
/datum/on_temp/botox/react(R, turf/T, obj/location)
	if(location:temp >= 3)
		evapourate(R, T, location)
/datum/on_temp/atropine
	rid = "atropine"
/datum/on_temp/atropine
/datum/on_temp/atropine/react(R, turf/T, obj/location)
	if(location:temp >= 3)
		evapourate(R, T, location)
/datum/on_temp/strychnine
	rid = "strychnine"
/datum/on_temp/strychnine
/datum/on_temp/strychnine/react(R, turf/T, obj/location)
	if(location:temp >= 3)
		evapourate(R, T, location)

/datum/on_temp/plant_oil
	rid = "plant oil"

/datum/on_temp/plant_oil

/datum/on_temp/plant_oil/react(R, turf/T, obj/location)
	if(location:temp >= 2.2)
		evapourate(R, T, location)
/datum/on_temp/pogankeepeptide
	rid = "pogankeepeptide"
/datum/on_temp/pogankeepeptide
/datum/on_temp/pogankeepeptide/react(R, turf/T, obj/location)
	if(location:temp >= 4)
		evapourate(R, T, location)

/datum/on_temp/ibuprofen
	rid = "ibuprofen"

/datum/on_temp/ibuprofen

/datum/on_temp/ibuprofen/react(R, turf/T, obj/location)
	if(location:temp >= 2)
		evapourate(R, T, location)
/datum/on_temp/paracetamol
	rid = "paracetamol"
/datum/on_temp/paracetamol
/datum/on_temp/paracetamol/react(datum/reagent/R, turf/T, obj/location)
	if(location:temp < 0)
		usr << "\blue You freeze out some paracetamol."
		var/TR = new /obj/item/reagent_container/consumable/track(T)
		TR:add_chem(R:id, R:name, R:amount, location:temp)
		spawn(0)
			if(location)
				location:remove_chem(R:id, R:amount)
/datum/on_temp/silicon
	rid = "silicon"
/datum/on_temp/silicon
/datum/on_temp/silicon/react(datum/reagent/R, turf/T, obj/location)
	if(location:temp < 0)
		usr << "\blue You freeze out some silicon."
		var/TR = new /obj/item/reagent_container/consumable/track(T)
		TR:add_chem(R:id, R:name, R:amount, location:temp)
		spawn(0)
			if(location)
				location:remove_chem(R:id, R:amount)
/datum/on_temp/caffeine
	rid = "caffeine"
/datum/on_temp/caffeine
/datum/on_temp/caffeine/react(datum/reagent/R, turf/T, obj/location)
	if(location:temp < 0)
		usr << "\blue You freeze out some caffeine."
		var/TR = new /obj/item/reagent_container/consumable/track(T)
		TR:add_chem(R:id, R:name, R:amount, location:temp)
		spawn(0)
			if(location)
				location:remove_chem(R:id, R:amount)
/datum/on_temp/nutriment
	rid = "nutriment"
/datum/on_temp/nutriment
/datum/on_temp/nutriment/react(datum/reagent/R, turf/T, obj/location)
	if(location:temp >= 5)
		usr << "\blue [R:name] decomposts."
		spawn(0)
			if(location)
				location:remove_chem(R:id, R:amount)
/datum/on_temp/carbo
	rid = "carboxylic acid"
/datum/on_temp/carbo
/datum/on_temp/carbo/react(datum/reagent/R, turf/T, obj/location)
	if(location:temp >= 5)
		usr << "\blue [R:name] decomposts."
		spawn(0)
			if(location)
				location:remove_chem(R:id, R:amount)

/datum/on_temp/carbon
	rid = "carbon"
/datum/on_temp/carbon
/datum/on_temp/carbon/react(datum/reagent/R, turf/T, obj/location)
	if(location:temp < 0)
		usr << "\blue You freeze out some carbon."
		var/TR = new /obj/item/reagent_container/consumable/track(T)
		TR:add_chem(R:id, R:name, R:amount, location:temp)
		spawn(0) location:remove_chem(R:id, R:amount)
	else
		if(location:temp >= 6)
			usr << "\blue [R:name] burns out."
			if(R:amount >= 5 || prob(20))
				if(istype(location:loc, /turf))
					location:show_message("\red OH FUCK THE SMOKE")
					new /obj/cloud/smoke/chem(location:loc)
				else
					location:loc:show_message("\red OH FUCK THE SMOKE")
					new /obj/cloud/smoke/chem(location:loc:loc)

			spawn(0)
				if(location)
					location:remove_chem(R:id, R:amount)

/datum/on_temp/cellulose
	rid = "cellulose"
/datum/on_temp/cellulose
/datum/on_temp/cellulose/react(datum/reagent/R, turf/T, obj/location)
	if(location:temp >= 6)
		usr << "\blue [R:name] burns out."
		if(R:amount >= 5 || prob(20))
			if(istype(location:loc, /turf))
				location:show_message("\red OH FUCK THE SMOKE")
				new /obj/cloud/smoke/chem(location:loc)
			else
				location:loc:show_message("\red OH FUCK THE SMOKE")
				new /obj/cloud/smoke/chem(location:loc:loc)

		spawn(0)
			if(location)
				location:remove_chem(R:id, R:amount)

/datum/on_temp/phosphorus
	rid = "phosphorus"
/datum/on_temp/phosphorus
/datum/on_temp/phosphorus/react(datum/reagent/R, turf/T, obj/location)
	if(location:temp >= 4)
		usr << "\blue [R:name] burns out."
		if(R:amount >= 5 && prob(50) || prob(20))
			if(istype(location:loc, /turf))
				location:show_message("\red OH FUCK THE SMOKE")
				new /obj/cloud/smoke/chem(location:loc)
			else
				location:loc:show_message("\red OH FUCK THE SMOKE")
				new /obj/cloud/smoke/chem(location:loc:loc)

		spawn(0)
			if(location)
				location:remove_chem(R:id, R:amount)

/datum/on_temp/ammonium_hydroxide
	rid = "ammonium hydroxide"

/datum/on_temp/ammonium_hydroxide
/datum/on_temp/ammonium_hydroxide/react(R, turf/T, obj/location)
	if(location:temp >= 2.5)
		evapourate(R, T, location)
/datum/on_temp/hydrogen
	rid = "hydrogen"
/datum/on_temp/hydrogen
/datum/on_temp/hydrogen/react(R, turf/T, obj/location)
	if(location:temp >= 1)
		var/howmany = 0
		if(R:amount >= 3)
			howmany = round(R:amount / 3)
		else if(R:amount >= 2.8)
			howmany = 1
		spawn(0)
			for(, howmany > 0, howmany--)
				var/F = new /obj/fire(T)
				F:heat = howmany + location:temp * 3
				spawn(0) howmany -= 1
		spawn(0)
			if(location)
				location:remove_chem(R:id, R:amount)
/datum/on_temp/aids
	rid = "AIDS"
/datum/on_temp/aids
/datum/on_temp/aids/react(R, turf/T, obj/location)
	if(location:temp >= 2)
		evapourate(R, T, location)

/datum/on_temp/nitrogen_tourettide
	rid = "nitrogen tourettide"

/datum/on_temp/nitrogen_tourettide


/datum/on_temp/nitrogen_tourettide/react(R, turf/T, obj/location)








	if(location:temp >= 5)
		evapourate(R, T, location)
/datum/on_temp/haloperidol
	rid = "haloperidol"
/datum/on_temp/haloperidol
/datum/on_temp/haloperidol/react(R, turf/T, obj/location)
	if(location:temp >= 4)
		evapourate(R, T, location)
/datum/on_temp/liquid_smoke
	rid = "liquid smoke"
/datum/on_temp/liquid_smoke
/datum/on_temp/liquid_smoke/react(R, turf/T, obj/location)
	if(location:temp >= 4)
		var/howmany = 0
		if(R:amount >= 2.5)
			howmany = round(R:amount / 2.5)
		else if(R:amount >= 0.9)
			howmany = 1
		spawn(0)
			for(, howmany > 0, howmany--)
				var/F = new /obj/fire(T)
				F:heat = howmany + location:temp * 2
				spawn(0) howmany -= 1
		spawn(0)
			if(location)
				location:remove_chem(R:id, R:amount)
/datum/on_temp/MDA
	rid = "MDA"
/datum/on_temp/MDA
/datum/on_temp/MDA/react(R, turf/T, obj/location)
	if(location:temp >= 4)
		evapourate(R, T, location)
/datum/on_temp/MDMA
	rid = "MDMA"
/datum/on_temp/MDMA
/datum/on_temp/MDMA/react(R, turf/T, obj/location)
	if(location:temp >= 4)
		evapourate(R, T, location)
/datum/on_temp/psilocybin
	rid = "psilocybin"
/datum/on_temp/psilocybin
/datum/on_temp/psilocybin/react(R, turf/T, obj/location)
	if(location:temp >= 2)
		evapourate(R, T, location)
/datum/on_temp/fluorine
	rid = "fluorine"
/datum/on_temp/fluorine
/datum/on_temp/fluorine/react(R, turf/T, obj/location)
	if(location:temp >= 1.1)
		evapourate(R, T, location)
/datum/on_temp/rhinestones
	rid = "rhinestones"
/datum/on_temp/rhinestones
/datum/on_temp/rhinestones/react(R, turf/T, obj/location)
	if(location:temp >= 1.1)
		evapourate(R, T, location)

/datum/on_temp/nitrocellulose
/datum/on_temp/gunpowder
/datum/on_temp/react(R, turf/T, obj/location)
	if(location:temp >= 2)
		if(R:amount >= 1)
			for(var/mob/M in viewers(location))
				M << "\red The solution explodes!"
			var/S = new /obj/effect/sparks(T)
			spawn(0)
				S:explosion(R:amount / 25)
				spawn(0)
					if(location)
						location:remove_chem("nitrocellulose", R:amount)

/datum/on_temp/react(R, turf/T, obj/location)


	if(location:temp >= 2)
		if(R:amount >= 1)
			for(var/mob/M in viewers(location))
				M << "\red The solution explodes!"
			var/S = new /obj/effect/sparks(T)
			spawn(0)
				S:explosion(R:amount / 15)
				spawn(0)
					if(location)
						location:remove_chem("space gunpowder", R:amount)
