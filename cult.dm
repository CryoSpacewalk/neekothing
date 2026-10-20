/obj/item/grimore{icon = 'grafon/item/book.dmi'; beltable = 1; dmg = 10; accu = 90; groovy = 10; parry = 10; icon_state = "stalin"; name = "Didonomicon"; desc = "This stuff gives you creeps."; var/datum/spell/s_charged = null}
/var/last_cid = 0
/var/cultstun_left = 2
/proc/stalin_summon(mob/M)









	stalin_summoned = 1
	M << "\red \bold FUCK YEAHHHHHHHHH"
	world << "\red \bold ALL HAIL COMRADE STALIN!!!"
	for(var/mob/C in world)
		if(C.cult == 1)
			C << pick("Daem sverh plana!", "Spasibo tovarischu Stalinu za nashe schastlivoe detstvo!", "Pyatiletka v chetyre goda!", "Slava velikomu Stalinu!", "Rabotay tak, kak uchit Stalin!", "Stalin - schastye narodnoe!")
	new /obj/singulo/stalin(M:loc)
	spawn(20)
		world << "\blue We detected a massive demonic invasion on your station. An emergency shuttle is called."
		spawn(5)
			forceshut = 1
			shuttlecall()

/mob/proc/cult()


	spawn(10)
		if(!("stalinism" in csecond))
			csecond += "stalinism"
		src << "\red It is time to wake up."
		spawn(30)
			cult_needed = 0
			cult = 1
			cultplayer = 1
			src << "\red \bold You're infernal stalinist!"
			src << "\red \bold You must use your grimore to cast destructive spells, convert spacemen to personality cult and maybe even summon avatar of Stalin himself!"
			src << "\red \bold Feel free to experiment with symbols in grimore, but don't forget that any spell you cast drains a bit of your lifeforce by damaging your organs."
			src << "\red \bold And yeah, some powerful spells can even drain you to death especially if you're already sick."
			src << "\red \bold You or one of your comrades will get aknowledge of one of spells after a while."
			if(src.hidden)
				del(src.hidden)
			if(src.hidden2)
				del(src.hidden2)
			src.equip_pocket(new /obj/item/grimore())
			var/convspell
			var/stunspell
			for(var/datum/spell/S in spells)
				if(S.name == "stalinistic conversion")
					convspell = S.spl
				else if(S.name == "visions of Inferno")
					stunspell = S.spl
			src << "\red \bold Use stalinistic conversion spell (today it is <font color=blue>[convspell]</font>) for converting other spacemen."
			src << "\red \bold Have a trouble converting those pesky enemies of the people? No problem! Use visions of Inferno spell (<font color=blue>[stunspell]</font>) to stun all visible non-stalinists in 4 tiles around you for about 10 seconds. You can use it only up to [cultstun_left] times, however."
			traitorism -= 0.5

/mob/proc/convert()
	src.cult = 1
	cultplayer = 1
	src << "\red \bold You're infernal stalinist!"
	src << "\red Help your fellow personality cultists to reabilitate comrade Stalin by summoning one of his shards into this sinful world."
	src << "\red Ask chief cultist for a grimore if you don't have one."

/mob/proc/cast(obj/A)


	if(src.item == A)
		var/ft = input("Select first symbol:", , "A") in list("A", "B", "J", "H", "V", "T", "N", "Z")
		var/sd = input("Select second symbol:", , "A") in list("A", "B", "J", "H", "V", "T", "N", "Z")
		var/td = input("Select third symbol:", , "A") in list("A", "B", "J", "H", "V", "T", "N", "Z")
		var/fh = input("Select fourth symbol:", , "A") in list("A", "B", "J", "H", "V", "T", "N", "Z")
		if(!src.item == A)
			return
		else
			var/spl = ft + sd + td + fh
			var/nospell = 1
			for(var/datum/spell/S in spells)
				if(S.spl == spl)
					nospell = 0
					src << "\blue The Didonomicon is charged. Use it when you need to cast your spell."
					A:s_charged = S
			spawn(0) if(nospell)
				src << "\red It is just a rubbish of runes, not a working spell!"


