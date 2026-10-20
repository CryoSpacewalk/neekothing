// Recovered from compiled neek.dmb (3 procs)

/mob/attack_by(obj/I, mob/usr)


	if(I:class && (I:class != usr:class && prob(66)))
		usr << "\red \bold You failed to use [src.name]!"
		usr << "\red By the way, looks like this thing isn't suited for human usage."
		return

	var/nurgaliev = 0

	if(istype(I, /obj/item/weapon/samurai) || (istype(I, /obj/item/limb) || (istype(I, /obj/item/reagent_container) || (istype(I, /obj/item/medical) || istype(I, /obj/item/collar)))))
		return

	if(usr:psi_radius)
		if(src in range(usr:psi_radius))
			nurgaliev = 1




	if(src.mutations:len)
		if(("eye0" in src.mutations) && prob(20) || (("eye1" in src.mutations) && prob(40) || ("tumor_eye" in src.mutations) && prob(40)))
			show_message("\red \bold [name] hypnotises [usr:name] with his weird eyes!", "\red You hypnotise [usr:name]!")
			if(prob(33))
				usr:blind(15)
			if(prob(33))
				usr:stun(2)
			return

		if(("tumor" in src.mutations) && prob(5) || ("tumor_eye" in src.mutations) && prob(5))
			show_message("\red \bold [usr:name] hits [name] right in the head tumor!", "\red [usr:name] hits you right in the tumor! It hurts!")
			damaga(5, "organ")
			torment(2)
			if(prob(50))
				epilepsy += 2

		if(("horns" in src.mutations) && prob(5))
			usr:show_message("\red \bold [usr:name] hits [src.name] right in the sharp horns! This was a stupid trick and definitely will hurt!", "\red You hit [src.name] in the horns! It hurts!")
			if(usr:armor < 5)
				usr:damaga(6, "brute")
			else
				usr:damaga(3, "brute")
			if(usr:armor < 5 || prob(40 - usr:armor * 2))
				usr:torment(2)


	if(usr:mutations:len)
		if(("eye0" in usr:mutations) && prob(5) || (("eye1" in usr:mutations) && prob(15) || ("tumor_eye" in usr:mutations) && prob(15)))
			usr:show_message("\red \bold [usr:name] hypnotises [src.name] with his weird eyes!", "\red You hypnotise [src.name]!")
			if(prob(33))
				blind(15)
			if(prob(33))
				stun(2)

		if(("hui" in usr:mutations) && prob(20))
			usr:show_message("\red \bold [usr:name] lashes [src.name] with his bloated [reverse_text("sinep")]!", "\red You lash [src.name] with your cock! So much fun!")
			usr:libido += 10
			damaga(2, "brute")
			if(prob(50 - usr:armor * 3))
				src << "\red Damn, you're kicked down with [usr:name] disfigured [reverse_text("sinep")]!"
				stun(2)

		if(("horns" in usr:mutations) && prob(15))
			usr:show_message("\red \bold [usr:name] headbutts [src.name] with his sharp horns!", "\red You headbutt [src.name] with your horns!")
			if(armor >= 5)
				src.damaga(5, "brute")
			else
				src.damaga(10, "brute")

	if(I:veteranbane)
		if(isghost(src))
			src << "\red \bold You're banished to the Hell!"
			ghostcount++
			src.show_message("\red \bold [usr:name] banishes [name]!")
			spawn(1)
				src.z = 2
				sleep(0)
				src.x = 5
				sleep(0)
				src.y = 5

		if(src.cult && prob(66))
			show_message("\red \bold [usr:name] burns [name] with his blessed [I:name]!")
			damaga(round(I:dmg * 1.5) + 5, "burn")

		if(istype(src, /mob/stalin))
			usr << "\red You seriously wound this stalinistic abonimation with your [I:name]!"
			damaga(25, "brute")

		for(var/obj/item/IT in src)
			if(IT:cursed)
				src << "\green [IT] is no longer cursed!"
				usr << "\green You uncurse [IT]."
			IT:cursed = 0
	else


		if(usr:hepe < 0)
			return

	if(I:warpy)
		show_message("\red \bold [usr:name] lashes [src.name] with [I]!", "\red You lash [src.name] with [I]!")
		nurgaliev = 1

	if((usr in range(1, src)) || nurgaliev)



		if(usr:mat == "ether" || (usr:cult || usr:abyss))
			var/sanity = 0
			if(clothes)
				if(src.clothes:evil_proof)
					sanity += 50
			if(item)
				if(src.item:veteranbane)
					sanity += 25
			if(src.prof == "purificator" || src.abyss)
				sanity += 25

			if(prob(sanity))

				if(prob(50))
					show_message("\blue [name] glides [usr] attack off!", "\blue You glide [usr] attack off!")
					return
				else if(prob(sanity / 2))
					show_message("\red [name] gets some damage, but counterstrikes!", "\blue You get some damage, but counterstrike!")
					if(usr:item)
						usr:attack_by(item, src)
					else
						usr:attack_hand(src)
					damaga(4, "brute")
					return
				else if(sanity)
					damaga(8, "brute")
					return

		if(prob(src.psi / 4))
			show_message("\red [name] mysteriously avoids [usr:name]'s attack!")
			playsound('sounds/om.wav')
			return



		if(item)
			if(prob(src.item:parry - min(10, src.thrill)))
				src.show_message("\red [src.name] blocks [usr:name] attack with [item]!")
				playsound('sounds/block.wav')
				return

		if(prob(I:accu + usr:empowered + usr:luck + round(usr:euphoria / 5) - usr:thrill + src.depression - round(src.euphoria / 10) - round(src.luck / 2)))

			if(I:painful)
				torment(I:painful)

			if(istype(I, /obj/item/medical))
				if(I:dmg + I:dmg / 5 * brutality > 0 && prob(50))
					src << "\red You feel a tiny prick!"
					damaga(I:dmg, "brute", I:sharp, I:groovy)

			if(I:dmg + I:dmg / 5 * brutality > src.armor)
				damaga(I:dmg + brutality - src.armor, "brute", I:sharp, I:groovy)

				var/crit = 0

				if(usr:clothes)
					if(src.headperk == "fake Hitler" || src.headperk == "fake Stalin")
						if(clothes:hitler)
							crit += 20
					if(istype(usr:clothes, /obj/item/clothes/military))
						crit += 10
					else if(istype(usr:clothes, /obj/item/clothes/purificator) || istype(usr:clothes, /obj/item/clothes/armor/adv))
						crit += 20
				if(usr:berserk)
					crit += 33
				if(prob(I:extracrit + crit + usr:luck + round(I:groovy / 4) + round(usr:euphoria / 3) + round(I:dmg / 5) + min(5, usr:empowered) + min(20, usr:luck / 2) + min(5, usr:brutality) - min(0, src.calm) + src.thrill - usr:thrill))
					show_message("\red \bold [usr] hits [src.name] REALLY hard!", "\blue \bold You hit [src.name] REALLY hard!")
					damaga(round(I:dmg * 2.5) + round(crit / 5) + brutality + empowered - src.armor, "brute", I:sharp, I:groovy)

				if(istype(I, /obj/item/weapon/baton) && (src.mat == "flesh" && prob(30 + usr:luck - round(src.luck / 2) - round(src.euphoria / 10) - src.painless)))
					for(var/mob/M in view(src))
						M << "\red \bold [usr] beats [name] with [usr:item]!"
					src.stun(5 - round(src.painless / 2) + round(usr:brutality / 2) + round(usr:empowered / 2) - round(euphoria / 4))
					src.playsound('sounds/baton.ogg')
				else if(I:dmg > 5)
					if(I:sharp)
						playsound(pick('sounds/chop.ogg', 'sounds/sord.ogg'))
					else
						playsound('sounds/bash.wav')

				if(prob(round(I:dmg / 3) + I:sharp * 5 + round(I:groovy / 3)) && !I:painful)
					src << "\red Ouch!"
					if(src.pain < 4)
						src.torment(3)
					else
						src.torment(2)
					src.chronoclock += 2
			else

				if(prob(75 - src.armor + usr:luck - round(src.luck / 2) + (I:dmg / 5 * brutality + usr:luck)))
					damaga(1 + I:dmg / 5 * brutality, "brute", I:sharp, I:groovy)

			if(I:stuntime > src.energyprotect && src.mat == "flesh")

				if(prob(round(euphoria / 10) + painless * 2 - pain))
					usr << "\red \bold [src] manages to resist getting stunned!"
					src << "\red [usr] fails to stun you!"
				else
					src.stun(I:stuntime - src.energyprotect)

			for(var/mob/M in view(5, src))
				if(usr:item == null)
					if(src.mat == "flesh")
						M << "\red [usr:name] [pick("kicks", "punches", "slaps")] [name]!"
					else
						M << "\red [usr:name] beats [name]!"
				else
					if(istype(I, /obj/item/tool/torch) && I:charges > 0)

						if(prob(33))
							torment(rand(1, 3))

						M << "\red [usr] burns [src] with his [usr:item]!"
						if(src.heatprotect < 10)
							src.damaga(12 - src.heatprotect, "burn")
							I:fuel(-1)
						else if(prob(60 - round(euphoria / 2)))
							src.damaga(2, "burn")
							I:fuel(-1)
						else
							usr << "\blue Your clothing protect you from burns!"

						if(prob(brutality * 10 + usr:luck - src.luck))
							src.damaga(brutality, "brute")
					else




						if(istype(usr:item, /obj/item/reagent_container/consumable) && src.mat == "flesh")
							var/olditem = usr:item
							M << "\red [usr] tries to feed [src] [usr:item]!"
							spawn(50) if(usr:item == olditem && ((usr in range(1, src)) || (src in range(usr:psi_radius))))
								M << "\red [usr] feeds [src] [usr:item]."
								src.toxins += I:toxins

								if(src.hepe > 0)
									if(100 - src.hepe >= I:healing)
										src.hepe += I:healing
									else
										src.hepe = 100
										src << "\green You feel fine."
								if(istype(usr:item, /obj/item/reagent_container/consumable/plant))
									src.extract(usr:item, src)
								usr:delitem()
						else
							if(istype(I, /obj/item/device/e_module) && src.mat == "plastic")
								usr << "\blue You load your directives to the robot's mind."
								src.enslavement(I)
							else
								if(!istype(usr:item, /obj/item/weapon/stunner))
									M << "\red [usr] attacks [src] with [usr:item]!"
									if(!I:sharp || I:dmg > 15)
										if(prob(15 + usr:empowered * 3 + brutality * 2 - round(src.euphoria / 5) + round(usr:euphoria / 5) + usr:calm - usr:thrill * 2 + round(I:dmg / 4)))
											show_message("\red \bold [usr] knocks [src] out!")


											playsound(pick('sounds/skullcrack1.ogg', 'sounds/skullcrack2.ogg'))
											var/stuntime = pick(max(1, round(pain / 2)), 2, 3, 4)

											if(prob(50))
												src.chronoclock += 2

											if(src.painless >= 6)
												stuntime = 0
											else
												stuntime -= src.painless

											if(stuntime)
												stun(stuntime)
												blind(stuntime * 10 + 10, 0)
								else
									M << "\red [usr] stuns [src] with [usr:item]!"
		else

			for(var/mob/M in view(5, src))
				if(usr:item == null)
					M << "\red [usr] fails to attack [src]!"
				else

					if(!istype(usr:item, /obj/item/medical))
						M << "\red [usr] fails to attack [src] with [usr:item]!"
					else
						usr << "\red You fail to use [usr:item] on [src]!"

