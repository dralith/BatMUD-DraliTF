;;
;; DraliTF modules/guild/merchant.tf version 0.2
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
;;   Command <arguments>        => Description
;;   refine <mineral> <bench>   => use 'refining' <mineral> in <bench>
;;   alloy <mineral> <bench>    => use 'alloying' <mineral> in <bench>
;;   amal <mineral> <bench>     => use 'amalgamate' <mineral> in <bench>
;;   gemc <mineral> <bench>     => use 'gemcutting' <mineral> in <bench>
;;   minc <mineral> <bench> <#> => use 'mineral cutting' <mineral> in <bench> cut <#>
;;   mine <mineral>             => use 'mining' mineral
;;   lj <tree>                  => use 'lumberjacking' <tree>
;;   pls <ugly person>          => use 'plastic surgery' <ugly person>
;;   em <coins>                 => use 'exchange money' <coins>
;;   labeli <item> as <label>   => use 'labeling' <item> as <label>
;;   bch <chest> <mineral>      => use 'chest creation' build <chest> hull from <mineral>
;;   rch <chest> <mineral>      => use 'chest creation' reinforce <chest> hull with <mineral>
;;   fch <chest>                => use 'chest creation' complete <chest>
;;   mre <mineral> <spell>      => use 'make reagent' <mineral> for <spell> into pouch
;;   skin                       => use 'skinning' corpse
;;   sew <material> <clothing>  => use 'sewing' <material> make <clothing>
;;   repair <type> <item>       => use 'repair <type>' <item>
;;   disc                       => cast 'floating disc'
;;   rdisc                      => cast 'floating disc' my disc
;;   rb <bank command>          => cast 'remote banking' <bank command>
;;   id <item>                  => cast 'identify' <item>
;;   adiamond <bench>           => alloy diamond from materials in <bench>
;;   coms                       => Small help list for 'services bill' system
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module specific functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def unload_merchant_module = \
	/purge -mregexp MERCH_.*%; \
	/unset adfw=0%;/unset adid=0%;/unset adre=0%;/unset adla=0%;/unset admi=0%;/unset unsetb=0%;/unset frnd=0%; \
    /unset fwco=0%;/unset idco=0%;/unset reco=0%;/unset laco=0%;/unset mico=0%;/unset toco=0%;/unset adsu=0%; \
    /unset adpr=0%;/unset prco=0%;/unset suco=0%;/unset addi=0%;/unset dico=0%;/unset fwtw=0%;/unset fwtp=0%; \
    /unset frid=0%;/unset bprc=0%;/unset blac=0%;/unset brec=0%;/unset bidc=0%;/unset bfwc=0%;/unset fwcast=0%; \
    /unset fwcast2=0%;/unset fw_item=0%;/unset fw_cast_bm=0%;/unset fwt=0%;/unset fwt2=0%;/unset fwbef=0%;/unset fwaft=0

