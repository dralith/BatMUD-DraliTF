;;
;; DraliTF modules/count.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;message index = sqrt((float)(25 * 25 * DAMAGE / 1000))
;;min_dam = (index * 1000 / 25 / 25) * (index * 1000 / 25 / 25)
;;crit "original" message index = DAMAGE / (crit_id + 1)
;;dam type message index = 3.85%/msg

/eval /load tf/saves/counter.tf

/def add_COUNTER = \
	/if (!getopts("i:t:n:m:a:q:","")) /d_error Invalid add_counter definition!%;/break%;/endif%; \
	/eval /set cnt_tmp=%%{%{opt_t}_count}%; \
	/if ($(/length %{cnt_tmp}) <= %{opt_i}) \
		/eval /set %{opt_t}_count=%%{%{opt_t}_count} 0%; \
		/eval /set %{opt_t}_crits=%%{%{opt_t}_crits} 0%; \
		/eval /set %{opt_t}_index=%%{%{opt_t}_index} %{opt_n}%; \
	/endif%; \
	/if (%{opt_q} =~ "weapon") \
		/def -mregexp -F -t'^You %{opt_m} .*' %{opt_n}_COUNTER_00 = /inc_COUNTER %{opt_t} %{opt_i} 0%; \
		/def -mregexp -F -t'^([A-z]+) ([a-z]+) you %{opt_m} .*' %{opt_n}_COUNTER_01 = /inc_COUNTER %{opt_t} %{opt_i} 1%; \
	/else \
		/def -mregexp -F -t'%{opt_m}' %{opt_n}_COUNTER_00 = /inc_COUNTER %{opt_t} %{opt_i} 0%; \
	/endif

;;	/def -mregexp -t'^([A-z ]+) %{opt_a} .*' %{opt_n}_COUNTER_10 = /inc_COUNTER %{opt_t} %{opt_i} 0%; \
;;	/def -mregexp -t'^([A-z]+) ([a-z]+) ([A-z ]+) %{opt_a} .*' %{opt_n}_COUNTER_11 = /inc_COUNTER %{opt_t} %{opt_i} 1

/add_COUNTER -i0	-q"misc"	-t"misc"	-n"Tumble"			-m"^([A-z ]*) tries to dodge your hit, but you are not fooled that easily!"			-a""
/add_COUNTER -i1	-q"misc"	-t"misc"	-n"Dodge"			-m"^You successfully dodge (.*)"													-a""
/add_COUNTER -i2	-q"misc"	-t"misc"	-n"Tumbled"			-m"^You try to dodge, but ([A-z ]*) is not fooled."									-a""
/add_COUNTER -i3	-q"misc"	-t"misc"	-n"Miss"			-m"^You miss ([A-z ]*)."															-a""
/add_COUNTER -i4	-q"misc"	-t"misc"	-n"Parry"			-m"^You successfully parry (.*)"													-a""
/add_COUNTER -i5	-q"misc"	-t"misc"	-n"Riposte"			-m"^...AND quickly."																-a""
/add_COUNTER -i6 	-q"misc"	-t"misc"	-n"Combat_Sense"	-m"^Your marvellous sense of combat prevents your (.*) from getting scratched\."	-a""
/if (member_array("misc", %{counters}) <= 0) /eval /set counters=%{counters} misc%; /endif

