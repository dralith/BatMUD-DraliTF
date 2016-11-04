;;
;; DraliTF modules/guild/tarmalen.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def unload_tarmalen_module = \
	/purge -mregexp TARM_.*%; \
	/unset tarm_1_1%;/unset tarm_1_2%;/unset tarm_1_3%; \
	/unset tarm_2_1%;/unset tarm_2_2%;/unset tarm_2_3%; \
	/unset tarm_3_1%;/unset tarm_3_2%;/unset tarm_3_3%; \
	/unset tarm_1_1_hp%;/unset tarm_1_2_hp%;/unset tarm_1_3_hp%; \
	/unset tarm_2_1_hp%;/unset tarm_2_2_hp%;/unset tarm_2_3_hp%; \
	/unset tarm_3_1_hp%;/unset tarm_3_2_hp%;/unset tarm_3_3_hp%; \
	/COMMAND_cleanup tarmalen

/def -F -mregexp -t'^\|.([0-9?]).([0-9?]) +([A-z]*) ([a-z ]*) ([0-9]+)\(([0-9 ]+)\)' TARM_place_grabber = \
    /if (%{P1} =~ "?") \
        /eval%; \
    /else \
        /eval /set tarm_%{P1}_%{P2}=%{P3}%; \
        /eval /set tarm_%{P1}_%{P2}_hp=$[%{P5}*100/%{P6}]%; \
    /endif
;;/eval /echo %%{tarm_%{P1}_%{P2}_hp}

/def -F -mregexp -t'^\|.([0-9?]).([0-9?]) +\+([A-z]*) ([a-z ]*) ([0-9]+)\(([0-9 ]+)\)' TARM_place_grabber_entity = \
    /if (%{P1} =~ "?") \
        /eval%; \
    /else \
        /eval /set tarm_%{P1}_%{P2}=%{P3}%; \
        /eval /set tarm_%{P1}_%{P2}_hp=$[%{P5}*100/%{P6}]%; \
    /endif

/set curr_heal=cure light wounds
/set curr_prot=unstun
/set curr_type=heal
/set nheal=0


/def -mregexp -b'^[Op' key_nkp0 = cast 'minor party heal'
/def -mregexp -b'^[Oq' key_nkp1 = /if (%{curr_type} =~ "heal") @@cast '%{curr_heal}' %{tarm_3_1}%; /else @@cast '%{curr_prot}' %{tarm_3_1}%; /endif
/def -mregexp -b'^[Or' key_nkp2 = /if (%{curr_type} =~ "heal") @@cast '%{curr_heal}' %{tarm_3_2}%; /else @@cast '%{curr_prot}' %{tarm_3_2}%; /endif
/def -mregexp -b'^[Os' key_nkp3 = /if (%{curr_type} =~ "heal") @@cast '%{curr_heal}' %{tarm_3_3}%; /else @@cast '%{curr_prot}' %{tarm_3_3}%; /endif
/def -mregexp -b'^[Ot' key_nkp4 = /if (%{curr_type} =~ "heal") @@cast '%{curr_heal}' %{tarm_2_1}%; /else @@cast '%{curr_prot}' %{tarm_2_1}%; /endif
/def -mregexp -b'^[Ou' key_nkp5 = /if (%{curr_type} =~ "heal") @@cast '%{curr_heal}' %{tarm_2_2}%; /else @@cast '%{curr_prot}' %{tarm_2_2}%; /endif
/def -mregexp -b'^[Ov' key_nkp6 = /if (%{curr_type} =~ "heal") @@cast '%{curr_heal}' %{tarm_2_3}%; /else @@cast '%{curr_prot}' %{tarm_2_3}%; /endif
/def -mregexp -b'^[Ow' key_nkp7 = /if (%{curr_type} =~ "heal") @@cast '%{curr_heal}' %{tarm_1_1}%; /else @@cast '%{curr_prot}' %{tarm_1_1}%; /endif
/def -mregexp -b'^[Ox' key_nkp8 = /if (%{curr_type} =~ "heal") @@cast '%{curr_heal}' %{tarm_1_2}%; /else @@cast '%{curr_prot}' %{tarm_1_2}%; /endif
/def key_nkp9 = /if (%{curr_type} =~ "heal") @@cast '%{curr_heal}' %{tarm_1_3}%; /else @@cast '%{curr_prot}' %{tarm_1_3}%; /endif

