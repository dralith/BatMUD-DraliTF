;;
;; DraliTF modules/guild/tiger.tf version 0.2
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
/def unload_tiger_module = \
	/purge TIGER*

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; base vars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set leap1=1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tiger claw
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -mregexp -F -t'^As (.*) drops to [a-z]* knees you leap in for the kill!' TIGER_claw1 = \
	/party_report _general [Clawed]%; \
	/set claw1=$[%claw1+1]

/def -mregexp -F -t' manages to resist your claws!' TIGER_claw2 = \
	/party_report _general [Resisted claw]%; \
	/set claw2=$[%claw2+1]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dim mak
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -t'You poke * with a finger almost breaking it!' TIGER_mak1 = \
	/party_report _general [Dim mak:0%]%; \
	/set mak1=$[%mak1+1]

/def -F -t'Your Dim Mak touch just tickles the target.' TIGER_mak2 = \
	/party_report _general [Dim mak:5%]%; \
	/set mak2=$[%mak1+1]

/def -F -t'You prod * in your attempt to kill *.' TIGER_mak3 = \
	/party_report _general [Dim mak:10%]%; \
	/set mak3=$[%mak3+1]

/def -F -t'You shove * by the shoulder.' TIGER_mak4 = \
	/party_report _general [Dim mak:20%]%; \
	/set mak4=$[%mak4+1]

/def -F -t'You poke * in the ribs with two fingers going in.' TIGER_mak5 = \
	/party_report _general [Dim mak:35%]%; \
	/set mak5=$[%mak5+1]

/def -F -t'You pinch * ear and channel chi.' TIGER_mak6 = \
	/party_report _general [Dim mak:50%]%; \
	/set mak6=$[%mak6+1]

/def -F -t'You shake * hand applying correct pressure.' TIGER_mak7 = \
	/party_report _general [Dim mak:65%]%; \
	/set mak7=$[%mak7+1]

/def -F -t'You mask your Dim Mak attack as tickling.' TIGER_mak8 = \
	/party_report _general [Dim mak:80%]%; \
	/set mak8=$[%mak8+1]

/def -F -t'You caress * softly with your hands channeling*' TIGER_mak9 = \
	/party_report _general [Dim mak:90%]%; \
	/set mak9=$[%mak9+1]

/def -F -t'You touch * in all the right places applying*' TIGER_mak10 = \
	/party_report _general [Dim mak:100%]%; \
	/set mak10=$[%mak10+1]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; shadow leap
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -mregexp -F -t'^You leap to the shadows and arrive to your target!' TIGER_leap0 = \
	/set leap1=0

/def -mregexp -F -t'^Your do, the inner self, balances itself.' TIGER_leap1 = \
	/party_report _general [Able to leap again]%; \
	/set leapl=1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tiger rep points
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -mregexp -F -t'^You feel more connected to Curath than ever before!' TIGER_clawpoint = \
	/set clawp=$[%clawp+1]%; \
	/party_report _general [Gained a focus point (tiger claw)]

/def -mregexp -F -t'^You learn to focus power from the deepest core of your being!' TIGER_makpoint = \
	/set makp=$[%makp+1]%; \
	/party_report _general [Gained a focus point (dim mak)]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Iron palm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -mregexp -F -t'^You do a complex attack maneuver but miss' ironpalm3. = \
	/set ip3=$[%ip3+1]

/def -mregexp -F -t'^You hit an open hand strike to' TIGER_ironpalm1 = \
	/set ip1=$[%ip1+1]%; \
	/set ipdamage=$[%ipdamage+100]

/def -mregexp -F -t'^You kick (.*) in the stomach making' TIGER_ironpalm4 = \
	/set ip4=$[%ip4+1]%; \
	/set ipdamage=$[%ipdamage+120]

/def -mregexp -F -t'^You deliver a strong finger-strike' TIGER_ironpalm5 = \
	/set ip5=$[%ip5+1]%; \
	/set ipdamage=$[%ipdamage+140]

/def -mregexp -F -t'^You execute a well timed combination' TIGER_ironpalm6 = \
	/set ip6=$[%ip6+1]%; \
	/set ipdamage=$[%ipdamage+145]

/def -mregexp -F -t'^You move with blinding speed' TIGER_ironpalm2 = \
	/set ip2=$[%ip2+1]%; \
	/set ipdamage=$[%ipdamage+150]

/def -mregexp -F -t'^Your hands start to glow with power.' TIGER_ironpalm7 = \
	/set ip7=$[%ip7+1]%; \
	/set ipdamage=$[%ipdamage+160]
