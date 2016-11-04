;;
;; DraliTF modules/guild/sailor.tf version 0.2
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
/def unload_sailor_module = \
	/purge SAILOR_*%; \
	/unset sailor_tag

/def -mregexp -t'^You have access to the \'([a-z]+)\' channel for sailors.' SAILOR_get_sailor_tag = \
	/set sailor_tag=%{P1}

/def -t'You have access to all 3 sailor channels: navy, mnavy, and pirate.' SAILOR_get_sailor_tag_wiz = \
	/set sailor_tag=wizard

/def SAILOR_fix_tag = \
	/if (%* =~ "") \
		/SAILOR_check_align%;\
	/endif%;\
	/if (%* =~ "pirate") \
		/return "@{BCred}Dread Pirate!@{n}"%;\
	/endif%;\
	/if (%* =~ "navy") \
		/return " @{Cmagenta}Royal Navy!@{n} "%;\
	/endif%;\
	/if (%* =~ "mnavy") \
		/return "@{BCblue}Merchant Navy@{n}"%;\
	/endif

/def SAILOR_check_align = @grep 'channel' sailor help
