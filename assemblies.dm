/obj/item/electronics
	icon = 'grafon/item/electronics.dmi'
/obj/item{icon = 'grafon/item.dmi'};/obj/item/electronics/deviceframe
	plastic_need = 1
	beltable = 1
	name = "device frame"
	icon_state = "deviceframe"
	var/wired = 0
	var/obj/result = null
/obj/item/electronics/deviceframe/attack_by(obj/I)
	if(istype(I, /obj/item/cable) && src.wired == 0)
		usr << "\blue You wire up [src]."
		src.wired = 1
		src.icon_state = "deviceframe_wired"
		var/CB = I
		spawn(0) CB:cminus(1)
	else if(src.wired == 1 && (!src.result && istype(I, /obj/item/electronics/core)))
		var/C = I
		src.result = C:result
		usr << "\blue You install [I] inside [src]."
		icon_state = "deviceframe_electronics"
		spawn(0) del(I)
	else if(src.result && istype(I, /obj/item/tool/screwdriver))
		usr << "\blue You finish your construction."
		new src.result(usr.loc)
		spawn(0) del(src)



/obj/machine/fabricator/electronics
	name = "Electronics PFU"
	icon_state = "fabricator_elec"
	hackicon = "fabricator_elec_hacked"
	wrenchable = 0
	desc = "A portable fabricator unit, able to read electronic blueprints from disks."
/obj/machine/fabricator/electronics

/obj/machine/fabricator/electronics/New()














































































	things.Add(new /obj/item/electronics/deviceframe())

/obj/machine/fabricator/electronics/attack_hand()
	var/Eproduct = input("\bold Materials left:\font metal: [src.metal]; silicon: [src.silicon]; biological structures: [src.wood]; plastic: [src.plastic]", "Please, make your selection.", "") in things
	if(usr in range(1, src))
		if(Eproduct:plastic_need > plastic)
			usr << "\red Not enough plastic ([Eproduct:plastic_need] needed)!"
		else if(Eproduct:metal_need > metal)
			usr << "\red Not enough metal ([Eproduct:metal_need] needed)!"
		else if(Eproduct:silicon_need > silicon)
			usr << "\red Not enough ([Eproduct:silicon_need] needed) silicon!"
		else if(Eproduct:wood_need > wood)
			usr << "\red Not enough([Eproduct:wood_need] needed) wood!"
		else
			metal -= Eproduct:metal_need
			plastic -= Eproduct:plastic_need
			silicon -= Eproduct:silicon_need
			wood -= Eproduct:wood_need
			spawn(20)
				new Eproduct:type(src.loc)

/obj/machine/fabricator/electronics/proc/readwrite(obj/D)









	if(istype(src, D:fabricator))
		switch(alert("Select your option.", , "Read (from disk)", "Write (to disk)"))
			if("Write (to disk)")
				D:thing = input("What to write on disk?", "", "") in src.things
			if("Read (from disk)")
				if(!D:thing)
					usr << "\red The disk appears to be empty."
				else
					for(var/obj/item/I in src.things)
						if(I.name == D:thing:name)
							usr << "\red This thing is already loaded into fabricator database!"
							return
					spawn(0)
						var/O = new D:thing:type()
						src.things += O
						usr << "\blue [src] data updated."
	else
		usr << "\red [src] refuses to take [D]."




/obj/machine/elecscan/attack_by(obj/I)




	if(!usr.candofun)
		usr << "\red NO"
		return

	if(istype(I, /obj/item/electronics/datadisk))
		switch(alert("Do you want to rewrite disk data, deleting old one and cleaning scanner data?", "", "Yes", "No"))
			if("Yes")
				if(src.thing)
					var/D = I
					D:thing = src.thing
					src.thing:loc = D
					spawn(0) src.thing = null
					usr << "\blue You rewrite disk data, cleaning scanner info."
				else
					usr << "\red [src] data base is empty for now."
			else
				return
	else if(istype(I, /obj/item/electronics) || (I:silicon_need > 0 || (I:metal_need > 0 || I:plastic_need > 0)))
		switch(alert("Do you want to deconstruct [I], deleting [src] data?", "", "Yes", "No"))
			if("Yes")
				src.thing = I
				I:loc = src
				spawn(0) usr.delitem()
			else
				return
/obj/item/electronics/core
	name = "device core"
	icon_state = "core_emeter"
	var/obj/result = null
