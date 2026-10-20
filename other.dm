/obj/dump
/obj/wisp
/obj/rainbow{icon = 'grafon/effects/effects.dmi'; icon_state = "warp_rainbow"; desc = "A piece of... Uh... Rainbow?"}
/obj/rainbow{abyss_native = 1}
/obj/landmark{invisibility = 100; icon = 'player/start.dmi'}
/obj/effect{layer = 5; mouse_opacity = 0; icon = 'grafon/effects/effects.dmi'}
/obj/abyssbeacon{density = 1; icon = 'grafon/cult.dmi'; icon_state = "beacon"; name = "Abyssal supression beacon"; desc = "A mysterious machine, able to supress Abyss in a square around it."}
/obj/abyssbeacon{anchored = 0}
/obj/abyss_altar{density = 1; icon = 'grafon/thingy.dmi'; name = "Abyssal altar"; desc = "Used by those folks trying to control chaotic powers of Abyss or just trying to escape this endless nightmare"; icon_state = "abyss_altar"}
/obj/tentacle{icon = 'grafon/effects/structure.dmi'; icon_state = "tentacle1"; var/thp = 25};/obj/harch;/obj/grenade_bullet{icon = 'grafon/item/liquid.dmi'; icon_state = "grenade"; var/target_x = 0; var/target_y = 0; var/gr; var/obj/current = null};/obj/grenade_bullet{anchored = 0};/obj/syringe_bullet{icon = 'grafon/item/liquid.dmi'; name = "syringe"; var/S; icon_state = "syringe_bullet"; var/obj/current = null; var/target_x = 0; var/target_y = 0};/obj/pseudobullet{invisibility = 101};/obj/vomit{icon = null /*icon id 73: unresolved*/; icon = 'grafon/effects/chemistry.dmi'; name = "pool of vomit"; icon_state = "vomit"; alticon = "gvomit1"};/obj/hud_effect{layer = 5; icon = null /*icon id 75: unresolved*/; icon = 'grafon/hud_effects.dmi'};/obj/cloud{layer = 4.5; icon = null /*icon id 73: unresolved*/; icon = 'grafon/effects/chemistry.dmi'; var/toxin = 0; name = "Cloud"; icon_state = "cloud"; var/heal = 0; var/corrosion = 0; var/fuel = 0; var/temp = 0; var/burning = 0; var/notransfer = 0; var/id = "your mom"};/obj/fire{icon = null /*icon id 73: unresolved*/; icon = 'grafon/effects/chemistry.dmi'; icon_state = "fire"; var/heat = 0; var/amount = 2; alticon = "gfire"};/obj/steam;/obj/omich{icon = 'grafon/thingy.dmi'; name = "???"; desc = "Damn it..."};/obj/drugged{invisibility = 5; icon = 'grafon/thingy.dmi'; var/laggy = 1; var/overlaps = 0; var/clock = 10; var/mobile = 0; var/lurking = 0; var/collides = 0; var/touches = 0; var/stuns = 0; var/whispers = 0};/obj/gumbie{layer = 5; icon = null /*icon id 86: unresolved*/; icon = 'grafon/huge.dmi'; name = "Welcome, damn it!"}
/obj/gumbie/New()
	if(prob(80))
		icon_state = "skull"
	else
		icon_state = "owl"

/obj/gumbie/proc/randomize()










	src.icon_state = pick("gumbie", "sad", "rooster", "syndicate", "vault", "grief", "holt", "elephant", "shitcurity")
	spawn(600) src.randomize()
/obj/poster
	icon = 'grafon/poster.dmi'
	name = "Poster"
	icon_state = "04"
/obj/poster
/obj/poster/bar
	icon_state = "bar"
	name = "Russkaya shaverma"
/obj/poster/bar
/obj/poster/bar/New()
	name = pick("Russkaya shaverma", "Blue oyster", "BNHO", "ПNBO", "RobustovЪ and son", "Spess Gentlemen Club")
/obj/effect/smite
	icon_state = "smite"
/obj/effect/liquid_splash
	icon = null /*icon id 73: unresolved*/
	icon = 'grafon/effects/chemistry.dmi'
	icon_state = "liquid"
	name = "liquid"
/obj/effect/sparks
	icon = 'grafon/effects/electrical.dmi'
	name = "Sparks"
	icon_state = "spark"
/obj/effect/lightning{density = 1; icon = 'grafon/effects/electrical.dmi'; name = "Ball lightning"; icon_state = "lightning"; desc = "OHOHOHOHOH RUN AWAY RIGHT NOW RETARD"}
/obj/effect/blood_splash{icon_state = "blood_splash"}
/obj/effect/blood_splash/New()

	..()
	spawn(10) del(src)

/obj/effect/goo_splash
	icon_state = "goo_splash"
/obj/effect/goo_splash
/obj/effect/goo_splash/New()
	..()
	spawn(10) del(src)
/obj/effect/rad
	name = "irradiation"
	icon_state = "rad"
/obj/effect/rad
/obj/effect/rad/New()
	..()
	spawn(20) del(src)


/obj/effect/rhinestones
	layer = TURF_LAYER + 0.5
	icon_state = "rhinestones"
