/obj/machine/fabricator
/obj/machine/elecscan{density = 1; name = "Electronics scanner"; icon_state = "elecscanner"; desc = "A machine for analyzing some kinds of electronics by deconstructing them."; var/thing}
/obj/machine/rejuvenator
/obj/machine/polydeus{density = 1; var/A; var/S; icon_state = "polydeus"; name = "PolyDeus"; desc = "A fucked-up part of machinery used for modding amoeba containers by injecting it with chemicals. It feeds on your madness, so you should get batshit on drugs before using it."}
/obj/machine/viral_comp
/obj/machine/bebeekalkah
/obj/machine/amoebaengine{name = "Amoeba-fueled engine"; desc = "This thing uses both amoeba core spirit and biomaterial to fuel your wires."; icon_state = "amoebaengine"}
/obj/machine/teleminer{layer = 2.1; name = "Teleminer"; icon_state = "telemine"; desc = "This thing allows you to deploy mines without even entering the minefield!"}
/obj/machine/op_frame{name = "U.R.M.O.M."; icon_state = "urmom"; alticon = "gurmom"; desc = "Universal Remote Machinery Operation Mainframe, a thing for controlling some kinds of machinery all around the camera-observed station parts. Any manipulation requires the power wired to this machine."}
/obj/machine/op_wirer
/obj/machine/spectrometer{name = "Stationary spectrometer"; icon_state = "spectrometer"}
/obj/machine/dust;/obj/machine/homunculi{density = 1; name = "Dextera Dei"; desc = "This eerie device allows you to grow your very-very own homunculus. While mass-creation of proteine-based robots is quite common all around metagalaxy, creating a sapient humanoid is still on experimental stage even in USSR-4."; icon_state = "homunculi"; var/steel = 0; var/nutriment = 0}
/obj/machine/homunculi/examine()
	usr << "\bold [desc]"
	usr << "\blue [nutriment] pts of nutriment loaded."
	usr << "\blue [steel] pts of metal loaded."

/obj/machine/homunculi/attack_hand()
	src.activate()

/obj/machine/homunculi/verb/act()
	set name = "Try to activate Dextera Dei"
	set src in range(1)
	src.activate()

/obj/machine/homunculi/proc/activate()
	if(!usr.candofun)
		usr << "\red You can't create homunculi, silly observer!"
		return
	usr << "\blue You try to activate your homunculus factory."
	if(nutriment < 50)
		usr << "\red \bold You need at least 50 nutriment to feed up your homunculus."
		return
	if(steel < 20)
		usr << "\red \bold You need at least 20 units of steel to strenghten your homunculus bones."
		return
	for(var/obj/wire/battery/B in src.loc)
		if(!B)
			usr << "\red \italic No power source detected."
			return
		else if(B.energy < 50)
			usr << "\red \italic Current power source is too weak to allow homunculus construction. Try to power it up."
			return
		else
			B.energy -= 50
			usr << "\blue You try to become the modern (or, as I think, postmodern) Prometheus."
			new /obj/effect/sparks(src.loc)
	sleep(0)
	var/L = list()
	var/mob/g_host = null
	for(var/mob/ghost/G in world)
		if(G.client)
			L += G
	sleep(0)
	if(!L:len)
		usr << "\red \bold There's no 'soul' seeking a new body in the complex and nearby dimension pockets. Alas, but we don't know what those 'souls' exactly are and can't produce them."
		return
	else
		g_host = pick(L)
	sleep(0)
	steel -= 20
	nutriment -= 50
	sleep(0)
	var/M = new /mob(src.loc)
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
				spawn(0)
					if(prob(50))
						M:limbs += new /obj/limb/r_leg1()
						M:update_sprite()
	sleep(0)
	for(var/obj/limb/chunk in M:limbs)
		if(chunk.name == "r_hand")
			M:limbs -= chunk
			M:update_sprite()
	spawn(0)
		M:limbs += new /obj/limb/r_hand1()
		M:update_sprite()
	sleep(0)



	M:ckey = g_host:ckey
	M:realkey = g_host:realkey
	M:realname = "Nameless Homunculus"
	M:name = "Nameless Homunculus"
	M:toxdmg()
	M:spacedmg()
	M:adv_visuals()
	sleep(0)
	M:randommut()
	M << "\blue \italic Where am I? Who is this weird man near those horrid machines? Who or WHAT the fuck am I?"
	sleep(0)
	if(prob(50))
		spawn(50)
			M << "\red Your body deforms!"
			M:randommut()
/obj/machine/homunculi/pedal{steel = 228; nutriment = 1488; name = "Dextera Dei"}
/obj/machine/homunculi/attack_by(obj/I)


	if(istype(I, /obj/item/reagent_container/beaker))
		var/B = I
		var/nutri = 0
		for(var/datum/reagent/RE in B:reagent_list)
			if(RE.id == "nutriment")
				nutri = 1
				nutriment += RE:amount
				spawn(0) B:remove_chem(RE.id, RE:amount)

		if(nutri)
			usr << "\blue The greedy machine sucks out all of the nutriment from [I:name]."
		else
			usr << "\red There's no nutriment in your container!"

	if(istype(I, /obj/item/material/sheet))
		var/S = I
		var/howmany = input("How many sheets do you want to load?", "") in list("1", "all")
		if((usr in range(1, src)) && usr.item == I)

			switch(howmany)
				if("1")
					steel += 2
					S:changecharge(-1)
				if("all")
					steel += S:charges * 2
					S:changecharge(-S:charges)
			sleep(0)
			usr << "\blue You feed the machine with steel."
