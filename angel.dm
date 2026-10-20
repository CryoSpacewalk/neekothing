/mob/angel
	icon = 'grafon/clothing_overlays.dmi'
	cult = 1
	empowered = 1
	luck = 50
	icon_state = "angel"
	name = "Malformed Angel"
	desc = "An insane humanoid creation of JHVH, overtaken and deformed by Stalin."
	var/bodiez = 0
/mob/angel
/mob/angel/New()
	src.verbs -= powahs
	src.toxdmg()
	src.adv_visuals()
	src.bodiez = rand(6, 8)
	sleep(0)
	src.limbs += new /obj/limb/head/recruit()

	src.verbs += /mob/verb/voices
	src.verbs += /mob/verb/psiterror

	src.verbs += /mob/verb/sublimation
	src.verbs += /mob/verb/gate_key


	src.toxdmg()


/mob/proc/angelize()





	var/A = new /mob/angel(src.loc)

	A:ckey = src.ckey

	sleep(0)

	A << "\red \bold You're an Angel, a powerful agent of Jehovah. Stalin've done some... research on you, mutilating both your body and your mind."
	A << "\red \bold However, you still remember what the Universe is drowning in sin. Sadly, but even the puriest beings on this station are bearing the Original Sin."
	A << "\red \bold You should be sure that at least [A:bodiez] sinners will not survive this shift. Your axe will tear their flesh and your psiterror powers will destroy their minds."
	A << "\red \bold Feel free to abuse sublimation of blood if you're short of euphoria to fuel your powers, but be sure not to kill yourself in process."
	A << "\red \bold Why the fuck are you still reading this? Go on your crusade!"

	var/realfname = pick("Juda", "Jozeph", "Iona", "Moses", "Abraham", "Haim")
	var/realsname = pick("Rabinovich", "Mayerstein", "Katz", "Baltershvin", "Axelson", "Herblum")
	A:realname = "[realfname] [realsname]"
	A:name = src.realname

	A:equip_clothes(new /obj/item/clothes/rags())
	A:equip_belt(new /obj/item/tool/axe/rusty())

	A:update_sprite()
	A:prof = null
	spawn(0) del(src)

/mob/verb/sublimation()



















	set category = "Angelic powers"
	set name = "Sublimation of blood"
	if(world.time - src.sublimation_last_used < src.sublimation_cooldown)
		return
	src << "\red \bold You feel a bit more happy as some your blood turns into heroin."
	src.damaga(25, "organ")
	src.euphoria += 20
	src.sublimation_last_used = world.time
	src.add_chem("heroin", "heroin", 0.1, 0)

/mob/verb/gate_key()




	set name = "The gate and the key"
	set category = "Angelic powers"
	if(world.time - src.gate_key_last_used < src.gate_key_cooldown)
		return
	if(src.euphoria < 25)
		src << "\red \bold You have to feel good to use this power!"
	src << "\blue \bold Yog-Sothoth is the gate. Yog-Sothoth is the key and guardian of the gate."

	src.euphoria -= 25
	src.gate_key_last_used = world.time

	for(var/obj/door/D in view(src))
		if(!D.fucked && !D.blocked)
			D.opened()


