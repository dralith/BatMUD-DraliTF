;;
;; DraliTF modules/guild/beastmaster.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set my_mount=0

/def -mregexp -F -t'^It responds to the motivation and reluctantly slinks forward\.' BMASTER_rug_up = \
	/party_report _general [RUg(%{rug_tar}):Up]%; \
	remove whip%;wield axe%; \
	/if (%{my_mount} !~ 0) \
		ride %{my_mount}%; \
	/endif

/def -mregexp -F -t'^You think that (.*) should be worried about being underground right about now\.' BMASTER_rug_down = \
	/party_report _general [RUg(%{P1}):Down]

/def -mregexp -F -t'^Your mount balks, refusing to go there\.$' BMASTER_rug_needed = \
	/party_report _general [RUG DOWN, NEED RUG TO GO THERE!!!]


/def -h'SEND {rug}*' BMASTER_cmd_rug = \
	/if (%{my_mount} !~ 0) \
		dismount%; \
	/endif%; \
	remove axe%;wield whip%;use 'ride underground' %{-1}%; \
	/set rug_tar=%{-1}%;

;;Ride through pain: down
;You think that Hoar frost gryphon should be worried about pain right about now.

/def -mregexp -F -t'You awaken from your short rest, and feel slightly better.' BMASTER_camp_end = \
	/if (%{my_mount} !~ 0) \
		ride %{my_mount}%; \
	/endif

/def -mregexp -t'^You get up on ([A-z ]+) and begin to ride\.' BMASTER_riding = \
	/set my_mount=%{P1}

/def -mregexp -t'^You are now off your mount.$' BMASTER_intent_dismounted = \
	lead %{my_mount}

;;Rug fail
;The animal does not respond.


/def unload_bmaster_module = \
	/PURGE -mregexp BMASTER_.*%; \
	/unset rug_tar%; \
	/unset my_mount
