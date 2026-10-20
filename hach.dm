/obj/item/var/market_price = 0
/obj/item/var/merged = 0
/obj/item/var/veteranbane = 0
/obj/item/var/warpy = 0
/obj/item/var/extracrit = 0
/obj/item/var/parry = 2
/obj/item/var/groovy = 0
/obj/item/device/brainport/hachmask{metal_need = 3; plastic_need = 3; silicon_need = 3; name = "non-abyssal dweller immitating device"; desc = "A special device for undercover barygas"; icon_state = "hachmask"}





var/list/baryga_ov = new /obj/overlay/baryga
/obj/item/device/brainport/hachmask/on_insert(mob/M)


















	M:update_sprite()

/obj/item/device/brainport/hachmask/on_removal(mob/M)
	M:update_sprite()


/obj/item/device/hachtele/attack_self()










	if(istype(usr.loc, /turf/floor/start) || (istype(usr.loc, /turf/floor/abyss) || istype(usr.loc, /turf/abyss)))
		for(var/obj/start/baryga/B in world)
			usr.loc = B.loc









var/list/markets = list(
	new /datum/goodlist/market_spice,
	new /datum/goodlist/market_weed,

	new /datum/goodlist/market_phenethylamine,
	new /datum/goodlist/market_shrooms,
	new /datum/goodlist/market_lsd,
	new /datum/goodlist/market_tryptamine,
	new /datum/goodlist/market_dissociatives,

	new /datum/goodlist/market_opi,
	new /datum/goodlist/market_benzo,

	new /datum/goodlist/market_booze,

	new /datum/goodlist/market_speed,
	new /datum/goodlist/market_ecstasy,

	new /datum/goodlist/market_drugstore,
	new /datum/goodlist/market_foreign,

	new /datum/goodlist/market_precursors,

	new /datum/goodlist/market_grow,
	new /datum/goodlist/market_supplies,
	new /datum/goodlist/market_hardware,
	new /datum/goodlist/market_science,
	new /datum/goodlist/market_magicks,
	new /datum/goodlist/market_device)




var/list/barygas = list()
var/cherenkov_value = 1;var/svetov_value = 1
/proc/bary_gen(tzyfra)
	tzyfra--
	new /datum/baryga()
	if(tzyfra)
		spawn(0) bary_gen(tzyfra)
var/dnet_comission = 5
/datum/baryga
	var/name = "huila"
	var/rotten = 0
	var/obj/goods = new/list()
	var/market_marker
/datum/baryga/New()

	src.name = "[pick("Corsair", "Pirate", "Captain", "Neuromancer", "Dr.", "Mr.", "Commander", "Chief", "Brother", "Don", "Duke", "General", "Comrade", "Bratishka", "Veteran", "Gautama", "Vovchik", "Master", "Overlord", "Sanek", "Krokodil", "Vitya", "Mishka")][pick("Khohol", "Trotski", "Paul", "Poldan", "Rundey", "Rydny", "228", "420", "1234testtest", " AK-47", " Jah", " Shakyamuni", " Shiva", " Kesey", " Shulgin", " Hoffman", " Leary", " Letoff", " Heemeyer", " Manson", " Chikatilo", " P-Orridge", " Tibet", " Douglas", " Marley")]"
	if(prob(20))
		src.rotten = 1
	var/G = pick(markets)
	spawn(0)
		src:goods:Add(G:glist)
		spawn(0)
			for(var/datum/marketname/M in src.goods)
				if(M)
					src.name += " [M.name]"
					src.market_marker = M.name
					spawn(0) src.goods -= M
			spawn(0)
				for(var/datum/tovar/T in src.goods)
					if(src:goods:len > 2 && prob(T.rarity))
						src.goods -= T
				spawn(0)
					src.goods += new /datum/tovar/cancel()
					barygas += src

/obj/item/device/communicator/baryga
	money = 0
	baryga = 1
	name = "baryga personal encryptor"
	icon_state = "communicator2"
	desc = "This device usually used for ordering stuff. Don't ask me how it works, just stuff it with money, gems and other precious stuff."

/obj/item/device/communicator/baryga


