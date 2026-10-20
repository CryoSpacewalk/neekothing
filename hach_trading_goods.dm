/datum/tovar
	var/name = "bag of dongs"
	var/price = 0
	var/good
	var/faked
	var/amt = 1
	var/rarity = 20
	var/opy = 0

/datum/tovar/cancel
	name = "cancel"
	price = 0
	good = null
	rarity = 0

/datum/tovar/cancel

/datum/tovar/carbo
	name = "carboxylic acids bottle"
	price = 25
	good = /obj/item/reagent_container/beaker/bottle/carbox

/datum/tovar/carbo

/datum/tovar/cellulose
	name = "cellulose bottle"
	price = 10
	good = /obj/item/reagent_container/beaker/bottle/cellulose

/datum/tovar/cellulose

/datum/tovar/phenethylamine
	name = "30pts of pure phenethylamine"
	price = 65
	good = /obj/item/reagent_container/beaker/bottle/phenethylamine
	rarity = 33

/datum/tovar/phenethylamine

/datum/tovar/benzaldehyde
	name = "30pts of pure benzaldehyde"
	price = 60
	good = /obj/item/reagent_container/beaker/bottle/benzaldehyde
	rarity = 33

/datum/tovar/benzaldehyde

/datum/tovar/benzaldehyde70
	name = "70pts of pure benzaldehyde"
	price = 120
	good = /obj/item/reagent_container/beaker/bucket/benzaldehyde
	rarity = 66

/datum/tovar/benzaldehyde70

/datum/tovar/amalgam70
	name = "70pts of amalgam"
	price = 120
	good = /obj/item/reagent_container/beaker/bucket/amalgam
	rarity = 66

/datum/tovar/amalgam70

/datum/tovar/pseudoephedrine
	name = "pseudoephedrine bottle"
	price = 35
	good = /obj/item/reagent_container/beaker/bottle/pseudoephedrine
	rarity = 25

/datum/tovar/pseudoephedrine

/datum/tovar/pseudoephedrine70
	name = "pseudoephedrine canister"
	price = 70
	good = /obj/item/reagent_container/beaker/bucket/pseudoephedrine
	rarity = 50

/datum/tovar/pseudoephedrine70

/datum/tovar/ephedrine
	name = "ephedrine bottle"
	price = 50
	good = /obj/item/reagent_container/beaker/bottle/ephedrine
	faked = /obj/item/reagent_container/beaker/bottle/ephedrine/fake
	rarity = 25

/datum/tovar/ephedrine

/datum/tovar/ephedrine70
	name = "ephedrine canister"
	price = 100
	good = /obj/item/reagent_container/beaker/bucket/ephedrine
	rarity = 50

/datum/tovar/ephedrine70

/datum/tovar/worms
	name = "space toad food (10x highly-nutrious worms!)"
	price = 20
	good = /obj/item/reagent_container/consumable/worm
	amt = 10

/datum/tovar/worms

/datum/tovar/key
	name = "primary access key"
	price = 20
	good = /obj/item/key/maint
	rarity = 10

/datum/tovar/key

/datum/tovar/charge
	name = "100% authentic Soviet supply charge"
	price = 108
	good = /obj/item/supplycharge

/datum/tovar/charge

/datum/tovar/twotwoeight
	name = "suit with original 228 print"
	price = 10
	good = /obj/item/clothes/standart/ak47

/datum/tovar/twotwoeight

/datum/tovar/hawaii
	name = "authentic hawaiian shirt"
	price = 10
	good = /obj/item/clothes/hawai

/datum/tovar/hawaii

/datum/tovar/bong
	name = "glass bong"
	price = 15
	good = /obj/item/bong

/datum/tovar/bong

/datum/tovar/guide
	name = "Young terrorist's handbook (now uncensored!)"
	price = 25
	rarity = 85
	good = /obj/item/readable/cockbook

/datum/tovar/guide

/datum/tovar/blueprint
	name = "Engineering assembly blueprint"
	price = 888
	rarity = 66
	good = /obj/item/readable/blueprint

/datum/tovar/blueprint

/datum/tovar/designer
	name = "Wonderful world of designer drugs"
	price = 50
	rarity = 85
	good = /obj/item/readable/designer

/datum/tovar/designer

/datum/tovar/cutters
	name = "Hydraulic cutters (keep it from children and assistants)"
	price = 145
	rarity = 50
	good = /obj/item/tool/hydraulic_cutters

/datum/tovar/cutters

/datum/tovar/chainsaw
	name = "Chainsaw (keep it from children and assistants)"
	price = 125
	rarity = 50
	good = /obj/item/tool/saw

/datum/tovar/chainsaw

/datum/tovar/cross
	name = "Petrine Cross (perfectly good for banishing spectres!)"
	price = 120
	good = /obj/item/tool/cross

/datum/tovar/cross

/datum/tovar/party
	name = "Party package (all you need for either a funky party or a gloomy rave packed in the single box!)"
	price = 2100
	good = /obj/item/party
	rarity = 60

/datum/tovar/party

/datum/tovar/grimore
	name = "A complete copy of Didonomicon book (probably useless if you're not stalinistic freak)"
	price = 500
	good = /obj/item/grimore
	rarity = 40

/datum/tovar/grimore

/datum/tovar/rock
	name = "An antique sigiled rock (INFERNAL STALINISM ALERT)"
	price = 1500
	good = /obj/item/readable/cult
	rarity = 90

/datum/tovar/rock

/datum/tovar/tracer
	name = "Tantric sigilum tracer"
	price = 200
	good = /obj/item/tool/tracer

/datum/tovar/tracer

/datum/tovar/opal
	name = "laboratory-level quality synthetic jewel"
	price = 115
	good = /obj/item/electronics/synthstone

/datum/tovar/opal

/datum/tovar/amoeba_food
	name = "amoeba food boxes (5x)"
	price = 60
	amt = 5
	good = /obj/item/reagent_container/consumable/amoeba

/datum/tovar/amoeba_food

/datum/tovar/amoeba_box
	name = "a common amoeba box"
	price = 40
	good = /obj/item/amoebabox

/datum/tovar/amoeba_box

/datum/tovar/amoeba_acidy
	name = "a corrosive amoeba box (not for children usage)"
	price = 250
	rarity = 50
	good = /obj/item/amoebabox/acidy

/datum/tovar/amoeba_acidy

/datum/tovar/amoeba_core
	name = "a rare amoeba core"
	price = 200
	rarity = 50
	good = /obj/item/amoebacore/regen

/datum/tovar/amoeba_core

/datum/tovar/science_pack
	name = "a package full of stuff useful for researcher"
	price = 2400
	rarity = 66
	good = /obj/item/science_pack

/datum/tovar/science_pack

/datum/tovar/abyss
	name = "Abyssal electronics core"
	price = 800
	rarity = 70
	good = /obj/item/electronics/core/abyss
	name = "Abyssal electronics core"
	price = 300
	rarity = 30
	good = /obj/item/electronics/core/abyss
/datum/tovar/abyss
/datum/tovar/fert5
	name = "5 units of combifertilizer"
	price = 15
	good = /obj/item/fertilizer
	amt = 5
/datum/tovar/fert5
/datum/tovar/fert10
	name = "10 units of combifertilizer"
	price = 25
	good = /obj/item/fertilizer
	amt = 10

/datum/tovar/fert10

/datum/tovar/fert50
	name = "50 units of combifertilizer"
	price = 120
	good = /obj/item/fertilizer
	amt = 50

/datum/tovar/fert50

/datum/tovar/dust5
	name = "5 units of universal pesticide"
	price = 20
	good = /obj/item/bugdust
	amt = 5

/datum/tovar/dust5

/datum/tovar/dust10
	name = "10 units of universal pesticide"
	price = 35
	good = /obj/item/bugdust
	amt = 10

/datum/tovar/dust10

/datum/tovar/dust50
	name = "50 units of universal pesticide"
	price = 170
	good = /obj/item/bugdust
	amt = 50

/datum/tovar/dust50

/datum/tovar/seed_weed1
	name = "cannabis sativa seed"
	price = 30
	good = /obj/item/reagent_container/consumable/seed/weed
	amt = 1

/datum/tovar/seed_weed1

/datum/tovar/seed_weed5
	name = "5x cannabis sativa seeds"
	price = 140
	good = /obj/item/reagent_container/consumable/seed/weed
	amt = 5

/datum/tovar/seed_weed5

/datum/tovar/seed_salvia1
	name = "salvia divinorum seed"
	price = 70
	good = /obj/item/reagent_container/consumable/seed/salvia
	amt = 1
	rarity = 50

/datum/tovar/seed_salvia1

/datum/tovar/seed_salvia5
	name = "5x salvia divinorum seeds"
	price = 350
	good = /obj/item/reagent_container/consumable/seed/salvia
	amt = 5
	rarity = 70

/datum/tovar/seed_salvia5

/datum/tovar/seed_woodrose
	name = "space woodrose seed (for growing purpouses)"
	price = 50
	good = /obj/item/reagent_container/consumable/seed/woodrose
	amt = 1

/datum/tovar/seed_woodrose

/datum/tovar/seed_blastcumber
	name = "blastcumber seed"
	price = 40
	good = /obj/item/reagent_container/consumable/seed/blastcumber
	amt = 1

/datum/tovar/seed_blastcumber

/datum/tovar/seed_lofofora
	name = "space lofofora seed"
	price = 40
	good = /obj/item/reagent_container/consumable/seed/lofofora
	rarity = 66
	amt = 1

/datum/tovar/seed_lofofora

