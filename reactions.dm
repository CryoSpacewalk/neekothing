// Recovered from compiled neek.dmb (174 procs)

/obj/item/reagent_container/proc/react(R1, R2, kata)











































































































































































































	for(var/datum/reaction/R in reactions_avaible)
		if((R1:id == R.r1 && R2:id == R.r2 || R2:id == R.r1 && R1:id == R.r2) && (R.requests_temp == null || R.requests_temp <= src.temp))
			if(!R.kata)
				R.react(R1, R2, src)
			else
				for(var/datum/reagent/RK in src.reagent_list)
					if(RK.id == R.kata)
						R.react(R1, R2, src)
/datum/on_mob
/datum/on_touch
/datum/on_sniff
/datum/on_smoke
/datum/on_turf
/datum/reaction{var/id = "hurr+durr"; var/r1 = "hurr"; var/r2 = "durr"; var/kata = 0; var/requests_temp = 0}
/datum/reaction/proc/react(R1, R2, kata, obj/location)

	world << "\blue <font_size = 6>Chemistry is broken, kud-kydah!</font>"

/datum/reaction/proc/reaction_message(obj/container, msg)
	var/place
	if(istype(container:loc, /turf))
		place = container:loc
	else
		place = container:loc:loc
	spawn(0)
		for(var/mob/M in viewers(place))
			M << msg

/datum/reaction/proc/two_to_one(R1, R2, obj/location, result_id, result_name, result_temp)
	var/reactive_amount
	if(R1:amount < R2:amount)
		reactive_amount = R1:amount
	else
		reactive_amount = R2:amount
	spawn(0)
		location:remove_chem(R1:id, reactive_amount)
		location:remove_chem(R2:id, reactive_amount)
		spawn(0)
			location:add_chem(result_id, result_name, reactive_amount * 2, result_temp)

/datum/reaction/proc/two_to_one_kata(R1, R2, kata, obj/location, result_id, result_name, result_temp)
	var/reactive_amount
	if(R1:amount < R2:amount)
		reactive_amount = R1:amount
	else
		reactive_amount = R2:amount
	spawn(0)
		location:remove_chem(R1:id, reactive_amount)
		location:remove_chem(R2:id, reactive_amount)
		spawn(0)
			location:add_chem(result_id, result_name, reactive_amount * 2, result_temp)

/datum/reaction/proc/three_to_one(R1, R2, R3, obj/location, result_id, result_name, result_temp)
	var/reactive_amount
	if(R1:amount < R2:amount)
		reactive_amount = R1:amount
	else
		reactive_amount = R2:amount
	if(R3:amount > reactive_amount)
		reactive_amount = R3:amount
	spawn(0)
		location:remove_chem(R1:id, reactive_amount)
		location:remove_chem(R2:id, reactive_amount)
		location:remove_chem(R3:id, reactive_amount)
		spawn(0)
			location:add_chem(result_id, result_name, reactive_amount * 3, result_temp)

/datum/reaction/proc/two_to_half(R1, R2, obj/location, result_id, result_name, result_temp)
	var/reactive_amount
	if(R1:amount < R2:amount)
		reactive_amount = R1:amount
	else
		reactive_amount = R2:amount
	spawn(0)
		location:remove_chem(R1:id, reactive_amount)
		location:remove_chem(R2:id, reactive_amount)
		spawn(0)
			location:add_chem(result_id, result_name, reactive_amount, result_temp)

/datum/reaction/proc/two_to_tenth(R1, R2, obj/location, result_id, result_name, result_temp)
	var/reactive_amount
	if(R1:amount < R2:amount)
		reactive_amount = R1:amount
	else
		reactive_amount = R2:amount
	spawn(0)
		location:remove_chem(R1:id, reactive_amount)
		location:remove_chem(R2:id, reactive_amount)
		spawn(0)
			location:add_chem(result_id, result_name, reactive_amount / 10, result_temp)

/datum/reaction/proc/two_to_quarter(R1, R2, obj/location, result_id, result_name, result_temp)
	var/reactive_amount
	if(R1:amount < R2:amount)
		reactive_amount = R1:amount
	else
		reactive_amount = R2:amount
	spawn(0)
		location:remove_chem(R1:id, reactive_amount)
		location:remove_chem(R2:id, reactive_amount)
		spawn(0)
			location:add_chem(result_id, result_name, reactive_amount / 4, result_temp)

/datum/reaction/proc/two_to_two(R1, R2, obj/location, result1_id, result1_name, result1_temp, result2_id, result2_name, result2_temp)
	var/reactive_amount
	if(R1:amount < R2:amount)
		reactive_amount = R1:amount
	else
		reactive_amount = R2:amount
	spawn(0)
		location:remove_chem(R1:id, reactive_amount)
		location:remove_chem(R2:id, reactive_amount)
		spawn(0)
			location:add_chem(result1_id, result1_name, reactive_amount, result1_temp)
			spawn(0) location:add_chem(result2_id, result2_name, reactive_amount, result2_temp)

/datum/reaction/proc/two_to_three(R1, R2, obj/location, result1_id, result1_name, result1_temp, result2_id, result2_name, result2_temp, result3_id, result3_name, result3_temp)
	var/reactive_amount
	if(R1:amount < R2:amount)
		reactive_amount = R1:amount
	else
		reactive_amount = R2:amount
	spawn(0)
		location:remove_chem(R1:id, reactive_amount)
		location:remove_chem(R2:id, reactive_amount)
		spawn(0)
			location:add_chem(result1_id, result1_name, reactive_amount / 1.5, result1_temp)
			spawn(0)
				location:add_chem(result2_id, result2_name, reactive_amount / 1.5, result2_temp)
				spawn(0) location:add_chem(result3_id, result3_name, reactive_amount / 1.5, result3_temp)
/datum/reaction/foam
	id = "foam+water"
	r1 = "foam"
	r2 = "water"
/datum/reaction/foam
/datum/reaction/foam/react(R1, R2, obj/location)
	var/reactive_amount
	var/place
	reaction_message(location, "\red The solution begin to bubble violently!")
	if(!istype(location:loc, /turf))
		place = location:loc:loc
	else
		place = location:loc
	if(R1:amount < R2:amount)
		reactive_amount = R1:amount
	else
		reactive_amount = R2:amount
	spawn(0)
		var/foamy = round(reactive_amount / 2)
		for(var/turf/T in range(foamy, place))
			var/F = new /obj/foam(place)
			F:fly(T)
		spawn(0)
			location:remove_chem(R1:id, reactive_amount)
			location:remove_chem(R2:id, reactive_amount)
/datum/reaction/rhinestones
	id = "aluminum+carbon"
	r1 = "aluminum"
	r2 = "carbon"
/datum/reaction/rhinestones
/datum/reaction/rhinestones/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution turns into a fuckload of shiny rhinestones.")
	two_to_half(R1, R2, location, "rhinestones", "rhinestones", location:temp)
/datum/reaction/warpotoxin
	id = "rhinestones+phosphorus"
	r1 = "rhinestones"
	r2 = "phosphorus"
/datum/reaction/warpotoxin
/datum/reaction/warpotoxin/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution glows for a moment.")
	two_to_half(R1, R2, location, "warpotoxin", "warpotoxin", location:temp)
/datum/reaction/luckstone
	id = "phenethylamine+rhinestones+methanol"
	r1 = "phenethylamine"
	r2 = "methanol"
	kata = "rhinestones"
/datum/reaction/luckstone
/datum/reaction/luckstone/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution turns into glowing powder.")
	two_to_half(R1, R2, location, "luckstone dust", "luckstone dust", location:temp)

/datum/reaction/antidote
	id = "manganese+cellulose"
	r1 = "manganese"
	r2 = "cellulose"

/datum/reaction/antidote
/datum/reaction/antidote/react(R1, R2, obj/location)
	reaction_message(location, "\red The reagent is turning indigo blue.")
	two_to_one(R1, R2, location, "antidote", "antidote", location:temp)
/datum/reaction/regenerite
	id = "antidote+aluminum"
	r1 = "antidote"
	r2 = "aluminum"
/datum/reaction/regenerite
/datum/reaction/regenerite/react(R1, R2, obj/location)
	reaction_message(location, "\red The reagent is turning bright red.")
	two_to_half(R1, R2, location, "regenerite", "regenerite", location:temp)
/datum/reaction/asd0
	id = "ASD+iron"
	r1 = "ASD"
	r2 = "iron"
