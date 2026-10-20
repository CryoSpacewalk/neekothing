/obj/time_bomb
	icon = 'time_bomb.dmi'
	icon_state = "shell"
	var/cur_ticks = 30
	var/ticking = 0
	var/icon/overlay = null
	var/might = 3
	var/quake = 0
	var/psycho = 0
	var/antirange = 0
/obj/time_bomb/quake
	density = 1
	quake = 1
	anchored = 0
	name = "M.O.P.E.D."
	icon_state = "shell_quake"
	desc = "Mining-Oriented Portable Explosive Device. A special mining explosivities, perfect for crushing space ice."
/obj/time_bomb/psycho
	density = 1
	psycho = 1
	anchored = 0
	icon_state = "shell_psycho"
	desc = "This thing will do miracles to people around it."
	name = "Psychosis generator"
/obj/time_bomb/anti
	antirange = 5
	name = "Anti-bomb"
/obj/time_bomb/operate(obj/W)
	if(W:energy > 0)
		src.attack_hand()
		W:energy -= 1
	else
		usr << "\red Not enough energy!"

/obj/time_bomb/proc/tick()
	src.ticking = 1
	while(src.ticking)
		src.update_icon()
		if(!src.cur_ticks)
			src.ticking = 0
			spawn(15)
				if(src:quake)
					src.shutter()
				else if(src:psycho)
					src.psychowave(30)
				else if(src:antirange)
					src.antiplosion(src:antirange)
				else
					src.explode()
			return
		src.cur_ticks--
		sleep(10)

/obj/time_bomb/proc/update_icon()
	overlays -= overlay
	if(!cur_ticks)
		if(quake)
			icon_state = "exploding_quake"
			return
		else if(psycho)
			icon_state = "exploding_psycho"
			return
		else if(antirange)
			return
		else
			icon_state = "exploding"
			return
	var/secs = cur_ticks % 10
	var/secs_secs = round(cur_ticks % 60 / 10)
	var/mins = round(cur_ticks / 60) % 10
	var/mins_mins = round(cur_ticks / 600) % 10
	overlay = icon('time_bomb.dmi', "[secs]")
	src.overlay:Shift(4, 4)
	src.overlay:Blend(icon('time_bomb.dmi', "[secs_secs]"), 3)
	src.overlay:Shift(4, 6)
	src.overlay:Blend(icon('time_bomb.dmi', "[mins]"), 3)
	src.overlay:Shift(4, 4)
	src.overlay:Blend(icon('time_bomb.dmi', "[mins_mins]"), 3)
	overlays += overlay

/obj/time_bomb/proc/explode()

	explosion(src.might)
	if(src)
		del(src)

/obj/time_bomb/proc/shutter()


	for(var/turf/ice/I in range(1, src.loc))
		if(I && prob(90))
			I.digout()
	for(var/turf/ice/I in range(3, src.loc))
		if(I && prob(80))
			I.digout()
	for(var/turf/ice/I in range(5, src.loc))
		if(I && prob(40))
			I.digout()
	for(var/turf/ice/I in range(7, src.loc))
		if(I && prob(25))
			I.digout()
	for(var/turf/floor/icy/I in range(3, src.loc))
		if(I && prob(60))
			I.spacize()
	for(var/obj/structure/window/W in range(8, src.loc))
		if(prob(66))
			W.damage(30)
	for(var/obj/structure/reinforcement/W in range(4, src.loc))
		if(prob(20))
			W.damage(30)
			spawn(0)
				if(W)
					W.show_message("\red [W.name] shrikes!")
	for(var/mob/M in range(5 * (src.might - 2), loc))
		if(M && M.armor / 4 + M.energyprotect / 5 + M.heatprotect / 10 < 10)
			M.stun(10 + round(M.pain / 2) - (M.armor / 4 + M.energyprotect / 5 + M.heatprotect / 10 + M.painless / 2))
	if(src)
		spawn(0) del(src)

/obj/time_bomb/proc/psychowave(power)
	for(var/mob/M in range(power, src.loc))
		M.delirium += 6
		M.calm--
		M.add_chem("salvinorin A", "salvinorin A", 1.7, 0)
		if(prob(50))
			spawn(1) M.add_chem("5-MeO-DMT", "5-MeO-DMT", 0.9, 0)
	if(src)
		spawn(0) del(src)

/obj/time_bomb/verb/set_time()
	set src in view(1)
	if(src.ticking)
		usr << "\red The bomb is already set up, get the fuck away from it!"
		return
	var/t = input("Set timer to:", "M.O.P.E.D.", 30) as num
	t = max(0, t)
	src.cur_ticks = t
	src.update_icon()
	usr << "You set the bomb timer to [t]."

/obj/time_bomb/attack_by(obj/I)
	if(istype(I, /obj/item/device/consolehack) && src.might < 6)
		usr << "\red Damn, you're a risky guy."
		src.might = src.might * 2
		spawn(20) src.attack_hand()
/obj/time_bomb/quake;/obj/time_bomb/psycho
/obj/time_bomb/attack_hand(mob/user)
	if(!src.ticking)
		spawn(0) src.tick()
		user << "\red You set up the [src.name]! <b>Run!</b>"
	else
		user << "\red It has already been activated, run!"

/obj/time_bomb/New()
	..()
	update_icon()
/obj/item/bomb
	icon = 'grafon/device.dmi'
	market_price = 100
	icon_state = "package"
	name = "package"
	desc = "It looks a bit suspicious."
/obj/item/bomb
/obj/item/bomb/attack_self()
	usr << "\blue You deploy your package."
	new /obj/time_bomb(usr.loc)
	usr.delitem()
	return