// Recovered from compiled neek.dmb (4 procs)

/var/list/drugnames = list("emergency mixture syringe", "fibgenerite blister", "anti-psychotic syringe", "fluoxetine blister", "selegiline (2.5) blister", "phenazepam blister", "clonazepam blister", "Dimedrol", "barbital blister", "Korvalol bottle", "emergency calming bottle", "baclofen (1pt)", "baclofen (2.5pts)", "phenibut blister", "gabalon blister", "hash (0.2g)", "hash (0.4g)", "CBD blister", "ibuprofen+ blister", "Cough syrup", "Sol. Ephedrini (30pts, 20%)", "Amantadine flu treatment", "Trigan-D blister", "Tramal injector", "Hydrocetamol (0.5 hydocodone, 5 paracetamol)", "amphe-pill", "IV chainsmoking nicotine injector (approved as an alternative to cigarettes in USSR-4)", "Dextrorall (dextroamphetamine 2pts)", "Piracetam (5)", "glucose pills blister", "carbamazepine blister", "ASD mutations treatment blister", "Mercurine (tm) syphilis treatment blister")












































/var/list/drug_potent = list("fibgenerite blister", "fluoxetine blister", "selegiline (2.5) blister", "clonazepam blister", "barbital blister", "Korvalol bottle", "emergency calming bottle", "baclofen (2.5pts)", "gabalon blister", "hash (0.4g)", "CBD blister", "ibuprofen+ blister", "Cough syrup", "Sol. Ephedrini (30pts, 20%)", "Amantadine flu treatment", "Tramal injector", "Hydrocetamol (0.5 hydocodone, 5 paracetamol)", "amphe-pill", "Dextrorall (dextroamphetamine 2pts)", "glucose pills blister", "carbamazepine blister", "ASD mutations treatment blister")

/obj/item/supplycharge
	market_price = 100
	name = "Supply cartridge (1 point)"
	icon_state = "cartridge"

/obj/item/supplycharge

/obj/item/stamp
	icon_state = "stamp"
	name = "recipe stamp"
	desc = "A device used for forging medical recipes."

/obj/item/stamp

/obj/item/recipe
	name = "recipe card"
	desc = "A doctor can take you one if you want to use one of this automatic drug stores."
	var/card_drug
	var/reforge_left = 1

/obj/item/recipe


/obj/item/recipe/blank
	reforge_left = 2
	name = "recipe card (blank)"
	icon_state = "recipe_blank"

/obj/item/recipe/blank



/obj/item/recipe/emerg
	card_drug = "emergency mixture syringe"
	name = "detoxication mix recipe card"
	icon_state = "recipe_blue"

/obj/item/recipe/emerg


/obj/item/recipe/halo
	card_drug = "anti-psychotic syringe"
	name = "haloperidol recipe card"
	icon_state = "recipe_red"

/obj/item/recipe/halo

/obj/item/recipe/speed
	card_drug = "amphe-pill"
	name = "stimulators recipe card"
	icon_state = "recipe_white"

/obj/item/recipe/speed

/obj/item/recipe/weed
	card_drug = "hash (0.2g)"
	name = "cannabis recipe card"
	icon_state = "recipe_green"

/obj/item/recipe/weed

/obj/item/recipe/syrup
	card_drug = "Cough syrup"
	name = "cough syrup recipe card"
	icon_state = "recipe_purple"

/obj/item/recipe/syrup

/obj/item/recipe/fibgen
	card_drug = "fibgenerite blister"
	name = "fibgenerite recipe card"
	icon_state = "recipe_yellow"

/obj/item/recipe/fibgen
/obj/item/recipe/attack_by(obj/I)
	if(istype(I, /obj/item/stamp))
		if(src:reforge_left)
			var/drugname = input("", "What kind of drug you want to?", "cancel") in drugnames
			if(drugname && usr.item == I)
				usr << "\blue You forge a recipe card ([drugname])."
				src.card_drug = drugname
				src.icon_state = "recipe_white"
				src.name = "recipe card ([drugname])"
				src:reforge_left--
		else
			usr << "\red \bold This recipe is too filled with stamps and shit! You cannot reforge it!"
	else
		..()

/obj/machine/drug/examine()



	var/T = "<B>Well, what do we have here?</B><HR><BR>"
	for(var/obj/O in src.contents)
		T = addtext(T, "<I>[O.name]</I><BR>")
	usr << browse(T)

/obj/machine/drug
	name = "automatic drug store"
	desc = "An automatic drug store."
	icon_state = "drug_store"

