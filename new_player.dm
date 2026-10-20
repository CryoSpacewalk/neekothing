// Recovered from compiled neek.dmb (13 procs)
/mob/Login()
	..()
	if(src.ckey == "kypa")
		src.kypa = 1
	else
		src.kypa = 0

	src.client.true_view = world.view
	src.reset_hud()
/mob{icon = 'grafon/player.dmi'}
/mob/Logout()
	return

/mob/new_player
	can_move = 0
	spacetravel = 0
	mat = "ether"
	sight = 32
/mob/new_player
/mob/new_player/reset_hud()
	return

/mob/proc/changelog()

	set hidden = 0

	var/changelog_sets = "window=Welcome, damn it!;display=1;\n\tsize=600x700;border=0;can_close=1;\n\tcan_resize=1;can_minimize=0;titlebar=1"

	src << browse(HTML_SKELETON(file2text("changelog.txt")), changelog_sets)



































































var/list/profavaible = list("assistant", "engineer", "security major", "doctor", "researcher", "project director", "chief engineer", "botanist", "chemist", "geologist", "captain", "operator", "cognitologist", "psychiatrist", "purificator", "prosecutor", "Geology robot")
/mob/new_player/Login()

	..()
	spawn(0)
		loc = locate(68, 12, 2)
	changelog()
	src.client << sound('yakui.ogg', wait = 0, channel = 666)
	name = input("Type your name or leave empty for random.", "name:", "")
	if(name == null || (name == "" || name == " "))
		var/firstname = pick("Vovan", "Sergey", "Zuchnewt", "Hop", "George", "Douglas", "Petyan", "Wasiliy", "Khodoque", "Mishanya", "Manya", "Urist", "Geshud", "GEDUSH", "Wasiliti", "Karik", "Ivan", "Yurka", "Adolph", "Syndie")
		var/secondname = pick("Kotov", "Pahomov", "Schetnikov", "Pupkin", "Tritor", "Melons", "Petuhov", "Griferkov", "McRobust", "McLiberal", "McFishDissector", "McMechanic", "McRooster", "McSpessman", "LE MEKANIKUE", "Tibet", "Karlov", "Armstrong", "Gagarin", "Germogenovich")
		name = "[firstname] [secondname]"

	var/profavaible_temp = profavaible

	if((ckey in donat_baryga) && baryga_needed)
		profavaible_temp += "baryga"

	var/profchoice = input("Select your role, plox.", "prof") in profavaible_temp

	var/mutation_choice = null
	if((ckey in donat_mutation) && !(profchoice == "Geology robot"))
		mutation_choice = input("Now select your mutation, if you want any", "prof") in all_mutations

	if((ckey in donat_mule) && !(profchoice == "Geology robot"))
		switch(alert("Do you want to be a drug mule?", , "Yes", "No"))
			if("Yes")
				src.client.mule = 1
			if("No")
				src.client.mule = 0

	if((ckey in donat_forger) && (!(profchoice == "Geology robot") && !src.client.mule))
		switch(alert("Do you want to be a forger?", , "Yes", "No"))
			if("Yes")
				src.client.forger = 1
			if("No")
				src.client.forger = 0

	if(src.client.forger)
		switch(alert("Have you faked your heterosexuality certificate?", , "Yes", "No"))
			if("Yes")
				faggot = 1
			if("No")
				faggot = 0


	sleep(0)
	sleep(0)
	if(profchoice == "project director" || (profchoice == "chief engineer" || (profchoice == "captain" || (profchoice == "operator" || (profchoice == "psychiatrist" || (profchoice == "purificator" || (profchoice == "prosecutor" || profchoice == "Geology robot")))))))
		profavaible.Remove(profchoice)


































	if(traitorism >= 1 && (prob(traitorism * 1.2) && (!src.client.mule && !(profchoice == "baryga"))))

		var/spychka = rand(1, 4)

		if(spychka == 1 && slbrkr_needed)
			profchoice = "slbrkr"
			src.client.forger = 0
			faggot = 0
			slbrkr_needed = 0

		if(spychka == 2 && nukebot_needed)
			profchoice = "robot"
			src.client.forger = 0
			faggot = 0
			nukebot_needed = 0

		if(spychka == 3 && !baryga)
			profchoice = "baryga"
			baryga = 1

		if(spychka == 4 && !baryga)
			if(castlist.len >= 5)
				profchoice = "angel"
				src.client.forger = 0
				faggot = 0
			else
				profchoice = "baryga"
				baryga = 1


	spawn(0)
		switch(profchoice)
			if("No!")
				src << "Yes you are!"
				del(src)
				return
			if(null, "")
				del(src)
				return

	var/headchoice = null
	if(profchoice != "robot")
		if(profchoice == "slbrkr")
			headchoice = "dorf"
		else
			headchoice = input("Select your fucking face.", "head selecting", "young recruit of the psychedelic forces") in list("young recruit of the psychedelic forces", "pass to the panties", "okkupay-narkofilyay", "fake Stalin", "fake Hitler", "dorf", "cannibal hobo", "emoboy", , "punks not dead, they're just too drunk", "competent researcher")

	var/M = new /mob()
	M:realkey = ckey
	M:faggot = faggot
	src.client << sound('null.ogg', wait = 0, channel = 666)

	if(mutation_choice)
		M:mutating(mutation_translation(mutation_choice))

	if(profchoice == "baryga")
		baryga_needed = 0
		faggot = 0
		src.client.mule = 0

	M:initialize_profa(headchoice, profchoice, src)

