/obj/item/var/sharp = 0
/obj/item/var/beltable = 0
/obj/item/var/hidable = 0
/mob
	icon_state = "body"
	luminosity = 0
	anchored = 0;var/gib_eater = 0
	var/suit = new /obj/overlay/clothes
	var/stuntime = 0
	var/can_move = 1
	var/aids = 0
	var/mat = "flesh"
	var/class = "man"
	var/hand = 1
	var/spessman = 0
	var/hepe = 100
	var/hungertick = 0
	var/hunger = 400
	var/organdmg = 0
	var/brutedmg = 0
	var/burndmg = 0
	var/moustache = 1
	var/dead = 0
	var/realname = "Wasya"
	var/stopit = 0
	var/realkey
	var/toxins = 0




	var/blood_chem = list()
	var/prof
	var/galyni = /obj/hud_effect/party
	var/drunk = 0
	var/sleepy = 0
	var/says_xynta = 0
	var/item
	var/l_hand
	var/r_hand
	var/clothes
	var/armor = 0
	var/dmg = 3
	var/stunned = 0
	var/processing = 0





	var/container = list()
	var/accu = 50
	var/energyprotect = 0
	var/chemprotect = 0
	var/heatprotect = 0
	var/psychosis = 0
	var/protez = 0
	var/belt
	var/hidden
	var/hidden2
	var/pocket
	var/list/pocketaccess = new()
	var/limbs = list(new /obj/limb/r_hand, new /obj/limb/l_hand, new /obj/limb/r_leg, new /obj/limb/l_leg)
	var/view_obj
	var/kypa = 0
	var/empowered = 0
/mob/verb/ooc(msg as text)

	set name = "OOC"
	world << "\color(200,50,200) \bold OOC: [usr.ckey]: [rhtml_encode(msg)]"
/mob/verb/pullmob()
	if(!(src == usr) && !usr.stunned)
		set category = "Object"
		set name = "Grab someone"
		set src in view(1)
		if(src.stunned == 1 || src.stunned == 0 && prob(50 + usr.luck))
			for(var/mob/M in view(usr))
				M << "\red [usr] grabs [src]!"
			src.loc = usr.loc
		else
			for(var/mob/M in view(usr))
				M << "\red [usr] falls to grab [src]!"
/mob/verb/stop_pulling()
	set category = "Object"
	for(var/atom/movable/A in range(1, usr))
		if(A == usr.pulling)
			A.break_pull()
/mob/verb/pocket()
	set name = "Put key in the pocket"
	set category = "Item interraction"
	if(!usr.pocket && (istype(usr.item, /obj/item/key) && src.clothes))
		usr << "\blue You put your [usr.item] in your uniform pocket."
		usr.pocket = usr.item
		usr.delitem()
/mob/verb/stripmob(M as mob)
	if(M:clothes && (usr.canstrip && (!usr.stunned && M != usr)))
		set name = "Strip others"
		set category = "Item interraction"

		if(M in view(1, usr))
			M << "\bold [usr.name] tries to strip you!"
			for(var/mob/MB in viewers(M))
				MB << "\bold [usr.name] tries to strip [M:name]!"
			spawn(40)
				if(M in view(1, usr))
					for(var/mob/MB in viewers(M))
						MB << "\bold [usr.name] strips [M:name]!"
					if(collar)
						src << "\blue \bold OH FUCK YEA FREEDOM"
						show_message("\blue [src.name] is no longer enslaved!")
						M:deslave()
					if(stuncollar)
						src << "\blue \bold OH FUCK YEA FREEDOM"
						show_message("\blue [src.name] is no longer enslaved!")
						M:destun()
					M:clothes:loc = M:loc
					M:unwearclothes()
/mob/verb/droppocket()
	set name = "Shake one's suit pockets"
	if(!(src.clothes == null) && !usr.stunned)
		set category = "Item interraction"
		set src in oview(1)
		if(pocket == null && (hidden == null && hidden2 == null))
			src << "\bold [usr] shakes your suit's pockets without any effect."
		else
			for(var/mob/M in view(usr))
				M << "Something falls out of [src]'s pocket."
			if(pocket)
				src << "\blue The key falls out of your pocket!"

				src.pocket:loc = loc
				pocket = null
			src.unhiditem()
			src.unhiditem2()

/mob/verb/drop()




	set name = "Drop item"
	set category = "Item interraction"
	src.dropitem(usr.item)
