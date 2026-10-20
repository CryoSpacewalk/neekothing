/obj/machine/drug
/obj/machine/drug
/obj/machine/ritualistic
	icon = 'grafon/cult.dmi'
	name = "Ritualistic Machinery"
	desc = "A weird part of machinery, based on some colonized planet alien chamanistic rituals. It uses electric power and a drop of your blood just to TRY to start a ritual. Oh, and it is radioactive so use some hazmats. Sometimes it will also damage your mind, so be careful."
	icon_state = "machinery"
/obj/machine/ritualistic/operate()
	attack_hand()

/obj/machine/ritualistic/attack_hand()

	if(!usr.candofun)
		usr << "\red No, you can't use spellcodes."
		return

	for(var/obj/wire/battery/B in src.loc)
		if(!B)
			usr << "\red \bold There's no power outlet under it!"
			return
		else if(B.energy < 3)
			usr << "\red It is either out of power or too power-dry for The Machinery!"
			return
		else
			B.energy -= 3

	spawn(0)

		usr.damaga(1, "organ")
		usr << "\blue The Machinery sucks a drop of your blood. Now you can try to use some ritual."
		var/ritname = ""
		ritname = input("", "please, input the ritual spellcode", ritname)

		spawn(0)

			var/mkaay = 0
			for(var/obj/machine/op_frame/OFR in range(1, usr))
				if(OFR)
					mkaay = 1
			sleep(0)
			if((usr in range(1, src)) || mkaay)
				src.harm()
				for(var/datum/ritual/R in machinae_rituals)
					if(R.codename == ritname)
						usr << "\red \bold [R.mesaga]"
						if(prob(25 - usr.energyprotect))
							usr << "\n The contact with the pure magic damages your serotonin flow."
							usr:chronodepr++
						if(prob(33 - usr.energyprotect / 2))
							usr << "\n The contact with the pure magic does weird things to your bloodflow."
							usr.add_chem("4-AcO-DMT", "4-AcO-DMT", 0.88, 0)
						if(prob(50 - usr.energyprotect * 2.5))
							usr << "\n The contact with the pure magic fills you with thrill."
							if(usr.thrill >= 10)
								usr.thrill += 5
							else
								usr.thrill = 10
						R.effect(src, usr)


/obj/machine/ritualistic/proc/harm(rangy)





	for(var/mob/M in range(rangy, src))
		if(M.mat == "flesh")
			if(M.energyprotect < 10 && M.hepe > 0)
				M << "\red You feel a bit nervous..."
				M.damaga(10 - M.energyprotect, "burn")

				if(prob(M.epilepsy * 3) && M in viewers(src))
					M.seizure(5)

				if(M.energyprotect < 10 && prob(33))
					M << "\red The world is so blurry..."
					M.epilepsy += 4
		else
			if(!istype(M, /mob/ghost))
				M << "\red You feel a bit nervous..."
				M.damaga(80, "burn")

	for(var/obj/putin/P in range(rangy, src))
		P.biodmg(20)

	for(var/obj/putin_big/P in range(rangy, src))
		P.biodmg(50)

	for(var/obj/bio/amoeba/A in range(rangy, src))
		A.biodmg(20)

	for(var/obj/bio/weed/W in range(rangy, src))
		W.grassdmg(50)
/datum/chemcolor
	var/rid = "your mom"
	var/r = 255
	var/g = 255
	var/b = 255
/datum/chemcolor
/datum/on_iv
	var/rid = "nothing to see here, folks"
/datum/on_iv
/datum/r_taste
/datum/r_taste
/datum/spell
	var/spl = "AAAA"
	var/name = "your mom"
/datum/baryga
/datum/tovar
/datum/marketname
	var/name
/datum/goodlist
	var/glist
/datum/mutation
	var/mid = "gayporn"
	var/olay
/datum/ritual
	var/codename = "nothing"
	var/mesaga = "IT IS BROKEN"
/datum/ritual/proc/effect(obj/O, mob/user)
	return
/datum/ritual/tele
	codename = "alii ianuae magicae"
	mesaga = "The Machinae channels some magic and transfers nearest creatures to the local 'start point'."
/datum/ritual/tele
/datum/ritual/tele/effect(obj/O)
	for(var/mob/M in range(8, O))
		for(var/turf/floor/start/S in world)
			M.loc = S

