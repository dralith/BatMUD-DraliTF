;;
;; DraliTF modules/guild/animist.tf version 0.1
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -ag -mregexp -t'^Your soul companion: ([a-z]+) \(([0-9]+)\%\) ([+-]+)' ANIMIST_soul_health = \
    /set soul_health=%{P2}%; \
    /eval /echo SOUL : %{P1} (%{P2}\%)%; \
    /update_rep_status

/def -ag -mregexp -t'^Your soul mount: ([a-z]+) \(([0-9]+)\%\) ([+-]+)' ANIMIST_mount_health = \
    /set mount_health=%{P2}%; \
    /eval /echo MOUNT: %{P1} (%{P2}\%)%; \
    /update_rep_status

/def -mregexp -t'^Your soul training points total is ([0-9]+)\. You have spent ([0-9]+) soul training points\. You have ([0-9]+) unused points\.' ANIMIST_soul_points = \
    /set soul_points=%{P3}

/def -mregexp -t'^Your mount experience level is currently \'([A-z]+)\'\. You are ([0-9]+)\% in to next level\.' ANIMIST_mount_points = \
    /set mount_points=%{P2}%; \
    /update_rep_status

/def update_rep_status = \
    /set guild_status=S\[$[pad(%{soul_points},3)]\]:$[pad(%{soul_health},3)] M\[$[pad(%{mount_points},3)]\]:$[pad(%{mount_health},3)]%; \
    /status_edit -r1 "[":1 guild_status:27 "]":1

/def -mregexp -t'^You are knocked off your mount!$' ANIMIST_dismount = \
    @@lead spirit

;Animist souls
;1      Tinhon                   poor           squirrel

;Animist strike
;You fail your attack.


/def -ag -mregexp -t'^(You feel slightly better at fighting with your soul companion\.|You feel slightly better at fighting with a soul mount\.)$' ANIMIST_GAGS

/def module_animist_unload = \
    /purge -mregexp ANIMIST_.*%; \
    /purge update_rep_status%; \
    /unset soul_points%; \
    /unset soul_health%; \
    /unset mount_points%; \
    /unset mount_health
