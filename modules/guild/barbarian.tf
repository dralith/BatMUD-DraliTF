;;
;; DraliTF modules/guild/barbarian.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Commands:
;;   Command <arguments>      - Description
;;   bc [target]              - use battlecry at [target]
;;   grap [target]            - use grapple at [target]
;;   lure [target]            - use lure at [target]
;;   enrage                   - use enrage
;;   bb <target>              - check barbarian binfo for <target>
;;   bbr                      - check your own barbarian binfo
;;   rrg                      - reset rep gains
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module specific functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def unload_barb_module = \
	/purge -mregexp BARB_.*

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Skill commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -h'SEND {bcry}*' BARB_bcry = \
	@use 'battlecry' %{-1}%; \
	/party_report _general [Battlecry->%{-1}]%; \
	@terror %-1

/def -h'SEND {grap}*' BARB_grap = \
	@use 'grapple' %{-1}%; \
	/party_report _general [Grappling->%{-1}]

/def -h'SEND {lure}*' BARB_lure = \
	@use 'lure' %{-1}%; \
	/party_report _general [Luring->%{-1}]

/def -h'SEND {enrage}' BARB_enrager = \
	@use enrage%; \
	@emote tries his best to dance like Groo!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Burn command
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -h'SEND {lb}' BARB_burn = \
	@drop all corpse%; \
	@light torch%; \
	@barbburn%; \
	@ext torch%; \
	@get all corpse%; \
	/BARB_bbr

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Repu commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -h'SEND {bbr}' BARB_bbr = /BARB_bb

/def -h'SEND {bb}*' BARB_bb = \
    /if (%2 !~ "") \
	    /set rrbl 0%; \
	    /set rep_nam %2%; \
	/else \
	    /set rrbl 1%; \
	    /set rep_nam %{MY_NAME}%; \
	/endif%; \
    @barbarian binfo %{rep_nam}

/def -h'SEND {rrg}' BARB_rrg = \
	/set rep_gained_bl=0%; \
	/d_warn Reset rep gained counter.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc Triggers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -t'You feel your barbaric senses taking over you.' BARB_mastery1 = \
	@charge barbarically
/def -F -t'Your battle sense is at its peak!*' BARB_mastery2 = \
    @charge barbarically

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Torch creation crap
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Note: with these enabled you will automatically toss any non-cork torches ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -p1 -t'torch out in front of you for all to see.' BARB_torchmaker = \
	@grep sturdy look at torch

/def -p1 -mregexp -t'^This is a sturdy looking torch made of ([a-z ]*)\\.' BARB_check_torch = \
	/if (%{P1} !~ "cork") \
		@toss torch%; \
	/else \
		@keep torch%; \
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lure Results
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;You let out a ferocious cry which scares +1 rnd +1 state
;Your barbaric senses take over you. +3 rnd +3 state
;You succeed in breaking "+TNAME+"'s concentration!  broke skill/spell

;You foolishly start taunting (.*) from behind your friends.

/def -F -t'...but you fail to outwit your enemy, which * notices!' BARB_lure_fail1 = \
	/party_report _general [Lure Failed]

/def -F -t'* ignores your lure.' BARB_LURE_fail2 = \
	/party_report _general [%{P1} is immune to lure]

