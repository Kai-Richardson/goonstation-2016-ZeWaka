fooddrink/coffee/espresso/latte // 5:1 milk:espresso
  name = "latte"
  id = "latte"
  description = "A latte is a type of espresso that has a bit of steamed milk."
  fluid_r = 73
  fluid_g = 52
  fluid_b = 29

  on_mob_life(var/mob/M)
    M.reagents.add_reagent("milk", 5)
    ..(M)

fooddrink/coffee/espresso/cappuchino // 1:1:1 milk foam:milk:espresso
  name = "cappuchino"
  id = "cappuchino"
  description = "A cappuchino is a type of espresso that has a bit of steamed milk and foam."
  fluid_r = 92
  fluid_g = 65
  fluid_b = 26

  on_mob_life(var/mob/M)
    M.reagents.add_reagent("milk", 1)
    ..(M)

fooddrink/coffee/espresso/mocha // 3:3:1 espresso:chocolate:milk
  name = "mocha"
  id = "mocha"
  description = "A mocha is a type of espresso that has a bunch of chocolate and milk."
  fluid_r = 61
  fluid_g = 39
  fluid_b = 15

  on_mob_life(var/mob/M)
    M.reagents.add_reagent("chocolate", 1)
    M.reagents.add_reagent("milk", 0.3)
    ..(M)