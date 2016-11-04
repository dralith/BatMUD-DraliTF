;;
;; DraliTF system/settings.tf version 0.1
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Init Client-side Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set cs_settings=AUTO_fire:0 AUTO_camp:0 AUTO_report:0 AUTO_teleport_report:0 \
AUTO_stun_report:0 AUTO_ticker_report:0 AVAIL_camp:1 AUTO_party_join:1 AUTO_pss:1 \
AUTO_rep_report:0 PARTY_lite:1 AUTO_skill_spell_report:0 AUTO_drop_at_burn:1 \
AUTO_blast_report:0 AUTO_general_report:1 AUTO_save_lites:1 AUTO_save_me:0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Display settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -ag CMD_sets = \
	/if (member_array("sailor", %{modules}) == 1 & sailor_tag !~ "") \
		/eval /echo -p ,------------------.            ,-------------.            ,------------------.  %;\
		/eval /echo -p | @{BCred}DraliTF@{n} @{BCcyan}Settings:@{n} \\\\          / $[SAILOR_fix_tag(%sailor_tag)] \\\\          / @{BCgreen}$[pad(%{MY_NAME},17)]@{n} |%;\
		/eval /echo -p | =================  `--------\' =============== `--------\'  ================= |%; \
	/else \
		/if (member_array("sailor", %{modules}) == 1) \
			/SAILOR_check_align%;\
		/endif%;\
		/eval /echo -p ,------------------.                                       ,------------------.  %;\
		/eval /echo -p | @{BCred}DraliTF@{n} @{BCcyan}Settings:@{n} \\\\                                     / @{BCgreen}$[pad(%{MY_NAME},17)]@{n} |%;\
		/eval /echo -p | =================  `-----------------.-----------------\'  ================= |%; \
	/endif%; \
	/eval /echo -p | @{BCcyan}Lite Party Status@{n}     ( @{BCyellow}psr@{n}    ) $[convert_num_to_onoff(get_setting("PARTY_lite"))] | @{BCcyan}Auto Join Parties@{n}     ( @{BCyellow}apj@{n}    ) $[convert_num_to_onoff(get_setting("AUTO_party_join"))] |%; \
	/eval /echo -p | @{BCcyan}Check PSS in Combat@{n}   ( @{BCyellow}apss@{n}   ) $[convert_num_to_onoff(get_setting("AUTO_pss"))] | @{BCcyan}Save Custom Lites@{n}     ( @{BCyellow}loot@{n}   ) $[convert_num_to_onoff(get_setting("AUTO_save_lites"))] |%; \
	/eval /echo -p | @{BCcyan}Report in Combat@{n}      ( @{BCyellow}repo@{n}   ) $[convert_num_to_onoff(get_setting("AUTO_report"))] | @{BCcyan}Report Use/Cast@{n}       ( @{BCyellow}srep@{n}   ) $[convert_num_to_onoff(get_setting("AUTO_skill_spell_report"))] |%; \
	/eval /echo -p | @{BCcyan}Report Stuns@{n}          ( @{BCyellow}stun@{n}   ) $[convert_num_to_onoff(get_setting("AUTO_stun_report"))] | @{BCcyan}Report Teleports@{n}      ( @{BCyellow}tele@{n}   ) $[convert_num_to_onoff(get_setting("AUTO_teleport_report"))] |%; \
	/eval /echo -p | @{BCcyan}Report ticks@{n}          ( @{BCyellow}ticker@{n} ) $[convert_num_to_onoff(get_setting("AUTO_ticker_report"))] | @{BCcyan}Report blasts@{n}         ( @{BCyellow}blastr@{n} ) $[convert_num_to_onoff(get_setting("AUTO_blast_report"))] |%; \
	/eval /echo -p | @{BCcyan}Remake/Refuel Fires@{n}   ( @{BCyellow}afire@{n}  ) $[convert_num_to_onoff(get_setting("AUTO_fire"))] | @{BCcyan}Camp After Fire@{n}       ( @{BCyellow}fica@{n}   ) $[convert_num_to_onoff(get_setting("AUTO_camp"))] |%; \
	/if (member_array("barb", %{modules}) == 1) \
		/eval /echo -p | @{BCcyan}Report Repu at Burn@{n}   ( @{BCyellow}repu@{n}   ) $[convert_num_to_onoff(get_setting("AUTO_rep_report"))] |                                      |%; \
	/endif%; \
	/eval /echo -p |--------------------------------------|--------------------------------------|%; \
	/eval /echo -p | @{BCcyan}Camp Available@{n}                   $[convert_num_to_yesno(get_setting("AVAIL_camp"))] |                                      |%; \
	/eval /echo -p `--------------------------------------\'--------------------------------------\'%;
