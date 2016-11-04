;Spellecho triggers. Collected by Dandalf, original code by Bombur, modified by Mozzoop
;Upkeep, modifying, collecting and stuff by Malar
;updated 8.12.2002
;-----------------------------------
;Priests
;-----------------------------------
/def -p2000000 -F -mregexp -t'puujalka jumalauta' ecausecritwounds = /set str=%*%;/substitute -p %{str} (@{Cred}cause critical wounds@{n})
/def -p2000000 -F -mregexp -t'yugzhrr paf' aneu = /set str=%*%;/substitute -p %{str} (@{Cred}aneurysm@{n})
/def -p2000000 -F -mregexp -t'annihilar hzzz golum' da = /set str=%*%;/substitute -p %{str} (@{Cmagenta}detect alignment@{n})
/def -p2000000 -F -mregexp -t'rhuuuumm angotz amprltz' casw = /set str=%*%;/substitute -p %{str} (@{Cred}cause serious wounds@{n})
/def -p2000000 -F -mregexp -t'rhuuuumm angotz klekltz' cacw = /set str=%*%;/substitute -p %{str} (@{Cred}cause critical wounds@{n})
/def -p2000000 -F -mregexp -t'yugzhrr' hemorrhage = /set str=%*%;/substitute -p %{str} (@{Cred}hemorrhage@{n})
/def -p2000000 -F -mregexp -t'Zmasching Pupkins\'s infanitsadnnes' melloncollie = /set str=%*%;/substitute -p %{str} (@{Cred}mellon collie@{n})
/def -p2000000 -F -mregexp -t'whoosy banzziii pal eeeiizz dooneb' dispelgood = /set str=%*%;/substitute -p %{str} (@{Cred}dispel good@{n})
/def -p2000000 -F -mregexp -t'Harken to me and hear my plea, disease is what I call to thee' pestilence = /set str=%*%;/substitute -p %{str} (@{Cred}pestilence@{n})
/def -p2000000 -F -mregexp -t'Good is dumb' protfgood = /set str=%*%;/substitute -p %{str} (@{Cblue}protection from good@{n})
/def -p2000000 -F -mregexp -t'PAF PAF PAF!' harmbody = /set str=%*%;/substitute -p %{str} (@{Cred}harm body@{n})
/def -p2000000 -F -mregexp -t'Feel your anger and strike with all your hatred.' eauraofhate = /set str=%*%;/substitute -p %{str} (@{Cblue}aura of hate@{n})
/def -p2000000 -F -mregexp -t'ZAP ZAP ZAP!' healbody = /set str=%*%;/substitute -p %{str} (@{Cyellow}heal body@{n})
/def -p2000000 -F -mregexp -t'viiltaja jaska' makescar = /set str=%*%;/substitute -p %{str} (@{Cred}make scar@{n})
/def -p2000000 -F -mregexp -t'Gawd DAMN IT!' damnarmament = /set str=%*%;/substitute -p %{str} (@{Cgreen}damn armament@{n})
/def -p2000000 -F -mregexp -t'Bastage' bastardlybalm = /set str=%*%;/substitute -p %{str} (@{Cred}bastardly balm@{n})
/def -p2000000 -F -mregexp -t'With this ring, i do deconsecrate thee' eunhmatr = /set str=%*%;/substitute -p %{str} (@{Cred}Unholy Matrimony@{n})
/def -p2000000 -F -mregexp -t'\'saugaii\'' ppoison = /set str=%*%;/substitute -p %{str} (@{Cred}poison@{n})
;-----------------------------------
;Navigators
;-----------------------------------
/def -p2000000 -F -mregexp -t'havia kauhistus pois' bbanish = /set str=%*%;/substitute -p %{str} (@{Cgreen}banish@{n})
/def -p2000000 -F -mregexp -t'buuuummbzdiiiiiibummm' mobilecannon = /set str=%*%;/substitute -p %{str} (@{Cgreen}mobile cannon@{n})
/def -p2000000 -F -mregexp -t'gwwaaajj' ssummon = /set str=%*%;/substitute -p %{str} (@{Cgreen}summon@{n})
/def -p2000000 -F -mregexp -t'prtolala offf pwerrrr' dimensiondoor = /set str=%*%;/substitute -p %{str} (@{Cgreen}dimension door@{n})
/def -p2000000 -F -mregexp -t'mad rad dar' wizardeye = /set str=%*%;/substitute -p %{str} (@{Cmagenta}wizard eye@{n})
/def -p2000000 -F -mregexp -t'hypin pompin luokses juoksen' erelocate = /set str=%*%;/substitute -p %{str} (@{Cgreen}relocate@{n})
/def -p2000000 -F -mregexp -t'flzeeeziiiiying nyyyaaa' ego = /set str=%*%;/substitute -p %{str} (@{Cgreen}go@{n})
/def -p2000000 -F -mregexp -t'xafe ayz xckgandhuzqarr' telewoerror = /set str=%*%;/substitute -p %{str} (@{Cgreen}teleport without error@{n})
/def -p2000000 -F -mregexp -t'xafe xyyqh xckgandhuzqarr' telewerror = /set str=%*%;/substitute -p %{str} (@{Cgreen}teleport with error@{n})
/def -p2000000 -F -mregexp -t'tonnikalaa' heavyweight = /set str=%*%;/substitute -p %{str} (@{Cblue}heavy weight@{n})
;-----------------------------------
;Tarmalen
;-----------------------------------
/def -p2000000 -F -mregexp -t'freudemas egoid' ecureplayer = /set str=%*%;/substitute -p %{str} (@{Cyellow}cure player@{n})
/def -p2000000 -F -mregexp -t'lkzaz zueei enz orn' ers = /set str=%*%;/substitute -p %{str} (@{Cyellow}remove scar@{n})
/def -p2000000 -F -mregexp -t'Creo Herbamus Satisfus' esatiateperson = /set str=%*%;/substitute -p %{str} (@{Cyellow}satiate person@{n})
/def -p2000000 -F -mregexp -t'naxanhar hecnatemne' esoulhold = /set str=%*%;/substitute -p %{str} (@{Cyellow}soul hold@{n})
/def -p2000000 -F -mregexp -t'Impetiquo es bien' elessenpoison = /set str=%*%;/substitute -p %{str} (@{Cyellow}lessen poison@{n})
/def -p2000000 -F -mregexp -t'Siwa on selvaa saastoa' erestore = /set str=%*%;/substitute -p %{str} (@{Cyellow}restore@{n})
/def -p2000000 -F -mregexp -t'Judicandee iocus merciaa Tarmalen' eguardianangel = /set str=%*%;/substitute -p %{str} (@{Cyellow}guardian angel@{n})
/def -p2000000 -F -mregexp -t'judicandus saugaiii' eremovepoison = /set str=%*%;/substitute -p %{str} (@{Cyellow}remove poison@{n})
/def -p2000000 -F -mregexp -t'judicandus littleee' ehealself = /set str=%*%;/substitute -p %{str} (@{Cyellow}heal self@{n})
/def -p2000000 -F -mregexp -t'judicandus mercuree' eclw = /set str=%*%;/substitute -p %{str} (@{Cyellow}cure light wounds@{n})
/def -p2000000 -F -mregexp -t'judicandus ignius' ecsw = /set str=%*%;/substitute -p %{str} (@{Cyellow}cure serious wounds@{n})
/def -p2000000 -F -mregexp -t'judicandus mangenic' eccw = /set str=%*%;/substitute -p %{str} (@{Cyellow}cure critical wounds@{n})
/def -p2000000 -F -mregexp -t'judicandus pzarcumus' eminorheal = /set str=%*%;/substitute -p %{str} (@{Cyellow}minor heal@{n})
/def -p2000000 -F -mregexp -t'judicandus pafzarmus' emajorheal = /set str=%*%;/substitute -p %{str} (@{Cyellow}major heal@{n})
/def -p2000000 -F -mregexp -t'judicandus zapracus' etrueheal = /set str=%*%;/substitute -p %{str} (@{Cyellow}true heal@{n})
/def -p2000000 -F -mregexp -t'pzzarr paf' ehalfheal = /set str=%*%;/substitute -p %{str} (@{Cyellow}half heal@{n})
/def -p2000000 -F -mregexp -t'judicandus puorgo ignius' eminorpartyheal = /set str=%*%;/substitute -p %{str} (@{Cyellow}minor party heal@{n})
/def -p2000000 -F -mregexp -t'judicandus puorgo mangenic' emajorpartyheal = /set str=%*%;/substitute -p %{str} (@{Cyellow}major party heal@{n})
/def -p2000000 -F -mregexp -t'judicandus eurto mangenic' etruepartyheal = /set str=%*%;/substitute -p %{str} (@{Cyellow}true party heal@{n})
/def -p2000000 -F -mregexp -t'Corporem Connecticut Corporee' elifelink = /set str=%*%;/substitute -p %{str} (@{Cyellow}life link@{n})
/def -p2000000 -F -mregexp -t'Naturallis Judicandus Imellys' enaturalrenewal = /set str=%*%;/substitute -p %{str} (@{Cyellow}natural renewal@{n})
/def -p2000000 -F -mregexp -t'nilaehz arzocupne' ebot = /set str=%*%;/substitute -p %{str} (@{Cyellow}blessing of tarmalen@{n})
/def -p2000000 -F -mregexp -t'koko mudi kuntoon, hep' ehealall = /set str=%*%;/substitute -p %{str} (@{Cyellow}heal all@{n})
/def -p2000000 -F -mregexp -t'Paxus' eunstun = /set str=%*%;/substitute -p %{str} (@{Cyellow}unstun@{n})
/def -p2000000 -F -mregexp -t'harnaxan temnahecne' euunpain = /set str=%*%;/substitute -p %{str} (@{Cyellow}unpain@{n})
/def -p2000000 -F -mregexp -t'mumbo jumbo' edeathsdoor = /set str=%*%;/substitute -p %{str} (@{Cyellow}deaths door@{n})
/def -p2000000 -F -mregexp -t'\'ful\'' elight = /set str=%*%;/substitute -p %{str} (@{Cyellow}light@{n})
/def -p2000000 -F -mregexp -t'vas na ful\'' egdark = /set str=%*%;/substitute -p %{str} (@{Cyellow}greater darkness@{n})
/def -p2000000 -F -mregexp -t'Jeeeeeeeeeeeesuuuuuuuus' ewaterwalking = /set str=%*%;/substitute -p %{str} (@{Cblue}water walking@{n})
/def -p2000000 -F -mregexp -t'likz az zurgeeon' esexchange = /set str=%*%;/substitute -p %{str} (@{Cblue}sex change@{n})
/def -p2000000 -F -mregexp -t'vokinsalak elfirtluassa' eraisedead = /set str=%*%;/substitute -p %{str} (@{Cgreen}raise dead@{n})
/def -p2000000 -F -mregexp -t'tuo fo wen stanhc' eressurect = /set str=%*%;/substitute -p %{str} (@{Cgreen}resurrect@{n})
/def -p2000000 -F -mregexp -t'Avee Alee adudaaa..' eholyway = /set str=%*%;/substitute -p %{str} (@{Cgreen}holy way@{n})
/def -p2000000 -F -mregexp -t'vole love velo levo' ewordofrecall = /set str=%*%;/substitute -p %{str} (@{Cgreen}word of recall@{n})
/def -p2000000 -F -mregexp -t'nilaehz temnahecne' ecurseoftarmalen = /set str=%*%;/substitute -p %{str} (@{Cred}curse of tarmalen / regeneration@{n})
/def -p2000000 -F -mregexp -t'Impuqueto es Bien' elessenpoison2 = /set str=%*%;/substitute -p %{str} (@{Cyellow}lessen poison@{n})
/def -p2000000 -F -mregexp -t'corpus novus foobar' enewbody = /set str=%*%;/substitute -p %{str} (@{Cgreen}New body@{n})
/def -p2000000 -F -mregexp -t'juustoa ja pullaa, sita mun maha halajaa' ecreatefood = /set str=%*%;/substitute -p %{str} (@{Cyellow}create food@{n})
;-----------------------------------
;Undead/Curses
;-----------------------------------
/def -p2000000 -F -mregexp -t'siwwis uurthg' amnesia = /set str=%*%;/substitute -p %{str} (@{Cred}amnesia@{n})
/def -p2000000 -F -mregexp -t'rtsstr uurthg' curseofogre = /set str=%*%;/substitute -p %{str} (@{Cred}curse of ogre@{n})
/def -p2000000 -F -mregexp -t'yugfzhrrr suuck suuuuuuck suuuuuuuuuuck' entergydrain = /set str=%*%;/substitute -p %{str} (@{Cred}energy drain@{n})
/def -p2000000 -F -mregexp -t'vaka vanha vainamoinen' entropy = /set str=%*%;/substitute -p %{str} (@{Cred}entropy@{n})
/def -p2000000 -F -mregexp -t'nitin uurthg' feeblemind = /set str=%*%;/substitute -p %{str} (@{Cred}feeble mind@{n})
/def -p2000000 -F -mregexp -t'noccon uurthg' concurse = /set str=%*%;/substitute -p %{str} (@{Cred}con curse@{n})
/def -p2000000 -F -mregexp -t'nyyjoo happa hilleiksis' edrainknowledge = /set str=%*%;/substitute -p %{str} (@{Cred}energy drain{n})
;-----------------------------------
;Spider
;-----------------------------------
/def -p2000000 -F -mregexp -t'Khizanth Arachnidus Satisfusmus' eprayspider =/set str=%*%;/substitute -p %{str} (@{Cyellow}prayer to the spider queen@{n})
/def -p2000000 -F -mregexp -t'Khizanth Arachnidus Walkitus' spiderwalk = /set str=%*%;/substitute -p %{str} (@{Cyellow}spider walk@{n})
/def -p2000000 -F -mregexp -t'Khizanth Arachnidus Hatredus' spiderwrath = /set str=%*%;/substitute -p %{str} (@{Cyellow}spider wrath@{n})
/def -p2000000 -F -mregexp -t'Khizanth Arachnidus Vitalis' hungerofspider = /set str=%*%;/substitute -p %{str} (@{Cyellow}hunger of the spider@{n})
/def -p2000000 -F -mregexp -t'Khizanth Arachnidus Diametricus' spidertouch = /set str=%*%;/substitute -p %{str} (@{Cyellow}spider touch@{n})
/def -p2000000 -F -mregexp -t'Khirsah Zokant Arachnidus' spiderdinquiry = /set str=%*%;/substitute -p %{str} (@{Cyellow}spider demon inquiry@{n})
/def -p2000000 -F -mregexp -t'arachnid infernalicus arachnoidus demonicus' spiderdconjur = /set str=%*%;/substitute -p %{str} (@{Cyellow}spider demon conjuration@{n})
/def -p2000000 -F -mregexp -t'infernalicus domus arachnid rex' spiderdemoncontrol = /set str=%*%;/substitute -p %{str} (@{Cyellow}spider demon control@{n})
/def -p2000000 -F -mregexp -t'infernalicus thanatos arachnidos' esdemonban =  /set str=%*%;/substitute -p %{str} (@{Cyellow}spider demon banishmenta@{n})
;-----------------------------------
;Lords of Chaos
;-----------------------------------
/def -p2000000 -F -mregexp -t'dsaflk aslfoir' bladeoffire = /set str=%*%;/substitute -p %{str} (@{Cred}blade of fire@{n})
/def -p2000000 -F -mregexp -t'ahieppa weaapytama nyttemmin' esummonblade=/set str=%*%;/substitute -p %{str} (@{Cgreen}summon blade@{n})
/def -p2000000 -F -mregexp -t'weaapytama wezup boomie' echaoticwarp =/set str=%*%;/substitute -p %{str} (@{Cgreen}chaotic warp@{n})
;-----------------------------------
;Tigers
;-----------------------------------
/def -p2000000 -F -mregexp -t'Polo Polomii' flamefist = /set str=%*%;/substitute -p %{str} (@{Cred}flame fist@{n})
/def -p2000000 -F -mregexp -t'shreds air with his hands and screams \'Haii!\'' tigerclaw = /set str=%*%;/substitute -p %{str} (@{Cred}tiger claw@{n})
;-----------------------------------
;Templar
;-----------------------------------
/def -p2000000 -F -mregexp -t'Grant your worshipper your protection' epfe2 = /set str=%*%;/substitute -p %{str} (@{Cblue}P F E@{n})
/def -p2000000 -F -mregexp -t'Faerwon, grant your favor!' eblessarmament = /set str=%*%;/substitute -p %{str} (@{Cblue}bless armament@{n})
/def -p2000000 -F -mregexp -t'Renew our strength' elayonhands = /set str=%*%;/substitute -p %{str} (@{Cyellow}lay on hands@{n})
;-----------------------------------
;Merchants
;-----------------------------------
/def -p2000000 -F -mregexp -t'rex car bus xzar' floatingdisc = /set str=%*%;/substitute -p %{str} (@{Cgreen}floating disc@{n})
/def -p2000000 -F -mregexp -t'jumpiiz laika wabbitzz' quicksilver = /set str=%*%;/substitute -p %{str} (@{Cblue}quicksilver@{n})
/def -p2000000 -F -mregexp -t'roope ankka rulettaa' createmoney = /set str=%*%;/substitute -p %{str} (@{Cgreen}create money@{n})
/def -p2000000 -F -mregexp -t'\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$' mip = /set str=%*%;/substitute -p %{str} (@{Cblue}money is power@{n})
/def -p2000000 -F -mregexp -t'mega visa huijari' identify = /set str=%*%;/substitute -p %{str} (@{Cmagenta}identify@{n})
/def -p2000000 -F -mregexp -t'blueeeeeeeeeee\*\*\*\*saka\?\?am!a' protect = /set str=%*%;/substitute -p %{str} (@{Cblue}protect item|armour|weapon@{n})
/def -p2000000 -F -mregexp -t'suomen hoyhen' featherw = /set str=%*%;/substitute -p %{str} (@{Cblue}feather weight@{n})
/def -p2000000 -F -mregexp -t'bat-o-mat' remotebanking = /set str=%*%;/substitute -p %{str} (@{Cyellow}remote banking@{n})
/def -p2000000 -F -mregexp -t'upo huurre helkama' preservecorpse = /set str=%*%;/substitute -p %{str} (@{Cyellow}preserve corpse@{n})
/def -p2000000 -F -mregexp -t'transformaticus minimus' featherweight = /set str=%*%;/substitute -p %{str} (@{Cgreen}feather weight@{n})
/def -p2000000 -F -mregexp -t'eki eki eki equifaxeki' creditcheck = /set str=%*%;/substitute -p %{str} (@{Cgreen}credit check@{n})
;-----------------------------------
;Psionicists
;-----------------------------------
/def -p2000000 -F -mregexp -t'all for one, gather around me' epsiphalanx = /set str=%*%;/substitute -p %{str} (@{Cblue}psionic phalanx@{n})
/def -p2000000 -F -mregexp -t'etati elem ekam' elevitation = /set str=%*%;/substitute -p %{str} (@{Cblue}levitation@{n})
/def -p2000000 -F -mregexp -t'jakki makupala' etherenotthere = /set str=%*%;/substitute -p %{str} (@{Cyellow}there not there@{n})
/def -p2000000 -F -mregexp -t'xafe uurthq' ephazeshift = /set str=%*%;/substitute -p %{str} (@{Cgreen}phaze shift|relocate@{n})
/def -p2000000 -F -mregexp -t'taikadaikaduu\'' eforget = /set str=%*%;/substitute -p %{str} (@{Cred}forget@{n})
/def -p2000000 -F -mregexp -t'kakakaaa  tsooon' ementalwatch = /set str=%*%;/substitute -p %{str} (@{Cyellow}mental watch@{n})
/def -p2000000 -F -mregexp -t'memono locati' emindstore = /set str=%*%;/substitute -p %{str} (@{Cgreen}mind store@{n})
/def -p2000000 -F -mregexp -t'nihenuak assaam no nek orrek' = etransmuteself = /set str=%*%;/substitute -p %{str} (@{Cyellow}transmute self@{n})
/def -p2000000 -F -mregexp -t'moon fiksu, soot tyhma' spellteaching = /set str=%*%;/substitute -p %{str} (@{Cyellow}spell teaching@{n})
/def -p2000000 -F -mregexp -t'aamad ato naav aanarub atyak ala' psychicpurge = /set str=%*%;/substitute -p %{str} (@{Cred}psychic purge@{n})
/def -p2000000 -F -mregexp -t'niihek atierapip aj niiramaan aaffaj' psionicshield = /set str=%*%;/substitute -p %{str} (@{Cblue}psionic shield@{n})
/def -p2000000 -F -mregexp -t'thoiiiiiisss huuuiahashn' psiforceshield = /set str=%*%;/substitute -p %{str} (@{Cblue}force shield@{n})
/def -p2000000 -F -mregexp -t'nostaaaanndiz noszum' ironwill = /set str=%*%;/substitute -p %{str} (@{Cblue}iron will@{n})
/def -p2000000 -F -mregexp -t'xulu tango charlie' forcedome = /set str=%*%;/substitute -p %{str} (@{Cblue}force dome@{n})
/def -p2000000 -F -mregexp -t'wheeeaaaaaa oooooo' fieldoffear = /set str=%*%;/substitute -p %{str} (@{Cblue}field of fear@{n})
/def -p2000000 -F -mregexp -t'ragus on etsat mumixam!' unstablemutation = /set str=%*%;/substitute -p %{str} (@{Cred}unstable mutation@{n})
/def -p2000000 -F -mregexp -t'vaxtextraktdryck' mentalglance = /set str=%*%;/substitute -p %{str} (@{Cmagenta}mental glance@{n})
/def -p2000000 -F -mregexp -t'kakakaaa tsooon' mentalwatch = /set str=%*%;/substitute -p %{str} (@{Cmagenta}mental watch@{n})
/def -p2000000 -F -mregexp -t'vorek ky taree' paralyze = /set str=%*%;/substitute -p %{str} (@{Cred}paralyze@{n})
/def -p2000000 -F -mregexp -t'Annatheer graaweizta.' minddevelopment = /set str=%*%;/substitute -p %{str} (@{Cblue}mind development@{n})
/def -p2000000 -F -mregexp -t'omm zur fehh' mindblast = /set str=%*%;/substitute -p %{str} (@{Cred}mind blast@{n})
/def -p2000000 -F -mregexp -t'omm zur sanc' psibolt = /set str=%*%;/substitute -p %{str} (@{Cred}psi bolt@{n})
/def -p2000000 -F -mregexp -t'omm mar nak semen' minddistuption = /set str=%*%;/substitute -p %{str} (@{Cred}mind disruption@{n})
/def -p2000000 -F -mregexp -t'tora tora tora' psychiccrush = /set str=%*%;/substitute -p %{str} (@{Cred}psychic crush@{n})
/def -p2000000 -F -mregexp -t'omm zur semen gnatlnamauch' psychicshout = /set str=%*%;/substitute -p %{str} (@{Cred}psychic shout@{n})
/def -p2000000 -F -mregexp -t'omm mar nak grttzt gnatlnamauch' psychicstorm = /set str=%*%;/substitute -p %{str} (@{Cred}psychic storm@{n})
/def -p2000000 -F -mregexp -t'omm zur semen' psiblast = /set str=%*%;/substitute -p %{str} (@{Cred}psi blast@{n})
/def -p2000000 -F -mregexp -t'..... .... ... ..  .    .!' invisibility = /set str=%*%;/substitute -p %{str} (@{Cblue}invisibility@{n})
/def -p2000000 -F -mregexp -t'diir mieelis sxil miarr mieelin' emindseize = /set str=%*%;/substitute -p %{str} (@{Cred}mindseize@{n})