/mob/proc/initialize_profa(headchoice, profname as text, mob/newplayer)
	src.name = newplayer:name
	src.realname = newplayer:name
	src.moustache = newplayer:moustache
	src.ckey = newplayer:ckey
	src.prof = profname

	del(newplayer)
	src.loc = null
	var/spawnlist = list()
	for(var/obj/start/S in world)
		if(S.name == profname)
			spawnlist += S
	if(spawnlist:len)
		var/S = spawnlist[rand(1, spawnlist:len)]
		src.loc = S:loc


	src.equip_profa(profname)
	src.show_profdesc(profname)
	src.terminal_logs(profname)
	src.add2cast(profname)

	if(client:forger)
		src.equip_forger()

	if(src.client.mule)
		src.equip_mule()


	if(profname == "robot")
		spawn(0) src.robotize()
	else
		if(!(profname == "slbrkr") && (!(profname == "baryga") && (!(profname == "robot") && (!(profname == "angel") && (!(profname == "purificator") && (!(profname == "geology robot") && (!(profname == "prosecutor") && (prob(traitorism + traitorism / 5) && cult_needed))))))))
			src.cult()


	switch(headchoice)
		if("young recruit of the psychedelic forces")


			src.limbs += new /obj/limb/head/recruit()
		if("punks not dead, they're just too drunk")


			src.limbs += new /obj/limb/head/punk()
		if("pass to the panties")


			src.limbs += new /obj/limb/head/useki()
		if("dorf")


			src.limbs += new /obj/limb/head/dorf()
		if("okkupay-narkofilyay")


			src.limbs += new /obj/limb/head/tesak()
		if("emoboy")


			src.limbs += new /obj/limb/head/emo()
		if("fake Stalin")


			src.limbs += new /obj/limb/head/stalin()
		if("fake Hitler")


			src.limbs += new /obj/limb/head/hitler()
		if("cannibal hobo")






			src.limbs += new /obj/limb/head/hobo()
		if("competent researcher")


			src.limbs += new /obj/limb/head/science()

	if(src.ckey in donat_profi)

		if(profname in prof_sec)
			src.empowered = 1
			src.profi = 1
		else if((profname in prof_engi) || ((profname in prof_med) || (profname == "botanist" || profname == "geologist")))
			src.profi = 1

	src.toxdmg()
	src.spacedmg()
	src.adv_visuals()
	if(src.moustache == 0)
		src.overlays += /obj/overlay/moustacheless





	if(profname == "slbrkr")
		src.slbrkr_initiate()

	if(profname == "angel")
		src.angelize()
	else
		if(prob(traitorism) && !(profname == "robot"))
			src.traitor()