/mob/verb/wearitem()
	set name = "Wear item"
	set category = "Item interraction"
	var/C = usr.item
	if(istype(usr, /mob/rooster) || (istype(usr, /mob/ghost) || istype(usr, /mob/robot)))
		usr << "\red You can't wear clothing!"
	else if(istype(usr.item, /obj/item/clothes))
		if(C:evil && (!src.cult && src:abyss < 0))
			src << "\red \bold This strange suit doesn't fit your body!"
			return
		else if(usr.clothes == null)
			src.wear(usr.item)
			usr.delitem()
		else
			usr << "You already wearing something!"
	else if(usr.item && !src.clothes)
		usr << "You can't wear it!"
/mob/verb/belt()
	set name = "Put item on the belt"
	if(!usr.item)
		return
	if(usr.clothes)
		set category = "Item interraction"
		src.beltitem(usr.item)
	else
		usr << "\red You have no clothes on!"
/mob/verb/hidpocket()
	set name = "Put item in the left inner pocket"
	if(!usr.item)
		return
	if(usr.clothes)
		set category = "Item interraction"
		src.hiditem(usr.item)
	else
		usr << "\red You have no clothes on!"

/mob/verb/hidpocket2()

	set name = "Put item in the right inner pocket"
	if(!usr.item)
		return
	if(usr.clothes)
		set category = "Item interraction"
		src.hiditem2(usr.item)
	else
		usr << "\red You have no clothes on!"
/mob/verb/take_from_belt()
	if(!usr.stunned)
		set name = "Take the item from the belt"
		set category = "Item interraction"
		src.unbeltitem()
/mob/verb/take_from_hidden()
	if(!usr.stunned)
		set name = "Take the item from the left inner pocket"
		set category = "Item interraction"
	src.unhiditem()
/mob/verb/take_from_hidden2()
	if(!usr.stunned)
		set name = "Take the item from the right inner pocket"
		set category = "Item interraction"
	src.unhiditem2()
/mob/verb/strip()
	if(!usr.stunned)
		set name = "Unwear item"
		set category = "Item interraction"
	src.unwearitem()
/mob/verb/punchself()
	if(!usr.stunned)
		set name = "Suicide"
		if(usr.hepe > 0)
			usr << "\red You hit yourself!"
			src.damaga(10, "brute")

/mob/verb/disay(msg as text)











	set name = "telesay"

	if(istype(src, /mob/ghost/observer))
		src << "\red \bold You can't speak in any maner!"
		show_message("[src.name] howls silently.")
		return

	if(!src.canspeak)
		return

	var/hurrurs = list()


	if("chromosome" in src.mutations)
		usr << "\red \bold You can't telespeak due to your mutation!"
		return
	else
		if(clothes:nopsi)
			usr << "\red \bold Your clothes are blocking your telepathic messages!"
			return
		else
			if(istype(src:brainport, /obj/item/device/brainport/radio) || (("tumor" in src.mutations) || (("tumor_eye" in src.mutations) || istype(src, /mob/robot))))

				if(src.psi > 10)

					for(var/mob/M in world)
						if(!("chromosome" in M.mutations))
							hurrurs += M
				else

					for(var/mob/M in world)
						if((istype(M:brainport, /obj/item/device/brainport/radio) || (("tumor" in M.mutations) || (("tumor_eye" in M.mutations) || istype(src, /mob/robot)))) && (!("chromosome" in M.mutations) && M.z == src.z))
							hurrurs += M
			else

				usr << "\red \bold You don't have a telepathy module neither special mutation so you cannot into telespeech!"
				return

	if(hurrurs:len)
		for(var/mob/M in hurrurs)

			if(M:clothes:nopsi)
				M << "\red Somebody is trying to telespeak with you, but your clothing is blocking any incoming psionic messages."
			else

				M << "[src.realname] telesays, \bold \blue''[rhtml_encode(transform_to_xynta(msg, 2 + round(says_xynta / 10)))]''"

