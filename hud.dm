// Recovered from compiled neek.dmb (35 procs)

/client/proc/reset_hud()




	if(src.mob.screen_hud)
		del(src.mob.screen_hud)
	var/huy = new /obj/hud(src)
	src.mob.screen_hud = huy
	huy:mymob = src.mob

/client/proc/del_hud()
	if(mob.screen_hud)
		del(mob.screen_hud)
		mob.screen_hud = null

/mob/proc/del_hud()
	if(src.client)
		client:del_hud()
	else
		if(src.screen_hud)
			del(src.screen_hud)
			src.screen_hud = null

/mob/proc/reset_hud()
	if(src.client)
		src.client.reset_hud()
	else
		if(src.screen_hud)
			del(src.screen_hud)
		var/huy = new /obj/hud(src)
		src.screen_hud = huy
		huy:mymob = src

/obj/hud
	var/mob/mymob = null
	var/obj/in_l_hand = null
	var/obj/in_r_hand = null
	var/obj/in_pocket = null
	var/obj/on_belt = null
	var/obj/in_hidden = null
	var/obj/in_hidden2 = null
	var/obj/on_body = null
	var/obj/in_brain = null





	var/buttons = list(new /obj/button/l_hand, new /obj/button/r_hand, new /obj/button/swap_hands, new /obj/button/drop, new /obj/button/pocket, new /obj/button/belt, new /obj/button/hidden, new /obj/button/hidden2, new /obj/button/clothes, new /obj/button/bpull, new /obj/button/brain, new /obj/button/consume, new /obj/button/use, new /obj/button/checkout, new /obj/button/checkmood)


	var/indicators = list(new /obj/hud_indicator/hp, new /obj/hud_indicator/eupho, new /obj/hud_indicator/calm, new /obj/hud_indicator/hunger, new /obj/hud_indicator/libido, new /obj/hud_indicator/hand_selector)

/obj/hud/New()
	..()
	spawn(0)
		src.draw_morda()
		src.initialize()
		src.process()



/obj/hud/proc/update()
	if(!src.mymob || !mymob:client)
		return

	if(src.mymob:r_hand)
		if(src.mymob:r_hand != src.in_r_hand || !(src.in_r_hand in mymob:client:screen))
			src.in_r_hand = src.mymob:r_hand
			mymob:client:screen += src.in_r_hand
			var/tempb = src.get_button("right hand")
			src.in_r_hand:screen_loc = tempb:screen_loc
	else
		if(src.in_r_hand)
			mymob:client:screen -= src.in_r_hand
			src.in_r_hand = null

	if(src.mymob:l_hand)
		if(src.mymob:l_hand != src.in_l_hand || !(src.in_l_hand in mymob:client:screen))
			src.in_l_hand = src.mymob:l_hand
			mymob:client:screen += src.in_l_hand
			var/tempb = src.get_button("left hand")
			src.in_l_hand:screen_loc = tempb:screen_loc
	else
		if(src.in_l_hand)
			mymob:client:screen -= src.in_l_hand
			src.in_l_hand = null

	var/swap_hands = src.get_button("swap hands")

	if(mymob:hand)
		if(swap_hands:dir != 8)
			swap_hands:dir = 8
	else
		if(swap_hands:dir != 4)
			swap_hands:dir = 4


	if(src.mymob:pocket)
		if(src.mymob:pocket != src.in_pocket || !(src.in_pocket in mymob:client:screen))
			src.in_pocket = src.mymob:pocket
			mymob:client:screen += src.in_pocket
			var/tempb = src.get_button("pocket")
			src.in_pocket:screen_loc = tempb:screen_loc
	else
		if(src.in_pocket)
			mymob:client:screen -= src.in_pocket
			src.in_pocket = null

	if(src.mymob:belt)
		if(src.mymob:belt != src.on_belt || !(src.on_belt in mymob:client:screen))
			src.on_belt = src.mymob:belt
			mymob:client:screen += src.on_belt
			var/tempb = src.get_button("belt")
			src.on_belt:screen_loc = tempb:screen_loc
	else
		if(src.on_belt)
			mymob:client:screen -= src.on_belt
			src.on_belt = null

	if(src.mymob:hidden)
		if(src.mymob:hidden != src.in_hidden || !(src.in_hidden in mymob:client:screen))
			src.in_hidden = src.mymob:hidden
			mymob:client:screen += src.in_hidden
			var/tempb = src.get_button("left hidden pocket")
			src.in_hidden:screen_loc = tempb:screen_loc
	else
		if(src.in_hidden)
			mymob:client:screen -= src.in_hidden
			src.in_hidden = null

	if(src.mymob:hidden2)
		if(src.mymob:hidden2 != src.in_hidden2 || !(src.in_hidden2 in mymob:client:screen))
			src.in_hidden2 = src.mymob:hidden2
			mymob:client:screen += src.in_hidden2
			var/tempb = src.get_button("right hidden pocket")
			src.in_hidden2:screen_loc = tempb:screen_loc
	else
		if(src.in_hidden2)
			mymob:client:screen -= src.in_hidden2
			src.in_hidden2 = null

	if(src.mymob:clothes)
		if(src.mymob:clothes != src.on_body || !(src.on_body in mymob:client:screen))
			src.on_body = src.mymob:clothes
			mymob:client:screen += src.on_body
			var/tempb = src.get_button("clothes")
			src.on_body:screen_loc = tempb:screen_loc
	else
		if(src.on_body)
			mymob:client:screen -= src.on_body
			src.on_body = null

	if(src.mymob:brainport)
		if(src.mymob:clothes != src.in_brain || !(src.in_brain in mymob:client:screen))
			src.in_brain = src.mymob:brainport
			mymob:client:screen += src.in_brain
			var/tempb = src.get_button("brain port")
			src.in_brain:screen_loc = tempb:screen_loc
	else
		if(src.in_brain)
			mymob:client:screen -= src.in_brain
			src.in_brain = null

	for(var/obj/hud_indicator/H in src.mymob:client:screen)
		H.update(src.mymob)

