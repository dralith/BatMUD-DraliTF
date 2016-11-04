; client side notebook
; Copyright (C) Tero Koskinen 2001 (tkoskine@students.cc.tut.fi)
;               alias Gurb
; These triggers come with ABSOLUTELY NO WARRANTY
; Works like batmud note-command (command is /note)
; --- Updates and edits by Dralith
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module specific functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def unload_note_module = \
	/undef NOTE_*%; \
	/undef note

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Base vars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set notelist=
/set _line=

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load current notes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/test (handle:=tfopen(strcat(%{TF_DIR},"/saves/note.tf"),"r"))
/while (tfread(handle, _line) >= 0) \
	/eval /set notelist=$[strcat({notelist},"!",{_line})]%; \
/done
/test (tfclose(handle))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Notebook functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def NOTE_add = \
	/echo Note added%; \
	/set notelist=$[strcat({notelist},"!",{*})]%; \
	/NOTE_save

/def NOTE_delete = \
	/echo Note %{1} deleted%;\
	/let notelist2=%;\
        /let a=$[strchr({notelist},"!")+1]%;\
        /let count=1%;\
        /while (strlen(substr({notelist},{a})) > 0) \
                /let b=$[{a}-1+strchr(substr({notelist},{a}),"!")]%;\
                /if (b-a == -2) \
			/if (count != {1}) \
                        	/let notelist2=$[strcat(notelist2,"!",substr({notelist},{a}))]%;\
			/endif%;\
                       	/let b=$[strlen({notelist})]%;\
                /elseif (b-a > 0) \
			/if (count != {1}) \
                        	/let c=$[substr({notelist},{a},{b}-{a}+1)]%;\
                        	/let notelist2=$[strcat(notelist2,"!",{c})]%;\
			/endif%;\
                /endif%;\
                /let a=$[{b}+2]%;\
                /let count=$[{count}+1]%;\
        /done%;\
	/set notelist=$[{notelist2}]%;\
	/NOTE_save


/def NOTE_print = \
	/let a=$[strchr({notelist},"!")+1]%;\
	/let count=1%;\
	/while (strlen(substr({notelist},{a})) > 0) \
		/let b=$[{a}-1+strchr(substr({notelist},{a}),"!")]%;\
		/if (b-a == -2) \
			/echo $[strcat(count," ",substr({notelist},{a}))]%;\
			/let b=$[strlen({notelist})]%;\
		/elseif (b-a > 0) \
			/let c=$[substr({notelist},{a},{b}-{a}+1)]%;\
			/echo $[strcat(count," ",{c})]%;\
		/endif%;\
		/let a=$[{b}+2]%;\
		/let count=$[{count}+1]%;\
	/done

/def NOTE_save = \
	/let handle=$[tfopen(strcat(%{TF_DIR},"/saves/note.tf"),"w")]%; \
        /let a=$[strchr({notelist},"!")+1]%;\
        /let count=1%;\
        /while (strlen(substr({notelist},{a})) > 0) \
                /let b=$[{a}-1+strchr(substr({notelist},{a}),"!")]%;\
                /if (b-a == -2) \
			/test (tfwrite(handle,substr({notelist},{a})))%;\
                        /let b=$[strlen({notelist})]%;\
                /elseif (b-a > 0) \
                        /let c=$[substr({notelist},{a},{b}-{a}+1)]%;\
			/test (tfwrite(handle,{c}))%;\
                /endif%;\
                /let a=$[{b}+2]%;\
                /let count=$[{count}+1]%;\
        /done%;\
	/test (tfclose(handle))


/def note=\
	/if (strcmp({1},"delete") == 0)\
		/NOTE_delete %{2}%;\
	/elseif (strlen({*}) > 0) \
		 /NOTE_add %{*}%;\
	/else /NOTE_print%;\
	/endif

