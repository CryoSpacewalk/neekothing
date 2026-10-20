// Recovered from compiled neek.dmb (12 procs)

/atom
	var/have_doubles = 0

var/list/double_turf_list = list("LSD" = 2, "serotonin" = 0.005, "25b-NBOMe" = 2, "25i-NBOMe" = 2, "salvinorin A" = 8, "adrenochrome" = 2, "DXM" = 1.29, "ketamine" = 1.19, "MXE" = 1.09, "MXP" = 1.09, "PCP" = 1)
















var/list/double_atom_list = list("LSA" = 2, "serotonin" = 2, "2C-B" = 2, "2C-I" = 2, "2C-P" = 4, "DOB" = 2, "DOC" = 2, "DOI" = 2, "DOM" = 2, "mescaline" = 2)



















var/list/sinus_list = list("LSD" = 3, "LSA" = 3, "serotonin" = 3, "2C-B" = 1, "2C-I" = 1, "2C-P" = 3, "25b-NBOMe" = 3, "25i-NBOMe" = 3, "DOB" = 1, "DOC" = 1, "DOI" = 1, "DOM" = 1, "mescaline" = 2, "5-MeO-DMT" = 3, "DMT" = 3, "4-HO-MET" = 1, "psilocybin" = 1, "5-MeO-DiPT" = 1, "5-Bromo-DMT" = 1, "MXP" = 2)





























var/list/turf_morphing_list = list("DXM" = 2.29, "MXE" = 2.09, "ketamine" = 2.19, "adrenochrome" = 2, "salvia" = 3, "MXP" = 3.09)





















var/list/quad_morphing_list = list("LSD" = 1, "LSA" = 1, "serotonin" = 2, "2C-B" = 1, "2C-I" = 1, "2C-P" = 2, "25b-NBOMe" = 2, "25i-NBOMe" = 2, "mescaline" = 1, "5-MeO-DMT" = 1, "DMT" = 1, "4-HO-MET" = 1, "psilocybin" = 1, "5-MeO-DiPT" = 1, "5-Bromo-DMT" = 2)





















var/list/kaleido_morphing_list = list("LSD" = 2, "LSA" = 2, "serotonin" = 2, "2C-B" = 1, "2C-I" = 1, "2C-P" = 1, "25b-NBOMe" = 1, "25i-NBOMe" = 1, "mescaline" = 2, "5-MeO-DMT" = 3, "DMT" = 3, "4-HO-MET" = 3, "psilocybin" = 1, "5-MeO-DiPT" = 3, "5-Bromo-DMT" = 2)





















var/list/glitch_prob_list = list("serotonin" = 10, "DXM" = 4, "MXE" = 2, "MXP" = 6, "3-MeO-PCP" = 2, "3-MeO-PCE" = 2, "2C-P" = 2, "DOB" = 1, "DOC" = 1, "DOM" = 1, "DOI" = 1, "2C-B-FLY" = 4, "Bromo-DragonFLY" = 6, "trihexyphenidyl" = 8, "atropine" = 6, "dicyclomine" = 6, "Nuclear titbit" = 6, "tropicamide" = 6, "DPH" = 6, "amantadine" = 5, "rimantadine" = 5)




