/obj/item/device/communicator/verb/reveal()































	set name = "reveal hidden packages (4 'turfs')"
	set category = "Machinery"

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	for(var/obj/structure/container/crate/inv/I in range(4, usr))
		I.invisibility = 0



/obj/item/device/communicator/proc/zatar(mob/junkie)
	var/B = input("Добро пожаловать. Снова. You have [money] cherenkovs left", "[darknet_name]") in barygas
	if(B && src == junkie:item)
		src.zatar_good(junkie, B)

/obj/item/device/communicator/proc/zatar_good(mob/junkie, datum/baryga/B)



	if(B && src == junkie:item)
		var/T = input("You have [money] cherenkovs left. Please, select desirable good.", "[B:name]") in B:goods

		if(T:name == "cancel")

			return
		else
			if(T && src == junkie:item)

				if(T:price / cherenkov_value > money)
					junkie << "\red \bold Sorry, man, not enough cherenkovs (it costs [T:price / cherenkov_value])!"
				else


					switch(alert("It will cost you [T:price / cherenkov_value] cherenkovs. Let's rock?", , "Yep", "Nope"))
						if("Yep")
							if(!B || junkie:item != src)
								return
							var/L = new /list()
							money -= T:price / cherenkov_value
							for(var/obj/landmark/klad/K in world)
								L += K
							spawn(0)
								var/obj/landmark/klad/K = pick(L)
								if(K)
									junkie << "Your purchase will await you at the [K:name]. Get it right now or somebody will outstrip you!"
									var/t = T:amt
									while(t)
										if(B:rotten && (T:faked && prob(33)))
											new T:faked(K:loc)
										else
											new T:good(K:loc)
										t--
									spawn(0) new /obj/structure/container/crate/inv(K:loc)
						else

							return

/obj/item/device/communicator/attack_by(obj/I)
	if(I:market_price > 0)
		var/cock = input("Do you want to sell this thing?", "") in list("Yes", "No")
		switch(cock)
			if("Yes")
				if(usr.item == I)
					usr << "\blue The device beeps:"
					usr << "\blue Sounds like a nice deal, dude."

					if(istype(I, /obj/item/reagent_container))

						var/RI = I

						for(var/datum/reagent/R in RI:reagent_list)

							switch(R.id)
								if("2C-B")


									src.market_price += R.amount * 29
								if("DXM")


									src.market_price += R.amount * 1.5
								if("LSD")


									src.market_price += R.amount * 59
								if("DOB")


									src.market_price += R.amount * 36.5
								if("25i-NBOMe")


									src.market_price += R.amount * 3.2
								if("ketamine")


									src.market_price += R.amount * 5
								if("salvinorin A")


									src.market_price += R.amount * 3.3

					src:money += I:market_price / cherenkov_value
					usr.delitem()
					return
				else

					usr << "\blue The device beeps:"
					usr << "\blue Looks like you've either lost or already sold this item! Don't be so greedy!"
					return
			else


				return

/obj/item/device/communicator/proc/svetov_buy()
	if(src:money >= 100 * svetov_value / cherenkov_value / (1 - dnet_comission / 100))
		usr << "\blue \bold You've bought 100 svetovs for [100 * svetov_value / cherenkov_value / (1 - dnet_comission / 100)] cherenkovs!"
		src:money -= svetov_value * (100 + dnet_comission)
		src.svetov += 100
	else
		usr << "\red \bold Not enough cherenkovs (you need [100 * svetov_value / cherenkov_value / (1 - dnet_comission / 100)])!"
		return

/obj/item/device/communicator/proc/svetov_sell()
	if(src:money >= 100 * cherenkov_value / svetov_value / (1 - dnet_comission / 100))
		usr << "\blue \bold You've bought 100 cherenkovs for [100 * cherenkov_value / svetov_value / (1 - dnet_comission / 100)] svetovs!"
		src.svetov -= cherenkov_value * (100 + dnet_comission)
		src:money += 100
	else
		usr << "\red \bold Not enough svetovs (you need [100 * cherenkov_value / svetov_value / (1 - dnet_comission / 100)])!"
		return

/obj/item/call_pack/attack_self()








	usr << "\blue You open the package."
	new /obj/item/device/caller(usr.loc)
	new /obj/item/device/uncaller(usr.loc)
	spawn(0) del(src)