/add_COUNTER -i0	-t"crit"	-n"Grinning_wickedly"		-m"^Grinning wickedly you"		-a"Grinning wickedly"		-q"misc"
/add_COUNTER -i1	-t"crit"	-n"Cackling_demonically"	-m"^Cackling demonically you"	-a"Cackling demonically"	-q"misc"
/add_COUNTER -i2	-t"crit"	-n"Snickering_savagely"		-m"^Snickering savagely you"	-a"Snickering savagely"		-q"misc"
/add_COUNTER -i3	-t"crit"	-n"Smiling_demonically"		-m"^Smiling demonically you"	-a"Smiling demonically"		-q"misc"
/add_COUNTER -i4	-t"crit"	-n"Grimacing_fiendishly"	-m"^Grimacing fiendishly you"	-a"Grimacing fiendishly"	-q"misc"
/add_COUNTER -i5	-t"crit"	-n"Grinning_diabolically"	-m"^Grinning diabolically you"	-a"Grinning diabolically"	-q"misc"
/add_COUNTER -i6	-t"crit"	-n"Smiling_devilishly"		-m"^Smiling devilishly you"		-a"Smiling devilishly"		-q"misc"
/add_COUNTER -i7	-t"crit"	-n"Grinning_satanically"	-m"^Grinning satanically you"	-a"Grinning satanically"	-q"misc"
/add_COUNTER -i8	-t"crit"	-n"Snickering_softly"		-m"^Snickering softly you"		-a"Snickering softly"		-q"misc"
/add_COUNTER -i9	-t"crit"	-n"Chortling_cruelly"		-m"^Chortling cruelly you"		-a"Chortling cruelly"		-q"misc"
/add_COUNTER -i10	-t"crit"	-n"Smirking_satanically"	-m"^Smirking satanically you"	-a"Smirking satanically"	-q"misc"
/add_COUNTER -i11	-t"crit"	-n"Smiling_happily"			-m"^Smiling happily you"		-a"Smiling happily"			-q"misc"
/add_COUNTER -i12	-t"crit"	-n"Grunting_gruesomely"		-m"^Grunting gruesomely you"	-a"Grunting gruesomely"		-q"misc"
/add_COUNTER -i13	-t"crit"	-n"Cackling_devilishly"		-m"^Cackling devilishly you"	-a"Cackling devilishly"		-q"misc"
/if ($(/member_array "crit" %{counters}) <= 0) /eval /set counters=%{counters} crit%; /endif


/add_COUNTER -i0	-q"weapon"	-t"tiger_ma"	-n"Slap"					-m"slap"									-a"slaps"
/add_COUNTER -i1	-q"weapon"	-t"tiger_ma"	-n"Step_on"					-m"step on"									-a"steps on"
/add_COUNTER -i2	-q"weapon"	-t"tiger_ma"    -n"Grab"					-m"grab"									-a"grabs"
/add_COUNTER -i3	-q"weapon"	-t"tiger_ma"	-n"Toe-kick"				-m"toe-kick"								-a"toe-kicks"
/add_COUNTER -i4	-q"weapon"	-t"tiger_ma"	-n"Knee"					-m"knee"									-a"knees"
/add_COUNTER -i5	-q"weapon"	-t"tiger_ma"	-n"Punch"					-m"punch"									-a"punches"
/add_COUNTER -i6	-q"weapon"	-t"tiger_ma"	-n"Elbow-smash"				-m"elbow-smash"								-a"elbow-smashes"
/add_COUNTER -i7	-q"weapon"	-t"tiger_ma"	-n"Stomp-kick"				-m"stomp-kick"								-a"stomp-kicks"
/add_COUNTER -i8	-q"weapon"	-t"tiger_ma"	-n"Foot-sweep"				-m"foot-sweep"								-a"foot-sweeps"
/add_COUNTER -i9	-q"weapon"	-t"tiger_ma"	-n"Throw"					-m"twist and throw"							-a"grabs and throws"
/add_COUNTER -i10	-q"weapon"	-t"tiger_ma"	-n"Finger-jab"				-m"finger-jab"								-a"finger-jabs"
/add_COUNTER -i11	-q"weapon"	-t"tiger_ma"	-n"Joint-lock"				-m"joint-lock"								-a"joint-locks"
/add_COUNTER -i12	-q"weapon"	-t"tiger_ma"	-n"Uppercut"				-m"uppercut"								-a"uppercuts"
/add_COUNTER -i13	-q"weapon"	-t"tiger_ma"	-n"Spinning_Back_Kick"		-m"spinning back kick"						-a"spins and back kicks"
/add_COUNTER -i14	-q"weapon"	-t"tiger_ma"	-n"Phoenix-eye_punch"		-m"phoenix-eye punch"						-a"phoenix-eye punches"
/add_COUNTER -i15	-q"weapon"	-t"tiger_ma"	-n"Spinning_backfist"		-m"spinning back fist"						-a"spins then backfists"
/add_COUNTER -i16	-q"weapon"	-t"tiger_ma"	-n"Jump_side-kick"			-m"jump up and side-kick"					-a"Jumps up and side-kicks"
/add_COUNTER -i17	-q"weapon"	-t"tiger_ma"	-n"Dragon-claw"				-m"dragon-claw"								-a"dragon-claws"
/add_COUNTER -i18	-q"weapon"	-t"tiger_ma"	-n"Groin-rip"				-m"feint high and then cruelly groin-rip"	-a"feints high and then cruelly groin-rips"
/add_COUNTER -i19	-q"weapon"	-t"tiger_ma"	-n"Snake-strike"			-m"snake-strike"							-a"snake-strikes"
/add_COUNTER -i20	-q"weapon"	-t"tiger_ma"	-n"Chain_punch"				-m"pummel, with dozens of chain punches"	-a"pummels, with dozens of chain punches"
/add_COUNTER -i21	-q"weapon"	-t"tiger_ma"	-n"Swallow-tail_Kick"		-m"leap, spin, and swallow-tail KICK"		-a"leaps, spins, and swallow-tail KICKS"
/add_COUNTER -i22	-q"weapon"	-t"tiger_ma"	-n"DEVASTATE"				-m"DEVASTATE, with a thrusting blow,"		-a"DEVASTATES"
/add_COUNTER -i23	-q"weapon"	-t"tiger_ma"	-n"BRUTALLY_THROAT_RIP"		-m"BRUTALLY THROAT RIP"						-a"BRUTALLY THROAT RIPS"
/add_COUNTER -i24	-q"weapon"	-t"tiger_ma"	-n"SAVAGELY_BELLY_SMASH"	-m"SAVAGELY BELLY SMASH"					-a"SAVAGELY BELLY SMASHES"
/add_COUNTER -i25	-q"weapon"	-t"tiger_ma"	-n"CRUELLY_TIGER_STRIKE"	-m"CRUELLY TIGER STRIKE"					-a"CRUELLY TIGER STRIKES"
/add_COUNTER -i26	-q"weapon"	-t"tiger_ma"	-n"Miss_(tiger_ma)"			-m"miss"									-a"misses"
/if (member_array("tiger_ma", %{counters}) <= 0) /eval /set counters=%{counters} tiger_ma%; /endif