/COMMAND_register -i'refine' -n'refine <mat> <bench>' -f'merchant' -d'Use refining' -a'1'
/COMMAND_register -i'alloy' -n'alloy <mat,etc> <bench>' -f'merchant' -d'Alloy <mats>' -a'1'
/COMMAND_register -i'amal' -n'amal <mat> <bench>' -f'merchant' -d'Amalgamate <mat>' -a'1'
/COMMAND_register -i'gemc' -n'gemc <mat> <bench>' -f'merchant' -d'Cut gems from <mat>' -a'1'
/COMMAND_register -i'minc' -n'minc <mat> <bench> <grams>' -f'merchant' -d'Cut mineral into <grams> chunk' -a'1'
/COMMAND_register -i'mine' -n'mine <deposit>' -f'merchant' -d'Mine materials' -a'1'
/COMMAND_register -i'lj' -n'lj <tree>' -f'merchant' -d'' -a'1'
/COMMAND_register -i'pls' -n'pls <player>' -f'merchant' -d'Perform' -a'1'
/COMMAND_register -i'em' -n'em <coins>' -f'merchant' -d'Use Exchange money' -a'1'
/COMMAND_register -i'labeli' -n'labeli <item> as <label>' -f'merchant' -d'Pull out the handy labeller' -a'1'
/COMMAND_register -i'bch' -n'bch <chest> <mat>' -f'merchant' -d'Build up the chest' -a'1'
/COMMAND_register -i'rch' -n'rch <chest> <mat>' -f'merchant' -d'Reinforce the chest' -a'1'
/COMMAND_register -i'fch' -n'fch <chest>' -f'merchant' -d'Finish the chest' -a'1'
/COMMAND_register -i'skin' -n'skin' -f'merchant' -d'Skin a corpse' -a'0'
/COMMAND_register -i'sew' -n'sew <mat> <item>' -f'merchant' -d'Make a <mat> <item>' -a'1'
/COMMAND_register -i'repair' -n'repair <type> <item>' -f'merchant' -d'Repair <item>' -a'1'
/COMMAND_register -i'disc' -n'disc' -f'merchant' -d'Summon/refresh floating disc' -a'0'
/COMMAND_register -i'rb' -n'rb <command>' -f'merchant' -d'Use the atm' -a'1'
/COMMAND_register -i'prot' -n'prot <type> <item>' -f'merchant' -d'Protect <item>' -a'1'
/COMMAND_register -i'fw' -n'fw <item>' -f'merchant' -d'Feather weight <item>' -a'1'
/COMMAND_register -i'rs' -n'rs <target>' -f'merchant' -d'Remove <target>s scars' -a'1'
/COMMAND_register -i'id' -n'id <item>' -f'merchant' -d'Identify <item>' -a'1'
/COMMAND_register -i'adfw' -n'adfw' -f'merchant_services' -d'Add 1 fw to receipt' -a'0'
/COMMAND_register -i'adid' -n'adid' -f'merchant_services' -d'Add 1 id to receipt' -a'0'
/COMMAND_register -i'adre' -n'adre' -f'merchant_services' -d'Add 1 repair to receipt' -a'0'
/COMMAND_register -i'adla' -n'adla' -f'merchant_services' -d'Add 1 label to receipt' -a'0'
/COMMAND_register -i'adpr' -n'adpr' -f'merchant_services' -d'Add 1 prot to receipt' -a'0'
/COMMAND_register -i'admi' -n'admi <cost>' -f'merchant_services' -d'Add mineral <cost> to receipt' -a'1'
/COMMAND_register -i'dico' -n'dico <percentage>' -f'merchant_services' -d'Set the discount percentage' -a'1'
/COMMAND_register -i'frpr' -n'frpr' -f'merchant_services' -d'Next prot/id is free' -a'0'
/COMMAND_register -i'buym' -n'buym <kgs> <mat> <price>' -f'merchant_services' -d'Buy mats, add to receipt' -a'1'
/COMMAND_register -i'setb' -n'setb <buyer>' -f'merchant_services' -d'Set the <buyer> of services' -a'1'
/COMMAND_register -i'resem' -n'resem' -f'merchant_services' -d'Reset the current services receipt' -a'0'
/COMMAND_register -i'alldmd' -n'alldmd <bench>' -f'merchant' -d'Alloy diamond' -a'1'
/COMMAND_register -i'allprl' -n'allprl <bench>' -f'merchant' -d'Alloy pearl' -a'1'
/COMMAND_register -i'coms' -n'coms' -f'merchant' -d'Display merchant command help' -a'0'
/COMMAND_register -i'tecoe' -n'tecoe' -f'merchant_services' -d'Echo services receipt' -a'0'
/COMMAND_register -i'teco' -n'teco' -f'merchant_services' -d'Emote services receipt' -a'0'
/COMMAND_register -i'reagent' -n'reagent <mat> [pouch]' -f'merchant' -d'Make reagents out of <mat> [in pouch]' -a'1'
;/COMMAND_register -i'' -n'' -f'merchant' -d'' -a'1'

