	processor 6502
	
	include "../vcs.h"
	include "../macro.h"

	seg code
	org $F000		; Set origin to $F000

START:
	CLEAN_START		; Clean RAM and TIA addresses

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Start a new frame by turning on VSYNC and VBLANK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NextFrame:
	lda #2			; same as binary #%00000010
	sta VSYNC		; turn on VSYNC
	sta VBLANK		; turn on VBLANK

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Generate the three lines of VSYNC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	sta WSYNC		; first scanline
	sta WSYNC		; second scanline
	sta WSYNC		; third scanline

	lda #0
	sta VSYNC		; turn off VSYNC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Generate the thirty-seven lines of VBLANK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ldx #37			; counter
LoopVBlank:
	sta WSYNC		; hit WSYNC to wait for next scanline
	dex				; decrement X
	bne LoopVBlank	; loop untix X==0

	lda #0
	sta VBLANK		; turn off VBLANK

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Draw 192 visible scanlines (karnel)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ldx #192		; counter
LoopVisible:
	stx COLUBK		; set the background color
	sta WSYNC
	dex				; X--
	bne LoopVisible	; loop while X != 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Output 30 more VBLANK lines (overscan) to complete frame
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	lda #2
	sta VBLANK

	ldx #30			; counter
LoopOverscan:
	sta WSYNC
	dex				; X--
	bne LoopOverscan; loop wile X != 0

	jmp NextFrame

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Complete my ROM size to 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	org $FFFC
	.word START
	.word START
