/obj/item/reagent_container/consumable/gland{market_price = 228; icon_state = "gland"; name = "Pineal gland"; desc = "I think this guy don't need it anymore. Let's find better use for this thing"}
/obj/item/reagent_container/consumable/spice{smokeable = 1; maxamount = 10; chem_capacity = 10; ret = 30; grun = 50; name = "spice silver"; desc = "Not for human consumption."; icon_state = "spice"}
/obj/item/reagent_container/consumable{icon = 'grafon/consumable.dmi'; maxamount = 30; beltable = 1; dmg = 0; var/smokeable = 0; var/chem_capacity = 30}
/obj/item/reagent_container/consumable/spice
/obj/item/reagent_container/consumable/attack(atom/A)



/obj/item/reagent_container/consumable/pill
	maxamount = 0
	chem_capacity = 0
	beltable = 0
	name = "pill"
	desc = "A large pill."
	icon_state = "pill_white"
/obj/item/reagent_container/consumable/pill
/obj/item/reagent_container/consumable/pill/New()
	pixel_x += rand(-3, 3)
	pixel_y += rand(-3, 3)
/obj/item/reagent_container/consumable/pill/antidote
	name = "antidote pill"
	icon_state = "pill_blue"
/obj/item/reagent_container/consumable/pill/antidote
/obj/item/reagent_container/consumable/pill/antidote/New()
	src.add_chem("antidote", "antidote", 15, 0)
	..()
/obj/item/reagent_container/consumable/pill/fibgenerite
	name = "fibgenerite pill"
	icon_state = "pill_yellow"
/obj/item/reagent_container/consumable/pill/fibgenerite
/obj/item/reagent_container/consumable/pill/fibgenerite/New()
	src.add_chem("fibgenerite", "fibgenerite", 15, 0)
	..()
/obj/item/reagent_container/consumable/pill/nutriment
	icon_state = "pill_yellow"
	name = "nutri-pill"
	desc = "A magic pill for dealing with dat pesky hunger."
/obj/item/reagent_container/consumable/pill/nutriment
/obj/item/reagent_container/consumable/pill/nutriment/New()
	src.add_chem("nutriment", "nutriment", 15, 0)
	..()
/obj/item/reagent_container/consumable/pill/jitter
	icon_state = "pill_yellow"
	name = "jitter pill"
/obj/item/reagent_container/consumable/pill/jitter
/obj/item/reagent_container/consumable/pill/jitter/New()
	src.add_chem("caffeine", "caffeine", 100, 0)
	..()
/obj/item/reagent_container/consumable/pill/speed
	name = "amphe-pill"
	desc = "Ones staying at the workplace for too long might use this pill at their own risk."
	icon_state = "pill_pink"
/obj/item/reagent_container/consumable/pill/speed
/obj/item/reagent_container/consumable/pill/speed/New()
	src.add_chem("amphetamine", "amphetamine", 2, 0)
	..()

/obj/item/reagent_container/consumable/pill/speed/faked
/obj/item/reagent_container/consumable/pill/speed/faked/New()
	if(prob(50))
		src.add_chem("MDPV", "MDPV", 2, 0)
	else
		src.add_chem("amphetamine", "amphetamine", 1.2, 0)
		spawn(0)
			src.add_chem("sugar", "sugar", 0.8, 0)
			..()
/obj/item/reagent_container/consumable/pill/dextro
	name = "Dextrorall (dextroamphetamine 2pts)"
	desc = "Ones staying at the workplace for too long might use this pill at their own risk."
	icon_state = "pill_pink"
/obj/item/reagent_container/consumable/pill/dextro
/obj/item/reagent_container/consumable/pill/dextro/New()
	src.add_chem("dextroamphetamine", "dextroamphetamine", 2, 0)
	..()
/obj/item/reagent_container/consumable/pill/ecstasy
	icon_state = "pill_pink"
	name = "happy wheel"
	desc = "A pink-colored pill."
/obj/item/reagent_container/consumable/pill/ecstasy
/obj/item/reagent_container/consumable/pill/ecstasy/New()
	src.add_chem("MDMA", "MDMA", 10, 0)
	..()
/obj/item/reagent_container/consumable/pill/ecstasy/fag
	name = "happy wheel"
/obj/item/reagent_container/consumable/pill/ecstasy/fag/New()
	src.add_chem("MDMA", "MDMA", 3, 0)
	spawn(0) src.add_chem("fagenerite", "fagenerite", 2, 0)
/obj/item/reagent_container/consumable/pill/ecstasy/crappy
	name = "happy wheel"
/obj/item/reagent_container/consumable/pill/ecstasy/crappy/New()
	src.add_chem("MDMA", "MDMA", 3, 0)
	spawn(0)
		src.add_chem("amphetamine", "amphetamine", 1, 0)
		..()
/obj/item/tool
	beltable = 1
/obj/item/weapon
	dmg = 9
	parry = 5
	accu = 75
	beltable = 1
