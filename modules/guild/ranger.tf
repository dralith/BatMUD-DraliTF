;;
;; DraliTF modules/guild/ranger.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Commands: (also viewable via /help setup)
;;   Command <arguments>      - Description
;;   rinit                    - Reset ranger statistics
;;   bf [target]              - use bladed fury at [target]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module specific functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def unload_ranger_module = \
	/purge -mregexp RANGER_.*%; \
	/COMMAND_cleanup ranger

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ranger Commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -h'SEND {rinit}' RANGER_reset = \
    /set bf0=0%; /set bf1=0%; /set bf2=0%; /set bf3=0%; /set bf4=0%; /set bf5=0%; \
	/set bf6=0%; /set bf7=0%; /set bf8=0%; /set bf9=0%; /set bf10=0%; /set bfmul=0%; \
	/set bfmas=0%; /set bfdmg=0

/COMMAND_register_i -n"bf" -m"ranger" -a"use 'bladed fury' \$*"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enhanced peer quoter
;; triggered off of: <name> [party]: peer <direction>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -mregexp -F -t'^([A-z]*) (\(|[[]|{|<)party([]}]|>|\)): peer (.*)' RANGER_qpeer =\
	quote 'peer %{P4}' emote

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bladed Fury repeater/counter
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; These triggers may be considered illegal by some, use at your own         ;;
;; disgression. (note: I've been using them for at least 6 years without a   ;;
;; problem yet, but I may just be lucky)                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;0 damage
/def -F -mregexp -t' laughs at your puny attempt to harm ' RANGER_bladed_fury_0 = \
	@bf%; \
	/set bf0=$[bf0+1]%; \
	/set bfdmg=$[bfdmg+0]%; \
	/RANGER_save
;1-30 damage
/def -F -mregexp -t' stumbles from the force of your attack.' RANGER_bladed_fury_1 = \
	@bf%; \
	/set bf1=$[bf1+1]%; \
	/set bfdmg=$[bfdmg+15]%; \
	/RANGER_save
;31-50 damage
/def -F -mregexp -t' is knocked back from the force of your attack.' RANGER_bladed_fury_2 = \
	@bf%; \
	/set bf2=$[bf2+1]%; \
	/set bfdmg=$[bfdmg+40]%; \
	/RANGER_save
;51-70
/def -F -mregexp -t'^Your attack causes (.*) to wince from immense pain.' RANGER_bladed_fury_3 = \
	@bf%; \
	/set bf3=$[bf3+1]%; \
	/set bfdmg=$[bfdmg+60]%; \
	/RANGER_save
;71-90
/def -F -mregexp -t' eyes widden in terror as you ruthlessly wound ' RANGER_bladed_fury_4 = \
	@bf%; \
	/set bf4=$[bf4+1]%; \
	/set bfdmg=$[bfdmg+80]%; \
	/RANGER_save
;91-110
/def -F -mregexp -t'^With great precision and speed you maliciously assault ' RANGER_bladed_fury_5 = \
	@bf%; \
	/set bf5=$[bf5+1]%; \
	/set bfdmg=$[bfdmg+100]%; \
	/RANGER_save
;111-130
/def -F -mregexp -t'^Your ruthless onslaught of attacks causes ' RANGER_bladed_fury_6 = \
	@bf%; \
	/set bf6=$[bf6+1]%; \
	/set bfdmg=$[bfdmg+120]%; \
	/RANGER_save
;131-150
/def -F -mregexp -t' reels from your onslaught and collapses ' RANGER_bladed_fury_7 = \
	@bf%; \
	/set bf7=$[bf7+1]%; \
	/set bfdmg=$[bfdmg+140]%; \
	/RANGER_save
;151-170
/def -F -mregexp -t' squeals in utter horrifying agony as ([a-z]*) blood' RANGER_bladed_fury_8 = \
	@bf%; \
	/set bf8=$[bf8+1]%; \
	/set bfdmg=$[bfdmg+160]%; \
	/RANGER_save
;171-200
/def -F -mregexp -t' screams of agony deafen you as you cruelly chop ' RANGER_bladed_fury_9 = \
	@bf%; \
	/set bf9=$[bf9+1]%; \
	/set bfdmg=$[bfdmg+185]%; \
	/RANGER_save
;201+
/def -F -mregexp -t'^Your inhumanly cruel onslaught on ' RANGER_bladed_fury_10 = \
	@bf%; \
	/set bf10=$[bf10+1]%; \
	/set bfdmg=$[bfdmg+200]%; \
	/RANGER_save


/def -F -mregexp -t' AND quickly hit again!' RANGER_multiple_fury = \
	/set bfmul=$[bfmul+1]%; \
	/RANGER_save

