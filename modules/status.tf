;;
;; DraliTF modules/status.tf version 0.2
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
/def unload_status_module = \
	/undef update_status%; \
	/purge STATUS_*%; \
	/set status_height=1%; \
	/status_defaults

/set hp=0
/set hpmax=0
/set sp=0
/set spmax=0
/set ep=0
/set epmax=0
/set exp=0
/set gold=0
/set bank=0
/set cerato=0
/set ccamp=1
/set poison=0
/set stunn=1
/set mediav=1
/set kataav=0
/set guild_status="  "
/status_add -r0 -c
/status_add -r1 -c
/status_add -r2 -c
/set campcol=BCgreen
/set cerecol=BCred
/set poiscol=BCgreen
/set stuncol=BCyellow
/set medicol=BCgreen
/set katacol=BCred
/set komdbar="       "
/set komdspc="         "
/set pbs_status=PBS[          ]
/set isize=2
/set status_int_log=nlog() ? "L" : ""
/set status_int_clock=ftime("%H:%M", time())
/set status_var_insert=insert ? "I" : "O"
/set status_pad=
/set status_height=2


/def -i update_status=\
/if (GUILD_channeller=0) /set auracol=BCblack%; /endif%; \
/if (stunn == 0) /set stuncol=BCred%; /endif%;\
/if (stunn == 1) /set stuncol=BCyellow%; /endif%;\
/if (stunn == 2) /set stuncol=BCgreen%; /endif%;\
/if (poison == 0) /set poiscol=BCgreen%; /endif%;\
/if (poison == 1) /set poiscol=BCred%; /endif%;\
/if (ccamp == 0) /set campcol=BCred%; /endif%;\
/if (ccamp == 1) /set campcol=BCgreen%; /endif%;\
/if (cerato == 0) /set cerecol=BCred%; /endif%;\
/if (cerato == 1) /set cerecol=BCgreen%; /endif%;\
/if (mediav == 0) /set medicol=BCred%; /endif%;\
/if (mediav == 1) /set medicol=BCgreen%; /endif%;\
/if (kataav == 0) /set katacol=BCred%; /endif%;\
/if (kataav == 1) /set katacol=BCgreen%; /endif%;\
/status_add -r0 -c%;/status_add -r0 -c%;/status_add -r1 -c%;/status_add -r2 -c%;\
/status_add -r0 -x "HP[":3 hp:-4:%{hpcol} "/":1 hpmax:4:%{hpcol} "]":1 " SP[":4 sp:-4:%{spcol} "/":1 spmax:4:%{spcol} "]":1 " EP[":4 ep:-3:%{epcol} "/":1 epmax:3:%{epcol} "]":1%;\
/status_add -r1 -x "Exp[":4 exp:-7 "|   ":1 tonextmeg:-7 "|     ":1 bonuspool:6 "] ":1 %;\
/status_add -r1 -x "Cash[":6 gold:-6 "+":1 bank:6 "]  ":1 %;\
/status_add -r0 -x "C":1:%{campcol} "M":1:%{medicol} "|     ":1 "P":1:%{cerecol} "K":1:%{katacol} "|     ":1 "S":1:%{stuncol} "D":1:%{poiscol}%;\
/status_add -r0 -x "[ ":1 @world:8 "| ":1 @more:10 "|":1 insert:1 "|  ":1 @clock:-5 "] ":1%;\
/if (%{GUILD_psi} == 1) \
/status_add -r1 -x "KOMD: [   ":7 %{komdbar}:6:Cbggreen %{komdspc}:1:Cbggreen "]   ":1%;\
/elseif (%{GUILD_crimson} == 1) \
/status_add -r1 -x pbs_status:15%; \
/elseif (%{GUILD_barb} == 1) \
/status_add -r1 -x "[ ":1  %{rep_n_bl}:7:Cbggreen %{rep_gained_bl}:-6: " ]":1%;\
/else \
/status_add -r1 -x "[":1%; \
/status_add -r1 -x guild_status:27%; \
/status_add -r1 -x "]":1%; \
/endif%; \
grep character\\. show experience%;\
exp

/update_status

/def -mregexp -t'Exp (|bonus )pool: ([0-9]*)' STATUS_get_pool_exp = \
	/set bonuspool=%{P2}%; \
	/status_edit -r1 bonuspool:6

/def -h'SEND {fprompt}' STATUS_fixprompt = \
	@@prompt Hp:<hp>/<maxhp> Ep:<ep>/<maxep> Sp:<sp>/<maxsp> EXP:<exp> \$<cash>+<bank> e\%:<rooms><lf>

