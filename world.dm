var/list/possibcure = list("manganeska", "mangadote", "iron", "stalkotoxin", "pogankeepeptide", "ethanol", "fuel", "glycerol", "haloperidol")

var/list/random_chem = list()
var/disallow_kypa = 0
var/playernum = 0
/world{name = "neek"; mob = /mob/new_player; area = /area/dark/space; view = 7; tick_lag = 0.3}
/client{preload_rsc = 0}
/proc/probcount()

	var/i = 1
	var/fixpro = 0.0005
	var/pro = fixpro
	var/lastpro = fixpro
	while(i < playernum)
		i++
		pro += fixpro * (1 - lastpro)
		lastpro = pro
		world.log << "prob ([i]): [pro]"
		sleep(0)

/mob/proc/counttraitors()




	var/i = 1
	var/fixpro = 0.01
	var/pro = fixpro
	var/lastpro = fixpro
	while(i < playernum)
		i++
		pro += fixpro * (1 - lastpro)
		lastpro = pro
		sleep(0)
	src << "\blue \italic \bold Current probablity of at least a single capitalistic intervent existing around station complex: <font color = red>[pro * 100]%</font>"
	src << ""

	if(playernum > 1)

		i = 1
		fixpro = 0.005
		var/secpro = fixpro
		lastpro = fixpro

		while(i < playernum)
			i++
			secpro += fixpro * (1 - lastpro)
			lastpro = secpro
			sleep(0)

		src << "\blue \italic \bold Current probablity of a pair of capitalistic intervents existing around station complex: <font color = red>[pro * secpro * 100]%</font>"
		src << ""

	src << "\blue \italic \bold Current probablity of an abyssal baryga trading illegal drugs and pharmacy around station complex: <font color = red>[rand(5, 45) + rand(baryga * 1, baryga * 40)]%</font> (information may be somewhat incorrect)"

/world/New()











	src.log = file("runtimez.txt")
	src.name = pick("", "A Horrific ", "Stationary ", "Bloody ", "Full Of Fish ", "Disco-style ") + pick("", "Communist ", "Red Alert ", "Old-style ") + pick("Station ", "Outpost ", "Research Facility ", "Sputnik ") + pick("[rand(0, 100)]", "Zion", "Druzhba", "Mir", "\"Roostervill\"", "Goolag")
	for(var/obj/bio/pogankeespawn/PS in src)
		if(prob(50))
			continue
		else if(prob(25))
			new /obj/bio/pogankah(PS.loc)
		else if(prob(33))
			new /obj/bio/pogankah/regeneshroom(PS.loc)
		else if(prob(50))
			new /obj/bio/pogankah/psilo(PS.loc)
		else if(prob(60))
			new /obj/bio/pogankah/lepista(PS.loc)
		else if(prob(66))
			new /obj/bio/sponge(PS.loc)
		else
			new /obj/bio/pogankah/killer(PS.loc)
	omsk_gen()
	bary_gen(rand(20, 35))
	spell_roll()
	morph_gen()
	gen_memes()
	eventselect()
	darknet_name = "<b>[pick("Hidden", "Shadow", "Unseen", "Invisible", "Black")] [pick("Maidan", "Agora", "Market", "Shop")]</b>"
	aidscure = pick(possibcure)
	var/ef1 = pick("damage", "kill", "heal", "strong heal", "nothing")
	var/ef2 = pick("stun", "heavy stun", "infection", "itch", "tele", "heavy tele", "nothing", "nothing")
	var/ef3 = pick("rad", "heavy rad", "feed", "dust", "scream", "chaos", "purge", "nothing", "nothing")
	random_chem.Add(ef1)
	random_chem.Add(ef2)
	random_chem.Add(ef3)
	for(var/turf/t in world)
		turfs[t.x][t.y][t.z] = t

/client/Stat()
	if(pedal)
		statpanel("Status", , "tick lag: [world.tick_lag]")

		statpanel("Status", , "Coordinates: [mob.x],[mob.y],[mob.z]")
		statpanel("Status", , "Playmuzon: [playmuzlo]")

	if(mob)
		statpanel("Status", , "CPU usage: [world.cpu]")
		if(mob.abyss >= 0)
			statpanel("Status", , "Abyssal points: [mob.abyss]")

var/list/clients = new/list()
var/list/mobs = new/list()
var/list/turfs[90][90][10]
