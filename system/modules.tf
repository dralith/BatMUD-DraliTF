;;
;; DraliTF system/modules.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/eval /load -q %{TF_DIR}/saves/modules.tf

/set module_list=

/def reg_module = \
	/if (!getopts("i:n:f:r:","")) /d_error Invalid module definition!%;/break%;/endif%; \
	/set module_list=%{module_list} %{opt_i}%; \
	/set module_%{opt_i}_name=%{opt_n}%; \
	/set module_%{opt_i}_reco=%{opt_r}%; \
	/set module_%{opt_i}_file=%{opt_f}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/reg_module -i"ars"			-n"Automated Response System"	-f"modules/ars.tf"			-r""
/reg_module -i"counter"		-n"Counter Tracking System"		-f"modules/count.tf"		-r""
/reg_module -i"default"		-n"Default Bat Triggers"		-f"modules/default.tf"		-r"status"
/reg_module -i"gags"		-n"Gag Module"					-f"modules/gags.tf"			-r""
/reg_module -i"keybinds"	-n"Keybindings Module"			-f"modules/keybinds.tf"		-r""
/reg_module -i"lites"		-n"Lites Module"				-f"modules/lites.tf"		-r""
/reg_module -i"mine"		-n"Personal Triggers"		    -f"modules/mine.tf"			-r""
/reg_module -i"party"		-n"Party Status Liting Module"	-f"modules/party.tf"		-r""
/reg_module -i"prots"		-n"Prot Tracking System"		-f"modules/prots.tf"		-r""
/reg_module -i"status"		-n"Status Line Module"			-f"modules/status.tf"		-r""
/reg_module -i"chest"		-n"Chests Module"				-f"modules/chest.tf"		-r""
/reg_module -i"realm_map" -n"Realm Map Module"		-f"modules/realm_map.tf" -r""
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Other player's triggers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/reg_module -i"complete"	-n"Tab Completion"				-f"modules/misc/complete.tf"		-r""
/reg_module -i"note"		-n"Client-Side Notebook Module"	-f"modules/misc/note.tf"			-r""
/reg_module -i"spelltrans"	-n"Spell Translation Module"	-f"modules/misc/spell_trans.tf"	-r""
/reg_module -i"autocruise"	-n"Hair's Auto-Cruise Module"	-f"modules/utility/autocruise.tf"	-r""
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Play-style modules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/reg_module -i"blaster"		-n"Basic Blaster Module"		-f"modules/basic/blaster.tf"	-r"caster"
/reg_module -i"caster"		-n"Basic Caster Module"			-f"modules/basic/caster.tf"		-r""
/reg_module -i"tank"		-n"Basic Tank Module"			-f"modules/basic/tank.tf"		-r""
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Guild module definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/reg_module -i"alchemists"	-n"Alchemists Guild Triggers"	-f"modules/guild/alchemist.tf"	-r""
/reg_module -i"animist"		-n"Animist Guild Triggers"		-f"modules/guild/animist.tf"		-r""
/reg_module -i"barb"		-n"Barbarian Guild Triggers"	-f"modules/guild/barbarian.tf"	-r"tank"
/reg_module -i"bmaster"		-n"Beastmaster Guild Triggers"	-f"modules/guild/beastmaster.tf"	-r"tank"
/reg_module -i"bard"		-n"Bard Guild Triggers"			-f"modules/guild/bard.tf"		-r"blaster"
/reg_module -i"chan"		-n"Channeller Guild Triggers"	-f"modules/guild/channeller.tf"	-r"blaster status"
/reg_module -i"crimson"		-n"Crimson Guild Triggers"		-f"modules/guild/crimson.tf"	-r"status"
/reg_module -i"druid"		-n"Druid Guild Triggers"		-f"modules/guild/druids.tf"		-r"blaster"
/reg_module -i"disciple"    -n"Disciple Guild Triggers"     -f"modules/guild/loc.tf"        -r""
/reg_module -i"kharim"      -n"Kharim Guild Triggers"       -f"modules/guild/kharim.tf"     -r"disciple"
/reg_module -i"mage"        -n"Mage Guild Triggers"         -f"modules/guild/mage.tf"       -r"blaster"
/reg_module -i"merchant"	-n"Merchant Guild Triggers"		-f"modules/guild/merchant.tf"	-r"merchant"
/reg_module -i"ranger"		-n"Ranger Guild Triggers"		-f"modules/guild/ranger.tf"		-r"tank"
/reg_module -i"riftwalker"  -n"Riftwalker Guild Triggers"   -f"modules/guild/riftwalker.tf" -r"blaster"
/reg_module -i"sailor"		-n"Sailor Guild Triggers"		-f"modules/guild/sailor.tf"		-r""
/reg_module -i"tarmalen"		-n"Tarmalen Guild Triggers"		-f"modules/guild/tarmalen.tf"		-r"caster"
/reg_module -i"tiger"		-n"Tiger Guild Triggers"		-f"modules/guild/tiger.tf"		-r"tank"


