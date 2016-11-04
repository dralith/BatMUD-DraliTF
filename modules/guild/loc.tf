;;
;; DraliTF modules/guild/loc.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        Module specific functions                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def unload_disciple_module = \
	/purge -mregexp LOC_.*

/set LOC_cs_cnt0=0
/set LOC_cs_cnt1=0
/set LOC_cs_cnt2=0
/set LOC_cs_cnt3=0
/set LOC_cs_cnt4=0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Chaotic Spawn                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -mregexp -t'^You feel like the pulse of chaos inside you is slowing down!$' LOC_spawn_dropping = \
	/party_report _general [Spawn:Dropping]%;@@use 'chaotic spawn'

/def -mregexp -t'^You force yourself deeper into the chaos frenzy!$' LOC_spawn_refreshed = \
    /party_report _general [Spawn:Refreshed]

/def -mregexp -t'^The extra organs retract back into your body\.$' LOC_spawn_dropped = \
	/party_report _general [Spawn:Down]%; \
	@@eqset dam%;@@wield all axe

/def -ag -mregexp -t'You kneel and pray to Azzarakk. .*' LOC_spawn_repgag
/def -mregexp -aBCgreen -t'^You feel (the chaos pulse inside you!|slightly more connected to chaos!)' LOC_spawn_repgain

/def -F -mregexp -t'You feel devoid of chaos.' LOC_spawn_rep0 = /echo -p You feel devoid of chaos. (@{Cred}1/7@{n})
/def -F -mregexp -t'You feel a slight tingling of chaos inside you.' LOC_spawn_rep1 = /echo -p You feel a slight tingling of chaos inside you. (@{Cred}2/7@{n})
/def -F -mregexp -t'You feel chaos pulsing deep inside you.' LOC_spawn_rep2 = /echo -p You feel chaos pulsing deep inside you. (@{Cred}3/7@{n})
/def -F -mregexp -t'You feel chaos pulsing inside your veins.' LOC_spawn_rep3 = /echo -p You feel chaos pulsing inside your veins. (@{Cred}4/7@{n})
/def -F -mregexp -t'You feel chaos energizing your body.' LOC_spawn_rep4 = /echo -p You feel chaos energizing your body. (@{Cred}5/7@{n})
/def -F -mregexp -t'You feel chaos pouring out of you.' LOC_spawn_rep5 = /echo -p You feel chaos pouring out of you. (@{Cred}6/7@{n})
/def -F -mregexp -t'You feel your veins throbbing with pure chaos!' LOC_spawn_rep6 = /echo -p You feel your veins throbbing with pure chaos! (@{Cred}7/7@{n})

/def -F -mregexp -t'Your skin feels smooth.' LOC_spawn_tent0 = /echo -p Your skin feels smooth. (@{Cred}1/8@{n})
/def -F -mregexp -t'You feel a tickling in your torso.' LOC_spawn_tent1 = /echo -p You feel a tickling in your torso. (@{Cred}2/8@{n})
/def -F -mregexp -t'Your feel a tingling in your torso.' LOC_spawn_tent2 = /echo -p Your feel a tingling in your torso. (@{Cred}3/8@{n})
/def -F -mregexp -t'You feel a burning bump in your side.' LOC_spawn_tent3 = /echo -p You feel a burning bump in your side. (@{Cred}4/8@{n})
/def -F -mregexp -t'There\'s a bulging mass in your side.' LOC_spawn_tent4 = /echo -p There\'s a bulging mass in your side. (@{Cred}5/8@{n})
/def -F -mregexp -t'There\'s a seething mass in your side.' LOC_spawn_tent6 = /echo -p There\'s a seething mass in your side. (@{Cred}6/8@{n})
/def -F -mregexp -t'A glowing, bulging mass is burning in your side.' LOC_spawn_tent5 = /echo -p A glowing, bulging mass is burning in your side. (@{Cred}7/8@{n})
/def -F -mregexp -t'Your side is about to burst by the seething mass lodged there!' LOC_spawn_tent7 = /echo -p Your side is about to burst by the seething mass lodged there (@{Cred}8/8@{n})

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Clawed Strike                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -mregexp -t'^You rush against your enemy and bash with all your strength!' LOC_cs_miss0
/def -mregexp -t'^You rush against your enemy, but your attempt to bash misses.' LOC_cs_miss1
/def -mregexp -t'^You try to attack your enemy but fall over your own feet\.' LOC_cs_miss2 = \
	/set LOC_cs_cnt4=$[%LOC_cs_cnt4+1]%;/LOC_save%; \
	@@use 'clawed strike' %{target}

/def -mregexp -t'^You pitifully reach out to (.*) and barely scratch [A-z]+ body with the tip of your claw\.' LOC_cs_hit0 = \
	/set LOC_cs_cnt0=$[%LOC_cs_cnt0+1]%;/LOC_save%; \
	@@use 'clawed strike' %{target}

/def -mregexp -t'^You suddenly lunge toward (.*) with all claws and sink them into [A-z]+ body tearing [A-z]+ flesh into shreds and howl wildly at the blood gushing from the wounds\.' LOC_cs_hit1 = \
	/set LOC_cs_cnt1=$[%LOC_cs_cnt1+1]%;/LOC_save%; \
	@@use 'clawed strike' %{target}

/def -mregexp -t'^You turn your face down to the ground and scream as you work yourself into a maniacal dance, twirling madly around (.*) sinking your claws deep into (.*), slashing and stabbing into the mass tearing it into shreds making (.*) sink to the ground in pain\.' LOC_cs_hit2 = \
	/set LOC_cs_cnt2=$[%LOC_cs_cnt2+1]%;/LOC_save%; \
	@@use 'clawed strike' %{target}

/def -mregexp -t'^You lose sight of the world as you howl madly and rush towards (.*) slashing fiercely with your claws, tearing the very essence of [A-z]+ strength out with the shreds as you devour them with lightning speed, feeling [A-z]+ blood strengthen your claws as you continue rending (.*) leaving [A-z]+ a crying weak mass\.' LOC_cs_hit3 = \
	/set LOC_cs_cnt3=$[%LOC_cs_cnt3+1]%;/LOC_save%; \
	@@use 'clawed strike' %{target}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                Data Saving                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def LOC_save = \
	/let striim=$[tfopen(strcat(%{TF_DIR},"/saves/disciple.tf"),"w")]%; \
	/test $[tfwrite(%{striim}, strcat("/set LOC_cs_cnt4=",%{LOC_cs_cnt4}))]%; \
	/test $[tfwrite(%{striim}, strcat("/set LOC_cs_cnt1=",%{LOC_cs_cnt1}))]%; \
	/test $[tfwrite(%{striim}, strcat("/set LOC_cs_cnt2=",%{LOC_cs_cnt2}))]%; \
	/test $[tfwrite(%{striim}, strcat("/set LOC_cs_cnt3=",%{LOC_cs_cnt3}))]%; \
	/test $[tfclose(%{striim})]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               Data Restore                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/eval /load %{TF_DIR}/saves/disciple.tf