/datum/tovar/lofofora
	name = "space lofofora (leaves seed if eaten or produced via plant extractor)"
	price = 55
	good = /obj/item/reagent_container/consumable/plant/lofofora
	rarity = 66
	amt = 1

/datum/tovar/lofofora

/datum/tovar/psychotria
	name = "psychotria oecumenica stalk (for growing purpouses, contains DMT)"
	price = 75
	good = /obj/item/reagent_container/consumable/seed/dmt
	rarity = 40
	amt = 1

/datum/tovar/psychotria

/datum/tovar/ayahuasca
	name = "ayahuasca liana (for growing purpouses, contains harmaline)"
	price = 40
	good = /obj/item/reagent_container/consumable/seed/maoi
	rarity = 40
	amt = 1

/datum/tovar/ayahuasca

/datum/tovar/syrup3
	name = "USSR-4 standard cough syrup #2 (3x)"
	price = 38
	good = /obj/item/reagent_container/beaker/bottle/syrup
	amt = 3

/datum/tovar/syrup3

/datum/tovar/syrup5
	name = "USSR-4 standard cough syrup #2 (5x)"
	price = 50
	good = /obj/item/reagent_container/beaker/bottle/syrup
	amt = 5

/datum/tovar/syrup5

/datum/tovar/syrup20
	name = "USSR-4 standard cough syrup #2 (20x)"
	price = 180
	good = /obj/item/reagent_container/beaker/bottle/syrup
	amt = 20

/datum/tovar/syrup20

/datum/tovar/syrup50
	name = "USSR-4 standard cough syrup #2 (50x)"
	price = 400
	good = /obj/item/reagent_container/beaker/bottle/syrup
	amt = 50
	rarity = 66

/datum/tovar/syrup50

/datum/tovar/dex5
	name = "DXM nickelbag (5pts)"
	price = 20
	good = /obj/item/reagent_container/beaker/tiny/DXM/small

/datum/tovar/dex5

/datum/tovar/dex20
	name = "DXM nickelbags (20pts)"
	price = 64
	good = /obj/item/reagent_container/beaker/tiny/DXM
	amt = 2

/datum/tovar/dex20

/datum/tovar/dex50
	name = "DXM nickelbags (50pts)"
	price = 120
	good = /obj/item/reagent_container/beaker/tiny/DXM
	amt = 5

/datum/tovar/dex50
/datum/tovar/dex_bottle1
	name = "30pts of pure DXM"
	price = 80
	good = /obj/item/reagent_container/beaker/bottle/dex
/datum/tovar/dex_bottle1
/datum/tovar/dex_bottle3
	name = "90pts of pure DXM"
	price = 220
	good = /obj/item/reagent_container/beaker/bottle/dex
	amt = 3
	rarity = 50
/datum/tovar/dex_bottle3
/datum/tovar/dex_bottle5
	name = "150pts of pure DXM"
	price = 340
	good = /obj/item/reagent_container/beaker/bottle/dex
	amt = 5
	rarity = 70
/datum/tovar/dex_bottle5
/datum/tovar/calypso
	name = "Calypsol injector"
	price = 35
	good = /obj/item/reagent_container/syringe/injector/calypsol
/datum/tovar/calypso
/datum/tovar/calypso4
	name = "Calypsol injectors (4x)"
	price = 110
	good = /obj/item/reagent_container/syringe/injector/calypsol
	amt = 4
	rarity = 65
/datum/tovar/calypso4
/datum/tovar/calypso20
	name = "Calypsol injectors (20x)"
	price = 520
	good = /obj/item/reagent_container/syringe/injector/calypsol
	amt = 20
	rarity = 75
/datum/tovar/calypso20
/datum/tovar/ket5
	name = "5pts of ketamine"
	price = 35
	good = /obj/item/reagent_container/beaker/tiny/k/half
	rarity = 50
/datum/tovar/ket5
/datum/tovar/ket10
	name = "10pts of ketamine"
	price = 60
	good = /obj/item/reagent_container/beaker/tiny/k
	rarity = 60
/datum/tovar/ket10
/datum/tovar/ket20
	name = "20pts of ketamine"
	price = 110
	good = /obj/item/reagent_container/beaker/bottle/k
	rarity = 70
/datum/tovar/ket20
/datum/tovar/mxe5
	name = "5pts of MXE"
	price = 40
	good = /obj/item/reagent_container/beaker/tiny/mxe/half
/datum/tovar/mxe5
/datum/tovar/mxe10
	name = "10pts of MXE"
	price = 70
	good = /obj/item/reagent_container/beaker/tiny/mxe
/datum/tovar/mxe10
/datum/tovar/salvia1
	name = "salvia divinorum leaves (1 dose)"
	price = 10
	good = /obj/item/reagent_container/consumable/plant/salvia
	rarity = 60
/datum/tovar/salvia1
/datum/tovar/salvia3
	name = "salvia divinorum leaves (3 doses)"
	price = 27
	good = /obj/item/reagent_container/consumable/plant/salvia
	amt = 3
	rarity = 80
/datum/tovar/salvia3
/datum/tovar/salvia5
	name = "salvia divinorum leaves (5 doses)"
	price = 40
	good = /obj/item/reagent_container/consumable/plant/salvia
	amt = 5
	rarity = 80
/datum/tovar/salvia5
/datum/tovar/salvia_extract2_1
	name = "salvia divinorum 2x extract (1 dose)"
	price = 15
	good = /obj/item/reagent_container/consumable/spice/salvia
	rarity = 80
/datum/tovar/salvia_extract2_1
/datum/tovar/salvia_extract2_3
	name = "salvia divinorum 2x extract (3 doses)"
	price = 37
	good = /obj/item/reagent_container/consumable/spice/salvia
	amt = 3
	rarity = 80
/datum/tovar/salvia_extract2_3
/datum/tovar/salvia_extract2_5
	name = "salvia divinorum 2x extract (5 doses)"
	price = 57
	good = /obj/item/reagent_container/consumable/spice/salvia
	amt = 5
	rarity = 80
/datum/tovar/salvia_extract2_5
/datum/tovar/salvia_extract10
	name = "salvia divinorum 10x extract (1 dose)"
	price = 80
	good = /obj/item/reagent_container/consumable/spice/salvia_strong
	rarity = 90
/datum/tovar/salvia_extract10
/datum/tovar/indopan
	name = "DiPT-indopan (USSR-4 Psychiatry Departament-approved, high quality) blister"
	price = 50
	good = /obj/item/blister/indopan
/datum/tovar/indopan
/datum/tovar/indopan5
	name = "DiPT-indopan (USSR-4 Psychiatry Departament-approved, high quality) blisters (5x)"
	price = 210
	good = /obj/item/blister/indopan
	amt = 5
/datum/tovar/indopan5
/datum/tovar/indopan10
	name = "DiPT-indopan (USSR-4 Psychiatry Departament-approved, high quality) blisters (10x)"
	price = 485
	good = /obj/item/blister/indopan
	amt = 10
/datum/tovar/indopan10
/datum/tovar/cb1
	name = "Nexus ampule (1x)"
	price = 30
	good = /obj/item/reagent_container/consumable/pill/ampule/nexus
/datum/tovar/cb1
/datum/tovar/cb5
	name = "Nexus ampule (5x)"
	price = 120
	good = /obj/item/reagent_container/consumable/pill/ampule/nexus
	amt = 5
/datum/tovar/cb5
/datum/tovar/cb10
	name = "Nexus ampule (10x)"
	price = 200
	good = /obj/item/reagent_container/consumable/pill/ampule/nexus
	amt = 10
/datum/tovar/cb10
/datum/tovar/cb100
	name = "Nexus ampule (100x)"
	price = 1500
	good = /obj/item/reagent_container/consumable/pill/ampule/nexus
	amt = 100
	rarity = 80
/datum/tovar/cb100
/datum/tovar/cb_5pts
	name = "5pts of 2C-B"
	price = 190
	good = /obj/item/reagent_container/beaker/tiny/nexus/half
	rarity = 80
/datum/tovar/cb_5pts
/datum/tovar/cb_10pts
	name = "10pts of 2C-B"
	price = 370
	good = /obj/item/reagent_container/beaker/tiny/nexus
/datum/tovar/cb_10pts
/datum/tovar/lsa
	name = "LSA solution (3pts)"
	price = 160
	good = /obj/item/reagent_container/beaker/tiny/lsa
/datum/tovar/lsa
/datum/tovar/lsa_great
	name = "LSA solution (6pts)"
	price = 290
	good = /obj/item/reagent_container/beaker/tiny/lsa/great
/datum/tovar/lsa_great
/datum/tovar/lsd1
	name = "LSD blotter (1x)"
	price = 50
	good = /obj/item/reagent_container/consumable/stamp/blotter
	faked = /obj/item/reagent_container/consumable/stamp/blotter_nbome
/datum/tovar/lsd1
/datum/tovar/lsd5
	name = "LSD blotter (5x)"
	price = 200
	good = /obj/item/reagent_container/consumable/stamp/blotter
	faked = /obj/item/reagent_container/consumable/stamp/blotter_nbome
	amt = 5
/datum/tovar/lsd5
/datum/tovar/lsd10
	name = "LSD blotter (10x)"
	price = 352
	good = /obj/item/reagent_container/consumable/stamp/blotter
	faked = /obj/item/reagent_container/consumable/stamp/blotter_nbome
	amt = 10
	rarity = 66