/obj/item{layer = 3.9; anchored = 0; closet_ok = 1; var{ret = 0; grun = 0; blueh = 0}}
/obj/item/blister/cigs{name = "USSR-4 standart cigarettes"; desc = "Approved for usage on station complexes."; icon_state = "blister_cigs"; icon_empty = "blister_cigs_empty"; pillname = "cigs"; P = /obj/item/reagent_container/cig/tobacco}
/obj/item/blister{icon = 'grafon/item/liquid.dmi'; beltable = 1; desc = "6 pills left"; var/tabs_left = 6; var/pillname = "pills"; var/icon_empty = "blister_empty"; var/P = null}
/obj/item/blister/cigs
/obj/item/blister/attack_self()

	if(tabs_left > 0)
		new P(usr.loc)
		tabs_left--
		spawn(0)
			if(tabs_left == 5)
				icon_state = "[icon_state]_some"
			else if(!tabs_left)
				icon_state = icon_empty
			desc = "[tabs_left] [pillname] left"

/obj/item/blister/verb/remove_pillz()
	set name = "Remove all pills/cigs/ampules/whatever"
	set category = "Item interraction"
	set src in view(1)
	if(tabs_left)
		while(tabs_left)
			new P(usr.loc)
			tabs_left--
			sleep(0)
		spawn(0)
			icon_state = icon_empty
			desc = "0 [pillname] left"

/obj/item/reagent_container/consumable/pill/antidote/small
	name = "antidote pill (5)"
	desc = "A small pill of universal absorbent, good for dealing with medical or industrial intoxications."

/obj/item/reagent_container/consumable/pill/antidote/small


/obj/item/reagent_container/consumable/pill/antidote/small/New()

























	src.add_chem("antidote", "antidote", 5, 0)

/obj/item/reagent_container/consumable/pill/fibgenerite/small
	name = "fibgenerite pill (3)"
	desc = "A small pill. Removes chemical and thermal burns then consumed. I don't know how this baby works and don't give a damn."

/obj/item/reagent_container/consumable/pill/fibgenerite/small

/obj/item/reagent_container/consumable/pill/fibgenerite/small/New()


	src.add_chem("fibgenerite", "fibgenerite", 3, 0)


/obj/item/reagent_container/consumable/pill/rimantadine
	icon_state = "pill_blue"
	name = "rimantadine pill"
	desc = "An antiviral pill."

/obj/item/reagent_container/consumable/pill/rimantadine

/obj/item/reagent_container/consumable/pill/rimantadine/New()





































































































































































































	src.add_chem("rimantadine", "rimantadine", 4, 0)
	..()

/obj/item/reagent_container/consumable/pill/sedative
	name = "barbital pill"
	desc = "A strong sedative."
/obj/item/reagent_container/consumable/pill/sedative
/obj/item/reagent_container/consumable/pill/sedative/New()
	src.add_chem("barbital", "barbital", 5, 0)
	..()

/obj/item/reagent_container/consumable/pill/sedative_weed
	name = "sedative pill"
	desc = "An experimental sedative. Use at your own risk."
/obj/item/reagent_container/consumable/pill/sedative_weed
/obj/item/reagent_container/consumable/pill/sedative_weed/New()
	src.add_chem("CBD", "CBD", 4, 0)
	..()

/obj/item/reagent_container/consumable/pill/phenazepam
	name = "phenazepam pill"
	desc = "A sedative."
/obj/item/reagent_container/consumable/pill/phenazepam
/obj/item/reagent_container/consumable/pill/phenazepam/New()
	src.add_chem("phenazepam", "phenazepam", 5, 0)
	..()
/obj/item/reagent_container/consumable/pill/valium
	icon_state = "pill_pink"
	desc = "A sedative."
	name = "valium pill"
/obj/item/reagent_container/consumable/pill/valium
/obj/item/reagent_container/consumable/pill/valium/New()
	src.add_chem("diazepam", "diazepam", 5, 0)
	..()

/obj/item/reagent_container/consumable/pill/dicyclomine
	name = "Trigan-D pill"
	desc = "A pill of a weak painkiller."
/obj/item/reagent_container/consumable/pill/dicyclomine
/obj/item/reagent_container/consumable/pill/dicyclomine/New()
	src.add_chem("dicyclomine", "dicyclomine", 5, 0)
	src.add_chem("paracetamol", "paracetamol", 5, 0)
	..()

/obj/item/reagent_container/consumable/pill/dimedrol
	name = "Dimedrol pill"
	desc = "A pill of a weak sedative."
/obj/item/reagent_container/consumable/pill/dimedrol
/obj/item/reagent_container/consumable/pill/dimedrol/New()
	src.add_chem("DPH", "DPH", 4.5, 0)
	..()
/obj/item/reagent_container/consumable/pill/aminazine
	icon_state = "pill_red"
	name = "aminazine pill"
	desc = "A pill of strong neuroleptic."
/obj/item/reagent_container/consumable/pill/aminazine
/obj/item/reagent_container/consumable/pill/aminazine/New()
	src.add_chem("aminazine", "aminazine", 5, 0)
	..()

/obj/item/reagent_container/consumable/pill/cyclodol
	name = "cyclodol pill"
	desc = "A pill of stuff usually taken along with neuropeptics to soften their side-effects."
