;;
;; DraliTF modules/guild/bard.tf version 0.2
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
;;   vw                       - cast venturers way
;;   warez                    - cast war ensemble
;;   nd [target]              - cast noituloves dischord at [target]
;;   cf [target]              - cast con fioco at [target]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module specific functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def unload_bard_module = \
	/purge -mregexp BARD_.*%; \
	/purge tri_*

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bard commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -h'SEND {vw}*' BARD_cvw = cast venturers way
/def -h'SEND {warez}*' BARD_cwarez = cast war ensemble
/def -h'SEND {nd}*' BARD_cnd = cast 'noituloves dischord' %-1
/def -h'SEND {cf}*' BARD_ccf = cast 'con fioco' %-1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Jesters Trivia Spammer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;============[A]W|U|U|F|H|W|Fab|PFG|================================
;; Name       [l]e|s|p|s|W|W|AoA|PFE|Fir|Asp|Aci|Col|Psi|Poi|Mag|Ele|
;;===================================================================
;; Harle      [G]X|X|X| | | |   |   | X |   |   |   |   |   |   |   |
;; Beanos     [G]X| |X| | | |   |   |   |   |   |   |   |   |   |   |
;; Mikaiyla   [G]X| |X| | | |   |   |   |   |   |   |   |   |   |   |
;; Krnlpanik  [E]X|X| | | | | X |   |   |   |   |   |   |   |   |   |
;;[Harle] [good] [ heavy weight and war ensemble ]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -mregexp -F -t'The information floods into your mind:' BARD_start_tri = \
	/set tri_name=%; \
	/BARD_reset_tri%; \
	/BARD_check_tri_prots

/def -mregexp -F -t'^[[](.*)[]] [[](.*)[]] [[] ' BARD_get_tri_name = \
	/set tri_name=$[substr(%{P1},0,10)]%; \
	/if (%{P2} =~ "evil") \
		/set tri_align=E%; \
	/endif%; \
	/if (%{P2} =~ "good") \
		/set tri_align=G%; \
	/endif%; \
	/if (%{P2} =~ "a bit evil") \
		/set tri_align=e%; \
	/endif%; \
	/if (%{P2} =~ "a bit good") \
		/set tri_align=g%; \
	/endif%; \
	/if (%{P2} =~ "neutral") \
		/set tri_align=N%; \
	/endif%; \
	/BARD_check_tri_prots%;\
	/BARD_reset_tri%;