/datum/tovar/lsd10
/datum/tovar/lsd100
	name = "LSD blotter (100x)"
	price = 2550
	good = /obj/item/reagent_container/consumable/stamp/blotter
	faked = /obj/item/reagent_container/consumable/stamp/blotter_nbome
	amt = 100
	rarity = 80
/datum/tovar/lsd100
/datum/tovar/lsd_liquid
	name = "3pts of LSD-25 solution"
	price = 350
	good = /obj/item/reagent_container/beaker/bottle/LSD
	rarity = 70
/datum/tovar/lsd_liquid
/datum/tovar/dob1
	name = "DOB blotter (1x)"
	price = 35
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOB
/datum/tovar/dob1
/datum/tovar/dob5
	name = "DOB blotters (5x)"
	price = 140
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOB
	amt = 5
/datum/tovar/dob5
/datum/tovar/dob10
	name = "DOB blotters (10x)"
	price = 235
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOB
	amt = 10
	rarity = 66
/datum/tovar/dob10
/datum/tovar/dob100
	name = "DOB blotters (100x)"
	price = 1650
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOB
	amt = 100
	rarity = 80
/datum/tovar/dob100
/datum/tovar/doi1
	name = "DOI blotter (1x)"
	price = 42
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOI
/datum/tovar/doi1
/datum/tovar/doi5
	name = "DOI blotters (5x)"
	price = 170
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOI
	amt = 5
/datum/tovar/doi5
/datum/tovar/doi10
	name = "DOB blotters (10x)"
	price = 287
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOI
	amt = 10
	rarity = 66
/datum/tovar/doi10
/datum/tovar/doi100
	name = "DOB blotters (100x)"
	price = 2250
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOI
	amt = 100
	rarity = 80
/datum/tovar/doi100
/datum/tovar/doc1
	name = "DOC blotter (1x)"
	price = 42
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOC
/datum/tovar/doc1
/datum/tovar/doc5
	name = "DOC blotters (5x)"
	price = 170
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOC
	amt = 5
/datum/tovar/doc5
/datum/tovar/doc10
	name = "DOB blotters (10x)"
	price = 287
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOC
	amt = 10
	rarity = 66
/datum/tovar/doc10
/datum/tovar/doc100
	name = "DOB blotters (100x)"
	price = 2250
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOC
	amt = 100
	rarity = 80
/datum/tovar/doc100
/datum/tovar/dom1
	name = "DOM blotter (1x)"
	price = 42
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOM
	rarity = 55
/datum/tovar/dom1
/datum/tovar/dom5
	name = "DOM blotters (5x)"
	price = 170
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOM
	amt = 5
	rarity = 65
/datum/tovar/dom5
/datum/tovar/dom10
	name = "DOM blotters (10x)"
	price = 287
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOM
	amt = 10
	rarity = 85
/datum/tovar/dom10
/datum/tovar/dom100
	name = "DOM blotters (100x)"
	price = 2250
	good = /obj/item/reagent_container/consumable/stamp/blotter_DOM
	amt = 100
	rarity = 90
/datum/tovar/dom100
/datum/tovar/dob_pts
	name = "840mpts of DOB powder"
	price = 235
	good = /obj/item/reagent_container/beaker/tiny/DOB
	rarity = 70
/datum/tovar/dob_pts
/datum/tovar/doi_pts
	name = "1200mpts of DOI powder"
	price = 268
	good = /obj/item/reagent_container/beaker/tiny/DOI
	rarity = 80
/datum/tovar/doi_pts
/datum/tovar/doc_pts
	name = "1200mpts of DOC powder"
	price = 268
	good = /obj/item/reagent_container/beaker/tiny/DOC
	rarity = 80
/datum/tovar/doc_pts
/datum/tovar/dom_pts
	name = "1200mpts of DOM powder"
	price = 268
	good = /obj/item/reagent_container/beaker/tiny/DOM
	rarity = 90
/datum/tovar/dom_pts
/datum/tovar/nbome1
	name = "25i-NBOMe blotter (1x)"
	price = 15
	good = /obj/item/reagent_container/consumable/stamp/blotter_nbome
/datum/tovar/nbome1
/datum/tovar/nbome5
	name = "25i-NBOMe blotter (5x)"
	price = 80
	good = /obj/item/reagent_container/consumable/stamp/blotter_nbome
	amt = 5
/datum/tovar/nbome5
/datum/tovar/nbome10
	name = "25i-NBOMe blotter (10x)"
	price = 140
	good = /obj/item/reagent_container/consumable/stamp/blotter_nbome
	amt = 10
/datum/tovar/nbome10
/datum/tovar/nbome100
	name = "25i-NBOMe blotter (100x)"
	price = 750
	good = /obj/item/reagent_container/consumable/stamp/blotter_nbome
	amt = 100
	rarity = 70
/datum/tovar/nbome100
/datum/tovar/nbome1000
	name = "25i-NBOMe blotter (1000x)"
	price = 3250
	good = /obj/item/reagent_container/consumable/stamp/blotter_nbome
	amt = 1000
	rarity = 80
/datum/tovar/nbome1000
/datum/tovar/nbome_crystal
	name = "10pts of pure 25i-NBOMe"
	price = 145
	good = /obj/item/reagent_container/beaker/tiny/nbome
/datum/tovar/nbome_crystal
/datum/tovar/dmt_smoke1
	name = "OBELISK(tm) premium smokeable DMT (1x)"
	price = 80
	good = /obj/item/reagent_container/consumable/spice/DMT
	amt = 1
	rarity = 85
/datum/tovar/dmt_smoke1
/datum/tovar/dmt_smoke5
	name = "OBELISK(tm) premium smokeable DMT (5x)"
	price = 320
	good = /obj/item/reagent_container/consumable/spice/DMT
	amt = 5
	rarity = 85
/datum/tovar/dmt_smoke5
/datum/tovar/dmt_smoke10
	name = "OBELISK(tm) premium smokeable DMT (10x)"
	price = 560
	good = /obj/item/reagent_container/consumable/spice/DMT
	rarity = 80
	amt = 10
	rarity = 85
/datum/tovar/dmt_smoke10
/datum/tovar/dmt_smoke100
	name = "OBELISK(tm) premium smokeable DMT (100x)"
	price = 4000
	good = /obj/item/reagent_container/consumable/spice/DMT
	amt = 100
	rarity = 90
/datum/tovar/dmt_smoke100
/datum/tovar/dmt_5pts
	name = "5pts of pure DMT"
	price = 620
	good = /obj/item/reagent_container/beaker/tiny/dmt/half
	faked = /obj/item/reagent_container/beaker/tiny/dmt/half/faked
	rarity = 80
/datum/tovar/dmt_5pts
/datum/tovar/dmt_10pts
	name = "10pts of pure DMT"
	price = 1100
	good = /obj/item/reagent_container/beaker/tiny/dmt
	faked = /obj/item/reagent_container/beaker/tiny/dmt/faked
	rarity = 90
/datum/tovar/dmt_10pts
/datum/tovar/shrooms
	name = "5x potent psilocybe mushrooms"
	price = 35
	good = /obj/item/reagent_container/consumable/plant/psilocybe
	amt = 5
/datum/tovar/shrooms
/datum/tovar/shrooms_great
	name = "10x potent psilocybe mushrooms"
	price = 65
	good = /obj/item/reagent_container/consumable/plant/psilocybe
	amt = 10
/datum/tovar/shrooms_great
/datum/tovar/psilocybin
	name = "50pts of pure psilocybin"
	price = 65
	good = /obj/item/reagent_container/beaker/psilo
	rarity = 60
/datum/tovar/psilocybin
/datum/tovar/psilo_ampule
	name = "psilocybin ampule"
	price = 33
	good = /obj/item/reagent_container/consumable/pill/ampule/psilo
	rarity = 60
/datum/tovar/psilo_ampule
/datum/tovar/psilo_ampule5
	name = "psilocybin ampules (5x)"
	price = 100
	good = /obj/item/reagent_container/consumable/pill/ampule/psilo
	amt = 5
	rarity = 60
/datum/tovar/psilo_ampule5
/datum/tovar/homet5
	name = "5x ampules of 4-HO-MET"
	price = 100
	good = /obj/item/reagent_container/consumable/pill/ampule/homet
	amt = 5
/datum/tovar/homet5
/datum/tovar/homet10
	name = "10x ampules of 4-HO-MET"
	price = 180
	good = /obj/item/reagent_container/consumable/pill/ampule/homet
	amt = 10
/datum/tovar/homet10
/datum/tovar/acodmt5
	name = "5x ampules of 4-AcO-DMT"
	price = 110
	good = /obj/item/reagent_container/consumable/pill/ampule/acodmt
	amt = 5
/datum/tovar/acodmt5
/datum/tovar/acodmt10
	name = "10x ampules of 4-AcO-DMT"
	price = 198
	good = /obj/item/reagent_container/consumable/pill/ampule/acodmt
	amt = 10
/datum/tovar/acodmt10
/datum/tovar/fivemeo
	name = "10pts of pure 5-MeO-DMT"
	price = 380
	good = /obj/item/reagent_container/beaker/tiny/fivemeo
/datum/tovar/fivemeo
/datum/tovar/dipt
	name = "10pts of pure DiPT"
	price = 120
	good = /obj/item/reagent_container/beaker/tiny/dipt
/datum/tovar/dipt
/datum/tovar/homet
	name = "10pts of pure 4-HO-MET"
	price = 115
	good = /obj/item/reagent_container/beaker/tiny/homet
/datum/tovar/homet
/datum/tovar/fivemeo_ampule
	name = "5-MeO-DMT ampule"
	price = 42
	good = /obj/item/reagent_container/consumable/pill/ampule/fivemeo
	rarity = 60
