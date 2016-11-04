;;
;; DraliTF modules/keybinds.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/def key_f1 = friends
/def key_f2 = sets
/def key_f3 =
/def key_f4 = /save_COUNTER
/def key_f5 = ps
/def key_f6 = show summary
/def key_f7 = show experience
/def key_f8 =
/def key_f9 =
/def key_f10 =
/def key_f11 =
/def key_f12 =

/def -b'^[[11~' F1 = /key_f1
/def -b'^[[12~' F2 = /key_f2
/def -b'^[[13~' F3 = /key_f3
/def -b'^[[14~' F4 = /key_f4
/def -b'^[[15~' F5 = /key_f5
/def -b'^[[17~' F6 = /key_f6
/def -b'^[[18~' F7 = /key_f7
/def -b'^[[19~' F8 = /key_f8
/def -b'^[[20~' F9 = /key_f9
/def -b'^[[21~' F10 = /key_f10
/def -b'^[[23~' F11 = /key_f11
/def -b'^[[24~' F12 = /key_f12

/def key_nkpEnt = /dokey_NEWLINE

/def -b'^[[2~' insert = /key_insert
/def -b'^[[1~' home = /key_home
/def -b'^[[4~' end = /key_end
/def -b'^[[5~' pgup = /key_pgup
/def -b'^[[6~' pgdn = /key_pgdn
/def -b'^[[3~' delete = /key_delete

/def key_end = /dokey_end
;/def key_pgup = /fg ->
;/def key_pgdn = /fg -<

/def -b'^[OA' = /key_up
/def -b'^[OB' = /key_down
/def -b'^[OC' = /key_right
/def -b'^[OD' = /key_left

/def key_up = /dokey searchb
/def key_down = /dokey recallf

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module specific functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def unload_keybinds_module = \
	/purge key_f*