/mob/proc/equip_profa(profname as text)




	if(src.ckey in baton_donat)
		new /obj/item/weapon/baton(loc)
		new /obj/item/reagent_container/consumable/pill/ecstasy(loc)
		new /obj/item/reagent_container/consumable/pill/ecstasy(loc)
		new /obj/item/reagent_container/consumable/pill/ecstasy(loc)
		new /obj/item/reagent_container/consumable/pill/heroin(loc)

	if(src.ckey in opi_donat)
		new /obj/item/reagent_container/consumable/pill/heroin(loc)
		new /obj/item/reagent_container/consumable/pill/methadone(loc)
		new /obj/item/reagent_container/consumable/pill/methadone(loc)

	if(src.ckey in weed_donat)
		new /obj/item/reagent_container/consumable/vtoryaki/weed(loc)
		new /obj/item/reagent_container/consumable/vtoryaki/weed(loc)
		new /obj/item/reagent_container/consumable/hash/edinichka(loc)
		new /obj/item/bong(loc)

	if(src.ckey in leet_donat)
		new /obj/item/clothes/ilita(loc)
		new /obj/item/reagent_container/cig/cigar/heroin(loc)
		new /obj/item/reagent_container/cig/cigar/speed(loc)
		new /obj/item/reagent_container/cig/cigar/speed(loc)
		new /obj/item/reagent_container/cig/cigar/speed(loc)




	switch(profname)
		if("engineer")




			src.equip_clothes(new /obj/item/clothes/engineer())
			src.equip_key(new /obj/item/key/engineer())
			src.equip_belt(new /obj/item/cash())
		if("assistant")

			src.equip_clothes(new /obj/item/clothes/standart())
			src.equip_key(new /obj/item/key/maint())
		if("botanist")
			src.equip_clothes(new /obj/item/clothes/hydro())
			src.equip_key(new /obj/item/key/hydro())
			src.equip_belt(new /obj/item/cash())
		if("security major")
			src.equip_clothes(new /obj/item/clothes/security())
			src.equip_key(new /obj/item/key/security())
			src.equip_brain(new /obj/item/device/brainport/radio())
			src.equip_belt(new /obj/item/cash())
		if("doctor")
			src.equip_clothes(new /obj/item/clothes/doctor())
			src.equip_key(new /obj/item/key/doctor())
			src.equip_belt(new /obj/item/cash())
		if("researcher")
			src.equip_clothes(new /obj/item/clothes/research())
			src.equip_key(new /obj/item/key/labs())
			src.equip_belt(new /obj/item/cash())
		if("chemist")
			src.equip_clothes(new /obj/item/clothes/chem())
			src.equip_key(new /obj/item/key/chemist())
			src.equip_belt(new /obj/item/cash())
		if("geologist")
			src.equip_clothes(new /obj/item/clothes/miner())
			src.equip_key(new /obj/item/key/mining())
			src.equip_belt(new /obj/item/cash())
		if("project director")

			for(var/obj/beacon/B in world)
				if(B.director == 0)
					B.director = 1
			src.equip_clothes(new /obj/item/clothes/leadlab())
			src.equip_key(new /obj/item/key/labcommand())
			src.equip_brain(new /obj/item/device/brainport/radio())
			src.equip_belt(new /obj/item/cash/poltos())
		if("operator")
			for(var/obj/beacon/B in world)
				if(B.operator == 0)
					B.operator = 1
			src.equip_clothes(new /obj/item/clothes/operator())
			src.equip_key(new /obj/item/key/operator())
			src.equip_brain(new /obj/item/device/brainport/radio())
			src.equip_belt(new /obj/item/cash/poltos())
		if("chief engineer")
			for(var/obj/beacon/B in world)
				if(B.chief == 0)
					B.chief = 1
			src.equip_clothes(new /obj/item/clothes/engineer/engielab())
			src.equip_key(new /obj/item/key/engineercommand())
			src.equip_brain(new /obj/item/device/brainport/radio())
			src.equip_belt(new /obj/item/cash/poltos())
		if("captain")
			for(var/obj/beacon/B in world)
				if(B.captain == 0)
					B.captain = 1
			src.equip_clothes(new /obj/item/clothes/military/captain())
			src.equip_brain(new /obj/item/device/brainport/radio())
			src.equip_belt(new /obj/item/cash/poltos())
		if("cognitologist")
			src.equip_clothes(new /obj/item/clothes/cognitology())
			src.equip_key(new /obj/item/key/mindscience())
			src.equip_belt(new /obj/item/cash())
		if("psychiatrist")
			for(var/obj/beacon/B in world)
				if(B.psychiatrist == 0)
					B.psychiatrist = 1
			src.equip_clothes(new /obj/item/clothes/psycho())
			src.equip_key(new /obj/item/key/psycho())
			src.equip_belt(new /obj/item/cash())
		if("purificator")
			for(var/obj/beacon/B in world)
				if(B.purificator == 0)
					B.purificator = 1
			src.equip_clothes(new /obj/item/clothes/purificator())
			src.equip_key(new /obj/item/key/purificator())
			src.equip_brain(new /obj/item/device/brainport/radio())
			src.equip_belt(new /obj/item/cash())
		if("prosecutor")
			for(var/obj/beacon/B in world)
				if(B.prosecutor == 0)
					B.prosecutor = 1
			src.equip_clothes(new /obj/item/clothes/security/prosecutor())
			src.equip_key(new /obj/item/key/prosecutor())
			src.equip_brain(new /obj/item/device/brainport/radio())
			src.equip_belt(new /obj/item/cash/poltos())
		if("baryga")
			baryga = 1
			equip_clothes(new /obj/item/clothes/standart/ak47())
			equip_key(new /obj/item/key/engineer())
			equip_brain(new /obj/item/device/brainport/radio())
			prof = null
			update_sprite()
		if("Geology robot")
			src.georobot()
		if("robot")
			return