/datum/tovar/fivemeo_ampule
/datum/tovar/fivemeo_ampule5
	name = "5-MeO-DMT ampules (5x)"
	price = 190
	good = /obj/item/reagent_container/consumable/pill/ampule/fivemeo
	amt = 5
	rarity = 60
/datum/tovar/fivemeo_ampule5
/datum/tovar/dipt_ampule
	name = "DiPT ampule"
	price = 25
	good = /obj/item/reagent_container/consumable/pill/ampule/dipt
/datum/tovar/dipt_ampule
/datum/tovar/dipt_ampule5
	name = "DiPT ampules (5x)"
	price = 100
	good = /obj/item/reagent_container/consumable/pill/ampule/dipt
	amt = 5
	rarity = 60
/datum/tovar/dipt_ampule5
/datum/tovar/fivedipt_ampule
	name = "5-MeO-DiPT ampule"
	price = 40
	good = /obj/item/reagent_container/consumable/pill/ampule/fivedipt
/datum/tovar/fivedipt_ampule
/datum/tovar/fivedipt_ampule5
	name = "5-MeO-DiPT ampules (5x)"
	price = 160
	good = /obj/item/reagent_container/consumable/pill/ampule/fivedipt
	amt = 5
	rarity = 50
/datum/tovar/fivedipt_ampule5
/datum/tovar/vodka2
	name = "2 fine-distilled vodka bottles"
	price = 42
	good = /obj/item/reagent_container/beaker/bottle/large/vodka
	amt = 2
/datum/tovar/vodka2
/datum/tovar/vodka10
	name = "10 fine-distilled vodka bottles"
	price = 378
	good = /obj/item/reagent_container/beaker/bottle/large/vodka
	amt = 10
	rarity = 40
/datum/tovar/vodka10
/datum/tovar/beer5
	name = "5 cans of space tuborg premium beer"
	price = 50
	good = /obj/item/reagent_container/beaker/bottle/tuborg
	amt = 5
/datum/tovar/beer5
/datum/tovar/beer10
	name = "10 cans of space tuborg premium beer"
	price = 80
	good = /obj/item/reagent_container/beaker/bottle/tuborg
	amt = 10
/datum/tovar/beer10
/datum/tovar/beer50
	name = "50 cans of space tuborg premium beer"
	price = 350
	good = /obj/item/reagent_container/beaker/bottle/tuborg
	amt = 50
	rarity = 50
/datum/tovar/beer50
/datum/tovar/beer_sovok
	name = "10 cans of authentic jigulevskoe beer"
	price = 65
	good = /obj/item/reagent_container/beaker/bottle/tuborg
	amt = 10
	rarity = 80
/datum/tovar/beer_sovok
/datum/tovar/semerki
	name = "2 bottles of USSR-4 exclusive 'Tri semerki' wine (burns perfectly as well)"
	price = 90
	good = /obj/item/reagent_container/beaker/bottle/large/tri_semerki
	amt = 2
	rarity = 50
/datum/tovar/semerki
/datum/tovar/ethanol
	name = "pure ethanol bottle"
	price = 40
	good = /obj/item/reagent_container/beaker/bottle/ethanol
/datum/tovar/ethanol
/datum/tovar/ethanol5
	name = "5 bottles of pure medical ethanol"
	price = 135
	good = /obj/item/reagent_container/beaker/bottle/ethanol
	amt = 5
/datum/tovar/ethanol5
/datum/tovar/stimdrink2
	name = "2 energy drink cans (caution: isn't suitable for pseudoephedrine-allergic persons)"
	price = 30
	good = /obj/item/reagent_container/beaker/bottle/stim
	amt = 2
/datum/tovar/stimdrink2
/datum/tovar/stimdrink10
	name = "10 energy drink cans (caution: isn't suitable for pseudoephedrine-allergic persons)"
	price = 110
	good = /obj/item/reagent_container/beaker/bottle/stim
	amt = 10
/datum/tovar/stimdrink10
/datum/tovar/stimdrink_plus
	name = "2 soulstorm+ drink cans (caution: isn't suitable for MDPV-allergic persons)"
	price = 60
	good = /obj/item/reagent_container/beaker/bottle/stim2
	amt = 2
	rarity = 35
/datum/tovar/stimdrink_plus
/datum/tovar/coffee
	name = "2 thermoses of black coffee, pre-sugared (warning: too many caffeine may result in jitters)"
	price = 40
	good = /obj/item/reagent_container/beaker/bottle/large/coffee
	amt = 2
/datum/tovar/coffee
/datum/tovar/absinth
	name = "10 glasses of green fairy juice"
	price = 228
	good = /obj/item/reagent_container/beaker/glass/absenth
	amt = 10
/datum/tovar/absinth
/datum/tovar/barbital1
	name = "barbital blister"
	price = 12
	good = /obj/item/blister/sedative
/datum/tovar/barbital1
/datum/tovar/barbital10
	name = "barbital blisters (10x)"
	price = 105
	good = /obj/item/blister/sedative
	amt = 10
/datum/tovar/barbital10
/datum/tovar/barbital100
	name = "barbital blisters party (100x)"
	price = 525
	good = /obj/item/blister/sedative
	rarity = 80
	amt = 100
/datum/tovar/barbital100
/datum/tovar/trankbottle
	name = "emergency tranquilizers mixture"
	price = 30
	good = /obj/item/reagent_container/beaker/bottle/trank
	rarity = 50
/datum/tovar/trankbottle
/datum/tovar/klono
	name = "clonazepam blister (1x)"
	price = 18
	good = /obj/item/blister/clonazepam
	rarity = 50
/datum/tovar/klono
/datum/tovar/klono10
	name = "clonazepam blister (10x)"
	price = 172
	good = /obj/item/blister/clonazepam
	rarity = 60
/datum/tovar/klono10
/datum/tovar/klono20
	name = "clonazepam blister (20x)"
	price = 126
	good = /obj/item/blister/clonazepam
	rarity = 70
/datum/tovar/klono20
/datum/tovar/cosmo
	name = "cosmozepam blister (1x)"
	price = 30
	good = /obj/item/blister/cosmozepam
	rarity = 80
	amt = 1
/datum/tovar/cosmo
/datum/tovar/cosmo10
	name = "cosmozepam blister (10x)"
	price = 290
	good = /obj/item/blister/cosmozepam
	rarity = 80
	amt = 10
/datum/tovar/cosmo10
/datum/tovar/poppy1
	name = "opium poppy chest"
	price = 15
	good = /obj/item/reagent_container/consumable/plant/poppy
	opy = 1
/datum/tovar/poppy1
/datum/tovar/poppy
	name = "5x opium poppy chests"
	price = 50
	good = /obj/item/reagent_container/consumable/plant/poppy
	amt = 5
	opy = 1
/datum/tovar/poppy
/datum/tovar/poppy_great
	name = "10x opium poppy chests"
	price = 90
	good = /obj/item/reagent_container/consumable/plant/poppy
	amt = 10
	opy = 1
/datum/tovar/poppy_great
/datum/tovar/blister1
	name = "ibuprofen+ blister"
	price = 15
	good = /obj/item/blister/ibuprofen
	opy = 1
/datum/tovar/blister1
/datum/tovar/blister10
	name = "ibuprofen+ blisters (10x)"
	price = 135
	good = /obj/item/blister/ibuprofen
	amt = 10
	opy = 1
/datum/tovar/blister10
/datum/tovar/blister100
	name = "ibuprofen+ blisters party (100x)"
	price = 750
	good = /obj/item/blister/ibuprofen
	amt = 100
	rarity = 80
	opy = 1
/datum/tovar/blister100
/datum/tovar/pheno
	name = "phenazepam blisters (3x)"
	price = 27
	good = /obj/item/blister/phenazepam
	amt = 3
/datum/tovar/pheno
/datum/tovar/pheno10
	name = "phenazepam blisters (10x)"
	price = 77
	good = /obj/item/blister/phenazepam
	amt = 10
/datum/tovar/pheno10
/datum/tovar/rohypnol
	name = "2pts of flunitrazepam"
	price = 42
	good = /obj/item/reagent_container/beaker/tiny/rohypnol/two
/datum/tovar/rohypnol
/datum/tovar/rohypnol10
	name = "10pts of flunitrazepam"
	price = 200
	good = /obj/item/reagent_container/beaker/tiny/rohypnol
/datum/tovar/rohypnol10
/datum/tovar/tram3
	name = "Tramal (tramadol) one-time injectors (3x)"
	price = 31
	good = /obj/item/reagent_container/syringe/injector/tramal
	amt = 3
	opy = 1
/datum/tovar/tram3
/datum/tovar/tram5
	name = "Tramal (tramadol) one-time injectors (5x)"
	price = 47
	good = /obj/item/reagent_container/syringe/injector/tramal
	rarity = 50
	amt = 5
	opy = 1
/datum/tovar/tram5
/datum/tovar/tram10
	name = "Tramal (tramadol) one-time injectors (10x)"
	price = 90
	good = /obj/item/reagent_container/syringe/injector/tramal
	rarity = 50
	amt = 10
	opy = 1
/datum/tovar/tram10
/datum/tovar/tram20
	name = "Tramal (tramadol) one-time injectors (20x)"
	price = 150
	good = /obj/item/reagent_container/syringe/injector/tramal
	rarity = 75
	amt = 20
	opy = 1
/datum/tovar/tram20
/datum/tovar/buprik_great
	name = "2400mpts of buprenorphine"
	price = 168
	good = /obj/item/reagent_container/beaker/tiny/buprik
	rarity = 66
	opy = 1
