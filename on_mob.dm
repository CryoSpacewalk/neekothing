// Recovered from compiled neek.dmb (331 procs)

/client/proc/check_psychosis(mob/M in world)




















	set category = "Debug"
	src << "\blue \bold [M:realname] psychosis: [M:psychosis]"

/mob/proc/shouttruth()








	if(src.class == "man")

		if(prob(60))
			if(src.prof)
				for(var/mob/M in hearers(src))
					if(!M.sleeps)
						M << "\blue \bold [src.name] shouts: My profession is [prof]!"
			else
				for(var/mob/M in hearers(src))
					if(!M.sleeps)
						M << "\blue \bold [src.name] shouts:I have no profession onboard!"
		else if(prob(50))
			if(src.maggot)
				for(var/mob/M in hearers(src))
					if(!M.sleeps)
						M << "\blue \bold [src.name] shouts: I am a homosexualist!"
			else
				for(var/mob/M in hearers(src))
					if(!M.sleeps)
						M << "\blue \bold [src.name] shouts: I am not a homosexualist, I prefer women if you ask!"
		else if(prob(50))
			if(src.cult)
				for(var/mob/M in hearers(src))
					if(!M.sleeps)
						M << "\blue \bold [src.name] shouts: I am an infernal stalinist!"
			else if(src.abyss >= 1)
				for(var/mob/M in hearers(src))
					if(!M.sleeps)
						M << "\blue \bold [src.name] shouts: I pray to the powers of Abyss!"
			else
				for(var/mob/M in hearers(src))
					if(!M.sleeps)
						M << "\blue \bold [src.name] shouts: I am not religious and don't worship to any mystical powers!"
		else
			if(src.traitor)
				for(var/mob/M in hearers(src))
					if(!M.sleeps)
						M << "\blue \bold [src.name] shouts: I am an agent of government-corporations!"
			else if(src.slbrkr)
				for(var/mob/M in hearers(src))
					if(!M.sleeps)
						M << "\blue \bold [src.name] shouts: the mighty Allah will crush you anyway!"
			else
				for(var/mob/M in hearers(src))
					if(!M.sleeps)
						M << "\blue \bold [src.name] shouts: I am not an agent of any capitalistic organisation!"

/mob/proc/glowing(g_q)






	if(prob(2))
		src << "\bold \red You're glowing!"

	src.glow = g_q
























	if(src.glow)

		for(var/turf/T in range(2, loc))
			new /obj/overlay/gaylight(T)

		for(var/mob/M in orange(2, src.loc))
			if(M.class == "man" && M.mat == "flesh")
				M << "\red \bold This blinking gives you an epilepsy!"
				M.epilepsy++
				if(prob(M.epilepsy * 1.5))
					M.seizure(4)

		spawn(3) glowing(g_q - 1)







/atom/proc/density_test(turf/T, goodturfs = list())
	var/P = new /obj/pseudobullet(src.loc)
	while(P:loc != T)
		sleep(0)
		step_to(P, T)
		if(!src.loc.opacity)
			goodturfs += src.loc
		else
			break
		return goodturfs

/mob/proc/sick()






	src << "\red \bold You feel sick."
	src.euphoria -= rand(2, 4)
	if(prob(25))
		src.vomit()

/mob/proc/vomit()
	if(prob(src.nauseablock * 2))
		return
	src << "\red You vomit. Ew-w-w-w!"
	if(src.hunger >= 5)
		src.hunger -= 5
	new /obj/vomit(src.loc)

/mob/proc/vomit_red()
	if(prob(src.nauseablock * 2))
		return
	src << "\red You vomit. Ew-w-w-w!"
	src << "\red You see a blood in your vomit. Disgusting."
	src.damaga(rand(1, 3), "organ")
	if(src.hunger >= 5)
		src.hunger -= 5
	new /obj/vomit/red(src.loc)

/obj/vomit/New()





	icon_state = pick("vomit_1", "vomit_2", "vomit_3")
	alticon = pick("gvomit1", "gvomit2", "gvomit3")
/obj/vomit/red
	name = "pool of vomit"
/obj/vomit/red/New()
	icon_state = pick("vomit_r1", "vomit_r2", "vomit_r3")
	alticon = pick("gvomit_r1", "gvomit_r2", "gvomit_r3")

/mob/proc/remove_chem(rid, r_amount)

	for(var/datum/reagent/RE in src.blood_chem)
		if(RE.id == rid)
			if(RE.amount > r_amount)
				RE.amount -= r_amount
			else
				RE.amount = 0
				src.blood_chem -= RE

/mob/proc/add_chem(rid, rname, r_amount, r_temp)
	sleep(0)
	var/plused = 0
	if(r_temp > 1)
		usr << "\red Damn, it is hot!"
		usr.damaga((round(r_amount / 2) + 1) * (round(r_temp / 3) + 1), "burn")
	for(var/datum/reagent/RE in src.blood_chem)
		if(RE.id == rid)
			RE.amount += r_amount
			plused = 1
	spawn(0)
		if(plused == 0)
			var/RT = new /datum/reagent()
			RT:id = rid
			RT:amount = r_amount
			RT:name = rname
			src.blood_chem += RT

/obj/item/reagent_container/beaker/attack(mob/M, mob/user)









	if(istype(M, /mob))
		switch(src.method)
			if("drink")
				if(!reagent_list:len)
					usr << "\red It is empty!"
					return
				if(M:mat == "flesh")
					user << "\blue You try to feed [M] some of [src] contents."
					for(var/mob/V in view(user))
						V << "\red [usr] tries to feed [M] some of [src] contents."
					spawn(40)
						if(((user in range(1, M)) || (M in range(usr.psi_radius))) && user:item == src)
							src.lips_touch(M)
							usr << "\blue You feed [M] some of [src] contents."
							for(var/mob/V in view(user))
								V << "\red [usr] feeds [M] some of [src] contents."
							spawn(0) src.transfer_to_mob(5, M)
			else
				shake()
				user << "\blue You splash [M] with [src] contents."
				for(var/mob/V in view(user))
					V << "\red [usr] splashes [M] with something!"
				splash(M)
	else
		..()

/obj/item/reagent_container/beaker/proc/splash(mob/M)
	if(length(src.reagent_list))
		var/q = 1 + M:chemprotect / 5
		for(var/datum/reagent/RE in src.reagent_list)
			RE.on_touch(RE.amount / q, M, "all")
		spawn(0) src.remove_all()

/obj/item/reagent_container/beaker/proc/lips_touch(mob/M)
	if(length(src.reagent_list))
		for(var/datum/reagent/RE in src.reagent_list)
			RE.on_touch(RE.amount, M, "single")

/datum/reagent/proc/on_mob(mob/M)































































































































































































































































	var/should_react = 1

	if(M:aids == 1 && src.id == aidscure)
		M << "\green You feel fucking great."
		M:aids = 0
	for(var/datum/on_mob/R in on_mob_avaible)
		if(src.id == R.rid)
			should_react = 0




			var/syn = 1
			if(M:synergy:len)

				for(var/datum/synergy/S in M:synergy)
					if(src.id == S.rid)
						syn = S.percent / 100

			R.react(src.amount * syn, src, M)

	spawn(0)

		if(should_react)

			for(var/datum/on_mob/basic/B in on_mob_avaible)
				B.react(src.amount, src, M)

/datum/on_mob
	var/rid = "nothing to see here, folks"
	var/stim = 0
/datum/on_mob/proc/react(quaziamt, R, mob/M)
	world << "\red <font size = 5>ON_MOB IS BROKEN, HURR DURR</font>"
/datum/on_mob/basic
	rid = "basic"
/datum/on_mob/basic
/datum/on_mob/basic/react(quaziamt, R, mob/M)
	if(prob(25))
		M:remove_chem(R:id, 1)
/datum/on_mob/antidote
	rid = "antidote"
/datum/on_mob/antidote
/datum/on_mob/antidote/react(quaziamt, R, mob/M)
	if(quaziamt >= 0.25)
		M:heal(1, "organ")
		M:remove_chem("toxin", 1)
		M:remove_chem("piperidine", 1)
		M:remove_chem("black yeast", 1)
		M:remove_chem("fuel", 1)
		M:remove_chem("stalkotoxin", 1)
		M:remove_chem("chlorine", 1)
		M:remove_chem("fluorine", 1)
		M:remove_chem("liquid smoke", 1)
		M:remove_chem("pogankeepeptide", 0.5)
		M:remove_chem("methanol", 0.5)
		M:remove_chem("ammonia", 0.5)
		M:remove_chem("ammonium hydroxide", 0.5)
		M:remove_chem("aqua regia", 1.5)
		M:remove_chem("polytrinic acid", 1.5)
		M:remove_chem("sulfuric acid", 1.5)
		M:remove_chem("hydrochloric acid", 1.5)
		M:remove_chem("nitric acid", 1.5)
		M:remove_chem("Nuclear titbit", 0.5)
		M:remove_chem("corpse rot", 0.5)
		M:remove_chem("biotoxin", 0.25)
		M:remove_chem("starsalve", 0.5)
		M:remove_chem("atropine", 0.5)
		M:remove_chem("strychnine", 0.5)
		M:remove_chem("botox", 0.5)
		M:remove_chem("mercury", 0.5)
		M:remove_chem("red mercury", 0.5)
		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "ASD" && RE.amount > 5)
				M:remove_chem("ASD", 1)
			if(RE.id == "nicotine" && RE.amount > 5)
				M:remove_chem("nicotine", 1)
			if(RE.id == "ibuprofen" && RE.amount >= 15)
				M:remove_chem("ibuprofen", 1)
			if(RE.id == "paracetamol" && RE.amount >= 10)
				M:remove_chem("paracetamol", 1)

	M:remove_chem("antidote", 0.25)
/datum/on_mob/glucose
	rid = "glucose"
/datum/on_mob/glucose
/datum/on_mob/glucose/react(quaziamt, R, mob/M)
	if(M:hunger <= 398 && quaziamt >= 1)
		M:hunger += 2
	else if(quaziamt >= 1)
		M:hunger = 400

	if(quaziamt >= 0.5)
		M:remove_chem("ethanol", 1)
		M:remove_chem("methanol", 0.5)

		if(M:alcho >= 80)
			if(M:delirium)
				M:delirium--
			M:alcho -= 20
		else if(M:alcho >= 30)
			M:alcho -= 10
		else if(M:alcho >= 15)
			M:alcho -= 5
		else if(M:alcho)
			M:alcho--

		if(M:barbi >= 50)
			M:barbi -= 40
		else if(M:barbi >= 10)
			M:barbi -= 5
		else if(M:barbi && prob(66))
			M:barbi--
		if(M:barbi >= 110)
			M:barbi -= 50

		if(M:benzo >= 100)
			M:benzo -= 50
		else if(M:benzo >= 50)
			M:benzo -= 30
		else if(M:benzo >= 20)
			M:benzo -= 5
		else if(M:benzo >= 10)
			M:benzo -= 3
		else if(M:benzo)
			M:benzo--

		if(M:hmur >= 80)
			M:hmur -= 10
		else if(M:hmur >= 30)
			M:hmur -= 5
		else if(M:hmur >= 15)
			M:hmur -= 3
		else if(M:hmur >= 8)
			M:hmur -= 2
		else if(M:hmur)
			M:hmur--

	if(prob(20) && M:hmur < 10)
		M:hmur = 0
	if(prob(20) && M:barbi < 10)
		M:barbi = 0
	if(prob(20) && M:benzo < 10)
		M:benzo = 0
	if(prob(50) && M:tension)
		M:tension--

	spawn(0) M:remove_chem("glucose", 0.5)

/datum/on_mob/mangadote
	rid = "mangadote"
/datum/on_mob/mangadote
/datum/on_mob/mangadote/react(quaziamt, R, mob/M)
	if(M:nausea && prob(20))

		M:nausea = 0

	if(quaziamt >= 0.25)
		M:heal(4, "organ")
		M:remove_chem("toxin", 1)
		M:remove_chem("piperidine", 1)
		M:remove_chem("black yeast", 1)
		M:remove_chem("fuel", 1)
		M:remove_chem("stalkotoxin", 1)
		M:remove_chem("chlorine", 1)
		M:remove_chem("fluorine", 1)
		M:remove_chem("liquid smoke", 1)
		M:remove_chem("pogankeepeptide", 0.5)
		M:remove_chem("methanol", 0.5)
		M:remove_chem("ammonia", 0.5)
		M:remove_chem("ammonium hydroxide", 0.5)
		M:remove_chem("aqua regia", 1.5)
		M:remove_chem("polytrinic acid", 1.5)
		M:remove_chem("sulfuric acid", 1.5)
		M:remove_chem("hydrochloric acid", 1.5)
		M:remove_chem("nitric acid", 1.5)
		M:remove_chem("Nuclear titbit", 1)
		M:remove_chem("corpse rot", 1)
		M:remove_chem("biotoxin", 0.5)
		M:remove_chem("starsalve", 1)
		M:remove_chem("atropine", 1)
		M:remove_chem("strychnine", 1)
		M:remove_chem("botox", 1)

		for(var/datum/reagent/RE in M:blood_chem)

			if(RE.id == "ASD" && RE.amount > 5)
				M:remove_chem("ASD", 1)
			if(RE.id == "nicotine" && RE.amount > 5)
				M:remove_chem("nicotine", 1)
			if(RE.id == "ibuprofen" && RE.amount >= 15)
				M:remove_chem("ibuprofen", 1)
			if(RE.id == "paracetamol" && RE.amount >= 10)
				M:remove_chem("paracetamol", 1)

			if(RE.id == "codeine" && RE.amount > 0.7)
				M:remove_chem("codeine", 0.5)
				M:vomit()

			if(RE.id == "morphine" && RE.amount > 0.6)
				M:remove_chem("morphine", 0.4)
				M:vomit()


	M:remove_chem("mangadote", 0.25)
/datum/on_mob/manganeska
	rid = "manganeska"
/datum/on_mob/manganeska
/datum/on_mob/manganeska/react(quaziamt, R, mob/M)
	if(quaziamt >= 1)

		if(M:nausea && prob(20))

			M:nausea = 0

		M:remove_chem("toxin", 0.5)
		M:remove_chem("piperidine", 0.5)
		M:remove_chem("black yeast", 1)
		M:remove_chem("fuel", 0.5)
		M:remove_chem("stalkotoxin", 0.5)
		M:remove_chem("chlorine", 0.5)
		M:remove_chem("fluorine", 0.5)
		M:remove_chem("liquid smoke", 0.5)
		M:remove_chem("pogankeepeptide", 0.25)
		M:remove_chem("methanol", 0.25)
		M:remove_chem("ammonia", 0.25)
		M:remove_chem("ammonium hydroxide", 0.25)
		M:remove_chem("aqua regia", 0.75)
		M:remove_chem("polytrinic acid", 0.75)
		M:remove_chem("sulfuric acid", 0.75)
		M:remove_chem("hydrochloric acid", 0.75)
		M:remove_chem("nitric acid", 0.75)
		M:remove_chem("Nuclear titbit", 0.5)
		M:remove_chem("corpse rot", 0.5)
		M:remove_chem("biotoxin", 0.25)
		M:remove_chem("starsalve", 0.5)
		M:remove_chem("atropine", 0.5)
		M:remove_chem("strychnine", 0.5)
		M:remove_chem("botox", 0.5)

		for(var/datum/reagent/RE in M:blood_chem)

			if(RE.id == "ASD" && RE.amount > 5)
				M:remove_chem("ASD", 1)
			if(RE.id == "nicotine" && RE.amount > 5)
				M:remove_chem("nicotine", 1)
			if(RE.id == "ibuprofen" && RE.amount >= 15)
				M:remove_chem("ibuprofen", 1)
			if(RE.id == "paracetamol" && RE.amount >= 10)
				M:remove_chem("paracetamol", 1)

			if(RE.id == "codeine" && RE.amount > 0.7)
				M:remove_chem("codeine", 0.5)
				M:vomit()

			if(RE.id == "morphine" && RE.amount > 0.6)
				M:remove_chem("morphine", 0.4)
				M:vomit()



	M:remove_chem("manganeska", 0.5)
/datum/on_mob/succinic
	rid = "succinic acid"
/datum/on_mob/succinic
/datum/on_mob/succinic/react(quaziamt, R, mob/M)
	if(quaziamt >= 1)

		M:succinic = 1

		M:remove_chem("GABA", 0.5)
		M:remove_chem("GHB", 0.5)
		M:remove_chem("baclofen", 0.25)
		M:remove_chem("pregabalin", 0.25)
		M:remove_chem("phenibut", 0.25)
		M:remove_chem("phenotropil", 0.25)

	if(quaziamt >= 1)
		M:remove_chem("succinic acid", 0.1)
	else
		M:succinic = 0
		M:remove_chem("succinic acid", 0.1)
/datum/on_mob/toxin
	rid = "toxin"
/datum/on_mob/toxin
/datum/on_mob/toxin/react(quaziamt, R, mob/M)
	if(prob(50) && quaziamt >= 1)
		M:damaga(rand(2, 5) + M:aids * 2, "organ")
		if(M:syphilis && prob(25))
			M << "\red Your organism is fighting against infection!"
			if(prob(50))
				M << "\green You feel somewhat better."
				M:syphilis = 0
		if(prob(5))
			M:sick()

	spawn(0) M:remove_chem("toxin", 0.25)
/datum/on_mob/piperidine
	rid = "piperidine"
/datum/on_mob/piperidine
/datum/on_mob/piperidine/react(quaziamt, R, mob/M)
	if(prob(50) && quaziamt >= 1)
		M:damaga(rand(2, 5) + M:aids * 2, "organ")
		if(prob(5))
			M:sick()

	spawn(0) M:remove_chem("piperidine", 0.25)

/datum/on_mob/strychnine
	rid = "strychnine"
/datum/on_mob/strychnine
/datum/on_mob/strychnine/react(quaziamt, R, mob/M)
	if(M:drowsy)
		M:drowsy = 0

	if(M:calm > 15 && prob(quaziamt * 10))
		M:calm--

	if(M:stunned && (!M:parastunned && prob(35 + round(quaziamt / 2))))
		M:stuntime--

	if(quaziamt >= 3)
		M:damaga(rand(4, 8) + M:aids * 3, "organ")
		if(prob(20))
			M:sick()
		if(prob(15 + round(quaziamt / 2)))
			M << "\red You're thrilling!"
			M:stun(2)
			M:thrill += 5

	spawn(0)
		if(quaziamt >= 2)
			M:remove_chem("strychnine", 0.25)
		else
			M:remove_chem("strychnine", 0.05)

/datum/on_mob/thebaine
	rid = "thebaine"
/datum/on_mob/thebaine
/datum/on_mob/thebaine/react(quaziamt, R, mob/M)
	if(M:drowsy)
		M:drowsy = 0

	if(M:calm > 15 && prob(quaziamt * 10))
		M:calm--

	if(M:stunned && (!M:parastunned && prob(35 + round(quaziamt / 2))))
		M:stuntime--

	if(quaziamt >= 3)
		M:damaga(rand(4, 5) + M:aids * 2, "organ")
		if(prob(20))
			M:sick()
		if(prob(15 + round(quaziamt / 2)))
			M << "\red You're thrilling!"
			M:stun(2)
			M:thrill += 4

	spawn(0)
		if(quaziamt >= 2)
			M:remove_chem("thebaine", 0.25)
		else
			M:remove_chem("thebaine", 0.05)
/datum/on_mob/biotoxin
	rid = "biotoxin"
/datum/on_mob/biotoxin
/datum/on_mob/biotoxin/react(quaziamt, R, mob/M)
	if(prob(50) && quaziamt >= 0.1)
		M:damaga(2 + rand(1, 2 + M:aids), "organ")
		if(prob(5))
			M:sick()
		if(prob(25 * (M:aids + 1)))
			M:damaga(1, "burn")
	var/blindew = 5 + quaziamt * 1.5 + M:aids * 5 - M:luck / 10
	if(blindew > 33)
		blindew = 33
	if(prob(blindew))
		M << "\red OH GOD MY BEAUTIFUL EYES"
		M:blind(rand(25, 60))

	spawn(0) M:remove_chem("biotoxin", 0.05)
/datum/on_mob/rot
	rid = "corpse rot"
/datum/on_mob/rot
/datum/on_mob/rot/react(quaziamt, R, mob/M)
	if(quaziamt >= 0.8)
		M:damaga(rand(1, 3) + M:aids * 2, "organ")
		if(prob(20))
			M << "\red Your limbs hurt a lot!"
			M:limb_damage(rand(5, 20), 1, 0)
		if(prob(15))
			M:sick()

	spawn(0) M:remove_chem("corpse rot", 0.2)

/datum/on_mob/atropine
	rid = "atropine"
/datum/on_mob/atropine
/datum/on_mob/atropine/react(quaziamt, R, mob/M)
	if(quaziamt >= 10)

		if(prob(50))
			M:stun(2)

		M:delirium += 2
		M:damaga(rand(5, 11), "organ")

	if(quaziamt >= 0.5)

		if(prob(33))
			M:stun(2)

		M:delirium++

		if(prob(20 - M:delirium))
			M:delirium++

		if(prob(quaziamt * 20))

			M:delirium++
			M:damaga(rand(1, 3), "organ")

	M:remove_chem("atropine", 0.5)

/datum/on_mob/botox
	rid = "botox"
/datum/on_mob/botox
/datum/on_mob/botox/react(quaziamt, R, mob/M)
	if(M:painless < 3)
		M:painless++
	if(M:painless < 4)
		M:painless++

	if(quaziamt >= 3)
		M:says_xynta += 2
		M:damaga(rand(4, 11) + M:aids * 3, "organ")
		if(prob(25))
			M:says_xynta += 5
		if(M:thrill)
			M:thrill--
		if(prob(10))
			M:sick()
		if(prob(quaziamt * 1.5))
			M:stun(4)
	else
		if(M:pain)
			M:pain--
		if(M:thrill)
			M:thrill--
		if(prob(70) && M:painless < 7)
			M:painless++

	spawn(0) M:remove_chem("botox", 0.25)

/datum/on_mob/sulfur
	rid = "sulfur"
/datum/on_mob/sulfur
/datum/on_mob/sulfur/react(quaziamt, R, mob/M)
	M:damaga(1, "organ")
	spawn(0) M:remove_chem("sulfur", 0.5)

/datum/on_mob/blacktar
	rid = "black tar"
/datum/on_mob/blacktar
/datum/on_mob/blacktar/react(quaziamt, R, mob/M)
	if(M:painless > 0)
		M:painless--

	if(quaziamt >= 0.003)
		if(M:pain < 6)
			M:torment(1)
		M:says_xynta += 2
		M:damaga(rand(4, 11) + M:aids * 3, "organ")
		M:damaga(2, "burn")
		M:sick()
		if(prob(20 + quaziamt * 100 - M:succinic * 10))
			M:stun(2)
		M:nausea += rand(3, 5)
		M:euphoria -= 6
		M:calm -= 2

	spawn(0) M:remove_chem("black tar", 0.001)

/datum/on_mob/glintsyn
	rid = "glintsyn"
/datum/on_mob/glintsyn
/datum/on_mob/glintsyn/react(quaziamt, R, mob/M)
	M:hmur += 25
	M:hm_tick = 4

	if(prob(20))
		M << "\red You feel a strong urge to shoot some H."

	spawn(0) M:remove_chem("glintsyn", 0.05)
/datum/on_mob/black_yeast
	rid = "black yeast"
/datum/on_mob/black_yeast
/datum/on_mob/black_yeast/react(quaziamt, R, mob/M)
	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "nutriment" || RE.id == "sugar")
			M:add_chem("ethanol", "ethanol", 1, 0)
			M:remove_chem(RE.id, 1)
		M:add_chem("fuel", "fuel", 1, 0)
		M:add_chem("chlorine", "chlorine", 0.15, 0)
		M:add_chem("methanol", "methanol", 0.2, 0)
		if(prob(25))
			M:add_chem("corpse rot", "corpse rot", 0.6, 0)
		if(prob(20))
			M:add_chem("biotoxin", "biotoxin", 0.25, 0)
	spawn(0) M:remove_chem("black yeast", 0.5)
/datum/on_mob/neurobacteria
	rid = "neurobacteria"
/datum/on_mob/neurobacteria
/datum/on_mob/neurobacteria/react(quaziamt, R, mob/M)
	if(quaziamt >= 1)
		M:damaga(1 + M:aids * 2, "organ")
		if(!M:syphilis)
			M << "\red \bold You feel like as if something was fucking up your body tissues."
			M:limb_damage(50, 0, 0)
		if(prob(10))
			M:sick()

	spawn(0) M:remove_chem("corpse rot", 0.5)

/datum/on_mob/thiopental
	rid = "sodium thiopental"
/datum/on_mob/thiopental
/datum/on_mob/thiopental/react(quaziamt, R, mob/M)
	if(prob(75 - M:succinic * 50))
		M:barbi++

	if(prob(80) && M:tension)
		M:tension--

	if(M:epilepsy)
		M:epilepsy--

	if(M:psychosis)
		M:psychosis--

	if(M:thrill)
		M:thrill = 0

	if(M:calm < 25)
		M:calm++

	if(prob(quaziamt * 5))
		M:calm++

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "ethanol" && (RE.amount >= 15 && quaziamt >= 4.5))
			if(prob(20))
				if(M:nausea < 5)
					M:nausea = 5
				else
					M:nausea += 2
			if(prob(25))
				M:says_xynta += 5
			M:damaga(3, "organ")

	if(quaziamt >= 15)
		M:calm += rand(1, 3)
		M:damaga(rand(5, 11), "organ")
		M:drowsy_change(10)
	else
		if(quaziamt >= 3)
			M:calm += rand(1, 2)
			if(M:drowsy < 10)
				M:drowsy = 11
			else
				M:drowsy_change(5)
		else
			if(prob(80))
				M:shouttruth()


	spawn(0)
		M:ba_tick = 5
		if(quaziamt > 30)
			M:remove_chem("sodium thiopental", 5)
		else if(quaziamt > 20)
			M:remove_chem("sodium thiopental", 2)
		else if(quaziamt >= 5)
			M:remove_chem("sodium thiopental", 0.5)
		else
			M:remove_chem("sodium thiopental", 0.05)
/datum/on_mob/spess
	rid = "liquid vacuum"
/datum/on_mob/spess
/datum/on_mob/spess/react(quaziamt, R, mob/M)
	if(quaziamt >= 0.2)
		M:damaga(pick(1, 3) + M:aids, "organ")
		M:damaga(pick(1, 3), "brute")
		M:damaga(pick(1, 3), "burn")
	spawn(0) M:remove_chem("liquid vacuum", 0.2)
/datum/on_mob/chlorine
	rid = "chlorine"
/datum/on_mob/chlorine
/datum/on_mob/chlorine/react(quaziamt, R, mob/M)
	if(quaziamt >= 1)
		M:damaga(pick(1, 2), "organ")
		if(prob(10))
			M:sick()

	spawn(0) M:remove_chem("chlorine", 0.05)
/datum/on_mob/regenerite
	rid = "regenerite"
/datum/on_mob/regenerite
/datum/on_mob/regenerite/react(quaziamt, R, mob/M)
	if(quaziamt >= 1)
		M:heal(1, "brute")
		M:heal(4, "organ")

	spawn(0) M:remove_chem("regenerite", 0.5)
/datum/on_mob/slowgen
	rid = "slowgenerite"
/datum/on_mob/slowgen
/datum/on_mob/slowgen/react(quaziamt, R, mob/M)
	if(quaziamt >= 0.1)
		if(prob(66))
			M:heal(1, "brute")
		M:heal(1, "organ")


	spawn(0) M:remove_chem("slowgenerite", 0.1)
/datum/on_mob/prothesine
	rid = "prothesine"
/datum/on_mob/prothesine
/datum/on_mob/prothesine/react(quaziamt, R, mob/M)
	if(quaziamt >= 1)
		M:heal(2, "organ")
		M:protez += 2
		if(M:wounds)
			M:woundcure(1)
	spawn(0) M:remove_chem("prothesine", 1)
/datum/on_mob/warnipizine
	rid = "warnipizine"
/datum/on_mob/warnipizine
/datum/on_mob/warnipizine/react(quaziamt, R, mob/M)
	var/F = new /obj/hud_effect/fog()
	var/HF = new /obj/hud_effect/heavy_fog()

	if(quaziamt >= 0.99)

		if(!("spice" in csecond))
			csecond += "spice"


		if(M:hunger && prob(50))
			M:hunger--

		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "nutriment")
				M:euphoria += pick(1, 2)

			if(RE.id == "sugar")
				M:euphoria += pick(1, 2)

			if(RE.id == "plant oil")
				M:euphoria += pick(1, 2)

			if(RE.id == "carboxylic acid")
				M:euphoria += pick(1, 2)


		if(prob(quaziamt * 20) + M:values_weed * 10)
			M:show_message("\blue [M:name] laughs.", "\green Damn, you're high.")
			M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
			M:euphoria += 3 + M:values_weed
			if(M:psi < 15)
				M:psi++

		if(prob(3) && M:client)
			M:client:screen += F
			spawn(60 - 30 * M:cetamed)
				for(var/obj/hud_effect/H in M:client:screen)
					if(!istype(H, /obj/hud_effect/eye))
						M:client:screen -= H

		else if(prob(quaziamt) && M:client)
			M:client:screen += HF
			spawn(80 - 40 * M:cetamed)
				for(var/obj/hud_effect/H in M:client:screen)
					if(!istype(H, /obj/hud_effect/eye))
						M:client:screen -= H

			M:calm++

		if(quaziamt >= 2 && prob(quaziamt * 4.5 + 8))
			M << "\red You feel nervous"
			if(M:calm > 10)
				M:calm--
			if(prob(1 + round(quaziamt / 2) - round(M:cetamed / 1.5)))
				M << pick("\red БЛЯДЬ НАС ЗАПАЛЯТ СЕЙЧАС ПРЯЧЕМ СТАФФ", "\red СУКА МНЕ ПИЗДЕЦ НАХУЯ Я СТОЛЬКО СКУРИЛ", "\red БЛЯТЬ МУСОРА УЛЫБАЕМСЯ И МАШЕМ", "\red БЛЯ МАМКА ЖЕ СЕЙЧАС ВЕРНЕТСЯ ЧО ДЕЛАТЬ")
				M:calm -= 2 + M:values_weed
			if(quaziamt >= 2.5)
				if(prob(60))
					M:stun(round(quaziamt / 2))
				M:show_message("\red [M:name] looks pale.")
				if(quaziamt >= 6.6)
					M:acid_dream(quaziamt / 2)
					M:psychosis += round(quaziamt / 12)

		if(M:wounds && (prob(45) && quaziamt > 0.03))
			M:woundcure(1)
		if(prob(10))
			M:heal(5, "brute")
	spawn(0) M:remove_chem("warnipizine", 0.33)

/datum/on_mob/ASD0
	rid = "ASD-F0"
/datum/on_mob/ASD0
/datum/on_mob/ASD0/react(quaziamt, R, mob/M)
	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "regenerite" && RE.amount >= 0.5)
			M:remove_chem("regenerite", 0.5)
			M:damaga(pick(2, 3), "organ")

	if(quaziamt >= 10)
		if(prob(40))
			M << "\red You're ODed on some medicine! Found some antidote ASAP!"
			M:damaga(3, "organ")
			if(prob(33))
				M:vomit_red()
				M:chronoclock++
	else
		if(quaziamt >= 1)
			M:heal(5, "brute")

	spawn(0) M:remove_chem("ASD-F0", 0.5)
/datum/on_mob/rhinestones
	rid = "rhinestones"
/datum/on_mob/rhinestones
/datum/on_mob/rhinestones/react(quaziamt, R, mob/M)
	if(quaziamt >= 1 && M:maggot)
		M:heal(rand(1, 3), "brute")
		M:heal(1, "organ")
		if(prob(66))
			M:heal(1, "burn")
	spawn(0) M:remove_chem("rhinestones", 1)
/datum/on_mob/warpotoxin
	rid = "warpotoxin"
/datum/on_mob/warpotoxin
/datum/on_mob/warpotoxin/react(quaziamt, R, mob/M)
	if(quaziamt >= 3 && prob(33))
		M:damaga(1, pick("organ", "brute"))
	if(prob(25))
		M:blink(3, M:loc)
	spawn(0) M:remove_chem("warpotoxin", 0.25)
/datum/on_mob/mutagenerite
	rid = "mutagenerite"
/datum/on_mob/mutagenerite
/datum/on_mob/mutagenerite/react(quaziamt, R, mob/M)
	if(quaziamt >= 1)
		M:heal(quaziamt * 10, "brute")
		M:heal(quaziamt * 10, "organ")
		M:heal(quaziamt * 10, "burn")
		if(M:wounds)
			M:woundcure(5)
	spawn(0) M:remove_chem("mutagenerite", quaziamt)
/datum/on_mob/ambrosine
	rid = "ambrosine"
/datum/on_mob/ambrosine
/datum/on_mob/ambrosine/react(quaziamt, R, mob/M)
	if(quaziamt >= 0.5)
		if(M:euphoria > 40)
			M:heal(8, "brute")
			M:heal(8, "organ")
			M:heal(8, "burn")
			if(M:wounds)
				M:woundcure()
		else if(M:euphoria > 20)
			M:heal(6, "brute")
			M:heal(6, "organ")
			M:heal(6, "burn")
			if(M:wounds && prob(66))
				M:woundcure(M:wounds)
		if(M:euphoria > 10)
			M:heal(3, "brute")
			M:heal(3, "organ")
			M:heal(3, "burn")
			if(M:wounds && prob(33))
				M:woundcure(1)
	spawn(0) M:remove_chem("ambrosine", 0.5)
/datum/on_mob/fuel
	rid = "fuel"
/datum/on_mob/fuel
/datum/on_mob/fuel/react(quaziamt, R, mob/M)
	if(prob(50) && quaziamt >= 1)
		M:damaga(pick(1, 2), "organ")
		if(prob(10))
			M:sick()

	M:remove_chem("fuel", 0.5)
/datum/on_mob/fibgenerite
	rid = "fibgenerite"
/datum/on_mob/fibgenerite
/datum/on_mob/fibgenerite/react(quaziamt, R, mob/M)
	if(quaziamt >= 0.5)
		M:heal(10, "burn")
		if(M:wounds && prob(66))
			M:woundcure(1)
		if(prob(50))
			M:heal(1, "brute")
		M:heal(1, "organ")
	spawn(0) M:remove_chem("fibgenerite", 0.5)
/datum/on_mob/stalkotoxin
	rid = "stalkotoxin"
/datum/on_mob/stalkotoxin
/datum/on_mob/stalkotoxin/react(quaziamt, R, mob/M)
	if(quaziamt >= 1)
		M:damaga(rand(1, 4) + M:aids * 2, "organ")
		if(prob(10))
			M:sick()

	spawn(0) M:remove_chem("stalkotoxin", 0.25)
/datum/on_mob/pogankeepeptide
	rid = "pogankeepeptide"
/datum/on_mob/pogankeepeptide
/datum/on_mob/pogankeepeptide/react(quaziamt, R, mob/M)
	if(quaziamt >= 7)
		M:damaga(rand(1, 3), "organ")
		if(prob(10))
			M:sick()
	else



		M:damaga(1, "organ")
	if(quaziamt >= 6)
		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "ethanol" && RE.amount >= 4)
				M:berserk = 1
				M:empowered += 5
				M:brutalize(1)
	if(quaziamt < 6)
		M:berserk = 0
		M:empowered -= 5
	spawn(0)
		M:remove_chem("pogankeepeptide", 0.33)
/datum/on_mob/iodine
	rid = "iodine"
/datum/on_mob/iodine
/datum/on_mob/iodine/react(quaziamt, R, mob/M)
	if(quaziamt >= 1)
		M:damaga(1, "organ")
		if(prob(5 + min(quaziamt, 10)))
			M:sick()
	spawn(0) M:remove_chem("iodine", 0.5)
/datum/on_mob/starsalve
	rid = "starsalve"
/datum/on_mob/starsalve
/datum/on_mob/starsalve/react(quaziamt, R, mob/M)
	if(prob(5 + min(30, quaziamt / 2)))
		M << "\red You feel bad."
		M:stun(1)
		M:torment(3)
	if(quaziamt >= 0.5)
		M:damaga(rand(8, 12), "organ")
		if(prob(33 + quaziamt))
			M:damaga(2, "burn")
		if(prob(5 + quaziamt))
			M:sick()
	spawn(0) M:remove_chem("starsalve", 0.25)
/datum/on_mob/mercury
	rid = "mercury"
/datum/on_mob/mercury
/datum/on_mob/mercury/react(quaziamt, R, mob/M)
	if(M:syphilis && prob(25))
		M << "\red Your organism is fighting against infection!"
		if(prob(50))
			M << "\green You feel somewhat better."
			M:syphilis = 0
	if(quaziamt >= 1)
		M:damaga(pick(1, 2), "organ")
		if(prob(5 + min(10, quaziamt)))
			M:sick()
	spawn(0) M:remove_chem("mercury", 0.5)
/datum/on_mob/mercury_red
	rid = "red mercury"
/datum/on_mob/mercury_red
/datum/on_mob/mercury_red/react(quaziamt, R, mob/M)
	if(M:syphilis && prob(25))
		M << "\red Your organism is fighting against infection!"
		if(prob(50))
			M << "\green You feel somewhat better."
			M:syphilis = 0
	if(quaziamt >= 1)
		M:damaga(3, "organ")
		if(prob(5 + min(10, quaziamt)))
			M:sick()
	spawn(0) M:remove_chem("red mercury", 0.5)
/datum/on_mob/amalgam
	rid = "amalgam"
/datum/on_mob/amalgam
/datum/on_mob/amalgam/react(quaziamt, R, mob/M)
	if(quaziamt >= 1)
		M:damaga(rand(1, 4), "organ")
		if(M:syphilis && prob(25))
			M << "\red Your organism is fighting against infection!"
			if(prob(50))
				M << "\green You feel somewhat better."
				M:syphilis = 0
		if(prob(5 + quaziamt))
			M:sick()
	spawn(0) M:remove_chem("amalgam", 0.25)
/datum/on_mob/phosphorus
	rid = "phosphorus"
/datum/on_mob/phosphorus
/datum/on_mob/phosphorus/react(quaziamt, R, mob/M)
	if(quaziamt >= 1)
		M:damaga(pick(1, 2), "organ")
		if(prob(1 + min(quaziamt, 9)))
			M:sick()
	spawn(0) M:remove_chem("phosphorus", 0.5)
/datum/on_mob/hydrochloric_acid
	rid = "hydrochloric acid"
/datum/on_mob/hydrochloric_acid
/datum/on_mob/hydrochloric_acid/react(quaziamt, R, mob/M)
	if(quaziamt >= 1)
		M:damaga(rand(1, 3), "organ")
		if(prob(10))
			M:sick()
	spawn(0) M:remove_chem("hydrochloric acid", 0.1)
/datum/on_mob/sulfuric_acid
	rid = "sulfuric acid"
/datum/on_mob/sulfuric_acid
/datum/on_mob/sulfuric_acid/react(quaziamt, R, mob/M)
	if(quaziamt >= 0.5)
		M:damaga(rand(1, 4), "organ")
		if(prob(15))
			M:sick()
	spawn(0) M:remove_chem("sulfuric acid", 0.1)
/datum/on_mob/nitric_acid
	rid = "nitric acid"
/datum/on_mob/nitric_acid
/datum/on_mob/nitric_acid/react(quaziamt, R, mob/M)
	if(quaziamt >= 0.5)
		M:damaga(rand(1, 4), "organ")
		if(prob(15))
			M:sick()
	spawn(0) M:remove_chem("nitric acid", 0.1)
/datum/on_mob/aqua_regia
	rid = "aqua regia"
/datum/on_mob/aqua_regia
/datum/on_mob/aqua_regia/react(quaziamt, R, mob/M)
	if(quaziamt >= 0.3)
		M:damaga(rand(4, 7), "organ")
		if(prob(20))
			M:sick()
	spawn(0) M:remove_chem("aqua regia", 0.1)
/datum/on_mob/polytrinic_acid
	rid = "polytrinic acid"
/datum/on_mob/polytrinic_acid
/datum/on_mob/polytrinic_acid/react(quaziamt, R, mob/M)
	M:damaga(rand(6, 10) + M:aids * 2, "organ")
	if(prob(25))
		M:sick()
	spawn(0) M:remove_chem("polytrinic acid", 0.05)
/datum/on_mob/milk
	rid = "milk"
/datum/on_mob/milk
/datum/on_mob/milk/react(quaziamt, R, mob/M)
	if(M:hunger <= 390 && quaziamt >= 1)
		M:hunger += 10
	else if(quaziamt >= 1)
		M:hunger = 400
	spawn(0) M:remove_chem("milk", 1)
/datum/on_mob/sugar
	rid = "sugar"
/datum/on_mob/sugar
/datum/on_mob/sugar/react(quaziamt, R, mob/M)
	if(M:hunger <= 385 && quaziamt >= 1)
		M:hunger += 15
	else if(quaziamt >= 1)
		M:hunger = 400
	spawn(0) M:remove_chem("sugar", 1)
/datum/on_mob/nutriment
	rid = "nutriment"
/datum/on_mob/nutriment
/datum/on_mob/nutriment/react(quaziamt, R, mob/M)
	if(M:hunger <= 380 && quaziamt >= 1)
		M:hunger += 20
	else if(quaziamt >= 1)
		M:hunger = 400
	spawn(0) M:remove_chem("nutriment", 1)
/datum/on_mob/condensed_milk
	rid = "condensed milk"
/datum/on_mob/condensed_milk
/datum/on_mob/condensed_milk/react(quaziamt, R, mob/M)
	if(M:hunger <= 380 && quaziamt >= 1)
		M:hunger += 20
	else if(quaziamt >= 1)
		M:hunger = 400
	spawn(0) M:remove_chem("condensed milk", 1)
/datum/on_mob/sgushenka
	rid = "sgushenka"
/datum/on_mob/sgushenka
/datum/on_mob/sgushenka/react(quaziamt, R, mob/M)
	if(M:hunger < 380 && quaziamt >= 1)
		M:hunger += 20
	else if(quaziamt >= 1)
		M:hunger = 400
	M:damaga(2 + M:aids * 2, "organ")
	spawn(0) M:remove_chem("sgushenka", 1)
/datum/on_mob/plant_oil
	rid = "plant oil"
/datum/on_mob/plant_oil
/datum/on_mob/plant_oil/react(quaziamt, R, mob/M)
	if(M:hunger < 375 && quaziamt >= 1)
		M:hunger += 25
	else if(quaziamt >= 1)
		M:hunger = 400
	spawn(0) M:remove_chem("plant oil", 1)
/datum/on_mob/water
	rid = "water"
/datum/on_mob/water
/datum/on_mob/water/react(quaziamt, R, mob/M)
	spawn(0) M:remove_chem("water", 1)
/datum/on_mob/foam
	rid = "foam"
/datum/on_mob/foam
/datum/on_mob/foam/react(quaziamt, R, mob/M)
	if(prob(15))
		if(quaziamt > 0.1)
			M << "\red A foam comes from your throat!"
			for(var/mob/ME in view(M))
				ME << "\red [M] spews out some foam!"
			var/F = new /obj/foam(M:loc)
			switch(M:dir)
				if(1)
					F:fly(locate(M:x, M:y + 2, M:z))
				if(2)
					F:fly(locate(M:x, M:y - 2, M:z))
				if(8)
					F:fly(locate(M:x - 2, M:y, M:z))
				if(4)
					F:fly(locate(M:x + 2, M:y, M:z))
				else
					F:fly(locate(M:x, M:y - 2, M:z))
		spawn(0) M:remove_chem("foam", 0.5)

/datum/on_mob/ethanol
	rid = "ethanol"
/datum/on_mob/ethanol
/datum/on_mob/ethanol/react(quaziamt, R, mob/M)
	if(!("alchonauts" in csecond))
		csecond += "alchonauts"
	if(!("hobos" in csecond))
		csecond += "hobos"
	if(!("drunkards" in csecond))
		csecond += "drunkards"

	if(prob(20) && M:tension)
		M:tension--

	M:euphoria += 3 + M:values_downers

	if(M:drunk >= 5 && prob(M:epilepsy))
		M:seizure(2 + min(round(M:epilepsy / 3), 4))

	if(M:drunk >= 4)
		M:nausea++

	if(M:drunk < round(quaziamt / 5) && M:drunk < 6)
		M:drunk += 1
	if(R:amount >= 0.2)
		M:al_tick = 10
	M:remove_chem("methanol", 0.2)
	M:remove_chem("ethanol", 0.2)

/datum/on_mob/methanol
	rid = "methanol"
/datum/on_mob/methanol
/datum/on_mob/methanol/react(quaziamt, R, mob/M)
	if(!("steklomoy" in csecond))
		csecond += "steklomoy"

	if(prob(40))
		M:nausea += 3

	if(prob(50))
		M:damaga(1 + M:aids * 2, "organ")
	if(prob(10) + round(quaziamt / 2))
		M << "\red The world around you suddenly fell in darkness..."
		M:blind(30)

	spawn(0) M:remove_chem("methanol", 0.1)
/datum/on_mob/ammonia
	rid = "ammonia"
	rid = "ammonia"
/datum/on_mob/ammonia/react(quaziamt, R, mob/M)
	if(prob(66))
		M:nausea += pick(1, 2)
	if(prob(25))
		M:damaga(1, "organ")

	spawn(0) M:remove_chem("ammonia", 0.5)
/datum/on_mob/ammonium_hydroxide
	rid = "ammonium hydroxide"
/datum/on_mob/ammonium_hydroxide
/datum/on_mob/ammonium_hydroxide/react(quaziamt, R, mob/M)
	if(prob(66))
		M:nausea += pick(1, 2)
	M:damaga(rand(1, 3), "organ")

	spawn(0) M:remove_chem("ammonium hydroxide", 0.25)



/datum/on_mob/ammonia/react(quaziamt, R, mob/M)
	M:damaga(1, "organ")

	spawn(0) M:remove_chem("ammonia", 0.25)
/datum/on_mob/methyl_acetate
	rid = "methyl acetate"
/datum/on_mob/methyl_acetate
/datum/on_mob/methyl_acetate/react(quaziamt, R, mob/M)
	M:damaga(1, "organ")
	spawn(0) M:remove_chem("methyl_acetate", 0.3)
/datum/on_mob/anhydride
	rid = "acetic anhydride"
/datum/on_mob/anhydride
/datum/on_mob/anhydride/react(quaziamt, R, mob/M)
	M:damaga(pick(1, 2), "organ")
	spawn(0) M:remove_chem("methyl_acetate", 0.25)
/datum/on_mob/yeast
	rid = "yeast"
/datum/on_mob/yeast
/datum/on_mob/yeast/react(quaziamt, R, mob/M)
	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "nutriment" || RE.id == "sugar")
			M:add_chem("ethanol", "ethanol", 1, 0)
			M:remove_chem(RE.id, 1)
	spawn(0) M:remove_chem("yeast", 1)
/datum/on_mob/blood
	rid = "blood"
/datum/on_mob/blood
/datum/on_mob/blood/react(quaziamt, R, mob/M)
	spawn(0) M:remove_chem("blood", quaziamt)
/datum/on_mob/aids
	rid = "AIDS"
/datum/on_mob/aids
/datum/on_mob/aids/react(quaziamt, R, mob/M)
	M:aids = 1
	spawn(0) M:remove_chem("AIDS", quaziamt)


/datum/on_mob/caffeine
	rid = "caffeine"

/datum/on_mob/caffeine
/datum/on_mob/caffeine/react(quaziamt, R, mob/M)
	if(M:drowsy)
		M:drowsy = 0

	if(M:calm > 15 && prob(quaziamt * 4))
		M:calm--

	if(M:stunned && (!M:parastunned && prob(75)))
		M:stuntime--

	if(quaziamt > 20)
		M:thrill += rand(2, 5)
	else
		if(quaziamt > 10)
			M:thrill += 2

	spawn(0) M:remove_chem("caffeine", 0.5)

/datum/on_mob/adrenaline
	rid = "adrenaline"
	stim = 1
/datum/on_mob/adrenaline
/datum/on_mob/adrenaline/react(quaziamt, R, mob/M)
	if(M:drowsy)
		M:drowsy = 0

	if(M:stuntime > 1 && !M:parastunned)
		M:stuntime = 1

	if(quaziamt > 5 && prob(quaziamt * 2))
		M:damaga(rand(1, 10), "organ")
		M:calm -= 1
	spawn(0)
		M:remove_chem("adrenaline", 0.1)

/datum/on_mob/speed
	rid = "amphetamine"
	stim = 1

/datum/on_mob/speed

/datum/on_mob/speed/react(quaziamt, R, mob/M)
	M:stim++

	if("chromosome" in M:mutations)
		if(prob(10))
			M:says_xynta = 0
			M << "\green You feel smarter for a second."
			if(prob(1))
				M << "\green \bold And MUCH smarter!"
				M:mutcure_target("chromosome")

	if(prob(33))
		M:stim++

	if(M:stunned && !M:parastunned)
		M:stuntime--

	if(M:libido < 80)
		M:libido += pick(1, 2)

	if(M:drowsy)
		M:drowsy = 0

	if(M:calm > 15 && prob(33 + quaziamt * 4))
		M:calm--
	else if(M:calm < 15 && (quaziamt < 4.5 && prob(10 + quaziamt)))
		M:calm++

	M:euphoria += 2 + M:values_stim
	if(prob(15 + M:values_stim * 5))
		M << "\blue You have an urge to do something useful."
		M:euphoria += rand(2, 4)

	if(quaziamt >= 4.5 && (prob(quaziamt) && M:client))
		M:psychosis += 5
		M:thrill++
		M:client:party_temporal(quaziamt)
		if(prob(5))
			M:mindbreak(1, 2)
		if(prob(3))
			M:mindbreak(1, 4)
		if(prob(50))
			M:damaga(rand(1, 3), "organ")
		M:calm -= 2
	else if(quaziamt >= 4 && M:thrill < 13)
		M:thrill++

	spawn(0)
		M:st_tick = 5
		M:remove_chem("amphetamine", 0.08)

/datum/on_mob/dextrospeed
	rid = "dextroamphetamine"
	stim = 1
/datum/on_mob/dextrospeed
/datum/on_mob/dextrospeed/react(quaziamt, R, mob/M)
	M:stim++

	if(prob(33))
		M:stim++

	if("chromosome" in M:mutations)
		if(prob(10))
			M:says_xynta = 0
			M << "\green You feel smarter for a second."
			if(prob(2))
				M << "\green \bold And MUCH smarter!"
				M:mutcure_target("chromosome")

	if(M:stunned && !M:parastunned)
		if(M:stuntime > 5)
			M:stuntime = 5
		else
			M:stuntime--

	if(M:libido < 80)
		M:libido += pick(1, 2)

	if(M:drowsy)
		M:drowsy = 0

	if(M:calm > 15 && prob(60 + quaziamt * 4))
		M:calm--
	else if(M:calm < 15 && (quaziamt < 4.5 && prob(30 + quaziamt * 2)))
		M:calm++

	M:euphoria += rand(2, 4) + M:values_stim
	if(prob(25 + M:values_stim * 5))
		M << "\blue You have an urge to do something useful."
		M:euphoria += rand(3, 8)

	if(quaziamt >= 4.5 && (prob(quaziamt) && M:client))
		M:psychosis += 5
		M:thrill++
		M:client:party_temporal(quaziamt)
		if(prob(5))
			M:mindbreak(1, 2)
		if(prob(3))
			M:mindbreak(1, 4)
		if(prob(5))
			M:damaga(rand(1, 3), "organ")
		M:calm -= 1
	else if(quaziamt >= 4 && M:thrill < 13)
		M:thrill++

	spawn(0)
		M:st_tick = 5
		M:remove_chem("dextroamphetamine", 0.08)

/datum/on_mob/mdpv
	rid = "MDPV"
	stim = 1
/datum/on_mob/mdpv
/datum/on_mob/mdpv/react(quaziamt, R, mob/M)
	M:stim += pick(1, 2)

	if("chromosome" in M:mutations)
		if(prob(10))
			M:says_xynta = 0
			M << "\green You feel smarter for a second."
			if(prob(1))
				M << "\green \bold And MUCH smarter!"
				M:mutcure_target("chromosome")

	if(M:calm > 15 && prob(quaziamt * 3))
		M:calm--
	else if(M:calm < 15 && (quaziamt < 3.7 && prob(quaziamt)))
		M:calm++
	if(quaziamt > 0.1)

		if(M:stunned && !M:parastunned)
			M:stuntime--

		if(M:libido < 80)
			M:libido += pick(1, 2)

		if(M:drowsy)
			M:drowsy = 0

	M:euphoria += 2 + M:values_stim
	if(prob(10 + M:values_stim * 4))
		M << "\blue You have an urge to do something useful."
		M:euphoria += rand(1, 3)

	if(quaziamt >= 3.7 && (prob(quaziamt) && M:client))
		M:psychosis += 5
		M:thrill += rand(1, 2)
		M:client:party_temporal(quaziamt)
		if(prob(3))
			M:mindbreak(1, 2)
		if(prob(2))
			M:mindbreak(1, 4)
		if(prob(50))
			M:damaga(round(quaziamt / 5), "organ")
		M:calm -= 2
	else if(quaziamt >= 3.5 && M:thrill < 13)
		M:thrill++

	spawn(0)
		M:st_tick = 5
		M:remove_chem("MDPV", 0.15)

/datum/on_mob/meth
	rid = "methamphetamine"
	stim = 1
/datum/on_mob/meth
/datum/on_mob/meth/react(quaziamt, R, mob/M)
	if(!("vint" in csecond))
		csecond += "vint"
	if(!("meth" in csecond))
		csecond += "meth"

	M:stim += pick(1, 2)

	if("chromosome" in M:mutations)
		if(prob(10))
			M:says_xynta = 0
			M << "\green You feel smarter for a second."
			if(prob(2))
				M << "\green \bold And MUCH smarter!"
				M:mutcure_target("chromosome")

	if(quaziamt > 0.1)

		if(M:stunned && !M:parastunned)
			M:stuntime--

		if(M:libido < 100)
			M:libido += pick(1, 2)

		if(M:drowsy)
			M:drowsy = 0

		M:euphoria++
		if(prob(20 + M:values_stim * 5))
			M << "\blue You have an urge to do something useful."
			M:euphoria += rand(2, 4) + M:values_stim

		if(prob(33 + quaziamt * 8))

			if(M:calm > 15 && prob(quaziamt * 5))
				M:calm--
			else
				if(M:calm < 15 && (quaziamt < 3.7 && prob(quaziamt * 1.5)))
					M:calm++
		if(quaziamt >= 3.7 && (prob(quaziamt) && M:client))
			M:psychosis += 5
			M:thrill += rand(1, 2)
			M:client:party_temporal(quaziamt)
			if(prob(5))
				M:mindbreak(1, 2)
			if(prob(5))
				M:mindbreak(1, 4)
			if(prob(70))
				M:damaga(2, "organ")
				M:calm -= 1
		else
			if(quaziamt >= 2.5 && M:thrill < 13)
				M:thrill++

	M:st_tick = 6
	M:remove_chem("methamphetamine", 0.05)

/datum/on_mob/dextrometh
	rid = "dextromethamphetamine"
	stim = 1
/datum/on_mob/dextrometh
/datum/on_mob/dextrometh/react(quaziamt, R, mob/M)
	if(!("vint" in csecond))
		csecond += "vint"
	if(!("meth" in csecond))
		csecond += "meth"

	M:stim += pick(1, 2)

	if("chromosome" in M:mutations)
		if(prob(20))
			M:says_xynta = 0
			M << "\green You feel smarter for a second."
			if(prob(2))
				M << "\green \bold And MUCH smarter!"
				M:mutcure_target("chromosome")

	if(quaziamt > 0.1)

		if(M:stunned && !M:parastunned)
			M:stuntime--

			if(M:stunned)
				M:stuntime--

		if(M:libido < 100)
			M:libido += pick(2, 3)


		if(M:drowsy)
			M:drowsy = 0

		M:euphoria += 3 + M:values_stim
		if(prob(20 + M:values_stim * 5))
			M << "\blue You have an urge to do something useful."
			M:euphoria += rand(3, 6) + M:values_stim * 2

		if(prob(33 + quaziamt * 10))

			if(M:calm > 15 && prob(quaziamt * 5))
				M:calm--
			else
				if(M:calm < 15 && (quaziamt < 2.1 && prob(quaziamt * 1.5)))
					M:calm++
		if(quaziamt >= 3.7 && (prob(quaziamt) && M:client))
			M:psychosis += 5
			M:thrill += rand(1, 2)
			M:client:party_temporal(quaziamt)
			if(prob(5))
				M:mindbreak(1, 2)
			if(prob(3))
				M:mindbreak(1, 4)
			if(prob(70))
				M:damaga(2, "organ")
				M:calm--
		else
			if(quaziamt >= 2.1 && M:thrill < 13)
				M:thrill++


	M:st_tick = 6
	M:remove_chem("dextromethamphetamine", 0.04)

/datum/on_mob/ephedrine
	rid = "ephedrine"
	stim = 1
/datum/on_mob/ephedrine
/datum/on_mob/ephedrine/react(quaziamt, R, mob/M)
	if(M:stunned && !M:parastunned)
		M:stuntime--

	if(M:drowsy)
		M:drowsy = 0

	if(quaziamt > 0.25 && (M:calm > 15 && prob(quaziamt * 4)))
		M:calm--
	else if(quaziamt > 0.25 && (M:calm < 15 && (quaziamt < 10 && prob(quaziamt))))
		M:calm++

	if(quaziamt > 6)

		if("chromosome" in M:mutations)
			if(prob(10))
				M:says_xynta = 0
				M << "\green You feel smarter for a second."
				if(prob(1))
					M << "\green \bold And MUCH smarter!"
					M:mutcure_target("chromosome")

		M:euphoria++

		if(prob(quaziamt))
			M:euphoria += pick(1, 2)

	if(quaziamt >= 13 && M:thrill < 10)
		M:thrill++
	else
		if(quaziamt >= 10 && (prob(quaziamt) && M:client))
			M:thrill++
			M:client:party_temporal(quaziamt)
			if(prob(50))
				M:damaga(round(quaziamt / 10), "organ")
				M:calm -= 1

	spawn(0)
		if(prob(10))
			M:st_tick = 2
		M:remove_chem("ephedrine", 0.25)

/datum/on_mob/pseudoephedrine
	rid = "pseudoephedrine"
	stim = 1
/datum/on_mob/pseudoephedrine
/datum/on_mob/pseudoephedrine/react(quaziamt, R, mob/M)
	if(M:stunned && !M:parastunned)
		M:stuntime--

	if(M:drowsy)
		M:drowsy = 0

	if(quaziamt > 0.33 && (M:calm > 15 && prob(quaziamt * 4)))
		M:calm--
	else if(quaziamt > 0.33 && (M:calm < 15 && (quaziamt < 10 && prob(quaziamt))))
		M:calm++

	if(quaziamt > 8)

		if("chromosome" in M:mutations)
			if(prob(10))
				M:says_xynta = 0
				M << "\green You feel smarter for a second."
				if(prob(1))
					M << "\green \bold And MUCH smarter!"
					M:mutcure_target("chromosome")

		M:euphoria++

		if(prob(quaziamt))
			M:euphoria += pick(1, 2)

	if(quaziamt >= 13 && M:thrill < 10)
		M:thrill++

	if(quaziamt >= 10 && (prob(quaziamt) && M:client))
		M:thrill++
		M:client:party_temporal(quaziamt)
		if(prob(50))
			M:damaga(round(quaziamt / 10), "organ")
			M:calm -= 1
	spawn(0)
		if(prob(10))
			M:st_tick = 2
		M:remove_chem("pseudoephedrine", 0.33)

/datum/on_mob/modafinil
	rid = "modafinil"
	stim = 1
/datum/on_mob/modafinil
/datum/on_mob/modafinil/react(quaziamt, R, mob/M)
	if(M:stunned && !M:parastunned)
		M:stuntime--

	if(M:drowsy)
		M:drowsy = 0

	if(quaziamt > 0.25 && (M:calm > 15 && prob(quaziamt * 4)))
		M:calm--
	else if(quaziamt > 0.25 && (M:calm < 15 && (quaziamt < 10 && prob(quaziamt))))
		M:calm++

	if(quaziamt > 6)

		if(prob(10))
			M:says_xynta = 0
			M << "\green You feel smarter for a second."
			if(prob(1) && ("chromosome" in M:mutations))
				M << "\green \bold And MUCH smarter!"
				M:mutcure_target("chromosome")

	if(quaziamt >= 13 && M:thrill < 10)
		M:thrill++
	else
		if(quaziamt >= 10 && (prob(quaziamt) && M:client))
			M:thrill++
			M:client:party_temporal(quaziamt)
			if(prob(50))
				M:damaga(round(quaziamt / 10), "organ")
				M:calm -= 1

	spawn(0)
		if(prob(10))
			M:st_tick = 2
		M:remove_chem("modafinil", 0.25)

/datum/on_mob/methcathinone
	rid = "methcathinone"
	stim = 1
/datum/on_mob/methcathinone
/datum/on_mob/methcathinone/react(quaziamt, R, mob/M)
	M:stim += 2

	if(prob(10))
		M:says_xynta = 0
		M << "\green You feel smarter for a second."
		if(prob(1) && ("chromosome" in M:mutations))
			M << "\green \bold And MUCH smarter!"
			M:mutcure_target("chromosome")

	if(M:stunned && !M:parastunned)
		M:stuntime--

	if(M:libido < 80)
		M:libido += pick(1, 2)

	if(M:drowsy)
		M:drowsy = 0

	if(M:calm > 15 && prob(quaziamt * 50))
		M:calm--
	else if(M:calm < 15 && (quaziamt < 4 && prob(quaziamt * 20)))
		M:calm++

	M:euphoria += 2 + M:values_stim
	if(prob(20 + M:values_stim * 5))
		M << "\blue You have an urge to do something useful."
		M:euphoria += 4 + M:values_stim

	if(quaziamt >= 4 && (prob(quaziamt * 2.5) && M:client))
		M:psychosis += 5
		M:thrill++
		M:client:party_temporal(quaziamt)
		if(prob(5))
			M:mindbreak(1, 2)
		if(prob(3))
			M:mindbreak(1, 4)
		if(prob(50))
			M:damaga(rand(2, 6), "organ")
			M:calm -= 1

	if(quaziamt >= 3.8 && M:thrill < 10)
		M:thrill++

	spawn(0)
		M:st_tick = 4
		M:remove_chem("methcathinone", 0.1)

/datum/on_mob/ffa
	rid = "4-FA"
/datum/on_mob/ffa
/datum/on_mob/ffa/react(quaziamt, R, mob/M)
	M:stim += pick(1, 2)

	if("chromosome" in M:mutations)
		if(prob(10))
			M:says_xynta = 0
			M << "\green You feel smarter for a second."
			if(prob(1))
				M << "\green \bold And MUCH smarter!"
				M:mutcure_target("chromosome")

	if(M:stunned && !M:parastunned)
		M:stuntime--

	if(M:libido < 80)
		M:libido += pick(1, 2)

	if(M:drowsy)
		M:drowsy = 0

	if(M:euphoria < 60)
		M:euphoria += rand(3, 9) + min(0, M:values_stim * 2)
	else
		M:euphoria += rand(3, 6) + M:values_stim

	if(M:calm > 15 && prob(quaziamt * 50))
		M:calm--
	else if(M:calm < 15 && (quaziamt <= 1.5 && prob(quaziamt * 15)))
		M:calm++
	if(quaziamt >= 3 && (prob(quaziamt) && M:client))
		M:psychosis += 5
		M:thrill++
		M:client:party_temporal(quaziamt)
		if(prob(5))
			M:mindbreak(1, 2)
		if(prob(10))
			M:mindbreak(1, 4)
		if(prob(70))
			M:damaga(round(quaziamt / 2.5), "organ")
			M:calm -= 1

	if(quaziamt > 1.5 && (M:thrill < 3 && prob(25)))
		M << "\red You feel jittery."
		M:thrill = 3
		M:calm--

	spawn(0)
		M:st_tick = 6
		M:remove_chem("4-FA", 0.03)


/datum/on_mob/meow
	rid = "mephedrone"
/datum/on_mob/meow
/datum/on_mob/meow/react(quaziamt, R, mob/M)
	M:stim += 2

	if("chromosome" in M:mutations)
		if(prob(10))
			M:says_xynta = 0
			M << "\green You feel smarter for a second."
			if(prob(1))
				M << "\green \bold And MUCH smarter!"
				M:mutcure_target("chromosome")

	if(M:stunned && !M:parastunned)
		M:stuntime--

	if(M:libido < 80)
		M:libido += pick(1, 2)

	if(M:drowsy)
		M:drowsy = 0

	M:euphoria += 7 + M:values_stim * 2

	if(M:calm > 15 && prob(quaziamt * 50))
		M:calm--
	else if(M:calm < 15 && (quaziamt <= 1.5 && prob(quaziamt * 15)))
		M:calm++
	if(quaziamt >= 3 && (prob(quaziamt) && M:client))
		M:psychosis += 5
		M:thrill++
		M:client:party_temporal(quaziamt)
		if(prob(5))
			M:mindbreak(1, 2)
		// was an unused label "label1" from the decompiler, with the next line indented under it.
		// The original has no prob() check here (pipes has if(prob(2))), so this always runs - probably an original bug.
		M:mindbreak(1, 4)
		if(prob(70))
			M:damaga(round(quaziamt / 2.5), "organ")
			M:calm -= 1

	if(quaziamt > 1.5 && (M:thrill < 3 && prob(25)))
		M << "\red You feel jittery."
		M:thrill = 3
		M:calm--

	spawn(0)
		M:st_tick = 6
		M:remove_chem("mephedrone", 0.03)

/datum/on_mob/cocaine
	rid = "cocaine"
/datum/on_mob/cocaine
/datum/on_mob/cocaine/react(quaziamt, R, mob/M)
	M:stim += 2

	if("chromosome" in M:mutations)
		if(prob(10))
			M:says_xynta = 0
			M << "\green You feel smarter for a second."
			if(prob(1))
				M << "\green \bold And MUCH smarter!"
				M:mutcure_target("chromosome")

	if(M:stunned && !M:parastunned)
		M:stuntime--

	if(M:libido < 80)
		M:libido += pick(1, 2)

	if(M:drowsy)
		M:drowsy = 0

	M:euphoria += 7 + M:values_stim * 2

	if(M:calm > 15 && prob(quaziamt * 50))
		M:calm--
	else if(M:calm < 15 && (quaziamt <= 1.5 && prob(quaziamt * 15)))
		M:calm++
	if(quaziamt >= 5 && (prob(quaziamt) && M:client))
		M:psychosis += 5
		M:thrill++
		M:client:party_temporal(quaziamt)
		if(prob(5))
			M:mindbreak(1, 2)
		// was an unused label "label1" from the decompiler, with the next line indented under it.
		// The original has no prob() check here (pipes has if(prob(2))), so this always runs - probably an original bug.
		M:mindbreak(1, 4)
		if(prob(70))
			M:damaga(round(quaziamt / 2.5), "organ")
			M:calm -= 1

	if(quaziamt > 2.5 && (M:thrill < 3 && prob(25)))
		M << "\red You feel jittery."
		M:thrill = 3
		M:calm--

	spawn(0)
		M:st_tick = 6
		M:remove_chem("cocaine", 0.06)

/datum/on_mob/pipes
	rid = "piperazine"
	stim = 1
/datum/on_mob/pipes
/datum/on_mob/pipes/react(quaziamt, R, mob/M)
	M:stim += pick(1, 2)

	if(M:calm > 15 && prob(quaziamt * 3))
		M:calm--
	else if(M:calm < 15 && (quaziamt < 3.7 && prob(quaziamt)))
		M:calm++
	if(quaziamt > 0.1)

		if(M:stunned && !M:parastunned)
			M:stuntime--

		if(M:libido < 80)
			M:libido += pick(1, 2)

		if(M:drowsy)
			M:drowsy = 0

		if(prob(33))
			M:damaga(1, "organ")

	M:euphoria += 1 + M:values_extasy
	if(prob(10))
		M << "\blue You have an urge to do something useful."
		M:euphoria += rand(1, 3)

	if(quaziamt >= 3 && (prob(quaziamt) && M:client))
		M:psychosis += 5
		M:thrill += rand(1, 2)
		M:client:party_temporal(quaziamt)
		if(prob(3))
			M:mindbreak(1, 2)
		if(prob(2))
			M:mindbreak(1, 4)
		if(prob(50))
			M:damaga(round(quaziamt / 5), "organ")
		M:calm -= 2
	else if(quaziamt >= 3.5 && M:thrill < 13)
		M:thrill++

	spawn(0)
		M:st_tick = 5
		M:remove_chem("piperazine", 0.15)

/datum/on_mob/bzp
	rid = "BZP"
/datum/on_mob/bzp
/datum/on_mob/bzp/react(quaziamt, R, mob/M)
	M:stim += 2

	if("chromosome" in M:mutations)
		if(prob(10))
			M:says_xynta = 0
			M << "\green You feel smarter for a second."
			if(prob(1))
				M << "\green \bold And MUCH smarter!"
				M:mutcure_target("chromosome")

	if(M:stunned && !M:parastunned)
		M:stuntime--

	if(M:libido < 80)
		M:libido += pick(1, 2)

	if(M:drowsy)
		M:drowsy = 0

	M:euphoria += 3 + M:values_stim

	if(M:calm > 15 && prob(quaziamt * 50))
		M:calm--
	else if(M:calm < 15 && (quaziamt <= 1.5 && prob(quaziamt * 15)))
		M:calm++
	if(quaziamt >= 3 && (prob(quaziamt) && M:client))
		M:psychosis += 5
		M:thrill++
		M:client:party_temporal(quaziamt)
		if(prob(5))
			M:mindbreak(1, 2)
		// was an unused label "label1" from the decompiler, with the next line indented under it.
		// The original has no prob() check here (pipes has if(prob(2))), so this always runs - probably an original bug.
		M:mindbreak(1, 4)
		if(prob(70))
			M:damaga(round(quaziamt / 2.5), "organ")
			M:calm -= 1

	if(quaziamt > 1.5 && (M:thrill < 3 && prob(25)))
		M << "\red You feel jittery."
		M:thrill = 3
		M:calm--

	spawn(0)
		M:st_tick = 6
		M:remove_chem("BZP", 0.05)

/datum/on_mob/fluoxetine
	rid = "fluoxetine"
/datum/on_mob/fluoxetine
/datum/on_mob/fluoxetine/react(quaziamt, R, mob/M)
	if(M:calm > 15 && prob(quaziamt * 5))
		M:calm--
	else if(M:calm < 15 && prob(quaziamt * 7))
		M:calm++

	if(M:euphoria < 15 && prob(95 - M:euphoria))
		M:euphoria++

	if(M:chronodepr)
		M:chronodepr--

	if(M:chronoclock)
		M:chronoclock = 0

	if(M:depression)
		M:depression--

	if(quaziamt > 10 && prob(quaziamt / 2))
		M:damaga(round(quaziamt / 5), "organ")
		M:calm -= 1
	for(var/datum/reagent/RE in M:blood_chem)
		if((RE.id == "selegiline" || RE.id == "harmaline") && (RE.amount >= 0.5 && quaziamt >= 0.5))
			M:ssyndrome++
		if(RE.id == "DXM" && (RE.amount >= 1 && (quaziamt >= 0.5 && prob(85))))
			M:ssyndrome++
		if(RE.id == "carbamazepine" && (RE.amount >= 0.8 && (quaziamt >= 0.5 && prob(80))))
			M:ssyndrome++
		if(RE.id == "tramadol" && (RE.amount >= 0.05 && (quaziamt >= 0.5 && prob(80))))
			M:ssyndrome++
	M:remove_chem("fluoxetine", 0.02)
/datum/on_mob/harmaline
	rid = "harmaline"
/datum/on_mob/harmaline
/datum/on_mob/harmaline/react(quaziamt, R, mob/M)
	if(M:calm > 15 && prob(quaziamt * 5))
		M:calm--
	else if(M:calm < 15 && prob(quaziamt * 7))
		M:calm++
	if(quaziamt > 10 && prob(quaziamt / 2))
		M:damaga(round(quaziamt / 5), "organ")
		M:calm -= 1

	if(M:euphoria < 5 && prob(95 - M:euphoria))
		M:euphoria++

	if(M:chronodepr)
		M:chronodepr--

	if(M:chronoclock)
		M:chronoclock = 0

	if(M:depression)
		M:depression--

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "fluoxetine" && (RE.amount >= 0.06 && quaziamt >= 0.06))
			M:ssyndrome++
		if(RE.id == "psilocybin" && (RE.amount > 0.1 && quaziamt > 0.06))
			M:add_chem(RE.id, RE.id, 0, 0.05)
		if((RE.id == "5-MeO-DMT" || (RE.id == "5-MeO-DiPT" || (RE.id == "DiPT" || (RE.id == "4-HO-MET" || (RE.id == "4-AcO-DMT" || RE.id == "5-Bromo-DMT"))))) && quaziamt >= 0.25)
			M:add_chem(RE.id, RE.id, RE.amount + min(0.5, quaziamt), 0)
			M:remove_chem("harmaline", quaziamt)
		if((RE.id == "amphetamine" || (RE.id == "dextromethamphetamine" || (RE.id == "methcathinone" || (RE.id == "methamphetamine" || (RE.id == "ephedrine" || (RE.id == "pseudoephedrine" || (RE.id == "MDPV" || (RE.id == "4-FA" || (RE.id == "mephedrone" || (RE.id == "cocaine" || (RE.id == "MDA" || (RE.id == "MDMA" || RE.id == "MDOH")))))))))))) && quaziamt > 0.2)
			M:ssyndrome++
			M:damaga(rand(2, 4), "organ")
		if(RE.id == "DMT" && (RE.amount >= 0.01 && quaziamt > 0.25))
			M:add_chem(RE.id, RE.id, RE.amount / 4 + min(0.5, quaziamt, 0))
			M:remove_chem("harmaline", quaziamt)

	M:remove_chem("harmaline", 0.02)

/datum/on_mob/selegiline
	rid = "selegiline"
/datum/on_mob/selegiline
/datum/on_mob/selegiline/react(quaziamt, R, mob/M)
	if(M:calm > 15 && prob(quaziamt * 5))
		M:calm--
	else if(M:calm < 15 && prob(quaziamt * 7))
		M:calm++

	if(quaziamt > 10 && prob(quaziamt / 2))
		M:damaga(round(quaziamt / 5), "organ")
		M:calm -= 1

	if(M:euphoria < 5 && prob(95 - M:euphoria))
		M:euphoria++

	if(M:chronodepr)
		M:chronodepr--

	if(M:chronoclock)
		M:chronoclock = 0

	if(M:depression)
		M:depression--

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "fluoxetine" && (RE.amount >= 0.06 && quaziamt >= 0.06))
			M:ssyndrome++
		if(RE.id == "psilocybin" && (RE.amount >= 0.1 && quaziamt > 0.06))
			M:add_chem(RE.id, RE.id, 0, 0.033)
		if((RE.id == "5-MeO-DMT" || (RE.id == "5-MeO-DiPT" || (RE.id == "DiPT" || (RE.id == "4-HO-MET" || (RE.id == "4-AcO-DMT" || RE.id == "5-Bromo-DMT"))))) && quaziamt >= 0.25)

			M:add_chem(RE.id, RE.id, RE.amount / 2 + min(0.5, quaziamt), 0)
			M:remove_chem("selegiline", quaziamt)
		if((RE.id == "amphetamine" || (RE.id == "dextromethamphetamine" || (RE.id == "methcathinone" || (RE.id == "methamphetamine" || (RE.id == "ephedrine" || (RE.id == "pseudoephedrine" || (RE.id == "MDPV" || (RE.id == "4-FA" || (RE.id == "mephedrone" || (RE.id == "cocaine" || (RE.id == "MDA" || (RE.id == "MDMA" || RE.id == "MDOH")))))))))))) && quaziamt > 0.2)
			M:ssyndrome++
			M:damaga(rand(2, 4), "organ")
		if(RE.id == "DMT" && quaziamt >= 0.25)
			M:add_chem(RE.id, RE.id, RE.amount / 6 + min(0.5, quaziamt), 0)
			M:remove_chem("selegiline", quaziamt)

	M:remove_chem("selegiline", 0.02)
/datum/on_mob/hash_oil
	rid = "hash oil"
/datum/on_mob/hash_oil
/datum/on_mob/hash_oil/react(quaziamt, R, mob/M)
	if(prob(10 + quaziamt * 2))
		M << "\green You feel relaxed."
	if(prob(quaziamt - 5))
		M << "\green That's some good stuff."
	M:add_chem("THC", "THC", pick(0.5, 1), 0)
	M:add_chem("CBD", "CBD", pick(0.5, 1), 0)
	if(prob(5 + quaziamt))
		M:add_chem("THC", "THC", pick(1, 2, 3), 0)
	spawn(0) M:remove_chem("hash oil", 1)
/datum/on_mob/THC
	rid = "THC"
/datum/on_mob/THC
/datum/on_mob/THC/react(quaziamt, R, mob/M)
	var/F = new /obj/hud_effect/fog()
	var/HF = new /obj/hud_effect/heavy_fog()

	if(M:psi < 20)
		M:psi++

	if(M:hunger >= 2)
		M:hunger -= 2
		M:euphoria++
	else
		M:hunger = 0

	if(M:chronoclock)
		if(prob(5))
			M:chronoclock = 0
		else
			M:chronoclock--

	if(M:chronodepr && prob(2))
		M << "\green You feel less depressed."
		M:chronodepr--

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "nutriment")
			M:euphoria += pick(1, 2)

		if(RE.id == "sugar")
			M:euphoria += pick(1, 2)

		if(RE.id == "plant oil")
			M:euphoria += pick(1, 2)

		if(RE.id == "carboxylic acid")
			M:euphoria += pick(1, 2)

	if(M:epilepsy > 0 && prob(66))
		M:epilepsy--

	if(M:euphoria < 30)
		M:euphoria += rand(1, 3)

	if(prob(5 + quaziamt * 2 + M:values_weed * 2))
		M:show_message("\blue [M:name] laughs.", "\green Damn, you're high.")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 3 + min(0, M:values_weed * 2)
		if(M:psi < 30)
			M:psi++

	if(prob(10) && M:client)
		M:client:screen += F
		spawn(60 - 30 * M:cetamed)
			for(var/obj/hud_effect/H in M:client:screen)
				if(!istype(H, /obj/hud_effect/eye))
					M:client:screen -= H
	else
		if(prob(quaziamt * 1.5) && M:client)
			M:client:screen += HF
			spawn(80 - 40 * M:cetamed)
				for(var/obj/hud_effect/H in M:client:screen)
					if(!istype(H, /obj/hud_effect/eye))
						M:client:screen -= H

			M:calm++

	if(prob(20))
		var/izmena = 1
		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "CBD" && RE:amount >= quaziamt * 0.8 || prob(M:cetamed * 50))
				izmena = 0
		spawn(0)
			if(izmena == 1)
				M << "\red You feel nervous"
				if(prob(1 + round(quaziamt / 2)))
					M << pick("\red БЛЯДЬ НАС ЗАПАЛЯТ СЕЙЧАС ПРЯЧЕМ СТАФФ", "\red СУКА МНЕ ПИЗДЕЦ НАХУЯ Я СТОЛЬКО СКУРИЛ", "\red БЛЯТЬ МУСОРА УЛЫБАЕМСЯ И МАШЕМ", "\red БЛЯ МАМКА ЖЕ СЕЙЧАС ВЕРНЕТСЯ ЧО ДЕЛАТЬ")
					M:calm -= 2
					M:psi += pick(1, 2)
				if(quaziamt >= 20)
					M:stun(round(quaziamt / 2))
					for(var/mob/ME in view(M))
						ME << "\red [M:name] looks pale."
					if(quaziamt >= 40)
						M:acid_dream(quaziamt / 2)

	spawn(0) M:remove_chem("THC", 0.2)
/datum/on_mob/JWH
	rid = "JWH-018"
/datum/on_mob/JWH
/datum/on_mob/JWH/react(quaziamt, R, mob/M)
	var/F = new /obj/hud_effect/fog()
	var/HF = new /obj/hud_effect/heavy_fog()

	if(M:chronoclock)
		if(prob(5))
			M:chronoclock = 0
		else
			M:chronoclock--

	if(M:chronodepr && prob(2))
		M << "\green You feel less depressed."
		M:chronodepr--

	if(!("spice" in csecond))
		csecond += "spice"


	if(M:hunger >= 2)
		M:hunger -= 2
		M:euphoria++
	else
		M:hunger = 0

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "nutriment")
			M:euphoria += pick(1, 2)

		if(RE.id == "sugar")
			M:euphoria += pick(1, 2)

		if(RE.id == "plant oil")
			M:euphoria += pick(1, 2)

		if(RE.id == "carboxylic acid")
			M:euphoria += pick(1, 2)


	if(prob(5 + quaziamt * 30 + M:values_weed * 2))
		M:show_message("\blue [M:name] laughs.", "\green Damn, you're high.")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 3 + M:values_weed
		if(M:psi < 20)
			M:psi++

		if(prob(quaziamt * 10))
			M:euphoria += pick(1, 2)

	if(prob(10) && M:client)
		M:client:screen += F
		spawn(60 - 30 * M:cetamed)
			for(var/obj/hud_effect/H in M:client:screen)
				if(!istype(H, /obj/hud_effect/eye))
					M:client:screen -= H
	else if(prob(quaziamt * 1.5) && M:client)
		M:client:screen += HF
		spawn(80 - 40 * M:cetamed)
			for(var/obj/hud_effect/H in M:client:screen)
				if(!istype(H, /obj/hud_effect/eye))
					M:client:screen -= H
		M:calm++
	if(quaziamt >= 0.2 && prob(quaziamt * 50 + 10))






		M << "\red You feel nervous"
		if(M:calm > 10)
			M:calm--
		if(prob(1 + round(quaziamt / 2) - M:cetamed))
			M << pick("\red БЛЯДЬ НАС ЗАПАЛЯТ СЕЙЧАС ПРЯЧЕМ СТАФФ", "\red СУКА МНЕ ПИЗДЕЦ НАХУЯ Я СТОЛЬКО СКУРИЛ", "\red БЛЯТЬ МУСОРА УЛЫБАЕМСЯ И МАШЕМ", "\red БЛЯ МАМКА ЖЕ СЕЙЧАС ВЕРНЕТСЯ ЧО ДЕЛАТЬ")
			M:calm -= 2
		if(quaziamt >= 2)
			if(prob(75))
				M:stun(round(quaziamt / 2))
			M:show_message("\red [M:name] looks pale.")
			if(quaziamt >= 4)
				M:acid_dream(quaziamt / 2)
				M:psychosis += round(quaziamt / 10)

	spawn(0) M:remove_chem("JWH-018", 0.08)
/datum/on_mob/JWH250
	rid = "JWH-250"
/datum/on_mob/JWH250
/datum/on_mob/JWH250/react(quaziamt, R, mob/M)
	var/F = new /obj/hud_effect/fog()
	var/HF = new /obj/hud_effect/heavy_fog()

	if(M:chronoclock)
		if(prob(5))
			M:chronoclock = 0
		else
			M:chronoclock--

	if(M:chronodepr && prob(2))
		M << "\green You feel less depressed."
		M:chronodepr--

	if(!("spice" in csecond))
		csecond += "spice"


	if(M:hunger >= 2)
		M:hunger -= 2
		M:euphoria++
	else
		M:hunger = 0

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "nutriment")
			M:euphoria += pick(1, 2)

		if(RE.id == "sugar")
			M:euphoria += pick(1, 2)

		if(RE.id == "plant oil")
			M:euphoria += pick(1, 2)

		if(RE.id == "carboxylic acid")
			M:euphoria += pick(1, 2)


	if(prob(5 + quaziamt * 30))
		M:show_message("\blue [M:name] laughs.", "\green Damn, you're high.")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += rand(1, 3)
		if(M:psi < 20)
			M:psi++

	if(prob(5) && M:client)
		M:client:screen += F
		spawn(60 - 30 * M:cetamed)
			for(var/obj/hud_effect/H in M:client:screen)
				if(!istype(H, /obj/hud_effect/eye))
					M:client:screen -= H
	else if(prob(quaziamt * 1.5) && M:client)
		M:client:screen += HF
		spawn(80 - 40 * M:cetamed)
			if(HF && M:client)
				M:client:screen -= HF
		M:calm++
	if(quaziamt >= 0.2 && prob(quaziamt * 50 + 10))
		M << "\red You feel nervous"
		if(M:calm > 10)
			M:calm--
		if(prob(1 + round(quaziamt / 2.5) - M:cetamed))
			M << pick("\red БЛЯДЬ НАС ЗАПАЛЯТ СЕЙЧАС ПРЯЧЕМ СТАФФ", "\red СУКА МНЕ ПИЗДЕЦ НАХУЯ Я СТОЛЬКО СКУРИЛ", "\red БЛЯТЬ МУСОРА УЛЫБАЕМСЯ И МАШЕМ", "\red БЛЯ МАМКА ЖЕ СЕЙЧАС ВЕРНЕТСЯ ЧО ДЕЛАТЬ")
			M:calm -= 2
		if(quaziamt >= 2)
			if(prob(75))
				M:stun(round(quaziamt / 2))
			M:show_message("\red [M:name] looks pale.")
			if(quaziamt >= 4.6)
				M:acid_dream(quaziamt / 2)
				M:psychosis += round(quaziamt / 12)
	spawn(0) M:remove_chem("JWH-250", 0.08)
/datum/on_mob/AB
	rid = "AB-228"
/datum/on_mob/AB
/datum/on_mob/AB/react(quaziamt, R, mob/M)
	var/F = new /obj/hud_effect/fog()
	var/HF = new /obj/hud_effect/heavy_fog()

	if(!("spice" in csecond))
		csecond += "spice"


	if(M:hunger >= 2)
		M:hunger -= 2
		M:euphoria++
	else
		M:hunger = 0

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "nutriment")
			M:euphoria += pick(1, 2)

		if(RE.id == "sugar")
			M:euphoria += pick(1, 2)

		if(RE.id == "plant oil")
			M:euphoria += pick(1, 2)

		if(RE.id == "carboxylic acid")
			M:euphoria += pick(1, 2)


	if(prob(5 + quaziamt * 20))
		M:show_message("\blue [M:name] laughs.", "\green Damn, you're high.")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += rand(1, 3)
		if(M:psi < 15)
			M:psi++

	if(prob(5) && M:client)
		M:client:screen += F
		spawn(60 - 30 * M:cetamed)
			for(var/obj/hud_effect/H in M:client:screen)
				if(!istype(H, /obj/hud_effect/eye))
					M:client:screen -= H

	else if(prob(quaziamt * 1.5) && M:client)
		M:client:screen += HF
		spawn(80 - 40 * M:cetamed)
			for(var/obj/hud_effect/H in M:client:screen)
				if(!istype(H, /obj/hud_effect/eye))
					M:client:screen -= H

		M:calm++

	if(quaziamt >= 0.3 && prob(quaziamt * 30 + 10))
		M << "\red You feel nervous"
		if(M:calm > 10)
			M:calm--
		if(prob(1 + round(quaziamt / 2) - round(M:cetamed / 1.5)))
			M << pick("\red БЛЯДЬ НАС ЗАПАЛЯТ СЕЙЧАС ПРЯЧЕМ СТАФФ", "\red СУКА МНЕ ПИЗДЕЦ НАХУЯ Я СТОЛЬКО СКУРИЛ", "\red БЛЯТЬ МУСОРА УЛЫБАЕМСЯ И МАШЕМ", "\red БЛЯ МАМКА ЖЕ СЕЙЧАС ВЕРНЕТСЯ ЧО ДЕЛАТЬ")
			M:calm -= 2
		if(quaziamt >= 2.5)
			if(prob(60))
				M:stun(round(quaziamt / 2))
			M:damaga(1, "organ")
			M:show_message("\red [M:name] looks pale.")
			if(quaziamt >= 4.6)
				M:acid_dream(quaziamt / 2)
				M:psychosis += round(quaziamt / 12)
	spawn(0) M:remove_chem("AB-228", 0.08)
/datum/on_mob/APICA
	rid = "APICA"
/datum/on_mob/APICA
/datum/on_mob/APICA/react(quaziamt, R, mob/M)
	var/F = new /obj/hud_effect/fog()
	var/HF = new /obj/hud_effect/heavy_fog()

	if(!("spice" in csecond))
		csecond += "spice"


	if(M:hunger >= 4)
		M:hunger -= 4
		M:euphoria++
	else
		M:hunger = 0

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "nutriment")
			M:euphoria += pick(1, 2)

		if(RE.id == "sugar")
			M:euphoria += pick(1, 2)

		if(RE.id == "plant oil")
			M:euphoria += pick(1, 2)

		if(RE.id == "carboxylic acid")
			M:euphoria += pick(1, 2)


	if(prob(5 + quaziamt * 30))
		M:show_message("\blue [M:name] laughs.", "\green Damn, you're high.")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += rand(1, 5)
		if(M:psi < 20)
			M:psi++

	if(prob(5) && M:client)
		M:client:screen += F
		spawn(60 - 30 * M:cetamed)
			if(F && M:client)
				M:client:screen -= F
	else if(prob(quaziamt * 1.5) && M:client)
		M:client:screen += HF
		spawn(80 - 40 * M:cetamed)
			if(HF && M:client)
				M:client:screen -= HF
		M:calm++

	if(quaziamt >= 0.2 && prob(quaziamt * 30 + 10))
		M << "\red You feel nervous"
		if(M:calm > 10)
			M:calm--
		if(prob(1 + round(quaziamt / 2) - round(M:cetamed / 1.5)))
			M << pick("\red БЛЯДЬ НАС ЗАПАЛЯТ СЕЙЧАС ПРЯЧЕМ СТАФФ", "\red СУКА МНЕ ПИЗДЕЦ НАХУЯ Я СТОЛЬКО СКУРИЛ", "\red БЛЯТЬ МУСОРА УЛЫБАЕМСЯ И МАШЕМ", "\red БЛЯ МАМКА ЖЕ СЕЙЧАС ВЕРНЕТСЯ ЧО ДЕЛАТЬ")
			M:calm -= 2
		if(quaziamt >= 2)
			if(prob(70))
				M:stun(round(quaziamt / 2))
			M:damaga(rand(1, 2), "organ")
			M:show_message("\red [M:name] looks pale.")
			if(quaziamt >= 4.6)
				M:acid_dream(quaziamt / 2)
				M:psychosis += round(quaziamt / 12)
	spawn(0) M:remove_chem("APICA", 0.08)
/datum/on_mob/APINACA
	rid = "APINACA"
/datum/on_mob/APINACA
/datum/on_mob/APINACA/react(quaziamt, R, mob/M)
	var/F = new /obj/hud_effect/fog()
	var/HF = new /obj/hud_effect/heavy_fog()

	if(!("spice" in csecond))
		csecond += "spice"


	if(M:hunger >= 4)
		M:hunger -= 4
		M:euphoria++
	else
		M:hunger = 0

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "nutriment")
			M:euphoria += pick(1, 2)

		if(RE.id == "sugar")
			M:euphoria += pick(1, 2)

		if(RE.id == "plant oil")
			M:euphoria += pick(1, 2)

		if(RE.id == "carboxylic acid")
			M:euphoria += pick(1, 2)

	if(M:euphoria < 5)
		M:euphoria = 5

	if(M:calm < 10)
		M:calm += 2

	if(prob(5 + quaziamt * 50))
		if(M:euphoria < 10)
			M:euphoria++
		M:show_message("\blue [M:name] laughs.", "\green Damn, you're high.")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += rand(1, 6)
		if(M:psi < 20)
			M:psi++

	if(prob(5) && M:client)
		M:client:screen += F
		spawn(60 - 30 * M:cetamed)
			for(var/obj/hud_effect/H in M:client:screen)
				if(!istype(H, /obj/hud_effect/eye))
					M:client:screen -= H

	else if(prob(quaziamt * 1.5) && M:client)
		M:client:screen += HF
		spawn(80 - 40 * M:cetamed)
			for(var/obj/hud_effect/H in M:client:screen)
				if(!istype(H, /obj/hud_effect/eye))
					M:client:screen -= H
		M:calm++

	if(quaziamt >= 0.1 && prob(quaziamt * 40 + 10))
		M << "\red You feel nervous"
		if(M:calm > 10)
			M:calm--
		if(prob(1 + round(quaziamt) - round(M:cetamed / 1.5)))
			M << pick("\red БЛЯДЬ НАС ЗАПАЛЯТ СЕЙЧАС ПРЯЧЕМ СТАФФ", "\red СУКА МНЕ ПИЗДЕЦ НАХУЯ Я СТОЛЬКО СКУРИЛ", "\red БЛЯТЬ МУСОРА УЛЫБАЕМСЯ И МАШЕМ", "\red БЛЯ МАМКА ЖЕ СЕЙЧАС ВЕРНЕТСЯ ЧО ДЕЛАТЬ")
			M:calm -= 2
		if(quaziamt >= 1)
			if(prob(80))
				M:stun(round(quaziamt))
			M:damaga(rand(1, 3), "organ")
			M:show_message("\red [M:name] looks pale.")
			if(quaziamt >= 4)
				M:acid_dream(quaziamt / 2)
				M:psychosis += round(quaziamt / 12)
	spawn(0) M:remove_chem("APINACA", 0.02)

/datum/on_mob/widow
	rid = "white widow"
/datum/on_mob/widow
/datum/on_mob/widow/react(quaziamt, R, mob/M)
	var/F = new /obj/hud_effect/fog()
	var/HF = new /obj/hud_effect/heavy_fog()

	if(M:chronoclock)
		if(prob(5))
			M:chronoclock = 0
		else
			M:chronoclock--

	if(M:chronodepr && prob(4))
		M << "\green You feel less depressed."
		M:chronodepr--
		M:euphoria += 5

	if(!("spice" in csecond))
		csecond += "spice"


	if(M:hunger >= 4)
		M:hunger -= 4
		M:euphoria++
	else
		M:hunger = 0

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "nutriment")
			M:euphoria += pick(1, 2)

		if(RE.id == "sugar")
			M:euphoria += pick(1, 2)

		if(RE.id == "plant oil")
			M:euphoria += pick(1, 2)

		if(RE.id == "carboxylic acid")
			M:euphoria += pick(1, 2)

		M:euphoria += 3
		if(M:calm <= 9)
			M:calm = 10

		if(prob(25))
			M << "\green You feel sooooo sedated."
			M:calm += rand(1, 4)
			M:drowsy_change(4)

	if(prob(5 + quaziamt * 30))
		M:show_message("\blue [M:name] laughs.", "\green Damn, you're high.")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += rand(5, 10)
		M:drowsy_change(3)
		M:calm++
		if(prob(10))
			spawn(10)
				M:stun(2)
				M:drowsy_change(5)
				M << "\blue Dude, you feel drowsy"
		if(M:psi < 20)
			M:psi++

		if(prob(quaziamt * 10))
			M:euphoria += pick(3, 5)

	if(prob(10) && M:client)
		M:client:screen += F
		spawn(60 - 30 * M:cetamed)
			for(var/obj/hud_effect/H in M:client:screen)
				if(!istype(H, /obj/hud_effect/eye))
					M:client:screen -= H
	else if(prob(quaziamt * 1.5) && M:client)
		M:client:screen += HF
		spawn(80 - 40 * M:cetamed)
			for(var/obj/hud_effect/H in M:client:screen)
				if(!istype(H, /obj/hud_effect/eye))
					M:client:screen -= H
		M:calm++
	if(quaziamt >= 0.2 && prob(quaziamt * 50 + 10))









		if(prob(10))
			M << "\red Hey, this stuff makes you fall sometimes!"
			M:stun(1)
		if(prob(5 - M:cetamed * 5))
			M:drowsy_change(5)
			M << "\blue Let's get some sleep"
			M:calm += 2
		if(quaziamt >= 2)
			if(prob(75))
				M:stun(round(quaziamt / 2))
			M:show_message("\red [M:name] looks pale.")
			if(quaziamt >= 4)
				M:acid_dream(quaziamt / 2)
				M:psychosis += round(quaziamt / 10)

	spawn(0) M:remove_chem("white widow", 0.08)

/datum/on_mob/barbital
	rid = "barbital"

/datum/on_mob/barbital
/datum/on_mob/barbital/react(quaziamt, R, mob/M)
	if(prob(60 - M:succinic * 50))
		M:barbi++

	if(prob(80) && M:tension)
		M:tension--

	if(M:psychosis)
		M:psychosis--

	if(quaziamt > 9)
		M:drowsy_change(2)

	if(M:epilepsy > 0)
		M:epilepsy--

	if(M:calm < 20)
		M:calm++

	if(prob(33))
		M:calm++

	if(M:thrill)
		M:thrill--

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "ethanol" && (RE.amount > 3 && quaziamt > 3.5))
			if(prob(20))
				if(M:nausea < 5)
					M:nausea = 5
			if(prob(25))
				M:says_xynta += 5
			M:damaga(3, "organ")

	if(prob(quaziamt * 4))
		M << "\green You feel relaxed."
		M:calm++
		M:euphoria += pick(1, 2, 3)
		if(M:thrill)
			M:thrill = 0

		if(prob(33))
			M:euphoria++

		if(quaziamt > 10 && prob(quaziamt * 3))
			if(quaziamt > 20)
				M:damaga(3, "organ")
				if(prob(10))
					M:vomit_red()
			if(prob(quaziamt * 2))
				M:drowsy_change(9)
				M << "\blue Let's get some sleep"
			for(var/datum/reagent/RE in M:blood_chem)
				if(RE.id == "ethanol" && (RE.amount > 1 && quaziamt > 0.5))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
					M:damaga(pick(3, 5, 7), "organ")
					M << "\red Or not so relaxed"
					if(prob(25))
						M:calm--
	spawn(0)
		M:ba_tick = 5
		M:remove_chem("barbital", 0.25)

/datum/on_mob/phenobarbital
	rid = "phenobarbital"
/datum/on_mob/phenobarbital
/datum/on_mob/phenobarbital/react(quaziamt, R, mob/M)
	if(prob(60 - M:succinic * 50))
		M:barbi++

	if(M:tension)
		M:tension--

	if(quaziamt > 9)
		M:drowsy_change(2)

	if(M:epilepsy > 0)
		M:epilepsy--

	if(M:psychosis)
		M:psychosis--

	if(M:calm < 20)
		M:calm++

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "ethanol" && (RE.amount >= 10 && quaziamt > 5))
			if(prob(20))
				if(M:nausea < 5)
					M:nausea = 5
				else
					M:nausea += 2
			if(prob(25))
				M:says_xynta += 5
			M:damaga(3, "organ")

	if(prob(quaziamt * 4))
		M << "\green You feel relaxed."
		M:calm++
		M:euphoria += pick(1, 2)
		if(M:thrill)
			M:thrill = 0

		if(prob(33))
			M:euphoria++

		if(quaziamt > 10 && prob(quaziamt * 3))
			if(quaziamt > 20)
				M:damaga(3, "organ")
				if(prob(10))
					M:vomit_red()
			if(prob(quaziamt * 2))
				M:drowsy_change(9)
				M << "\blue Let's get some sleep"
			for(var/datum/reagent/RE in M:blood_chem)
				if(RE.id == "ethanol" && (RE.amount > 1 && quaziamt > 0.5))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
					M:damaga(pick(3, 5, 7), "organ")
					M << "\red Or not so relaxed"
					if(prob(25))
						M:calm--
	spawn(0)
		M:ba_tick = 5
		M:remove_chem("phenobarbital", 0.05)

/datum/on_mob/pentobarbital
	rid = "pentobarbital"
/datum/on_mob/pentobarbital
/datum/on_mob/pentobarbital/react(quaziamt, R, mob/M)
	if(prob(60 - M:succinic * 50))
		M:barbi++

	if(M:tension)
		M:tension--

	if(quaziamt > 4.5)
		M:drowsy_change(2)

	if(M:epilepsy > 0)
		M:epilepsy--

	if(M:psychosis)
		M:psychosis--

	if(M:calm < 20)
		M:calm++

	if(prob(33))
		M:calm++

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "ethanol" && (RE.amount > 3 && quaziamt >= 3))
			if(prob(20))
				if(M:nausea < 5)
					M:nausea = 5
				else
					M:nausea += 2
			if(prob(25))
				M:says_xynta += 5
			M:damaga(3, "organ")

	if(prob(quaziamt * 8))
		M << "\green You feel relaxed."
		M:calm++
		M:euphoria += pick(1, 2, 3)
		if(M:thrill)
			M:thrill = 0

		if(prob(33))
			M:euphoria++

		if(quaziamt > 5 && prob(quaziamt * 3))
			if(quaziamt > 10)
				M:damaga(3, "organ")
				if(prob(10))
					M:vomit_red()
			if(prob(quaziamt * 5))
				M:drowsy_change(9)
				M << "\blue Let's get some sleep"
			for(var/datum/reagent/RE in M:blood_chem)
				if(RE.id == "ethanol" && (RE.amount > 0.5 && quaziamt > 0.5))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
					M:damaga(pick(3, 5, 7), "organ")
					M << "\red Or not so relaxed"
					if(prob(25))
						M:calm--
	spawn(0)
		M:ba_tick = 5
		M:remove_chem("pentobarbital", 0.1)

/datum/on_mob/amobarbital
	rid = "amobarbital"
/datum/on_mob/amobarbital
/datum/on_mob/amobarbital/react(quaziamt, R, mob/M)
	if(prob(60 - M:succinic * 50))
		M:barbi++

	if(M:tension)
		M:tension--

	if(quaziamt > 4.5)
		M:drowsy_change(2)

	if(M:epilepsy > 0)
		M:epilepsy--

	if(M:psychosis)
		M:psychosis--

	if(M:calm < 20)
		M:calm++

	if(prob(33))
		M:calm++

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "ethanol" && (RE.amount > 3 && quaziamt >= 3))
			if(prob(20))
				if(M:nausea < 5)
					M:nausea = 5
				else
					M:nausea += 2
			if(prob(25))
				M:says_xynta += 5
			M:damaga(3, "organ")

	if(prob(quaziamt * 8))
		M << "\green You feel relaxed."
		M:calm++
		M:euphoria += pick(1, 2, 3)
		if(M:thrill)
			M:thrill = 0

		if(prob(33))
			M:euphoria++

		if(quaziamt > 1 && prob(66))
			M:shouttruth()

		if(quaziamt > 5 && prob(quaziamt * 3))
			if(quaziamt > 10)
				M:damaga(3, "organ")
				if(prob(10))
					M:vomit_red()
			if(prob(quaziamt / 2.5))
				M:drowsy_change(9)
				M << "\blue Let's get some sleep"
			for(var/datum/reagent/RE in M:blood_chem)
				if(RE.id == "ethanol" && (RE.amount > 0.5 && quaziamt > 0.5))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
					M:damaga(pick(3, 5, 7), "organ")
					M << "\red Or not so relaxed"
					if(prob(25))
						M:calm--

	spawn(0)
		M:ba_tick = 5
		if(quaziamt >= 4)
			M:remove_chem("amobarbital", 0.1)
		else
			M:remove_chem("amobarbital", 0.05)

/datum/on_mob/benzo
	rid = "benzodiazepine"
/datum/on_mob/benzo
/datum/on_mob/benzo/react(quaziamt, R, mob/M)
	if(!M:benzo_block)

		if(prob(50 - M:succinic * 50))
			M:benzo++

		if(prob(80) && M:tension)
			M:tension--

		if(M:epilepsy > 0)
			M:epilepsy--

		if(M:psychosis)
			M:psychosis--

		if(M:depression)
			M:depression--

		if(quaziamt > 10)
			M:drowsy_change(2)

		if(M:calm < 20)
			M:calm++

		var/boozd = 0

		for(var/datum/reagent/RE in M:blood_chem)

			if(RE.id == "ethanol" && (RE.amount > 5 && quaziamt >= 8))
				boozd = 1
				if(prob(20))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
				if(prob(25))
					M:says_xynta += 5
				if(prob(min(quaziamt, 15)))
					M:delirium += 5
				if(quaziamt > 15 && prob(50))
					M:damaga(3, "organ")

		if(prob(quaziamt * 4))
			M << "\green You feel relaxed."
			M:calm++
			M:euphoria += pick(1, 2)
			if(M:thrill)
				M:thrill = 0

			if(prob(15))

				M:euphoria++

			if(quaziamt > 20 && prob(quaziamt))
				M:damaga(rand(3, 5), "organ")
				if(prob(quaziamt / 2))
					M:drowsy_change(9)
					M << "\blue Let's get some sleep"
				for(var/datum/reagent/RE in M:blood_chem)
					if(RE.id == "ethanol" && (RE.amount > 3 && quaziamt > 1))
						boozd = 1
						if(M:nausea < 5)
							M:nausea = 5
						else
							M:nausea += 2
						M:damaga(pick(3, 5, 7), "organ")
						M << "\red Or not so relaxed"
						if(prob(25))
							M:calm--

		if(quaziamt < 20 && (M:delirium && !boozd))
			M:delirium--

			if(prob(15))
				M:delirium = 0



			for(var/datum/reagent/RE in M:blood_chem)

				if(RE.id == "DPH" && RE.amount >= 10)
					M:remove_chem("DPH", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "dicyclomine" && RE.amount >= 20)
					M:remove_chem("dicyclomine", 2)
					if(prob(5))
						M:vomit()

				if(RE.id == "tropicamide" && RE.amount >= 7.5)
					M:remove_chem("tropicamide", 0.75)
					if(prob(5))
						M:vomit()

				if(RE.id == "atropine")
					M:remove_chem("atropine", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "Nuclear titbit")
					M:remove_chem("Nuclear titbit", 1)
					if(prob(5))
						M:vomit()

	spawn(0)
		M:be_tick = 5
		M:remove_chem("benzodiazepine", 0.25)

/datum/on_mob/phenazepam
	rid = "phenazepam"
/datum/on_mob/phenazepam
/datum/on_mob/phenazepam/react(quaziamt, R, mob/M)
	if(!M:benzo_block)

		if(prob(45 - M:succinic * 40))
			M:benzo++

		if(prob(90) && M:tension)
			M:tension--

		if(M:depression)
			M:depression--

		if(M:epilepsy > 0)
			M:epilepsy--

		if(M:psychosis > 0)
			M:psychosis--

		if(M:thrill > 0)
			M:thrill--

		if(quaziamt > 5)
			M:drowsy_change(2)

		if(M:calm < 10)
			M:calm++

		if(M:calm < 20 && prob(50))
			M:calm++

		if(prob(20))
			M:calm++

		var/boozd = 0

		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "ethanol" && (RE.amount >= 19 && quaziamt >= 10))
				boozd = 1
				if(prob(20))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
				if(prob(25))
					M:says_xynta += 5
				if(prob(min(quaziamt, 15)))
					M:delirium += 5
				if(quaziamt > 15 && prob(50))
					M:damaga(3, "organ")

		if(prob(quaziamt * 4))
			M << "\green You feel relaxed."
			M:calm++
			M:euphoria += rand(1, 3)
			if(M:thrill)
				M:thrill = 0

			if(prob(25))

				M:euphoria++

			if(quaziamt > 25 && prob(quaziamt))

				if(prob(33))
					M:euphoria++

				M:damaga(rand(3, 5), "organ")
				if(prob(quaziamt / 2.5))
					M:drowsy_change(9)
					M << "\blue Let's get some sleep"

			for(var/datum/reagent/RE in M:blood_chem)
				if(RE.id == "ethanol" && (RE.amount > 9 && quaziamt > 5))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
					M:damaga(pick(3, 5, 7), "organ")
					M << "\red Or not so relaxed"
					if(prob(25))
						M:calm--

		if(quaziamt < 25 && (M:delirium && !boozd))
			M:delirium--

			if(prob(20))
				M:delirium = 0

			for(var/datum/reagent/RE in M:blood_chem)

				if(RE.id == "DPH" && RE.amount >= 10)
					M:remove_chem("DPH", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "dicyclomine" && RE.amount >= 20)
					M:remove_chem("dicyclomine", 2)
					if(prob(5))
						M:vomit()

				if(RE.id == "tropicamide" && RE.amount >= 7.5)
					M:remove_chem("tropicamide", 0.75)
					if(prob(5))
						M:vomit()

				if(RE.id == "atropine")
					M:remove_chem("atropine", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "Nuclear titbit")
					M:remove_chem("Nuclear titbit", 1)
					if(prob(5))
						M:vomit()

	spawn(0)
		M:be_tick = 5
		M:remove_chem("phenazepam", 0.25)

/datum/on_mob/diazepam
	rid = "diazepam"
/datum/on_mob/diazepam
/datum/on_mob/diazepam/react(quaziamt, R, mob/M)
	if(!M:benzo_block)

		if(M:calm < 20 && prob(50))
			M:calm++

		if(prob(20))
			M:calm++

		if(prob(33 - M:succinic * 23))
			M:benzo++

		if(prob(90) && M:tension)
			M:tension--

		if(M:epilepsy > 0)
			M:epilepsy--

		if(M:psychosis > 0)
			M:psychosis--

		if(quaziamt > 7)
			M:drowsy_change(2)

		var/boozd = 0

		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "ethanol" && (RE.amount > 12 && quaziamt > 6))
				boozd = 1
				if(prob(20))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
				if(prob(25))
					M:says_xynta += 5
				if(prob(min(quaziamt, 15)))
					M:delirium += 5
				if(quaziamt > 15 && prob(50))
					M:damaga(3, "organ")

		if(prob(quaziamt * 4))
			M << "\green You feel relaxed."
			M:calm++
			M:euphoria += rand(1, 2)

		if(M:calm < 10)
			M:calm++

		if(M:thrill)
			M:thrill = 0

		if(prob(33))

			M:euphoria++

		if(quaziamt > 25 && prob(quaziamt))

			if(prob(33))
				M:euphoria++

			M:damaga(rand(2, 4), "organ")
			if(prob(quaziamt / 5))
				M:drowsy_change(6)
				M << "\blue Let's get some sleep"
				for(var/datum/reagent/RE in M:blood_chem)
					if(RE.id == "ethanol" && (RE.amount > 10 && quaziamt > 7.5))
						boozd = 1
						if(M:nausea < 5)
							M:nausea = 5
						else
							M:nausea += 2
						M:damaga(pick(2, 4, 6), "organ")
						M << "\red Or not so relaxed"
						if(prob(25))
							M:calm--

		if(quaziamt < 25 && (M:delirium && !boozd))
			M:delirium--

			if(prob(20))
				M:delirium = 0

			for(var/datum/reagent/RE in M:blood_chem)

				if(RE.id == "DPH" && RE.amount >= 10)
					M:remove_chem("DPH", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "dicyclomine" && RE.amount >= 20)
					M:remove_chem("dicyclomine", 2)
					if(prob(5))
						M:vomit()

				if(RE.id == "tropicamide" && RE.amount >= 7.5)
					M:remove_chem("tropicamide", 0.75)
					if(prob(5))
						M:vomit()

				if(RE.id == "atropine")
					M:remove_chem("atropine", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "Nuclear titbit")
					M:remove_chem("Nuclear titbit", 1)
					if(prob(5))
						M:vomit()

	spawn(0)
		M:be_tick = 5
		M:remove_chem("diazepam", 0.25)

/datum/on_mob/midazolam
	rid = "midazolam"
/datum/on_mob/midazolam
/datum/on_mob/midazolam/react(quaziamt, R, mob/M)
	if(!M:benzo_block)

		if(M:calm < 20)
			M:calm += pick(1, 2)

		if(prob(33))
			M:calm++

		if(prob(40 - M:succinic * 30))
			M:benzo++

		if(M:tension > 0)
			M:tension--

		if(M:epilepsy > 0)
			M:epilepsy--

		if(M:psychosis > 0)
			M:psychosis--



		if(quaziamt > 3 && prob(33))
			M << "\red You feel a bit drowsy."
			M:drowsy_change(1)
		else if(quaziamt > 6)
			M:drowsy_change(2)

		var/boozd = 0

		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "ethanol" && (RE.amount > 9 && quaziamt > 6))
				boozd = 1
				if(prob(20))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
				if(prob(25))
					M:says_xynta += 5
				if(prob(min(quaziamt, 15)))
					M:delirium += 5
				if(quaziamt > 12 && prob(50))
					M:damaga(3, "organ")

		if(prob(quaziamt * 8))
			M << "\green You feel relaxed."
			M:calm++
			M:euphoria += rand(1, 4)

		if(M:calm < 10)
			M:calm += 2

		if(M:thrill)
			M:thrill = 0

		if(prob(33))

			M:euphoria++

		if(quaziamt > 12)

			if(prob(33))
				M:euphoria++

			M:damaga(rand(10, 15), "organ")

			if(prob(quaziamt / 2))
				M:drowsy_change(6)
				M << "\blue Let's get some sleep"
			for(var/datum/reagent/RE in M:blood_chem)
				if(RE.id == "ethanol" && quaziamt > 7.5)
					boozd = 1
					M:damaga(pick(1, 2, 4, 6, 8), "organ")
					M << "\red Or not so relaxed"
					if(prob(25))
						M:calm--

		if(quaziamt < 12 && (M:delirium && !boozd))
			M:delirium--

			if(prob(40))
				M:delirium = 0

			for(var/datum/reagent/RE in M:blood_chem)

				if(RE.id == "DPH" && RE.amount >= 10)
					M:remove_chem("DPH", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "dicyclomine" && RE.amount >= 20)
					M:remove_chem("dicyclomine", 2)
					if(prob(5))
						M:vomit()

				if(RE.id == "tropicamide" && RE.amount >= 7.5)
					M:remove_chem("tropicamide", 0.75)
					if(prob(5))
						M:vomit()

				if(RE.id == "atropine")
					M:remove_chem("atropine", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "Nuclear titbit")
					M:remove_chem("Nuclear titbit", 1)
					if(prob(5))
						M:vomit()

	spawn(0)
		M:be_tick = 8
		M:remove_chem("midazolam", 0.5)

/datum/on_mob/triazolam
	rid = "triazolam"

/datum/on_mob/triazolam
/datum/on_mob/triazolam/react(quaziamt, R, mob/M)
	if(!M:benzo_block)

		if(prob(30 - M:succinic * 25))
			M:benzo++

		if(prob(70) && M:tension)
			M:tension--

		if(M:epilepsy > 0)
			M:epilepsy--

		if(M:psychosis > 0)
			M:psychosis--

		if(M:depression > 0)
			M:depression--

		if(M:thrill && prob(66))
			if(M:thrill > 5)
				M:thrill -= 5
			else if(M:thrill >= 2)
				M:thrill -= 2
			else if(M:thrill)
				M:thrill--

		if(quaziamt > 8)
			M:drowsy_change(2)

		if(prob(10))
			M:calm++

		var/boozd = 0

		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "ethanol" && (RE.amount > 12 && quaziamt > 6))
				boozd = 1
				if(prob(20))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
				if(prob(25))
					M:says_xynta += 5
				if(prob(min(quaziamt, 15)))
					M:delirium += 5
				if(quaziamt > 15 && prob(50))
					M:damaga(3, "organ")

		if(prob(quaziamt * 3))
			M << "\green You feel relaxed."
			M:calm++
			M:euphoria++

		if(M:calm < 15)
			M:calm++

		if(prob(33))

			M:euphoria++

		if(quaziamt > 25 && prob(quaziamt))

			if(prob(33))
				M:euphoria++

			if(prob(50))
				M:damaga(rand(3, 5), "organ")
			if(prob(quaziamt / 3))
				M:drowsy_change(6)
				M << "\blue Let's get some sleep"
			for(var/datum/reagent/RE in M:blood_chem)
				if(RE.id == "ethanol" && (RE.amount > 10 && quaziamt > 7.5))
					boozd = 1
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
					M:damaga(pick(2, 4, 6), "organ")
					M << "\red Or not so relaxed"
					if(prob(25))
						M:calm--

		if(quaziamt < 25 && (M:delirium && !boozd))

			M:delirium--

			if(prob(15))
				M:delirium = 0

			for(var/datum/reagent/RE in M:blood_chem)

				if(RE.id == "DPH" && RE.amount >= 10)
					M:remove_chem("DPH", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "dicyclomine" && RE.amount >= 20)
					M:remove_chem("dicyclomine", 2)
					if(prob(5))
						M:vomit()

				if(RE.id == "tropicamide" && RE.amount >= 7.5)
					M:remove_chem("tropicamide", 0.75)
					if(prob(5))
						M:vomit()

				if(RE.id == "atropine")
					M:remove_chem("atropine", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "Nuclear titbit")
					M:remove_chem("Nuclear titbit", 1)
					if(prob(5))
						M:vomit()

	spawn(0)
		M:be_tick = 5
		M:remove_chem("triazolam", 0.25)

/datum/on_mob/alprazolam
	rid = "alprazolam"
/datum/on_mob/alprazolam
/datum/on_mob/alprazolam/react(quaziamt, R, mob/M)
	if(!M:benzo_block)

		if(M:euphoria < 20)
			M:euphoria += pick(1, 2)

		if(prob(50 - M:succinic * 40))
			M:benzo++

		if(M:tension > 0)
			M:tension--

		if(M:epilepsy > 0)
			M:epilepsy--

		if(M:psychosis > 0)
			M:psychosis--

		if(M:depression >= 2)
			M:depression -= 2
		else if(M:depression > 0)
			M:depression--

		if(quaziamt > 3)
			M:euphoria++
			M:drowsy_change(2)

		if(M:chronoclock)
			if(prob(8))
				M:chronoclock = 0
			else
				M:chronoclock--

		if(M:chronodepr && prob(4))
			M << "\green You feel less depressed."
			M:chronodepr--

		var/boozd = 0

		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "ethanol" && (RE.amount > 8 && quaziamt > 6))
				boozd = 1
				if(prob(20))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
				if(prob(25))
					M:says_xynta += 5
				if(prob(min(quaziamt, 15)))
					M:delirium += 5
				if(quaziamt > 15 && prob(50))
					M:damaga(3, "organ")

		if(prob(quaziamt * 5))
			M << "\green You feel relaxed."
			M:calm++
			M:euphoria += rand(1, 4)

		if(M:calm < 15)
			M:calm++

		if(prob(20))
			M:calm++

		if(M:thrill)
			M:thrill = 0

		if(prob(33))

			M:euphoria++

		if(quaziamt > 25 && prob(50))

			if(prob(33))
				M:euphoria++

			M:damaga(rand(3, 5), "organ")
			if(prob(quaziamt / 2))
				M:drowsy_change(6)
				M << "\blue Let's get some sleep"
			for(var/datum/reagent/RE in M:blood_chem)
				if(RE.id == "ethanol" && (RE.amount > 10 && quaziamt > 7.5))
					boozd = 1
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
					M:damaga(pick(2, 4, 6), "organ")
					M << "\red Or not so relaxed"
					if(prob(25))
						M:calm--

		if(quaziamt < 25 && (M:delirium && !boozd))
			M:delirium--

			if(prob(25))
				M:delirium = 0

			for(var/datum/reagent/RE in M:blood_chem)

				if(RE.id == "DPH" && RE.amount >= 10)
					M:remove_chem("DPH", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "dicyclomine" && RE.amount >= 20)
					M:remove_chem("dicyclomine", 2)
					if(prob(5))
						M:vomit()

				if(RE.id == "tropicamide" && RE.amount >= 7.5)
					M:remove_chem("tropicamide", 0.75)
					if(prob(5))
						M:vomit()

				if(RE.id == "atropine")
					M:remove_chem("atropine", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "Nuclear titbit")
					M:remove_chem("Nuclear titbit", 1)
					if(prob(5))
						M:vomit()

	spawn(0)
		M:be_tick = 5
		M:remove_chem("alprazolam", 0.2)

/datum/on_mob/clonazepam
	rid = "clonazepam"
/datum/on_mob/clonazepam
/datum/on_mob/clonazepam/react(quaziamt, R, mob/M)
	if(!M:benzo_block)

		if(prob(50 - M:succinic * 50))
			M:benzo++

		if(prob(80) && M:tension)
			M:tension--

		if(M:epilepsy > 0)
			M:epilepsy--

		if(M:thrill)
			M:thrill = 0

		if(M:psychosis)
			M:psychosis--

		if(M:depression >= 2)
			M:depression -= 2
		else if(M:depression)
			M:depression--

		if(quaziamt > 0.4)
			M:drowsy_change(pick(2, 3))
			M:euphoria++

		if(M:calm < 10)
			M:calm += rand(1, 5)

		if(M:calm < 20)
			M:calm++

		var/boozd = 0

		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "ethanol" && (RE.amount > 4 && quaziamt > 0.4))
				boozd = 1
				if(prob(20))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
				if(prob(25))
					M:says_xynta += 5
				if(prob(min(quaziamt * 8, 15)))
					M:delirium += 5
				if(quaziamt >= 2 && prob(50))
					M:damaga(3, "organ")

		if(prob(min(quaziamt * 50, 66)))
			M << "\green You feel relaxed."
			M:calm++

			M:euphoria += pick(1, 2, 3)

			if(prob(33))

				M:euphoria++

			if(quaziamt > 10 && prob(quaziamt))

				if(prob(40))
					M:euphoria++

				M:damaga(rand(3, 8), "organ")
				if(prob(quaziamt))
					M:drowsy_change(9)
					M << "\blue Let's get some sleep"
				for(var/datum/reagent/RE in M:blood_chem)
					if(RE.id == "ethanol" && (RE.amount > 3 && quaziamt > 1.5))
						boozd = 1
						if(M:nausea < 5)
							M:nausea = 5
						else
							M:nausea += 2
						M:damaga(pick(3, 5, 7), "organ")
						M << "\red Or not so relaxed"
						if(prob(25))
							M:calm--

		if(quaziamt < 10 && (M:delirium && !boozd))
			M:delirium--

			if(prob(40))
				M:delirium = 0

			for(var/datum/reagent/RE in M:blood_chem)

				if(RE.id == "DPH" && RE.amount >= 10)
					M:remove_chem("DPH", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "dicyclomine" && RE.amount >= 20)
					M:remove_chem("dicyclomine", 2)
					if(prob(5))
						M:vomit()

				if(RE.id == "tropicamide" && RE.amount >= 7.5)
					M:remove_chem("tropicamide", 0.75)
					if(prob(5))
						M:vomit()

				if(RE.id == "atropine")
					M:remove_chem("atropine", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "Nuclear titbit")
					M:remove_chem("Nuclear titbit", 1)
					if(prob(5))
						M:vomit()


	spawn(0)
		M:be_tick = 5
		M:remove_chem("clonazepam", 0.05)


/datum/on_mob/nitrazepam
	rid = "nitrazepam"
/datum/on_mob/nitrazepam
/datum/on_mob/nitrazepam/react(quaziamt, R, mob/M)
	if(!M:benzo_block)

		if(prob(50 - M:succinic * 50))
			M:benzo++

		if(prob(80) && M:tension)
			M:tension--

		if(M:epilepsy > 0)
			M:epilepsy--

		if(M:psychosis > 0)
			M:psychosis--

		if(M:depression >= 2)
			M:depression -= 2
		else if(M:depression > 0)
			M:depression--

		if(M:thrill)
			M:thrill = 0

		if(quaziamt > 0.4)
			M:drowsy_change(pick(2, 3))
			M:euphoria++

		if(M:calm < 20)
			M:calm++

		if(M:calm < 15)
			M:calm += rand(1, 5)
		else
			M:calm++

		var/boozd = 0

		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "ethanol" && (RE.amount > 3 && quaziamt > 0.4))
				boozd = 1
				if(prob(20))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
				if(prob(25))
					M:says_xynta += 5
				if(prob(min(quaziamt * 8, 15)))
					M:delirium += 5
				if(quaziamt >= 2 && prob(50))
					M:damaga(3, "organ")

		if(prob(min(quaziamt * 50, 90)))
			M << "\green You feel relaxed."
			M:calm++

			M:euphoria += rand(1, 3)

			if(prob(20))

				M:euphoria++

			if(prob(50))
				M:drowsy_change(1)

		if(quaziamt > 14)

			if(prob(40))
				M:euphoria++

			if(prob(5))
				M << "\red You have a trouble with standing vertically."
				M:stun(3)
			M:damaga(rand(3, 8), "organ")
			if(prob(quaziamt))
				M:drowsy_change(9)
				M << "\blue Let's get some sleep"
			for(var/datum/reagent/RE in M:blood_chem)
				if(RE.id == "ethanol" && (RE.amount > 3 && quaziamt > 3))
					boozd = 1
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
					M:damaga(pick(3, 5, 7), "organ")
					M << "\red Or not so relaxed"
					if(prob(25))
						M:calm--

		if(quaziamt < 14 && (M:delirium && !boozd))
			M:delirium--

			if(prob(40))
				M:delirium = 0

			for(var/datum/reagent/RE in M:blood_chem)

				if(RE.id == "DPH" && RE.amount >= 10)
					M:remove_chem("DPH", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "dicyclomine" && RE.amount >= 20)
					M:remove_chem("dicyclomine", 2)
					if(prob(5))
						M:vomit()

				if(RE.id == "tropicamide" && RE.amount >= 7.5)
					M:remove_chem("tropicamide", 0.75)
					if(prob(5))
						M:vomit()

				if(RE.id == "atropine")
					M:remove_chem("atropine", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "Nuclear titbit")
					M:remove_chem("Nuclear titbit", 1)
					if(prob(5))
						M:vomit()


	spawn(0)
		M:be_tick = 5
		M:remove_chem("nitrazepam", 0.1)

/datum/on_mob/flunitrazepam
	rid = "flunitrazepam"
/datum/on_mob/flunitrazepam
/datum/on_mob/flunitrazepam/react(quaziamt, R, mob/M)
	if(!M:benzo_block)

		if(prob(60 - M:succinic * 50))
			M:benzo++

		if(prob(80) && M:tension)
			M:tension--

		if(M:epilepsy > 0)
			M:epilepsy--

		if(M:psychosis > 0)
			M:psychosis--

		if(M:depression > 0)
			M:depression--

		if(M:thrill >= 2)
			M:thrill -= 2

		if(quaziamt > 1)
			M:drowsy_change(pick(2, 3))
			M:euphoria++

		if(M:calm < 15)
			M:calm += rand(1, 5)
		else
			M:calm++

		var/boozd = 0

		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "ethanol" && (RE.amount > 2 && quaziamt > 0.4))
				boozd = 1
				M:drowsy_change(5)
				M:stun(4)
				if(prob(20))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
				if(prob(25))
					M:says_xynta += 5
				if(prob(min(quaziamt * 8, 15)))
					M:delirium += 5
					M:calm++
				if(quaziamt >= 2 && prob(50))
					M:damaga(3, "organ")

		if(prob(min(quaziamt * 50, 90)))
			M << "\green You feel relaxed."
			M:calm++

			M:euphoria += rand(1, 3)

			if(prob(20))

				M:euphoria++

		if(quaziamt > 14)

			if(prob(40))
				M:euphoria++

			if(prob(5))
				M << "\red You have a trouble with standing vertically."
				M:stun(3)
			M:damaga(rand(3, 8), "organ")
			if(prob(quaziamt))
				M:drowsy_change(9)
				M << "\blue Let's get some sleep"
			for(var/datum/reagent/RE in M:blood_chem)
				if(RE.id == "ethanol" && (RE.amount > 3 && quaziamt > 3))
					boozd = 1
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
					M:damaga(pick(3, 5, 7), "organ")
					M << "\red Or not so relaxed"
					if(prob(25))
						M:calm--

		if(quaziamt < 14 && (M:delirium && !boozd))

			M:delirium--

			if(prob(20))
				M:delirium = 0

			for(var/datum/reagent/RE in M:blood_chem)

				if(RE.id == "DPH" && RE.amount >= 10)
					M:remove_chem("DPH", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "dicyclomine" && RE.amount >= 20)
					M:remove_chem("dicyclomine", 2)
					if(prob(5))
						M:vomit()

				if(RE.id == "tropicamide" && RE.amount >= 7.5)
					M:remove_chem("tropicamide", 0.75)
					if(prob(5))
						M:vomit()

				if(RE.id == "atropine")
					M:remove_chem("atropine", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "Nuclear titbit")
					M:remove_chem("Nuclear titbit", 1)
					if(prob(5))
						M:vomit()


			if(prob(10))
				M:delirium = 0


	spawn(0)
		M:be_tick = 5
		M:remove_chem("flunitrazepam", 0.15)

/datum/on_mob/cosmozepam
	rid = "cosmozepam"
/datum/on_mob/cosmozepam
/datum/on_mob/cosmozepam/react(quaziamt, R, mob/M)
	if(!M:benzo_block)

		if(prob(50 - M:succinic * 50))
			M:benzo++

		if(prob(80) && M:tension)
			M:tension--

		if(M:epilepsy > 0)
			M:epilepsy--

		if(M:psychosis > 0)
			M:psychosis--

		if(M:depression >= 2)
			M:depression -= 2
		else if(M:depression > 0)
			M:depression--

		if(M:thrill > 0)
			M:thrill = 0

		if(quaziamt > 0.2)
			M:drowsy_change(rand(2, 4))
			M:euphoria++

		if(M:calm < 20)
			M:calm++

		if(M:calm < 10)
			M:calm += rand(1, 5)

		var/boozd = 0

		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "ethanol" && (RE.amount > 2 && quaziamt > 0.2))
				boozd = 1
				if(prob(20))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
				if(prob(25))
					M:says_xynta += 5
				if(prob(min(quaziamt * 8, 15)))
					M:delirium += 5
				if(quaziamt >= 2 && prob(50))
					M:damaga(3, "organ")

		if(prob(min(quaziamt * 90, 80)))
			M << "\green You feel relaxed."
			M:calm++

			M:euphoria += rand(1, 3)

			if(prob(50))

				M:euphoria++

			if(quaziamt > 6.5)

				if(prob(55))
					M:euphoria++

				if(prob(5))
					M << "\red You have a trouble with standing vertically."
					M:stun(3)
				M:damaga(rand(3, 8), "organ")
				if(prob(quaziamt))
					M:drowsy_change(12)
					M << "\blue Let's get some sleep"
				for(var/datum/reagent/RE in M:blood_chem)
					if(RE.id == "ethanol" && (RE.amount > 3 && quaziamt > 0.75))
						boozd = 1
						if(M:nausea < 5)
							M:nausea = 5
						else
							M:nausea += 2
						M:damaga(pick(3, 5, 7), "organ")
						M << "\red Or not so relaxed"
						if(prob(25))
							M:calm--

		if(quaziamt < 6.5 && (M:delirium && !boozd))
			M:delirium--

			if(prob(50))
				M:delirium = 0

			for(var/datum/reagent/RE in M:blood_chem)

				if(RE.id == "DPH" && RE.amount >= 10)
					M:remove_chem("DPH", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "dicyclomine" && RE.amount >= 20)
					M:remove_chem("dicyclomine", 2)
					if(prob(5))
						M:vomit()

				if(RE.id == "tropicamide" && RE.amount >= 7.5)
					M:remove_chem("tropicamide", 0.75)
					if(prob(5))
						M:vomit()

				if(RE.id == "atropine")
					M:remove_chem("atropine", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "Nuclear titbit")
					M:remove_chem("Nuclear titbit", 1)
					if(prob(5))
						M:vomit()


	spawn(0)
		M:be_tick = 5
		M:remove_chem("cosmozepam", 0.025)

/datum/on_mob/cognitozepam
	rid = "cognitozepam"
/datum/on_mob/cognitozepam
/datum/on_mob/cognitozepam/react(quaziamt, R, mob/M)
	if(!M:benzo_block)

		M:euphoria++

		if(prob(40 - M:succinic * 35))
			M:benzo++

		if(M:tension > 0)
			M:tension--

		if(prob(5) && M:chronodepr)
			M:chronodepr--
		if(M:thrill)
			M:thrill = 0

		if(M:epilepsy > 0)
			M:epilepsy--

		if(M:psychosis > 0)
			M:psychosis--

		if(M:depression >= 2)
			M:depression -= 2
		else if(M:depression > 0)
			M:depression--

		if(M:calm < 20)
			M:calm++

		if(M:calm < 10)
			M:calm += rand(1, 5)

		var/boozd = 0

		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "ethanol" && (RE.amount > 1 && quaziamt > 0.1))
				boozd = 1
				if(prob(20))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
				if(prob(25))
					M:says_xynta += 5
				if(prob(min(quaziamt * 8, 15)))
					M:delirium += 5
				if(quaziamt >= 2 && prob(50))
					M:damaga(3, "organ")

		if(prob(min(quaziamt * 100, 80)))
			M << "\green You feel relaxed."
			M:calm++

			M:drowsy_change(2)

			M:euphoria += rand(1, 3)

			if(prob(60))

				M:euphoria++

			if(quaziamt > 1 && prob(quaziamt))


				if(prob(70))

					M:euphoria++


				M:damaga(rand(4, 10), "organ")

				if(prob(5))
					M:drowsy_change(15)
					M << "\blue Let's get some sleep"
				for(var/datum/reagent/RE in M:blood_chem)
					if(RE.id == "ethanol" && (RE.amount > 3 && quaziamt > 0.05))
						boozd = 1
						if(M:nausea < 5)
							M:nausea = 5
						else
							M:nausea += 2
						M:damaga(pick(3, 5, 7), "organ")
						M << "\red Or not so relaxed"
						if(prob(25))
							M:calm--

		if(quaziamt <= 1 && (M:delirium && !boozd))
			M:delirium--

			if(prob(66))
				M:delirium = 0

			for(var/datum/reagent/RE in M:blood_chem)

				if(RE.id == "DPH" && RE.amount >= 10)
					M:remove_chem("DPH", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "dicyclomine" && RE.amount >= 20)
					M:remove_chem("dicyclomine", 2)
					if(prob(5))
						M:vomit()

				if(RE.id == "tropicamide" && RE.amount >= 7.5)
					M:remove_chem("tropicamide", 0.75)
					if(prob(5))
						M:vomit()

				if(RE.id == "atropine")
					M:remove_chem("atropine", 1)
					if(prob(5))
						M:vomit()

				if(RE.id == "Nuclear titbit")
					M:remove_chem("Nuclear titbit", 1)
					if(prob(5))
						M:vomit()


	spawn(0)
		M:be_tick = 5
		M:remove_chem("cognitozepam", 0.006)

/datum/on_mob/CBD
	rid = "CBD"
/datum/on_mob/CBD
/datum/on_mob/CBD/react(quaziamt, R, mob/M)
	if(M:chronoclock)
		if(prob(5))
			M:chronoclock = 0
		else
			M:chronoclock--

	if(M:chronodepr && prob(2))
		M << "\green You feel less depressed."
		M:chronodepr--

	if(prob(10 + quaziamt * 2))
		M << "\green You feel relaxed."
		M:calm++

		if(M:euphoria < 50)
			M:euphoria += pick(1, 2)

	if(quaziamt >= 20 && prob(50))
		M:drowsy_change(2)


	spawn(0) if(prob(20 + quaziamt * 2)) M:remove_chem("CBD", 1)
/datum/on_mob/MDA
	rid = "MDA"
/datum/on_mob/MDA
/datum/on_mob/MDA/react(quaziamt, R, mob/M)
	if(prob(quaziamt / 4 + (15 - M:calm)))
		M:calm++

	if(prob(5))
		M:spacevisions(0)

	if(M:psi < 20)
		M:psi += rand(1, 3)

	M:euphoria += pick(0, 1, 2, 3)

	if(M:calm < 20)
		M:calm += 2

	if(M:depression >= 2)
		M:depression -= 2
	else if(M:depression)
		M:depression--

	if(M:tension)
		M:tension--

	if(M:chronoclock)
		if(prob(10))
			M:chronoclock = 0
		else if(M:chronoclock > 2)
			M:chronoclock -= 2
		else
			M:chronoclock--

	if(prob(5) && M:chronodepr)
		M << "\green You feel less depressed."
		M:chronodepr--

	if(M:empathy < 60)
		M:empathy = 60

	if(prob(10))
		M << "\green You feel a pleasant warmth"
		M:euphoria += 2

	if(prob(10 + quaziamt - M:cetamed * 15) && M:client)
		M:client:party_temporal(40)
	if(prob(15) && quaziamt >= 15)
		M:mindbreak(1, 3)
	if(prob(15) && quaziamt >= 20)
		M:mindbreak(1, 4)
	if(prob(15) && quaziamt >= 30)
		M:acid_dream(quaziamt / 5)
		M:mindbreak(1, 2)
	spawn(0) M:remove_chem("MDA", 0.4)
/datum/on_mob/MDMA
	rid = "MDMA"
/datum/on_mob/MDMA
/datum/on_mob/MDMA/react(quaziamt, R, mob/M)
	if(prob(quaziamt / 3 + (20 - M:calm)))
		M:calm++

	M:euphoria++

	if(prob(1))
		M:spacevisions(0)

	if(M:empathy < 100)
		M:empathy = 100

	if(M:calm < 20)
		M:calm += 2

	if(M:psi < 20)
		M:psi++

	M:euphoria += rand(2, 5)

	if(M:depression >= 2)
		M:depression -= 2
	else if(M:depression)
		M:depression--

	if(M:tension >= 2)
		M:tension -= 2
	else if(M:tension)
		M:tension--

	if(M:chronoclock)
		if(prob(20))
			M:chronoclock = 0
		else if(M:chronoclock > 2)
			M:chronoclock -= 2
		else
			M:chronoclock--

	if(prob(10) && M:chronodepr)
		M << "\green You feel less depressed."
		M:chronodepr--

	if(prob(10 + min(quaziamt, 15)))
		M << "\green You feel a pleasant warmth"
		M:euphoria += 2

	if(prob(20 + quaziamt - M:cetamed * 15) && M:client)
		M:client:party_temporal(150)
	if(prob(15) && quaziamt >= 20)
		M:mindbreak(1, 3)
	if(prob(15) && quaziamt >= 30)
		M:mindbreak(1, 4)
	if(prob(10) && quaziamt >= 40)
		M:acid_dream(quaziamt / 5)
		M:mindbreak(1, 2)
	spawn(0) M:remove_chem("MDMA", 0.11)
/datum/on_mob/MDOH
	rid = "MDOH"
/datum/on_mob/MDOH
/datum/on_mob/MDOH/react(quaziamt, R, mob/M)
	if(prob(quaziamt / 3 + (20 - M:calm)))
		M:calm++

	M:euphoria++

	if(prob(5))
		M:spacevisions(0)

	if(M:empathy < 75)
		M:empathy = 75

	if(M:libido < 15)
		M:libido += 2

	if(M:calm < 20)
		M:calm += 2

	if(M:psi < 40)
		M:psi += rand(1, 3)

	M:euphoria += rand(1, 3)

	if(M:depression)
		M:depression--

	if(M:chronoclock)
		if(prob(25))
			M:chronoclock = 0
		else if(M:chronoclock > 2)
			M:chronoclock -= 2
		else
			M:chronoclock--

	if(prob(5) && M:chronodepr)
		M << "\green You feel less depressed."
		M:chronodepr--

	if(prob(10 + min(quaziamt / 1.5, 15)))
		M << "\green You feel a pleasant warmth"
		M:euphoria += 2

	if(prob(20 + quaziamt / 1.5 - M:cetamed * 15) && M:client)
		M:client:party_temporal(150)
	if(prob(15) && quaziamt >= 20)
		M:mindbreak(1, 3)
	if(prob(15) && quaziamt >= 30)
		M:mindbreak(1, 4)
	if(prob(10) && quaziamt >= 40)
		M:acid_dream(quaziamt / 5)
		M:mindbreak(1, 2)
	spawn(0) M:remove_chem("MDOH", 0.3)
/datum/on_mob/phenethylamine
	rid = "phenethylamine"
/datum/on_mob/phenethylamine
/datum/on_mob/phenethylamine/react(quaziamt, R, mob/M)
	if(quaziamt > 10 && prob(33))
		M:calm++
	else if(quaziamt > 10 && prob(50))
		M:calm--
	if(quaziamt > 20 && (prob(quaziamt) && M:client))
		M:client:party_temporal(40)
	if(prob(15) && quaziamt >= 60)
		M:acid_dream(quaziamt / 6)
		M:mindbreak(0.005 * quaziamt, 2)
	if(quaziamt > 10 && prob(5))
		M:psychosis++
	spawn(0) M:remove_chem("phenethylamine", 0.4)

/datum/on_mob/DMT
	rid = "DMT"
/datum/on_mob/DMT
/datum/on_mob/DMT/react(quaziamt, R, mob/M)
	var/dmt = new /obj/hud_effect/dmt()

	var/hueg = new /obj/hud_effect/dmt_huge()

	if(quaziamt > 0.015 && quaziamt < 0.3)

		if(M:chronoclock)
			if(prob(10))
				M:chronoclock = 0
			else
				M:chronoclock--

		if(M:chronodepr && prob(7))
			M << "\green You feel less depressed."
			M:chronodepr--

	M:spacevisions(33)

	if(M:adapt < 10)
		M:adapt++

	for(var/turf/T in view(M))
		if(T.density && prob(60 + quaziamt * 100 - M:cetamed * 20))
			new /obj/drugged/wall_fract(T)
		if(!T.density && prob(60 + quaziamt * 100 - M:cetamed * 10))
			new /obj/drugged/floor_fract(T)
		if(!T.density && (quaziamt >= 0.2 && prob(15)))
			var/D = new /obj/drugged/elf(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2
		if(!T.density && (quaziamt >= 0.25 && prob(2 - M:cetamed)))
			var/D = new /obj/drugged/dobman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2

	if(M:euphoria >= 50)
		if(prob(66))
			M:euphoria -= 5
	else
		M:euphoria += pick(-10, 20)

	if(M:adapt > 5 && prob(M:adapt * 2))
		M:euphoria += pick(-20, 25)
		M << "\blue You hear an echoe from the throughts inside of your head."
		if(prob(50))
			M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

	M:psi += rand(2, 10)

	if(M:see_invisible < 14)
		M:see_invisible++

	if(prob(5) && (M:adapt > 9 && M:client))
		M:client:screen += hueg
		spawn(50)
			if(hueg && M:client)
				M:client:screen -= hueg

	if(prob(quaziamt * 200 - quaziamt * M:cetamed * 90) && M:client)
		M:client:screen += dmt
		spawn(quaziamt * 50 - quaziamt * 25 * M:cetamed)
			if(dmt && M:client)
				M:client:screen -= dmt

	if(quaziamt > 0.05 && prob(35 - M:adapt - M:cetamed * 20))
		M << "\red \bold OH FUCK NO IT IS TOO SCARY"
		M:stun(1 + round(quaziamt))
		M:calm -= pick(1, 1, 1, 1, 2, 3, round(quaziamt))
	else
		M:acid_dream(quaziamt * 100)


	if(quaziamt >= 0.3 || prob(1))
		if(prob(15))
			M:mindbreak(pick(1, 2), 2)
		if(prob(15))
			M:mindbreak(pick(1, 2), 3)
		if(prob(15))
			M:mindbreak(pick(1, 2), 4)
	spawn(0) M:remove_chem("DMT", 0.015)
/datum/on_mob/five_meo
	rid = "5-MeO-DMT"
/datum/on_mob/five_meo
/datum/on_mob/five_meo/react(quaziamt, R, mob/M)
	var/dmt = new /obj/hud_effect/dmt()

	if(quaziamt > 0.009 && quaziamt < 0.6)

		if(M:chronoclock)
			if(prob(2))
				M:chronoclock = 0
			else if(prob(50))
				M:chronoclock--

		if(M:chronodepr && prob(2))
			M << "\green You feel less depressed."
			M:chronodepr--

	if(prob(50))
		M:spacevisions(66 - M:cetamed * 33)

	if(M:adapt < 10)
		M:adapt++
	for(var/turf/T in view(M))

		if(T.icon_state == "green" && prob(4 - M:cetamed))
			new /obj/drugged/floor_grind(T)

		if(T.icon_state == "green_broken" && prob(8 - M:cetamed))
			new /obj/drugged/floor_broken(T)

		if(T.density && prob(10))
			new /obj/drugged/wall(T) || new /obj/drugged/wall_fract(T)
		if(!T.density && prob(20))
			new /obj/drugged/floor_fract(T) || new /obj/drugged/floor_mov(T)
		if(!T.density && (quaziamt >= 0.2 && prob(2 - M:cetamed)))
			var/D = new /obj/drugged/acid_spaceman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2
		if(!T.density && (quaziamt >= 0.25 && prob(1)))
			var/D = new /obj/drugged/dobman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2

	if(M:euphoria >= 50)
		if(prob(66))
			M:euphoria -= 5
	else
		M:euphoria += pick(-13, 14)

	M:psi += rand(2, 5)

	if(M:see_invisible < 7)
		M:see_invisible++

	if(prob(quaziamt * 15 - quaziamt * M:cetamed * 7) && M:client)
		M:client:screen += dmt
		spawn(quaziamt * 20 - quaziamt * 10 * M:cetamed)
			if(dmt && M:client)
				M:client:screen -= dmt

	if(quaziamt > 0.6 && prob(35 - M:adapt * 5 - M:cetamed * 20))
		M << "\red \bold OH FUCK NO IT IS TOO SCARY"
		M:stun(1 + round(quaziamt))
		M:calm -= pick(-1, -1, 1, 1, 2, 3, round(quaziamt * 2))
	else
		M:acid_dream(quaziamt * 4)


	if(quaziamt >= 1.8 || prob(1))
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 3)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 4)
	spawn(0) M:remove_chem("5-MeO-DMT", 0.09)
/datum/on_mob/fivedipt
	rid = "5-MeO-DiPT"
/datum/on_mob/fivedipt
/datum/on_mob/fivedipt/react(quaziamt, R, mob/M)
	var/dmt = new /obj/hud_effect/dmt()

	if(quaziamt > 0.007 && quaziamt < 1.4)

		if(M:chronoclock)
			if(prob(5))
				M:chronoclock = 0
			else
				M:chronoclock--

		if(M:chronodepr && prob(5))
			M << "\green You feel less depressed."
			M:chronodepr--

	if(prob(50))
		M:spacevisions(33)

	if(M:adapt < 10)
		M:adapt++

	for(var/turf/T in view(M))
		if(T.density && prob(2 + quaziamt * 2))
			new /obj/drugged/wall_fract(T)

	for(var/turf/T in view(M))

		if(T.icon_state == "green" && prob(4 - M:cetamed))
			new /obj/drugged/floor_grind(T)

		if(T.icon_state == "green_broken" && prob(8 - M:cetamed))
			new /obj/drugged/floor_broken(T)

		if(T.density && prob(8))
			new /obj/drugged/wall(T) || new /obj/drugged/wall_fract(T)
		if((istype(T, /turf/floor) || istype(T, /turf/ground)) && prob(10))
			new /obj/drugged/floor(T)
		else if(!T.density && (quaziamt >= 0.2 && prob(2)))
			var/D = new /obj/drugged/acid_spaceman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2
		if(!T.density && (quaziamt >= 0.25 && prob(1)))
			var/D = new /obj/drugged/dobman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2

	if(prob(round(M:adapt / 3)))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	M:distortion += pick(2, 3, 4, 5)

	if(M:euphoria >= 50)
		if(prob(66))
			M:euphoria -= 5
	else
		M:euphoria += pick(-5, 9)

	M:psi += rand(1, 6)

	if(M:see_invisible < 9)
		M:see_invisible++

	if(prob(quaziamt * 10 - quaziamt * M:cetamed * 5) && M:client)
		M:distortion++
		M:client:screen += dmt
		spawn(quaziamt * 15 - quaziamt * 8 * M:cetamed)
			if(dmt && M:client)
				M:client:screen -= dmt

	if(quaziamt > 0.6 && prob(30 - M:adapt * 2 - M:cetamed * 20))
		M << "\red \bold Damn, it is fucking weird."
		M:stun(quaziamt)
		M:calm -= pick(-2, -1, 1, 2, round(quaziamt * 2))
		M:distortion++
	else
		M:acid_dream(quaziamt * 4)
	if(prob(10 + quaziamt * 6))

		M:distortion++
	if(quaziamt >= 1.4 || prob(1))
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 3)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 4)
	spawn(0) M:remove_chem("5-MeO-DiPT", 0.07)
/datum/on_mob/dipt
	rid = "DiPT"
/datum/on_mob/dipt
/datum/on_mob/dipt/react(quaziamt, R, mob/M)
	var/dmt = new /obj/hud_effect/dmt()

	if(quaziamt > 0.085 && quaziamt < 1.7)

		if(M:chronoclock)
			if(prob(5))
				M:chronoclock = 0
			else
				M:chronoclock--

		if(M:chronodepr && prob(5))
			M << "\green You feel less depressed."
			M:chronodepr--

	if(M:adapt < 10)
		M:adapt++

	M:distortion += pick(2, 4, 6, 8)


	if(M:euphoria >= 50)
		if(prob(66))
			M:euphoria -= 5
	else
		M:euphoria += pick(-4, 7)

	M:psi += rand(1, 4)

	if(M:see_invisible < 7)
		M:see_invisible++

	if(prob(quaziamt * 5) && M:client)
		M:distortion++
		M:client:screen += dmt
		spawn(quaziamt * 15 - quaziamt * 8 * M:cetamed)
			if(dmt && M:client)
				M:client:screen -= dmt

	if(quaziamt > 0.6 && prob(25 - M:adapt * 2 - M:cetamed * 15))
		M << "\red \bold OH FUCK NO IT IS TOO SCARY"
		M:stun(quaziamt)
		M:calm -= pick(1, 1, 1, 1, 2, 3)
		M:distortion += 2
	else
		M:acid_dream(quaziamt * 4)
	if(prob(10 + quaziamt * 6))

		M:distortion += 2
	if(quaziamt >= 1.7 || prob(1))
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 3)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 4)
	spawn(0) M:remove_chem("DiPT", 0.085)
/datum/on_mob/psilocybin
	rid = "psilocybin"
/datum/on_mob/psilocybin
/datum/on_mob/psilocybin/react(quaziamt, R, mob/M)
	var/mesc = new /obj/hud_effect/mesc_soft()

	if(prob(50))
		M:spacevisions(33)

	if(quaziamt > 0.08 && quaziamt < 20)

		if(M:chronoclock)
			if(prob(5))
				M:chronoclock = 0
			else
				M:chronoclock--

		if(M:chronodepr && prob(5))
			M << "\green You feel less depressed."
			M:chronodepr--

	if(M:adapt < 10)
		M:adapt++

	for(var/turf/T in view(M))
		if(T.density && prob(quaziamt * 2))
			new /obj/drugged/wall(T)
		if((istype(T, /turf/floor) || istype(T, /turf/ground)) && prob(quaziamt * 2.5))
			new /obj/drugged/floor(T)
		else if(!T.density && (quaziamt >= 0.2 && prob(2)))
			var/D = new /obj/drugged/acid_spaceman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2
		if(!T.density && (quaziamt >= 0.25 && prob(1)))
			var/D = new /obj/drugged/dobman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2

	if(M:euphoria >= 50)
		if(prob(66))
			M:euphoria -= 5
	else
		M:euphoria += pick(-1, 3)

	if(prob(quaziamt))

		if(M:euphoria >= 70)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-3, 5)
		M:psi++
		if(prob(33))
			M << "\blue You hear an echoe from the throughts inside of your head."
			if(prob(50))
				M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

	M:psi += rand(2, 4)

	M:acid_dream(quaziamt / 1.5)

	if(M:see_invisible < 5)
		M:see_invisible++

	if(prob(quaziamt / 4 - quaziamt * M:cetamed * 0.24) && (M:adapt > 8 && M:client))
		M:client:screen += mesc
		spawn(quaziamt / 1.5 - M:cetamed)
			if(M:client)
				for(var/obj/hud_effect/H in M:client:screen)
					if(!istype(H, /obj/hud_effect/eye))
						M:client:screen -= H


	if(quaziamt >= 60 && prob(quaziamt / 4 - M:adapt - M:cetamed * 20))
		M:calm -= rand(2, 6)
		M << "\blue Where the fuck am I?"

		M:euphoria += pick(-6 + M:cetamed, 3)


	if(prob(10 + quaziamt * 2 - M:cetamed * 20))
		if(quaziamt <= 20)
			if(M:client)
				M:client:view = 8 - M:cetamed * 2
		else if(quaziamt <= 25)
			if(M:client)
				M:client:view = 9 - M:cetamed * 3
		else
			if(M:client)
				M:client:view = 10 - M:cetamed * 3
		spawn(80)
			if(M:client)
				M:client:view = M:client:true_view
	if(prob(quaziamt * 2 - M:cetamed * 12) && M:client)
		M:client:shroomed(quaziamt * 10)
	if(prob(quaziamt * 1.5 - M:cetamed * quaziamt) && M:client)
		spawn(pick(5, 10, 20))
			M:client:dir = 4
			spawn(1)
				M:client:dir = 2
				spawn(1)
					M:client:dir = 8
					spawn(1)
						M:client:dir = 1
	if(quaziamt >= 20 || prob(1))
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 3)
		if(prob(5) && quaziamt > 20)
			M:acid_dream(quaziamt / 2)
			M:mindbreak(pick(1, 2), 4)
	spawn(0) M:remove_chem("psilocybin", 0.8)
/datum/on_mob/homet
	rid = "4-HO-MET"
/datum/on_mob/homet
/datum/on_mob/homet/react(quaziamt, R, mob/M)
	var/mesc = new /obj/hud_effect/mesc_soft()

	if(quaziamt > 0.008 && quaziamt < 2)

		if(M:chronoclock)
			if(prob(5))
				M:chronoclock = 0
			else
				M:chronoclock--

		if(M:chronodepr && prob(5))
			M << "\green You feel less depressed."
			M:chronodepr--

	if(quaziamt > 0.008 && prob(quaziamt * 100))

		if(prob(50))
			M:spacevisions(20)

		if(M:adapt < 10)
			M:adapt++

		for(var/turf/T in view(M))
			if(T.density && prob(quaziamt * 20))
				new /obj/drugged/wall(T)
			if((istype(T, /turf/floor) || istype(T, /turf/ground)) && prob(quaziamt * 25))
				new /obj/drugged/floor(T)
			else if(!T.density && (quaziamt >= 0.2 && prob(2)))
				var/D = new /obj/drugged/acid_spaceman(T)
				if(M:z == 7)
					D:invisibility = 0
					D:clock *= 5
					D:laggy /= 2
			if(!T.density && (quaziamt >= 0.25 && prob(1)))
				var/D = new /obj/drugged/dobman(T)
				if(M:z == 7)
					D:invisibility = 0
					D:clock *= 5
					D:laggy /= 2

		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-1, 3)

		if(prob(quaziamt * 10))

			M:euphoria += pick(-3, 5)
			M:psi++
			if(prob(33))
				M << "\blue You hear an echoe from the throughts inside of your head."
				if(prob(50))
					M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

		M:psi += rand(1, 3)

		M:acid_dream(quaziamt * 6)

		if(M:see_invisible < 5)
			M:see_invisible++

		if(prob(quaziamt / 4 - quaziamt * M:cetamed * 0.24) && (M:adapt > 8 && M:client))
			M:client:screen += mesc
			spawn(quaziamt / 1.5 - M:cetamed)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H


		if(quaziamt >= 6 && prob(quaziamt * 2.5 - M:adapt - M:cetamed * 20))
			M:calm -= rand(2, 6)
			M << "\blue Where the fuck am I?"

			M:euphoria += pick(-8 + M:cetamed, 3)


		if(prob(10 + quaziamt * 20 - M:cetamed * 20))
			if(quaziamt <= 20)
				if(M:client)
					M:client:view = 8 - M:cetamed * 2
			else if(quaziamt <= 25)
				if(M:client)
					M:client:view = 9 - M:cetamed * 3
			else
				if(M:client)
					M:client:view = 10 - M:cetamed * 3
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		if(prob(quaziamt * 20 - M:cetamed * 12) && M:client)
			M:client:shroomed(quaziamt * 10)
		if(prob(quaziamt * 15 - M:cetamed * quaziamt) && M:client)
			spawn(pick(5, 10, 20))
				M:client:dir = 4
				spawn(1)
					M:client:dir = 2
					spawn(1)
						M:client:dir = 8
						spawn(1)
							M:client:dir = 1
		if(quaziamt >= 2 || prob(1))
			if(prob(15))
				M:mindbreak(pick(1, 1, 2), 3)
			if(prob(5) && quaziamt > 2.5)
				M:acid_dream(quaziamt / 2)
				M:mindbreak(pick(1, 2), 4)
	spawn(0) M:remove_chem("4-HO-MET", 0.08)
/datum/on_mob/acodmt
	rid = "4-AcO-DMT"
/datum/on_mob/acodmt
/datum/on_mob/acodmt/react(quaziamt, R, mob/M)
	var/frac = new /obj/hud_effect/dmt()

	if(quaziamt > 0.08 && quaziamt < 2)

		if(M:chronoclock)
			if(prob(10))
				M:chronoclock = 0
			else
				M:chronoclock--

		if(M:chronodepr && prob(5))
			M << "\green You feel less depressed."
			M:chronodepr--

	if(quaziamt > 0.08 && prob(quaziamt * 100))

		if(prob(20))
			M:spacevisions(40)

		if(M:adapt < 10)
			M:adapt++

		for(var/turf/T in view(M))
			if(T.density && prob(60 + quaziamt * 100 - M:cetamed * 20))
				new /obj/drugged/wall_fract(T)
			if(!T.density && (quaziamt >= 0.25 && prob(2 - M:cetamed)))
				var/D = new /obj/drugged/dobman(T)
				if(M:z == 7)
					D:invisibility = 0
					D:clock *= 5
					D:laggy /= 2

		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-5, 10)

		if(prob(quaziamt * 10))

			M:euphoria += pick(-20, 25)
			M:psi++
			if(prob(33))
				M << "\blue You hear an echoe from the throughts inside of your head."
				if(prob(50))
					M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

		M:psi += rand(1, 3)

		M:acid_dream(quaziamt * 6)

		if(M:see_invisible < 9)
			M:see_invisible++

		if(prob(10 + round(quaziamt * 1.2) - M:cetamed * 4) && (M:adapt > 8 && M:client))
			M:client:screen += frac
			spawn(30 - M:cetamed * 15)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H

		if(quaziamt >= 5 && prob(quaziamt * 2.5 - M:adapt - M:cetamed * 20))
			M << "\red \bold OH FUCK NO IT IS TOO SCARY"
			M:stun(1 + round(quaziamt))
			M:calm -= pick(1, 1, 1, 1, 2, 3, round(quaziamt))
			M << "\blue Where the fuck am I?"

			M:euphoria += pick(-9 + M:cetamed, 3)


		if(prob(10 + quaziamt * 20 - M:cetamed * 20))
			if(quaziamt <= 20)
				if(M:client)
					M:client:view = 8 - M:cetamed * 2
			else if(quaziamt <= 25)
				if(M:client)
					M:client:view = 9 - M:cetamed * 3
			else
				if(M:client)
					M:client:view = 10 - M:cetamed * 3
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		if(prob(quaziamt * 20 - M:cetamed * 12) && M:client)
			M:client:shroomed(quaziamt * 10)
		if(prob(quaziamt * 15 - M:cetamed * quaziamt) && M:client)
			spawn(pick(5, 10, 20))
				M:client:dir = 4
				spawn(1)
					M:client:dir = 2
					spawn(1)
						M:client:dir = 8
						spawn(1)
							M:client:dir = 1
		if(quaziamt >= 2 || prob(1))
			if(prob(15))
				M:mindbreak(pick(1, 1, 2), 3)
			if(prob(5) && quaziamt > 2.5)
				M:acid_dream(quaziamt / 2)
				M:mindbreak(pick(1, 2), 4)
	spawn(0) M:remove_chem("4-AcO-DMT", 0.08)

/datum/on_mob/bromodmt
	rid = "5-Bromo-DMT"
/datum/on_mob/bromodmt
/datum/on_mob/bromodmt/react(quaziamt, R, mob/M)
	var/dmt = new /obj/hud_effect/dmt()

	if(M:calm < 0 && prob(50))
		M:calm++

	if(quaziamt > 0.009 && quaziamt < 0.6)

		if(M:chronoclock)
			if(prob(5))
				M:chronoclock = 0
			else if(prob(66))
				M:chronoclock--

		if(M:chronodepr && prob(5))
			M << "\green You feel less depressed."
			M:chronodepr--

	if(prob(50))
		M:spacevisions(20 - M:cetamed * 5)

	if(M:adapt < 10)
		M:adapt++
	for(var/turf/T in view(M))

		if(T.icon_state == "green" && prob(4 - M:cetamed))
			new /obj/drugged/floor_grind(T)

		if(T.icon_state == "green_broken" && prob(8 - M:cetamed))
			new /obj/drugged/floor_broken(T)

		if(T.density && prob(10))
			new /obj/drugged/wall(T) || new /obj/drugged/wall_fract(T)
		if(!T.density && prob(20))
			new /obj/drugged/floor_fract(T) || new /obj/drugged/floor_mov(T)
		if(!T.density && (quaziamt >= 0.2 && prob(2 - M:cetamed)))
			var/D = new /obj/drugged/acid_spaceman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2
		if(!T.density && (quaziamt >= 0.25 && prob(1)))
			var/D = new /obj/drugged/dobman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2

	if(prob(66))
		M:euphoria += pick(-5, 15)

	M:psi += rand(2, 5)

	if(M:see_invisible < 7)
		M:see_invisible++

	if(prob(quaziamt * 15 - quaziamt * M:cetamed * 7) && M:client)
		M:client:screen += dmt
		spawn(quaziamt * 20 - quaziamt * 10 * M:cetamed)
			if(dmt && M:client)
				M:client:screen -= dmt

	if(quaziamt > 0.6 && prob(35 - M:adapt * 5 - M:cetamed * 20))
		M << "\green \bold You feel a wave of sedatation coming through your body."
		M:stun(1 + round(quaziamt))
		M:calm += 5
	else
		M:acid_dream(quaziamt * 4)


	if(quaziamt >= 1.8 || prob(1))
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 3)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 4)
	spawn(0) M:remove_chem("5-Bromo-DMT", 0.09)


/datum/on_mob/amt
	rid = "AMT"

/datum/on_mob/amt
/datum/on_mob/amt/react(quaziamt, R, mob/M)
	if(M:empathy < 30)
		M:empathy = 30

	if(M:drowsy)
		M:drowsy = 0

	if(quaziamt > 0.08 && quaziamt < 2)

		if(M:chronoclock)
			if(prob(33))
				M:chronoclock = 0
			else
				if(M:chronoclock >= 3)
					M:chronoclock -= 3
				else
					M:chronoclock--

		if(M:chronodepr && prob(25))
			M << "\green You feel less depressed."
			M:chronodepr--

		if(M:adapt < 10)
			M:adapt++

	if(quaziamt > 0.08 && prob(quaziamt * 20))

		if(prob(20 - M:adapt * 1.5))
			M:spacevisions(10)

		for(var/turf/T in view(M))
			if(T.density && prob(1))
				new /obj/drugged/wall_fract(T)

		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-5, 10)

		if(prob(quaziamt * 10))

			M:euphoria += pick(-20, 25)
			M:psi++
			if(prob(33))
				M << "\blue You hear an echoe from the throughts inside of your head."
				if(prob(50))
					M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

		M:psi += rand(1, 3)

		M:acid_dream(quaziamt * 6)

		if(M:see_invisible < 9)
			M:see_invisible++

		if(quaziamt >= 5 && prob(quaziamt * 2.5 - M:adapt - M:cetamed * 20))
			M << "\red \bold OH FUCK NO IT IS TOO SCARY"
			M:stun(1 + round(quaziamt))
			M:calm -= pick(1, 1, 1, 1, 2, 3, round(quaziamt))
			M << "\blue WHO the fuck am I?"

			M:euphoria += pick(-9 + M:cetamed, 3)


		if(prob(10 + quaziamt * 20 - M:cetamed * 20))
			if(quaziamt <= 20)
				if(M:client)
					M:client:view = 8 - M:cetamed * 2
			else if(quaziamt <= 25)
				if(M:client)
					M:client:view = 9 - M:cetamed * 3
			else
				if(M:client)
					M:client:view = 10 - M:cetamed * 3
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		if(prob(quaziamt * 15 - M:cetamed * quaziamt) && M:client)
			spawn(pick(5, 10, 20))
				M:client:dir = 4
				spawn(1)
					M:client:dir = 2
					spawn(1)
						M:client:dir = 8
						spawn(1)
							M:client:dir = 1
		if(quaziamt >= 2 || prob(1))
			if(prob(15))
				M:mindbreak(pick(1, 1, 2), 3)
			if(prob(5) && quaziamt > 2.5)
				M:acid_dream(quaziamt / 2)
				M:mindbreak(pick(1, 2), 4)
	spawn(0) M:remove_chem("AMT", 0.08)

/datum/on_mob/DXM
	rid = "DXM"

/datum/on_mob/DXM
/datum/on_mob/DXM/react(quaziamt, R, mob/M)
	if(prob(5))
		M << "\red Your organism is fighting against infection!"
		if(prob(10))
			M << "\green You feel somewhat better."
			M:flu = 0
			M:immune = 1

	if(M:coughy)
		M:coughy = 0

	if(quaziamt < 3)
		goto LAB_085B

	else if(quaziamt < 6)

		M:euphoria += pick(1, 2)

		if(M:psi < 10)
			M:psi++

		if(prob(quaziamt * 1.5))
			M:calm++
		if(M:painless < 4)
			M:painless += pick(1, 2)
		if(prob(20) && M:client)
			M:client:view = 6
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		else if(prob(25) && M:client)
			M:client:view = 8
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view

	else if(quaziamt < 9)

		M:euphoria += pick(1, 2)

		if(M:psi < 20)
			M:psi += pick(1, 2)

		if(prob(quaziamt))
			M:says_xynta += 5

		if(prob(quaziamt))

			M:euphoria += rand(2, 4)

		if(prob(5))
			M:calm++
		if(M:painless < 5)
			M:painless += pick(1, 2)
		if(prob(20 - M:cetamed * 10) && M:client)
			M:client:view = 2 + M:cetamed * 2
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		else if(prob(25) && M:client)
			M:client:view = 9 - M:cetamed * 2
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		else if(prob(33 - M:cetamed * 20))
			M << "\red You feel weird."
			M:psi++





		if(prob(10))

			var/W = new /obj/hud_effect/webpunk()

			M:client:screen += W
			spawn(30)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H

		if(prob(5))

			M:webpunk(quaziamt * 2)

	else if(quaziamt < 15)

		if(M:see_invisible < 2)
			M:see_invisible++

		if(prob(50))
			M:spacevisions(33)

		M:euphoria += pick(-1, 0, 1, 2, 3, 4, 5)

		if(M:psi < 40)
			M:psi += rand(1, 3)

		if(prob(quaziamt))
			M:says_xynta += 6



		if(M:painless < 6)
			M:painless += pick(1, 2)
		if(prob(33 - M:cetamed * 13) && M:client)
			M:client:view = 1 + M:cetamed
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		else if(prob(66 - M:cetamed * 26) && M:client)
			M:client:view = 10 - M:cetamed * 2
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		if(prob(33 - M:cetamed * 11))
			M << "\red You feel weird."

			if(prob(10))
				if(M:nausea < 5)
					M:nausea = 5
				else
					M:nausea += 2

		if(prob(2))
			M:mindbreak(1, 2)
		if(prob(5))
			M:mindbreak(pick(1, 1, 2), 5)

		if(prob(50))

			var/W = new /obj/hud_effect/webpunk()

			M:client:screen += W
			spawn(30)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H

		if(prob(10))

			M:webpunk(quaziamt * 2)

	else if(quaziamt < 30)

		if(M:see_invisible < 4)
			M:see_invisible++

		if(prob(80))
			M:spacevisions(33)

		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-1, 3)

		M:euphoria += pick(-3, 4)

		M:psi += rand(2, 4)

		if(prob(quaziamt))
			M:says_xynta += 6



		M:calm--
		if(M:painless < 8)
			M:painless += 2
		if(prob(50 - M:cetamed * 20) && M:client)
			M:client:view = 0
			spawn(90)
				if(M:client)
					M:client:view = M:client:true_view
		else if(M:client)
			M:client:view = 10 - M:cetamed * 4
			spawn(90)
				if(M:client)
					M:client:view = M:client:true_view
		if(prob(50 - M:cetamed * 20))
			M << "\red You feel weird."

			M:vomit()
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 5)
		if(prob(10))
			M:mindbreak(1, 2)
		if(prob(10 - M:cetamed * 5))
			M:damaga(1, "organ")


		M:webpunk(31)

	else if(quaziamt >= 30)

		if(M:see_invisible < 4)
			M:see_invisible++

		if(prob(80))
			M:spacevisions(33)

		M:euphoria += pick(-40 + M:cetamed * 20, 21)

		M:psi += 4

		if(prob(quaziamt - M:cetamed * 2))
			M:says_xynta += 6

		if(prob(90 - M:cetamed * 45))
			M:stun(pick(5, 10, 50 - M:cetamed * 20))


		M:calm--
		if(M:painless < 8)
			M:painless += 2
		if(prob(50 - M:cetamed * 20) && M:client)
			M:client:view = 0
			spawn(85)
				if(M:client)
					M:client:view = M:client:true_view
		else if(M:client)
			M:client:view = 10 - M:cetamed * 4
			spawn(85)
				if(M:client)
					M:client:view = M:client:true_view
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 5)
		if(prob(10))
			M:mindbreak(1, 2)
		if(prob(90))
			M << "\red You feel weird."
			M:psi++

			M:vomit()
			if(prob(15))
				M:damaga(pick(1, 2, 3), "organ")


		M:webpunk(31)

	LAB_085B:
	M:remove_chem("DXM", 0.06)

/datum/on_mob/ketamine
	rid = "ketamine"
/datum/on_mob/ketamine
/datum/on_mob/ketamine/react(quaziamt, R, mob/M)
	if(M:coughy && prob(50))
		M:coughy = 0

	if(quaziamt >= 2 && quaziamt < 4.5)
		if(M:painless < 6)
			M:painless += pick(1, 2)

		if(M:see_invisible < 4)
			M:see_invisible++

		if(prob(quaziamt * 10))
			M:says_xynta += 10

		if(prob(33))
			if(M:euphoria >= 50)
				if(prob(66))
					M:euphoria -= 5
			else
				M:euphoria += pick(-1, 1, 2, 3, 4)

		if(prob(quaziamt * 10))
			M << "\red You feel extremely weird."

			M:psi += rand(2, 4)

		if(prob(33) && M:client)
			M:client:view = 1 + M:cetamed
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		else
			if(prob(66 - M:cetamed * 13) && M:client)
				M:client:view = 9 - M:cetamed * 2
				spawn(80)
					if(M:client)
						M:client:view = M:client:true_view






		if(prob(8))
			M:mindbreak(1, 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 5)
	else if(quaziamt >= 4.5)


		M << "\blue You feel extremely numb."
		if(M:painless < 10)
			M:painless += 2
		M:drowsy_change(5)


	M:remove_chem("ketamine", 0.033)

/datum/on_mob/mxe
	rid = "MXE"
/datum/on_mob/mxe
/datum/on_mob/mxe/react(quaziamt, R, mob/M)
	if(M:coughy && prob(50))
		M:coughy = 0

	if(quaziamt >= 1 && quaziamt < 7)

		if(M:see_invisible < 4)
			M:see_invisible++

		if(prob(50))
			M:spacevisions(33)

		if(M:painless < 6)
			M:painless += pick(1, 2)

		if(prob(quaziamt * 10))
			M:says_xynta += 10

		if(prob(45))
			if(M:euphoria >= 50)
				if(prob(66))
					M:euphoria -= 5
			else
				M:euphoria += pick(-1, 1, 2, 3, 4)

		if(prob(quaziamt * 20))
			M << "\red You feel extremely weird."

			M:psi += rand(2, 4)

		if(prob(50))

			var/W = new /obj/hud_effect/webpunk()

			M:client:screen += W
			spawn(30)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H

		if(prob(10) && quaziamt >= 5)

			M:webpunk(quaziamt * 3)

		if(prob(33) && M:client)
			M:client:view = 1 + M:cetamed
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		else if(prob(66 - M:cetamed * 13) && M:client)
			M:client:view = 9 - M:cetamed * 2
			spawn(85)
				if(M:client)
					M:client:view = M:client:true_view






		if(prob(8))
			M:mindbreak(1, 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 5)
	else
		if(quaziamt >= 7)


			M << "\blue You feel extremely numb."
			if(M:painless < 10)
				M:painless += 2
			M:drowsy_change(5)


	M:remove_chem("MXE", 0.033)

/datum/on_mob/mxp
	rid = "MXP"
/datum/on_mob/mxp
/datum/on_mob/mxp/react(quaziamt, R, mob/M)
	if(M:coughy && prob(50))
		M:coughy = 0

	if(quaziamt >= 1 && quaziamt < 7)

		if(M:see_invisible < 4)
			M:see_invisible++

		if(prob(50))
			M:spacevisions(33)

		if(M:painless < 6)
			M:painless += pick(1, 2)

		if(prob(quaziamt * 10))
			M:says_xynta += 10

		M:euphoria += pick(-1, 1, 2, 3, 4)

		if(prob(quaziamt * 20))
			M << "\red You feel extremely weird."

			M:psi += rand(2, 4)

		if(prob(33) && M:client)
			M:client:view = 1 + M:cetamed
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		else if(prob(66 - M:cetamed * 13) && M:client)
			M:client:view = 9 - M:cetamed * 2
			spawn(85)
				if(M:client)
					M:client:view = M:client:true_view
		if(prob(8))
			M:mindbreak(1)
		if(prob(15))
			M:mindbreak(rand(1, 3), pick(2, 5))

		if(prob(50))

			var/W = new /obj/hud_effect/webpunk()

			M:client:screen += W
			spawn(30)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H

		if(prob(10) && quaziamt >= 5)

			M:webpunk(quaziamt * 3)
	else
		if(quaziamt >= 7 && prob(66 - M:cetamed * 22))
			M << "\red You feel being watched."
			M:ssyndrome++

	M:remove_chem("MXP", 0.033)
/datum/on_mob/salvinorin
	rid = "salvinorin A"
/datum/on_mob/salvinorin
/datum/on_mob/salvinorin/react(quaziamt, R, mob/M)
	var/curvy = new /obj/hud_effect/natural()
	var/roundy = new /obj/hud_effect/wheel()
	var/PN = new /obj/hud_effect/perun()
	var/ST = new /obj/hud_effect/stalin()

	M:psi++

	M:spacevisions(50)

	if(quaziamt >= 0.3)

		if(prob(25))

			var/W = new /obj/hud_effect/webpunk()

			M:client:screen += W
			spawn(30)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H

		if(prob(50))
			if(M:euphoria >= 50)
				if(prob(66))
					M:euphoria -= 5
			else
				M:euphoria += pick(-1, 3)

		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-5, -2, 0, 4)

		if(prob(33))
			M:says_xynta += 5

		if(quaziamt < 1)
			M:calm -= round(quaziamt * 5)
		else

			M:calm -= 5

		M:psi += rand(2, 4)

		if(M:psi <= 5)
			M:calm--

		if(prob(quaziamt * (50 - M:cetamed * 25)) && M:client)
			M:client:view = 16 - M:cetamed * 5
		else if(M:client && prob(100 - M:cetamed * 25))
			M:client:view = 12 - M:cetamed * 5
		if(M:client)
			spawn(90) M:client:view = M:client:true_view

			if(prob(100 - M:cetamed * 50))
				M:client:screen += curvy

				spawn(quaziamt * 100 - quaziamt * 50 * M:cetamed)
					if(M:client)
						for(var/obj/hud_effect/H in M:client:screen)
							if(!istype(H, /obj/hud_effect/eye))
								M:client:screen -= H

		if(quaziamt >= 1 && (M:client && prob(33)))
			M:client:screen += ST

			M << "\red \bold Stalin says: 'Get out'"

			M:calm++

			M:psi += pick(1, 2)

			M:remove_chem("salvinorin A", 0.1)

			spawn(10)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H

		else if(quaziamt >= 1.5 && (prob(quaziamt * 10) && M:client))

			if(prob(10))
				if(quaziamt >= 10)
					M:client << sound('sounds/esmart.wav')

			M:client:screen += PN

			M << "\red \bold Perun says: 'Get the fuck out of my dimension'"

			M:calm++

			M:psi += 3

			M:remove_chem("salvinorin A", 0.1)

			spawn(20)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
					if(M:client)
						for(var/obj/hud_effect/H in M:client:screen)
							if(!istype(H, /obj/hud_effect/eye))
								M:client:screen -= H


		if(prob(15 - M:cetamed * 10) && M:client)

			M:client:screen += roundy

			spawn(quaziamt * 100 - quaziamt * 50 * M:cetamed)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H

	if(quaziamt >= 0.3 && M:see_invisible < 8)
		M:see_invisible = 8

	if(quaziamt >= 0.4)
		if(prob(33))
			M:mindbreak(1, 5)

	if(prob(70 + quaziamt * 10)) M:remove_chem("salvinorin A", 0.1)

/datum/on_mob/adrenochrome
	rid = "adrenochrome"
/datum/on_mob/adrenochrome
/datum/on_mob/adrenochrome/react(quaziamt, R, mob/M)
	if(M:coughy && prob(50))
		M:coughy = 0

	if(quaziamt >= 1 && quaziamt < 7)

		if(M:see_invisible < 6)
			M:see_invisible++

		for(var/turf/T in view(M))
			if(T.density)
				new /obj/drugged/ad_wall(T)
			if(istype(T, /turf/space))
				new /obj/drugged/pseudospace(T)
			else if(!T.density && prob(25 + quaziamt * 10))
				new /obj/drugged/floor_ad(T)

		M:psi++

		if(prob(50))
			M:spacevisions(33)

		if(M:painless < 6)
			M:painless += pick(1, 2)

		if(prob(quaziamt * 20))
			M:says_xynta += 10

		if(prob(45))
			M:euphoria += rand(-5, 8)

		if(prob(5 + quaziamt * 20))
			M << "\red You feel extremely weird."
			M:psi += rand(2, 4)

		if(prob(33) && M:client)
			M:client:view = 1 + M:cetamed
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		else if(prob(66 - M:cetamed * 13) && M:client)
			M:client:view = 10 - M:cetamed * 2
			spawn(110)
				if(M:client)
					M:client:view = M:client:true_view

		if(prob(66))

			var/W = new /obj/hud_effect/webpunk()

			M:client:screen += W
			spawn(30)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H

		if(prob(10) && quaziamt >= 5)

			M:webpunk(quaziamt * 3)

		if(prob(10))
			M:mindbreak(pick(1, 1, 1, 2), 2)
		else if(prob(20))
			M:mindbreak(pick(1, 1, 2), 5)
	else
		if(quaziamt >= 7)

			M << "\blue You feel extremely numb."
			if(M:painless < 10)
				M:painless += 2
			M:drowsy_change(5)

	M:remove_chem("adrenochrome", 0.033)

/datum/on_mob/PCP
	rid = "PCP"
	stim = 1
/datum/on_mob/PCP
/datum/on_mob/PCP/react(quaziamt, R, mob/M)
	if(M:coughy && prob(50))
		M:coughy = 0

	if(quaziamt >= 2)
		if(M:painless < 6)
			M:painless += pick(1, 2)

		if(M:see_invisible < 4)
			M:see_invisible++

		if(prob(quaziamt * 10))
			M:says_xynta += 10

		if(prob(33))
			if(M:euphoria >= 50)
				if(prob(66))
					M:euphoria -= 5
			else
				M:euphoria += rand(1, 4)

		if(prob(quaziamt * 10))
			M << "\red You feel extremely weird."

			M:psi += rand(2, 4)

		if(prob(33) && M:client)
			M:client:view = 1 + M:cetamed
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		else
			if(prob(66 - M:cetamed * 13) && M:client)
				M:client:view = 9 - M:cetamed * 2
				spawn(80)
					if(M:client)
						M:client:view = M:client:true_view

		if(prob(33))

			var/partyhard = new /obj/hud_effect/party()

			M:client:screen += partyhard


			spawn(30) M:client:screen -= partyhard

		if(prob(8))
			M:mindbreak(1, 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 5)

		if(prob(3) && quaziamt >= 2.5)

			M:webpunk(35)

		if(quaziamt >= 4.5)
			M:berserk_rage(1)

		if(prob(10) && quaziamt >= 5)

			M:webpunk(quaziamt * 3)

	M:remove_chem("PCP", 0.033)

/datum/on_mob/PCE
	rid = "PCE"
	stim = 1
/datum/on_mob/PCE
/datum/on_mob/PCE/react(quaziamt, R, mob/M)
	if(M:coughy && prob(50))
		M:coughy = 0

	if(quaziamt >= 3)
		if(M:painless < 6)
			M:painless += pick(1, 2)

		if(M:see_invisible < 4)
			M:see_invisible++

		if(prob(quaziamt * 10))
			M:says_xynta += 10

		if(prob(33))
			if(M:euphoria >= 50)
				if(prob(66))
					M:euphoria -= 5
			else
				M:euphoria += rand(1, 4)

		if(prob(quaziamt * 10))
			M << "\red You feel extremely weird."

			M:psi += rand(2, 4)

		if(prob(33) && M:client)
			M:client:view = 1 + M:cetamed
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		else
			if(prob(66 - M:cetamed * 13) && M:client)
				M:client:view = 9 - M:cetamed * 2
				spawn(80)
					if(M:client)
						M:client:view = M:client:true_view

		if(prob(33))

			var/partyhard = new /obj/hud_effect/party()

			M:client:screen += partyhard


			spawn(30) M:client:screen -= partyhard

		if(prob(8))
			M:mindbreak(1, 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 5)

		if(prob(3) && quaziamt >= 4)

			M:webpunk(35)

		if(quaziamt >= 5.5)
			M:berserk_rage(1)

	M:remove_chem("PCE", 0.1)

/datum/on_mob/meoPCP
	rid = "3-MeO-PCP"
	stim = 1
/datum/on_mob/meoPCP
/datum/on_mob/meoPCP/react(quaziamt, R, mob/M)
	if(M:coughy && prob(50))
		M:coughy = 0

	if(quaziamt >= 1.33)
		if(M:painless < 6)
			M:painless += pick(1, 2)

		if(M:see_invisible < 4)
			M:see_invisible++

		if(prob(quaziamt * 10))
			M:says_xynta += 10

		if(prob(33))
			if(M:euphoria >= 50)
				if(prob(66))
					M:euphoria -= 5
			else
				M:euphoria += rand(1, 4)

		if(prob(quaziamt * 10))
			M << "\red You feel extremely weird."

			M:psi += rand(2, 4)

		if(prob(33) && M:client)
			M:client:view = 1 + M:cetamed
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		else
			if(prob(66 - M:cetamed * 13) && M:client)
				M:client:view = 9 - M:cetamed * 2
				spawn(80)
					if(M:client)
						M:client:view = M:client:true_view

		if(prob(33))

			var/partyhard = new /obj/hud_effect/party()

			M:client:screen += partyhard


			spawn(30) M:client:screen -= partyhard

		if(prob(8))
			M:mindbreak(1, 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 5)

		if(prob(3) && quaziamt >= 2)

			M:webpunk(35)

		if(quaziamt >= 3)
			M:berserk_rage(1)

	M:remove_chem("3-MeO-PCP", 0.02)

/datum/on_mob/meoPCE
	rid = "3-MeO-PCE"
	stim = 1
/datum/on_mob/meoPCE
/datum/on_mob/meoPCE/react(quaziamt, R, mob/M)
	if(M:coughy && prob(50))
		M:coughy = 0

	if(quaziamt >= 1.33)
		if(M:painless < 6)
			M:painless += pick(1, 2)

		if(M:see_invisible < 4)
			M:see_invisible++

		if(prob(quaziamt * 10))
			M:says_xynta += 10

		if(prob(33))
			if(M:euphoria >= 50)
				if(prob(66))
					M:euphoria -= 5
			else
				M:euphoria += rand(1, 4)

		if(prob(quaziamt * 10))
			M << "\red You feel extremely weird."

			M:psi += rand(2, 4)

		if(prob(33) && M:client)
			M:client:view = 1 + M:cetamed
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		else
			if(prob(66 - M:cetamed * 13) && M:client)
				M:client:view = 9 - M:cetamed * 2
				spawn(80)
					if(M:client)
						M:client:view = M:client:true_view

		if(prob(33))

			var/partyhard = new /obj/hud_effect/party()

			M:client:screen += partyhard


			spawn(30) M:client:screen -= partyhard

		if(prob(3) && quaziamt >= 2)

			M:webpunk(35)

		if(prob(8))
			M:mindbreak(1, 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 5)

		if(quaziamt >= 3)
			M:berserk_rage(1)

	M:remove_chem("3-MeO-PCE", 0.02)

/datum/on_mob/adamantane
	rid = "adamantane"

/datum/on_mob/adamantane

/datum/on_mob/adamantane/react(quaziamt, R, mob/M)

	if(M:aids_potency)
		M:aids_potency = 0

	if(M:coughy && prob(20))
		M:coughy = 0

	if(M:flu)

		if(prob(33))
			M << "\red Your organism is fighting against infection!"
			if(prob(10))
				M << "\green You feel somewhat better."
				M:flu = 0
				M:immune = 1
	M:remove_chem("adamantane", 0.25)

/datum/on_mob/amantadine
	rid = "amantadine"
/datum/on_mob/amantadine
/datum/on_mob/amantadine/react(quaziamt, R, mob/M)
	if(M:aids_potency)
		M:aids_potency = 0

	if(M:coughy && prob(33))
		M:coughy = 0

	if(M:flu)

		if(prob(75))
			M << "\red Your organism is fighting against infection!"
			if(prob(33))
				M << "\green You feel somewhat better."
				M:flu = 0
				M:immune = 1

	if(quaziamt >= 7.5)

		M:psi++

		if(M:painless < 1)
			M:painless++

		if(prob(quaziamt * 3))
			M:says_xynta += 10

		if(prob(25) && M:delirium < 15)
			M:delirium += 2
			if(prob(10))
				M:stun(2)
				M:delirium += 3
				M << "\red \bold You feel completely off the rocket."

		if(prob(33))
			M:euphoria += pick(-5, 5)

		if(prob(66))

			var/W = new /obj/hud_effect/webpunk()

			M:client:screen += W
			spawn(30)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H

		if(prob(20))

			M:webpunk(quaziamt * 2)

		if(prob(quaziamt * 2))
			M << "\red You feel extremely weird."
			M:psi += pick(2, 3, 4)

		if(prob(33) && M:client)
			M:client:view = 1 + M:cetamed * 2
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view
		else
			if(prob(66) && M:client)
				M:client:view = 9 - M:cetamed * 2
				spawn(100 - M:cetamed * 60)
					if(M:client)
						M:client:view = M:client:true_view
		if(prob(5))
			M:mindbreak(0.5, 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 1, 2), 5)
	M:remove_chem("amantadine", 0.25)

/datum/on_mob/rimantadine
	rid = "rimantadine"
/datum/on_mob/rimantadine
/datum/on_mob/rimantadine/react(quaziamt, R, mob/M)
	if(M:aids_potency)
		M:aids_potency = 0

	if(M:coughy && prob(33))
		M:coughy = 0

	if(M:flu)

		if(prob(50))
			M << "\red Your organism is fighting against infection!"
			if(prob(50))
				M << "\green You feel somewhat better."
				M:flu = 0
				M:immune = 1

	if(quaziamt >= 15)

		M:psi++

		if(M:painless < 1)
			M:painless++

		if(prob(quaziamt))
			M:says_xynta += 10

		if(prob(25) && M:delirium < 10)
			M:delirium += 2
			if(prob(10))
				M:stun(2)
				M:delirium += 2
				M << "\red \bold You feel completely off the rocket."

		if(prob(33))
			if(M:euphoria >= 50)
				if(prob(66))
					M:euphoria -= 5
			else
				M:euphoria += pick(-5, 5)

		if(prob(50))

			var/W = new /obj/hud_effect/webpunk()

			M:client:screen += W
			spawn(30)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H

		if(prob(20))

			M:webpunk(quaziamt * 2)

		if(prob(quaziamt * 2))
			M << "\red You feel extremely weird."
			M:psi += pick(2, 3, 4)

		if(prob(33) && M:client)
			M:client:view = 2 + M:cetamed * 2
			spawn(80 - M:cetamed * 50)
				if(M:client)
					M:client:view = M:client:true_view
		else
			if(prob(66) && M:client)
				M:client:view = 8 - M:cetamed * 2
				spawn(80 - M:cetamed * 50)
					if(M:client)
						M:client:view = M:client:true_view
		if(prob(5))
			M:mindbreak(0.5, 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 5)
	else
		if(quaziamt >= 8)
			M:euphoria += rand(1, 3)
			if(prob(10))
				M << "\green You feel somewhat better."
				if(M:calm < 20)
					M:calm++
					M:euphoria++

	M:remove_chem("rimantadine", 0.33)


/datum/on_mob/LSD
	rid = "LSD"

/datum/on_mob/LSD

/datum/on_mob/LSD/react(quaziamt, R, mob/M)
	M:psi += rand(2, 6)

	if(M:adapt < 10)
		M:adapt++

	if(M:depression && prob(80))
		M:depression--

	if(prob(5) && (M:chronodepr && M:adapt > 7))
		M:chronodepr--

	M:spacevisions(33)

	if(prob(M:adapt))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	for(var/turf/T in view(M))

		if(T.icon_state == "green" && prob(4 - M:cetamed))
			new /obj/drugged/floor_grind(T)

		if(T.icon_state == "green_broken" && prob(8 - M:cetamed))
			new /obj/drugged/floor_broken(T)

		if(T.density && prob(quaziamt * 40))
			new /obj/drugged/wall(T)
		if(T.density && prob(quaziamt * 10))
			new /obj/drugged/dob_eye(T)
		else if(!T.density && (quaziamt >= 0.2 && prob(2)))
			var/D = new /obj/drugged/acid_spaceman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2
		if(!T.density && (quaziamt >= 0.25 && prob(2)))
			var/D = new /obj/drugged/dobman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2

	if(quaziamt >= 0.15)

		if(M:see_invisible < 8)
			M:see_invisible++


		if(prob(25))
			for(var/turf/wall/T in view(M))
				if(prob(66))
					T.wall_melt(M)

	if(M:euphoria >= 50)
		if(prob(50))
			M:euphoria -= 5
	else

		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else if(prob(42))
			M:euphoria += pick(-3, 8)


	var/kislota = new /obj/hud_effect/acid()
	var/curvy = new /obj/hud_effect/natural()
	M:acid_dream(quaziamt * 20)

	if(prob(100 / (1 + M:cetamed)))
		if(prob(quaziamt * 30 - M:cetamed * 10) && M:client)
			M:client:screen += kislota
			spawn(quaziamt * 30 - quaziamt * 15 * M:cetamed)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H
		else
			if(prob(quaziamt * 20) - M:cetamed * 7 && M:client)
				M:client:screen += curvy
		spawn(quaziamt * 30 - quaziamt * 15 * M:cetamed)
			if(M:client)
				for(var/obj/hud_effect/H in M:client:screen)
					if(!istype(H, /obj/hud_effect/eye))
						M:client:screen -= H
	else
		if(prob(10 + quaziamt * 50) && M:client)
			M:client:view = 1 + M:cetamed * 2
			spawn(80 - M:cetamed * 50)
				if(M:client)
					M:client:view = M:client:true_view
	if(quaziamt >= 0.15 && prob(50 - M:adapt * 8))
		M << "\red \bold OH FUCK NO IT IS TOO SCARY"
		M:stun(2)
		M:calm -= rand(4, 8)


	if(quaziamt >= 0.25 || prob(1))
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 3)

	if(prob(5 + quaziamt * 20) && M:client)
		if(prob(80))
			M:client << sound('muzlo/pew.wav')
		else if(prob(75))
			M:client << sound('sounds/explosion1.ogg')
		else
			M:client << sound('sounds/down.ogg')

	spawn(0) M:remove_chem("LSD", 0.0015)


/datum/on_mob/LSA
	rid = "LSA"
/datum/on_mob/LSA
/datum/on_mob/LSA/react(quaziamt, R, mob/M)
	M:psi += rand(1, 4)

	if(M:adapt < 10)
		M:adapt++

	if(M:depression && prob(66))
		M:depression--

	if(prob(3) && (M:chronodepr && M:adapt > 8))
		M:chronodepr--

	if(prob(20))
		M:spacevisions(33)

	if(prob(M:adapt - 2))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	for(var/turf/T in view(M))












		if(T.icon_state == "green" && prob(4 - M:cetamed))
			new /obj/drugged/floor_grind(T)

		if(T.icon_state == "green_broken" && prob(8 - M:cetamed))
			new /obj/drugged/floor_broken(T)

		if(T.density && prob(quaziamt * 40))
			new /obj/drugged/wall(T)
		if(T.density && prob(quaziamt * 5))
			new /obj/drugged/dob_eye(T)
		else if(!T.density && (quaziamt >= 0.2 && prob(2)))
			var/D = new /obj/drugged/acid_spaceman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2
		if(!T.density && (quaziamt >= 0.25 && prob(2)))
			var/D = new /obj/drugged/dobman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2

	if(quaziamt >= 0.15 && M:see_invisible < 8)
		M:see_invisible++

	if(M:euphoria >= 50)
		if(prob(50))
			M:euphoria -= 5
	else
		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else if(prob(33))
			M:euphoria += pick(-2, 5)

	var/kislota = new /obj/hud_effect/acid()
	var/curvy = new /obj/hud_effect/natural()
	M:acid_dream(quaziamt * 20)

	if(prob(100 / (1 + M:cetamed)))
		if(prob(quaziamt * 15 - M:cetamed * 7) && M:client)
			M:client:screen += kislota
			spawn(quaziamt * 15 - quaziamt * 10 * M:cetamed)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H
		else
			if(prob(quaziamt * 10 - M:cetamed * 5) && M:client)
				M:client:screen += curvy
				spawn(quaziamt * 15 - quaziamt * 10 * M:cetamed)
					if(M:client)
						for(var/obj/hud_effect/H in M:client:screen)
							if(!istype(H, /obj/hud_effect/eye))
								M:client:screen -= H
	else
		if(prob(10 + quaziamt * 25) && M:client)
			M:client:view = 1 + M:cetamed * 2
			spawn(80 - M:cetamed * 50)
				if(M:client)
					M:client:view = M:client:true_view

	if(quaziamt >= 0.3 && prob(50 - M:adapt * 8))
		M << "\red \bold OH FUCK NO IT IS TOO SCARY"
		M:stun(2)
		M:calm -= rand(3, 6)



	if(quaziamt >= 0.25 && prob(10))
		M:sick()

	if(quaziamt >= 0.5 || prob(1))
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 3)



	if(prob(5 + quaziamt * 10) && M:client)
		if(prob(80))
			M:client << sound('muzlo/pew.wav')
		else if(prob(75))
			M:client << sound('sounds/explosion1.ogg')
		else
			M:client << sound('sounds/down.ogg')
	spawn(0) M:remove_chem("LSA", 0.003)
/datum/on_mob/DOB
	rid = "DOB"
/datum/on_mob/DOB
/datum/on_mob/DOB/react(quaziamt, R, mob/M)
	var/halynee = new /obj/hud_effect/heck()
	var/kislota = new /obj/hud_effect/acid()
	var/hammer = new /obj/hud_effect/sovok()
	M:acid_dream(quaziamt / 2)

	if(M:drowsy)
		M:drowsy = 0

	M:spacevisions(80)

	M:psi += rand(1, 3)

	if(M:adapt < 10)
		M:adapt++

	if(prob(M:adapt - 6))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	for(var/turf/T in view(M))

		if(T.icon_state == "green" && prob(4 - M:cetamed))
			new /obj/drugged/floor_grind(T)

		if(T.icon_state == "green_broken" && prob(8 - M:cetamed))
			new /obj/drugged/floor_broken(T)

		if(T.density && prob(6))
			new /obj/drugged/wall_distort(T)
		if(T.density && prob(3))
			new /obj/drugged/wall(T)
		if(T.density && prob(3))
			new /obj/drugged/dob_eye(T)
		else if(!T.density && (quaziamt >= 0.07 && prob(2)))
			var/D = new /obj/drugged/acid_spaceman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2
		if(!T.density && (quaziamt >= 0.07 && prob(2)))
			var/D = new /obj/drugged/dobman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2

	if(M:see_invisible < 9)
		M:see_invisible++

	if(quaziamt >= 0.1)
		M:psychosis += 1 + round(quaziamt * 20)
		if(prob(85 - M:adapt * 5 - M:cetamed * 30))
			M << "\red \bold OH FUCK NO IT IS TOO SCARY"
			M:stun(rand(2, 3))
			M:calm -= rand(5, 7)
			if(prob(33))
				M:damaga(rand(3, 5), "organ")
				M:legs_damage(5, 1)
	else if(quaziamt >= 0.007 && prob(65 - M:adapt * 5 - M:cetamed * 33))
		M << "\red \bold OH FUCK NO IT IS TOO SCARY"
		M:stun(rand(2, 5))
		M:calm -= rand(5, 7)


	if(quaziamt >= 0.05 && prob(8 + quaziamt * 180))
		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-8, 8)
		if(prob(33))
			M << "\blue You hear an echoe from the throughts inside of your head."
			if(prob(50))
				M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

	if(prob(100 / (1 + M:cetamed)))
		if(prob(M:adapt) && M:client)
			M:client:screen += halynee
			spawn(70 - M:cetamed * 20)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H
		else if(prob(M:adapt - M:cetamed * 2) && M:client)
			M:client:screen += kislota
			spawn(30 - M:cetamed * 15)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H
		else
			if(prob(1 - M:cetamed))
				M:client:screen += hammer
				spawn(quaziamt * 20 - M:cetamed * 10)
					if(M:client)
						for(var/obj/hud_effect/H in M:client:screen)
							if(!istype(H, /obj/hud_effect/eye))
								M:client:screen -= H

	if(quaziamt >= 0.07 || prob(1))
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 4)

	if(prob(10 + quaziamt * 100) && M:client)
		if(prob(80))
			M:client << sound('muzlo/pew.wav')
		else if(prob(75))
			M:client << sound('sounds/explosion1.ogg')
		else
			M:client << sound('sounds/down.ogg')

	spawn(0) M:remove_chem("DOB", 0.0014)

/datum/on_mob/DOI
	rid = "DOI"
/datum/on_mob/DOI
/datum/on_mob/DOI/react(quaziamt, R, mob/M)
	var/halynee = new /obj/hud_effect/vortex()
	var/kislota = new /obj/hud_effect/acid()
	var/hammer = new /obj/hud_effect/sovok()
	M:acid_dream(quaziamt / 2)

	if(M:drowsy)
		M:drowsy = 0

	if(M:adapt < 10)
		M:adapt++

	M:spacevisions(20)

	if(prob(M:adapt - 3))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	M:psi += rand(1, 3)

	for(var/turf/T in view(M))

		if(T.icon_state == "green" && prob(4 - M:cetamed))
			new /obj/drugged/floor_grind(T)

		if(T.icon_state == "green_broken" && prob(8 - M:cetamed))
			new /obj/drugged/floor_broken(T)

		if(T.density && prob(3))
			new /obj/drugged/wall(T)
		if(T.density && prob(3))
			new /obj/drugged/dob_eye(T)
		else if(!T.density && (quaziamt >= 0.07 && prob(2)))
			var/D = new /obj/drugged/acid_spaceman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2
		if(!T.density && (quaziamt >= 0.09 && (M:adapt >= 10 && prob(2))))
			var/D = new /obj/drugged/dobman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2

	if(M:see_invisible < 9)
		M:see_invisible++

	if(quaziamt >= 0.2)
		M:psychosis += 1 + round(quaziamt * 20)
		if(prob(72 - M:adapt * 5 - M:cetamed * 20))
			M << "\red \bold OH FUCK NO IT IS TOO SCARY"
			M:stun(2)
			M:calm -= pick(2, 5)
		if(prob(10))
			M:legs_damage(3, 1)
			M:damaga(rand(1, 3), "organ")
	else if(quaziamt >= 0.01 && prob(60 - M:adapt * 6 - M:cetamed * 30))
		M << "\red \bold OH FUCK NO IT IS TOO SCARY"
		M:stun(2)
		M:calm -= rand(1, 4)

	if(quaziamt >= 0.05 && prob(8 + quaziamt * 160))
		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-6, 8)
		if(prob(33))
			M << "\blue You hear an echoe from the throughts inside of your head."
			if(prob(50))
				M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

	if(prob(100 / (1 + M:cetamed)))
		if(prob(M:adapt) && M:client)
			M:client:screen += halynee
			spawn(70 - M:cetamed * 30)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H
		else if(prob(M:adapt - 2) && M:client)
			M:client:screen += kislota
			spawn(30 - M:cetamed * 15)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H
		else if(prob(1 - M:cetamed))
			M:client:screen += hammer
			spawn(quaziamt * 20 - M:cetamed * 10)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H


	if(quaziamt >= 0.07 || prob(1))
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 4)

	if(prob(5 + quaziamt * 50) && M:client)
		if(prob(80))
			M:client << sound('muzlo/pew.wav')
		else if(prob(75))
			M:client << sound('sounds/explosion1.ogg')
		else
			M:client << sound('sounds/down.ogg')

	spawn(0) M:remove_chem("DOI", 0.002)

/datum/on_mob/DOC
	rid = "DOC"
/datum/on_mob/DOC
/datum/on_mob/DOC/react(quaziamt, R, mob/M)
	var/halynee = new /obj/hud_effect/vortex()
	var/kislota = new /obj/hud_effect/acid()
	var/hammer = new /obj/hud_effect/sovok()
	M:acid_dream(quaziamt / 2)

	if(M:drowsy)
		M:drowsy = 0

	if(M:adapt < 10)
		M:adapt++

	M:spacevisions(20)

	if(prob(M:adapt))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	M:psi += rand(1, 5)

	for(var/turf/T in view(M))

		if(T.icon_state == "green" && prob(4 - M:cetamed))
			new /obj/drugged/floor_grind(T)

		if(T.icon_state == "green_broken" && prob(8 - M:cetamed))
			new /obj/drugged/floor_broken(T)
		else
			if(T.density && (prob(2) && quaziamt >= 0.19))
				new /obj/drugged/wall_distort(T)
		if(T.density && prob(3))
			new /obj/drugged/wall(T)
		if(T.density && prob(7))
			new /obj/drugged/dob_eye(T)
		else if(!T.density && (quaziamt >= 0.07 && prob(2)))
			var/D = new /obj/drugged/acid_spaceman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2
		if(!T.density && (quaziamt >= 0.09 && prob(2)))
			var/D = new /obj/drugged/dobman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2

	if(M:see_invisible < 13)
		M:see_invisible++

	if(quaziamt >= 0.2)
		M:psychosis += 1 + round(quaziamt * 20)
		if(prob(75 - M:adapt * 5 - M:cetamed * 22))
			M << "\red \bold OH FUCK NO IT IS TOO SCARY"
			M:stun(2)
			M:calm -= pick(2, 3, 4, 5, 6)
		if(prob(10))
			M:legs_damage(3, 1)
			M:damaga(rand(1, 3), "organ")
	else if(quaziamt >= 0.07 && prob(55 - M:adapt * 5 - M:cetamed * 4))
		M << "\red \bold OH FUCK NO IT IS TOO SCARY"
		M:stun(3)
		M:calm -= pick(2, 6)

	if(quaziamt >= 0.05 && prob(10 + quaziamt * 160))
		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-8, 12)
		if(prob(33))
			M << "\blue You hear an echoe from the throughts inside of your head."
			if(prob(50))
				M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

	if(prob(100 / (1 + M:cetamed)))
		if(prob(M:adapt * 1.5) && M:client)
			M:client:screen += halynee
			spawn(40 - M:cetamed * 20)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H
		else if(prob(M:adapt) && M:client)
			M:client:screen += kislota
			spawn(quaziamt * 20 - M:cetamed * 10)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H
		else if(prob(1 - M:cetamed))
			M:client:screen += hammer
			spawn(quaziamt * 20 - M:cetamed * 10)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H


	if(quaziamt >= 0.05 || prob(2))
		if(prob(20))
			M:mindbreak(pick(1, 1, 2), 2)
		if(prob(20))
			M:mindbreak(pick(1, 1, 2), 4)

	if(prob(5 + quaziamt * 50) && M:client)
		if(prob(80))
			M:client << sound('muzlo/pew.wav')
		else if(prob(75))
			M:client << sound('sounds/explosion1.ogg')
		else
			M:client << sound('sounds/down.ogg')
	spawn(0) M:remove_chem("DOC", 0.002)


/datum/on_mob/DOM
	rid = "DOM"
/datum/on_mob/DOM
/datum/on_mob/DOM/react(quaziamt, R, mob/M)
	var/halynee = new /obj/hud_effect/vortex()
	var/kislota = new /obj/hud_effect/acid()

	M:acid_dream(quaziamt / 3)

	if(M:adapt < 10)
		M:adapt++

	if(prob(50))
		M:spacevisions(20)

	if(prob(M:adapt))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		hearers(M) << sound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	M:psi += rand(1, 3)

	for(var/turf/T in view(M))
		if(T.density && (prob(M:adapt - 6) && quaziamt >= 0.19))
			new /obj/drugged/wall_distort(T)
		else if(!T.density && (quaziamt >= 0.75 && (M:adapt > 8 && prob(3))))
			var/D = new /obj/drugged/acid_spaceman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2
		else if(!T.density && (quaziamt >= 0.1 && prob(2)))
			var/D = new /obj/drugged/dobman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2

	if(M:see_invisible < 8)
		M:see_invisible++

	if(prob(100 / (1 + M:cetamed)))
		if(quaziamt >= 0.008 && (prob(55) && M:client))
			M:client:screen += halynee
			spawn(50 - M:cetamed * 30)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H
		else
			if(quaziamt >= 0.007 && (prob(quaziamt * 10) && M:client))
				M:client:screen += kislota
				spawn(20 - M:cetamed * 10)
					if(M:client)
						for(var/obj/hud_effect/H in M:client:screen)
							if(!istype(H, /obj/hud_effect/eye))
								M:client:screen -= H


	if(quaziamt >= 0.2)
		M:psychosis += 1 + round(quaziamt * 20)
		if(prob(60 - M:adapt * 5 - M:cetamed * 30))
			M << "\red \bold OH FUCK NO IT IS TOO SCARY"
			M:stun(2)
			M:calm -= rand(2, 6)
		if(prob(10))
			M:damaga(2, "organ")
			M:legs_damage(4, 1)
	else if(quaziamt >= 0.005 && prob(M:adapt * 5))
		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-3, 7)
		if(M:calm < 20)
			M:calm++
		if(prob(33))
			M << "\blue You hear an echoe from the throughts inside of your head."
			if(prob(50))
				M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

	if(quaziamt >= 0.07 || prob(1))
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 4)
	if(quaziamt >= 0.9 && (prob(quaziamt * 5) && M:client))
		if(prob(80))
			M:client << sound('muzlo/pew.wav')
		else if(prob(75))
			M:client << sound('sounds/explosion1.ogg')
		else if(quaziamt >= 10)
			M:client << sound('sounds/down.ogg')
	spawn(0) if(prob(5 + quaziamt * 10)) M:remove_chem("DOM", 0.002)


/datum/on_mob/bromoDFLY
	rid = "Bromo-DragonFLY"

/datum/on_mob/bromoDFLY
/datum/on_mob/bromoDFLY/react(quaziamt, R, mob/M)
	var/halynee = new /obj/hud_effect/heck()
	var/kislota = new /obj/hud_effect/acid()
	var/hammer = new /obj/hud_effect/sovok()
	M:acid_dream(quaziamt)

	if(M:drowsy)
		M:drowsy = 0

	M:spacevisions(80)

	M:damaga(pick(1, 2), "organ")

	M:psi += rand(1, 3)

	if(M:adapt < 10)
		M:adapt++

	if(prob(M:adapt - 6))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	for(var/turf/T in view(M))

		if(T.icon_state == "green" && prob(4 - M:cetamed))
			new /obj/drugged/floor_grind(T)

		if(T.icon_state == "green_broken" && prob(8 - M:cetamed))
			new /obj/drugged/floor_broken(T)

		if(T.density && prob(6))
			new /obj/drugged/wall_distort(T)
		if(T.density && prob(3))
			new /obj/drugged/wall(T)
		if(T.density && prob(3))
			new /obj/drugged/dob_eye(T)
		else if(!T.density && (quaziamt >= 0.07 && prob(2)))
			var/D = new /obj/drugged/acid_spaceman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2
		if(!T.density && (quaziamt >= 0.07 && prob(2)))
			var/D = new /obj/drugged/dobman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2

	if(M:see_invisible < 9)
		M:see_invisible++

	if(quaziamt >= 0.05)
		M:psychosis += 1 + round(quaziamt * 20)
		if(prob(85 - M:adapt * 5 - M:cetamed * 30))
			M << "\red \bold OH FUCK NO IT IS TOO SCARY"
			M:stun(rand(2, 3))
			M:calm -= rand(5, 7)
			if(prob(50))
				M:damaga(5, "organ")
				M:legs_damage(rand(5, 10), 1)
	else if(quaziamt >= 0.0035 && prob(65 - M:adapt * 5 - M:cetamed * 33))
		M << "\red \bold OH FUCK NO IT IS TOO SCARY"
		M:stun(rand(2, 5))
		M:calm -= rand(5, 7)


	if(quaziamt >= 0.05 && prob(8 + quaziamt * 300))
		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-8, 8)
		if(prob(33))
			M << "\blue You hear an echoe from the throughts inside of your head."
			if(prob(50))
				M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

	if(prob(100 / (1 + M:cetamed)))
		if(prob(M:adapt) && M:client)
			M:client:screen += halynee
			spawn(70 - M:cetamed * 20)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H
		else if(prob(M:adapt - M:cetamed * 2) && M:client)
			M:client:screen += kislota
			spawn(30 - M:cetamed * 15)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H
		else
			if(prob(1 - M:cetamed))
				M:client:screen += hammer
				spawn(quaziamt * 20 - M:cetamed * 10)
					if(M:client)
						for(var/obj/hud_effect/H in M:client:screen)
							if(!istype(H, /obj/hud_effect/eye))
								M:client:screen -= H

	if(quaziamt >= 0.07 || prob(1))
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 4)

	if(prob(10 + quaziamt * 100) && M:client)
		if(prob(80))
			M:client << sound('muzlo/pew.wav')
		else if(prob(75))
			M:client << sound('sounds/explosion1.ogg')
		else
			M:client << sound('sounds/down.ogg')

	spawn(0) M:remove_chem("Bromo-DragonFLY", 0.0007)
/datum/on_mob/CBFLY
	rid = "2C-B-FLY"
/datum/on_mob/CBFLY
/datum/on_mob/CBFLY/react(quaziamt, R, mob/M)
	var/halynee = new /obj/hud_effect/worms()
	var/kislota = new /obj/hud_effect/acid()
	M:acid_dream(quaziamt / 3)

	M:damaga(1, "organ")

	if(M:drowsy)
		M:drowsy = 0

	if(M:adapt < 10)
		M:adapt++

	if(M:depression)
		M:depression--

	if(prob(5) && (M:chronodepr && M:adapt > 5))
		M:chronodepr--

	if(prob(50))
		M:spacevisions(33)

	for(var/turf/T in view(M))
		if(T.density && (prob(16 - M:adapt) && quaziamt >= 2.7))
			new /obj/drugged/wall_distort(T)

	if(prob(round(M:adapt / 2)))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		hearers(M) << sound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	if(M:see_invisible < 6)
		M:see_invisible++

	M:psi += rand(2, 4)

	if(quaziamt >= 2 && prob(quaziamt * 2))
		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-3, 6)
		if(prob(33))
			M << "\blue You hear an echoe from the throughts inside of your head."
			if(prob(50))
				M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

	if(quaziamt >= 0.75 && (prob(quaziamt * 10) && M:client))
		M:client:screen += halynee
		spawn(70 - M:cetamed * 35)
			if(M:client)
				for(var/obj/hud_effect/H in M:client:screen)
					if(!istype(H, /obj/hud_effect/eye))
						M:client:screen -= H
	else
		if(quaziamt >= 2.5 && (prob(quaziamt * 3 - quaziamt * M:cetamed * 1.4) && M:client))
			M:client:screen += kislota
			spawn(quaziamt * 40 - quaziamt * 20 * M:cetamed)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H


	if(quaziamt >= 2.25 && prob(75 - M:adapt * 10 - M:cetamed * 10))
		M:psychosis += 1 + round(quaziamt)
		M << "\red \bold OH FUCK NO IT IS TOO SCARY"
		M:stun(round(quaziamt))
		M:calm -= rand(2, 6)
		M:damaga(3, "organ")
		if(prob(10))
			M:legs_damage(3, 1)
	else
		if(M:euphoria <= 20)
			M:euphoria += pick(1, 2)

	if(quaziamt >= 1.35 || prob(2))
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 4)
	if(M:adapt > 8 && (prob(quaziamt * 10) && M:client))
		if(prob(80))
			M:client << sound('muzlo/pew.wav')
		else if(prob(75))
			M:client << sound('sounds/explosion1.ogg')
		else if(quaziamt >= 10)
			M:client << sound('sounds/down.ogg')
	spawn(0) M:remove_chem("2C-B-FLY", 0.025)

/datum/on_mob/nbome
	rid = "25i-NBOMe"

/datum/on_mob/nbome

/datum/on_mob/nbome/react(quaziamt, R, mob/M)
	var/halynee = new /obj/hud_effect/dmt()
	var/kislota = new /obj/hud_effect/acid()

	M:acid_dream(quaziamt / 3)

	if(prob(50))
		M:spacevisions(33)

	if(M:adapt < 10)
		M:adapt++

	if(prob(round(M:adapt / 2) + 1))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		hearers(M) << sound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	M:psi += rand(1, 3)

	for(var/turf/T in view(M))
		if(T.density && prob(2))
			new /obj/drugged/wall(T)
		if(!T.density && (quaziamt >= 0.75 && prob(2)))
			var/D = new /obj/drugged/acid_spaceman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2
		else if(!T.density && (quaziamt >= 1.2 && prob(2)))
			var/D = new /obj/drugged/dobman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2

	if(M:see_invisible < 6)
		M:see_invisible++

	if(quaziamt >= 0.1 && prob(5 + quaziamt * 2))
		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-2, 4)
		if(prob(33))
			M << "\blue You hear an echoe from the throughts inside of your head."
			if(prob(50))
				M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

	if(prob(100 / (1 + M:cetamed)))
		if(quaziamt >= 0.2 && (prob(1 + quaziamt * 10 - M:cetamed * 4) && M:client))
			M:client:screen += halynee
			spawn(70 - M:cetamed * 30)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H
		else
			if(quaziamt >= 0.7 && (prob(1 + quaziamt * 1.5) && M:client))
				M:client:screen += kislota
				spawn(quaziamt * 20 - M:cetamed * quaziamt / 2)
					if(M:client)
						for(var/obj/hud_effect/H in M:client:screen)
							if(!istype(H, /obj/hud_effect/eye))
								M:client:screen -= H


	if(quaziamt >= 1.2)
		M:psychosis += 1 + round(quaziamt)
		if(prob(60 - M:adapt * 5 - M:cetamed * 30))
			M << "\red \bold OH FUCK NO IT IS TOO SCARY"
			M:stun(round(quaziamt))
			M:calm -= pick(2, 3, 4, 5, 6)
		if(prob(10))
			M:damaga(2, "organ")
			M:legs_damage(2, 1)
	if(quaziamt >= 1 || prob(1))
		if(prob(15))
			M:mindbreak(pick(1, 1, 1, 2), 2)


		if(prob(15))
			M:mindbreak(pick(1, 1, 1, 2), 4)
	if(quaziamt >= 0.9 && (prob(quaziamt * 5) && M:client))
		if(prob(80))
			M:client << sound('muzlo/pew.wav')
		else if(prob(75))
			M:client << sound('sounds/explosion1.ogg')
		else if(quaziamt >= 10)
			M:client << sound('sounds/down.ogg')
	spawn(0) M:remove_chem("25i-NBOMe", 0.02)

/datum/on_mob/nbome_b
	rid = "25b-NBOMe"
/datum/on_mob/nbome_b
/datum/on_mob/nbome_b/react(quaziamt, R, mob/M)
	var/halynee = new /obj/hud_effect/dmt()
	var/kislota = new /obj/hud_effect/natural()
	var/hammer = new /obj/hud_effect/sovok()

	M:acid_dream(quaziamt / 3)

	if(prob(66))
		M:spacevisions(33)

	if(M:adapt < 10)
		M:adapt++

	if(prob(M:adapt / 1.5 + quaziamt * 10))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		hearers(M) << sound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	M:psi += rand(1, 3)

	for(var/turf/T in view(M))

		if(T.density && prob(3))
			new /obj/drugged/wall(T)
		else if(!T.density && (quaziamt >= 0.75 && prob(2)))
			var/D = new /obj/drugged/acid_spaceman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2
		else if(!T.density && (quaziamt >= 1.2 && prob(2)))
			var/D = new /obj/drugged/dobman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2

	if(M:see_invisible < 7)
		M:see_invisible++

	if(quaziamt >= 0.06 && prob(10 + quaziamt * 2))
		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-5, 6)
		if(prob(33))
			M << "\blue You hear an echoe from the throughts inside of your head."
			if(prob(50))
				M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

	if(prob(100 / (1 + M:cetamed)))
		if(quaziamt >= 0.04 && (prob(quaziamt * 10 - quaziamt * M:cetamed / 2) && M:client))
			M:client:screen += halynee
			spawn(70 - M:cetamed * 35)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H
		else
			if(quaziamt >= 0.8 && (prob(quaziamt * (1.5 - quaziamt)) && M:client))
				M:client:screen += kislota
				spawn(quaziamt * 20 - quaziamt * 10 * M:cetamed)
					if(M:client)
						for(var/obj/hud_effect/H in M:client:screen)
							if(!istype(H, /obj/hud_effect/eye))
								M:client:screen -= H
			else
				if(prob(1 - M:cetamed))
					M:client:screen += hammer
					spawn(quaziamt * 20 - quaziamt * 10 * M:cetamed)
						if(M:client)
							for(var/obj/hud_effect/H in M:client:screen)
								if(!istype(H, /obj/hud_effect/eye))
									M:client:screen -= H


	if(quaziamt >= 1.2)
		M:psychosis += 1 + round(quaziamt * 1.4)
		if(prob(60 - M:adapt * 5 - M:cetamed * 5))
			M << "\red \bold OH FUCK NO IT IS TOO SCARY"
			M:stun(round(quaziamt))
			M:calm -= pick(2, 3, 4, 5, 6)
		if(prob(10))
			M:damaga(1, "organ")
			M:legs_damage(2, 1)
	if(quaziamt >= 1 || prob(1))
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 2)


		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 4)
	if(quaziamt >= 0.8 && (prob(quaziamt * 5) && M:client))
		if(prob(80))
			M:client << sound('muzlo/pew.wav')
		else if(prob(75))
			M:client << sound('sounds/explosion1.ogg')
		else if(quaziamt >= 10)
			M:client << sound('sounds/down.ogg')
	spawn(0) M:remove_chem("25b-NBOMe", 0.02)
/datum/on_mob/syberia
	rid = "2C-B"
/datum/on_mob/syberia
/datum/on_mob/syberia/react(quaziamt, R, mob/M)
	var/halynee = new /obj/hud_effect/worms()
	var/kislota = new /obj/hud_effect/acid()
	M:acid_dream(quaziamt / 3)

	if(M:drowsy)
		M:drowsy = 0

	if(M:adapt < 10)
		M:adapt++

	if(M:depression)
		M:depression--

	if(prob(5) && (M:chronodepr && M:adapt > 5))
		M:chronodepr--

	if(prob(50))
		M:spacevisions(33)

	for(var/turf/T in view(M))
		if(T.density && (prob(16 - M:adapt) && quaziamt >= 2.7))
			new /obj/drugged/wall_distort(T)

	if(prob(round(M:adapt / 2)))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		hearers(M) << sound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	if(M:see_invisible < 6)
		M:see_invisible++

	M:psi += rand(2, 4)

	if(quaziamt >= 2 && prob(quaziamt * 2))
		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-3, 6)
		if(prob(33))
			M << "\blue You hear an echoe from the throughts inside of your head."
			if(prob(50))
				M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

	if(quaziamt >= 1.5 && (prob(quaziamt * 10) && M:client))
		M:client:screen += halynee
		spawn(70 - M:cetamed * 35)
			if(M:client)
				for(var/obj/hud_effect/H in M:client:screen)
					if(!istype(H, /obj/hud_effect/eye))
						M:client:screen -= H
	else
		if(quaziamt >= 2.5 && (prob(quaziamt * 1.5 - quaziamt * M:cetamed * 0.7) && M:client))
			M:client:screen += kislota
			spawn(quaziamt * 20 - quaziamt * 10 * M:cetamed)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H


	if(quaziamt >= 4.5 && prob(75 - M:adapt * 10 - M:cetamed * 10))
		M:psychosis += 1 + round(quaziamt)
		M << "\red \bold OH FUCK NO IT IS TOO SCARY"
		M:stun(round(quaziamt))
		M:calm -= rand(2, 6)
	else
		if(M:euphoria <= 20)
			M:euphoria += pick(1, 2)

	if(quaziamt >= 2.7 || prob(2))
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 4)
	if(M:adapt > 8 && (prob(quaziamt * 5) && M:client))
		if(prob(80))
			M:client << sound('muzlo/pew.wav')
		else if(prob(75))
			M:client << sound('sounds/explosion1.ogg')
		else if(quaziamt >= 10)
			M:client << sound('sounds/down.ogg')
	spawn(0) M:remove_chem("2C-B", 0.05)
/datum/on_mob/tcp
	rid = "2C-P"
/datum/on_mob/tcp
/datum/on_mob/tcp/react(quaziamt, R, mob/M)
	var/halynee = new /obj/hud_effect/worms()
	var/kislota = new /obj/hud_effect/acid()
	var/hammer = new /obj/hud_effect/sovok()
	M:acid_dream(quaziamt / 2.8)

	if(M:drowsy)
		M:drowsy = 0

	M:psi += rand(2, 6)

	if(M:depression)
		M:depression--

	if(prob(5) && (M:chronodepr && M:adapt > 7))
		M:chronodepr--

	if(prob(50))
		M:spacevisions(75)

	if(M:adapt < 10)
		M:adapt++

	if(prob(round(M:adapt / 2)))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	if(M:see_invisible < 6)
		M:see_invisible++

	for(var/turf/T in view(M))

		if(T.density && prob(4))
			new /obj/drugged/wall_distort(T)

	if(quaziamt >= 2 && prob(quaziamt * 2))
		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-8, 12)
		if(prob(66))
			M << "\blue You hear an echoe from the throughts inside of your head."
			if(prob(50))
				M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

	if(quaziamt >= 1.5 && (prob(quaziamt * 10) && M:client))
		M:client:screen += halynee
		spawn(70 - M:cetamed * 35)
			if(M:client)
				for(var/obj/hud_effect/H in M:client:screen)
					if(!istype(H, /obj/hud_effect/eye))
						M:client:screen -= H
	else
		if(quaziamt >= 2 && (prob(quaziamt * 1.5 - quaziamt * M:cetamed * 0.7) && M:client))
			M:client:screen += kislota
			spawn(quaziamt * 20 - quaziamt * 10 * M:cetamed)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H
		else
			if(prob(1 - M:cetamed))
				M:client:screen += hammer
				spawn(quaziamt * 20 - M:cetamed * 10)
					if(M:client)
						for(var/obj/hud_effect/H in M:client:screen)
							if(!istype(H, /obj/hud_effect/eye))
								M:client:screen -= H



	if(quaziamt >= 2 && prob(quaziamt * 25 - M:adapt * 5 - M:cetamed * 5))
		M:psychosis += 1 + round(quaziamt)
		M << "\red \bold OH FUCK NO IT IS TOO SCARY"
		M:stun(round(1 + round(quaziamt)))
		M:calm -= pick(3, 6)
	if(quaziamt >= 2.2 || prob(2))
		if(prob(15))
			M:mindbreak(pick(1, 2), 2)
		if(prob(15))
			M:mindbreak(pick(1, 2), 4)
	if(M:adapt > 8 && (prob(quaziamt * 5) && M:client))
		if(prob(80))
			M:client << sound('muzlo/pew.wav')
		else if(prob(75))
			M:client << sound('sounds/explosion1.ogg')
		else if(quaziamt >= 10)
			M:client << sound('sounds/down.ogg')
	spawn(0) if(prob(10 + quaziamt * 5)) M:remove_chem("2C-P", 0.05)
/datum/on_mob/tci
	rid = "2C-I"
/datum/on_mob/tci
/datum/on_mob/tci/react(quaziamt, R, mob/M)
	var/halynee = new /obj/hud_effect/worms()
	var/kislota = new /obj/hud_effect/acid()
	M:acid_dream(quaziamt / 3)

	if(M:drowsy)
		M:drowsy = 0

	if(M:adapt < 10)
		M:adapt++

	if(M:depression)
		M:depression--

	if(prob(5) && (M:chronodepr && M:adapt > 2))
		M:chronodepr--

	if(prob(50))
		M:spacevisions(10)

	if(prob(round(M:adapt / 2)))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	M:psi += rand(1, 4)

	if(M:see_invisible < 6)
		M:see_invisible++

	if(quaziamt >= 2 && prob(quaziamt * 2))
		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-2, 0, 5)
		if(prob(33))
			M << "\blue You hear an echoe from the throughts inside of your head."
			if(prob(50))
				M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

	if(quaziamt >= 1.5 && (prob(quaziamt * 10) && M:client))
		M:client:screen += halynee
		spawn(70 - quaziamt * 35)
			if(M:client)
				for(var/obj/hud_effect/H in M:client:screen)
					if(!istype(H, /obj/hud_effect/eye))
						M:client:screen -= H
	else
		if(quaziamt >= 4 && (prob(quaziamt * 1.5 - quaziamt * M:cetamed * 0.7) && M:client))
			M:client:screen += kislota
			spawn(quaziamt * (20 - M:cetamed * 10))
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H



	if(quaziamt >= 2.9 && prob(quaziamt * (5 - M:cetamed * 2.5) - M:psychosis))
		M:psychosis += 1 + round(quaziamt)
		M << "\red \bold OH FUCK NO IT IS TOO SCARY"
		M:stun(2)
		M:calm -= pick(2, 4)
	if(quaziamt >= 3 || prob(2))
		if(prob(10))
			M:mindbreak(pick(1, 1, 1, 2), 2)


		if(prob(15))
			M:mindbreak(pick(1, 1, 1, 2), 4)
	if(quaziamt >= 4 && (prob(quaziamt * 5) && M:client))
		if(prob(80))
			M:client << sound('muzlo/pew.wav')
		else if(prob(75))
			M:client << sound('sounds/explosion1.ogg')
		else if(quaziamt >= 10)
			M:client << sound('sounds/down.ogg')
	spawn(0) M:remove_chem("2C-I", 0.05)
/datum/on_mob/mescaline
	rid = "mescaline"
/datum/on_mob/mescaline
/datum/on_mob/mescaline/react(quaziamt, R, mob/M)
	var/halynee = new /obj/hud_effect/mesc()
	var/kislota = new /obj/hud_effect/mesc_wicked()
	M:acid_dream(quaziamt / 3)

	if(prob(50))
		M:spacevisions(33)

	for(var/turf/T in view(M))
		if(T.density && prob(5 + quaziamt * 40))
			new /obj/drugged/green_wall(T)
		if(!T.density && (quaziamt >= 0.07 && prob(10 + quaziamt * 30)))
			new /obj/drugged/green_floor(T)

	if(M:drowsy)
		M:drowsy = 0

	if(M:adapt < 10)
		M:adapt++

	if(M:depression)
		M:depression--

	if(prob(5) && (M:chronodepr && M:adapt > 5))
		M:chronodepr--

	if(prob(round(M:adapt / 2)))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	if(M:see_invisible < 6)
		M:see_invisible++

	M:psi += pick(3, 4)

	if(quaziamt >= 2 && prob(quaziamt * 2))
		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-3, 6)
		if(prob(33))
			M << "\blue You hear an echoe from the throughts inside of your head."
			if(prob(50))
				M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

	if(quaziamt >= 1.5 && (prob(quaziamt * 10) && M:client))
		M:client:screen += halynee
		spawn(70 - M:cetamed * 35)
			if(M:client)
				for(var/obj/hud_effect/H in M:client:screen)
					if(!istype(H, /obj/hud_effect/eye))
						M:client:screen -= H
	else
		if(quaziamt >= 2.5 && (prob(quaziamt * 1.5 - quaziamt * M:cetamed * 0.7) && M:client))
			M:client:screen += kislota
			spawn(quaziamt * 20 - quaziamt * 10 * M:cetamed)
				if(M:client)
					for(var/obj/hud_effect/H in M:client:screen)
						if(!istype(H, /obj/hud_effect/eye))
							M:client:screen -= H


	if(quaziamt >= 4.5 && prob(75 - M:adapt * 10 - M:cetamed * 10))
		M:psychosis += 1 + round(quaziamt)
		M << "\red \bold OH FUCK NO IT IS TOO SCARY"
		M:stun(round(quaziamt))
		M:calm -= rand(2, 6)
	else
		if(M:euphoria <= 20)
			M:euphoria += pick(1, 2)

	if(quaziamt >= 2.7 || prob(2))
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 2)
		if(prob(15))
			M:mindbreak(pick(1, 1, 2), 4)
	if(M:adapt > 8 && (prob(quaziamt * 5) && M:client))
		if(prob(80))
			M:client << sound('muzlo/pew.wav')
		else if(prob(75))
			M:client << sound('sounds/explosion1.ogg')
		else if(quaziamt >= 10)
			M:client << sound('sounds/down.ogg')
	spawn(0) M:remove_chem("mescaline", 0.05)


/datum/on_mob/serotonin
	rid = "serotonin"

/datum/on_mob/serotonin
/datum/on_mob/serotonin/react(quaziamt, R, mob/M)
	M:spacevisions(50)

	var/halynee = new /obj/hud_effect/worms()
	var/kislota = new /obj/hud_effect/acid()
	var/fractals = new /obj/hud_effect/dmt()
	var/firy = new /obj/hud_effect/heck()

	if(M:adapt < 10)
		M:adapt++

	if(prob(round(M:adapt / 2)))
		M:show_message("\blue [M:name] laughs.", "\blue The life is so silly and hilarious. Let's laugh!")
		M:playsound(pick('sounds/laugh1.wav', 'sounds/laugh2.wav'))
		M:euphoria += 2

	if(prob(quaziamt * (50 - M:cetamed * 20)) && M:client)
		M:client:screen += halynee
		spawn(70 - M:cetamed * 30)
			if(M:client && prob(50))
				for(var/obj/hud_effect/H in M:client:screen)
					if(!istype(H, /obj/hud_effect/eye))
						M:client:screen -= H

	if(prob(quaziamt * (40 - M:cetamed * 16)) && M:client)
		M:client:screen += fractals
		spawn(70 - M:cetamed * 30)
			if(M:client && prob(50))
				for(var/obj/hud_effect/H in M:client:screen)
					if(!istype(H, /obj/hud_effect/eye))
						M:client:screen -= H


	if(prob(quaziamt * (30 - M:cetamed * 12)) && M:client)
		M:client:screen += firy
		spawn(70 - M:cetamed * 30)
			if(M:client)
				for(var/obj/hud_effect/H in M:client:screen)
					if(!istype(H, /obj/hud_effect/eye))
						M:client:screen -= H


	if(prob(quaziamt * (20 - M:cetamed * 8)) && M:client)
		M:client:screen += kislota
		spawn(70 - M:cetamed * 30)
			if(M:client)
				for(var/obj/hud_effect/H in M:client:screen)
					if(!istype(H, /obj/hud_effect/eye))
						M:client:screen -= H

	M:acid_dream(quaziamt / 2)

	if(M:euphoria >= 50)
		if(prob(50))
			M:euphoria -= 5
	else
		M:euphoria += rand(-3, 5)

	M:psi += 5

	for(var/turf/T in view(M))

		if(T.icon_state == "green" && prob(80 - M:cetamed * 20))
			new /obj/drugged/floor_grind(T)

		if(T.icon_state == "green_broken" && prob(80 - M:cetamed * 20))
			new /obj/drugged/floor_broken(T)

		if(T.density && prob(50))
			new /obj/drugged/wall(T)
		if(T.density && prob(10 - M:cetamed * 10))
			new /obj/drugged/dob_eye(T)
		if(!T.density && (quaziamt >= 0.02 && prob(2)))
			var/D = new /obj/drugged/acid_spaceman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2
		if(!T.density && (quaziamt >= 0.025 && prob(2)))
			var/D = new /obj/drugged/dobman(T)
			if(M:z == 7)
				D:invisibility = 0
				D:clock *= 5
				D:laggy /= 2

	if(M:see_invisible < 13)
		M:see_invisible++

	if(quaziamt >= 0.02 && prob(50))
		M:mindbreak(1, 3)

	if(quaziamt >= 0.05)
		M << "\red \bold Well, it wasn't a good idea to take this crap."
		if(prob(66 - M:cetamed * 22))
			M:ssyndrome++

	if(prob(10 + quaziamt * 200) && M:client)
		if(prob(80))
			M:client << sound('muzlo/pew.wav')
		else if(prob(75))
			M:client << sound('sounds/explosion1.ogg')
		else
			M:client << sound('sounds/down.ogg')
	spawn(0) M:remove_chem("serotonin", 0.0025)


/datum/on_mob/liquid_smoke
	rid = "liquid smoke"
/datum/on_mob/liquid_smoke
/datum/on_mob/liquid_smoke/react(quaziamt, R, mob/M)
	M:damaga(1, "heat")
	if(prob(33))
		M:damaga(1, "organ")
	spawn(0) M:remove_chem("liquid smoke", 0.25)
/datum/on_mob/cyclodol
	rid = "trihexyphenidyl"
/datum/on_mob/cyclodol
/datum/on_mob/cyclodol/react(quaziamt, R, mob/M)
	if(quaziamt >= 0.25)

		M:remove_chem("haloperidol", 0.2)

		M:cyclodol = 1

		if(quaziamt > 10)

			M:delirium++

			if(prob(20 - M:delirium))
				M:delirium++

			if(prob(quaziamt * 2))

				M:delirium++
				M:damaga(1, "organ")
		else
			if(quaziamt >= 4)

				if(M:calm < 20)
					M:calm++

				M:euphoria += 2

	if(quaziamt > 0.1)
		M:remove_chem("trihexyphenidyl", 0.1)
	else
		M:cyclodol = 0
		M:remove_chem("trihexyphenidyl", 0.1)

/datum/on_mob/haloperidol
	rid = "haloperidol"
/datum/on_mob/haloperidol
/datum/on_mob/haloperidol/react(quaziamt, R, mob/M)
	if(!M:cyclodol)
		M:stun(rand(2, 5))
		if(prob(4 + quaziamt))
			M:euphoria--
		if(prob(20))
			M << "\red Your muscles hurt."
			M:damaga(1, "organ")

	if(M:psychosis > 0)
		M:psychosis--
		if(M:psychosis > 0 && prob(15 + M:psychosis / 2))
			M:psychosis = 0

	if(quaziamt >= 1.5 && (M:calm < 20 && prob(quaziamt * 5)))
		M:calm++

	if(M:psi > 0)
		M:psi--

	if(M:see_invisible)
		M:see_invisible--

	if(prob(40))
		M:delirium = 0
	else if(M:delirium > 0)
		M:delirium--
	M:remove_chem("psilocybin", 2)
	M:remove_chem("mescaline", 0.5)
	M:remove_chem("LSD", 0.1)
	M:remove_chem("LSA", 0.1)
	M:remove_chem("DOB", 0.1)
	M:remove_chem("DOI", 0.1)
	M:remove_chem("DOC", 0.1)
	M:remove_chem("DOM", 0.1)
	M:remove_chem("2C-B", 0.1)
	M:remove_chem("2C-P", 0.1)
	M:remove_chem("2C-I", 0.1)
	M:remove_chem("2C-H", 0.1)
	M:remove_chem("Bromo-DragonFLY", 0.05)
	M:remove_chem("2C-B-FLY", 0.1)
	M:remove_chem("25i-NBOMe", 0.2)
	M:remove_chem("25b-NBOMe", 0.2)
	M:remove_chem("amphetamine", 3)
	M:remove_chem("dextroamphetamine", 3)
	M:remove_chem("methamphetamine", 3)
	M:remove_chem("dextromethamphetamine", 3)
	M:remove_chem("mephedrone", 1.5)
	M:remove_chem("cocaine", 2.5)
	M:remove_chem("BZP", 1.5)
	M:remove_chem("piperazine", 1.5)
	M:remove_chem("4-FA", 1.5)
	M:remove_chem("DXM", 2)
	M:remove_chem("MXE", 0.6)
	M:remove_chem("MXP", 0.6)
	M:remove_chem("ketamine", 0.6)
	M:remove_chem("adrenochrome", 0.6)
	M:remove_chem("PCP", 0.6)
	M:remove_chem("PCE", 0.6)
	M:remove_chem("3-MeO-PCP", 0.4)
	M:remove_chem("3-MeO-PCE", 0.4)
	M:remove_chem("DMT", 0.6)
	M:remove_chem("5-MeO-DMT", 0.6)
	M:remove_chem("5-MeO-DiPT", 0.4)
	M:remove_chem("4-HO-MET", 0.4)
	M:remove_chem("5-Bromo-DMT", 0.4)
	M:remove_chem("DiPT", 0.6)
	M:remove_chem("salvinorin A", 0.2)
	M:remove_chem("dicyclomine", 1)
	M:remove_chem("DPH", 0.5)
	M:remove_chem("tropicamide", 0.5)
	M:remove_chem("atropine", 1)
	M:remove_chem("Nuclear titbit", 1)
	M:remove_chem("MDA", 1)
	M:remove_chem("MDMA", 1)
	M:remove_chem("MDOH", 1)
	M:remove_chem("JWH-018", 1)
	M:remove_chem("white widow", 1)
	M:remove_chem("JWH-250", 1)
	M:remove_chem("AB-228", 1)
	M:remove_chem("APICA", 1)
	M:remove_chem("APINACA", 1)
	M:remove_chem("THC", 0.5)
	if(prob(66) && quaziamt >= 5)
		if(prob(15))
			M:mindbreak(-1, 1)
		if(prob(15))
			M:mindbreak(-1, 2)
		if(prob(15))
			M:mindbreak(-1, 3)
		if(prob(15))
			M:mindbreak(-1, 4)
		if(prob(15))
			M:mindbreak(-1, 5)
	spawn(0)
		M:remove_chem("haloperidol", 0.5)

/datum/on_mob/aminazine
	rid = "aminazine"
/datum/on_mob/aminazine
/datum/on_mob/aminazine/react(quaziamt, R, mob/M)
	if(!M:cyclodol)
		if(quaziamt >= 6)
			M:stun(rand(1, 3))
		if(prob(4 + quaziamt))
			M:euphoria--

	if(M:psychosis)
		M:psychosis--
		if(M:psychosis > 0 && prob(10 + M:psychosis / 2))
			M:psychosis = 0

	if(quaziamt >= 3 && (M:calm < 20 && prob(quaziamt * 10)))
		M:calm++

	if(M:psi)
		M:psi--

	if(M:see_invisible)
		M:see_invisible--

	if(quaziamt >= 30 && (prob(25) && !M:cyclodol))
		M << "\red Your muscles hurt."
		M:damaga(1, "organ")
	if(prob(33))
		M:delirium = 0
	else if(M:delirium > 0)
		M:delirium--
	M:remove_chem("psilocybin", 2)
	M:remove_chem("mescaline", 0.5)
	M:remove_chem("LSD", 0.1)
	M:remove_chem("LSA", 0.1)
	M:remove_chem("DOB", 0.1)
	M:remove_chem("DOI", 0.1)
	M:remove_chem("DOC", 0.1)
	M:remove_chem("DOM", 0.1)
	M:remove_chem("2C-B", 0.1)
	M:remove_chem("2C-P", 0.1)
	M:remove_chem("2C-I", 0.1)
	M:remove_chem("2C-H", 0.1)
	M:remove_chem("Bromo-DragonFLY", 0.05)
	M:remove_chem("2C-B-FLY", 0.1)
	M:remove_chem("25i-NBOMe", 0.2)
	M:remove_chem("25b-NBOMe", 0.2)
	M:remove_chem("amphetamine", 3)
	M:remove_chem("dextroamphetamine", 3)
	M:remove_chem("methamphetamine", 3)
	M:remove_chem("dextromethamphetamine", 3)
	M:remove_chem("mephedrone", 1.5)
	M:remove_chem("cocaine", 2.5)
	M:remove_chem("BZP", 1.5)
	M:remove_chem("piperazine", 1.5)
	M:remove_chem("4-FA", 1.5)
	M:remove_chem("DXM", 2)
	M:remove_chem("MXE", 0.6)
	M:remove_chem("MXP", 0.6)
	M:remove_chem("ketamine", 0.6)
	M:remove_chem("adrenochrome", 0.6)
	M:remove_chem("PCP", 0.6)
	M:remove_chem("PCE", 0.6)
	M:remove_chem("3-MeO-PCP", 0.4)
	M:remove_chem("3-MeO-PCE", 0.4)
	M:remove_chem("DMT", 0.6)
	M:remove_chem("5-MeO-DMT", 0.6)
	M:remove_chem("5-MeO-DiPT", 0.4)
	M:remove_chem("4-HO-MET", 0.4)
	M:remove_chem("5-Bromo-DMT", 0.4)
	M:remove_chem("DiPT", 0.6)
	M:remove_chem("salvinorin A", 0.2)
	M:remove_chem("dicyclomine", 1)
	M:remove_chem("DPH", 0.5)
	M:remove_chem("tropicamide", 0.5)
	M:remove_chem("atropine", 1)
	M:remove_chem("Nuclear titbit", 1)
	M:remove_chem("MDA", 1)
	M:remove_chem("MDMA", 1)
	M:remove_chem("MDOH", 1)
	M:remove_chem("JWH-018", 1)
	M:remove_chem("white widow", 1)
	M:remove_chem("JWH-250", 1)
	M:remove_chem("AB-228", 1)
	M:remove_chem("APICA", 1)
	M:remove_chem("APINACA", 1)
	M:remove_chem("THC", 0.5)
	if(prob(66) && quaziamt >= 6)
		if(prob(15))
			M:mindbreak(-1, 1)
		if(prob(15))
			M:mindbreak(-1, 2)
		if(prob(15))
			M:mindbreak(-1, 3)
		if(prob(15))
			M:mindbreak(-1, 4)
		if(prob(15))
			M:mindbreak(-1, 5)
	spawn(0)
		M:remove_chem("aminazine", 0.5)

/datum/on_mob/clozapine
	rid = "clozapine"
/datum/on_mob/clozapine
/datum/on_mob/clozapine/react(quaziamt, R, mob/M)
	if(!M:cyclodol)
		if(quaziamt >= 10 && prob(quaziamt))
			M:stun(rand(1, 3))

	if(M:psychosis > 0)
		M:psychosis--
		if(M:psychosis > 0 && prob(10 + M:psychosis / 2))
			M:psychosis = 0





	if(M:psi > 0)
		M:psi--

	if(M:see_invisible > 0)
		M:see_invisible--

	if(quaziamt >= 4.5 && (M:calm < 20 && prob(quaziamt * 5)))
		M:calm++

	if(prob(20))
		M:delirium = 0
	else if(M:delirium > 0)
		M:delirium--
	M:remove_chem("psilocybin", 2)
	M:remove_chem("mescaline", 0.5)
	M:remove_chem("LSD", 0.1)
	M:remove_chem("LSA", 0.1)
	M:remove_chem("DOB", 0.1)
	M:remove_chem("DOI", 0.1)
	M:remove_chem("DOC", 0.1)
	M:remove_chem("DOM", 0.1)
	M:remove_chem("2C-B", 0.1)
	M:remove_chem("2C-P", 0.1)
	M:remove_chem("2C-I", 0.1)
	M:remove_chem("2C-H", 0.1)
	M:remove_chem("Bromo-DragonFLY", 0.05)
	M:remove_chem("2C-B-FLY", 0.1)
	M:remove_chem("25i-NBOMe", 0.2)
	M:remove_chem("25b-NBOMe", 0.2)
	M:remove_chem("amphetamine", 3)
	M:remove_chem("dextroamphetamine", 3)
	M:remove_chem("methamphetamine", 3)
	M:remove_chem("dextromethamphetamine", 3)
	M:remove_chem("mephedrone", 1.5)
	M:remove_chem("cocaine", 2.5)
	M:remove_chem("BZP", 1.5)
	M:remove_chem("piperazine", 1.5)
	M:remove_chem("4-FA", 1.5)
	M:remove_chem("DXM", 2)
	M:remove_chem("MXE", 0.6)
	M:remove_chem("MXP", 0.6)
	M:remove_chem("ketamine", 0.6)
	M:remove_chem("adrenochrome", 0.6)
	M:remove_chem("PCP", 0.6)
	M:remove_chem("PCE", 0.6)
	M:remove_chem("3-MeO-PCP", 0.4)
	M:remove_chem("3-MeO-PCE", 0.4)
	M:remove_chem("DMT", 0.6)
	M:remove_chem("5-MeO-DMT", 0.6)
	M:remove_chem("5-MeO-DiPT", 0.4)
	M:remove_chem("4-HO-MET", 0.4)
	M:remove_chem("5-Bromo-DMT", 0.4)
	M:remove_chem("DiPT", 0.6)
	M:remove_chem("salvinorin A", 0.2)
	M:remove_chem("dicyclomine", 1)
	M:remove_chem("DPH", 0.5)
	M:remove_chem("tropicamide", 0.5)
	M:remove_chem("atropine", 1)
	M:remove_chem("Nuclear titbit", 1)
	M:remove_chem("MDA", 1)
	M:remove_chem("MDMA", 1)
	M:remove_chem("MDOH", 1)
	M:remove_chem("JWH-018", 1)
	M:remove_chem("white widow", 1)
	M:remove_chem("JWH-250", 1)
	M:remove_chem("AB-228", 1)
	M:remove_chem("APICA", 1)
	M:remove_chem("APINACA", 1)
	M:remove_chem("THC", 0.5)
	if(prob(50) && quaziamt >= 6)
		if(prob(33))
			M:mindbreak(-1, 1)
		if(prob(33))
			M:mindbreak(-1, 2)
		if(prob(33))
			M:mindbreak(-1, 3)
		if(prob(33))
			M:mindbreak(-1, 4)
		if(prob(33))
			M:mindbreak(-1, 5)
	spawn(0)
		M:remove_chem("clozapine", 0.5)

/datum/on_mob/risperidone
	rid = "risperidone"
/datum/on_mob/risperidone
/datum/on_mob/risperidone/react(quaziamt, R, mob/M)
	if(M:psychosis > 0)
		M:psychosis--

	if(M:delirium > 0)
		M:delirium--

	if(M:psi > 0)
		M:psi--

	if(M:calm < 20)
		M:calm++

	if(M:euphoria > 0)
		if(prob(35) && M:euphoria >= 3)
			M:euphoria -= round(M:euphoria / 3)
		else
			M:euphoria--

	if(prob(20))
		M << "\red You feel tired."
		M:calm += 2
		M:drowsy_change(1)
		M:euphoria--

	if(prob(50))
		if(M:chronoclock >= 2)
			M:chronoclock -= round(M:chronoclock / 2)
		else
			M:chronoclock--
	else

		M:chronoclock += 5
		M:euphoria--
		M:calm++
		M << "\red You feel somewhat sad."

	if(prob(50) && M:depression)
		M:depression--

	if(prob(quaziamt * 3))
		M:calm++
	if(M:psychosis)
		M:psychosis--
		if(M:psychosis > 0 && prob(10 + M:psychosis / 2))
			M:psychosis = 0

	if(M:see_invisible > 0)
		M:see_invisible--

	if(quaziamt >= 4.5 && (M:calm < 20 && prob(quaziamt * 5)))
		M:calm++

	if(prob(20))
		M:delirium = 0
	else if(M:delirium)
		M:delirium--
	M:remove_chem("psilocybin", 2)
	M:remove_chem("mescaline", 0.5)
	M:remove_chem("LSD", 0.1)
	M:remove_chem("LSA", 0.1)
	M:remove_chem("DOB", 0.1)
	M:remove_chem("DOI", 0.1)
	M:remove_chem("DOC", 0.1)
	M:remove_chem("DOM", 0.1)
	M:remove_chem("2C-B", 0.1)
	M:remove_chem("2C-P", 0.1)
	M:remove_chem("2C-I", 0.1)
	M:remove_chem("2C-H", 0.1)
	M:remove_chem("Bromo-DragonFLY", 0.05)
	M:remove_chem("2C-B-FLY", 0.1)
	M:remove_chem("25i-NBOMe", 0.2)
	M:remove_chem("25b-NBOMe", 0.2)
	M:remove_chem("amphetamine", 3)
	M:remove_chem("dextroamphetamine", 3)
	M:remove_chem("methamphetamine", 3)
	M:remove_chem("dextromethamphetamine", 3)
	M:remove_chem("mephedrone", 1.5)
	M:remove_chem("cocaine", 2.5)
	M:remove_chem("BZP", 1.5)
	M:remove_chem("piperazine", 1.5)
	M:remove_chem("4-FA", 1.5)
	M:remove_chem("DXM", 2)
	M:remove_chem("MXE", 0.6)
	M:remove_chem("MXP", 0.6)
	M:remove_chem("ketamine", 0.6)
	M:remove_chem("adrenochrome", 0.6)
	M:remove_chem("PCP", 0.6)
	M:remove_chem("PCE", 0.6)
	M:remove_chem("3-MeO-PCP", 0.4)
	M:remove_chem("3-MeO-PCE", 0.4)
	M:remove_chem("DMT", 0.6)
	M:remove_chem("5-MeO-DMT", 0.6)
	M:remove_chem("5-MeO-DiPT", 0.4)
	M:remove_chem("4-HO-MET", 0.4)
	M:remove_chem("5-Bromo-DMT", 0.4)
	M:remove_chem("DiPT", 0.6)
	M:remove_chem("salvinorin A", 0.2)
	M:remove_chem("dicyclomine", 1)
	M:remove_chem("DPH", 0.5)
	M:remove_chem("tropicamide", 0.5)
	M:remove_chem("atropine", 1)
	M:remove_chem("Nuclear titbit", 1)
	M:remove_chem("MDA", 1)
	M:remove_chem("MDMA", 1)
	M:remove_chem("MDOH", 1)
	M:remove_chem("JWH-018", 1)
	M:remove_chem("white widow", 1)
	M:remove_chem("JWH-250", 1)
	M:remove_chem("AB-228", 1)
	M:remove_chem("APICA", 1)
	M:remove_chem("APINACA", 1)
	M:remove_chem("THC", 0.5)
	if(prob(50) && quaziamt >= 7)
		if(prob(33))
			M:mindbreak(-1, 1)
		if(prob(33))
			M:mindbreak(-1, 2)
		if(prob(33))
			M:mindbreak(-1, 3)
		if(prob(33))
			M:mindbreak(-1, 4)
		if(prob(33))
			M:mindbreak(-1, 5)
	spawn(0)
		M:remove_chem("risperidone", 0.5)

/datum/on_mob/paliperidone
	rid = "paliperidone"
/datum/on_mob/paliperidone
/datum/on_mob/paliperidone/react(quaziamt, R, mob/M)
	if(M:psychosis > 0)
		M:psychosis--

	if(M:delirium > 0)
		M:delirium--

	if(M:psi && prob(33))
		M:psi--

	if(M:calm < 20)
		M:calm++

	if(M:psi > 0)
		M:psi--

	if(M:see_invisible > 0)
		M:see_invisible--

	if(M:euphoria > 0 && prob(75))
		if(prob(20) && M:euphoria >= 3)
			M:euphoria -= round(M:euphoria / 3)
		else
			M:euphoria--

	if(prob(15))
		M << "\red You feel tired."
		M:calm += 2
		M:drowsy_change(1)
		M:euphoria -= 2

	if(prob(70))
		if(M:chronoclock >= 2)
			M:chronoclock -= round(M:chronoclock / 2)
		else
			M:chronoclock--
	else

		M:chronoclock += 5
		M:euphoria--
		M:calm++
		M << "\red You feel somewhat sad."

	if(prob(75) && M:depression)
		M:depression--

	if(prob(quaziamt * 3))
		M:calm++
	if(M:psychosis)
		M:psychosis--
		if(M:psychosis > 0 && prob(10 + M:psychosis / 2))
			M:psychosis = 0

	if(quaziamt >= 4.5 && (M:calm < 20 && prob(quaziamt * 5)))
		M:calm++

	if(prob(20))
		M:delirium = 0
	else if(M:delirium > 0)
		M:delirium--
	M:remove_chem("psilocybin", 2)
	M:remove_chem("mescaline", 0.5)
	M:remove_chem("LSD", 0.1)
	M:remove_chem("LSA", 0.1)
	M:remove_chem("DOB", 0.1)
	M:remove_chem("DOI", 0.1)
	M:remove_chem("DOC", 0.1)
	M:remove_chem("DOM", 0.1)
	M:remove_chem("2C-B", 0.1)
	M:remove_chem("2C-P", 0.1)
	M:remove_chem("2C-I", 0.1)
	M:remove_chem("2C-H", 0.1)
	M:remove_chem("Bromo-DragonFLY", 0.05)
	M:remove_chem("2C-B-FLY", 0.1)
	M:remove_chem("25i-NBOMe", 0.2)
	M:remove_chem("25b-NBOMe", 0.2)
	M:remove_chem("amphetamine", 3)
	M:remove_chem("dextroamphetamine", 3)
	M:remove_chem("methamphetamine", 3)
	M:remove_chem("dextromethamphetamine", 3)
	M:remove_chem("mephedrone", 1.5)
	M:remove_chem("cocaine", 2.5)
	M:remove_chem("BZP", 1.5)
	M:remove_chem("piperazine", 1.5)
	M:remove_chem("4-FA", 1.5)
	M:remove_chem("DXM", 2)
	M:remove_chem("MXE", 0.6)
	M:remove_chem("MXP", 0.6)
	M:remove_chem("ketamine", 0.6)
	M:remove_chem("adrenochrome", 0.6)
	M:remove_chem("PCP", 0.6)
	M:remove_chem("PCE", 0.6)
	M:remove_chem("3-MeO-PCP", 0.4)
	M:remove_chem("3-MeO-PCE", 0.4)
	M:remove_chem("DMT", 0.6)
	M:remove_chem("5-MeO-DMT", 0.6)
	M:remove_chem("5-MeO-DiPT", 0.4)
	M:remove_chem("4-HO-MET", 0.4)
	M:remove_chem("5-Bromo-DMT", 0.4)
	M:remove_chem("DiPT", 0.6)
	M:remove_chem("salvinorin A", 0.2)
	M:remove_chem("dicyclomine", 1)
	M:remove_chem("DPH", 0.5)
	M:remove_chem("tropicamide", 0.5)
	M:remove_chem("atropine", 1)
	M:remove_chem("Nuclear titbit", 1)
	M:remove_chem("MDA", 1)
	M:remove_chem("MDMA", 1)
	M:remove_chem("MDOH", 1)
	M:remove_chem("JWH-018", 1)
	M:remove_chem("white widow", 1)
	M:remove_chem("JWH-250", 1)
	M:remove_chem("AB-228", 1)
	M:remove_chem("APICA", 1)
	M:remove_chem("APINACA", 1)
	M:remove_chem("THC", 0.5)
	if(prob(50) && quaziamt >= 7)
		if(prob(33))
			M:mindbreak(-1, 1)
		if(prob(33))
			M:mindbreak(-1, 2)
		if(prob(33))
			M:mindbreak(-1, 3)
		if(prob(33))
			M:mindbreak(-1, 4)
		if(prob(33))
			M:mindbreak(-1, 5)
	spawn(0)
		M:remove_chem("paliperidone", 0.4)


/datum/on_mob/carbamazepine
	rid = "carbamazepine"

/datum/on_mob/carbamazepine

/datum/on_mob/carbamazepine/react(quaziamt, R, mob/M)

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "ethanol" && RE.amount > 1)
			if(prob(20))
				if(M:nausea < 5)
					M:nausea = 5
				else
					M:nausea += 2
			if(prob(66))
				M << "\red You feel just plain disgusting."
				M:euphoria -= 3
				M:says_xynta += 5
				M:nausea += 4
			M:damaga(1, "organ")

	if(M:psychosis > 0)
		M:psychosis--

	if(M:delirium > 0)
		M:delirium--

	if(M:epilepsy > 0)
		M:epilepsy--

	if(M:psi && prob(33))
		M:psi--

	if(M:calm < 20)
		M:calm++

	if(quaziamt >= 9 && prob(66))
		step(src, pick(1, 2, 8, 4))
		M:drowsy_change(2)
		if(prob(66) || M:euphoria > 0)
			M:euphoria -= 2
	else





		if(M:chronodepr && prob(10))
			M:chronodepr--

	if(M:thrill)
		M:thrill = 0
	if(prob(66) && M:tension)
		M:tension--
	if(prob(75) && M:depression)
		M:depression--

	if(prob(5))
		M:pain = 0
	else if(M:pain >= 2)
		M:pain -= 2
	else if(M:pain)
		M:pain--

	if(prob(quaziamt * 3))
		M:calm++

	if(quaziamt >= 9 && prob(66))
		step(src, pick(1, 2, 8, 4))
		M:drowsy_change(2)

	spawn(0)
		M:remove_chem("carbamazepine", 0.25)


/datum/on_mob/gabapentin
	rid = "gabapentin"

/datum/on_mob/gabapentin

/datum/on_mob/gabapentin/react(quaziamt, R, mob/M)
	if(M:benzo && prob(40))
		M:benzo--

	if(M:barbi && prob(33))
		M:barbi--

	if(M:hmur && prob(20))
		M:hmur--

	if(M:ghb)
		M:ghb--

	if(M:alcho)
		M:alcho--


	M:euphoria += pick(1, 1, 1, 1, 2, 3)

	if(prob(quaziamt * 3) && quaziamt > 5)
		M:calm++

	if(M:calm < 20)
		M:calm++

	if(M:euphoria < 0 && prob(75))
		M:euphoria++

	if(M:chronodepr && prob(10))
		M:chronodepr--

	if(M:thrill)
		M:thrill = 0
	if(prob(66) && M:tension)
		M:tension--
	if(prob(66) && M:depression)
		M:depression--

	if(prob(5))
		M:pain = 0
	else if(M:pain >= 2)
		M:pain -= 2
	else if(M:pain)
		M:pain--

	if(M:epilepsy > 0)
		M:epilepsy--

	if(quaziamt >= 20 && prob(66))
		M:calm += rand(2, 4)
		M:euphoria += rand(1, 3)
		if(prob(50))
			M:drowsy_change(1)
	else if(quaziamt > 40)
		M:calm += 4
		M:euphoria += 2
		M << "\blue You feel sleepy."
		M:drowsy_change(5)


	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "oxycodone")
			M:euphoria += 3
		if(RE.id == "heroin")
			M:euphoria += 3
		if(RE.id == "methadone")
			M:euphoria += 3
		if(RE.id == "fentanyl")
			M:euphoria += 3
		if(RE.id == "acetylfentanyl")
			M:euphoria += 3
		if(RE.id == "morphine")
			M:euphoria += pick(1, 2)
		if(RE.id == "tramadol")
			M:euphoria += pick(1, 2)
		if(RE.id == "codeine")
			M:euphoria += pick(1, 2)
		if(RE.id == "buprenorphine")
			M:euphoria += 2
		if(RE.id == "hydrocodone")
			M:euphoria += 2

		if(RE.id == "benzodiazepine")
			M:euphoria++
		if(RE.id == "phenazepam")
			M:euphoria += pick(1, 1, 2)
		if(RE.id == "diazepam")
			M:euphoria += pick(1, 1, 2)
		if(RE.id == "midazolam")
			M:euphoria += 2
		if(RE.id == "clonazepam")
			M:euphoria += pick(1, 2)
		if(RE.id == "nitrazepam")
			M:euphoria += pick(1, 2)
		if(RE.id == "cosmozepam")
			M:euphoria += pick(1, 2)
		if(RE.id == "cognitozepam")
			M:euphoria += pick(1, 2)
		if(RE.id == "alprazolam")
			M:euphoria += rand(1, 3)
		if(RE.id == "triazolam")
			M:euphoria++


		if(RE.id == "ethanol")
			M:euphoria += pick(1, 1, 2)
		if(RE.id == "GABA")
			M:euphoria += pick(1, 1, 2)
		if(RE.id == "baclofen")
			M:euphoria += pick(1, 1, 2)
		if(RE.id == "phenibut")
			M:euphoria += pick(1, 2)
		if(RE.id == "GHB")
			M:euphoria += pick(1, 2)
		if(RE.id == "phenotropil")
			M:euphoria += pick(1, 1, 2)

		if(RE.id == "clozapine" && prob(33))
			M:calm++
		if(RE.id == "carbamazepine" && prob(33))
			M:euphoria++
			M:calm++

	spawn(0)
		M:remove_chem("gabapentin", 0.5)
/datum/on_mob/fluorine
	rid = "fluorine"
/datum/on_mob/fluorine
/datum/on_mob/fluorine/react(quaziamt, R, mob/M)
	if(prob(50) && quaziamt >= 1)
		M:damaga(2, "organ")
		if(prob(10))
			M:sick()
	M:remove_chem("fluorine", 0.05)
/datum/on_mob/fagenerite
	rid = "fagenerite"
/datum/on_mob/fagenerite
/datum/on_mob/fagenerite/react(quaziamt, R, mob/M)
	if(!M:maggot)
		M << "\blue \bold You feel more attracted to the people of the same gender."
		M:maggot = 1
	else if(R:amount >= 1)
		M:heal(pick(0, 1), "brute")
		M:heal(pick(0, 1), "organ")
		if(prob(20))
			M:heal(1, "burn")
	spawn(0) M:remove_chem("fagenerite", 1)
/datum/on_mob/luckstone
	rid = "luckstone dust"
/datum/on_mob/luckstone
/datum/on_mob/luckstone/react(quaziamt, R, mob/M)
	if(prob(25) && M:luck < 100)
		M << "\green You feel a bit more lucky."
		M:luck++
	spawn(0) M:remove_chem("luckstone dust", 1)
/datum/on_mob/inytropidril
	rid = "inytropidril"
/datum/on_mob/inytropidril
/datum/on_mob/inytropidril/react(quaziamt, R, mob/M)
	if(prob(20))
		for(var/A in random_chem)
			switch(A)
				if("purge")
					M << "\green You feel clear."
					M:remove_chem("toxin", quaziamt / 2)
					M:remove_chem("fuel", quaziamt / 2)
					M:remove_chem("stalkotoxin", quaziamt / 2)
					M:remove_chem("chlorine", quaziamt / 2)
					M:remove_chem("fluorine", quaziamt / 2)
					M:remove_chem("liquid smoke", quaziamt / 2)
					M:remove_chem("pogankeepeptide", quaziamt / 2)
					M:remove_chem("methanol", quaziamt / 2)
					M:remove_chem("ammonia", quaziamt / 2)
					M:remove_chem("ammonium hydroxide", quaziamt / 2)
					M:remove_chem("aqua regia", quaziamt / 2)
					M:remove_chem("polytrinic acid", quaziamt / 2)
					M:remove_chem("sulfuric acid", quaziamt / 2)
					M:remove_chem("hydrochloric acid", quaziamt / 2)
					M:remove_chem("nitric acid", quaziamt / 2)
					M:remove_chem("Nuclear titbit", quaziamt / 2)
					M:remove_chem("corpse rot", quaziamt / 2)
					M:remove_chem("biotoxin", quaziamt / 2)
					M:remove_chem("starsalve", quaziamt / 2)
					M:remove_chem("atropine", quaziamt / 2)
					M:remove_chem("botox", quaziamt / 2)
					M:heal(2, "organ")

					if(M:delirium)
						M:delirium--
					if(M:deli > 0 && prob(50))
						M:deli--
					if(M:dofa > 0 && prob(50))
						M:dofa--
					if(M:sero > 0 && prob(50))
						M:sero--
					if(M:adreno > 0 && prob(50))
						M:adreno--
					if(M:nmda > 0 && prob(50))
						M:nmda--
				if("damage")
					M:damaga(3, "organ")
					M:sick()
				if("kill")
					if(M:hepe <= 30)
						M:damaga(30, "organ")
					else
						M:damaga(15, "organ")
						M << "\red \bold OH FUCK IT HURTS"
				if("heal")
					M:heal(2, "organ")
					M:heal(2, "burn")
					M:heal(2, "brute")
					if(prob(50))
						M:woundcure(1)
				if("strong heal")
					M:heal(5, "organ")
					M:heal(5, "burn")
					M:heal(5, "brute")
					M:woundcure(1)
				if("stun")
					M:stun(3)
				if("heavy stun")
					M:stun(7)
				if("infection")
					if(prob(15))
						M << "\red You feel somewhat uncomfortable..."
						M:aids = 1
				if("itch")
					M << "\red Your nose itches."
				if("spark")
					M << "\red You feel a weak current coming through your body."
					new /obj/effect/sparks(M:loc)
				if("rad")
					M << "\red \bold Your surroundings glow for a moment."
					for(var/mob/V in view(M))
						V << "\red [M:name] glows for a moment."
						if(prob(15) && V.energyprotect < 6)
							V.damaga(1, "burn")
							if(prob(5))
								V.randommut()
				if("heavy rad")
					M << "\red \bold Your surroundings glows brightly for a moment!"
					for(var/mob/V in view(M))
						V << "\red \bold [M:name] glows brightly for a moment!"
						if(prob(15) && V.energyprotect < 15)
							if(V.energyprotect < 6)
								V.damaga(5, "burn")
							else
								V.damaga(3, "burn")
							if(prob(10))
								V.randommut()
				if("chaos")
					M << "\red \bold You feel like if something comes into your bloodstream..."
					var/chemo = pick("chlorine", "regenerite", "inytropidril", "fuel", "fibgenerite", "toxin", "antidote", "fluorine", "haloperidol", "sugar", "MDA", "MDMA", "MDOH", "MDPV", "LSD", "ambrosine")
					M:add_chem(chemo, chemo, pick(1, 2), 0)
				if("tele")
					M << "\blue whooom"
					M:blink(2, M:loc)
				if("heavy tele")
					M << "\blue \bold PFEWWWWWW"
					M:blink(8, M:loc)
				if("feed")
					M << "\blue You feel full."
					M:add_chem("nutriment", "nutriment", rand(1, 3), 0)
				if("scream")
					M:say(pick("бля", "химик дай ДОБа", "капитан предатель", "хуй", "пизда", "колбаса", "спасите убивают", "капитан гондон", "Я сосу хуи", "ХОНК", "херп дерп", "Я ебал твою мать", "трейтор с бомбой у медблока", "СОЮЗ НЕРУШИМЫЙ РЕСПУБЛИК СВОБОДНЫХ", "\green идиот, убейте меня кто-нибудь", "ya twoy mamku ebal suka", "huli ty tvorish pidor ebaniy"))
				if("dust")
					if(prob(10))
						M << "\red You vomit out some glowing dust!"
						new /obj/item/reagent_container/consumable/dust(M:loc)
						M:damaga(1, "ogran")
	spawn(0)
		M:remove_chem("inytropidril", 0.1)

/datum/on_mob/nitrogen_tourettinide
	rid = "nitrogen tourettinide"
/datum/on_mob/nitrogen_tourettinide
/datum/on_mob/nitrogen_tourettinide/react(quaziamt, R, mob/M)
	if(prob(50) && quaziamt >= 0.1)
		M:say(pick("MAMU EBAL", "FUCK", "SHIT", "HUI", "PIZDA", "SUKA", "PAUK EBANIY", "SASAI", "YOBA", "GAY[reverse_text("REGGIN")]", "бля", "химик дай ДОБа", "капитан предатель", "хуй", "пизда", "колбаса", "спасите убивают", "капитан гондон", "Я сосу хуи", "ХОНК", "херп дерп", "Я ебал твою мать", "трейтор с бомбой у медблока", "СОЮЗ НЕРУШИМЫЙ РЕСПУБЛИК СВОБОДНЫХ", "\green идиот, убейте меня кто-нибудь", "ya twoy mamku ebal suka", "huli ty tvorish pidor ebaniy"))
		if(quaziamt >= 8 && prob(25))
			M:says_xynta += 10
			M:damaga(1, "organ")
			M:sick()

	M:remove_chem("nitrogen tourettinide", 0.05)

/datum/on_mob/peacenipizine
	rid = "peacenipizine"
/datum/on_mob/peacenipizine
/datum/on_mob/peacenipizine/react(quaziamt, R, mob/M)
	if(prob(20))
		M:fap()

	if(M:semen == 0)
		M:semen = 25

	if(M:libido < 50)
		M:libido = 50

	if(M:hunger)
		M:hunger--

	if(quaziamt >= 0.05)

		M:fap()

		if(M:hepe <= 15)
			M:heal(3, "burn")
			M:heal(3, "brute")
			M:heal(3, "organ")
			if(M:hunger >= 3)
				M:hunger -= 3
			else
				M:hunger = 0
		else
			if(M:hepe < 50 && prob(40))
				M:heal(4, "burn")
				M:heal(5, "brute")
				M:heal(5, "organ")
				if(M:hunger)
					M:hunger--
				else
					M:hunger = 0

		if(M:wounds && prob(33))
			M:woundcure(1)
			if(M:hunger >= 2)
				M:hunger -= 2
			else
				M:hunger = 0

	M:remove_chem("peacenipizine", 0.05)

/datum/on_mob/flumazenil
	rid = "flumazenil"

/datum/on_mob/flumazenil

/datum/on_mob/flumazenil/react(quaziamt, R, mob/M)


	if(M:benzo_block < 2)
		M:benzo_block = 2

		if(M:benzo > 85 && prob(M:benzo / 2))
			M:benzo--
	spawn(0)
		M:remove_chem("flumazenil", 0.5)


/datum/on_mob/naloxone
	rid = "naloxone"

/datum/on_mob/naloxone

/datum/on_mob/naloxone/react(quaziamt, R, mob/M)

	if(M:opi_block < 2)
		M:opi_block = 2

	if(quaziamt >= 1)

		if(M:drunk > 3)
			M:drunk--

		M:remove_chem("DXM", 1)
		M:remove_chem("thebaine", 1)

		for(var/datum/reagent/RE in M:blood_chem)

			if(RE.id == "ethanol" && RE.amount > 10)
				M:remove_chem("ethanol", 5)
			else
				if(RE.id == "ethanol" || RE.id == "methanol")
					M:remove_chem("ethanol", 0.5)
					M:remove_chem("methanol", 0.5)
				else
					if(RE.id == "DXM" && RE.amount >= 3.5)
						M:remove_chem("DXM", 1)






























		if(M:hmur > 85 && prob(M:hmur / 2))
			M:stun(1)
			if(prob(25))
				M:torment(2)
				M:hmur--

	spawn(0)
		M:remove_chem("naloxone", 0.5)
/datum/on_mob/opium
	rid = "opium"
/datum/on_mob/opium
/datum/on_mob/opium/react(quaziamt, R, mob/M)
	if(quaziamt >= 0.1)
		M:add_chem("codeine", "codeine", 0.1, 0)
		if(prob(10))
			M:add_chem("morphine", "morphine", 0.1, 0)
	else
		M:add_chem("codeine", "codeine", quaziamt, 0)
	M:remove_chem("opium", 0.1)

/datum/on_mob/codeine
	rid = "codeine"
/datum/on_mob/codeine
/datum/on_mob/codeine/react(quaziamt, R, mob/M)
	if(!("purple drank" in csecond))
		csecond += "purple drank"

	if(!M:opi_block)


		if(prob(5))
			M << "\red Your organism is fighting against infection!"
			if(prob(10))
				M << "\green You feel somewhat better."
				M:flu = 0
				M:immune = 1

		if(prob(70 - M:succinic * 33))
			M:hmur++

		if(M:painless < 9)
			M:painless += 2

		if(M:pain)
			M:pain--

		if(M:euphoria < 30)
			M:euphoria += 2

		if(M:coughy)
			M:coughy = 0

		if(M:tension)
			M:tension--

		if(M:calm < 20 && prob(75))
			M:calm++

		M:euphoria += rand(1, 3)

		if(quaziamt > 0.7)
			M:damaga(rand(3, 7), "organ")
			M:sick()
			if(prob(15 + quaziamt * 10))
				M:stun(2)
				M:nausea += 2

			M:euphoria -= rand(1, 4)
			M:calm--

		M:hm_tick = 4

	M:remove_chem("codeine", 0.01)

/datum/on_mob/tramadol
	rid = "tramadol"
/datum/on_mob/tramadol
/datum/on_mob/tramadol/react(quaziamt, R, mob/M)
	if(!M:opi_block)

		if(prob(70 - M:succinic * 33))
			M:hmur++

		if(M:painless < 10)
			M:painless += 2

		if(M:pain)
			M:pain--

		if(M:euphoria < 40)
			M:euphoria += 2

		if(M:coughy)
			M:coughy = 0

		if(M:tension)
			M:tension--

		if(M:calm < 20)
			M:calm++

		M:euphoria += rand(1, 4)

		if(quaziamt > 0.7)
			M:damaga(rand(2, 6), "organ")
			M:sick()
			if(prob(15 + quaziamt * 10))
				M:stun(1)
				M:nausea += 2

			M:euphoria -= rand(1, 4)
			M:calm--

		M:hm_tick = 4
	M:remove_chem("tramadol", 0.01)

/datum/on_mob/morphine
	rid = "morphine"
/datum/on_mob/morphine
/datum/on_mob/morphine/react(quaziamt, R, mob/M)
	if(!M:opi_block)

		M:euphoria += pick(1, 2)

		if(prob(70 - M:succinic * 10))
			M:hmur++

		if(M:painless < 10)
			M:painless += 2

		if(M:pain)
			M:pain--

		if(M:euphoria < 45)
			M:euphoria += pick(1, 2)

		if(M:coughy)
			M:coughy = 0

		if(M:tension)
			M:tension--

		if(M:calm < 20)
			M:calm++

		if(M:calm < 20 && prob(66))
			M:calm += pick(1, 2)

		if(prob(20))
			M:calm++
			M:euphoria += rand(2, 7)
			for(var/mob/V in view(M))
				V << "\red \bold [M:name] closes \his eyes and smiles"

		if(quaziamt > 0.6)
			M:damaga(5, "organ")
			M:sick()
			if(prob(20 + quaziamt * 10 - M:succinic * 5))
				M:stun(2)
			if(prob(80))
				M:nausea += rand(2, 5)

			M:euphoria -= rand(1, 4)
			M:calm--

		M:hm_tick = 4
	M:remove_chem("morphine", 0.01)

/datum/on_mob/heroin
	rid = "heroin"
/datum/on_mob/heroin
/datum/on_mob/heroin/react(quaziamt, R, mob/M)
	if(!M:opi_block)

		M:hmur++
		M:euphoria += pick(1, 2)

		if(prob(75 - M:succinic * 25))
			M:hmur++

		if(M:painless < 10)
			M:painless += 2

		if(M:pain > 5)
			M:pain = 5
		else if(M:pain)
			M:pain--

		if(M:euphoria < 60)
			M:euphoria += pick(1, 2)

		if(M:coughy)
			M:coughy = 0

		if(M:tension)
			M:tension--

		if(prob(25))
			M:calm++
			M:euphoria += rand(5, 12)
			for(var/mob/V in view(M))
				V << "\red \bold [M:name] closes \his eyes and smiles"
		if(quaziamt > 0.4)
			M:damaga(5, "organ")
			M:sick()
			if(prob(20 + quaziamt * 20 - M:succinic * 5))
				M:stun(2)
			if(prob(80))
				M:nausea += rand(3, 5)

			M:euphoria -= 5
			M:calm -= rand(1, 3)

		M:hm_tick = 4
	M:remove_chem("heroin", 0.01)

/datum/on_mob/methadone
	rid = "methadone"
/datum/on_mob/methadone
/datum/on_mob/methadone/react(quaziamt, R, mob/M)
	if(!M:opi_block)

		M:hmur++
		M:euphoria += rand(1, 3)

		if(prob(50 - M:succinic * 25))
			M:hmur++

		if(M:painless < 10)
			M:painless += 2

		if(M:pain > 5)
			M:pain = 5
		else if(M:pain)
			M:pain--

		if(M:euphoria < 60)
			M:euphoria += rand(3, 5)

		if(M:coughy)
			M:coughy = 0

		if(M:tension)
			M:tension--

		if(M:calm < 20)
			M:calm += pick(1, 2)
		else if(M:calm > 20 && prob(25))
			M:calm--

		if(prob(25))
			M:euphoria += rand(7, 15)
			M:calm++
			for(var/mob/V in view(M))
				V << "\red \bold [M:name] closes \his eyes and smiles"

		if(quaziamt > 0.4)
			M:damaga(5, "organ")
			M:sick()
			if(prob(20 + quaziamt * 20 - M:succinic * 5))
				M:stun(2)
			if(prob(80))
				M:nausea += rand(3, 5)

			M:euphoria -= 5
			M:calm -= rand(1, 3)

		M:hm_tick = 4
	M:remove_chem("methadone", 0.005)


/datum/on_mob/desomorphine
	rid = "desomorphine"
/datum/on_mob/desomorphine
/datum/on_mob/desomorphine/react(quaziamt, R, mob/M)
	if(!("krokodil" in csecond))
		csecond += "krokodil"

	if(!M:opi_block)

		M:hmur++
		M:euphoria += pick(1, 2)

		if(prob(50 - M:succinic * 25))
			M:hmur++

		if(M:painless < 10)
			M:painless += 2

		if(M:pain > 5)
			M:pain = 5
		else
			M:pain--

		if(M:euphoria < 60)
			M:euphoria += pick(1, 2)

		if(M:coughy)
			M:coughy = 0

		if(M:tension)
			M:tension--

		if(M:calm < 20)
			M:calm++

		if(prob(quaziamt * 30))
			M:damaga(1, "organ")

		if(M:calm < 15)
			M:calm += pick(1, 2)

		if(prob(25))
			M:calm++
			if(prob(66))
				M:euphoria += rand(2, 6)
			for(var/mob/V in view(M))
				V << "\red \bold [M:name] closes \his eyes and smiles"

		if(quaziamt > 0.5)
			M:damaga(5, "organ")
			M:sick()
			if(prob(20 + quaziamt * 15 - M:succinic * 5))
				M:stun(2)
			if(prob(80))
				M:nausea += rand(3, 5)

			M:euphoria -= 5
			M:calm -= rand(1, 3)

		M:hm_tick = 4

	M:remove_chem("desomorphine", 0.01)

/datum/on_mob/hydrocodone
	rid = "hydrocodone"
/datum/on_mob/hydrocodone
/datum/on_mob/hydrocodone/react(quaziamt, R, mob/M)
	if(!M:opi_block)

		M:hmur++
		M:euphoria += pick(1, 2)

		if(prob(60 - M:succinic * 33))
			M:hmur++

		if(M:painless < 9)
			M:painless += 2

		if(M:pain)
			M:pain--

		if(M:euphoria < 40)
			M:euphoria += 2

		if(M:coughy)
			M:coughy = 0

		if(M:tension)
			M:tension--

		if(M:calm < 20)
			M:calm++

		if(prob(25))
			M:calm++
			M:euphoria += rand(2, 5)
			for(var/mob/V in view(M))
				V << "\red \bold [M:name] closes \his eyes and smiles"

		if(quaziamt > 0.3)
			M:damaga(rand(3, 7), "organ")
			M:sick()
			if(prob(15 + quaziamt * 10))
				M:stun(2)
			if(prob(80))
				M:nausea += rand(5, 8)

			M:euphoria -= 5
			M:calm -= rand(1, 3)

		M:hm_tick = 4

	M:remove_chem("hydrocodone", 0.007)

/datum/on_mob/oxycodone
	rid = "oxycodone"
/datum/on_mob/oxycodone
/datum/on_mob/oxycodone/react(quaziamt, R, mob/M)
	if(!M:opi_block)

		M:hmur++
		M:euphoria += pick(1, 2)

		if(prob(50 - M:succinic * 25))
			M:hmur++

		if(M:painless < 10)
			M:painless += 2

		if(M:pain > 5)
			M:pain = 5
		else
			M:pain--

		if(M:euphoria < 60)
			M:euphoria += pick(1, 2)


		if(M:coughy)
			M:coughy = 0

		if(M:tension)
			M:tension--

		if(M:calm < 20)
			M:calm += pick(1, 2)
		if(prob(25))
			M:calm++
			M:euphoria += pick(5, 8)
			for(var/mob/V in view(M))
				V << "\red \bold [M:name] closes \his eyes and smiles"
		if(quaziamt > 0.2)
			M:damaga(5, "organ")
			M:sick()
			if(prob(5 + quaziamt * 50 - M:succinic * 10))
				M:stun(2)
			if(prob(80))
				M:nausea += rand(3, 5)

			M:euphoria -= 5
			M:calm -= rand(1, 3)

		M:hm_tick = 4
	M:remove_chem("oxycodone", 0.0033)

/datum/on_mob/fentanyl
	rid = "fentanyl"
/datum/on_mob/fentanyl
/datum/on_mob/fentanyl/react(quaziamt, R, mob/M)
	if(!M:opi_block)

		M:hmur++
		M:euphoria += pick(1, 2)

		if(prob(50 - M:succinic * 25))
			M:hmur++

		if(M:painless < 10)
			M:painless += 2

		if(M:pain > 5)
			M:pain = 5
		else
			M:pain--

		if(M:euphoria < 60)
			M:euphoria += 2

		if(M:coughy)
			M:coughy = 0

		if(M:tension)
			M:tension--

		if(M:calm < 20)
			M:calm += pick(1, 2)
		if(prob(33))
			M:calm++
			M:euphoria += rand(1, 8)
			for(var/mob/V in view(M))
				V << "\red \bold [M:name] closes \his eyes and smiles"
		if(quaziamt > 0.02)
			M:damaga(7, "organ")
			M:sick()
			if(prob(20 + quaziamt * 100 - M:succinic * 10))
				M:stun(2)
			M:nausea += rand(3, 5)

			M:euphoria -= 6
			M:calm -= 2

		M:hm_tick = 4
	M:remove_chem("fentanyl", 0.001)

/datum/on_mob/acetylfentanyl
	rid = "acetylfentanyl"
/datum/on_mob/acetylfentanyl
/datum/on_mob/acetylfentanyl/react(quaziamt, R, mob/M)
	if(!M:opi_block)

		M:hmur++
		M:euphoria += pick(1, 2)

		if(prob(50 - M:succinic * 25))
			M:hmur++

		if(M:painless < 10)
			M:painless += 2

		if(M:pain > 5)
			M:pain = 5
		else
			M:pain--

		if(M:euphoria < 60)
			M:euphoria += 2

		if(M:coughy)
			M:coughy = 0

		if(M:tension)
			M:tension--

		if(M:calm < 20)
			M:calm += pick(1, 2)
		if(prob(33))
			M:calm++
			M:euphoria += rand(1, 8)
			for(var/mob/V in view(M))
				V << "\red \bold [M:name] closes \his eyes and smiles"
		if(quaziamt > 0.03)
			M:damaga(7, "organ")
			M:sick()
			if(prob(20 + quaziamt * 100 - M:succinic * 10))
				M:stun(2)
			M:nausea += rand(3, 5)

			M:euphoria -= 6
			M:calm -= 2

		M:hm_tick = 4
	M:remove_chem("acetylfentanyl", 0.0015)

/datum/on_mob/buprenorphine
	rid = "buprenorphine"
/datum/on_mob/buprenorphine
/datum/on_mob/buprenorphine/react(quaziamt, R, mob/M)
	if(M:opi_block < 5)
		M:opi_block = 5

	if(prob(50 - M:succinic * 33))
		M:hmur++

	if(M:painless < 10)
		M:painless += 2

	if(M:pain)
		M:pain--

	if(M:euphoria < 60)
		M:euphoria += 2

	if(M:coughy)
		M:coughy = 0

	if(M:tension)
		M:tension--

	if(M:calm < 20)
		M:calm++

	M:euphoria += rand(1, 5)

	if(quaziamt >= 0.25 && prob(10))
		if(M:nausea < 5)
			M:nausea = 5
		else
			M:nausea += 2

	if(quaziamt > 0.7)
		M:damaga(rand(3, 6), "organ")
		M:sick()
		if(prob(5 + quaziamt * 10))
			M:stun(2)
		M:nausea += rand(2, 5)

		M:euphoria -= 5
		M:calm -= rand(1, 3)

	M:hm_tick = 4
	M:remove_chem("buprenorphine", 0.009)

/datum/on_mob/dicyclomine
	rid = "dicyclomine"
/datum/on_mob/dicyclomine
/datum/on_mob/dicyclomine/react(quaziamt, R, mob/M)
	if(M:pain && prob(33))
		M:pain--

	if(quaziamt < 20 && (M:calm < 20 && prob(33)))
		M:calm++

		if(prob(5))
			M:pain = 0
		else if(M:pain >= 2)
			M:pain -= 2
		else if(M:pain)
			M:pain--
	else
		if(quaziamt >= 20)

			M:delirium++

			if(prob(20 - M:delirium))
				M:delirium++

			if(prob(quaziamt))

				M:delirium++
				M:damaga(1, "organ")

	M:remove_chem("dicyclomine", 0.5)

/datum/on_mob/DPH
	rid = "DPH"
/datum/on_mob/DPH
/datum/on_mob/DPH/react(quaziamt, R, mob/M)
	if(M:nauseablock < 30)
		M:nauseablock = 30

	if(M:nausea > 5)
		M:nausea -= 5
	if(M:nausea > 2)
		M:nausea -= 2
	else if(M:nausea)
		M:nausea--

	if(M:nausea && prob(7))
		M:nausea = 0

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "oxycodone")
			M:euphoria += rand(4, 6)

		if(RE.id == "hydrocodone")
			M:euphoria += rand(2, 6)

		if(RE.id == "fentanyl")
			M:euphoria += pick(2, 5)

		if(RE.id == "acetylfentanyl")
			M:euphoria += pick(2, 5)

		if(RE.id == "heroin")
			M:euphoria += rand(4, 6)

		if(RE.id == "methadone")
			M:euphoria += rand(4, 6)

		if(RE.id == "morphine")
			M:euphoria += pick(2, 5)

		if(RE.id == "tramadol")
			M:euphoria += rand(1, 5)

		if(RE.id == "codeine")
			M:euphoria += rand(1, 5)



	if(quaziamt < 10 && (M:calm < 20 && prob(75)))
		M:calm++
	else
		if(quaziamt >= 10)

			M:delirium++

			if(prob(20 - M:delirium))
				M:delirium++

			if(prob(quaziamt * 2))

				M:delirium++
				M:damaga(1, "organ")

	M:remove_chem("DPH", 0.25)

/datum/on_mob/tropicamide
	rid = "tropicamide"
/datum/on_mob/tropicamide
/datum/on_mob/tropicamide/react(quaziamt, R, mob/M)
	if(M:nauseablock < 30)
		M:nauseablock = 30

	if(M:nausea > 5)
		M:nausea -= 5
	if(M:nausea > 2)
		M:nausea -= 2
	else if(M:nausea)
		M:nausea--

	if(M:nausea && prob(10))
		M:nausea = 0

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "oxycodone")
			M:euphoria += rand(4, 6)

		if(RE.id == "hydrocodone")
			M:euphoria += rand(2, 6)

		if(RE.id == "fentanyl")
			M:euphoria += pick(2, 5)

		if(RE.id == "acetylfentanyl")
			M:euphoria += pick(2, 5)

		if(RE.id == "heroin")
			M:euphoria += rand(4, 6)

		if(RE.id == "methadone")
			M:euphoria += rand(4, 6)

		if(RE.id == "morphine")
			M:euphoria += pick(2, 5)

		if(RE.id == "tramadol")
			M:euphoria += rand(1, 5)

		if(RE.id == "codeine")
			M:euphoria += rand(1, 5)

		if(RE.id == "amphetamine")
			M:euphoria += rand(1, 4)
			if(M:calm > 20)
				M:calm--

		if(RE.id == "dextroamphetamine")
			M:euphoria += rand(1, 4)
			if(M:calm > 20)
				M:calm--

		if(RE.id == "methamphetamine")
			M:euphoria += rand(1, 4)
			if(M:calm > 20)
				M:calm--

		if(RE.id == "dextromethamphetamine")
			M:euphoria += rand(1, 5)
			if(M:calm > 20)
				M:calm--

		if(RE.id == "methcathinone")
			M:euphoria += rand(1, 6)
			if(M:calm > 20)
				M:calm--

		if(RE.id == "MDPV")
			M:euphoria += rand(1, 4)
			if(M:calm > 20)
				M:calm--

		if(RE.id == "ephedrine")
			M:euphoria += pick(1, 2)
			if(M:calm > 20)
				M:calm--

		if(RE.id == "pseudoephedrine")
			M:euphoria += pick(1, 2)
			if(M:calm > 20)
				M:calm--

		if(RE.id == "4-FA")
			M:euphoria += rand(1, 6)
			if(M:calm > 20)
				M:calm--

		if(RE.id == "mephedrone")
			M:euphoria += rand(1, 6)
			if(M:calm > 20)
				M:calm--

		if(RE.id == "cocaine")
			M:euphoria += rand(1, 6)
			if(M:calm > 20)
				M:calm--

	if(quaziamt < 7.5 && (M:calm < 20 && prob(66)))
		M:calm++
	else
		if(quaziamt >= 7.5)

			M:delirium++

			if(prob(20 - M:delirium))
				M:delirium++

			if(prob(quaziamt * 2))

				M:delirium++
				M:damaga(1, "organ")

	M:remove_chem("tropicamide", 0.25)

/datum/on_mob/titbeat
	rid = "Nuclear titbit"

/datum/on_mob/titbeat
/datum/on_mob/titbeat/react(quaziamt, R, mob/M)
	if(M:libido < 100)
		M:libido += pick(1, 2)

	if(M:euphoria < 40)
		M:euphoria += pick(1, 2)

	if(!M:glow)
		M:glowing(30)

	if(quaziamt >= 10)

		M:delirium++

		if(prob(20 - M:delirium))
			M:delirium++

		if(prob(M:delirium))
			M:euphoria += rand(1, 3)

		if(quaziamt >= 25 && prob(50))
			M:damaga(1, "organ")

	M:remove_chem("Nuclear titbit", 0.4)


/datum/on_mob/paracetamol
	rid = "paracetamol"
/datum/on_mob/paracetamol
/datum/on_mob/paracetamol/react(quaziamt, R, mob/M)
	if(quaziamt >= 1)

		if(M:coughy && prob(50))
			M:coughy = 0

		if(prob(5))
			M:pain = 0
		else if(M:pain >= 2)
			M:pain -= 2
		else if(M:pain)
			M:pain--

		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "ethanol" && (RE.amount > 1 && prob(1 + RE.amount + quaziamt)))
				if(prob(50))
					M:vomit_red()
					M:nausea += 3
				else
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
				M:damaga(pick(3, 5, 7), "organ")
				M << "\red You have an ugly feeling about your liver"

	if(quaziamt >= 10 && prob(80))
		M:damaga(rand(4, 6), "organ")
		M:euphoria -= rand(2, 4)
		if(prob(25))
			M:sick()

	if(quaziamt >= 15 && prob(25))
		M:damaga(5 + pick(1, 2) + round(quaziamt / 10), "organ")
		M:euphoria -= rand(4, 7)
		M:calm--
		if(prob(50))
			M:vomit_red()
			M:nausea += pick(1, 2)
		else if(prob(50))
			if(M:nausea < 5)
				M:nausea = 5
			else
				M:nausea += 3

	spawn(0)
		M:remove_chem("paracetamol", 0.5)

/datum/on_mob/ibuprofen
	rid = "ibuprofen"
/datum/on_mob/ibuprofen
/datum/on_mob/ibuprofen/react(quaziamt, R, mob/M)
	if(quaziamt >= 0.5)

		if(M:thrill && prob(50))
			M:thrill = 0

		if(M:tension && prob(70))
			M:tension--

		if(M:pain >= 2)
			M:pain -= 2
		else if(M:pain)
			M:pain--

	if(quaziamt >= 15 && prob(80))
		M:damaga(rand(1, 5), "organ")
		M:euphoria -= rand(2, 4)
		M:nausea += pick(1, 2)
		if(prob(20))
			M:sick()

	spawn(0)
		M:remove_chem("ibuprofen", 0.33)

/datum/on_mob/gaba
	rid = "GABA"

/datum/on_mob/gaba


/datum/on_mob/gaba/react(quaziamt, R, mob/M)
	if(M:benzo && prob(50))
		M:benzo--

	if(M:barbi && prob(50))
		M:barbi--

	if(M:hmur && prob(33))
		M:hmur--

	if(M:ghb)
		M:ghb--

	if(M:alcho && prob(75))
		M:alcho--


	if(M:tension && prob(33))
		M:tension--

	if(M:thrill && prob(50))
		M:thrill -= 2

	if(prob(quaziamt / 2 + (15 - M:calm)))
		M:calm++

	if(M:euphoria < 0)

		M:euphoria += rand(1, 3)

	if(prob(10) && M:euphoria < 10)

		M:euphoria++

	if(M:epilepsy > 0)
		if(prob(M:epilepsy) && quaziamt >= 4)
			M:seizure(2)


	if(quaziamt >= 30)

		M:says_xynta += 2

		M:damaga(1, "organ")

		if(prob(10))
			M:sick()

	spawn(0) M:remove_chem("GABA", 0.4)

/datum/on_mob/gbl
	rid = "GBL"

/datum/on_mob/gbl

/datum/on_mob/gbl/react(quaziamt, R, mob/M)


	if(M:benzo && prob(50))
		M:benzo--

	if(M:barbi && prob(50))
		M:barbi--

	if(M:hmur && prob(33))
		M:hmur--

	if(M:alcho && prob(75))
		M:alcho--


	if(prob(50))
		M:ghb++

	if(M:libido < 60)
		M:libido += rand(2, 4)

	if(M:tension > 0 && prob(40))
		M:tension--

	if(quaziamt < 22 && (M:thrill > 0 && prob(85)))
		M:thrill--

	if(M:depression > 0 && prob(10))
		M:depression--

	if(prob(quaziamt / 5 + (15 - M:calm)))
		M:calm++

	if(M:euphoria < 80)

		M:euphoria += pick(1, 2)

	if(M:epilepsy)
		if(prob(M:epilepsy / 4))
			M:seizure(4)

	if(prob(5))
		M:euphoria++

	if(quaziamt >= 11.5 && prob(10))
		M << "\red The world became blurry for a second."
		M:epilepsy += 2

	if(quaziamt >= 22)
		if(prob(5))
			M << "\red You definitely ate too much of this stuff."
			M:stun(2)
		if(prob(66))
			M:nausea += 2

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "ethanol" && RE.amount > 1)
			if(prob(20))
				if(M:nausea < 5)
					M:nausea = 5
				else
					M:nausea += 3
			if(prob(25))
				M:says_xynta += 5
			M:damaga(3, "organ")
		if(RE.id == "baclofen" && (RE.amount >= 2 && prob(33)))
			M:euphoria += pick(1, 2)
			M:damaga(2, "organ")

	if(quaziamt >= 27)

		M:says_xynta += 2

		M:damaga(3 + M:aids, "organ")

		M:euphoria -= rand(2, 5)
		M:calm--
		M:nausea += 2

		if(prob(10))
			M:sick()

	spawn(0)
		M:ghb_tick = 5
		M:remove_chem("GBL", 0.5)


/datum/on_mob/ghb
	rid = "GHB"

/datum/on_mob/ghb


/datum/on_mob/ghb/react(quaziamt, R, mob/M)
	if(M:benzo && prob(50))
		M:benzo--

	if(M:barbi && prob(50))
		M:barbi--

	if(M:hmur && prob(33))
		M:hmur--

	if(M:alcho && prob(75))
		M:alcho--


	if(prob(60))
		M:ghb++

	if(M:libido < 80)
		M:libido += rand(2, 4)

	if(M:tension > 0 && prob(66))
		M:tension--

	if(quaziamt < 20 && M:thrill > 0)
		M:thrill--

	if(M:depression > 0 && prob(20))
		M:depression--

	if(prob(quaziamt / 4 + (15 - M:calm)))
		M:calm++

	if(M:euphoria < 90)

		M:euphoria += rand(2, 5)

	if(M:epilepsy)
		if(prob(M:epilepsy / 4))
			M:seizure(4)

	if(prob(8))
		M:euphoria++

	if(quaziamt >= 10 && prob(10))
		M << "\red The world became blurry for a second."
		M:epilepsy += 2

	if(quaziamt >= 20)
		if(prob(5))
			M << "\red You definitely ate too much of this stuff."
			M:stun(2)
		if(prob(66))
			M:nausea += 2

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "ethanol" && RE.amount > 1)
			if(prob(20))
				if(M:nausea < 5)
					M:nausea = 5
				else
					M:nausea += 3
			if(prob(25))
				M:says_xynta += 5
			M:damaga(3, "organ")
		if(RE.id == "baclofen" && (RE.amount >= 2 && prob(33)))
			M:euphoria += pick(1, 2)
			M:damaga(2, "organ")

	if(quaziamt >= 25)

		M:says_xynta += 2

		M:damaga(3 + M:aids, "organ")

		M:euphoria -= rand(2, 5)
		M:calm--
		M:nausea += 2

		if(prob(10))
			M:sick()

	spawn(0)
		M:ghb_tick = 5
		M:remove_chem("GHB", 0.3)

/datum/on_mob/lithium_oxybutyrate
	rid = "lithium oxybutyrate"

/datum/on_mob/lithium_oxybutyrate
/datum/on_mob/lithium_oxybutyrate/react(quaziamt, R, mob/M)
	if(M:benzo && prob(85))
		M:benzo--

	if(M:barbi && prob(85))
		M:barbi--

	if(M:hmur && prob(66))
		M:hmur--

	if(M:ghb && prob(50))
		M:ghb--

	if(M:alcho)
		M:alcho--

	if(M:libido < 10)
		M:libido++

	if(quaziamt <= 30 && M:tension > 0)
		M:tension--

	if(quaziamt <= 30 && M:thrill > 0)
		M:thrill--

	if(quaziamt <= 30 && M:depression > 0)
		M:depression--

	if(quaziamt <= 30 && (M:calm < 20 && prob(66)))
		M:calm += pick(1, 2)

	if(M:delirium > 2)
		M:delirium -= 2

	if(M:delirium > 0)
		M:delirium--

	if(M:psychosis > 0 && prob(40))
		M:psychosis = 0

	if(prob(5))
		M:calm++

	if(prob(5) && M:chronodepr > 0)
		M << "\green You feel less depressed."

	M:euphoria++

	if(prob(10) && M:euphoria < 5)
		M:euphoria++

	if(prob(5))
		M:euphoria++

	if(quaziamt > 30)
		if(prob(15))
			M << "\red The world became blurry for a second."
			M:epilepsy += 2
		if(prob(5))
			M << "\red You definitely ate too much of this stuff."
			M:stun(2)
		if(prob(66))
			M:nausea += 2

	spawn(0)
		M:ghb_tick = 5
		M:remove_chem("lithium oxybutyrate", 0.4)

/datum/on_mob/bakla
	rid = "baclofen"

/datum/on_mob/bakla


/datum/on_mob/bakla/react(quaziamt, R, mob/M)


	if(M:benzo && prob(50))
		M:benzo--

	if(M:barbi && prob(50))
		M:barbi--

	if(M:hmur && prob(33))
		M:hmur--

	if(M:alcho && prob(75))
		M:alcho--


	if(!("baclofen" in csecond))
		csecond += "baclofen"

	if(quaziamt >= 2)

		if(prob(65))
			M:ghb++

		if(M:libido < 80)
			M:libido++

		if(quaziamt < 15 && M:thrill)
			M:thrill = 0

		if(M:tension > 0 && prob(40))
			M:tension--

		if(M:depression > 0 && prob(33))
			M:tension--

		if(prob(quaziamt + (15 - M:calm)))
			M:calm++

		if(M:euphoria < 90 && quaziamt >= 2)

			M:euphoria += pick(1, 2)

		if(M:epilepsy)
			if(prob(M:epilepsy))
				M:seizure(5)

		if(prob(5))

			M:euphoria++

		if(quaziamt >= 10 && prob(10))
			M << "\red The world became blurry for a second."
			M:epilepsy += 2

		if(quaziamt >= 15)
			if(prob(5))
				M << "\red You definitely ate too much of this stuff."
				M:stun(2)
			if(prob(66))
				M:nausea += 2

		for(var/datum/reagent/RE in M:blood_chem)
			if(RE.id == "ethanol" && (RE.amount > 1 && quaziamt > 10))
				if(prob(20))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2

				if(prob(25))
					M:says_xynta += 5
				M:damaga(3, "organ")
			if(RE.id == "phenibut" && (quaziamt >= 5 && RE.amount >= 2))
				M:euphoria += pick(1, 2)
				if(prob(40))
					M << "\red You feel a bit sleepy."
					M:drowsy_change(rand(1, 3))

		if(quaziamt >= 17.5)

			if(M:nausea < 15)
				M:nausea += 2

			M:says_xynta += 2

			M:euphoria -= rand(2, 4)
			M:calm--

			M:damaga(rand(1, 3) + M:aids * 2, "organ")

			if(prob(10))
				M:sick()
	else


		if(prob(15))
			M:ghb++

		if(M:thrill)
			M:thrill = 0

		if(M:tension && prob(40))
			M:tension--

	spawn(0)
		M:ghb_tick = 5
		M:remove_chem("baclofen", 0.05)

/datum/on_mob/pregabalin
	rid = "pregabalin"

/datum/on_mob/pregabalin


/datum/on_mob/pregabalin/react(quaziamt, R, mob/M)

	if(M:benzo && prob(50))
		M:benzo--

	if(M:barbi && prob(50))
		M:barbi--

	if(M:hmur && prob(33))
		M:hmur--

	if(M:alcho && prob(75))
		M:alcho--


	if(quaziamt > 3)

		if(prob(50))
			M:ghb++

		if(M:libido < 100)
			M:libido++

		if(M:tension > 0)
			M:tension--

		if(M:depression > 0 && prob(50))
			M:tension--

		if(prob(33) && M:thrill < 3)
			M:thrill++

		if(prob(quaziamt + (15 - M:calm)))
			M:calm++

		if(M:euphoria < 95)
			M:euphoria += rand(1, 5)

		if(prob(quaziamt) && M:thrill < 3)
			M:thrill++

		if(M:epilepsy)
			if(prob(M:epilepsy))
				M:seizure(5)

		if(prob(7))

			M:euphoria++

		if(quaziamt >= 15 && prob(5))

			M:says_xynta += 8

			M:stun(2)

		for(var/datum/reagent/RE in M:blood_chem)

			if(RE.id == "phenibut" && RE.amount >= 2)
				M:euphoria += 5


			if(RE.id == "oxycodone")
				M:euphoria += 3
			if(RE.id == "heroin")
				M:euphoria += 3
			if(RE.id == "methadone")
				M:euphoria += 3
			if(RE.id == "fentanyl")
				M:euphoria += 3
			if(RE.id == "acetylfentanyl")
				M:euphoria += 3
			if(RE.id == "morphine")
				M:euphoria += pick(1, 2)
			if(RE.id == "tramadol")
				M:euphoria += pick(1, 2)
			if(RE.id == "codeine")
				M:euphoria += pick(1, 2)
			if(RE.id == "buprenorphine")
				M:euphoria += 2
			if(RE.id == "hydrocodone")
				M:euphoria += 2

			if(RE.id == "benzodiazepine")
				M:euphoria++
			if(RE.id == "phenazepam")
				M:euphoria += pick(1, 1, 2)
			if(RE.id == "diazepam")
				M:euphoria += pick(1, 1, 2)
			if(RE.id == "midazolam")
				M:euphoria += 2
			if(RE.id == "clonazepam")
				M:euphoria += pick(1, 2)
			if(RE.id == "nitrazepam")
				M:euphoria += pick(1, 2)
			if(RE.id == "cosmozepam")
				M:euphoria += pick(1, 2)
			if(RE.id == "cognitozepam")
				M:euphoria += pick(1, 2)
			if(RE.id == "alprazolam")
				M:euphoria += rand(1, 3)
			if(RE.id == "triazolam")
				M:euphoria++

			if(RE.id == "ethanol" && (RE.amount > 1 && quaziamt > 14))
				if(prob(20))
					if(M:nausea < 5)
						M:nausea = 5
					else
						M:nausea += 2
				if(prob(25))
					M:says_xynta += 5
				M:damaga(3, "organ")

		if(quaziamt >= 17.5)

			M:thrill++

			M:says_xynta += 2

			M:damaga(1 + M:aids * 2, "organ")

			if(prob(10))
				M:sick()
	else

		if(M:tension)
			M:tension--

		if(M:depression && prob(50))
			M:tension--

		if(M:thrill && prob(70))
			M:thrill--

		if(prob(10))
			M:ghb++



	spawn(0)
		M:ghb_tick = 7
		M:remove_chem("pregabalin", 0.05)

/datum/on_mob/phenibut
	rid = "phenibut"

/datum/on_mob/phenibut

/datum/on_mob/phenibut/react(quaziamt, R, mob/M)



	if(M:benzo && prob(40))
		M:benzo--

	if(M:barbi && prob(33))
		M:barbi--

	if(M:hmur && prob(20))
		M:hmur--

	if(M:ghb)
		M:ghb--

	if(M:alcho > 10)
		M:alcho = 10
	else if(M:alcho)
		M:alcho--


	if("chromosome" in M:mutations)
		if(prob(15))
			M:says_xynta = 0
			M << "\green You feel smarter for a second."
			if(prob(1))
				M << "\green \bold And MUCH smarter!"
				M:mutcure_target("chromosome")

	if(M:libido < 30)
		M:libido += pick(1, 2)

	if(prob(80) && M:tension)
		M:tension--

	if(prob(quaziamt * 2 + (15 - M:calm)))
		M:calm++

	if(M:calm <= 20)
		M:calm++

	if(M:euphoria < 105)

		M:euphoria += 3

	if(M:euphoria < 70)

		M:euphoria++

	if(quaziamt >= 15 && prob(15))
		if(prob(33))
			M:stun(3)

		if(prob(66))
			if(prob(15))
				M:mindbreak(-1, 1)
			if(prob(15))
				M:mindbreak(-1, 2)
			if(prob(15))
				M:mindbreak(-1, 3)
			if(prob(15))
				M:mindbreak(-1, 4)
			if(prob(15))
				M:mindbreak(-1, 5)

		if(prob(10))
			M:sick()

	spawn(0) M:remove_chem("phenibut", 0.5)

/datum/on_mob/piracetam
	rid = "piracetam"
/datum/on_mob/piracetam
/datum/on_mob/piracetam/react(quaziamt, R, mob/M)
	if(!M:cetamed && quaziamt > 2)
		M:cetamed = 1

	if("chromosome" in M:mutations)
		if(prob(15))
			M:says_xynta = 0
			M << "\green You feel smarter for a second."
			if(prob(1))
				M << "\green \bold And MUCH smarter!"
				M:mutcure_target("chromosome")

	if(M:drowsy)
		M:drowsy = 0

	if(M:stunned && (!M:parastunned && prob(33)))
		M:stuntime--

	if(M:calm > 20)
		M:calm--

	if(M:cetamed && quaziamt <= 2)
		M:cetamed = 0

	if(M:client && prob(25))
		spawn(10)
			if(M:client)
				for(var/obj/hud_effect/H in M:client:screen)
					M << "\blue Your hallucinations fade away."
					if(!istype(H, /obj/hud_effect/eye))
						M:client:screen -= H
				if(M:client:view != M:client:true_view)
					M << "\blue Your sight suddenly returns to normal."
					M:client:view = M:client:true_view

	if(prob(66) && quaziamt >= 20)
		if(prob(15))
			M:mindbreak(-1, 1)
		if(prob(15))
			M:mindbreak(-1, 2)
		if(prob(15))
			M:mindbreak(-1, 3)
		if(prob(15))
			M:mindbreak(-1, 4)
		if(prob(15))
			M:mindbreak(-1, 5)

	spawn(0)
		M:remove_chem("piracetam", 0.05)


/datum/on_mob/phenotropil
	rid = "phenotropil"

/datum/on_mob/phenotropil
/datum/on_mob/phenotropil/react(quaziamt, R, mob/M)
	if(M:benzo && prob(40))
		M:benzo--

	if(M:barbi && prob(33))
		M:barbi--

	if(M:hmur && prob(20))
		M:hmur--

	if(M:ghb)
		M:ghb--

	if(M:alcho)
		M:alcho--


	if("chromosome" in M:mutations)
		if(prob(33))
			M:says_xynta = 0
			M << "\green You feel smarter for a second."
			if(prob(1))
				M << "\green \bold And MUCH smarter!"
				M:mutcure_target("chromosome")

	if(M:drowsy)
		M:drowsy = 0

	if(M:stunned && (!M:parastunned && prob(33)))
		M:stuntime--

	if(M:libido < 50)
		M:libido += pick(1, 2)

	if(prob(85) && M:tension)
		M:tension--

	if(prob(quaziamt * 2 + (15 - M:calm)))
		M:calm++

	if(M:calm <= 20)
		M:calm++
	else
		if(M:calm > 20)
			M:calm--

	if(M:euphoria < 105 && prob(50))

		M:euphoria += 3

	if(M:euphoria < 70)

		M:euphoria++

	if(quaziamt >= 15 && prob(10))
		if(prob(33))
			M:stun(rand(1, 4))

		if(prob(88))
			if(prob(15))
				M:mindbreak(-1, 1)
			if(prob(15))
				M:mindbreak(-1, 2)
			if(prob(15))
				M:mindbreak(-1, 3)
			if(prob(15))
				M:mindbreak(-1, 4)
			if(prob(15))
				M:mindbreak(-1, 5)

		if(prob(10))
			M:sick()

	spawn(0) M:remove_chem("phenotropil", 0.5)


/datum/on_mob/nicotine
	rid = "nicotine"

/datum/on_mob/nicotine
/datum/on_mob/nicotine/react(quaziamt, R, mob/M)
	if(quaziamt <= 0.5)
		if(M:ci_tick > 40)

			M:cigs = 45
			M:euphoria -= 10
			if(prob(20))
				M:vomit()
			if(prob(50) && M:thrill < 5)
				M:thrill = 5
		else
			M:cigs = 45
			M:ci_tick = 60
			M:euphoria += 15
			if(M:drowsy)
				M:drowsy = 0
			if(M:calm < 15)
				M:calm += 5
			else if(M:calm < 20)
				M:calm += 3
			else
				M:calm += 2




			for(var/datum/reagent/RE in M:blood_chem)
				if(RE.id == "oxycodone")
					M:euphoria += 20

				if(RE.id == "hydrocodone")
					M:euphoria += 15

				if(RE.id == "heroin")
					M:euphoria += 15

				if(RE.id == "methadone")
					M:euphoria += 15

				if(RE.id == "morphine")
					M:euphoria += 15

				if(RE.id == "dextroamphetamine")
					M:euphoria += 15
					if(M:calm > 20)
						M:calm--

				if(RE.id == "methamphetamine")
					M:euphoria += 15
					if(M:calm > 20)
						M:calm--

				if(RE.id == "dextromethamphetamine")
					M:euphoria += 20
					if(M:calm > 20)
						M:calm--

				if(RE.id == "methcathinone")
					M:euphoria += 25
					if(M:calm > 20)
						M:calm--

				if(RE.id == "MDPV")
					M:euphoria += 15
					if(M:calm > 20)
						M:calm--

				if(RE.id == "ephedrine" && RE.amount > 6)
					M:euphoria += 15
					if(M:calm > 20)
						M:calm--

				if(RE.id == "pseudoephedrine" && RE.amount > 8)
					M:euphoria += 15
					if(M:calm > 20)
						M:calm--

				if(RE.id == "4-FA")
					M:euphoria += 15
					if(M:calm > 20)
						M:calm--

				if(RE.id == "mephedrone")
					M:euphoria += 25
					if(M:calm > 20)
						M:calm--

				if(RE.id == "cocaine")
					M:euphoria += 25
					if(M:calm > 20)
						M:calm--

				if(RE.id == "THC")
					M:euphoria += 10

				if(RE.id == "CBD")
					M:euphoria += 10

				if(RE.id == "JWH-018")
					M:euphoria += 15

				if(RE.id == "JWH-250")
					M:euphoria += 15

				if(RE.id == "AB-228")
					M:euphoria += 10

				if(RE.id == "APICA")
					M:euphoria += 10

				if(RE.id == "APINACA")
					M:euphoria += 20

				if(RE.id == "white widow")
					M:euphoria += 15
					M:calm += 4

	if(quaziamt > 5)
		if(prob(20))
			M << "\red You're ODed on nicotine! Found some antidote ASAP!"
		M << "\red You feel unstable."
		if(prob(50))
			M:damaga(2, "organ")
		if(prob(50))
			M:chronoclock += rand(1, 3)
		if(prob(33))
			if(M:thrill < 4)
				M:thrill = 4
			else
				M:thrill++
		if(prob(33))
			M:vomit_red()
		if(prob(20))
			M:stun(2)
	else
		if(prob(5))
			M << "\red You feel weird."
			if(prob(10))
				M:randommut()

	M:remove_chem("nicotine", 0.5)

/datum/on_mob/ASD
	rid = "ASD"

/datum/on_mob/ASD
/datum/on_mob/ASD/react(quaziamt, R, mob/M)
	if(M:radtox > 10)
		M:radtox -= 10
	else
		M:radtox = 0

	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "mutagen" || (RE.id == "ASD-F0" || (RE.id == "polinum" || RE.id == "novichok")))
			M:remove_chem(RE.id, 1)

	if(quaziamt > 5)
		if(prob(40))
			M << "\red You're ODed on some medicine! Found some antidote ASAP!"
			M:damaga(3, "organ")
			if(prob(33))
				M:vomit_red()
				M:chronoclock++
	else
		if(prob(50))
			M << "\blue You feel weird."
			if(prob(30))
				M:curemut()

	M:remove_chem("ASD", 0.5)

/datum/on_mob/polonium
	rid = "polonium"
/datum/on_mob/polonium
/datum/on_mob/polonium/react(quaziamt, R, mob/M)
	M:radtox++
	M:remove_chem("polonium", 1)

/datum/on_mob/novichok
	rid = "novichok"
/datum/on_mob/novichok
/datum/on_mob/novichok/react(quaziamt, R, mob/M)
	M:radtox += 5
	M:remove_chem("novichok", 0.5)

/datum/on_mob/mutagen
	rid = "mutagen"

/datum/on_mob/mutagen
/datum/on_mob/mutagen/react(quaziamt, R, mob/M)
	if(quaziamt > 5)
		if(prob(40))
			M << "\red You're ODed on some medicine! Found some antidote ASAP!"
			M:damaga(3, "organ")
			if(prob(33))
				M:vomit_red()
				M:chronoclock++
	else
		if(quaziamt >= 0.5 && prob(50))
			M << "\blue You feel weird."
			if(prob(25))
				M:randommut()

	M:remove_chem("mutagen", 0.5)

/datum/on_mob/dextroamitriptine
	rid = "dextroamitriptine"
/datum/on_mob/dextroamitriptine
/datum/on_mob/dextroamitriptine/react(quaziamt, R, mob/M)
	if(quaziamt > 0.1)
		if(M:cigs >= 50)
			M:cigs -= 80
		else if(M:cigs >= 30)
			M:cigs -= 30
		else if(M:cigs >= 20)
			M:cigs -= 20
		else if(M:cigs >= 10)
			M:cigs -= 10
		else if(M:cigs >= 5)
			M:cigs -= 5
		else if(M:cigs)
			M:cigs--

		if(M:stim >= 50)
			M:stim -= 50
		else if(M:stim >= 30)
			M:stim -= 30
		else if(M:stim >= 20)
			M:stim -= 20
		else if(M:stim >= 10)
			M:stim -= 10
		else if(M:stim >= 5)
			M:stim -= 5
		else if(M:stim)
			M:stim--



	M:remove_chem("dextroamitriptine", 0.25)


/datum/on_mob/shining_powder
	rid = "shining powder"
/datum/on_mob/shining_powder
/datum/on_mob/shining_powder/react(quaziamt, R, mob/M)
	world << "meh"
	for(var/datum/drug_design/D in designer_drugs)
		world << "[D.name]"
		if(D.name == rid)
			world << "hmm"
			design_on_mob(quaziamt, M, D)
/datum/on_mob/mysterious_powder
	rid = "mysterious powder"
/datum/on_mob/mysterious_powder
/datum/on_mob/mysterious_powder/react(quaziamt, R, mob/M)
	for(var/datum/drug_design/D in designer_drugs)
		if(D.name == rid)
			design_on_mob(quaziamt, M, D)
/datum/on_mob/gloomy_powder
	rid = "gloomy powder"
/datum/on_mob/gloomy_powder
/datum/on_mob/gloomy_powder/react(quaziamt, R, mob/M)
	for(var/datum/drug_design/D in designer_drugs)
		if(D.name == rid)
			design_on_mob(quaziamt, M, D)
/datum/on_mob/powder_of_wonders
	rid = "powder of wonders"
/datum/on_mob/powder_of_wonders
/datum/on_mob/powder_of_wonders/react(quaziamt, R, mob/M)
	for(var/datum/drug_design/D in designer_drugs)
		if(D.name == rid)
			design_on_mob(quaziamt, M, D)
/datum/on_mob/eldritch_powder
	rid = "eldritch powder"
/datum/on_mob/eldritch_powder
/datum/on_mob/eldritch_powder/react(quaziamt, R, mob/M)
	for(var/datum/drug_design/D in designer_drugs)
		if(D.name == rid)
			design_on_mob(quaziamt, M, D)


/datum/reagent/proc/on_touch(quaziamt, mob/M, method)







































	for(var/datum/on_touch/R in on_touch_avaible)
		if(src.id == R.rid)
			R.react(quaziamt, src, M, method)

/datum/on_touch
	var/rid = "nothing to see here, folks"
/datum/on_touch/proc/react(quaziamt, R, mob/M, method)
	world << "\red <font size = 5>ON_TOUCH IS BROKEN, HURR DURR</font>"
/datum/on_touch/chlorine
	rid = "chlorine"
/datum/on_touch/chlorine
/datum/on_touch/chlorine/react(datum/quaziamt, R, M as mob, method)
	if(M:chemprotect >= 8)
		return
	for(var/mob/MM in hearers(M))
		if(!MM.sleeps)
			MM << "\red \bold [M] screams!"
	M:torment(3)
	switch(method)
		if("all")
			M:damaga(round(1 / (round(M:chemprotect / 3) + 1) * quaziamt + 1), "burn")
		if("single")
			M:damaga(4, "burn")
/datum/on_touch/regenerite
	rid = "regenerite"
/datum/on_touch/regenerite
/datum/on_touch/regenerite/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	switch(method)
		if("all")
			M:heal(round(8 / (round(M:chemprotect / 3) + 1)) * quaziamt + 1, "brute")
		if("single")

			M:heal(1, "brute")

/datum/on_touch/fibgenerite
	rid = "fibgenerite"

/datum/on_touch/fibgenerite
/datum/on_touch/fibgenerite/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	switch(method)
		if("all")
			M:heal(round(10 * quaziamt / (round(M:chemprotect / 3 + 1) + 1)), "burn")
		if("single")
			M:heal(3, "burn")
/datum/on_touch/rot
	rid = "corpse rot"
/datum/on_touch/rot
/datum/on_touch/rot/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	var/rotpowah = round(3 * quaziamt / (round(M:chemprotect / 3 + 1) + 1))
	if(rotpowah > 90)
		rotpowah = 90
	switch(method)
		if("all")
			M:damaga(round(quaziamt / 4) - M:chemprotect, "brute")
			M:limb_damage(rotpowah, 1, 0)
			spawn(0) M:limb_damage(rotpowah, 1, 0)
		if("single")
			M:limb_damage(rand(2, 5), 1, 0)
/datum/on_touch/hydrochloric_acid
	rid = "hydrochloric acid"
/datum/on_touch/hydrochloric_acid
/datum/on_touch/hydrochloric_acid/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	for(var/mob/MM in hearers(M))
		if(!MM.sleeps)
			MM << "\red \bold [M] screams!"
	M:torment(5)
	var/acidpowah = round(3 * quaziamt / (round(M:chemprotect / 3 + 1) + 1))
	if(acidpowah > 85)
		acidpowah = 85
	switch(method)
		if("all")
			M:damaga(acidpowah, "burn")
		if("single")
			M:damaga(5, "burn")
/datum/on_touch/sulfuric_acid
	rid = "sulfuric acid"
/datum/on_touch/sulfuric_acid
/datum/on_touch/sulfuric_acid/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	for(var/mob/MM in hearers(M))
		if(!MM.sleeps)
			MM << "\red \bold [M] screams!"
	M:torment(5)
	var/acidpowah = round(3.4 * quaziamt / (round(M:chemprotect / 3 + 1) + 1))
	if(acidpowah > 85)
		acidpowah = 85
	switch(method)
		if("all")
			M:damaga(acidpowah, "burn")
		if("single")
			M:damaga(6, "burn")
/datum/on_touch/nitric_acid
	rid = "nitric acid"
/datum/on_touch/nitric_acid
/datum/on_touch/nitric_acid/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	for(var/mob/MM in hearers(M))
		if(MM.sleeps)
			MM << "\red \bold [M] screams!"
	M:torment(5)
	var/acidpowah = round(3.4 * quaziamt / (round(M:chemprotect / 3 + 1) + 1))
	if(acidpowah > 85)
		acidpowah = 85
	switch(method)
		if("all")
			M:damaga(acidpowah, "burn")
		if("single")
			M:damaga(6, "burn")
/datum/on_touch/aqua_regia
	rid = "aqua regia"
/datum/on_touch/aqua_regia
/datum/on_touch/aqua_regia/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 12)
		return
	for(var/mob/MM in hearers(M))
		if(!MM.sleeps)
			MM << "\red \bold [M] screams!"
	M:torment(10)
	switch(method)
		if("all")
			M:damaga(round(5 * quaziamt / (round(M:chemprotect / 3 + 1) + 2)), "burn")
		if("single")
			M:damaga(10, "burn")
/datum/on_touch/polytrinic_acid
	rid = "polytrinic acid"
/datum/on_touch/polytrinic_acid
/datum/on_touch/polytrinic_acid/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 12)
		return
	for(var/mob/MM in hearers(M))
		if(!MM.sleeps)
			MM << "\red \bold [M] screams!"
	M:torment(10)
	switch(method)
		if("all")
			M:damaga(round(6 * quaziamt / (round(M:chemprotect / 3 + 1) + 5)), "burn")
		if("single")
			M:damaga(15, "burn")
/datum/on_touch/ammonium_hydroxide
	rid = "ammonium hydroxide"
/datum/on_touch/ammonium_hydroxide
/datum/on_touch/ammonium_hydroxide/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	for(var/mob/MM in hearers(M))
		if(!MM.sleeps)
			MM << "\red \bold [M] screams!"
	M:torment(5)
	switch(method)
		if("all")
			M:damaga(round(quaziamt / (round(M:chemprotect / 3 + 1) + 1)), "burn")
		if("single")
			M:damaga(3, "burn")
/datum/on_touch/novichok
	rid = "novichok"
/datum/on_touch/novichok
/datum/on_touch/novichok/react(quaziamt, R, datum/M as mob, method)
	if(M:energyprotect >= 10 || M:chemprotect >= 10)
		return
	switch(method)
		if("all")
			M:radtox += 5
			M:add_chem("novichok", "novichok", quaziamt, 0)
		if("single")
			M:radtox++
/datum/on_touch/polonium
	rid = "polonium"
/datum/on_touch/polonium
/datum/on_touch/polonium/react(quaziamt, R, datum/M as mob, method)
	if(M:energyprotect >= 10 || M:chemprotect >= 10)
		return
	switch(method)
		if("all")
			M:radtox++
			M:add_chem("polonium", "polonium", quaziamt, 0)
		if("single")
			M:radtox++
/datum/on_touch/liquid_smoke
	rid = "liquid smoke"
/datum/on_touch/liquid_smoke
/datum/on_touch/liquid_smoke/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect + M:heatprotect >= 20)
		return
	for(var/mob/MM in hearers(M))
		if(!MM.sleeps)
			MM << "\red \bold [M] screams!"
	switch(method)
		if("all")
			M:damaga(round(quaziamt / (round((M:chemprotect + M:heatprotect) / 6 + 1) + 1)), "burn")
		if("single")
			M:damaga(3, "burn")
/datum/on_touch/iodine
	rid = "iodine"
/datum/on_touch/iodine
/datum/on_touch/iodine/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	switch(method)
		if("all")
			M:heal(round(2.5 / (round(M:chemprotect / 3 + 1) + 1)) * quaziamt, "brute")
		if("single")
			M:heal(1, "brute")
/datum/on_touch/starsalve
	rid = "starsalve"
/datum/on_touch/starsalve
/datum/on_touch/starsalve/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	switch(method)
		if("all")
			M:heal(round(10 / (round(M:chemprotect / 3 + 1) + 1)) * quaziamt, "burn")
		if("single")
			M:heal(1, "burn")

/datum/on_touch/LSD
	rid = "LSD"
/datum/on_touch/LSD
/datum/on_touch/LSD/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	if(method == "all")
		M:add_chem("LSD", "LSD", quaziamt / 1.3, 0)
/datum/on_touch/DOB
	rid = "DOB"
/datum/on_touch/DOB
/datum/on_touch/DOB/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	if(method == "all")
		M:add_chem("DOB", "DOB", quaziamt / 1.3, 0)
/datum/on_touch/DOC
	rid = "DOC"
/datum/on_touch/DOC
/datum/on_touch/DOC/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	if(method == "all")
		M:add_chem("DOC", "DOC", quaziamt / 1.3, 0)
/datum/on_touch/DOI
	rid = "DOI"
/datum/on_touch/DOI
/datum/on_touch/DOI/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	if(method == "all")
		M:add_chem("DOI", "DOI", quaziamt / 1.3, 0)
/datum/on_touch/DOM
	rid = "DOM"
/datum/on_touch/DOM
/datum/on_touch/DOM/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	if(method == "all")
		M:add_chem("DOM", "DOM", quaziamt / 1.3, 0)
/datum/on_touch/botox
	rid = "botox"
/datum/on_touch/botox
/datum/on_touch/botox/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	switch(method)
		if("all")
			M:add_chem("botox", "botox", quaziamt / 2, 0)
		if("single")
			if(prob(50) && M:thrill)
				M:thrill = 0


/datum/on_touch/blacktar
	rid = "black tar"
/datum/on_touch/blacktar
/datum/on_touch/blacktar/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	switch(method)
		if("all")
			M:add_chem("black tar", "black tar", quaziamt / 1.5, 0)
		if("single")
			M:damaga(5, "burn")
			M:damaga(5, "organ")

/datum/on_touch/atropine
	rid = "atropine"

/datum/on_touch/atropine
/datum/on_touch/atropine/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	switch(method)
		if("all")
			M:add_chem("atropine", "atropine", quaziamt / 1.5, 0)
		if("single")
			M:damaga(2, "organ")
/datum/on_touch/biotoxin
	rid = "biotoxin"
/datum/on_touch/biotoxin
/datum/on_touch/biotoxin/react(quaziamt, R, datum/M as mob, method)
	if(M:chemprotect >= 10)
		return
	switch(method)
		if("all")
			M:add_chem("biotoxin", "biotoxin", quaziamt / 1.5, 0)
		if("single")
			M:damaga(1, "burn")

/obj/item/reagent_container/consumable/track
	beltable = 0
	name = "track"
	icon_state = "track1"
	desc = "A track of some powder."
	var/snortd = 0

/obj/item/reagent_container/consumable/track

/obj/item/reagent_container/consumable/track/New()



	icon_state = "track[rand(1, 4)]"
	..()

/obj/item/reagent_container/consumable/track/verb/sniff()
	set name = "Snort some track"
	set src in view(1)
	if(src.snortd)
		return
	src.snortd = 1
	for(var/mob/V in viewers(usr))
		V << "\red \bold [usr] snorts [src]!"
	var/Rsum = 0
	for(var/datum/reagent/R in src.reagent_list)
		R.on_sniff(R.amount, usr)
		Rsum += R.amount
	src.transfer_to_mob(Rsum, usr)
	spawn(5) del(src)
/obj/item/reagent_container/consumable/track/speed
	name = "track"
/obj/item/reagent_container/consumable/track/speed/New()
	src.add_chem("amphetamine", "amphetamine", 2, 0)
/obj/item/reagent_container/consumable/track/venom
	name = "track"
	desc = "It is probably not a good idea to snort so dirty stuff."
/obj/item/reagent_container/consumable/track/venom/New()
	src.add_chem("amphetamine", "amphetamine", 1.9, 0)
	spawn(0)
		src.add_chem("paracetamol", "paracetamol", 20, 0)

/datum/reagent/proc/on_sniff(quaziamt, mob/M)























































	var/q_sum = 0
	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == src.id)
			q_sum += RE.amount
	for(var/datum/on_sniff/R in on_sniff_avaible)
		if(src.id == R.rid)
			R.react(quaziamt, src, M, q_sum)

/datum/on_sniff
	var/rid = "nothing to see here, folks"
/datum/on_sniff/proc/react(quaziamt, R, mob/M, q_sum)
	world << "\red <font size = 5>ON_SNIFF IS BROKEN, HURR DURR</font>"

/datum/on_sniff/speed
	rid = "amphetamine"
/datum/on_sniff/speed
/datum/on_sniff/speed/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.09)

		M << "\blue You feel a rush of energy!"
		if(M:calm > 15)
			if(prob(5 + M:luck / 10))
				M:calm = 15
			else
				M:calm -= 2
		if(M:stuntime)
			M:stuntime = 0
		if(M:drowsy)
			M:drowsy = 0
		M:euphoria += 5

/datum/on_sniff/dextrospeed
	rid = "dextroamphetamine"
/datum/on_sniff/dextrospeed
/datum/on_sniff/dextrospeed/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.09)

		M << "\blue You feel a rush of energy!"
		if(M:calm > 15)
			if(prob(10 + M:luck / 10))
				M:calm = 15
			else
				M:calm -= 2
		if(M:stuntime)
			M:stuntime = 0
		if(M:drowsy)
			M:drowsy = 0
		M:euphoria += 8

/datum/on_sniff/meth
	rid = "methamphetamine"
/datum/on_sniff/meth
/datum/on_sniff/meth/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.09)

		M << "\blue You feel a rush of energy!"
		if(M:calm > 15)
			if(prob(5 + M:luck / 10))
				M:calm = 15
			else
				M:calm -= 2
		if(M:stuntime)
			M:stuntime = 0
		if(M:drowsy)
			M:drowsy = 0
		M:euphoria += 5

/datum/on_sniff/dextrometh
	rid = "dextromethamphetamine"
/datum/on_sniff/dextrometh
/datum/on_sniff/dextrometh/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.09)

		M << "\blue You feel a rush of energy!"
		if(M:calm > 15)
			if(prob(5 + M:luck / 10))
				M:calm = 15
			else
				M:calm -= 2
		if(M:stuntime)
			M:stuntime = 0
		if(M:drowsy)
			M:drowsy = 0
		M:euphoria += 5

/datum/on_sniff/mdpv
	rid = "MDPV"
/datum/on_sniff/mdpv
/datum/on_sniff/mdpv/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.1)

		M << "\blue You feel a rush of energy!"
		if(M:calm > 15)
			if(prob(M:luck / 10))
				M:calm = 15
			else
				M:calm -= 2
		if(M:stuntime)
			M:stuntime = 0
		if(M:drowsy)
			M:drowsy = 0
		M:euphoria += 5

/datum/on_sniff/methcathinone
	rid = "methcathinone"
/datum/on_sniff/methcathinone
/datum/on_sniff/methcathinone/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.09)

		M << "\blue You feel a rush of energy!"
		if(M:calm > 15)
			if(prob(15 + M:luck / 10))
				M:calm = 15
			else
				M:calm -= 2
		if(M:stuntime)
			M:stuntime = 0
		if(M:drowsy)
			M:drowsy = 0
		M:euphoria += 8

/datum/on_sniff/ffa
	rid = "4-FA"
/datum/on_sniff/ffa
/datum/on_sniff/ffa/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.9)
		M << "\blue You feel a rush of energy!"
		if(M:calm > 15)
			if(prob(15 + M:luck / 10))
				M:calm = 15
			else
				M:calm -= 2
		if(M:stuntime)
			M:stuntime = 0
		if(M:drowsy)
			M:drowsy = 0
		M:euphoria += 8

/datum/on_sniff/meow
	rid = "mephedrone"
/datum/on_sniff/meow
/datum/on_sniff/meow/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.9)
		M << "\blue You feel a rush of energy!"
		if(M:calm > 15)
			if(prob(15 + M:luck / 10))
				M:calm = 15
			else
				M:calm -= 2
		if(M:stuntime)
			M:stuntime = 0
		if(M:drowsy)
			M:drowsy = 0
		M:euphoria += 10

/datum/on_sniff/cocaine
	rid = "cocaine"
/datum/on_sniff/cocaine
/datum/on_sniff/cocaine/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 1.5)
		M << "\blue You feel a rush of energy!"
		if(M:calm > 15)
			if(prob(15 + M:luck / 10))
				M:calm = 15
			else
				M:calm -= 2
		if(M:stuntime)
			M:stuntime = 0
		if(M:drowsy)
			M:drowsy = 0
		M:euphoria += 10

/datum/on_sniff/morphine
	rid = "morphine"

/datum/on_sniff/morphine

/datum/on_sniff/morphine/react(datum/quaziamt, R, mob/M as mob, q_sum)
	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.25)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.3)

				M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
				M:euphoria += 25

				if(M:calm < 20)
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"

/datum/on_sniff/codeine
	rid = "codeine"

/datum/on_sniff/codeine
/datum/on_sniff/codeine/react(quaziamt, R, datum/M as mob, q_sum)
	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.3)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.35)
				M << "\green \bold [pick("Da-a-amn, you feel good", "This is just awesome", "Fu-uck, so much of a goodness")]"
				M:euphoria += 20

				if(M:calm < 20 && prob(50))
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"

/datum/on_sniff/tramadol
	rid = "tramadol"
/datum/on_sniff/tramadol
/datum/on_sniff/tramadol/react(quaziamt, R, datum/M as mob, q_sum)
	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.3)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.35)
				M << "\green \bold [pick("Da-a-amn, you feel good", "This is just awesome", "Fu-uck, so much of a goodness")]"
				M:euphoria += 25

				if(M:calm < 20 && prob(66))
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"

/datum/on_sniff/buprenorphine
	rid = "buprenorphine"
/datum/on_sniff/buprenorphine
/datum/on_sniff/buprenorphine/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum > 0.3)
		M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
		M:euphoria += 2
	else
		if(quaziamt >= 0.35)
			M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
			M:euphoria += 40

			if(M:calm < 20 && prob(75))
				M:calm = 20
				M:show_message("\red \bold [M:name] closes \his eyes and smiles")
			else
				M:calm += 5

			for(var/mob/V in hearers(M))
				if(!V.sleeps)
					V << "\red \bold [M:name] moans in pleasure!"

/datum/on_sniff/heroin
	rid = "heroin"
/datum/on_sniff/heroin
/datum/on_sniff/heroin/react(quaziamt, R, datum/M as mob, q_sum)
	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.15)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.2)

				M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
				M:euphoria += 50

				if(M:calm < 20 && prob(75 + usr:luck / 5))
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"

/datum/on_sniff/methadone
	rid = "methadone"
/datum/on_sniff/methadone
/datum/on_sniff/methadone/react(quaziamt, R, datum/M as mob, q_sum)
	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.15)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.2)

				M << "\green \bold [pick("Da-a-amn, you feel good", "This is just awesome", "Fu-uck, so much of a goodness")]"
				M:euphoria += 30

				if(M:calm < 20 && prob(75 + usr:luck / 5))
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"

/datum/on_sniff/desomorphine
	rid = "desomorphine"
/datum/on_sniff/desomorphine
/datum/on_sniff/desomorphine/react(quaziamt, R, datum/M as mob, q_sum)
	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.2)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.25)

				M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
				M:euphoria += 40

				if(M:calm < 20 && prob(75 + usr:luck / 5))
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"

/datum/on_sniff/oxycodone
	rid = "oxycodone"
/datum/on_sniff/oxycodone
/datum/on_sniff/oxycodone/react(quaziamt, R, datum/M as mob, q_sum)
	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.08)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.1)

				M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
				M:euphoria += 44

				if(M:calm < 20)
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"

/datum/on_sniff/fentanyl
	rid = "fentanyl"
/datum/on_sniff/fentanyl
/datum/on_sniff/fentanyl/react(quaziamt, R, datum/M as mob, q_sum)
	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.008)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.01)

				M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
				M:euphoria += 48

				if(M:calm < 20 && prob(75 + usr:luck / 5))
					M:calm = 15
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"

/datum/on_sniff/acetylfentanyl
	rid = "acetylfentanyl"
/datum/on_sniff/acetylfentanyl
/datum/on_sniff/acetylfentanyl/react(quaziamt, R, datum/M as mob, q_sum)
	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.008)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.01)

				M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
				M:euphoria += 48

				if(M:calm < 20 && prob(75 + usr:luck / 5))
					M:calm = 15
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"


/datum/on_sniff/hydrocodone
	rid = "hydrocodone"
/datum/on_sniff/hydrocodone
/datum/on_sniff/hydrocodone/react(quaziamt, R, datum/M as mob, q_sum)
	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.1)
			M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.15)
				M << "\green \bold [pick("Da-a-amn, you feel good", "This is just awesome", "Fu-uck, so much of a goodness")]"
				M:euphoria += 40

				if(M:calm < 20 && prob(75 + usr:luck / 5))
					M:calm = 15
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"

/datum/on_sniff/cb
	rid = "2C-B"

/datum/on_sniff/cb

/datum/on_sniff/cb/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.1)

		M << "\red OH SHIT YOUR NOSDRILS BURN OUCH."
		M:stun(5)
		M:psi += 10
		M:euphoria -= 10
		M:calm -= 10

/datum/on_sniff/cp
	rid = "2C-P"
/datum/on_sniff/cp
/datum/on_sniff/cp/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.1)

		M << "\red OH SHIT YOUR NOSDRILS BURN OUCH."
		M:stun(9)
		M:psi += 15
		M:euphoria -= 10
		M:calm -= 15

/datum/on_sniff/ci
	rid = "2C-I"
/datum/on_sniff/ci
/datum/on_sniff/ci/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.1)

		M << "\red OH SHIT YOUR NOSDRILS BURN OUCH."
		M:stun(3)
		M:psi += 8
		M:euphoria -= 5
		M:calm -= 5

/datum/on_sniff/ibome
	rid = "25i-NBOMe"

/datum/on_sniff/ibome

/datum/on_sniff/ibome/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt > 0.04)

		M << "\red Damn, it is trippy."
		M:stun(1)
		M:psi += 8
		M:euphoria += 2
		M:calm -= 2

/datum/on_sniff/bbome
	rid = "25b-NBOMe"
/datum/on_sniff/bbome
/datum/on_sniff/bbome/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt > 0.04)

		M << "\red Damn, it is trippy."
		M:stun(1)
		M:psi += 8
		M:euphoria += 2
		M:calm -= 2

/datum/on_sniff/dob
	rid = "DOB"
/datum/on_sniff/dob
/datum/on_sniff/dob/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt > 0.0028)

		M << "\red Damn, it is trippy."
		M:stun(1)
		M:psi += 8
		M:euphoria += 2
		M:calm -= 2

/datum/on_sniff/doi
	rid = "DOI"
/datum/on_sniff/doi
/datum/on_sniff/doi/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt > 0.004)

		M << "\red Damn, it is trippy."
		M:psi += 8
		M:euphoria += 5

/datum/on_sniff/doc
	rid = "DOC"
/datum/on_sniff/doc
/datum/on_sniff/doc/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt > 0.004)

		M << "\red Damn, it is trippy."
		M:psi += 8
		M:euphoria += 5

/datum/on_sniff/dom
	rid = "DOM"
/datum/on_sniff/dom
/datum/on_sniff/dom/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt > 0.004)

		M << "\red Damn, it is trippy."
		M:psi += 8
		M:euphoria += 8
		if(M:calm < 15)
			M:calm += 5
		else if(M:calm < 20)
			M:calm += 2



/datum/on_sniff/pcp
	rid = "PCP"
/datum/on_sniff/pcp
/datum/on_sniff/pcp/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 1.5)

		M << "\red FUCK YEA, ANGEL DUST!"
		M:psi += 8
		M:euphoria += 10
		M:damaga(2, "organ")
		if(prob(33) && M:client)
			M:client:view = 2 + M:cetamed
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view

/datum/on_sniff/mxe
	rid = "MXE"
/datum/on_sniff/mxe
/datum/on_sniff/mxe/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 1)

		M << "\red Damn, it is trippy."
		M:psi += 8
		M:euphoria += 5
		if(prob(33) && M:client)
			M:client:view = 2 + M:cetamed
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view

/datum/on_sniff/ketamine
	rid = "ketamine"
/datum/on_sniff/ketamine
/datum/on_sniff/ketamine/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 2)

		M << "\red Damn, it is trippy."
		M:psi += 8
		M:euphoria += 5
		if(prob(33) && M:client)
			M:client:view = 2 + M:cetamed
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view


/datum/on_sniff/sugar
	rid = "sugar"
/datum/on_sniff/sugar
/datum/on_sniff/sugar/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.05)

		M << "\red Looks like it contains some inert powder, lol."

/datum/on_sniff/glucose
	rid = "glucose"
/datum/on_sniff/glucose
/datum/on_sniff/glucose/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.05)

		M << "\red Looks like it contains some inert powder, lol."

/datum/on_sniff/cellulose
	rid = "cellulose"
/datum/on_sniff/cellulose
/datum/on_sniff/cellulose/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.05)

		M << "\red Looks like it contains some inert powder, lol."

/datum/on_sniff/gunpowder
	rid = "space gunpowder"
/datum/on_sniff/gunpowder
/datum/on_sniff/gunpowder/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.05)

		M << "\red Looks like it contains some inert powder, lol."

/datum/on_sniff/carbon
	rid = "carbon"
/datum/on_sniff/carbon
/datum/on_sniff/carbon/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.05)

		M << "\red Looks like it contains some inert powder, lol."

/datum/on_sniff/aluminum
	rid = "aluminum"
/datum/on_sniff/aluminum
/datum/on_sniff/aluminum/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.5)

		M << "\red Looks like it contains some inert powder, lol."

/datum/on_sniff/silicon
	rid = "silicon"
/datum/on_sniff/silicon
/datum/on_sniff/silicon/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.5)

		M << "\red Looks like it contains some inert powder, lol."

/datum/on_sniff/salt
	rid = "salt"
/datum/on_sniff/salt
/datum/on_sniff/salt/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.5)

		M << "\red Looks like it contains some inert powder, lol."

/datum/on_sniff/paracetamol
	rid = "paracetamol"
/datum/on_sniff/paracetamol
/datum/on_sniff/paracetamol/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.5)

		M << "\red Looks like it contains some inert powder, lol."

/datum/on_sniff/rhinestones
	rid = "rhinestones"
/datum/on_sniff/rhinestones
/datum/on_sniff/rhinestones/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.05)

		M << "\red Looks like it contains some inert powder, lol."

/datum/on_sniff/fagenerite
	rid = "fagenerite"
/datum/on_sniff/fagenerite
/datum/on_sniff/fagenerite/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.05)

		M << "\red Looks like it contains some inert powder, lol."


/datum/on_sniff/ephedrine
	rid = "ephedrine"

/datum/on_sniff/ephedrine
/datum/on_sniff/ephedrine/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.5)

		M << "\red Looks like it contains ephedrine."
		M:euphoria += 3
		M:calm -= 3

/datum/on_sniff/pseudoephedrine
	rid = "pseudoephedrine"
/datum/on_sniff/pseudoephedrine
/datum/on_sniff/pseudoephedrine/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 0.5)

		M << "\red Looks like it contains ephedrine."
		M:euphoria += 2
		M:calm -= 2


/datum/reagent/proc/on_smoke(quaziamt, mob/M)












































	var/q_sum = 0
	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == src.id)
			q_sum += RE.amount
	for(var/datum/on_smoke/R in on_smoke_avaible)
		if(src.id == R.rid)
			R.react(quaziamt, src, M, q_sum)

/datum/on_smoke
	var/rid = "still nothing to see here, folks"
/datum/on_smoke/proc/react(quaziamt, R, mob/M, q_sum)
	world << "\red <font size = 5>ON_SMOKE IS BROKEN, HURR DURR</font>"

/datum/on_smoke/salvinorin
	rid = "salvinorin A"

/datum/on_smoke/salvinorin

/datum/on_smoke/salvinorin/react(quaziamt, R, datum/M as mob, q_sum)

	M << "\red <font size = 4>IN THE NAME OF SCIENTIFIC METHOD, IT WAS A SALVIA! WHY IN THE HELL I DID THIS</font>"
	M:psi += 8
	M:calm -= 5
	M:stun(4)
	M:client:view = 16 - M:cetamed * 5
	M:add_chem("salvinorin A", "salvinorin A", quaziamt / 2, 1)
	spawn(10) M:client:view = M:client:true_view


/datum/on_smoke/mxe
	rid = "MXE"
/datum/on_smoke/mxe
/datum/on_smoke/mxe/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum)
		M << "\red You feel strangely mundane. Looks like you're already on some stuff from this vape!"
		return

	if(quaziamt >= 1)

		M << "\red Damn, it is trippy."
		M:psi += 15
		M:euphoria += 10
		M:calm -= 3
		if(prob(33) && M:client)
			M:client:view = 2 + M:cetamed
			spawn(80)
				if(M:client)
					M:client:view = M:client:true_view


/datum/on_smoke/five_meo
	rid = "5-MeO-DMT"

/datum/on_smoke/five_meo

/datum/on_smoke/five_meo/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum)
		M << "\red You feel strangely mundane. Looks like you're already on some stuff from this vape!"
		return

	M << "\red Damn, it is trippy. OWOWOWOWOW"

	if(quaziamt >= 0.4)
		var/dmt = new /obj/hud_effect/dmt()

		if(M:see_invisible < 7)
			M:see_invisible = 7

		if(M:chronoclock)
			if(prob(2))
				M:chronoclock = 0
			else if(prob(50))
				M:chronoclock--

			if(M:chronodepr && prob(2))
				M << "\green You feel less depressed."
				M:chronodepr--

		if(prob(50))
			M:spacevisions(66 - M:cetamed * 33)

		if(M:adapt < 10)
			M:adapt++
		for(var/turf/T in view(M))

			if(T.icon_state == "green" && prob(4 - M:cetamed))
				new /obj/drugged/floor_grind(T)

			if(T.icon_state == "green_broken" && prob(8 - M:cetamed))
				new /obj/drugged/floor_broken(T)

			if(T.density && prob(10))
				new /obj/drugged/wall(T) || new /obj/drugged/wall_fract(T)
			if(!T.density && prob(20))
				new /obj/drugged/floor_fract(T) || new /obj/drugged/floor_mov(T)
			if(!T.density && (quaziamt >= 0.2 && prob(2 - M:cetamed)))
				var/D = new /obj/drugged/acid_spaceman(T)
				if(M:z == 7)
					D:invisibility = 0
					D:clock *= 5
					D:laggy /= 2
			if(!T.density && (quaziamt >= 0.25 && prob(1)))
				var/D = new /obj/drugged/dobman(T)
				if(M:z == 7)
					D:invisibility = 0
					D:clock *= 5
					D:laggy /= 2

		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-13, 14)

		M:psi += rand(2, 5)

		M:client:screen += dmt
		spawn(quaziamt * 20 - quaziamt * 10 * M:cetamed)
			if(dmt && M:client)
				M:client:screen -= dmt


		M:stun(1 + round(quaziamt))
		M:calm -= pick(-1, -1, 1, 1, 2, 3, round(quaziamt * 2))

		if(quaziamt >= 1 || prob(10))
			if(prob(15))
				M:mindbreak(pick(1, 1, 2), 2)
			if(prob(15))
				M:mindbreak(pick(1, 1, 2), 3)
			if(prob(15))
				M:mindbreak(pick(1, 1, 2), 4)

/datum/on_smoke/fivedipt
	rid = "5-MeO-DiPT"

/datum/on_smoke/fivedipt
/datum/on_smoke/fivedipt/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum)
		M << "\red You feel strangely mundane. Looks like you're already on some stuff from this vape!"
		return

	M << "\red Damn, it is trippy. OWOWOWOWOW"

	if(quaziamt >= 0.4)
		var/dmt = new /obj/hud_effect/dmt()

		if(M:see_invisible < 7)
			M:see_invisible = 7

		if(M:chronoclock)
			if(prob(2))
				M:chronoclock = 0
			else if(prob(50))
				M:chronoclock--

			if(M:chronodepr && prob(2))
				M << "\green You feel less depressed."
				M:chronodepr--

		if(prob(50))
			M:spacevisions(66 - M:cetamed * 33)

		if(M:adapt < 10)
			M:adapt++
		for(var/turf/T in view(M))

			if(T.icon_state == "green" && prob(4 - M:cetamed))
				new /obj/drugged/floor_grind(T)

			if(T.icon_state == "green_broken" && prob(8 - M:cetamed))
				new /obj/drugged/floor_broken(T)

			if(T.density && prob(10))
				new /obj/drugged/wall(T) || new /obj/drugged/wall_fract(T)
			if(!T.density && prob(20))
				new /obj/drugged/floor_fract(T) || new /obj/drugged/floor_mov(T)
			if(!T.density && (quaziamt >= 0.2 && prob(2 - M:cetamed)))
				var/D = new /obj/drugged/acid_spaceman(T)
				if(M:z == 7)
					D:invisibility = 0
					D:clock *= 5
					D:laggy /= 2
			if(!T.density && (quaziamt >= 0.25 && prob(1)))
				var/D = new /obj/drugged/dobman(T)
				if(M:z == 7)
					D:invisibility = 0
					D:clock *= 5
					D:laggy /= 2

		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-13, 14)

		M:psi += rand(2, 5)

		M:client:screen += dmt
		spawn(quaziamt * 20 - quaziamt * 10 * M:cetamed)
			if(dmt && M:client)
				M:client:screen -= dmt

		M:stun(1 + round(quaziamt))
		M:calm -= pick(-1, -1, 1, 1, 2, 3, round(quaziamt * 2))

		if(quaziamt >= 1 || prob(10))
			if(prob(15))
				M:mindbreak(pick(1, 1, 2), 2)
			if(prob(15))
				M:mindbreak(pick(1, 1, 2), 3)
			if(prob(15))
				M:mindbreak(pick(1, 1, 2), 4)


/datum/on_smoke/dipt
	rid = "DiPT"
/datum/on_smoke/dipt
/datum/on_smoke/dipt/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum)
		M << "\red You feel strangely mundane. Looks like you're already on some stuff from this vape!"
		return

	if(quaziamt >= 0.6)

		M << "\blue You hear an echoe from the throughts inside of your head."
		M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

		M:psi += 5

		if(M:see_invisible < 7)
			M:see_invisible = 7

		M:distortion += 8

/datum/on_smoke/dmt
	rid = "DMT"

/datum/on_smoke/dmt
/datum/on_smoke/dmt/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum)
		M << "\red You feel strangely mundane. Looks like you're already on some stuff from this vape!"
		return

	if(quaziamt >= 0.2)

		M << "\red \bold OWOWOWOWOWOW OH FUCK"

		if(M:see_invisible < 14)
			M:see_invisible = 14

		var/dmt = new /obj/hud_effect/dmt()

		M:spacevisions(33)

		if(M:adapt < 10)
			M:adapt++

		for(var/turf/T in view(M))
			if(T.density && prob(60 + quaziamt * 300 - M:cetamed * 20))
				new /obj/drugged/wall_fract(T)
			if(!T.density && prob(60 + quaziamt * 300 - M:cetamed * 10))
				new /obj/drugged/floor_fract(T)
			if(!T.density && prob(50))
				var/D = new /obj/drugged/elf(T)
				if(M:z == 7)
					D:invisibility = 0
					D:clock *= 5
					D:laggy /= 2
			if(!T.density && (quaziamt >= 0.25 && prob(2 - M:cetamed)))
				var/D = new /obj/drugged/dobman(T)
				if(M:z == 7)
					D:invisibility = 0
					D:clock *= 5
					D:laggy /= 2

		if(M:euphoria >= 50)
			if(prob(66))
				M:euphoria -= 5
		else
			M:euphoria += pick(-10, 20)

		M << "\blue You hear an echoe from the throughts inside of your head."
		if(prob(50))
			M:client << sound(pick('sounds/ambi1.wav', 'sounds/ambi2.wav', 'sounds/ambi3.wav'))

		M:psi += rand(2, 10)

		M:client:screen += dmt
		spawn(quaziamt * 50 - quaziamt * 25 * M:cetamed)
			if(dmt && M:client)
				M:client:screen -= dmt

		M:stun(1 + round(quaziamt))
		M:calm -= 5

	if(prob(33))
		M:mindbreak(pick(1, 2), 2)
	if(prob(33))
		M:mindbreak(pick(1, 2), 3)
	if(prob(33))
		M:mindbreak(pick(1, 2), 4)


/datum/on_smoke/cbd
	rid = "CBD"

/datum/on_smoke/cbd

/datum/on_smoke/cbd/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 1)

		M << "\green You feel rela-a-a-axed."
		M:euphoria += min(quaziamt, 5)
		M:calm += 3

/datum/on_smoke/thc
	rid = "THC"
/datum/on_smoke/thc
/datum/on_smoke/thc/react(quaziamt, R, datum/M as mob, q_sum)
	if(quaziamt >= 1)

		M << "\green Dat's the stuff."
		M:euphoria += min(quaziamt, 10)

/datum/on_smoke/jwh018
	rid = "JWH-018"
/datum/on_smoke/jwh018
/datum/on_smoke/jwh018/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum)
		M << "\red You feel strangely mundane. Looks like you're already on some stuff from this vape!"
		return

	if(quaziamt >= 0.3)

		M << "\green Dat's the stuff."
		M:euphoria += min(quaziamt * 10, 15)
		if(M:calm > 0)
			M:calm = max(0, M:calm - 8)

		if(prob(15))
			M << "\red \bold AAAAAAGH IT HURTS"
			M << "\red Protip: smoking crap like this usually isn't a good idea."
			M:damaga(20, "organ")

/datum/on_smoke/jwh250
	rid = "JWH-250"
/datum/on_smoke/jwh250
/datum/on_smoke/jwh250/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum)
		M << "\red You feel strangely mundane. Looks like you're already on some stuff from this vape!"
		return

	if(quaziamt >= 0.3)

		M << "\green Dat's the stuff."
		M:euphoria += min(quaziamt * 10, 8)
		if(M:calm > 0)
			M:calm = max(0, M:calm - 4)

		if(prob(15))
			M << "\red \bold AAAAAAGH IT HURTS"
			M << "\red Protip: smoking crap like this usually isn't a good idea."
			M:damaga(20, "organ")

/datum/on_smoke/ab228
	rid = "AB-228"
/datum/on_smoke/ab228
/datum/on_smoke/ab228/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum)
		M << "\red You feel strangely mundane. Looks like you're already on some stuff from this vape!"
		return

	if(quaziamt >= 0.3)

		M << "\green Dat's the stuff."
		M:euphoria += min(quaziamt * 10, 8)
		if(M:calm > 0)
			M:calm = max(0, M:calm - 4)

		if(prob(33))
			M << "\red \bold AAAAAAGH IT HURTS"
			M << "\red Protip: smoking crap like this usually isn't a good idea."
			M:damaga(50, "organ")

/datum/on_smoke/apica
	rid = "APICA"
/datum/on_smoke/apica
/datum/on_smoke/apica/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum)
		M << "\red You feel strangely mundane. Looks like you're already on some stuff from this vape!"
		return

	if(quaziamt >= 0.3)

		M << "\green Dat's the stuff."
		M:euphoria += min(quaziamt * 10, 8)
		if(M:calm > 0)
			M:calm = max(0, M:calm - 4)

		if(prob(33))
			M << "\red \bold AAAAAAGH IT HURTS"
			M << "\red Protip: smoking crap like this usually isn't a good idea."
			M:damaga(50, "organ")

/datum/on_smoke/apinaca
	rid = "AB-228"
/datum/on_smoke/apinaca
/datum/on_smoke/apinaca/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum)
		M << "\red You feel strangely mundane. Looks like you're already on some stuff from this vape!"
		return

	if(quaziamt >= 0.075)

		M << "\green Dat's the stuff."
		M:euphoria += 30
		if(M:calm > 0)
			M:calm -= 6

		if(prob(50))
			M << "\red \bold AAAAAAGH IT HURTS"
			M << "\red Protip: smoking crap like this usually isn't a good idea."
			M:damaga(50, "organ")


/datum/on_smoke/speed
	rid = "ampetamine"

/datum/on_smoke/speed
/datum/on_smoke/speed/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum >= 1.9)
		M << "\red \bold You definitely smoke this crap too frequently! How 'bout making a pause?"
		M:euphoria++
	else
		if(quaziamt >= 2.25)

			M << "\blue You feel a rush of energy!"
			if(M:calm > 15)
				if(prob(66))
					M:calm = 15
				else
					M:calm -= 2
			if(M:stuntime)
				M:stuntime = 0
			if(M:drowsy)
				M:drowsy = 0
			M:euphoria += 15

/datum/on_smoke/dextrospeed
	rid = "dextroampetamine"
/datum/on_smoke/dextrospeed
/datum/on_smoke/dextrospeed/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum >= 1.9)
		M << "\red \bold You definitely smoke this crap too frequently! How 'bout making a pause?"
		M:euphoria++
	else
		if(quaziamt >= 2.25)

			M << "\blue You feel a rush of energy!"
			if(M:calm > 15)
				if(prob(66))
					M:calm = 15
				else
					M:calm -= 2
			if(M:stuntime)
				M:stuntime = 0
			if(M:drowsy)
				M:drowsy = 0
			M:euphoria += 15

/datum/on_smoke/meth
	rid = "methamphetamine"
/datum/on_smoke/meth
/datum/on_smoke/meth/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum >= 1.5)
		M << "\red \bold You definitely smoke this crap too frequently! How 'bout making a pause?"
		M:euphoria += 2
	else
		if(quaziamt >= 1.85)
			M << "\blue You feel a rush of energy!"
			if(M:calm > 15)
				if(prob(66))
					M:calm = 15
				else
					M:calm -= 2
			if(M:stuntime)
				M:stuntime = 0
			if(M:drowsy)
				M:drowsy = 0
			M:euphoria += 50
			M:stim += 10

			for(var/mob/V in hearers(M))
				if(!V.sleeps)
					V << "\red \bold [M:name] moans in pleasure!"

/datum/on_smoke/cocaine
	rid = "cocaine"
/datum/on_smoke/cocaine
/datum/on_smoke/cocaine/react(quaziamt, R, mob/M, q_sum)
	if(q_sum >= 4)
		M << "\blue You feel a rush of energy!"
		M << "\green \bold OH YEAAAAA IT FEELS JUST LIKE TOVARISCH KRUPSKAYA BLOWING YOU OFF"
		if(M:calm > 15)
			if(prob(50))
				M:calm = 15
			else
				M:calm -= 2
		if(M:stuntime)
			M:stuntime = 0
		if(M:drowsy)
			M:drowsy = 0
		M:euphoria += 70
		M:stim += 15

		for(var/mob/V in hearers(M))
			if(!V.sleeps)
				V << "\red \bold [M:name] moans in pleasure!"

/datum/on_smoke/mdpv
	rid = "MDPV"

/datum/on_smoke/mdpv
/datum/on_smoke/mdpv/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum > 2)
		M << "\red \bold You definitely shoot this crap too frequently! How 'bout making a pause?"
		M:euphoria++
	else
		if(quaziamt >= 2.23)
			M << "\blue You feel a rush of energy!"
			if(M:calm > 15)
				if(prob(50))
					M:calm = 15
				else
					M:calm -= 2
			if(M:stuntime)
				M:stuntime = 0
			if(M:drowsy)
				M:drowsy = 0
			M:euphoria += 10


/datum/on_smoke/heroin
	rid = "heroin"

/datum/on_smoke/heroin
/datum/on_smoke/heroin/react(quaziamt, R, datum/M as mob, q_sum)
	R:on_iv(quaziamt, M, "head")

/datum/on_smoke/opium
	rid = "opium"
/datum/on_smoke/opium
/datum/on_smoke/opium/react(quaziamt, R, datum/M as mob, q_sum)
	for(var/datum/reagent/RE in M:blood_chem)
		if(RE.id == "codeine" || RE.id == "morphie")
			q_sum += RE.amount

	if(M:opi_block)
		M << "\red \bold You feel mundane as hell."
	else
		if(q_sum > 0.25)
			M << "\red \bold You definitely smoke this crap too frequently! How 'bout making a pause?"
			M:euphoria += 2
		else
			if(quaziamt >= 0.3)

				M << "\green \bold [pick("DAMN OH YEAH", "HOLY MOTHER OF LENIN", "YOU'VE NEVER FELT ANYTHING BETTER", "YEAAAAAAAAA")]"
				M:euphoria += 50

				if(M:calm < 20)
					M:calm = 20
					M:show_message("\red \bold [M:name] closes \his eyes and smiles")
				else
					M:calm += 5

				for(var/mob/V in hearers(M))
					if(!V.sleeps)
						V << "\red \bold [M:name] moans in pleasure!"

/datum/on_smoke/codeine
	rid = "codeine"
/datum/on_smoke/codeine
/datum/on_smoke/codeine/react(quaziamt, R, datum/M as mob, q_sum)
	R:on_iv(quaziamt, M, "head")

/datum/on_smoke/tramadol
	rid = "tramadol"
/datum/on_smoke/tramadol
/datum/on_smoke/tramadol/react(quaziamt, R, datum/M as mob, q_sum)
	R:on_iv(quaziamt, M, "head")

/datum/on_smoke/morphine
	rid = "morphine"
/datum/on_smoke/morphine
/datum/on_smoke/morphine/react(quaziamt, R, datum/M as mob, q_sum)
	R:on_iv(quaziamt, M, "head")

/datum/on_smoke/buprenorphine
	rid = "buprenorphine"
/datum/on_smoke/buprenorphine
/datum/on_smoke/buprenorphine/react(quaziamt, R, datum/M as mob, q_sum)
	R:on_iv(quaziamt, M, "head")
/datum/on_smoke/methadone
	rid = "methadone"
/datum/on_smoke/methadone
/datum/on_smoke/methadone/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	R:on_iv(quaziamt, M, "head")
/datum/on_smoke/hydrocodone
	rid = "hydrocodone"
/datum/on_smoke/hydrocodone
/datum/on_smoke/hydrocodone/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	R:on_iv(quaziamt, M, "head")
/datum/on_smoke/oxycodone
	rid = "oxycodone"
/datum/on_smoke/oxycodone
/datum/on_smoke/oxycodone/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	R:on_iv(quaziamt, M, "head")
/datum/on_smoke/fentanyl
	rid = "fentanyl"
/datum/on_smoke/fentanyl
/datum/on_smoke/fentanyl/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	R:on_iv(quaziamt, M, "head")
/datum/on_smoke/acetylfentanyl
	rid = "acetylfentanyl"
/datum/on_smoke/acetylfentanyl
/datum/on_smoke/acetylfentanyl/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	R:on_iv(quaziamt, M, "head")
/datum/on_smoke/moprphine
	rid = "moprphine"
/datum/on_smoke/moprphine
/datum/on_smoke/moprphine/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	R:on_iv(quaziamt, M, "head")
/datum/on_smoke/desomorphine
	rid = "desomorphine"
/datum/on_smoke/desomorphine
/datum/on_smoke/desomorphine/react(quaziamt, R, datum/M as mob, q_sum, limbname = null)

	R:on_iv(quaziamt, M, null)


/datum/on_smoke/nicotine
	rid = "nicotine"

/datum/on_smoke/nicotine

/datum/on_smoke/nicotine/react(quaziamt, R, mob/M, q_sum)
	if(M:ci_tick > 40)
		M << "\red You're smoking too frequently!"


/datum/on_smoke/widow
	rid = "white widow"

/datum/on_smoke/widow

/datum/on_smoke/widow/react(quaziamt, R, datum/M as mob, q_sum)
	if(q_sum)
		M << "\red \bold You definitely smoke this crap too frequently! How 'bout making a pause?"
		M:euphoria += 2

	if(quaziamt >= 1)

		M << "\green Dat's the stuff."
		M:euphoria += min(quaziamt * 10, 15)
		M:calm += 10

		if(prob(50))
			M << "\red \bold It is difficult to stand on your feet while being on this stuff."
			M:stun(5)