/obj/item/reagent_container/consumable/pill/cyclodol
/obj/item/reagent_container/consumable/pill/cyclodol/New()
	src.add_chem("trihexyphenidyl", "trihexyphenidyl", 4, 0)
	..()
/obj/item/reagent_container/consumable/pill/carbamazepine
	icon_state = "pill_pink"
	name = "carbamazepine pill"
	desc = "A pill of soft anti-psychotic which, however, able to cure depression, thrill and tension sometimes."
/obj/item/reagent_container/consumable/pill/carbamazepine
/obj/item/reagent_container/consumable/pill/carbamazepine/New()
	src.add_chem("carbamazepine", "carbamazepine", 5, 0)
	..()
/obj/item/reagent_container/consumable/pill/fluoxetine
	icon_state = "pill_red"
	name = "fluoxetine pill (300mpts)"
	desc = "A pill of common SSRI."
/obj/item/reagent_container/consumable/pill/fluoxetine
/obj/item/reagent_container/consumable/pill/fluoxetine/New()
	src.add_chem("fluoxetine", "fluoxetine", 0.3, 0)
	..()
/obj/item/reagent_container/consumable/pill/selegiline
	icon_state = "pill_sel"
	name = "selegiline pill (300mpts)"
	desc = "A pill of common MAOI."
/obj/item/reagent_container/consumable/pill/selegiline
/obj/item/reagent_container/consumable/pill/selegiline/New()
	src.add_chem("selegiline", "selegiline", 0.3, 0)
	..()

/obj/item/reagent_container/consumable/pill/bakla10
	name = "baclofen pill (10)"
	desc = "A pill of GABA derivative."
/obj/item/reagent_container/consumable/pill/bakla10
/obj/item/reagent_container/consumable/pill/bakla10/New()
	src.add_chem("baclofen", "baclofen", 1, 0)
	..()

/obj/item/reagent_container/consumable/pill/bakla25
	desc = "A pill of GABA derivative."
	name = "baclofen pill (25)"
/obj/item/reagent_container/consumable/pill/bakla25
/obj/item/reagent_container/consumable/pill/bakla25/New()
	src.add_chem("baclofen", "baclofen", 2.5, 0)
	..()

/obj/item/reagent_container/consumable/pill/booze
	name = "White Squirrel pill"
	desc = "A wonderful pill for curing heavy-ass hangover."
/obj/item/reagent_container/consumable/pill/booze
/obj/item/reagent_container/consumable/pill/booze/New()
	src.add_chem("aminazine", "aminazine", 1, 0)
	spawn(0)
		src.add_chem("glucose", "glucose", 10, 0)
		..()

/obj/item/reagent_container/consumable/pill/glucose
	name = "Glucose pill"
	desc = "This pill is able to cure alcohol or drug addiction... Sometimes. Also, it is very tasty and fitting!"
/obj/item/reagent_container/consumable/pill/glucose
/obj/item/reagent_container/consumable/pill/glucose/New()
	src.add_chem("glucose", "glucose", 30, 0)
	..()

/obj/item/reagent_container/consumable/pill/phenibut
	name = "phenibut pill"
	desc = "A pill of softcore sedative drug."
/obj/item/reagent_container/consumable/pill/phenibut
/obj/item/reagent_container/consumable/pill/phenibut/New()
	src.add_chem("phenibut", "phenibut", 2.5, 0)
	..()
/obj/item/reagent_container/consumable/pill/cetam
	icon_state = "pill_yellowish"
	name = "piracetam pill"
	desc = "A pill of softcore stimulant/mnemotic drug."
/obj/item/reagent_container/consumable/pill/cetam
/obj/item/reagent_container/consumable/pill/cetam/New()
	src.add_chem("piracetam", "piracetam", 5, 0)
	..()
/obj/item/reagent_container/consumable/pill/luckstone
	icon_state = "luckstone"
	name = "Luckstone"
	desc = "Consuming it will greatly increase your luck. Or mildly increase your luck. Or not affect your luck at all. Who knows?"
/obj/item/reagent_container/consumable/pill/luckstone
/obj/item/reagent_container/consumable/pill/luckstone/New()
	src.add_chem("luckstone dust", "luckstone dust", 30, 0)
/obj/item/reagent_container/consumable/pill/ampule
	icon_state = "ampule"
	name = "ampule"
	desc = "A consumable cellulose ampoule."
/obj/item/reagent_container/consumable/pill/ampule
/obj/item/reagent_container/consumable/pill/ampule/New()
	src.add_chem("cellulose", "cellulose", 2, 0)
	..()
/obj/item/reagent_container/consumable/pill/ampule/nexus
	desc = "A consumable cellulose ampoule, filled with some white powder."
/obj/item/reagent_container/consumable/pill/ampule/nexus
/obj/item/reagent_container/consumable/pill/ampule/nexus/New()
	src.add_chem("2C-B", "2C-B", 2.5, 0)
	..()
/obj/item/reagent_container/consumable/pill/ampule/mesc
	desc = "A consumable cellulose ampoule, filled with some white powder."