/datum/tovar/buprik_great
/datum/tovar/buprik
	name = "1200mpts of buprenorphine"
	price = 96
	good = /obj/item/reagent_container/beaker/tiny/buprik/half
	rarity = 50
	opy = 1
/datum/tovar/buprik
/datum/tovar/buprik_small
	name = "400mpts of buprenorphine"
	price = 36
	good = /obj/item/reagent_container/beaker/tiny/buprik/small
	opy = 1
/datum/tovar/buprik_small
/datum/tovar/heroin_great
	name = "2400mpts of high-quality heroin (#3)"
	price = 180
	good = /obj/item/reagent_container/beaker/tiny/heroin
	opy = 1
/datum/tovar/heroin_great
/datum/tovar/heroin
	name = "1200mpts of high-quality heroin (#3)"
	price = 108
	good = /obj/item/reagent_container/beaker/tiny/heroin/half
	rarity = 50
	opy = 1
/datum/tovar/heroin
/datum/tovar/heroin_small
	name = "400mpts of high-quality heroin (#3)"
	price = 40
	opy = 1
	good = /obj/item/reagent_container/beaker/tiny/heroin/small
/datum/tovar/heroin_small
/datum/tovar/fentanyl_great
	name = "120mpts of pure fentanyl"
	price = 204
	good = /obj/item/reagent_container/beaker/tiny/fentanyl
	opy = 1
/datum/tovar/fentanyl_great
/datum/tovar/fentanyl
	name = "60mpts of pure fentanyl"
	price = 126
	good = /obj/item/reagent_container/beaker/tiny/fentanyl/half
	opy = 1
/datum/tovar/fentanyl
/datum/tovar/fentanyl_small
	name = "20mpts of pure fentanyl"
	price = 50
	good = /obj/item/reagent_container/beaker/tiny/fentanyl/small
	opy = 1
/datum/tovar/fentanyl_small
/datum/tovar/methadone_great
	name = "2400mpts of methadone"
	price = 200
	good = /obj/item/reagent_container/beaker/tiny/methadone
	rarity = 60
	opy = 1
/datum/tovar/methadone_great
/datum/tovar/methadone
	name = "1200mpts of methadone"
	price = 112
	good = /obj/item/reagent_container/beaker/tiny/methadone/half
	opy = 1
/datum/tovar/methadone
/datum/tovar/methadone_small
	name = "400mpts of methadone"
	price = 42
	good = /obj/item/reagent_container/beaker/tiny/methadone/half
	opy = 1
/datum/tovar/methadone_small
/datum/tovar/methadone_pill
	name = "4 pills of methadone"
	price = 96
	amt = 4
	good = /obj/item/reagent_container/consumable/pill/methadone
	opy = 1
/datum/tovar/methadone_pill
/datum/tovar/methadone_blister
	name = "Methadone blister"
	price = 103
	good = /obj/item/blister/methadone
	rarity = 40
	opy = 1
/datum/tovar/methadone_blister
/datum/tovar/methadone_blister20
	name = "Methadone blisters party (20)"
	price = 1450
	good = /obj/item/blister/methadone
	amt = 20
	rarity = 60
	opy = 1
/datum/tovar/methadone_blister20
/datum/tovar/oxy_blister
	name = "OxyContinuum(tm) preciption painkiller blister"
	price = 120
	good = /obj/item/blister/oxy
	opy = 1
/datum/tovar/oxy_blister
/datum/tovar/oxy_blister5
	name = "OxyContinuum(tm) blisters (5x)"
	price = 560
	good = /obj/item/blister/oxy
	opy = 1
/datum/tovar/oxy_blister5
/datum/tovar/oxy_blister20
	name = "OxyContinuum(tm) blisters party (20x)"
	price = 2100
	good = /obj/item/blister/oxy
	rarity = 88
	opy = 1
/datum/tovar/oxy_blister20
/datum/tovar/morphine
	name = "20pts of medical morphine"
	price = 490
	rarity = 80
	good = /obj/item/reagent_container/beaker/bottle/morphine
	opy = 1
/datum/tovar/morphine
/datum/tovar/speed
	name = "10pts of high-quality amphetamine"
	price = 60
	good = /obj/item/reagent_container/beaker/tiny/speed
/datum/tovar/speed
/datum/tovar/mdpv
	name = "10pts of MDPV"
	price = 35
	good = /obj/item/reagent_container/beaker/tiny/mdpv
/datum/tovar/mdpv
/datum/tovar/meth
	name = "10pts of high-quality methamphetamine"
	price = 70
	good = /obj/item/reagent_container/beaker/tiny/meth
	faked = /obj/item/reagent_container/beaker/tiny/meth/faked
/datum/tovar/meth
/datum/tovar/speed_pill
	name = "amphetamine pills (5x)"
	price = 275
	good = /obj/item/reagent_container/consumable/pill/speed
	amt = 5
/datum/tovar/speed_pill
/datum/tovar/speed_pill10
	name = "amphetamine pills (10x)"
	price = 435
	good = /obj/item/reagent_container/consumable/pill/speed
	amt = 10
	rarity = 50
/datum/tovar/speed_pill10
/datum/tovar/meow_pill
	name = "meow-meow pills (5x)"
	price = 290
	good = /obj/item/reagent_container/consumable/pill/meow
	amt = 5
/datum/tovar/meow_pill
/datum/tovar/meow_pill10
	name = "meow-meow pills (10x)"
	price = 480
	good = /obj/item/reagent_container/consumable/pill/meow
	amt = 10
	rarity = 60
/datum/tovar/meow_pill10
/datum/tovar/meow5
	name = "5pts of pure mephedrone"
	price = 150
	good = /obj/item/reagent_container/beaker/tiny/meow5
/datum/tovar/meow5
/datum/tovar/meow10
	name = "10pts of pure mephedrone"
	price = 270
	good = /obj/item/reagent_container/beaker/tiny/meow10
	rarity = 50
/datum/tovar/meow10
/datum/tovar/meow50
	name = "50pts of pure mephedrone"
	price = 960
	good = /obj/item/reagent_container/beaker/meow50
	rarity = 66
/datum/tovar/meow50
/datum/tovar/cocaine6
	name = "6pts of Malabar-2 cocaine"
	price = 270
	good = /obj/item/reagent_container/beaker/tiny/cocaine6
	rarity = 33
/datum/tovar/cocaine6
/datum/tovar/cocaine12
	name = "12pts of Malabar-2 cocaine"
	price = 505
	good = /obj/item/reagent_container/beaker/tiny/cocaine12
	rarity = 20
/datum/tovar/cocaine12
/datum/tovar/ecstasy
	name = "ecstasy pills (10x)"
	price = 270
	good = /obj/item/reagent_container/consumable/pill/ecstasy
	amt = 10
/datum/tovar/ecstasy
/datum/tovar/ecstasy2
	name = "ecstasy pills (5x)"
	price = 150
	good = /obj/item/reagent_container/consumable/pill/ecstasy
	faked = /obj/item/reagent_container/consumable/pill/ecstasy/crappy
	amt = 5
/datum/tovar/ecstasy2
/datum/tovar/empatho
	name = "Empathopentin (USSR-4 Psychiatry Departament-approved, high quality) blister"
	price = 80
	good = /obj/item/blister/empathopentin
	rarity = 40
/datum/tovar/empatho
/datum/tovar/empatho5
	name = "Empathopentin (USSR-4 Psychiatry Departament-approved, high quality) blisters (5x)"
	price = 340
	good = /obj/item/blister/empathopentin
	amt = 5
	rarity = 40
/datum/tovar/empatho5
/datum/tovar/empatho10
	name = "Empathopentin (USSR-4 Psychiatry Departament-approved, high quality) blisters (10x)"
	price = 600
	good = /obj/item/blister/empathopentin
	amt = 10
	rarity = 50
/datum/tovar/empatho10
/datum/tovar/speed_beaker
	name = "50pts of high-quality amphetamine"
	price = 275
	good = /obj/item/reagent_container/beaker/speed
/datum/tovar/speed_beaker
/datum/tovar/meth_beaker
	name = "50pts of high-quality methamphetamine"
	price = 325
	rarity = 80
	good = /obj/item/reagent_container/beaker/meth
/datum/tovar/meth_beaker
/datum/tovar/mda
	name = "pure MDA bottle (30pts)"
	price = 60
	good = /obj/item/reagent_container/beaker/bottle/mda
/datum/tovar/mda
/datum/tovar/mdma
	name = "pure MDMA bottle (30pts)"
	price = 170
	rarity = 80
	good = /obj/item/reagent_container/beaker/bottle/mdma
/datum/tovar/mdma
/datum/tovar/mdoh
	name = "pure MDOH bottle (30pts)"
	price = 160
	rarity = 66
	good = /obj/item/reagent_container/beaker/bottle/mdoh
/datum/tovar/mdoh
/datum/tovar/cbd
	name = "medical CBD blister"
	price = 25
	good = /obj/item/blister/sedative_cbd
/datum/tovar/cbd
/datum/tovar/weed2
	name = "weed (2x)"
	price = 8
	good = /obj/item/reagent_container/consumable/vtoryaki/weed
	amt = 2
/datum/tovar/weed2
/datum/tovar/weed5
	name = "weed (5x)"
	price = 18
	good = /obj/item/reagent_container/consumable/vtoryaki/weed
	amt = 5
