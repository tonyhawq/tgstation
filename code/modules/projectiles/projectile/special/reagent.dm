/obj/projectile/reagent_splurt
	icon_state = null
	hitscan = TRUE
	muzzle_type = /obj/effect/projectile/muzzle/laser/emitter
	tracer_type = /obj/effect/projectile/tracer/laser/emitter
	impact_type = /obj/effect/projectile/impact/laser/emitter
	impact_effect_type = null
	hitscan_light_intensity = 0
	hitscan_light_range = 0
	muzzle_flash_intensity = 0
	muzzle_flash_range = 0
	impact_light_intensity = 0
	impact_light_range = 0
	damage = 0
	range = 4

/obj/projectile/reagent_splurt/Initialize(mapload)
	. = ..()
	create_reagents(2.5, NONE)

/obj/projectile/reagent_splurt/proc/splash(atom/target)
	reagents.expose(target, TOUCH)
	playsound(target, 'sound/effects/slosh.ogg', 25, TRUE)
	SEND_SIGNAL(target, COMSIG_ATOM_SPLASHED)
	var/mutable_appearance/splash_animation = mutable_appearance('icons/effects/effects.dmi', "splash")
	if(isturf(target))
		splash_animation.icon_state = "splash_floor"
	splash_animation.color = mix_color_from_reagents(reagents.reagent_list)
	target.flick_overlay_view(splash_animation, 1 SECONDS)

/obj/projectile/reagent_splurt/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	splash(target)

/obj/projectile/reagent_splurt/reduce_range()
	if (range == 1 && loc)
		splash(loc)
	. = ..()
// todo: move to ammunition / make it not require a bullet

/obj/item/ammo_casing/water_gun
	name = "water gun pump"
	desc = "Trigger actuated water pump."
	slot_flags = null
	projectile_type = /obj/projectile/reagent_splurt
	firing_effect_type = null

/obj/item/ammo_casing/water_gun/Initialize(mapload)
	. = ..()

/obj/item/ammo_casing/water_gun/ready_proj(atom/target, mob/living/user, quiet, zone_override = "")
	if(!loaded_projectile)
		return ..()
	if (!loc.reagents)
		return ..()

	loc.reagents.trans_to(loaded_projectile, 2.5)
	return ..()
