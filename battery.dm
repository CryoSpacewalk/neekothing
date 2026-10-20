// Recovered from compiled neek.dmb (7 procs)
/obj/structure/battery
	icon = 'grafon/wire.dmi'
	name = "Power Storage Unit"
	icon_state = "powerstorage"
	alticon = "gpowerstorage"
	wrenchable = 1
	var/mode = "OUTPUT"
	var/energy = 0
	var/output = 1
	var/input = 1
	var/capacity = 500
/obj/structure/battery
/obj/structure/battery/New()
	src.function()
/obj/structure/battery/operate(obj/W)
	if(W:energy > 0)
		W:energy -= 1
		var/method = input("What to do?") in list("Turn on/off", "Change INPUT", "Change OUTPUT")
		if(usr in range(1, W))
			switch(method)
				if("Turn on/off")
					src.attack_hand()
				if("Change INPUT")
					var/newinput = input("Change INPUT") in list(1, 2, 5)
					if(usr in range(1, W))
						src.input = newinput
				if("Change OUTPUT")
					var/newoutput = input("Change OUTPUT") in list(1, 2, 5, 10)
					if(usr in range(1, W))
						src.output = newoutput
	else
		usr << "\red Not enough energy!"
		return

/obj/structure/battery/verb/setout()
	set name = "Set OUTPUT"
	set src in view(1)
	var/newoutput = input("Set OUTPUT of the battery") in list(1, 2, 5, 10)
	if(src in view(1, usr))
		src.output = newoutput
/obj/structure/battery/verb/setin()
	set name = "Set INPUT"
	set src in view(1)
	var/newinput = input("Set 	INPUT of the battery") in list(1, 2, 5)
	if(src in view(1, usr))
		src.input = newinput

/obj/structure/battery/startup
	output = 10
	mode = "OUTPUT"
	energy = 110
	capacity = 200
	name = "Startup power storage"
	desc = "Allows a part of the station to stay lighted at least for a few minutes, so lazy-ass engineers will set up engines, power storages, solars and shit."
	icon_state = "emergencysmall"

/obj/structure/battery/startup

/obj/structure/battery/tiny
	output = 5
	mode = "OUTPUT"
	energy = 80
	capacity = 180
	desc = "Allows a part of the station to stay lighted at least for a few minutes, so lazy-ass engineers will set up engines, power storages, solars and shit."
	name = "Mini-power storage"
	icon_state = "emergencytiny"

/obj/structure/battery/tiny
/obj/structure/battery/proc/function()
	for(var/obj/wire/battery/W in src.loc)
		if(src.mode == "INPUT" && (W.energy >= src.input && src.input <= capacity))
			W.energy -= src.input
			energy += src.input
		else if(src.mode == "OUTPUT" && src.energy >= output)
			W.energy += src.output
			energy -= src.output
	spawn(5) src.function()

/obj/structure/battery/emergency
	energy = 666
	capacity = 1000
	mode = "INPUT"
	name = "Advanced Power Storage Unit"
	icon_state = "emergencypower"
/obj/structure/battery/emergency
/obj/structure/battery/rooster
	energy = 200
	icon_state = "rooster"
	mode = "INPUT"
	name = "Laboratories backup Power Storage Unit"
/obj/structure/battery/rooster
/obj/structure/battery/psycho
	energy = 175
	icon_state = "rooster"
	mode = "INPUT"
	name = "Psychiatry machinery Power Storage Unit"
/obj/structure/battery/psycho
/obj/structure/battery/attack_hand()
	if(src.mode == "INPUT")
		src.mode = "OUTPUT"
	else
		src.mode = "INPUT"
	usr << "\blue You change the power storage unit settings to [src.mode]."
	playsound('sounds/electro.wav')

/obj/structure/battery/attack_by(obj/I)


	if(istype(I, /obj/item/reagent_container/cig))
		if(energy <= 0)
			usr << "\red It is outta power so you can't use it for smoking!"
		else
			var/C = I
			C:smoke(usr)


	if(istype(I, /obj/item/tool/meter))
		usr << "\blue Power storage unit energy: [src.energy] out of [src.capacity]"
	else if(istype(I, /obj/item/tool/screwdriver) && (!istype(I, /obj/structure/battery/emergency) && !istype(I, /obj/structure/battery/rooster)))
		if(energy > 4)
			usr << "\red It is too charged!"
		else
			usr << "\blue You remove covering and unsecure [src]."
			var/M = new /obj/machframe(src.loc)
			M:stage = 2
			M:icon_state = "machine_cored"
			new /obj/item/material/plastic(src.loc)
			if(energy > usr.energyprotect)
				usr << "\red SPARK!"
				usr.damaga(energy - usr.energyprotect, "burn")
			spawn(0) del(src)
