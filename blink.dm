/client/var/true_view = 7

/mob/verb/blink_eyes()






	set name = "blink your cataractic eyes"
	if(src.client)
		if(src.mat == "flesh")
			src.client.eyeblink()
		else
			src << "\red You don't have an eyes to blink!"

/client/proc/eyeblink()



	mob.show_message("[mob.name] blinks.")

	for(var/obj/tick/T in src.screen)
		if(prob(10))
			T.death()

	var/i = 0
	var/uveko = new /obj/hud_effect/eye()
	var/dveko = new /obj/hud_effect/eye()
	uveko:screen_loc = "WEST,NORTH to EAST,NORTH"
	dveko:screen_loc = "WEST,SOUTH to EAST,SOUTH"
	src.screen += uveko
	src.screen += dveko
	while(i < src.view)
		uveko:screen_loc = "WEST,NORTH to EAST,NORTH-[i]"
		dveko:screen_loc = "WEST,SOUTH to EAST,SOUTH+[i]"
		sleep(0.1)
		i++
	sleep(1)
	i = src.view
	while(i > 0)
		uveko:screen_loc = "WEST,NORTH to EAST,NORTH-[i]"
		dveko:screen_loc = "WEST,SOUTH to EAST,SOUTH+[i]"
		sleep(0.1)
		i--
	sleep(1)
	src.screen -= uveko
	src.screen -= dveko

	for(var/obj/hud_effect/H in screen)
		src.screen -= H

	if(src)
		src.view = src.true_view
