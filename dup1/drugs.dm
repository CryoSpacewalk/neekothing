/obj/omich/New()






































	src.icon_state = pick("amoeba", "gagarin", "static", "tesak", "legless", "traitor")
	spawn(0) src.roam()
/obj/omich/proc/roam()
	if(prob(50))
		step(src, pick(1, 2, 8, 4))
	spawn(20) src.roam()

/client/proc/uprt(ptc)




	if(prob(50 - src.mob.drunk * 8))
		src.mob.stun(2.5 + ptc / 10)
		src.mob << "\red Holy Lord."
		var/elist = list()
		for(var/obj/landmark/eye/E in world)
			elist += E
		var/L
		if(elist:len)
			L = elist[rand(1, elist:len)]
		else
			src.mob << "\red NO SHROOMS FOR U"
		spawn(0)
			src.perspective = 1
			src.eye = L:loc

			spawn(25 + ptc) src.eye = mob

/client/proc/shroomed(ptc)


















	var/b = new /obj/hud_effect/red_frame/bottom()
	screen += b
	var/l = new /obj/hud_effect/red_frame/left()
	screen += l
	var/u = new /obj/hud_effect/red_frame/upper()
	screen += u
	var/r = new /obj/hud_effect/red_frame/right()
	screen += r
	spawn(ptc)
		screen -= b
		screen -= u
		screen -= l
		screen -= r

/client/proc/colored(fiveticks)
	var/vw = 1
	while(vw <= view * 2 + 1)
		var/vws = 1
		while(vws <= view * 2 + 1)
			var/C = new /obj/hud_effect/color()
			C:screen_loc = "[vws],[vw]"
			screen += C
			vws++
		vw++
	spawn(5 * fiveticks)
		for(var/obj/hud_effect/color/C in screen)
			screen -= C

/proc/transform_to_xynta(msg as text, brutal)







	var/rep
	var/nmb = 2
	while(nmb < length(msg))
		rep = pick("buzz", "ÿ", "û", "ó", "à", "õûõ", "àáûðâàëã", "óóóó", "àààà", "ûûûû", "áðëáðëáðë")
		if(prob(brutal))
			msg = copytext(msg, 1, nmb) + rep + copytext(msg, nmb + 1)
			nmb += length(rep) + 1
		else
			nmb++
	return msg

/obj/hud_effect/eye
	mouse_opacity = 0
	icon_state = "eye_basic1"

/obj/hud_effect/eye

/obj/hud_effect/red_frame
	icon_state = "frame"

/obj/hud_effect/red_frame

/obj/hud_effect/fog
	mouse_opacity = 0
	icon_state = "dot"
	screen_loc = "WEST,SOUTH to EAST,NORTH"

/obj/hud_effect/fog

/obj/hud_effect/heavy_fog
	mouse_opacity = 0
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "dot_heavy"

/obj/hud_effect/heavy_fog

/obj/hud_effect/heck
	icon = null /*icon id 73: unresolved*/
	icon = 'grafon/effects/chemistry.dmi'
	icon_state = "fire"
	screen_loc = "WEST,SOUTH to EAST,NORTH"

/obj/hud_effect/heck

/obj/hud_effect/vortex
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "vortex"

/obj/hud_effect/vortex

/obj/hud_effect/worms
	mouse_opacity = 0
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "worms"

/obj/hud_effect/worms

/obj/hud_effect/dmt
	mouse_opacity = 0
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "dmt1"

/obj/hud_effect/dmt


/obj/hud_effect/dmt/New()
	icon_state = "dmt[pick(1, 2, 3)]"
/obj/hud_effect/mesc
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "mesc1"
/obj/hud_effect/mesc
/obj/hud_effect/mesc/New()
	icon_state = "mesc[pick(1, 2)]"

/obj/hud_effect/mesc_soft
	mouse_opacity = 0
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "mesc_tr"

/obj/hud_effect/mesc_soft

/obj/hud_effect/mesc_wicked
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "mesc_wicked"

/obj/hud_effect/mesc_wicked

/obj/hud_effect/mesc_blurry
	mouse_opacity = 0
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "mesc_blur"

