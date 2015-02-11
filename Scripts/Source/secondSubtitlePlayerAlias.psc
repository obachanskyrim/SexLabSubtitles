Scriptname secondSubtitlePlayerAlias extends ReferenceAlias

bool InitOnce = false
bool Init_v20_Once = false

Event OnPlayerLoadGame()
	secondSubtitleText SSC = (getowningquest() as secondSubtitleText)
	SSC.Initialize()
	SSC.RegisterMenukey()

	; If !InitOnce
	; endIf

	If !(Init_v20_Once)
		Init_v20_Once = true
		SSC.CommonSetInit()
	endIf

	; debug.trace("# Subtitle PlayerAlias - OnPlayerLoadGame èàóùäÆóπ")
endEvent