/datum/reaction/asd0
/datum/reaction/asd0/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution looks even more stable than before.")
	two_to_one(R1, R2, location, "ASD-F0", "ASD-F0", location:temp)
/datum/reaction/fagenerite
	id = "rhinestones+ethanol"
	r1 = "rhinestones"
	r2 = "ethanol"
/datum/reaction/fagenerite
/datum/reaction/fagenerite/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution turns into a liquid [reverse_text("toggaf")]ry!")
	two_to_half(R1, R2, location, "fagenerite", "fagenerite", location:temp)
/datum/reaction/magnaneska
	id = "manganese+potassium"
	r1 = "manganese"
	r2 = "potassium"
/datum/reaction/magnaneska
/datum/reaction/magnaneska/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution turns light purple.")
	two_to_one(R1, R2, location, "manganeska", "manganeska", location:temp)
/datum/reaction/mangadote
	id = "magnaneska+antidote"
	r1 = "manganeska"
	r2 = "antidote"
/datum/reaction/mangadote
/datum/reaction/mangadote/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution begin to bubble violently!")
	two_to_one(R1, R2, location, "mangadote", "mangadote", location:temp)
/datum/reaction/fibgenerite
	id = "regenerite+plant oil"
	r1 = "regenerite"
	r2 = "plant oil"
/datum/reaction/fibgenerite
/datum/reaction/fibgenerite/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution [pick("begin to bubble", "suddenly turn bright yellow")].")
	two_to_one(R1, R2, location, "fibgenerite", "fibgenerite", location:temp)
/datum/reaction/prothesine
	id = "regenerite+ammonia"
	r1 = "regenerite"
	r2 = "ammonia"
/datum/reaction/prothesine
/datum/reaction/prothesine/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution [pick("begin to bubble", "suddenly turn bright yellow")].")
	two_to_half(R1, R2, location, "prothesine", "prothesine", location:temp)
/datum/reaction/peacenipizine
	id = "regenerite+sodium"
	r1 = "regenerite"
	r2 = "ammonia"
/datum/reaction/peacenipizine
/datum/reaction/peacenipizine/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution creates a weird throughts in your head.")
	two_to_half(R1, R2, location, "peacenipizine", "peacenipizine", location:temp)

/datum/reaction/sgushenka
	id = "condensed milk+hydrochloric acid"
	r1 = "hydrochloric acid"
	r2 = "condensed milk"

/datum/reaction/sgushenka
/datum/reaction/sgushenka/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution [pick("begin to bubble", "hiss loudly")].")
	two_to_one(R1, R2, location, "sgushenka", "sgushenka", location:temp)

/datum/reaction/methanol
	id = "cellulose+water"
	r1 = "cellulose"
	r2 = "water"
/datum/reaction/methanol
/datum/reaction/methanol/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution begin to bubble.")
	two_to_one(R1, R2, location, "methanol", "methanol", location:temp)
/datum/reaction/lithium_boom
	id = "lithium+water"
	r1 = "lithium"
	r2 = "water"
/datum/reaction/lithium_boom
/datum/reaction/lithium_boom/react(R1, R2, obj/location)
	var/reactive_amount
	var/place
	if(!istype(location:loc, /turf))
		place = location:loc:loc
	else
		place = location:loc
	if(R1:amount < R2:amount)
		reactive_amount = R1:amount
	else
		reactive_amount = R2:amount
	spawn(0)
		if(reactive_amount >= 4)
			reaction_message(location, "\red The solution explodes!")
			var/S = new /obj/effect/sparks(place)
			spawn(0) S:explosion(round(reactive_amount / 30))
		spawn(0)
			spawn(0)
				location:remove_chem(R1:id, reactive_amount)
				location:remove_chem(R2:id, reactive_amount)
/datum/reaction/sodium_boom
	id = "sodium+water"
	r1 = "sodium"
	r2 = "water"
/datum/reaction/sodium_boom
/datum/reaction/sodium_boom/react(R1, R2, obj/location)
	var/reactive_amount
	var/place
	if(!istype(location:loc, /turf))
		place = location:loc:loc
	else
		place = location:loc
	if(R1:amount < R2:amount)
		reactive_amount = R1:amount
	else
		reactive_amount = R2:amount
	spawn(0)
		if(reactive_amount >= 4)
			reaction_message(location, "\red The solution explodes!")
			var/S = new /obj/effect/sparks(place)
			spawn(0) S:explosion(round(reactive_amount / 30))
		spawn(0)
			spawn(0)
				location:remove_chem(R1:id, reactive_amount)
				location:remove_chem(R2:id, reactive_amount)
/datum/reaction/ammonia
	id = "hydrogen+nitrogen"
	r1 = "hydrogen"
	r2 = "nitrogen"
/datum/reaction/ammonia
/datum/reaction/ammonia/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution smells of ammonia.")
	two_to_one(R1, R2, location, "ammonia", "ammonia", location:temp)
/datum/reaction/ammonium_hydroxide
	id = "ammonia+water"
	r1 = "ammonia"
	r2 = "water"
/datum/reaction/ammonium_hydroxide
/datum/reaction/ammonium_hydroxide/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution smells of ammonia strongly.")
	two_to_one(R1, R2, location, "ammonium hydroxide", "ammonium hydroxide", location:temp)
/datum/reaction/urea
	id = "ammonia+carbon"
	r1 = "ammonia"
	r2 = "carbon"
/datum/reaction/urea
/datum/reaction/urea/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution smells of piss.")
	two_to_half(R1, R2, location, "ammonia", "ammonia", location:temp)
/datum/reaction/aqua_regia
	id = "nitric acid+hydrochloric acid"
	r1 = "nitric acid"
	r2 = "hydrochloric acid"
/datum/reaction/aqua_regia
/datum/reaction/aqua_regia/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution begin to slowly corrode its surroundings.")
	var/chlorpart
	for(var/datum/reagent/R in location:reagent_list)
		if(R.id == "nitric acid")
			chlorpart = R.amount
	for(var/datum/reagent/R in location:reagent_list)
		if(R.id == "hydrochloric acid")
			if(R.amount < chlorpart * 3)
				chlorpart = R.amount / 3
	spawn(0)
		location:remove_chem("nitric acid", chlorpart)
		location:remove_chem("hydrochloric acid", chlorpart * 3)
		spawn(0)
			location:add_chem("aqua regia", "aqua regia", chlorpart * 4, location:temp)

/datum/reaction/starsalve
	id = "aqua regia+plant oil"
	r1 = "aqua regia"
	r2 = "plant oil"
/datum/reaction/starsalve
/datum/reaction/starsalve/react(R1, R2, obj/location)
	if(!("the starsalve was synthesed this round" in funfacts))
		funfacts += "the starsalve was synthesed this round"

	src.reaction_message(location, "\red The solution begins to smell awfully. You can't bear it!")
	for(var/mob/M in range(1, location:loc))
		M.stun(2)
	src.two_to_half(R1, R2, location, "starsalve", "starsalve", location:temp)
/datum/reaction/polytrinic_acid
	id = "aqua regia+ammonium hydroxide"
	r1 = "aqua regia"
	r2 = "ammonium hydroxide"
	requests_temp = 2
/datum/reaction/polytrinic_acid
/datum/reaction/polytrinic_acid/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution begin to bubble.")
	two_to_half(R1, R2, location, "polytrinic acid", "polytrinic acid", location:temp)

/datum/reaction/napalm
	id = "liquid smoke+fuel"
	r1 = "fuel"
	r2 = "liquid smoke"

/datum/reaction/napalm
/datum/reaction/napalm/react(R1, R2, obj/location)
	reaction_message(location, "\red OH FUCK ITS BURNING")
	var/reactive_amount
	var/place
	if(!istype(location:loc, /turf))
		place = location:loc:loc
	else
		place = location:loc


	if(R1:amount < R2:amount)
		reactive_amount = R1:amount
	else
		reactive_amount = R2:amount
	spawn(0)
		if(reactive_amount >= 4)


			spawn(0)
				for(, reactive_amount > 0, reactive_amount--)


					var/C = new /obj/fire(place)
					if(location:temp <= 10)
						C:heat = 25
					else
						C:heat = location:temp + 15
					spawn(0) reactive_amount -= 4.5
		spawn(0)
			spawn(0)
				location:remove_chem(R1:id, reactive_amount)
				location:remove_chem(R2:id, reactive_amount)