/def -F -t'Alas, * is not standing in the front row.' BARB_LURE_fail3 = \
	/party_report _general [%{P1} isn't in the front row]

/def -F -t'* doesn\'t make a careless attack, * seems to know that trick already.' BARB_lure_fail4 = \
	/party_report _general [%{P1} has been lured already!]

/def -F -t'You fail to make any use of your opportunity!' BARB_lure1 = \
	/set stunrounds=0%; \
	/repeat -0:00:01 1 /BARB_lurereport

/def -F -t'You have trouble but manage to deliver a kick in*' BARB_lure2 = \
	/set stunrounds=1%; \
	/repeat -0:00:01 1 /BARB_lurereport

/def -F -t'You valiantly strike back at * while*' BARB_lure3 = \
	/set stunrounds=2%; \
	/repeat -0:00:01 1 /BARB_lurereport

/def -F -t'You see opportunity and butt the shaft of your*' BARB_lure4 = \
	/set stunrounds=3%; \
	/repeat -0:00:01 1 /BARB_lurereport

/def -F -t'You go \'GOTCHA!\' and strike your weapon into*' BARB_lure5 = \
	/set stunrounds=4+%; \
	/repeat -0:00:01 1 /BARB_lurereport

/def -F -t'But *\'s extreme knowledge in stunned maneuvers*' BARB_lure6 = \
	/set stunrounds=0

/def -F -t'Your barbaric senses take over you.' BARB_lure_bsense = \
	/set bsenses=BARBARICALLY Lured

/def -F -t'You succeed in breaking *\'s concentration!' BARB_lure_break = \
	/set broke_con=1

/def BARB_lurereport = \
	/if (%{broke_con} =~ 1) \
		/party_report _general [%{bsenses} %{stunrounds} rounds] (broke skill/spell)%; \
	/else \
		/party_report _general [%{bsenses} %{stunrounds} rounds]%; \
	/endif%; \
	/set broke_con=0%; \
	/set b_stunrounds=0%; \
	/set stunrounds=0%; \
	/set bsenses=Lured

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Cleave trigs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set BARB_cleave_cnt0=0
/set BARB_cleave_cnt1=0
/set BARB_cleave_cnt2=0
/set BARB_cleave_cnt3=0
/set BARB_cleave_cnt4=0
/set BARB_cleave_cnt5=0
/set BARB_cleave_cnt6=0
/set BARB_cleave_cnt7=0
/set BARB_cleave_cnt8=0
/set BARB_cleave_cnt9=0
/set BARB_cleave_cnt10=0
/set BARB_cleave_cnt11=0
/set BARB_cleave_cnt12=0
/set BARB_cleave_cnt13=0
/set BARB_cleave_cnt14=0
/set BARB_cleave_cnt15=0
/set BARB_cleave_cnt16=0
/set BARB_cleave_cnt17=0
/set BARB_cleave_cnt18=0
/set BARB_cleave_cnt19=0
/set BARB_cleave_cnt20=0

/def -mregexp -F -t'^You cleave your opponent a glancing blow to the shield arm.' BARB_cleave_0 = \
;	/set BARB_cleave_cnt0=[%{BARB_cleave_cnt0}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You lash out, cleaving your foe\'s instep.' BARB_cleave_1 = \
;	/set BARB_cleave_cnt1=[%{BARB_cleave_cnt1}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You take aim and cleave at your foe\'s exposed thigh.' BARB_cleave_2 = \
;	/set BARB_cleave_cnt2=[%{BARB_cleave_cnt2}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You swiftly cleave your foe\'s exposed weapon hand, drawing a bloody line.' BARB_cleave_3 = \
;	/set BARB_cleave_cnt3=[%{BARB_cleave_cnt3}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^Your enemy howls as you cleave a crushing blow to the elbow.' BARB_cleave_4 = \
;	/set BARB_cleave_cnt4=[%{BARB_cleave_cnt4}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^Your enemy wails in agony as you cleave ([A-z]+) groin!' BARB_cleave_5 = \
;	/set BARB_cleave_cnt5=[%{BARB_cleave_cnt5}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You whip your weapon out, delivering a smash to your foe\'s kneecap.' BARB_cleave_6 = \
;	/set BARB_cleave_cnt6=[%{BARB_cleave_cnt6}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You change your cleave in mid-motion, and pummel foe\'s midsection instead.' BARB_cleave_7 = \
;	/set BARB_cleave_cnt7=[%{BARB_cleave_cnt7}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You knock your opponent\'s weapon aside, and cleave ([A-z]+) open chest.' BARB_cleave_8 = \
;	/set BARB_cleave_cnt8=[%{BARB_cleave_cnt8}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You make a quick lunge, cleaving your opponent across the jaw.' BARB_cleave_9 = \
;	/set BARB_cleave_cnt9=[%{BARB_cleave_cnt9}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You step forward and deliver a crushing blow to your enemy\'s temple with the flat of your blade.' BARB_cleave_10 = \
;	/set BARB_cleave_cnt10=[%{BARB_cleave_cnt10}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^Your enemy gasps as you cleave a wound across ([A-z]+) forehead.' BARB_cleave_11 = \
;	/set BARB_cleave_cnt11=[%{BARB_cleave_cnt11}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You begin your cleave, but see a new opportunity and smash your foe with the haft of your weapon!\n' BARB_cleave_12 = \
;	/set BARB_cleave_cnt12=[%{BARB_cleave_cnt12}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You turn your enemy\'s lunge aside and cleave in one swift movement.' BARB_cleave_13 = \
;	/set BARB_cleave_cnt13=[%{BARB_cleave_cnt13}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You swiftly cleave your enemy across the throat, almost severing ([A-z]+) windpipe.' BARB_cleave_14 = \
;	/set BARB_cleave_cnt14=[%{BARB_cleave_cnt14}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You use all your strength, and POUND a mighty blow to foe\'s exposed chest.' BARB_cleave_15 = \
;	/set BARB_cleave_cnt15=[%{BARB_cleave_cnt15}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You LUNGE, cleaving your enemy HARD on the temple, causing a deep gash.' BARB_cleave_16 = \
;	/set BARB_cleave_cnt16=[%{BARB_cleave_cnt0}+16]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You quickly jump forward and deliver a rending blow to foe\'s collarbone.' BARB_cleave_17 = \
;	/set BARB_cleave_cnt17=[%{BARB_cleave_cnt17}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You lunge forward, and CLEAVE your enemy across the ribcage.' BARB_cleave_18 = \
;	/set BARB_cleave_cnt18=[%{BARB_cleave_cnt18}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^Your battle sense is at its peak!  Time seems to slow down, your enemy seems pitiful!' BARB_cleave_19 = \
;	/set BARB_cleave_cnt19=[%{BARB_cleave_cnt19}+1]%; \
	@@use 'cleave' %{target}
/def -mregexp -F -t'^You make a great cleaving maneuver, but your enemy blocks your attack.' BARB_cleave_miss = \
;	/set BARB_cleave_20=[%{BARB_cleave_20}+1]%; \
	@@use 'cleave' %{target}

;...And you turn suddenly and STRIKE again.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Barb Repu/Burn triggers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set rep_gained_bl=0
/set rep_old_bl=0

/def -F -ag -mregexp -t'^Reputation:  (.*)' BARB_rep_tit = /set rep_title=%{P1}
/def -F -ag -mregexp -t'^Guild level: (.*).' BARB_rep_gl = /set rep_glvl=%{P1}
/def -F -ag -mregexp -t'^Joined:  (.*)' BARB_rep_join = /set rep_jn=%{P1}
/def -F -ag -mregexp -t'^Reputation bar:' BARB_gag_rep

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Looting and burning lites/rep worth
;; Following triggers are stolen from Beanos' Barbarian triggers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -t'You feel nasty.'                 BARB_lb1 = /substitute -p @{Cwhite}%* (1-3)@{n}
/def -F -t'You feel wicked.'                BARB_lb2 = /substitute -p @{BCwhite}%* (3-4)@{n}
/def -F -t'You feel bad.'                   BARB_lb3 = /substitute -p @{Cyellow}%* (4-8)@{n}
/def -F -t'You feel barbaric.'              BARB_lb4 = /substitute -p @{BCyellow}%* (7-8)@{n}
/def -F -t'Now you ARE wicked!'             BARB_lb5 = /substitute -p @{Cgreen}%* (7-14)@{n}
/def -F -t'Now you ARE bad!'                BARB_lb6 = /substitute -p @{BCgreen}%* (15-20)@{n}
/def -F -t'Now you ARE barbaric!'           BARB_lb7 = /substitute -p @{Cred}%* (15-29)@{n}
/def -F -t'You wallow in reputation.'       BARB_lb8 = /substitute -p @{BCred}%* (25-34)@{n}
/def -F -t'You feel Groo smiling upon you.' BARB_lb9 = /substitute -p @{BCred}%* (46+)@{n}

/def BARB_repcheck_ = \
	/set tmp_title %{rep_title}%; \
	/if (get_setting("AUTO_rep_report") = 1) \
		/if (%{rrbl} != 0) \
			/set rep_change_bl $[%{rep_n_bl} - %{rep_old_bl}]%; \
			/set rep_old_bl $[%{rep_n_bl} + 1 - 1]%; \
			/set rep_gained_bl $[%{rep_gained_bl} + %{rep_change_bl}]%;\
			@say Title[$[pad(%{tmp_title},25)]] Rep[$[pad(%{rep_n_bl},7)]] Diff[$[pad(%{rep_change_bl},3)]] Gained[$[pad(%{rep_gained_bl},5)]]%;\
		/elseif (%{rrbl} != 1) \
			/set rep_change_bl 0%;\
			/set tmp_nam $[strcat(toupper(substr(%{rep_nam},0,1)),substr(%{rep_nam},1))]:%; \
			@say $[pad(%{tmp_nam},-12)] Lvl[$[pad(%{rep_glvl},3)]] Title[$[pad(%{tmp_title},25)]] Rep[$[pad(%{rep_n_bl},7)]]%;\
		/endif%; \
	/elseif (get_setting("AUTO_rep_report") = 0) \
		/if (%{rrbl} != 0) \
			/set rep_change_bl $[%{rep_n_bl} - %{rep_old_bl}]%; \
			/set rep_old_bl $[%{rep_n_bl} + 1 - 1]%; \
			/set rep_gained_bl $[%{rep_gained_bl} + %{rep_change_bl}]%;\
			/d_pass Lvl[$[pad(%{rep_glvl},3)]] Title[$[pad(%{tmp_title},25)]] Rep[$[pad(%{rep_n_bl},7)]] Diff[%{rep_change_bl}] Gained[%{rep_gained_bl}]%;\
		/elseif (%{rrbl} != 1) \
			/set rep_change_bl 0%;\
			/d_pass Lvl[$[pad(%{rep_glvl},3)]] Title[$[pad(%{tmp_title},25)]] Rep[$[pad(%{rep_n_bl},7)]]%;\
		/endif%; \
	/endif%; \
	/set guild_status=Rep: %{rep_n_bl}%; \
	/status_edit -r1 "[":1 guild_status:27 "]":1%; \
	/BARB_save_repu

/def -i -ag -mregexp -t"^\[(X*)(@*)(#*)(:*)(\.*)\]$" BARB_rep_bl =\
	/let repval=$[(strlen(%{P1})*10000)]%; \
	/let repval=$[(strlen(%{P2})*1000) + %{repval}]%; \
	/let repval=$[(strlen(%{P3})*100) + %{repval}]%; \
	/let repval=$[(strlen(%{P4})*10) + strlen(%{P5}) + %{repval}]%; \
	/set rep_n_bl=%{repval}%; \
  	/BARB_repcheck_

/def BARB_save_repu = \
	/let striim=$[tfopen(strcat(%{TF_DIR},"/saves/repu.tf"),"w")]%; \
	/test $[tfwrite(%{striim}, strcat("/set rep_old_bl=",%{rep_old_bl}))]%; \
	/test $[tfwrite(%{striim}, strcat("/set rep_gained_bl=",%{rep_gained_bl}))]%; \
	/test $[tfclose(%{striim})]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load last known rep values
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/eval /load %{TF_DIR}/saves/repu.tf
