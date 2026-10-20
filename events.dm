// Recovered from compiled neek.dmb (13 procs)

var/ebreak = 0
/proc/eventselect()


	economical_events()

	if(prob(50))
		solarflare()
	if(prob(15))
		cult_knowledge()
	if(prob(1))
		mutarad()

	if(prob(25))
		if(prob(2))
			towercap()
		if(prob(1))
			weedstart()
		if(prob(1.5))
			invasion_mild()

		if(prob(0.5))
			invasion()
		if(prob(1.5))
			worldhaunt()
		if(prob(2))
			invasion_veter()
		if(prob(1))
			worldputin()

	if(prob(3))
		if(prob(10))
			popobawa()




	if(prob(33))
		for(var/mob/M in world)
			var/lonely = 1
			for(var/mob/MB in view(src))
				if(MB)
					lonely = 0
			if(lonely)
				M << pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav')


	spawn(0)
		if(ebreak == 0)
			spawn(600) eventselect()
		else
			world << "Meanwhile one of the admins has disabled event loop."

/proc/solarflare()


	for(var/obj/machine/solar/S in world)
		for(var/turf/space/T in view(2, S))
			S.feed(50)
	for(var/mob/M in world)
		var/noflare = 0
		if(prob(M.epilepsy * 2))
			if(prob(M.energyprotect * 10))
				M << "\blue You feel protected from solar flare."
			else
				M << "\red Looks like there's a solar flare somewhere in space. Your epilepsy takes its toll."
				M.seizure(6)
		var/blind = 0
		for(var/turf/space/T in view(2, M))
			if(T)
				if(M.clothes)
					if(M:clothes:hide_face)
						M << "\blue Your gear protects you from solar flare."
						noflare = 1
				blind = 1
		if(M.mat == "flesh" && (blind && !noflare))
			M << "\red The solar flare blinds you!"
			M.blind(45)
			if(prob(50))
				M << "\red You feel fucking blurry."
				M.epilepsy += 5
			if("eye0" in (M.mutations || "tumor_eye") in M.mutations)
				M << "\red \bold Your mutation-grown eyes hurt!"
				M.damaga(2, pick("burn", "organ"))
				if(prob(50))
					M.torment(3)
			if("eye1" in M.mutations)
				M << "\red \bold Your mutation-grown eyes hurt a lot!"
				M.damaga(8, pick("burn", "organ"))
				M.torment(4)
		else if(blind)
			M << "\blue You feel a strong solar flare in the depths of space. Good thing you can't get blinded."

/proc/cult_knowledge()
	for(var/mob/M in world)
		if(M.dead == 0 && (M.cult == 1 && prob(25)))
			M.knowledge_roulette()

/proc/weedstart()
	var/weedpoints = list()
	for(var/obj/bio/weedstart/W in world)
		weedpoints += W
	if(weedpoints:len)
		var/WS = weedpoints[rand(1, weedpoints:len)]
		spawn(0) new /obj/bio/weed(WS:loc)
	spawn(30) station_alert("Blade weed seeds invasion has been expected on board of your station after some scan. We afraid what they've already grown up somewhere aboard.")

/proc/invasion()
	var/spawnpoints = list()
	for(var/obj/bio/amoebaspawn/A in world)
		spawnpoints += A
	if(spawnpoints:len)
		var/AS = spawnpoints[rand(1, spawnpoints:len)]
		var/aamount = rand(4, 6)
		spawn(0)
			for(var/i = 0, i < aamount, i++)
				if(prob(33))
					new /obj/bio/amoeba(AS:loc)
				else if(prob(50))
					new /obj/bio/amoeba/acid(AS:loc)
				else if(prob(33))
					new /obj/bio/amoeba/chaos(AS:loc)
				else
					new /obj/bio/amoeba/chaos(AS:loc)
	spawn(30) station_alert("A danger of invasion of giant mono-cellular animals has reached your station. We advice you to found and annihilate those creatures, but be careful: some of them may be mutated in a dangerous way!")

/proc/invasion_mild()
	var/spawnpoints = list()
	for(var/obj/bio/amoebaspawn/A in world)
		spawnpoints += A
	if(spawnpoints:len)
		var/AS = spawnpoints[rand(1, spawnpoints:len)]
		var/aamount = rand(3, 5)
		spawn(0)
			for(var/i = 0, i < aamount, i++)
				new /obj/bio/amoeba(AS:loc)
	spawn(30) station_alert("A danger of invasion of giant mono-cellular animals has reached your station. We advice you to found and annihilate those creatures.")