/mob/verb/say(msg as text)













	var/haloper

	if(!canspeak)
		src << "\red \bold You can't speak in any maner!"
		show_message("[src.name] howls silently.")
		return

	for(var/datum/reagent/R in src.blood_chem)
		if(R.id == "haloperidol")
			haloper = R.amount
		if(R.id == "aminazine")
			haloper = round(R.amount / 2)
	if(!msg)
		return
	if(src.sleeps)
		return


	var/hurrurs = new /list()












	for(var/mob/M in hearers(src.loc))
		if(!M.sleeps)
			hurrurs += M

	if(prob(haloper * 15 - src.luck * 1.5))
		if(prob(25))
			src << "\red You fail to open your mouth."
		else

			spawn(0)
				for(var/mob/M in hurrurs)
					M << "[src.realname] slurs, \bold''[rhtml_encode(transform_to_xynta(msg, 25 + round(says_xynta / 10)))]''"
	else if(hepe > 0 || mat == "ether")
		if(prob((drunk - 1) * 15 - round(luck / 4)))
			for(var/mob/M in hurrurs)

				switch(mat)
					if("flesh")
						M << "[realname] slurs something that you cannot understand."
					if("plastic")
						M << "[realname] beeps something that you cannot understand."
					if("ether")
						M << "<font color = purple>[realname] hisses something that you cannot understand.</font>"
		if(says_xynta && src.mat == "flesh")


			for(var/mob/M in hurrurs)



				M << "[src.realname] says, \bold''[rhtml_encode(transform_to_xynta(msg, 10 + round(says_xynta / 10)))]''"
			for(var/obj/radio/station/S in range(1, src))
				S.broadcast(rhtml_encode(msg))
		else
			for(var/mob/M in hurrurs)

				var/distort = null

				if(prob(M.distortion))
					distort = pick("\italic", "\green", "\blue", "\red", "\yellow", "\navy", "\magenta")
					if(prob(50))
						M << "[distort] Makes some strange sounds while trying to speak!"
						M << pick('sounds/beep.wav', 'sounds/hoot.wav', 'sounds/necrowind.ogg', 'sounds/drone.wav')

				switch(mat)
					if("flesh")
						if(src.drunk > 1)
							if(prob(src.drunk * 5))
								M << "[realname] slurs, \bold [distort] ''[rhtml_encode(msg)], [pick("fuck it", "fuck you", "fuck", "fucking shit")]''"
							else
								M << "[realname] slurs, \bold [distort] ''[html_encode(msg)]''"
						else
							M << "[realname] says, \bold [distort] ''[rhtml_encode(msg)]''"
					if("plastic")
						M << "[realname] beeps, \bold [distort] ''[rhtml_encode(msg)]''"
					if("ether")
						M << "<font color = purple>[realname] hisses, \bold [distort] ''[rhtml_encode(msg)]''</font>"
			for(var/obj/radio/station/S in range(1, src))
				S.broadcast(msg)
/mob/verb/count(cnt as num)
	if(usr.hepe > 20 || usr.hepe <= 20 && (usr.hepe > 0 && prob(25)))
		for(var/mob/M in view(usr))
			M << "[usr] counts to [cnt]"

/mob/ghost
	density = 0
	icon_state = "nope"
	alticon = "gghost"
	mat = "ether"
	hepe = -100
	dead = 1
	casts_shadow = 0

/mob/ghost/New()


















	spawn(5)
		src.z = 2
	spawn(5)
		src.x = 5
	spawn(5)
		src.y = 5
	spawn(5)

		src.verbs -= powahs
	src.adv_visuals()

	spawn(0)
		if(src.client)
			client:verbs += /client/proc/darkness

/client/proc/darkness()
	set name = "Blackout"
	set category = "Commands"
	for(var/obj/lamp/L in view(src.mob))
		L.turnoff_temp(50)

/client/proc/darkness_lesser()
	set name = "Lesser blackout"
	set category = "Commands"
	for(var/obj/lamp/L in view(src.mob))
		L.turnoff_temp(10)




/mob/rooster{icon = 'grafon/rooster.dmi'; hepe = 25; class = "rooster"; clothes = null



	limbs = list(new /obj/limb/rooster/r_hand, new /obj/limb/rooster/l_hand, new /obj/limb/rooster/r_leg, new /obj/limb/rooster/l_leg)
	armor = 0;name = "Rooster"}
/mob/rooster/New()
	src.toxdmg()
	src.spacedmg()
	src.update_sprite()
	src.adv_visuals()
	src.dir = pick(1, 2, 8, 4)
	var/pogonyalo = pick("Manya", "Vasilisa", "Marusya", "Parashnik", "Petuhoed", "Petuhan", "Zashquarya", "Swinohvost", "Shepka", "Paukan", "Roosterok", "Skolzkeey", "Voed", "Kotowasiy")
	src.name = "rooster [pogonyalo]"
	src.realname = src.name
	src.move_random()