;     --M I S C--
/def -p2000000 -F -mregexp -t'peilikuvia ja lasinsirpaleita' mirrorimage = /set str=%*%;/substitute -p %{str} (@{Cblue}mirror image@{n})
/def -p2000000 -F -mregexp -t'lentavia lauseita' floatingletters = /set str=%*%;/substitute -p %{str} (@{Cyellow}floating letters@{n})
;-----------------------------------
;Alchemists
;-----------------------------------
/def -p2000000 -F -mregexp -t'greeeenie fiiingerie' createherb = /set str=%*%;/substitute -p %{str} (@{Cyellow}create berb@{n})
/def -p2000000 -F -mregexp -t'imppy floooogah' summonhomonoculus = /set str=%*%;/substitute -p %{str} (@{Cyellow}summon homonculus@{n})
/def -p2000000 -F -mregexp -t'kallora kassam' shiftblade = /set str=%*%;/substitute -p %{str} (@{Cyellow}shift blade@{n})
/def -p2000000 -F -mregexp -t'aaaaaaaaattchhhoooooooooo' sneezingpowder = /set str=%*%;/substitute -p %{str} (@{Cyellow}sneezing powder@{n})
/def -p2000000 -F -mregexp -t'grrreee allblakkee'  = /set str=%*%;/substitute -p %{str} (@{Cblue}dim@{n})
/def -p2000000 -F -mregexp -t'grrreee gelowwa'  = /set str=%*%;/substitute -p %{str} (@{Cblue}glow@{n})
/def -p2000000 -F -mregexp -t'condiiit riimaynii' esneezingpowder = /set str=%*%;/substitute -p %{str} (@{Cblue}aegis@{n})
;-----------------------------------
;Conjurers
;-----------------------------------
/def -p2000000 -F -mregexp -t'siwwis mof' awareness = /set str=%*%;/substitute -p %{str} (@{Cblue}awareness@{n})
/def -p2000000 -F -mregexp -t'Ziiiiiiiiiiit Ziit Ziiiit' electricfield = /set str=%*%;/substitute -p %{str} (@{Cblue}electric field@{n})
/def -p2000000 -F -mregexp -t'withing thang walz' shelter = /set str=%*%;/substitute -p %{str} (@{Cblue}shelter@{n})
/def -p2000000 -F -mregexp -t'ztonez des deckers' forceabsorption = /set str=%*%;/substitute -p %{str} (@{Cblue}force absorption@{n})
/def -p2000000 -F -mregexp -t'fooohh haaahhh booooloooooh' auradetection = /set str=%*%;/substitute -p %{str} (@{Cmagenta}aura detection@{n})
/def -p2000000 -F -mregexp -t'toughen da mind reeez un biis' psires = /set str=%*%;/substitute -p %{str} (@{Cblue}psychic sanctuary@{n})
/def -p2000000 -F -mregexp -t'sulphiraidzik hydrochloodriz gidz zuf' acidres = /set str=%*%;/substitute -p %{str} (@{Cblue}corrosion shield@{n})
/def -p2000000 -F -mregexp -t'skaki barictos yetz fiil' coldres = /set str=%*%;/substitute -p %{str} (@{Cblue}frost insulation@{n})
/def -p2000000 -F -mregexp -t'qor monoliftus' asphyxres = /set str=%*%;/substitute -p %{str} (@{Cblue}ether boundary@{n})
/def -p2000000 -F -mregexp -t'morri nam pantoloosa' poisonres = /set str=%*%;/substitute -p %{str} (@{Cblue}toxic dilution@{n})
/def -p2000000 -F -mregexp -t'meke tul magic' manares = /set str=%*%;/substitute -p %{str} (@{Cblue}magic dispersion@{n})
/def -p2000000 -F -mregexp -t'kablaaaammmmm bliitz zundfer' elecres = /set str=%*%;/substitute -p %{str} (@{Cblue}energy channeling@{n})
/def -p2000000 -F -mregexp -t'hot hot not zeis daimons' fireres = /set str=%*%;/substitute -p %{str} (@{Cblue}heat reduction@{n})
/def -p2000000 -F -mregexp -t'diiiiuuunz aaanziz' displacement = /set str=%*%;/substitute -p %{str} (@{Cblue}displacement@{n})
/def -p2000000 -F -mregexp -t'nsiiznau' shieldofprotection = /set str=%*%;/substitute -p %{str} (@{Cblue}shield of protection@{n})
/def -p2000000 -F -mregexp -t'ziiiuuuuns wiz' blurredimage = /set str=%*%;/substitute -p %{str} (@{Cblue}blurred image@{n})
/def -p2000000 -F -mregexp -t'fooharribah inaminos cantor' earmorofaether = /set str=%*%;/substitute -p %{str} (@{Cblue}Armour of Aether@{n})
;-----------------------------------
;Channelers
;-----------------------------------
/def -p2000000 -F -mregexp -t'enfuego delcosa' edrainitem =/set str=%*%;/substitute -p %{str} (@{Cyellow}drain item@{n})
/def -p2000000 -F -mregexp -t'shar ryo den...Haa!' echannelball =/set str=%*%;/substitute -p %{str} (@{Cred}channelball@{n})
/def -p2000000 -F -mregexp -t'RRRRAAAAAHHRRRRGGGGGGHHH!!!!!' eenergyaura =/set str=%*%;/substitute -p %{str} (@{Cblue}energy aura@{n})
;-----------------------------------
;Nuns
;-----------------------------------
/def -p2000000 -F -mregexp -t'zeriqum' nunshelter = /set str=%*%;/substitute -p %{str} (@{Cblue}celestial haven@{n})
/def -p2000000 -F -mregexp -t'sanctus angeliq' soulshield = /set str=%*%;/substitute -p %{str} (@{Cblue}soul shield@{n})
/def -p2000000 -F -mregexp -t'Ez\' div' edispelevil = /set str=%*%;/substitute -p %{str} (@{Cred}dispel evil@{n})
/def -p2000000 -F -mregexp -t'sanctus Exzordus' eprotevil = /set str=%*%;/substitute -p %{str} (@{Cblue}protection from evil@{n})
/def -p2000000 -F -mregexp -t'Exzorde\' �' esaintlytouch = /set str=%*%;/substitute -p %{str} (@{Cred}saintly touch@{n})
/def -p2000000 -F -mregexp -t'Sanctus inxze' eholyhand = /set str=%*%;/substitute -p %{str} (@{Cred}holy hand@{n})
/def -p2000000 -F -mregexp -t'Rev \'liz' eholywind = /set str=%*%;/substitute -p %{str} (@{Cred}holy wind@{n})
/def -p2000000 -F -mregexp -t'sanctus . o O' eheavenlyprot = /set str=%*%;/substitute -p %{str} (@{Cblue}heavenly protection@{n})
/def -p2000000 -F -mregexp -t'Sanctum disqum' edispelundead = /set str=%*%;/substitute -p %{str} (@{Cred}dispel undead@{n})
/def -p2000000 -F -mregexp -t'Satan down' ebanishdemons = /set str=%*%;/substitute -p %{str} (@{Cred}banish demons@{n})
;-----------------------------------
;Bards
;-----------------------------------
/def -p2000000 -F -mregexp -t'\'AeaH*Gdg\'' confioco = /set str=%*%;/substitute -p %{str} (@{Cred}con fioco@{n})
/def -p2000000 -F -mregexp -t'daaa timaaa of daaa maaanth' moonsense = /set str=%*%;/substitute -p %{str} (@{Cblue}Moon Sense@{n})
/def -p2000000 -F -mregexp -t'III want to ROAR, III want to SLAM, III want to*' uncontmosh = /set str=%*%;/substitute -p %{str} (@{Cred}uncontrollable mosh@{n})
/def -p2000000 -F -mregexp -t'summons a group of pixies who immediately prepare a dinner*' ekingsfeast = /set str=%*%;/substitute -p %{str} (@{Cblue}kings feast@{n})
/def -p2000000 -F -mregexp -t'a few steps to earthen might, a few steps just go ahead*' eventurersway = /set str=%*%;/substitute -p %{str} (@{Cblue}venturers way@{n})
/def -p2000000 -F -mregexp -t'dIsCHoRD' noitudischord = /set str=%*%;/substitute -p %{str} (@{Cred}noituloves dischord@{n})
/def -p2000000 -F -mregexp -t'To all the eyes around me, I wish to remain hidden' ecthought = /set str=%*%;/substitute -p %{str} (@{Cblue}clandestine thoughts@{n})
/def -p2000000 -F -mregexp -t'may enhance a precense.' evigilantmelody = /set str=%*%;/substitute -p %{str} (@{Cyellow}vigilant melody@{n})
/def -p2000000 -F -mregexp -t'merry song \'Shooting Star\'' ecatchysingalong = /set str=%*%;/substitute -p %{str} (@{Cyellow}catchy singalong@{n})
/def -p2000000 -F -mregexp -t'What child is this, who laid to rest' ehealingsong = /set str=%*%;/substitute -p %{str} (@{Cyellow}healing song@{n})
;-----------------------------------
;Misc
;-----------------------------------
;RED
/def -p2000000 -F -mregexp -t'ddt ddt ddt is good for you and me!' poisoncloud = /set str=%*%;/substitute -p %{str} (@{Cred}poison cloud@{n})
/def -p2000000 -F -mregexp -t'May this become the blood of the Spider queen' venomblade = /set str=%*%;/substitute -p %{str} (@{Cred}venom blade@{n})
/def -p2000000 -F -mregexp -t'etsi poika pippuria' panish = /set str=%*%;/substitute -p %{str} (@{Cred}party banish@{n})
/def -p2000000 -F -mregexp -t'gimme urhits' energydrain = /set str=%*%;/substitute -p %{str} (@{Cred}energy drain@{n})
/def -p2000000 -F -mregexp -t'yugfzhrrr suuck suuuuuck suuuuuuuuuuck' xpdrain = /set str=%*%;/substitute -p %{str} (@{Cred}exp drain@{n})
/def -p2000000 -F -mregexp -t'xeddex uurthg' dexcurse = /set str=%*%;/substitute -p %{str} (@{Cred}dex curse@{n})
/def -p2000000 -F -mregexp -t'removezzzzzarmour' eremovearmour = /set str=%*%;/substitute -p %{str} (@{Cred}remove protections@{n})
/def -p2000000 -F -mregexp -t'I HATE MAGIC' manadrain = /set str=%*%;/substitute -p %{str} (@{Cred}mana drain@{n})
/def -p2000000 -F -mregexp -t'kewa dan dol rae hout' edegenerateperson = /set str=%*%;/substitute -p %{str} (@{Cred}degenerate person@{n})
/def -p2000000 -F -mregexp -t'jammpa humppa ryydy mopsi' eflip = /set str=%*%;/substitute -p %{str} (@{Cred}flip@{n})
/def -p2000000 -F -mregexp -t'huumeet miehen tiella pitaa' ehallu = /set str=%*%;/substitute -p %{str} (@{Cred}hallucination@{n})
;BLUE
/def -p2000000 -F -mregexp -t'demoni on pomoni' infrav =/set str=%*%;/substitute -p %{str} (@{Cblue}infravision@{n})
/def -p2000000 -F -mregexp -t'ahne paskianen olen ma kun taikuutta' eseemag =/set str=%*%;/substitute -p %{str} (@{Cblue}see magic@{n})
/def -p2000000 -F -mregexp -t'\$\%\&\@ \#\*\%\@\*\@\# \$\&\*\@\#' eseeinvis = /set str=%*%;/substitute -p %{str} (@{Cblue}see invisiblility@{n})
/def -p2000000 -F -mregexp -t'imprickening zang gah' imprisonment = /set str=%*%;/substitute -p %{str} (@{Cblue}imprisonment@{n})
/def -p2000000 -F -mregexp -t'The sharper, the sweeter' ebloodseeker = /set str=%*%;/substitute -p %{str} (@{Cblue}blood seeker@{n})
/def -p2000000 -F -mregexp -t'Ourglazz Schmourglazz' = /set str=%*%;/substitute -p %{str} (@{Cblue}resist entropy@{n})
;GREEN
/def -p2000000 -F -mregexp -t'sakenoivasta voimasta' ehaste = /set str=%*%;/substitute -p %{str} (@{Cgreen}haste@{n})
/def -p2000000 -F -mregexp -t'Akronym Htouy, Hokrune Arafax' youth = /set str=%*%;/substitute -p %{str} (@{Cgreen}youth@{n})
/def -p2000000 -F -mregexp -t'draws a large circle to the air with his hands and screams \'Haii!\'' shadowleap = /set str=%*%;/substitute -p %{str} (@{Cgreen}shadow leap@{n})
/def -p2000000 -F -mregexp -t'khozak' edestcorpse = /set str=%*%;/substitute -p %{str} (@{Cgreen}word of attrition@{n})
;YELLOW
/def -p2000000 -F -mregexp -t'$%&@ #*%@*@# $&*@#' seeinvis = /set str=%*%;/substitute -p %{str} (@{Cyellow}see invisbility@{n})
/def -p2000000 -F -mregexp -t'rise Rise RISE' efloat = /set str=%*%;/substitute -p %{str} (@{Cblue}float@{n})
/def -p2000000 -F -mregexp -t'ja nyt kenka kepposasti nousee' efieldoflight = /set str=%*%;/substitute -p %{str} (@{Cyellow}field of light@{n})
/def -p2000000 -F -mregexp -t'tamakan natelo assim' allseeingeye = /set str=%*%;/substitute -p %{str} (@{Cyellow}all seeing eye@{n})
/def -p2000000 -F -mregexp -t'vas ful' greaterlight = /set str=%*%;/substitute -p %{str} (@{Cyellow}greater light@{n})
/def -p2000000 -F -mregexp -t'na ful' darkness = /set str=%*%;/substitute -p %{str} (@{Cyellow}darkness@{n})
/def -p2000000 -F -mregexp -t'vas na ful' greaterdarkness = /set str=%*%;/substitute -p %{str} (@{Cyellow}greater darkness@{n})
/def -p2000000 -F -mregexp -t'Grant me the power, the fire from within' egloryofdestruction = /set str=%*%;/substitute -p %{str} (@{Cyellow}glory of destruction@{n})
/def -p2000000 -F -mregexp -t'enfuego delyo' emanaxfer = /set str=%*%;/substitute -p %{str} (@{Cyellow}transfer mana@{n})
/def -p2000000 -F -mregexp -t'aalltyyuii regonza zirii' = /set str=%*%;/substitute -p %{str} (@{Cyellow}clairvoyance@{n})

