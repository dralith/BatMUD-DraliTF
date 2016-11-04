;;
;; DraliTF modules/realm_map.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/set location_uid=
/set location_usr=
/set gag_whereami=0

/def -F -w'BatMUD' -h'SEND {north|south|east|west|northwest|northeast|southeast|southwest|n|s|e|w|nw|ne|se|sw|N|S|E|W|SE|SW|NW|NE}' MAPPER_movement = \
	/set gag_whereami=$[gag_whereami+1]%; \
	/send %{*}%; \
	/send whereami

/def -mregexp -t'^(The ship cruises ([a-z]+)\.|The ship cruises ([a-z]+) along the tradelane\.)$' MAPPER_ship_movement = \
	/set gag_whereami=$[gag_whereami+1]%; \
	/send whereami

/def -mregexp -t'^You stop\.$' MAPPER_travel_movement = \
	/set gag_whereami=$[gag_whereami+1]%; \
	/send whereami

/def -ag -mregexp -F -t'You are in \'(.*)\' in (.*)\. \(Global: ([0-9]+)x, ([0-9]+)y\)' MAPPER_whereami_ship = \
	/if (%{gag_whereami} = 0) \
	  /echo -aCyellow %{P0}%; \
	/else \
	  /set gag_whereami=$[gag_whereami - 1]%; \
    /endif%; \
      /MAPPER_update_ow_location %{P3},%{P4}

/def -ag -mregexp -F -t'You are in \'(.*)\' in (.*) on the continent of ([A-z ]+)\. \(Coordinates: ([0-9]+)x, ([0-9]+)y\; Global: ([0-9]+)x, ([0-9]+)y\)' MAPPER_whereami_inside = \
	/if (%{gag_whereami} = 0) \
	  /echo -aCyellow %{P0}%; \
	/else \
	  /set gag_whereami=$[gag_whereami - 1]%; \
    /endif%; \
      /MAPPER_update_ow_location %{P6},%{P7}


/def -ag -mregexp -F -t'You are in \'(.*)\', which is on the continent of ([A-z ]+)\. \(Coordinates: ([0-9]+)x, ([0-9]+)y\; Global: ([0-9]+)x, ([0-9]+)y\)' MAPPER_whereami_outside = \
	/if (%{gag_whereami} = 0) \
	  /echo -aCyellow %{P0}%; \
	/else \
	  /set gag_whereami=$[gag_whereami - 1]%; \
    /endif%; \
      /MAPPER_update_ow_location %{P5},%{P6}

/def MAPPER_update_ow_location = \
	/quote !wget --spider -q "http:///esiris.no-ip.org:2222/bat/bmap/update.php?uid=%{location_uid}&coords=%{*}" -o /dev/null
;	/sys wget --spider -q "http:///esiris.no-ip.org:2222/bat/bmap/update.php?uid=%{location_uid}&coords=%{*}" -o /dev/null