/obj/item/electronics/datadisk{market_price = 5; silicon_need = 1; name = "data disk"; icon_state = "disk"; desc = "A diskette for holding construction info for fabricators."; var/obj/fabricator = /obj/machine/fabricator/electronics; var/obj/thing = null}
/obj/item/electronics/synthstone{market_price = 100; plastic_need = 2; name = "synth jewel"; desc = "While not as expensive as other jewels, this thing is used in some electronic assemblies."; icon_state = "synthjewel"}
/obj/item/electronics/synthstone/attack_by(obj/I)




	if(istype(I, /obj/item/electronics/targeting))
		usr << "\blue You connect your targeting system to the synthetic jewel."
		new /obj/item/electronics/blaster_raw(usr.loc)
		spawn(0)
			usr.delitem()
			spawn(0) del(src)
	else
		..()
/obj/item/electronics/blaster_raw
	market_price = 165
	silicon_need = 1
	plastic_need = 3
	size = 2
	dmg = 5
	parry = 5
	name = "unfinished gun"
	icon_state = "blaster_raw"
	desc = "An unfinished gun, lacking either a majority of wiring or something else."
/obj/item/electronics/blaster_raw
/obj/item/electronics/blaster_raw/attack_by(obj/I)
	if(istype(I, /obj/item/cable))
		usr << "\blue You wire up your blaster."
		var/W = I
		new /obj/item/weapon/gun/blaster/red(usr.loc)
		spawn(0)
			W:cminus(1)
			spawn(0) del(src)
	else if(istype(I, /obj/item/electronics/tantric))
		usr << "\blue You add a tantric assembly to your construction."
		new /obj/item/weapon/gun/eupho(usr.loc)
		spawn(0)
			usr.delitem()
			spawn(0) del(src)
/obj/item/electronics/plasma_gen
	market_price = 100
	silicon_need = 1
	metal_need = 1
	plastic_need = 1
	size = 2
	dmg = 5
	name = "plasma generator"
	icon_state = "plasma_gen"
	desc = "A small plasma generator, used in construction of some devices"
/obj/item/electronics/plasma_gen
/obj/item/electronics/plasma_gen/attack_by(obj/I)
	if(istype(I, /obj/item/electronics/targeting))
		usr << "\blue You attach a targeting system to your generator"
		new /obj/item/electronics/tarplasm(usr.loc)
		spawn(0)
			del(I)
			spawn(0) del(src)
	else if(istype(I, /obj/item/electronics/plasma_gen))
		usr << "\blue You make a double plasma generator. Woo-hoo!"
		new /obj/item/electronics/double_plasma(usr.loc)
		spawn(0)
			del(I)
			spawn(0) del(src)

/obj/item/electronics/targeting
	market_price = 60
	silicon_need = 1
	plastic_need = 2
	name = "primary targeting system"
	icon_state = "targeting_sys"
	desc = "A common targeting system, used in a majority of today energy arms"
/obj/item/electronics/targeting
/obj/item/electronics/targeting/attack_by(obj/I)
	if(istype(I, /obj/item/tool/screwdriver))
		usr << "\blue You change this thing a bit."
		if(istype(src.loc, /turf))
			new /obj/item/device/seeker_raw(src.loc)
		else
			new /obj/item/device/seeker_raw(loc:loc)
		spawn(0) del(src)
	else if(istype(I, /obj/item/diamond))
		usr << "\blue You connect your targeting system to the gem."
		new /obj/item/electronics/blaster_raw(usr.loc)
		spawn(0)
			usr.delitem()
			spawn(0) del(src)
	else if(istype(I, /obj/item/weapon/spray))
		var/S = I
		if(S:igniter)
			new /obj/item/device/igniter(usr.loc)
		usr << "\blue You connect your targeting system to the spray."
		var/L = new /obj/item/gas/loader(usr.loc)
		if(S:tank)
			if(S:tank:cl || (S:tank:tox || (S:tank:smk || (S:tank:anti || (S:tank:fuel || S:tank:regen)))))
				usr << "\blue You add your spray tank to the loader."
				S:tank:loc = L
				L:tanks += S:tank
				L:tankcount++
				L:icon_state = "[L:realicon][L:tankcount]"
				L:name = "gastank loader ([L:tankcount])"
			else
				S:tank:loc = usr.loc
		spawn(0)
			usr.delitem()
			spawn(0) del(src)
	else if(istype(I, /obj/item/electronics/synthstone))
		usr << "\blue You connect your targeting system to the synthetic jewel."
		new /obj/item/electronics/blaster_raw(usr.loc)
		spawn(0)
			usr.delitem()
			spawn(0) del(src)
	else
		..()
