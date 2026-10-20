
/obj/machine/snek
	name = "Tic-tac-toe"
	density = 1
	bomb_proof = 15
	icon = 'grafon/structure.dmi'
	icon_state = "zmeyka"
	desc = "A fascinating game for bored personnel! I have no idea how this thing works even without power supply."


	attack_hand()
		usr << browse('tictactoe.js',"display=0;")
		usr << browse('tictactoe.html',snek_set)
		snek_check(usr)

	proc/snek_check(mob/user)

		if(user in range(1,src))
			spawn(10) snek_check()
		else
			user << browse(null)
			return