/obj/hud_effect/mesc_blurry
/obj/hud_effect/acid
	mouse_opacity = 0
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "acid0"
/obj/hud_effect/acid
/obj/hud_effect/acid/New()
	if(prob(33))
		icon_state = "acid[rand(1, 7)]"
	else
		icon_state = "color[rand(0, 6)]"

/obj/hud_effect/natural
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "curvy1"

/obj/hud_effect/natural
/obj/hud_effect/natural/New()
	if(prob(33))
		icon_state = "curvy[pick(1, 2)]"

/obj/hud_effect/wheel
	mouse_opacity = 0
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "roundy"

/obj/hud_effect/wheel

/obj/hud_effect/sovok
	mouse_opacity = 0
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "sovok"

/obj/hud_effect/sovok
/obj/hud_effect/perun
	icon = 'grafon/perun.dmi'
	icon_state = "singulo"
	screen_loc = "CENTER"
/obj/hud_effect/perun
/obj/hud_effect/dmt_huge
	icon = 'grafon/hud_3x3.dmi'
	icon_state = "dmt"
	screen_loc = "CENTER-1,CENTER-1"
/obj/hud_effect/dmt_huge
/obj/hud_effect/dmt_huge/New()
	icon_state = pick("dmt", "dmt_sacral")

/obj/hud_effect/ttgl
	screen_loc = "CENTER"
	icon = 'grafon/hud_3x3.dmi'
	icon_state = "ttgl"

/obj/hud_effect/ttgl

/obj/hud_effect/ttgl_left
	icon = 'grafon/hud_3x3.dmi'
	icon_state = "ttgl_left"

/obj/hud_effect/ttgl_left
/obj/hud_effect/ttgl_right
	icon = 'grafon/hud_3x3.dmi'
	icon_state = "ttgl_right"
/obj/hud_effect/ttgl_right
/obj/hud_effect/stalin
	icon = 'grafon/perun.dmi'
	icon_state = "stalin"
	screen_loc = "WEST,SOUTH to EAST,NORTH"
/obj/hud_effect/stalin
/obj/hud_effect/nightmare
	screen_loc = "WEST,SOUTH+1"
	icon = null /*icon id 77: unresolved*/
	icon = 'grafon/1dba19b34341.jpg'
/obj/hud_effect/nightmare
/obj/hud_effect/nightmare/New()
	icon = pick('grafon/mir-space-station.jpg', 'grafon/creepy_art.jpg', 'grafon/creepy1.jpg', 'grafon/creepy2.jpg', 'grafon/wtc.jpg', 'grafon/RetrieveAsset.jpg', 'grafon/ap_nick_ut_pulitzer_prize_image_1972_vietnam_thg_120606_wblog.jpg', 'grafon/1dba19b34341.jpg')


/obj/hud_effect/blurry
	icon_state = "frame_blur"

/obj/hud_effect/blurry

/obj/hud_effect/static_screen
	mouse_opacity = 0
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon = 'grafon/thingy.dmi'
	// ^ icon match was partial
	icon_state = "static"

/obj/hud_effect/static_screen

/obj/hud_effect/color
	mouse_opacity = 0
	icon_state = "color0"

/obj/hud_effect/color



/obj/hud_effect/color/New()









	icon_state = "color[pick(0, 1, 2, 3, 4, 5, 6)]"
/obj/hud_effect/channel1
	screen_loc = "NORTHWEST"
	icon = 'grafon/thingy.dmi'
	// ^ icon match was partial
	icon_state = "channel1"
/obj/hud_effect/channel1
/obj/hud_effect/webpunk
	screen_loc = "SOUTHWEST"
	icon = 'grafon/thingy.dmi'
	// ^ icon match was partial
	icon_state = "webpunk"
/obj/hud_effect/webpunk
/obj/hud_effect/webpunk/New()
	icon_state = "webpunk[rand(0, 2)]"
	screen_loc = pick("SOUTHWEST", "SOUTHEAST", "NORTHEAST")

/mob/proc/see_things(tikz)





























