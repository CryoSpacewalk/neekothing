//#include double_quotes.txt

var/darknet_name = "dongs"

///banners generation


proc/bannergen(var/list/markers, var/device_link, var/orient)

	var/banr = ""
	var/datum/baryga/B = null
	var/i = barygas.len

//	banr += "<table=[orient]>"
//	banr+="<p align = middle>"//<p align = [gay_orient]>"
//	banr+="""
//	banr+= "[gay_orient]"
//	banr+="""
//	banr+=">"

	sleep()

	while(!B&&i)
		i--
		var/datum/baryga/BRG = pick(barygas)

		if( !(BRG.market_marker in markers) )
			B = BRG
			markers += BRG.market_marker

	switch(B.market_marker)

		if("(bathsalts & smoking mixes)")
			banr = "<a href='?src=\ref[device_link];action=[B.name] '><img src='banner_spice.gif'></a>"

		if("(confiscated goods)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_arms.gif'></a>"

		if("(tryptamines)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_trypt.gif'></a>"

		if("(dissociatives)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_dis.gif' class></a>"

		if("(ecstasy)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_e.gif' class></a>"

		if("(foreign drugstore wholesale ordering)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_foreign.gif' class></a>"

		if("(cannabis)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_weed.gif' class></a>"

		if("(opiates)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_opi.gif' class></a>"

		if("(alchohol drinks and beveages)")//2d
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_booze.gif'></a>"

		if("(stims)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_speed.gif'></a>"

		if("(Lysergamides)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_lsd.gif'></a>"

		if("(preciption drugs)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_preciption.gif'></a>"

		if("(phenethylamines)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_phenik.gif'></a>"

		if("(psilocybe srooms)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_shrooms.gif'></a>"

		if("(phenethylamines)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_phenik.gif'></a>"

		if("(growing supplies)")//2d
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_grow.gif'></a>"

		if("(occultic supplies)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_magick.gif'></a>"

		if("(electronics)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_hardware.gif'></a>"

		if("(research assembly)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_science.gif'></a>"

		if("(devices and device cores)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_device.gif'></a>"

		if("(benzodiazepines and other sedatives)")
			banr = "<a href='?src=\ref[device_link];action=[B.name]'><img src='banner_benzo.gif'></a>"

		else
			banr = ""

//	banr+="</table>"
//	world << "[banr]"
	return banr

var/list/banners = list()

proc/banner_list()
	var/i = 8
	while(i)
		banners += bannergen()
		i--

proc/banner_output()//N ДА, МЫ ЕБАНУЛИСb!
	banner_list()
	var/x = pick(banners)
	banners = list()
	return x

/obj/item/device/communicator

	attack_self()

		var/list/used_markers() = list()//list of the used banners so all banners will be unique

		dnet_change(used_markers)

		usr << browse_rsc('pic1.gif')

		usr << browse_rsc('banner_dis.gif')
		usr << browse_rsc('banner_trypt.gif')
		usr << browse_rsc('banner_arms.gif')
		usr << browse_rsc('banner_spice.gif')
		usr << browse_rsc('banner_opi.gif')
		usr << browse_rsc('banner_foreign.gif')
		usr << browse_rsc('banner_weed.gif')
		usr << browse_rsc('banner_e.gif')
		usr << browse_rsc('banner_hardware.gif')
		usr << browse_rsc('banner_preciption.gif')
		usr << browse_rsc('banner_speed.gif')
		usr << browse_rsc('banner_lsd.gif')
		usr << browse_rsc('banner_lab.gif')
		usr << browse_rsc('banner_science.gif')
		usr << browse_rsc('banner_benzo.gif')
		usr << browse_rsc('banner_device.gif')
		usr << browse_rsc('banner_phenik.gif')
		usr << browse_rsc('banner_shrooms.gif')
//		usr << browse_rsc('banner_grow.gif')



		usr << browse(darknet_body,darknet_set)


////////////

	Topic(href,href_list[])

		switch(href_list["action"])

			if("svetov_buy")
				svetov_buy()

			if("svetov_sell")
				svetov_sell()

			else

				for(var/datum/baryga/B in barygas)

					if(B.name == href_list["action"])
						zatar_good(usr,B)

////////////


	var
		darknet_body
		darknet_set = {"window=darknet_body;display=1;
size=10x10,border=0;can_close=1;
can_resize=0;can_minimize=0;titlebar=1"}

	proc/dnet_change(used_markers)

///baryga list

		var/baryga_matrix = "<font color = yellow><b>Active traders (by categories):</b><HR><BR>"
//
		for(var/datum/baryga/B in barygas)

			baryga_matrix += "<BR><a href='?src=\ref[src];action=[B.name]'>[B.name]</a>"
			if(prob(25))
				baryga_matrix+="<table align = right>[bannergen(used_markers,src,orient = "right")]<table>"

///a majority of random banners

//		var/r_banner1 = "[bannergen(used_markers,src,"center")]"//не ебу, зачем
///

		darknet_body = {"

<style> .gay_orientation_right {float: right; margin: 0 0 5px 5px;}</style>
<style> .gay_orientation_center {float: center; margin: 0 0 5px 5px;}</style>
<style> .gay_orientation_left {float: left;margin: 0 0 5px 5px;}</style>

<head>
<title>Bluespace encryptor "Rassvet" (WARNING: not for civilian usage) ******hax0d by RPaul******</title>
</head>

<body bgcolor = darkred>

<H1>

<a href=http://www.srkn.ru/texts/salo_part1.shtml><img src='pic1.gif'></a>
<font color = yellow size = 4>Welcome to the [darknet_name]: fastest and safest way to deliver your order via bluespace!
</font>
<img src="/pic1.gif">

</H1>

<table cellpadding=10 border=0 width=580>

[banner_output()]

<font color = yellow>

<td align = "left">
<BR><BR>

Welcome back.<BR>
You have <b>[money]</b> cherenkovs left.<BR>
You have <b>[svetov]</b> svetovs left.<BR>
<BR>
Current svetov value: [svetov_value] rubles.<BR>
Current cherenkov value: [cherenkov_value] rubles.<BR>

"<a href='?src=\ref[src];action=svetov_buy'>Buy 100 svetovs for [ (100*svetov_value/cherenkov_value)/(1-dnet_comission/100) ] cherenkovs ([dnet_comission]% comission)</a>"<BR>
"<a href='?src=\ref[src];action=svetov_sell'>Buy 100 cherenkovs for [ (100*cherenkov_value/svetov_value)/(1-dnet_comission/100) ] svetovs ([dnet_comission]% comission)</a>"<BR>


[banner_output()]

</td>

</font>

</table>
<BR>
<BR>

[baryga_matrix]
<BR>

<table align = center>[bannergen(used_markers,src,orient = "center")]<table>

</body>"}

//На деревьях вместо листьев <a href='?src=\ref[src];action=zatar'>вешать будем коммунистов!</a>

