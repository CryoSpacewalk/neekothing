/mob
	var/brutal_pos = 0
/mob{var/calming_pos = 0}
/mob{var/eupho_pos = 0}
/proc/sanitize_simple(t, repl_chars = list("ÿ" = "&#255;", "\n" = "#", "\t" = "#", "ï¿½" = "ï¿½"))
	for(var/char in repl_chars)
		var/index = findtext(t, char)
		while(index)
			t = copytext(t, 1, index) + repl_chars[char] + copytext(t, index + 1)
			index = findtext(t, char)
		return t

/proc/ruout(msg, html = 0)
	var/rep
	if(html)
		rep = "&#x44F;"
	else
		rep = "&#255;"
	var/index = findtext(msg, "ÿ", 1)
	while(index)
		msg = copytext(msg, 1, index) + rep + copytext(msg, index + 1)
		index = findtext(msg, "ÿ", 1)
	return msg

/proc/rhtml_encode(msg, html = 0)
	var/rep
	if(html)
		rep = "&#x44F;"
	else
		rep = "&#255;"
	var/c = text2list(msg, "ÿ")
	if(c:len == 1)
		c = text2list(msg, rep)
		if(c:len == 1)
			return html_encode(msg)
	var/out = ""
	var/first = 1
	for(var/text in c)
		if(!first)
			out += rep
		first = 0
		out += html_encode(text)
	return out

/proc/rhtml_decode(msg, html = 0)
	var/rep
	if(html)
		rep = "&#x44F;"
	else
		rep = "&#255;"
	var/c = text2list(msg, "ÿ")
	if(c:len == 1)
		c = text2list(msg, "&#255;")
		if(c:len == 1)
			c = text2list(msg, "&#x4FF")
			if(c:len == 1)
				return html_decode(msg)
	var/out = ""
	var/first = 1
	for(var/text in c)
		if(!first)
			out += rep
		first = 0
		out += html_decode(text)

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
