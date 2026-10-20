// Recovered from compiled neek.dmb (7 procs)

/client/proc/observe_mob(mob/M in world)
	set category = "Pedal"
	src.perspective = 1
	eye = M

/client/proc/observe_target(obj/T in world)

	set category = "Pedal"
	src.perspective = 1
	src.eye = T:loc

/mob/ghostalike
	casts_shadow = 0
	icon_state = "observer"

/mob/eye
	invisibility = 101
	candofun = 0
	canpull = 0
	candofun = 0
	canstrip = 0
	canspeak = 0
/mob/eye

/mob/eye/New()
















	src.verbs -= powahs
/obj/eye/orb{icon = null /*icon id 35: unresolved*/; icon = 'grafon/item.dmi'; name = "crystal orb"; icon_state = "orb_eye"; var/evil = 0}
/obj/eye/orb/wicked{evil = 1; name = "black orb"; icon_state = "orb_eye_evil"}
/obj/eye/orb/Click()


	if(usr.mat == "ether" || ((usr.cult == 1 || usr.abyss == 1) && usr.mat == "flesh" || usr.mat == "plastic"))
		if(usr.mat == "plastic")
			usr << "\blue \bold You use your connector port to interract with this weird device."
		switch(alert("What do you wanna observe?", , "Mob", "Place", "Permanent observing"))
			if("Mob")
				var/list/L = new()
				for(var/mob/M in world)
					L.Add(M)
				var/targmob = input("") in L
				if(usr.client)
					usr.client.observe_mob(targmob)
			if("Place")
				var/list/LT = new()
				for(var/obj/eye/target/T in world)
					LT.Add(T)
				var/targt = input("") in LT
				if(usr.client)
					usr.client.observe_target(targt)
			if("Permanent observing")
				if(usr.dead)
					for(var/turf/floor/start/S in world)
						usr.loc = S
						usr.invisibility = 101
						usr.opacity = 0
						usr.canpull = 0
						usr.candofun = 0
						usr.canstrip = 0
						usr.canspeak = 0
						usr.client.verbs -= /client/proc/darkness

		if(usr.mat == "flesh" && src.evil == 1)
			usr << "\red You feel drained a bit."
			usr.damaga(6, "organ")
	else
		usr << "\red You don't know what to do with this thingy."

/mob/ghost/observer
	canpull = 0
	canstrip = 0
	canspeak = 0
	candofun = 0
	dead = 1
	mov_speed = -3
	name = "Ghasty Observer"
	desc = "This thing looks harmless, but purificator probably will not like its presence."
	icon_state = "observer"
/mob/ghost/observer

/mob/ghost/observer/New()






	spawn(5)
		src.verbs -= powahs
		spawn(0) src.view_fuck()
/mob/ghost/observer/proc/view_fuck()
	if(src.client)
		if(prob(15))
			src << "\red \bold Your perception distorts!"
			if(src.client.view == src.client.true_view)
				src.client.view = src.client.true_view - 3
			else
				src.client.view = src.client.true_view
	spawn(20) src.view_fuck()




/mob/ghostalike

/obj/observ_ring/Click()


	if(usr.mat == "ether" && !istype(usr, /mob/ghost/observer))
		src << "\blue You enter the midgard as an observer."
		var/S
		for(var/turf/floor/start/ST in world)
			S = ST
		var/G = new /mob/ghost/observer(S)
		G:traitor = usr:traitor
		G:objective1 = usr.objective1
		G:objective2 = usr.objective2
		G:ckey = usr.ckey
		G:realkey = usr.realkey
		G:realname = usr.name
		if(G:client)
			G:client:verbs -= /client/proc/darkness
			G:client:verbs += /client/proc/darkness_lesser
		spawn(0)
			src.verbs -= powahs
		spawn(0) G:name = pick("[usr.realname]'s Ghasty Observer", "[usr.realname]'s Observation Spectre", "[usr.realname]'s Seeking Spectre", "[usr.realname]'s Spiritual Observer", "[usr.realname]'s Lurking Spectre")
	else
		usr << "\red \bold Your body refuses to contact with this weird sigil."
