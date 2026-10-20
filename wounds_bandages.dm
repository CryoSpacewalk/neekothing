// Recovered from compiled neek.dmb (9 procs)

/mob/proc/wound()







	if(src.wounds < 5 && (src.class == "man" && src.mat == "flesh"))
		show_message("\red [src.name] is bleeding!")
		bleed(1)
		src << "\red You're wounded!"
		wounds++
		var/W = new /obj/overlay/wound(src)
		W:layer = -4
		W:icon_state = "wound[src.wounds]"
		src.overlays += W

/mob/proc/woundcure(power)
	if(src.wounds > 0)
		src << "\green Your wounds feel better."
		var/i = min(power, src.wounds)
		while(i)
			var/W = new /obj/overlay/wound(src)
			W:layer = -4
			W:icon_state = "wound[src.wounds]"
			src.overlays -= W
			src.contents -= W
			src.wounds--
			sleep(0)
			del(W)
			i--

/mob/proc/woundcheck()
	if(prob(6 * src.wounds) && src.painless < 2)
		src << "\red Your wounds hurt!"
		src.torment(2 + round(src.wounds / 1.5))
	if(prob(4 * src.wounds))
		src << "\red You're bleeding!"
		src.bleed(rand(1, 3), "organ")

/mob/proc/sickcheck()







	if(src.flu)
		src.coughy += 5
		if(prob(2))
			src << "\red You feel sick. Why not visit a doctor?"
			thrill += 6
	if(src.coughy > 5 && prob(src.coughy))
		src.cough()
		src.coughy = 0
	if(src.syphilis && prob(50))
		src.damaga(1, "organ")
		if(prob(50))
			src << "\red Your limbs hurt."
			src.limb_damage(2, 1, 0)
		if(prob(10))
			src.add_chem("corpse rot", "corpse rot", 1.2, 0)
	if(src.aids)
		if(src.aids_potency < 10)
			src.aids_potency++
		if(src.aids_potency > 5 && prob(src.aids_potency))
			src.damaga(1, "organ")
			if(prob(1))
				src << "\red \bold You feel like as if something was fucking up your body tissues."
				src.syphilis = 1
			if(prob(3) && !src.immune)
				src.flu = 1
				src << "\red \bold You feel a scratch in your throat."

/mob/proc/cough()
	show_message("\red [src.name] coughs!")
	if(item && prob(33))
		src.dropitem(src.item)
	if(src.flu && (src.aids || prob(50)))
		src << "\red A blood comes in your throat!"
		src.damaga(2, "organ")
	for(var/mob/M in range(1, src))
		if(!src.immune && (src != M && (M.chemprotect < 8 && (M.aids || prob(70 - M.chemprotect * 5 - M.luck)))))
			M << "\red You feel sick."
			M.flu = 1

	if(prob(10))
		var/H = new /obj/harch(src.loc)
		if(flu)
			H:sick = 1

/obj/blood/New()






	icon_state = "blood[rand(1, 5)]"


/obj/effect/blood_spring/New()





	..()
	spawn(6) del(src)

/mob/proc/bleed(dmg, dmgtype = "brute")
	new /obj/effect/blood_spring(src.loc)
	damaga(dmg, dmgtype)
	new /obj/blood(src.loc)


/obj/item/medical/bandage
	dmg = 0
	charges = 5
	name = "bandage pack"
	desc = "A self-applicable bandage pack. Even a monkey can use it to cure some wounds! 5 charges left."
	icon_state = "bandage"

/obj/item/medical/bandage

/obj/item/medical/bandage/single
	charges = 1
	name = "emergency bandage pack"
	desc = "A self-applicable bandage pack. Even a monkey can use it to cure some wounds! 1 charges left."
/obj/item/medical/bandage/single
/obj/item/medical/bandage/attack(atom/A)
	var/M; if(istype(A, /mob))
		M = A
		if(M:wounds && M:mat == "flesh")
			show_message("\green [usr.name] bandages some of the [M:name] wounds.")
			M:woundcure(1)
			if(charges > 1)
				charges--
				desc = "A self-applicable bandage pack. Even a monkey can use it to cure some wounds! [charges] charges left."
			else

				spawn(0) usr.delitem()
		else
			usr << "\blue Looks like this patient don't need any wound treatment"
			return
	else
		return