var/list/glitch_min_list = list("serotonin" = 0, "DXM" = 6, "MXE" = 1, "MXP" = 1, "3-MeO-PCP" = 1.33, "3-MeO-PCE" = 1.33, "2C-P" = 0, "DOB" = 0, "DOC" = 0, "DOM" = 0, "DOI" = 0, "2C-B-FLY" = 2, "Bromo-DragonFLY" = 0, "trihexyphenidyl" = 10, "atropine" = 0.5, "dicyclomine" = 20, "Nuclear titbit" = 0, "tropicamide" = 7.5, "DPH" = 10, "amantadine" = 7.5, "rimantadine" = 15)
/mob/proc/adv_visuals()









































	if(!src.client)
		return

	src.drug_visuals_check()

	if(src.doubles_shift_turf)
		for(var/turf/T in view(double_turf_list[doubles_shift_turf] + 1, src))
			client:doubles_gen(T, 30, 128, double_turf_list[src.doubles_shift_turf])

	if(src.doubles_shift_obj)
		var/formula = client:view - 2 - double_atom_list[src.doubles_shift_obj]
		for(var/obj/M in view(src))
			if(!M.invisibility && !(M in view(formula, src)))
				client:doubles_gen(M, 30, 64, double_atom_list[src.doubles_shift_obj])

	if(src.sinus_obj)
		for(var/obj/O in view(3, src))
			if(!O.invisibility && prob(sinus_list[src.sinus_obj]))
				src.client.sinus_gen(O, 360, 10, 16, null, 40)

	if(src.turf_morphing)
		for(var/turf/T in view(src))
			if(prob(turf_morphing_list[src.turf_morphing]))
				client:tile_morphing(T, 360, 64, img_delay = 5)

	if(src.kaleido_morphing)
		for(var/obj/O in view(3, src))
			if(!O.invisibility && (prob(kaleido_morphing_list[src.kaleido_morphing]) && !prob(50)))
				src.client.tile_morphing(O, 360, 64, img_delay = 5)

	if(src.quad_morphing)
		for(var/turf/T in view(src))
			if(prob(quad_morphing_list[src.quad_morphing]))
				client:quad_morphing(T, 360, 5, 36, null, 32)

	if(src.glitch_morphing)
		for(var/turf/T in view(src))
			if(prob(glitch_prob_list[src.glitch_morphing]))
				client:glitch_morphing(T, 12, rand(1, 4))
		for(var/obj/structure/S in view(src))
			if(prob(glitch_prob_list[src.glitch_morphing]))
				client:glitch_morphing(S, 12, rand(1, 4))
		for(var/obj/door/D in view(src))
			if(prob(glitch_prob_list[src.glitch_morphing]))
				client:glitch_morphing(D, 12, rand(1, 4))
		for(var/obj/machine/M in view(src))
			if(prob(glitch_prob_list[src.glitch_morphing]))
				client:glitch_morphing(M, 12, rand(1, 4))

	spawn(10) src.adv_visuals()

/mob/proc/drug_visuals_check()

	var/double_turf
	double_turf = 0
	var/double_atom = 0
	var/sinus = 0
	var/turf_morph = 0
	var/kaleido_morph = 0
	var/quad_morph = 0
	var/glitch_morph = 0

	if(src.blood_chem:len)

		for(var/datum/reagent/R in src.blood_chem)
			for(var/drugname in double_turf_list)
				if(R.id == drugname)
					double_turf = drugname
			for(var/drugname in double_atom_list)
				if(R.id == drugname)
					double_atom = drugname
			for(var/drugname in sinus_list)
				if(R.id == drugname)
					sinus = drugname
			for(var/drugname in turf_morphing_list)
				if(R.id == drugname)
					turf_morph = drugname
			for(var/drugname in kaleido_morphing_list)
				if(R.id == drugname)
					kaleido_morph = drugname
			for(var/drugname in quad_morphing_list)
				if(R.id == drugname)
					quad_morph = drugname
			for(var/drugname in glitch_min_list)
				if(R.id == drugname && R.amount >= glitch_min_list[drugname])
					glitch_morph = drugname
	spawn(0)

		if(src.z in abyssal_levels)
			src.doubles_shift_turf = 0
			src.doubles_shift_obj = 0
			src.sinus_obj = 0
			src.turf_morphing = 0
			src.kaleido_morphing = 0
			src.quad_morphing = 0
		else

			src.doubles_shift_turf = double_turf
			src.doubles_shift_obj = double_atom
			src.sinus_obj = sinus
			src.turf_morphing = turf_morph
			src.kaleido_morphing = kaleido_morph
			src.quad_morphing = quad_morph

		src.glitch_morphing = glitch_morph