/obj/machine/drug/attack_by(obj/I)
	if(istype(I, /obj/item/recipe))
		var/R = new /obj/item/recipe()
		R = I
		var/Idrug = null

		if(R:card_drug)
			for(var/obj/item/A in src.contents)
				if(A.name == R:card_drug)
					Idrug = A

			if(!Idrug)
				usr << "\red \bold Sorry, out of stock!"
			else
				Idrug:loc = src.loc
				spawn(0) src.contents -= Idrug
		else

			usr << "\red \bold This recipe card doesn't have any stamps nor drug name! Who do you trying to shame, uh?"
			return

	else if(istype(I, /obj/item/device/consolehack))

	else if(istype(I, /obj/item/tool/pulse))

		if(I:charges <= 0)
			return

		if(prob(50 + usr.luck - usr.thrill * 2 + usr.energyprotect * 1.5) && !("chromosome" in usr.mutations))
			I:charges--
			usr << "\blue You successfully hack [src.name]!"
		else

			if(prob(50))
				I:charges--
			usr << "\red \bold You try to hack [src.name], but your [I:name] slips to the power supply wire, shocking you!"
			if(usr.energyprotect < 7)
				usr.stun(6)
				usr.damaga(5, "burn")
				if(prob(50))
					usr.torment(3)
				if(prob(25))
					usr.epilepsy += 2
			else
				usr.stun(2)
				usr.damaga(2, "burn")
/obj/machine/drug/New()

	for(var/atom/A in src.contents)

		if(A.name in drug_potent && prob(15))
			del(A)
			spawn(0) src.contents -= A


/obj/machine/drug/common
	contents = list(new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/blister/asd0,
		new /obj/item/reagent_container/consumable/pill/speed,
		new /obj/item/reagent_container/consumable/hash/pluha,
		new /obj/item/reagent_container/beaker/bottle/syrup,
		new /obj/item/reagent_container/beaker/bottle/syrup,
		new /obj/item/blister/fibgenerite,
		new /obj/item/blister/mercury,
		new /obj/item/blister/dimedrol,
		new /obj/item/blister/amantadine,
		new /obj/item/blister/phenazepam,
		new /obj/item/blister/bakla,
		new /obj/item/blister/ibuprofen,
		new /obj/item/blister/sedative,
		new /obj/item/reagent_container/beaker/bottle/korvalol,
		new /obj/item/reagent_container/syringe/injector/tramal,
		new /obj/item/blister/glucose,
		new /obj/item/blister/cetam,
		new /obj/item/reagent_container/beaker/bottle/salut,
		new /obj/item/blister/phenibut,
		new /obj/item/blister/gabalon,
		new /obj/item/blister/carbamazepine,
		new /obj/item/reagent_container/syringe/injector/cigs,









































		new /obj/item/reagent_container/syringe/injector/cigs)
	name = "Drug store"
	desc = "A common drug store. Has some fibgen pills, emergency syringes and cough syrup in the stock"

/obj/machine/drug/common

/obj/machine/drug/secure
	contents = list(new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/blister/asd0,
		new /obj/item/reagent_container/consumable/pill/speed,
		new /obj/item/reagent_container/consumable/pill/speed,
		new /obj/item/reagent_container/consumable/pill/dextro,
		new /obj/item/reagent_container/consumable/hash/pluha,
		new /obj/item/reagent_container/consumable/hash/pluha,
		new /obj/item/reagent_container/beaker/bottle/syrup,
		new /obj/item/reagent_container/beaker/bottle/syrup,
		new /obj/item/reagent_container/beaker/bottle/syrup,
		new /obj/item/blister/fibgenerite,
		new /obj/item/blister/mercury,
		new /obj/item/reagent_container/syringe/halo,
		new /obj/item/blister/dimedrol,
		new /obj/item/blister/dimedrol,
		new /obj/item/blister/amantadine,
		new /obj/item/blister/phenazepam,
		new /obj/item/blister/phenazepam,
		new /obj/item/blister/clonazepam,
		new /obj/item/blister/sedative,
		new /obj/item/blister/phenibut,
		new /obj/item/blister/phenibut,
		new /obj/item/blister/gabalon,
		new /obj/item/blister/bakla,
		new /obj/item/blister/bakla25,
		new /obj/item/blister/ibuprofen,
		new /obj/item/blister/ibuprofen,
		new /obj/item/blister/hydro,
		new /obj/item/blister/glucose,
		new /obj/item/blister/glucose,
		new /obj/item/blister/cetam,
		new /obj/item/reagent_container/beaker/bottle/trank,
		new /obj/item/reagent_container/beaker/bottle/korvalol,
		new /obj/item/reagent_container/beaker/bottle/salut,
		new /obj/item/reagent_container/beaker/bottle/salut,
		new /obj/item/blister/fluoxetine,
		new /obj/item/blister/carbamazepine,
		new /obj/item/reagent_container/syringe/injector/tramal,
		new /obj/item/reagent_container/syringe/injector/tramal,
		new /obj/item/reagent_container/syringe/injector/cigs,
		new /obj/item/reagent_container/syringe/injector/cigs,
		new /obj/item/reagent_container/syringe/injector/cigs,
		new /obj/item/reagent_container/consumable/pill/asd,
























































		new /obj/item/reagent_container/consumable/pill/asd)
	name = "drug store+"
	icon_state = "drug_store_heavy"
	desc = "A heavy-duty drug store, having a bit of every preciption drug avaible."