/datum/reaction/glycerol
	id = "plant oil+sulfuric acid"
	r1 = "plant oil"
	r2 = "sulfuric acid"
/datum/reaction/glycerol
/datum/reaction/glycerol/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution is turning into jelly mass.")
	two_to_half(R1, R2, location, "glycerol", "glycerol", location:temp)
/datum/reaction/nitroglycerin
	id = "glycerol+nitric acid"
	r1 = "glycerol"
	r2 = "nitric acid"
/datum/reaction/nitroglycerin
/datum/reaction/nitroglycerin/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution is turning into oily liquid.")
	two_to_half(R1, R2, location, "nitroglycerin", "nitroglycerin", location:temp)
/datum/reaction/nitrocellulose
	id = "cellulose+nitric acid"
	r1 = "cellulose"
	r2 = "nitric acid"
/datum/reaction/nitrocellulose
/datum/reaction/nitrocellulose/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution looks somewhat unstable.")
	two_to_half(R1, R2, location, "nitrocellulose", "nitrocellulose", location:temp)
/datum/reaction/gunpowder
	id = "nitrocellulose+carbon+sugar"
	r1 = "nitrocellulose"
	r2 = "carbon"
	kata = "sugar"
/datum/reaction/gunpowder
/datum/reaction/gunpowder/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution looks somewhat unstable.")
	two_to_half(R1, R2, location, "space gunpowder", "space gunpowder", location:temp)
	two_to_half(R1, R2, location, "nitrocellulose", "nitrocellulose", location:temp)
/datum/reaction/steel
	id = "iron+carbon+fuel"
	r1 = "iron"
	r2 = "carbon"
	kata = "fuel"
	requests_temp = 1
/datum/reaction/steel
/datum/reaction/steel/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution turns into metallic gel.")
	two_to_one(R1, R2, location, "liquid steel", "liquid steel", location:temp)
/datum/reaction/lye
	id = "sodium+hydrogen"
	r1 = "sodium"
	r2 = "hydrogen"
/datum/reaction/lye
/datum/reaction/lye/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution smells kinda caustic.")
	two_to_one(R1, R2, location, "lye", "lye", location:temp)
/datum/reaction/lye2
	id = "potassium+hydrogen"
	r1 = "potassium"
	r2 = "hydrogen"
/datum/reaction/lye2
/datum/reaction/lye2/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution smells kinda caustic.")
	two_to_one(R1, R2, location, "lye", "lye", location:temp)
/datum/reaction/lye_heat
	id = "lye+water"
	r1 = "lye"
	r2 = "water"
/datum/reaction/lye_heat
/datum/reaction/lye_heat/react(R1, R2, obj/location)
	var/reactive_amount
	var/allamount
	for(var/datum/reagent/R in location:reagent_list)
		allamount += R.amount
	if(R1:amount < R2:amount)
		reactive_amount = R1:amount
	else
		reactive_amount = R2:amount
	spawn(0)
		if(reactive_amount >= 4)
			reaction_message(location, "\red The solution heats up.")
			spawn(0) location:temp += 0.1 + reactive_amount * 20 / allamount
		spawn(0)
			spawn(0)
				location:remove_chem(R1:id, reactive_amount)
				location:remove_chem(R2:id, reactive_amount)
/datum/reaction/liquid_smoke
	id = "sugar+aqua regia"
	r1 = "sugar"
	r2 = "aqua regia"
/datum/reaction/liquid_smoke
/datum/reaction/liquid_smoke/react(R1, R2, obj/location)
	reaction_message(location, "\red The reagent is turning into oily black liquid.")
	two_to_half(R1, R2, location, "liquid smoke", "liquid smoke", location:temp)
/datum/reaction/smoke
	id = "liquid smoke+water"
	r1 = "liquid smoke"
	r2 = "water"
/datum/reaction/smoke
/datum/reaction/smoke/react(R1, R2, obj/location)
	reaction_message(location, "\red PSHHHHHH")
	var/reactive_amount
	var/place
	if(!istype(location:loc, /turf))
		place = location:loc:loc
	else
		place = location:loc


	if(R1:amount < R2:amount)
		reactive_amount = R1:amount
	else
		reactive_amount = R2:amount
	spawn(0)
		if(reactive_amount >= 4.5)


			spawn(0)
				for(, reactive_amount > 0, reactive_amount--)


					var/C = new /obj/cloud/smoke(place)
					if(location:temp <= 6)
						C:temp = 6
					else
						C:temp = location:temp
					spawn(0) reactive_amount -= 5
		spawn(0)
			spawn(0)
				location:remove_chem(R1:id, reactive_amount)
				location:remove_chem(R2:id, reactive_amount)

/datum/reaction/asd
	id = "nutriment+iodine+polonium"
	r1 = "nutriment"
	r2 = "iodine"
	kata = "polonium"
	requests_temp = 1

/datum/reaction/asd
/datum/reaction/asd/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution looks extremely stable.")
	two_to_half(R1, R2, location, "ASD", "ASD", location:temp)
/datum/reaction/mutagen
	id = "ASD+nitric acid+polonium"
	r1 = "ASD"
	r2 = "nitric acid"
	kata = "polonium"
/datum/reaction/mutagen
/datum/reaction/mutagen/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution looks extremely unstable.")
	two_to_half(R1, R2, location, "mutagen", "mutagen", location:temp)
/datum/reaction/nicotine
	id = "nutriment+nitric acid"
	r1 = "nutriment"
	r2 = "nitric acid"
/datum/reaction/nicotine
/datum/reaction/nicotine/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution smokes like chief engineer's office.")
	two_to_half(R1, R2, location, "nicotine", "nicotine", location:temp)
/datum/reaction/dextroamitriptine
	id = "nicotine+toxin"
	r1 = "nicotine"
	r2 = "toxin"
/datum/reaction/dextroamitriptine
/datum/reaction/dextroamitriptine/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution is no longer smokes like chief engineer's office, hooray!")
	two_to_one(R1, R2, location, "dextroamitriptine", "dextroamitriptine", location:temp)
/datum/reaction/novichok
	id = "ASD+fluorine+phosphorus"
	r1 = "ASD"
	r2 = "fluorine"
	kata = "phosphorus"
/datum/reaction/novichok
/datum/reaction/novichok/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution flashes for a moment.")
	two_to_half(R1, R2, location, "novichok", "novichok", location:temp)


/datum/reaction/aids
	id = "blood+AIDS"
	r1 = "blood"
	r2 = "AIDS"
/datum/reaction/aids
/datum/reaction/aids/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a bad feeling about it.")
	two_to_one(R1, R2, location, "AIDS", "AIDS", location:temp)
/datum/reaction/toxin
	id = "fuel+chlorine"
	r1 = "fuel"
	r2 = "chlorine"
/datum/reaction/toxin
/datum/reaction/toxin/react(R1, R2, obj/location)
	reaction_message(location, "\red The reagent is turning bright green.")
	two_to_half(R1, R2, location, "toxin", "toxin", location:temp)

/datum/reaction/botox
	id = "yeast+regenerite"
	r1 = "yeast"
	r2 = "regenerite"
/datum/reaction/botox
/datum/reaction/botox/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution begin to bubble.")
	two_to_half(R1, R2, location, "botox", "botox", location:temp)

/datum/reaction/strychnine
	id = "toxin+acetic anhydride"
	r1 = "toxin"
	r2 = "acetic anhydride"
/datum/reaction/strychnine
/datum/reaction/strychnine/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution smells bitter.")
	two_to_one(R1, R2, location, "strychnine", "strychnine", location:temp)
/datum/reaction/biotoxin
	id = "fuel+yeast"
	r1 = "fuel"
	r2 = "yeast"
/datum/reaction/biotoxin
/datum/reaction/biotoxin/react(R1, R2, obj/location)
	reaction_message(location, "\red The reagent is turning bright purple.")
	two_to_half(R1, R2, location, "biotoxin", "biotoxin", location:temp)
/datum/reaction/rot
	id = "nutriment+toxin"
	r1 = "nutriment"
	r2 = "toxin"
/datum/reaction/rot
/datum/reaction/rot/react(R1, R2, obj/location)
	reaction_message(location, "\red The reagent smells terrible!")
	two_to_half(R1, R2, location, "corpse rot", "corpse rot", location:temp)
/datum/reaction/rot2
	id = "urea+toxin"
	r1 = "urea"
	r2 = "toxin"