/obj/item/grimore/attack_self(mob/M)










	if(M:cult == 0)
		M << pick("Daem sverh plana!", "Spasibo tovarischu Stalinu za nashe schastlivoe detstvo!", "Pyatiletka v chetyre goda!", "Slava velikomu Stalinu!", "Rabotay tak, kak uchit Stalin!", "Stalin - schastye narodnoe!")
		return
	else if(src.s_charged)
		src:s_charged:casting(M)
		src.s_charged = null
	else
		M:cast(src)


/obj/cult/New()










	for(var/obj/cult/S in src.loc)
		if(!(S == src))
			del(S)

/obj/cult/attack_by(atom/I)
	if(istype(I, /obj/item/soap))
		del(src)
/obj/cult/stalin_portrait
	name = "Some mustached folk face"
	icon_state = "portrait"
/obj/cult/stalin_portrait
/obj/cult/stalin_portrait/attack_hand(mob/M)
	if(!usr.candofun)
		usr << "\red NO"
		return
	if(M:cult == 0)
		M << "\red You have an uncanny feeling about it."
		return
	else
		for(var/mob/ME in src.loc)
			if(ME.cult == 0)
				ME.stun(5)
				M << "\blue [ME.name] looks a lot more like comrade to you now."
				ME.convert()
		spawn(0) del(src)

/obj/cult/penta
	name = "Pentacle"
	icon_state = "penta2"
	desc = "For some reason, spectres and veterans can't walk over this thing."
/obj/cult/penta
/obj/cult/penta/Cross(atom/movable/A)
	if(istype(A, /mob))
		var/M = A
		if(M:mat == "ether")
			return 0
		else
			return 1
	else if(istype(A, /obj/putin))



		return 0
	else
		return 1

/obj/cult/penta/Crossed(atom/movable/A)
	if(istype(A, /mob))
		var/M = A
		if(M:cult)
			M << "\red [src.name] burns you as you walk over it."
			M:damaga(rand(1, 11 - round(M:luck / 10)), "organ")
			M:damaga(rand(5, 11 - round(M:luck / 20)), "burn")
			if(prob(20))
				M << "\red \bold OH IT BURNS"
				M:torment(2)
				M:stun(2)
		if("horns" in M:mutations)
			M << "\red OUCH! Looks like your horns prevents easy passing through [src.name]."
			M:damaga(rand(5, 11 - round(M:luck / 20)), "burn")
	else if(istype(A, /obj/putin_big))
		var/PB = A
		src.show_message("[PB:name] is burned by protective sigil!")
		PB:biodmg(23)
		..()

/obj/cult/penta/New()
	icon_state = "penta[rand(1, 6)]"
	..()

/obj/cult/lesser_banish
	name = "Lesser Banishment Pentagram"
	icon_state = "lesser_banish"
	desc = "For some reason, spectres and veterans are banished or damaged by this thing."

/obj/cult/lesser_banish
/obj/cult/lesser_banish/Cross(atom/movable/A)
	if(istype(A, /mob))
		var/M = A
		if(istype(M, /mob/ghost))
			var/mob/ghost/GH = A
			src.show_message("[GH:name] is banished!")
			spawn(1)
				GH:z = 2
				sleep(0)
				GH:x = 5
				sleep(0)
				GH:y = 5
		else if(istype(M, /mob/stalin))
			var/ST = A
			ST:damaga(50, "brute")
			src.show_message("[ST:name] is damaged!")
		else
			return 1
	else if(istype(A, /obj/putin))




		return 0
	else
		return 1

/obj/cult/drain
	name = "Creepy drawing"
	icon_state = "drain"
	var/cid = 0
