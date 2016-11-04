;;
;; DraliTF modules/mine.tf version 0.3
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Day/Night length timer
/set day_time=$[time()]
/def -aBCred -msimple -t"The eastern sky glows with early dawn." MINE_dawn=
/def -aBCgreen -msimple -t"The sun edges down past the western horizon." MINE_down_past=
/def -aBCred -msimple -t"The sun rises." MINE_sun=\
        /set day_time=$[time()]%;\
        /let delta=$[((day_time-night)/60)]%;\
        /echo -aBCgreen The night was %delta mins long.
/def -aCgreen -msimple -t"The sun sets." MINE_sun_sets=\
        /set night=$[time()]%;\
        /let delta=$[({night}-{day_time})/60]%;\
        /echo -aBCgreen The day was %delta mins long.

; Coffer counters
/def -F -mregexp -t'^    Gold      ([ ]*)([0-9]*) Worth:' MINE_getgoldincoffer = /set goldic=%{P2}
/def -F -mregexp -t'^    Platinum  ([ ]*)([0-9]*) Worth:' MINE_getplatincoffer = /set platic=%{P2}
/def -F -mregexp -t'^    Batium    ([ ]*)([0-9]*) Worth:' MINE_getbatiincoffer = /set batiic=%{P2}
/def -F -mregexp -t'^    Anipium   ([ ]*)([0-9]*) Worth:' MINE_getanipincoffer = /set anipic=%{P2}
/def -F -mregexp -t'^    Mithril   ([ ]*)([0-9]*) Worth:' MINE_getmithincoffer = /set mithic=%{P2}
/def -h'SEND {coff}*' MINE_coff = \
/if (%2 =~ "") \
/echo Cash: %gold Bank: %bank Coffers: Gold(%goldic)%goldic, Platinum(%platic)$[%platic*10] Anipium(%anipic)$[%anipic*50], Batium(%batiic)$[%batiic*100], Mithril(%mithic)$[%mithic*500] >> Total($[%batiic+%anipic+%mithic+%goldic+%gold+%bank])$[(%platic*10)+(%batiic*100)+(%anipic*50)+(%mithic*500)+%bank+%gold+%goldic]%; \
/else \
%-1 Cash: %gold Bank: %bank Coffers: Gold(%goldic)%goldic, Platinum(%platic)$[%platic*10], Anipium(%anipic)$[%anipic*50], Batium(%batiic)$[%batiic*100], Mithril(%mithic)$[%mithic*500] >> Total($[%batiic+%anipic+%mithic+%goldic+%gold+%bank])$[(%platic*10)+(%batiic*100)+(%anipic*50)+(%mithic*500)+%bank+%gold+%goldic]%; \
/endif
/def -h'SEND {pcc}' MINE_pcc = cs-room%;nw%;open \$%;open gold%;%;put gold in gold%;put batium,anipium,mithril,platinum in \$%;la \$%;la gold%;close all coffer%;se%;room-cs%;ne%;e%;ne%;dep%;sw%;w%;sw

/def -h'SEND {cmats}' MINE_check_mats = remove pick;wield staff;raise staff;remove staff;wield pick
/def -h'SEND {rily}' MINE_rily = remove sword%;wield shovel%;dig rubble%;remove shovel%;wield sword

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          URL grabber and opener                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def clear_urls = /set last_url=%;/set last_urls=

/def -mregexp -F -t'http://([-.?&~%/=A-Za-z0-9]*)' grab_urls = \
	/set last_url=http://%{P1}%; \
	/set last_urls=%{last_urls} http://%{P1}%;\
	/set last_urls=$(/unique %{last_urls})

/def get_urls = \
	/set url_count=0%; \
	/set url_mark=%*%; \
	/mapcar /check_url %{last_urls}

/def check_urls = \
	/set url_count=$[%url_count+1]%; \
	/if (%{url_count} = %{url_mark}) \
		/sys opera -newpage "%*"%; \
	/endif

/def list_urls = \
	/echo -p @{Cyellow}[TF]:@{n} @{BCgreen}URL list:@{n}%; \
	/set url_count=0%; \
	/mapcar /echourl %{last_urls}

/def echo_urls = \
	/set url_count=$[%url_count+1]%; \
	/echo -p @{Cyellow}[TF]:@{n} @{BCyellow}$[pad(%{url_count},3)]: %*@{n}

/def unload_mine_module = \
	/purge MINE_*%; \
	/purge *_urls