/datum/reaction/rot2
/datum/reaction/rot2/react(R1, R2, obj/location)
	reaction_message(location, "\red The reagent smells terrible!")
	two_to_half(R1, R2, location, "corpse rot", "corpse rot", location:temp)
/datum/reaction/atropine
	id = "carboxylic acid+biotoxin+hydrochloric acid"
	r1 = "carboxylic acid"
	r2 = "biotoxin"
	kata = "hydrochloric acid"
/datum/reaction/atropine
/datum/reaction/atropine/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns really fucked up.")
	two_to_one(R1, R2, location, "atropine", "atropine", location:temp)
/datum/reaction/spess
	id = "biotoxin+lithium"
	r1 = "lithium"
	r2 = "biotoxin"
/datum/reaction/spess
/datum/reaction/spess/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns somewhat cooler.")
	two_to_half(R1, R2, location, "liquid vacuum", "liquid vacuum", 0)
/datum/reaction/glintsyn
	id = "biotoxin+lithium"
	r1 = "lithium"
	r2 = "biotoxin"
/datum/reaction/glintsyn
/datum/reaction/glintsyn/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns somewhat cooler.")
	two_to_half(R1, R2, location, "glintsyn", "glintsyn", 0)
/datum/reaction/black_yeast
	id = "yeast+chlorine+blood"
	r1 = "yeast"
	r2 = "chlorine"
	kata = "blood"
/datum/reaction/black_yeast
/datum/reaction/black_yeast/react(R1, R2, obj/location)
	reaction_message(location, "\red The yeast suddenly turns darker.")
	two_to_half(R1, R2, location, "black yeast", "black yeast", location:temp)
/datum/reaction/black_yeast_grow
	id = "black yeast+nutriment+hydrochloric acid"
	r1 = "black yeast"
	r2 = "nutriment"
/datum/reaction/black_yeast_grow
/datum/reaction/black_yeast_grow/react(R1, R2, obj/location)
	reaction_message(location, "\red The yeast starts to grow.")
	two_to_one(R1, R2, location, "black yeast", "black yeast", location:temp)
/datum/reaction/bacteria
	id = "black yeast+fuel+sulfuric acid"
	r1 = "black yeast"
	r2 = "fuel"
	kata = "sulfuric acid"
/datum/reaction/bacteria
/datum/reaction/bacteria/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture looks disgusting.")
	two_to_half(R1, R2, location, "neurobacteria", "neurobacteria", location:temp)


/datum/reaction/haloperidol
	id = "toxin+fluorine"
	r1 = "toxin"
	r2 = "fluorine"

/datum/reaction/haloperidol
/datum/reaction/haloperidol/react(R1, R2, obj/location)
	reaction_message(location, "\red The reagent is turning transparent.")
	two_to_half(R1, R2, location, "haloperidol", "haloperidol", location:temp)
/datum/reaction/aminazine
	id = "toxin+methanol"
	r1 = "toxin"
	r2 = "methanol"
/datum/reaction/aminazine
/datum/reaction/aminazine/react(R1, R2, obj/location)
	reaction_message(location, "\red The reagent is turning transparent.")
	two_to_half(R1, R2, location, "aminazine", "aminazine", location:temp)
/datum/reaction/clozapine
	id = "toxin+benzodiazepine"
	r1 = "toxin"
	r2 = "benzodiazepine"
/datum/reaction/clozapine
/datum/reaction/clozapine/react(R1, R2, obj/location)
	reaction_message(location, "\red The reagent is turning transparent.")
	two_to_half(R1, R2, location, "clozapine", "clozapine", location:temp)
/datum/reaction/carbamazepine
	id = "benzodiazepine+nitrogen+potassium"
	r1 = "benzodiazepine"
	r2 = "nitrogen"
	kata = "potassium"
/datum/reaction/carbamazepine
/datum/reaction/carbamazepine/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into homogeneous loose powder.")
	two_to_one(R1, R2, location, "carbamazepine", "carbamazepine", location:temp)
/datum/reaction/trihexyphenidyl
	id = "toxin+nitrogen"
	r1 = "toxin"
	r2 = "nitrogen"
/datum/reaction/trihexyphenidyl
/datum/reaction/trihexyphenidyl/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into loose white powder.")
	two_to_one(R1, R2, location, "trihexyphenidyl", "trihexyphenidyl", location:temp)
/datum/reaction/naloxone
	id = "methanol+yeast+oxycodone"
	r1 = "methanol"
	r2 = "yeast"
	kata = "oxycodone"
/datum/reaction/naloxone
/datum/reaction/naloxone/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns kinda boring.")
	two_to_one(R1, R2, location, "naloxone", "naloxone", location:temp)
/datum/reaction/flumazenil
	id = "iodine+silicon"
	r1 = "iodine"
	r2 = "silicon"
/datum/reaction/flumazenil
/datum/reaction/flumazenil/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns kinda boring.")
	two_to_half(R1, R2, location, "flumazenil", "flumazenil", location:temp)
/datum/reaction/ambrosine
	id = "toxin+hydrochloric acid+ethanol"
	r1 = "toxin"
	r2 = "ethanol"
	kata = "hydrochloric acid"
/datum/reaction/ambrosine
/datum/reaction/ambrosine/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture smells fantastic!")
	two_to_one(R1, R2, location, "ambrosine", "ambrosine", location:temp)
/datum/reaction/fluoxetine
	id = "fuel+ambrosine"
	r1 = "ambrosine"
	r2 = "fuel"
/datum/reaction/fluoxetine
/datum/reaction/fluoxetine/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into white powder.")
	two_to_half(R1, R2, location, "fluoxetine", "fluoxetine", location:temp)

/datum/reaction/inytropidril
	id = "glycerol+liquid smoke"
	r1 = "glycerol"
	r2 = "liquid smoke"
/datum/reaction/inytropidril
/datum/reaction/inytropidril/react(R1, R2, obj/location)
	if(!("an inytropidril was synthesed this round" in funfacts))
		funfacts += "an inytropidril was synthesed this round"

	src.reaction_message(location, "\red The reagent is turning... weird?")
	src.two_to_half(R1, R2, location, "inytropidril", "inytropidril", location:temp)


/datum/reaction/nitrogen_tourettinide
	id = "ammonia+haloperidol"
	r1 = "ammonia"
	r2 = "haloperidol"

/datum/reaction/nitrogen_tourettinide

/datum/reaction/nitrogen_tourettinide/react(R1, R2, obj/location)




	reaction_message(location, "\red The reagent is starting to make weird sounds...")
	two_to_one(R1, R2, location, "nitrogen tourettinide", "nitrogen tourettinide", location:temp)
/datum/reaction/foam_powder
	id = "sodium+hydrogen"
	r1 = "sodium"
	r2 = "hydrogen"
/datum/reaction/foam_powder
/datum/reaction/foam_powder/react(R1, R2, obj/location)
	reaction_message(location, "\red The reagent is turning into powder.")
	two_to_half(R1, R2, location, "foam", "foam", location:temp)
/datum/reaction/montage_powder
	id = "foam+fluorine"
	r1 = "foam"
	r2 = "fluorine"
/datum/reaction/montage_powder
/datum/reaction/montage_powder/react(R1, R2, obj/location)
	reaction_message(location, "\red The reagent is turning yellow.")
	two_to_half(R1, R2, location, "montage powder", "montage powder", location:temp)
/datum/reaction/montage_foam
	id = "montage powder+water"
	r1 = "montage powder"
	r2 = "water"
/datum/reaction/montage_foam
/datum/reaction/montage_foam/react(R1, R2, obj/location)
	reaction_message(location, "\red PSHHHHHH")
	var/reactive_amount
	var/place
	if(!istype(location:loc, /turf))
		place = location:loc:loc
	else
		place = location:loc
	if(R1:amount < R2:amount)
		reactive_amount = R1:amount
	else
		reactive_amount = R2:amount
	spawn(0)
		var/F = new /obj/structure/montage_foam(place)
		F:amt = round(reactive_amount / 4)
		spawn(0)
			location:remove_chem(R1:id, reactive_amount)
			location:remove_chem(R2:id, reactive_amount)
/datum/reaction/yeast_grow
	id = "yeast+ammonia"
	r1 = "yeast"
	r2 = "ammonia"
/datum/reaction/yeast_grow
/datum/reaction/yeast_grow/react(R1, R2, obj/location)
	reaction_message(location, "\red The yeast starts to grow.")
	two_to_one(R1, R2, location, "yeast", "yeast", location:temp)