/obj/item/electronics/double_plasma
	silicon_need = 2
	metal_need = 2
	plastic_need = 2
	size = 3
	market_price = 200
	dmg = 10
	parry = 5
	name = "double plasma generator"
	icon_state = "tarplasm"
	desc = "It looks unfinished, yet very serious"
/obj/item/electronics/double_plasma
/obj/item/electronics/double_plasma/attack_by(obj/I)
	if(istype(I, /obj/item/electronics/targeting))
		usr << "\blue You attach a targeting system to your doubled generator"
		new /obj/item/electronics/tarplasm_double(usr.loc)
		spawn(0)
			del(I)
			spawn(0) del(src)
/obj/item/electronics/tarplasm
	silicon_need = 2
	metal_need = 2
	plastic_need = 3
	size = 3
	dmg = 9
	parry = 5
	market_price = 200
	icon_state = "tarplasm"
	name = "targeted plasma generator"
	desc = "It looks unfinished"
/obj/item/electronics/tarplasm
/obj/item/electronics/tarplasm/attack_by(obj/I)
	if(istype(I, /obj/item/cable))
		var/CB = I
		if(CB:cleft < 2)
			usr << "\red There's not enough of cable in your coil (you need at least 2 left)!"
		else
			usr << "\blue You wire up your generator"
			new /obj/item/weapon/gun/plasma(usr.loc)
			spawn(0)
				CB:cminus(2)
				spawn(0) del(src)
/obj/item/electronics/tarplasm_double
	silicon_need = 3
	metal_need = 3
	plastic_need = 4
	size = 4
	dmg = 11
	parry = 5
	market_price = 300
	name = "targeted dual plasma generator"
	icon_state = "tarplasm_double"
	desc = "It looks unfinished, yet serious as hell"
/obj/item/electronics/tarplasm_double
/obj/item/electronics/tarplasm_double/attack_by(obj/I)
	if(istype(I, /obj/item/cable))
		var/CB = I
		if(CB:cleft < 3)
			usr << "\red There's not enough of cable in your coil (you need at least 3 left)!"
		else
			usr << "\blue You wire up your generator. Now they'll know what fear is"
			new /obj/item/weapon/gun/plasma/hardcore(usr.loc)
			spawn(0)
				CB:cminus(3)
				spawn(0) del(src)

/obj/item/electronics/tantric
	market_price = 25
	plastic_need = 3
	name = "tantric assembly"
	icon_state = "tantric"
	desc = "A mysterious device used in a central euphoria-based constructions."

/obj/item/electronics/tantric

/obj/item/electronics/tantric/attack_by(obj/I)



	if(istype(I, /obj/item/tool/screwdriver))
		usr << "\blue You fuck with tantric assembly a bit. Now you can stick it in your drug-infested brain."
		new /obj/item/device/brainport/tantric(usr.loc)
		spawn(0) del(src)


/obj/item/electronics/xom
	market_price = 150
	plastic_need = 2
	silicon_need = 2
	market_price = 250
	name = "demonic device"
	desc = "This thing is connected to some unknown demon... somehow"
	icon_state = "xom"
/obj/item/electronics/xom

/obj/item/electronics/xom/attack_self()












	usr << "\bold You hear a voice in your head:"
	usr << "\blue \bold Hello, hilarious manthing. Please connect me to some tantric crap so we can do... wonders."
	if(prob(50))
		usr.stun(12)
		usr.euphoria += 40

/obj/item/electronics/xom/attack(obj/I)
	if(istype(I, /obj/item/electronics/tantric))
		usr << "\bold You hear a voice in your head:"
		usr << "\blue \bold OH HAI! Sorry, but this tantric thing looks a bit... unfinished."
	else
		if(istype(I, /obj/item/device/brainport/tantric))
			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold OH YEAAAAA! You're a smart boy. This thing is just what we needed."
			new /obj/item/electronics/xom_finished(usr.loc)
			spawn(0)
				usr.delitem()
				del(src)

/obj/item/electronics/xom_finished
	market_price = 300
	plastic_need = 4
	wood_need = 2
	silicon_need = 2
	name = "finished demonic device"
	desc = "This device is strictly connected to a demon which calls itself Xom. Or Zom. Or Zom. Or Xomey. Or sometime Chaos, Kaos, Haos or Khaos. Anyway, use this piece of electronics at your own risk."
	icon_state = "xom2"