/datum/ritual/corrupt
	codename = "abysso corrupta"
	mesaga = "The Machinae channels some magic and transfers some exotic matter from the unformed parts of universe there."
/datum/ritual/corrupt
/datum/ritual/corrupt/effect(obj/O)
	for(var/turf/T in range(15, O))
		if(!T.density)
			if(!(T in range(4, src)) && prob(2))
				T.abyss_corrupt(1)

/datum/ritual/muta
	codename = "corruptio corporis"
	mesaga = "The Machinae channels some magic and heals your body, but changes it as well."

/datum/ritual/muta


/datum/ritual/muta/effect(obj/O, mob/user)


	user:heal(100, "brute")
	user:heal(100, "burn")
	user:heal(100, "organ")
	if(user:wounds)
		user:woundcure(user:wounds)
	user:add_chem("mangadote", 7, 0)
	user:randommut()
/datum/ritual/wound
	codename = "vulnus sanitatem"
	mesaga = "The Machinae channels some magic and heals your bleeding wounds."
/datum/ritual/wound
/datum/ritual/wound/effect(obj/O, mob/user)
	if(user:wounds)
		user:woundcure(user:wounds)
	if(user:hunger > 50)
		user:hunger -= 50
	else
		user:hunger = 0
/datum/ritual/hunger
	codename = "salutem de fame"
	mesaga = "The Machinae channels some magic and feels you with nutrious substances, but causes you a light epilepsy."
/datum/ritual/hunger
/datum/ritual/hunger/effect(obj/O, mob/user)
	user:add_chem("nutriment", 10, 0)
	user:epilepsy++
/datum/ritual/exorcismo
	codename = "exorcismo"
	mesaga = "The Machinae channels some magic and banishes all of the 'spirits' around."
/datum/ritual/exorcismo
/datum/ritual/exorcismo/effect(obj/O, mob/user)
	for(var/mob/ghost/G in range(20, O))
		G << "\red \bold You're banished to the Hell!"
		ghostcount++
		G.show_message("\red \bold [G.name] is banished!")
		spawn(1)
			G.z = 2
			sleep(0)
			G.x = 5
			sleep(0)
			G.y = 5
/datum/ritual/burn
	codename = "corpus incineratio"
	mesaga = "The Machinae channels some magic and starts to burn the skin of living creatures."
/datum/ritual/burn
/datum/ritual/burn/effect(obj/O)
	for(var/mob/M in world)
		if(M.mat == "flesh")
			M << "\red \bold You feel like something wicked is channeling magic through your body."
			M.damaga(66, "burn")
/datum/ritual/weed
	codename = "et herbis"
	mesaga = "The Machinae channels some magic and transfers some herbs to your body."
/datum/ritual/weed
/datum/ritual/weed/effect(obj/O, mob/user)
	user:add_chem("hash oil", "hash oil", 15, 0)
	user:add_chem("CBD", "CBD", 5, 0)
	user:add_chem("THC", "THC", 3, 0)
/datum/ritual/embody
	codename = "per vim Spiritus"
	mesaga = "The Machinae channels some magic and takes a bit of exotic matter to gift local pseudo-ghosts and so-called 'observers' with some mutilated, but at least material human bodies"
/datum/ritual/embody
/datum/ritual/embody/effect(obj/O, mob/user)
	if(prob(33))
		user << "\red Ouch! Something smites you!"
		user:damaga(15, "brute")
	if(prob(33))
		user << "\red \bold OUCH! Something invisible cuts you! It hurts and bleeds!"
		user:wound(1)
	for(var/mob/ghost/g_host in world)
		if(g_host.z == O:z && g_host.type != /mob/ghost/wraith)
			var/mob/M = new /mob(g_host.loc)
			if(prob(33))
				M:l_hand = null
				for(var/obj/limb/chunk in M:limbs)
					if(chunk.name == "l_hand")
						M:limbs -= chunk
						M:update_sprite()
			else if(prob(50))
				for(var/obj/limb/chunk in M:limbs)
					if(chunk.name == "l_leg")
						M:limbs -= chunk
						M:update_sprite()
			else
				for(var/obj/limb/chunk in M:limbs)
					if(chunk.name == "r_leg")
						M:limbs -= chunk
						M:update_sprite()
				sleep(0)



			M:ckey = g_host.ckey
			M:realkey = g_host.realkey
			M:realname = "Nameless Homunculus"
			M:name = "Nameless Homunculus"
			M:toxdmg()
			M:spacedmg()
			M:adv_visuals()
			sleep(0)
			M:randommut()
			M << "\blue \italic Where am I? What is all those weird rememberances of previous life, be they real or not? Who or WHAT the fuck am I?"
			spawn(0) del(g_host)
