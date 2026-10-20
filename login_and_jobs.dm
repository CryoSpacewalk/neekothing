// Recovered from compiled neek.dmb (7 procs)

/mob/proc/equip_clothes(obj/I)



	I:loc = src

	src.wear(I)

/mob/proc/equip_key(obj/I)
	spawn(0)
		I:loc = src
		src.pocket = I

/mob/proc/equip_brain(obj/I)
	spawn(0)
		I:loc = src
		src:brainport = I

/mob/proc/equip_pocket(obj/I)
	spawn(0)
		I:loc = src
		src.hidden = I

/mob/proc/equip_pocket2(obj/I)
	spawn(0)
		I:loc = src
		src.hidden2 = I

/mob/proc/equip_belt(obj/I)
	spawn(0)
		I:loc = src
		src.belt = I

/client/New()
	check_ban()
	world << "[key] has logged in!"
	..()

/client
	script = "<STYLE>BODY {font: monospace}</STYLE>\n\n\tmacro\n\t\tALT return \"blink-your-cataractic-eyes\"\n\t\tNortheast return \"change-hands\"\n\t\tSoutheast return \"break-pull\"\n\t\tDelete return \"consume\"\n\t\tInsert return \"use\"\n\t\tShift return \"Prepare-to-throw-it\"\n"



















/client/var/logged_in = 0