/mob/proc/show_profdesc(profname as text)
	switch(profname)
		if("engineer")
			src << "\red \bold You're an engineer. Your foremost duty is to set up station powernet via either starting turbine engine, wiring up solar collectors or both. You're also responsible for repairing any damage dealt to station (trust me - it will be damaged)."
		if("assistant")
			src << "\red \bold You're an assistant. You should help fellow specialists in their business. If you have nothing else to do, find a bottle of fuel (or just fill any empty container from fuel canister) and refill fuel lamps on Baikonur-5 and main station."
		if("botanist")
			src << "\red \bold You're a botanist. You can grow misc stuff in your hydro trays for medical, griefful or culinary reasons. Use your extractor to process plants into seeds and chemicals."
		if("security major")
			src << "\red \bold You're a security major. You have a baton for beating criminal scum and a jail for keeping live prisoners or hide dead bodies. Do not let people to steal, kill, rape, vandalize, release chlorine and so."
		if("researcher")
			src << "\red \bold You're the researcher. It is quite difficult to say clearly what should you do. Broadly speaking, you should try to understand how the things work and then try to use your knowledge. You can found some foul roosters for testing chemicals and other things at the east of your arrival. Also, feel free to roam around the station if you think what you can find something interesting, but be aware of captain and security!"
		if("doctor")
			src << "\red \bold You're local doctor. People WILL try to kill each other, so you're extremely important person here. You can find misc medicine around medical bay and med storages. Use blood and body analyzers to get an information about your patient's condition and then use your medical magic to heal this poor soul."
		if("chemist")
			src << "\red \bold You're a chemist. You're both researcher, medic and walking supply unit. Use your machinery to combine misc chemicals together trying get some result. Medics and botanists may ask you for some medicine or even some extra chemicals. PD also will try to crawl into your cozy lab sometimes in search for fresh destruction metodics."
		if("geologist")
			src << "\red \bold You're a geologist. You have a pickaxe, a spacesuit and a very private geology bay in the deep space. Supply station with essencial materials like metal or plastic and keep on your own researches of samples found."
		if("project director")
			src << "\red \bold You're a director of station laboratories. Communicate with your fellow researchers, bring your knowledge to the bright ones and try to stop too curious scientists from destroying the station. And try not to destroy it by yourself."
		if("chief engineer")
			src << "\red \bold You're a chief engineer. CE is like a common engineer, but with even more responsibility and a bit of authority. Do not let engineers to ignore powernets dryout or, for example, to shoot the people in the corridors with emitters."
		if("captain")
			src << "\red \bold You're local tyrant. Do not let any of those fuckers around to kill someone or break something and try to stay alive yourself. Your can make some extra holes in the bodies of agressive or dangerously retarded crewmen with your blaster or cut them apart with your very special energy axe. Also, don't let the people to steal your very own golden key (they WILL try to steal it if they know what it is). If you get hurt, try to found a doctor, a fine medicine or at least some food. And yeah, enjoy."
		if("operator")
			src << "\red \bold You're an operator. You responsibility is so huge that you even don't allowed to leave your workplace without captain's permission. You have a lot of machinery for remote control around the station and a private fortress floating in the space near the main station. It is your duty to observe the goddamn station and prevert those traitors, faggots and retards from destroying it."
		if("cognitologist")
			src << "\red \bold You're a cognitologist. You're trying to awake hidden reserves of mind with help of special machinery and psychoactive substations. Try not to destroy your brain with psychedelics and avoid overdosing!"
		if("psychiatrist")
			src << "\red \bold You're a psychiatrist. While cognitologists trying to fuck up someone's brain, you'll try to fix it. Use your bad big benzos, neuroleptics and serotonin-related stuff to cure poor souls who cannot stay wild rhythm of station. Also, you have a rubber baton. Groovy."
		if("purificator")
			src << "\red \bold You're a purificator. Folks from security may be good at beating the shit out of traitors and rogue robots, but they have no chance fighting multiple biohazards, infernal stalinists intervention or full-scale veteran invasion. Seriously, most folks don't even know what kind of stuff may invade their cozy little station at any time! \n And this is why you're here. Use your suit and bat to deal with hazards of both biological (amoebas and bladeweeds) and esoterical (spectres, rampaging mystics and beasts of Abyss) nature."
		if("prosecutor")
			src << "\red \bold You're a prosecutor. It is like being captain number two, but even harder. Your goal is to force ALL of the station complex to stay in line. This includes security majors: don't let them go rogue. You have a console which allows you to torture every officer on complex; don't abuse it but if you see any signs of disobeyment feel free to torment the fucker up. \n \n \n Also, press dat fucking button before entering your cabinet or your turrets will rape you."
		if("baryga")
			src << "\red \bold You're a dirty, smelly and greedy baryga, raiding the station complex from The Abyss. Security hates you and will kill or capture you on sight. Sell the drugs to the station complex dwellers, try to get as rich and swaggy as possible and use your gear to not get caught. \n Your <B>MAIN</B> objective is to hoard 1500 cherenkovs on your personal encryptor. Trade drugs for gems, money, cartridges and shit or be a robber (and got murdered in process)."
		if("robot")
			src << "\blue*Beep*"

	var/L = list("baryga", "robot", "prosecutor", "operator", "captain", "chief engineer", "project director")

	if(!(src.prof in L))
		src << ""
		src << "\blue Due to logistics problems, you've been teleported not straight to the station, but to the Baikonur-5 landing site. Head south until you reach Baikonur-5 gate."

