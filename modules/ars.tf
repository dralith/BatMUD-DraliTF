;;
;; DraliTF modules/ars.tf version 0.2
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
/def unload_ars_module = \
	/undef recieved_tell%; \
	/undef recieved_emote%; \
	/undef ars%; \
	/unset last_teller%; \
	/unset autoresp_system%; \
	/unset ars_message%; \
	/unset def_ars_message

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Base Vars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set autoresp_system=0
/set def_ars_message=I'm idle/afk.
/set ars_message=
/set last_teller=

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Automated response system Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def -h'SEND {ars}*' ars = \
	/if (%{-1} !~ "" & %{-1} !~ "clear") \
		/echo -aBCcyan [TF]: ARS Msg set to [%{-1}]%; \
		/set ars_message=%{-1}%; \
	/elseif (%{-1} =~ "clear") \
		/echo -aBCyellow [TF]: ARS Msg reset to default [%{def_ars_message}]%; \
		/set ars_message=%{def_ars_message}%; \
	/else \
		/if (%{ars_message} =~ "") \
			/set ars_message=%{def_ars_message}%; \
		/endif%; \
		/if (%{autoresp_system} = 0) \
			/set autoresp_system=1%; \
			/echo -aBCgreen [TF]: Auto-Response System: [ On] (%{ars_message})%; \
		/else \
			/set autoresp_system=0%; \
			/echo -aBCred [TF]: Auto-Response System: [Off]%; \
		/endif%; \
	/endif

/def -F -mregexp -t'^([A-z]*) tells you' recieved_tell = \
	/if (%{autoresp_system} = 1 & %{P1} !~ %{last_teller}) \
		@tell %{P1} Auto-Response: %{ars_message}%; \
		/set last_teller=%{P1}%; \
	/endif

/def -F -mregexp -t'^@([A-z]*) .* you' recieved_emote = \
	/if (%{autoresp_system} = 1 & %{P1} !~ %{last_teller}) \
		@tell %{P1} Auto-Response: %{ars_message}%; \
		/set last_teller=%{P1}%; \
	/endif