/obj/cult/drain
/obj/cult/drain/attack_hand(mob/M)
	if(M:cult == 0)
		M << "\red You have an uncanny feeling about it."
		return
	else
		M << "\blue You hide the drawing from others."
		spawn(0) src.invisibility = 2
/obj/cult/drain/Crossed(atom/movable/A)
	if(istype(A, /mob) && A:density)
		var/M = A
		if(M:cult)
			return
		if(M:clothes)
			if(istype(M:clothes, /obj/item/clothes/purificator))
				usr << "\red \bold You've just crossed life-draining sigilum. Don't worry: it is no more."
				del(src)
				return
		M:damaga(8, "organ")
		M:damaga(1, "burn")
		M:damaga(1, "brute")
		M:limb_damage(5, 1, 0)
		for(var/mob/MB in world)
			if(MB.cid == src.cid)
				MB << "\green You feel somewhat better."
				MB.heal(10, "organ")
				MB.heal(10, "burn")
				MB.heal(10, "brute")
		if(prob(round(M:luck / 10)))
			M << "\red You feel a tiny prick."
/obj/cult/veteran
	name = "Creepy drawing"
	var/cid = 0
	icon_state = "veteran"
	var/succ = 0
/obj/cult/veteran
/obj/cult/veteran/attack_hand(mob/M)
	if(M:cult == 0)
		M << "\red You have an uncanny feeling about it."
		return
	else
		for(var/mob/MB in src.loc)
			if(MB.dead && MB.mat == "flesh")
				src.show_message("\red It feeds...")
				src.succ += 2
				del(M)
		for(var/obj/item/gib/G in src.loc)
			if(src.succ < 2)
				src.succ++
				src.show_message("\red It feeds...")
				del(G)
		for(var/obj/item/limb/L in src.loc)
			if(src.succ < 2 && !L.robo)
				src.succ++
				src.show_message("\red It feeds...")
				del(L)
		spawn(0)
			if(src.succ >= 2)
				new /obj/effect/warp_splash(loc)
				new /mob/stalin/veteran(loc)
				src.succ = 0
				if(prob(33))
					new /obj/effect/warp_splash(loc)
					src.show_message("\red Stalin seeks other their fellow comrades and send some extra supplies")
					new /mob/stalin/veteran(loc)
					new /mob/stalin/veteran(loc)
/obj/cult/haunt
	icon_state = "haunt"
	name = "Creepy drawing"
/obj/cult/haunt/New()
	for(var/obj/cult/stalin_portrait/S in src.loc)
		if(!(S == src))
			del(S)
/obj/cult/haunt/attack_hand(mob/M)
	if(M:cult == 0)
		M << "\red You have an uncanny feeling about it."
		return
	else
		if(0 in funfacts)
			funfacts += "the station was haunted with stalinistic magick this round"
		M << "\red You try to haunt this place with the dwellers of Hell."
		for(var/mob/ghost/G in world)
			G.loc = src.loc
	spawn(0) del(src)
/obj/cult/escape
	name = "Drawn portal"
	icon_state = "escape"
/obj/cult/escape
/obj/cult/escape/New()
	for(var/obj/cult/stalin_portrait/S in src.loc)
		if(!(S == src))
			del(S)
/obj/cult/escape/attack_hand(mob/M)
	if(M:cult == 0)
		M << "\red Nothing happens."
		return
	else
		M << "\red You pass through the subrealm gates."
		for(var/mob/A in view(M))
			if(A.mat == "ether")
				for(var/turf/floor/start/T in world)
					A.loc = T
		spawn(0)
			for(var/turf/floor/start/T in world)
				M:loc = T
			new /obj/effect/sparks(M:loc)
		spawn(0) del(src)
