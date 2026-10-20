// Recovered from compiled neek.dmb (6 procs)

/obj/overlay/clothes

/obj/overlay/noose
	layer = MOB_LAYER + 0.1
	icon = 'grafon/clothing_overlays.dmi'
	icon_state = "noose"

/mob/proc/noose(obj/N, mob/usurr)





































	if(prob(1))
		usurr << noosle_stehi
		if(src != usurr)
			src << noosle_stehi
	dir = 2
	src.parastunned = 1
	src.anchored = 1
	break_pull()
	if(src.stunned)
		var/I = new /icon(src.icon)
		I:Turn(-90)
		icon = I
		parastunned = 1
		update_sprite()
		stuntime = 5
	else
		src.parastunned = 1
		src.stun(5)
	var/NS = new /obj/overlay/noose(src)
	NS:layer = -2
	src.overlays += NS
	show_message("\red \bold [src.name] is hanged!")
	spawn(40)
		if(prob(luck / 4))
			funfacts += "[src.realname] was a lucky enough bastard to escape from the noose this round"
			show_message("\red The noose breaks!")
			src.overlays -= NS
			src.contents -= NS
			anchored = 0
			spawn(0) del(N)
		else
			hangedcount++
			if(hangedcount == 7)
				funfacts += "Lord loves the hanging - that's why He gave us necks"
				world << "[ruout("Господь нас создал с шеей; ведь вешать Он любил!")]"
				playmuzlo = 1
				world << sound('LordLovesaHanging.ogg', 0, 0, 666, 40)
				spawn(400)
					playmuzlo = 0
			var/A = new /obj/overlay/afterhang(src)
			A:layer = -2
			overlays += A
			overlays -= NS
			contents -= NS
			src.anchored = 0
			spawn(0) damaga(666, "organ")

/obj/structure/noose/verb/hangin()









	set name = "Hang the fucker up"
	set src in view(1)

	if(!usr.candofun)
		usr << "\red You're unable to hang people up!"
		return

	if(!usr.stunned)
		src.attack_hand(usr)

/obj/structure/noose/attack_hand(mob/usr)
	var/M = null
	for(var/mob/MB in src.loc)
		if(MB.class == "man" && (!MB.dead && !MB.parastunned))
			M = MB
	if(M)

		var/havehead = 0

		for(var/obj/limb/L in M:limbs)

			if(istype(L, /obj/limb/head))
				havehead = 1

		if(!havehead)
			usr << "\red You can't hang headless people!"
		else
			if(M == usr)
				var/answ = input("Are you sure you want to hang yourself up?") in list("Yes", "No")
				if(answ == "Yes" && usr:loc == src.loc)
					M:noose(src, usr)
			else
				if(M:stunned)
					M:noose(src, usr)
				else

					usr << "\red You have to stun this folk before hangin'!"
	else

		usr << "\red \bold You only can hang living humans and veterans!"


/obj/capspawn/attack_by(obj/I)












	src.tieto(I, usr)
	..()

/obj/proc/tieto(obj/I, mob/user)
	var/isused = 0
	var/tielist = list()
	if(istype(I, /obj/item/cable))
		var/C = I
		for(var/mob/M in src.loc)
			if(M.wired)
				isused = 1
			if(M.class == "man")
				tielist += M
		if(isused)
			user << "\red There's already somebody tied here!"
			return
		if(!tielist:len)
			user << "\red There's nobody to tie there!"
			return
		else
			var/mob/victim = pick(tielist)
			spawn(0)
				victim:wired = 1
				victim:tieobj = src
				funfacts += "[usr.realname] was into a BDSM stuff today!"
				victim << "\red \bold You're tied to [src.name] with the cable by [user:name]!"
				src.show_message("\red \bold [user:name] ties [victim:name] to the [src.name]!")
				victim:stun(5)
				spawn(0)
					C:cminus(1)

/mob/proc/untie()
	src << "\green \bold You're free-e-e-e-eee!"
	src.wired = 0
	src.parastunned = 0
	src.tieobj = null
	src.stun(2)
