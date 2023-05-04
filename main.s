.include "header.inc"
.include "constants.inc"

.segment "CODE"
.proc irq_handler
  RTI
.endproc

.proc nmi_handler
  PHA
  PHP

  RTI
  LDA #$00                      ; will transfer to PPU 00
  STA OAMADDR
  LDA #$02                      ; tranfer page from $0200
  STA OAMDMA

  PLP
  PLA
.endproc

.import reset_handler

.export main
.proc main
  ;; Set PPU write address
  LDX PPUSTATUS
  LDX #$3f
  STX PPUADDR
  LDX #$00
  STX PPUADDR

  LDA #$29  ; green color
  STA PPUDATA
  ;; Set PPU color state
  LDA #%0001110
  STA PPUMASK
forever:
  JMP forever
.endproc

.segment "VECTORS"
.addr nmi_handler, reset_handler, irq_handler

.segment "CHR"
.res 8192
