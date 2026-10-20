/obj/seal{pixel_x = -32; pixel_y = -32; luminosity = 1; icon = 'grafon/perun.dmi'; name = "Sigillum Dei"; icon_state = "psi_pentacle"; desc = "A diagram from some old book, this thing appeal to the attention of unknown entity residing somewhere really far away from here, remaining fully unreachable. For some reason, this being or substance will serve as a buffer between observer and psionic storm."; var/obj/signer1 = null; var/on = 1}
/obj/psi_poebota/Crossed(atom/A)






	if(istype(A, /mob))
		var/M = A
		M:psi = 40


/atom/proc/psion()











	var/tloc

	if(istype(src, /atom/movable))
		tloc = src.loc
	else

		tloc = src

	for(var/atom/A in range(tloc, src.psi_radius))

		if(istype(A, /turf))
			if(prob(15) && A.density)
				new /obj/delusion(A)
			if(prob(10) && !A.density)
				new /obj/delusion(A)

		if(A)
			if(A.alticon && !A.alted)
				if(!A.fsticon)
					A.fsticon = A.icon_state
				spawn(0)
					A.icon_state = A.alticon
					spawn(0)
						A.alted = 1
					spawn(20)
						A.icon_state = A.fsticon
						A.alted = 0

/mob/proc/psicheck()















	if(src:clothes:nopsi)
		return

	if(!src.client)
		return

	if(src.psi)
		src.psi_radius = 1 + round(src.psi / 10)
	else
		src.psi_radius = 0

	src.psion()

	if(src.psi < 40)
		src.tempora--
	if(prob(src.psi / 5))
		src.tempora++

	if(src.psi == 0)
		src.tempora = 0

	src.depthui = src.tempora

	if(src.tempora)
		spawn(3) src.psicheck(src.tempora)
	else

		client:verbs -= /client/proc/fieldterror
		src.psiactive = 0

/mob/proc/turnpsi(t)





	if(src:clothes:nopsi)
		return

	if(!src.client)
		return

	if(src.psiactive)
		return

	src.psiactive = 1
	client:verbs += /client/proc/fieldterror

	src.tempora = t

	src.psicheck()

/atom/proc/psisprite()



















	if(!src.alted)

		src.fsticon = src.icon_state

	src.altclock++

	src.alted = 1

	src.icon_state = src.alticon

	spawn(0)

		src.psioff_clock()

/atom/proc/psioff_clock()

	if(src.altclock)

		src.altclock--

		spawn(3) src.psioff_clock()
	else


		if(src.alted)

			src.alted = 0
			src.icon_state = src.fsticon

/obj/seal/proc/flip()















	src.signer1 = null
	if(src.on)
		src.on = 0
		src.icon_state = "psi_pentacle_off"
	else

		src.on = 1
		src.icon_state = "psi_pentacle"


/obj/seal/attack_by(obj/I, mob/M)
	if(istype(I, /obj/item/tool/cross))
		if(!src.signer1)
			M << "\red You sign The Seal. Now you need somebody else to approve the activation."
			src.signer1 = M
		else if(src.signer1 != M)
			M << "\red \bold You approve the activation of The Seal."
			src.flip()


/obj/psistorm/New()











	src.psiactivity()

/obj/psistorm/proc/psiactivity()

	var/seald = 0

	for(var/obj/seal/S in range(3, src.loc))

		if(S.on)
			seald = 1

	for(var/mob/M in viewers(src))

		if(!seald)

			if("chromosome" in M.mutations)
				M << "You don't feel anything strange near this thing."
			else
				if(M:clothes:nopsi)
					M << "Looks like you're protected from psistorm influence."
				else


					if(prob(M.epilepsy - M.psi))
						M.seizure(12)

					if(M.psi <= 10 && prob(33))
						M << "\red The world is so blurry..."
						M.epilepsy += 2

					if(prob(50 - M.psi * 2))
						M.calm -= pick(1, 2)

					if(prob(25 - M.psi))
						M.delirium++

					if(prob(1))
						M.psi++

					if(prob(5))
						M << "\red You stare into the storm."
						M.stun(pick(1, 2, 3, 4))
						M.psi += 3

					if(prob(M.psi * 2) && !M.psiactive)
						M.turnpsi(300 + M.psi * 40)

			if(prob(2 + seald * 18))
				M << "\red You hear a voice in your head:"
				M << "<font color = [rc()]>[pick("Damn, NOW I need some piracetam. And a fuckload of sedatives. And a new pants.", "Where is my weed?", "The law is reason, free from passion", "Who are you? I didn't invite you. Get the fuck out.", "mI shtiface drnuk ohh llol", "Love is the law, love under will", "Weed is not a drug", "Damn, too many methox again", "I'll never smoke this shit again", "Man, you SHOULD try this stuff", "Well, somebody finally wired up the solars. Let's run through the potentor", "Somebody, call a doctor", "Goddamn potentor is off again", "Grecha? Without tropic?", "OH GOD MY LEG", "I can't see a thing, help", "But since you are like lukewarm water, neither hot nor cold, I will spit you out of my mouth!", "")]</font>"

			if(prob(5))
				M.calm--

	spawn(pick(1, 5, 10, 15, 20, 30, 40)) src.psiactivity()


/obj/delusion/New()






	src.icon_state = "color_psi[rand(1, 4)]"
	for(var/mob/M in viewers(src))
		if(M.epilepsy && prob(6))
			M << "\red \bold This colored things are too bright!"
			M.seizure(5)
	spawn(3) del(src)


/client/proc/fieldterror()




	set name = "Goddamn Psiterror"
	set category = "Psiterror"
	if(world.time - src.mob.fieldterror_last_used < src.mob.fieldterror_cooldown)
		src << "\red You're spamming your power too much."
		return
	if(src.mob.euphoria < 33)
		src << "\red You have to feel awesome to do things like this!"
		return
	src.mob.euphoria -= 33
	for(var/mob/M in range(src.mob.psi_radius))
		if(M != src.mob)

			if("chromosome" in M.mutations)
				M << "\blue You feel ticklish a bit. And you surely don't know why everybody around is so worried."
			else if(M:clothes:nopsi)
				M << "\blue Something is trying to rape your mind, but you're protected against stuff like this."
			else
				M << "\red You see a fuckload of horrible visages dancing around you."
				if(M.calm >= 10)
					M.calm -= 20
				else
					M.calm -= 15
				M.euphoria -= 10
				if(prob(66))
					M.thrill += 4
				M.stun(rand(2, 5))
				if(prob(33))
					M.delirium += 15
	src.mob.fieldterror_last_used = world.time


/atom
	var/psi_radius = 0
	var/psi = -1
	var/psiactive = 0
	var/alticon = null
	var/fsticon = null
	var/alted = 0
	var/altclock = 0