/client/proc/fake_icon(atom/A)

	var/T
	if(istype(A, /turf))
		T = A
	else
		T = A:loc
	var/image/I = image(A:icon, T, A:icon_state, A:layer)

	return I

/client/proc/doubles_gen(atom/A, tick, transp, i_shift)






	var/I_base = new /icon(A:icon, A:icon_state)
	var/I1 = new /icon(A:icon, A:icon_state)
	var/I2 = new /icon(A:icon, A:icon_state)
	I1 -= rgb(0, 0, 0, transp)
	I2 -= rgb(0, 0, 0, transp)
	I_base:Blend(I1, 3, 1 - i_shift, 1)
	I_base:Blend(I2, 3, 1 + i_shift, 1)

	var/image/doubles = image(I_base, A, A:layer)
	doubles:mouse_opacity = 0
	doubles:override = 1
	doubles:layer = A:layer

	src << doubles
	spawn(tick) doubles:hide()




/client/proc/sinus_gen(atom/A, tick, img_delay = 0, transp, image/prev_img, clock)

	if(img_delay)
		spawn(img_delay) prev_img:hide()
	else
		prev_img:hide()

	var/image/doubles = image(A:icon, A, A:layer)
	doubles:mouse_opacity = 0
	doubles:override = 1

	var/I_base = new /icon(A:icon, A:icon_state)
	var/I1 = new /icon(A:icon, A:icon_state)
	var/I2 = new /icon(A:icon, A:icon_state)
	I1 -= rgb(0, 0, 0, transp)
	I2 -= rgb(0, 0, 0, transp)
	I_base:Blend(I1, 3, round(16 * sin(tick)) / 2, round(16 * sin(tick * 2)) / 2)
	I_base:Blend(I2, 3, -round(16 * sin(tick)) / 2, -round(16 * sin(tick * 2)) / 2)

	doubles = image(I_base, A, A:layer)
	doubles:layer = A:layer

	src << doubles

	if(clock)

		spawn(2) src.sinus_gen(A, tick - 10, img_delay, transp, doubles, clock - 1)
	else


		doubles:hide()
		return



/client/proc/quad_morphing(atom/A, tick, img_delay = 0, transp, image/prev_img, clock)


	if(img_delay)
		spawn(img_delay) prev_img:hide()
	else
		prev_img:hide()

	var/image/doubles = image(A:icon, A, A:layer)
	doubles:mouse_opacity = 0
	doubles:override = 1



	var/I_base = new /icon(A:icon, A:icon_state)
	var/I_nw = new /icon('grafon/mask.dmi', "turf_nw")
	var/I_ne = new /icon('grafon/mask.dmi', "turf_ne")
	var/I_sw = new /icon('grafon/mask.dmi', "turf_sw")
	var/I_se = new /icon('grafon/mask.dmi', "turf_se")

	I_nw:Blend(I_base, 0, 1, 1)
	I_ne:Blend(I_base, 0, 1, 1)
	I_sw:Blend(I_base, 0, 1, 1)
	I_se:Blend(I_base, 0, 1, 1)

	I_nw:Turn(tick)
	I_ne:Turn(-tick)
	I_sw:Turn(-tick)
	I_se:Turn(tick)


	I_nw -= rgb(0, 0, 0, transp)
	I_ne -= rgb(0, 0, 0, transp)
	I_sw -= rgb(0, 0, 0, transp)
	I_se -= rgb(0, 0, 0, transp)

	I_nw:Blend(I_ne, 3, 1, 1)
	I_nw:Blend(I_sw, 3, 1, 1)
	I_nw:Blend(I_se, 3, 1, 1)

	doubles = image(I_nw, A, A:layer)
	doubles:layer = 2

	src << doubles

	if(clock)


		spawn(2) src.quad_morphing(A, tick - 10, img_delay, transp, doubles, clock - 1)
	else


		doubles:hide()
		return

