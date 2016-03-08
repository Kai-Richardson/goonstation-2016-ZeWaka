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
/obj/coffee_machines/espresso //sorry about the frankencode
	name = "espresso machine"
	desc = "It's top of the line NanoTrasen espresso technology! Featuring 100% Organic Locally-Grown espresso beans!" //haha no
	icon = 'icons/obj/foodNdrink/zecoffee.dmi'
	icon_state = "syndie" //no no no
	var/lcup_amount = 6
	var/contained_cup = /obj/item/reagent_containers/food/drinks/lattecup
	var/contained_cup_name = "latte cup"

	get_desc(dist, mob/user)
		if (dist <= 1)
			. += "There's [(src.lcup_amount > 0) ? src.lcup_amount : "no" ] [src.contained_cup_name][s_es(src.lcup_amount)] in \the [src]."
		if (dist <= 2 && reagents)
			. += "<br><span style=\"color:blue\">[reagents.get_description(user,RC_SCALE)]</span>" //does not show amnt of reagents if you are more than 2 tiles away

	attackby(obj/item/W as obj, mob/user as mob)
		if (istype(W, src.contained_cup) & src.lcup_amount < 6)
			user.drop_item()
			qdel(W)
			src.lcup_amount ++
			boutput(user, "You place \the [src.contained_cup_name] back into \the [src].")
			src.update()
		else return ..()

	attack_hand(mob/user as mob)
		src.add_fingerprint(user)
		if (src.lcup_amount <= 0)
			user.show_text("\The [src] doesn't have any cups left, doofus!", "red")
		else
			boutput(user, "You take \an [src.contained_cup_name] out of \the [src].")
			src.lcup_amount--
			var/obj/item/reagent_containers/food/drinks/lattecup/P = new /obj/item/reagent_containers/food/drinks/lattecup
			user.put_in_hand_or_drop(P)
			src.update()

	proc/update()
//		src.icon_state = "coffeepot[src.lcup_amount]"
		src.icon_state = "fanny"
		return