/def -mregexp -b'^[Ol' key_nkp+ = /switch_level up
/def -mregexp -b'^[OP' key_nlck = @@party status short
/def -mregexp -b'^[OQ' key_nkp/ = /switch_prot
/def -mregexp -b'^[OR' key_nkp* = /switch_type
/def -mregexp -b'^[OS' key_nkp- = /switch_level down
/def key_nkp. = @@cast 'major party heal'

/def switch_prot = \
  /if (%{curr_prot} =~ "unstun") \
    /set curr_prot=unpain%; \
  /elseif (%{curr_prot} =~ "unpain") \
    /set curr_prot=unstun%; \
  /endif%; \
  /echo Now casting: %{curr_prot}s

/def switch_type = \
  /if (%{curr_type} =~ "heal") /set curr_type=prot%; \
  /elseif (%{curr_type} =~ "prot") /set curr_type=heal%; \
  /endif%; \
  /echo Now casting: %{curr_type}s

/def switch_level = \
  /if (%{1} =~ "down") \
    /set nheal=$[%{nheal}-1]%; \
  /endif%; \
  /if (%{1} =~ "up") \
    /set nheal=$[%{nheal}+1]%; \
  /endif%; \
  /if (%{nheal} < 0) \
    /set nheal=5%; \
  /endif%; \
  /if (%{nheal} > 5) \
    /set nheal=0%; \
  /endif%; \
  /if (%{nheal} == 0) \
    /set curr_heal=cure light wounds%; \
  /elseif (%{nheal} == 1) \
    /set curr_heal=cure serious wounds%; \
  /elseif (%{nheal} == 2) \
    /set curr_heal=cure critical wounds%; \
  /elseif (%{nheal} == 3) \
    /set curr_heal=minor heal%; \
  /elseif (%{nheal} == 4) \
    /set curr_heal=major heal%; \
  /elseif (%{nheal} == 5) \
    /set curr_heal=true heal%; \
  /endif%; \
  /eval /echo Now casting: %{curr_heal}



/def -F -mregexp -t'^([A-z]*) accepts (.*) from you.' TARM_grabrrb = \
  /set acceptee=%{P1}%; \
  /set accepted=%{P2}%; \
  /echo !!!!!!!!!!!!!!! %acceptee accepted %accepted !!!!!!!!!!!!!!!!!!!!!

/def -mregexp -F -t'You resurrect ([A-z]*).' TARM_ress1 = /set resses=$[%resses+1]%;/set ressed=1%;/TARM_save
/def -mregexp -F -t'You resurrect ([A-z]*) the christmas elf.' TARM_ress2 = /set resses=$[%resses+1]%;/set ressed=1%;/TARM_save
/def -mregexp -F -t'You raise ([A-z]*) from the dead.' TARM_rais1 = /set raises=$[%raises+1]%;/set raised=1%;/TARM_save
/def -mregexp -F -t'You raise ([A-z]*) the christmas elf from the dead.' TARM_rais2 = /set raises=$[%raises+1]%;/set raised=1%;/TARM_save
/def -mregexp -F -t'You create a new body for ([A-z]*).' TARM_body1 = /set bodyes=$[%bodyes+1]%;/set bodyed=1%;/TARM_save
/def -mregexp -F -t'You create a new body for ([A-z]*) the christmas elf.' TARM_body2 = /set bodyes=$[%bodyes+1]%;/set bodyed=1%;/TARM_save


/def -F -mregexp -t'([A-z]*) shivers and turns pale.' TARM_grabpois = \
    /set poisoned=%{P1}

/def -mregexp -abBCred -F -t'^([A-z]*) lapses into unconsciousness' TARM_unconner1 = \
    @dd %{P1}

