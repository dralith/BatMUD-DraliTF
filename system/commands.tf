;;
;; DraliTF system/commands.tf version 0.1
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Command functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set COMMAND_list_default=

/def COMMAND_register = \
	/if (!getopts("i:n:f:d:a:","")) /d_error Invalid command definition!%;/break%;/endif%; \
	/eval /set COMMAND_list_%{opt_f}=%%{COMMAND_list_%{opt_f}} %{opt_i}%; \
	/set COMMAND_%{opt_i}_name=%{opt_n}%; \
	/set COMMAND_%{opt_i}_desc=%{opt_d}%; \
	/set COMMAND_%{opt_i}_file=%{opt_f}%; \
	/if (%{opt_a} = 1) \
	  /def -h'SEND {%{opt_i}}*' COMMAND_%{opt_i} = /CMD_%{opt_i} %%-1%; \
	/else \
	  /def -h'SEND {%{opt_i}}' COMMAND_%{opt_i} = /CMD_%{opt_i}%; \
	/endif

/def COMMAND_list = \
        /set ctype=%{*}%; \
        /if (%{ctype} =~ "") \
          /set ctype=default%; \
        /endif%; \
		/set clen=$(/eval /length %%{COMMAND_list_%{ctype}})%; \
		/let mi=1%; \
		/if (%{clen} >= 1) \
			/echo -p [TF]: ,--------------------------------------------------------------------------.%; \
			/echo -p [TF]: | @{B}$[pad("Syntax:",-30)]@{n} \(@{B}$[pad("Name:",-7)]@{n}\) @{B}Description:@{n}                    |%; \
			/echo -p [TF]: |--------------------------------------------------------------------------|%; \
			/while (%{mi} <= %{clen}) \
				/set cmod=$(/eval /nth %{mi} %%{COMMAND_list_%{ctype}})%; \
				/eval /set cmd_name=%%{COMMAND_%{cmod}_name}%; \
				/eval /set cmd_desc=%%{COMMAND_%{cmod}_desc}%; \
				/eval /set cmd_name=%{cmd_name}%; \
				/eval /set cmd_desc=%{cmd_desc}%; \
				/echo -p [TF]: | @{BCcyan}$[pad(%{cmd_name},-30)]@{n} \(@{BCyellow}$[pad(%{cmod},-7)]@{n}\) @{B}$[pad(%{cmd_desc},-31)]@{n} |%; \
				/let mi=$[%{mi}+1]%; \
			/done%; \
			/echo -p [TF]: `--------------------------------------------------------------------------'%; \
		/else \
			/d_error No commands available. How do you have this without it's command?%; \
		/endif

/def COMMAND_register_i = \
		/if (!getopts("n:m:a:","")) /d_error Invalid command definition!%;/break%;/endif%; \
		/eval /set COMMAND_list_i_%{opt_m}=%%{COMMAND_list_i_%{opt_m}} %{opt_n}%; \
		/eval /send @@command %{opt_n} %{opt_a}

/def COMMAND_cleanup = \
		/if (%{1} =~ "") \
				/d_warn Cleanup requires a module argument.%; \
				/return%; \
		/endif%; \
		/eval /set com_list=%%{COMMAND_list_i_%{1}}%; \
		/set ml=$(/length %{com_list})%; \
		/set mi=1%; \
		/while (%{mi} <= %{ml}) \
			/send @@uncommand $(/eval /nth %{mi} %{com_list})%; \
      /set mi=$[%{mi}+1]%; \
		/done%; \
		/eval /unset COMMAND_list_i_%{1}%; \
		/unset com_list