/add_COUNTER -i0	-q"weapon"	-t"slash"	-n"Scrape"					-m"scrape"					-a"scrapes"
/add_COUNTER -i1	-q"weapon"	-t"slash"	-n"Solidly_Slash"			-m"solidly slash"			-a"solidly slashes"
/add_COUNTER -i2	-q"weapon"	-t"slash"	-n"Gash"					-m"gash"					-a"gashes"
/add_COUNTER -i3	-q"weapon"	-t"slash"	-n"Lightly_Cut"				-m"lightly cut"				-a"lightly cuts"
/add_COUNTER -i4	-q"weapon"	-t"slash"	-n"Cut"						-m"cut"						-a"cuts"
/add_COUNTER -i5	-q"weapon"	-t"slash"	-n"Tear"					-m"tear"					-a"tears"
/add_COUNTER -i6	-q"weapon"	-t"slash"	-n"Incise"					-m"incise"					-a"incises"
/add_COUNTER -i7	-q"weapon"	-t"slash"	-n"Shred"					-m"shred"					-a"shreds"
/add_COUNTER -i8	-q"weapon"	-t"slash"	-n"Horribly_Shred"			-m"horribly shred"			-a"horribly shreds"
/add_COUNTER -i9	-q"weapon"	-t"slash"	-n"Slash"					-m"slash"					-a"slashes"
/add_COUNTER -i10	-q"weapon"	-t"slash"	-n"Incisively_Cut"			-m"incisively cut"			-a"incisively cuts"
/add_COUNTER -i11	-q"weapon"	-t"slash"	-n"Incisiveley_Tear"		-m"incisively tear"			-a"incisively tears"
/add_COUNTER -i12	-q"weapon"	-t"slash"	-n"Slit"					-m"slit"					-a"slits"
/add_COUNTER -i13	-q"weapon"	-t"slash"	-n"Cruelly_Tatter"			-m"cruelly tatter"			-a"cruelly tatters"
/add_COUNTER -i14	-q"weapon"	-t"slash"	-n"Savagely_Shave"			-m"savagely shave"			-a"savagely shaves"
/add_COUNTER -i15	-q"weapon"	-t"slash"	-n"Rive"					-m"rive"					-a"rives"
/add_COUNTER -i16	-q"weapon"	-t"slash"	-n"Cruelly_Slash"			-m"cruelly slash"			-a"cruelly slashes"
/add_COUNTER -i17	-q"weapon"	-t"slash"	-n"Uncontrollably_Slash"	-m"uncontrollably slash"	-a"uncontrollably slashes"
/add_COUNTER -i18	-q"weapon"	-t"slash"	-n"Quickly_Cut"				-m"quickly cut"				-a"quickly cuts"
/add_COUNTER -i19	-q"weapon"	-t"slash"	-n"Savagely_Rip"			-m"savagely rip"			-a"savagely rips"
/add_COUNTER -i20	-q"weapon"	-t"slash"	-n"BRUTALLY_TEAR"			-m"BRUTALLY TEAR"			-a"BRUTALLY TEARS"
/add_COUNTER -i21	-q"weapon"	-t"slash"	-n"SAVAGELY_SHRED"			-m"SAVAGELY SHRED"			-a"SAVAGELY SHREDS"
/add_COUNTER -i22	-q"weapon"	-t"slash"	-n"CRUELLY_REND"			-m"CRUELLY REND"			-a"CRUELLY RENDS"
/add_COUNTER -i23	-q"weapon"	-t"slash"	-n"BARBARICALLY_REND"		-m"BARBARICALLY REND"		-a"BARBARICALLY RENDS"
/add_COUNTER -i24	-q"weapon"	-t"slash"	-n"DISMEMBER"				-m"DISMEMBER"				-a"DISMEMBERS"
/add_COUNTER -i25	-q"weapon"	-t"slash"	-n"CRUELLY_DISMEMBER"		-m"CRUELLY DISMEMBER"		-a"CRUELLY DISMEMBERS"
/add_COUNTER -i26	-q"weapon"	-t"slash"	-n"Miss_(slash)"			-m"miss"					-a"misses"
/if (member_array("slash", %{counters}) <= 0) /eval /set counters=%{counters} slash%; /endif

