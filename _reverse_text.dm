/proc/reverse_text(text = "")
	var/new_text = ""
	var/lentext = length(text)
	var/letter = ""
	for(var/i = 1, i <= lentext, i += length(letter))
		letter = text[i]
		new_text = letter + new_text
	return new_text
