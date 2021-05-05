	processor 6502
	
	include "../vcs.h"
	include "../macro.h"

	seg code
	org $f000		; defines the origin of the ROM at $F000

START:
	CLEAN_START		; Macro to safely clear the memory


	org $FFFC
	.word START
	.word START	