/obj/cult/escape/attack_by(atom/I)
	if(istype(I, /obj/item/tool/cross))
		usr << "\red You activate drawn portal with your [I:name] and pass through the subrealm gates."
		for(var/mob/A in view(usr))
			if(A.mat == "ether")
				for(var/turf/floor/start/T in world)
					A.loc = T
		spawn(0)
			for(var/turf/floor/start/T in world)
				usr.loc = T
			new /obj/effect/sparks(usr.loc)
		spawn(0) del(src)
	else
		..()
/obj/cult/tentacle
	name = "Weird sigil"
	icon_state = "tentacle"
/obj/cult/tentacle
/obj/cult/tentacle/New()
	spawn(100)
		for(var/mob/M in viewers(src))
			if(prob(66))
				M.bashroulette()
		spawn(0)
			src.abyss_corrupt(4)
			spawn(0)
				del(src)

var/list/spells = list(
	new /datum/spell/haunt,
	new /datum/spell/convert,
	new /datum/spell/orb,
	new /datum/spell/comrades,
	new /datum/spell/summon,

	new /datum/spell/veteran,
	new /datum/spell/stun,
	new /datum/spell/repression,
	new /datum/spell/drain,

	new /datum/spell/tentacle)
/datum/spell/proc/casting(mob/M)





	world << "<font size=7>HONK HONK EI NATH HOP TRAITOR</font>"
/datum/spell/proc/sroll()
	var/ft = pick("A", "B", "J", "H", "V", "T", "N", "Z")
	var/sd = pick("A", "B", "J", "H", "V", "T", "N", "Z")
	var/td = pick("A", "B", "J", "H", "V", "T", "N", "Z")
	var/fh = pick("A", "B", "J", "H", "V", "T", "N", "Z")
	spl = ft + sd + td + fh
/datum/spell/convert
	name = "stalinistic conversion"
/datum/spell/convert
/datum/spell/convert/casting(mob/M)
	M:damaga(5, "brute")
	M << "\red You draw comrade Joseph's portrait on the floor. Touch it with some non-stalinist on top of it for conversion."
	new /obj/cult/stalin_portrait(M:loc)
/datum/spell/haunt
	name = "gates of Inferno"
/datum/spell/haunt
/datum/spell/haunt/casting(mob/M)
	M:damaga(10, "organ")
	M << "\red Dead are restless."
	for(var/mob/ghost/G in world)
		G.loc = locate(G.x, G.y, 1)
/datum/spell/orb
	name = "Orb of Monitoring"
/datum/spell/orb
/datum/spell/orb/casting(mob/M)
	M:damaga(5, "organ")
	M << "\red Now you'll know what are enemies of the people up to."
	new /obj/eye/orb/wicked(M:loc)
/datum/spell/comrades
	name = "comrade list"
/datum/spell/comrades
/datum/spell/comrades/casting(mob/M)
	M:damaga(1, "organ")
	for(var/mob/C in world)
		if(C.dead == 0 && C.cult == 1)
			M << "\red [C]."
/datum/spell/summon
	name = "Stalin rehabilitation"
/datum/spell/summon
/datum/spell/summon/casting(mob/M)
	var/amt = 0
	for(var/mob/C in world)
		if(C.dead == 0 && C.cultplayer == 1)
			amt += 1
	spawn(0)
		if(amt < 5)
			M << "\red There's not enough comrades for casting this spell! You need at least 5 infernal stalinists for this spell."
		else
			stalin_summon(M)


/datum/spell/repression
	name = "repression on betrayers"
/datum/spell/repression
/datum/spell/repression/casting(mob/M)
	M:damaga(10, "organ")
	M:damaga(10, "burn")
	M << "\red You repress all non-stalinists in your surroundings."
	for(var/mob/C in range(world.view, M))
		if(!C.cult && !C.dead)
			if("chromosome" in C.mutations)
				C << "You don't feel anything strange."
				return
			if(C.clothes)
				if(istype(C:clothes, /obj/item/clothes/purificator) || C:clothes:nopsi)
					C << "\blue You're protected from infernostalinistic torment!"
					return
			spawn(0)
				C << "\red \bold OH MY PARTY THE PAIN"
				C.torment(6)
				if(prob(66))
					C.delirium += rand(5, 15)
				C.stun(7)
				C:chronodepr += 1
				C.chronoclock += 80
				C.damaga(5, "organ")
				C.damaga(5, "burn")
				C.damaga(5, "brute")