/def unload_spelltrans_module = /d_error Haha, need to recode this module :D

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; DraliTF modules/misc/spell_trans.tf version 0.2
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;   name words type upmsg downmsg
/def register_spell = \
	/set not_prot=0%; \
	/if (!getopts("n:w:t:u:d:","")) \
		/if (!getopts("n:w:t:","")) \
			/d_error Invalid register_spell definition!%; \
			/break%; \
		/endif%; \
		/set not_prot=1%; \
	/endif%; \
	/set spelllist=$[strcat(%{spelllist}," ",%{opt_n})]%; \
	/if (%{opt_t} =~ "buff") \
		/set trans_col=@{BCgreen}%; \
	/elseif (%{opt_t} =~ "debuff") \
		/set trans_col=@{BCred}%; \
	/elseif (%{opt_t} =~ "blast") \
		/set trans_col=@{Cmagenta}%; \
	/elseif (%{opt_t} =~ "area") \
		/set trans_col=@{BCmagenta}%; \
	/elseif (%{opt_t} =~ "tele") \
		/set trans_col=@{BCyellow}%; \
	/elseif (%{opt_t} =~ "heal") \
		/set trans_col=@{Cgreen}%; \
	/else \
		/set trans_col=@{Cyellow}%; \
	/endif%; \
	/eval /def -mregexp -t'%{opt_w}' SPELL_TRANS_%{opt_n} = /set str=%%%*%%%;/substitute -p %%%{str} (%{trans_col}%{opt_n}@{n})%; \
	/if (%{not_prot} != 1) \
		/echo Ooh a prot!%; \
	/endif