/obj/item/electronics/xom_finished
/obj/item/electronics/xom_finished/attack_self()
	if(world.time - usr.xom_last_used < 150)
		usr << "\red You're using this thing too frequently!"
		usr.stun(2)
		return

	usr.xom_last_used = world.time

	usr << "\bold You hear a voice in your head:"
	usr << "\blue \bold Hello, my hilarious friend! I hope what you're ready to have some fun, because we're gonna full hilarious now!"
	var/match = rand(1, 19)
	usr.euphoria += 33
	switch(match)
		if(1)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold Let's go for some bluespace hops, yeah!"
			usr.blink(3)
			spawn(20)
				usr.blink(4)
				spawn(20)
					usr.blink(5)
		if(2)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold Let's go high. I like weed so you should too get used to it."
			usr.add_chem("THC", "THC", 3.5, 0)
			usr.add_chem("CBD", "CBD", 4, 0)
		if(3)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold Whoops, looks like my pet tentacles got loose."

			for(var/turf/TR in range(7, usr))
				if(prob(11) && (TR.density && !TR.hastent))
					for(var/turf/TF in range(1, TR))
						if(!TF.density)
							if(TF.x < TR.x && TF.y == TR.y)
								var/T = new /obj/tentacle(TF)
								T:dir = 8
								T:loc = locate(TR.x - 1, TR.y, TR.z)
								TR.hastent = 1
							if(TF.x > TR.x && TF.y == TR.y)
								var/T = new /obj/tentacle(TF)
								T:dir = 4
								T:loc = locate(TR.x + 1, TR.y, TR.z)
								TR.hastent = 1
							if(TF.x == TR.x && TF.y > TR.y)
								var/T = new /obj/tentacle(TF)
								T:dir = 1
								T:loc = locate(TR.x, TR.y + 1, TR.z)
								TR.hastent = 1
							if(TF.x == TR.x && TF.y < TR.y)
								var/T = new /obj/tentacle(TF)
								T:dir = 2
								T:loc = locate(TR.x, TR.y - 1, TR.z)
								TR.hastent = 1
		if(4)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold I just bought a new butterfly knife and need somebody to test it on. Sorry, dude, but you're the closest one test subject."
			if(usr.hepe >= 50)
				usr.damaga(25, "brute")
			else if(usr.hepe >= 20)
				usr.damaga(10, "brute")
			else
				usr.damaga(5, "brute")
			if(prob(25))
				usr.wound()
		if(5)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold The world is so shiiiiiiiiiiiiiiny!"
			usr.add_chem("25i-NBOMe", "25i-NBOMe", 7.1, 0)
			new /obj/item/diamond(usr.loc)
		if(6)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold sery but im ddddddrunk a bit. wana havb a drink too??"
			usr.add_chem("ethanol", "ethanol", 7, 0)
		if(7)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold Do you like floors? I don't. Fuck floors!"
			for(var/turf/T in orange(8, usr))
				if((istype(T, /turf/floor) || (istype(T, /turf/ground) || istype(T, /turf/abyss))) && (!istype(T, /turf/floor/start) && prob(25)))
					T.spacize()
		if(8)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold Do you like walls or those solid things in spatial pockets? I don't. Fuck walls!"
			for(var/turf/T in orange(8, usr))
				if(T.density && (!istype(T, /turf/rock/edge) && prob(25)))
					T.spacize()
		if(9)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold Lol, you're in a terrarium now."
			for(var/turf/T in orange(1, usr))
				if(!T.density && T != usr.loc)
					for(var/obj/structure/window/W in T)
						del(W)
					spawn(0) new /obj/structure/window(T)
		if(10)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold Lol, you're in a cage now."
			for(var/turf/T in range(1, usr))
				if(!T.density && T != usr.loc)
					for(var/obj/structure/reinforcement/weak/W in T)
						del(W)
					spawn(0) new /obj/structure/reinforcement/weak(T)
		if(11)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold Here's a young cozy amoeba. Yep, healing one, not the one who corrodes walls and tries to murder you. Be good to her."
			new /obj/bio/amoeba/regen/small(usr.loc)
		if(12)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold You're now addicted to benzos a bit, he-he-he. I'm kind today so take this blister of glucose. It will help a bit."
			usr.benzo = 145
			new /obj/item/blister/glucose(usr.loc)
		if(13)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold You know what I think 'bout doors? Fuck them!"
			for(var/obj/door/D in range(10, usr))
				D.fuckup()
		if(14)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold How about invite some guests from our bluespace sleeve?"
			weedstart()
			invasion()
			spawn(35)
				invasion()
				spawn(35)
					invasion()
					spawn(35)
						worldputin()
						if(prob(10))
							spawn(40)
								popobawa()
		if(15)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold I have a hopes for you so Stalin... loaned this golem to me. Well-well-well, I just stole it, don't look at me with such a view! However, now go and fight like a man."
			for(var/turf/T in range(3, usr))
				if(!T.density && !(T in range(1, usr)))
					new /mob/stalin/veteran(T)
					return
		if(16)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold Here. Just take  it."
			new /obj/item/weapon/battleaxe(usr.loc)
			new /obj/item/blister/regenerite(usr.loc)
		if(17)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold Well, I need some of your blood so I will suck it out. Take this as a payment if you want."
			usr.damaga(33, "organ")
			new /obj/item/reagent_container/consumable/pill/luckstone(usr.loc)
		if(18)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold Yea, I like to let free bluespace pests. You will survive, aren't you?"
			for(var/turf/T in range(6, usr))
				if(!(T in range(4, usr)))
					if(prob(40))
						new /obj/bio/amoeba(T)
					if(prob(10))
						new /obj/bio/amoeba/chaos(T)
		if(19)

			usr << "\bold You hear a voice in your head:"
			usr << "\blue \bold Good news: you're now a homo and can fuck even straight people (stunned ones, of course). Bad news: I grant you with some weird mutation."
			usr.maggot = 1
			usr:grapist = 1
			usr.mutating("hui")

	if((usr.hepe <= 25 || usr.wounds >= 3) && prob(33))
		usr << "\bold You hear a voice in your head:"
		usr << "\blue \bold I have some bandages, regenerite, mangadote and fibgen for you. Take it. Yeah, I'm a good folk."
		usr.heal(2, "burn")
		usr.heal(2, "brute")
		usr.heal(2, "organ")
		usr.add_chem("regenerite", "regenerite", 6.5, 0)
		usr.add_chem("fibgenerite", "fibgenerite", 5, 0)
		usr.add_chem("mangadote", "mangadote", 5, 0)
		if(usr.wounds)
			usr.woundcure(usr.wounds)