/obj/drugged/New()





































	if(src.overlaps)
		for(var/obj/drugged/D in src.loc)
			if(D != src)
				del(D)
	src.tick_tack()

/obj/drugged/proc/tick_tack()
	for(var/obj/drugged/D in loc)
		if(D != src && prob(80))
			del(D)

	var/collided = 0

	if(src.mobile)
		if(src.lurking)
			for(var/mob/M in viewers(src))
				if(M)
					step_to(src, M)
				if(src.collides && loc == M.loc)
					collided = 1
		else
			step(src, pick(1, 2, 8, 4))

	if(touches)
		for(var/mob/M in src.loc)
			if(M.see_invisible >= invisibility)
				M << "\red \bold Contact with [src.name] is unbearable."
				M.calm--
				M.euphoria -= 2
				if(prob(50) && M.calm)
					M.calm--
				if(M.calm > 10 && prob(66))
					M.calm -= 2
				if(prob(40) && src.stuns)
					M << "\red [src.name] rushes at you!"
					M.stun(pick(2, 3))
			else
				M << "Something [pick("touches", "is watching", "is coming for")] you."

	if(!src.clock || collided)
		del(src)
	else
		src.clock--
		spawn(10 * src.laggy) src.tick_tack()

/obj/drugged/verb/speak()

	set name = "Ask your vision of something"
	set src in view(1)
	if(src.whispers)
		usr.say("Can you tell me more about me and world around me, please?")
		usr << "\blue You ask [src] about yourself and the world around you."
		spawn(10)
			if(src)
				usr << "\blue [src] answers to you."
				usr << src.playsound(pick('sounds/flute1.wav', 'sounds/flute2.wav'))
				if(prob(50))
					usr << "\green Its answer calms you and feels you with joy."
					usr.euphoria += 10
					usr.calm++
				else
					usr << "\red Its answer scares and disappoints you."
					usr.euphoria -= 5
					usr.calm -= 2
	else
		usr << "\red Looks like [src] is either unable or unwilling to talk with you."
/obj/drugged/dob_eye
	invisibility = 7
	clock = 5
	touches = 1
	name = "Eye"
	desc = "We can see you"
/obj/drugged/dob_eye
/obj/drugged/dob_eye/New()
	icon_state = "psy_eye_dob[pick("1", "2", "3", "4")]"
	..()

/obj/drugged/wall
	invisibility = 3
	overlaps = 1

/obj/drugged/wall


/obj/drugged/wall/New()


	icon_state = "wall[rand(1, 4)]" || "wall_mov[rand(1, 5)]"
	..()
/obj/drugged/green_wall
	invisibility = 3
	overlaps = 1
/obj/drugged/green_wall
/obj/drugged/green_wall/New()
	icon_state = "grwall[rand(1, 8)]"
	..()
/obj/drugged/wall_distort
/obj/drugged/wall_distort
/obj/drugged/wall_distort/New()
	icon_state = "wall_distort[rand(1, 9)]"
/obj/drugged/wall_fract
/obj/drugged/wall_fract
/obj/drugged/wall_fract/New()
	icon_state = "frac_wall[rand(1, 13)]"

/obj/drugged/ice_wall
	name = "Ice"
	icon_state = "iwall1"

/obj/drugged/ice_wall

/obj/drugged/ice_wall/New()






























	icon_state = "icewall[rand(1, 6)]"
	..()

/obj/drugged/ad_wall
	name = "Wall"
	icon_state = "adwall1"
/obj/drugged/ad_wall
/obj/drugged/ad_wall/New()
	icon_state = "adwall[rand(1, 6)]"
	..()
/obj/drugged/floor
	invisibility = 3
	overlaps = 1
	icon_state = "floor1"
/obj/drugged/floor
/obj/drugged/floor/New()
	if(prob(66))
		icon_state = "floor[rand(1, 4)]"
	else
		icon_state = "floor_mov[rand(1, 9)]"
	..()
/obj/drugged/floor_mov
	invisibility = 3
	overlaps = 1
	icon_state = "floor_mov1"