/datum/reaction/yeast_grow2
	id = "yeast+nutriment"
	r1 = "yeast"
	r2 = "nutriment"
/datum/reaction/yeast_grow2
/datum/reaction/yeast_grow2/react(R1, R2, obj/location)
	reaction_message(location, "\red The yeast starts to grow.")
	two_to_one(R1, R2, location, "yeast", "yeast", location:temp)
/datum/reaction/ethanol
	id = "yeast+sugar"
	r1 = "yeast"
	r2 = "sugar"
/datum/reaction/ethanol
/datum/reaction/ethanol/react(R1, R2, obj/location)
	reaction_message(location, "\red The sugar is brewing.")
	two_to_two(R1, R2, location, "ethanol", "ethanol", location:temp, "methanol", "methanol", location:temp)
/datum/reaction/nutriment
	id = "carbon+ammonia+fuel"
	r1 = "carbon"
	r2 = "ammonia"
	kata = "fuel"
/datum/reaction/nutriment
/datum/reaction/nutriment/react(R1, R2, obj/location)
	reaction_message(location, "\red The reagent solidificates.")
	two_to_half(R1, R2, location, "nutriment", "nutriment", location:temp)
/datum/reaction/succinic
	id = "yeast+glucose"
	r1 = "yeast"
	r2 = "glucose"
/datum/reaction/succinic
/datum/reaction/succinic/react(R1, R2, obj/location)
	reaction_message(location, "\red The sugar is brewing.")
	two_to_one(R1, R2, location, "succinic acid", "succinic acid", location:temp)


/datum/reaction/fuelsaccharose
	id = "fuel+sugar"
	r1 = "fuel"
	r2 = "sugar"
/datum/reaction/fuelsaccharose
/datum/reaction/fuelsaccharose/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution looks less sweet than you expected.")
	two_to_half(R1, R2, location, "fuelsaccharose", "fuelsaccharose", location:temp)
/datum/reaction/piperidine
	id = "toxin+ammonia"
	r1 = "toxin"
	r2 = "ammonia"
/datum/reaction/piperidine
/datum/reaction/piperidine/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution smells funny.")
	two_to_half(R1, R2, location, "piperidine", "piperidine", location:temp)
/datum/reaction/PCP
	id = "piperidine+fuelsaccharose+carbo"
	r1 = "piperidine"
	r2 = "fuelsaccharose"
	kata = "carboxylic acid"
/datum/reaction/PCP
/datum/reaction/PCP/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution begins to shine like a crazy diamond.")
	two_to_half(R1, R2, location, "PCP", "PCP", location:temp)
/datum/reaction/PCE
	id = "piperidine+fuel+carbo"
	r1 = "piperidine"
	r2 = "fuel"
	kata = "carboxylic acid"
/datum/reaction/PCE
/datum/reaction/PCE/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution begins to shine like a crazy diamond.")
	two_to_half(R1, R2, location, "PCE", "PCE", location:temp)
/datum/reaction/meoPCE
	id = "PCE+antidote"
	r1 = "PCE"
	r2 = "antidote"
/datum/reaction/meoPCE
/datum/reaction/meoPCE/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution begins to shine like a crazy diamond.")
	two_to_half(R1, R2, location, "3-MeO-PCE", "3-MeO-PCE", location:temp)
/datum/reaction/meoPCP
	id = "PCP+antidote"
	r1 = "PCP"
	r2 = "antidote"
/datum/reaction/meoPCP
/datum/reaction/meoPCP/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution begins to shine like a crazy diamond.")
	two_to_half(R1, R2, location, "3-MeO-PCP", "3-MeO-PCP", location:temp)
/datum/reaction/MXE
	id = "3-MeO-PCE+fuelsaccharose"
	r1 = "3-MeO-PCE"
	r2 = "fuelsaccharose"
/datum/reaction/MXE
/datum/reaction/MXE/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution begins to shine like a crazy diamond.")
	two_to_one(R1, R2, location, "MXE", "MXE", location:temp)
/datum/reaction/MXP
	id = "3-MeO-PCP+fuelsaccharose"
	r1 = "3-MeO-PCP"
	r2 = "fuelsaccharose"
/datum/reaction/MXP
/datum/reaction/MXP/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution begins to shine like a crazy diamond.")
	two_to_one(R1, R2, location, "MXP", "MXP", location:temp)

/datum/reaction/adamantane
	id = "toxin+hydrogen+aluminum"
	r1 = "toxin"
	r2 = "hydrogen"
	kata = "aluminum"

/datum/reaction/adamantane

/datum/reaction/adamantane/react(R1, R2, obj/location)

	reaction_message(location, "\red The solution begins to sparkle.")
	two_to_one(R1, R2, location, "adamantane", "adamantane", location:temp)
/datum/reaction/amantadine
	id = "adamantane+nitric acid+sulfuric acid"
	r1 = "adamantane"
	r2 = "sulfuric acid"
	kata = "nitric acid"
/datum/reaction/amantadine
/datum/reaction/amantadine/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution stops sparkling.")
	two_to_one(R1, R2, location, "amantadine", "amantadine", location:temp)
/datum/reaction/rimantadine
	id = "adamantane+aluminum+lithium"
	r1 = "adamantane"
	r2 = "aluminum"
	kata = "lithium"
/datum/reaction/rimantadine
/datum/reaction/rimantadine/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution stops sparkling.")
	two_to_one(R1, R2, location, "rimantadine", "rimantadine", location:temp)
/datum/reaction/warnipizine
	id = "fuel+adamantane"
	r1 = "fuel"
	r2 = "adamantane"
/datum/reaction/warnipizine
/datum/reaction/warnipizine/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution begins to sparkle.")
	two_to_one(R1, R2, location, "warnipizine", "warnipizine", location:temp)
/datum/reaction/AB
	id = "adamantane+carboxylic acid"
	r1 = "adamantane"
	r2 = "carboxylic acid"
/datum/reaction/AB
/datum/reaction/AB/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution smells funny.")
	two_to_one(R1, R2, location, "AB-228", "AB-228", location:temp)
/datum/reaction/widow
	id = "AB-228+toxin"
	r1 = "AB-228"
	r2 = "toxin"
/datum/reaction/widow
/datum/reaction/widow/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution sedatates you a bit with nothing but mere a look.")
	two_to_half(R1, R2, location, "white widow", "white widow", location:temp)
/datum/reaction/APICA
	id = "AB-228+ammonia"
	r1 = "AB-228"
	r2 = "ammonia"
/datum/reaction/APICA
/datum/reaction/APICA/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution smells very funny.")
	two_to_half(R1, R2, location, "APICA", "APICA", location:temp)
/datum/reaction/APINACA
	id = "APICA+hydrogen"
	r1 = "APICA"
	r2 = "hydrogen"
/datum/reaction/APINACA
/datum/reaction/APINACA/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution smells extremely funny.")
	two_to_half(R1, R2, location, "APINACA", "APINACA", location:temp)
/datum/reaction/amalgam
	id = "mercury+nitric acid+aluminum"
	r1 = "mercury"
	r2 = "nitric acid"
	kata = "aluminum"
/datum/reaction/amalgam
/datum/reaction/amalgam/react(R1, R2, obj/location)
	var/lolgas
	var/T

	if(istype(location:loc, /turf))
		T = location:loc
	else
		T = location:loc:loc
	if(R1:amount < R2:amount)
		lolgas = R1:amount
	else
		lolgas = R2:amount
	if(lolgas >= 4)
		while(lolgas > 0)
			new /obj/cloud/toxin(T)
			lolgas -= 4
	reaction_message(location, "\red \bold OH FUCK THE GAS")
	two_to_half(R1, R2, location, "amalgam", "amalgam", location:temp)


/datum/reaction/lsd
	id = "pogankeepeptide+carbo"
	r1 = "pogankeepeptide"
	r2 = "carboxylic acid"
/datum/reaction/lsd
/datum/reaction/lsd/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a weird feelings about your new chemical.")
	two_to_half(R1, R2, location, "LSD", "LSD", location:temp)
/datum/reaction/tryptamine
	id = "carbo+nutriment+ammonium hydroxide"
	r1 = "carboxylic acid"
	r2 = "nutriment"
	kata = "ammonium hydroxide"
/datum/reaction/tryptamine
/datum/reaction/tryptamine/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into some kind of... powder?")
	two_to_half(R1, R2, location, "tryptamine", "tryptamine", location:temp)
