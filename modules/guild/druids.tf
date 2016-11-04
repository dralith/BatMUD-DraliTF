;;
;; DraliTF modules/guild/druids.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -mregexp -F -t'^shedding an eerie ([a-z]+) light\.\$' DRUIDS_staff_charge = \
    /set staff_charge=%{P1}

/def -mregexp -F -t'^Shimi          ([0-9 ]+)\$' DRUIDS_pool_totals = \
    /set pool_charge=%{P1}

/def unload_druid_module = \
    /purge -mregexp DRUIDS_.*%; \
    /COMMAND_cleanup druids

/COMMAND_register_i	 -n"chst" 	 -m"druids"	 -a"cast 'charge staff' amount \$*"
/COMMAND_register_i	 -n"dpool"	 -m"druids"	 -a"cast 'drain pool' amount \$*;pr [Draining Pool:\$*]"
/COMMAND_register_i	 -n"xmana"	 -m"druids"	 -a"cast 'transfer mana' \$1 amount \$2;pr [Giving \$2sp:\$1]"
/COMMAND_register_i	 -n"reple"	 -m"druids"	 -a"cast 'replenish energy' \$1 amount \$2;pr [Giving \$2ep:\$1];get mistletoe from frame;keep mistletoe"
/COMMAND_register_i	 -n"eblod"	 -m"druids"	 -a"cast 'earth blood' \$*;pr [EBlood:\$*]"
/COMMAND_register_i	 -n"epowr"	 -m"druids"	 -a"cast 'earth power' \$*;pr [EPower:\$*]"
/COMMAND_register_i	 -n"eskin"	 -m"druids"	 -a"cast 'earth skin' \$*;pr [ESkin:\$*]"
/COMMAND_register_i	 -n"flexs"	 -m"druids"	 -a"cast 'flex shield' \$*;pr [Flex:\$*]"
/COMMAND_register_i	 -n"vines"	 -m"druids"	 -a"cast 'vine mantle' \$*;pr [Vines:\$*]"
/COMMAND_register_i	 -n"regen"	 -m"druids"	 -a"cast 'regeneration' \$*;pr [Regen:\$*]"
/COMMAND_register_i	 -n"wf"   	 -m"druids"	 -a"cast 'wither flesh' \$*;pr [Wither:\$*]"
/COMMAND_register_i	 -n"qu"   	 -m"druids"	 -a"cast 'earthquake' \$*;pr [Quaking]"
/COMMAND_register_i	 -n"gf"   	 -m"druids"	 -a"cast 'gem fire' use \$*;pr [GemFire:\$-1]"
/COMMAND_register_i	 -n"hf"   	 -m"druids"	 -a"cast 'hoar frost' \$*;pr [HFrost:\$*]"
/COMMAND_register_i	 -n"sl"   	 -m"druids"	 -a"cast 'star light' \$*;pr [StarLight:\$*]"
/COMMAND_register_i	 -n"cm"   	 -m"druids"	 -a"cast 'create mud' \$*;pr [Pitting:\$*]"
/COMMAND_register_i	 -n"i2ahm"	 -m"druids"	 -a"cast 'inquiry to ahm' \$*"
/COMMAND_register_i	 -n"reinc"	 -m"druids"	 -a"cast 'reincarnation' \$*;tell \$* Casting reinc"
/COMMAND_register_i	 -n"rain"  	 -m"druids"	 -a"cast 'rain';pr [Rain]"
/COMMAND_register_i	 -n"wind"	   -m"druids"	 -a"cast 'drying wind';pr [Wind]"
/COMMAND_register_i	 -n"infra"	 -m"druids"	 -a"cast 'infravision' \$*;pr [Infra:\$*]"
/COMMAND_register_i	 -n"cinvi"	 -m"druids"	 -a"cast 'see invisible' \$*;pr [See Invis:\$*]"
/COMMAND_register_i	 -n"wwalk"	 -m"druids"	 -a"cast 'water walking' \$*;pr [WW:\$*]"
/COMMAND_register_i	 -n"resto"	 -m"druids"	 -a"cast 'restore' \$*;pr [Restore:\$*]"
