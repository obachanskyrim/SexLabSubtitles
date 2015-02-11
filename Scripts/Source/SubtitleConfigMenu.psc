Scriptname SubtitleConfigMenu extends SKI_ConfigBase
; SexLab Subtitles MCMコンフィグメニュー

secondSubtitleTextHUD property ssHUD auto ; 字幕＆メニューHUD
secondSubtitleText property SSC auto ; 字幕のコントロール
SubtitleSetSetting property SSetting auto ; 字幕のセッティング

int _csdefault = 0 ; デフォルトボタンで選択される字幕セット（初期値「字幕を表示しない」）

Event OnConfigInit()
	ModName = "$MCM_modName"
	Pages     = new string[2]
	Pages[0]  = "$MCM_page1_subtitleSetting"
	Pages[1]  = "$MCM_page2_commonSubtitleSetting"
EndEvent

event OnGameReload()
	parent.OnGameReload()
	Quest hudQuest = Game.GetFormFromFile(0x1829, "SexLabSubtitles.esp") as Quest
	Quest SControlQuest = Game.GetFormFromFile(0x12C4, "SexLabSubtitles.esp") as Quest

	ssHUD = hudQuest as secondSubtitleTextHUD
	SSC = SControlQuest as secondSubtitleText
	SSetting = SControlQuest as SubtitleSetSetting
endEvent

int function GetVersion()
	return ssubtitletextUtil.GetVersion()
endFunction

Event OnVersionUpdate(int a_version)
	debug.trace("# [SexLab Subtitles] - Update - ver." + CurrentVersion + " >> ver." + a_version)
	If CurrentVersion > 0 && CurrentVersion < 20
		; debug.trace("# ver1.1以下からのアップデート処理")
		ModName = "$MCM_modName"
		Pages     = new string[2]
		Pages[0]  = "$MCM_page1_subtitleSetting"
		Pages[1]  = "$MCM_page2_commonSubtitleSetting"
	elseIf CurrentVersion == 20
		; debug.trace("# ver2.0→ver2.1アップデート処理")
		SSC.CommonSetInit()
	elseIf CurrentVersion == 21
		; debug.trace("# v2.1→v2.2アップデート処理")
		SSC.CommonSetInitUpdate22()
	endIf
EndEvent

; ==============================================
event OnPageReset(string page)
	; 表紙
	if page == ""
		SetTitleText("$MCM_modCatchCopy")
		LoadCustomContent("exported/Widgets/obachan/S_Subtitles_Logo.swf", 95, 30)
		return
	endIf
	UnloadCustomContent()
	; 1ページ目
	if page == "$MCM_page1_subtitleSetting"
		Page1Settings()
	endif
	; 2ページ目
	if page == "$MCM_page2_commonSubtitleSetting"
		Page2Settings()
	endif
endEvent
; ==============================================
Event OnConfigOpen()
endEvent
Event OnConfigClose()
	; 字幕SEXが稼働中なら字幕を更新する
	If SSC.isRunningSubtitle ;字幕sex稼働中の場合
		; debug.trace("# [Subtitles MCM] - 字幕稼働中 -MCMの変更を適用します...")
		int situation = SSC.situation
		int sstage = SSC.getSubtitleStageNow()
		string[] SSet = SSetting.getCSsetBySituation(situation, sstage) ; 変更後の字幕
		string sname = SSetting.getNameCSname(situation)

		If sname == "$SMENU_disble" ; 字幕非表示を選んでいた場合
			SSC.repeatUpdate = false
		else
			If SSC.SSet == SSet ; 実行中の字幕と変更後の字幕が同じ場合
				; debug.trace("# [MCM]  - 現在実行中の字幕に変更はありませんでした")
			else
				SSC.SSet = SSet
				SSC.Temp = 0
				SSC.repeatUpdate = true
				SSC.ShowSubtitlesAuto()
			endif
		endIf
	endif
EndEvent

;/---------------------------------------------------------------------------
	1ページ目の設定（字幕Mod全体の設定）