/mob/rooster/experimental
	hepe = 1
	hunger = 0

/mob/rooster/experimental

/mob/rooster/proc/move_random()
	if(src.dead)
		return

	if(prob(1))
		src.playsound('sounds/rooster.wav')
	if(prob(20) && src.stunned == 0)
		step(src, pick(1, 2, 8, 4))
	for(var/obj/item/reagent_container/consumable/I in src.loc)
		if(I)
			if(prob(25))
				var/chemsum = 0
				for(var/datum/reagent/R in I.reagent_list)
					chemsum += R.amount
				if(istype(I, /obj/item/reagent_container/consumable/plant))
					src.extract(I, src)
				spawn(0)
					I.transfer_to_mob(chemsum, src)
					src.show_message("\blue [src.name] consumes [I.name].")
					sleep(0)
					del(I)

	spawn(10)
		if(src.dead)
			return
		else
			src.move_random()

/mob/dm
	icon = 'start.dmi'
	key = "Nee"
/mob/dm
/mob/dm/verb/see_through_walls()
	sight = 16

/proc/isghost(mob/M)
	if(istype(M, /mob/ghost))
		return 1
	else
		return 0

/mob/proc/heal(healamount, dmgtype)
	switch(dmgtype)
		if("brute")
			if(src.brutedmg > healamount)
				src.brutedmg -= healamount
			else
				healamount = src.brutedmg
				spawn(0) src.brutedmg = 0
		if("burn")
			if(src.burndmg > healamount)
				src.burndmg -= healamount
			else
				healamount = src.burndmg
				spawn(0) src.burndmg = 0
		if("organ")
			if(src.organdmg > healamount)
				src.organdmg -= healamount
			else
				healamount = src.organdmg
				spawn(0) src.organdmg = 0
	spawn(0)
		if(100 - src.hepe >= healamount)
			src.hepe += healamount
		else
			src.hepe = 100
			src << "\green You feel fine."

/mob/proc/stun(stuntiem)











































	if(src.hepe <= 0)
		return
	var/meh = 0
	for(var/obj/item/I in src)
		if(istype(I, /obj/item/weapon/battleaxe/proton))
			meh = 1
	if((istype(src:brainport, /obj/item/device/brainport/tantric) || istype(src:brainport, /obj/item/device/brainport/seeker)) && (!src.parastunned && prob(33)))
		src.show_message("\red [src.name] avoids being stunned, thanks to his brain module!", "\blue Your brain module protects you from stunning.")
		meh = 1
	if(meh)
		return
	if(stunned == 0)
		stunned = 1
		src.stuntime = stuntiem
		spawn(0)

			src.drophands()
			if(src.mount)
				src.overlays -= mount:OL
				mount:loc = src.loc
				spawn(0)
					src.mount = null
			if(!src.parastunned)
				var/I = new /icon(src.icon)
				I:Turn(90)

				src.icon = I
				src.update_sprite(90)
			spawn(0)
				src.on_stun()
	else if(src.stuntime < stuntiem && !src.parastunned)
		src.stuntime = stuntiem

/mob/proc/on_stun()
	if(src.stuntime <= 0)
		stunned = 0
		if(!src.parastunned)
			var/I = new /icon(src.icon)
			I:Turn(-90)

			src.icon = I
			src.update_sprite()
		src.parastunned = 0
		spawn(0)
			return
	else
		src.stuntime -= 1
		spawn(10) src.on_stun()

/mob/proc/shake(tiem)






	while(tiem > 0)
		var/I = new /icon(src.icon)
		I:Shift(1, 3)
		src.icon = I
		sleep(2)
		I:Shift(2, 6)
		src.icon = I
		sleep(2)
		I:Shift(1, 3)
		I:Shift(8, 3)
		src.icon = I
		sleep(2)
		I:Shift(4, 6)
		src.icon = I
		sleep(2)
		I:Shift(8, 3)
		src.icon = I
		sleep(2)
		tiem -= 1
	src.on_stun()

