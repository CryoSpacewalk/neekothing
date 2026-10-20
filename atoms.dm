// Recovered from compiled neek.dmb (26 procs)
/atom/var/anchored = 1
/atom
/obj
/obj/proc/process()
	return

/atom/proc/attack_hand(mob/user)
	return

/atom/proc/attack_by(obj/item, mob/user)
	return

/atom/proc/after_attack(A as mob|obj|turf, mob/user)
	return

/obj/proc/attack(atom/A, mob/user)
	return

/obj/proc/attack_self(mob/user)
	return

/atom/proc/attack_bezrukim(mob/user)
	return





var/delay = 10
/atom/Click(location, control, params)
	var/parameters = params2list(params)

	if(parameters["shift"])
		if(!isarea(src))
			src:examine()
		return

	if(parameters["middle"])
		usr.swap_hands()
		return

	if(parameters["Northeast"])
		usr.swap_hands()
		return






	if(parameters["ctrl"])
		if(istype(src, /atom/movable))
			if(src == usr.pulling)
				src:break_pull()
			else
				src:pullit()
			return

	if(src.x && (src.y && (usr.x && usr.y)))
		var/dx = src.x - usr.x
		var/dy = src.y - usr.y
		if(dy > 0 && abs(dx) < dy)
			usr.dir = 1
		if(dy < 0 && abs(dx) < abs(dy))
			usr.dir = 2
		if(dx > 0 && abs(dy) <= dx)
			usr.dir = 4
		if(dx < 0 && abs(dy) <= abs(dx))
			usr.dir = 8
		if(dx == 0 && dy == 0)
			if(src.pixel_y > 16)
				usr.dir = 1
			if(src.pixel_y < -16)
				usr.dir = 2
			if(src.pixel_x > 16)
				usr.dir = 4
			if(src.pixel_x < -16)
				usr.dir = 8

	if(world.time - usr.last_click < delay)
		return

	if(isghost(usr))
		return

	var/in_range = get_dist(usr, src)
	if(in_range <= 1 || src.loc == usr)
		in_range = 1
	else
		in_range = 0

	usr.last_click = world.time

	if(usr.client.operat)
		src.operate(usr.client.opwire)

	if(usr.item && (!(usr.stunned || usr.parastunned) && usr.check_limb("[usr.hand == 0 ? "r" : "l"]_hand")))

		if(usr.throw_mode && !(src in range(1, usr)))
			usr.throw_item(src)

		if(isobj(src))
			if(src == usr.item)
				return usr.item:attack_self(usr)
			else
				if(in_range)
					src.attack_by(usr.item, usr)
					if(usr.item)
						usr.item:attack(src, usr)
				else
					usr.item:after_attack(src, usr)
				return
		if(ismob(src) || isturf(src))
			if(in_range)
				src.attack_by(usr.item, usr)
				if(usr.item)
					usr.item:attack(src, usr)
			else if(src in range(usr.psi_radius))
				src.attack_by(usr.item, usr)
				if(usr.item)
					usr.item:attack(src, usr)
					new /obj/effect/warp_splash(src.loc)
			else if(usr.item:warpy && src in range(3, usr))
				src.attack_by(usr.item, usr)
				if(usr.item)
					usr.item:attack(src, usr)
					new /obj/effect/warp_splash(src.loc)
			else
				usr.item:after_attack(src, usr)
			return
		else
			return
	else
		if(!isarea(src))
			if(in_range || (src in range(usr.psi_radius)))
				if(usr.check_limb("[usr.hand == 0 ? "r" : "l"]_hand"))
					return src.attack_hand(usr)
				else
					return src.attack_bezrukim(usr)
			else
				return

/atom/movable/var/nopull = 0

/atom/movable



/atom/movable/verb/pullit()
	set src in oview(1)
	if(src.anchored || (src.nopull || !usr.canpull))
		return
	usr.pulling = src
	usr << "Now pulling: [usr.pulling]"

/atom/movable/verb/break_pull()
	if(usr.pulling)
		usr.pulling = null
		return
	else
		usr << "\red You aren't pulling anything!"
		return

/mob



