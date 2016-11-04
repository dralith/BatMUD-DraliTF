;;
;; DraliTF modules/guild/crimson.tf version 0.2
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
;;   bc <target>              - use battlecry at <target>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module specific functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def unload_crimson_module = \
	/purge CRIMSO_*%; \
	/unset pbs_target%; \
	/unset pbs_active

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Crimson commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -h'SEND {bc}*' bcry = \
	earmark %-1%; \
	use 'battlecry' %-1%; \
	pr [Battlecry->%-1]%; \
	terror %-1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Protection by Stupidity(Sacrifice) functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -mregexp -t'^You kneel in front of ([A-z]*) and whisper \'With my life I\'ll protect yours\'\.' CRIMSO_pbs_1 = \
	/set pbs_target=%{P1}

/def -F -t'Soldier\'s vow has been given.' CRIMSO_pbs_2 = \
	/set pbs_active=1%; \
	/CRIMSO_update_c_status

/def -F -mregexp -t'^You no longer protect ([A-z]*)' CRIMSO_pbs_3 = \
	/set pbs_active=0%; \
	/party_report _general [No longer protecting %{pbs_target}]%; \
	/set pbs_target=%; \
	/CRIMSO_update_c_status

/def -mregexp -F -t'^With reflexes almost impossibly quick you dive in front of ([A-z]*),' CRIMSO_pbs_4 = \
	/party_report _general [Stupidity saved: %{P1}]

/def -mregexp -F -t'^You are already protecting ([A-z]*)\.' CRIMSO_pbs_5 = \
	/set pbs_target=%{P1}%;\
	/CRIMSO_update_c_status

/def CRIMSO_update_c_status = \
	/set pbs_status=PBS[$[pad(%{pbs_target},-10)]]%; \
	/status_edit -r1 pbs_status:15