/def CMD_refine = use 'refining' %1 in %-1
/def CMD_alloy = use 'alloying' %1 in %-1
/def CMD_amal = use 'amalgamate' %1 in %-1
/def CMD_gemc = use 'gem cutting' %1 in %-1
/def CMD_minc = use 'mineral cutting' %1 in %2 cut %3
/def CMD_mine = use 'mining' %*
/def CMD_lj = use 'lumberjacking' %*
/def CMD_pls = use 'plastic surgery' %*
/def CMD_em = use 'exchange money' %*
/def CMD_labeli = use 'labeling' %*
/def CMD_bch = use 'chest creation' build %1 hull from %-1
/def CMD_rch = use 'chest creation' reinforce %1 hull with %-1
/def CMD_fch = use 'chest creation' complete %*
/def CMD_skin = use 'skinning' corpse
/def CMD_sew = use 'sewing' %1 make %-1
/def CMD_repair = use 'repair %1' %-1
/def CMD_disc = cast floating disc at my disc
/def CMD_rb = cast 'remote banking' %*
/def CMD_prot = cast 'protect %1' %-1
/def CMD_rs = cast 'remove scar' %*
/def CMD_id = cast 'identify' %*

/def CMD_adfw = /set adfw=$[%adfw+1]%;/if (%frnd = 1) /set fwco=$[%fwco+1000]%; /else /set fwco=$[%fwco+2000]%; /endif
/def CMD_adid = /set adid=$[%adid+1]%;/if (%frnd = 1) /set idco=$[%idco+1000]%; /else /set idco=$[%idco+2000]%; /endif
/def CMD_adre = /set adre=$[%adre+1]%;/if (%frnd = 1) /set reco=$[%reco+5000]%; /else /set reco=$[%reco+10000]%; /endif
/def CMD_adla = /set adla=$[%adla+1]%;/if (%frnd = 1) /set laco=$[%laco+1000]%; /else /set laco=$[%laco+2000]%; /endif
/def CMD_adpr = /set adpr=$[%adpr+1]%;/if (%frnd = 1) /set prco=$[%prco+1000]%; /else /set prco=$[%prco+2000]%; /endif
/def CMD_admi = /set admi=$[%admi+1]%;/set mico=$[%mico+%1]
/def CMD_dico = /set addi=%1
/def CMD_frpr = /set frid=1
/def CMD_buym = buy any %{1} divine refined %{2} for %{3}%;admi $[%{3}*%{1}]
/def CMD_setb = /set setb=%2%;/set frnd=0%;/set bfwc=2000%;/set bidc=2000%;/set brec=10000%;/set blac=2000%;/set bprc=2000
/def CMD_resem = /set adfw=0%;/set adid=0%;/set adre=0%;/set adla=0%;/set admi=0%;/set setb=0%;/set frnd=0%; \
                             /set fwco=0%;/set idco=0%;/set reco=0%;/set laco=0%;/set mico=0%;/set toco=0%;/set adsu=0%; \
                             /set adpr=0%;/set prco=0%;/set suco=0%;/set addi=0%;/set dico=0%;/set fwtw=0%;/set fwtp=0%; \
                             /set frid=0%;/set bprc=0%;/set blac=0%;/set brec=0%;/set bidc=0%;/set bfwc=0%;/set fwcast=0%; \
                             /set fwcast2=0%;/set fw_item=0%;/set fw_cast_bm=0%;/set fwt=0%;/set fwt2=0%;/set fwbef=0%;/set fwaft=0

