// Recovered from compiled neek.dmb (1 procs)
/proc/calculate_closest(atom/movable/A1, L, minrange = world.maxx)

	var/minatom = null

	for(var/atom/A in L)

		if(get_dist(A1:loc, A.loc) < minrange && step_to(A1, A, 0, -1) != 0)
			minrange = range(A1, A)
			minatom = A

	if(minatom)
		world << "[minatom]"
		return minatom
	else
		world << "no minatom"
		return(pick(L))