/def -h'SEND {fscore}' STATUS_fixshortscore = \
	@@sc set h:<hp>/<maxhp>[{diffhp}] s:<sp>/<maxsp>[{diffsp}] e:<ep>/<maxep>[{diffep}] xp:<exp>[{diffexp}] \$:<cash>+<bank>[{diffcash}] eq:<eqset>

/def -p1 -F -mregexp -t'^h:([0-9-]*)/([0-9]*)\[(.*)\] s:([0-9-]*)/([0-9-]*)\[(.*)\] e:([0-9-]*)/([0-9-]*)\[(.*)\] xp:([0-9]*)\[(.*)\] \$:([0-9]*)\+([0-9]*)\[(.*)\] eq:(.*)' STATUS_sc_tickreport =\
/set hp=%{P1}%;/set hpmax=%{P2}%;/set hpdiff=%{P3}%;/set sp=%{P4}%;/set spmax=%{P5}%;/set spdiff=%{P6}%; \
/set ep=%{P7}%;/set epmax=%{P8}%;/set epdiff=%{P9}%;/set exp=%{P10}%;/set expdiff=%{P11}%; \
/set cash=%{P12}%;/set cashdiff=%{P14}%;/set bank=%{P13}%;/set eqset=%{P15}%; \
/if (%spmax == 0) /set spmax=1%; /endif%; \
/set hpperc=$[%hp * 100 / %hpmax]%;/set epperc=$[%ep * 100 / %epmax]%;/set spperc=$[%sp * 100 / %spmax]%; \
/set hpcol=$[lite_by_percent_2(%{hpperc})]%;/set spcol=$[lite_by_percent_2(%{spperc})]%;/set epcol=$[lite_by_percent_2(%{epperc})]%; \
/set diffs=0%;/set tickt=$[timer(%{ltick})]%; \
/if (%hpdiff > 1 | %hpdiff < 0) /set diffs=1%;/status_edit -r0 hp:-4:%hpcol%;/status_edit -r0 hpmax:4:%hpcol%; /endif%; \
/if (%spdiff > 1 | %spdiff < 0) /set diffs=1%;/status_edit -r0 sp:-4:%spcol%;/status_edit -r0 spmax:4:%spcol%; /endif%; \
/if (%epdiff > 1 | %epdiff < 0) /set diffs=1%;/status_edit -r0 ep:-3:%epcol%;/status_edit -r0 epmax:3:%epcol%; /endif%; \
/if (%diffs > 0 & get_setting("AUTO_ticker_report") = 1) emote HP:(%hpdiff)%hpperc% SP:(%spdiff)%spperc% EP:(%epdiff)%epperc%  [%tickt]%;/set ltick=$[time()]%; /endif%; \
/if (ressed == 1) /set totxpgain=$[%totxpgain+%expdiff]%;/set ressxp=$[%ressxp+%expdiff]%;/set ressed=0%;/TARM_save%;/echo Gained %expdiff from ress%; /endif%;\
/if (raised == 1) /set totxpgain=$[%totxpgain+%expdiff]%;/set raisxp=$[%raisxp+%expdiff]%;/set raised=0%;/TARM_save%;/echo Gained %expdiff from rais%; /endif%;\
/if (bodyed == 1) /set totxpgain=$[%totxpgain+%expdiff]%;/set bodyxp=$[%bodyxp+%expdiff]%;/set bodyed=0%;/TARM_save%;/echo Gained %expdiff from body%; /endif%;\
/if (reinced == 1) /set totxpgain=$[%totxpgain+%expdiff]%;/set reincxp=$[%reincxp+%expdiff]%;/set reinced=0%;/TARM_save%;/echo Gained %expdiff from reinc%; /endif%;\
/if (%expdiff > 1 | %expdiff < 0) /set tonextmeg=$[nextmeg-(exptotal+exp)]%;/if (tonextmeg < 0) /set nextmeg=$[nextmeg+1000000]%; /endif%;/set tonextmeg=$[pad(tonextmeg,7)]%;/status_edit -r1 tonextmeg:-7%;/status_edit -r1 exp:-7%; /endif%; \
/if (%goldiff > 1 | %goldiff < 0) /status_edit -r1 gold:-6%;/status_edit -r1 bank:6%; /endif%; \
/set hpmaxdiff=$[%oldhpmax - %hpmax]%;/if (%hpmaxdiff = 4) @pe is losing control of his demons.%;/set sdcont=0%; /endif%;\
/set oldhpmax=%hpmax%;/set oldexp=%exp%;/set oldgold=%gold%;/set oldsp=%sp%;/set oldep=%ep%;/set oldhp=%hp