/mob/attack_hand(mob/user)





	if(src.wired)
		if(user == src)
			if(world.time - src.tie_last_used < src.tie_delay)
				src << "\red You're already trying to untie yourself!"
				return
			var/instatye = 0
			if(user:brainport)
				if(istype(user:brainport, /obj/item/device/brainport/tantric))
					instatye = 1
			user:show_message("\red [user:name] tries to remove the tying!", "You try to free yourself!")
			if(instatye || prob(3 + round(user:luck / 10)))
				user:show_message("\red [user:name] removes the tying!", "\blue Finally, you free yourself!")
				user:untie()
			src.tie_last_used = world.time
		else if(!user:stunned && !user:wired)
			show_message("\red [user] removes the tying from [name]!", "\blue You untie [name]")
			src.untie()
			return

	sleep(0)
	if(prob(src.psi / 4))
		show_message("\red [name] mysteriously avoids [user:name]'s attack!")
		playsound('sounds/om.wav')
		return


	var/sanity = 0
	if(src.clothes)
		if(clothes:evil_proof)
			sanity += 50
		if(src.l_hand || src.r_hand)
			var/I1 = src.l_hand
			var/I2 = src.r_hand
			if(I1:veteranbane || I2:veteranbane)
				sanity += 25
		if(src.prof == "purificator" || src.abyss)
			sanity += 25

	if(prob(sanity) && usr.mat == "ether")

		if(prob(50))
			show_message("\blue [name] glides [usr] attack off!", "\blue You glide [usr] attack off!")
			return
		else if(prob(sanity / 2))
			show_message("\red [name] gets some damage, but counterstrikes!", "\blue You get some damage, but counterstrike!")
			if(usr.item)
				usr.attack_by(src.item, src)
			else
				usr.attack_hand(src)
			src.damaga(4, "brute")




			return
		else if(sanity)




			src.damaga(8, "brute")
			return

	sleep(0)





	if(src.mutations:len)
		if(("eye0" in src.mutations) && prob(20) || (("eye1" in src.mutations) && prob(40) || ("tumor_eye" in src.mutations) && prob(40)))
			show_message("\red \bold [name] hypnotises [usr.name] with his weird eyes!", "\red You hypnotise [usr.name]!")
			if(prob(33))
				usr.blind(15)
			if(prob(33))
				usr.stun(2)
			return

		sleep(0)

		if(("tumor" in src.mutations) && prob(5) || ("tumor_eye" in src.mutations) && prob(5))
			show_message("\red \bold [usr.name] hits [name] right in the head tumor!", "\red [usr.name] hits you right in the tumor! It hurts!")
			damaga(5, "organ")
			torment(2)
			if(prob(50))
				epilepsy += 2

		if(("horns" in src.mutations) && prob(5))
			usr.show_message("\red \bold [usr.name] hits [src.name] right in the sharp horns! This was a stupid trick and definitely will hurt!", "\red You hit [src.name] in the horns! It hurts!")
			if(usr.armor < 5)
				usr.damaga(8, "brute")
			else
				usr.damaga(4, "brute")
			if(usr.armor < 5 || prob(33))
				usr.torment(2)


	if(usr.mutations:len)
		if(("eye0" in usr.mutations) && prob(5) || (("eye1" in usr.mutations) && prob(15) || ("tumor_eye" in usr.mutations) && prob(15)))
			usr.show_message("\red \bold [usr.name] hypnotises [src.name] with his weird eyes!", "\red You hypnotise [src.name]!")
			src.blind(15)
			src.stun(2)

		if(("hui" in usr.mutations) && prob(20))
			usr.show_message("\red \bold [usr.name] lashes [src.name] with his bloated [reverse_text("sinep")]!", "\red You lash [src.name] with your cock! So much fun!")
			usr.libido += 10
			src.damaga(2, "brute")
			if(prob(50 - armor * 3))
				src << "\red Damn, you're kicked down with [usr.name] disfigured [reverse_text("sinep")]!"
				src.stun(2)

		if(("horns" in usr.mutations) && prob(15))
			usr.show_message("\red \bold [usr.name] headbutts [src.name] with his sharp horns!", "\red You headbutt [src.name] with your horns!")
			if(src.armor >= 5)
				damaga(5, "brute")
			else
				damaga(10, "brute")



	spawn(1.5)
		if(user:flurry_count)
			if(get_dist(user, src) <= 2)
				user:flurry_count--

				src.attack_hand(user)
			else
				src.flurry_count = 0

	if(user:stunned == 1)
		return

	if(src.hepe <= 0)
		// was an unused label "label1" from the decompiler (an empty line in the original .dmb)
		show_message("\red [user] [pick("kicks", "cold-bloodedly punches", "swings at", "spits at", "[pick("farts", "swings his dick")] in the direction of", "stares glumly at")] [src]'s corpse.")
		return

	var/extras = 0

	if(user:brainport && user:euphoria >= 20)
		if(istype(user:brainport, /obj/item/device/brainport/tantric))
			user:euphoria -= 4
			extras++

	if(prob(src.luck))
		extras++
		extras = abs(extras * 2)

	if(prob(src.psi / 4))
		show_message("\red [name] mysteriously avoids [user:name]'s attack!")
		playsound('sounds/om.wav')
		return

	if(prob(user:accu + extras * 10 + round(user:euphoria / 10) + user:calm - user:thrill))

		if(user:dmg * user:empowered + user:brutality > src.armor)




			damaga(4 + user:dmg * user:empowered + user:brutality + extras * 5 - src.armor, "brute")
			user:show_message("\red [user:name] hits [name] really hard!", "You hit [src] really hard.")

			if(prob(10 + user:empowered * 5 + user:brutality * 2 - src.euphoria + user:euphoria + round(user:calm / 2) - user:thrill - round(src.calm / 2) + extras * 15))
				src.show_message("\red \bold [user] knocks [src] out!")
				src.playsound(pick('sounds/skullcrack1.ogg', 'sounds/skullcrack2.ogg'))
				var/stuntime = pick(max(1, round(src.pain / 2)), 2, 3, 4)

				if(prob(50))
					src.chronoclock++

				if(src.painless >= 6)
					stuntime = 0
				else
					stuntime -= src.painless

				if(stuntime)
					src.stun(stuntime)
					src.blind(stuntime * 10 + 10, 0)
			else

				src.playsound(pick('sounds/punch1.ogg', 'sounds/punch2.ogg'))
		else
			if(prob(75 - src.armor + user:empowered * 5 + user:brutality * 2 + extras * 2))
				src.damaga(3 + user:empowered, "brute")
		// was an unused label "label2" from the decompiler (an empty line in the original .dmb)
		show_message("\red [user] [pick("kicks", "punches", "slaps", "bites", "headbutts", "stabs in the eyes with his fingers", "strikes with an elbow")] [src]!")
	else


		user:show_message("\red [user] tries to attack [src], but misses!", "\red You miss [src]!")

