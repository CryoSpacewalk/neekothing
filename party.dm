/client/var/partying
/client/var/opwire
/client/proc/start_partying()
	if(src.partying)
		return 0
	var/partyhard = new /obj/hud_effect/party()
	src.partying = partyhard
	src.screen += partyhard
	usr << sound('baybar.ogg', 1, channel = 666, volume = 30)
	spawn(0) src.party()
	return 1

/client/proc/stop_partying()
	screen -= partying
	del(partying)
	dir = 1
	lazy_eye = 0
	usr << sound('null.ogg', wait = 0, channel = 666)

/client/proc/party_hard()
	set category = "OOC"
	if(start_partying())
		spawn(300)
			stop_partying()

/client/proc/party()
	var/newdir
	while(partying)
		newdir = dir
		while(newdir == dir)
			newdir = pick(1, 2, 4, 8)
		dir = newdir
		lazy_eye = rand(0, 4)
		sleep(rand(5, 20))

/client/proc/party_temporal(t)









	if(!start_partying())
		start_partying()
	spawn(t) stop_partying()

/obj/cloud/var/amount = 0
