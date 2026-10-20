/obj/tick
/obj/bio{icon = 'grafon/plant.dmi'}
/obj/anti{icon = 'grafon/thingy.dmi'; icon_state = "anti"; name = "Membrane burner"}
/obj/comp
/obj/wire
/obj/triwire
/obj/cult{layer = 2.3; icon = 'grafon/cult.dmi'}
/obj/banisher{icon = 'grafon/cult.dmi'; name = "Greater Banishing Pentagram"; icon_state = "banishing"}
/obj/clight{layer = 5; mouse_opacity = 0; icon = 'grafon/mask.dmi'; icon_state = "red_trans"}
/obj/bike
/obj/eye;/obj/observ_ring{icon = 'grafon/perun.dmi'; name = "Observation sigil"; icon_state = "ghost"; desc = "Some ghosts use it to observe the station complex better."};/obj/psi_poebota{icon = 'player/start.dmi'; icon_state = "putin"};/obj/seal;/obj/psistorm{pixel_x = -32; pixel_y = -32; luminosity = 1; icon = 'grafon/perun.dmi'; icon_state = "psi"; name = "psionic storm"; alticon = "psi1"; desc = "A material projection of the collective egregore of every cognitologist alive in the local sector of Multiverse."};/obj/delusion{layer = 2.1; icon = null /*icon id 75: unresolved*/; icon = 'grafon/hud_effects.dmi'; name = "delusion"; desc = "A small rift between realities."};/obj/putin;/obj/putin_big;/obj/teleporter;/obj/onewaytele{icon = 'door.dmi'; icon_state = "tele"; name = "One-way teleporter"};/obj/onewaytele{wrenchable = 1};/obj/shoggoth;/obj/machinery/warper{density = 1; icon = 'grafon/structure.dmi'; desc = "A mysterious antique machine with kinda unpredictable properities"; icon_state = "warper"; var/powah = 10; var/maxpowah = 100; var/obj/droppoint = null; var/powus = 20; var/drnr = 3}
/obj/machinery/warper/proc/warp()
	if(!src.droppoint)

		return
	for(var/atom/movable/A in range(1 + round(src.powus / 20), src))
		if(prob(66))
			new /obj/effect/warp_splash(A.loc)
		var/blinklist = list()
		if(A != src)
			for(var/turf/T in range(1 + round(src.powus / 20), src.droppoint))
				if(!istype(T, /turf/rock))
					blinklist += T
			if(blinklist:len)
				var/S = blinklist[rand(1, blinklist:len)]
				A.loc = S
	for(var/turf/floor/F in range(src.powus / 5, src))
		if(prob(5))
			new /turf/floor/base(F)
/obj/machinery/warper/verb/button()
	set name = "press the big red button"
	set src in view(1)
	if(!src.droppoint)
		usr << "\red ÅÃÃÎÃ: no drop point found!"
	else if(src.droppoint in range(src.powus / 2.5, src))
		usr << "\blue BEEEEEP"
		spawn(0) src.warp()
	else
		usr << "\red ÅÃÃÎÃ: power usage is too low!"
		return
/obj/machinery/warper/verb/checkpower()
	set name = "check warper powerlevel"
	set src in view(1)
	usr << "\blue [powah] energy points"
/obj/machinery/warper/verb/drain()
	set name = "drain power from nearby sources"
	set src in view(1)
	for(var/obj/wire/W in range(src.drnr, src))
		if(src.maxpowah - src.powah > 0)
			if(src.maxpowah - src.powah > W.energy)
				src.powah += W.energy
				W.energy = 0
			else
				W.energy -= src.maxpowah - src.powah
				src.powah = src.maxpowah
		else
			usr << "\red Warper is already fully loaded!"
		spawn(0)
			for(var/obj/structure/battery/B in range(src.drnr, src))
				if(src.maxpowah - src.powah > 0)
					if(src.maxpowah - src.powah > B.energy)
						src.powah += B.energy
						B.energy = 0
					else
						B.energy -= src.maxpowah - src.powah
						src.powah = src.maxpowah
			spawn(0)
				for(var/obj/item/battery/BR in range(src.drnr, src))
					if(src.maxpowah - src.powah > 0)
						if(src.maxpowah - src.powah > BR.energy)
							src.powah += BR.energy
							BR.energy = 0
						else
							BR.energy -= src.maxpowah - src.powah
							src.powah = src.maxpowah
/obj/machinery/warper/verb/drainrange()
	set name = "set power draining range"
	set src in view(usr, 1)
	drnr = input("Please, set powerdrain range:", "current draining range is [drnr]", drnr) in list(1, 2, 3, 4, 5)
/obj/machinery/warper/verb/warppower()
	set name = "set warper power usage"
	set src in view(usr, 1)
	powus = input("Please, set warper power usage:", "current power usage is [powus]", powus) in list(5, 10, 15, 20, 25, 50, 100)
/obj/machinery/warper/verb/droppoint()
	set name = "set droppoint"
	set src in view(1)
	var/drop_x = input("Inputing droppoint X", "", 0) in list(-20, -15, -10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20)
	var/drop_y = input("Inputing droppoint Y", "", 0) in list(-20, -15, -10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20)
	for(var/turf/T in world)
		if(T.x == src.x + drop_x && (T.y == src.y + drop_y && T.z == src.z))
			src.droppoint = T
/obj/effect/rhinestones
/obj/effect/rhinestones
/obj/effect/warp_splash
	icon_state = "warp_splash"
/obj/effect/warp_splash/New()
	..()
	spawn(10) del(src)

