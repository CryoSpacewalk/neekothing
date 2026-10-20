/obj/item/clothes/abyss
	name = "Abyssal armor"
	desc = "This thing gives you creeps"
	playericon = "abyss"
	armor = 11
	energyprotect = 10
	chemprotect = 6
	heatprotect = 9
	evil = 1
	market_price = 666
	icon_state = "abyss"
/obj/item/clothes/slbrkr
	name = "Rusty armor"
	desc = "This piece of combat exoskeleton is just as heavy, rusty and dirty as it is effective"
	playericon = "slbrkr"
	armor = 14
	energyprotect = 10
	chemprotect = 8
	heatprotect = 8
	hide_face = 1
	market_price = 666
	icon_state = "slbrkr"
/obj/item/clothes
	icon = 'grafon/clothes.dmi'
	name = "Clothing"
	playericon = "standart"
	armor = 1
	energyprotect = 1
	chemprotect = 1
	heatprotect = 1
	dmg = 2
	accu = 50
	size = 2
	var/evil_proof = 0
	var/hide_face = 0
	var/evil = 0
	var/hitler = 0
	var/nopsi = 0
/obj/item/clothes/slbrkr
/obj/item/clothes/standart
	icon_state = "standart"
	name = "Standart Clothing"
/obj/item/clothes/standart
	playericon = "standart"
/obj/item/clothes/engineer
	name = "Engineer Uniform"
	playericon = "engineer"
	energyprotect = 3
	icon_state = "engineer"
/obj/item/clothes/miner
	name = "Geology bay Uniform"
	playericon = "miner"
	heatprotect = 2
	icon_state = "miner"
/obj/item/clothes/ilita
	name = "Ilitka Clothing"
	playericon = "ilita"
	icon_state = "ilita"
/obj/item/clothes/stalin{var/weed = 0; name = "Stalin Suit"; playericon = "stalin"; chemprotect = 4; energyprotect = 4; armor = 4; heatprotect = 4; hide_face = 1; igniter = 1; hitler = 1; market_price = 200; icon_state = "stalin"; var/maxw = 16; var/thc_k = 1; var/cbd_k = 0.9}
/obj/item/clothes/stalin/attack_by(obj/I)










	if(istype(I, /obj/item/reagent_container/consumable))

		var/R = I
		var/isblazed = 0

		if(R:smokeable)
			var/obj/item/reagent_container/consumable/vtoryaki/VT = new /obj/item/reagent_container/consumable/vtoryaki(usr.loc)
			if(prob(66))
				del(VT)
			for(var/datum/reagent/RE in R:reagent_list)
				if(RE.id == "hash oil")
					if(VT)
						VT:add_chem("hash oil", "hash oil", RE.amount / 4, 0)
					isblazed = 1
					src.weed += RE.amount
					if(src.weed > src.maxw)
						usr << "\red \bold [R:name] is too fucking big for this pot! You just lost some of the stuff!"
						src.weed = src.maxw
					spawn(0)
						if(src.weed > 0)
							var/S = new /obj/steam(usr.loc)
							spawn(0)
								var/R1 = new /datum/reagent()
								var/R2 = new /datum/reagent()
								R1:id = "THC"
								R1:name = R1:id
								R1:amount = src.weed / 2
								R2:id = "CBD"
								R2:name = R2:id
								R2:amount = src.weed / 3
								spawn(0)
									S:chemicals_carried += R1
									S:chemicals_carried += R2
									spawn(0) S:initiate()
								usr << "\green You breathe the smoke."
								usr.euphoria += min(src.weed, 10)
								usr.add_chem("THC", "THC", src.thc_k * src.weed / 1.5, 0)
								usr.add_chem("CBD", "CBD", src.cbd_k * src.weed, 0)
								spawn(0) src.weed = 0
				else
					for(var/datum/on_smoke/smk in on_smoke_avaible)
						if(RE.id == smk.rid)
							RE.on_smoke(RE.amount, usr)
							isblazed = 1
							usr << "\green You breathe the vapours."
							if(VT)
								VT:add_chem(RE.name, RE.id, RE.amount / 5, 0)
							usr.add_chem(RE.id, RE.id, RE.amount, 1.5)
		else
			usr << "\red You can't smoke this!"

		spawn(0)
			if(isblazed)
				del(I)
				return
	else

		..()




