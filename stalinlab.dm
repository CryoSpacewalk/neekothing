/obj/machine/gibber
	name = "Biomechanics body departer"
	desc = "A thing for departing dead bodies."
	icon_state = "gibber"
/obj/machine/gibber{anchored = 1; bomb_proof = 50}
/obj/machine/podstand{density = 1; icon = 'grafon/device.dmi'; name = "pod stand"; icon_state = "podstand"}
/obj/machine/podstand{anchored = 0; wrenchable = 0}
/obj/machine/node
/obj/machine/grimore{icon = 'grafon/furniture.dmi'; icon_state = "cult"; name = "Demonic research Machinery"; desc = "A part of strange machinery decided to research demonic runes. It is radioactive, so be careful."; var/G = null; var/atom/movable/C}
/obj/machine/grimore/verb/reject()

	set name = "Reject contents"
	set src in view(1)

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate this weird thing!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	usr << "You reject the contents from the machine."
	if(src.G)
		src.G:loc = loc
		spawn(0)
			src.G = null

	if(src.C)
		src.C:loc = loc
		spawn(0)
			src.C = null

/obj/machine/grimore/operate()

	attack_hand()


/obj/machine/grimore/attack_by(obj/A)
	if(istype(A, /obj/item/grimore))
		usr << "\blue You load a demonic grimore into your [src.name]"
		A:loc = src
		src.G = A
		spawn(0) usr.delitem()

	if(istype(A, /obj/item/readable/cult))
		usr << "\blue You load a demonic runic slab into your [src.name]"
		A:loc = src
		src.C = A
		spawn(0) usr.delitem()

/obj/machine/grimore/attack_hand()




	if(!usr.candofun)
		usr << "\red NO"
		return

	for(var/mob/M in range(10, src))

		if(M.mat == "flesh")
			M.damaga(3, "organ")
			if(M.energyprotect < 20 && M.hepe > 0)
				M << "\red You feel a bit nervous..."
				M.damaga(15 - round(M.energyprotect / 3), "burn")

				if(prob(M.epilepsy * 3) && M in viewers(src))
					M.seizure(5)

				if(M.energyprotect < 10 && prob(33))
					M << "\red The world is so blurry..."
					M.epilepsy += 4
		else
			if(!istype(M, /mob/ghost))
				M << "\red You feel a bit nervous..."
				M.damaga(80, "burn")

	for(var/obj/putin/P in range(20, src))
		P.biodmg(20)

	for(var/obj/bio/amoeba/A in range(20, src))
		A.biodmg(20)

	for(var/obj/bio/weed/W in range(30, src))
		W.grassdmg(50)



	if(G)
		if(prob(33))
			usr << "The grimore glows for a second. Maybe it is now somewhat active?"
			src.G:s_charged = pick(spells)
			if(prob(10 + usr.psi))
				spawn(20) usr << "\red Something whispers in your head. It says [G:s_charged:spl]"
		else
			if(prob(50 + usr.cult * 10))
				usr << "\blue You try to understand weird runes, but nothing happens. Maybe one more time?"
			else

				usr << "\red \bold Just looking on those damned runes makes you extremely tired."
				usr.calm += 10
				usr.euphoria -= 10

	if(C)
		if(prob(50))
			usr << "You try to de-cypher weird runes on this rock, but fail. Maybe one more time?"
			return
		else
			if(prob(50))
				var/R = pick(machinae_rituals)
				usr << "\blue Now you know a spellcode: [R:codename]"
			else if(prob(50))
				var/R = pick(reactions_avaible)
				usr << "\blue Now you know a chem recipe: [R:id]"
			else
				var/rad_clr = pick("red", "green", "blue")
				var/P
				switch(rad_clr)
					if("red")
						P = pick(green_morphable)
						usr << "Now you know that [P] component of star dust will turn into [red_morphable[P]] then exposed to radiation while being under red lighting."
					if("green")
						P = pick(green_morphable)
						usr << "Now you know that [P] component of star dust will turn into [green_morphable[P]] then exposed to radiation while being under green lighting."
					if("blue")
						P = pick(blue_morphable)
						usr << "Now you know that [P] component of star dust will turn into [blue_morphable[P]] then exposed to radiation while being under blue lighting."

			if(prob(66))
				show_message("\red \bold [C:name] falls into dust!")
				C = null

