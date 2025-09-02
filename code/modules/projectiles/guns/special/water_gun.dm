/obj/item/gun/water
	name = "water gun"
	desc = "A Foam Force Super Soaker. Intended for children aged 6 and up."
	icon_state = "chemgun"
	inhand_icon_state = "chemgun"
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 3
	throw_range = 7
	force = 4
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT)
	clumsy_check = FALSE
	fire_sound = 'sound/effects/spray2.ogg'

/obj/item/gun/water/Initialize(mapload)
	. = ..()
	chambered = new /obj/item/ammo_casing/water_gun(src)
	create_reagents(90, OPENCONTAINER)

/obj/item/gun/water/can_shoot()
	return reagents.total_volume > 0

/obj/item/gun/water/handle_chamber()
	if(chambered && !chambered.loaded_projectile)
		chambered.newshot()
