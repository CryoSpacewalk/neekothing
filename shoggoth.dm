// Recovered from compiled neek.dmb (7 procs)

/obj/shoggoth
	density = 1
	icon = 'grafon/thingy.dmi'
	// ^ icon match was partial
	name = "The Manifestator"
	icon_state = "shoggoth"
	var/hitz = 4

/obj/shoggoth/New()

	src.shoggoth_lives()

/obj/shoggoth/examine()

	usr << "It looks weird, ьut... so <font color = [pick("red", "purple", "yellow", "green")]>[pick("Я", "R", "r", "#")]</font><font color = [pick("red", "purple", "yellow", "green")]>E</font><font color = [pick("red", "purple", "yellow", "green")]>A</font><font color = [pick("red", "purple", "yellow", "green")]>L</font>"
	usr.client.controlsfuck = 1
	for(var/i = 0, i < 10, i++)
		input("Select your role, plox.", "prof") in profavaible

/obj/shoggoth/attack_by(obj/I)
	if(I:veteranbane)
		usr << "[pick("Why do you fear?", "You don't want to know it?", "The truth hurts you, isn't it?", "Are you afraid of truth?", "If you stop it, I'll show you the true nature of things", "It isn't a good idea")][RRR()]"
		src.hitz--
		if(!src.hitz)
			var/T = loc
			T:icon_state = null
			T:alticon = null
			T:fsticon = null
			del(src)
		spawn(0) src.psyscream()
	else
		src.show_message("[usr.name] [pick("t", "T", "т")][pick("Я", "R")]IES T[pick("0", "o", "O", "()", "_")] [pick("H", "h", "н")]IT <font color = [pick("red", "purple", "yellow", "green")]>MA</font><font color = [pick("red", "purple", "yellow", "green")]>NI</font><font color = [pick("red", "purple", "yellow", "green")]>FE</font><font color = [pick("red", "purple", "yellow", "green")]>ST</font><font color = [pick("red", "purple", "yellow", "green")]>AT</font><font color = [pick("red", "purple", "yellow", "green")]>OR</font> witн [I:name] without A[pick("П", "n", "N", "И")]У effeСt")


/obj/shoggoth/proc/psyscream()
	for(var/mob/M in viewers(src))
		if(M:clothes:nopsi || "chromosome" in M.mutations)
			continue

		if(prob(50))
			M << "<font color = black>Your head hurts.</font>[RRR()]"

		if(prob(10))
			M << browse_rsc('triangle.jpg')
			M << browse("<img src=triangle.jpg>")

	var/hurrurs = list()
	for(var/mob/M in world)
		if(istype(M:brainport, /obj/item/device/brainport/radio) || (("tumor" in M.mutations) || (("tumor_eye" in M.mutations) || istype(src, /mob/robot) && (!M:clothes:nopsi && (!("chromosome" in M.mutations) && M.z == src.z)))))
			hurrurs += M

	if(hurrurs:len)
		for(var/mob/M in hurrurs)
			M << "The M[srnd()]a[srnd()]n[srnd()]i[srnd()]f[srnd()]e[srnd()]s[srnd()]t[srnd()]a[srnd()]t[srnd()]o[srnd()]r telesays, \bold \blue''Now you can see it too''"


/obj/shoggoth/proc/shoggoth_lives()
	if(prob(25))
		step_rand(src)

	if(prob(10))
		src.psyscream()

	for(var/turf/T in range(1, src))
		if(istype(T, /turf/space))
			T.icon_state = null
			T.alticon = null
			T.fsticon = null
		else
			T.icon_state = "shoggoth"
			T.alticon = "shoggoth"
			T.fsticon = "shoggoth"

	spawn(10) src.shoggoth_lives()

/proc/srnd()


	var/s = pick("#", "@", "^", "я", "_", "'", "+", "\bold ", "\red ", "\blue ", "\green ")












	if(prob(50))
		return s
	else
		return ""

/proc/RRR()
	if(prob(66))
		return ""
	else
		return "я"