/obj/item/reagent_container/consumable/pill/ampule/mesc
/obj/item/reagent_container/consumable/pill/ampule/mesc/New()
	src.add_chem("mescaline", "mescaline", 2.5, 0)
	..()
/obj/item/reagent_container/consumable/pill/ampule/homet
	desc = "A consumable cellulose ampoule, filled with some white powder."
/obj/item/reagent_container/consumable/pill/ampule/homet
/obj/item/reagent_container/consumable/pill/ampule/homet/New()
	src.add_chem("4-HO-MET", "4-HO-MET", 1.1, 0)
	..()
/obj/item/reagent_container/consumable/pill/ampule/acodmt
	desc = "A consumable cellulose ampoule, filled with some white powder."
/obj/item/reagent_container/consumable/pill/ampule/acodmt
/obj/item/reagent_container/consumable/pill/ampule/acodmt/New()
	src.add_chem("4-AcO-DMT", "4-AcO-DMT", 1.1, 0)
	..()
/obj/item/reagent_container/consumable/pill/ampule/mxe
	desc = "A consumable cellulose ampoule, filled with some white powder."
/obj/item/reagent_container/consumable/pill/ampule/mxe
/obj/item/reagent_container/consumable/pill/ampule/mxe/New()
	src.add_chem("MXE", "MXE", 3.5, 0)
	..()
/obj/item/reagent_container/consumable/pill/ampule/gabapentin
	name = "gabapentin ampule (5pts)"
	desc = "A consumable cellulose ampoule, filled with epilepsy treatment powder."
/obj/item/reagent_container/consumable/pill/ampule/gabapentin
/obj/item/reagent_container/consumable/pill/ampule/gabapentin/New()
	src.add_chem("gabapentin", "gabapentin", 5, 0)
	..()
/obj/item/reagent_container/consumable/pill/ampule/clonazepam
	name = "clonazepam ampule (0.6)"
	icon_state = "ampule_small"
	desc = "A tiny cellulose ampoule, filled with some white powder."
/obj/item/reagent_container/consumable/pill/ampule/clonazepam
/obj/item/reagent_container/consumable/pill/ampule/clonazepam/New()
	src.add_chem("clonazepam", "clonazepam", 0.6, 0)
	..()
/obj/item/reagent_container/consumable/pill/ampule/nitrazepam
	name = "nitrazepam ampule (1.2)"
	icon_state = "ampule_redblue"
	desc = "An ampule of potent sleep-aid."
/obj/item/reagent_container/consumable/pill/ampule/nitrazepam
/obj/item/reagent_container/consumable/pill/ampule/nitrazepam/New()
	src.add_chem("nitrazepam", "nitrazepam", 1.2, 0)
	..()
/obj/item/reagent_container/consumable/pill/ampule/midazolam
	icon_state = "ampule_small"
	name = "midazolam ampule (7)"
	desc = "An ampule of potent sleep-aid. NEVER take more than 1 tab in a row or you're fucked."
/obj/item/reagent_container/consumable/pill/ampule/midazolam
/obj/item/reagent_container/consumable/pill/ampule/midazolam/New()
	src.add_chem("midazolam", "midazolam", 7, 0)
	..()
/obj/item/reagent_container/consumable/pill/ampule/cosmozepam
	icon_state = "ampule_small"
	desc = "A tiny cellulose ampoule, filled with some white powder."
	name = "cosmozepam ampule (0.5)"
/obj/item/reagent_container/consumable/pill/ampule/cosmozepam
/obj/item/reagent_container/consumable/pill/ampule/cosmozepam/New()
	src.add_chem("cosmozepam", "cosmozepam", 0.5, 0)
	..()
/obj/item/reagent_container/consumable/pill/ampule/risperidone
	name = "risperidone ampule (4)"
	icon_state = "ampule_dark"
	desc = "A cellulose ampoule of a potent antipsychotic drug, which causes dysphoria and drowsiness as a side-effect."
/obj/item/reagent_container/consumable/pill/ampule/risperidone
/obj/item/reagent_container/consumable/pill/ampule/risperidone/New()
	src.add_chem("risperidone", "risperidone", 4, 0)
	..()
/obj/item/reagent_container/consumable/pill/ampule/oxylith
	name = "lithium oxybutyrate/potassium permanganate ampule (6/2)"
	icon_state = "ampule_blue"
	desc = "Some kild of jack-o-all traides in psychiatry: lessens/removes delirium, helps with thrill, tension and non-chronic depression, have some change to cure patient of dysthimia and is able to stop psychosis. Manganeska added for anti-nausea and anti-toxic effects."
/obj/item/reagent_container/consumable/pill/ampule/oxylith
/obj/item/reagent_container/consumable/pill/ampule/oxylith/New()
	src.add_chem("lithium oxybutyrate", "lithium oxybutyrate", 6, 0)
	src.add_chem("manganeska", "manganeska", 2, 0)
	..()

/obj/item/reagent_container/consumable/pill/ampule/halo
	icon_state = "ampule_dark"
	name = "haloperidol ampule (4)"
	desc = "A cellulose ampoule of a potent antipsychotic drug, which causes dysphoria and paralysis as a side-effect."
