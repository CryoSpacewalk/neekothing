// Recovered from compiled neek.dmb (1 procs)

/atom/var/atom/stalk_target = null
/atom/var/atom/deficon = null
/atom/proc/stalk(bot_memory, hatescult, hatesabyss, hatesrobots, hatesethereal, hatesnpc)








	for(var/mob/M in view(src))
		if(M.psiactive)
			step_away(src, M)

	if(stalk_target)
		if(src.stalk_target:psiactive || (!hatescult && src.stalk_target:cult || (stalk_target:dead || (!hatesabyss && stalk_target:abyss > 0 || !(stalk_target in view(src)) && prob(100 - bot_memory)))))
			stalk_target = null

	spawn(0)

		if(stalk_target)
			step_to(src, stalk_target)
		else
			for(var/mob/M in view(src))
				if(!M.psiactive || (!hatescult && M.cult || (!hatesabyss && M.abyss >= 0 || (!hatesrobots && M.mat == "plastic" || !hatesethereal && (M.mat == "ether" && (!hatesnpc && M.ckey))))))
					stalk_target = M
