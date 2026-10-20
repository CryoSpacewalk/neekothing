// Recovered from compiled neek.dmb (6 procs)

/mob/var/tumble_cooldown = 60

/mob/var/tumble_last_used = -60

/mob/var/roundhouse_kick_cooldown = 200

/mob/var/roundhouse_kick_last_used = -200

/mob/var/flurry_count = 0

/mob/var/flurry_cooldown = 100

/mob/var/flurry_last_used = -100

/mob/var/combat_throw_cooldown = 60
/mob/var/combat_throw_last_used = -60
/mob/var/parastunned = 0
/mob/var/luck = 10
/mob/var/wired = 0
/mob/proc/tumble()
	set name = "tumble"
	set category = "combat"
	set desc = "Tumble into the cover!"
	if(!src.can_move)
		return
	if(world.time - src.tumble_last_used < src.tumble_cooldown)

		return
	if(src.euphoria < 10)
		usr << "\red \bold You have to feel good to do things like this!"
		return
	src.euphoria -= 10
	src.tumble_last_used = world.time
	spawn(0)
		for(var/i = 0, i < 4, i++)
			var/I = new /icon(src.icon)
			I:Turn(90)
			src.icon = I
			src.update_sprite((i + 1) * 90)
			sleep(1)
	for(var/i = 0, i < 3, i++)
		src.last_move = 0
		step(src, src.dir)
		sleep(0.7)
	src.empowered++
	spawn(10)
		src.empowered--

/mob/proc/dash()





	set name = "dash"
	set desc = "Body slam!"
	set category = "combat"
	if(src.euphoria < 10)
		usr << "\red \bold You have to feel good to do things like this!"
		return
	src.euphoria -= 10
	var/t = loc
	for(var/i = 0, i < 5, i++)
		t = get_step(t, src.dir)
	src.throw_at(t, 15)

/mob/proc/roundhouse_kick()



	set name = "roundhouse kick"
	set desc = "KEEEEYAAH!!"
	set category = "combat"
	if(world.time - src.roundhouse_kick_last_used < src.roundhouse_kick_cooldown)
		return
	if(src.euphoria < 10)
		usr << "\red \bold You have to feel good to do things like this!"
		return
	src.euphoria -= 10
	var/mobcount = 0
	for(var/mob/m in orange(1, get_turf(src)))
		mobcount++
		var/t = get_turf(m)
		for(var/i = 0, i < 100, i++)
			t = get_step(t, get_dir(src, m))
			if(!t || t:density)
				break
		m.throw_at(t, 15)
		m.damaga(30, "brute")
	if(mobcount)
		src << "<font size=[mobcount + 2] color=#ff0000>KEEE-YAAAAH!!!</font>"
		src.roundhouse_kick_last_used = world.time

/mob/proc/flurry()





	set name = "flurry"
	set desc = "Cho-cho-cho!"
	set category = "combat"
	if(world.time - src.flurry_last_used < src.flurry_cooldown)
		return
	if(src.euphoria < 10)
		usr << "\red \bold You have to feel good to do things like this!"
		return
	src.euphoria -= 10
	src.flurry_count = 4
	src.flurry_last_used = world.time

/mob/proc/combat_throw()



	set name = "throw"
	set desc = "Throw them head first onto the wall."
	set category = "combat"
	if(world.time - src.combat_throw_last_used < src.combat_throw_cooldown)
		return
	if(src.euphoria < 10)
		usr << "\red \bold You have to feel good to do things like this!"
		return
	src.euphoria -= 10
	var/t = get_step(src, src.dir)
	for(var/mob/m in t)
		m.dir = get_dir(m, src)
		src.dir = m.dir
		var/target_turf = src.loc
		for(var/i = 0, i < 7, i++)
			target_turf = get_step(target_turf, m.dir)
		m.loc = src.loc
		m.throw_at(target_turf, 10)
		m.stun(3)
		src.show_message("\red [src.name] has sent [m.name] flying over his shoulder!", "\blue You throw [m.name] over your shoulder.")
		src.combat_throw_last_used = world.time

/mob/proc/dash_eupho()


	if(src.euphoria < 30)
		usr << "\red \bold You have to feel good to do things like this!"
		return
	if(src:brainport)
		if(istype(src:brainport, /obj/item/device/brainport/tantric))
			set desc = "KEEEEYAAH!!"
			set category = "combat"
			var/mobcount = 0
			for(var/mob/m in orange(1, get_turf(src)))
				mobcount++
				var/t = get_turf(m)
				for(var/i = 0, i < 100, i++)
					t = get_step(t, get_dir(src, m))
					if(!t || t:density)
						break
				m.throw_at(t, 15)
				m.damaga(30, "brute")
			if(mobcount)
				src << "<font size=[mobcount + 2] color=#ff0000>KEEE-YAAAAH!!!</font>"
				src.euphoria -= 30