/datum/spell/drain
	name = "lifedraining sigil"
/datum/spell/drain
/datum/spell/drain/casting(mob/M)
	M << "\red You draw a sigil on the floor. Now touch it to make invisible and wait for some non-stalinist to run over!"
	var/D = new /obj/cult/drain(M:loc)
	last_cid++
	M:cid = last_cid
	D:cid = last_cid
	M:damaga(1, "organ")
/datum/spell/veteran
	name = "Sigilum Veteranum"
/datum/spell/veteran
/datum/spell/veteran/casting(mob/M)
	M << "\red You draw a summoning sigil on the floor. Now bring a dead body or 2 bodyparts/gibs here then touch the sigil. Brains are useless, alas."
	new /obj/cult/veteran(M:loc)
	M:damaga(10, "organ")
/datum/spell/stun
	name = "visions of Inferno"
/datum/spell/stun
/datum/spell/stun/casting(mob/M)
	if(cultstun_left)
		M << "\red You haunt your victim with the hellish mirage."
		cultstun_left--
		if(!cultstun_left)
			M << "\red \bold Stalinists can terrify people with visions of Inferno for no longer. Now you're on your own in the means of stun."
			return

		for(var/mob/MB in range(4, M))





			if(MB.dead == 0 && (MB.cult == 0 && MB.mat == "flesh"))
				if("chromosome" in MB.mutations)
					MB << "You don't feel anything strange."
				else if(MB:clothes:nopsi)
					MB << "\blue Your clothing protects you from being mindraped."
				else
					MB.calm -= 10
					MB.stun(10)
					MB << "\red You've seen enough shit, but THIS..."
		M:damaga(3, "organ")
	else
		M << "\red \bold You're unable to do it!"
/datum/spell/tentacle
	name = "Exotic matter horrors"
/datum/spell/tentacle
/datum/spell/tentacle/casting(mob/M)
	M << "\red You draw a summoning sigil on the floor. Now run as away as possible since it will spam exotic matter soon, devastating all around."
	new /obj/cult/tentacle(M:loc)
	M:damaga(10, "organ")

/proc/spell_roll()


	for(var/datum/spell/S in spells)
		S.sroll()
	spawn(0)
		for(var/datum/spell/S in spells)
			spawn(0) for(var/datum/spell/SP in spells)
				if(SP.spl == S.spl)
					S.sroll()

/mob/proc/knowledge_roulette()


	var/S = pick(spells)
	src << "\red You feel a rush of acknowledge and weird hallucinations for a second."
	src << ""
	src << ""
	src << "You're now knowing what <font color=blue>[S:name]</font> is <font color=blue>[S:spl]</font>"


/obj/item/tool/tracer
	plastic_need = 6
	silicon_need = 1
	name = "Tantric tracer"
	desc = "A tool able to draw sigils impassable by spectres and veterans alike. Drains you of euphoria, however."
	icon_state = "tracer"

/obj/item/tool/tracer


/obj/item/tool/tracer/attack_self(mob/M)




	for(var/obj/cult/penta/P in M:loc)
		if(P)
			return
	if(M:euphoria > -5)
		M << "\blue You draw a pentacle."
		M:euphoria -= 5
		new /obj/cult/penta(M:loc)
	else if(M:hepe > 5)
		M << "\red You feel too shitty to use it, so it'll use your blood to draw sigils."
		M:damaga(5, "organ")
		new /obj/cult/penta(M:loc)
	else
		M << "\red You feel too dysphoretic and is too damaged to use it."

/obj/banisher/New()




	src.banishround()