/mob/proc/drophands()
	var/litem = src.l_hand
	var/ritem = src.r_hand
	if(src.l_hand && (!litem:cursed && !litem:merged))
		l_hand:loc = src.loc
		spawn(0) src.l_hand = null
	if(src.r_hand && (!ritem:cursed && !ritem:merged))
		r_hand:loc = src.loc
		spawn(0) src.r_hand = null
	spawn(0)
		if(src.item && (!item:cursed && !item:merged))
			dropitem(src.item)

/mob/proc/spacedmg()























	if(src.dead)
		return



	if(prob(10))

		if(src.z == 7)

			src << pick('sounds/hell1.wav', 'sounds/hell_demon.ogg')













	if(istype(src.loc, /turf/space))
		if(src.hepe > 0 && src.mat == "flesh")
			if(istype(src.clothes, /obj/item/clothes/space) || mount)
				spawn(10) src.spacedmg()
			else
				src << "\red You feel a pain from inside of yours!"
				src.damaga(6, "organ")
				src.damaga(2, "brute")
				src.damaga(2, "burn")
				if(prob(1) && (!prob(luck) && immune))
					src << "\red \bold Looks like running around without spacesuit gives you a cough."
					src.flu = 1

				spawn(10) src.spacedmg()
	else
		spawn(10) src.spacedmg()












/mob/proc/blind(tiem, msg = 1)
	if((istype(src:brainport, /obj/item/device/brainport/tantric) || istype(src:brainport, /obj/item/device/brainport/seeker)) && !src.sleeps)
		src.show_message("\red [src.name] keeps his sight clear, thanks to his brain module!", "\blue Your brain module protects you from blinding.")
		return
	if(!(src.sight == 1))
		src.sight = 1
		if(msg)
			src << "\red \bold Your eyes hurt!"
		spawn(tiem) src.sight = 0

/mob/proc/dropitem(obj/I = usr.item)
	if(src.item)
		if(istype(src.item, /obj/item))
			var/it = src.item
			if(it:merged)
				src << "\red It is a part of your body, you can't drop it!"
				return
			if(it:cursed)
				src << "\red You can't drop it. It's cursed."
				return
		I:loc = src.loc
		if(istype(I, /obj/item/tool/flashlight))
			src.sd_SetLuminosity(0)
			for(var/obj/item/tool/flashlight/F in src)
				if(F != I && F.on)
					src.sd_SetLuminosity(F.lum)




		src.delitem()

		return

/mob/proc/delitem()
	src.item = null
	if(hand)
		l_hand = null
	else
		r_hand = null
	del(src.item)

/mob/proc/beltitem(obj/I)




	if(src.belt)
		return
	if(I:size < 4)
		if(I:beltable)
			usr.belt = usr.item
			usr.delitem()
			usr << "Now carring something on the belt."
		else if(!(usr.item == null))
			usr << "\red This thing doesn't fit to the belt!"
	else
		usr << "\red This thing is too large for your belt!"

/mob/proc/hiditem(obj/I)
	if(src.hidden)
		return
	if(I:size < 3)
		usr.hidden = usr.item
		usr.delitem()
		usr << "Now carring something in the left inner pocket."
	else
		usr << "\red This thing is too large for your pocket!"

/mob/proc/hiditem2(obj/I)
	if(src.hidden2)
		return
	if(I:size < 3)
		usr.hidden2 = usr.item
		usr.delitem()
		usr << "Now carring something in the right inner pocket."
	else
		usr << "\red This thing is too large for your pocket!"

/mob/proc/unbeltitem()
	if(belt)
		if(istype(belt, /obj/item/tool/flashlight))
			src.sd_SetLuminosity(0)
			for(var/obj/item/tool/flashlight/F in src)
				if(F != belt && F.on)
					src.sd_SetLuminosity(F.lum)
		belt:loc = src.loc
		belt = null
		src << "Now carring nothing on the belt."
		return

/mob/proc/unhiditem()
	if(hidden)
		if(istype(hidden, /obj/item/tool/flashlight))
			src.sd_SetLuminosity(0)
			for(var/obj/item/tool/flashlight/F in src)
				if(F != hidden && F.on)
					src.sd_SetLuminosity(F.lum)
		hidden:loc = src.loc
		hidden = null
		src << "Now carring nothing in the left hidden pocket."
		return

/mob/proc/unhiditem2()
	if(src.hidden2)
		if(istype(src.hidden2, /obj/item/tool/flashlight))
			sd_SetLuminosity(0)
			for(var/obj/item/tool/flashlight/F in src)
				if(F != src.hidden2 && F.on)
					src.sd_SetLuminosity(F.lum)
		hidden2:loc = src.loc
		src.hidden2 = null
		src << "Now carring nothing in the right hidden pocket."
		return

