SECTION "Sprite Buffers", SRAM, BANK[0]
; Named twice since I still have the old names most places
S_SPRITEBUFFER0::
sSpriteBuffer0:: ds SPRITEBUFFERSIZE ; a000

S_SPRITEBUFFER1::
sSpriteBuffer1:: ds SPRITEBUFFERSIZE ; a188

S_SPRITEBUFFER2::
sSpriteBuffer2:: ds SPRITEBUFFERSIZE ; a310

	ds $100

sHallOfFame:: ds HOF_TEAM * NUM_HOF_TEAMS ; a598


SECTION "Save Data", SRAM, BANK[1]
	ds $598 ; Possibly just filler data?

sPlayerName::  ds $b ; a598 (NAME_LENGTH)
sMainData::    ds wMainDataEnd   - wMainDataStart ; a5a3
sSpriteData::  ds wSpriteDataEnd - wSpriteDataStart ; ad2c
sPartyData::   ds wPartyDataEnd  - wPartyDataStart ; af2c
sCurBoxData::  ds wBoxDataEnd    - wBoxDataStart ; b0c0
sTilesetType:: ds 1 ; b522
sMainDataCheckSum:: ds 1 ; b523


SECTION "Saved Boxes 1", SRAM, BANK[2]

sBox1:: ds wBoxDataEnd - wBoxDataStart ; a000
sBox2:: ds wBoxDataEnd - wBoxDataStart ; a462
sBox3:: ds wBoxDataEnd - wBoxDataStart ; a8c4
sBox4:: ds wBoxDataEnd - wBoxDataStart ; ad26
sBox5:: ds wBoxDataEnd - wBoxDataStart ; b188
sBox6:: ds wBoxDataEnd - wBoxDataStart ; b5ea
sBank2AllBoxesChecksum:: ds 1 ; ba4c
sBank2IndividualBoxChecksums:: ds 6 ; ba4d


SECTION "Saved Boxes 2", SRAM, BANK[3]

sBox7::  ds wBoxDataEnd - wBoxDataStart ; a000
sBox8::  ds wBoxDataEnd - wBoxDataStart ; a462
sBox9::  ds wBoxDataEnd - wBoxDataStart ; a8c4
sBox10:: ds wBoxDataEnd - wBoxDataStart ; ad26
sBox11:: ds wBoxDataEnd - wBoxDataStart ; b188
sBox12:: ds wBoxDataEnd - wBoxDataStart ; b5ea
sBank3AllBoxesChecksum:: ds 1 ; ba4c
sBank3IndividualBoxChecksums:: ds 6 ; ba4d