/mob/proc/damaga(damageamount, dmgtype, sharp, groovy)






	if(damageamount >= 0)

		if(istype(src:brainport, /obj/item/device/brainport/tantric) && (dmgtype != "organ" && prob(10)))
			src.show_message("\red \bold [src.name] mysteriously avoids [dmgtype] damage!", "\blue \bold Your module protects you from [dmgtype] damage.")
			return

		if(src.class == "man" && prob(damageamount * 1.5))
			src.calm--
			if(prob(damageamount / 2))
				src.chronoclock++

		if(src.mat == "flesh" && painless <= 2)
			if(dmgtype == "organ" && prob(2 + damageamount / 4))
				src << "\red It burns from the inside of you! OUCH FUCK NO"
				src.calm--
				if(prob(50))
					src.torment(1)
					src.chronoclock++
		if(dmgtype == "burn" && (prob(2 + damageamount / 8) && src.painless < 5))
			src << "\red IT BURNS AS FUCK"
			src.calm--
			if(prob(80))
				src.torment(pick(1, 2))
				src.chronoclock += 2

		if(src.hepe > damageamount)
			src.hepe -= damageamount
			switch(dmgtype)
				if("organ")
					organdmg += damageamount
				if("brute")
					brutedmg += damageamount
				if("burn")
					burndmg += damageamount
				else
					world << "\red <font size = 5>DAMAGE SYSTEM IS BROKEN, KOKOKOK</font>"

			if(src.mount && src.hepe <= 20)
				src.show_message("\red \bold [src.name] is too weak and wounded so he falls from his [src:mount:name]!")
				src.overlays -= src:mount:OL
				src:mount:loc = src.loc
				spawn(0)
					src.mount = null

			if(dmgtype == "brute")
				src.limb_damage(damageamount, sharp, groovy)
				if(prob(damageamount / 1.5 + sharp * 15))
					src.wound()

			if(src.hepe < 10 - painless && prob(100 - calm - painless * 2))
				src << "\red \bold You're almost dead!"
			else if(src.hepe < 30 - painless && prob(100 - calm * 2 - painless * 2))
				src << "\red \bold You feel horrible."
			else if(src.hepe < 50 - painless && prob(100 - calm * 4 - painless * 2))
				src << "\red Your body feels bad."
			if(prob(damageamount) && src.class == "man")
				src.calm -= 1 + round(damageamount / 10)
				if(prob(damageamount))
					src.chronoclock++

		else if(euphoria > 10 && prob(min(euphoria / 10, 5)))
			src.mortal_throw()

		else if(src.dead == 0 && !(src.mat == "plastic"))

			if(src.mount)
				usr:mount:unmount()

			if(src.mat == "flesh" && src.class == "man")
				bodycount++

			if(!("Murderous" in cfirst))
				cfirst += "Murderous"
			if(!("Bloody" in cfirst))
				cfirst += "Bloody"



			src << "\blue You feel dead a little."

			src.hepe = 0
			src.density = 0
			src.dead = 1

			if(l_hand || r_hand)
				spawn(0) src.drophands()

			if(src.pocket)
				src:pocket:loc = src.loc
				src.pocket = null

			if(src.hidden)
				src:hidden:loc = src.loc
				src.hidden = null

			if(src.hidden2)
				src:hidden2:loc = src.loc
				src.hidden2 = null

			if(src.belt)
				src:belt:loc = src.loc
				src.belt = null

			if(src:brainport)
				src:brainport:loc = src.loc
				src:brainport = null

			if(!(src.clothes == null))
				src:clothes:loc = src.loc
				src.clothes = null
			src.dir = pick(2, 8, 4)

			var/I = new /icon(src.icon)

			var/degr = 0
			switch(src.dir)
				if(2)
					degr = 180
				if(8)
					degr = 90
				if(4)
					degr = -90

			I:Turn(degr)
			src.icon = I
			if(!(src.ckey == null))
				src.realkey = src.ckey

			if(src.prof == "captain")
				capdead = 1



			if(src.client)
				for(var/obj/tick/T in src.client.screen)
					del(T)
				if(src.client.camera_anchor)
					src.client.camera_anchor = null

				for(var/obj/hud_effect/H in src.client.screen)
					src.client.screen -= H
				src.client.view = src.client.true_view



			if(src.mat != "ether")
				var/G = new /mob/ghost(loc)
				G:traitor = traitor
				G:cult = src.cult
				G:slbrkr = src.slbrkr
				G:cultplayer = src.cultplayer
				G:objective1 = src.objective1
				G:objective2 = src.objective2
				G:ckey = src.ckey
				G:realkey = src.realkey
				G:name = "[src.realname]'s ghost"
				G:realname = src.realname
				if(src.client)
					spawn(0)
						G:client = src.client
				if(src.ckey)
					spawn(0)
						G:ckey = src.ckey
			src.traitor_corpse = src.traitor
			src.cultplayer = src.cultplayer
			src.traitor = 0
			src.name = src.realname


			src.ckey = null
			src.update_sprite(degr)



			return

		else if(src.dead == 0 && src.mat == "plastic")
			src.dead = 1
			var/B = new /obj/item/device/brainpod(src.loc)
			new /obj/melt(src.loc)
			B:icon_state = "brainpod_full"
			B:name = "brain pod (with brain)"
			B:brainkey = src.ckey
			B:traitor = src:traitor
			B:first_objective = src.objective1
			B:second_objective = src.objective2
			var/G = new /mob/ghost(src.loc)
			G:traitor = src:traitor
			G:objective1 = src.objective1
			G:objective2 = src.objective2
			G:ckey = src.ckey
			G:name = src.realname
			G:realkey = src.realkey

			if(!("luddites" in csecond))
				csecond += "luddites"

			spawn(0)
				del(src)

		else if(damageamount >= 20 && (dmgtype == "brute" && sharp))
			src.gib()
			return
	else
		return