;You feel light.															WW up
;You feel heavier.															WW down
;You have infravision.														infra up
;Everything no longer seems so red.											infra down

;;Cast Grabbers
;You embrace yourself and state 'the light within'							holy glow cast
;You signal the ghost to get closer and boom 'itsy bitsy chill'				Ghost chill
;You feel a warm feeling and chant 'jack-o-lantern'							Ghost Light

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                   Tarmalen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Shimi's chanting appears to do absolutely nothing.							Unstun up
;A guardian angel arrives to protect you!									Guardian Angel up
;Your guardian angel cannot stay for longer and flies away.					Guardian Angel down
;You feel your will getting stronger.										Unpain up
;You feel your will returning to normal.									Unpain down
;You create a link to Ssmud.												life link up
;You hear a loud snap like sound!											life link down
;/register_spell -n""	-w""	-t""


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                     Druids
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Your skin feels softer.													Earth skin -1
;/def -p2000000 -F -mregexp -t'traces fiery blue runes on a vine seed with his Staff of Druids' evinemantle = /set str=%*%;/substitute -p %{str} (@{Cblue}vine mantle@{n})
;/def -p2000000 -F -mregexp -t'traces fiery demonic night runes in the air' ewitherflesh = /set str=%*%;/substitute -p %{str} (@{Cred}wither flesh@{n})
;/def -p2000000 -F -mregexp -t'traces fiery red runes on his gem' = /set str=%*%;/substitute -p %{str} (@{Cred}gem fire@{n})