/datum/tovar/weed5
/datum/tovar/weed10
	name = "weed (10x)"
	price = 32
	good = /obj/item/reagent_container/consumable/vtoryaki/weed
	amt = 10
	rarity = 45
/datum/tovar/weed10
/datum/tovar/hash
	name = "1g of high-potent hasheesh"
	price = 20
	good = /obj/item/reagent_container/consumable/hash/edinichka
/datum/tovar/hash
/datum/tovar/hash5
	name = "5g of high-potent hasheesh"
	price = 85
	good = /obj/item/reagent_container/consumable/hash/dohuya
	rarity = 45
/datum/tovar/hash5
/datum/tovar/bud5
	name = "5x high-potent buds"
	price = 45
	good = /obj/item/reagent_container/consumable/plant/bud
	amt = 5
/datum/tovar/bud5
/datum/tovar/bud10
	name = "10x high-potent buds"
	price = 80
	good = /obj/item/reagent_container/consumable/plant/bud
	amt = 10
	rarity = 45
/datum/tovar/bud10
/datum/tovar/reefer5
	name = "5x buds (with nicotine-free empty reefers!)"
	price = 50
	good = /obj/item/reefer_pack
	amt = 1
	rarity = 40
/datum/tovar/reefer5
/datum/tovar/reefer10
	name = "10x buds (with nicotine-free empty reefers!)"
	price = 90
	good = /obj/item/reefer_pack
	amt = 2
	rarity = 50
/datum/tovar/reefer10
/datum/tovar/synthbud5
	name = "5x synthpotented buds"
	price = 67
	good = /obj/item/reagent_container/consumable/plant/bud/potent
	good = /obj/item/reagent_container/consumable/plant/bud/potent/fake
	amt = 5
	rarity = 60
/datum/tovar/synthbud5
/datum/tovar/synthbud10
	name = "10x synthpotented buds"
	price = 121
	good = /obj/item/reagent_container/consumable/plant/bud/potent
	good = /obj/item/reagent_container/consumable/plant/bud/potent/fake
	amt = 10
	rarity = 70
/datum/tovar/synthbud10
/datum/tovar/hash_oil
	name = "30 units of hash oil"
	price = 55
	good = /obj/item/reagent_container/beaker/bottle/hash
	rarity = 60
/datum/tovar/hash_oil
/datum/tovar/spice_silver3
	name = "spice silver (3x)"
	price = 10
	good = /obj/item/reagent_container/consumable/spice
	amt = 3
/datum/tovar/spice_silver3
/datum/tovar/spice_silver5
	name = "spice silver (5x)"
	price = 15
	good = /obj/item/reagent_container/consumable/spice
	amt = 5
/datum/tovar/spice_silver5
/datum/tovar/spice_silver10
	name = "spice silver (10x)"
	price = 25
	good = /obj/item/reagent_container/consumable/spice
	amt = 5
/datum/tovar/spice_silver10
/datum/tovar/spice_silver100
	name = "spice silver (100x)"
	price = 160
	good = /obj/item/reagent_container/consumable/spice
	amt = 100
/datum/tovar/spice_silver100
/datum/tovar/spice_gold3
	name = "spice gold (3x)"
	price = 12
	good = /obj/item/reagent_container/consumable/spice/gold
	amt = 3
/datum/tovar/spice_gold3
/datum/tovar/spice_gold5
	name = "spice gold (5x)"
	price = 18
	good = /obj/item/reagent_container/consumable/spice/gold
	amt = 5
/datum/tovar/spice_gold5
/datum/tovar/spice_gold10
	name = "spice gold (10x)"
	price = 30
	good = /obj/item/reagent_container/consumable/spice/gold
	amt = 10
/datum/tovar/spice_gold10
/datum/tovar/spice_gold100
	name = "spice gold (100x)"
	price = 210
	good = /obj/item/reagent_container/consumable/spice/gold
	amt = 100
/datum/tovar/spice_gold100
/datum/tovar/spice_diamond3
	name = "spice diamond (3x)"
	price = 15
	good = /obj/item/reagent_container/consumable/spice/diamond
	amt = 3
/datum/tovar/spice_diamond3
/datum/tovar/spice_diamond5
	name = "spice diamond (5x)"
	price = 22
	good = /obj/item/reagent_container/consumable/spice/diamond
	amt = 5
/datum/tovar/spice_diamond5
/datum/tovar/spice_diamond10
	name = "spice diamond (10x)"
	price = 40
	good = /obj/item/reagent_container/consumable/spice/diamond
	amt = 10
/datum/tovar/spice_diamond10
/datum/tovar/spice_diamond100
	name = "spice diamond (100x)"
	price = 260
	good = /obj/item/reagent_container/consumable/spice/diamond
	amt = 100
/datum/tovar/spice_diamond100
/datum/tovar/spice_special5
	name = "top premium herbal mix (5x)"
	price = 60
	good = /obj/item/reagent_container/consumable/spice/trippy
	rarity = 60
	amt = 5
/datum/tovar/spice_special5
/datum/tovar/spice_special10
	name = "top premium herbal mix (10x)"
	price = 110
	good = /obj/item/reagent_container/consumable/spice/trippy
	rarity = 80
	amt = 10
/datum/tovar/spice_special10
/datum/tovar/spice_special100
	name = "top premium herbal mix (100x)"
	price = 640
	good = /obj/item/reagent_container/consumable/spice/trippy
	rarity = 90
	amt = 100
/datum/tovar/spice_special100
/datum/tovar/widow5
	name = "White Widow smoking chemical (5x)"
	price = 50
	good = /obj/item/reagent_container/consumable/spice/widow
	amt = 5
/datum/tovar/widow5
/datum/tovar/widow10
	name = "White Widow smoking chemical (10x)"
	price = 80
	good = /obj/item/reagent_container/consumable/spice/widow
	rarity = 60
	amt = 10
/datum/tovar/widow10
/datum/tovar/widow100
	name = "White Widow smoking chemical (100x)"
	price = 480
	good = /obj/item/reagent_container/consumable/spice/widow
	rarity = 90
	amt = 100
/datum/tovar/widow100
/datum/tovar/peace
	name = "peacenipizine blister"
	price = 24
	good = /obj/item/blister/peace
/datum/tovar/peace
/datum/tovar/peace5
	name = "peacenipizine blister (5x)"
	price = 105
	good = /obj/item/blister/peace
/datum/tovar/peace5
/datum/tovar/fluox1
	name = "fluoxetine blister"
	price = 20
	good = /obj/item/blister/fluoxetine
/datum/tovar/fluox1
/datum/tovar/fluox10
	name = "fluoxetine blisters (10x)"
	price = 175
	good = /obj/item/blister/fluoxetine
	amt = 10
/datum/tovar/fluox10
/datum/tovar/fluox100
	name = "fluoxetine blisters party (100x)"
	price = 800
	good = /obj/item/blister/fluoxetine
	rarity = 80
	amt = 100
/datum/tovar/fluox100
/datum/tovar/ambrobene
	name = "Ambrobene+ syrup (5pts of codeine, 25pts of ambrosine)"
	price = 60
	good = /obj/item/reagent_container/beaker/bottle/ambro_plus
	rarity = 66
	opy = 1
/datum/tovar/ambrobene
/datum/tovar/ambrobene20
	name = "Ambrobene+ party (20x)"
	price = 700
	good = /obj/item/reagent_container/beaker/bottle/ambro_plus
	amt = 20
	opy = 1
/datum/tovar/ambrobene20
/datum/tovar/ambrobene50
	name = "Ambrobene+ party (50x)"
	price = 1500
	good = /obj/item/reagent_container/beaker/bottle/ambro_plus
	amt = 50
	rarity = 75
	opy = 1
/datum/tovar/ambrobene50
/datum/tovar/ambrobene100
	name = "Ambrobene+ party (100x)"
	price = 2550
	good = /obj/item/reagent_container/beaker/bottle/ambro_plus
	amt = 100
	rarity = 90
	opy = 1
/datum/tovar/ambrobene100
/datum/tovar/glucocetamol
	name = "Glucocetamol blister (isn't a drug itself, but useful on withdrawals; do not consume more than 1 pill in a row)"
	price = 60
	good = /obj/item/blister/glucocetamol
	rarity = 66
/datum/tovar/glucocetamol
/datum/tovar/glucocetamol10
	name = "Glucocetamol blisters party (10x)"
	price = 540
	good = /obj/item/blister/glucocetamol
	amt = 10
/datum/tovar/glucocetamol10
/datum/tovar/glucocetamol50
	name = "Glucocetamol blisters party (50x)"
	price = 2490
	good = /obj/item/blister/glucocetamol
	amt = 50
/datum/tovar/glucocetamol50
/datum/tovar/squirrel
	name = "'White squirrel' brand USSR-4 anti-hangover pills (especially useful if you're drunk yourself into delirium)"
	price = 50
	good = /obj/item/blister/squirrel
	rarity = 66
/datum/tovar/squirrel
/datum/tovar/plasmagen
	name = "Plasma generator"
	price = 160
	good = /obj/item/electronics/plasma_gen
	rarity = 50
/datum/tovar/plasmagen
/datum/tovar/targeting
	name = "Targeting system"
	price = 140
	good = /obj/item/electronics/targeting
/datum/tovar/targeting
/datum/tovar/transport_comp
	name = "Universal Communications motherboard"
	price = 155
	good = /obj/item/electronics/board/transport
/datum/tovar/transport_comp
/datum/tovar/sec_comp
	name = "Security Control (a.k.a. distant shitcurity torturing) motherboard"
	price = 280
	good = /obj/item/electronics/board/prosecutor