/def CMD_alldmd = use alloying at pearl,moss agate,onyx,emerald,sapphire,ruby,carnelian,olivine,quartz,turquoise,malachite,aquamarine,jade,sunstone,zircon,opal,amethyst,bloodstone,alexandrite,topaz,rhodonite,garnet,chrysoberyl in %*
/def CMD_allprl = use alloying at moss agate,onyx,emerald,sapphire,ruby,carnelian,olivine,quartz,turquoise,malachite,aquamarine,jade,sunstone,zircon,opal,amethyst,bloodstone,alexandrite,topaz,rhodonite,garnet,chrysoberyl in %*

/def -F -P0BCgreen -mregexp -F -t'You sold * at the exchange for *' MERCH_exchange

/def CMD_coms = \
/echo ,---------------------------------------------------.%; \
/echo | refine  (refining     ) | lj      (lumberjacking) |%; \
/echo | alloy   (alloying     ) | pls     (surgery      ) |%; \
/echo | gemc    {gemcutting   ) | repair  (repair *     ) |%; \
/echo | minc    (mincutting   ) | em      (exchange cash) |%; \
/echo | mine    (mining       ) | labeli  (labeling     ) |%; \
/echo | b|f|rch (chestcreation) | mre     (make reagent ) |%; \
/echo | (r)disc (floating disc) | rb      (remotebanking) |%; \
/echo |-------------------------|-------------------------|%; \
/echo | frpr  next prot/id=free | setb  set buyer         |%; \
/echo | adfw  add 1 fw to calc  | adid  add 1 id to calc  |%; \
/echo | adre  add 1 repair      | adla  add 1 label       |%; \
/echo | admi  add # mineralcost | resem reset sales calc  |%; \
/echo | adpr  add 1 prot cast   | adsu  add surgery (5k)  |%; \
/echo | dico  set discount <%>  |Reset calc after each use|%; \
/echo | buym  buy any <#> divine <material> for <price>   |%; \
/echo | teco  report costs->buyer (tecoe echos costs)     |%; \
/echo | NOTE: fw's and surgeries must be added manually!! |%; \
/echo `---------------------------------------------------'

/def CMD_fw = cast 'feather weight' %*%;/set fw_item=%*%;/set fwcast=1%;/set fwcast2=1%;weigh %fw_item

/def -mregexp -t'You cast the spell successfully.' MERCH_fwt = /set fw_cast_bm=1

/def -mregexp -t'^(.*) glows yellow for a moment.' MERCH_fwt1 = /if ({fw_cast_bm} = 1 & {fwcast} = 1) /set fwt=%{P1}%;weigh %fw_item%;/set fwcast=0%;/set fw_cast_bm=0%;/set fwcast2=0%; /endif

/def -mregexp -t'You feel that the spell will last for ([0-9]+)d, ([0-9]+)h, ([0-9]+)min and ([0-9]+)s.' MERCH_fwt2 = \
    /let MERCH_fwd=%{P1}%; \
    /let MERCH_fwh=%{P2}%; \
    /let MERCH_fwm=%{P3}%; \
    /set fwt2=$[((%MERCH_fwd * 24) + (%MERCH_fwh) + (%MERCH_fwm * 100.0 / 6000.0))]

/def -mregexp -t'^:([ ]+)([0-9]*)\.([0-9]*)' MERCH_scaler = \
  /if ({fwcast2} = 1) \
    /set fwbef=%{P2}.%{P3}%; \
  /else \
    /set fwaft=%{P2}.%{P3}%; \
    /if ($[substr(100 - (%fwaft * 100 / %fwbef),0,4)] > 30) \
      /CMD_adfw%; \
    /endif%; \
    /set fwcast2=1%; \
    /set fwtw=$[(%{fwtw} + abs(%fwaft - %fwbef))]%; \
    /set fwtp=$[(%{fwtp} + substr(100 - (%fwaft * 100 / %fwbef),0,4))]%; \
    /MERCH_rfw%; \
  /endif

