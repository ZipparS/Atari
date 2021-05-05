	processor 6502

	seg code
	org $F000

Start:
	sei
	cld
	ldx #$F0
	stx $09

	org $FFFC
	.word Start
	.word Start	
