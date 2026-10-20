/mob
	var/brutal_pos = 0
/mob{var/calming_pos = 0}
/mob{var/eupho_pos = 0}
/proc/gen_memes()





























	var/i = rand(8, 10)
	meme_brutal = rand("a", "z")
	while(i)
		i--
		meme_brutal = addtext(meme_brutal, rand("a", "z"))
		sleep(0)
	i = rand(8, 10)
	meme_calming = rand("a", "z")
	while(i)
		i--
		meme_calming = addtext(meme_calming, rand("a", "z"))
		sleep(0)
	i = rand(8, 10)
	meme_eupho = rand("a", "z")
	while(i)
		i--
		meme_eupho = addtext(meme_eupho, rand("a", "z"))
		sleep(0)
