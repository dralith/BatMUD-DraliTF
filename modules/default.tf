;;
;; DraliTF modules/default.tf version 0.2
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
;;   Command <arguments>        - Description
;;   fnm                        - Fix the next million var
;;   next <Skill/Spell> <guild> - Check how much exp you need for the next
;;                                percent of <Skill/Spell> in <guild>
;;   sets  (HOTKEY: F2)         - Show your current client settings and the
;;                                commands to change them.
;;   See 'Command aliasing' section
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module specific functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def unload_default_module = \
	/purge SET_*%; \
	/purge *_queue%; \
	/purge convert_*%; \
	/purge *_setting%; \
	/undef pss%; \
	/purge MISC_*%; \
	/purge CMD_*

/def -mregexp -F -t'^What is your name: ([a-z]+)' SET_my_name = \
	/eval /set MY_NAME=$[tolower(%{P1})]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Command registration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/COMMAND_register -i'k' -n'k <target>' -f'default' -d'Attack <target>' -a'1'
/COMMAND_register -i'sp' -n'sp' -f'default' -d'Report that you are out of SP' -a'0'
/COMMAND_register -i'ep' -n'ep' -f'default' -d'Report that you are out of EP' -a'0'
/COMMAND_register -i'qpeer' -n'qpeer <direction>' -f'default' -d'Quote "peer <dir>" to emote' -a'1'
/COMMAND_register -i'tg' -n'tg <mob>' -f'default' -d'Target <mob>' -a'1'
/COMMAND_register -i'rec' -n'rec <search>' -f'default' -d'Search scrollback for <search>' -a'1'
/COMMAND_register -i'dm' -n'dm' -f'default' -d'Drop 1 mowgles' -a'0'
/COMMAND_register -i'gc' -n'gc' -f'default' -d'Get good coins and chests' -a'0'
/COMMAND_register -i'fb' -n'fb' -f'default' -d'Build a fire' -a'0'
/COMMAND_register -i'fish' -n'fish' -f'default' -d'Use fishing' -a'0'
/COMMAND_register -i'fa' -n'fa <player>' -f'default' -d'Use first aid at <player>' -a'1'
/COMMAND_register -i'camp' -n'camp' -f'default' -d'Take a nap' -a'0'
/COMMAND_register -i'medi' -n'medi' -f'default' -d'Meditate on the state of things' -a'0'
/COMMAND_register -i'tc' -n'tc' -f'default' -d'Create a torch' -a'0'
/COMMAND_register -i'co' -n'co <target>' -f'default' -d'Consider <target>' -a'1'
/COMMAND_register -i'fnm' -n'fnm' -f'default' -d'Fix next meg' -a'0'
/COMMAND_register -i'next' -n'next <skill/spell> <guild>' -f'default' -d'Calc how much exp for next %' -a'1'
/COMMAND_register -i'sets' -n'sets' -f'default' -d'Show client settings' -a'0'
/COMMAND_register -i'afire' -n'afire' -f'default' -d'Toggle auto fire refuel/remake' -a'0'
/COMMAND_register -i'acamp' -n'acamp' -f'default' -d'Toggle auto camp after fire' -a'0'
/COMMAND_register -i'repo' -n'repo' -f'default' -d'Toggle round reporting' -a'0'
/COMMAND_register -i'repu' -n'repu' -f'default' -d'Toggle rep reporting' -a'0'
/COMMAND_register -i'slite' -n'slite' -f'default' -d'Toggle saving of custom lites' -a'0'
/COMMAND_register -i'srep' -n'srep' -f'default' -d'Toggle skill/spell reporting' -a'0'
/COMMAND_register -i'tele' -n'tele' -f'default' -d'Toggle teleport notifications' -a'0'
/COMMAND_register -i'apss' -n'apss' -f'default' -d'Toggle pss each round' -a'0'
/COMMAND_register -i'ticker' -n'ticker' -f'default' -d'Toggle tick reporting' -a'0'
/COMMAND_register -i'blastr' -n'blastr' -f'default' -d'Toggle blast reporting' -a'0'
/COMMAND_register -i'apj' -n'apj' -f'default' -d'Toggle auto party joining' -a'0'
/COMMAND_register -i'psr' -n'psr' -f'default' -d'Toggle party status lites' -a'0'
/COMMAND_register -i'stun' -n'stun' -f'default' -d'Toggle stun reporting' -a'0'

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Command actions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def CMD_k = /set killing=1%;@@kill %{*}
/def CMD_sp = /party_report _general [Out of SP]
/def CMD_ep = /party_report _general [Out of EP]
/def CMD_qpeer = quote 'peer %{*}' emote
/def CMD_tg = /set target=%{*}%;target %{*}
/def CMD_recaller = /recall -q -mregexp #/50 %{*}
;; ########## Money commands ##########
/def CMD_dm = drop 1 mowgles
/def CMD_gc = get gold,platinum,mithril,anipium,batium%;get all box%;get all chest
;; ########## General skills ##########
/def CMD_fb = use fire building%;/party_report _general [Building fire]
/def CMD_fish = use fishing
/def CMD_fa = use first aid at %*%;/party_report _general [First Aid->%*]
/def CMD_camp = use camping%;/party_report _general [camping]%;/tell_status Camping
/def CMD_medi = /party_report _general [Meditating]%;use meditation%;/tell_status Meditating
/def CMD_tc = use torch creation
/def CMD_co = use 'consider' %*%;/party_report _general [Consider->%*]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Skill timer/round counter
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -mregexp -t'[\*]+ Round ([0-9]+) (.*)' TRIG_round_counter = \
	/set skill_rounds=$[%{skill_rounds} + 1]%; \
    /if (get_setting("AUTO_pss") =~ "1") \
    	@@scan all long%; \
		/pss%; \
 		/party_report_2%; \
	/endif