/register_spell -n"Reincarnation"	-w"henget uusix"	-t"misc"
/register_spell -n"Call_Pigeon"		-w"habbi urblk"		-t"misc"
/register_spell -n"Earthquake"		-w"\'\%\'"	-t"blast"
/register_spell -n"Drain_Pool"		-w"\$ !\^"			-t"misc"
/register_spell -n"Charge_Staff"	-w"\'# !\(\'"		-t"misc"
/register_spell -n"Create Mud"		-w"# !#"			-t"blast"
/register_spell -n"Transfer_Mana"	-w"\'\"\) !#\'"		-t"misc"
/register_spell -n"Hoar_Frost"		-w"\'\& \^\'"		-t"blast"
/register_spell -n"Starlight"		-w"!\( !!"			-t"blast"
/register_spell -n"Runic_Heal"		-w"!\* \*"			-t"heal"

/register_spell -n"Flex_Shield"	-w"\^ !\)"	-t"buff"	-u"You sense a flex shield covering your body like a second skin."	-d"Your flex shield wobbles, PINGs and vanishes."
/register_spell -n"Earth_Skin"	-w"\% !\("	-t"buff"	-u"You feel your skin harden."	-d"Your skin returns to its original texture."
/register_spell -n"Earth_Power"	-w"\% !\^"	-t"buff"	-u"You feel your strength changing. You flex your muscles experimentally."	-d"The runic sigla '% !^' fade away.. leaving you feeling strange."
/register_spell -n"Drying_Rain"		-w"hooooooooooowwwwwwwwwwwlllllllllllllll"	-t"buff"	-u"This location is now surrounded in a desert yellow forcefield."	-d"The desert yellow forcefield vanishes."

