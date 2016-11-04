;;
;; DraliTF modules/friends.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -mregexp -t'^Added \[([A-z]+)\] to the friends list\.' FRIENDS_added_friend = \
	/set friends_list=%{friends_list} $[tolower(%{P1})]%; \
	/set friends_list=$(/unique %{friends_list})%; \
	/set friends_removed=$(/remove $[tolower(%{P1})] %{friends_removed})%; \
	/FRIENDS_save

/def -mregexp -t'^Removed \[([A-z]+)\] from your friends list\.' FRIENDS_removed_friend = \
	/set friends_removed=%{friends_removed} $[tolower(%{P1})]%; \
	/set friends_removed=$(/unique %{friends_removed})%; \
	/set friends_list=$(/remove $[tolower(%{P1})] %{friends_list})%; \
	/FRIENDS_save

/def FRIENDS_update = \
	/let i=1%; \
	/let len=$(/length %{friends_list})%; \
	/while (%{i} < %{len}) \
		/eval @@friends -a $(/nth %{i} %{friends_list})%; \
		/let i=$[%{i} + 1]%; \
	/done%; \
	/let i=1%; \
	/let len=$(/length %{friends_removed})%; \
	/while (%{i} < %{len}) \
		/eval @@friends -d $(/nth %{i} %{friends_removed})%; \
		/let i=$[%{i} + 1]%; \
	/done%; \

/def FRIENDS_save = \
	/let handle=$[tfopen(strcat(%{TF_DIR},"/saves/friends.tf"),"w")]%; \
	/test $[tfwrite(%{handle}, strcat("/set friends_list=", %{friends_list}, ""))]%; \
    /test $[tfwrite(%{handle}, strcat("/set friends_removed=", %{friends_removed}, ""))]%; \
	/test (tfclose(%{handle}))

/def -ag -mregexp -F -t'^Alas, you already have ([A-z]+) in your friends list.' FRIENDS_gag_add
/def -ag -mregexp -F -t'^You don't have ([A-z]+) on your friends list.' FRIENDS_gag_remove

/def module_friends_unload = \
	/PURGE -mregexp FRIENDS_.*%; \
	/unset friends_list%; \
	/unset friends_removed%; \
	/unset friends_remove

/eval /load %{TF_DIR}/saves/friends.tf
