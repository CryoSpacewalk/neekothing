/client/var/op_camera
/client/var/build_mode = 0
/client/proc/enter_build_mode()
	set category = "Debug"
	usr << "build mode = [!build_mode], show popup menus = [!show_popup_menus]"
	build_mode = !build_mode
	show_popup_menus = !show_popup_menus

/client/Click(object, location, control, params)
	if(build_mode)
		return build_mode_click(object, location, control, params)
	else
		..(object, location, control, params)

/client/DblClick(object, location, control, params)
	if(build_mode)
		return build_mode_click(object, location, control, params)
	else
		..(object, location, control, params)

/client/proc/build_mode_click(atom/object, location, control, params)

	var/parameters = params2list(params)

	if(isobj(object))
		if(parameters["left"])
			new /obj/effect/sparks(object:loc)
			return
		if(parameters["right"])
			del(object)
			return
		return
	if(ismob(object))
		if(parameters["left"])
			object:heal(100, "burn")
			object:heal(100, "brute")
			object:heal(100, "organ")
			usr << "\blue Healed [object]"
			return
		if(parameters["right"])
			new /obj/effect/blood_splash(object:loc)
			object:damaga(20, "brute")
			if(object)
				usr << "\red [object].hepe: [object:hepe]"
			return
		return
	if(isturf(object))
		if(parameters["left"])
			if(istype(object, /turf/space))
				usr << "Created a new floor tile."
				new /turf/floor/regular(object)
				return
			if(istype(object, /turf/floor))
				usr << "Created a new wall."
				new /turf/wall(object)
				return
			if(istype(object, /turf/wall))
				new /obj/effect/sparks(object)
				return
			return
		if(parameters["right"])
			if(istype(object, /turf/space))
				new /obj/effect/sparks(object)
				return
			if(istype(object, /turf/floor))
				usr << "Spacized the floor."
				object:spacize()
				return
			if(istype(object, /turf/wall))
				usr << "Dismantled the wall."
				object:remove()
				return
			return
		return