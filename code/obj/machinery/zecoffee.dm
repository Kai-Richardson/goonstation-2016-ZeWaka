/obj/machinery/coffee_machines
	name = "coffee machine debug"
	desc = "Report to coders if you can see this!"
	icon = 'icons/obj/foodNdrink/zecoffee.dmi'// no no no
	icon_state = "syndie"
	density = 1
	anchored = 1
	flags = FPRINT
	pressure_resistance = 2*ONE_ATMOSPHERE

	proc/smash()
		new /obj/effects/water(src.loc)
		qdel(src)

	ex_act(severity)
		switch(severity)
			if (1.0)
				qdel(src)
				return
			if (2.0)
				if (prob(50))
					smash()
					return
			if (3.0)
				if (prob(5))
					smash()
					return
			else
		return

	blob_act(var/power)
		if (prob(25))
			smash()

	temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
		..()
		if (reagents)
			for (var/i = 0, i < 9, i++) // ugly hack
				reagents.temperature_reagents(exposed_temperature, exposed_volume)

/* ==================================================== */
/* --------------------- Machines --------------------- */
/* ==================================================== */
/obj/machinery/coffee_machines/espresso //sorry about the frankencode
	name = "espresso machine"
	desc = "It's top of the line NanoTrasen espresso technology! Featuring 100% Organic Locally-Grown espresso beans!" //haha no
	icon = 'icons/obj/foodNdrink/zecoffee.dmi'
	icon_state = "syndie" //no no no
	var/cupinside = 0 //true or false
	var/cup = "coffee cup"

	attackby(obj/item/W as obj, mob/user as mob)
		if (istype(W, src.cup))
			user.drop_item()
			qdel(W)
			src.cupinside ++
			boutput(user, "You place \the [src.cup] into \the [src].")
			src.update()
		else return ..()

	attack_hand(mob/user as mob)
		src.add_fingerprint(user)
		if (src.cupinside == 0)
			user.show_text("\The [src] has no cup to remove, doofus!", "red")
		else
			boutput(user, "You take \an [src.cup] out of \the [src].")
			src.cupinside--
			var/obj/item/reagent_containers/food/drinks/coffeecup/P = new /obj/item/reagent_containers/food/drinks/coffeecup //wont be this once i put reagent stuff in
			user.put_in_hand_or_drop(P) //wont be this once i put reagent stuff in
			src.update()

	proc/update()
//		src.icon_state = "coffeepot[src.cupinside]" //i switch this over after i get icons done
		src.icon_state = "fanny"
		return

/* ===================================================== */
/* ---------------------- Cup Rack --------------------- */
/* ===================================================== */
/obj/cup_rack
	name = "coffee cup rack"
	desc = "It's a rack to hang your fancy coffee cups." //*tip
	icon = 'icons/obj/foodNdrink/zecoffee.dmi'
	icon_state = "cuprack7" //changes based cup_ammount
	var/cup_amount = 7
	var/contained_cup = /obj/item/reagent_containers/food/drinks/coffeecup
	var/contained_cup_name = "coffee cup"

	get_desc(dist, mob/user)
		if (dist <= 2)
			. += "There's [(src.cup_amount > 0) ? src.cup_amount : "no" ] [src.contained_cup_name][s_es(src.cup_amount)] in \the [src]."

	attackby(obj/item/W as obj, mob/user as mob)
		if (istype(W, src.contained_cup) & src.cup_amount < 6)
			user.drop_item()
			qdel(W)
			src.cup_amount ++
			boutput(user, "You place \the [src.contained_cup_name] back into \the [src].")
			src.updateicon()
		else return ..()

	attack_hand(mob/user as mob)
		src.add_fingerprint(user)
		if (src.cup_amount <= 0)
			user.show_text("\The [src] doesn't have any cups left, doofus!", "red")
		else
			boutput(user, "You take \an [src.contained_cup_name] out of \the [src].")
			src.cup_amount--
			var/obj/item/reagent_containers/food/drinks/coffeecup/P = new /obj/item/reagent_containers/food/drinks/coffeecup
			user.put_in_hand_or_drop(P)
			src.updateicon()

	proc/updateicon()
		src.icon_state = "cuprack[src.cup_amount]" //sets the icon_state to the ammount of cups on the rack
		return