/mob/proc/add2cast(profname as text)
	switch(profname)
		if("engineer")
			castlist += "[src.ckey] as [src.realname], the [pick("skillful", "smart", "responsible", "rutheless")] [profname]!"
		if("assistant")
			castlist += "[src.ckey] as [src.realname], the [pick("mischevious", "cunning")] [profname]!"
		if("botanist")
			castlist += "[src.ckey] as [src.realname], the [pick("skillful", "smart", "rutheless")] [profname]!"
		if("security major")

			castlist += "[src.ckey] as [src.realname], the [pick("brave", "fearless", "responsible")] [profname]!"
		if("prosecutor")
			castlist += "[src.ckey] as [src.realname], the [pick("brave", "fearless", "responsible", "strict")] [profname]!"
		if("purificator")
			castlist += "[src.ckey] as [src.realname], the [pick("brave", "fearless", "heroic")] [profname]!"
		if("captain")
			castlist += "[src.ckey] as [src.realname], the [pick("brave", "fearless", "responsible")] [profname]!"
		if("researcher")

			castlist += "[src.ckey] as [src.realname], the [pick("smart", "responsible", "skillful", "genius")] [profname]!"
		if("doctor")
			castlist += "[src.ckey] as [src.realname], the [pick("careful", "smart", "responsible", "skillful")] [profname]!"
		if("psychiatrist")
			castlist += "[src.ckey] as [src.realname], the [pick("careful", "smart", "responsible", "skillful")] [profname]!"
		if("project director")
			castlist += "[src.ckey] as [src.realname], the [pick("smart", "responsible", "skillful", "genius")] [profname]!"
		if("cognitologist")
			castlist += "[src.ckey] as [src.realname], the [pick("true-seeing", "smart", "responsible", "skillful", "genius")] [profname]!"
		else
			castlist += "[src.ckey] as [src.realname]!"