/add_COUNTER -i0	-q"weapon"	-t"bash"	-n"lightly_jostle"		-m"lightly jostle"		-a""
/add_COUNTER -i1	-q"weapon"	-t"bash"	-n"jostle"				-m"jostle"				-a""
/add_COUNTER -i2	-q"weapon"	-t"bash"	-n"butt"				-m"butt"				-a""
/add_COUNTER -i3	-q"weapon"	-t"bash"	-n"bump"				-m"bump"				-a""
/add_COUNTER -i4	-q"weapon"	-t"bash"	-n"thump"				-m"thump"				-a""
/add_COUNTER -i5	-q"weapon"	-t"bash"	-n"stroke"				-m"stroke"				-a""
/add_COUNTER -i6	-q"weapon"	-t"bash"	-n"thrust"				-m"thrust"				-a""
/add_COUNTER -i7	-q"weapon"	-t"bash"	-n"jab"					-m"jab"					-a""
/add_COUNTER -i8	-q"weapon"	-t"bash"	-n"bash"				-m"bash"				-a""
/add_COUNTER -i9	-q"weapon"	-t"bash"	-n"strike"				-m"strike"				-a""
/add_COUNTER -i10	-q"weapon"	-t"bash"	-n"sock"				-m"sock"				-a""
/add_COUNTER -i11	-q"weapon"	-t"bash"	-n"cuff"				-m"cuff"				-a""
/add_COUNTER -i12	-q"weapon"	-t"bash"	-n"knock"				-m"knock"				-a""
/add_COUNTER -i13	-q"weapon"	-t"bash"	-n"flail"				-m"flail"				-a""
/add_COUNTER -i14	-q"weapon"	-t"bash"	-n"whack"				-m"whack"				-a""
/add_COUNTER -i15	-q"weapon"	-t"bash"	-n"beat"				-m"beat"				-a""
/add_COUNTER -i16	-q"weapon"	-t"bash"	-n"smash"				-m"smash"				-a""
/add_COUNTER -i17	-q"weapon"	-t"bash"	-n"cruelly_beat"		-m"cruelly beat"		-a""
/add_COUNTER -i18	-q"weapon"	-t"bash"	-n"badly_smash"			-m"badly smash"			-a""
/add_COUNTER -i19	-q"weapon"	-t"bash"	-n"horribly_thrust"		-m"horribly thrust"		-a""
/add_COUNTER -i20	-q"weapon"	-t"bash"	-n"savagely_sock"		-m"savagely sock"		-a""
/add_COUNTER -i21	-q"weapon"	-t"bash"	-n"savagely_strike"		-m"savagely strike"		-a""
/add_COUNTER -i22	-q"weapon"	-t"bash"	-n"REALLY_WHACK"		-m"REALLY WHACK"		-a""
/add_COUNTER -i23	-q"weapon"	-t"bash"	-n"BRUTALLY_BEAT"		-m"BRUTALLY BEAT"		-a""
/add_COUNTER -i24	-q"weapon"	-t"bash"	-n"CRUELLY_CUFF"		-m"CRUELLY CUFF"		-a""
/add_COUNTER -i25	-q"weapon"	-t"bash"	-n"BARBARICALLY_BASH"	-m"BARBARICALLY BASH"	-a""
/add_COUNTER -i26	-q"weapon"	-t"bash"	-n"Miss_(bash)"			-m"miss"				-a"misses"
/if (member_array("bash", %{counters}) <= 0) /eval /set counters=%{counters} bash%; /endif

