;;
;; DraliTF modules/prots.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Default vars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set disp_avrg_prot_times=0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Clear prots when you first enter the game
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -t'Moving to starting location.' clear_prots_on_entry = /set ProtList=

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Prot commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -h'SEND {cprots}' clear_prots = /set ProtList=
/def -h'SEND {cprot}*' clear_prot = /set rem_comm=1%;/rem_prot %{2}%;/set rem_comm=0
/def -h'SEND {prots}' echo_prots = /list_prots%;/eval /echo -aBCcyan %{prots}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tweak trigger
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -mregexp -t'^([A-z]*) tweaks your nose mischievously.|^You tweak your own nose mischievously.' protreport = \
    /list_prots%; \
    /party_report _general %{prots}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Add a prot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def add_prot= \
;;  /if (!%{caster}) /set caster=UnKnown%; /endif%;\
  /if ($[check_prot(%{1})] = 1) \
  /set ProtList=%{1}:$[time()]:%{caster} %{ProtList}%; \
  /else \
    /set rem_silent=1%; \
    /rem_prot %{1}%; \
    /set ProtList=%{1}:$[time()]:%{caster} %{ProtList}%; \
  /endif%; \
  /if (%{add_silent} = 0) /party_report _general [%{1}(%{caster}):Active]%; /else /set add_silent=0%; /endif%;\
  /unset caster

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Check if the prot is active
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def check_prot=\
  /set num_prots=$(/length %{ProtList})%; \
  /set cou_prots=0%; \
  /set tprots=%{ProtList}%; \
  /set retprot=1%;\
  /while ({cou_prots}<{num_prots})\
    /set cprot=$(/pop tprots)%;\
    /eval /set in_prots=$[strstr(%{cprot}, %{1})]%; \
    /if (%{in_prots} >= 0) \
      /set retprot=0%;\
    /endif%; \
    /set cou_prots=$[{cou_prots}+1]%;\
  /done%; \
  /return %{retprot}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Remove a prot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def rem_prot= \
  /set num_prots=$(/length %{ProtList})%;/set cou_prots=0%;/set tprots=%{ProtList}%;/set prot_remmed=0%;\
  /while ({cou_prots}<{num_prots})\
    /set cprot=$(/pop tprots)%;\
    /eval /set in_prots=$[strstr(%{cprot}, %{1})]%; \
    /if ({in_prots} != -1) \
      /set tmp_prot=%{cprot}%;\
      /set prot_tmp=$[replace(":", " ", %{cprot})]%; \
      /set prot_time_tmp=$(/cadr %{prot_tmp})%;\
      /set prot_caster=$(/cddr %{prot_tmp})%; \
      /set dwn_time=$[timer(%{prot_time_tmp})]%;\
      /set prot_remmed=1%;\
    /endif%; \
    /set cou_prots=$[{cou_prots}+1]%;\
  /done%; \
  /eval /set ProtList=$(/remove %{tmp_prot} %{ProtList})%; \
  /if (%{prot_remmed} == 1 & %{rem_comm} != 1) \
  /if (%{disp_avrg_prot_times}=1) \
  /if (%{rem_silent} = 1) /set rem_silent=0%; /else /party_report _general [%{1}:Down] (%{dwn_time}) {%{prot_caster}'s avrg: $[timer2($(/eval /_echo %%{%{prot_caster}%{1}avrgtime}))]}%; /endif%; \
  /else \
  /if (%{rem_silent} = 1) /set rem_silent=0%; /else /party_report _general [%{1}:Down] (%{dwn_time})%; /endif%; \
  /endif%; \
  /endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; List prots
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def list_prots= \
  /set num_prots=$(/length %{ProtList})%; \
  /set cou_prots=0%;/set prot_list=%; \
  /set tprots=%{ProtList}%; \
  /while ({cou_prots}<{num_prots})\
    /set cprot=$(/pop tprots)%;\
    /set prot_tmp=$[replace(":", " ", %{cprot})]%; \
    /set prot_name_tmp=$(/car %{prot_tmp})%;\
    /set prot_name_tmp=$[replace("_", " ", %{prot_name_tmp})]%;\
    /set prot_time_tmp=$(/cadr %{prot_tmp})%;\
    /set prot_temp_list=%{prot_name_tmp}[$[timer(%{prot_time_tmp})]]%;\
    /set prot_stack=$(/eval /_echo %%{%{prot_name_tmp}stack})%; \
    /if (%{prot_stack} != 0) /set prot_temp_list=%{prot_temp_list}(%{prot_stack})%; /endif%;\
    /set prot_list=%{prot_temp_list} %{prot_list}%;\
    /set cou_prots=$[{cou_prots}+1]%;\
  /done%; \
  /if (%{num_prots}=0) /set prots=Prots: none%; /else \
  /set prots=Prots: %{prot_list}%; /endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Get caster's avrg time for <prot>                                UNFINISHED
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def add_avrg_prot_time= \
  /set list_avrg_times=%{1}%{2} %{list_avrg_times}%; \
  /set list_avrg_times=$(/unique %{list_avrg_times})%; \
  /set %{1}%{2}casts=$[$(/eval /_echo %%{%{1}%{2}casts}) + 1]%; \
  /set %{1}%{2}tottime=$[$(/eval /_echo %%{%{1}%{2}tottime}) + {3}]%; \
  /set %{1}%{2}avrgtime=$[$(/eval /_echo %%{%{1}%{2}tottime}) / $(/eval /_echo %%{%{1}%{2}casts})]%; \
  /let striim= $[tfopen("tf/saves/protavrgtimes.tf","w")]%;\
  /test $[tfwrite(striim,strcat("/set list_avrg_times=",%{list_avrg_times}))]%;\
  /set num_nms=$(/length %{list_avrg_times})%;/set cou_nms=0%;/set nms_list=%;/set tnms=%{list_avrg_times}%; \
  /while ({cou_nms}<{num_nms})\
    /set cnms=$(/pop tnms)%;\
    /test $[tfwrite(striim,strcat("/set ",%{cnms},"casts=",$(/eval /_echo %%{%{cnms}casts})))] %;\
    /test $[tfwrite(striim,strcat("/set ",%{cnms},"tottime=",$(/eval /_echo %%{%{cnms}tottime})))] %;\
    /test $[tfwrite(striim,strcat("/set ",%{cnms},"avrgtime=",$(/eval /_echo %%{%{cnms}avrgtime})))] %;\
    /set cou_nms=$[{cou_nms}+1]%;\
  /done%; \
  /test $[tfclose(striim)]
;; load avrg prot times
;;/eval /load tf/saves/protavrgtimes.tf

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; --- CASTER GRABERS ---
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -mregexp -t'^([A-z]*) traces (.*) runes' castgrab1 = /set caster %{P1}
/def -F -mregexp -t'^([A-z]*) utters the magic words' castgrab2 = /set caster=%{P1}
/def -F -mregexp -t'^([A-z]*) claps ([a-z]*) hands and whispers' castgrab3 = /set caster=%{P1}
/def -F -mregexp -t'^([A-z]*) rapidly swallows a dozen iron nails' castgrab4 = /set caster=%{P1}
/def -F -mregexp -t'^([A-z]*) is surrounded by blue waves as you hear' castgrab5 = /set caster=%{P1}
/def -F -mregexp -t'^([A-z]*) sings:' castgrab6 = /set caster=%{P1}
/def -F -mregexp -t'^([A-z]*) rolls his eyes wildly and exclaims' castgrab7 = /set caster=%{P1}
/def -F -mregexp -t'^([A-z]*) jumps up and begins dancing around the room.' castgrab8 = /set caster=%{P1}
/def -F -mregexp -t'^([A-z]*) rubs wax in ([a-z]*) feet and chants' castgrab9= /set caster=%{P1}
/def -F -mregexp -t'^([A-z]*) rubs ([a-z]*) eyes with sand and whispers' castgrab10= /set caster=%{P1}
/def -F -mregexp -t'^([A-z]*) booms in sinister voice' castgrab11 = /set caster=%{P1}
/def -F -mregexp -t'^([A-z]*) waves his index finger while uttering' castgrab23 = /set caster=%{P1}
/def -F -mregexp -t'^([A-z]*) flaps arms and utters the magic words' castgrab25 = /set caster=%{P1}
/def -F -mregexp -t'^You trace (.*) runes' castgrab12 = /set caster=%{MY_NAME}
/def -F -mregexp -t'^You utter the magic words' castgrab13 = /set caster=%{MY_NAME}
/def -F -mregexp -t'^You clap hands and whisper' castgrab14 = /set caster=%{MY_NAME}
/def -F -mregexp -t'^You rapidly swallow a dozen iron nails' castgrab15 = /set caster=%{MY_NAME}
/def -F -mregexp -t'^You is surrounded by blue waves as you hear' castgrab16 = /set caster=%{MY_NAME}
/def -F -mregexp -t'^You sing:' castgrab17 = /set caster=%{MY_NAME}
/def -F -mregexp -t'^You roll your eyes wildly and exclaim' castgrab18 = /set caster=%{MY_NAME}
/def -F -mregexp -t'^You jump up and begin dancing around the room.' castgrab19 = /set caster=%{MY_NAME}
/def -F -mregexp -t'^You rub wax in your feet and chant' castgrab20= /set caster=%{MY_NAME}
/def -F -mregexp -t'^You rub your eyes with sand and whisper' castgrab21= /set caster=%{MY_NAME}
/def -F -mregexp -t'^You boom in sinister voice' castgrab22 = /set caster=%{MY_NAME}
/def -F -mregexp -t'^You wave your index finger while uttering' castgrab24 = /set caster=%{MY_NAME}
/def -F -mregexp -t'^You flap arms and utter the magic words' castgrab26 = /set caster=%{MY_NAME}
/def -F -mregexp -t'^You close your eyes in complete concentration and chant' castgrab27 = /set caster=%{MY_NAME}
/def -F -mregexp -t'^You break up a mirror and chant' castgrab28 = /set caster=%{MY_NAME}
/def -F -mregexp -t'^You tap the power of the blue star with the words' castgrab29 = /set caster=%{MY_NAME}
/def -F -mregexp -t'^([A-z ]*) screams in rage and yells' castgrab30 = /set caster=%{P1}
/def -F -t'You laugh out loud and exclaim \'Myh myh!\'' castgrab31 = /set caster=%{P1}
/def -F -t'([A-z ]*) laughs out loud and exclaims \'Myh myh!\'' castgrab32 = /set caster=%{P1}
/def -p1 -F -t'([A-z]*) screams in rage and yells \'Feel your anger and strike with all your hatred.' castgrab33 = /set caster%{P1}
/def -F -mregexp -t'^You strike your fists together and scream' castgrab34 = /set caster=%{MY_NAME}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Prot on/off triggers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  TARMALEN  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ---------------------------------- BOT ---------------------------------------
/def -p1 -F -t'You feel strong - like you could carry the whole flat world on your back!' PROT_bot_up = /add_prot BoT
/def -p1 -F -t'You feel weaker.' PROT_bot_dn = /rem_prot BoT
;; --------------------------------- UNSTUN -------------------------------------
/def -p1 -F -mregexp -t'^([A-z]*)\'s chanting appears to do absolutely nothing' unsup = /add_prot Uns%;/set stunn=2%;/status_edit -r0 "S":1:BCgreen
/def -p2 -F -mregexp -t'^It doesn\'t hurt at all*' stu1 = /party_report _general [Uns:Weakened]%;/set stunn=2%;/status_edit -r0 "S":1:BCgreen
/def -p2 -F -t'It doesn\'t hurt as much as it normally*' stu4 = /rem_prot Uns%;/set stunn=1%;/status_edit -r0 "S":1:BCred
;; --------------------------------- UNPAIN -------------------------------------
/def -p1 -F -t'You feel your will getting stronger*' unpup = /add_prot Unp
/def -p1 -F -t'Your Unpain spell dissipates*' unpdn1 = /rem_prot Unp
/def -p1 -F -t'You feel your will getting normal*' unpdn2 = /rem_prot Unp
/def -p1 -F -t'You suffer an acute health change*' unpdn3 = /rem_prot Unp
/def -p1 -F -t'You feel your will returning normal*' unpdn4 = /rem_prot Unp
;; --------------------------- GUARDIAN ANGEL -----------------------------------
/def -p1 -F -t'A guardian angel arrives to protect you!' gangelup = /add_prot Angel
/def -p1 -F -t'Your guardian angel cannot stay for longer and flies away.' gangeldn = /rem_prot Angel


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  DRUIDS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ----------------------------- EARTH BLOOD ------------------------------------
/def -p1 -F -t'An icy chill runs through your veins.' ebloodup = /add_prot Eblood
;; ----------------------- FLEX SHIELD ------------------------------------------
/def -p1 -F -t'You sense a flex shield covering your body like a second skin.' flexup = /add_prot Flex
/def -p1 -F -t'Your flex shield wobbles, PINGs and vanishes.' flexdn = /rem_prot Flex
;; ------------------------ EARTH SKIN ------------------------------------------
/def -p1 -F -t'You feel your skin harden*' eskinup = /set add_silent=1%;/set Eskinstack=$[%{Eskinstack}+1]%;/party_report _general [Eskin(%{caster}):Active] [%{Eskinstack} stacked]%;/add_prot Eskin
/def -p1 -F -t'Your skin feels softer*' eskindn = /set Eskinstack=$[%{Eskinstack} - 1]%;/if (%{Eskinstack} = 0) /rem_prot Eskin%; /else /party_report _general [Eskin:Weakened] [%{Eskinstack} left]%; /endif
;; ------------------------- EARTH POWER ----------------------------------------
/def -p1 -mglob -F -t'You feel your strength changing*' epowerup = /add_prot Epower
/def -p1 -mglob -F -t'*runic sigla \'% !^\' fade away..*' epowerdn = /rem_prot Epower
;; ----------------------------- REGENERATION -----------------------------------
/def -p1 -F -t'You feel your metabolism speed up.' PROT_regen_up = /add_prot Regen
/def -p1 -F -t'You no longer have an active regeneration spell on you.' PROT_regen_dn = /rem_prot Regen
;; ----------------------- VINE MANTLE -------------------------------------------
/def -p1 -F -t'Vines entangle your body.' vinemup = /add_prot Vines
/def -p1 -F -t'The vines around your body shrink.' vinemweak =
/def -p1 -F -t'The vines crumbles to dust.' vinemdown = /rem_prot Vines


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  BARBARIAN ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; -------------------------------- ENRAGE --------------------------------------
/def -mregexp -F -t'^(You feel mildly enraged\.|You feel your barbarian rage stir up\.|You are maddened with rage!|Your blood is boiling with rage!|You feel the adrenaline BURST into your veins!|You tremble uncontrollably and feel completely ENRAGED!|You are ENRAGED! Your body ACHES for action!|You feel TOTALLY ENRAGED and ready to KICK ASS!|Holy CRAP! OH what a RUSH!|YOU FEEL AS IF YOU WERE GROO HIMSELF!)' PROT_enrage_up = /add_prot Enrage
/def -mregexp -F -t'^You no longer feel enraged.' PROT_enrage_dn = /rem_prot Enrage
;; ---------------------------- PAIN THRESHOLD ----------------------------------
/def -p1 -F -t'You begin to concentrate on pain threshold.' PROT_b_phys_up = /add_prot b-phys
/def -p1 -F -t'Your concentration breaks and you feel less protected from physical damage.' PROT_b_phys_dn = /rem_prot b-phys

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  REAVER  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ------------------ Glory of Destruction ----------------------------------------
/def -p1 -F -mregexp -t'^The destructive forces leave your body.' goddn = /rem_prot GoD
/def -p1 -F -mregexp -t'^Your body swells in anticipation of the battles to come.' godup = /add_prot GoD


;; --------------------- Aura of Hate ---------------------------------------------
/def -p1 -F -mregexp -t'^You feel burning hatred and rage erupt within you' aohup = /add_prot AoH
/def -p1 -F -t'You feel your anger and hate of the world recede.' aohdn = /rem_prot AoH


;; --------------------- Flame Fists ----------------------------------------------
/def -p1 -F -t'Your fists are surrounded by Curath\'s black flames!' ff_up = /add_prot Flame_Fists
/def -p1 -F -t'Your flaming fists disappear.' ff_dn = /rem_prot Flame_Fists


;; --------------------- Lift of load ---------------------------------------------
/def -p1 -F -t'You feel odd. Not stronger, but...' lift_of_load_up = /add_prot lift_of_load
/def -p1 -F -t'You feel odd. Not weaker, but...' lift_of_load_dn = /rem_prot lift_of_load




;; ---------------------- Iron Will -----------------------------------------------
/def -p1 -F -t'You feel protected from being stunned.' iw_up = /add_prot IW
/def -p1 -F -t'You feel no longer protected from being stunned.' iw_dn = /rem_prot IW
;; ---------------------- Quicksilver ---------------------------------------------
/def -p1 -F -mregexp -t'^You feel more agile.' quicksilverup = /add_prot QSilver
/def -p1 -F -mregexp -t'^You feel less agile.' quicksilverdn = /rem_prot QSilver

;; --------------------- Mirror Image ---------------------------------------------
/def -p1 -F -mregexp -t'^Suddenly ([0-9]*) images of yourself appear.' mirrorsup = /add_prot Mirrors
/def -p1 -F -mregexp -t'^All of your images vanish!|^You have no more mirror images.' mirrorsdn = /rem_prot Mirrors
;; ------------------ Personal Force Field ----------------------------------------
/def -p1 -F -mregexp -t'^You surround yourself by a bubble of force.' pffup = /add_prot PF
/def -p1 -F -mregexp -t'^Your field disperses with a soft *pop* and is gone.' pffdn = /rem_prot PF
;; -------------- Dispel magical prottections -------------------------------------
/def -p1 -F -t'You feel unprotected.' remove_minor_conj = \
  	/rem_prot M-phys%;/rem_prot M-elec%;/rem_prot M-fire%;/rem_prot M-acid%;/rem_prot M-psi%;\
	  /rem_prot M-poison%;/rem_prot M-mana%;/rem_prot M-asphyx%;/rem_prot M-cold
/def -p1 -F -t'You feel much more vulnerable.' remove_major_conj = \
	  /rem_prot m-phys%;/rem_prot m-elec%;/rem_prot m-fire%;/rem_prot m-acid%;/rem_prot m-psi%;\
  	/rem_prot m-poison%;/rem_prot m-mana%;/rem_prot m-asphyx%;/rem_prot m-cold
;; ------------------- MINOR CONJU PROTS ------------------------------------------
/def -F -mregexp -t'\'morri nam pantoloosa\'' TD1 = /set cplong=m-poison
/def -F -mregexp -t'\'meke tul magic\'' MD1 = /set cplong=m-mana
/def -F -mregexp -t'\'hot hot not zeis daimons\'' HR1 = /set cplong=m-fire
/def -F -mregexp -t'\'qor monoliftus\'' EB1 = /set cplong=m-asphyx
/def -F -mregexp -t'\'skaki barictos yetz fiil\'' FI1 = /set cplong=m-cold
/def -F -mregexp -t'\'sulphiraidzik hydrochloodriz gidz zut\'' CS1 = /set cplong=m-acid
/def -F -mregexp -t'\'kablaaaammmmm bliitz zundfer\'' EC1 = /set cplong=m-elec
/def -F -mregexp -t'\'toughen da mind reeez un biis\'' PS1 = /set cplong=m-psi
/def -F -mregexp -t'\'ztonez des deckers\'' fab1 = /set cplong=m-phys
/def -F -t'A skin brown flash*' fadn = /if ($[check_prot("m-phys")] = 0) /rem_prot m-phys%; /else /rem_prot m-phys[S]%; /endif
/def -F -t'A crackling blue flash*' ecdn = /if ($[check_prot("m-elec")] = 0) /rem_prot m-elec%; /else /rem_prot m-elec[S]%; /endif
/def -F -t'A disgusting yellow flash*' csdn = /if ($[check_prot("m-acid")] = 0) /rem_prot m-acid%; /else /rem_prot m-acid[S]%; /endif
/def -F -t'A cold white flash*' fidn = /if ($[check_prot("m-cold")] = 0) /rem_prot m-cold%; /else /rem_prot m-cold[S]%; /endif
/def -F -t'A transparent flash*' psdn = /if ($[check_prot("m-psi")] = 0) /echo test%;/rem_prot m-psi%; /else /echo test2%;/rem_prot m-psi[S]%; /endif
/def -F -t'A burning red flash*' hrdn = /if ($[check_prot("m-fire")] = 0) /rem_prot m-fire%; /else /rem_prot m-fire[S]%; /endif
/def -F -t'A green flash*' tddn = /if ($[check_prot("m-poison")] = 0) /rem_prot m-poison%; /else /rem_prot m-poison[S]%; /endif
/def -F -t'A golden flash*' mddn = /if ($[check_prot("m-mana")] = 0) /rem_prot m-mana%; /else /rem_prot m-mana[S]%; /endif
/def -F -t'A dull black flash*' ebdn = /if ($[check_prot("m-asphyx")] = 0) /rem_prot m-asphyx%; /else /rem_prot m-asphyx[S]%; /endif
/def -F -t'You sense a powerful protective aura around you.' TD2 = /repeat -0:00:01 1 /conjprotrep
/def -F -t'You sense an extra powerful protective aura around you.' TD3 = /repeat -0:00:01 1 /conjprotrep2
/def conjprotrep = /add_prot %{cplong}
/def conjprotrep2 = /add_prot %{cplong}[S]
;; ---------------------- HALLUCINATION ------------------------------------------
/def -p1 -F -mglob -t'*looks at you mesmerizingly.  The world around you changes.' hallu = /add_prot Hallu
;; -------------------------- FORGET ---------------------------------------------
/def -p1 -F -t'You feel rather empty-headed*' forgotten = /add_prot Forget
/def -p1 -F -t'A fog lifts from your mind. You can remember things clearly now.' forgetdn = /rem_prot Forget
;; -------------------------- BLIND ----------------------------------------------
/def -p1 -F -t'Your eyes become usless*' blindup = /add_prot Blind
/def -p1 -F -t'You can see again!' blinddn = /rem_prot Blind
;; -------------------------- DEATH ----------------------------------------------
/def -p1 -F -mregexp -t'^You die.' deatheffectsup = /set rem_silent=1%;/add_prot Death_effects%;/rem_prot Flex%;/rem_prot Invis%;/rem_prot Unp%;/rem_prot Eskin%;/rem_prot PFE%;/rem_prot PFG%;/rem_prot Uns
;;spider touch.
/def -p1 -aBCgreen -F -t'You feel more vital.' deatheffectsgone = /rem_prot Death_effects
;; --------------------- SHIELD OF FAITH -----------------------------------------
/def -p1 -F -mregexp -t'^You are surrounded by divine glow!' sofup = /add_prot SoF
/def -p1 -F -mregexp -t'^You can feel the power of Faerwon leaving you.' sofdwn = /rem_prot SoF
/def -p1 -F -mregexp -t'^Your glow disappears.' sofdwn2 = /rem_prot SoF
;; -------------------- MELODICAL EMBRACE ----------------------------------------
/def -p1 -F -mregexp -t'^([A-z]*) wraps you into an embracing melody' emraup = /add_prot Embrace
/def -p1 -F -t'The embracing melody subsides, leaving you longing for more.' emradn = /rem_prot Embrace
;; ---------------------- ARCHES FAVOUR ------------------------------------------
/def -p1 -F -t'You feel optimistic about your near future!' archup = /add_prot AFavour
/def -p1 -F -t'You no longer have Arches Favour on you. You feel sad.' archdn = /rem_prot AFavour
;; ----------------------- HASTE/SLOW --------------------------------------------
/def -p1 -F -t'The world seems to slow down.' hasteup = /add_prot Haste
/def -p1 -F -t'The world seems to speed up.' slowup =
/def -p1 -F -t'The world seems to slow down again.' slowdown = /rem_prot Haste
;; ------------------------- HEAVENLY -------------------------------------------
/def -p1 -F -mregexp -t'^([A-z]*)\'s (.*) vibrates under magical pressure as you are suddenly' eheavprotup = /add_prot Heavenly
/def -p1 -F -t'*Holy particles slow down, rapidly fading*' eheavprotdn = /rem_prot Heavenly
;; ---------------------------- PFG ---------------------------------------------
/def -p1 -mglob -F -t'A vile black aura surrounds you*' pfgup = /add_prot PFG
/def -p1 -mglob -F -t'You no longer have a vile black aura around you*' pfgdn = /rem_prot PFG
;; --------------------- SHIELD OF PROTECT --------------------------------------
/def -p1 -mglob -F -t'You feel a slight tingle.' sopup = /add_prot SoP
/def -p1 -mglob -F -t'You feel more vulnerable now.' sopdn = /rem_prot SoP
;; ------------------------ HEAVY WEIGHT ----------------------------------------
/def -p1 -mglob -F -t'You suddenly feel magically heavier*' hwup = /if (%sticky>1) /set sticky=0%;/add_prot HW[S]%; /else /add_prot HW%; /endif
/def -p1 -mglob -F -t'You feel lighter, but it does*' hwdn = /if ($[check_prot(HW)] = 0) /rem_prot HW%; /else /rem_prot HW[S]%; /endif
;; ------------------------ WATER WALKING ---------------------------------------
/def -p1 -mglob -F -t'You feel light.' wwup = /add_prot WW
/def -p1 -mglob -F -t'You feel heavier*' wwdn = /rem_prot WW
;; ---------------------------- FLOAT -------------------------------------------
/def -p1 -mglob -F -t'You feel light, and rise into the air.' floatup = /add_prot Float
/def -p1 -mglob -F -t'You slowly descend until your feet are*' wwdn2 = /rem_prot Float
;; ----------------------------- INFRA ------------------------------------------
/def -p1 -F -t'You have infravision*' irup = /add_prot Infra
/def -p1 -F -t'Everything no longer seems so red*' irdn = /rem_prot Infra
;; --------------------------- LEVITATION ---------------------------------------
/def -p1 -F -t'You slowly rise from the ground and start levitating.' levitationup = /add_prot Levi
/def -p1 -F -t'You decide that you have levitated enough and slowly descend to the ground.' levitationdn = /rem_prot Levi
;; ------------------------ BLUR/DISPLACEMENT -----------------------------------
/def -p1 -F -t'*ziiiuuuuns wiz*' tmp_blur = /set tmp_spell=%{tmp_spell} Blur%;/set tmp_spell2=Blur
/def -p1 -F -t'*diiiiuuunz aaanziz*' tmp_disp = /set tmp_spell=%{tmp_spell} Disp%;/set tmp_spell2=Disp
/def -p1 -F -t'You feel a powerful aura*' dispup = /add_prot %{tmp_spell2}
/def -p1 -F -t'You feel less invisible*' blurdn = /rem_prot Blur
/def -p1 -F -t'You feel much less invisible.' dispdn = /rem_prot Disp
;; ------------------------ MIND DEVELOPMENT ------------------------------------
/def -p1 -F -t'You feel your mind developing.*' minddevelopup = /set add_silent=1%;/set MindDstack=$[%MindDstack+1]%;/party_report _general [Mind Devel(%caster):Active] [%mdevstack stacked]%;/add_prot MindD
/def -p1 -F -t'Your brain suddenly seems smaller.*' minddevelodown = /set MindDstack=$[%MindDstack - 1]%;/if (MindDstack = 0) /rem_prot MindD%; /else /party_report _general [Mind Devel:Weakened] [%MindDstack left] /endif
;; ------------------------------ WAREZ -----------------------------------------
/def -p1 -F -t'You feel full of battle rage!*' wensembleup = /add_prot WarEz
/def -p1 -F -t'The effect of war ensemble wears off.' wensembledn = /rem_prot WarEz
;; ------------------------ RESIST DISPEL ---------------------------------------
/def -p1 -F -t'You feel extra sticky for protection*' resdispup = /set sticky=1%;@@emote feels sticky, Ewww.
;; ------------------------------- PFE-------------------------------------------
/def -p1 -mglob -F -t'A white holy aura surrounds you*' pfeup = /add_prot PFE
/def -p1 -F -t'*shimmers with sheer power as you are surrounded by protective*' pfeup2 = /add_prot PFE
/def -p1 -mglob -F -t'You no longer have a white aura around you*' pfedn = /rem_prot PFE
/def -p1 -mglob -F -t'You suddenly feel more vulnerable to evil.' pfedn2 = /rem_prot PFE
;; ---------------------- RESIST DISINTEGRATE -----------------------------------
/def -p1 -F -t'You feel very firm*' resdistrup = /add_prot R-Disint
;; --------------------------- SOUL SHIELD --------------------------------------
/def -p1 -F -t'Your life force becomes stronger.' soulsup = /add_prot SSh
/def -p1 -F -t'([A-z]*) places her hand over you and blesses your soul in the name of Las.' soulshieldup = /add_prot SSh
/def -p1 -F -t'Your soul feels suddenly more vulnerable*' sshielddn = /rem_prot SSh
;; ---------------------------- SEE INVIS ---------------------------------------
/def -p1 -F -t'You feel you can see more*' sinvisup = /add_prot S-Invis
/def -p1 -F -t'Your vision is less sensitive*' sinvisdn = /rem_prot S-Invis
;; --------------------------- INVISIBILITY -------------------------------------
/def -p1 -F -t'You suddenly can\'t see yourself*' invisup = /add_prot Invis
/def -p1 -F -t'You turn visible*' invisdn = /rem_prot Invis
;; --------------------------- BLADE OF FIRE ------------------------------------
/def -p1 -F -t'As your chant finishes, a red-hot flame rages from your*' bofire_ = /add_prot BoF
/def -p1 -F -t'The flames surrounding your chaos blade subside.' bofire_down = /rem_prot BoF
;; ---------------------------- FORCE SHIELD ------------------------------------
/def -p1 -F -mregexp -t'^([A-z]*) forms a shield of force around you' fshieldup2 = /add_prot FSh
/def -p1 -F -t'You form a psionic shield of force around your body.' fshieldup = /add_prot FSh
/def -p1 -F -t'Your armour feels thinner*' fshielddn = /rem_prot FSh
;; --------------------------- PSIONIC SHIELD -----------------------------------
/def -p1 -F -t'Psionic waves surge through your body and mind!' pshieldup = /add_prot PsiSh
/def -p1 -F -t'The psionic shield vanishes.' pshielddn = /rem_prot PsiSh
;; ----------------------------- SPIDER WALK ------------------------------------
/def -mregexp -F -t'^For some reason you want to run on the walls for a little while.' spiderwlkup = /add_prot Spider_Walk
/def -mregexp -F -t'^The walls don\'t look so inviting anymore.' spiderwlkdn = /rem_prot Spider_Walk
;; --------------------------- Major Conj Prots ---------------------------------
/def -p1 -F -mregexp -t'^You see a (.*) shield fade into existance around you.' mcpup = \
    /if (%{P1} =~ "crackling red-orange") /set mcps=M-fire%;/endif%;\
    /if (%{P1} =~ "frosty blue-white") /set mcps=M-cold%;/endif%;\
    /if (%{P1} =~ "slimy olive green") /set mcps=M-poison%;/endif%;\
    /if (%{P1} =~ "flickering golden") /set mcps=M-mana%;/endif%;\
    /if (%{P1} =~ "bubbling yellow") /set mcps=M-acid%;/endif%;\
    /if (%{P1} =~ "neon purple") /set mcps=M-elec%;/endif%;\
    /if (%{P1} =~ "swirling foggy white") /set mcps=M-asphyx%;/endif%;\
    /if (%{P1} =~ "misty pale blue") /set mcps=M-psi%;/endif%;\
    /if (%{P1} =~ "crystal clear") /set mcps=M-phys%;/endif%;\
    /add_prot %{mcps}
/def -p1 -F -mregexp -t'^You see an extra (.*) shield fade into existance around you.' mcpupsticky = \
    /if (%{P1} =~ "crackling red-orange") /set mcps=M-fire%;/endif%;\
    /if (%{P1} =~ "frosty blue-white") /set mcps=M-cold%;/endif%;\
    /if (%{P1} =~ "slimy olive green") /set mcps=M-poison%;/endif%;\
    /if (%{P1} =~ "flickering golden") /set mcps=M-mana%;/endif%;\
    /if (%{P1} =~ "bubbling yellow") /set mcps=M-acid%;/endif%;\
    /if (%{P1} =~ "neon purple") /set mcps=M-elec%;/endif%;\
    /if (%{P1} =~ "swirling foggy white") /set mcps=M-asphyx%;/endif%;\
    /if (%{P1} =~ "misty pale blue") /set mcps=M-psi%;/endif%;\
    /if (%{P1} =~ "crystal clear") /set mcps=M-phys%;/endif%;\
    /add_prot %{mcps}[S]
/def -p1 -F -mregexp -t'^Your (.*) shield fades out.' mcpdown = \
    /if (%{P1} =~ "crackling red-orange") /set mcps=M-fire%;/endif%;\
    /if (%{P1} =~ "frosty blue-white") /set mcps=M-cold%;/endif%;\
    /if (%{P1} =~ "slimy olive green") /set mcps=M-poison%;/endif%;\
    /if (%{P1} =~ "flickering golden") /set mcps=M-mana%;/endif%;\
    /if (%{P1} =~ "bubbling yellow") /set mcps=M-acid%;/endif%;\
    /if (%{P1} =~ "neon purple") /set mcps=M-elec%;/endif%;\
    /if (%{P1} =~ "swirling foggy white") /set mcps=M-asphyx%;/endif%;\
    /if (%{P1} =~ "misty pale blue") /set mcps=M-psi%;/endif%;\
    /if (%{P1} =~ "crystal clear") /set mcps=M-phys%;/endif%;\
    /if ($[check_prot(%{mcps})] == 0) /rem_prot %{mcps}%; /else /rem_prot %{mcps}[S]%; /endif
;; ----------------------------- curse/disease ----------------------------------
/def -p1 -mglob -F -t'You successfully resist a curse.' eresistcurse = /party_report [resisted curse]
/def -p1 -mglob -F -t'You are not affected by the disease.' savedcon = /party_report [resisted curse]

/def unload_prot_module = /d_error This module needs to be recoded.
