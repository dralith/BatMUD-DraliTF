;;
;; DraliTF modules/guild/mage.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    BCgreen
/def -mregexp -t'[T|t]iny leather bag' MAGE_rleather = /set str=%*%;/substitute -p %{str} (@{BCgreen}Aura of wind@{n})
/def -mregexp -t'[S|s]tone cube' MAGE_rstone = /set str=%*%;/substitute -p %{str} (@{BCgreen}Acid shield@{n})
/def -mregexp -t'[G|g]rey fur triangle' MAGE_rfur = /set str=%*%;/substitute -p %{str} (@{BCgreen}Frost shield@{n})
/def -mregexp -t'[S|s]mall glass cone' MAGE_rglass = /set str=%*%;/substitute -p %{str} (@{BCgreen}Flame shield@{n})
/def -mregexp -t'[S|s]mall iron rod' MAGE_riron = /set str=%*%;/substitute -p %{str} (@{BCgreen}Lightning shield@{n})
/def -mregexp -t'[Q|q]uartz prism' MAGE_rquartz = /set str=%*%;/substitute -p %{str} (@{BCgreen}Repulsor aura@{n})
/def -mregexp -t'[S|s]mall highsteel disc' MAGE_rhighsteel = /set str=%*%;/substitute -p %{str} (@{BCgreen}Armour of aether@{n})
/def -mregexp -t'[T|t]iny amethyst crystal' MAGE_ramethyst = /set str=%*%;/substitute -p %{str} (@{BCgreen}Shield of detoxifiction@{n})
;;    Cred
/def -mregexp -t'[B|b]ronze marble' MAGE_rbronze = /set str=%*%;/substitute -p %{str} (@{Cred}Blast vacuum@{n})
/def -mregexp -t'[O|o]livine powder' MAGE_rolivine = /set str=%*%;/substitute -p %{str} (@{Cred}Acid Blast@{n})
/def -mregexp -t'[S|s]teel arrowhead' MAGE_rsteel = /set str=%*%;/substitute -p %{str} (@{Cred}Cold ray@{n})
/def -mregexp -t'[G|g]ranite sphere' MAGE_rgranite = /set str=%*%;/substitute -p %{str} (@{Cred}Lava blast@{n})
/def -mregexp -t'[pieces|piece] of electrum wire' MAGE_relectrum = /set str=%*%;/substitute -p %{str} (@{Cred}Electrocution@{n})
/def -mregexp -t'[C|c]opper rod' MAGE_rcopper = /set str=%*%;/substitute -p %{str} (@{Cred}Golden arrow@{n})
/def -mregexp -t'[S|s]ilvery bark chip' MAGE_rmallorn = /set str=%*%;/substitute -p %{str} (@{Cred}Summon carnal spores@{n})
;;    BCred
/def -mregexp -t'[S|s]mall brass fan' MAGE_rbrass = /set str=%*%;/substitute -p %{str} (@{BCred}Vacuum globe@{n})
/def -mregexp -t'[B|b]loodstone rings' MAGE_rbloodstone = /set str=%*%;/substitute -p %{str} (@{BCred}Acid storm@{n})
/def -mregexp -t'[H|h]andful of onyx gravel' MAGE_ronyx = /set str=%*%;/substitute -p %{str} (@{BCred}Hailstorm@{n})
/def -mregexp -t'[b|B]lue cobalt cup' MAGE_rcobalt = /set str=%*%;/substitute -p %{str} (@{BCred}Lava storm@{n})
/def -mregexp -t'[T|t]ungsten wires' MAGE_rtungsten = /set str=%*%;/substitute -p %{str} (@{BCred}Lightning storm@{n})
/def -mregexp -t'[T|t]iny platinum hammer' MAGE_rplatinum = /set str=%*%;/substitute -p %{str} (@{BCred}Magic eruption@{n})
/def -mregexp -t'[E|e]bony tube' MAGE_rebony = /set str=%*%;/substitute -p %{str} (@{BCred}Killing cloud@{n})


/COMMAND_register_i	 -n'fabs'		-m'mage'	-a"cast 'force absorption' \$*;party report [FAbs->\$*]"
/COMMAND_register_i	 -n'mirrors'	-m'mage'	-a"cast 'mirror image' \$*;party report [Mirrors->\$*]"
/COMMAND_register_i	 -n'mbar'		-m'mage'	-a"cast 'mana barrier';party report [Mana Barrier->Me]"

/COMMAND_register_i	 -n'ww'			-m'mage'	-a"cast 'water walking' \$*;party report [WW->\$*]"
/COMMAND_register_i	 -n'float'		-m'mage'	-a"cast 'floating' \$*;party report [Floating->\$*]"
/COMMAND_register_i	 -n'invis'		-m'mage'	-a"cast 'invisibility' \$*;party report [Invis->\$*]"
/COMMAND_register_i	 -n'cinvis'		-m'mage'	-a"cast 'see invisible' \$*;party report [See Invis->\$*]"
/COMMAND_register_i	 -n'cmagic'		-m'mage'	-a"cast 'see magic' \$*;party report [See Magic->\$*]"

/COMMAND_register_i	 -n'identify'	-m'mage'	-a"cast 'identify' \$*;party report [Identify->\$*]"

/COMMAND_register_i	 -n'twe'		-m'mage'	-a"cast 'teleport with error';party report [Going Home, Maybe?]"
/COMMAND_register_i	 -n'twoe'		-m'mage'	-a"cast 'teleport without error';party report [Going Home]"
/COMMAND_register_i	 -n'reloc'		-m'mage'	-a"cast 'relocate' \$*;party report [Reloc->\$*]"

/COMMAND_register_i	 -n'heals'		-m'mage'	-a"cast 'heal self'"

/COMMAND_register_i	 -n'cold1'		-m'mage'	-a"cast 'chill touch' \$*"
/COMMAND_register_i	 -n'acid1'		-m'mage'	-a"cast 'disruption' \$*"
/COMMAND_register_i	 -n'fire1'		-m'mage'	-a"cast 'flame arrow' \$*"
/COMMAND_register_i	 -n'mana1'		-m'mage'	-a"cast 'magic missile' \$*"
/COMMAND_register_i	 -n'elec1'		-m'mage'	-a"cast 'shocking grasp' \$*"
/COMMAND_register_i	 -n'pois1'		-m'mage'	-a"cast 'thorn spray' \$*"
/COMMAND_register_i	 -n'asph1'		-m'mage'	-a"cast 'vacuumbolt' \$*"

/COMMAND_register_i	 -n'prisma'		-m'mage'	-a"cast 'prismatic burst' \$*"

/def unload_riftwalker_module = \
    /COMMAND_cleanup mage