/;
	Function Page1Settings()
		SetTitleText("$MCM_page1info")
		SetCursorFillMode(TOP_TO_BOTTOM)

		int flags
		if ssHUD.isControlFin
			flags = OPTION_FLAG_DISABLED
		else
			flags = OPTION_FLAG_NONE
		endIf

		AddHeaderOption("$MCM_page1head1")
		AddKeyMapOptionST("keymap_menuKey", "$MCM_page1menukey", ssHUD.menuKey, flags)
		AddSliderOptionST("slider_interval","$MCM_page1interval", ssHUD.interval, "$MCM_Seconds", flags)
		AddToggleOptionST("toggle_randommode","$MCM_page1randommode", SSC.repeatRandom, flags) ; v2.2 added
		AddEmptyOption()

		AddHeaderOption("$MCM_page1head2")
		AddToggleOptionST("toggle_smode","$MCM_page1smode", ssHUD.SMode, flags)
		AddTextOptionST("text_uninstall", "$MCM_page1shutdown", "$MCM_page1valth", flags)

		if ssHUD.isControlFin
			AddTextOptionST("text_reset", "$MCM_page1reset", "$MCM_shareAction")
		else
			AddTextOptionST("text_reset", "$MCM_page1reset", "$MCM_shareAction", OPTION_FLAG_DISABLED)
		endIf

	EndFunction
	; ----------------------------------------------------------------------
	; 字幕セット変更メニューの呼び出しキー
	state keymap_menuKey
		event OnHighlightST()
			SetInfoText("$MCM_page1menukeyInfo")
		endEvent
		event OnKeyMapChangeST(int newKeyCode, string conflictControl, string conflictName)
			if !KeyConflict(newKeyCode, conflictControl, conflictName)
				ssHUD.UnregisterForKey(ssHUD.menuKey)
				ssHUD.menuKey = newKeyCode
				ssHUD.RegisterForKey(ssHUD.menuKey)
				SetKeyMapOptionValueST(ssHUD.menuKey)
			endIf
		endEvent
		event OnDefaultST()
			ssHUD.UnregisterForKey(ssHUD.menuKey)
			ssHUD.menuKey = 48 ; デフォルト「B」
			ssHUD.RegisterForKey(ssHUD.menuKey)
			SetKeyMapOptionValueST(ssHUD.menuKey)
		endEvent
	endState
	; キーがカブった時の処理
	bool function KeyConflict(int newKeyCode, string conflictControl, string conflictName)
		bool continue = true
		if (conflictControl != "")
			string msg
			if (conflictName != "")
				msg = "$MCM_page1menukeyWarn1{$" + conflictName + "}{$" + conflictControl + "}"
			else
				msg = "$MCM_page1menukeyWarn2{$" + conflictControl + "}"
			endIf
			continue = ShowMessage(msg, true, "$Yes", "$No")
		endIf
		return !continue
	endFunction
	; 割り当てたキーをMCMに登録（競合メッセージ用）
	String Function GetCustomControl(int keyCode)
		if(keyCode == ssHUD.menuKey)
			return "$MCM_page1menukeyMessage"
		endIf
	EndFunction
	; ----------------------------------------------------------------------
	; 字幕表示の間隔の調整
	state slider_interval
		event OnHighlightST()
			SetInfoText("$MCM_page1intervalInfo")
		endEvent
		event OnSliderOpenST()
			SetSliderDialogStartValue(ssHUD.interval)
			SetSliderDialogDefaultValue(6)
			SetSliderDialogRange(4, 8)
			SetSliderDialogInterval(1)
		endEvent
		event OnSliderAcceptST(float value)
			ssHUD.interval = value
			SetSliderOptionValueST(ssHUD.interval, "$MCM_Seconds")
		endEvent
		event OnDefaultST()
			ssHUD.interval = 6.0
			SetToggleOptionValueST(ssHUD.interval, "$MCM_Seconds")
		endEvent
	endState
	; ----------------------------------------------------------------------
	; 字幕機能全体のオン・オフ
	state toggle_smode
		event OnHighlightST()
			SetInfoText("$MCM_page1smodeInfo")
		endEvent
		event OnSelectST()
			ssHUD.SMode = !(ssHUD.SMode)
			SetToggleOptionValueST(ssHUD.SMode)
		endEvent
		event OnDefaultST()
			ssHUD.SMode = true
			SetToggleOptionValueST(ssHUD.SMode)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; 字幕ランダム表示のオン・オフ
	state toggle_randommode
		event OnHighlightST()
			SetInfoText("$MCM_page1randommodeInfo")
		endEvent
		event OnSelectST()
			SSC.repeatRandom = !(SSC.repeatRandom)
			SetToggleOptionValueST(SSC.repeatRandom)
		endEvent
		event OnDefaultST()
			SSC.repeatRandom = false
			SetToggleOptionValueST(SSC.repeatRandom)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; Modを外す場合
	state text_uninstall
		event OnHighlightST()
			SetInfoText("$MCM_page1shutdownInfo")
		endEvent
		event OnSelectST()
			ssHUD.stopSubtitleControl()
			ForcePageReset()
		endEvent
	endState
	; ----------------------------------------------------------------------
	; Modの手動リセット
	state text_reset
		event OnHighlightST()
			SetInfoText("$MCM_page1resetInfo")
		endEvent
		event OnSelectST()
			ssHUD.resetSubtitleControl()
			ForcePageReset()
		endEvent
	endState
	; ----------------------------------------------------------------------
	; 字幕のインポート
	state text_importAgain
		event OnHighlightST()
			SetInfoText("$MCM_page1importAgainInfo")
		endEvent
		event OnSelectST()
			bool importOK = SSetting.importSubtitleSetInit() ; 字幕セットの準備とインポート
			int i = 0
			while !(importOK) && (i < 10)
				utility.wait(0.1)
				i += 1
			endwhile
			ssHUD.SetMenuInit() ; HUDメニューの準備（セット名の登録）
			int len = (SSetting.IS_name).length
			ShowMessage("$MCM_page1importMessage{" + len + "}", false, "$Yes")
			SSetting.CSetAgain()
			ForcePageReset()
		endEvent
	endState