/add_COUNTER -i0	-q"weapon"	-t"shield"	-n"Lightly_Shove"		-m"lightly shove"			-a"lightly shoves"
/add_COUNTER -i1	-q"weapon"	-t"shield"	-n"Lightly_Batter"		-m"lightly batter"			-a"lightly batters"
/add_COUNTER -i2	-q"weapon"	-t"shield"	-n"Lightly_Push"		-m"lightly push"			-a"lightly pushes"
/add_COUNTER -i3	-q"weapon"	-t"shield"	-n"Lightly_Bash"		-m"lightly bash"			-a"lightly bashes"
/add_COUNTER -i4	-q"weapon"	-t"shield"	-n"Lightly_Slam"		-m"lightly slam"			-a"lightly slams"
/add_COUNTER -i5	-q"weapon"	-t"shield"	-n"Lightly_Crush"		-m"lightly crush"			-a"lightly crushes"
/add_COUNTER -i6	-q"weapon"	-t"shield"	-n"Heavily_Shove"		-m"heavily shove"			-a"heavily shoves"
/add_COUNTER -i7	-q"weapon"	-t"shield"	-n"Batter"				-m"batter"					-a"batters"
/add_COUNTER -i8	-q"weapon"	-t"shield"	-n"Heavily_Push"		-m"heavily push"			-a"heavily pushes"
/add_COUNTER -i9	-q"weapon"	-t"shield"	-n"Heavily_Bash"		-m"heavily bash"			-a"heavily bashes"
/add_COUNTER -i10	-q"weapon"	-t"shield"	-n"Slam"				-m"slam"					-a"slams"
/add_COUNTER -i11	-q"weapon"	-t"shield"	-n"Crush"				-m"crush"					-a"crushes"
/add_COUNTER -i12	-q"weapon"	-t"shield"	-n"Really_Shove"		-m"really shove"			-a"really shoves"
/add_COUNTER -i13	-q"weapon"	-t"shield"	-n"Really_Batter"		-m"really batter"			-a"really batters"
/add_COUNTER -i14	-q"weapon"	-t"shield"	-n"Really_Push"			-m"really push"				-a"really pushes"
/add_COUNTER -i15	-q"weapon"	-t"shield"	-n"Really_Bash"			-m"really bash"				-a"really bashes"
/add_COUNTER -i16	-q"weapon"	-t"shield"	-n"Really_Slam"			-m"really slam"				-a"really slams"
/add_COUNTER -i17	-q"weapon"	-t"shield"	-n"Really_Crush"		-m"really crush"			-a"really crushes"
/add_COUNTER -i18	-q"weapon"	-t"shield"	-n"Cruelly_Shove"		-m"cruelly shove"			-a"cruelly shoves"
/add_COUNTER -i19	-q"weapon"	-t"shield"	-n"Cruelly_Batter"		-m"cruelly batter"			-a"cruelly batters"
/add_COUNTER -i20	-q"weapon"	-t"shield"	-n"Cruelly_Push"		-m"cruelly push"			-a"cruelly pushes"
/add_COUNTER -i21	-q"weapon"	-t"shield"	-n"Cruelly_Bash"		-m"cruelly bash"			-a"cruelly bashes"
/add_COUNTER -i22	-q"weapon"	-t"shield"	-n"REALLY_SLAMC"		-m"REALLY SLAM"				-a"REALLY SLAMS"
/add_COUNTER -i23	-q"weapon"	-t"shield"	-n"REALLY_CRUSHC"		-m"REALLY CRUSH"			-a"REALLY CRUSHES"
/add_COUNTER -i24	-q"weapon"	-t"shield"	-n"BRUTALLY_CRUSH"		-m"BRUTALLY CRUSH"			-a"BRUTALLY CRUSHES"
/add_COUNTER -i25	-q"weapon"	-t"shield"	-n"BARBARICALLY_SLAM"	-m"BARBARICALLY SLAM"		-a"BARBARICALLY SLAMS"
/add_COUNTER -i26	-q"weapon"	-t"shield"	-n"Miss_(shield)"		-m"miss"					-a"misses"
/if (member_array("shield", %{counters}) <= 0) /eval /set counters=%{counters} shield%; /endif
/eval /set counters=$(/unique %{counters})