/obj/item/reagent_container/consumable/pill/ampule/halo
/obj/item/reagent_container/consumable/pill/ampule/halo/New()
	src.add_chem("haloperidol", "haloperidol", 4, 0)
	..()
/obj/item/reagent_container/consumable/pill/ampule/pharmahuasca
	desc = "A consumable cellulose ampoule, filled with some powder."
/obj/item/reagent_container/consumable/pill/ampule/pharmahuasca
/obj/item/reagent_container/consumable/pill/ampule/pharmahuasca/New()
	src.add_chem("harmaline", "harmaline", 0.3, 0)
	spawn(0)
		src.add_chem("DMT", "DMT", 0.4, 0)
		..()

/obj/item/reagent_container/consumable/pill/ampule/psilo
/obj/item/reagent_container/consumable/pill/ampule/psilo
/obj/item/reagent_container/consumable/pill/ampule/psilo/New()
	src.add_chem("psilocybin", "psilocybin", 12, 0)
	..()

/obj/item/reagent_container/consumable/pill/ampule/fivemeo
/obj/item/reagent_container/consumable/pill/ampule/fivemeo
/obj/item/reagent_container/consumable/pill/ampule/fivemeo/New()
	src.add_chem("5-MeO-DMT", "5-MeO-DMT", 0.9, 0)
	..()

/obj/item/reagent_container/consumable/pill/ampule/dipt
/obj/item/reagent_container/consumable/pill/ampule/dipt
/obj/item/reagent_container/consumable/pill/ampule/dipt/New()
	src.add_chem("DiPT", "DiPT", 0.9, 0)
	..()

/obj/item/reagent_container/consumable/pill/ampule/fivedipt
/obj/item/reagent_container/consumable/pill/ampule/fivedipt
/obj/item/reagent_container/consumable/pill/ampule/fivedipt/New()
	src.add_chem("5-MeO-DiPT", "5-MeO-DiPT", 0.9, 0)
	..()

/obj/item/reagent_container/consumable/pill/ampule/mescaline
/obj/item/reagent_container/consumable/pill/ampule/mescaline
/obj/item/reagent_container/consumable/pill/ampule/mescaline/New()
	src.add_chem("mescaline", "mescaline", 0.9, 0)
	..()


/obj/item/reagent_container/consumable/pill/ultramix
	icon_state = "pill_mix"
	name = "universal regeneration mixture pill"
	desc = "A pill of potent healing mixture."

/obj/item/reagent_container/consumable/pill/ultramix

/obj/item/reagent_container/consumable/pill/ultramix/New()
	src.add_chem("regenerite", "regenerite", 3, 0)
	src.add_chem("fibgenerite", "fibgenerite", 3, 0)
	src.add_chem("antidote", "antidote", 3, 0)

/obj/item/reagent_container/consumable/pill/regen
	icon_state = "pill_red"
	name = "regenerite pill (5)"
	desc = "A pill of strong cell restoring drug. If consumed, heals organ damage perfectly."
/obj/item/reagent_container/consumable/pill/regen
/obj/item/reagent_container/consumable/pill/regen/New()
	src.add_chem("regenerite", "regenerite", 5, 0)

/obj/item/reagent_container/consumable/pill/ibuprofen
	name = "ibuprofen+ pill"
	desc = "A preciously good anti-cough pill. Also used in case of strong pain."

/obj/item/reagent_container/consumable/pill/ibuprofen

/obj/item/reagent_container/consumable/pill/ibuprofen/New()














	src.add_chem("ibuprofen", "ibuprofen", 4, 0)
	spawn(0)
		src.add_chem("codeine", "codeine", 0.05, 0)
		..()

/obj/item/reagent_container/consumable/pill/gaba
	name = "gabalon pill"
	desc = "This pill sometimes used for curing addictions as well as removing depression."
/obj/item/reagent_container/consumable/pill/gaba
/obj/item/reagent_container/consumable/pill/gaba/New()
	src.add_chem("GABA", "GABA", 4, 0)

/obj/item/reagent_container/consumable/pill/glucocetamol
	icon_state = "pill_yellowish"
	name = "glucocetamol pill"
	desc = "A pill for curing junkies as well as benzo and barbiturate addicts. Eating more than 3 in a row results in horrid side-effects, so be warned."
/obj/item/reagent_container/consumable/pill/glucocetamol
/obj/item/reagent_container/consumable/pill/glucocetamol/New()
	src.add_chem("ibuprofen", "ibuprofen", 5, 0)
	spawn(0)
		src.add_chem("paracetamol", "paracetamol", 5, 0)
		spawn(0)
			src.add_chem("glucose", "glucose", 10, 0)
			spawn(0)
				src.add_chem("manganeska", "manganeska", 5, 0)
				spawn(0)
					src.add_chem("alprazolam", "alprazolam", 2, 0)
					spawn(0)
						src.add_chem("GABA", "GABA", 2.8, 0)
		..()
/obj/item/reagent_container/consumable/pill/indopan
	icon_state = "pill_pink"
	name = "DiPT-indopan pill"
	desc = "An experimental psychoactive pill, containing a mixture of weak antidepressants and used for psychedelic therapy. Do not use more than 1 pill in a row, however and do not combine it with MAOI!"