/mob/var/last_click = 0
/mob/var/last_move = 0
/mob/var/pulling
/mob/var/tieobj
/mob/var/mov_speed = 1
/mob/var/tie_delay = 50
/mob/var/tie_last_used = -50
/mob/Move(direction)
	if(!can_move)

		if(wired)
			if(world.time - tie_last_used < tie_delay)
				src << "\red You're already trying to untie yourself!"
				return
			show_message("\red [name] tries to remove the tying!", "You try to free yourself!")
			if(prob(2))
				show_message("\red [name] removes the tying!", "\blue You try to free yourself!")
				untie()
			tie_last_used = world.time
		return 0

	if(istype(loc, /obj/structure/container))
		for(var/obj/structure/container/C in src.loc:loc)
			if(C.welded == 0)
				C.opclose()





































	var/speedy = world.tick_lag * (4 - mov_speed) + !check_limb("r_leg") + !check_limb("l_leg")

	if(mount)

		var/iseupho = 10

		if(src.mount:tantric)
			iseupho = euphoria

		speedy = world.tick_lag * 4 / (mount:boost + iseupho / 10)

	if(world.time - last_move < speedy)
		return 0
	else
		last_move = world.time
		var/prevloc = src.loc
		if(ckey)
			src.client.eye = src
		if(pulling)
			if(!(pulling in oview(src, 1)) || !isturf(src.pulling:loc))
				pulling = null
		..(direction)

		if(prob(7 + drunk * 5 + thrill * 5))
			playsound(pick('sounds/footstep1.wav', 'sounds/footstep2.wav'))

			if(!sleeps)
				if(prob(distortion))
					src.client << sound('sounds/dipt_step.wav')
				else if(prob(src.distortion * 2))
					src.client << playsound('sounds/drum.wav')

		if(pulling)
			if(get_step_towards(prevloc, direction) == src.loc)
				step_to(pulling, prevloc)
	if(z == 7)
		if(istype(src.loc, /turf/abyss) && prob(50) || prob(2))
			abyss_switch()
	reset_view()
	return 1

/atom/proc/show_message(msg as text, selfmsg = null, range = -1)

	if(!msg)
		return

	var/receivers
	if(range != -1)

		receivers = viewers(src, range)
		for(var/atom/A in view(src, range))
			if(!(A in receivers))
				receivers += A
	else

		receivers = viewers(src)
		for(var/atom/A in view(src))
			if(!(A in receivers))
				receivers += A

	if(selfmsg && ismob(src))
		receivers -= src
		if(src:client)
			src << selfmsg

	for(var/mob/M in receivers)
		if(M.client)
			M << msg

/atom/proc/playsound(snd, loudness = 100)


	for(var/mob/M in range(src))

		if(!M.sleeps && !playmuzlo)
			if(prob(M.distortion / 2))
				if(prob(50))
					M << sound('sounds/deeper.wav')
				else
					M << sound('sounds/just_what.ogg', 'sounds/flute1.wav', 'sounds/flute2.wav', 'sounds/hoot.wav')
			else
				M << sound(snd, volume = loudness)
/turf
/turf/verb/examine()
	set src in view()
	if(src.desc)
		usr << desc
	else
		usr << "This is [src]."

/obj/verb/examine()
	set src in view()
	if(src.desc)
		usr << desc
	else if(istype(src, /obj/item/reagent_container/beaker))
		var/B = src
		usr << "A thingy for holding liquids."
		var/isempty = 1
		var/r_sum = 0
		for(var/datum/reagent/R in B:reagent_list)
			if(R.amount > 0)
				isempty = 0
				r_sum += R.amount
				if(B:transparent)
					if(R.amount == B:maxamount)
						usr << "It is full of [R.name]."
					else if(R.amount >= B:maxamount / 1.5)
						usr << "It is mostly filled with [R.name]."
					else if(R.amount >= B:maxamount / 3)
						usr << "It is about half-full with [R.name]."
					else if(R.amount >= B:maxamount / 10)
						usr << "It contains some [R.name]."
					else
						usr << "It contains a bit of [R.name]."

		spawn(0)

			if(isempty)
				usr << "\red It is empty."
			else if(!B:transparent)
				if(r_sum == B:maxamount)
					usr << "\blue It is full of something."
				else if(r_sum >= B:maxamount / 1.5)
					usr << "It is mostly filled with something."
				else if(r_sum >= B:maxamount / 3)
					usr << "It is about half-full with something."
				else if(r_sum >= B:maxamount / 10)
					usr << "It contains some unknown chemicals."
				else
					usr << "It contains a bit of something."
	else

		usr << "This is [src]."
	if(istype(src, /obj/item/reagent_container/syringe))
		var/S = src
		if(S:aids)
			usr << "\red It looks very dirty."