/mob/proc/unwearitem()
	if(src.clothes && !src.item)
		if(src:clothes:cursed)
			src << "\red You can't remove it. It's cursed."
			return
		else
			src:clothes:attack_hand(src)
			src << "Now wearing nothing."
			return

/mob/proc/unwearclothes()
	if(src.clothes && clothes:cursed)
		src << "\red You can't take it off. It's cursed."
		return
	src.deslave()
	src.destun()
	src.armor = 0
	src.energyprotect = 0
	src.chemprotect = 0
	src.heatprotect = 0




	src.unbeltitem()
	src.unhiditem()
	src.unhiditem2()
	src.clothes = null
	if(moustache == 0 && (dead == 0 && hepe > 0))
		src.overlays += /obj/overlay/moustacheless
	if(src.name == "Unknown")
		src.name = src.realname
	if(pocket)
		pocket:loc = src.loc
		pocket = null
		pocketaccess = null
		show_message("Something falls out of [src]'s pocket.", "\blue The key falls out of your pocket!")
	spawn(0) src.update_sprite()

/mob/proc/update_contents(obj/O)
	if(src.item == O)
		src.item = null
	else if(src.pocket == O)
		src.pocket = null
	else if(src.belt == O)
		src.belt = null
	else if(src.hidden == O)
		src.hidden = null
	else if(src.hidden2 == O)
		src.hidden2 = null
	else if(src.clothes == O)
		src.unwearclothes()
	else if(src:brainport == O)
		src.brainremoval()

/mob/verb/change_hands()
	usr << "\blue Changed [src.hand ? "left hand" : "right hand"] to [src.hand ? "right hand" : "left hand"]."
	usr.swap_hands()

/mob/proc/swap_hands()
	if(src.hand)
		src.item = src.r_hand
	else
		src.item = src.l_hand
	src.hand = !src.hand

/mob/verb/examine()

	set src in view()

	if(!src.client)
		usr << "\red \bold  It is a fucking mindless vegetable! Just look at him! \n"

	src.show_hepe()

	if(src.baryga)
		if(src:brainport)
			if(istype(src:brainport, /obj/item/device/brainport/hachmask))
				goto LAB_0046
		usr << "\red \bold <font size = 6>OH FUCK ITS BARYGA CALL THE SECURITY</font>"

	LAB_0046:

	if(src.hepe <= 0)
		return

	if(src.stalk_target)
		usr << "\red \bold [src] is stalking someone!"
	if(src.sleeps)
		usr << "\blue \bold [src] sleeps."
	if(src.calm < 10)
		usr << "\red [src] looks nervous"
	else if(src.calm > 30)
		usr << "\red [src] looks lethargic as fuck"
	else if(src.calm > 20)
		usr << "\blue [src] looks relaxed"
	if(src.euphoria > 10)
		usr << "\blue [src] smiles like an idiot"
	else if(src.euphoria < -10)
		usr << "\red \bold [src] looks EXTREMELY unhappy."
	else if(src.euphoria < 0)
		usr << "\blue [src] looks sad."
	if(src.thrill)
		usr << "\red [src] is thrilling."
	if(src.pain > 0)
		usr << "\red [src] twitching in pain."
	if(src.l_hand)
		usr << "\blue [src] has [src.l_hand] in left hand."
	if(src.r_hand)
		usr << "\blue [src] has [src.r_hand] in right hand."
	if(src.belt)
		usr << "\blue [src] has [src.belt] on belt."
	if(src.clothes)
		usr << "\blue [src] is wearing [src.clothes]."
	if(usr.clothes)
		if(istype(usr.clothes, /obj/item/clothes/psycho))
			usr << ""
			usr << "\blue With help of your aura-seeking glasses, you can also say the following: \n"
			usr << "\red Delirium level: [delirium]"
			usr << "\red Visual perception enrichment: [see_invisible]"
			usr << "\red Tongue numbness: [says_xynta]"
			usr << "\red Psionic potential: [psi]"

			usr << ""

			usr << "\red Tension level: [tension]"
			usr << "\red Thrill level: [thrill]"
			usr << "\red Nausea: [nausea]"
			usr << "\red Non-chronic depression level: [depression]"

			usr << ""

			usr << ""

			if(barbi || (benzo || (hmur || (stim || (alcho || (ghb || cigs))))))
				usr << "\bold Addiction factors: "
				usr << "Barbiturates addiction factor: [barbi] (100+ means addiction)"
				usr << "Benzodiazepines addiction factor: [benzo] (100+ means addiction)"
				usr << "Opiates addiction factor: [hmur] (80+ means addiction)"
				usr << "Amphetamines addiction factor: [stim] (50+ means addiction)"
				usr << "Ethanol addiction factor: [alcho] (20+ means hangover, 110+ can result in delirium)"
				usr << "\italic GABA derivatives addiction factor: [ghb] (80+ means addiction, can be cured with phenibut or pure GABA)"
				if(ci_tick)
					usr << "\italic Nicotine addiction factor: [cigs] (he needs to smoke in [ci_tick] chemticks)"
				else if(cigs)
					usr << "\italic Nicotine addiction factor: [cigs] (he is currently on nicotine withdrawal)"
			else
				usr << "\green No addictions detected."

			if(chronoclock)
				usr << ""
				usr << "\red \italic This person is close to the dysthymia. Current depression potencial is [chronoclock], but if it reaches 100, this one will get chronic depression."

			if(epilepsy)
				usr << ""
				usr << "\red \bold \italic This person is suffering from epilepsy. Dostoevsky factor: [epilepsy]"

			if(schizo)
				usr << ""
				usr << "\red \bold \italic This person is suffering from schizophrenia."
				usr << "\red \bold Jacoby's factor: [schizo] (10+ usually requires immediate hospitalisation)"

			if(chronodepr)
				usr << ""
				usr << "\red \bold \italic This person is suffering from dysthymia."
				usr << "\red \bold Letov's factor: [chronodepr] (10+ usually requires immediate hospitalisation)"

			if(ssyndrome)
				usr << ""
				usr << "\red \bold \italic This person is suffering from serotonin syndrome."
				usr << "\red \bold Castaneda's factor: [ssyndrome] (5+ is extremely dangerous and requires immediate hospitalisation)"