/def -F -mregexp -t'^You start concentrating on the skill.|^You start chanting.' TRIG_skill_start = \
	/set skill_start_time=$[time()]%; \
	/set skill_rounds=0%; \
	/set grab_skill_spell=1%; \
	@@cast info

/def -F -ag -mregexp -t'^You are prepared to do the skill.|You are done with the chant.' TRIG_skill_end = \
	/echo -p @{Cbgblue}$[toupper(%{curr_skill_spell},1)] done:@{n} Time($[timer(%{skill_start_time})]) Rounds[%{skill_rounds}]

/def -F -mregexp -t'^You are using \'([ a-z]*)\'.*|^You are casting \'([ a-z]*)\'.*' TRIG_grab_skill_spell = \
	/if (%{grab_skill_spell} == 1) \
                /set curr_skill_spell=%{P1}%{P2}%; \
                /set grab_skill_spell=0%; \
		/substitute -ag%; \
	/endif%; \
	/if (%{concealed} == 1) \
		/party_report _general [casting concealed] [:%{P1}%{P2}:]%; \
		/set concealed=0%; \
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Next Mil counter trigs.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -mregexp -t'^Total of ([0-9]*) experience spent on character.' TRIG_grabtotalexp = \
	/set exptotal=%{P1}%; \
	/set nextmeg=$[((trunc(%{P1}/1000000))+1)*1000000]%; \
	/CMD_fnm

/def CMD_fnm = \
	/set tonextmeg=$[nextmeg-(exptotal+exp)]%; \
	/if (tonextmeg < 0) \
		/set nextmeg=$[nextmeg+1000000]%; \
	/endif%; \
	/set tonextmeg=$[pad(tonextmeg,7)]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Poison
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -p1 -mglob -F -t'You shiver and suffer from POISON*' TRIG_poison1 = \
	/party_report _general [Poison:ME]%; \
	/set poison=1%; \
	/status_edit -r0 "D":1:BCred

/def -p1 -mglob -F -t'You SAVE against POISON*' TRIG_poison2 = \
	/if (poison=0) \
		/party_report _general [resisted poison]%; \
	/endif

/def -p1 -aCgreen -F -t'You feel the poison leaving your veins*' TRIG_poisgone1 = \
	/party_report _general [Poison gone]%; \
	/set poison=0%; \
	/status_edit -r0 "D":1:BCgreen

/def -p1 -F -t'*AND the sigla change colour and glow bright green.*' TRIG_poisgone2 = \
	/party_report _general [Poison gone]%; \
	/set poison=0%; \
	/status_edit -r0 "D":1:BCgreen

/def -p1 -aCgreen -F -t'You feel poison leaving*' TRIG_poisgone3 = \
	/party_report _general [Poison gone]%; \
	/set poison=0%; \
	/status_edit -r0 "D":1:BCgreen

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Stun Reporting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ########## I Got stunned ##########
/def -mregexp -F -t'^...BUT you break it off with intense concentration.' TRIG_stun3 = \
	/party_report _stun [Broke stun(maneuvers)]%; \
	/set stunn=1%; \
	/status_edit -r0 "S":1:BCyellow

