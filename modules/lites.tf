;;
;; DraliTF modules/lites.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module specific functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def unload_lites_module = \
	/purge -mregexp LITE_.*%; \
	/purge -mregexp .*_lite.*

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Basic Lites
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; -- PUBLIC CHANNEL - (dark cyan) --------------------------------------------
/def -P0Ccyan -mregexp -F -t'(\(|[[]|{|<)sales([]]|}|>|\))' LITE_CHANNEL_sales
/def -P0Ccyan -mregexp -F -t'(\(|[[]|{|<)ghost([]]|}|>|\))' LITE_CHANNEL_ghost
/def -P0Ccyan -mregexp -F -t'(\(|[[]|{|<)newbie([]]|}|>|\))' LITE_CHANNEL_newbie
/def -P0Ccyan -mregexp -F -t'(\(|[[]|{|<)wanted([]]|}|>|\))' LITE_CHANNEL_wanted
/def -P0Ccyan -mregexp -F -t'(\(|[[]|{|<)race([]]|}|>|\))' LITE_CHANNEL_race
/def -P0Ccyan -mregexp -F -t'(\(|[[]|{|<)reborn([]]|}|>|\))' LITE_CHANNEL_reborn
/def -P0Ccyan -mregexp -F -t'(\(|[[]|{|<)lfp([]]|}|>|\))' LITE_CHANNEL_lfp
/def -P0Ccyan -mregexp -F -t'(\(|[[]|{|<)regions([]]|}|>|\))' LITE_CHANNEL_regions
/def -P0Ccyan -mregexp -F -t'(\(|[[]|{|<)pkiller([]]|}|>|\))' LITE_CHANNEL_pkiller
;; -- CHAT CHANNEL - (dark blue) ----------------------------------------------
/def -P0Cblue -mregexp -F -t'(\(|[[]|{|<)imud([]]|}|>|\))' LITE_CHANNEL_imud
/def -P0Cblue -mregexp -F -t'(\(|[[]|{|<)bat([]]|}|>|\))' LITE_CHANNEL_bat
/def -P0Cblue -mregexp -F -t'(\(|[[]|{|<)mudcon([]]|}|>|\))' LITE_CHANNEL_mudcon
/def -P0Cblue -mregexp -F -t'(\(|[[]|{|<)bs([]]|}|>|\))' LITE_CHANNEL_bs
/def -P0Cblue -mregexp -F -t'(\(|[[]|{|<)chat([]]|}|>|\))' LITE_CHANNEL_chat
/def -P0Cblue -mregexp -F -t'(\(|[[]|{|<)cards([]]|}|>|\))' LITE_CHANNEL_cards
/def -P0Cblue -mregexp -F -t'(\(|[[]|{|<)gladiator([]]|}|>|\))' LITE_CHANNEL_gladiator
/def -P0Cblue -mregexp -F -t'(\(|[[]|{|<)politics([]]|}|>|\))' LITE_CHANNEL_politics
/def -P0Cblue -mregexp -F -t'(\(|[[]|{|<)tunes([]]|}|>|\))' LITE_CHANNEL_tunes
/def -P0Cblue -mregexp -F -t'(\(|[[]|{|<)stream([]]|}|>|\))' LITE_CHANNEL_stream
;; -- SPORTS CHANNEL - (blue) -------------------------------------------------
/def -P0BCblue -mregexp -F -t'(\(|[[]|{|<)hockey([]]|}|>|\))' LITE_CHANNEL_hockey
/def -P0BCblue -mregexp -F -t'(\(|[[]|{|<)football([]]|}|>|\))' LITE_CHANNEL_football
;; -- FINNISH CHANNEL - (magenta) ------------------------------------------------
/def -P0BCmagenta -mregexp -F -t'(\(|[[]|{|<)ifin([]]|}|>|\))' LITE_CHANNEL_ifin
/def -P0BCmagenta -mregexp -F -t'(\(|[[]|{|<)fin([]]|}|>|\))' LITE_CHANNEL_fin
/def -P0BCmagenta -mregexp -F -t'(\(|[[]|{|<)suomi([]]|}|>|\))' LITE_CHANNEL_suomi
;; -- GUILD CHANNEL - (dark green) --------------------------------------------
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)tarmalen([]]|}|>|\))' LITE_CHANNEL_tarmalen
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)druids([]}]|>|\))' LITE_CHANNEL_druid
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)monk([]}]|>|\))' LITE_CHANNEL_monk
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)nun([]}]|>|\))' LITE_CHANNEL_nun
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)templar([]}]|>|\))' LITE_CHANNEL_templar
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)priests([]]|}|>|\))' LITE_CHANNEL_priests
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)lord_chaos([]]|}|>|\))' LITE_CHANNEL_lord_chaos
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)tiger([]}]|>|\))' LITE_CHANNEL_tiger
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)spider([]}]|>|\))' LITE_CHANNEL_spider
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)reaver([]}]|>|\))' LITE_CHANNEL_reaver
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)merchant([]]|}|>|\))' LITE_CHANNEL_merchant
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)bard([]}]|>|\))' LITE_CHANNEL_bard
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)civmage([]}]|>|\))' LITE_CHANNEL_civmage
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)civilized_fighter([]}]|>|\))' LITE_CHANNEL_civfighter
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)sabres([]}]|>|\))' LITE_CHANNEL_sabres
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)alchemists([]}]|>|\))' LITE_CHANNEL_alchemists
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)knight([]}]|>|\))' LITE_CHANNEL_knight
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)runemages([]}]|>|\))' LITE_CHANNEL_runemages
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)cavalier([]}]|>|\))' LITE_CHANNEL_cavalier
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)squire([]}]|>|\))' LITE_CHANNEL_squire
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)psionicist([]]|}|>|\))' LITE_CHANNEL_psionicist
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)mage([]}]|>|\))' LITE_CHANNEL_mage
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)channellers([]}]|>|\))' LITE_CHANNEL_channellers
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)conjurers([]}]|>|\))' LITE_CHANNEL_conjurers
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)ranger([]}]|>|\))' LITE_CHANNEL_ranger
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)crimson([]}]|>|\))' LITE_CHANNEL_crimson
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)barbarian([]}]|>|\))' LITE_CHANNEL_barbarian
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)beastmaster([]}]|>|\))' LITE_CHANNEL_beastmaster
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)pirate([]}]|>|\))' LITE_CHANNEL_pirate
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)mnavy([]}]|>|\))' LITE_CHANNEL_mnavy
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)navy([]}]|>|\))' LITE_CHANNEL_navy
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)tzarakk([]}]|>|\))' LITE_CHANNEL_tzarakk
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)disciple([]}]|>|\))' LITE_CHANNEL_disciple
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)archers([]}]|>|\))' LITE_CHANNEL_archers
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)nergal([]}]|>|\))' LITE_CHANNEL_nergal
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)aelena([]}]|>|\))' LITE_CHANNEL_aelena
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)kharim([]}]|>|\))' LITE_CHANNEL_kharim
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)explorer([]}]|>|\))' LITE_CHANNEL_explorer
/def -mregexp -PCgreen -F -t'(\(|[[]|{|<)navigator([]]|}|>|\))' LITE_CHANNEL_navigator
;; -- NON-PUBLIC CHANNEL - (dark yellow) --------------------------------------
/def -mregexp -PCyellow -F -t'(\(|[[]|{|<)party([]}]|>|\))' LITE_CHANNEL_party
/def -mregexp -PCyellow -F -t'(\(|[[]|{|<)pipe([]}]|>|\))' LITE_CHANNEL_pipe
/def -mregexp -PCyellow -F -t'(\(|[[]|{|<)holz([]}]|>|\))' LITE_CHANNEL_holz
;; -- SOCIETY CHANNEL - (dark yellow) -----------------------------------------
/def -mregexp -PCyellow -F -t'(\(|[[]|{|<)([a-z]*)[+]([]}]|>|\))' LITE_CHANNEL_society
;; -- OTHER CHANNEL - (yellow) ------------------------------------------------
/def -F -PBCyellow -mregexp -t'Info:' LITE_info
/def -F -PBCyellow -mregexp -t'shouts|You shout' LITE_shout
;; -- WIZARD CHANNEL - (green) ------------------------------------------------
/def -mregexp -PBCgreen -F -t'(\(|[[]|{|<)wiz([]}]|>|\))' LITE_CHANNEL_wiz
/def -mregexp -PBCgreen -F -t'(\(|[[]|{|<)awiz([]}]|>|\))' LITE_CHANNEL_awiz
/def -mregexp -PBCgreen -F -t'(\(|[[]|{|<)code([]}]|>|\))' LITE_CHANNEL_code
/def -mregexp -PBCgreen -F -t'(\(|[[]|{|<)hack([]}]|>|\))' LITE_CHANNEL_hack
/def -mregexp -PBCgreen -F -t'(\(|[[]|{|<)world([]}]|>|\))' LITE_CHANNEL_world
/def -mregexp -PBCgreen -F -t'(\(|[[]|{|<)iwiz([]}]|>|\))' LITE_CHANNEL_iwiz

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ALERTS (bright red) [usually BAD to see]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -P0BCred -mregexp -t'^Alas, your magic is suppressed.' LITE_suppressed
/def -F -P0BCred -mregexp -t'^For a moment you see a glimpse of black four leaf clover.' LITE_clover
/def -F -P0BCred -mregexp -t'^You get the feeling that someone is looking over your shoulder.' LITE_mental_glance
/def -F -P0BCred -mregexp -t'^You feel a magical presence probing' LITE_snoop
/def -F -P0BCred -mregexp -t'^You feel like your environment is being scanned.' LITE_blood_bath_scan
/def -F -P0BCred -mregexp -t'^You are so exhausted' LITE_exhausted
/def -F -P0BCred -mregexp -t'^([A-z ]*) manages to squirm free' LITE_strangle_end
/def -F -P0BCred -mregexp -t'^([A-z ]*) gags violently and screams' LITE_strangle1
/def -F -P0BCred -mregexp -t'^You tighten your strangling wire' LITE_strangle2
/def -F -P0BCred -mregexp -t'^([A-z ]*) is too full, and ' LITE_chest_overflow
/def -F -P0BCred -mregexp -t'^([A-z ]*) is now in the (.*) row' LITE_party_row_changed
/def -F -P0BCred -mregexp -t'(forcefield|Forcefield|forcfield|Forcfield|forcefeld|force field)' LITE_forcefield
/def -F -P0BCred -mregexp -t'( THIRSTY!| thirsty)' LITE_thirst
/def -F -P0BCred -mregexp -t'(DEHYDRATED|DEHYDRATING|FAMISHED)' LITE_famish
/def -F -P0BCred -mregexp -t'paralyzes' LITE_paralyze
/def -F -P0BCred -mregexp -t'^([A-z ]*) has summoned you.' LITE_summoned
/def -F -P0BCred -mregexp -t'(se on sarki nyt|rikki ja poikki)' LITE_destructs
/def -F -P0BCred -mregexp -t'POISON' LITE_poison
/def -F -P0BCred -mregexp -t'^A new orb made of some smooth white material' LITE_newbie_orb
/def -F -P0BCred -mregexp -t'(Robin Hood|hooded man called Robin)' LITE_robin_hood
/def -F -P0BCred -mregexp -t'sauga(i+)' LITE_poison_spellwords
/def -F -P0BCred -mregexp -t'offensive (spell|skill)' LITE_off_skill_spell
/def -F -P0BCred -mregexp -t'^([A-z ]*) is disturbed by ' LITE_aggroed1
/def -F -P0BCred -mregexp -t'^([A-z ]*) got mad at ' LITE_aggroed2
/def -F -P0BCred -mregexp -t'^Your .* gets damaged' LITE_eq_damaged = /d_error %%%%%%%%%%%% EQDAMAGE %%%%%%%%%%%%
/def -F -P0BCred -mregexp -t'loses its tangerine glow.' LITE_prot_drop = /d_error %%%%%%%%% Prot gone %%%%%%%%%%
/def -F -P0BCred -mregexp -t'seems to sparkle oddly' LITE_fw_drop = /d_error %%%%%%%%%%% FW gone %%%%%%%%%%%%
/def -F -P0BCred -mregexp -t'PAF PAF PAF' LITE_habo
/def -F -P0BCred -mregexp -t'^Your .* breaks into zillion' LITE_eq_break
/def -F -P0BCred -mregexp -t'(vaka vanha vainamoinen|vaka tosi vanha vainamoinen)' LITE_entropy
/def -F -P0BCred -mregexp -t'^The blood red demon shouts*' LITE_bb_demon
/def -F -P0BCred -mregexp -t'^You fail to (reach|touch)*' LITE_failed_to_reach
/def -F -P0BCred -mregexp -t'^You can see Death, clad in black, collect your corpse.$' LITE_i_died
/def -F -P0BCred -mregexp -t'^You cannot leave, you have been AMBUSHED.' LITE_ambushed
/def -F -P0BCred -mregexp -t'^You feel the godly effects withdraw*' LITE_godly_presence_end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Beneficial or Indifferent Lites
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -P0BCgreen -mregexp -t'is stunned from the intrusion into' LITE_mind_seize
/def -F -P0BCgreen -mregexp -t'^You feel your luck improve (.*)' LITE_luck_improved
/def -F -P0BCgreen -mregexp -t'^You feel a godly presence' LITE_godly_presence_start
/def -F -P0BCgreen -mregexp -t'^You feel like you just got slightly better (.*)' LITE_gained_percent
/def -F -P0BCgreen -mregexp -t'^You score a CRITICAL hit!' LITE_critical
/def -F -P0BCgreen -mregexp -t'^You score a [*]CRITICAL[*] hit!' LITE_star_critical
/def -F -P0BCgreen -mregexp -t'^You feel your luck changing.' LITE_luck
/def -F -P0BCgreen -mregexp -t'^The marks on the Kerbholz seem to shift.' LITE_holz
/def -F -P0BCgreen -mregexp -t'^Your keen senses note a disturbance seconds before the ambush!' LITE_ambush_safe1
/def -F -P0BCgreen -mregexp -t'^Your superb dexterity avoids a nasty ambush.' LITE_ambush_safe2
/def -F -P0BCgreen -mregexp -t'^Your (.*) tactics allows you to evade the ambush.' LITE_ambush_safe3
/def -F -P0BCgreen -mregexp -t'^Your marvellous intellect allows you to evade the ambush.' LITE_ambush_safe4
/def -F -P0BCwhite -mregexp -t'^([A-z ]*)  is DEAD, R.I.P.' LITE_rip
/def -F -P0Cgreen -mregexp -t'^([A-z ]*) seems hurt and confused.' LITE_spell_lost1
/def -F -P0Cgreen -mregexp -t'^([A-z ]*) seems to lose (.*)' LITE_spell_lost2
/def -F -P0BCblue -mregexp -t'^You start concentrating on the skill.' LITE_skill_start
/def -F -P0BCblue -mregexp -t'^You start chanting.' LITE_spell_start
/def -F -P0Ccyan -mregexp -t'^\*(.*)' LITE_emotes1
/def -F -P0Ccyan -mregexp -t'^\@(.*)' LITE_emotes2
/def -F -P0Ccyan -mregexp -t'^Bank transfer from (.*)' LITE_bank_transfer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mob Shape Lites
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -aBCgreen -F -mregexp -t'([-\'A-z\. ]+) is in excellent shape \(([0-9]+)\%\).' LITE_shape1
/def -aCgreen -F -mregexp -t'([A-z\'\. -]+) is in a good shape \(([0-9]+)\%\).' LITE_shape2
/def -aBCcyan -F -mregexp -t'([A-z\'\. -]+) is slightly hurt \(([0-9]+)\%\).' LITE_shape3
/def -aCcyan -F -mregexp -t'([A-z\'\. -]+) is noticeably hurt \(([0-9]+)\%\).' LITE_shape4
/def -aBCyellow -F -mregexp -t'([A-z\'\. -]+) is not in a good shape \(([0-9]+)\%\).' LITE_shape5
/def -aCyellow -F -mregexp -t'([A-z\'\. -]+) is in bad shape \(([0-9]+)\%\).' LITE_shape6
/def -aBCred -F -mregexp -t'([A-z\'\. -]+) is in very bad shape \(([0-9]+)\%\).' LITE_shape7
/def -aCred -F -mregexp -t'([A-z\'\. -]+) is near death \(([0-9]+)\%\).' LITE_shape8

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Equipment lites
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -P0BCyellow -mregexp -t'^([A-z ]*): (.*) <yellow glow>$' LITE_yellow_glow
/def -F -P0Cred -mregexp -t'^([A-z ]*): (.*) <red glow>$' LITE_red_glow
/def -F -P0BCblue -mregexp -t'^([A-z ]*): (.*) <blue glow>$' LITE_blue_glow
/def -F -P0BCgreen -mregexp -t'^([A-z ]*): (.*) <green glow>$' LITE_green_glow
/def -F -P0Cmagenta -mregexp -t'^([A-z ]*): (.*) <purple glow>$' LITE_purple_glow
/def -F -P0BCred -mregexp -t'^([A-z ]*): (.*) <orange glow>$' LITE_orange_glow
/def -F -P0BCwhite -mregexp -t'^([A-z ]*): (.*) <white glow>$' LITE_white_glow
/def -F -P0Ccyan -mregexp -t'^([A-z ]*): (.*) \(glowing\)$' LITE_glowing

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Money Lites
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -mregexp -P0BCyellow -t'^A (.*) of ([a-z]*) coins' LITE_coins_1
/def -F -mregexp -P0BCyellow -t'^([A-z,0-9 ]*) ([a-z]*) coin' LITE_coins_2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom Lite Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def add_lite = \
	/if (!getopts("c:n:b","")) \
		/return 0%; \
	/endif%; \
	/if (%{opt_c} =~ "" | %{opt_n} =~ "") \
		/d_error Syntax: /add_lite -c'<color>' -n'<name>' -b     (-b = bright/bold)%; \
		/break%; \
	/endif%; \
	/set lite_name=%{opt_n}%;\
	/set lite_name=$[replace(" ", "_", %{lite_name})]%;\
	/if ($[check_lited(%{lite_name})] = 1) \
		/d_pass Added [%{opt_n}] to the lites list.%; \
		/set lited_minerals=%{lite_name}:%{opt_c}:%{opt_b} %{lited_minerals}%; \
	/else \
		/d_pass Updating [%{opt_n}] on the lites list.%; \
		/set rem_lite_silent=1%; \
		/rem_lite %{opt_n}%; \
		/set lited_minerals=%{lite_name}:%{opt_c}:%{opt_b} %{lited_minerals}%; \
	/endif%; \
	/if (%{opt_b} == 1) \
		/def -F -mregexp -P0BC%{opt_c} -t'%{opt_n}' LITE_%{lite_name}_min_lite%; \
	/else \
		/def -F -mregexp -P0C%{opt_c} -t'%{opt_n}' LITE_%{lite_name}_min_lite%; \
	/endif%; \
	/set lited_minerals=$(/unique %{lited_minerals})%; \
	/if (get_setting("AUTO_save_lites") =~ "1") \
		/save_min_lites%; \
	/endif

