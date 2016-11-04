;;
;; DraliTF modules/guild/channeller.tf version 0.2
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
;;   prt                      - Toggle verbose reporting
;;   ctype                    - Cycle cast type
;;   stype <type>             - Switch cast type
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/def -h'SEND {prt}' toggleVerbose = \
  /if ( verbose=0 ) \
    /set verbose=1%;\
    /d_pass Verbose reporting enabled.%;\
  /else \
    /set verbose=0%;\
    /d_fail Verbose reporting disabled.%;\
  /endif

/def protpartysay = \
	/if (verbose) \
		/eval /party_report _misc %{*}%; \
	/else \
		/d_pass %{*}%; \
	/endif

/def -aCred -mregexp -t"^Suddenly a softly glowing aura of yellow light comes into being around you." aura_on = \
	/set aurac=yellow%;\
	/set aura=1%;\
	/set aura_time=$[time()]%;\
	/protpartysay [Aura On] (%aurac)

/def -aCred -mregexp -t"^Your aura is starting to weaken!" aura_weak = \
	/party_report _misc Aura fading, time to reload

/def -aCred -mregexp -t"^Your aura of glowing light fades to nothing." aura_off = \
	/protpartysay [Aura Down] (@(timer(aura_time)))%; \
	/set aura_time=0%; \
	/set aurac=0; \
	/set aura=0%; \
	/set aura_time=$[time()]

/def -mregexp -t"^Not all is lost, however, you did just recharge your aura." aura_rechargex = \
	/set aura_time=$[time()]%;\
	/protpartysay [Aura recharged] (@(timer(aura_time)))

/def -mregexp -t"^You try to focus more magic energy into your aura but get no useful result." aura_no_result = \
	/set aura_time=$[time()]%; \
	/protpartysay [Aura recharged] (@(timer(aura_time)))

/def -mregexp -t"^You attempt to focus even more energy, but make very little progress." aura_little_result = \
	/set aura_time=$[time()]%; \
	/protpartysay [Aura recharged] (@(timer(aura_time)))

/def -mregexp -t"^You try your hardest but cannot focus enough energy." aura_hardest = \
	/set aura_time=$[time()]%; \
	/protpartysay [Aura recharged] (@(timer(aura_time)))

/def -mregexp -t"^With a burst of energy, your aura changes from soft yellow to bright red." aura_red = \
	/set aurac=red%; \
	/set aura=2%; \
	/set aura_time=$[time()]%; \
	/protpartysay [Aura upgraded] (@(timer(aura_time)))

/def -mregexp -t'^Tendrils of lightning flit around you as your aura changes from flame red to' aura_blue = \
	/set aurac=blue%; \
	/set aura=3%; \
	/set aura_time=$[time()]%; \
	/protpartysay [Aura upgraded] (@(timer(aura_time)))

; 0 = ball  mana
; 1 = bolt  elec
; 2 = burn  fire
; 3 = ray   mana
; 4 = spray fire

/def -h'SEND {ctype}' cycle_type = \
	/if (%cctype = 4) /set cctype=0%;/protpartysay [Type(Cball):Mana]%;/set ctype=Mana%;/set das=ball%; /endif%;\
	/if (%cctype = 3) /set cctype=4%;/protpartysay [Type(Cspray):Fire]%;/set ctype=Fire%;/set das=spray%; /endif%;\
	/if (%cctype = 2) /set cctype=3%;/protpartysay [Type(Cray):Mana]%;/set ctype=Mana%;/set das=ray%; /endif%;\
	/if (%cctype = 1) /set cctype=2%;/protpartysay [Type(Cburn):Fire]%;/set ctype=Fire%;/set das=burn%; /endif%;\
	/if (%cctype = 0) /set cctype=1%;/protpartysay [Type(Cbolt):Elec]%;/set ctype=Elec%;/set das=bolt%; /endif

/def -h'SEND {stype}*' swap_type=\
	/if (%2 =~ "0") /set cctype=0%;/protpartysay [Type(Cball):Mana]%;/set ctype=Mana%;/set das=ball%; /endif%;\
	/if (%2 =~ "1") /set cctype=1%;/protpartysay [Type(Cbolt):Elec]%;/set ctype=Elec%;/set das=bolt%; /endif%;\
	/if (%2 =~ "2") /set cctype=2%;/protpartysay [Type(Cburn):Fire]%;/set ctype=Fire%;/set das=burn%; /endif%;\
	/if (%2 =~ "3") /set cctype=3%;/protpartysay [Type(Cray):Mana]%;/set ctype=Mana%;/set das=ray%; /endif%;\
	/if (%2 =~ "4") /set cctype=4%;/protpartysay [Type(Cspray):Fire]%;/set ctype=Fire%;/set das=spray%; /endif