/def -mregexp -F -t'^...BUT you avoid being stunned with pure willpower' TRIG_stun_iw = \
	/party_report _stun [resists stun(IW)]%; \
	/set stunn=1%; \
	/status_edit -r0 "S":1:BCyellow

/def -mregexp -F -t'^You are no longer stunned.' stun2 = \
	/party_report _stun [Out of stun]%; \
	/set stunn=1%; \
	/status_edit -r0 "S":1:BCyellow
/def -mregexp -F -t'^You get hit, and your eyes lose focus slightly.' TRIG_stun5 = \
	/party_report _stun [I'm stunned(1)]%; \
	/set stunn=0%; \
	/status_edit -r0 "S":1:BCred

/def -mregexp -F -t'^You become somewhat confused, losing your edge.' TRIG_stun6 = \
	/party_report _stun [I'm stunned(2)]%; \
	/set stunn=0%; \
	/status_edit -r0 "S":1:BCred

/def -mregexp -F -t'^Your mind reels and the world becomes blurred.' TRIG_stun7 = \
	/party_report _stun [I'm stunned(3)]%; \
	/set stunn=0%; \
	/status_edit -r0 "S":1:BCred

/def -mregexp -F -t'^You get hit badly, and have problems staying in balance.' TRIG_stun8 = \
	/party_report _stun [I'm stunned(4)]%; \
	/set stunn=0%; \
	/status_edit -r0 "S":1:BCred

/def -mregexp -F -t'^You stagger helplessly in pain and confusion.' TRIG_stun9 = \
	/party_report _stun [I'm stunned(5)]%; \
	/set stunn=0%; \
	/status_edit -r0 "S":1:BCred

/def -mregexp -F -t'^You lose connection to the reality, becoming truly STUNNED.' TRIG_stun10 = \
	/party_report _stun [I'm stunned(6)]%; \
	/set stunn=0%; \
	/status_edit -r0 "S":1:BCred

/def -mregexp -F -t'^You lose your concentration and cannot do the skill.' skillbreak2 = \
	/party_report _stun [skill broken]

;; ########## Monster Stuned ##########
/def -mregexp -F -t'^...WHO breaks the stun quickly off with intense concentration.' TRIG_stun1 = \
	/party_report _stun [Broke stun]

/def -mregexp -F -t'^Your attack causes (.*) to lose focus slightly.' TRIG_stun11 = \
	/party_report _stun [%{P1} stunned(1)]

/def -mregexp -F -t'^You hurt (.*) who seems to become somewhat confused.' TRIG_stun12 = \
	/party_report _stun [%{P1} stunned(2)]

/def -mregexp -F -t'^You cause (.*) world to become blurred and unfocused.' TRIG_stun13 = \
	/party_report _stun [%{P1} stunned(3)]

/def -mregexp -F -t'is suddenly almost unable to stay in balance.' TRIG_stun21 = \
	/party_report _stun [%{PL} stunned(4)]

/def -mregexp -F -t'^You make (.*) stagger helplessly in pain and confusion.' TRIG_stun115 = \
	/party_report _stun [%{P1} stunned(5)]

/def -mregexp -F -t'^You STUN (.*), who loses connection to reality.' TRIG_stun16 = \
	/party_report _stun [%{P1} stunned(6)]

/def -mregexp -F -t'^The eyes of (.*) lose focus slightly.' TRIG_stun17 = \
	/party_report _stun [%{P1} stunned(1)]

/def -mregexp -F -t'swears and seems to be somewhat confused.' TRIG_stun18 = \
	/party_report _stun [%{PL}stunned(2)]

/def -mregexp -F -t'struggles to keep focus while the world becomes blurred.' TRIG_stun19 = \
	/party_report _stun [%{PL}stunned(3)]

/def -mregexp -F -t'gets hit badly and has serious problems staying in balance.' TRIG_stun20 = \
	/party_report _stun [%{PL}stunned(4)]

/def -mregexp -F -t'staggers helplessly in pain and confusion.' TRIG_stun22 = \
	/party_report _stun [%{PL}stunned(5)]

/def -mregexp -F -t'loses connection to reality, becoming truly STUNNED.' TRIG_stun23 = \
	/party_report _stun [%{PL}stunned(6)]

;; ########## Monster lost skill/spell ##########
/def -mregexp -F -t'^([A-z ]+) seems hurt and confused\.' TRIG_stun24 = \
	/party_report _stun [%{P1} lost skill/spell]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ceremony
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -p1 -F -t'You perform the ceremony.' TRIG_cerup = \
	/set cerato=1%; \
	/status_edit -r0 "P":1:BCgreen

/def -p1 -F -t'You have an unusual feeling as you cast the spell.' TRIG_cerdn = \
	/set cerato=0%; \
	/status_edit -r0 "P":1:BCred

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; target trigs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -mregexp -t'^You are now targetting (.*).' TRIG_targetrep = \
	/set target=%{P1}%; \
	/party_report _general [Target->%{P1}]

/def -mregexp -F -t'(.*) is DEAD, R.I.P.$' TRIG_targetclear = \
    /set killing=0%;/set target=%; \
    /set killcount=$[%{killcount}+1]%; \
    /if (%{killcount} == 20) \
        @party kills%; \
        /set killcount=0%; \
    /endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; next skill/spell%
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -p1 CMD_next = \
	grep %{*} info 35%; \
	/set nextperc=1

/def -p1 -mregexp -t'\| (.*) \|  ([0-9]*) \| (.*) \| (.*) \| (.*) \|' TRIG_nextperc2 = \
	/if (nextperc==1) \
		/eval emote For % [$[%{P2}+1]] of [$[pad(%{P1},25)]] I need [$[pad(%{P5}-%exp,7)]/$[pad(%{P5},7)]] exp%; \
		/set nextperc=0%; \
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -mregexp -t'^Alas, your magic is suppressed.' MISC_suppressed = \
	/party_report _misc [magic suppressed]

/def -p1 -mglob -F -t'* is disturbed by *' MISC_aggroed1 = \
	/party_report _misc [Mob Aggroed!]

/def -p1 -mglob -F -t'* got mad at *' MISC_aggroed2 = \
	/party_report _misc [Mob Aggroed!]

/def -mregexp -t'^You feel like you just got slightly better in (.*).' MISC_gained_percent = \
	/party_report _misc [Gained 1\%:%{P1}]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Autosave
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def TRIG_saver = \
	@save%; \
	/repeat -0:05 1 /TRIG_saver%; \
	/set saver_pid=%?

;/if (get_setting("AUTO_save_me") =~ "1") \
;	/TRIG_saver%; \
;/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ambush
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -mregexp -t'^You cannot leave, you have been AMBUSHED.' MISC_ambushed = \
	/party_report _general [Ambushed!]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auto Eat/Drink
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -mglob -F -t'You feel like you could go for a drink.' MISC_drink1 = \
	@@drink fountain

/def -mglob -F -t'You are THIRSTY*' MISC_drink2 = \
	@@drink fountain

/def -mglob -F -t'You are DEHYDRATING*' MISC_drink3 = \
	@@drink fountain

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Avoid death
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -aBCred -t'You regenerate astonishingly fast*' TRIG_avoid_death = \
	/party_report _general [Avoided Death]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Parry trigs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -mregexp -t'^You currently have ([0-9]*)/51 points in parry.' MISC_parry = \
	/set parry=Parry: %{P1},

/def -mregexp -t'^Your total defense factor is: ([0-9]*).' MISC_def = \
	/party_report _general [%{parry} Def: %{P1}]

/def -mregexp -t'^You put your parry factor to ([0-9]*).' MISC_parry2 = \
	/set parry=Parry: %{P1},

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Consider trigs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -mregexp -t'^You take a close look at (.*) in comparison to yourself.' TRIG_consider_start = \
	/set cotarget=%{P1}%; \
	/set consider_exp=

/def -mregexp -t'^You would get (.*) experience for' TRIG_consider_exp = \
	/set consider_exp=%{P1}

/def -t'The final estimation is that*' TRIG_consider_end = \
	/party_report _general [%{cotarget} -> %{consider_exp}]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Camping
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -p1 -aCgreen -F -t'You feel a bit tired*' TRIG_camprdlite1 = \
	/set AVAIL_camp=1%; \
	/party_report _general [Camp available]%; \
	/status_edit -r0 "C":1:BCgreen

/def -p1 -aCgreen -F -t'You feel tired*' TRIG_camprdlite4 = \
	/set AVAIL_camp=1%; \
	/party_report _general [Camp available]%; \
	/status_edit -r0 "C":1:BCgreen

/def -p1 -aCgreen -F -t'You feel like camping a little*' TRIG_camprdlite2 = \
	/set AVAIL_camp=1%; \
	/party_report _general [Camp available]%; \
	/status_edit -r0 "C":1:BCgreen

/def -p1 -aCgreen -F -t'You stretch yourself and consider*' TRIG_camprdlite3 = \
	/set AVAIL_camp=1%; \
	/party_report _general [Camp available]%; \
	/status_edit -r0 "C":1:BCgreen

/def -p1 -F -mregexp -t'You lie down and begin to rest for a while.' TRIG_campc = \
	/set AVAIL_camp=0%; \
	/set busy=1%; \
	/status_edit -r0 "C":1:BCred

/def -p1 -F -mregexp -t'^(You wake up!|You awaken from your short rest, and feel slightly better.)$' TRIG_ecampawake = \
	/set busy=0%; \
	/party_report _general [Awake]%; \
	/empty_queue%; \
	/tell_status reset

/def -p1 -F -t'You lie down for a short rest, soothed by the lullaby sung by*' TRIG_lullaby_bard = \
	/set busy=1

/def -p1 -F -t'You don\'t quite feel like camping at the moment.' TRIG_camp_failed = \
	/if (%{busy} = 1) \
		/set busy=0%; \
		/tell_status reset%; \
	/endif

/def -p1 -F -t'Your movement prevents you from doing the skill.' TRIG_camp_broken = \
	/if (%{busy} = 1) \
		/set busy=0%; \
		/tell_status reset%; \
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Meditation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -p1 -t'You sit down and start meditating.' TRIG_medi_start = \
	/set busy=1%; \
	/status_edit -r0 "M":1:BCred

/def -p1 -t'Something disturbs you and you cannot concentrate any longer.' TRIG_medi_awake = \
	/set busy=0%; \
	/party_report _general [Awake]%; \
	/empty_queue%; \
	/tell_status reset%; \
	/repeat -0:00:30 1 @@grep 'not in tune' help skill meditation

/def -ag -t'You are not in tune with your inner forces yet.' TRIG_medi_not_avail = \
	/repeat -0:00:30 1 @@grep 'not in tune' help skill meditation

/def -ag -t'No matches for \'not in tune\'.' TRIG_medi_check = \
	/party_report [Meditation Available]%; \
	/status_edit -r0 "M":1:BCgreen

/def -ag -t'You fail to reach the state of inner harmony.' TRIG_medi_fail = \
	/tell_status reset

/def -p1 -F -t'Your movement prevents you from casting the spell.' TRIG_medi_broken = \
	/if (%{busy} = 1) \
		/set busy=0%; \
		/tell_status reset%; \
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; surgery report
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -mregexp -t'^The operation is over before you even notice.' MISC_surg1 = \
	/set surgrep=1%; \
	@@grep Cha score%; \
	/def -ag -F -mregexp -t'Cha' surggag

/def -F -mregexp -t'^Cha: ([A-z-]*) \(([0-9]*)\) (.*) Siz: ' MISC_surg2 = \
	/if (surgrep=1) \
		@@emote is %{P1} (%{P2})%; \
		/set surgrep=0%; \
		/undef surggag%; \
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CLIENT SIDE SETTINGS - and the triggers that go with it.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/def -F -mregexp -t' is DEAD, R\.I\.P\.' TRIG_count_saver = \
	/if ($(/member_array counter %{modules}) == 1) \
		/save_COUNTER%; \
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auto-camp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -mregexp -t'^A sense of pride overcomes you as you light the fire.' TRIG_autocamp = \
	/if (get_setting("AUTO_camp") =~ "1") \
		@@use camping%; \
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auto-fire
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -mregexp -t'^The fire burns out, spoiling anything in it.' TRIG_autofire = \
	/if (get_setting("AUTO_fire") =~ "1") \
		@@use fire building%; \
	/endif

/def -F -mregexp -t'(^Only few sticks are still burning on the campfire\.|^Flames on the campfire are growing weaker\.|^The fire flickers as it\'s starting to run out of fuel\.)' TRIG_refuel = \
	/if (get_setting("AUTO_fire") =~ "1") \
		@@refuel%; \
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Skill/Spell reporting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -F -mregexp -t'(^You start concentrating on the skill\.|^You start chanting\.)' TRIG_checkusecast = \
	/if (get_setting("AUTO_skill_spell_report") =~ "1") \
		@@cast info%; \
	/endif

/def -mregexp -t'^You are ([a-z]*) \'(.*)\'\.' TRIG_sk_sp_rep = \
	/party_report _skill_spell %{P1} '%{P2}'.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Teleport Reporters
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ########## Reloc ##########
/def -F -mregexp -t'^([A-z]*) vanishes in a bright flash as reality snaps.' TRIG_tele1 = \
	/party_report _teleport [Left(Reloc/TWOE):%{P1}]

/def -F -mregexp -t'^When your eyes clear, ([A-z]*) stands before you.' TRIG_tele2 = \
	/party_report _teleport [Arrived(Reloc):%{P1}]

;; ########## SUmmon ##########
/def -F -mregexp -t'^([A-z]*) snaps into existence.' TRIG_tele3 = \
	/party_report _teleport [Arrived(Summon):%{P1}]

/def -F -mregexp -t'^([A-z]*) suddenly snaps out of existence.' TRIG_tele4 = \
	/party_report _teleport [Left(Summon):%{P1}]

/def -F -mregexp -t'^([A-z]*) has summoned you!' TRIG_summoned = \
	/party_report _teleport [Summoned by:%{P1}]

;; ########## Go/Teleport with(out) error/Holy way ##########
/def -F -mregexp -t'^([A-Z]*) fades in through a hole in reality.' TRIG_tele5 = \
	/party_report _teleport [Arrived(GO/TWOE):%{P1}]

/def -F -mregexp -t'^([A-z]*) arrives through a loophole in space-time continuum.' TRIG_tele6 = \
	/party_report _teleport [Arrived(R/R/B):%{P1}]

/def -F -mregexp -t'^around the area for a few moments and suddenly transforms into ([A-z]*)!' TRIG_tele7 = \
	/party_report _teleport [Arrived(Holy way):%{P1}]

;; ########## Banish ##########
/def -F -mregexp -t'^([A-z]*) disappears into thick air' TRIG_banished2 = \
	/party_report _teleport [%{P1}:BANISHED]

/def -F -mregexp -t'^You feel that (.*) doesn\'t enjoy your presence.*' TRIG_banished = \
	/party_report _teleport [BANISHED by:%{P1}]

;; ########## Heal/Harm All ##########
/def -F -mregexp -t'^You feel like ([A-z]*) the christmas elf healed you a bit*' TRIG_heal_all_rep = \
	/party_report _teleport [Heal All:%{P1}]

/def -F -mregexp -t'^You feel like ([A-z]*) healed you a bit*' TRIG_heal_all_rep1 = \
	/party_report _teleport [Heal All:%{P1}]

/def -F -mregexp -t'^You feel like ([A-z]*) the christmas elf harmed you a bit*' TRIG_harm_all_rep = \
	/party_report _teleport [Harm All:%{P1}]

/def -F -mregexp -t'^You feel like ([A-z]*) harmed you a bit*' TRIG_harm_all_rep1 = \
	/party_report _teleport [Harm All:%{P1}]

/def -F -mregexp -t'^You feel like you healed ([0-9]*) players.' TRIG_heal_all = \
	/party_report _teleport [Healed:%{P1} players]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Party Status
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def pss = \
	/if (get_setting("AUTO_pss") =~ "1") \
		/set pssgag=1%; \
		@pss%; \
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Busy queue
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def add_queue = \
	/let formatted_msg=$[replace(" ", "_", {*})]%; \
	/set busy_queue=%{busy_queue} %{formatted_msg}

/def empty_queue = \
	/let num_msgs=$(/length %{busy_queue})%; \
	/set cou_msgs=0%; \
	/let tmsgs=%{busy_queue}%; \
	/while ({cou_msgs}<{num_msgs})\
		/let cmsgs=$(/pop tmsgs)%;\
		/let temp_msg0=%{cmsgs}%;\
		/let temp_msg0=$[replace("&^", " ", %{temp_msg0})]%;\
		/let temp_msg1=$(/car %{temp_msg0})%; \
		/let temp_msg1=$[replace("_", " ", %{temp_msg1})]%;\
		/let temp_msg2=$(/cadr %{temp_msg0})%; \
		/party_report _general %{temp_msg1} (Delay: $[timer(%{temp_msg2})]) %; \
		/set cou_msgs=$[{cou_msgs}+1]%;\
	/done%; \
	/unset busy_queue
