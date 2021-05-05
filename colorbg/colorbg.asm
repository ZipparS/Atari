	processor 6502
	
	include "../vcs.h"
	include "../macro.h"

	seg code
	org $f000		; defines the origin of the ROM at $F000

START:
	CLEAN_START		; Macro to safely clear the memory
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set background luminosity color to yellow
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Loop_BG:
	lda #$1E		; Load color into A ($1E is NTSC yellow)
	sta COLUBK		; Store A to Background_Color Address $09
	
	jmp Loop_BG		; Repeat from START	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fill ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	org $FFFC		; Define origin to $FFFC
	.word START		; Reset vector at $FFFC (where program starts)
	.word START		; Interrupt vector at $FFFE (unused in the VCS)