/def MERCH_rfw = \
  /if ({setb} = 0) \
    /eval /echo -aBCyellow %fwt: [$[substr(%fwt2,0,5)] hrs] Was(%{fwbef}) Now(%{fwaft}) Lost($[abs(%fwaft - %fwbef)][$[substr(100 - (%fwaft * 100 / %fwbef),0,4)]\\%]).%; \
  /else \
    tell %setb %fwt: [$[substr(%fwt2,0,5)] hrs] Was(%{fwbef}) Now(%{fwaft}) Lost($[abs(%fwaft - %fwbef)][$[substr(100 - (%fwaft * 100 / %fwbef),0,4)]\%]).%; \
  /endif

/def CMD_teco = \
/set toco=$[%fwco+%idco+%laco+%reco+%prco+%suco+%mico]%; \
emote  Feather weights: $[pad(%adfw,3)] * $[pad(%bfwc,6)] =$[pad(%fwco,10)] %; \
emote  Identify:        $[pad(%adid,3)] * $[pad(%bidc,6)] =$[pad(%idco,10)] %; \
emote  Labels:          $[pad(%adla,3)] * $[pad(%blac,6)] =$[pad(%laco,10)] %; \
emote  Prots:           $[pad(%adpr,3)] * $[pad(%bprc,6)] =$[pad(%prco,10)] %; \
emote  Repairs:         $[pad(%adre,3)] * $[pad(%brec,6)] =$[pad(%reco,10)] %; \
emote ------------------------------------------%; \
emote {+               Mineral costs: $[pad(%mico,9)]} %; \
emote {+                     Surgery: $[pad(%suco,9)]} %; \
/set toco=$[%fwco+%idco+%laco+%reco+%prco+%suco+%mico]%; \
/set dico=$[%addi*%toco/100]%; \
/set toco=$[%fwco+%idco+%laco+%reco+%prco+%suco+%mico - %dico]%; \
emote {-              Discount($[pad(addi,3)]\%): $[pad(%dico,9)]}  %; \
emote {=                 Grand total: $[pad(%toco,9)]}


/def CMD_tecoe = \
/set toco=$[%fwco+%idco+%laco+%reco+%prco+%suco+%mico]%; \
/echo   Feather weights: $[pad(%adfw,3)] * $[pad(%bfwc,6)] =$[pad(%fwco,10)]  %; \
/echo   Identify:        $[pad(%adid,3)] * $[pad(%bidc,6)] =$[pad(%idco,10)]  %; \
/echo   Labels:          $[pad(%adla,3)] * $[pad(%blac,6)] =$[pad(%laco,10)]  %; \
/echo   Prots:           $[pad(%adpr,3)] * $[pad(%bprc,6)] =$[pad(%prco,10)]  %; \
/echo   Repairs:         $[pad(%adre,3)] * $[pad(%brec,6)] =$[pad(%reco,10)]  %; \
/echo  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%; \
/echo  {+              Mineral costs: $[pad(%mico,9)]}  %; \
/echo  {+                    Surgery: $[pad(%suco,9)]}  %; \
/set toco=$[%fwco+%idco+%laco+%reco+%prco+%suco+%mico]%; \
/set dico=$[%addi*%toco/100]%; \
/set toco=$[%fwco+%idco+%laco+%reco+%prco+%suco + %mico - %dico]%; \
/echo  {-             Discount($[pad(addi,3)]\%): $[pad(%dico,9)]}  %; \
/echo  {=                Grand total: $[pad(%toco,9)]}

/def -p22 -mregexp -F -t'You use your hammer and' MERCH_recount = /MERCH_adre
/def -mregexp -t'glows blue for just a moment.' MERCH_prcount = /if (frid = 0) /MERCH_adpr%; /else /set frid=0%; /endif
/def -mregexp -t'^The following messages seem to vibrate from' MERCH_idcount = /if (frid = 0) /MERCH_adid%; /else /set frid=0%; /endif
/def -mregexp -t'^You label' MERCH_labcount = /MERCH_adla
/def -mregexp -t'^Cleared (.*)\'s label.' MERCH_labcount2 = /MERCH_adla