/register_spell -n"Rain"			-w"huku mopo huku"	-t"buff"
/register_spell -n"Shapechange"		-w"\'!\(\'"			-t"buff"
/register_spell -n"Earth_Blood"		-w"\'!\( \*\)\'"	-t"buff"


;You feel relieved. suppress down


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                 Liberators
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/register_spell -n"Ghost_Chill"	-w"itsy bitsy chill"	-t"blast"
/register_spell -n"Ghost_Light"	-w"jack-o-lantern"		-t"blast"
;You embrace yourself and state 'the light within'													holy glow cast
;You feel warm. The warmth increases, but never reaches hot. The room around you brightens up.		Holy Glow up

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                               Folklorists
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/register_spell -n"Minor_Protection" -w"parvus munimentum" -t"buff" -u"You feel slightly protected\." -d"The minor protection fades away\."

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                     Mages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  A C I D  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/register_spell -n"Disruption"	-w"fzz zur fehh"					-t"blast"
/register_spell -n"Acid_Wind"	-w"fzz zur sanc"					-t"blast"
/register_spell -n"Acid_Arrow"	-w"fzz zur semen"					-t"blast"
/register_spell -n"Acid_Ray"	-w"fzz mar nak semen'"				-t"blast"
/register_spell -n"Acid_Blast"	-w"fzz mar nak grttzt"				-t"blast"
/register_spell -n"Acid_Rain"	-w"fzz zur sanc gnatz namauch"		-t"area"
/register_spell -n"Acid_Storm"	-w"fzz mar nak semen gnatlnamauch"	-t"area"
;;;;;;;;;;;;;;;;;;;;;;;;;  A S P H Y X I A T I O N  ;;;;;;;;;;;;;;;;;;;;;;;;;;
/register_spell -n"Vacuumbolt"		-w"ghht zur fehh"				-t"blast"
/register_spell -n"Suffocation"		-w"ghht zur sanc"				-t"blast"
/register_spell -n"Chaos_Bolt"		-w"ghht zur semen"				-t"blast"
/register_spell -n"Strangulation"	-w"ghht mar nak semen"			-t"blast"
/register_spell -n"Blast_Vacuum"	-w"ghht mar nak grttzt"			-t"blast"
/register_spell -n"Vacuum_Ball"		-w"ghht zur sanc namauch"		-t"area"
/register_spell -n"Vacuum_Globe"	-w"ghht zur sanc gnatlnamauch"	-t"area"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  M A G I C A L  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/register_spell -n"Magic_Missile"			-w"gtzt zur fehh"						-t"blast"
/register_spell -n"Summon_Lesser_Spores"	-w"gtzt zur sanc"						-t"blast"
/register_spell -n"Levin_Bolt"				-w"gtzt zur semen"						-t"blast"
/register_spell -n"Summon_Greater_Spores"	-w"gtzt mar nak semen"					-t"blast"
/register_spell -n"Golden_Arrow"			-w"gtzt mar nak grttzt'"				-t"blast"
/register_spell -n"Magic_Wave"				-w"gtzt zur semen gnatlnamauch"			-t"area"
/register_spell -n"Magic_Eruption"			-w"gtzt mar nak grttzt gnatlnamauch"	-t"area"
;;;;;;;;;;;;;;;;;;;;;;;;;  E L E C T R I C I T Y  ;;;;;;;;;;;;;;;;;;;;;;;;;;;
/register_spell -n"Shocking_Grasp"		-w"zot zur fehh"					-t"blast"
/register_spell -n"Lightning_Bolt"		-w"zot zur sanc"					-t"blast"
/register_spell -n"Blast_Lightning"		-w"zot zur semen"					-t"blast"
/register_spell -n"Forked_Lightning"	-w"zot mar nak semen'"				-t"blast"
/register_spell -n"Electrocution"		-w"zot mar nak grttzt"				-t"blast"
/register_spell -n"Chain_Lightning"		-w"zot zur semen gnatlnamauch"		-t"area"
/register_spell -n"Lightning_Storm"		-w"zot mar nak semen gnatlnamauch"	-t"area"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  P O I S O N  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/register_spell -n"Thorn_Spray"				-w"krkx zur fehh"						-t"blast"
/register_spell -n"Poison_Blast"			-w"krkx zur sanc"						-t"blast"
/register_spell -n"Venom_Strike"			-w"krkx zur semen"						-t"blast"
/register_spell -n"Power_Blast"				-w"krkx mar nak semen"					-t"blast"
/register_spell -n"Summon_Carnal_Spores"	-w"krkx mar nak grttzt'"				-t"blast"
/register_spell -n"Poison_Spray"			-w"krkx zur sanc gnatlnamauch"			-t"area"
/register_spell -n"Killing_Cloud"			-w"krkx mar nak grttzt gnatlnamauch"	-t"area"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  C O L D  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/register_spell -n"Chill Touch"		-w"cah zur fehh"					-t"blast"
/register_spell -n"Flaming Ice"		-w"cah zur sanc"					-t"blast"
/register_spell -n"Darkfire"		-w"cah zur semen"					-t"blast"
/register_spell -n"Icebolt"			-w"cah mar nak semen"				-t"blast"
/register_spell -n"Cold_Ray"		-w"cah mar nak grttzt'"				-t"blast"
/register_spell -n"Cone_of_Cold"	-w"cah zur semen gnatlnamauch"		-t"area"
/register_spell -n"Hailstorm"		-w"cah mar nak grttzt gnatlnamauch"	-t"area"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  F I R E  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/register_spell -n"Fireball"		-w"zing yulygul bugh"				-t"blast"
/register_spell -n"Flame_Arrow"		-w"fah zur fehh"					-t"blast"
/register_spell -n"Firebolt"		-w"fah zur sanc"					-t"blast"
/register_spell -n"Fireblast"		-w"fah zur semen"					-t"blast"
/register_spell -n"Meteor_Blast"	-w"fah mar nak semen"				-t"blast"
/register_spell -n"Lava_Blast"		-w"fah mar nak grttzt'"				-t"blast"
/register_spell -n"Meteor_Swarm"	-w"fah zur sanc gnatlnamauch"		-t"area"
/register_spell -n"Lava_Storm"		-w"fah mar nak grttzt gnatlnamauch"	-t"area"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  F I E L D S  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/register_spell -n"Electric_Field"		-w"Ziiiiiiiiit Ziiit Ziiiit"	-t"misc"
