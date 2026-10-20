/client
	var/controlsfuck = 0
/client/proc/reversal(atom/r_dir)






	if(r_dir:x > mob.x)
		West()
	else
		if(r_dir:x < mob.x)
			East()
		else
			if(r_dir:y > mob.y)
				South()
			else
				if(r_dir:y < mob.y)
					North()
