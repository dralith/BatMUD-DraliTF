;;
;; DraliTF modules/basic/caster.tf version 0.2
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
;;   roundr                   - toggle spell round reports
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module specific functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def unload_caster_module = \
	/purge -mregexp CASTER_.*%; \
	/purge CMD_roundr%; \
	/unset rounds%; \
	/unset Blastrounds%; \
	/unset concealed

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/COMMAND_register -i'roundr' -n'roundr [on|off]' -f'caster' -d'Toggle/set round reporting [essence eye].' -a'1'

/def CMD_roundr = \
	/if (%{-1} =~ "") \
	    /if (%{rounds} == 1) \
	    	/set rounds=0%; \
	    	/d_pass Casting Rounds [off]%; \
	    /else \
	    	/set rounds=1%; \
	    	/d_pass Casting Rounds [ on]%; \
	    /endif%; \
	/else \
		/if (%{-1} =~ "on")
	    	/set rounds=1%; \
	    	/d_pass Casting Rounds [ on]%; \
	    /else \
	    	/set rounds=0%; \
	    	/d_pass Casting Rounds [off]%; \
	    /endif%; \
	/endif%; \

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Round reporting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def CASTER_reportrounds = \
	/if (%{rounds}) \
		/party_report _general %{Spell} in %{Blastrounds}%; \
	/endif

/def -p1 -mregexp -t'*: (#*)' CASTER_epc = \
	/set Blastrounds=strlen(%{P1})%; \
	/CASTER_reportrounds

/def -p1 -F -t'You skillfully cast the spell with haste.' CASTER_haste1 = \
	/set Blastrounds=$[{Blastrounds}-1]%; \
	/CASTER_reportrounds

/def -p1 -F -t'You skillfully cast the spell with greater haste.' CASTER_haste2 = \
	/set Blastrounds=$[{Blastrounds}-2]%; \
	/CASTER_reportrounds

/def -p1 -F -t'You surreptitiously conceal your spell casting.' CASTER_concealed = \
	/set concealed=1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mana Control
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -p1 -ag -t'You feel like you saved some spellpoints*' CASTER_spsavedgag
