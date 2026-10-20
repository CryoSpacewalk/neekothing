// Recovered from compiled neek.dmb (2 procs)

/obj/overlay/bike/jetbike
	layer = MOB_LAYER + 0.9
	icon = 'grafon/thingy.dmi'
	// ^ icon match was partial
	icon_state = "jetbike_overlay"

/obj/overlay/bike/vessel
	layer = 4.9
	icon = 'grafon/thingy.dmi'
	// ^ icon match was partial
	icon_state = "voronok_overlay"

/obj/bike
	density = 1
	icon = 'grafon/thingy.dmi'
	// ^ icon match was partial
	var/OL
	var/boost = 1
	var/tantric = 0
	anchored = 0

/obj/bike/verb/unmount()



















	if(src == usr.mount)
		set name = "Unmount your transport (jetbike or other)"
		set category = "Machinery"
		usr.overlays -= src.OL


		usr.mount:loc = usr.loc

		spawn(0)
			usr.mount = null




/obj/bike/attack_hand()

	if(!usr.candofun)
		usr << "\red NO"
		return
	if(usr.hepe <= 20)
		usr << "\red \bold You're too weak and wounded to drive!"
		return
	if(!usr.mount)
		usr.mount = src
		src.loc = usr
		usr.overlays += src.OL


/obj/bike/jetbike
	tantric = 1












	OL = new /obj/overlay/bike/jetbike
	name = "'Ural' tantric jetbike"
	desc = "A fast and unstable thing for those tired of walkin'. It protects you from dangers of effects due how much Hindu pantheon power it collects. It is also will go faster if you're on euphoretics, jerking off or fucking while driving. I'm serious."
	icon_state = "jetbike"

/obj/bike/vessel
	boost = 2
	OL = new /obj/overlay/bike/vessel
	name = "'Jigulee' microship"
	icon_state = "voronok"
	desc = "A funny-looking jet engine designed for one person. While slower against drugged jetbikers, this thing is still able to move faster than a man and protects you from effects of space."