/def -mregexp -F -t'heavy weight' BARD_check_tri_hw = /set tri_hw=X
/def -mregexp -F -t'war ensemble' BARD_check_tri_war = /set tri_war=X
/def -mregexp -F -t'unstun' BARD_check_tri_uns = /set tri_uns=X
/def -mregexp -F -t'unpain' BARD_check_tri_unp = /set tri_unp=X
/def -mregexp -F -t'force shield' BARD_check_tri_fsh = /set tri_fsh=X
/def -mregexp -F -t'force absorbtion' BARD_check_tri_fabaoa = /set tri_fabaoa=x
/def -mregexp -F -t'armour of aether' BARD_check_tri_fabaoa2 = /set tri_fabaoa=X
/def -mregexp -F -t'heavy weight' BARD_check_tri_hw = /set tri_hw=X
/def -mregexp -F -t'water walking' BARD_check_tri_ww = /set tri_ww=X
/def -mregexp -F -t'floating' BARD_check_tri_ww2 = /set tri_ww=X
/def -mregexp -F -t'levitation' BARD_check_tri_ww3 = /set tri_ww=X
/def -mregexp -F -t'protection from evil' BARD_check_tri_pfe = /set tri_pfge=X
/def -mregexp -F -t'protection from good' BARD_check_tri_pfg = /set tri_pfge=X
/def -mregexp -F -t'heat reduction' BARD_check_tri_fir = /set tri_fir=x
/def -mregexp -F -t'flame shield' BARD_check_tri_fir2 = /set tri_fir=X
/def -mregexp -F -t'ether boundry' BARD_check_tri_asp = /set tri_asp=x
/def -mregexp -F -t'aura of wind' BARD_check_tri_asp2 = /set tri_asp=X
/def -mregexp -F -t'corrosion shield' BARD_check_tri_aci = /set tri_aci=x
/def -mregexp -F -t'acid shield' BARD_check_tri_aci2 = /set tri_aci=X
/def -mregexp -F -t'frost insulation' BARD_check_tri_col = /set tri_col=x
/def -mregexp -F -t'frost shield' BARD_check_tri_col2 = /set tri_col=X
/def -mregexp -F -t'toxic dilution' BARD_check_tri_poi = /set tri_poi=x
/def -mregexp -F -t'shield of detoxification' BARD_check_tri_poi2 = /set tri_poi=X
/def -mregexp -F -t'magic dispersion' BARD_check_tri_mag = /set tri_mag=x
/def -mregexp -F -t'repulsor aura' BARD_check_tri_mag2 = /set tri_mag=X
/def -mregexp -F -t'energy channeling' BARD_check_tri_ele = /set tri_ele=x
/def -mregexp -F -t'lightning shield' BARD_check_tri_ele2 = /set tri_ele=X
/def -mregexp -F -t'psychic sanctuary' BARD_check_tri_psi = /set tri_psi=x
/def -mregexp -F -t'psionic phalanx' BARD_check_tri_psi2 =  /set tri_psi=X
/def -mregexp -F -t'iron will' BARD_check_tri_iw = /set tri_iw=X

/def -F -P0BCyellow -mregexp -t'^You memorize the tunes for (.*)' BARD_memorize

/def -h'SEND {chpr}' BARD_check_tri_prots = \
	/if (tri_name =~ "") \
		@@emote ============[A]W|I|U|U|F|H|W|Fab|PFG|= Type prots [x=minor X=major] = %; \
		@@emote  Name       [l]e|W|s|p|s|W|W|AoA|PFE|Fir|Asp|Aci|Col|Psi|Poi|Mag|Ele| %; \
		@@emote ====================================================================| %; \
		/set tri_cast=1%; \
		/repeat -00:00:01 1 /BARD_reset_tri_2%;\
	/endif%; \
	/if (tri_name !~ "" & tri_cast = 1) \
		@@emote  $[pad({tri_name},-10)] [$[pad(%{tri_align},1)]]$[pad(%{tri_war},1)]|$[pad(%{tri_iw},1)]|$[pad(%{tri_uns},1)]|$[pad(%{tri_unp},1)]|$[pad(%{tri_fsh},1)]|$[pad(%{tri_hw},1)]|$[pad(%{tri_ww},1)]| $[pad( %{tri_fabaoa},1)] | $[pad(%{tri_pfge},1)] | $[pad(%{tri_fir},1)] | $[pad(%{tri_asp},1)] | $[pad(%{tri_aci},1)] | $[pad(%{tri_col},1)] | $[pad(%{tri_psi},1)] | $[pad(%{tri_poi},1)] | $[pad(%{tri_mag},1)] | $[pad(%{tri_ele},1)] |%;\
	/endif%;

/def BARD_reset_tri = /set tri_align=%;/set tri_war=%;/set tri_uns=%;/set tri_unp=%;/set tri_fsh=%;/set tri_fab=%;/set tri_aoa=%;/set tri_pfg=%;/set tri_pfe=%;/set tri_hw=%;/set tri_ww=

/def BARD_reset_tri_2 = /set tri_align=%;/set tri_war=%;/set tri_uns=%;/set tri_unp=%;/set tri_fsh=%;/set tri_fab=%;/set tri_aoa=%;/set tri_pfg=%;/set tri_pfe=%;/set tri_hw=%;/set tri_ww=%;/set tri_name=%;/set tri_cast=0