/def -mregexp -t'^You begin mining the ([a-z]*) ([a-z]*)' MERCH_miner = la %{P2} on ground
/def -mregexp -t'You skillfully cut the gem ore into a beautiful gem.' MERCH_gemcutter = get gem from gw

/def -mregexp -t'^Your disc wavers dangerously.' MERCH_discwavers = @party report Disc falling time to reload!

;;    BCgreen
/def -mregexp -t'[T|t]iny leather bag' MERCH_rleather = /set str=%*%;/substitute -p %{str} (@{BCgreen}Aura of wind@{n})
/def -mregexp -t'[S|s]tone cube' MERCH_rstone = /set str=%*%;/substitute -p %{str} (@{BCgreen}Acid shield@{n})
/def -mregexp -t'[G|g]rey fur triangle' MERCH_rfur = /set str=%*%;/substitute -p %{str} (@{BCgreen}Frost shield@{n})
/def -mregexp -t'[S|s]mall glass cone' MERCH_rglass = /set str=%*%;/substitute -p %{str} (@{BCgreen}Flame shield@{n})
/def -mregexp -t'[S|s]mall iron rod' MERCH_riron = /set str=%*%;/substitute -p %{str} (@{BCgreen}Lightning shield@{n})
/def -mregexp -t'[Q|q]uartz prism' MERCH_rquartz = /set str=%*%;/substitute -p %{str} (@{BCgreen}Repulsor aura@{n})
/def -mregexp -t'[S|s]mall highsteel disc' MERCH_rhighsteel = /set str=%*%;/substitute -p %{str} (@{BCgreen}Armour of aether@{n})
/def -mregexp -t'[T|t]iny amethyst crystal' MERCH_ramethyst = /set str=%*%;/substitute -p %{str} (@{BCgreen}Shield of detoxifiction@{n})
;;    Cred
/def -mregexp -t'[B|b]ronze marble' MERCH_rbronze = /set str=%*%;/substitute -p %{str} (@{Cred}Blast vacuum@{n})
/def -mregexp -t'[O|o]livine powder' MERCH_rolivine = /set str=%*%;/substitute -p %{str} (@{Cred}Acid Blast@{n})
/def -mregexp -t'[S|s]teel arrowhead' MERCH_rsteel = /set str=%*%;/substitute -p %{str} (@{Cred}Cold ray@{n})
/def -mregexp -t'[G|g]ranite sphere' MERCH_rgranite = /set str=%*%;/substitute -p %{str} (@{Cred}Lava blast@{n})
/def -mregexp -t'[pieces|piece] of electrum wire' MERCH_relectrum = /set str=%*%;/substitute -p %{str} (@{Cred}Electrocution@{n})
/def -mregexp -t'[C|c]opper rod' MERCH_rcopper = /set str=%*%;/substitute -p %{str} (@{Cred}Golden arrow@{n})
/def -mregexp -t'[S|s]ilvery bark chip' MERCH_rmallorn = /set str=%*%;/substitute -p %{str} (@{Cred}Summon carnal spores@{n})
;;    BCred
/def -mregexp -t'[S|s]mall brass fan' MERCH_rbrass = /set str=%*%;/substitute -p %{str} (@{BCred}Vacuum globe@{n})
/def -mregexp -t'[B|b]loodstone rings' MERCH_rbloodstone = /set str=%*%;/substitute -p %{str} (@{BCred}Acid storm@{n})
/def -mregexp -t'[H|h]andful of onyx gravel' MERCH_ronyx = /set str=%*%;/substitute -p %{str} (@{BCred}Hailstorm@{n})
/def -mregexp -t'[b|B]lue cobalt cup' MERCH_rcobalt = /set str=%*%;/substitute -p %{str} (@{BCred}Lava storm@{n})
/def -mregexp -t'[T|t]ungsten wires' MERCH_rtungsten = /set str=%*%;/substitute -p %{str} (@{BCred}Lightning storm@{n})
/def -mregexp -t'[T|t]iny platinum hammer' MERCH_rplatinum = /set str=%*%;/substitute -p %{str} (@{BCred}Magic eruption@{n})
/def -mregexp -t'[E|e]bony tube' MERCH_rebony = /set str=%*%;/substitute -p %{str} (@{BCred}Killing cloud@{n})

