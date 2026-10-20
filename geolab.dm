// Recovered from compiled neek.dmb (13 procs)

/obj/machine/dust
	name = "Micro-particle configurator"
	icon_state = "molecular"
	var/lamp = "red"
	var/obj/lightOL = null
/var/geology_logs = null
/obj/machine/spectrometer/proc/scan(uzurr)
	for(var/obj/item/reagent_container/consumable/dust/D in src.loc)
		src.dir = 1
		src.luminosity = 2
		spawn(30)
			src.dir = 2
			src.luminosity = 0
			uzurr << "\blue The console softly beeps to you:"
			if(!(D == null))
				for(var/datum/reagent/R in D.reagent_list)
					uzurr << "Amount of [R.name]: [R.amount]"
			else
				usr << "\red \bold Error: no reagents found."

/obj/machine/dust/New()





	src.sd_SetLuminosity(1)
	var/CL = new /obj/clight(loc)
	src.overlays += CL
	src.lightOL = CL

/obj/machine/dust/examine()
	usr << "Configurator's lamps are glowing in [lamp]."




/obj/machine/dust/proc/rad()

	for(var/obj/item/reagent_container/consumable/dust/D in src.loc)
		D.morph_color(src.lamp)

	src.luminosity = 2
	src.dir = 1
	spawn(20)
		src.dir = 2
		src.luminosity = 0

/obj/machine/dust/proc/switch_lamp()









	switch(src.lamp)
		if("red")

			src.lamp = "green"
			lightOL:icon -= rgb(255, 0, 0)
			src.lightOL.icon += rgb(0, 255, 0)
		if("green")

			src.lamp = "blue"
			lightOL:icon -= rgb(0, 255, 0)
			src.lightOL.icon += rgb(0, 0, 255)
		if("blue")


			src.lamp = "red"
			lightOL:icon -= rgb(0, 0, 255)
			src.lightOL.icon += rgb(255, 0, 0)

/obj/comp/dust












	board = new /obj/item/electronics/board/dust
	icon_state = "dust";name = "Spectrometry Control Console"
/obj/comp/dust/verb/scan()
	set name = "Begin spectrometry"
	set src in view(1)

	if(!src.on)
		usr << "\red \bold It is off, damn it!"
		return

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	for(var/obj/machine/spectrometer/S in range(10, src.loc))
		S.scan(usr)
		return
/obj/comp/dust/verb/rad()
	set name = "Begin microparticle re-config"
	set src in view(1)

	if(!src.on)
		usr << "\red \bold It is off, damn it!"
		return

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	for(var/obj/machine/dust/D in range(10, src.loc))
		D.rad()
		return
/obj/comp/dust/verb/lamp()
	set name = "Swtich light color"
	set src in view(1)

	if(!src.on)
		usr << "\red \bold It is off, damn it!"
		return

	if("chromosome" in usr.mutations)
		usr << "\red \bold You don't know how to operate it!"
		return

	if(!usr.candofun)
		usr << "\red You're unable to operate machinery!"
		return

	for(var/obj/machine/dust/D in range(10, src.loc))
		D.switch_lamp()
		return

/obj/comp/dust/New()
	src.powercheck()
/obj/comp/dust/operate(obj/W)
	src.turnoff()
















var/list/red_morphable = list()
var/list/green_morphable = list()
var/list/blue_morphable = list()

var/list/chemical_morphable = list("carbon", "sulfur", "iron", "aluminum", "silicon", "sodium", "lithium", "potassium", "rhinestones", "amalgam", "toxin", "regenerite", "3-MeO-PCP", "3-MeO-PCE", "PCP", "PCE", "amphetamine", "dextroamphetamine", "methamphetamine")


var/list/chemical_morphable_easy = list("carbon", "sulfur", "iron", "aluminum", "silicon", "sodium", "lithium")
var/list/chemical_morphable_hard = list("regenerite", "3-MeO-PCP", "3-MeO-PCE", "PCP", "PCE", "amphetamine", "dextroamphetamine", "methamphetamine", "benzaldehyde", "acetic anhydride")

var/list/easy_index = list()
var/list/hard_index = list()
var/default_max_morph = 6
/proc/morph_gen()




	var/r_easy_item = chemical_morphable.Copy()
	var/g_easy_item = chemical_morphable.Copy()
	var/b_easy_item = chemical_morphable.Copy()

	for(var/IN in chemical_morphable)

		var/RIT = pick(r_easy_item)
		red_morphable[IN] = RIT
		r_easy_item -= RIT

		var/GIT = pick(g_easy_item)
		green_morphable[IN] = GIT
		g_easy_item -= GIT

		var/BIT = pick(b_easy_item)
		blue_morphable[IN] = BIT
		b_easy_item -= BIT

/obj/item/reagent_container/consumable/dust
	maxamount = 0
	name = "Star dust"
	icon_state = "dust"
	desc = "It glows softly."
	var/max_morph = 0
/obj/item/reagent_container/consumable/dust
/obj/item/reagent_container/consumable/dust/New()
	var/things = rand(5, 10)
	src.add_chem("silicon", "silicon", things, 0)


/obj/item/reagent_container/consumable/dust/proc/morph_color(clr)

	src.max_morph++
	if(src.max_morph > default_max_morph)
		src.show_message("\red \bold The star dust decomposts into fine powder due to intense radiation!")
		var/T = new /obj/item/reagent_container/consumable/track(loc)
		for(var/datum/reagent/R in src.reagent_list)
			T:add_chem(R.name, R.id, R.amount / 2, 0)
		del(src)
		return
	else
		for(var/datum/reagent/R in reagent_list)

			var/delitel = 1.5

			if(clr == "red" && red_morphable[R.name])

				if(red_morphable[R.name] in chemical_morphable_hard)
					delitel *= 2

				src.add_chem(red_morphable[R.name], red_morphable[R.name], R.amount / delitel, 0)


			if(clr == "green" && green_morphable[R.name])

				if(green_morphable[R.name] in chemical_morphable_hard)
					delitel *= 2

				src.add_chem(green_morphable[R.name], green_morphable[R.name], R.amount / delitel, 0)

			if(clr == "blue" && blue_morphable[R.name])

				if(blue_morphable[R.name] in chemical_morphable_hard)
					delitel *= 2

				src.add_chem(blue_morphable[R.name], blue_morphable[R.name], R.amount / delitel, 0)

			spawn(1) src.remove_chem(R.name, R.amount)
