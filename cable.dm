/obj/item/battery
/obj/item/battery
/obj/item/ammo
/obj/item/ammo
/obj/item/cable
	dmg = 7
	accu = 90
	beltable = 1
	name = "Cable piece"
	desc = "10 left"
	icon_state = "cable"
	var/cleft = 10
/obj/item/cable
/obj/item/cable/proc/cminus(amt)
	cleft -= amt
	desc = "[cleft] left"
	if(!cleft)
		del(src)
/obj/item/cable/single{cleft = 1; name = "Cable piece"}
/obj/item/cable/attack_by(obj/I)
	if(istype(I, /obj/item/tbranch))
		usr << "\blue You apply a t-branch to the cable."
		new /obj/item/tcable(usr.loc)
		spawn(0)
			del(I)
			src.cminus(1)
	else if(istype(I, /obj/item/outlet))
		usr << "\blue You apply a power outlet to the cable."
		new /obj/item/caboutlet(usr.loc)
		spawn(0)
			del(I)
			src.cminus(1)
	else if(istype(I, /obj/item/warpwire))
		usr << "\blue You apply an electron translator to the cable."
		new /obj/item/sharecable(usr.loc)
		spawn(0)
			del(I)
			src.cminus(1)
/obj/item/cable/attack_self(mob/M)
	var/W = new /obj/wire()
	var/CB = usr.item
	W:dir = input("1 is north/south, 8 is west/east, 6 is southeast, 10 is southwest, 9 is northwest, 5 is northeast.", "Select a cable position:", "WEST") in list(1, 8, 10, 6, 9, 5)
	if(istype(usr.item, /obj/item/cable))
		W:loc = usr.loc
		CB:cminus(1)
		return

/obj/item/tcable
	beltable = 1
	name = "Cable T-branch"
	desc = "For making T-wires."
	icon_state = "tcable"

/obj/item/tcable

/obj/item/bluecable
	dmg = 7
	accu = 90
	beltable = 1
	market_price = 21
	beltable = 1
	plastic_need = 1
	silicon_need = 1
	name = "Wire leech"
	icon_state = "evilcable"
/obj/item/bluecable

/obj/item/sharecable
	dmg = 7
	accu = 90
	beltable = 1
	market_price = 21
	beltable = 1
	name = "Wire sharer"
	icon_state = "bluecable"
/obj/item/sharecable
/obj/item/outlet
	name = "Power outlet"
	desc = "Can be applied to the cable piece."
	icon_state = "powerport"
/obj/item/outlet
/obj/item/caboutlet
	beltable = 1
	name = "Cable with outlet"
	desc = "For connecting some kinds of machinery and for device recharging."
	icon_state = "cabledport"
/obj/item/caboutlet
/obj/item/caboutlet/attack_self()
	var/W = new /obj/wire/battery()
	W:dir = input("1 is north/south, 8 is west/east:", "Select a power outlet position:", "WEST") in list(1, 8)
	if(istype(usr.item, /obj/item/caboutlet))
		W:loc = usr.loc
		usr.delitem()
		return

