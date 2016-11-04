;;
;; DraliTF modules/guild/riftwalker.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;entity skills
;Your entity is using 'blazing_sunder'.
/def -aBCcyan -t'Your entity is prepared to do the skill.' RIFTW_entity_skill

/def -t'Your disc wavers dangerously.' RIFTW_disc_drop = /party_report _general DISC DROPPING!! TIME TO RELOAD!

;entity control
;--=  Fire entity  HP:495(557) [-28] [controlled] []  =--
;--=  Fire entity  HP:166(540) [-6] [CONTROLLED] []  =--
/def -t'Your control over your entity starts to waver, something has disrupted the link!' RIFTW_elink_drop1 = /party_report _general Link to Entity dropping!!
/def -t'Entity sense: You feel free of your master but it leaves you feeling weak.' RIFTW_elink_drop2 = /party_report _general Link to Entity dropped!!

/def -mregexp -F -t'^A dazzling spark races along the stream of green light between you and (.*)!' RIFTW_spark_made = keep add all spark
/def -mregexp -F -t'^A crumpled piece of paper flies through the air and you grab it!' RIFTW_remnant_made = keep add all paper

;rift pulse
;Your hands tingle and glow for a second.

;; Earth Entity
/def -mregexp -F -t'^Earth entity seems to bulk up, and starts making threatening gestures\.$' RIFTW_earth_up = \
	/party_report _general [Earthen Cover:Up]
/def -mregexp -F -t'^Your earth entity hunches down looking much less solid than a second ago\.$' RIFTW_earth_down = \
	/party_report _general [Earthen Cover:Down]


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMMANDS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Rift entity spells
;1 spark
/COMMAND_register_i  -n'econ'	-m'riftwalker'	-a"cast 'establish entity control'"
/COMMAND_register_i  -n'bere'	-m'riftwalker'	-a"cast 'beckon rift entity'"
/COMMAND_register_i  -n'bire'	-m'riftwalker'	-a"cast 'bind rift entity' \$*"
/COMMAND_register_i  -n'dire'	-m'riftwalker'	-a"cast 'dismiss rift entity'"
/COMMAND_register_i  -n'rscr'	-m'riftwalker'	-a"cast 'rift scramble'"
/COMMAND_register_i  -n'trre'	-m'riftwalker'	-a"cast 'transform rift entity' \$*"
;5 sparks
/COMMAND_register_i  -n'sume'	-m'riftwalker'	-a"cast 'summon rift entity' \$*"
/COMMAND_register_i  -n'rege'	-m'riftwalker'	-a"cast 'regenerate rift entity' \$*"

;; Offspells
/COMMAND_register_i  -n'rrp'	-m'riftwalker'	-a"cast 'rift pulse' \$*"
/COMMAND_register_i  -n'rsb'	-m'riftwalker'	-a"cast 'spark birth' \$*"

;; Misc
/COMMAND_register_i  -n'disc'	-m'riftwalker'	-a"cast 'floating disc' mydisc"

;; Prots
/COMMAND_register_i	 -n'fabs'	-m'riftwalker'	-a"cast 'force absorption' \$*;party report [FAbs->\$*]"
/COMMAND_register_i	 -n'mirrors' -m'riftwalker'	-a"cast 'mirror image' \$*;party report [Mirrors->\$*]"
/COMMAND_register_i	 -n'iw'		-m'riftwalker'	-a"cast 'iron will' \$*;party report [IW->\$*]"

/def unload_riftwalker_module = \
    /purge -mregexp RIFTW_.*%; \
    /COMMAND_cleanup riftwalker