/datum/reaction/fivemeo
	id = "toxin+tryptamine"
	r1 = "toxin"
	r2 = "tryptamine"
/datum/reaction/fivemeo
/datum/reaction/fivemeo/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a bad feelings about your new chemical.")
	two_to_one(R1, R2, location, "5-MeO-DMT", "5-MeO-DMT", location:temp)
/datum/reaction/homet
	id = "ammonia+tryptamine"
	r1 = "ammonia"
	r2 = "tryptamine"
/datum/reaction/homet
/datum/reaction/homet/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a weird feelings about your new chemical.")
	two_to_half(R1, R2, location, "4-HO-MET", "4-HO-MET", location:temp)
/datum/reaction/dipt
	id = "fuel+tryptamine"
	r1 = "fuel"
	r2 = "tryptamine"
/datum/reaction/dipt
/datum/reaction/dipt/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a weird feelings about your new chemical.")
	two_to_half(R1, R2, location, "DiPT", "DiPT", location:temp)
/datum/reaction/fivedipt
	id = "DiPT+toxin"
	r1 = "DiPT"
	r2 = "toxin"
/datum/reaction/fivedipt
/datum/reaction/fivedipt/react(R1, R2, obj/location)
	if(!("chemists was good at fucked up tryptamines synthesis this round" in funfacts))
		funfacts += "chemists was good at fucked up tryptamines synthesis this round"
	src.reaction_message(location, "\red You have a weird feelings about your new chemical.")
	src.two_to_one(R1, R2, location, "5-MeO-DiPT", "5-MeO-DiPT", location:temp)

/datum/reaction/acodmt
	id = "hydrochloric acid+psilocybin"
	r1 = "hydrochloric acid"
	r2 = "psilocybin"

/datum/reaction/acodmt

/datum/reaction/acodmt/react(R1, R2, obj/location)

	reaction_message(location, "\red You have a weird feelings about your new chemical.")
	two_to_half(R1, R2, location, "4-AcO-DMT", "4-AcO-DMT", location:temp)
/datum/reaction/acodmt2
	id = "sulfuric acid+psilocybin"
	r1 = "sulfuric acid"
	r2 = "psilocybin"
/datum/reaction/acodmt2
/datum/reaction/acodmt2/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a weird feelings about your new chemical.")
	two_to_half(R1, R2, location, "4-AcO-DMT", "4-AcO-DMT", location:temp)
/datum/reaction/acodmt3
	id = "nitric acid+psilocybin"
	r1 = "nitric acid"
	r2 = "psilocybin"
/datum/reaction/acodmt3
/datum/reaction/acodmt3/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a weird feelings about your new chemical.")
	two_to_half(R1, R2, location, "4-AcO-DMT", "4-AcO-DMT", location:temp)
/datum/reaction/acodmt4
	id = "aqua regia+psilocybin"
	r1 = "aqua regia"
	r2 = "psilocybin"
/datum/reaction/acodmt4
/datum/reaction/acodmt4/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a weird feelings about your new chemical.")
	two_to_half(R1, R2, location, "4-AcO-DMT", "4-AcO-DMT", location:temp)


/datum/reaction/phenethylamine
	id = "carbo+hydrogen"
	r1 = "carboxylic acid"
	r2 = "hydrogen"
/datum/reaction/phenethylamine
/datum/reaction/phenethylamine/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into some kind of... powder?")
	two_to_half(R1, R2, location, "phenethylamine", "phenethylamine", location:temp, "methanol", "methanol", location:temp)
/datum/reaction/DOB
	id = "phenethylamine+bromine"
	r1 = "phenethylamine"
	r2 = "bromine"
/datum/reaction/DOB
/datum/reaction/DOB/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a bad feelings about your new chemical.")
	two_to_tenth(R1, R2, location, "DOB", "DOB", location:temp)
/datum/reaction/DOI
	id = "phenethylamine+iodine"
	r1 = "phenethylamine"
	r2 = "iodine"
/datum/reaction/DOI
/datum/reaction/DOI/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a good feelings about your new chemical.")
	two_to_tenth(R1, R2, location, "DOI", "DOI", location:temp)
/datum/reaction/DOC
	id = "phenethylamine+chlorine"
	r1 = "phenethylamine"
	r2 = "chlorine"
/datum/reaction/DOC
/datum/reaction/DOC/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a good feelings about your new chemical.")
	two_to_tenth(R1, R2, location, "DOC", "DOC", location:temp)
/datum/reaction/DOM
	id = "phenethylamine+fuel"
	r1 = "phenethylamine"
	r2 = "fuel"
/datum/reaction/DOM
/datum/reaction/DOM/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a good feelings about your new chemical.")
	two_to_tenth(R1, R2, location, "DOM", "DOM", location:temp)
/datum/reaction/tch
	id = "amalgam + phenethylamine"
	r1 = "amalgam"
	r2 = "phenethylamine"
/datum/reaction/tch
/datum/reaction/tch/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a weird feelings about your new chemical.")
	two_to_half(R1, R2, location, "2C-H", "2C-H", location:temp)
/datum/reaction/siberia
	id = "2C-H+bromine"
	r1 = "2C-H"
	r2 = "bromine"
/datum/reaction/siberia
/datum/reaction/siberia/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a good feelings about your new chemical.")
	two_to_half(R1, R2, location, "2C-B", "2C-B", location:temp)
/datum/reaction/tci
	id = "2C-H+iodine"
	r1 = "2C-H"
	r2 = "iodine"
/datum/reaction/tci
/datum/reaction/tci/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a good feelings about your new chemical.")
	two_to_half(R1, R2, location, "2C-I", "2C-I", location:temp)
/datum/reaction/tcp
	id = "2C-H+fuel"
	r1 = "2C-H"
	r2 = "fuel"
/datum/reaction/tcp
/datum/reaction/tcp/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a weird feelings about your new chemical.")
	two_to_half(R1, R2, location, "2C-P", "2C-P", location:temp)
/datum/reaction/CBFLY
	id = "2C-B+fuelsaccharose"
	r1 = "2C-B"
	r2 = "fuelsaccharose"
/datum/reaction/CBFLY
/datum/reaction/CBFLY/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a bad feelings about your new chemical.")
	two_to_half(R1, R2, location, "2C-B-FLY", "2C-B-FLY", location:temp)
/datum/reaction/bromoDFLY
	id = "2C-B-FLY+toxin"
	r1 = "2C-B-FLY"
	r2 = "toxin"
/datum/reaction/bromoDFLY
/datum/reaction/bromoDFLY/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a very, very bad feelings about your new chemical.")
	two_to_half(R1, R2, location, "Bromo-DragonFLY", "Bromo-DragonFLY", location:temp)
/datum/reaction/nbome
	id = "2C-I+benzaldehyde"
	r1 = "2C-I"
	r2 = "benzaldehyde"
/datum/reaction/nbome
/datum/reaction/nbome/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a weird feelings about your new chemical.")
	two_to_one(R1, R2, location, "25i-NBOMe", "25i-NBOMe", location:temp)
/datum/reaction/nbome_b
	id = "2C-B+benzaldehyde"
	r1 = "2C-B"
	r2 = "benzaldehyde"
/datum/reaction/nbome_b
/datum/reaction/nbome_b/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a weird feelings about your new chemical.")
	two_to_one(R1, R2, location, "25b-NBOMe", "25b-NBOMe", location:temp)
/datum/reaction/mda
	id = "phenethylamine+hydrochloric acid"
	r1 = "phenethylamine"
	r2 = "hydrochloric acid"
/datum/reaction/mda
/datum/reaction/mda/react(R1, R2, obj/location)
	reaction_message(location, "\red You have a good feelings about your new chemical.")
	two_to_one(R1, R2, location, "MDA", "MDA", location:temp)
/datum/reaction/mdma
	id = "MDA+methanol"
	r1 = "MDA"
	r2 = "methanol"
/datum/reaction/mdma
/datum/reaction/mdma/react(R1, R2, obj/location)
	reaction_message(location, "\red The reagent is radiating pleasant warmth.")
	two_to_one(R1, R2, location, "MDMA", "MDMA", location:temp)
/datum/reaction/mdoh
	id = "MDA+ethanol"
	r1 = "MDA"
	r2 = "ethanol"
/datum/reaction/mdoh
/datum/reaction/mdoh/react(R1, R2, obj/location)
	reaction_message(location, "\red The reagent is radiating pleasant warmth.")
	two_to_one(R1, R2, location, "MDOH", "MDOH", location:temp)


