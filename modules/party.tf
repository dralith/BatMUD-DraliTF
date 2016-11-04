;;
;; DraliTF modules/party.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set a party status short alias so first line gag works
;; And a party reset alias to reset both ingame stats and trigger stats
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module specific functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def unload_party_module = \
	/purge PARTY_*%; \
	/purge *party_*

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Party status commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -h'SEND {pss}*' COMM_pss = \
	/if (get_setting("PARTY_lite") = 1) \
		/set pssgag=1%; \
	/endif%; \
	@pss%-1

/def -h'SEND {preset}*' COMM_p_reset = \
	/party_reset_members%; \
	@party reset

/eval /set psFile=$[tfopen("party_status", "w")]
/if (%psFile =~ -1) \
	/sys mkfifo party_status%; \
	/eval /set psFile=$[tfopen("party_status", "w")]%; \
/endif
/test (tfflush(%psFile, "off"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Gag and replace Party status [short] output
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/def -t',-----------------------------------------------------------------------------\.' PARTY_line1 = \
	/unset plr_%{plc_1_1}%;/unset plr_%{plc_1_2}%;/unset plr_%{plc_1_3}%; \
	/unset plr_%{plc_2_1}%;/unset plr_%{plc_2_2}%;/unset plr_%{plc_2_3}%; \
	/unset plr_%{plc_3_1}%;/unset plr_%{plc_3_2}%;/unset plr_%{plc_3_3}%; \
	/if ({pssgag} == 1)\
        /echo ,-------------------------------------------------------------------------------------------------.%; \
		/substitute -ag%;\
	/endif

/def -mregexp -t'\| Party (.*)\|' PARTY_line2 = \
	/if (get_setting("PARTY_lite") == 1)\
        /echo | Party %{P1};-------------------.%;\
		/substitute -ag%;\
	/endif

/def -mregexp -t'\| Created: (.*)\|' PARTY_line3 = \
	/if (get_setting("PARTY_lite") == 1)\
	    /echo | Created: %{P1}|=Party Status Crap=|%;\
		/substitute -ag%;\
	/endif


/def -t'|========================================================|====================|' PARTY_line4 = \
	/if (get_setting("PARTY_lite") == 1)\
	        /echo |========================================================|====================|===================|%;\
		/substitute -ag%;\
	/endif


/def -t'| Place  Name      Status      HP         SP        EP   | Lvl |   Experience |' PARTY_line5 = \
	/if (get_setting("PARTY_lite") == 1)\
	        /echo | Place  Name      Status      HP         SP        EP   | Lvl |   Experience | In party | XpRate |%;\
		/substitute -ag%;\
	/endif

/def -t'|========================================================|=====|==============|' PARTY_line6 = \
	/if (get_setting("PARTY_lite") == 1)\
	        /echo |========================================================|=====|==============|==========|========|%;\
		/substitute -ag%;\
	/endif

/def -t'`-----------------------------------------------------------------------------\'' PARTY_line7 = \
	/if (get_setting("PARTY_lite") == 1)\
        /echo `-------------------------------------------------------------------------------------------------'%; \
		/substitute -ag%;\
        /set psTopLine=,-----------------------------------------------------------------.%; \
        /set psDivider= }==================={ }==================={ }==================={ %; \
        /set psBotLine=`-----------------------------------------------------------------'%; \
		/test $[tfwrite(%psFile,%psTopLine)]%; \
		/test $[tfwrite(%psFile,strcat("| ",pad(%plc_1_1, -19)," | ",pad(%plc_1_2, -19)," | ",pad(%plc_1_3, -19)," |"))]%; \
		/test $[tfwrite(%psFile,\
strcat("| ",lite_by_percent_3($(/eval /nth 6 %%{plr_%{plc_1_1}})),pad($(/eval /nth 6 %%{plr_%{plc_1_1}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 9 %%{plr_%{plc_1_1}})),pad($(/eval /nth 9 %%{plr_%{plc_1_1}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 12 %%{plr_%{plc_1_1}})),pad($(/eval /nth 12 %%{plr_%{plc_1_1}}), -5),lite_by_percent_3(777), \
      " | ",lite_by_percent_3($(/eval /nth 6 %%{plr_%{plc_1_2}})),pad($(/eval /nth 6 %%{plr_%{plc_1_2}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 9 %%{plr_%{plc_1_2}})),pad($(/eval /nth 9 %%{plr_%{plc_1_2}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 12 %%{plr_%{plc_1_2}})),pad($(/eval /nth 12 %%{plr_%{plc_1_2}}), -5),lite_by_percent_3(777), \
      " | ",lite_by_percent_3($(/eval /nth 6 %%{plr_%{plc_1_3}})),pad($(/eval /nth 6 %%{plr_%{plc_1_3}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 9 %%{plr_%{plc_1_3}})),pad($(/eval /nth 9 %%{plr_%{plc_1_3}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 12 %%{plr_%{plc_1_3}})),pad($(/eval /nth 12 %%{plr_%{plc_1_3}}), -5),lite_by_percent_3(777)," |"))]%; \
		/test $[tfwrite(%psFile,%psDivider)]%; \
		/test $[tfwrite(%psFile,strcat("| ",pad(%plc_2_1, -19)," | ",pad(%plc_2_2, -19)," | ",pad(%plc_2_3, -19)," |"))]%; \
		/test $[tfwrite(%psFile,\
strcat("| ",lite_by_percent_3($(/eval /nth 6 %%{plr_%{plc_2_1}})),pad($(/eval /nth 6 %%{plr_%{plc_2_1}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 9 %%{plr_%{plc_2_1}})),pad($(/eval /nth 9 %%{plr_%{plc_2_1}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 12 %%{plr_%{plc_2_1}})),pad($(/eval /nth 12 %%{plr_%{plc_2_1}}), -5),lite_by_percent_3(777), \
      " | ",lite_by_percent_3($(/eval /nth 6 %%{plr_%{plc_2_2}})),pad($(/eval /nth 6 %%{plr_%{plc_2_2}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 9 %%{plr_%{plc_2_2}})),pad($(/eval /nth 9 %%{plr_%{plc_2_2}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 12 %%{plr_%{plc_2_2}})),pad($(/eval /nth 12 %%{plr_%{plc_2_2}}), -5),lite_by_percent_3(777), \
      " | ",lite_by_percent_3($(/eval /nth 6 %%{plr_%{plc_2_3}})),pad($(/eval /nth 6 %%{plr_%{plc_2_3}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 9 %%{plr_%{plc_2_3}})),pad($(/eval /nth 9 %%{plr_%{plc_2_3}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 12 %%{plr_%{plc_2_3}})),pad($(/eval /nth 12 %%{plr_%{plc_2_3}}), -5),lite_by_percent_3(777)," |"))]%; \
       	/test $[tfwrite(%psFile,%psDivider)]%; \
		/test $[tfwrite(%psFile,strcat("| ",pad(%plc_3_1, -19)," | ",pad(%plc_3_2, -19)," | ",pad(%plc_3_3, -19)," |"))]%; \
		/test $[tfwrite(%psFile,\
strcat("| ",lite_by_percent_3($(/eval /nth 6 %%{plr_%{plc_3_1}})),pad($(/eval /nth 6 %%{plr_%{plc_3_1}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 9 %%{plr_%{plc_3_1}})),pad($(/eval /nth 9 %%{plr_%{plc_3_1}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 12 %%{plr_%{plc_3_1}})),pad($(/eval /nth 12 %%{plr_%{plc_3_1}}), -5),lite_by_percent_3(777), \
      " | ",lite_by_percent_3($(/eval /nth 6 %%{plr_%{plc_3_2}})),pad($(/eval /nth 6 %%{plr_%{plc_3_2}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 9 %%{plr_%{plc_3_2}})),pad($(/eval /nth 9 %%{plr_%{plc_3_2}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 12 %%{plr_%{plc_3_2}})),pad($(/eval /nth 12 %%{plr_%{plc_3_2}}), -5),lite_by_percent_3(777), \
      " | ",lite_by_percent_3($(/eval /nth 6 %%{plr_%{plc_3_3}})),pad($(/eval /nth 6 %%{plr_%{plc_3_3}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 9 %%{plr_%{plc_3_3}})),pad($(/eval /nth 9 %%{plr_%{plc_3_3}}), -5),lite_by_percent_3(777), \
       "  ",lite_by_percent_3($(/eval /nth 12 %%{plr_%{plc_3_3}})),pad($(/eval /nth 12 %%{plr_%{plc_3_3}}), -5),lite_by_percent_3(777)," |"))]%; \
		/test $[tfwrite(%psFile,%psBotLine)]%; \
		/test $[tfflush(%psFile)]%; \
;		/test $[tfclose(%psFile)]%; \
        /set pssgag=0%;\
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Parse each party members status
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/def -F -mregexp -t'^\|.([0-9?].[0-9?]*) +([A-z+]*) (.*) ([0-9-]+)\( *([0-9-]+)\) +([0-9-]+)\( *([0-9-]+)\) *([0-9-]+)\( *([0-9-]+)\) \| ([0-9A-Z ]*) \| ([0-9 ]*) \|' PARTY_lites = \
	/set PARTY_name=%{P2}%;/set PARTY_hp=%{P4}%;/set PARTY_mhp=%{P5}%;/set PARTY_sp=%{P6}%;/set PARTY_msp=%{P7}%;/set PARTY_ep=%{P8}%;/set PARTY_mep=%{P9}%;\
	/set check_mem=$[strstr(%{party_members}, %{PARTY_name})]%; \
	/if (%{check_mem} == -1) \
		/set party_members=%{party_members} %{PARTY_name}:$[time()]%; \
	/endif%; \
	/set PARTY_hp_percent=$[PARTY_hp*100/PARTY_mhp]%;/set PARTY_sp_percent=$[PARTY_sp*100/PARTY_msp]%;/set PARTY_ep_percent=$[PARTY_ep*100/PARTY_mep]%;\
	/set PARTY_hp=$[pad(%{P4},2)]%;/set PARTY_mhp=$[pad(%{P5},4)]%;/set PARTY_sp=$[pad(%{P6},4)]%;/set PARTY_msp=$[pad(%{P7},4)]%;/set PARTY_ep=$[pad(%{P8},3)]%;/set PARTY_mep=$[pad(%{P9},3)]%;\
        /set PARTY_hp=$[lite_by_percent({PARTY_hp_percent},{PARTY_hp})]%;/set PARTY_mhp=$[lite_by_percent(%{PARTY_hp_percent},%{PARTY_mhp})]%; \
        /set PARTY_sp=$[lite_by_percent({PARTY_sp_percent},{PARTY_sp})]%;/set PARTY_msp=$[lite_by_percent(%{PARTY_sp_percent},%{PARTY_msp})]%; \
        /set PARTY_ep=$[lite_by_percent({PARTY_ep_percent},{PARTY_ep})]%;/set PARTY_mep=$[lite_by_percent(%{PARTY_ep_percent},%{PARTY_mep})]%; \
	/if (get_setting("PARTY_lite") = 1) \
		/set pssgag=1%; \
		/get_in_party_time %{PARTY_name}%;\
		/set pctime=$(/car %{tmp_rett})%; \
		/set pjtime=$(/cadr %{tmp_rett})%; \
		/set pttime=$[(trunc(%{pctime} - %{pjtime})) / 60 + 1]%; \
		/set member_exp=%{P11}%;\
		/if (%{member_exp} == 0) \
        		/set member_party_rate=NoKill%; \
		/else \
			/set member_party_rate=$[%{member_exp} / %{pttime}]%; \
		/endif%; \
		/if (%{member_party_rate} <= 100) /set member_party_ratex=@{BCred}$[pad(%{member_party_rate},6)]@{n}%; /endif%; \
		/if (%{member_party_rate} >= 100) /set member_party_ratex=@{Cred}$[pad(%{member_party_rate},6)]@{n}%; /endif%; \
		/if (%{member_party_rate} >= 500) /set member_party_ratex=@{Cyellow}$[pad(%{member_party_rate},6)]@{n}%; /endif%; \
		/if (%{member_party_rate} >= 1000) /set member_party_ratex=@{BCyellow}$[pad(%{member_party_rate},6)]@{n}%; /endif%; \
		/if (%{member_party_rate} >= 5000) /set member_party_ratex=@{Cwhite}$[pad(%{member_party_rate},6)]@{n}%; /endif%; \
		/if (%{member_party_rate} >= 10000) /set member_party_ratex=@{BCwhite}$[pad(%{member_party_rate},6)]@{n}%; /endif%; \
		/if (%{member_party_rate} >= 15000) /set member_party_ratex=@{Cgreen}$[pad(%{member_party_rate},6)]@{n}%; /endif%; \
		/if (%{member_party_rate} >= 20000) /set member_party_ratex=@{BCgreen}$[pad(%{member_party_rate},6)]@{n}%; /endif%; \
		/set in_party_time=$[timer(%{pjtime})]%; \
		/eval /echo -p | %{P1}  %{P2} %{P3} %{PARTY_hp}(%{PARTY_mhp}) %{PARTY_sp}(%{PARTY_msp}) %{PARTY_ep}(%{PARTY_mep}) | %{P10} | %{P11} | $[pad(%{in_party_time},8)] | %{member_party_ratex} |%; \
		/if (%{P1} != "?.?") \
			/set plc_$[replace(".","_",%{P1})]=%{P2}%; \
			/set plr_$[replace(" ","",%{P2})]=%{P1} %{P2} $[replace(" ","",%{P3})] %{P4} %{P5} $[trunc(%P4*100/%P5)] %{P6} %{P7} $[trunc(%P6*100/%P7)] %{P8} %{P9} $[trunc(%P8*100/%P9)] %{P10} $[replace(" ","",%{P11})] %{member_party_rate}%; \
		/else \
			/set plr_$[replace(" ","",%{P2})]=%{P1} %{P2} $[replace(" ","",%{P3})] %{P4} %{P5} $[trunc(%P4*100/%P5)] %{P6} %{P7} $[trunc(%P6*100/%P7)] %{P8} %{P9} $[trunc(%P8*100/%P9)] %{P10} $[replace(" ","",%{P11})] %{member_party_rate}%; \
		/endif%; \
		/substitute -ag%;\
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc party triggers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/def -abBCred -F -t'You are the new leader*' PARTY_got_lead = @pff
/def -t'* offers you membership to party*' PARTY_join = /if (get_setting("AUTO_party_join")=1) @party join%;/set party_members=%{MY_NAME}:$[time()]%;@pss%; /endif
/def -ag -h'SEND {plv}' PARTY_leave = @party leave%;/set party_members=%;/set in_party=0
/def -ag -h'SEND {pc}' PARTY_create = \
	@party create meh%; \
	/set party_members=%{MY_NAME}:$[trunc(time())]%; \
	/set in_party=1
/def -ag -h'SEND {pj}' PARTY_join_CMD = @party join%;/set party_members=%{MY_NAME}:$[time()]%;@pss

/def -mregexp -F -t'^You kick ([A-z]*) out of party.' PARTY_kick_member = /rem_party_member %{P1}
/def -mregexp -F -t'^([A-z]*) left the party.' PARTY_left_member = /rem_party_member %{P1}

/def -F -mregexp -t'([A-z]*) steps to the .* side of .* row and starts following the leader.' PARTY_joined = \
	/if (%{in_party} == 1) /set party_members=%{party_members} %{P1}:$[trunc(time())]%; /endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Database functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/def get_in_party_time = \
	/if ($(/length %{party_members}) = 0) \
		/echo -aBCred [TF]: Not in party%; \
	/else \
		/set num_mems=$(/length %{party_members})%; \
		/set cou_mems=0%; \
		/set tmems=%{party_members}%; \
		/set tmp_members=%;/set tmp_mem_time=%; \
		/while ({cou_mems}<{num_mems})\
			/set cmem=$(/pop tmems)%;\
			/set tmp_mem=%{cmem}%;\
			/set tmp_mem=$[replace(":", " ", %{tmp_mem})]%;\
			/set tmp_mem2=$(/car %{tmp_mem})%; \
			/if (%{tmp_mem2} =~ %{1}) \
				/set tmp_mem_time=$(/cadr %{tmp_mem})%; \
				/set tmp_members=%{tmp_mem2}%;\
			/endif%; \
			/set cou_mems=$[{cou_mems}+1]%;\
		/done%; \
		/set curr_time=$[time()]%; \
		/set tmp_rett=%{curr_time} %{tmp_mem_time}%; \
	/endif

/def rem_party_member = \
	/set num_mems=$(/length %{party_members})%; \
	/set cou_mems=0%; \
	/set tmems=%{party_members}%; \
	/while ({cou_mems}<{num_mems})\
		/set cmem=$(/pop tmems)%;\
		/set tmp_mem=%{cmem}%;\
		/set tmp_mem=$[replace(":", " ", %{tmp_mem})]%;\
		/set tmp_mem=$(/car %{tmp_mem})%; \
		/if (%{tmp_mem} =~ %{1}) \
			/set rem_mem=%{cmem}%; \
		/endif%; \
		/set cou_mems=$[{cou_mems}+1]%;\
	/done%; \
	/eval /unset plr_%{rem_mem}%; \
	/eval /set party_members=$(/remove %{rem_mem} %{party_members})

/def party_reset_members = \
	/set num_mems=$(/length %{party_members})%; \
	/set cou_mems=0%;/set tmp_mems=%; \
	/set tmems=%{party_members}%; \
	/while ({cou_mems}<{num_mems})\
		/set cmem=$(/pop tmems)%;\
		/set tmp_mem=%{cmem}%;\
		/set tmp_mem=$[replace(":", " ", %{tmp_mem})]%;\
		/set tmp_mem=$(/car %{tmp_mem})%; \
		/set tmp_mems=%{tmp_mems} %{tmp_mem}:$[time()]%; \
		/set cou_mems=$[{cou_mems}+1]%;\
	/done%; \
	/set party_members=%{tmp_mems}
