// Recovered from compiled neek.dmb (10 procs)

/datum/reagent/proc/on_turf(turf/T, hawt)












	for(var/datum/on_turf/R in on_turf_avaible)
		if(src.id == R.rid)
			R.react(src, T, hawt)

/datum/on_turf
	var/rid = "nothing to see here, folks"
/datum/on_turf/proc/react(R, turf/T, hawt)
	world << "\red <font size = 5>ON_TURF IS BROKEN, HURR DURR</font>"
/datum/on_turf/chlorine
	rid = "chlorine"
/datum/on_turf/chlorine
/datum/on_turf/chlorine/react(R, turf/T, hawt)
	if(T:density)
		return
	var/howmany = 0
	if(R:amount >= 3)
		howmany = round(R:amount / 3)
	else if(R:amount >= 2.8)
		howmany = 1
	spawn(0)
		for(, howmany > 0, howmany--)
			var/C = new /obj/cloud/prespawned(T)
			C:temp = hawt
			spawn(0) howmany -= 1
/datum/on_turf/regenerite
	rid = "regenerite"
/datum/on_turf/regenerite
/datum/on_turf/regenerite/react(R, turf/T, hawt)
	if(T:density)
		return
	var/howmany = 0
	if(R:amount >= 3)
		howmany = round(R:amount / 3)
	else if(R:amount >= 2.8)
		howmany = 1
	spawn(0)
		for(, howmany > 0, howmany--)
			var/C = new /obj/cloud/regenerite(T)
			C:temp = hawt
			spawn(0) howmany -= 1
/datum/on_turf/antidote
	rid = "antidote"
/datum/on_turf/antidote
/datum/on_turf/antidote/react(R, turf/T, hawt)
	if(T:density)
		return
	var/howmany = 0
	if(R:amount >= 3)
		howmany = round(R:amount / 3)
	else if(R:amount >= 2.8)
		howmany = 1
	spawn(0)
		for(, howmany > 0, howmany--)
			var/C = new /obj/cloud/antidote(T)
			C:temp = hawt
/datum/on_turf/toxin
	rid = "toxin"
/datum/on_turf/toxin
/datum/on_turf/toxin/react(R, turf/T, hawt)
	if(T:density)
		return
	var/howmany = 0
	if(R:amount >= 3)
		howmany = round(R:amount / 3)
	else if(R:amount >= 2.8)
		howmany = 1
	spawn(0)
		for(, howmany > 0, howmany--)
			var/C = new /obj/cloud/toxin(T)
			C:temp = hawt
			spawn(0) howmany -= 1
/datum/on_turf/fuel
	rid = "fuel"
/datum/on_turf/fuel
/datum/on_turf/fuel/react(R, turf/T, hawt)
	if(T:density)
		return
	var/howmany = 0
	if(R:amount >= 3)
		howmany = round(R:amount / 3)
	else if(R:amount >= 2.8)
		howmany = 1
	spawn(0)
		for(, howmany > 0, howmany--)
			var/C = new /obj/cloud/fuel(T)
			C:temp = hawt
			spawn(0) howmany -= 1
/datum/on_turf/aqua_regia
	rid = "aqua regia"
/datum/on_turf/aqua_regia
/datum/on_turf/aqua_regia/react(R, turf/T, hawt)
	if(istype(T, /turf/floor))
		if((istype(T, /turf/floor/base) || istype(T, /turf/floor/icy)) && R:amount >= 30)
			for(var/mob/M in view(T))
				M << "[T] melts!"
			spawn(0) T:spacize()
		else if(istype(T, /turf/floor) && (T:bombable && !istype(T, /turf/floor/start)))
			if(R:amount >= 30)
				for(var/mob/M in view(T))
					M << "[T] melts!"
					if(prob(10))
						for(var/turf/wall/W in range(1, T))
							if(prob(10 + min(round(R:amount / 2), 15)) && !istype(T, /turf/wall/brick))
								W:show_message("[W] covering melts!")
								spawn(0) W:remove_without_mat()
				spawn(0) T:spacize()
			else if(R:amount >= 10)
				for(var/mob/M in view(T))
					M << "[T] covering melts!"
				spawn(0) new /turf/floor/base(T)
	else if(istype(T, /turf/wall) && (R:amount >= 30 && !istype(T, /turf/wall/brick)))
		var/W = T
		W:remove_without_mat()
/datum/on_turf/polytrinic_acid
	rid = "polytrinic acid"
/datum/on_turf/polytrinic_acid
/datum/on_turf/polytrinic_acid/react(R, turf/T, hawt)
	if(istype(T, /turf/floor) && T:bombable)
		if((istype(T, /turf/floor/base) || istype(T, /turf/floor/icy)) && R:amount >= 8)
			for(var/mob/M in view(T))
				M << "[T] melts!"
			spawn(0) T:spacize()
		else if(istype(T, /turf/floor) && !istype(T, /turf/floor/start))
			if(R:amount >= 12)
				for(var/mob/M in view(T))
					M << "[T] melts!"
				spawn(0) T:spacize()
			else if(R:amount >= 5)
				for(var/mob/M in view(T))
					M << "[T] covering melts!"
		if(prob(33 + round(R:amount / 5)))
			for(var/turf/wall/W in range(1, T))
				if(prob(33) && !istype(T, /turf/wall/brick))
					W:show_message("[W] covering melts!")
					spawn(0) W:remove_without_mat()
			spawn(0) new /turf/floor/base(T)
	else if(istype(T, /turf/wall) && (R:amount >= 15 && !istype(T, /turf/wall/brick)))
		var/W = T
		W:remove_without_mat()
/datum/on_turf/rhinestones
	rid = "rhinestones"
/datum/on_turf/rhinestones
/datum/on_turf/rhinestones/react(R, turf/T, hawt)
	var/isstones = 0
	for(var/obj/effect/rhinestones/RS in T)
		if(RS)
			isstones = 1
	if(!isstones)
		new /obj/effect/rhinestones(T)