/obj/drugged/floor_mov
/obj/drugged/floor_mov/New()
	icon_state = "floor_mov[rand(1, 9)]"
	..()
/obj/drugged/floor_fract
	invisibility = 3
	overlaps = 1
	icon_state = "floor_fract1"
/obj/drugged/floor_fract
/obj/drugged/floor_fract/New()
	icon_state = "floor_fract[rand(1, 9)]"
	..()
/obj/drugged/green_floor
	invisibility = 3
	overlaps = 1
	icon_state = "gfloor1"
/obj/drugged/green_floor
/obj/drugged/green_floor/New()
	icon_state = "gfloor[rand(1, 5)]"
	..()
/obj/drugged/floor_grind
	invisibility = 3
	overlaps = 1
	icon_state = "grfloor1"
/obj/drugged/floor_grind
/obj/drugged/floor_grind/New()
	icon_state = "grfloor[rand(1, 3)]"
	..()
/obj/drugged/floor_broken
	invisibility = 3
	overlaps = 1
	clock = 7
	icon_state = "gfbfloor"
/obj/drugged/floor_broken
/obj/drugged/floor_ad
	invisibility = 3
	overlaps = 1
	name = "Floor"
	icon_state = "adfloor1"
/obj/drugged/floor_ad
/obj/drugged/floor_ad/New()
	icon_state = "adfloor[rand(1, 4)]"
	..()
/obj/drugged/pseudospace
	invisibility = 2
	icon = 'floor.dmi'
	overlaps = 1
	name = "Space"
	icon_state = "space_deep"
/obj/drugged/pseudospace
/obj/drugged/pseudospace/New()
	dir = pick(1, 2, 8, 4, 9, 5, 10, 6)
	..()

/obj/drugged/dobman
	invisibility = 9
	laggy = 0.33
	whispers = 1
	mobile = 1
	touches = 1
	desc = "We can see you"
	name = "Observer"
	icon_state = "dobman"
/obj/drugged/dobman
/obj/drugged/acid_spaceman
	invisibility = 8
	laggy = 5
	whispers = 1
	mobile = 1
	name = "Samsara overcomer"
	desc = "Om!"
/obj/drugged/acid_spaceman
/obj/drugged/acid_spaceman/New()
	if(prob(10))
		icon_state = "static_om_spaceman"
	else
		icon_state = "om_spaceman"
	..()


/obj/drugged/elf
	invisibility = 10
	whispers = 1
	mobile = 1
	clock = 50
	laggy = 0.5
	name = "Mechanical fractal elf"
	icon_state = "elf1"

/obj/drugged/elf


/obj/drugged/elf/New()








	icon_state = "elf[rand(1, 3)]"
	..()
/obj/drugged/traitor
	invisibility = 10
	mobile = 1
	lurking = 1
	collides = 1
	laggy = 0.25
	icon_state = "traitor"
	name = "dongz"
/obj/drugged/traitor/New()
	var/firstname = pick("Vovan", "Sergey", "Zuchnewt", "Hop", "George", "Douglas", "Petyan", "Wasiliy", "Khodoque", "Mishanya", "Manya", "Urist", "Geshud", "GEDUSH", "Wasiliti", "Karik", "Ivan", "Yurka", "Adolph", "Syndie")
	var/secondname = pick("Kotov", "Pahomov", "Schetnikov", "Pupkin", "Tritor", "Melons", "Petuhov", "Griferkov", "McRobust", "McLiberal", "McFishDissector", "McMechanic", "McRooster", "McSpessman", "LE MEKANIKUE", "Tibet", "Karlov", "Armstrong", "Gagarin", "Germogenovich")
	name = "[firstname] [secondname]"


	..()
/obj/drugged/volga
	invisibility = 10
	mobile = 1
	lurking = 1
	collides = 1
	touches = 1
	laggy = 0.33
	name = "Killer Volga"
	desc = "WROOM WROOM MOTHERFUCKER"
	icon_state = "auto"
/obj/drugged/volga
/obj/drugged/lazor
	invisibility = 9
	icon = 'grafon/singulo.dmi'
	mobile = 1
	lurking = 1
	collides = 1
	clock = 100
	laggy = 0.1
	icon_state = "pewpew"