/def -F -mregexp -t'^Using your mastery of Bladed Fury you hit extra HARD!' RANGER_master_fury = \
	/set bfmas=$[bfmas+1]%; \
	/RANGER_save

/def -F -h'SEND {bfcount}' RANGER_bfcount = \
    /let totalbf=$[bf0+bf1+bf2+bf3+bf4+bf5+bf6+bf7+bf8+bf9+bf10]%; \
	/echo ,-----------------------------------------------------------------------------.%; \
	/echo | Message:           Hit:  \%:   Dam:   | Message:           Hit:  \%:   Dam:   |%; \
	/echo |-----------------------------------------------------------------------------|%; \
	/echo | $[pad("Laughs",-17)] $[pad(%{bf0},5)] $[pad($[%{bf0}*100/%{totalbf}],2)]\% $[pad(%{bf0}*0,8)] | \
	        $[pad("Stumbles",-17)] $[pad(%{bf1},5)] $[pad($[%{bf1}*100/%{totalbf}],2)]\% $[pad(%{bf1}*15,8)] |%; \
	/echo | $[pad("Knocked",-17)] $[pad(%{bf2},5)] $[pad($[%{bf2}*100/%{totalbf}],2)]\% $[pad(%{bf2}*40,8)] | \
	        $[pad("Winced",-17)] $[pad(%{bf3},5)] $[pad($[%{bf3}*100/%{totalbf}],2)]\% $[pad(%{bf3}*60,8)] |%; \
	/echo | $[pad("Terror",-17)] $[pad(%{bf4},5)] $[pad($[%{bf4}*100/%{totalbf}],2)]\% $[pad(%{bf4}*80,8)] | \
	        $[pad("Malicious",-17)] $[pad(%{bf5},5)] $[pad($[%{bf5}*100/%{totalbf}],2)]\% $[pad(%{bf5}*100,8)] |%; \
	/echo | $[pad("Ruthless",-17)] $[pad(%{bf6},5)] $[pad($[%{bf6}*100/%{totalbf}],2)]\% $[pad(%{bf6}*120,8)] | \
	        $[pad("Reels",-17)] $[pad(%{bf7},5)] $[pad($[%{bf7}*100/%{totalbf}],2)]\% $[pad(%{bf7}*140,8)] |%; \
	/echo | $[pad("Squeals",-17)] $[pad(%{bf8},5)] $[pad($[%{bf8}*100/%{totalbf}],2)]\% $[pad(%{bf8}*160,8)] | \
	        $[pad("Screams",-17)] $[pad(%{bf9},5)] $[pad($[%{bf9}*100/%{totalbf}],2)]\% $[pad(%{bf9}*185,8)] |%; \
	/echo | $[pad("Inhuman",-17)] $[pad(%{bf10},5)] $[pad($[%{bf10}*100/%{totalbf}],2)]\% $[pad(%{bf10}*200,8)] | \
	       ------------------------------------ |%; \
	/echo | Mastery\[$[pad(%{bfmas},5)]\] ------- Multi:\[$[pad(%{bfmul},5)]\] | \
	        Totals:           $[pad(%{totalbf},5)]     $[pad(%{bfdmg},8)] |%; \
    /echo `-----------------------------------------------------------------------------'

/def RANGER_save= \
	/let striim= $[tfopen(strcat(%{TF_DIR},"/saves/ranger.tf"),"w")]%; \
	/test $[tfwrite(striim,strcat("/set bf0 ",bf0,""))]%; \
	/test $[tfwrite(striim,strcat("/set bf1 ",bf1,""))]%; \
	/test $[tfwrite(striim,strcat("/set bf2 ",bf2,""))]%; \
	/test $[tfwrite(striim,strcat("/set bf3 ",bf3,""))]%; \
	/test $[tfwrite(striim,strcat("/set bf4 ",bf4,""))]%; \
	/test $[tfwrite(striim,strcat("/set bf5 ",bf5,""))]%; \
	/test $[tfwrite(striim,strcat("/set bf6 ",bf6,""))]%; \
	/test $[tfwrite(striim,strcat("/set bf7 ",bf7,""))]%; \
	/test $[tfwrite(striim,strcat("/set bf8 ",bf8,""))]%; \
	/test $[tfwrite(striim,strcat("/set bf9 ",bf9,""))]%; \
	/test $[tfwrite(striim,strcat("/set bf10 ",bf10,""))]%; \
	/test $[tfwrite(striim,strcat("/set bfmul ",bfmul,""))]%; \
	/test $[tfwrite(striim,strcat("/set bfmas ",bfmas,""))]%; \
	/test $[tfwrite(striim,strcat("/set bfdmg ",bfdmg,""))]%; \
	/test $[tfclose(striim)]

/eval /load %{TF_DIR}/saves/ranger.tf