/def check_lited=\
	/set num_mins=$(/length %{lited_minerals})%; \
	/set cou_mins=0%; \
	/set tmins=%{lited_minerals}%; \
	/set retmin=1%;\
	/while ({cou_mins}<{num_mins})\
		/set cmin=$(/pop tmins)%;\
		/eval /set in_mins=$[strstr(%{cmin}, %{1})]%; \
		/if (%{in_mins} >= 0) \
			/set retmin=0%; \
		/endif%; \
		/set cou_mins=$[{cou_mins}+1]%; \
	/done%; \
	/return %{retmin}

/def rem_lite = \
	/if (%{1} =~ "") \
		/d_error Syntax: /rem_lite <name>%; \
		/break%; \
	/endif%; \
	/set num_mins=$(/length %{lited_minerals})%;/set cou_mins=0%;/set tmins=%{lited_minerals}%;/set mineral_remmed=0%;\
	/while ({cou_mins}<{num_mins})\
		/set cmin=$(/pop tmins)%;\
		/eval /set in_mins=$[strstr(%{cmin}, %{1})]%; \
		/if ({in_mins} != -1) \
			/set tmp_minr=%{cmin}%;\
			/set tmp_min=$[replace(":", " ", %{tmp_minr})]%;\
			/set tmp_min=$(/car %{tmp_min})%; \
			/set mineral_remmed=1%;\
		/endif%; \
		/set cou_mins=$[{cou_mins}+1]%;\
	/done%; \
	/eval /set lited_minerals=$(/remove %{tmp_minr} %{lited_minerals})%; \
	/if (%{mineral_remmed} == 1) \
		/set lite_name=%{tmp_min}%;\
		/set lite_name=$[replace(" ", "_", %{lite_name})]%;\
		/undef %{lite_name}_min_lite%; \
		/if (%{rem_lite_silent} == 0) \
			/d_warn Removed [%{tmp_min}] from the lites list.%; \
		/endif%; \
		/if (get_setting("AUTO_save_lites") =~ "1") \
			/save_min_lites%; \
		/endif%; \
	/endif%; \
	/if (%{rem_lite_silent} == 1) \
		/set rem_lite_silent=0%; \
	/endif

