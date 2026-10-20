/area{mouse_opacity = 0; icon = 'grafon/areas.dmi'}
/area/escape{luminosity = 1; sd_lighting = 0; icon_state = "escape"; name = "Escape arm"}
/area/light{luminosity = 1; sd_lighting = 0; icon_state = "light"}
/area/kurokoko{luminosity = 0; sd_lighting = 1}
/area/kurokoko/New()
	sd_LightLevel()
	..()

/mob/proc/spawn_light()
	new /obj/light_emitter(src.loc)

/mob/proc/spacize()
	src:loc:spacize()

/obj/light_emitter/New()
	..()
	sd_SetLuminosity(3)
/obj/overlay/doormelt{icon = 'grafon/door.dmi'; icon_state = "doormelt"}
/obj/overlay/moustacheless{icon = 'grafon/player.dmi'; icon_state = "moustacheless"}
/obj/overlay/antiabyss{layer = 6; mouse_opacity = 0; icon = 'floor.dmi'; name = "Abyss supression"; icon_state = "abyss_glow"; var/master}
/obj/overlay/hach{icon = 'grafon/face_overlays.dmi'; icon_state = "brove"}
/obj/overlay/baryga{icon = 'grafon/mutations.dmi'; icon_state = "baryga"}
/obj/overlay/plant{icon = 'grafon/plant.dmi'}
/obj/overlay/bike
/obj/overlay/mutation{icon = 'grafon/mutations.dmi'}
/obj/overlay/collar
/obj/overlay/tube
/obj/overlay/signiter{icon = 'grafon/item/gas.dmi'; icon_state = "overlay_signiter"};/obj/overlay/gaylight{layer = 6; mouse_opacity = 0; icon = 'floor.dmi'; name = "Glow"; icon_state = "glow"}
/obj/overlay/gaylight/New()
	src.sd_SetLuminosity(3)
	spawn(2) del(src)

/obj/glower/New()

















	src.sd_SetLuminosity(3)
	for(var/turf/T in range(2, src))
		var/A = new /obj/overlay/anchlight(T)
		A:master = src

/obj/glower/attack_by(obj/I)
	if(istype(I, /obj/item/reagent_container/cig))
		var/C = I
		C:smoke(usr)

/obj/glower/attack_hand()
	if(prob(90))
		if(usr.heatprotect <= 5 && usr.energyprotect <= 5)
			if(prob(90))
				usr << "\red You touch [src.name] and it burns you a bit."
				usr.damaga(1, "burn")
			else
				usr << "\red \bold You touch [src.name] and it burns as thousand Eternal flames!"
				usr.damaga(40, "burn")
				if(prob(50))
					usr.randommut()
		else
			usr << "\blue [src.name] is warm on touch."

/obj/glower/Move(NewLoc, Dir = 0, step_x = 0, step_y = 0)
	..()
	for(var/obj/overlay/anchlight/A in range(3, src))
		if(A.master == src)
			del(A)
	for(var/turf/T in range(2, src))
		var/obj/overlay/anchlight/A = new /obj/overlay/anchlight(T)
		A:master = src



/obj/overlay/anchlight
	layer = 6
	mouse_opacity = 0
	icon = 'floor.dmi'
	name = "Glow"
	icon_state = "glow"
	var/master = null