/client/proc/tile_turning(I_base, tick, transp, quad_dir)





	var/I = new /icon('grafon/mask.dmi', "turf_[quad_dir]")

	I:Blend(I_base, 0, 1, 1)
	I -= rgb(0, 0, 0, transp)

	switch(quad_dir)
		if("nw")
			I:Shift(6, 8)
			I:Turn(tick)
			I:Shift(9, 8)
		if("sw")
			I:Shift(5, 8)
			I:Turn(tick)
			I:Shift(10, 8)
		if("ne")
			I:Shift(10, 8)
			I:Turn(tick)
			I:Shift(5, 8)
		if("se")
			I:Shift(9, 8)
			I:Turn(tick)
			I:Shift(6, 8)

	return I

/client/proc/tile_morphing(atom/A, tick, transp, img_delay = 0, image/prev_img = null)



	if(img_delay && prev_img)
		spawn(img_delay) prev_img:hide()
	else
		prev_img:hide()

	var/I_base = new /icon(A:icon, A:icon_state)
	var/I_kombo = src.tile_turning(I_base, tick, transp, "nw")
	I_kombo:Blend(src.tile_turning(I_base, tick, transp, "sw"), 3, 1, 1)
	I_kombo:Blend(src.tile_turning(I_base, tick, transp, "se"), 3, 1, 1)
	I_kombo:Blend(src.tile_turning(I_base, tick, transp, "ne"), 3, 1, 1)

	var/image/I_nw_img = image(I_kombo, A, A:layer)
	I_nw_img:mouse_opacity = 0
	I_nw_img:override = 0
	I_nw_img:layer = 2

	src << I_nw_img



	spawn(2)

		if(tick)
			src.tile_morphing(A, tick - 5, transp, img_delay, I_nw_img)
		else

			I_nw_img:hide()
			return

/client/proc/glitch_morphing(atom/A, glitch_step, clock)



	var/image/glitchpic = image(A:icon, A, A:layer)
	glitchpic:mouse_opacity = 0
	glitchpic:override = 1

	var/I_base = new /icon(A:icon, A:icon_state)
	var/I1 = new /icon('grafon/mask.dmi', "glitch1")
	var/I2 = new /icon('grafon/mask.dmi', "glitch2")
	var/I3 = new /icon('grafon/mask.dmi', "glitch3")
	var/I4 = new /icon('grafon/mask.dmi', "glitch4")
	var/I5 = new /icon('grafon/mask.dmi', "glitch5")
	var/I6 = new /icon('grafon/mask.dmi', "glitch6")
	var/I7 = new /icon('grafon/mask.dmi', "glitch7")
	var/I8 = new /icon('grafon/mask.dmi', "glitch8")

	I1:Blend(I_base, 0, 1, 1)
	I2:Blend(I_base, 0, 1, 1)
	I3:Blend(I_base, 0, 1, 1)
	I4:Blend(I_base, 0, 1, 1)
	I5:Blend(I_base, 0, 1, 1)
	I6:Blend(I_base, 0, 1, 1)
	I7:Blend(I_base, 0, 1, 1)
	I8:Blend(I_base, 0, 1, 1)

	I1:Shift(pick(8, 4), rand(round(glitch_step / 2), glitch_step), pick(0, 1))
	I2:Shift(pick(8, 4), rand(round(glitch_step / 2), glitch_step), pick(0, 1))
	I3:Shift(pick(8, 4), rand(round(glitch_step / 2), glitch_step), pick(0, 1))
	I4:Shift(pick(8, 4), rand(round(glitch_step / 2), glitch_step), pick(0, 1))
	I5:Shift(pick(8, 4), rand(round(glitch_step / 2), glitch_step), pick(0, 1))
	I6:Shift(pick(8, 4), rand(round(glitch_step / 2), glitch_step), pick(0, 1))
	I7:Shift(pick(8, 4), rand(round(glitch_step / 2), glitch_step), pick(0, 1))
	I8:Shift(pick(8, 4), rand(round(glitch_step / 2), glitch_step), pick(0, 1))

	I1:Blend(I2, 3, 1, 1)
	I1:Blend(I3, 3, 1, 1)
	I1:Blend(I4, 3, 1, 1)
	I1:Blend(I4, 3, 1, 1)
	I1:Blend(I5, 3, 1, 1)
	I1:Blend(I6, 3, 1, 1)
	I1:Blend(I7, 3, 1, 1)
	I1:Blend(I8, 3, 1, 1)

	glitchpic = image(I1, A, A:layer)
	glitchpic:layer = A:layer

	src << glitchpic

	spawn(clock) glitchpic:hide()

