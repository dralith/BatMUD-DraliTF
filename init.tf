;;
;; DraliTF init.tf version 0.3
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; World definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;############## B.A.T. ry Muds ###############
/addworld -T"lpp" BatMud bat.org 23
/addworld -T"lpp" HCbat hcbat.bat.org 23
;;########## Muds Connected via Imud ##########
/addworld -T"lpp" Sumu sumu.org 23
/addworld -T"lpp" Zombie zombiemud.org 23
/addworld -T"lpp" Icesus icesus.org 23


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Base vars for TF
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set isize=2
/visual on
/redef on
/more off
/set warn_5keys=off

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load sub-systems
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/eval /load %{TF_DIR}/system/arrays.tf
/eval /load %{TF_DIR}/system/modules.tf
/eval /load %{TF_DIR}/system/commands.tf
/eval /load %{TF_DIR}/system/settings.tf
/eval /load %{TF_DIR}/system/timers.tf

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Echo functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def d_error = /eval /echo -aBCred [TF]: %{*}
/def d_warn = /eval /echo -aCyellow [TF]: %{*}
/def d_pass = /eval /echo -aBCgreen [TF]: %{*}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Party report
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def party_report = \
	/set AUTO_report_misc=$[get_setting(strcat("AUTO",%{1},"_report"))]%; \
	/if ($[fg_world()] =~ "HCbat") \
		/if ({AUTO_report_misc} == 1) \
			/if (%{busy} == 1) \
				/add_queue %{-1}&^$[time()]%; \
			/else \
				@@party say %{-1}%; \
			/endif%; \
		/else \
			/d_warn %{MY_NAME} [party]: %{-1}%; \
	    /endif%; \
	/else \
		/if ({AUTO_report_misc} == 1) \
			/if (%{busy} == 1) \
				/add_queue %{-1}&^$[time()]%; \
			/else \
				@@party report %{-1}%; \
			/endif%; \
		/else \
			/d_warn %{MY_NAME} [report]: %{-1}%; \
	    /endif%; \
	/endif

/def party_report_2 = \
	/if (get_setting("AUTO_report") =~ "1") \
		@@party report %{-1}%; \
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lite by percent
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lite_by_percent <percent> <str> - return str with lite codes
;; lite_by_percent_2 <percent>     - return colour string
;; lite_by_percent_3 <percent>     - return ansi colour code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def lite_by_percent = \
        /if (%{1} > 100) /return "@{BCgreen}%{2}@{n}"%; /endif%; \
        /if (%{1} > 90) /return "@{BCgreen}%{2}@{n}"%; /endif%; \
        /if (%{1} > 80) /return "@{Cgreen}%{2}@{n}"%; /endif%; \
        /if (%{1} > 70) /return "@{BCcyan}%{2}@{n}"%; /endif%; \
        /if (%{1} > 60) /return "@{Ccyan}%{2}@{n}"%; /endif%; \
        /if (%{1} > 50) /return "@{BCyellow}%{2}@{n}"%; /endif%; \
        /if (%{1} > 40) /return "@{Cyellow}%{2}@{n}"%; /endif%; \
        /if (%{1} > 30) /return "@{BCmagenta}%{2}@{n}"%; /endif%; \
        /if (%{1} > 20) /return "@{Cmagenta}%{2}@{n}"%; /endif%; \
        /if (%{1} > 10) /return "@{BCred}%{2}@{n}"%; /endif%; \
        /if (%{1} > 1) /return "@{Cred}%{2}@{n}"%; /endif%; \
        /if (%{1} <= 1) /return "@{BCblack}%{2}@{n}"%; /endif

/def lite_by_percent_2 = \
        /if (%{1} > 100) /return "BCgreen"%; /endif%; \
        /if (%{1} > 90) /return "BCgreen"%; /endif%; \
        /if (%{1} > 80) /return "Cgreen"%; /endif%; \
        /if (%{1} > 70) /return "BCcyan"%; /endif%; \
        /if (%{1} > 60) /return "Ccyan"%; /endif%; \
        /if (%{1} > 50) /return "BCyellow"%; /endif%; \
        /if (%{1} > 40) /return "Cyellow"%; /endif%; \
        /if (%{1} > 30) /return "BCmagenta"%; /endif%; \
        /if (%{1} > 20) /return "Cmagenta"%; /endif%; \
        /if (%{1} > 10) /return "BCred"%; /endif%; \
        /if (%{1} > 1) /return "Cred"%; /endif%; \
        /if (%{1} <= 1) /return "BCblack"%; /endif

/def lite_by_percent_3 = \
		/if (%{1} == 777) /return "[0m"%; /endif%; \
        /if (%{1} >= 90) /return "[1;32m"%; /endif%; \
        /if (%{1} >= 80) /return "[32m"%; /endif%; \
        /if (%{1} >= 70) /return "[1;36m"%; /endif%; \
        /if (%{1} >= 60) /return "[36m"%; /endif%; \
        /if (%{1} >= 50) /return "[1;33m"%; /endif%; \
        /if (%{1} >= 40) /return "[33m"%; /endif%; \
        /if (%{1} >= 30) /return "[1;35m"%; /endif%; \
        /if (%{1} >= 20) /return "[35m"%; /endif%; \
        /if (%{1} >= 10) /return "[1;31m"%; /endif%; \
        /if (%{1} >= 2) /return "[31m"%; /endif%; \
        /if (%{1} <= 1) /return "[1;30m"%; /endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tell status defunker
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set previous_tell_status=""

/def tell_status = \
	/if (%{*} =~ "reset") \
		/if (%{previous_tell_status} =~ "\"\"") \
			@@tell status clear%; \
		/else \
			@@tell status %{previous_tell_status}%; \
			/set previous_tell_status=""%; \
		/endif%; \
	/else \
		/set tell_status_grab=1%; \
		@@tell status%; \
		@@tell status %{*}%; \
	/endif

/def -mregexp -t'^Your tell status is \'(.*)\'\.$' tell_status_grabber_1 = \
	/if (%{tell_status_grab} == 1) \
		/set previous_tell_status=%{P1}%; \
		/set tell_status_grab=0%; \
		/substitute -ag%; \
	/endif

/def -mregexp -t'^You have no tell status\.$' tell_status_grabber_2 = \
	/if (%{tell_status_grab} == 1) \
		/set previous_tell_status=""%; \
		/set tell_status_grab=0%; \
		/substitute -ag%; \
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load last known modules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/init_modules

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Logging - TF_DIR/logs/YY/MM/DD  [Last so INIT isn't logged]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/if (%{LOGGING} == 1) \
	/def -F -h'CONNECT *' start_log_at_connect = \
		/eval /log -g %{TF_DIR}/logs/$(/time \%y)/$(/time \%m)/$(/time \%d)%;\
		/eval /log -i %{TF_DIR}/logs/$(/time \%y)/$(/time \%m)/$(/time \%d)%;\
/endif
