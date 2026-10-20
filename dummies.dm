// Recovered from compiled neek.dmb (7 procs)

/mob/gay
	limbs = list(new /obj/limb/head, new /obj/limb/r_hand, new /obj/limb/l_hand, new /obj/limb/r_leg, new /obj/limb/l_leg); name = "Boris"
/mob/gay/New()
	src.realname = src.name
	src.toxdmg()
	src.spacedmg()
	src.adv_visuals()
	src.update_sprite()
	src.dir = pick(1, 2, 8, 4)
	src.maggot = 1

/mob/cultist


	limbs = list(new /obj/limb/head, new /obj/limb/r_hand, new /obj/limb/l_hand, new /obj/limb/r_leg, new /obj/limb/l_leg); name = "La Vay"
/mob/cultist/New()
	src.realname = src.name
	src.toxdmg()
	src.spacedmg()
	src.adv_visuals()
	src.update_sprite()
	src.dir = pick(1, 2, 8, 4)
	src.cult = 1

/mob/dummy
	hepe = 9999

	limbs = list(new /obj/limb/head, new /obj/limb/r_hand, new /obj/limb/l_hand, new /obj/limb/r_leg, new /obj/limb/l_leg); name = "Test dummy"
/mob/dummy/New()
	src.realname = src.name
	src.toxdmg()
	src.spacedmg()
	src.adv_visuals()
	src.update_sprite()
	src.dir = pick(1, 2, 8, 4)
	src.maggot = 1
/mob
	name = "Wasya"
/mob/dummy
/mob/dummy/popo
	graped = 1
/mob/dummy/popo
/mob/pedalspawn
	limbs = list(new /obj/limb/head, new /obj/limb/r_hand, new /obj/limb/l_hand, new /obj/limb/r_leg, new /obj/limb/l_leg)
/mob/pedalspawn/New()
	src.realname = src.name
	src.toxdmg()
	src.spacedmg()
	src.adv_visuals()
	src.update_sprite()
	src.dir = pick(1, 2, 8, 4)

/mob/junkie
	realname = "William Burroughs"

	limbs = list(new /obj/limb/head, new /obj/limb/r_hand, new /obj/limb/l_hand, new /obj/limb/r_leg, new /obj/limb/l_leg); name = "William Burroughs"
/mob/junkie/New()
	toxdmg()
	spacedmg()
	adv_visuals()
	update_sprite()
	dir = pick(1, 2, 8, 4)
	spawn(5)
		hmur = 80
		benzo = 80


/mob/depro
	realname = "Igor Letoff"
	chronodepr = 10
	limbs = list(new /obj/limb/head, new /obj/limb/r_hand, new /obj/limb/l_hand, new /obj/limb/r_leg, new /obj/limb/l_leg); name = "Igor Letoff"
/mob/depro/New()
	toxdmg()
	spacedmg()
	adv_visuals()
	update_sprite()
	dir = pick(1, 2, 8, 4)


/mob/security
	limbs = list(new /obj/limb/head, new /obj/limb/r_hand, new /obj/limb/l_hand, new /obj/limb/r_leg, new /obj/limb/l_leg); name = "Security officer"
/mob/security/New()
	src.prof = "security major"
	src.name = "Officer [pick("Konovaloff", "Smirnoff", "Beepsky", "Veteranoff", "Kotowasiyski", "Evsykoff", "Patrushev", "Shoigu")]"
	src.realname = src.name
	src.equip_clothes(new /obj/item/clothes/security())
	src.equip_key(new /obj/item/key/security())
	src.equip_brain(new /obj/item/device/brainport/radio())
	src.toxdmg()
	src.spacedmg()
	src.adv_visuals()
	src.update_sprite()
	src.dir = pick(1, 2, 8, 4)