/mob/proc/fix_this_shit(rand = 0)
	if(!rand)
		src << "<font size=8 color=#ff1198>F</font><font size=6 color=#43ff05>	 I</font><font size=7 color=#0072ff>	 X</font>"
		src << "	 	 <font size=5 color=#fffb65>T</font><font size=8 color=#adffd3>H</font><font size=7 color=#ff5e2d>I</font><font size=4 color=#ffb7e0>S</font>"
		src << "	<font size = 8>S	 H	 I	 T</font>"
	else
		src << "<font size=8 color=[rc()]>F</font><font size=6 color=[rc()]>	 I</font><font size=7 color=[rc()]>	 X</font>"
		src << "	 	 <font size=5 color=[rc()]>T</font><font size=8 color=[rc()]>H</font><font size=7 color=[rc()]>I</font><font size=4 color=[rc()]>S</font>"
		src << "	<font size=8 color=[rc()]>S</font><font size=8 color=[rc()]>	 H</font><font size=8 color=[rc()]>	 I</font><font size=8 color=[rc()]>	 T</font>"

/proc/rc()
	return "#[num2hex(rand(0, 255))][num2hex(rand(0, 255))][num2hex(rand(0, 255))]"

/proc/num2hex(num, placeholder)
	if(placeholder == null)
		placeholder = 2
	if(!isnum(num))
		CRASH("num2hex not given a numeric argument (user error)")
		return
	if(!num)
		return "0"
	var/hex = ""
	var/i = 0
	while(16 ** i < num)
		i++
	var/power = null
	power = i - 1
	while(power >= 0)
		var/val = round(num / 16 ** power)
		num -= val * 16 ** power
		switch(val)
			if(9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
				hex += "[val]"
			if(10)
				hex += "A"
			if(11)
				hex += "B"
			if(12)
				hex += "C"
			if(13)
				hex += "D"
			if(14)
				hex += "E"
			if(15)
				hex += "F"

		power--
	while(length(hex) < placeholder)
		hex = "0[hex]"
	return hex

/mob/Bump(atom/movable/M)
	if(istype(M, /obj/structure/container/crate/inv))
		M:invisibility = 0
	if(M:anchored == 0 && !M:nopull)
		if(src.pulling == M)
			src.pulling = null
		step(M, usr.dir)

/proc/get_obstacle(turf/t)
	if(t:density)
		return t
	for(var/obj/o in t)
		if(o.density)
			return o
	for(var/mob/m in t)
		return m
	return null

/proc/get_turf(atom/a)
	if(isturf(a))
		return a
	while(a != null)
		a = a:loc
		if(isturf(a))
			return a

/atom/proc/throw_at(atom/target, speed = 30, distance = 100)

	if(!src)
		return
	if(src.anchored)
		return
	var/distance_traveled = 0
	var/prevloc = get_turf(src)
	while(src && ((src.x != target:x || (src.y != target:y || src.z != target:z)) && (distance_traveled < distance && speed > 0)))

		step_towards(src, target)
		if(get_turf(src) != prevloc)
			prevloc = get_turf(src)
		else
			if(get_turf(src) == get_turf(target))
				return

		var/a = get_obstacle(get_step(src, src.dir))
		if(a)
			src.thrown_at(a, speed)
			a:thrown_at_with(src, speed)
			return

		if(ismob(src))
			var/m = src
			m:last_move = 0
		sleep(10 / speed)

		distance_traveled++

/atom/proc/thrown_at(atom/obstacle, speed)



/mob/thrown_at(atom/obstacle, speed)
	src << "\red You collide with [obstacle:name]"
	src.damaga(max(0, (speed - 2) * 2), "brute")

/atom/proc/thrown_at_with(atom/object, speed)

/mob/thrown_at_with(atom/object, speed)
	if(ismob(object))
		var/mob/m = object
		src << "\red [m:name] has collided into you. \bold That hurts!"
		src.damaga(max(0, (speed - 2) * 2), "brute")
	else
		if(istype(object, /obj/item))
			var/obj/item/I = object
			show_message("[I:name] collides into [src.name]!")
			src << "\red [I:name] has collided into you. \bold That hurts!"
			src.damaga(max(0, speed - 6) + I:size * 2 + round(I:dmg / 5), "brute")
			if(I:sharp)
				src.wound()



/mob
	var/profi = 0


/mob
	var/unblock = 0

