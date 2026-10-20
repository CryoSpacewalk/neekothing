/obj/item/collar{beltable = 1; market_price = 228; metal_need = 15; silicon_need = 5; icon_state = "collar"; name = "Rusty collar"; desc = "A dirty collar of rusty carbon steel"}
/obj/item/stuncollar{beltable = 1; market_price = 100; metal_need = 7; silicon_need = 2; name = "Stuncollar"; icon_state = "collar2"; desc = "A one-time collar for stunning criminal scum"}
/obj/item/container{name = "some fucking chemodan"; desc = "This is some fucking chemodan. It is well-known for banging YOUR mom from time to time."; icon_state = "chemodan"; var/amt = 0; var/maxamt = 8}
/obj/item/container/attack_hand()




	if(istype(src.loc, /mob))
		take()
	else if(usr.stunned == 0)
		src.pickup(usr)

/obj/item/container/verb/take()
	set name = "take from container"
	set src in view(1)
	if(src.contents.len == 0)
		usr << "\red It is empty!"
	else
		var/hooi = input("What to take?", "", src.contents[1]) in list(src.contents)
		spawn(0)
			hooi:pickup(usr)
			src:amt -= hooi:size
			src.contents -= hooi
/obj/item/container/attack_by(obj/I)
	if(src.maxamt - src:amt > I:size)
		usr << "\blue You put [I] inside your [src.name]."
		src:amt += I:size
		spawn(0)
			usr.dropitem()
			I:loc = src
	else
		usr << "\red Not enough space!"
