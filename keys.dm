/obj/item/amoebacore;/obj/item/amoebabox;/obj/item/readable;/obj/item/grimore;/obj/item/call_pack{icon = 'grafon/device.dmi'; market_price = 220; icon_state = "package"; name = "package"; desc = "It looks a bit suspicious."};/obj/item/cash{beltable = 1; market_price = 10; name = "spess rubels (10)"; icon_state = "rubel10"; desc = "Some goddamn cash"};/obj/item/fertilizer{icon = 'grafon/plant.dmi'; beltable = 1; name = "plant fertilizer"; icon_state = "fertilizer"; desc = "A portion of delicious minerals and organic stuff for plants. Do not consume."};/obj/item/bugdust{icon = 'grafon/plant.dmi'; beltable = 1; name = "vermin dust"; icon_state = "bugdust"; desc = "A powder harmless to plants but harmful to insect vermins."};/obj/item/debris;/obj/item/bong;/obj/item/vodniy_unfin{icon = 'grafon/item/liquid.dmi'; icon_state = "vodniy"; name = "Bottle in a bottle"; desc = "Just a bottle. In a bottle. Hilarious! Also, some water. This probably can be used for smoking psychoactive crap, if you add some plastic, metal or something to it."};/obj/item/limb;/obj/item/brain;/obj/item/key/slbrkr{name = "Slave chamber key-ring"; icon_state = "key_slbrkr"};/obj/item/key/slbrkr_main{name = "Some rusty key"; icon_state = "key_jpeg"}
/obj/item/key
	var/obj/access = new/list()
	dmg = 4
	accu = 70
	beltable = 1
	icon_state = "key_copper"
	name = "Key"
/obj/item/key/slbrkr_main
/obj/item/key/maint
	name = "Primary maintenance key"
/obj/item/key/maint/New()
	src:access:Add("primary")
/obj/item/key/engineer
	name = "Engineering and construction key"
	icon_state = "key_silver"
/obj/item/key/engineer
/obj/item/key/engineer/New()
	src:access:Add("primary", "engineer", "external", "circuit")
/obj/item/key/doctor
	icon_state = "key_silver"
	name = "Healthcare key"
/obj/item/key/doctor
/obj/item/key/doctor/New()
	src:access:Add("medical", "med_general", "biomech")
/obj/item/key/chemist
	name = "Med/sci key"
	icon_state = "key_blue"
/obj/item/key/chemist
/obj/item/key/chemist/New()
	src:access:Add("med_general", "chem")
/obj/item/key/command
	name = "Comrade Leadership key"
	icon_state = "key_military"
/obj/item/key/command
/obj/item/key/command/New()
	src:access:Add("embrasure", "command", "primary", "external", "research_wing", "security")
/obj/item/key/security
	icon_state = "key_military"
	name = "Security key"
/obj/item/key/security
/obj/item/key/security/New()
	src:access:Add("embrasure", "security", "primary")
/obj/item/key/labs
	name = "Laboratories key"
	icon_state = "key_electronic"
/obj/item/key/labs
/obj/item/key/labs/New()
	src:access:Add("labs", "research_wing", "circuit")
/obj/item/key/mining
	icon_state = "key_electronic"
	name = "Geology key"
/obj/item/key/mining
/obj/item/key/mining/New()
	src:access:Add("mining", "research_wing", "deepmine")
/obj/item/key/geobot
	name = "Geology access key"
	desc = "This thing is a part of your robotic body so no, you can't remove it."
	icon_state = "key_sputnik"
/obj/item/key/geobot
/obj/item/key/geobot/New()
	src:access:Add("mining", "research_wing", "deepmine")
/obj/item/key/geobot/attack_hand()
	if(istype(usr, /mob/robot))
		return
/obj/item/key/labcommand
	icon_state = "key_electronic"
	name = "Laboratories directing key"
/obj/item/key/labcommand
/obj/item/key/labcommand/New()
	src:access:Add("mind", "psychiatry", "primary", "labs", "command", "EVA", "medical", "med_general", "hydro", "chem", "biomech", "mining", "research_wing", "circuit")
/obj/item/key/engineercommand
	icon_state = "key_electronic"
	name = "Engineering and construction directing key"
/obj/item/key/engineercommand
/obj/item/key/engineercommand/New()
	src:access:Add("primary", "engineer", "command", "EVA", "proletary", "biomech", "external", "circuit")
/obj/item/key/captain
	name = "Golden key"
	icon_state = "key_gold"
/obj/item/key/captain
/obj/item/key/captain/New()
	src:access:Add("embrasure", "mining", "deepmine", "mind", "psychiatry", "med_general", "research_wing", "engineer", "primary", "EVA", "security", "labs", "medical", "command", "captain", "proletary", "bar", "hydro", "chem", "biomech", "operator", "external", "purificator", "prosecutor", "circuit")
/obj/item/key/sputnik
	icon_state = "key_sputnik"
	name = "Old-model robotic access module"
/obj/item/key/sputnik
/obj/item/key/sputnik/New()
	src:access:Add("sputnik", "command", "engineer", "primary", "EVA", "security", "labs", "medical", "med_general", "bar", "hydro", "chem", "biomech", "circuit")
/obj/item/key/sputnik/attack_hand()
	if(istype(usr, /mob/robot))
		return
/obj/item/key/hydro
	name = "Hydroponics key"
	icon_state = "key_green"
/obj/item/key/hydro
/obj/item/key/hydro/New()
	src:access:Add("hydro", "bar")
/obj/item/key/operator
	name = "Operation and Control key"
	icon_state = "key_elite"
/obj/item/key/operator
/obj/item/key/operator/New()
	src:access:Add("operator")
/obj/item/key/mindscience
	icon_state = "key_electronic"
	name = "Cognitology key"
/obj/item/key/mindscience
/obj/item/key/mindscience/New()
	src:access:Add("mind", "research_wing")
/obj/item/key/psycho
	icon_state = "key_electronic"
	name = "Psychiatry key"
/obj/item/key/psycho
/obj/item/key/psycho/New()
	src:access:Add("psychiatry", "research_wing")
/obj/item/key/purificator
	name = "Purificator outpost key"
	icon_state = "key_white"
/obj/item/key/purificator
/obj/item/key/purificator/New()
	src:access:Add("embrasure", "purificator", "primary", "deepmine", "external")
/obj/item/key/prosecutor
	name = "Prosecutor key"
	icon_state = "key_prosecutor"
/obj/item/key/prosecutor
/obj/item/key/prosecutor/New()
	src:access:Add("embrasure", "research_wing", "primary", "EVA", "security", "command", "bar", "external", "med_general", "prosecutor", "circuit")