/COMMAND_register_i	 -n"clw" -m"tarmalen" -a"cast 'cure light wounds' \$*"
/COMMAND_register_i	 -n"csw" -m"tarmalen" -a"cast 'cure serious wounds' \$*"
/COMMAND_register_i	 -n"ccw" -m"tarmalen" -a"cast 'cure critical wounds' \$*"
/COMMAND_register_i	 -n"mih" -m"tarmalen" -a"cast 'minor heal' \$*"
/COMMAND_register_i	 -n"mah" -m"tarmalen" -a"cast 'major heal' \$*"
/COMMAND_register_i	 -n"miph" -m"tarmalen" -a"cast minor party heal"
/COMMAND_register_i	 -n"maph" -m"tarmalen" -a"cast major party heal"
/COMMAND_register_i	 -n"rs" -m"tarmalen" -a"cast 'remove scar' \$*"
/COMMAND_register_i	 -n"rp" -m"tarmalen" -a"cast 'remove poison' \$*"
/COMMAND_register_i	 -n"bot" -m"tarmalen" -a"cast 'blessing of tarmalen' \$*;party report [BoT->\$*]"
/COMMAND_register_i	 -n"unp" -m"tarmalen" -a"cast 'unpain' \$*;party report [Unpain->\$*]"
/COMMAND_register_i	 -n"uns" -m"tarmalen" -a"cast 'unstun' \$*;party report [Unstun->\$*]"
/COMMAND_register_i	 -n"rais" -m"tarmalen" -a"cast 'raise dead' \$*;tell \$* Raising you from the dead."
/COMMAND_register_i	 -n"ress" -m"tarmalen" -a"cast 'resurrect' \$*;tell \$* Using necromancy to bring you back to life."
/COMMAND_register_i	 -n"body" -m"tarmalen" -a"cast 'new body' \$*;tell \$* Making you a sexy body to inhabit."
/COMMAND_register_i	 -n"dd" -m"tarmalen" -a"cast 'deaths door' \$*;party report [DD->\$*]"
/COMMAND_register_i	 -n"satiate" -m"tarmalen" -a"cast 'satiate person' \$*"
/COMMAND_register_i	 -n"restore" -m"tarmalen" -a"cast 'restore' \$*;party report [Restore->\$*]"
/COMMAND_register_i	 -n"bless" -m"tarmalen" -a"use 'bless' \$*"
/COMMAND_register_i	 -n"tempt" -m"tarmalen" -a"use 'tempt' \$*"


/def -h'SEND {tarminit}' TARM_reset_stats = \
	/set totxpgain=$[totxpgain - ressxp - raisxp - bodyxp]%; \
	/set resses=0%; \
	/set ressxp=0%; \
	/set raises=0%; \
	/set raisxp=0%; \
	/set bodyes=0%; \
	/set bodyxp=0%; \
	/TARM_save


/def TARM_save = \
  /let striim=$[tfopen(strcat(%{TF_DIR},"/saves/tarm.tf"),"w")]%; \
	/test $[tfwrite(%{striim},strcat("/set resses ",%{resses},""))]%; \
	/test $[tfwrite(%{striim},strcat("/set raises ",%{raises},""))]%; \
	/test $[tfwrite(%{striim},strcat("/set bodyes ",%{bodyes},""))]%; \
	/test $[tfwrite(%{striim},strcat("/set ressxp ",%{ressxp},""))]%; \
	/test $[tfwrite(%{striim},strcat("/set raisxp ",%{raisxp},""))]%; \
	/test $[tfwrite(%{striim},strcat("/set bodyxp ",%{bodyxp},""))]%; \
	/test $[tfwrite(%{striim},strcat("/set reincxp ",%{reincxp},""))]%; \
	/test $[tfwrite(%{striim},strcat("/set reincs ",%{reincs},""))]%; \
	/test $[tfwrite(%{striim},strcat("/set totxpgain ",%{totxpgain},""))]%; \
	/test $[tfclose(%{striim})]


/eval /load %{TF_DIR}/saves/tarm.tf
