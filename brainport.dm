// Recovered from compiled neek.dmb (11 procs)

/mob
	var/brainport
/mob/proc/brainstuff()
	set name = "Insert/remove brain module"
	set category = "Item interraction"

	if(usr.item && !src:brainport)

		var/havehead = 0
		if(src.limbs:len)
			for(var/obj/limb/L in src.limbs)
				if(L.name == "head")
					havehead = 1

		if(havehead)

			if(istype(usr.item, /obj/item/device/brainport))
				src:brainport = usr.item
				brainport:on_insert(usr)




				usr.delitem()
				usr << "You stick [src:brainport:name] right into your brain. Ew-w-w."
			else if(!(usr.item == null))
				usr << "\red You can only stuff your brain with brain modules. Oh, and drugs, of course."
		else

			usr << "\red \bold You don't have a head and can't insert brain modules!"

/mob/proc/brainremoval()
	if(src:brainport && !usr.item)
		src:brainport:on_removal(usr)
		src.item = src:brainport
		src:brainport = null
		src << "You carefully remove your brain module."




		return

/mob/proc/brainremoval_forced()
	if(src:brainport)




		brainport:on_removal(usr)
		brainport:loc = src.loc
		src:brainport = null
		return

/obj/button/brain
	name = "brain port"
	icon_state = "brainport"
	screen_loc = "10,1"

/obj/button/brain
/obj/button/brain/default_action()
	usr.brainstuff()


/obj/item/device/seeker_raw/attack_by(obj/I)



	if(istype(I, /obj/item/electronics/core/targeting) || istype(I, /obj/item/electronics/targeting))
		usr << "\blue You finish your seeker module."
		if(istype(src.loc, /turf))
			new /obj/item/device/brainport/seeker(src.loc)
		else
			new /obj/item/device/brainport/seeker(loc:loc)
		spawn(0)
			usr.delitem()
			del(src)

/obj/item/device/brainport/proc/on_insert(mob/M)


/obj/item/device/brainport/proc/on_removal(mob/M)

/obj/item/device/brainport/tantric/on_insert(mob/M)














	M += /mob/proc/dash_eupho

/obj/item/device/brainport/tantric/on_removal(mob/M)
	M -= /mob/proc/dash_eupho


/obj/item/device/brainport/radio
	plastic_need = 3
	silicon_need = 1
	name = "telepathy brain module"
	desc = "This thing allows you to send and receive telepathic messages. However, one with mundane psionic potency can only communicate within one Z-level."
	icon_state = "radio"

/obj/item/device/brainport/radio
/obj/item/device/brainport/seeker
	plastic_need = 5
	silicon_need = 2
	name = "seeker module"
	desc = "This thing greatly improves your sight. Sticking it in your brain will cause minor organ damage, but enchanced perception worths it, right?"
	icon_state = "seeker"
/obj/item/device/brainport/seeker
/obj/item/device/brainport/seeker/on_insert(mob/M)
	M << "\red Your head begin to ache as you insert [src.name]."
	M:damaga(2, "organ")
	M:euphoria -= 5
	M:client:true_view = world.view + 3
	M:client:view = M:client:true_view

/obj/item/device/brainport/seeker/on_removal(mob/M)
	M:client:true_view = world.view
	M:client:view = M:client:true_view
