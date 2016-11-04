;;
;; DraliTF system/arrays.tf version 0.1
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; /array_add <name> <key> <vals>
/def array_add
;; /array_delete <name> <key>
/def array_delete
;; /array_purge <name>
/def array_purge

;; /array_get <name> <key>
/def array_get
;; /array_length <name>
/def array_length

;; /array_slice <name> <start> [end]
/def array_slice
;; /array_trim <name>
/def array_trim

;; /array_foreach <name> <function>
/def array_foreach
;; /array_unique <name>
/def array_unique
;; /array_keys <name>
/def array_keys
;; /array_values <name>
/def array_values

;; /array_save <name>
/def array_save
;; /array_restore <name>
/def array_restore

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Member array  /member_array <needle> <haystack>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def member_array = \
	/let i=1%; \
	/let len=$(/length %{-1})%; \
	/if (%{1} =~ "") \
		/d_error No arguments given to member_array%; \
		/d_error SYNTAX: member_array(needle, haystack) or /member_array <needle> <haystack>%; \
	  /result (-1)%; \
	/endif%; \
	/if (%{len} == 0) \
	  /d_error Missing haystack array from member_array%; \
		/d_error SYNTAX: member_array(needle, haystack) or /member_array <needle> <haystack>%; \
	  /result (-1)%; \
	/endif%; \
	/while (%{i} <= %{len}) \
		/let tmp=$(/eval /nth %{i} %{-1})%; \
		/if (%{1} =~ %{tmp}) \
			/result (%{i})%; \
		/endif%; \
		/let i=$[%{i}+1]%; \
	/done%; \
	/result (0)