/obj/hud/proc/initialize()


	for(var/obj/button/B in src.buttons)
		if(src:mymob:client)
			src:mymob:client:screen += B

	for(var/obj/hud_indicator/H in src.indicators)
		if(src:mymob:client)
			src:mymob:client:screen += H

/obj/hud/process()
	src.update()
	sleep(2)
	if(!src.mymob)
		del(src)
		return
	spawn(0) src.process()
	return 1

/obj/hud/Del()
	for(var/obj/button/B in src.buttons)
		if(src.mymob && src:mymob:client)
			src:mymob:client:screen -= B
		del(B)
	for(var/obj/I in list(src.in_r_hand, src.in_l_hand, src.in_pocket, src.on_belt, src.in_hidden, src.in_hidden2, src.on_body))
		if(I && (src.mymob && src:mymob:client))
			src:mymob:client:screen -= I
	..()

/mob/proc/gimme_hud()
	if(usr.screen_hud)
		return
	var/huy = new /obj/hud(src)
	huy:mymob = usr
	usr.screen_hud = huy

/obj/button/Click()



	src.default_action(usr)

/obj/button/proc/default_action(mob/user)
	return

/obj/button/suicide
	icon_state = "suicide"
	screen_loc = "5,1"

/obj/button/suicide
/obj/button/suicide/default_action()
	usr.punchself()

/obj/button/drop
	name = "drop item"
	icon_state = "drop"
	screen_loc = "1,2"
/obj/button/drop
/obj/button/drop/default_action()
	usr.dropitem(usr.item)


/obj/button/l_hand
	name = "left hand"
	screen_loc = "5,1"
	icon_state = "empty_left"
/obj/button/l_hand
/obj/button/swap_hands
	icon_state = "hands"
	screen_loc = "6,1"
/obj/button/swap_hands
/obj/button/swap_hands/default_action()
	if(usr.hand)

		for(var/obj/button/r_hand/R in usr.screen_hud)
			R.icon_state = "empty_right_active"
		for(var/obj/button/l_hand/L in usr.screen_hud)
			L.icon_state = "empty_left"
	else

		for(var/obj/button/r_hand/R in usr.screen_hud)
			R.icon_state = "empty_right"
		for(var/obj/button/l_hand/L in usr.screen_hud)
			L.icon_state = "empty_left_active"
	usr.change_hands()

/obj/button/r_hand
	name = "right hand"
	icon_state = "empty_right"
	screen_loc = "7,1"

/obj/button/r_hand
/obj/button/pocket
	icon_state = "empty_pocket"
	screen_loc = "3,2"
/obj/button/pocket
/obj/button/pocket/default_action()
	usr.pocket()

/obj/button/belt
	icon_state = "empty_belt"
	screen_loc = "2,1"

/obj/button/belt
/obj/button/belt/default_action()
	usr.belt()

/obj/button/hidden
	name = "left hidden pocket"
	icon_state = "empty_hidden_left"
	screen_loc = "1,1"
/obj/button/hidden
/obj/button/hidden/default_action()
	usr.hidpocket()

/obj/button/hidden2
	name = "right hidden pocket"
	icon_state = "empty_hidden_right"
	screen_loc = "3,1"
/obj/button/hidden2
/obj/button/hidden2/default_action()
	usr.hidpocket2()

/obj/button/clothes
	icon_state = "empty_suit"
	screen_loc = "2,2"

/obj/button/clothes
/obj/button/clothes/default_action()
	usr.wearitem()

/client/proc/hud_test()
	for(var/i = 1, i <= screen.len, i++)
		usr << screen[i]

/obj/hud/proc/get_button(naem as text)
	for(var/obj/button in src.buttons)
		if(button.name == naem)
			return button
	return null

/obj/button/bpull
	name = "break pull"
	icon_state = "bpull"
	screen_loc = "7,2"
/obj/button/bpull
/obj/button/bpull/default_action()
	for(var/atom/movable/A in range(1, usr))
		if(A == usr.pulling)
			A.break_pull()


/obj/button/consume
	name = "consume"
	icon_state = "eat"
	screen_loc = "11,1"

/obj/button/consume

