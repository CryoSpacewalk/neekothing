// Recovered from compiled neek.dmb (1 procs)
/mob/proc/mortal_throw()
	src << "\green \bold YOU WAS ABOUT TO DIE BUT YOUR WILL FOR LIFE PREVENTS YOUR FROM DIYNG THIS TIME!"
	if(src.brutedmg)
		src.heal(2, "brute")
	if(src.organdmg)
		src.heal(2, "organ")
	if(src.burndmg)
		src.heal(2, "burn")
