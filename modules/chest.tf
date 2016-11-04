;;
;; DraliTF modules/chest.tf version 0.2
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
;; Module specific functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def unload_chest_module = \
	/purge CHEST_*

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lite open/closed chests
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -P0BCred -mregexp -t'\(open\)' CHEST_open
/def -F -P0BCgreen -mregexp -t'\(closed\)' CHEST_closed

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Add slot counters to chest descriptions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -mregexp -t'([A-Z,A-z,0-9]*) contains: \(([0-9]*) out of ([0-9]*) slot(.*) used\)' CHEST_remslots = \
	/def -F -mregexp -t'labeled as $[tolower(%{P1})]' CHEST_%{P1}chest_count = /set str=\%*\%;/substitute -p \%{str} ($[pad(%{P2},2)]/$[pad(%{P3},2)])%; \
	/let striim= $[tfopen(strcat(strcat(%{TF_DIR},"/saves/chests/"),$[tolower(%{P1})],".tf"),"w")]%; \
	/test $[tfwrite(striim,strcat("/def -F -mregexp -t'labeled as ",$[tolower(%{P1})],"' CHEST_",%{P1},"chest_count = /set str=%*%;/substitute -p %{str} (",$[pad(%{P2},2)],"/",$[pad(%{P3},2)],")"))]%;\
	/test $[tfclose(striim)]

/def -h'SEND {adchest}*' CHEST_addchest = \
	/let striim= $[tfopen(strcat(%{TF_DIR},"/saves/chests.tf"),"a")]%; \
	/test $[tfwrite(striim,strcat("/load ",%{TF_DIR},"/saves/chests/",$[tolower(%2)],".tf"))]%; \
	/test $[tfclose(striim)]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Gag reinforcements
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -mregexp -t'reinforced with ([a-z]*) ' CHEST_reinfgag = \
	/test substitute(strcat({PL}, "", replace("reinforced with (.*)", "", {PR})))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load chest data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/load %{TF_DIR}/saves/chests.tf