/client/proc/tile_fractal(atom/A, obj/prev_img, delay, transp, depth, powr)



	var/Aloc

	if(istype(A, /turf))
		Aloc = A
	else
		Aloc = A:loc

	powr++

	var/icon/I_n_ic = new /icon(A:icon, A:icon_state)
	var/icon/I_s_ic = new /icon(A:icon)
	var/icon/I_w_ic = new /icon(A:icon)
	var/icon/I_e_ic = new /icon(A:icon)

	I_n_ic -= rgb(0, 150, 0, transp)
	I_s_ic -= rgb(0, 0, 0, transp)
	I_w_ic -= rgb(0, 0, 0, transp)
	I_e_ic -= rgb(0, 0, 0, transp)

	var/obj/I_n_obj = new /obj(Aloc)
	var/image/I_n = image(I_n_ic, I_n_obj)




	src << I_n






	sleep(delay)

	I_n_ic:Shift(1, 10, 1)




	spawn(delay)

		if(depth)
			src.tile_fractal(I_n_obj, I_n_obj, delay, transp, depth - 1, powr)



			spawn(1) prev_img:hide()
		else
			I_n:hide()
			I_n_obj:hide()



		return








/client/proc/tile_recolor(atom/A, tick, color_step, color_of_now = "red", color_counter = 0, image/prev_img = null)

	src << "color of now: [color_of_now]"

	var/I_over

	if(prev_img)
		prev_img:hide()
		I_over = new /icon(prev_img:icon, prev_img:icon_state)
	else
		I_over = new /icon(A:icon, A:icon_state)

	switch(color_of_now)
		if("red")

			if(color_counter < 125)
				I_over += rgb(color_step, 0, -color_step)
			else
				color_of_now = "green"
				color_counter = 0
		if("green")
			if(color_counter < 125)
				I_over += rgb(-color_step, color_step, 0)
			else
				color_of_now = "blue"
				color_counter = 0
		if("blue")
			if(color_counter < 125)
				I_over += rgb(0, -color_step, color_step)
			else
				color_of_now = "red"
				color_counter = 0
		else
			if(color_counter < 125)
				I_over += rgb(color_step, 0, 0)
			else
				color_of_now = "green"
				color_counter = 0

	var/image/I_recolor_img = image(I_over, A, A:layer)
	I_recolor_img:mouse_opacity = 0
	I_recolor_img:override = 0
	I_recolor_img:layer = 5

	src << I_recolor_img



	spawn(2)

		if(tick)
			src.tile_recolor(A, tick--, color_step, color_of_now, color_counter + color_step, I_recolor_img, I_over)
		else

			I_recolor_img:hide()
			return








/mob/proc/webpunk(tiem = 20)

	var/gun_left_ic = new /icon('grafon/thingy.dmi', "webpunk_gun_l")
	var/gun_right_ic = new /icon('grafon/thingy.dmi', "webpunk_gun_r")
	var/ontop_ic = new /icon('grafon/thingy.dmi', "webpunk[rand(0, 2)]")

	var/image/gun_left = image(gun_left_ic, src, 4.1)
	var/image/gun_right = image(gun_right_ic, src, 4.1)
	var/image/ontop = image(ontop_ic, src, 4.1)

	ontop:pixel_y += 32
	gun_left:pixel_x -= 32
	gun_right:pixel_x += 32

	if(src.client)
		src.client << ontop
		src.client << gun_left
		src.client << gun_right

	spawn(tiem)
		gun_left:hide()
		gun_right:hide()
		ontop:hide()
		return