/datum/tovar/sec_comp
/datum/tovar/tantric
	name = "Tantric assembly"
	price = 40
	good = /obj/item/electronics/tantric
/datum/tovar/tantric
/datum/tovar/consolehack
	name = "Console module"
	price = 300
	good = /obj/item/device/consolehack
	rarity = 70
/datum/tovar/consolehack
/datum/tovar/e_module
	name = "Biomechanics reprogramming module"
	price = 450
	good = /obj/item/device/e_module
	rarity = 60
/datum/tovar/e_module
/datum/tovar/brutforcer
	name = "Door brutforcer"
	price = 750
	good = /obj/item/device/brutforcer
	rarity = 85
/datum/tovar/brutforcer
/datum/tovar/caller
	name = "USSR-4 shuttle caller and uncaller (all-in-one pack!)"
	price = 400
	good = /obj/item/call_pack
	rarity = 50
/datum/tovar/caller
/datum/tovar/fullabyss
	name = "Abyssal teleporter"
	price = 390
	rarity = 50
	good = /obj/item/device/abyss_tele
/datum/tovar/fullabyss
/datum/tovar/shocker
	name = "Electric shock (for self-defence only)"
	price = 300
	rarity = 50
	good = /obj/item/device/abyss_tele
/datum/tovar/shocker
/datum/tovar/fullxom
	name = "Fully-assembled Xom communicator"
	price = 666
	rarity = 50
	good = /obj/item/electronics/xom_finished
/datum/tovar/fullxom
/datum/tovar/spreader
	name = "Fully-assembled 'stick it in amoeba box and open the latter for fun!'"
	price = 400
	rarity = 50
	good = /obj/item/electronics/amoeba
/datum/tovar/spreader
/datum/tovar/r_hand
	name = "Cybersaw (right hand)"
	price = 300
	good = /obj/item/limb/r_hand/r_hand_robo
/datum/tovar/r_hand
/datum/tovar/l_hand
	name = "Cybersaw (left hand)"
	price = 300
	good = /obj/item/limb/l_hand/l_hand_robo
/datum/tovar/l_hand
/datum/marketname/booze
	name = "(alchohol drinks and beveages)"
/datum/marketname/booze
/datum/marketname/ecstasy
	name = "(ecstasy)"
/datum/marketname/ecstasy
/datum/marketname/speed
	name = "(stims)"
/datum/marketname/speed
/datum/marketname/opi
	name = "(opiates)"
/datum/marketname/opi
/datum/marketname/precursors
	name = "(precursors)"
/datum/marketname/precursors
/datum/marketname/weed
	name = "(cannabis)"
/datum/marketname/weed
/datum/marketname/spice
	name = "(bathsalts & smoking mixes)"
/datum/marketname/spice
/datum/marketname/lsd
	name = "(Lysergamides)"
/datum/marketname/lsd
/datum/marketname/preciption
	name = "(preciption drugs)"
/datum/marketname/preciption
/datum/marketname/foreign
	name = "(foreign drugstore wholesale ordering)"
/datum/marketname/foreign
/datum/marketname/dissociatives
	name = "(dissociatives)"
/datum/marketname/dissociatives
/datum/marketname/phenethylamine
	name = "(phenethylamines)"
/datum/marketname/phenethylamine
/datum/marketname/tryptamine
	name = "(tryptamines)"
/datum/marketname/tryptamine
/datum/marketname/shrooms
	name = "(psilocybe srooms)"
/datum/marketname/shrooms
/datum/marketname/grow
	name = "(growing supplies)"
/datum/marketname/grow
/datum/marketname/supplies
	name = "(confiscated goods)"
/datum/marketname/supplies
/datum/marketname/magicks
	name = "(occultic supplies)"
/datum/marketname/magicks
/datum/marketname/hardware
	name = "(electronics)"
/datum/marketname/hardware
/datum/marketname/science
	name = "(research assembly)"
/datum/marketname/science
/datum/marketname/device
	name = "(devices and device cores)"
/datum/marketname/device
/datum/marketname/benzo
	name = "(benzodiazepines and other sedatives)"
/datum/marketname/benzo
/datum/goodlist/market_precursors
	glist = list(new /datum/marketname/precursors, new /datum/tovar/phenethylamine, new /datum/tovar/carbo, new /datum/tovar/benzaldehyde, new /datum/tovar/benzaldehyde70, new /datum/tovar/ephedrine, new /datum/tovar/ephedrine70, new /datum/tovar/pseudoephedrine, new /datum/tovar/pseudoephedrine70, new /datum/tovar/cellulose)

/datum/goodlist/market_precursors

/datum/goodlist/market_booze















	glist = list(new /datum/marketname/booze, new /datum/tovar/vodka2, new /datum/tovar/vodka10, new /datum/tovar/beer5, new /datum/tovar/beer10, new /datum/tovar/beer50, new /datum/tovar/beer_sovok, new /datum/tovar/semerki, new /datum/tovar/ethanol, new /datum/tovar/ethanol5, new /datum/tovar/absinth, new /datum/tovar/stimdrink2, new /datum/tovar/stimdrink10, new /datum/tovar/stimdrink_plus, new /datum/tovar/coffee, new /datum/tovar/squirrel)

/datum/goodlist/market_booze

/datum/goodlist/market_speed












	glist = list(new /datum/marketname/speed, new /datum/tovar/mdpv, new /datum/tovar/speed, new /datum/tovar/meth, new /datum/tovar/speed_pill, new /datum/tovar/speed_pill10, new /datum/tovar/meow_pill, new /datum/tovar/meow_pill10, new /datum/tovar/speed_beaker, new /datum/tovar/meth_beaker, new /datum/tovar/meow5, new /datum/tovar/meow10, new /datum/tovar/meow50)

/datum/goodlist/market_speed

/datum/goodlist/market_ecstasy










	glist = list(new /datum/marketname/ecstasy, new /datum/tovar/ecstasy, new /datum/tovar/ecstasy2, new /datum/tovar/mda, new /datum/tovar/mdma, new /datum/tovar/mdoh, new /datum/tovar/meow_pill, new /datum/tovar/meow_pill10, new /datum/tovar/party, new /datum/tovar/absinth, new /datum/tovar/empatho10)

/datum/goodlist/market_ecstasy

/datum/goodlist/market_benzo















	glist = list(new /datum/marketname/benzo, new /datum/tovar/barbital1, new /datum/tovar/barbital10, new /datum/tovar/barbital100, new /datum/tovar/pheno, new /datum/tovar/pheno10, new /datum/tovar/klono, new /datum/tovar/klono10, new /datum/tovar/klono20, new /datum/tovar/cosmo, new /datum/tovar/cosmo10, new /datum/tovar/trankbottle, new /datum/tovar/cbd, new /datum/tovar/rohypnol, new /datum/tovar/rohypnol10, new /datum/tovar/glucocetamol)

/datum/goodlist/market_benzo


/datum/goodlist/market_opi























	glist = list(new /datum/marketname/opi, new /datum/tovar/poppy, new /datum/tovar/poppy_great, new /datum/tovar/heroin, new /datum/tovar/heroin_great, new /datum/tovar/heroin_small, new /datum/tovar/buprik, new /datum/tovar/buprik_great, new /datum/tovar/buprik_small, new /datum/tovar/fentanyl, new /datum/tovar/fentanyl_great, new /datum/tovar/fentanyl_small, new /datum/tovar/methadone, new /datum/tovar/methadone_great, new /datum/tovar/methadone_pill, new /datum/tovar/methadone_blister, new /datum/tovar/methadone_blister20, new /datum/tovar/oxy_blister, new /datum/tovar/oxy_blister5, new /datum/tovar/morphine, new /datum/tovar/tram3, new /datum/tovar/tram5, new /datum/tovar/tram10, new /datum/tovar/tram20, new /datum/tovar/glucocetamol)

/datum/goodlist/market_opi

/datum/goodlist/market_weed













	glist = list(new /datum/marketname/weed, new /datum/tovar/hash, new /datum/tovar/bud5, new /datum/tovar/bud10, new /datum/tovar/synthbud5, new /datum/tovar/synthbud10, new /datum/tovar/reefer5, new /datum/tovar/reefer10, new /datum/tovar/weed2, new /datum/tovar/weed5, new /datum/tovar/weed10, new /datum/tovar/hash_oil, new /datum/tovar/peace, new /datum/tovar/cbd)

/datum/goodlist/market_weed

/datum/goodlist/market_drugstore








































	glist = list(new /datum/marketname/preciption, new /datum/tovar/ambrobene, new /datum/tovar/syrup3, new /datum/tovar/syrup5, new /datum/tovar/syrup20, new /datum/tovar/barbital1, new /datum/tovar/barbital10, new /datum/tovar/barbital100, new /datum/tovar/pheno, new /datum/tovar/klono, new /datum/tovar/klono10, new /datum/tovar/klono20, new /datum/tovar/cosmo, new /datum/tovar/cosmo10, new /datum/tovar/trankbottle, new /datum/tovar/speed_pill, new /datum/tovar/blister1, new /datum/tovar/blister10, new /datum/tovar/blister100, new /datum/tovar/fluox1, new /datum/tovar/fluox10, new /datum/tovar/fluox100, new /datum/tovar/tram3, new /datum/tovar/tram5, new /datum/tovar/tram10, new /datum/tovar/oxy_blister, new /datum/tovar/oxy_blister5, new /datum/tovar/calypso, new /datum/tovar/methadone_pill, new /datum/tovar/methadone_blister, new /datum/tovar/cbd, new /datum/tovar/ethanol5, new /datum/tovar/empatho, new /datum/tovar/empatho5, new /datum/tovar/empatho10, new /datum/tovar/indopan, new /datum/tovar/indopan5, new /datum/tovar/indopan10, new /datum/tovar/glucocetamol10, new /datum/tovar/peace, new /datum/tovar/peace5)