/obj/banisher/proc/banishround()


	for(var/mob/ghost/G in world)
		if(G.z == src.z)
			G.banish()

	for(var/mob/popobava/P in range(20, src))
		P.damaga(150, "brute")

	for(var/mob/stalin/S in range(25, src))
		S.show_message("\red \bold [src.name] is banished!")
		spawn(1)
			S.z = 2
			sleep(0)
			S.x = 5
			sleep(0)
			S.y = 5
			sleep(0)
			var/W = new /mob/ghost/wraith(S.loc)
			if(S.ckey)
				W:ckey = S.ckey
			W:name = "Shard of a Stalin's force"
			W:icon_state = "wraith2"
			spawn(0) del(S)

	for(var/obj/putin/P in range(20, src))
		P.fuckup()
		P.biodmg(50)

	for(var/obj/putin_big/P in range(20, src))
		P.biodmg(100)

	spawn(50)
		src.banishround()

/obj/item/tool/banisher
	icon = 'grafon/cult.dmi'
	size = 4
	plastic_need = 10
	metal_need = 10
	silicon_need = 5
	name = "Greater banishing sigil tracer"
	icon_state = "banisher_tool"
	desc = "A tool able to draw sigil which will devastate all demonic creatures around. Using it will cause horrible side-effects on user, but sometimes it is worth it."
/obj/item/tool/banisher
/obj/item/tool/banisher/attack_self(mob/M)
	if(prob(50))
		M << "\blue \bold It was a truly great sacrifice from you, man."
		M:damaga(500, "brute", 1)
	else
		M << "\blue \bold It was a great sacrifice from you, man."
		M:damaga(50, "brute", 1)
		M:calm -= 5
		M:euphoria -= 10
		M:epilepsy += 10
		M:chronodepr += 2
		M:delirium += 11
		if(prob(50))
			M:randommut()

	new /obj/banisher(M:loc)

/obj/item/tool/antighost
	icon = 'grafon/cult.dmi'
	name = "Spectre banisher"
	desc = "A weird device, it burns your skin, but banishes all spectres in range of ~30 meters (30 'turfs')."
	icon_state = "antighost"

/obj/item/tool/antighost
/obj/item/tool/antighost/attack_self(mob/M)
	M:damaga(20, "burn")
	M << "\red Damn, it burns, but at least you banish some lenindamn spectres from here."
	for(var/mob/ghost/MB in range(30))
		MB.banish()

/obj/item/tool/banisher_lesser
	icon = 'grafon/cult.dmi'
	name = "Automatic lesser banisher"
	icon_state = "lesser_banisher"
	desc = "This thing draws a lesser banishment pentagram using a drop of your blood. Be careful: sometimes it can wound you!"
/obj/item/tool/banisher_lesser
/obj/item/tool/banisher_lesser/attack_self(mob/M)
	M:damaga(3, "brute")
	M << "\red Damn, it hurts a bit."
	if(prob(5))
		M:wound()
	new /obj/cult/lesser_banish(M:loc)

/obj/structure/hellraiser/attack_hand()









	usr << "\red An eye for an eye, this thing only will work if it drains a bit of blood from you and you feed amoeba core to it."
	..()

/obj/structure/hellraiser/attack_by(atom/I)
	if(istype(I, /obj/item/amoebacore))
		usr.damaga(20, "organ", 0)
		spawn(0)
			del(I)
			src.summon()
	..()

/obj/structure/hellraiser/proc/summon()
	src.show_message("\red Hellraiser blurs for a while...")


	var/glist = list()
	for(var/mob/M in world)
		if(istype(M, /mob/ghost) || istype(M, /mob/ghostalike))
			if(M.ckey && !istype(M, /mob/ghost/observer))
				glist += M
	sleep(0)
	if(glist:len == 0)
		src.show_message("\red Looks like it can't find any active spirit-minds around.")
	else
		var/MB = pick(glist)
		MB:loc = src.loc