/obj/item/device
	icon = 'grafon/item/electronics.dmi'
/obj/item/device/brainport
	icon = 'grafon/device.dmi'
/obj/item/device/brainport/tantric
	plastic_need = 4
	silicon_need = 2
	icon_state = "tantric"
	name = "tantric brain module"
	desc = "This thing makes you run faster and hit harder, but rapidly drains your euphoria. Also, you have an urge to stuck some kind of crystal in it for some weird reason."
/obj/item/device/brainport/tantric/attack_by(obj/I)
	if(istype(I, /obj/item/electronics/synthstone))
		usr << "\blue You fuck with tantric brainport a bit. It still looks somewhat unfinished due to its small value or something."
		new /obj/item/electronics/spreader_unfinished(usr.loc)
		spawn(0)
			del(I)
			usr.delitem()
	..()

/obj/item/electronics/synthstone/attack_by(obj/I)
	if(istype(I, /obj/item/device/brainport/tantric))
		usr << "\blue You fuck with tantric brainport a bit. It still looks somewhat unfinished due to its small value or something."
		new /obj/item/electronics/spreader_unfinished(usr.loc)
		spawn(0)
			del(I)
			usr.delitem()
	..()

/obj/item/electronics/spreader_unfinished
	silicon_need = 1
	plastic_need = 2
	name = "Unfinished amoeba spreader"
	desc = "An amoeba spreader with too small value to work."
	icon_state = "amoeba_unfin"
/obj/item/electronics/spreader_unfinished
/obj/item/electronics/spreader_unfinished/attack_by(obj/I)
	if(istype(I, /obj/item/gas/tank))
		var/T = I
		if(T:cl > 0 || (T:tox > 0 || (T:smk > 0 || T:fuel > 0)))
			usr << "\red It is full of toxins! Empty it first!"
			return
		else if(T:anti >= 5 || T:regen >= 5)
			new /obj/item/electronics/amoeba(usr.loc)
			new /obj/item/amoebacore/regen(usr.loc)
		else
			new /obj/item/electronics/amoeba(usr.loc)
		spawn(0)
			del(I)
			del(src)


/obj/item/electronics/jetbike
	size = 3
	plastic_need = 5
	metal_need = 5
	name = "Jetbike assembly"
	desc = "Just stuck it into some machinery frame and go for the ride!"
	icon_state = "bike"
