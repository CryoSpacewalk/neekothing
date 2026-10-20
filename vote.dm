// Recovered from compiled neek.dmb (2 procs)

var/vote_init = 0

var/list/voted = list()
/client/verb/vote()

	set name = "Vote for reboot"
	set category = "OOC"

	if(src.ckey in voted)
		src << "\red \bold [vote_init] folks have already voted, including you!"
	else
		var/answ = input("Are you fucking sure you want to reboot the world ([vote_init] folks have already voted)?") in list("Yes", "No")
		if(answ == "Yes")
			if(src.ckey in voted)
				src << "\red \bold Are you trying to cheat me? You've already voted!"
				return
			voted += src.ckey
			vote_init++
			if(vote_init == 1)
				vote_reboot(src.ckey)

/proc/vote_reboot(M_name)
	world << "<font size = 5>[M_name] wanna to reboot the world! You have one minute to vote if you wanna to restart.</font>"
	spawn(600)
		var/votes_needed = 0
		for(var/mob/M in world)
			if(M.client)
				votes_needed++
		if(vote_init >= votes_needed / 2)
			world << "<font size = 5>The voting is over! [vote_init] out of [votes_needed] players've voted for restart!</font>"
			world << "\red \bold Rebooting world..."
			spawn(10) world.Reboot()
		else
			world << "<font size = 5>The voting is over! [vote_init] out of [votes_needed] players've voted for restart! No reboot for you!</font>"
			vote_init = 0