/datum/ritual/anima
	codename = "anima libera"
	mesaga = "The Machinae channels some magic and fills everything around with life."
/datum/ritual/anima
/datum/ritual/anima/effect(obj/O, mob/user)
	for(var/turf/T in range(40, O))
		if(prob(10) && !T.density)
			new /obj/bio/pogankah(T)
	sleep(0)
	for(var/turf/T in range(40, O))
		if(prob(2) && !T.density)
			new /obj/bio/pogankah/psilo(T)
	sleep(0)
	for(var/turf/T in range(40, O))
		if(prob(2) && !T.density)
			new /obj/bio/pogankah/killer(T)
	sleep(0)
	for(var/turf/T in range(40, O))
		if(prob(2) && !T.density)
			new /obj/bio/pogankah/regeneshroom(T)
	sleep(0)
	for(var/turf/T in range(40, O))
		if(prob(5) && !T.density)
			new /obj/furniture/towercap(T)
	sleep(0)
	for(var/turf/T in range(40, O))
		if(prob(2) && !T.density)
			new /obj/bio/toad(T)
	sleep(0)
	for(var/turf/T in range(40, O))
		if(prob(20) && !T.density)
			new /obj/item/reagent_container/consumable/worm(T)
	sleep(0)
	for(var/turf/T in range(40, O))
		if(prob(2) && !T.density)
			new /obj/bio/amoeba(T)
	sleep(0)
	for(var/turf/T in range(40, O))
		if(prob(3) && !T.density)
			new /obj/item/reagent_container/consumable/plant/bud(T)
	sleep(0)
	for(var/turf/T in range(40, O))
		if(prob(4) && !T.density)
			new /obj/bio/cucumber(T)
	sleep(0)
	for(var/turf/T in range(40, O))
		if(prob(1) && !T.density)
			new /obj/item/reagent_container/consumable/plant/salvia(T)
	sleep(0)
	for(var/turf/T in range(40, O))
		if(prob(2) && !T.density)
			new /obj/tentacle(T)
/datum/ritual/mutarad
	codename = "dura lux"
	mesaga = "The Machinae channels some magic and causes mutagenic radiation to flow all around the station complex."
/datum/ritual/mutarad
/datum/ritual/mutarad/effect(obj/O, mob/user)
	mutarad()
	sleep(0)
	mutarad()
	sleep(0)
	mutarad()

/datum/ritual/om
	codename = "om mani padme hum"
	mesaga = "The Machinae channels some power through one of the Buddah,fills you with power and heals your wounds."

/datum/ritual/om


/datum/ritual/om/effect(obj/O, mob/user)
	user:heal(25, "burn")
	user:heal(25, "brute")
	user:heal(25, "organ")
	if(user:wounds)
		user:woundcure(user:wounds)
	user:verbs += new /mob/verb/overdrive()
/datum/ritual/krishna
	codename = "hare krishna hare krishna krishna hare krishna hare hare rama hare rama rama hare rama hare"
	mesaga = "The Machinae channels some power through one of the 'demons', cures your mutations and heals some of your wounds."
/datum/ritual/krishna
/datum/ritual/krishna/effect(obj/O, mob/user)
	user:heal(15, "burn")
	user:heal(15, "brute")
	user:heal(15, "organ")
	if(user:wounds)
		user:woundcure(1)
	spawn(30)
		user << "\blue Your body looks somewhat more normal now."
		user:curemut()
		spawn(30)
			user << "\blue \bold Your body looks even more normal now!"
			user:curemut()
/datum/ritual/shiva
	codename = "om namah shivaya"
	mesaga = "The Machinae channels some power through one of the 'demons', making you stronger and curing your of bleeding and one of the mutations."
/datum/ritual/shiva
/datum/ritual/shiva/effect(obj/O, mob/user)
	user:heal(10, "brute")
	if(user:wounds)
		user:woundcure(user:wounds)
	user:verbs += new /mob/proc/roundhouse_kick()
	spawn(30)
		user << "\blue Your body looks somewhat more normal now."