/datum/goodlist/market_drugstore

/datum/goodlist/market_foreign





















	glist = list(new /datum/marketname/foreign, new /datum/tovar/syrup20, new /datum/tovar/syrup50, new /datum/tovar/klono20, new /datum/tovar/pheno10, new /datum/tovar/barbital100, new /datum/tovar/blister100, new /datum/tovar/fluox100, new /datum/tovar/ambrobene20, new /datum/tovar/ambrobene50, new /datum/tovar/ambrobene100, new /datum/tovar/methadone_blister20, new /datum/tovar/tram20, new /datum/tovar/calypso20, new /datum/tovar/oxy_blister20, new /datum/tovar/rohypnol10, new /datum/tovar/ethanol5, new /datum/tovar/indopan10, new /datum/tovar/glucocetamol10, new /datum/tovar/glucocetamol50, new /datum/tovar/empatho10, new /datum/tovar/peace5)

/datum/goodlist/market_foreign

/datum/goodlist/market_phenethylamine


































	glist = list(new /datum/marketname/phenethylamine, new /datum/tovar/phenethylamine, new /datum/tovar/cb1, new /datum/tovar/cb5, new /datum/tovar/cb10, new /datum/tovar/cb100, new /datum/tovar/cb_5pts, new /datum/tovar/cb_10pts, new /datum/tovar/dob1, new /datum/tovar/dob5, new /datum/tovar/dob10, new /datum/tovar/dob100, new /datum/tovar/doi1, new /datum/tovar/doi5, new /datum/tovar/doi10, new /datum/tovar/doi100, new /datum/tovar/doc1, new /datum/tovar/doc5, new /datum/tovar/doc10, new /datum/tovar/doc100, new /datum/tovar/dom1, new /datum/tovar/dom5, new /datum/tovar/dom10, new /datum/tovar/dom100, new /datum/tovar/dob_pts, new /datum/tovar/doi_pts, new /datum/tovar/doc_pts, new /datum/tovar/dom_pts, new /datum/tovar/nbome1, new /datum/tovar/nbome5, new /datum/tovar/nbome10, new /datum/tovar/nbome100, new /datum/tovar/nbome1000, new /datum/tovar/nbome_crystal)

/datum/goodlist/market_phenethylamine

/datum/goodlist/market_tryptamine




















	glist = list(new /datum/marketname/tryptamine, new /datum/tovar/dmt_smoke1, new /datum/tovar/dmt_smoke5, new /datum/tovar/dmt_smoke10, new /datum/tovar/dmt_smoke100, new /datum/tovar/psilocybin, new /datum/tovar/psilo_ampule, new /datum/tovar/psilo_ampule5, new /datum/tovar/fivemeo_ampule, new /datum/tovar/fivemeo_ampule5, new /datum/tovar/dipt_ampule, new /datum/tovar/dipt_ampule5, new /datum/tovar/fivedipt_ampule, new /datum/tovar/fivedipt_ampule5, new /datum/tovar/homet5, new /datum/tovar/homet10, new /datum/tovar/acodmt5, new /datum/tovar/acodmt10, new /datum/tovar/fivemeo, new /datum/tovar/dipt, new /datum/tovar/homet)

/datum/goodlist/market_tryptamine

/datum/goodlist/market_lsd







	glist = list(new /datum/marketname/lsd, new /datum/tovar/lsa, new /datum/tovar/lsa_great, new /datum/tovar/lsd1, new /datum/tovar/lsd5, new /datum/tovar/lsd10, new /datum/tovar/lsd100, new /datum/tovar/lsd_liquid)

/datum/goodlist/market_lsd

/datum/goodlist/market_dissociatives














	glist = list(new /datum/marketname/dissociatives, new /datum/tovar/dex5, new /datum/tovar/dex20, new /datum/tovar/dex50, new /datum/tovar/dex_bottle1, new /datum/tovar/dex_bottle3, new /datum/tovar/dex_bottle5, new /datum/tovar/ket5, new /datum/tovar/ket10, new /datum/tovar/ket20, new /datum/tovar/calypso, new /datum/tovar/calypso4, new /datum/tovar/calypso20, new /datum/tovar/mxe5, new /datum/tovar/mxe10)

/datum/goodlist/market_dissociatives

/datum/goodlist/market_shrooms





	glist = list(new /datum/marketname/shrooms, new /datum/tovar/shrooms, new /datum/tovar/shrooms_great, new /datum/tovar/psilocybin, new /datum/tovar/psilo_ampule, new /datum/tovar/psilo_ampule5)

/datum/goodlist/market_shrooms

/datum/goodlist/market_spice



















	glist = list(new /datum/marketname/spice, new /datum/tovar/mdpv, new /datum/tovar/spice_silver3, new /datum/tovar/spice_silver5, new /datum/tovar/spice_silver10, new /datum/tovar/spice_silver100, new /datum/tovar/spice_gold3, new /datum/tovar/spice_gold5, new /datum/tovar/spice_gold10, new /datum/tovar/spice_gold100, new /datum/tovar/spice_diamond3, new /datum/tovar/spice_diamond5, new /datum/tovar/spice_diamond10, new /datum/tovar/spice_diamond100, new /datum/tovar/spice_special5, new /datum/tovar/spice_special10, new /datum/tovar/spice_special100, new /datum/tovar/widow5, new /datum/tovar/widow10, new /datum/tovar/widow100)

/datum/goodlist/market_spice

/datum/goodlist/market_grow
















	glist = list(new /datum/marketname/grow, new /datum/tovar/fert5, new /datum/tovar/fert10, new /datum/tovar/fert50, new /datum/tovar/dust5, new /datum/tovar/dust10, new /datum/tovar/dust50, new /datum/tovar/poppy1, new /datum/tovar/shrooms, new /datum/tovar/seed_woodrose, new /datum/tovar/seed_lofofora, new /datum/tovar/seed_weed1, new /datum/tovar/seed_weed5, new /datum/tovar/seed_salvia1, new /datum/tovar/seed_salvia5, new /datum/tovar/psychotria, new /datum/tovar/ayahuasca)

/datum/goodlist/market_grow

/datum/goodlist/market_supplies
























	glist = list(new /datum/marketname/supplies, new /datum/tovar/caller, new /datum/tovar/key, new /datum/tovar/fert10, new /datum/tovar/dust10, new /datum/tovar/charge, new /datum/tovar/hawaii, new /datum/tovar/twotwoeight, new /datum/tovar/bong, new /datum/tovar/consolehack, new /datum/tovar/brutforcer, new /datum/tovar/e_module, new /datum/tovar/plasmagen, new /datum/tovar/guide, new /datum/tovar/blueprint, new /datum/tovar/designer, new /datum/tovar/chainsaw, new /datum/tovar/cutters, new /datum/tovar/cross, new /datum/tovar/party, new /datum/tovar/grimore, new /datum/tovar/rock, new /datum/tovar/abyss, new /datum/tovar/l_hand, new /datum/tovar/r_hand)

/datum/goodlist/market_supplies

/datum/goodlist/market_hardware
	glist = list(new /datum/marketname/hardware,
		new /datum/tovar/plasmagen,
		new /datum/tovar/targeting,
		new /datum/tovar/transport_comp,
		new /datum/tovar/transport_comp,
		new /datum/tovar/sec_comp,
		new /datum/tovar/tantric,
		new /datum/tovar/consolehack,
		new /datum/tovar/e_module,
		new /datum/tovar/caller,
		new /datum/tovar/abyss,
		new /datum/tovar/fullabyss,

		new /datum/tovar/blueprint)

/datum/goodlist/market_hardware

/datum/goodlist/market_science


















	glist = list(new /datum/marketname/science, new /datum/tovar/cross, new /datum/tovar/grimore, new /datum/tovar/opal, new /datum/tovar/plasmagen, new /datum/tovar/targeting, new /datum/tovar/tantric, new /datum/tovar/amoeba_food, new /datum/tovar/amoeba_box, new /datum/tovar/amoeba_acidy, new /datum/tovar/amoeba_core, new /datum/tovar/science_pack, new /datum/tovar/worms, new /datum/tovar/abyss, new /datum/tovar/spreader, new /datum/tovar/l_hand, new /datum/tovar/r_hand, new /datum/tovar/designer, new /datum/tovar/blueprint)

/datum/goodlist/market_science

/datum/goodlist/market_magicks








	glist = list(new /datum/marketname/magicks, new /datum/tovar/cross, new /datum/tovar/grimore, new /datum/tovar/rock, new /datum/tovar/tracer, new /datum/tovar/dmt_smoke1, new /datum/tovar/abyss, new /datum/tovar/fullxom, new /datum/tovar/fullabyss)

/datum/goodlist/market_magicks

/datum/goodlist/market_device













	glist = list(new /datum/tovar/cross, new /datum/tovar/tracer, new /datum/tovar/shocker, new /datum/tovar/plasmagen, new /datum/tovar/abyss, new /datum/tovar/fullabyss, new /datum/tovar/consolehack, new /datum/tovar/brutforcer, new /datum/tovar/caller, new /datum/tovar/fullxom, new /datum/tovar/spreader, new /datum/tovar/l_hand, new /datum/tovar/r_hand, new /datum/tovar/blueprint)

/datum/goodlist/market_device