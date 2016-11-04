;;
;; DraliTF utility/autocruise.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Stolen from Hair and massively overhauled.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set cont_switch=0

/DEF -ag -h"send {autocruise}*" AUTOCRUISE_cmd = \
	/eval /set ac_tmp=$(/check_location %{-1})%; \
	/IF (%{ac_tmp} !~ "") \
		/SET ac_coords=$(/nth 2 %{ac_tmp})%; \
		/SET ac_loc=$(/nth 1 %{ac_tmp})%; \
		/SET ac_cont=$(/nth 3 %{ac_tmp})%; \
	/ELSE \
		/SET ac_coords=%{-1}%; \
		/SET ac_loc=coords%; \
	/ENDIF%; \
	/IF (regmatch("^([0-9]*)x([0-9]*)y$", %{ac_coords} ) ) \
		/SET ship_autocruise=1 %; \
		/SET ac_flag=1 %; \
		/SET ac_destx=%{P1} %; \
		/SET ac_desty=%{P2} %; \
		/SEND @whereami %; \
	/ELSE /ECHO -aCbgyellow,Cblack *** Usage:  autocruise 123x123y *** %; \
	/ENDIF

/set laen_to_luce=
/set laen_to_roth=300x360y 250x310y 250x70y 31010y 734x10y cruise_838_ne
/set laen_to_deso=
/set laen_to_furn=300x360y cruise_155_sw 145x700y 205x760y cruise_628_e cruise_425_se 189x81y

;7954,10549 lucentium_ferry
;7954,9090 laenor-lucentium
;9591,9427 furn-ferry 189x81y
;9500,9427 furn1 98x81y
;9025,8952 laenor-furn
;8397,8952 laenor7 205x760y
;8337,8892 laenor8 145x700y
;8337,8707 laenor9
;8492,8552 laenor-ferry 300x360y
;8442,9502 laenor1 250x310y
;8442,8262 laenor2 250x70y
;8502,8202 laenor3 310x10y
;8926,8202 laenor10 734x10y
;7964,7364 roth-ferry 262x428y

;7558,10153 deso-luce2
;7558,9486 deso-luce1
;7443,9486 deso_3
/set luce_to_laen=397x13y cruise_1459_n cruise_383_ne 300x360y
/set luce_to_roth=397x13y cruise_1459_n cruise_383_ne 300x360y 250x310y 250x70y 31010y 734x10y cruise_838_ne
/set luce_to_deso=397x13y cruise_396_nw cruise_667_n cruise_115_w 432x445y
/set luce_to_furn=397x13y cruise_1459_n cruise_383_ne 145x700y 205x760y cruise_628_e cruise_425_se 189x81y

/set roth_to_laen=
/set roth_to_deso=
/set roth_to_furn=
/set roth_to_luce=

/set deso_to_laen=
/set deso_to_furn=
/set deso_to_roth=
/set deso_to_luce=

/set furn_to_laen=
/set furn_to_deso=
/set furn_to_roth=
/set furn_to_luce=

/DEF -F -mregexp -ag -t"^You are in (.*) on the continent of ([A-Za-z]+)\. \(Coordinates\: ([0-9]*)x, ([0-9]*)y" AUTOCRUISE_get_coordinates = \
	/IF (%{ship_autocruise} == 1) \
		/IF (%{ac_loc} !~ "coords") \
			/EVAL /SET cr_cont=$[tolower(substr(%{P2},0,4))]%; \
			/IF (%{cr_cont} !~ %{ac_cont}) \
				/if (%{cont_switch} > 0) \
					/echo Doing nothing mid cruise%; \
					/return%; \
				/elseif (%{cont_switch} < 0) \
					/echo Going to the next set of coords%; \
					/AUTOCRUISE_start%; \
					/return%; \
				/else \
					/eval /echo %{cr_cont} != %{ac_cont}%; \
					/set cont_switch=1%; \
					/eval /set ac_path=%%{%{cr_cont}_to_%{ac_cont}} %{ac_coords}%; \
				/endif%; \
			/ENDIF%; \
		/ENDIF%; \
		/SET ship_xcoord=%{P3} %; \
		/SET ship_ycoord=%{P4} %; \
		/AUTOCRUISE_start %; \
	/ENDIF

/DEF AUTOCRUISE_start = \
	/SET ship_autocruise=0 %; \
	/IF ($(/length %{ac_path}) > 0) \
		/LET ac_next_dest=$(/car %{ac_path})%; \
		/set ac_path=$(/cdr %{ac_path})%; \
		/IF (regmatch("^([0-9]*)x([0-9]*)y$", %{ac_next_dest} ) ) \
			/SET ac_flag=1 %; \
			/SET ac_destx=%{P1} %; \
			/SET ac_desty=%{P2} %; \
		/ELSE \
			/SEND $(/eval /replace _   %{ac_next_dest})%; \
		/ENDIF%; \
	/ENDIF%; \
	/LET ac_xdiff=$[%{ac_destx}-%{ship_xcoord}] %; \
	/LET ac_ydiff=$[%{ac_desty}-%{ship_ycoord}] %; \
	/IF (%{ac_xdiff} < 0) /SET ac_xdir=west %; \
	/ELSEIF (%{ac_xdiff} > 0) /SET ac_xdir=east %; \
	/ELSEIF (%{ac_xdiff} == 0) /SET ac_xdir=nil %; \
	/ENDIF %; \
	/IF (%{ac_ydiff} < 0) /SET ac_ydir=north %; \
	/ELSEIF (%{ac_ydiff} > 0) /SET ac_ydir=south %; \
	/ELSEIF (%{ac_ydiff} == 0) /SET ac_ydir=nil %; \
	/ENDIF %; \
	/LET ac_xdiff=$[abs(%{ac_xdiff})] %; \
	/LET ac_ydiff=$[abs(%{ac_ydiff})] %; \
	/IF (%{ac_xdir} =~ "nil") \
		/IF (%{ac_ydir} =~ "nil") \
			/SET ship_autocruise=0 %; \
		/ELSE /SEND @cruise %{ac_ydiff} %{ac_ydir} %; \
		/ENDIF %; \
	/ELSEIF (%{ac_ydir} =~ "nil") \
		/IF (%{ac_xdir} =~ "nil") \
			/SET ship_autocruise=0 %; \
		/ELSE /SEND @cruise %{ac_xdiff} %{ac_xdir} %; \
		/ENDIF %; \
	/ELSEIF (%{ac_xdiff} > %{ac_ydiff}) \
		/SET ship_autocruise=1 %; \
		/SEND @cruise %{ac_ydiff} %{ac_ydir}%{ac_xdir} %; \
	/ELSEIF (%{ac_ydiff} > %{ac_xdiff}) \
		/SET ship_autocruise=1 %; \
		/SEND @cruise %{ac_xdiff} %{ac_ydir}%{ac_xdir} %; \
	/ENDIF

/DEF -mregexp -ag -t"(.*) tells you \'We\'ve gon\' as far towards ([a-z]*) as ask\'d, (.*).\'$" AUTOCRUISE_continue = \
	/IF (%{ship_autocruise} == 1) \
		/SEND @whereami %; \
	/ELSE /ECHO %{P0} %; \
	/ENDIF %; \
	/IF (%{ac_flag} == 1 & %{ship_autocruise} == 0) \
		/ECHO -aCbgyellow,Cblack *** Autocruise Complete *** %; \
		/SET ac_flag=0 %; \
	/ENDIF

/DEF -mregexp -t"(.*) whispers to you \'I din\'nae think we\'ll get verra far wit\' tha anchor down.\'$" AUTOCRUISE_anchored = \
	/IF (%{ship_autocruise} == 1) \
		/SEND @ship launch %; \
		/SEND @whereami %; \
	/ENDIF

/DEF -mregexp -t"(.*) tells you \'We\'ve can\'nae go ena more towards (.*).\'$" AUTOCRUISE_terrain_block = \
	/SET ship_autocruise=0 %; \
	/SET ac_flag=0 %; \
	/ECHO -aCbgyellow,Cblack *** Autocruise Aborted.  Cannot clear terrain ***

