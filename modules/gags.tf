;;
;; DraliTF modules/gags.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/def -p1 -ag -t'You have nothing called \'corpse\'!' GAG_1
/def -p1 -ag -t'You fail in tinning and spoil the corpse.' GAG_2
/def -p1 -ag -t'You have no \'can\'.' GAG_3
/def -p1 -ag -t'There is no mithril in *' GAG_4
/def -p1 -ag -t'There is no batium in *' GAG_5
/def -p1 -ag -t'There is no anipium in *' GAG_6
/def -p1 -ag -t'There is nothing here called mithril*' GAG_7
/def -p1 -ag -t'There is nothing here called batium*' GAG_8
/def -p1 -ag -t'There is nothing here called anipium*' GAG_9
/def -p1 -ag -mglob -t'drop mowgles' GAG_10
/def -p1 -ag -mglob -t'drop zinc' GAG_11
/def -p1 -ag -mglob -t'drop tin' GAG_12
/def -p1 -ag -mglob -t'drop copper' GAG_13
/def -p1 -ag -mglob -t'drop bronze' GAG_14
/def -p1 -ag -mglob -t'drop silver' GAG_15
/def -p1 -ag -mglob -t'You have nothing called \'silver\'!' GAG_18
/def -p1 -ag -mglob -t'You have nothing called \'bronze\'!' GAG_19
/def -p1 -ag -mglob -t'You have nothing called \'copper\'!' GAG_20
/def -p1 -ag -mglob -t'You have nothing called \'tin\'!' GAG_21
/def -p1 -ag -mglob -t'You have nothing called \'zinc\'!' GAG_22
/def -p1 -ag -mglob -t'You have nothing called \'mowgles\'!' GAG_23
/def -p1 -ag -mregexp -t'^Uhhh drink from what!$' GAG_24
/def -p1 -ag -mregexp -t'The crystal throbs faintly, healing some of your wounds.' GAG_29
/def -p1 -ag -mregexp -t'The fire\'s warmth soothes you.' GAG_28
/def -p1 -ag -mglob -t'You can not take*' GAG_31
/def -p1 -ag -mregexp -t'You have nothing called \'all corpse\'!' GAG_32
/def -p1 -ag -mglob -t'There is no corpse here*' GAG_33
/def -p100 -ag -mglob -t'Shopkeeper shouts*' GAG_34
/def -p100 -ag -mglob -t'Weaponsmith shouts*' GAG_35
/def -p100 -ag -mglob -t'*Reasonable prices!' GAG_36
/def -p100 -ag -t'*This offer is available only for a limited time, so be quick*' GAG_37
/def -p100 -ag -t'Armourer shouts*' GAG_38
/def -mregexp -F -aCred -t'^You feel that ([A-z]*) goes unconscious.' GAG_39 = /test substitute(strcat({PL}, "You feel extremely happy that %{P1} goes unconscious.", replace("You feel that ([A-z]*) goes unconscious.", "You feel extremely happy that %{P1} goes unconscious.", {PR})))
/def -mregexp -F -aBCred -t'^You feel that ([A-z]*) is in great pain.' GAG_40 = /test substitute(strcat({PL}, "You feel mildly excited that %{P1} is about to die.", replace("You feel that ([A-z]*) is in great pain.", "You feel mildly excited that %{P1} is about to die.", {PR})))
/def -mregexp -F -ag -t'^You feel that ([A-z]*) is satiated.' GAG_41
/def -mregexp -F -ag -t'^You feel that ([A-z]*) has a new level.' GAG_42
/def -mregexp -F -ag -t'^You feel that ([A-z]*) is younger now.' GAG_43

/def -ag -h'SEND {spamgag}*' GAG_44 = /def -ag -t'%2 {wears|removes}*' GAG_%2 = /eval /echo -aCred %2 Swaped

/def unload_gags_module = \
	/purge GAG_*
