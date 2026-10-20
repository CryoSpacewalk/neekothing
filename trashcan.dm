// Recovered from compiled neek.dmb (3 procs)

/obj/dump
	invisibility = 101
	var/todel = list(); bomb_proof = 100
/obj/dump/New()
	src.trashcan_clear()

/obj/dump/proc/trashcan_clear()
	if(src.todel:len)

		var/A = src.todel[1]
		del(A)
	spawn(10) src.trashcan_clear()

/atom/movable/proc/trash()
	for(var/obj/dump/D in world)
		if(!(src in D.todel))
			D.todel += src
			src.loc = null

			sleep(-1)