/def check_location = \
	/set res=0%; \
	/set res=$(/member_array %{1} %{aclist_area_names})%; \
	/set cr_type=area%; \
	/if (%{res} == 0) \
		/set res=$(/member_array %{1} %{aclist_mobs_names})%; \
		/set cr_type=mobs%; \
	/endif%; /if (%{res} == 0) \
		/set res=$(/member_array %{1} %{aclist_pcity_names})%; \
		/set cr_type=pcity%; \
	/endif%; /if (%{res} == 0) \
		/set res=$(/member_array %{1} %{aclist_city_names})%; \
		/set cr_type=city%; \
	/endif%; /if (%{res} == 0) \
		/set res=$(/member_array %{1} %{aclist_shrine_names})%; \
		/set cr_type=shrine%; \
	/endif%; /if (%{res} == 0) \
		/set res=$(/member_array %{1} %{aclist_ferry_names})%; \
		/set cr_type=ferry%; \
	/endif%; /if (%{res} == 0) \
		/set res=$(/member_array %{1} %{aclist_guild_names})%; \
		/set cr_type=guild%; \
	/endif%; /if (%{res} == 0) \
		/set res=$(/member_array %{1} %{aclist_trainer_names})%; \
		/set cr_type=trainer%; \
	/endif%; \
	/if (%{res} > 0) \
	  /result "%{1} $(/eval /nth %{res} %%{aclist_%{cr_type}_coords}) $(/eval /nth %{res} %%{aclist_%{cr_type}_conts})"%; \
	/endif

/def list_location = \
  /let in_list=$(/eval /member_array %{1} %{ac_conts_list})%; \
	/if (%{in_list} == 0) \
	  /d_error No such continent [%{1}].%; \
		/return%; \
	/endif%; \
	/let in_list=$(/eval /member_array %{2} %{ac_types_list})%; \
	/if (%{in_list} == 0) \
	  /d_error No such location type [%{2}].%; \
		/return%; \
	/endif%; \
	/set ml=$(/eval /length %%{aclist_%{2}_names})%; \
	/set mi=1%; \
	/while (%{mi} <= %{ml}) \
	  /let on_cont=$(/eval /nth %{mi} %%{aclist_%{2}_conts})%; \
;		/eval /echo %{on_cont} == %{1}%; \
		/if (%{on_cont} =~ %{1}) \
			/echo $(/eval /nth %{mi} %%{aclist_%{2}_names})%; \
		/endif%; \
		/set mi=$[%{mi}+1]%; \
	/done

/def reg_location = \
	/if (!getopts("t:c:d:n:a:","")) \
		/d_error Invalid module definition!%; \
		/break%; \
	/endif%; \
	/set ml=$(/length %{opt_n})%; \
	/set mi=1%; \
	/while (%{mi} <= %{ml}) \
		/if ($(/member_array %{opt_t} %{ac_types_list}) <= 0) \
			/eval /set ac_types_list=%{opt_t} %{ac_types_list}%; \
		/endif%; \
		/if ($(/member_array %{opt_c} %{ac_conts_list}) <= 0) \
			/eval /set ac_conts_list=%{opt_c} %{ac_conts_list}%; \
		/endif%; \
		/set tmp_name=$(/nth %{mi} %{opt_n})%; \
		/if ($(/eval /member_array %{tmp_name} %%{aclist_%{opt_t}_names}) <= 0) \
			/eval /set aclist_%{opt_t}_names=%%{aclist_%{opt_t}_names} %{tmp_name}%; \
			/eval /set aclist_%{opt_t}_conts=%%{aclist_%{opt_t}_conts} %{opt_c}%; \
			/eval /set aclist_%{opt_t}_coords=%%{aclist_%{opt_t}_coords} %{opt_d}%; \
		/endif%; \
		/eval /set mi=$[%{mi}+1]%; \
	/done%; \
	/if (%{opt_a} != "") \
		/eval /set %{opt_n}_alert=%{opt_a}%; \
	/endif