/proc/worldhaunt()




	for(var/obj/landmark/haunt/H in world)
		if(prob(80))
			new /mob/ghost/wraith(H.loc)
	spawn(50) station_alert("Paranormal activity has been detected on board of your station complex. Please contact local purificator as soon as possible.")

/proc/popobawa()
	for(var/obj/landmark/popo/P in world)
		new /mob/popobava(P.loc)
	spawn(30) station_alert("Demonic 'visit' has been detected on board of your station complex. Please contact local purificator as soon as possible.")

/proc/worldputin()








	var/L = list()
	for(var/obj/landmark/putin/P in world)
		L += P
	var/sotka = pick(L)
	new /obj/putin(sotka:loc)
	for(var/obj/landmark/putin/P in world)
		if(prob(5) && P != sotka)
			new /obj/putin_big(P.loc)
	spawn(30) station_alert("Possibility of mnogohodovochkas infection on your station is extremely high. Please contact local purificator as soon as possible.")

/proc/station_alert(msg as text)










	for(var/obj/radio/R in world)
		R.buzz(msg)
	for(var/obj/comp/alert/A in world)
		A.add_message(msg)
		spawn(20)
			if(A.on)
				A.playsound('sounds/electro.wav')
				for(var/mob/M in hearers(A))
					if(!M.sleeps)
						M << "\blue [A] beeps:"
						M << "\blue New message received."

/proc/mutarad()
	station_alert("A wave of mutagenic radiation expected to flow over the complex just in few seconds. Please, stay out of outer windows or open space.")
	spawn(100)
		for(var/obj/machine/solar/S in world)
			for(var/turf/space/T in view(2, S))
				S.feed(20)
		for(var/mob/M in world)

			if(!M.energyprotect)
				M.radtox += 5

			if(prob(M.epilepsy * 2))
				if(prob(M.energyprotect * 10))
					M << "\blue You feel protected from solar flare."
				else
					M << "\red Looks like there's a solar flare somewhere in space. Your epilepsy takes its toll."
					M.seizure(6)
			var/blind = 0
			for(var/turf/space/T in view(2, M))
				if(T)
					new /obj/effect/rad(T)
				blind = 1
			if(blind)
				M << "\blue Those lights in the space void looks so weird."
				if(prob(100 - M.energyprotect * 8))
					if(("eye0" in M.mutations || "tumor_eye") in M.mutations)
						M << "\red \bold Your mutation-grown eyes hurt!"
						M.damaga(2, pick("burn", "organ"))
						if(prob(50))
							M.torment(3)
					if("eye1" in M.mutations)
						M << "\red \bold Your mutation-grown eyes hurt a lot!"
						M.damaga(8, pick("burn", "organ"))
						M.torment(4)
					if(M.mat == "flesh" && (M.class == "man" && prob(66)))
						spawn(3) M.randommut()
					M.radtox += 10
					sleep(50)
					if(M.mat == "flesh" && (M.class == "man" && prob(10 + M.radtox)))
						M.randommut()

/proc/towercap()
	for(var/obj/bio/shroomspawn/SS in world)
		if(prob(66))
			new /obj/furniture/towercap(SS.loc)
	spawn(30) station_alert("Tower cap spores invasion has been expected on board of your station after some scan. Use any axes, hydraulic cutters, robotic saws or chainsaws to get rid of them.")

/proc/invasion_veter()
	var/spawnpoints = list()
	var/spawnpoints_active = list()
	for(var/obj/landmark/veterspawn/VS in world)
		spawnpoints += VS
	if(spawnpoints:len)
		var/sp_amount = rand(2, 7)
		spawn(0)
			for(var/i = 0, i < sp_amount, i++)
				spawnpoints_active += pick(spawnpoints)
	sleep(1)
	if(spawnpoints_active:len)
		for(var/obj/landmark/veterspawn/V_spawn in spawnpoints_active)
			new /mob/stalin/veteran(V_spawn.loc)
	for(var/mob/M in world)
		if(M.prof == "purificator")
			M << "\red \bold That's it: something is besieging a Baikonur-5 telecab!"
	spawn(30) station_alert("We've detected a pack of wild veterans at the Baikonur-5. Contact purificator as soon as possible.")