/mob/proc/terminal_logs(profname as text)


	if(profname == "robot" || (profname == "baryga" || (profname == "angel" || (profname == "slbrkr" || !profname))))
		return

	var/msg = "[src.realname] have joined the crew as [profname]"

	for(var/obj/comp/alert/A in world)
		A.playsound('sounds/engine.wav')
		A.show_message("\blue The console softly beeps to you:")
		A.show_message(msg)
		A.messages += "<b>[msg]</b>"

/mob/new_player/proc/penisLogin()
	if(src.client.logged_in)
		src.client.reset_hud()
	for(var/obj/beacon/B in world)
		if(B.captain == 1)
			src.loc = locate(/turf/floor/capstart)

			name = pick("Volodya Ulianov", "Joseph Stalin", "Karl Marks", "Serega Trotski", "Che Guevara", "Fidel Castro")
			src << "\red \bold You're local tyrant. Do not let any of those fuckers around to kill someone or break something and try to stay alive yourself. Your can make some extra holes in the bodies of agressive or dangerously retarded crewmen with your blaster or cut them apart with your very special energy axe. Also, don't let the people to steal your very own golden key (they WILL try to steal it if they know what it is). If you get hurt, try to found a doctor, a fine medicine or at least some food. And yeah, enjoy."
			world << "\bold All hail [name], your new tyrant!"
			if(B in world)
				B.captain = 1
			src.chemprotect = 3
			src.armor = 5
			src.energyprotect = 5
			src.clothes = new /obj/item/clothes/military/captain()
			src.icon_state = "captain"
			src.spacedmg()
			src.toxdmg()
			src.prof = "captain"
			//..()
		else if(!src.client.logged_in)
			src.loc = locate(68, 12, 2)
			var/newname
			newname = input("Choose a name for your character or leave it empty to let the fate do it by you:", "Your Name.", "")
			if(newname == "" || newname == " ")
				var/firstname = pick("Vovan", "Zuchnewt", "Hop", "George", "Douglas", "Petyan", "Wasiliy", "Khodoque", "Mishanya", "Manya", "Urist", "Geshud", "GEDUSH", "Wasiliti", "Karik", "Ivan", "Yurka", "Adolph", "Syndie")
				var/secondname = pick("Kotov", "Schetnikov", "Pupkin", "Tritor", "Melons", "Petuhov", "Griferkov", "McRobust", "McLiberal", "McFishDissector", "McMechanic", "McRooster", "McSpessman", "LE MEKANIKUE", "Tibet", "Karlov", "Armstrong", "Gagarin", "Germogenovich")
				name = "[firstname] [secondname]"
			else
				name = "[newname]"
			if(B.director == 0 && B.chief == 0)
				src.prof = input("Your profession onboard (assistant is quite easy and griefful, engineers and security majors are a bit harder to play):", "Select your profession", "assistant") in list("assistant", "security major", "researcher", "project director", "engineer", "chief engineer", "doctor")
			else if(B.director == 1 && B.chief == 0)
				src.prof = input("Your profession onboard (assistant is quite easy and griefful, engineers and security majors are a bit harder to play):", "Select your profession", "assistant") in list("assistant", "security major", "researcher", "engineer", "chief engineer", "doctor")
			else if(B.director == 0 && B.chief == 1)
				src.prof = input("Your profession onboard (assistant is quite easy and griefful, engineers and security majors are a bit harder to play):", "Select your profession", "assistant") in list("assistant", "security major", "researcher", "project director", "engineer", "doctor")
			else
				src.prof = input("Your profession onboard (assistant is quite easy and griefful, engineers and security majors are a bit harder to play):", "Select your profession", "assistant") in list("assistant", "security major", "researcher", "engineer", "doctor")
			switch(src.prof)
				if("assistant")
					src.chemprotect = 0
					src.armor = 1
					src.energyprotect = 0
					src.clothes = new /obj/item/clothes/standart()

					src.equip_key(new /obj/item/key/maint())

					src.loc = locate(/turf/floor/start)
					src << "\red \bold You're an assistant. You should help fellow specialists in their business. Or, at least, stay alive until the end."
				if("engineer")
					src.chemprotect = 0
					src.armor = 1
					src.energyprotect = 3
					src.clothes = new /obj/item/clothes/engineer()
					src.equip_key(new /obj/item/key/engineer())
					src.icon_state = "engineer"
					src.loc = locate(pick(41, 42), pick(53, 54, 55, 56, 57, 58, 59), 1)
					src << "\red \bold You're an engineer. Your duty is to set up all station powernets and then start to keep them in working condition. Also, you should repair hull breaches to prevent your comrades from walking in the outer space. Your uniform has a belt for keeping small and medium-sized tools. You can found misc power equipment in the engineering. Try to realize how it works and then use it."
				if("security major")
					src.chemprotect = 0
					src.armor = 2
					src.energyprotect = 0
					src.clothes = new /obj/item/clothes/security()
					src.equip_key(new /obj/item/key/security())
					src.icon_state = "security"
					src.loc = locate(pick(61, 62), pick(37, 38), 1)
					src << "\red \bold You're a security major. You have a gun for blinding and a baton for beating criminal scum and a jail for keeping live prisoners or hide dead bodies. Do not let people to steal, kill, rape, vandalize, release chlorine and so."
				if("doctor")
					src.chemprotect = 5
					src.armor = 1
					src.energyprotect = 0
					src.clothes = new /obj/item/clothes/doctor()
					src.equip_key(new /obj/item/key/doctor())
					src.icon_state = "doctor"
					src.loc = locate(pick(9, 10, 11, 12), pick(43, 44, 45, 46, 47), 1)
					src << "\red \bold You're local doctor. People WILL try to kill each other, so you're extremely important person here. You can find misc medicine around medical bay and med storages. Use blood and body analyzers to get an information about your patient's condition and then use your medical magic to heal this poor soul."
				if("researcher")
					src.chemprotect = 4
					src.armor = 1
					src.energyprotect = 4
					src.clothes = new /obj/item/clothes/research()
					src.equip_key(new /obj/item/key/labs())
					src.icon_state = "research"
					src.loc = locate(pick(56, 57, 58, 59, 60, 61), pick(51, 52), 1)
					src << "\red \bold You're the researcher. It is quite difficult to say clearly what should you do. Broadly speaking, you should try to understand how the things work and then try to use your knowledge. You can found some foul roosters for testing chemicals and other things at the east of your arrival. Also, feel free to roam around the station if you think what you can find something interesting, but be aware of captain and security!"
				if("project director")
					B.director = 1
					src.chemprotect = 4
					src.armor = 1
					src.energyprotect = 4
					src.clothes = new /obj/item/clothes/leadlab()
					src.equip_key(new /obj/item/key/labcommand())
					src.icon_state = "leadlab"
					src.loc = locate(65, 53, 1)
					src << "\red \bold You're the director of station laboratories. Communicate with your fellow researchers, bring your knowledge to the bright ones and try to stop too curious scientists from destroying the station. And try not to destroy it by yourself."
				if("chief engineer")
					B.chief = 1
					src.chemprotect = 4
					src.armor = 1
					src.energyprotect = 4
					src.clothes = new /obj/item/clothes/engineer/engielab()
					src.equip_key(new /obj/item/key/engineercommand())
					src.icon_state = "engielab"
					src.loc = locate(32, 48, 1)
					src << "\red \bold You're the chief engineer. CE is like a common engineer, but with even more responsibility and a bit of authority. Do not let engineers to ignore powernets dryout or, for example, to shoot the people in the corridors with emitters."
				else
					usr << "\red \bold Are you a wizard"
					src.loc = locate(/turf/floor/start)
			if(prob(traitorism))
				src.traitor()
			src.client.logged_in = 1
			src.client.reset_hud()
			src.toxdmg()
			src.spacedmg()
			playernum++
			//..()

/mob/proc/georobot()
	sleep(0)
	var/R = new /mob/robot(src.loc)
	R:overlays += /obj/overlay/jet
	R:can_move = 1
	R:ckey = src.ckey
	R:realkey = src.realkey
	R:prof = src.prof
	spawn(0)
		R << "\blue Beep"
		spawn(10)
			R << "\red \bold You're a geology robot. Use your fellow drill and saw to assist those puny living geologists."
			var/RD = new /obj/item/tool/robot/robodrill(src.loc)
			RD:pickup(R)
			R:r_hand = new /obj/item/tool/robot/robosaw()
			R:equip_key(new /obj/item/key/geobot())
			spawn(0) del(src)

/mob/new_player/Logout()
	..()
	src.key = null
	del(src)