/obj/machine/drug/secure


/obj/machine/drug/nuthouse
	contents = list(new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/reagent_container/consumable/hash/pluha,
		new /obj/item/reagent_container/consumable/hash/pluha,
		new /obj/item/reagent_container/syringe/halo,
		new /obj/item/reagent_container/syringe/halo,
		new /obj/item/blister/dimedrol,
		new /obj/item/blister/phenazepam,
		new /obj/item/blister/phenazepam,
		new /obj/item/blister/clonazepam,
		new /obj/item/blister/sedative,
		new /obj/item/blister/sedative,
		new /obj/item/blister/phenibut,
		new /obj/item/blister/phenibut,
		new /obj/item/blister/gabalon,
		new /obj/item/blister/gabalon,
		new /obj/item/blister/glucose,
		new /obj/item/blister/glucose,
		new /obj/item/blister/cetam,
		new /obj/item/blister/ibuprofen,
		new /obj/item/reagent_container/beaker/bottle/trank,
		new /obj/item/reagent_container/beaker/bottle/korvalol,
		new /obj/item/blister/sel,
		new /obj/item/blister/sel,
		new /obj/item/blister/fluoxetine,
		new /obj/item/blister/fluoxetine,
		new /obj/item/reagent_container/syringe/injector/cigs,
		new /obj/item/reagent_container/syringe/injector/cigs,



















		new /obj/item/reagent_container/syringe/injector/cigs)
	name = "sedatives store"
	desc = "A kind of drug store usually placed in those dirty asylums for nuts."

/obj/machine/drug/weed
	contents = list(new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/reagent_container/consumable/hash/pluha,
		new /obj/item/reagent_container/consumable/hash/pluha,
		new /obj/item/reagent_container/consumable/hash/pluha,
		new /obj/item/reagent_container/consumable/hash/pluha,
		new /obj/item/reagent_container/consumable/hash/pluha,
		new /obj/item/reagent_container/consumable/hash/pluha_big,
		new /obj/item/reagent_container/consumable/hash/pluha_big,
		new /obj/item/reagent_container/consumable/hash/pluha_big,
		new /obj/item/blister/sedative_cbd,
		new /obj/item/blister/sedative_cbd,
		new /obj/item/reagent_container/syringe/injector/cigs,











		new /obj/item/reagent_container/syringe/injector/cigs)
	name = "medical cannabis store"
	icon_state = "drug_store_hash"
	desc = "A special drug store for medical cannabis (recipe is required, you pothead)."

/obj/machine/drug/speed
	contents = list(new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/reagent_container/consumable/pill/speed,
		new /obj/item/reagent_container/consumable/pill/speed,
		new /obj/item/reagent_container/consumable/pill/speed,
		new /obj/item/reagent_container/consumable/pill/speed,
		new /obj/item/reagent_container/consumable/pill/dextro,
		new /obj/item/reagent_container/consumable/pill/dextro,





		new /obj/item/blister/cetam)
	name = "automatic stimulators store"
	desc = "A special drug store for late workers."

/obj/machine/drug/military
	contents = list(new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/reagent_container/syringe/emergency,
		new /obj/item/blister/asd0,
		new /obj/item/blister/asd0,
		new /obj/item/reagent_container/consumable/pill/speed,
		new /obj/item/reagent_container/consumable/pill/speed,
		new /obj/item/reagent_container/consumable/pill/speed,
		new /obj/item/reagent_container/consumable/pill/speed,
		new /obj/item/reagent_container/consumable/pill/dextro,
		new /obj/item/reagent_container/consumable/pill/dextro,
		new /obj/item/reagent_container/consumable/pill/dextro,
		new /obj/item/blister/fibgenerite,
		new /obj/item/blister/fibgenerite,
		new /obj/item/reagent_container/beaker/bottle/trank,
		new /obj/item/reagent_container/beaker/bottle/korvalol,
		new /obj/item/reagent_container/beaker/bottle/korvalol,
		new /obj/item/blister/hydro,
		new /obj/item/reagent_container/syringe/injector/tramal,
		new /obj/item/reagent_container/syringe/injector/tramal,
		new /obj/item/reagent_container/syringe/injector/tramal,
		new /obj/item/reagent_container/consumable/pill/asd,
		new /obj/item/reagent_container/syringe/injector/cigs,
		new /obj/item/reagent_container/syringe/injector/cigs,













		new /obj/item/reagent_container/syringe/injector/cigs)
	icon_state = "drug_store_heavy"
	name = "military spacefleet onboard drugstore"
	desc = "A military drug store. Full of speed and fix-me-fast kind of needles."