/obj/item/electronics/jetbike
/obj/item/electronics/jetbike_unwired
	size = 3
	plastic_need = 3
	metal_need = 3
	name = "Jetbike assembly (unfinished)"
	desc = "It looks unwired."
	icon_state = "bike_nowire"
/obj/item/electronics/jetbike_unwired
/obj/item/electronics/jetbike_unwired/attack_by(atom/I)
	if(istype(I, /obj/item/cable))
		usr << "\blue You wire your assembly."
		var/W = I
		W:cminus(1)
		new /obj/item/electronics/jetbike_unpowered(usr.loc)
		spawn(0)
			del(src)
/obj/item/electronics/jetbike_unpowered
	size = 3
	plastic_need = 4
	metal_need = 3
	name = "Jetbike assembly (no power!)"
	desc = "It looks unpowered. Use some tantric shit or something."
	icon_state = "bike_nopower"
/obj/item/electronics/jetbike_unpowered
/obj/item/electronics/jetbike_unpowered/attack_by(atom/I)
	if(istype(I, /obj/item/device/brainport/tantric) || istype(I, /obj/item/electronics/tantric))
		usr << "You connected some kind of tantric stuff to finish your jetbike electronics"
		new /obj/item/electronics/jetbike(usr.loc)
		spawn(0)
			del(I)
			del(src)
/obj/item/material/sheet
/obj/item/material/sheet/attack_by(atom/I)
	if(istype(I, /obj/item/device/jet) || istype(I, /obj/item/caboutlet))
		usr << "You connected some kind of engine to the sheet material, then form it into... something."
		new /obj/item/electronics/jetbike_unwired(usr.loc)
		src.changecharge(-1)
		spawn(0)
			del(I)
		..()
/obj/item/material/sheet{dmg = 8; accu = 40; sharp = 1; stackable = 1; maxstack = 25; name = "Metal sheet"; desc = "sheets of steel. Its edges are sharp, but I doubt that you can make a good weapon of it: better use it for engineering purposes."; icon_state = "sheet"};/obj/item/material/plastic{dmg = 8; accu = 40; stackable = 1; maxstack = 25; name = "Plastic sheet"; desc = "sheets of high-density plastic material."; icon_state = "psheet"};/obj/item/material/plastic/prespawned{charges = 10; name = "Plastic sheet"};/obj/item/material/plastic/fromgas{charges = 5; name = "Plastic sheet"};/obj/item/material/plastic/order{charges = 20; name = "Plastic sheet"}
/obj/item/material/plastic/attack_by(atom/I)
	if(istype(I, /obj/item/device/jet) || istype(I, /obj/item/caboutlet))
		usr << "You connected some kind of engine to the sheet material, then form it into... something."
		new /obj/item/electronics/jetbike_unwired(usr.loc)
		src.changecharge(-1)
		spawn(0)
			del(I)
		..()

/obj/item/device/red_mercury
	icon = null /*icon id 35: unresolved*/
	icon = 'grafon/item.dmi'
	name = "red mercury antennae"
	icon_state = "red_mercury"
	desc = "A mysterious device with unpredictable effects both on electronics and people's brains."

/obj/item/device/red_mercury

/obj/item/device/red_mercury/attack_self()
	usr << "\blue You wave your antennae around."

	if(prob(33))
		usr << "\red \bold The antennae blows up in your hands!"
		src.explosion(0)
		spawn(0)
			if(src)
				del(src)
			return

	for(var/mob/M in range(world.view, usr))
		if("chromosome" in M.mutations)
			M << "\blue You feel ticklish a bit. And you surely don't know why everybody around is so worried."
		else if(M:clothes:nopsi)
			M << "\blue Something is trying to [reverse_text("epar")] your mind, but you're protected against stuff like this."
		else if(prob(50))
			M << "\red You see a fuckload of horrible visages dancing around you."
			if(M.calm >= 10)
				M.calm -= 20
			else
				M.calm -= 15
			M.euphoria -= 10
			if(prob(66))
				M.thrill += 4
			M.stun(rand(2, 5))
		else
			M << "\red There's a voice in your head!"
			M << "\green It tells you pleasant things."
			M << "\green \bold Feels good man."
			M.calm += 5
			M.euphoria += 70

	for(var/obj/comp/C in range(world.view, usr))
		C.turnoff()

	for(var/obj/wire/C in range(2, usr))
		C.melt()
