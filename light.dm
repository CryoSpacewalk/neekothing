// Recovered from compiled neek.dmb (18 procs)

/proc/sd_SetDarkIcon(icon, shades)








































































































































































































































































































































































































































	sd_dark_icon = icon
	sd_dark_shades = shades

	for(var/area/A in world)
		if(A.sd_darkimage) A.sd_LightLevel(A.sd_light_level, 0)

/atom/New()




	..()

	if(!isarea(src) && src.luminosity > 0)
		spawn(1)
			src.sd_ApplyLum()

/atom/Del()


	if(!isarea(src) && src.luminosity > 0)
		src.sd_StripLum()
	..()



/atom/proc/sd_ApplyLum(V = view(src.luminosity, src), center = src)
	if(src.luminosity > sd_top_luminosity)
		sd_top_luminosity = src.luminosity

	for(var/turf/T in V)


		T.sd_lumcount += src.luminosity - get_dist(center, T)









		T.sd_LumUpdate()


/atom/proc/sd_StripLum(V = view(src.luminosity, src), center = src)

	for(var/turf/T in V)


		T.sd_lumcount -= src.luminosity - get_dist(center, T)










		T.sd_LumUpdate()


/atom/proc/sd_ApplyLocalLum(affected = view(sd_top_luminosity, src))

	for(var/atom/A in affected)
		if(A.luminosity) A.sd_ApplyLum()

/atom/proc/sd_StripLocalLum()













	var/affected = list()
	for(var/atom/A in view(sd_top_luminosity, src))
		var/turfflag = isturf(src) ? 1 : 0
		if(A.luminosity && get_dist(src, A) <= A.luminosity + turfflag)
			A.sd_StripLum()
			affected += A







	return affected

/atom/proc/sd_SetLuminosity(new_luminosity as num)






	if(luminosity > 0)
		sd_StripLum()
	luminosity = new_luminosity
	if(luminosity > 0)
		sd_ApplyLum()

/atom/proc/sd_SetOpacity(new_opacity as num)







	if(src.opacity == (new_opacity ? 1 : 0)) return
	var/list/affected, atom/A, turf/T, turf/ATurf

	affected = new /list()





	affected = new /list()
	for(A in range(sd_top_luminosity, src))
		T = A
		while(T && !istype(T)) T = T.loc
		if(T)
			var/list/V = view(A.luminosity, T)
			if(!(src in V)) continue
			var/turfflag = 0
			if(A == T) turfflag = 1
			if(A.luminosity && get_dist(A, src) <= A.luminosity + turfflag)
				affected[A] = V



	src.opacity = new_opacity
	if(src.opacity)
		for(A in affected)
			ATurf = A
			while(ATurf && !istype(ATurf)) ATurf = ATurf.loc
			if(ATurf)
				for(T in affected[A] - view(A.luminosity, ATurf))
					T.sd_lumcount -= A.luminosity - get_dist(A, T)









					T.sd_LumUpdate()
	else


























		for(A in affected)
			ATurf = A
			while(ATurf && !istype(ATurf)) ATurf = ATurf.loc
			if(ATurf)
				for(T in view(A.luminosity, ATurf) - affected[A])
					T.sd_lumcount += A.luminosity - get_dist(A, T)





					T.sd_LumUpdate()

/atom/proc/sd_NewOpacity(new_opacity)

























	if(src.opacity != new_opacity)
		var/affected = src.sd_StripLocalLum()
		src.opacity = new_opacity
		var/T = src
		while(T && !isturf(T))
			T = T:loc
		if(T)
			T:sd_lumcount = 0


		src.sd_ApplyLocalLum(affected)

/turf/proc/sd_LumReset()















	var/affected = src.sd_StripLocalLum()
	src.sd_lumcount = 0




	src.sd_ApplyLocalLum(affected)

/turf/proc/sd_LumUpdate()

	set background = 1
	var/Loc = src.loc
	if(!istype(Loc, /area) || !Loc:sd_lighting) return




	var/light = min(max(src.sd_lumcount, 0), sd_dark_shades)
	var/ltag = copytext(Loc:tag, 1, findtext(Loc:tag, "sd_L")) + "sd_L[light]"


	if(Loc:tag != ltag)
		var/A = locate(ltag)
		if(!A)
			A = new Loc:type()
			A:tag = ltag



			for(var/V in Loc:vars - "contents")
				if(issaved(Loc:vars[V])) A:vars[V] = Loc:vars[V]






			A:tag = ltag








			A:sd_LightLevel(light)



		A:contents += src

/atom/movable/Move()



















































	var/oldloc = src.loc

	var/oldview
	if(src.luminosity > 0)
		if(isturf(src.loc))
			oldview = view(src.luminosity, src.loc)
		else
			oldview = list()


	. = ..()







	if(. && src.luminosity > 0)

		if(istype(oldloc, /turf))
			src.sd_StripLum(oldview, oldloc)
			oldloc:sd_lumcount++
		src.sd_ApplyLum()

/area/dark
	luminosity = 0

/area/dark


















/area/proc/sd_LightLevel(slevel = src.sd_light_level as num, keep = 1)
	if(!src) return
	src.overlays -= src.sd_darkimage


	if(keep) src.sd_light_level = slevel


	slevel = min(max(slevel, 0), sd_dark_shades)


	if(slevel > 0)
		src.luminosity = 1
	else
		src.luminosity = 0


	src.sd_darkimage = image(sd_dark_icon, , num2text(slevel), sd_light_layer)
	src.overlays += src.sd_darkimage

/area/proc/sd_New(sd_created)

















	if(!tag) tag = "[type]"
	spawn(1)
		if(sd_lighting)

			if(!sd_created)


				sd_LightLevel()











/mob/sd_ApplyLum(V, center = src)
	if(!V)
		if(isturf(src.loc))
			V = view(src.luminosity, src.loc)
		else
			V = view(src.luminosity, src)
	. = ..(V, center)


/mob/sd_StripLum(V, center = src)
	if(!V)
		if(isturf(src.loc))
			V = view(src.luminosity, src.loc)
		else
			V = view(src.luminosity, src)
	. = ..(V, center)

/mob/sd_ApplyLocalLum(affected)

	if(!affected)
		if(isturf(src.loc))
			affected = view(sd_top_luminosity, src.loc)
		else
			affected = view(sd_top_luminosity, src)
	. = ..(affected)

var/sd_dark_icon = 'ss13_dark_alpha7.dmi'
var/sd_dark_shades = 7
var/sd_light_layer = 10
var/sd_light_outside = 0
var/sd_top_luminosity = 0