;/---------------------------------------------------------------------------
	2ページ目の設定（汎用字幕の割り当て）
/;
	Function Page2Settings()
		SetTitleText("$MCM_page2info")
		SetCursorFillMode(LEFT_TO_RIGHT)

		int flags
		if ssHUD.isControlFin
			flags = OPTION_FLAG_DISABLED
		else
			flags = OPTION_FLAG_NONE
		endIf
		AddHeaderOption("$MCM_page2head1")
		AddHeaderOption("$MCM_page1head3")


		AddMenuOptionST("menu_cmode_default", "$CMODE_default", ssHUD.SetMenu[_csdefault], flags)
		AddTextOptionST("text_importAgain", "$MCM_page1importAgain", "$MCM_shareAction", flags)

		AddTextOptionST("text_forcedAll", "$CMODE_forcedall", "$CMODE_forcedall_btn", flags)
		AddEmptyOption()

		AddEmptyOption()
		AddEmptyOption()

		AddHeaderOption("$MCM_page2head2")
		AddEmptyOption()

		AddMenuOptionST("menu_cmode0", "$CMODE_0", SSetting.common_setname[0], flags)
		AddMenuOptionST("menu_cmode1", "$CMODE_1", SSetting.common_setname[1], flags)
		AddMenuOptionST("menu_cmode2", "$CMODE_2", SSetting.common_setname[2], flags)
		AddMenuOptionST("menu_cmode3", "$CMODE_3", SSetting.common_setname[3], flags)
		AddMenuOptionST("menu_cmode4", "$CMODE_4", SSetting.common_setname[4], flags)
		AddMenuOptionST("menu_cmode5", "$CMODE_5", SSetting.common_setname[5], flags)
		AddMenuOptionST("menu_cmode6", "$CMODE_6", SSetting.common_setname[6], flags)
		AddMenuOptionST("menu_cmode7", "$CMODE_7", SSetting.common_setname[7], flags)
		AddMenuOptionST("menu_cmode8", "$CMODE_8", SSetting.common_setname[8], flags)
		AddMenuOptionST("menu_cmode9", "$CMODE_9", SSetting.common_setname[9], flags)
		AddMenuOptionST("menu_cmode10", "$CMODE_10", SSetting.common_setname[10], flags)
		AddMenuOptionST("menu_cmode11", "$CMODE_11", SSetting.common_setname[11], flags)
		AddMenuOptionST("menu_cmode12", "$CMODE_12", SSetting.common_setname[12], flags)
		;v2.2 added
		AddMenuOptionST("menu_cmode13", "$CMODE_13", SSetting.common_setname[13], flags)
		AddMenuOptionST("menu_cmode14", "$CMODE_14", SSetting.common_setname[14], flags)
		AddMenuOptionST("menu_cmode15", "$CMODE_15", SSetting.common_setname[15], flags)
		AddMenuOptionST("menu_cmode16", "$CMODE_16", SSetting.common_setname[16], flags)
		AddMenuOptionST("menu_cmode17", "$CMODE_17", SSetting.common_setname[17], flags)
		AddMenuOptionST("menu_cmode18", "$CMODE_18", SSetting.common_setname[18], flags)
		AddMenuOptionST("menu_cmode19", "$CMODE_19", SSetting.common_setname[19], flags)
		AddMenuOptionST("menu_cmode20", "$CMODE_20", SSetting.common_setname[20], flags)
	EndFunction
	; ----------------------------------------------------------------------
	; デフォルトの字幕セットの設定
	state menu_cmode_default
		event OnHighlightST()
			SetInfoText("$MCM_cmode_default_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(_csdefault)
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
				SetMenuOptionValueST(ssHUD.SetMenu[_csdefault])
			else
				_csdefault = i
				If _csdefault == 0
					SetMenuOptionValueST("$SMENU_disble")
				else
					debug.trace("# setnameは" + SSetting.IS_name)
					string changename = SSetting.IS_name[_csdefault - 1]
					SetMenuOptionValueST(changename)
				endif
			endIf
		endEvent
		event OnDefaultST()
			SetMenuOptionValueST(ssHUD.SetMenu[_csdefault])
		endEvent
	endState
	; ----------------------------------------------------------------------
	; デフォルトの字幕を全てのシチュエーションに適用する
	state text_forcedAll
		event OnHighlightST()
			SetInfoText("$MCM_cmode_farcedall_info")
		endEvent
		event OnSelectST()
			If _csdefault == 0
				int num = 0
				while (num < 13)
					SSetting.setNameCSname(num, "$SMENU_disble")
					num += 1
				endwhile
			else
				int choicemode = _csdefault - 1 ; 実際の選択は非表示の分を抜いた数
				string setname = SSetting.IS_name[choicemode] ;選択したセット名
				int setindex = SSetting.IS_index[choicemode] ;選択したセットのインポート元（ver2.1）
				;選択したセット
				string[] set1 = SSetting.getSSetByIndex(choicemode, 1)
				string[] set2 = SSetting.getSSetByIndex(choicemode, 2)
				string[] set3 = SSetting.getSSetByIndex(choicemode, 3)
				string[] set4 = SSetting.getSSetByIndex(choicemode, 4)
				string[] set5 = SSetting.getSSetByIndex(choicemode, 5)
				;選択したセットを全てのシチュエーションの汎用字幕としてセット
				int num2 = 0
				while (num2 < 21)
					 SSetting.intoSSetToCS(num2, set1, set2, set3, set4, set5)
					 SSetting.intoCSindex(num2, setindex)
					 SSetting.setNameCSname(num2, setname)
					num2 += 1
				endwhile
			endIf
			ForcePageReset()
		endEvent
	endState
	; ----------------------------------------------------------------------
	; 選択した字幕に変更する処理（choiceは選択した字幕のメニュー順、cmodeは汎用字幕シチュエーション番号）
	Function changeCmode(int choice, int cmode)
		; debug.trace("# メニューオプション" + ssHUD.SetMenu[choice] + "が選ばれました")
		string sname
		If choice < 1 ; 字幕非表示の場合
			sname = "$SMENU_disble"
			SSetting.intoCSempty(cmode)
			SSetting.intoCSindex(cmode, 0)
		else
			int choicemode = choice - 1 ; 実際の選択は非表示の分を抜いた数になる
			sname = SSetting.IS_name[choicemode] ;選択したセット名
			int setindex = SSetting.IS_index[choicemode] ;選択したセットのインポート元（ver2.1）
			;選択したセット
			string[] set1 = SSetting.getSSetByIndex(choicemode, 1)
			string[] set2 = SSetting.getSSetByIndex(choicemode, 2)
			string[] set3 = SSetting.getSSetByIndex(choicemode, 3)
			string[] set4 = SSetting.getSSetByIndex(choicemode, 4)
			string[] set5 = SSetting.getSSetByIndex(choicemode, 5)
			;選択したセットを現在のシチュエーションの汎用字幕としてセット
			 SSetting.intoSSetToCS(cmode, set1, set2, set3, set4, set5)
			 SSetting.intoCSindex(cmode, setindex)
		endIf
		;選択したセットの名前を現在のシチュエーションの字幕名としてセット
		SSetting.setNameCSname(cmode, sname)
		SetMenuOptionValueST(sname) ; メニューに反映
	EndFunction
	; ----------------------------------------------------------------------
	; cmode0 クリーチャー用
	state menu_cmode0
		event OnHighlightST()
			SetInfoText("$MCM_cmode0_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[0])) ;現在の選択肢
			SetMenuDialogDefaultIndex(_csdefault) ; デフォルトの選択肢の順番
			SetMenuDialogOptions(ssHUD.SetMenu) ;表示する選択肢の配列
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
				changeCmode(_csdefault, 0)
			else
				changeCmode(i, 0)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 0) ; デフォルトを選んだ場合
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode1 シックスナイン
	state menu_cmode1
		event OnHighlightST()
			SetInfoText("$MCM_cmode1_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[1]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 1)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 1)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode2 手で愛撫
	state menu_cmode2
		event OnHighlightST()
			SetInfoText("$MCM_cmode2_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[2]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 2)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 2)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode3 足で愛撫
	state menu_cmode3
		event OnHighlightST()
			SetInfoText("$MCM_cmode3_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[3]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 3)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 3)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode4 胸で愛撫
	state menu_cmode4
		event OnHighlightST()
			SetInfoText("$MCM_cmode4_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[4]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 4)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 4)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode5 マスターベーション
	state menu_cmode5
		event OnHighlightST()
			SetInfoText("$MCM_cmode5_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[5]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 5)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 5)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode6 フィストファック
	state menu_cmode6
		event OnHighlightST()
			SetInfoText("$MCM_cmode6_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[6]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 6)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 6)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode7 騎乗位
	state menu_cmode7
		event OnHighlightST()
			SetInfoText("$MCM_cmode7_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[7]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 7)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 7)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode8 前戯
	state menu_cmode8
		event OnHighlightST()
			SetInfoText("$MCM_cmode8_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[8]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 8)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 8)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode9 強姦のフェラチオ
	state menu_cmode9
		event OnHighlightST()
			SetInfoText("$MCM_cmode9_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[9]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 9)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 9)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode10 フェラチオ
	state menu_cmode10
		event OnHighlightST()
			SetInfoText("$MCM_cmode10_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[10]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 10)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 10)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode11 強姦
	state menu_cmode11
		event OnHighlightST()
			SetInfoText("$MCM_cmode11_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[11]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 11)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 11)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode12 一般
	state menu_cmode12
		event OnHighlightST()
			SetInfoText("$MCM_cmode12_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[12]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 12)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 12)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode13 強姦アナル
	state menu_cmode13
		event OnHighlightST()
			SetInfoText("$MCM_cmode13_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[13]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 13)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 13)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode14 アナル
	state menu_cmode14
		event OnHighlightST()
			SetInfoText("$MCM_cmode14_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[14]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 14)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 14)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode15 同性-強姦オーラル
	state menu_cmode15
		event OnHighlightST()
			SetInfoText("$MCM_cmode15_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[15]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 15)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 15)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode16 同性-オーラル
	state menu_cmode16
		event OnHighlightST()
			SetInfoText("$MCM_cmode16_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[16]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 16)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 16)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode17 同性-強姦アナル
	state menu_cmode17
		event OnHighlightST()
			SetInfoText("$MCM_cmode17_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[17]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 17)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 17)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode18 同性-アナル
	state menu_cmode18
		event OnHighlightST()
			SetInfoText("$MCM_cmode18_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[18]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 18)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 18)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode19 同性-強姦
	state menu_cmode19
		event OnHighlightST()
			SetInfoText("$MCM_cmode19_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[19]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 19)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 19)
		endEvent
	endState
	; ----------------------------------------------------------------------
	; cmode20 同性-一般
	state menu_cmode20
		event OnHighlightST()
			SetInfoText("$MCM_cmode20_info")
		endEvent
		event OnMenuOpenST()
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.common_setname[20]))
			SetMenuDialogDefaultIndex(_csdefault)
			SetMenuDialogOptions(ssHUD.SetMenu)
		endEvent
		event OnMenuAcceptST(int i)
			if i < 0
			else
				changeCmode(i, 20)
			endIf
		endEvent
		event OnDefaultST()
			changeCmode(_csdefault, 20)
		endEvent
	endState