/obj/button/consume/default_action()
	usr.eat(usr.item)


/obj/button/use
	name = "use"
	icon_state = "star"
	screen_loc = "6,2"
/obj/button/use
/obj/button/use/default_action()
	usr.use(usr.item)
/obj/button/checkout
	name = "checkout"
	icon_state = "hamsa_on"
	screen_loc = "13,1"
/obj/button/checkout
/obj/button/checkout/default_action()
	usr.checkout()
/obj/button/checkmood
	name = "check mood"
	icon_state = "hamsa"
	screen_loc = "12,1"
/obj/button/checkmood
/obj/button/checkmood/default_action()
	usr.checkmood()

/obj/hud_indicator/proc/update(mob/M)













/obj/hud_indicator/hand_selector
	mouse_opacity = 0
	name = ""
	screen_loc = "5,1"
	icon_state = "hand_selector"
/obj/hud_indicator/hand_selector/update(mob/M)
	if(M:hand)
		src.screen_loc = "5,1"
	else
		src.screen_loc = "7,1"

/obj/hud_indicator/hp
	name = "health condition"
	icon_state = "normal"
	screen_loc = "15,14"
/obj/hud_indicator/hp
/obj/hud_indicator/hp/update(mob/M)
	switch(M:hepe)
		if(1 to 20)
			src.icon_state = "heartattack_plus"
		if(21 to 40)
			src.icon_state = "heartattack"
		if(41 to 60)
			src.icon_state = "fastbeat"
		if(61 to 80)
			src.icon_state = "mediumbeat"
		else
			src.icon_state = "normal"



/obj/hud_indicator/eupho
	icon = 'grafon/neekoUI_large.dmi'
	name = "euphoria"
	icon_state = "eupho_0"
	screen_loc = "15,11"
/obj/hud_indicator/eupho
/obj/hud_indicator/eupho/update(mob/M)
	if(M:euphoria < -5)
		src.icon_state = "eupho_bad"
	else if(M:euphoria < 10)
		src.icon_state = "eupho_0"
	else if(M:euphoria < 50)
		src.icon_state = "eupho_10"
	else if(M:euphoria < 75)
		src.icon_state = "eupho_50"
	else if(M:euphoria < 100)
		src.icon_state = "eupho_75"
	else if(M:euphoria < 110)
		src.icon_state = "eupho_100"
	else
		src.icon_state = "eupho_150"


/obj/hud_indicator/calm
	name = "panic"
	icon_state = "medalert"
	screen_loc = "15,15"

/obj/hud_indicator/calm

/obj/hud_indicator/calm/update(mob/M)
	if(M:calm < 10)
		src.icon_state = "PANIC"
	else if(M:calm < 15)
		src.icon_state = "WOKE"
	else if(M:calm < 20)
		src.icon_state = "highalert"
	else if(M:calm > 20)
		src.icon_state = "noalert"
	else
		src.icon_state = "medalert"


/obj/hud_indicator/hunger
	icon_state = "hunger_200"
	screen_loc = "15,13"

/obj/hud_indicator/hunger

/obj/hud_indicator/hunger/update(mob/M)

	if(M:hunger <= 0)
		src.icon_state = "hunger_0"
	else if(M:hunger < 50)
		src.icon_state = "hunger_10"
	else if(M:hunger < 100)
		src.icon_state = "hunger_50"
	else if(M:hunger < 200)
		src.icon_state = "hunger_100"
	else
		src.icon_state = "hunger_200"

/obj/hud_indicator/libido
	name = "libido"
	icon_state = "libido_0"
	screen_loc = "15,10"
/obj/hud_indicator/libido
/obj/hud_indicator/libido/update(mob/M)
	if(M:libido <= 0)
		src.icon_state = "libido_0"
	else if(M:libido <= 50)
		src.icon_state = "libido_25"
	else if(M:libido <= 75)
		src.icon_state = "libido_50"
	else if(M:libido < 100)
		src.icon_state = "libido_high"
	else
		src.icon_state = "lenny"

/obj/hud/proc/draw_morda()





























	var/M1 = new /obj/morda/metal()
	M1:screen_loc = "4,1"
	src:mymob:client:screen += M1

	var/M2 = new /obj/morda/metal/left()
	M2:screen_loc = "8,1"
	src:mymob:client:screen += M2

	var/M3 = new /obj/morda/metal/right()
	M3:screen_loc = "9,1"
	src:mymob:client:screen += M3

	var/M4 = new /obj/morda/metal/left()
	M4:screen_loc = "14,1"
	src:mymob:client:screen += M4

	var/M5 = new /obj/morda/metal/right()
	M5:screen_loc = "15,1"
	src:mymob:client:screen += M5

	var/K1 = new /obj/morda/metal/kromka()
	K1:screen_loc = "14,15 to 14,10"
	src:mymob:client:screen += K1

	var/K2 = new /obj/morda/metal/kromka_bottom()
	K2:screen_loc = "15,9"
	src:mymob:client:screen += K2

	var/K3 = new /obj/morda/metal/kromka_angle()
	K3:screen_loc = "14,9"
	src:mymob:client:screen += K3