/obj/item/reagent_container/consumable/pill/indopan
/obj/item/reagent_container/consumable/pill/indopan/New()
	src.add_chem("DiPT", "DiPT", 0.85, 0)
	spawn(0)
		src.add_chem("4-HO-MET", "4-HO-MET", 0.4, 0)
		spawn(0)
			src.add_chem("4-AcO-DMT", "4-AcO-DMT", 0.4, 0)
			spawn(0)
				src.add_chem("AMT", "AMT", 0.8, 0)
				spawn(0)
					src.add_chem("alprazolam", "alprazolam", 2, 0)
					spawn(0)
						src.add_chem("CBD", "CBD", 3, 0)
						spawn(0)
							src.add_chem("THC", "THC", 0.8, 0)
							spawn(0)
								src.add_chem("GABA", "GABA", 2, 0)
		..()
/obj/item/reagent_container/consumable/pill/empathopentin
	icon_state = "pill_sel"
	name = "empathopentin pill"
	desc = "A psychoactive pill for using in pair of SSRI (but NOT MAOI) to get rid of many of the horrid conditions. Usually used at the late stage of withdrawals of addict breaking with heavy drug usage. Eating more than 2 pills results in unpleasant side-effects such as heavy drowsiness. Also, it contains ibuprofen, just like glucocetamlol, so be careful while using both of this drugs on one patient."
/obj/item/reagent_container/consumable/pill/empathopentin
/obj/item/reagent_container/consumable/pill/empathopentin/New()
	src.add_chem("ibuprofen", "ibuprofen", 3.3, 0)
	spawn(0)
		src.add_chem("glucose", "glucose", 4, 0)
		spawn(0)
			src.add_chem("manganeska", "manganeska", 6, 0)
			spawn(0)
				src.add_chem("MDA", "MDA", 4, 0)
				spawn(0)
					src.add_chem("gabapentin", "gabapentin", 7, 0)
					spawn(0)
						src.add_chem("GABA", "GABA", 2, 0)
		..()
/obj/item/reagent_container/consumable/pill/methadone
	icon_state = "pill_methadone"
	name = "Methadone pill"
	desc = "For peroral usage only."
/obj/item/reagent_container/consumable/pill/methadone
/obj/item/reagent_container/consumable/pill/methadone/New()
	src.add_chem("methadone", "methadone", 0.2, 0)
	spawn(0)
		src.add_chem("cellulose", "cellulose", 1, 0)
	..()
/obj/item/reagent_container/consumable/pill/heroin
	icon_state = "pill_blue"
	desc = "For peroral usage only."
	name = "Heroin pill"
/obj/item/reagent_container/consumable/pill/heroin
/obj/item/reagent_container/consumable/pill/heroin/New()
	src.add_chem("heroin", "heroin", 0.2, 0)
	..()

/obj/item/reagent_container/consumable/pill/oxy
	name = "OxyContinuum painkiller pill"
	desc = "A combination drug with each pill containing 15pts of paracetamol and 50mpts of oxycodone. It has a tiny note scrabbled in it: 'For peroral usage only.'"
/obj/item/reagent_container/consumable/pill/oxy
/obj/item/reagent_container/consumable/pill/oxy/New()
	src.add_chem("paracetamol", "paracetamol", 15, 0)
	spawn(1)
		src.add_chem("oxycodone", "oxycodone", 0.05, 0)
		..()

/obj/item/reagent_container/consumable/pill/buproxone
	desc = "For peroral usage only."
	name = "Buproxone (tm) pill"
/obj/item/reagent_container/consumable/pill/buproxone
/obj/item/reagent_container/consumable/pill/buproxone/New()
	src.add_chem("buprenorphine", "buprenorphine", 0.2, 0)
	spawn(0)
		src.add_chem("naloxone", "naloxone", 5, 0)
		spawn(0)
			src.add_chem("cellulose", "cellulose", 1, 0)
		..()
/obj/item/reagent_container/consumable/pill/hydro
	desc = "For peroral usage only."
	icon_state = "pill_hydro"
	name = "Hydrocetamol pill"
/obj/item/reagent_container/consumable/pill/hydro
/obj/item/reagent_container/consumable/pill/hydro/New()
	src.add_chem("hydrocodone", "hydrocodone", 0.05, 0)
	spawn(0)
		src.add_chem("paracetamol", "paracetamol", 5, 0)
		spawn(0)
			src.add_chem("cellulose", "cellulose", 0.9, 0)
		..()
/obj/item/reagent_container/consumable/pill/amantadine
	icon_state = "pill_blue"
	name = "amantadine pill"
	desc = "You probably shouldn't take more than 1 pill at a time."
/obj/item/reagent_container/consumable/pill/amantadine
/obj/item/reagent_container/consumable/pill/amantadine/New()
	src.add_chem("amantadine", "amantadine", 4, 0)
	..()


/obj/item/reagent_container/consumable/pill/mercury
	icon_state = "pill_blue"
	name = "Mercurine (tm) pill"
	desc = "A common syphilis treatment. Somewhat toxic, however."