/datum/reaction/pipes
	id = "toxin+ammonium hydroxide"
	r1 = "toxin"
	r2 = "ammonium hydroxide"
/datum/reaction/pipes
/datum/reaction/pipes/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution looks just plain disgusting.")
	two_to_half(R1, R2, location, "piperazine", "piperazine", location:temp)
/datum/reaction/BZP
	id = "piperazine+sulfuric acid+sodium"
	r1 = "piperazine"
	r2 = "sulfuric acid"
	kata = "sodium"
/datum/reaction/BZP
/datum/reaction/BZP/react(R1, R2, obj/location)
	reaction_message(location, "\red The solution looks somewhat less shitty.")
	two_to_half(R1, R2, location, "BZP", "BZP", location:temp)

/datum/reaction/speed
	id = "amalgam+benzaldehyde"
	r1 = "amalgam"
	r2 = "benzaldehyde"

/datum/reaction/speed
/datum/reaction/speed/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture warms up.")
	two_to_half(R1, R2, location, "amphetamine", "amphetamine", location:temp + 0.1)
/datum/reaction/mdpv
	id = "fuel+benzaldehyde+toxin"
	r1 = "fuel"
	r2 = "benzaldehyde"
	kata = "toxin"
/datum/reaction/mdpv
/datum/reaction/mdpv/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into white powder.")
	two_to_one(R1, R2, location, "MDPV", "MDPV", location:temp)
/datum/reaction/meth
	id = "methamphetamine"
	r1 = "pseudoephedrine"
	r2 = "phosphorus"
	kata = "iodine"
/datum/reaction/meth
/datum/reaction/meth/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns clear.")
	two_to_half(R1, R2, location, "methamphetamine", "methamphetamine", location:temp)
/datum/reaction/dextrometh
	id = "dextromethamphetamine"
	r1 = "ephedrine"
	r2 = "phosphorus"
	kata = "iodine"
/datum/reaction/dextrometh
/datum/reaction/dextrometh/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns clear.")
	two_to_half(R1, R2, location, "dextromethamphetamine", "dextromethamphetamine", location:temp)
/datum/reaction/methcathinone
	id = "pseudoephedrine+manganeska"
	r1 = "pseudoephedrine"
	r2 = "manganeska"
/datum/reaction/methcathinone
/datum/reaction/methcathinone/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns clear.")
	two_to_one(R1, R2, location, "methcathinone", "methcathinone", location:temp)
/datum/reaction/methcathinone2
	id = "ephedrine+manganeska"
	r1 = "ephedrine"
	r2 = "manganeska"
/datum/reaction/methcathinone2
/datum/reaction/methcathinone2/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns clear.")
	two_to_one(R1, R2, location, "methcathinone", "methcathinone", location:temp)
/datum/reaction/methyl_acetate
	id = "carbo+methanol"
	r1 = "methanol"
	r2 = "carboxylic acid"
/datum/reaction/methyl_acetate
/datum/reaction/methyl_acetate/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture bubbles.")
	two_to_one(R1, R2, location, "methyl acetate", "methyl acetate", location:temp)
/datum/reaction/anhydride
	id = "acetate+carbon"
	r1 = "methyl acetate"
	r2 = "carbon"
/datum/reaction/anhydride
/datum/reaction/anhydride/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into white powder.")
	two_to_one(R1, R2, location, "acetic anhydride", "acetic anhydride", location:temp)
/datum/reaction/barbital
	id = "urea+nutriment"
	r1 = "urea"
	r2 = "nutriment"
/datum/reaction/barbital
/datum/reaction/barbital/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into white powder.")
	two_to_half(R1, R2, location, "barbital", "barbital", location:temp)
/datum/reaction/phenobarbital
	id = "urea+fuel+bromine"
	r1 = "urea"
	r2 = "fuel"
	kata = "bromine"
/datum/reaction/phenobarbital
/datum/reaction/phenobarbital/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into white powder.")
	two_to_half(R1, R2, location, "phenobarbital", "phenobarbital", location:temp)
/datum/reaction/pentobarbital
	id = "urea+sodium+ethanol"
	r1 = "urea"
	r2 = "sodium"
	kata = "ethanol"
/datum/reaction/pentobarbital
/datum/reaction/pentobarbital/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into white powder.")
	two_to_half(R1, R2, location, "pentobarbital", "pentobarbital", location:temp)
/datum/reaction/thiopental
	id = "sodium + barbital"
	r1 = "sodium"
	r2 = "barbital"
/datum/reaction/thiopental
/datum/reaction/thiopental/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture liquifies.")
	two_to_half(R1, R2, location, "sodium thiopental", "sodium thiopental", location:temp)
/datum/reaction/benzo
	id = "ethanol+carboxylic acid"
	r1 = "ethanol"
	r2 = "carboxylic acid"
/datum/reaction/benzo
/datum/reaction/benzo/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into white powder.")
	two_to_one(R1, R2, location, "benzodiazepine", "benzodiazepine", location:temp)
/datum/reaction/phenazepam
	id = "benzodiazepine+nitric acid"
	r1 = "benzodiazepine"
	r2 = "nitric acid"
/datum/reaction/phenazepam
/datum/reaction/phenazepam/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into white powder.")
	two_to_half(R1, R2, location, "phenazepam", "phenazepam", location:temp)
/datum/reaction/diazepam
	id = "benzodiazepine+methanol"
	r1 = "benzodiazepine"
	r2 = "methanol"
/datum/reaction/diazepam
/datum/reaction/diazepam/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into pale pink powder.")
	two_to_half(R1, R2, location, "diazepam", "diazepam", location:temp)
/datum/reaction/midazolam
	id = "diazepam+hydrochloric acid"
	r1 = "diazepam"
	r2 = "hydrochloric acid"
/datum/reaction/midazolam
/datum/reaction/midazolam/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into pale pink powder.")
	two_to_half(R1, R2, location, "midazolam", "midazolam", location:temp)
/datum/reaction/triazolam
	id = "benzodiazepine+fuel"
	r1 = "benzodiazepine"
	r2 = "fuel"
/datum/reaction/triazolam
/datum/reaction/triazolam/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture solidificates for a second.")
	two_to_one(R1, R2, location, "triazolam", "triazolam", location:temp)
/datum/reaction/alprazolam
	id = "triazolam+ammonium hydroxide"
	r1 = "triazolam"
	r2 = "ammonium hydroxide"
/datum/reaction/alprazolam
/datum/reaction/alprazolam/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into pale pink powder.")
	two_to_half(R1, R2, location, "alprazolam", "alprazolam", location:temp)
/datum/reaction/nitrazepam
	id = "benzodiazepine+nitric acid"
	r1 = "benzodiazepine"
	r2 = "nitric acid"
/datum/reaction/nitrazepam
/datum/reaction/nitrazepam/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into yellowish-white powder.")
	two_to_quarter(R1, R2, location, "nitrazepam", "nitrazepam", location:temp)
/datum/reaction/flunitrazepam
	id = "flunitrazepam+fluorine"
	r1 = "benzodiazepine"
	r2 = "fluorine"
/datum/reaction/flunitrazepam
/datum/reaction/flunitrazepam/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into yellowish-white powder.")
	two_to_one(R1, R2, location, "flunitrazepam", "flunitrazepam", location:temp)
/datum/reaction/clonazepam
	id = "benzodiazepine+ammonia"
	r1 = "benzodiazepine"
	r2 = "ammonia"
/datum/reaction/clonazepam
/datum/reaction/clonazepam/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into white powder.")
	two_to_quarter(R1, R2, location, "clonazepam", "clonazepam", location:temp)
/datum/reaction/cosmozepam
	id = "clonazepam+fuel"
	r1 = "clonazepam"
	r2 = "fuel"
/datum/reaction/cosmozepam
/datum/reaction/cosmozepam/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into white fog for a second.")
	two_to_half(R1, R2, location, "cosmozepam", "cosmozepam", location:temp)
/datum/reaction/cognitozepam
	id = "cosmozepam+toxin"
	r1 = "cosmozepam"
	r2 = "toxin"
/datum/reaction/cognitozepam
/datum/reaction/cognitozepam/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into purple fog for a second.")
	two_to_half(R1, R2, location, "cognitozepam", "cognitozepam", location:temp)
/datum/reaction/opium
	id = "opium+ethanol"
	r1 = "opium"
	r2 = "ethanol"