/def disp_COUNTER = \
	/set type=%{1}%; \
	/eval /set _index=%%{%{type}_index}%; \
	/eval /set _crits=%%{%{type}_crits}%; \
	/eval /set _count=%%{%{type}_count}%; \
	/set ilen=$(/eval /length %{_index})%; \
	/set in=1%; \
	/set ind=1%; \
	/set T_dama=0%;\
	/set T_hits=0%;\
	/set T_crit=0%;\
	/set A_hit_count=0%; \
	/set T_miss=$(/nth 27 %{_count})%; \
	/echo ,-------------------------------------------------------------------------------------------------.%; \
	/echo |Message:               Hit:  \%:  Ct: \%:  Dam:   |Message:               Hit:  \%:  Ct: \%:  Dam:   |%; \
	/while (%{in} < %{ilen}) \
		/set indx=$(/nth %{in} %{_index})%; \
		/set crit=$(/nth %{in} %{_crits})%; \
		/set coun=$(/nth %{in} %{_count})%; \
		/set T_hits=$[%{coun} + %{T_hits}]%; \
		/set T_crit=$[%{crit} + %{T_crit}]%; \
    	/set in=$[%{in}+1]%; \
  	/done%; \
	/set in=1%; \
	/while (%{in} < %{ilen}) \
		/set indx=$(/nth %{in} %{_index})%; \
		/set crit=$(/nth %{in} %{_crits})%; \
		/set coun=$(/nth %{in} %{_count})%; \
		/set dama=$[((%{in} * 1000 / 25 / 25) * (%{in} * 1000 / 25 / 25))]%; \
		/set dama=$[(%{coun} + %{crit}) * %{dama}]%; \
		/set T_dama=$[%{dama} + %{T_dama}]%; \
		/if (%{A_hit_count} <=  %{coun}) \
			/set A_hit_count=%{coun}%; \
			/set A_hit=%{indx}%; \
		/endif%; \
		/if (%{indx} !~ "") \
			/if (%{T_hits} < 1) \
				/let hit_perc=0%; \
			/else \
      			/let hit_perc=$[%{coun}*100/(%{T_hits})]%; \
      		/endif%; \
      		/if (%{T_crit} < 1) \
      			/let crit_perc=0%; \
      		/else \
      			/let crit_perc=$[%{crit}*100/%{T_crit}]%; \
      		/endif%; \
			/set cout=%{cout} |$[pad(%{indx},-22)] $[pad(%{coun},5)] $[pad(%{hit_perc},2)]\% $[pad(%{crit},3)] $[pad(%{crit_perc},2)]\% $[pad(%{dama},6)]%; \
			/if (%{ind} == 2) \
				/echo %{cout} |%; \
				/set ind=0%; \
				/set cout=%; \
			/endif%; \
			/set ind=$[%{ind}+1]%; \
		/endif%; \
		/set in=$[%{in}+1]%; \
	/done %; \
	/echo |-------------------------------------------------------------------------------------------------|%; \
	/echo | Total Hits: \[$[pad(%{T_hits},10)]\] ---------- Total Crits: \[$[pad(%{T_crit},6)]\] ---------- Total Damage: \[$[pad(%{T_dama},10)]\] |%; \
	/if ((%{T_miss}+%{T_hits}) < 1) \
		/set hit_p=0\%%; \
	/else \
		/set hit_p=$[%{T_hits} * 100 / (%{T_miss}+%{T_hits})]\%%; \
	/endif%; \
	/let dod=$(/nth 2 %{misc_count})%; \
	/let tum=$(/nth 1 %{misc_count})%; \
	/let par=$(/nth 5 %{misc_count})%; \
	/let rip=$(/nth 6 %{misc_count})%; \
	/echo | Total Miss: \[$[pad(%{T_miss},10)]\] ---------- Hit Percent: \[$[pad(%{hit_p},4)]\] - Average Hit: \[$[pad(%{A_hit},22)]\] |%; \
	/echo | Dodges: \[$[pad(%{dod},6)]\] ------- Parries: \[$[pad(%{par},6)]\] ------- Ripostes: \[$[pad(%{rip},6)]\] ------- Tumbles: \[$[pad(%{tum},6)]\] |%; \
	/echo `-------------------------------------------------------------------------------------------------'%; \
	/unset cout%;/unset in%;/unset ind%;/unset indx%;/unset ilen%;/unset _index%;/unset _crits%;/unset _count%;/unset type%; \
	/unset coun%;/unset crit%;/unset A_hit%;/unset A_hit_count%;/unset T_miss%;/unset T_dama%;/unset T_hits%;/unset T_crit

/def inc_COUNTER = \
	/set cname=%{1}%; \
	/set cindex=%{2}%; \
	/set crit_hit=%{3}%; \
	/set new_count=%;/set count=0%; \
	/if (%{crit_hit} == 1) \
		/eval /set tcount=%%{%{cname}_crits}%; \
	/else \
		/eval /set tcount=%%{%{cname}_count}%; \
	/endif%; \
	/let len=$(/length %{tcount})%; \
	/while (%{count}<=%{len}) \
		/set temp_count=$(/pop tcount)%; \
		/if (%{count} == %{cindex}) \
			/set new_count=%{new_count} $[%{temp_count}+1]%; \
		/else \
			/set new_count=%{new_count} %{temp_count}%; \
		/endif%; \
		/set count=$[%{count}+1]%; \
	/done%; \
	/if (%{crit_hit} == 1) \
		/set %{cname}_crits=%{new_count}%;\
	/else \
		/set %{cname}_count=%{new_count}%;\
	/endif%; \
	/unset tcount%;/unset cindex%;/unset cname%;/unset crit_hit%;/unset new_count%; \
	/unset count%;/unset temp_count%;/unset len

/def save_COUNTER = \
	/let striim=$[tfopen("tf/saves/counter.tf","w")]%; \
	/let len=$(/length %{counters})%; \
	/set i=1%; \
	/while (%{i} <= %{len}) \
		/eval /set cname=$$(/nth %%{i} %{counters})%; \
		/eval /set cdata=%%{%{cname}_count}%; \
		/test $[tfwrite(striim,strcat("/set ",cname,"_count=",cdata,""))]%; \
		/eval /set cdata=%%{%{cname}_crits}%; \
		/test $[tfwrite(striim,strcat("/set ",cname,"_crits=",cdata,""))]%; \
		/eval /set cdata=%%{%{cname}_index}%; \
		/test $[tfwrite(striim,strcat("/set ",cname,"_index=",cdata,""))]%; \
		/set i=$[%{i}+1]%; \
	/done%; \
	/test $[tfwrite(striim,strcat("/set counters=",counters,""))]%; \
	/unset i%;/test $[tfclose(striim)]

/def unload_counter_module = \
	/save_COUNTER%; \
	/purge -mregexp .*COUNTER.*%; \
	/let len=$(/length %{counters})%; \
	/set i=1%; \
	/while (%{i} <= %{len}) \
		/eval /unset $$(/nth %%{i} %{counters})_count%; \
		/eval /unset $$(/nth %%{i} %{counters})_index%; \
		/eval /unset $$(/nth %%{i} %{counters})_crits%; \
		/set i=$[%{i}+1]%; \
	/done%;/unset i%;/unset counters