/obj/item/reagent_container/consumable/pill/mercury

/obj/item/reagent_container/consumable/pill/mercury/New()


	src.add_chem("mercury", "mercury", 4.5, 0)
	spawn(0)
		src.add_chem("slowgenerite", "slowgenerite", 0.6, 0)
		..()


/obj/item/reagent_container/consumable/pill/meow
	icon_state = "pill_pink"
	name = "Meow-meow pill"
	desc = "Meoooooooooooooow!^___^"
/obj/item/reagent_container/consumable/pill/meow
/obj/item/reagent_container/consumable/pill/meow/New()
	src.add_chem("mephedrone", "mephedrone", 1.8, 0)
/obj/item/reagent_container/consumable/pill/fagenerite
	icon_state = "pill_pink"
	name = "Kinky pill"
	desc = "Well, uh. I don't know what to say."
/obj/item/reagent_container/consumable/pill/fagenerite
/obj/item/reagent_container/consumable/pill/fagenerite/New()
	src.add_chem("fagenerite", "fagenerite", 2, 0)
	spawn(0)
		src.add_chem("GHB", "GHB", 9, 0)
/obj/item/reagent_container/consumable/pill/glow
	icon_state = "pill_blue"
	name = "Glow-pill"
	desc = "This stuff makes you glow. WARNING: too many of this pills may cause poorly-researched side-effects."
/obj/item/reagent_container/consumable/pill/glow
/obj/item/reagent_container/consumable/pill/glow/New()
	src.add_chem("Nuclear titbit", "Nuclear titbit", 8, 0)

/obj/item/reagent_container/consumable/pill/peace
	name = "Peacenipizine pill"
	desc = "Use at your own risk"
/obj/item/reagent_container/consumable/pill/peace
/obj/item/reagent_container/consumable/pill/peace/New()
	src.add_chem("peacenipizine", "peacenipizine", 6.5, 0)
/obj/item/reagent_container/consumable/pill/funk
	icon_state = "pill_shiny"
	name = "Funky pill"
	desc = "So much fun! Now with rhinestones!"
/obj/item/reagent_container/consumable/pill/funk
/obj/item/reagent_container/consumable/pill/funk/New()
	src.add_chem("MDMA", "MDMA", 6, 0)
	spawn(0)
		src.add_chem("rhinestones", "rhinestones", 10, 0)

/obj/item/party
	icon = 'grafon/device.dmi'
	market_price = 1700
	icon_state = "package"
	name = "package"
	desc = "It looks a bit suspicious."
/obj/item/party
/obj/item/party/attack_self()
	usr << "\blue You deploy your package."
	new /obj/item/reagent_container/beaker/bottle/titbit(usr.loc)
	sleep(0)
	new /obj/item/reagent_container/beaker/bottle/tuborg(usr.loc)
	new /obj/item/reagent_container/beaker/bottle/tuborg(usr.loc)
	new /obj/item/reagent_container/beaker/bottle/tuborg(usr.loc)
	sleep(0)
	new /obj/item/reagent_container/consumable/pill/ecstasy(usr.loc)
	new /obj/item/reagent_container/consumable/pill/ecstasy(usr.loc)
	sleep(0)
	new /obj/item/reagent_container/consumable/pill/funk(usr.loc)
	new /obj/item/reagent_container/consumable/pill/funk(usr.loc)
	sleep(0)
	new /obj/item/reagent_container/consumable/pill/fagenerite(usr.loc)
	new /obj/item/reagent_container/consumable/pill/fagenerite(usr.loc)
	sleep(0)
	new /obj/item/reagent_container/consumable/pill/glow(usr.loc)
	new /obj/item/reagent_container/consumable/pill/glow(usr.loc)
	new /obj/item/reagent_container/consumable/pill/glow(usr.loc)
	new /obj/item/reagent_container/consumable/pill/glow(usr.loc)
	sleep(0)
	new /obj/item/reagent_container/beaker/glass(usr.loc)
	new /obj/item/reagent_container/beaker/glass(usr.loc)
	new /obj/item/reagent_container/beaker/glass(usr.loc)
	new /obj/item/reagent_container/beaker/glass(usr.loc)
	sleep(0)
	new /obj/item/reagent_container/beaker/glass(usr.loc)
	new /obj/item/reagent_container/beaker/bottle/large/vodka(usr.loc)
	new /obj/item/reagent_container/beaker/bottle/large/vodka(usr.loc)
	new /obj/item/reagent_container/beaker/bottle/large/vodka(usr.loc)
	sleep(0)
	new /obj/item/reagent_container/beaker/bottle/stim(usr.loc)
	new /obj/item/reagent_container/beaker/bottle/stim(usr.loc)
	new /obj/item/reagent_container/beaker/bottle/stim2(usr.loc)
	new /obj/item/reagent_container/beaker/bottle/stim2(usr.loc)
	sleep(0)
	new /obj/item/reagent_container/beaker/bottle/tuborg(usr.loc)
	new /obj/item/reagent_container/beaker/bottle/tuborg(usr.loc)
	new /obj/item/reagent_container/beaker/bottle/beer(usr.loc)
	new /obj/item/reagent_container/beaker/bottle/beer(usr.loc)
	sleep(0)
	new /obj/item/reagent_container/consumable/sandwich(usr.loc)
	new /obj/item/reagent_container/consumable/sandwich(usr.loc)
	new /obj/item/reagent_container/consumable/sandwich(usr.loc)
	new /obj/item/reagent_container/consumable/sandwich(usr.loc)
	new /obj/item/reagent_container/consumable/sandwich(usr.loc)
	sleep(0)
	new /obj/item/reagent_container/consumable/chicken(usr.loc)
	new /obj/item/reagent_container/consumable/chicken/wing(usr.loc)
	new /obj/item/reagent_container/consumable/chicken/wing(usr.loc)
	sleep(0)
	usr.delitem()
	return