/def unload_autocruise_module = \
	/PURGE -mregexp AUTOCRUISE_.*%; \
	/purge reg_location%; \
	/purge check_location%; \
	/purge list_location


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                  Lucentium
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                     Cities
/reg_location	-a""	-t"city"	-c"luce"	-d"413x151y"	-n"lorenchia"
/reg_location	-a""	-t"city"	-c"luce"	-d"540x239y"	-n"silver_lake"
/reg_location	-a""	-t"ferry"	-c"luce"	-d"397x15y"		-n"luce_ferry"
;;                                                              Player Cities
/reg_location	-a""	-t"pcity"	-c"luce"	-d"409x17y"		-n"breakwater"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"397x23y"		-n"kittencity"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"410x41y"		-n"kanemouke"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"405x69y"		-n"sumuland"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"402x56y"		-n"zithroland"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"415x63y"		-n"dawnhill"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"388x87y"		-n"iirimameoi"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"395x96y"		-n"twigaland"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"353x106y"	-n"moseisley"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"418x103y"	-n"inferno"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"422x90y"		-n"copenhagen"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"417x125y"	-n"actium"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"403x143y"	-n"alliance"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"426x153y"	-n"downtown"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"428x194y"	-n"norsunluutorni"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"380x159y"	-n"asimyth"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"361x147y"	-n"baron"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"337x192y"	-n"takubaz"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"350x132y"	-n"shadowdale"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"339x300y"	-n"pluto"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"342x420y"	-n"wayrest"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"254x194y"	-n"bittercape"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"242x179y"	-n"zircus"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"232x171y"	-n"carcassonne"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"261x172y"	-n"providence"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"270x188y"	-n"corfinium"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"296x176y"	-n"conquest"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"282x138y"	-n"elanthia"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"328x66y"		-n"clockwork"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"219x162y"	-n"valimar"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"143x186y"	-n"hoven"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"147x203y"	-n"illusia"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"154x328y"	-n"stormhold"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"36x199y"		-n"nekropolis"
/reg_location	-a""	-t"pcity"	-c"luce"	-d"58x136y"		-n"wildboars"
;;                                                               Race Shrines
/reg_location	-a""	-t"shrine"	-c"luce"	-d"393x194y"	-n"thrikhren"
/reg_location	-a""	-t"shrine"	-c"luce"	-d"542x456y"	-n"merfolk"
/reg_location	-a""	-t"shrine"	-c"luce"	-d"332x278y"	-n"cyclops"
/reg_location	-a""	-t"shrine"	-c"luce"	-d"316x254y"	-n"cromagnon"
/reg_location	-a""	-t"shrine"	-c"luce"	-d"241x227y"	-n"titan"
/reg_location	-a""	-t"shrine"	-c"luce"	-d"244x136y"	-n"catfolk"
/reg_location	-a""	-t"shrine"	-c"luce"	-d"255x101y"	-n"lizardman"
/reg_location	-a""	-t"shrine"	-c"luce"	-d"335x130y"	-n"satyr"
/reg_location	-a""	-t"shrine"	-c"luce"	-d"396x42y"		-n"centaur"
;;                                                                      Areas
/reg_location	-a""	-t"area"	-c"luce"	-d"411x50y"		-n"lands_of_lor"
/reg_location	-a""	-t"area"	-c"luce"	-d"392x73y"		-n"cornfields"
/reg_location	-a""	-t"area"	-c"luce"	-d"384x99y"		-n"shrea"
/reg_location	-a""	-t"area"	-c"luce"	-d"361x116y"	-n"stagira"
/reg_location	-a""	-t"area"	-c"luce"	-d"426x81y"		-n"lanzia"
/reg_location	-a""	-t"area"	-c"luce"	-d"410x92y"		-n"dahbec"
/reg_location	-a""	-t"area"	-c"luce"	-d"412x137y"	-n"public_gardens"
/reg_location	-a""	-t"area"	-c"luce"	-d"446x148y"	-n"paladin_stronghold"
/reg_location	-a""	-t"area"	-c"luce"	-d"412x204y"	-n"whirlpool"
/reg_location	-a""	-t"area"	-c"luce"	-d"431x205y"	-n"land_of_the_overworld zebells"
/reg_location	-a""	-t"area"	-c"luce"	-d"480x156y"	-n"shipwreck"
/reg_location	-a""	-t"area"	-c"luce"	-d"400x248y"	-n"door_to_the_past stifsim"
/reg_location	-a""	-t"area"	-c"luce"	-d"373x235y"	-n"marble_sanded_beach beach"
/reg_location	-a""	-t"area"	-c"luce"	-d"357x187y"	-n"clouds_above_lor rechendak"
/reg_location	-a""	-t"area"	-c"luce"	-d"336x181y"	-n"catfolk_shipyard"
/reg_location	-a""	-t"area"	-c"luce"	-d"382x151y"	-n"underdark"
/reg_location	-a""	-t"area"	-c"luce"	-d"342x140y"	-n"anthill"
/reg_location	-a""	-t"area"	-c"luce"	-d"441x278y"	-n"oystria"
/reg_location	-a""	-t"area"	-c"luce"	-d"393x482y"	-n"observatory_foyer"
/reg_location	-a""	-t"area"	-c"luce"	-d"292x268y"	-n"creepy_house"
/reg_location	-a""	-t"area"	-c"luce"	-d"243x195y"	-n"duzelton duz"
/reg_location	-a""	-t"area"	-c"luce"	-d"234x151y"	-n"catfolk_tree"
/reg_location	-a""	-t"area"	-c"luce"	-d"295x126y"	-n"astacia"
/reg_location	-a""	-t"area"	-c"luce"	-d"337x114y"	-n"satyr_forest"
/reg_location	-a""	-t"area"	-c"luce"	-d"263x59y"		-n"obelisk"
/reg_location	-a""	-t"area"	-c"luce"	-d"285x45y"		-n"iron_gate templar_shield_quest"
/reg_location	-a""	-t"area"	-c"luce"	-d"338x40y"		-n"a_tale_of_two_towers two_towers"
/reg_location	-a""	-t"area"	-c"luce"	-d"224x45y"		-n"lost_pyramid"
/reg_location	-a""	-t"area"	-c"luce"	-d"219x88y"		-n"colosseum"
/reg_location	-a""	-t"area"	-c"luce"	-d"131x195y"	-n"fraggle_village fraggles"
/reg_location	-a""	-t"area"	-c"luce"	-d"144x255y"	-n"mirror_mine"
/reg_location	-a""	-t"area"	-c"luce"	-d"196x305y"	-n"pyran"
/reg_location	-a""	-t"area"	-c"luce"	-d"123x288y"	-n"earth_tower"
/reg_location	-a""	-t"area"	-c"luce"	-d"120x291y"	-n"ice_tower"
/reg_location	-a""	-t"area"	-c"luce"	-d"126x291y"	-n"fire_tower"
/reg_location	-a""	-t"area"	-c"luce"	-d"123x294y"	-n"wind_tower"
/reg_location	-a""	-t"area"	-c"luce"	-d"147x374y"	-n"brotherhood_of_sorcery adachain"
/reg_location	-a""	-t"area"	-c"luce"	-d"87x257y"		-n"troglodyte_village troglodytes"
/reg_location	-a""	-t"area"	-c"luce"	-d"84x262y"		-n"troglodyte_hut steves_hut"
/reg_location	-a""	-t"area"	-c"luce"	-d"49x250y"		-n"karatur akira"
/reg_location	-a""	-t"area"	-c"luce"	-d"63x148y"		-n"valley_of_the_kings votk"
/reg_location	-a""	-t"area"	-c"luce"	-d"87x156y"		-n"afkadel_el_sha"
/reg_location	-a""	-t"area"	-c"luce"	-d"95x141y"		-n"kharim_el_main"
/reg_location	-a""	-t"area"	-c"luce"	-d"79x137y"		-n"hakun_al_mar harun_al_kor"
/reg_location	-a""	-t"area"	-c"luce"	-d"91x132y"		-n"kundar_el_alam"
/reg_location	-a""	-t"area"	-c"luce"	-d"99x114y"		-n"great_central_desert gcd nifties"
/reg_location	-a""	-t"area"	-c"luce"	-d"113x98y"		-n"oasis"
/reg_location	-a""	-t"area"	-c"luce"	-d"656x139y"	-n"trillochs_tower"
/reg_location	-a""	-t"area"	-c"luce"	-d"631x97y"		-n"ship_navigators"
/reg_location	-a""	-t"area"	-c"luce"	-d"535x91y"		-n"jondalars_castle beanstalk"
;;                                                                     Guilds
/reg_location	-a""	-t"guild"	-c"luce"	-d"436x151y"	-n"alchemist"
/reg_location	-a""	-t"guild"	-c"luce"	-d"392x148y"	-n"monk"
/reg_location	-a""	-t"guild"	-c"luce"	-d"201x456y"	-n"monk_special_luce"
/reg_location	-a""	-t"guild"	-c"luce"	-d"407x181y"	-n"tzarakk"
/reg_location	-a""	-t"guild"	-c"luce"	-d"266x344y"	-n"mage_poison"
/reg_location	-a""	-t"guild"	-c"luce"	-d"589x398y"	-n"mage_electric"
/reg_location	-a""	-t"guild"	-c"luce"	-d"370x182y"	-n"tiger_luce"
/reg_location	-a""	-t"guild"	-c"luce"	-d"262x210y"	-n"tarm_luce"
/reg_location	-a""	-t"trainer"	-c"luce"	-d"411x165y"	-n"ranger_luce"
/reg_location	-a""	-t"trainer"	-c"luce"	-d"382x153y"	-n"barb_luce"
/reg_location	-a""	-t"trainer"	-c"luce"	-d"250x298y"	-n"priest_luce"
;;                                                             Overworld Mobs
/reg_location	-a""	-t"mobs"	-c"luce"	-d"215x294y"	-n"jungle_cavalier"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                     Laenor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                     Cities
/reg_location	-a""	-t"city"	-c"laen"	-d"596x410y"	-n"tyr_farwyn"
/reg_location	-a""	-t"city"	-c"laen"	-d"580x379y"	-n"dortlewall"
/reg_location	-a""	-t"city"	-c"laen"	-d"365x474y"	-n"arelium"
/reg_location	-a""	-t"city"	-c"laen"	-d"338x493y"	-n"pleasantville"
/reg_location	-a""	-t"city"	-c"laen"	-d"275x406y"	-n"vendace_shore"
;;                                                              Player Cities
/reg_location	-a""	-t"pcity"	-c"laen"	-d"361x122y"	-n"dragonbane"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"625x82y"		-n"riverfall"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"603x122y"	-n"mielenrauha"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"582x214y"	-n"unconcerned"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"305x343y"	-n"void"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"378x301y"	-n"shangrila"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"427x300y"	-n"lapland"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"444x296y"	-n"evergreen"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"453x304y"	-n"eternia"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"464x302y"	-n"farmville"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"475x306y"	-n"downunder"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"482x344y"	-n"onyx_citadel"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"503x357y"	-n"kalia"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"509x380y"	-n"windspyre"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"514x396y"	-n"garden"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"519x412y"	-n"kepustan"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"535x417y"	-n"bat_suburb"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"510x432y"	-n"tormentia"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"518x432y"	-n"sumucity"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"655x349y"	-n"quintinity"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"625x382y"	-n"mistfall"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"613x391y"	-n"darkness"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"587x403y"	-n"cloudcastle"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"572x428y"	-n"transylvania"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"613x425y"	-n"melusine"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"498x444y"	-n"graveyard"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"482x456y"	-n"demonia"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"480x469y"	-n"dionysus"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"475x485y"	-n"zhamania"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"536x468y"	-n"darkhold"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"593x480y"	-n"serpentkeep"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"594x492y"	-n"desolation"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"581x500y"	-n"tardis"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"560x516y"	-n"shadarii"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"540x497y"	-n"hamppukaupunki"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"629x750y"	-n"manhole"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"570x670y"	-n"whitehall"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"533x600y"	-n"laiduin"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"467x598y"	-n"absolon"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"468x563y"	-n"valhalla"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"455x568y"	-n"twilight"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"528x551y"	-n"orathdur"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"454x505y"	-n"odessa"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"442x508y"	-n"innsmouth"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"432x514y"	-n"santillana"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"454x517y"	-n"sacred_gardens"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"442x517y"	-n"ankh_morpork"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"404x520y"	-n"orion"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"380x537y"	-n"smithville"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"390x541y"	-n"texas"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"375x503y"	-n"babylon"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"376x488y"	-n"midian"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"336x513y"	-n"nightfall"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"321x493y"	-n"simcity"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"327x462y"	-n"redwall"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"313x450y"	-n"nightshelter"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"284x454y"	-n"oulu"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"311x443y"	-n"neverness"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"299x433y"	-n"avalon"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"262x435y"	-n"joensuu"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"299x383y"	-n"fightclub"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"318x394y"	-n"kapilavastu"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"298x397y"	-n"neo_turku"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"297x406y"	-n"gothamcity"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"284x408y"	-n"chairman"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"303x420y"	-n"isca"
/reg_location	-a""	-t"pcity"	-c"laen"	-d"311x365y"	-n"macedonia"
;;                                                               Race Shrines
/reg_location	-a""	-t"shrine"	-c"laen"	-d"394x319y"	-n"zombie"
/reg_location	-a""	-t"shrine"	-c"laen"	-d"510x310y"	-n"tinmen"
/reg_location	-a""	-t"shrine"	-c"laen"	-d"561x303y"	-n"dwarf"
/reg_location	-a""	-t"shrine"	-c"laen"	-d"613x116y"	-n"sprite"
/reg_location	-a""	-t"shrine"	-c"laen"	-d"621x455y"	-n"ent"
/reg_location	-a""	-t"shrine"	-c"laen"	-d"474x506y"	-n"human"
/reg_location	-a""	-t"shrine"	-c"laen"	-d"405x550y"	-n"elf"
/reg_location	-a""	-t"shrine"	-c"laen"	-d"398x570y"	-n"hobbit"
/reg_location	-a""	-t"shrine"	-c"laen"	-d"256x585y"	-n"leprechaun"
;;                                                                      Areas
/reg_location	-a""	-t"area"	-c"laen"	-d"311x404y"	-n"arthur"
/reg_location	-a""	-t"area"	-c"laen"	-d"288x433y"	-n"oakvale"
/reg_location	-a""	-t"area"	-c"laen"	-d"238x470y"	-n"newbie_forest"
/reg_location	-a""	-t"area"	-c"laen"	-d"228x476y"	-n"conifer_forest"
/reg_location	-a""	-t"area"	-c"laen"	-d"281x479y"	-n"newbie_mountain"
/reg_location	-a""	-t"area"	-c"laen"	-d"289x474y"	-n"diggas diggas_domain"
/reg_location	-a""	-t"area"	-c"laen"	-d"312x460y"	-n"circus"
/reg_location	-a""	-t"area"	-c"laen"	-d"319x462y"	-n"old_oak_forest"
/reg_location	-a""	-t"area"	-c"laen"	-d"317x466y"	-n"grannys_house"
/reg_location	-a""	-t"area"	-c"laen"	-d"327x470y"	-n"enchanter_drow"
/reg_location	-a""	-t"area"	-c"laen"	-d"306x486y"	-n"newbie_mines"
/reg_location	-a""	-t"area"	-c"laen"	-d"292x517y"	-n"stone_circle"
/reg_location	-a""	-t"area"	-c"laen"	-d"302x497y"	-n"old_convent"
/reg_location	-a""	-t"area"	-c"laen"	-d"310x556y"	-n"mountain_dwarves"
/reg_location	-a""	-t"area"	-c"laen"	-d"340x578y"	-n"dark_castle"
/reg_location	-a""	-t"area"	-c"laen"	-d"339x468y"	-n"orc_scouts"
/reg_location	-a""	-t"area"	-c"laen"	-d"348x474y"	-n"asylum"
/reg_location	-a""	-t"area"	-c"laen"	-d"351x479y"	-n"wibble_village"
/reg_location	-a""	-t"area"	-c"laen"	-d"344x481y"	-n"enchanter_valar"
/reg_location	-a""	-t"area"	-c"laen"	-d"357x482y"	-n"petting_zoo"
/reg_location	-a""	-t"area"	-c"laen"	-d"363x485y"	-n"dungeon"
/reg_location	-a""	-t"area"	-c"laen"	-d"341x489y"	-n"hundred_acre_forest"
/reg_location	-a""	-t"area"	-c"laen"	-d"368x491y"	-n"newberry_park"
/reg_location	-a""	-t"area"	-c"laen"	-d"354x497y"	-n"apple_orchard"
/reg_location	-a""	-t"area"	-c"laen"	-d"340x498y"	-n"newbie_taskmaster"
/reg_location	-a""	-t"area"	-c"laen"	-d"388x511y"	-n"newbie_playground"
/reg_location	-a""	-t"area"	-c"laen"	-d"385x518y"	-n"small_meadow"
/reg_location	-a""	-t"area"	-c"laen"	-d"387x528y"	-n"farmhouse"
/reg_location	-a""	-t"area"	-c"laen"	-d"410x533y"	-n"wrebie_forest"
/reg_location	-a""	-t"area"	-c"laen"	-d"422x524y"	-n"arskas_hut"
/reg_location	-a""	-t"area"	-c"laen"	-d"434x522y"	-n"hunt_master"
/reg_location	-a""	-t"area"	-c"laen"	-d"463x520y"	-n"peacock_farm"
/reg_location	-a""	-t"area"	-c"laen"	-d"459x533y"	-n"school_of_lumine"
/reg_location	-a""	-t"area"	-c"laen"	-d"419x539y"	-n"kilrathi"
/reg_location	-a""	-t"area"	-c"laen"	-d"467x572y"	-n"misty_forest mist"
/reg_location	-a""	-t"area"	-c"laen"	-d"474x574y"	-n"crack"
/reg_location	-a""	-t"area"	-c"laen"	-d"406x596y"	-n"gnome_airship"
/reg_location	-a""	-t"area"	-c"laen"	-d"456x616y"	-n"crescent_tower"
/reg_location	-a""	-t"area"	-c"laen"	-d"577x681y"	-n"secladin"
/reg_location	-a""	-t"area"	-c"laen"	-d"614x634y"	-n"sewers_of_silverfang silverfang"
/reg_location	-a""	-t"area"	-c"laen"	-d"516x632y"	-n"zoys_inn"
/reg_location	-a""	-t"area"	-c"laen"	-d"524x606y"	-n"beastlands"
/reg_location	-a""	-t"area"	-c"laen"	-d"517x593y"	-n"chessboard"
/reg_location	-a""	-t"area"	-c"laen"	-d"516x585y"	-n"village_of_stouby stouby"
/reg_location	-a""	-t"area"	-c"laen"	-d"519x553y"	-n"lonely_inn"
/reg_location	-a""	-t"area"	-c"laen"	-d"517x526y"	-n"land_of_anarchy"
/reg_location	-a""	-t"area"	-c"laen"	-d"542x509y"	-n"kender_mansion kenders"
/reg_location	-a""	-t"area"	-c"laen"	-d"518x508y"	-n"rainbow_cloak colours"
/reg_location	-a""	-t"area"	-c"laen"	-d"490x469y"	-n"drawbridge"
/reg_location	-a""	-t"area"	-c"laen"	-d"528x429y"	-n"bigeaul castle_bigeaul"
/reg_location	-a""	-t"area"	-c"laen"	-d"533x479y"	-n"tunnel"
/reg_location	-a""	-t"area"	-c"laen"	-d"571x484y"	-n"forest_of_moonrind moonrind"
/reg_location	-a""	-t"area"	-c"laen"	-d"594x467y"	-n"hugoville"
/reg_location	-a""	-t"area"	-c"laen"	-d"590x428y"	-n"temple_of_the_winds"
/reg_location	-a""	-t"area"	-c"laen"	-d"559x412y"	-n"bunny_valley"
/reg_location	-a""	-t"area"	-c"laen"	-d"613x410y"	-n"iron_mine"
/reg_location	-a""	-t"area"	-c"laen"	-d"690x408y"	-n"goddess_garden"
/reg_location	-a""	-t"area"	-c"laen"	-d"652x358y"	-n"temple_of_sarku sarku"
/reg_location	-a""	-t"area"	-c"laen"	-d"594x367y"	-n"mountaineer_cottage"
/reg_location	-a""	-t"area"	-c"laen"	-d"508x347y"	-n"ivory_tower"
/reg_location	-a""	-t"area"	-c"laen"	-d"270x322y"	-n"faerie_island"
/reg_location	-a""	-t"area"	-c"laen"	-d"365x294y"	-n"pluras_castle pluras"
/reg_location	-a""	-t"area"	-c"laen"	-d"462x292y"	-n"abandoned_valley"
/reg_location	-a""	-t"area"	-c"laen"	-d"350x242y"	-n"gauntlet_event"
/reg_location	-a""	-t"area"	-c"laen"	-d"439x278y"	-n"butterfly_farm"
/reg_location	-a""	-t"area"	-c"laen"	-d"447x241y"	-n"simons_hut simons"
/reg_location	-a""	-t"area"	-c"laen"	-d"532x263y"	-n"forest_of_legolas legolas"
/reg_location	-a""	-t"area"	-c"laen"	-d"580x185y"	-n"blackteeth_mountain blackteeth"
/reg_location	-a""	-t"area"	-c"laen"	-d"727x135y"	-n"elven_village"
/reg_location	-a""	-t"area"	-c"laen"	-d"538x167y"	-n"dunedains_mansion"
/reg_location	-a""	-t"area"	-c"laen"	-d"621x103y"	-n"fouls_creche"
/reg_location	-a""	-t"area"	-c"laen"	-d"618x98y"		-n"urvile_tree woodhelvin"
/reg_location	-a""	-t"area"	-c"laen"	-d"613x102y"	-n"mithil_stonedown mithil"
/reg_location	-a""	-t"area"	-c"laen"	-d"608x99y"		-n"revelstone"
/reg_location	-a""	-t"area"	-c"laen"	-d"605x101y"	-n"guards_gap"
/reg_location	-a""	-t"area"	-c"laen"	-d"363x133y"	-n"ixixixiblat"
/reg_location	-a""	-t"area"	-c"laen"	-d"298x122y"	-n"mesme_forest mesme"
/reg_location	-a""	-t"area"	-c"laen"	-d"343x88y"		-n"faerie_forest"
;;                                                                     Guilds
/reg_location	-a""	-t"guild"	-c"laen"	-d"340x554y"	-n"ranger"
/reg_location	-a""	-t"guild"	-c"laen"	-d"295x608y"	-n"runemage_east"
/reg_location	-a""	-t"guild"	-c"laen"	-d"335x460y"	-n"squire cavalier"
/reg_location	-a""	-t"guild"	-c"laen"	-d"352x468y"	-n"sailor"
/reg_location	-a""	-t"guild"	-c"laen"	-d"310x381y"	-n"explorer"
/reg_location	-a""	-t"guild"	-c"laen"	-d"453x559y"	-n"druid"
/reg_location	-a""	-t"guild"	-c"laen"	-d"465x504y"	-n"knight"
/reg_location	-a""	-t"guild"	-c"laen"	-d"505x483y"	-n"channeller"
/reg_location	-a""	-t"guild"	-c"laen"	-d"699x701y"	-n"mage_magical"
/reg_location	-a""	-t"guild"	-c"laen"	-d"642x415y"	-n"runemage_west"
/reg_location	-a""	-t"guild"	-c"laen"	-d"572x403y"	-n"tarm_laen"
/reg_location	-a""	-t"guild"	-c"laen"	-d"490x302y"	-n"crimson"
/reg_location	-a""	-t"guild"	-c"laen"	-d"405x294y"	-n"monk_special_laen"
/reg_location	-a""	-t"guild"	-c"laen"	-d"391x294y"	-n"archer"
/reg_location	-a""	-t"guild"	-c"laen"	-d"404x242y"	-n"runemage_south"
/reg_location	-a""	-t"guild"	-c"laen"	-d"309x335y"	-n"tiger"
/reg_location	-a""	-t"guild"	-c"laen"	-d"546x632y"	-n"temple_of_las nun_temple"
/reg_location	-a""	-t"trainer"	-c"laen"	-d"297x513y"	-n"barb_laen"
/reg_location	-a""	-t"trainer"	-c"laen"	-d"670x90y"		-n"priest_laen"
/reg_location	-a""	-t"trainer"	-c"laen"	-d"295x408y"	-n"animist_laen"
;;                                                             Overworld Mobs
/reg_location	-a""	-t"mobs"	-c"laen"	-d"517x647y"	-n"river_cavalier"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                 Desolathya
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                     Cities
/reg_location	-t"city"	-c"deso"	-d"285x274y"	-n"calythien"		-a""
;;                                                              Player Cities
;/reg_location	-a""	-t"pcity"		-c"deso"	-d""		-n""
/reg_location	-a""	-t"pcity"		-c"deso"	-d"298x49y"		-n"highwater"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"296x64y"		-n"perilous"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"245x74y"		-n"gehenna"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"242x60y"		-n"silvermoon"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"236x126y"	-n"delvelinion"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"230x145y"	-n"daleshop"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"277x184y"	-n"ravenloft"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"252x204y"	-n"isis"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"201x209y"	-n"luostan"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"276x243y"	-n"theta"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"253x279y"	-n"paradise"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"351x277y"	-n"sungate"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"28x367y"		-n"shire"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"78x448y"		-n"mausoleum"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"239x359y"	-n"harmony"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"343x339y"	-n"x"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"421x445y"	-n"tenebrae"
/reg_location	-a""	-t"pcity"		-c"deso"	-d"415x434y"	-n"camelot"
;;                                                               Race Shrines
/reg_location	-t"shrine"	-c"deso"	-d"215x444y"	-n"gnoll"			-a""
/reg_location	-t"shrine"	-c"deso"	-d"152x473y"	-n"skeleton"		-a""
/reg_location	-t"shrine"	-c"deso"	-d"85x464y"		-n"lich"			-a""
/reg_location	-t"shrine"	-c"deso"	-d"179x360y"	-n"ogre"			-a""
/reg_location	-t"shrine"	-c"deso"	-d"228x321y"	-n"gargoyle"		-a"2 e"
/reg_location	-t"shrine"	-c"deso"	-d"32x44y"		-n"leech"			-a""
/reg_location	-t"shrine"	-c"deso"	-d"341x103y"	-n"shadow"			-a"3 s"
/reg_location	-t"shrine"	-c"deso"	-d"473x237y"	-n"minotaur"		-a""
/reg_location	-t"shrine"	-c"deso"	-d"416x278y"	-n"kobold"			-a""
;;                                                                      Areas
/reg_location	-a""	-t"area"		-c"deso"	-d"194x334y"	-n"abandoned_barn"
/reg_location	-a""	-t"area"		-c"deso"	-d"245x319y"	-n"ancient_temple_of_gods"
/reg_location	-a""	-t"area"		-c"deso"	-d"382x419y"	-n"ancient_tower tralpecktor"
/reg_location	-a""	-t"area"		-c"deso"	-d"127x284y"	-n"apollo"
/reg_location	-a""	-t"area"		-c"deso"	-d"507x119y"	-n"broken_forest_barracks bf_barracks"
/reg_location	-a""	-t"area"		-c"deso"	-d"508x118y"	-n"broken_forest_castle bf_castle"
/reg_location	-a""	-t"area"		-c"deso"	-d"511x118y"	-n"broken_forest_prison bf_prison"
/reg_location	-a""	-t"area"		-c"deso"	-d"510x120y"	-n"broken_forest_seacrest bf_seacrest"
/reg_location	-a""	-t"area"		-c"deso"	-d"239x325y"	-n"brimshire"
/reg_location	-a""	-t"area"		-c"deso"	-d"183x387y"	-n"buckthorn_valley"
/reg_location	-a""	-t"area"		-c"deso"	-d"264x275y"	-n"burning_village"
/reg_location	-a""	-t"area"		-c"deso"	-d"368x312y"	-n"castle_of_toxic toxic"
/reg_location	-a""	-t"area"		-c"deso"	-d"302x94y"		-n"caves_of_orac orac"
/reg_location	-a""	-t"area"		-c"deso"	-d"388x112y"	-n"celestial_caverns"
/reg_location	-a""	-t"area"		-c"deso"	-d"308x279y"	-n"dhregal_mines kobold_mines"
/reg_location	-a""	-t"area"		-c"deso"	-d"229x153y"	-n"dalesman twisted_tower"
/reg_location	-a""	-t"area"		-c"deso"	-d"282x45y"		-n"dunamor berul"
/reg_location	-a""	-t"area"		-c"deso"	-d"228x294y"	-n"followers_of_vanion vanion"
/reg_location	-a""	-t"area"		-c"deso"	-d"338x368y"	-n"goblin_farm"
/reg_location	-a""	-t"area"		-c"deso"	-d"292x388y"	-n"hairikko_forest"
/reg_location	-a""	-t"area"		-c"deso"	-d"258x230y"	-n"halls_of_the_dead"
/reg_location	-a""	-t"area"		-c"deso"	-d"517x120y"	-n"jurkajefs_tower"
/reg_location	-a""	-t"area"		-c"deso"	-d"278x211y"	-n"magerathia"
/reg_location	-a""	-t"area"		-c"deso"	-d"202x60y"		-n"midnight_carnival carnival"
/reg_location	-a""	-t"area"		-c"deso"	-d"194x368y"	-n"millies_nightmare"
/reg_location	-a""	-t"area"		-c"deso"	-d"248x385y"	-n"mythical_valley"
/reg_location	-a""	-t"area"		-c"deso"	-d"478x79y"		-n"naganich_village teywaer"
/reg_location	-a""	-t"area"		-c"deso"	-d"278x307y"	-n"ochimo"
/reg_location	-a""	-t"area"		-c"deso"	-d"309x49y"		-n"pier"
/reg_location	-a""	-t"area"		-c"deso"	-d"332x351y"	-n"ranger_quest_area 51_daughters"
/reg_location	-a""	-t"area"		-c"deso"	-d"27x77y"		-n"red_tides_village red_tides"
/reg_location	-a""	-t"area"		-c"deso"	-d"175x221y"	-n"ruins_of_el_deagnoh el_deagnoh"
/reg_location	-a""	-t"area"		-c"deso"	-d"328x329y"	-n"seabird_inn"
/reg_location	-a""	-t"area"		-c"deso"	-d"278x35y"		-n"seashore_tower"
/reg_location	-a""	-t"area"		-c"deso"	-d"480x92y"		-n"small_well taywaer_well"
/reg_location	-a""	-t"area"		-c"deso"	-d"473x191y"	-n"snotling_farm"
/reg_location	-a""	-t"area"		-c"deso"	-d"166x356y"	-n"soy"
/reg_location	-a""	-t"area"		-c"deso"	-d"491x478y"	-n"stone_garden"
/reg_location	-a""	-t"area"		-c"deso"	-d"243x51y"		-n"sunderland"
/reg_location	-a""	-t"area"		-c"deso"	-d"363x459y"	-n"tarackia"
/reg_location	-a""	-t"area"		-c"deso"	-d"220x231y"	-n"temple_of_all_gods"
/reg_location	-a""	-t"area"		-c"deso"	-d"458x72y"		-n"teywaer_graveyard"
/reg_location	-a""	-t"area"		-c"deso"	-d"403x77y"		-n"teywaer_tunnel"
/reg_location	-a""	-t"area"		-c"deso"	-d"430x424y"	-n"warlock_conclave"
/reg_location	-a""	-t"area"		-c"deso"	-d"304x305y"	-n"tiburcios_tower tiburcio"
/reg_location	-a""	-t"area"		-c"deso"	-d"404x420y"	-n"tinmen_monastery"
/reg_location	-a""	-t"area"		-c"deso"	-d"131x192y"	-n"unholy_cathedral cathedral"
/reg_location	-a""	-t"area"		-c"deso"	-d"360x371y"	-n"valley_of_silence halberdheath"
/reg_location	-a""	-t"area"		-c"deso"	-d"238x113y"	-n"well"
/reg_location	-a""	-t"area"		-c"deso"	-d"133x266y"	-n"zorn"
;;                                                                     Guilds
/reg_location	-a""	-t"guild"		-c"deso"	-d"328x414y"	-n"animist"
/reg_location	-a""	-t"guild"		-c"deso"	-d"238x87y"		-n"liberator"
/reg_location	-a""	-t"guild"		-c"deso"	-d"341x467y"	-n"aelena"
/reg_location	-a""	-t"guild"		-c"deso"	-d"37x64y"		-n"mage_acid"
/reg_location	-a""	-t"guild"		-c"deso"	-d"94x87y"		-n"inner_circle"
/reg_location	-a""	-t"guild"		-c"deso"	-d"164x435y"	-n"reaver"
/reg_location	-a""	-t"guild"		-c"deso"	-d"306x377y"	-n"tarm_deso"
/reg_location	-a""	-t"guild"		-c"deso"	-d"403x306y"	-n"templar"
/reg_location	-a""	-t"guild"		-c"deso"	-d"201x153y"	-n"tiger_deso"
/reg_location	-a""	-t"guild"		-c"deso"	-d"79x433y"		-n"tree_navs"
/reg_location	-a""	-t"trainer"	-c"deso"	-d"262x379y"	-n"priest_deso"
/reg_location	-a""	-t"trainer"	-c"deso"	-d"296x288y"	-n"ranger_deso"
/reg_location	-a""	-t"trainer"	-c"deso"	-d"313x292y"	-n"barb_deso"
;;                                                             Overworld Mobs
/reg_location	-a""	-t"mobs"		-c"deso"	-d"102x371y"	-n"midnight_cavalier"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                  Furnachia
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                     Cities
/reg_location	-t"city"		-c"furn"	-d"198x87y"		-n"rilynttar"	-a""
;;                                                               Race Shrines
/reg_location	-t"shrine"	-c"furn"	-d"364x62y"		-n"draconian"		-a""
/reg_location	-t"shrine"	-c"furn"	-d"325x173y"	-n"orc"				-a""
/reg_location	-t"shrine"	-c"furn"	-d"334x193y"	-n"vampire"			-a"1 w"
/reg_location	-t"shrine"	-c"furn"	-d"297x231y"	-n"troll"			-a""
/reg_location	-t"shrine"	-c"furn"	-d"258x394y"	-n"barsoomian"		-a""
/reg_location	-t"shrine"	-c"furn"	-d"221x202y"	-n"duergar"			-a""
/reg_location	-t"shrine"	-c"furn"	-d"204x236y"	-n"demon"			-a"LAVA	sw,w,sw,nw,2 n LAVA"
/reg_location	-t"shrine"	-c"furn"	-d"132x241y"	-n"drow"			-a""
/reg_location	-t"shrine"	-c"furn"	-d"43x172y"		-n"doppleganger"	-a""
;;                                                                      Areas
/reg_location	-a""	-t"area"		-c"furn"	-d"130x248y"		-n"hell 9th_plane_of_hell"
/reg_location	-a""	-t"area"		-c"furn"	-d"333x260y"		-n"furn_fortress_east"
/reg_location	-a""	-t"area"		-c"furn"	-d"250x430y"		-n"furn_fortress_south"
/reg_location	-a""	-t"area"		-c"furn"	-d"68x259y"			-n"furn_fortress_west"
/reg_location	-a""	-t"area"		-c"furn"	-d"299x112y"		-n"abandoned_house"
/reg_location	-a""	-t"area"		-c"furn"	-d"135x204y"		-n"abandoned_temple"
/reg_location	-a""	-t"area"		-c"furn"	-d"141x159y"		-n"abandoned_village"
/reg_location	-a""	-t"area"		-c"furn"	-d"189x88y"			-n"ancona_manor"
/reg_location	-a""	-t"area"		-c"furn"	-d"68x459y"			-n"atlantis"
/reg_location	-a""	-t"area"		-c"furn"	-d"158x205y"		-n"black_marble_altar"
/reg_location	-a""	-t"area"		-c"furn"	-d"192x143y"		-n"cartwheel"
/reg_location	-a""	-t"area"		-c"furn"	-d"119x168y"		-n"castle_brantis brantis"
/reg_location	-a""	-t"area"		-c"furn"	-d"417x174y"		-n"castle_firefox firefox"
/reg_location	-a""	-t"area"		-c"furn"	-d"297x299y"		-n"corabandor"
/reg_location	-a""	-t"area"		-c"furn"	-d"176x161y"		-n"darkwood"
/reg_location	-a""	-t"area"		-c"furn"	-d"220x85y"			-n"domgroths_mansion domgroths"
/reg_location	-a""	-t"area"		-c"furn"	-d"199x81y"			-n"drow_tower"
/reg_location	-a""	-t"area"		-c"furn"	-d"165x10y"			-n"elven_outpost"
/reg_location	-a""	-t"area"		-c"furn"	-d"166x244y"		-n"enchanted_forest"
/reg_location	-a""	-t"area"		-c"furn"	-d"167x168y"		-n"forest_of_the_moon"
/reg_location	-a""	-t"area"		-c"furn"	-d"187x116y"		-n"haunted_mansion"
/reg_location	-a""	-t"area"		-c"furn"	-d"251x346y"		-n"jungle_cave"
/reg_location	-a""	-t"area"		-c"furn"	-d"171x236y"		-n"kutanakor_east"
/reg_location	-a""	-t"area"		-c"furn"	-d"131x236y"		-n"kutanakor_west"
/reg_location	-a""	-t"area"		-c"furn"	-d"145x335y"		-n"ndoki"
/reg_location	-a""	-t"area"		-c"furn"	-d"270x135y"		-n"necromancers_swamp necromancers"
/reg_location	-a""	-t"area"		-c"furn"	-d"200x201y"		-n"nocilis_valley"
/reg_location	-a""	-t"area"		-c"furn"	-d"77x269y"			-n"old_fort"
/reg_location	-a""	-t"area"		-c"furn"	-d"209x95y"			-n"orc_samurai"
/reg_location	-a""	-t"area"		-c"furn"	-d"310x220y"		-n"orthanc"
/reg_location	-a""	-t"area"		-c"furn"	-d"272x175y"		-n"perins"
/reg_location	-a""	-t"area"		-c"furn"	-d"327x127y"		-n"plakhstan"
/reg_location	-a""	-t"area"		-c"furn"	-d"301x185y"		-n"rillions_castle rillions"
/reg_location	-a""	-t"area"		-c"furn"	-d"76x108y"			-n"rounce"
/reg_location	-a""	-t"area"		-c"furn"	-d"321x339y"		-n"secret_jungle"
/reg_location	-a""	-t"area"		-c"furn"	-d"397x304y"		-n"steaming_cavern fire_giants"
/reg_location	-a""	-t"area"		-c"furn"	-d"279x214y"		-n"temple_of_aljerak aljerak"
/reg_location	-a""	-t"area"		-c"furn"	-d"98x205y"			-n"temple_of_the_twisted_prophecies twisted"
/reg_location	-a""	-t"area"		-c"furn"	-d"177x297y"		-n"trilloch_zoo"
/reg_location	-a""	-t"area"		-c"furn"	-d"214x155y"		-n"under_volcano"
/reg_location	-a""	-t"area"		-c"furn"	-d"289x146y"		-n"volcano"
/reg_location	-a""	-t"area"		-c"furn"	-d"143x305y"		-n"zonni_swamp"
;;                                                                     Guilds
/reg_location	-a""	-t"guild"		-c"furn"	-d"205x120y"	-n"lord_of_chaos"
/reg_location	-a""	-t"guild"		-c"furn"	-d"405x308y"	-n"mage_fire"
/reg_location	-a""	-t"guild"		-c"furn"	-d"223x234y"	-n"monk_special_furn"
/reg_location	-a""	-t"guild"		-c"furn"	-d"311x242y"	-n"wanderers"
/reg_location	-a""	-t"guild"		-c"furn"	-d"220x107y"	-n"temple_of_chaos locs"
/reg_location	-a""	-t"trainer"	-c"furn"	-d"200x118y"	-n"barb_furn"
/reg_location	-a""	-t"trainer"	-c"furn"	-d"195x104y"	-n"monk_furn"
/reg_location	-a""	-t"trainer"	-c"furn"	-d"204x95y"		-n"ranger_furn"
/reg_location	-a""	-t"trainer"	-c"furn"	-d"143x161y"	-n"animist_furn"
/reg_location	-a""	-t"trainer"	-c"furn"	-d"298x336y"	-n"priest_guild_special"
;;                                                             Overworld Mobs
/reg_location	-a""	-t"mobs"		-c"furn"	-d"227x123y"	-n"badlands_cavalier"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                  Rothikgen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                     Cities
/reg_location	-t"city"	-c"roth"	-d"221x271y"	-n"shadowkeep"		-a""
;;                                                              Player Cities
/reg_location	-a""	-t"pcity"		-c"roth"	-d"219x309y"		-n"atlantis_pcity"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"281x207y"		-n"batdiamondinc"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"235x230y"		-n"bullerbyn"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"36x374y"			-n"castle_ewige"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"385x268y"		-n"compton"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"150x250y"		-n"crabfroth"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"263x160y"		-n"darkvale"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"302x220y"		-n"darkwoods"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"236x244y"		-n"deimos"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"183x292y"		-n"dentistador"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"318x385y"		-n"destiny"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"211x287y"		-n"dragonsleap"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"370x123y"		-n"fevre"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"242x302y"		-n"giza_plateau"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"334x384y"		-n"gomorra"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"303x381y"		-n"hayhead"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"289x259y"		-n"highwood"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"236x270y"		-n"huntingcamp"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"74x85y"			-n"ithilien"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"175x316y"		-n"junkyard"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"240x364y"		-n"kauhajoki"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"205x246y"		-n"kelly"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"269x232y"		-n"kostovalikapale"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"227x318y"		-n"loserville"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"246x242y"		-n"manadrain"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"422x134y"		-n"mossad"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"254x438y"		-n"nampa"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"176x269y"		-n"nieuw_amsterdam"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"243x140y"		-n"nitroplut"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"168x289y"		-n"otieno"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"369x54y"			-n"pielavesj"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"202x168y"		-n"rautasaari"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"337x250y"		-n"revalanneva"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"353x257y"		-n"rivendell"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"274x250y"		-n"sepulchre"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"210x264y"		-n"teamonetwenty"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"405x215y"		-n"thalarion"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"111x187y"		-n"tortuga"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"226x329y"		-n"valgerville"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"201x260y"		-n"wihneland"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"260x281y"		-n"xanadu"
/reg_location	-a""	-t"pcity"		-c"roth"	-d"122x51y"			-n"xian"
;;                                                               Race Shrines
/reg_location	-t"shrine"	-c"roth"	-d"77x372y"		-n"brownie"			-a""
/reg_location	-t"shrine"	-c"roth"	-d"103x201y"	-n"wolfman"			-a""
/reg_location	-t"shrine"	-c"roth"	-d"137x148y"	-n"duck"			-a""
/reg_location	-t"shrine"	-c"roth"	-d"338x71y"		-n"penguin"			-a""
/reg_location	-t"shrine"	-c"roth"	-d"331x123y"	-n"giant"			-a""
/reg_location	-t"shrine"	-c"roth"	-d"237x246y"	-n"valar"			-a""
/reg_location	-t"shrine"	-c"roth"	-d"327x264y"	-n"gnome"			-a""
/reg_location	-t"shrine"	-c"roth"	-d"269x314y"	-n"moomin"			-a""
;;                                                                      Areas
/reg_location	-a""	-t"area"		-c"roth"	-d197x134y""		-n"abandoned_study"
/reg_location	-a""	-t"area"		-c"roth"	-d"346x296y"		-n"ackbars ackbars_quest"
/reg_location	-a""	-t"area"		-c"roth"	-d"220x345y"		-n"amberley_mansion amberley"
/reg_location	-a""	-t"area"		-c"roth"	-d"331x405y"		-n"anaconda_ruins anaconda"
/reg_location	-a""	-t"area"		-c"roth"	-d"186x311y"		-n"battlefield"
/reg_location	-a""	-t"area"		-c"roth"	-d"145x185y"		-n"beaumont_hamel beaumont"
/reg_location	-a""	-t"area"		-c"roth"	-d"227x139y"		-n"campsite"
/reg_location	-a""	-t"area"		-c"roth"	-d"186x307y"		-n"castle_of_lord_drauron drauron"
/reg_location	-a""	-t"area"		-c"roth"	-d"186x315y"		-n"cavern"
/reg_location	-a""	-t"area"		-c"roth"	-d"385x250y"		-n"caverns_of_chaos"
/reg_location	-a""	-t"area"		-c"roth"	-d"346x296y"		-n"dark_forest"
/reg_location	-a""	-t"area"		-c"roth"	-d"344x382y"		-n"donaru"
/reg_location	-a""	-t"area"		-c"roth"	-d"356x269y"		-n"drugstore"
/reg_location	-a""	-t"area"		-c"roth"	-d"186x310y"		-n"encampment_1"
/reg_location	-a""	-t"area"		-c"roth"	-d"187x314y"		-n"encampment_2"
/reg_location	-a""	-t"area"		-c"roth"	-d"141x113y"		-n"evil_vale"
/reg_location	-a""	-t"area"		-c"roth"	-d"398x285y"		-n"forest_in_the_valley"
/reg_location	-a""	-t"area"		-c"roth"	-d"28x399y"			-n"giant_killers doobies"
/reg_location	-a""	-t"area"		-c"roth"	-d"313x324y"		-n"hack"
/reg_location	-a""	-t"area"		-c"roth"	-d"396x255y"		-n"harazam_tower harazam"
/reg_location	-a""	-t"area"		-c"roth"	-d"163x69y"			-n"hells_dojo"
/reg_location	-a""	-t"area"		-c"roth"	-d"246x54y"			-n"hill_giants"
/reg_location	-a""	-t"area"		-c"roth"	-d"221x265y"		-n"horn_durath"
/reg_location	-a""	-t"area"		-c"roth"	-d"380x203y"		-n"horsehead_mountain horsehead"
/reg_location	-a""	-t"area"		-c"roth"	-d"453x31y"			-n"ice_castle frost_giants"
/reg_location	-a""	-t"area"		-c"roth"	-d"272x389y"		-n"inn_of_the_four_winds four_winds"
/reg_location	-a""	-t"area"		-c"roth"	-d"104x100y"		-n"kalevala"
/reg_location	-a""	-t"area"		-c"roth"	-d"231x261y"		-n"kathvael_forest katvile kathvael"
/reg_location	-a""	-t"area"		-c"roth"	-d"220x148y"		-n"king_eowyns_land eow"
/reg_location	-a""	-t"area"		-c"roth"	-d"420x261y"		-n"kintril_church"
/reg_location	-a""	-t"area"		-c"roth"	-d"133x452y"		-n"lighthouse"
/reg_location	-a""	-t"area"		-c"roth"	-d"148x51y"			-n"lonely_mountain"
/reg_location	-a""	-t"area"		-c"roth"	-d"252x334y"		-n"marble_shrine"
/reg_location	-a""	-t"area"		-c"roth"	-d"321x220y"		-n"mirkhold"
/reg_location	-a""	-t"area"		-c"roth"	-d"353x200y"		-n"moongate"
/reg_location	-a""	-t"area"		-c"roth"	-d"166x198y"		-n"mushroom_hill shrooms"
/reg_location	-a""	-t"area"		-c"roth"	-d"340x398y"		-n"norans_attic"
/reg_location	-a""	-t"area"		-c"roth"	-d"386x184y"		-n"norse_cave"
/reg_location	-a""	-t"area"		-c"roth"	-d"425x231y"		-n"norse_village"
/reg_location	-a""	-t"area"		-c"roth"	-d"76x157y" 		-n"old_copper_mine"
/reg_location	-a""	-t"area"		-c"roth"	-d"240x330y"		-n"old_forest"
/reg_location	-a""	-t"area"		-c"roth"	-d"62x315y"			-n"paupers_castle paupers"
/reg_location	-a""	-t"area"		-c"roth"	-d"319x396y"		-n"perilous_forest"
/reg_location	-a""	-t"area"		-c"roth"	-d"336x102y"		-n"plateau_of_tsang tsang"
/reg_location	-a""	-t"area"		-c"roth"	-d"222x71y"			-n"rendburg"
/reg_location	-a""	-t"area"		-c"roth"	-d"428x213y"		-n"ruins_of_untar_trinit untar_trinit"
/reg_location	-a""	-t"area"		-c"roth"	-d"218x255y"		-n"smurville"
/reg_location	-a""	-t"area"		-c"roth"	-d"158x147y"		-n"snow_peaked_mountain snowy_peak"
/reg_location	-a""	-t"area"		-c"roth"	-d"257x245y"		-n"snow_devils snowdevils citadel"
/reg_location	-a""	-t"area"		-c"roth"	-d"392x294y"		-n"spider_cave"
/reg_location	-a""	-t"area"		-c"roth"	-d"358x186y"		-n"stonehenge"
/reg_location	-a""	-t"area"		-c"roth"	-d"288x60y"			-n"taiga"
/reg_location	-a""	-t"area"		-c"roth"	-d"286x107y"		-n"traders_house"
/reg_location	-a""	-t"area"		-c"roth"	-d"84x112y"			-n"village_of_aldor aldor"
/reg_location	-a""	-t"area"		-c"roth"	-d"412x243y"		-n"wormhole"
;;                                                                     Guilds
/reg_location	-a""	-t"guild"			-c"roth"	-d"370x244y"		-n"barb"
/reg_location	-a""	-t"guild"			-c"roth"	-d"277x131y"		-n"barb_arena"
/reg_location	-a""	-t"guild"			-c"roth"	-d"233x128y"		-n"barb_cevi"
/reg_location	-a""	-t"guild"			-c"roth"	-d"128x169y"		-n"beastmaster"
/reg_location	-a""	-t"guild"			-c"roth"	-d"257x233y"		-n"kharim"
/reg_location	-a""	-t"guild"			-c"roth"	-d"84x396y"			-n"mage_asphyx"
/reg_location	-a""	-t"guild"			-c"roth"	-d"297x72y"			-n"mage_cold"
/reg_location	-a""	-t"guild"			-c"roth"	-d"277x283y"		-n"monk_special_roth"
/reg_location	-a""	-t"guild"			-c"roth"	-d"340x273y"		-n"navigator"
/reg_location	-a""	-t"guild"			-c"roth"	-d"248x255y"		-n"nun"
/reg_location	-a""	-t"guild"			-c"roth"	-d"168x281y"		-n"psionicist"
/reg_location	-a""	-t"guild"			-c"roth"	-d"163x225y"		-n"riftwalker_cave"
/reg_location	-a""	-t"guild"			-c"roth"	-d"149x108y"		-n"tarm_roth"
/reg_location	-a""	-t"guild"			-c"roth"	-d"236x348y"		-n"tiger_roth"
/reg_location	-a""	-t"guild"			-c"roth"	-d"200x270y"		-n"psi_quest_area"
/reg_location	-a""	-t"trainer"		-c"roth"	-d"170x195y"		-n"priest_roth"
/reg_location	-a""	-t"trainer"		-c"roth"	-d"218x285y"		-n"ranger_roth"
;;                                                             Overworld Mobs
/reg_location	-t"mobs"	-c"roth"		-a""	-d"437x219y"		-n"athanel"
/reg_location	-t"mobs"	-c"roth"		-a""	-d"395x254y"		-n"bufloogh"
/reg_location	-t"mobs"	-c"roth"		-a""	-d"423x239y"		-n"cyclon"
/reg_location	-t"mobs"	-c"roth"		-a""	-d"397x236y"		-n"goathead"
/reg_location	-t"mobs"	-c"roth"		-a""	-d"399x264y"		-n"red_hawk redhawk"
/reg_location	-t"mobs"	-c"roth"		-a""	-d"376x260y"		-n"silver"
/reg_location	-t"mobs"	-c"roth"		-a""	-d"246x45y"			-n"skyrider_cavalier"