/datum/reaction/opium
/datum/reaction/opium/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns completely awesome.")
	two_to_three(R1, R2, location, "ethanol", "ethanol", location:temp, "codeine", "codeine", location:temp, "morphine", "morphine", location:temp)
/datum/reaction/opium2
	id = "opium+methanol"
	r1 = "opium"
	r2 = "methanol"
/datum/reaction/opium2
/datum/reaction/opium2/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns completely awesome.")
	two_to_three(R1, R2, location, "methanol", "methanol", location:temp, "codeine", "codeine", location:temp, "morphine", "morphine", location:temp)
/datum/reaction/heroin
	id = "morphine+acetic anhydride"
	r1 = "morphine"
	r2 = "acetic anhydride"
/datum/reaction/heroin
/datum/reaction/heroin/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns completely awesome.")
	two_to_half(R1, R2, location, "heroin", "heroin", location:temp)
/datum/reaction/krokodil
	id = "codeine+phosphorus+iodine"
	r1 = "codeine"
	r2 = "phosphorus"
	kata = "iodine"
/datum/reaction/krokodil
/datum/reaction/krokodil/react(R1, R2, obj/location)
	if(!("some folk have cooked krokodil this round" in funfacts))
		funfacts += "some folk have cooked krokodil this round"
	src.reaction_message(location, "\red The mixture turns shittier.")
	src.two_to_one(R1, R2, location, "desomorphine", "desomorphine", location:temp)
/datum/reaction/oxycodone
	id = "thebaine+bromine+ammonia"
	r1 = "thebaine"
	r2 = "bromine"
	kata = "ammonia"
/datum/reaction/oxycodone
/datum/reaction/oxycodone/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns unbeliveable awesome.")
	two_to_half(R1, R2, location, "oxycodone", "oxycodone", location:temp)
/datum/reaction/hydrocodone
	id = "fuel+codeine"
	r1 = "codeine"
	r2 = "fuel"
/datum/reaction/hydrocodone
/datum/reaction/hydrocodone/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns completely awesome.")
	two_to_half(R1, R2, location, "hydrocodone", "hydrocodone", location:temp)
/datum/reaction/acetylfentanyl
	id = "acetic anhydride+fentanyl"
	r1 = "acetic anhydride"
	r2 = "fentanyl"
/datum/reaction/acetylfentanyl
/datum/reaction/acetylfentanyl/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns completely awesome.")
	two_to_one(R1, R2, location, "acetylfentanyl", "acetylfentanyl", location:temp)
/datum/reaction/gaba
	id = "yeast+cellulose"
	r1 = "yeast"
	r2 = "cellulose"
/datum/reaction/gaba
/datum/reaction/gaba/react(R1, R2, obj/location)
	reaction_message(location, "\red The cellulose is brewing, but in a somewhat wacko way.")
	two_to_two(R1, R2, location, "GABA", "GABA", location:temp, "yeast", "yeast", location:temp)
/datum/reaction/gbl
	id = "GABA+hydrogen"
	r1 = "GABA"
	r2 = "hydrogen"
/datum/reaction/gbl
/datum/reaction/gbl/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into some funny powder.")
	two_to_one(R1, R2, location, "GBL", "GBL", location:temp)
/datum/reaction/ghb
	id = "GBL+sodium"
	r1 = "GBL"
	r2 = "sodium"
/datum/reaction/ghb
/datum/reaction/ghb/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into some funny powder.")
	two_to_half(R1, R2, location, "GHB", "GHB", location:temp)
/datum/reaction/lithium_oxybutyrate
	id = "GBL+lithium"
	r1 = "GBL"
	r2 = "lithium"
/datum/reaction/lithium_oxybutyrate
/datum/reaction/lithium_oxybutyrate/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns into some funny powder.")
	two_to_half(R1, R2, location, "lithium oxybutyrate", "lithium oxybutyrate", location:temp)
/datum/reaction/bakla
	id = "phenibut+chlorine"
	r1 = "phenibut"
	r2 = "chlorine"
/datum/reaction/bakla
/datum/reaction/bakla/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns completely fucked up. I hope you're not goint to drink it, uh?")
	two_to_one(R1, R2, location, "baclofen", "baclofen", location:temp)
/datum/reaction/phenibut
	id = "GABA+phenethylamine"
	r1 = "GABA"
	r2 = "phenethylamine"
/datum/reaction/phenibut
/datum/reaction/phenibut/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns somewhat clearer.")
	two_to_one(R1, R2, location, "phenibut", "phenibut", location:temp)
/datum/reaction/phenotropil
	id = "phenibut+piracetam"
	r1 = "phenibut"
	r2 = "piracetam"
/datum/reaction/phenotropil
/datum/reaction/phenotropil/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns even more clear.")
	two_to_one(R1, R2, location, "phenotropil", "phenotropil", location:temp)
/datum/reaction/gabapentin
	id = "carbo+nitrogen"
	r1 = "carboxylic acid"
	r2 = "nitrogen"
/datum/reaction/gabapentin
/datum/reaction/gabapentin/react(R1, R2, obj/location)
	reaction_message(location, "\red The cellulose is brewing, but in a somewhat wacko way.")
	two_to_one(R1, R2, location, "gabapentin", "gabapentin", location:temp)
/datum/reaction/piracetam
	id = "GABA+toxin"
	r1 = "GABA"
	r2 = "toxin"
/datum/reaction/piracetam
/datum/reaction/piracetam/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns somewhat less fucked.")
	two_to_one(R1, R2, location, "piracetam", "piracetam", location:temp)
/datum/reaction/titbit
	id = "dicyclomine+polonium"
	r1 = "dicyclomine"
	r2 = "polonium"
/datum/reaction/titbit
/datum/reaction/titbit/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture is glowing!")
	two_to_one(R1, R2, location, "Nuclear titbit", "Nuclear titbit", location:temp)
/datum/reaction/tropicamide
	id = "carboxylic acid+fuel"
	r1 = "carboxylic acid"
	r2 = "fuel"
/datum/reaction/tropicamide
/datum/reaction/tropicamide/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture looks kinda weird to you.")
	two_to_half(R1, R2, location, "tropicamide", "tropicamide", location:temp)


/datum/reaction/mercury_red
	id = "mercury+AIDS"
	r1 = "mercury"
	r2 = "AIDS"
/datum/reaction/mercury_red
/datum/reaction/mercury_red/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture turns bright red.")
	two_to_half(R1, R2, location, "red mercury", "red mercury", location:temp)


/datum/reaction/shining_powder
	id = "benzaldehyde+phenethylamine+mitol"
	r1 = "phenethylamine"
	r2 = "mitol"
	kata = "benzaldehyde"

/datum/reaction/shining_powder
/datum/reaction/shining_powder/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture looks extremely weird to you.")
	two_to_half(R1, R2, location, "shining powder", "shining powder", location:temp)
/datum/reaction/mysterious_powder
	id = "DiPT+mitol+piracetam"
	r1 = "DiPT"
	r2 = "mitol"
	kata = "piracetam"
/datum/reaction/mysterious_powder
/datum/reaction/mysterious_powder/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture looks extremely weird to you.")
	two_to_half(R1, R2, location, "mysterious powder", "mysterious powder", location:temp)
/datum/reaction/gloomy_powder
	id = "benzodiazepine+mitol+benzaldehyde"
	r1 = "benzodiazepine"
	r2 = "mitol"
	kata = "benzaldehyde"
/datum/reaction/gloomy_powder
/datum/reaction/gloomy_powder/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture looks extremely weird to you.")
	two_to_half(R1, R2, location, "gloomy powder", "gloomy powder", location:temp)
/datum/reaction/powder_of_wonders
	id = "ambrosine+mitol+DMT"
	r1 = "ambrosine"
	r2 = "mitol"
	kata = "DMT"
/datum/reaction/powder_of_wonders
/datum/reaction/powder_of_wonders/react(R1, R2, obj/location)
	reaction_message(location, "\red The mixture looks extremely weird to you.")
	two_to_half(R1, R2, location, "powder of wonders", "powder of wonders", location:temp)
/datum/reaction/eldritch_powder
	id = "Nuclear titbit+mitol"
	r1 = "Nuclear titbit"
	r2 = "mitol"
/datum/reaction/eldritch_powder
/datum/reaction/eldritch_powder/react(R1, R2, obj/location)
	reaction_message(location, "\red \bold The mixture looks at you.")
	two_to_half(R1, R2, location, "eldritch powder", "eldritch powder", location:temp)

