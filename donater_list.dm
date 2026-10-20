// Recovered from compiled neek.dmb (2 procs)
/var/baryga_needed = 1



var/list/donat_mutation = list("kotowasiy", "ahdeza")




var/list/donat_mule = list("kotowasiy", "ahdeza")




var/list/donat_forger = list("kotowasiy", "ahdeza")




var/list/donat_profi = list("kotowasiy", "ahdeza")




var/list/donat_baryga = list("kotowasiy", "ahdeza")




var/list/donat_lucky = list("kotowasiy")
/mob/proc/equip_mule()














	src << ""
	src << "\red \bold As a drug mule, you have to deliver 2.4pts of heroin to the escape shuttle evacuation point. It doesn't matter if you deliver it in this ziplock (check your pocket!), in another beaker, in the form of pills, or even hidden inside some food: just escape with 2.4pts of heroin equipped."

	src.equip_pocket2(new /obj/item/reagent_container/beaker/tiny/heroin())

/mob/proc/equip_forger()


	src << ""
	src << "\red \bold One way or another, you've managed to master your skills in forging documents and recipe cards. You even have smuggled medical stamp (check your pocket!) here, so you're able to forge and reforge recipe cards."

	if(src.maggot)
		src << "\red \bold They don't let homosexuals onto frontier complexes due to some dumb restriction, but you've managed to fool commission with fake certificate."

	src.equip_pocket2(new /obj/item/stamp())
/client/var/mule = 0
/client/var/forger = 0
/client/var/reversd = 0
var/list/prof_med = list("doctor", "researcher", "cognitologist", "psychiatrist", "chemist", "project director")









var/list/prof_sec = list("security major", "captain", "purificator", "prosecutor")






var/list/prof_engi = list("engineer", "operator", "assistant", "chief engineer")
