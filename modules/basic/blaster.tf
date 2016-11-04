;;
;; DraliTF modules/basic/blaster.tf version 0.2
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
/def unload_blaster_module = \
	/purge -mregexp BLAST_.*%; \
	/unset devastated%; \
	/unset dcrit%; \
	/unset Spelltype%; \
	/unset rep_msg

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Base Vars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set devastated=0
/set dcrit=0
/set Spelltype=psi

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Blaster Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -mregexp -t'^You watch with self\-pride as your ([a-z ]+) hits ([A-z ]*).' BLAST_type = \
;; CHANNU blasts
	/if (%P1 =~ "channelray"|%P1 =~ "channelball") /set Spelltype=mana%; /endif%;\
	/if (%P1 =~ "channelspray"|%P1 =~ "channelburn") /set Spelltype=fire%; /endif%;\
	/if (%P1 =~ "channelbolt") /set Spelltype=electric%; /endif%;\
;; DRUID blasts
	/if (%P1 =~ "star light"|%P1 =~ "wither flesh") /set Spelltype=mana%; /endif%;\
	/if (%P1 =~ "gem fire") /set Spelltype=fire%; /endif%;\
	/if (%P1 =~ "hoar frost") /set Spelltype=cold%; /endif%;\
;; MAGE blasts
	/if (%P1 =~ "cold ray"|%P1 =~ "icebolt"|%P1 =~ "darkfire"|%P1 =~ "flaming ice"|%P1 =~ "chill touch") /set Spelltype=cold%; /endif%;\
	/if (%P1 =~ "lava blast"|%P1 =~ "meteor blast"|%P1 =~ "fire blast"|%P1 =~ "firebolt"|%P1 =~ "flame arrow") /set Spelltype=fire%; /endif%;\
	/if (%P1 =~ "acid blast"|%P1 =~ "acid ray"|%P1 =~ "acid arrow"|%P1 =~ "acid wind"|%P1 =~ "disruption") /set Spelltype=acid%; /endif%;\
	/if (%P1 =~ "golden arrow"|%P1 =~ "summon greater spores"|%P1 =~ "levin bolt"|%P1 =~ "summon lesser spores"|%P1 =~ "magic missile") /set Spelltype=mana%; /endif%;\
	/if (%P1 =~ "electrocution"|%P1 =~ "forked lightning"|%P1 =~ "blast lightning"|%P1 =~ "lightning bolt"|%P1 =~ "shocking grasp") /set Spelltype=electric%; /endif%;\
	/if (%P1 =~ "summon carnal spores"|%P1 =~ "power blast"|%P1 =~ "venom strike"|%P1 =~ "poison blast"|%P1 =~ "thorn spray") /set Spelltype=poison%; /endif%;\
	/if (%P1 =~ "blast vacuum"|%P1 =~ "strangulation"|%P1 =~ "chaos bolt"|%P1 =~ "suffocation"|%P1 =~ "vacuumbolt") /set Spelltype=asphyx%; /endif%;\
;; BARD blasts
	/if (%P1 =~ "con fioco") /set Spelltype=fire%; /endif%;\
	/if (%P1 =~ "noituloves deathlore") /set Spelltype=psi%; /endif%;\
	/if (%P1 =~ "uncontrollable mosh"|%P1 =~ "noituloves dischord") /set Spelltype=phys%; /endif%;\
;; PSIONICIST blasts
	/if (%P1 =~ "mind disruption"|%P1 =~ "psi blast"|%P1 =~ "psibolt"|%P1 =~ "mind blast") /set Spelltype=psi%; /endif%;\
;; RIFTWALKER blasts
	/if (%P1 =~ "rift pulse"|%P1 =~ "spark birth") /set Spelltype=cold%; /endif

/def -mregexp -t'You crush ([A-z ]*)\'s mind with your psychic attack!' BLAST_type2 = \
	/set Spelltype=psi

/def -mregexp -t'You devastate ([A-z ]*)\'s mind with your powers!' BLAST_devastated = \
	/set Devastated=1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Resistance Reports
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -PCyellow -mregexp -t'^([A-z ]*) screams in pain.' BLAST_etscreams = \
	/BLAST_report %P1 screams (0\% %{Spelltype} resistance)

/def -F -PCyellow -mregexp -t'^([A-z ]*) writhes in agony.' BLAST_etwrithes = \
	/BLAST_report %P1 writhes (20\% %{Spelltype} resistance)

/def -F -PCyellow -mregexp -t'^([A-z ]*) grunts from the pain.' BLAST_etgrunts = \
	/BLAST_report %P1 grunts (40\% %{Spelltype} resistance)

/def -F -PCyellow -mregexp -t'^([A-z ]*) shudders from the force of the attack.' BLAST_etshudd = \
	/BLAST_report %P1 shudders (60\% %{Spelltype} resistance)

/def -F -PCyellow -mregexp -t'^([A-z ]*) winces a little from the pain.' BLAST_etwinces = \
	/BLAST_report %P1 winces (80\% %{Spelltype} resistance)

/def -F -PCyellow -mregexp -t'^([A-z ]*) shrugs off the attack.' BLAST_etshrugs = \
	/BLAST_report %P1 shrugs  (100\% %{Spelltype} resistance)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def BLAST_report = \
	/if (%{Devastated} == 1) \
		/set rep_msg=%* [Devastated]%;\
		/set Devastated=0%;\
	/else \
		/set rep_msg=%*%;\
	/endif%;\
	/if (%{dcrit} != 0) \
		/set rep_msg=%{rep_msg} Dcrit[%{dcrit}]%;\
		/set dcrit=0%;\
	/endif%;\
	/party_report _blast %{rep_msg}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dcrit Triggers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -aCgreen -t'You feel like your spell gained additional power.' BLAST_dcrit1 = \
	/set dcrit=1

/def -aCgreen -t'You feel like you managed to channel additional POWER to your spell.' BLAST_dcrit2 = \
	/set dcrit=2

/def -aCgreen -t'Your fingertips are surrounded with swirling ENERGY as you cast the spell.' BLAST_dcrit3 = \
	/set dcrit=3

/def -aCgreen -t'You feel connected to the very essence of magic.' BLAST_dcrit4 = \
	/set dcrit=4
