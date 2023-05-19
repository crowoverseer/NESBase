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

  LDX #$00
  STX current_sprite

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

  LDA #$29                      ; green color
  STA PPUDATA
  ;; Set PPU color state
  LDA #%0001110
  STA PPUMASK
forever:
  JMP forever
.endproc

.segment "ZEROPAGE"
player_x: .res 1
player_y: .res 1
pad1: .res 1
current_sprite: .res 1
buffer:  .res 1
.exportzp player_x, player_y, pad1, current_sprite, buffer

.segment "VECTORS"
.addr nmi_handler, reset_handler, irq_handler

.segment "CHR"
.res 8192
