// Recovered from compiled neek.dmb (8 procs)

/obj/item/battery
	market_price = 5
	plastic_need = 1
	var/energy = 10
	icon_state = "battery"
	var/maxenergy = 10

/obj/item/ammo
	icon = 'grafon/item/weapons.dmi'
	size = 1
	var/amt = 10
/atom/var/wrenchable = 0
/atom/var/obj/shadow = null
/atom/var/bomb_proof = 100


/obj/item/tool/hammer
	dmg = 12
	accu = 75
	size = 2
	parry = 5
	icon_state = "hammer"

/obj/item/tool/hammer

/obj/item/tool/axe
	dmg = 18
	accu = 75
	size = 3
	sharp = 1
	groovy = 15
	market_price = 60
	parry = 10
	icon_state = "axe"

/obj/item/tool/axe

/obj/item/tool/wirecutters
	dmg = 6
	accu = 75
	sharp = 1
	name = "wirecutters"
	icon_state = "cutters"

/obj/item/tool/wirecutters

/obj/item/tool/hydraulic_cutters
	dmg = 25
	accu = 60
	size = 4
	sharp = 1
	groovy = 20
	market_price = 120
	parry = 10
	metal_need = 15
	name = "hydraulic cutters"
	desc = "A huge scissor-like tool for cutting metal."
	icon_state = "hydraulic_cutters"

/obj/item/tool/hydraulic_cutters

/obj/item/tool/wrench
	dmg = 9
	accu = 70
	icon_state = "wrench"

/obj/item/tool/wrench


/obj/item/tool/wrench/magic
	accu = 100
	parry = 10
	name = "magic wrench"
	icon_state = "wrench2"
	desc = "A wonderful tool able to un-anchor a crapload of stuff supposed to stay in place for eternity."

/obj/item/tool/wrench/magic


/obj/item/tool/wrench/magic/attack(atom/A, mob/user)
	if(A:wrenchable)
		user << "\blue You stealthy unsecure [A:name]!"
		A:anchored = 0
	else
		..()

/obj/item/tool/screwdriver
	dmg = 5
	accu = 85
	icon_state = "screwdriver"

/obj/item/tool/screwdriver

/obj/item/tool/meter
	name = "electrometer"
	icon_state = "meter"

/obj/item/tool/meter

/obj/item/tool/pulse
	igniter = 1
	charges = 10
	name = "pulse tool"
	desc = "A rechargable tool for pulsing wires. 10/10 charge left."
	icon_state = "pulse"
	var/pulsemode = 1

/obj/item/tool/pulse



/obj/item/tool/pulse/attack_self()


	if(src.pulsemode < 5)
		src.pulsemode += 1
	else
		src.pulsemode = 1
	usr << "\blue You set [src.name] pulse mode to [pulsemode]."

/obj/item/tool/airmeter
	name = "gas sensor"
	icon_state = "gasmeter"
/obj/item/tool/airmeter
/obj/item/tool/airmeter/attack(turf/T, mob/user)
	if(isturf(T))
		T:airscan()

/obj/item/tool/airmeter/attack_self(mob/user)
	if(isturf(src.loc))
		src:loc:airscan()
	else
		user << "\red Airscan error: <b>#UNKNOWN#</b>"

/obj/item/proc/fuel(A)




































	if(A > 0)
		if(src.charges + A <= 6)
			if(src.charges == 0)
				src.icon_state = "torch"
			src.charges += A
	if(A < 0)
		if(src.charges + A > 0)
			src.charges += A
		else
			src.charges = 0
			src.icon_state = "torch_off"
/obj/item/tool/pickaxe
	dmg = 17
	accu = 75
	size = 3
	sharp = 1
	groovy = 5
	parry = 10
	metal_need = 8
	silicon_need = 2
	icon_state = "pickaxe"
	desc = "Strike the earth!"
/obj/item/tool/sonic_drill{dmg = 25; accu = 66; size = 3; sharp = 1; groovy = 15; market_price = 90; parry = 8; metal_need = 5; plastic_need = 1; name = "sonic drill"; desc = "A heavy-duty mining tool."; icon_state = "sonic_drill"}
/obj/item/tool/torch{dmg = 4; charges = 6; size = 2; igniter = 1; name = "welding torch"; desc = "A gas welding torch."; icon_state = "torch"}
/obj/item/tool/scalpel{dmg = 12; accu = 75; size = 2; sharp = 1; groovy = 5; market_price = 20; icon_state = "scalpel"}
/obj/item/tool/flashlight{name = "flashlight"; icon_state = "flashlight_off"; var/on = 0; var/lum = 0}
/obj/item/tool/flashlight/New()

	src.lumo()

/obj/item/tool/flashlight/proc/lumo()
	if(istype(src.loc, /mob))
		var/M = src.loc
		if(!M:glow)
			loc:sd_SetLuminosity(src.lum)
	else
		src.sd_SetLuminosity(lum)


	spawn(3) src.lumo()

/obj/item/tool/flashlight/attack_self()
	if(on)
		on = 0
		icon_state = "flashlight_off"
		sd_SetLuminosity(0)
		lum = 0
	else
		on = 1
		icon_state = "flashlight_on"
		sd_SetLuminosity(5)
		lum = 5


