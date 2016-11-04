;;
;; DraliTF system/timers.tf version 0.1
;; Copyright (C) 2008-2016 Steve Tremel a.k.a. Dralith Maugan (at) BatMud
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; version 3 of the License.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more information on the usage of these files see:
;;         http://esiris.no-ip.org:2222/bat/tf/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; format time
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; timer <timestamp>  -  Diff <from timestamp> to current time
;; timer2 <timestamp> -  Convert <timestamp> seconds to H:M:S format
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def timer = \
	/set timerm=0%; \
	/set timerh=0%; \
	/set timers=0%; \
	/set timerx=%; \
	/set timert=$[trunc(time() - %1)]%; \
	/if (%timert > 60) \
		/set timerm=$[%timert / 60]%; \
		/set timers=$[%timert - (%timert / 60 * 60)]%; \
	/else \
		/set timers=%timert%; \
	/endif%; \
	/if (%timerm > 60) \
		/set timerh=$[%timerm / 60]%; \
		/set timerm=$[%timerm - (%timerm / 60 * 60)]%; \
	/endif%; \
	/if (%timerh > 0) \
		/set timerx=%{timerh}:%; \
	/endif%; \
	/if (%timerm < 10 & %timerh > 0) \
		/set timerm=0%{timerm}%; \
	/endif%; \
	/if (%timerm > 0) \
		/set timerx=%{timerx}%{timerm}:%; \
	/endif%; \
	/if (%timers < 10) \
		/set timers=0%{timers}%; \
	/endif%; \
	/set timerx=%{timerx}%{timers}%; \
	/return timerx

/def timer2 = \
	/set timerm=0%; \
	/set timerh=0%; \
	/set timers=0%; \
	/set timerx=%; \
	/set timert=$[trunc(%1)]%; \
	/if (%timert > 60) \
		/set timerm=$[%timert / 60]%; \
		/set timers=$[%timert - (%timert / 60 * 60)]%; \
	/else \
		/set timers=%timert%; \
	/endif%; \
	/if (%timerm > 60) \
		/set timerh=$[%timerm / 60]%; \
		/set timerm=$[%timerm - (%timerm / 60 * 60)]%; \
	/endif%; \
	/if (%timerh > 0) \
		/set timerx=%{timerh}:%; \
	/endif%; \
	/if (%timerm < 10 & %timerh > 0) \
		/set timerm=0%{timerm}%; \
	/endif%; \
	/if (%timerm > 0) \
		/set timerx=%{timerx}%{timerm}:%; \
	/endif%; \
	/if (%timers < 10) \
		/set timers=0%{timers}%; \
	/endif%; \
	/set timerx=%{timerx}%{timers}%; \
	/return timerx