/def CMD_reagent = \
  /if (%1 =~ "leather") /let reag_spell=aura of wind%; \
  /elseif (%1 =~ "stone") /let reag_spell=acid shield%; \
  /elseif (%1 =~ "fur") /let reag_spell=frost shield%; \
  /elseif (%1 =~ "glass") /let reag_spell=flame shield%; \
  /elseif (%1 =~ "iron") /let reag_spell=lightning shield%; \
  /elseif (%1 =~ "quartz") /let reag_spell=repulsor shield%; \
  /elseif (%1 =~ "highsteel") /let reag_spell=armour of aether%; \
  /elseif (%1 =~ "amethyst") /let reag_spell=shield of detoxification%; \
  /elseif (%1 =~ "bronze") /let reag_spell=blast vacuum%; \
  /elseif (%1 =~ "olivine") /let reag_spell=acid blast%; \
  /elseif (%1 =~ "steel") /let reag_spell=cold ray%; \
  /elseif (%1 =~ "granite") /let reag_spell=lava blast%; \
  /elseif (%1 =~ "electrum") /let reag_spell=electrocution%; \
  /elseif (%1 =~ "copper") /let reag_spell=golden arrow%; \
  /elseif (%1 =~ "mallorn") /let reag_spell=summon carnal spores%; \
  /elseif (%1 =~ "brass") /let reag_spell=vacuum globe%; \
  /elseif (%1 =~ "bloodstone") /let reag_spell=acid storm%; \
  /elseif (%1 =~ "onyx") /let reag_spell=hailstorm%; \
  /elseif (%1 =~ "cobalt") /let reag_spell=lava storm%; \
  /elseif (%1 =~ "tungsten") /let reag_spell=lightning storm%; \
  /elseif (%1 =~ "platinum") /let reag_spell=magic eruption%; \
  /elseif (%1 =~ "ebony") /let reag_spell=killing cloud%; \
  /endif%;\
  /if (%2 !~ "") \
    /eval use 'make reagent' %1 for %{reag_spell} into %2%; \
  /else \
    /eval use 'make reagent' %1 for %{reag_spell}%; \
  /endif

/def MERCH_hunt_lites = \
/let always_hunt = "(starmetal|dragonscale|diamond)"%; \
/let duko_hunt = "(anipium|nullium|zhentorium|diggalite|illumium)"%; \
/let glass_hunt = "(crystal|obsidian)"%; \
/let quicksilver_hunt = "(cesium|lead|magnesium)"%; \
/let wood_hunt = "(pear|apple|pine|)"%; \
/let reagent_prot_hunt = "(leather|stone|fur|glass|iron|quartz|highsteel|amethyst)"%; \
/let reagent_area_hunt = "(brass|bloodstone|onyx|cobalt|tungsten|platinum|ebony)"%; \
/let reagent_solo_hunt = "(bronze|olivine|steel|granite|electrum|copper|mallorn)"%; \
/let ship_hunt = "(adamantium|birch|bloodstone|brass|cedar|cloth|diamond|dukonium|ebony|emerald|glass|gold|highsteel|illumium|iron|laen|lead|mahogany|mallorn|marble|mithril|nullium|oak|obsidian|palladium|platinum|quicksilver|ruby|sapphire|slate|starmetal|steel|titanium|turquoise|wood|zhentorium)"
