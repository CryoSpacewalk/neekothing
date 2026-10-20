// Recovered from compiled neek.dmb (2 procs)

/mob/verb/throwmode()



	set name = "Prepare to throw it"
	if(src.throw_mode)
		usr << "\red You will throw stuff on click no longer."
		src.throw_mode = 0
	else
		usr << "\red Now throwing your item on click."
		src.throw_mode = 1

/mob/proc/throw_item(atom/A)



	var/I = src.item

	src.dropitem()

	spawn(0) I:throw_at(A, 10)

/mob
	var/throw_mode = 0