/def list_lites = \
	/if ($(/length %{lited_minerals}) = 0) \
		/party_report _general No lites%; \
	/else \
		/set num_mins=$(/length %{lited_minerals})%; \
		/set cou_mins=0%; \
		/set tmins=%{lited_minerals}%; \
		/set tmp_minerals=%; \
		/while ({cou_mins}<{num_mins}) \
			/set cmin=$(/pop tmins)%; \
			/eval /set in_mins=$[strstr(%{cmin}, %{1})]%; \
			/if ({in_mins} != -1) \
				/set tmp_min=%{cmin}%; \
				/set tmp_min=$[replace(":", " ", %{tmp_min})]%; \
				/set tmp_min=$(/car %{tmp_min})%; \
				/set tmp_minerals=%{tmp_min} %{tmp_minerals}%; \
			/endif%; \
			/set cou_mins=$[{cou_mins}+1]%; \
		/done%; \
		/set tmp_minerals=$[substr(replace(" ", ", ", %{tmp_minerals}),0,-2)]%; \
		/party_report _general Lites: %{tmp_minerals}%; \
	/endif

/def save_min_lites= \
	/let striim= $[tfopen(strcat(%{TF_DIR},"/saves/custom_lites.tf"),"w")]%; \
	/test $[tfwrite(striim,strcat("/set lited_minerals=",%{lited_minerals}))]%; \
	/set num_mins=$(/length %{lited_minerals})%; \
	/set cou_mins=0%; \
	/set tmins=%{lited_minerals}%; \
	/set mineral_remmed=0%; \
	/while ({cou_mins}<{num_mins}) \
		/set cmin=$(/pop tmins)%; \
		/set tmp_minr=%{cmin}%; \
		/set tmp_min=$[replace(":", " ", %{tmp_minr})]%; \
		/set tmp_minn=$(/car %{tmp_min})%; \
		/set tmp_minc=$(/cadr %{tmp_min})%; \
		/set tmp_minb=$(/cddr %{tmp_min})%; \
		/if (%tmp_minb = 1) \
			/test $[tfwrite(striim,strcat("/add_lite -c'",%{tmp_minc},"' -n'",%{tmp_minn},"' -b"))]%; \
		/else \
			/test $[tfwrite(striim,strcat("/add_lite -c'",%{tmp_minc},"' -n'",%{tmp_minn},"'"))]%; \
		/endif%; \
		/set cou_mins=$[{cou_mins}+1]%; \
	/done%; \
	/test $[tfclose(striim)]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load Custom Lites
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/eval /load %{TF_DIR}/saves/custom_lites.tf
