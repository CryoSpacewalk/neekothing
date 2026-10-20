// Recovered from compiled neek.dmb (2 procs)

/mob/proc/show_drugvalues(atom/valueman, keyword, drugvalue)


















	switch(drugvalue)
		if(-2)

			usr << "[valueman:name] thinks what using [keyword] drugs is nothing more than a waste of time."
		if(-1)
			usr << "[valueman:name] somewhat dislikes [keyword] drugs."
		if(0)
			usr << "[valueman:name] don't have any opinion on [keyword] drugs."
		if(1)
			usr << "[valueman:name] has a rather high opinion on [keyword] drugs."
		if(2)
			usr << "[valueman:name] thinks what [keyword] drugs are sooo fucking sweet."
/mob{var/values_opi = 0; var/values_psy = 0; var/values_stim = 0; var/values_dis = 0; var/values_downers = 0; var/values_extasy = 0; var/values_weed = 0; var/values_needle = 0; var/values_fuck = 0}
/mob/proc/show_values()


	usr.show_drugvalues(src, "opioid", src.values_opi)
	usr.show_drugvalues(src, "psychedelic", src.values_psy)
	usr.show_drugvalues(src, "stimulating", src.values_stim)
	usr.show_drugvalues(src, "dissociative", src.values_dis)
	usr.show_drugvalues(src, "alchohol and sedative", src.values_downers)
	usr.show_drugvalues(src, "cannabis-derived", src.values_weed)
	usr.show_drugvalues(src, "empathogenic", src.values_extasy)

	if(values_needle < 0)
		usr << "[src.name] is quite afraid of needles."
	else
		usr << "[src.name] is not afraid of injections at all."

	if(values_fuck)
		usr << "[src.name] is one horny bastard!"
	else

		usr << "[src.name] is almost frigid."