/mob/proc/show_hepe()


	switch(hepe)
		if(100 to 9000)
			usr << "\blue [src] looks splendid."
		if(81 to 100)
			usr << "\blue [src] looks okay."
		if(61 to 80)
			usr << "\red [src] looks pale a bit."
		if(41 to 60)
			usr << "\red [src] looks pale."
		if(21 to 40)
			usr << "\red [src] looks very pale."
		if(1 to 20)
			usr << "\red <b>[src] is dying!</b>"
		else
			usr << "\red <b>[src] looks not too full of life and joy.</b>"
			return
	switch(burndmg)
		if(3 to 40)
			usr << "\red [src] looks burned."
		if(41 to 100)
			usr << "\red \bold [src] looks horribly burned."
	switch(brutedmg)
		if(3 to 40)
			usr << "\red [src] looks injured."
		if(41 to 100)
			usr << "\red \bold [src] looks heavily injured."

/mob/rooster/show_hepe()
	switch(hepe)
		if(100 to 9000)
			usr << "\blue [src] looks just like one of rooster gods!"
		if(50 to 100)
			usr << "\blue [src] looks epic."
		if(25 to 50)
			usr << "\blue [src] looks splendid."
		if(21 to 25)
			usr << "[src] looks okay."
		if(6 to 20)
			usr << "\red [src] looks injured."
		if(1 to 5)
			usr << "\red <b>[src] is dying!</b>"
		else
			usr << "\red <b>[src] looks not too full of life and joy.</b>"
			return

/mob/ghost/show_hepe()
	usr << "\blue The ghost HAS NO HEPE"

/mob/proc/wear(obj/C, kostyl)
	if(!src.clothes)
		clothes = C

		src.armor = C:armor
		src.energyprotect = C:energyprotect
		src.chemprotect = C:chemprotect
		src.heatprotect = C:heatprotect




		if(C:hide_face)
			src.overlays -= /obj/overlay/moustacheless
			src.realname = src.name
			spawn(0) src.name = "Unknown"
		src << "Now wearing [C:name]."
		spawn(0)
			src.update_sprite()
			return

/mob/proc/reset_view()

	if(src.client)
		src.client.operat = 0
		if(!src.view_obj)
			src.client.perspective = 0
		else
			src.client.eye = src.view_obj
			src.client.perspective = 1
