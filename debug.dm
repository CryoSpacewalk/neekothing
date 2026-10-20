// Recovered from compiled neek.dmb (3 procs)
/obj/floor
/obj/floor/gay
/obj/floor/gay/New()
/obj/floor/gay/dismemberment_flight()

/obj/proc/dismemberment_flight()
	world << "test dismemberment_flight"
	var/final_x = rand(src.x - 5, src.x + 5)
	var/final_y = rand(src.y - 5, src.y + 5)
	var/dist = 1
	while(src.x != final_x && src.y != final_y)
		for(var/obj/floor/F in range(1, src))
			F.text = "<font color=red>.</font>"
		step_to(src, locate(final_x, final_y, src.z), 1, 0)
		dist++
		if(dist > 5)
			return
		sleep(2)
