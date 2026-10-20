/*mob/verb/creditgeneration()
	creditgen()
	credit_body = "<CENTER><font size = 7>[creditsname]</font></CENTER><HR><BR>"
	var/i = 3
	if(castlist.len)
		for(var/cst in castlist)
			credit_body += "\b <CENTER>[cst]</CENTER><BR>"
			credit_body += "<BR>"

	credit_body += "<HR>"
	credit_body += "\b <font size = 4>FUN FACTS:</font><BR>"
	credit_body += "<font size = 4>Did you know that</font><BR>"
	while(i)
		var/factofaday = pick(funfacts)
		funfacts-=factofaday
		credit_body += "*[factofaday]?<BR>"
		i--

	usr << browse(credit_body,credit_sets)
*/




//html

var/credit_sets = {"window=Fuck you!;display=1;
size=600x700;border=0;can_close=1;
can_resize=1;can_minimize=0;titlebar=1"}

var/credit_body

//Cast

var/list/castlist = list()





//creditsname

var/creditsname = ""

var/list/cfirst = list("A nation of","The unbelieveable","Rise of","Fall of","Ascension of","The rampaging","The godawful")
var/list/csecond = list("terror","proletariate","psychonauts","paranoia","enlightened","true-seeing","liars","communists")

//generation of credicts as it is
proc/creditgen()
	var/meh = pick(cfirst)
	var/heh = pick(csecond)
	cfirst -= meh
	csecond -= heh
	var/lel = ""
	var/kek = ""
	if(prob(50))
		lel = pick(cfirst)
		kek = pick(csecond)
		creditsname = "[meh] [heh]: [lel] [kek]"
	else
		creditsname = "[meh] [heh]"
		if(bodycount)
			funfacts += "[bodycount] people died today"
		else
			funfacts += "a miracle occurs and nobody died today"
		if(beheaded)
			funfacts += "[beheaded] heads were severed today"
		if(ghostcount)
			funfacts += "[ghostcount] spectres and veterans were banished by purificator today"
		if(hangedcount==1)
			funfacts += "only one man was hanged today"
		if(!nuked)
			funfacts += "the crew protected the nuke from banging somehow"
		else if(hangedcount)
			funfacts += "[hangedcount] people were hanged today"
		var/clcount
		var/toxcount
		for(var/obj/cloud/prespawned/C in world)
			clcount++
		for(var/obj/cloud/toxin/C in world)
			toxcount++
		if(clcount >= 4)
			funfacts += "somebody just released a fuckload of chlorine today"
		if(toxcount >= 4)
			funfacts += "somebody just released a fuckload of toxin today"
	spawn()
		credit_body = "<CENTER><font size = 7>[creditsname]</font></CENTER><HR><BR>"
		var/i = 3
		if(castlist.len)
			for(var/cst in castlist)
				credit_body += "\b <CENTER>[cst]</CENTER><BR>"
				credit_body += "<BR>"

		credit_body += "<HR>"
		credit_body += "\b <font size = 4>FUN FACTS:</font><BR>"
		credit_body += "<font size = 4>Did you know that</font><BR>"
		while(i)
			var/factofaday = pick(funfacts)
			funfacts-=factofaday
			credit_body += "*[factofaday]?<BR>"
			i--
			world << browse(credit_body,credit_sets)

//FUN FACTS

var/list/funfacts = list("if you're reading it, you probably have an internet access","if you cut your finger very deeply with a knife, it usually bleeds","if you drink much from a bottle marked 'poison', it is almost certain to disagree with you, sooner or later","a red-hot poker will burn you if you hold it too long")

//bodycount and statistic shit

var/bodycount = 0
var/beheaded = 0
var/ghostcount = 0
var/hangedcount = 0