;; Add slite setting

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;SET COMMANDS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def CMD_afire = /toggle_cs_setting AUTO_fire Refuel/Remake Fires
/def CMD_acamp = /toggle_cs_setting AUTO_camp Camp after making fire
/def CMD_repo = /toggle_cs_setting AUTO_report Round Report
/def CMD_repu = /toggle_cs_setting AUTO_rep_report Reputation Report
/def CMD_slite = /toggle_cs_setting AUTO_save_lites Save Custom Lites
/def CMD_srep = /toggle_cs_setting AUTO_skill_spell_report Report Skills/Spells
/def CMD_tele = /toggle_cs_setting AUTO_teleport_report Report teleports
/def CMD_apss = /toggle_cs_setting AUTO_pss Auto PSS in combat
/def CMD_ticker = /toggle_cs_setting AUTO_ticker_report Report ticks
/def CMD_blastr = /toggle_cs_setting AUTO_blast_report Report blasts
/def CMD_apj = /toggle_cs_setting PARTY_auto_join Party Auto Join
/def CMD_psr = /toggle_cs_setting PARTY_lite Party Status Lites
/def CMD_stun = /toggle_cs_setting AUTO_stun_report Report Stuns

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Client side settings:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def toggle_cs_setting = \
	/if (get_setting(%{1}) =~ "-1") \
		/set_setting %{1} 1%; \
		/eval /echo -aBCgreen [TF]: %{-1}: [ On]%; \
	/elseif (get_setting(%{1}) =~ "1") \
		/set_setting %{1} 0%; \
		/eval /echo -aBCred [TF]: %{-1}: [Off]%; \
	/else \
		/set_setting %{1} 1%; \
		/eval /echo -aBCgreen [TF]: %{-1}: [ On]%; \
	/endif

/def set_setting = \
	/if (get_setting(%{1}) !~ "-1") \
		/rem_setting %{1}%; \
	/endif%; \
	/set cs_settings=%{cs_settings} %{1}:%{2}

/def rem_setting = \
	/set temp_setting=$[get_setting("-f",%{1})]%; \
	/if (%{temp_setting} =~ "-1") \
		/echo -p @{BCred}[TF]:@{n} Error: No Setting [%{1}] found%; \
	/endif%; \
	/set cs_settings=$(/remove %{temp_setting} %{cs_settings})%; \
	/unset temp_setting

/def get_setting = \
	/set num_settings=$(/length %{cs_settings})%; \
	/set cou_settings=0%; \
	/set tsettings=%{cs_settings}%; \
	/set temp_return=999%; \
	/while ({cou_settings}<{num_settings})\
		/set csetting=$(/pop tsettings)%;\
		/set temp_setting=%{csetting}%;\
		/set temp_setting=$[replace(":", " ", %{temp_setting})]%;\
		/set temp_setting_1=$(/car %{temp_setting})%; \
		/set temp_setting_2=$(/cadr %{temp_setting})%; \
		/set temp_setting_3=%{temp_setting}%; \
		/if (%{1} =~ "-f") \
			/if (%{2} =~ %{temp_setting_1}) \
				/set temp_return=%{csetting}%; \
			/endif%; \
		/elseif (%{1} =~ %{temp_setting_1}) \
			/set temp_return=%{temp_setting_2}%; \
		/endif%; \
		/set cou_settings=$[{cou_settings}+1]%;\
	/done%; \
	/if (%{temp_return} == 999) \
		/return "-1"%; \
	/else \
		/return "%{temp_return}"%; \
	/endif

/def convert_num_to_onoff = \
	/if (%{1} =~ "0") \
		/return "@{BCred}Off@{n}"%; \
	/else \
		/return "@{BCgreen} On@{n}"%; \
	/endif

/def convert_num_to_yesno = \
	/if (%{1} =~ "0") \
		/return "@{BCred} No@{n}"%; \
	/else \
		/return "@{BCgreen}Yes@{n}"%; \
	/endif