/obj/drugged/lazor
/obj/drugged/clone
	invisibility = 13
	laggy = 1
/obj/drugged/clone/New()
	spawn(0) ..()


/obj/drugged/delirium
	invisibility = 13
	laggy = 2.5
/obj/drugged/delirium
/obj/drugged/delirium/New()
	var/ii = rand(1, 15)

	switch(ii)
		if(1)

			icon = 'Wall.dmi'
			icon_state = "gray"
			name = "metal wall"
		if(2)

			icon = 'Wall.dmi'
			icon_state = "wall1"
			name = "metal wall"
		if(3)

			icon = 'Wall.dmi'
			icon_state = "wall3"
			name = "reinforced wall"
		if(4)

			icon = 'Wall.dmi'
			icon_state = "brick"
			name = "brick wall"
		if(5)

			icon = 'Wall.dmi'
			icon_state = "nazi"
			name = "nazi wall"
		if(6)

			icon = 'grafon/structure.dmi'
			icon_state = "grile"
			name = "Steel grille"
		if(6)

			icon = 'grafon/structure.dmi'
			icon_state = "grille"
			name = "Steel grille"
		if(7)

			icon = 'grafon/structure.dmi'
			icon_state = "weakgrille"
			name = "Iron grille"
		if(8)

			icon = 'grafon/structure.dmi'
			icon_state = "woodgrille"
			name = "Wooden grille"
		if(9)

			icon = 'grafon/structure.dmi'
			icon_state = "woodbarricade"
			name = "Wooden barricade"
		if(10)

			icon = 'grafon/window.dmi'
			icon_state = "basic"
			name = "window"
		if(11)

			icon = 'grafon/item/weapons.dmi'
			icon_state = "baton"
			name = "rubber baton"
		if(12)

			icon = 'grafon/item/weapons.dmi'
			icon_state = "blaster_red"
			name = "blaster"
		if(13)

			icon = 'grafon/item/electronics.dmi'
			icon_state = "mobila"
			name = "Capitalistic mobile phone"
		if(14)

			name = "electric shock"
			icon = 'grafon/item/weapons.dmi'
			icon_state = "shock"
		if(15)

			name = "plus-axe"
			icon = 'grafon/item/weapons.dmi'
			icon_state = "protonaxe"
		if(15)

			name = "syringe gun"
			icon = 'grafon/item/liquid.dmi'
			icon_state = "syringe_gun"
		if(16)

			name = "Trigan-D"
			icon = 'grafon/item/liquid.dmi'
			icon_state = "blister_trigan"
		else

			icon = 'grafon/structure.dmi'
			icon_state = "mine"
			name = "space mine"
			desc = "Just don't fucking touch it."

	spawn(0) ..()

/obj/drugged/spess
	invisibility = 2
	clock = 7
	name = "space"
	icon_state = "tspace1"

/obj/drugged/spess

/obj/drugged/spess/New()
	icon_state = "tspace[rand(1, 4)]"
	..()
/obj/drugged/spess_creepy
	invisibility = 2
	clock = 7
	name = "space"
	icon_state = "screepy1"
/obj/drugged/spess_creepy
/obj/drugged/spess_creepy/New()
	icon_state = "screepy[rand(1, 6)]"
	..()

/mob/proc/spacevisions(creepy)

	var/L = list()

	for(var/turf/space/S in view(src))
		L += S

	var/turf/space/S

	if(L:len)
		S = pick(L)

	if(prob(creepy))
		var/SP = new /obj/drugged/spess_creepy(S)
		if(SP in view(src))
			src << "\red You see something horrible in the depths of space."
			if(src.calm >= 20)
				src.calm -= rand(3, 5)
			else
				src.calm -= 2
	else

		var/SP = new /obj/drugged/spess(S)
		if(SP in view(src))
			src << "\blue You see something weird in the depths of space."
			if(src.calm < 20)
				src.calm += pick(-2, 2)
				src.euphoria += pick(-10, 10)
			else
				src.calm--
				src.euphoria += 5