/def init_modules = \
    /mapcar /mload %{modules}

/def mod = \
	/modules %{*}

/def mload = \
	/modules load %{*}

/def munload = \
	/modules unload %{*}

/def mlist = \
	/modules list

/def modules = \
	/if (%{1} =~ "list") \
		/if ($(/length %{modules}) >= 1) \
			/echo -aBCcyan [TF]: Loaded Modules:%; \
			/echo -aCcyan  [TF]:      %{modules}%; \
		/else \
			/d_warn No modules loaded.%; \
		/endif%; \
	/endif%; \
	/if (%{1} =~ "help") \
		/echo    %; \
		/echo -p /mod, /module%; \
		/echo -p @{B}  @{n}Usage:%; \
		/echo -p @{B}          /mod <options>@{n}%; \
		/echo -p @{B}          /module <options>@{n}%; \
		/echo -p @{B}  @{n}____________________________________________________________________________%; \
		/echo    %; \
		/echo -p @{B}  @{n}Options:%; \
		/echo -p @{B}          help@{n}                 - This help file.%; \
		/echo -p @{B}          all@{n}                  - List all available modules.%; \
		/echo -p @{B}          list@{n}                 - List all loaded modules.%; \
		/echo -p @{B}          load <module name>@{n}   - Load module <module name>.%; \
		/echo -p @{B}          unload <module name>@{n} - Unload module and all related settings.%; \
		/echo    %; \
		/echo -p @{B}  @{n}Aliases:%; \
		/echo -p @{B}          /mload@{n}               - /module load%; \
		/echo -p @{B}          /munload@{n}             - /module unload%; \
		/echo -p @{B}          /mlist@{n}               - /module list%; \
		/echo    %; \
	/endif%; \
	/if (%{1} =~ "all") \
		/let mlen=$(/length %{module_list})%; \
		/let mi=1%; \
		/if (%{mlen} >= 1) \
			/echo -p [TF]: ,--------------------------------------------------------------------------.%; \
			/echo -p [TF]: | @{B}$[pad("Full Name:",-30)]@{n} \(@{B}$[pad("Name:",-10)]@{n}\) @{B}Recommended Modules:@{n}         |%; \
			/echo -p [TF]: |--------------------------------------------------------------------------|%; \
			/while (%{mi} <= %{mlen}) \
				/let mmod=$(/nth %{mi} %{module_list})%; \
				/eval /set mname=%%{module_%{mmod}_name}%; \
				/eval /set mrec=%%{module_%{mmod}_reco}%; \
				/eval /set mname=%{mname}%; \
				/eval /set mrec=%{mrec}%; \
				/echo -p [TF]: | @{BCcyan}$[pad(%{mname},-30)]@{n} \(@{BCyellow}$[pad(%{mmod},10)]@{n}\) @{B}$[pad(%{mrec},-28)]@{n} |%; \
				/let mi=$[%{mi}+1]%; \
			/done%; \
			/echo -p [TF]: `--------------------------------------------------------------------------'%; \
		/else \
			/d_error No modules available. Why did you remove all the modules?%; \
		/endif%; \
	/endif%; \
	/if (%{1} =~ "load") \
		/if ($(/member_array %{-1} %{module_list}) > 0) \
			/eval /load -q %{TF_DIR}/%%{module_%{-1}_file}%; \
			/set modules=%{modules} %{-1}%; \
			/d_pass Module [%%{module_%{-1}_name}] loaded.%; \
			/save_modules%; \
		/else \
			/set modules=$(/remove %{-1} %{modules})%; \
			/save_modules%; \
			/d_error Failed to load module [%{-1}].%; \
		/endif%; \
	/endif%; \
	/if (%{1} =~ "unload") \
		/if ($(/member_array %{-1} %{modules}) > 0) \
			/set modules=$(/remove %{-1} %{modules})%; \
			/unload_%{-1}_module%; \
			/d_error Module [%%{module_%{-1}_name}] unloaded.%; \
			/save_modules%; \
		/else \
			/d_error Failed to unload module [%{-1}].%; \
		/endif%; \
	/endif%; \
	/if (%{1} =~ "") \
		/d_warn Syntax: /mod(ules) <help|all|list|load [module name]|unload [module name]>%; \
	/endif

/def save_modules = \
    /set modules=$(/unique %{modules})%; \
	/let striim= $[tfopen(strcat(%{TF_DIR},"/saves/modules.tf"),"w")]%; \
	/test $[tfwrite(striim,strcat("/set modules=",modules,""))]%; \
	/test $[tfclose(striim)]