/def -p1 -ag -F -mregexp -t'^Hp:([0-9-]*)/([0-9-]*) Ep:([0-9-]*)/([0-9-]*) Sp:([0-9-]*)/([0-9-]*) EXP:([0-9-]*) \$([0-9-]*)\+([0-9-]*) e:*' STATUS_tickreport = \
/set hp=%{P1}%;/set hpmax=%{P2}%;/set ep=%{P3}%;/set epmax=%{P4}%;/set sp=%{P5}%;/set spmax=%{P6}%;/set exp=%{P7}%;/set gold=%{P8}%;/set bank=%{P9}%;\
/set expl=%{6}%;/set expldif=$[%expl - %oldexpl]%;/set expdiff=$[%exp - %oldexp]%;/set goldiff=$[%gold - %oldgold]%; \
/set hpdiff=$[%hp - %oldhp]%;/set epdiff=$[%ep - %oldep]%;/set spdiff=$[%sp - %oldsp]%; \
/if (%spmax == 0) /set spmax=1%; /endif%; \
/set hpperc=$[%hp * 100 / %hpmax]%;/set epperc=$[%ep * 100 / %epmax]%;/set spperc=$[%sp * 100 / %spmax]%; \
/set diffs=0%;/set tickt=$[time() - %ltick]%; \
/set hpcol=$[lite_by_percent_2(%{hpperc})]%;/set spcol=$[lite_by_percent_2(%{spperc})]%;/set epcol=$[lite_by_percent_2(%{epperc})]%; \
/set diffs=0%;/set tickt=$[timer(%{ltick})]%; \
/if (%hpdiff > 1 | %hpdiff < 0) /set diffs=1%;/status_edit -r0 hp:-4:%hpcol%;/status_edit -r0 hpmax:4:%hpcol%; /endif%; \
/if (%spdiff > 1 | %spdiff < 0) /set diffs=1%;/status_edit -r0 sp:-4:%spcol%;/status_edit -r0 spmax:4:%spcol%; /endif%; \
/if (%epdiff > 1 | %epdiff < 0) /set diffs=1%;/status_edit -r0 ep:-3:%epcol%;/status_edit -r0 epmax:3:%epcol%; /endif%; \
/if (%diffs > 0 & get_setting("AUTO_ticker_report") = 1) emote HP:(%hpdiff)%hpperc% SP:(%spdiff)%spperc% EP:(%epdiff)%epperc%  [%tickt]%;/set ltick=$[time()]%; /endif%; \
/if (ressed == 1) /set totxpgain=$[%totxpgain+%expdiff]%;/set ressxp=$[%ressxp+%expdiff]%;/set ressed=0%;/TARM_save%;/echo Gained %expdiff from ress%; /endif%;\
/if (raised == 1) /set totxpgain=$[%totxpgain+%expdiff]%;/set raisxp=$[%raisxp+%expdiff]%;/set raised=0%;/TARM_save%;/echo Gained %expdiff from rais%; /endif%;\
/if (bodyed == 1) /set totxpgain=$[%totxpgain+%expdiff]%;/set bodyxp=$[%bodyxp+%expdiff]%;/set bodyed=0%;/TARM_save%;/echo Gained %expdiff from body%; /endif%;\
/if (reinced == 1) /set totxpgain=$[%totxpgain+%expdiff]%;/set reincxp=$[%reincxp+%expdiff]%;/set reinced=0%;/TARM_save%;/echo Gained %expdiff from reinc%; /endif%;\
/if (%expdiff > 1 | %expdiff < 0) /set tonextmeg=$[nextmeg-(exptotal+exp)]%;/if (tonextmeg < 0) /set nextmeg=$[nextmeg+1000000]%; /endif%;/set tonextmeg=$[pad(tonextmeg,7)]%;/status_edit -r1 tonextmeg:-7%;/status_edit -r1 exp:-7%; /endif%; \
/if (%goldiff > 1 | %goldiff < 0) /status_edit -r1 gold:-6%;/status_edit -r1 bank:6%; /endif%; \
/set oldexp=%exp%;/set oldgold=%gold%;/set oldsp=%sp%;/set oldep=%ep%;/set oldhp=%hp