/obj/item/reefer_pack
	icon = 'grafon/device.dmi'
	market_price = 30
	icon_state = "package"
	name = "package"
	desc = "It looks a bit suspicious."
/obj/item/reefer_pack
/obj/item/reefer_pack/attack_self()
	usr << "\blue You deploy your package."
	new /obj/item/reagent_container/cig(usr.loc)
	new /obj/item/reagent_container/cig(usr.loc)
	new /obj/item/reagent_container/cig(usr.loc)
	sleep(0)
	new /obj/item/reagent_container/consumable/plant/bud(usr.loc)
	new /obj/item/reagent_container/consumable/plant/bud(usr.loc)
	new /obj/item/reagent_container/consumable/plant/bud(usr.loc)
	new /obj/item/reagent_container/consumable/plant/bud(usr.loc)
	new /obj/item/reagent_container/consumable/plant/bud(usr.loc)
	sleep(0)
	usr.delitem()
	return

/obj/item/science_pack
	icon = 'grafon/device.dmi'
	market_price = 2000
	desc = "It looks a bit suspicious."
	name = "research supplies"
	icon_state = "package_white"
/obj/item/science_pack
/obj/item/science_pack/attack_self()
	usr << "\blue You deploy your package."
	new /obj/item/cable(usr.loc)
	new /obj/item/caboutlet(usr.loc)
	new /obj/item/caboutlet(usr.loc)
	new /obj/item/bluecable(usr.loc)
	sleep(0)
	new /obj/item/amoebacore(usr.loc)
	new /obj/item/amoebacore(usr.loc)
	new /obj/item/reagent_container/syringe(usr.loc)
	new /obj/item/reagent_container/consumable/plant/bud(usr.loc)
	sleep(0)
	new /obj/item/gas/tank/fuel(usr.loc)
	new /obj/item/gas/tank/fuel(usr.loc)
	new /obj/item/gas/tank/fuel(usr.loc)
	new /obj/item/gas/tank/regenerite(usr.loc)
	sleep(0)
	new /obj/item/gas/loader(usr.loc)
	new /obj/item/gas/mask(usr.loc)
	new /obj/item/gas/tube(usr.loc)
	new /obj/item/gas/tube(usr.loc)
	new /obj/item/device/igniter(usr.loc)
	sleep(0)
	new /obj/item/electronics/synthstone(usr.loc)
	new /obj/item/electronics/targeting(src.loc)
	new /obj/item/electronics/plasma_gen(src.loc)
	new /obj/item/electronics/plasma_gen(src.loc)
	sleep(0)
	new /obj/item/device/signaler(usr.loc)
	new /obj/item/device/signaler(usr.loc)
	new /obj/item/device/signaler(usr.loc)
	new /obj/item/electronics/core/tele(usr.loc)
	sleep(0)
	usr.delitem()
	return

/obj/item/reagent_container/consumable/pill/mutagen
	name = "mutagen pill"
	desc = "A pill of potent mutagen."

/obj/item/reagent_container/consumable/pill/mutagen

/obj/item/reagent_container/consumable/pill/mutagen/New()

	src.add_chem("mutagen", "mutagen", 5, 0)
	..()

/obj/item/reagent_container/consumable/pill/asd
	name = "ASD pill"
	desc = "A pill of anti-mutagenic treatment."
/obj/item/reagent_container/consumable/pill/asd
/obj/item/reagent_container/consumable/pill/asd/New()
	src.add_chem("ASD", "ASD", 5, 0)
	..()
/obj/item/reagent_container/consumable/pill/asd0
	icon_state = "pill_darkred"
	name = "ASD-F0 pill"
	desc = "A pill of mechanical damage treatment. It is useless against open wounds, however."
/obj/item/reagent_container/consumable/pill/asd0
/obj/item/reagent_container/consumable/pill/asd0/New()
	src.add_chem("ASD-F0", "ASD-F0", 5, 0)
	..()
/obj/item/reagent_container/consumable/pill/antismoke
	name = "Nicotine addiction cure pill"
	desc = "A pill of dextroamitriptine, for nicotine addiction removal."
/obj/item/reagent_container/consumable/pill/antismoke
/obj/item/reagent_container/consumable/pill/antismoke/New()
	src.add_chem("dextroamitriptine", "dextroamitriptine", 2, 0)
	src.add_chem("glucose", "glucose", 2, 0)
	..()

