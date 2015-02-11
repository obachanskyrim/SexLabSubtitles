Scriptname SubtitleSetSetting extends Quest
{sexLab用 字幕セットのインポート・汎用字幕の設定}

string endcode = "#ssend" ; 終了タグ
string[] Property common_setname auto;シチュエーションに適用されているセット名
string[] Property common_situation auto; シチュエーション名
int[] Property CS_index auto ; シチュエーションに適用されているセットのインポート元番号

string[] Property IS_name auto ; インポートした字幕のセット名
int[] Property IS_index auto ; インポートした字幕のファイル番号

; 汎用字幕ファイルの初期化 for v2.2update 13種に8シチュ追加
Function commonSetInitUpdate22()
	string[] common_setname_add
	string[] common_situation_add
	common_setname_add = new string[8]
	common_situation_add = new string[8]
	common_situation_add[0] = "$CMODE_13"
	common_situation_add[1] = "$CMODE_14"
	common_situation_add[2] = "$CMODE_15"
	common_situation_add[3] = "$CMODE_16"
	common_situation_add[4] = "$CMODE_17"
	common_situation_add[5] = "$CMODE_18"
	common_situation_add[6] = "$CMODE_19"
	common_situation_add[7] = "$CMODE_20"
	int[] CS_index_add = new int[8]
	int num = 0
	while (num < 8)
		common_setname_add[num] = "$SMENU_disble"
		CS_index_add[num] = 0
		num += 1
	endwhile
	common_setname = sslUtility.MergeStringArray(common_setname_add, common_setname)
	common_situation = sslUtility.MergeStringArray(common_situation_add, common_situation)
	CS_index = sslUtility.MergeIntArray(cs_index_add, CS_index)
	int num2 = 13
	while (num2 < 21)
		intoCSempty(num)
		num2 += 1
	endwhile
	; Debug.Trace("# common_setnameは" + common_setname)
	; Debug.Trace("# common_situation" + common_situation)
	; Debug.Trace("# CS_indexは" + CS_index.length)
EndFunction

; 汎用字幕ファイルの初期化
Function commonSetInit()
	common_setname = sslUtility.EmptyStringArray()
	common_situation = sslUtility.EmptyStringArray()
	common_setname = new string[21]
	common_situation = new string[21]
	common_situation[0] = "$CMODE_0"
	common_situation[1] = "$CMODE_1"
	common_situation[2] = "$CMODE_2"
	common_situation[3] = "$CMODE_3"
	common_situation[4] = "$CMODE_4"
	common_situation[5] = "$CMODE_5"
	common_situation[6] = "$CMODE_6"
	common_situation[7] = "$CMODE_7"
	common_situation[8] = "$CMODE_8"
	common_situation[9] = "$CMODE_9"
	common_situation[10] = "$CMODE_10"
	common_situation[11] = "$CMODE_11"
	common_situation[12] = "$CMODE_12"
	common_situation[13] = "$CMODE_13"
	common_situation[14] = "$CMODE_14"
	common_situation[15] = "$CMODE_15"
	common_situation[16] = "$CMODE_16"
	common_situation[17] = "$CMODE_17"
	common_situation[18] = "$CMODE_18"
	common_situation[19] = "$CMODE_19"
	common_situation[20] = "$CMODE_20"

	CS_index = sslUtility.EmptyIntArray()
	CS_index = new int[21]
	int num = 0
	while (num < 21)
		common_setname[num] = "$SMENU_disble"
		CS_index[num] = 0
		intoCSempty(num)
		num += 1
	endwhile
EndFunction

; 字幕セットの準備
bool Function importSubtitleSetInit()
	int filecount = importJSONfileCount(1, 30, "../sexlabSubtitles/importSet")
	; debug.trace("# インポートするJSONファイルは合計" + filecount + "個存在しています")
	IS_name = sslUtility.EmptyStringArray()
	IS_index = sslUtility.EmptyIntArray()
	If filecount > 0
		IS_name =	PapyrusUtil.StringArray(filecount)
		IS_index =	PapyrusUtil.IntArray(filecount)
	endif
	importSSetToNameAndIndex(1, 30, "../sexlabSubtitles/importSet", IS_name, IS_index)
	bool importFin = setImportSSet()
	If importFin
		return true
	else
		return false
	endIf
EndFunction

;デフォルト字幕のセット（Mod導入初回時のみ）
Function defaultSSet()
	; debug.trace("# defaultSSet開始")
	int startset1 = IS_name.find("汎用和姦男女")
	int startset2 = IS_name.find("汎用オーラル受")
	int startset3 = IS_name.find("汎用喘ぎ女性のみ")
	int startset4 = IS_name.find("喘ぎ女性ハード")
	int startset5 = IS_name.find("男喘ぎ・女性積極的")
	int startset6 = IS_name.find("状況描写・女女")

	; インポート元のファイル番号
	int startindex1
	int startindex2
	int startindex3
	int startindex4
	int startindex5
	int startindex6
	If startset1 < 0
		startindex1 = 0
	else
		startindex1 = IS_index[startset1]
	endif
	If startset2 < 0
		startindex2 = 0
	else
		startindex2 = IS_index[startset2]
	endif
	If startset3 < 0
		startindex3 = 0
	else
		startindex3 = IS_index[startset3]
	endif
	If startset4 < 0
		startindex4 = 0
	else
		startindex4 = IS_index[startset4]
	endif
	If startset5 < 0
		startindex5 = 0
	else
		startindex5 = IS_index[startset5]
	endif
	If startset6 < 0
		startindex6 = 0
	else
		startindex6 = IS_index[startset6]
	endif

	; debug.trace("# 【汎用和姦男女】はimportSet" + startindex1)
	; debug.trace("# 【汎用オーラル受】はimportSet" + startindex2)
	; debug.trace("# 【汎用喘ぎ女性のみ】はimportSet" + startindex3)
	; debug.trace("# 【喘ぎ女性ハード】はimportSet" + startindex4)
	; debug.trace("# 【男喘ぎ・女性積極的】はimportSet" + startindex5)
	; debug.trace("# 【状況描写・女女】はimportSet" + startindex6)

	If startset1 >= 0
		string[] set1 = getSSetByIndex(startset1, 1)
		string[] set2 = getSSetByIndex(startset1, 2)
		string[] set3 = getSSetByIndex(startset1, 3)
		string[] set4 = getSSetByIndex(startset1, 4)
		string[] set5 = getSSetByIndex(startset1, 5)
		intoSSetToCS(12, set1, set2, set3, set4, set5)
		intoCSindex(12, startindex1)
		setNameCSname(12, "汎用和姦男女")
		intoSSetToCS(14, set1, set2, set3, set4, set5)
		intoCSindex(14, startindex1)
		setNameCSname(14, "汎用和姦男女")
	endif
	If startset2 >= 0
		string[] set1 = getSSetByIndex(startset2, 1)
		string[] set2 = getSSetByIndex(startset2, 2)
		string[] set3 = getSSetByIndex(startset2, 3)
		string[] set4 = getSSetByIndex(startset2, 4)
		string[] set5 = getSSetByIndex(startset2, 5)
		intoSSetToCS(9, set1, set2, set3, set4, set5)
		intoSSetToCS(10, set1, set2, set3, set4, set5)
		intoCSindex(9, startindex2)
		intoCSindex(10, startindex2)
		setNameCSname(9, "汎用オーラル受")
		setNameCSname(10, "汎用オーラル受")
	endif
	If startset3 >= 0
		string[] set1 = getSSetByIndex(startset3, 1)
		string[] set2 = getSSetByIndex(startset3, 2)
		string[] set3 = getSSetByIndex(startset3, 3)
		string[] set4 = getSSetByIndex(startset3, 4)
		string[] set5 = getSSetByIndex(startset3, 5)
		intoSSetToCS(1, set1, set2, set3, set4, set5)
		intoSSetToCS(5, set1, set2, set3, set4, set5)
		intoCSindex(1, startindex3)
		intoCSindex(5, startindex3)
		setNameCSname(1, "汎用喘ぎ女性のみ")
		setNameCSname(5, "汎用喘ぎ女性のみ")
	endif
	If startset4 >= 0
		string[] set1 = getSSetByIndex(startset4, 1)
		string[] set2 = getSSetByIndex(startset4, 2)
		string[] set3 = getSSetByIndex(startset4, 3)
		string[] set4 = getSSetByIndex(startset4, 4)
		string[] set5 = getSSetByIndex(startset4, 5)
		intoSSetToCS(0, set1, set2, set3, set4, set5)
		intoSSetToCS(6, set1, set2, set3, set4, set5)
		intoSSetToCS(11, set1, set2, set3, set4, set5)
		intoSSetToCS(13, set1, set2, set3, set4, set5)
		intoCSindex(0, startindex4)
		intoCSindex(6, startindex4)
		intoCSindex(11, startindex4)
		intoCSindex(13, startindex4)
		setNameCSname(0, "喘ぎ女性ハード")
		setNameCSname(6, "喘ぎ女性ハード")
		setNameCSname(11, "喘ぎ女性ハード")
		setNameCSname(13, "喘ぎ女性ハード")
	endif
	If startset5 >= 0
		string[] set1 = getSSetByIndex(startset5, 1)
		string[] set2 = getSSetByIndex(startset5, 2)
		string[] set3 = getSSetByIndex(startset5, 3)
		string[] set4 = getSSetByIndex(startset5, 4)
		string[] set5 = getSSetByIndex(startset5, 5)
		intoSSetToCS(2, set1, set2, set3, set4, set5)
		intoSSetToCS(3, set1, set2, set3, set4, set5)
		intoSSetToCS(4, set1, set2, set3, set4, set5)
		intoSSetToCS(7, set1, set2, set3, set4, set5)
		intoSSetToCS(8, set1, set2, set3, set4, set5)
		intoCSindex(2, startindex5)
		intoCSindex(3, startindex5)
		intoCSindex(4, startindex5)
		intoCSindex(7, startindex5)
		intoCSindex(8, startindex5)
		setNameCSname(2, "男喘ぎ・女性積極的")
		setNameCSname(3, "男喘ぎ・女性積極的")
		setNameCSname(4, "男喘ぎ・女性積極的")
		setNameCSname(7, "男喘ぎ・女性積極的")
		setNameCSname(8, "男喘ぎ・女性積極的")
	endif
	If startset6 >= 0
		string[] set1 = getSSetByIndex(startset6, 1)
		string[] set2 = getSSetByIndex(startset6, 2)
		string[] set3 = getSSetByIndex(startset6, 3)
		string[] set4 = getSSetByIndex(startset6, 4)
		string[] set5 = getSSetByIndex(startset6, 5)
		intoSSetToCS(15, set1, set2, set3, set4, set5)
		intoSSetToCS(16, set1, set2, set3, set4, set5)
		intoSSetToCS(17, set1, set2, set3, set4, set5)
		intoSSetToCS(18, set1, set2, set3, set4, set5)
		intoSSetToCS(19, set1, set2, set3, set4, set5)
		intoSSetToCS(20, set1, set2, set3, set4, set5)
		intoCSindex(15, startindex6)
		intoCSindex(16, startindex6)
		intoCSindex(17, startindex6)
		intoCSindex(18, startindex6)
		intoCSindex(19, startindex6)
		intoCSindex(20, startindex6)
		setNameCSname(15, "状況描写・女女")
		setNameCSname(16, "状況描写・女女")
		setNameCSname(17, "状況描写・女女")
		setNameCSname(18, "状況描写・女女")
		setNameCSname(19, "状況描写・女女")
		setNameCSname(20, "状況描写・女女")
	endif
EndFunction

;デフォルト字幕のセット（v2.1→v2.2）
Function defaultSSetUpdate22()
	; debug.trace("# defaultSSetUpdate22処理開始")
	int startset1 = IS_name.find("汎用和姦男女")
	int startset4 = IS_name.find("喘ぎ女性ハード")
	int startset6 = IS_name.find("状況描写・女女")

	; インポート元のファイル番号
	int startindex1
	int startindex4
	int startindex6
	If startset1 < 0
		startindex1 = 0
	else
		startindex1 = IS_index[startset1]
	endif
	If startset4 < 0
		startindex4 = 0
	else
		startindex4 = IS_index[startset4]
	endif
	If startset6 < 0
		startindex6 = 0
	else
		startindex6 = IS_index[startset6]
	endif

	; debug.trace("# 【汎用和姦男女】はimportSet" + startindex1)
	; debug.trace("# 【喘ぎ女性ハード】はimportSet" + startindex4)
	; debug.trace("# 【状況描写・女女】はimportSet" + startindex6)

	If startset1 >= 0
		string[] set1 = getSSetByIndex(startset1, 1)
		string[] set2 = getSSetByIndex(startset1, 2)
		string[] set3 = getSSetByIndex(startset1, 3)
		string[] set4 = getSSetByIndex(startset1, 4)
		string[] set5 = getSSetByIndex(startset1, 5)
		intoSSetToCS(14, set1, set2, set3, set4, set5)
		intoCSindex(14, startindex1)
		setNameCSname(14, "汎用和姦男女")
	endif
	If startset4 >= 0
		string[] set1 = getSSetByIndex(startset4, 1)
		string[] set2 = getSSetByIndex(startset4, 2)
		string[] set3 = getSSetByIndex(startset4, 3)
		string[] set4 = getSSetByIndex(startset4, 4)
		string[] set5 = getSSetByIndex(startset4, 5)
		intoSSetToCS(13, set1, set2, set3, set4, set5)
		intoCSindex(13, startindex4)
		setNameCSname(13, "喘ぎ女性ハード")
	endif
	If startset6 >= 0
		string[] set1 = getSSetByIndex(startset6, 1)
		string[] set2 = getSSetByIndex(startset6, 2)
		string[] set3 = getSSetByIndex(startset6, 3)
		string[] set4 = getSSetByIndex(startset6, 4)
		string[] set5 = getSSetByIndex(startset6, 5)
		intoSSetToCS(15, set1, set2, set3, set4, set5)
		intoSSetToCS(16, set1, set2, set3, set4, set5)
		intoSSetToCS(17, set1, set2, set3, set4, set5)
		intoSSetToCS(18, set1, set2, set3, set4, set5)
		intoSSetToCS(19, set1, set2, set3, set4, set5)
		intoSSetToCS(20, set1, set2, set3, set4, set5)
		intoCSindex(15, startindex6)
		intoCSindex(16, startindex6)
		intoCSindex(17, startindex6)
		intoCSindex(18, startindex6)
		intoCSindex(19, startindex6)
		intoCSindex(20, startindex6)
		setNameCSname(15, "状況描写・女女")
		setNameCSname(16, "状況描写・女女")
		setNameCSname(17, "状況描写・女女")
		setNameCSname(18, "状況描写・女女")
		setNameCSname(19, "状況描写・女女")
		setNameCSname(20, "状況描写・女女")
	endif
	; Debug.Trace("# common_setnameは" + common_setname)
EndFunction

;汎用字幕セットの再セット（新しくインポートした字幕ファイルの内容を更新する）
Function CSetAgain()
	int i = 0
	while (i < 21)
		string d_situation = 	common_situation[i]
		int d_index = CS_index[i]
		If !(d_index == 0)
			string[] set1 = getSSetByIndex2(d_index, 1)
			string[] set2 = getSSetByIndex2(d_index, 2)
			string[] set3 = getSSetByIndex2(d_index, 3)
			string[] set4 = getSSetByIndex2(d_index, 4)
			string[] set5 = getSSetByIndex2(d_index, 5)
			intoSSetToCS(i, set1, set2, set3, set4, set5)
			intoCSindex(i, d_index)
			common_setname[i] = getSetnameImportNum(d_index)
		endif
		; debug.trace("# " + d_situation + "の字幕のインポート元：importSet" + d_index + "を" + common_setname[i] + "に更新しました")
		i += 1
	endwhile
EndFunction

;/===========================================================
	【汎用字幕21種】v2.2

	; 0 - creature
	; 1 - arrok69
	; 2 - handjob
	; 3 - footjob
	; 4 - boobjob
	; 5 - masturbation
	; 6 - fisting
	; 7 - cowgirl
	; 8 - foreplay

	; 15 - agg_oral_s (samesex)
	; 16 - oral_s (samesex)
	; 17 - agg_anal_s (samesex)
	; 18 - anal_s (samesex)
	; 19 - agg_missionary_s (samesex)
	; 20 - missonary_s (samesex)

	; 9 - agg_oral
	; 10 - oral
	; 13 - agg_anal
	; 14 - anal
	; 11 - agg_missionary
	; 12 - missonary

/;
; 汎用字幕セット
	;v2.2 added
	string[] common_agg_oral_s_1
	string[] common_agg_oral_s_2
	string[] common_agg_oral_s_3
	string[] common_agg_oral_s_4
	string[] common_agg_oral_s_5
	string[] common_oral_s_1
	string[] common_oral_s_2
	string[] common_oral_s_3
	string[] common_oral_s_4
	string[] common_oral_s_5
	string[] common_agg_anal_s_1
	string[] common_agg_anal_s_2
	string[] common_agg_anal_s_3
	string[] common_agg_anal_s_4
	string[] common_agg_anal_s_5
	string[] common_anal_s_1
	string[] common_anal_s_2
	string[] common_anal_s_3
	string[] common_anal_s_4
	string[] common_anal_s_5
	string[] common_agg_missionary_s_1
	string[] common_agg_missionary_s_2
	string[] common_agg_missionary_s_3
	string[] common_agg_missionary_s_4
	string[] common_agg_missionary_s_5
	string[] common_missionary_s_1
	string[] common_missionary_s_2
	string[] common_missionary_s_3
	string[] common_missionary_s_4
	string[] common_missionary_s_5
	string[] common_agg_anal_1
	string[] common_agg_anal_2
	string[] common_agg_anal_3
	string[] common_agg_anal_4
	string[] common_agg_anal_5
	string[] common_anal_1
	string[] common_anal_2
	string[] common_anal_3
	string[] common_anal_4
	string[] common_anal_5
	;v2.0
	string[] common_creature_1
	string[] common_creature_2
	string[] common_creature_3
	string[] common_creature_4
	string[] common_creature_5
	string[] common_69_1
	string[] common_69_2
	string[] common_69_3
	string[] common_69_4
	string[] common_69_5
	string[] common_handjob_1
	string[] common_handjob_2
	string[] common_handjob_3
	string[] common_handjob_4
	string[] common_handjob_5
	string[] common_footjob_1
	string[] common_footjob_2
	string[] common_footjob_3
	string[] common_footjob_4
	string[] common_footjob_5
	string[] common_boobjob_1
	string[] common_boobjob_2
	string[] common_boobjob_3
	string[] common_boobjob_4
	string[] common_boobjob_5
	string[] common_masturbation_1
	string[] common_masturbation_2
	string[] common_masturbation_3
	string[] common_masturbation_4
	string[] common_masturbation_5
	string[] common_fisting_1
	string[] common_fisting_2
	string[] common_fisting_3
	string[] common_fisting_4
	string[] common_fisting_5
	string[] common_cowgirl_1
	string[] common_cowgirl_2
	string[] common_cowgirl_3
	string[] common_cowgirl_4
	string[] common_cowgirl_5
	string[] common_agg_oral_1
	string[] common_agg_oral_2
	string[] common_agg_oral_3
	string[] common_agg_oral_4
	string[] common_agg_oral_5
	string[] common_oral_1
	string[] common_oral_2
	string[] common_oral_3
	string[] common_oral_4
	string[] common_oral_5
	string[] common_foreplay_1
	string[] common_foreplay_2
	string[] common_foreplay_3
	string[] common_foreplay_4
	string[] common_foreplay_5
	string[] common_agg_missionary_1
	string[] common_agg_missionary_2
	string[] common_agg_missionary_3
	string[] common_agg_missionary_4
	string[] common_agg_missionary_5
	string[] common_missionary_1
	string[] common_missionary_2
	string[] common_missionary_3
	string[] common_missionary_4
	string[] common_missionary_5

; 汎用字幕のセットのインポート元を保管する（ver2.1 インポート更新用）
Function intoCSindex(int csnum, int importnum)
	; debug.trace("# intoCSindex処理 - シチュエーション" + csnum + "はimportSet" + importnum)
	CS_index[csnum] = importnum
EndFunction

; 字幕セットを汎用セットの枠にセットする処理（5ステージ分まとめて）
Function intoSSetToCS(int csnum, string[] set1, string[] set2, string[] set3, string[] set4, string[] set5)
	; debug.trace("# intoSSetToCS開始")
	If csnum == 0
		common_creature_1 = set1
		common_creature_2 = set2
		common_creature_3 = set3
		common_creature_4 = set4
		common_creature_5 = set5
	elseif csnum == 1
		common_69_1 = set1
		common_69_2 = set2
		common_69_3 = set3
		common_69_4 = set4
		common_69_5 = set5
	elseif csnum == 2
		common_handjob_1 = set1
		common_handjob_2 = set2
		common_handjob_3 = set3
		common_handjob_4 = set4
		common_handjob_5 = set5
	elseif csnum == 3
		common_footjob_1 = set1
		common_footjob_2 = set2
		common_footjob_3 = set3
		common_footjob_4 = set4
		common_footjob_5 = set5
	elseif csnum == 4
		common_boobjob_1 = set1
		common_boobjob_2 = set2
		common_boobjob_3 = set3
		common_boobjob_4 = set4
		common_boobjob_5 = set5
	elseif csnum == 5
		common_masturbation_1 = set1
		common_masturbation_2 = set2
		common_masturbation_3 = set3
		common_masturbation_4 = set4
		common_masturbation_5 = set5
	elseif csnum == 6
		common_fisting_1 = set1
		common_fisting_2 = set2
		common_fisting_3 = set3
		common_fisting_4 = set4
		common_fisting_5 = set5
	elseif csnum == 7
		common_cowgirl_1 = set1
		common_cowgirl_2 = set2
		common_cowgirl_3 = set3
		common_cowgirl_4 = set4
		common_cowgirl_5 = set5
	elseif csnum == 8
		common_foreplay_1 = set1
		common_foreplay_2 = set2
		common_foreplay_3 = set3
		common_foreplay_4 = set4
		common_foreplay_5 = set5
	elseif csnum == 9
		common_agg_oral_1 = set1
		common_agg_oral_2 = set2
		common_agg_oral_3 = set3
		common_agg_oral_4 = set4
		common_agg_oral_5 = set5
	elseif csnum == 10
		common_oral_1 = set1
		common_oral_2 = set2
		common_oral_3 = set3
		common_oral_4 = set4
		common_oral_5 = set5
	elseif csnum == 11
		common_agg_missionary_1 = set1
		common_agg_missionary_2 = set2
		common_agg_missionary_3 = set3
		common_agg_missionary_4 = set4
		common_agg_missionary_5 = set5
	elseif csnum == 12
		common_missionary_1 = set1
		common_missionary_2 = set2
		common_missionary_3 = set3
		common_missionary_4 = set4
		common_missionary_5 = set5
	elseif csnum == 13
		common_agg_anal_1 = set1
		common_agg_anal_2 = set2
		common_agg_anal_3 = set3
		common_agg_anal_4 = set4
		common_agg_anal_5 = set5
	elseif csnum == 14
		common_anal_1 = set1
		common_anal_2 = set2
		common_anal_3 = set3
		common_anal_4 = set4
		common_anal_5 = set5
	elseif csnum == 15
		common_agg_oral_s_1= set1
		common_agg_oral_s_2= set2
		common_agg_oral_s_3= set3
		common_agg_oral_s_4= set4
		common_agg_oral_s_5= set5
	elseif csnum == 16
		common_oral_s_1= set1
		common_oral_s_2= set2
		common_oral_s_3= set3
		common_oral_s_4= set4
		common_oral_s_5= set5
	elseif csnum == 17
		common_agg_anal_s_1= set1
		common_agg_anal_s_2= set2
		common_agg_anal_s_3= set3
		common_agg_anal_s_4= set4
		common_agg_anal_s_5= set5
	elseif csnum == 18
		common_anal_s_1= set1
		common_anal_s_2= set2
		common_anal_s_3= set3
		common_anal_s_4= set4
		common_anal_s_5= set5
	elseif csnum == 19
		common_agg_missionary_s_1= set1
		common_agg_missionary_s_2= set2
		common_agg_missionary_s_3= set3
		common_agg_missionary_s_4= set4
		common_agg_missionary_s_5= set5
	elseif csnum == 20
		common_missionary_s_1= set1
		common_missionary_s_2= set2
		common_missionary_s_3= set3
		common_missionary_s_4= set4
		common_missionary_s_5= set5
	else
		debug.trace("@  intoCommonSetByNum - 指定の汎用セット名が不正です")
	endIf
endfunction

; 「字幕を表示しない」設定にした場合、該当の汎用セットを空にする
Function intoCSempty(int csnum)
	string[] empty
	intoSSetToCS(csnum, empty, empty, empty, empty, empty)
EndFunction

;字幕のセット名を汎用字幕のセット名配列に格納する
Function setNameCSname(int situation, string name)
	common_setname[situation] = name
EndFunction

;シチュエーション番号から現在の字幕セット名を取得する
string Function getNameCSname(int situation)
	return common_setname[situation]
EndFunction

;字幕が非表示設定かどうかを調べる
bool Function isCSdisable(int situation)
	If common_setname[situation] == "$SMENU_disble"
		return true
	else
		return false
	endIf
EndFunction

;シチュエーション番号と指定のステージ数から登録されている汎用の字幕セットを返す
string[] Function getCSsetBySituation(int situation, int stage)
	If situation == 0
		If stage == 1
			return common_creature_1
		elseIf stage == 2
			return common_creature_2
		elseIf stage == 3
			return common_creature_3
		elseIf stage == 4
			return common_creature_4
		elseIf stage == 5
			return common_creature_5
		endIf
	elseif situation == 1
		If stage == 1
			return common_69_1
		elseIf stage == 2
			return common_69_2
		elseIf stage == 3
			return common_69_3
		elseIf stage == 4
			return common_69_4
		elseIf stage == 5
			return common_69_5
		endIf
	elseif situation == 2
		If stage == 1
			return common_handjob_1
		elseIf stage == 2
			return common_handjob_2
		elseIf stage == 3
			return common_handjob_3
		elseIf stage == 4
			return common_handjob_4
		elseIf stage == 5
			return common_handjob_5
		endIf
	elseif situation == 3
		If stage == 1
			return common_footjob_1
		elseIf stage == 2
			return common_footjob_2
		elseIf stage == 3
			return common_footjob_3
		elseIf stage == 4
			return common_footjob_4
		elseIf stage == 5
			return common_footjob_5
		endIf
	elseif situation == 4
		If stage == 1
			return common_boobjob_1
		elseIf stage == 2
			return common_boobjob_2
		elseIf stage == 3
			return common_boobjob_3
		elseIf stage == 4
			return common_boobjob_4
		elseIf stage == 5
			return common_boobjob_5
		endIf
	elseif situation == 5
		If stage == 1
			return common_masturbation_1
		elseIf stage == 2
			return common_masturbation_2
		elseIf stage == 3
			return common_masturbation_3
		elseIf stage == 4
			return common_masturbation_4
		elseIf stage == 5
			return common_masturbation_5
		endIf
	elseif situation == 6
		If stage == 1
			return common_fisting_1
		elseIf stage == 2
			return common_fisting_2
		elseIf stage == 3
			return common_fisting_3
		elseIf stage == 4
			return common_fisting_4
		elseIf stage == 5
			return common_fisting_5
		endIf
	elseif situation == 7
		If stage == 1
			return common_cowgirl_1
		elseIf stage == 2
			return common_cowgirl_2
		elseIf stage == 3
			return common_cowgirl_3
		elseIf stage == 4
			return common_cowgirl_4
		elseIf stage == 5
			return common_cowgirl_5
		endIf
	elseif situation == 8
		If stage == 1
			return common_foreplay_1
		elseIf stage == 2
			return common_foreplay_2
		elseIf stage == 3
			return common_foreplay_3
		elseIf stage == 4
			return common_foreplay_4
		elseIf stage == 5
			return common_foreplay_5
		endIf
	elseif situation == 9
		If stage == 1
			return common_agg_oral_1
		elseIf stage == 2
			return common_agg_oral_2
		elseIf stage == 3
			return common_agg_oral_3
		elseIf stage == 4
			return common_agg_oral_4
		elseIf stage == 5
			return common_agg_oral_5
		endIf
	elseif situation == 10
		If stage == 1
			return common_oral_1
		elseIf stage == 2
			return common_oral_2
		elseIf stage == 3
			return common_oral_3
		elseIf stage == 4
			return common_oral_4
		elseIf stage == 5
			return common_oral_5
		endIf
	elseif situation == 11
		If stage == 1
			return common_agg_missionary_1
		elseIf stage == 2
			return common_agg_missionary_2
		elseIf stage == 3
			return common_agg_missionary_3
		elseIf stage == 4
			return common_agg_missionary_4
		elseIf stage == 5
			return common_agg_missionary_5
		endIf
	elseif situation == 12
		If stage == 1
			return common_missionary_1
		elseIf stage == 2
			return common_missionary_2
		elseIf stage == 3
			return common_missionary_3
		elseIf stage == 4
			return common_missionary_4
		elseIf stage == 5
			return common_missionary_5
		endIf
	elseif situation == 13
		If stage == 1
			return common_agg_anal_1
		elseIf stage == 2
			return common_agg_anal_2
		elseIf stage == 3
			return common_agg_anal_3
		elseIf stage == 4
			return common_agg_anal_4
		elseIf stage == 5
			return common_agg_anal_5
		endIf
	elseif situation == 14
		If stage == 1
			return common_anal_1
		elseIf stage == 2
			return common_anal_2
		elseIf stage == 3
			return common_anal_3
		elseIf stage == 4
			return common_anal_4
		elseIf stage == 5
			return common_anal_5
		endIf
	elseif situation == 15
		If stage == 1
			return common_agg_oral_s_1
		elseIf stage == 2
			return common_agg_oral_s_2
		elseIf stage == 3
			return common_agg_oral_s_3
		elseIf stage == 4
			return common_agg_oral_s_4
		elseIf stage == 5
			return common_agg_oral_s_5
		endIf
	elseif situation == 16
		If stage == 1
			return common_oral_s_1
		elseIf stage == 2
			return common_oral_s_2
		elseIf stage == 3
			return common_oral_s_3
		elseIf stage == 4
			return common_oral_s_4
		elseIf stage == 5
			return common_oral_s_5
		endIf
	elseif situation == 17
		If stage == 1
			return common_agg_anal_s_1
		elseIf stage == 2
			return common_agg_anal_s_2
		elseIf stage == 3
			return common_agg_anal_s_3
		elseIf stage == 4
			return common_agg_anal_s_4
		elseIf stage == 5
			return common_agg_anal_s_5
		endIf
	elseif situation == 18
		If stage == 1
			return common_anal_s_1
		elseIf stage == 2
			return common_anal_s_2
		elseIf stage == 3
			return common_anal_s_3
		elseIf stage == 4
			return common_anal_s_4
		elseIf stage == 5
			return common_anal_s_5
		endIf
	elseif situation == 19
		If stage == 1
			return common_agg_missionary_s_1
		elseIf stage == 2
			return common_agg_missionary_s_2
		elseIf stage == 3
			return common_agg_missionary_s_3
		elseIf stage == 4
			return common_agg_missionary_s_4
		elseIf stage == 5
			return common_agg_missionary_s_5
		endIf
	elseif situation == 20
		If stage == 1
			return common_missionary_s_1
		elseIf stage == 2
			return common_missionary_s_2
		elseIf stage == 3
			return common_missionary_s_3
		elseIf stage == 4
			return common_missionary_s_4
		elseIf stage == 5
			return common_missionary_s_5
		endIf
	else
		debug.trace("@  getCSsetBySituation - 指定の汎用セット名が不正です")
	endIf
EndFunction

;/===========================================================
	【JSONから字幕セットを取得する処理】
/;
;---------------------------------------------------------------------------
; ファイルパス（filePath）の末尾数字startnumからmaxnumのファイルの有無を調べ総数をカウントする
int Function importJSONfileCount(int startnum, int maxnum, string filePath)
	int i = startnum
	int count = 0
	while (i < maxnum + 1)
		string file = filePath + i + ".json"
		If JsonUtil.Load(file)
			count += 1
		endIf
		i += 1
	endwhile
	return count
EndFunction
;ファイルパス（filePath）の末尾数字startnum-maxnumのファイルからセット名とファイル番号を指定の配列に取得する
Function importSSetToNameAndIndex(int startnum, int maxnum, string filePath, string[] names, int[] ids)
	int i = startnum
	int r = 0
	while (i < maxnum + 1)
		string file = filePath + i + ".json"
		If JsonUtil.Load(file)
			names[r] = JsonUtil.StringListGet(file, "import_name", 0)
			ids[r] = i
			r += 1
		endIf
		i += 1
	endwhile
EndFunction
;インポート元の番号の字幕ファイルから字幕セットの名前を引き出す（ver2.1）
String Function getSetnameImportNum(int importnum)
	If importnum == 0
		return "$SMENU_disble"
	else
		int index = IS_index.find(importnum)
		; debug.trace("# importSet" + importnum + "のindexは" + index)
		If index >= 0
			return IS_name[index]
		else
			; debug.trace("# 指定のインポート番号のセット名は登録されていません")
			return "$SMENU_disble"
		endif
	endif
EndFunction
; ファイルの有無に関わらず1-30番までのファイルの字幕セットを取得する
bool Function setImportSSet()
	IS1_1 = importSSet(1,1)
	IS1_2 = importSSet(1,2)
	IS1_3 = importSSet(1,3)
	IS1_4 = importSSet(1,4)
	IS1_5 = importSSet(1,5)
	IS2_1 = importSSet(2,1)
	IS2_2 = importSSet(2,2)
	IS2_3 = importSSet(2,3)
	IS2_4 = importSSet(2,4)
	IS2_5 = importSSet(2,5)
	IS3_1 = importSSet(3,1)
	IS3_2 = importSSet(3,2)
	IS3_3 = importSSet(3,3)
	IS3_4 = importSSet(3,4)
	IS3_5 = importSSet(3,5)
	IS4_1 = importSSet(4,1)
	IS4_2 = importSSet(4,2)
	IS4_3 = importSSet(4,3)
	IS4_4 = importSSet(4,4)
	IS4_5 = importSSet(4,5)
	IS5_1 = importSSet(5,1)
	IS5_2 = importSSet(5,2)
	IS5_3 = importSSet(5,3)
	IS5_4 = importSSet(5,4)
	IS5_5 = importSSet(5,5)
	IS6_1 = importSSet(6,1)
	IS6_2 = importSSet(6,2)
	IS6_3 = importSSet(6,3)
	IS6_4 = importSSet(6,4)
	IS6_5 = importSSet(6,5)
	IS7_1 = importSSet(7,1)
	IS7_2 = importSSet(7,2)
	IS7_3 = importSSet(7,3)
	IS7_4 = importSSet(7,4)
	IS7_5 = importSSet(7,5)
	IS8_1 = importSSet(8,1)
	IS8_2 = importSSet(8,2)
	IS8_3 = importSSet(8,3)
	IS8_4 = importSSet(8,4)
	IS8_5 = importSSet(8,5)
	IS9_1 = importSSet(9,1)
	IS9_2 = importSSet(9,2)
	IS9_3 = importSSet(9,3)
	IS9_4 = importSSet(9,4)
	IS9_5 = importSSet(9,5)
	IS10_1 = importSSet(10,1)
	IS10_2 = importSSet(10,2)
	IS10_3 = importSSet(10,3)
	IS10_4 = importSSet(10,4)
	IS10_5 = importSSet(10,5)
	IS11_1 = importSSet(11,1)
	IS11_2 = importSSet(11,2)
	IS11_3 = importSSet(11,3)
	IS11_4 = importSSet(11,4)
	IS11_5 = importSSet(11,5)
	IS12_1 = importSSet(12,1)
	IS12_2 = importSSet(12,2)
	IS12_3 = importSSet(12,3)
	IS12_4 = importSSet(12,4)
	IS12_5 = importSSet(12,5)
	IS13_1 = importSSet(13,1)
	IS13_2 = importSSet(13,2)
	IS13_3 = importSSet(13,3)
	IS13_4 = importSSet(13,4)
	IS13_5 = importSSet(13,5)
	IS14_1 = importSSet(14,1)
	IS14_2 = importSSet(14,2)
	IS14_3 = importSSet(14,3)
	IS14_4 = importSSet(14,4)
	IS14_5 = importSSet(14,5)
	IS15_1 = importSSet(15,1)
	IS15_2 = importSSet(15,2)
	IS15_3 = importSSet(15,3)
	IS15_4 = importSSet(15,4)
	IS15_5 = importSSet(15,5)
	IS16_1 = importSSet(16,1)
	IS16_2 = importSSet(16,2)
	IS16_3 = importSSet(16,3)
	IS16_4 = importSSet(16,4)
	IS16_5 = importSSet(16,5)
	IS17_1 = importSSet(17,1)
	IS17_2 = importSSet(17,2)
	IS17_3 = importSSet(17,3)
	IS17_4 = importSSet(17,4)
	IS17_5 = importSSet(17,5)
	IS18_1 = importSSet(18,1)
	IS18_2 = importSSet(18,2)
	IS18_3 = importSSet(18,3)
	IS18_4 = importSSet(18,4)
	IS18_5 = importSSet(18,5)
	IS19_1 = importSSet(19,1)
	IS19_2 = importSSet(19,2)
	IS19_3 = importSSet(19,3)
	IS19_4 = importSSet(19,4)
	IS19_5 = importSSet(19,5)
	IS20_1 = importSSet(20,1)
	IS20_2 = importSSet(20,2)
	IS20_3 = importSSet(20,3)
	IS20_4 = importSSet(20,4)
	IS20_5 = importSSet(20,5)
	IS21_1 = importSSet(21,1)
	IS21_2 = importSSet(21,2)
	IS21_3 = importSSet(21,3)
	IS21_4 = importSSet(21,4)
	IS21_5 = importSSet(21,5)
	IS22_1 = importSSet(22,1)
	IS22_2 = importSSet(22,2)
	IS22_3 = importSSet(22,3)
	IS22_4 = importSSet(22,4)
	IS22_5 = importSSet(22,5)
	IS23_1 = importSSet(23,1)
	IS23_2 = importSSet(23,2)
	IS23_3 = importSSet(23,3)
	IS23_4 = importSSet(23,4)
	IS23_5 = importSSet(23,5)
	IS24_1 = importSSet(24,1)
	IS24_2 = importSSet(24,2)
	IS24_3 = importSSet(24,3)
	IS24_4 = importSSet(24,4)
	IS24_5 = importSSet(24,5)
	IS25_1 = importSSet(25,1)
	IS25_2 = importSSet(25,2)
	IS25_3 = importSSet(25,3)
	IS25_4 = importSSet(25,4)
	IS25_5 = importSSet(25,5)
	IS26_1 = importSSet(26,1)
	IS26_2 = importSSet(26,2)
	IS26_3 = importSSet(26,3)
	IS26_4 = importSSet(26,4)
	IS26_5 = importSSet(26,5)
	IS27_1 = importSSet(27,1)
	IS27_2 = importSSet(27,2)
	IS27_3 = importSSet(27,3)
	IS27_4 = importSSet(27,4)
	IS27_5 = importSSet(27,5)
	IS28_1 = importSSet(28,1)
	IS28_2 = importSSet(28,2)
	IS28_3 = importSSet(28,3)
	IS28_4 = importSSet(28,4)
	IS28_5 = importSSet(28,5)
	IS29_1 = importSSet(29,1)
	IS29_2 = importSSet(29,2)
	IS29_3 = importSSet(29,3)
	IS29_4 = importSSet(29,4)
	IS29_5 = importSSet(29,5)
	IS30_1 = importSSet(30,1)
	IS30_2 = importSSet(30,2)
	IS30_3 = importSSet(30,3)
	IS30_4 = importSSet(30,4)
	IS30_5 = importSSet(30,5)
	return true
EndFunction
;指定の番号（num）のファイルから、指定ステージの字幕テキストを配列として取得する
string [] Function importSSet(int num, int stage)
	return importSSetFromFile(num, stage, "../sexlabSubtitles/importSet")
EndFunction
string [] Function importSSetFromFile(int num, int stage, string filePath)
	string file = filePath + num + ".json"
	If !JsonUtil.Load(file)
		return sslUtility.EmptyStringArray()
	else
		If stage == 1
			string stagekey = "import_stage1"
			int len = JsonUtil.StringListFind(file, stagekey, endcode)
			; debug.trace("# importSet" + num + "のstage1のセリフは" + len + "です")
			string[] isset = PapyrusUtil.StringArray(len)
			int i = 0
			while (i < len)
				isset[i] = JsonUtil.StringListGet(file, stagekey, i)
				i += 1
			endwhile
			; debug.trace("# stage1は" + isset)
			return isset
		elseif stage == 2
			string stagekey = "import_stage2"
			int len = JsonUtil.StringListFind(file, stagekey, endcode)
			; debug.trace("# importSet" + num + "のstage2のセリフは" + len + "です")
			string[] isset = PapyrusUtil.StringArray(len)
			int i = 0
			while (i < len)
				isset[i] = JsonUtil.StringListGet(file, stagekey, i)
				i += 1
			endwhile
			return isset
		elseif stage == 3
			string stagekey = "import_stage3"
			int len = JsonUtil.StringListFind(file, stagekey, endcode)
			; debug.trace("# importSet" + num + "のstage3のセリフは" + len + "です")
			string[] isset = PapyrusUtil.StringArray(len)
			int i = 0
			while (i < len)
				isset[i] = JsonUtil.StringListGet(file, stagekey, i)
				i += 1
			endwhile
			return isset
		elseif stage == 4
			string stagekey = "import_stage4"
			int len = JsonUtil.StringListFind(file, stagekey, endcode)
			; debug.trace("# importSet" + num + "のstage4のセリフは" + len + "です")
			string[] isset = PapyrusUtil.StringArray(len)
			int i = 0
			while (i < len)
				isset[i] = JsonUtil.StringListGet(file, stagekey, i)
				i += 1
			endwhile
			return isset
		elseif stage == 5
			string stagekey = "import_stage5"
			int len = JsonUtil.StringListFind(file, stagekey, endcode)
			; debug.trace("# importSet" + num + "のstage5のセリフは" + len + "です")
			string[] isset = PapyrusUtil.StringArray(len)
			int i = 0
			while (i < len)
				isset[i] = JsonUtil.StringListGet(file, stagekey, i)
				i += 1
			endwhile
			return isset
		else
			debug.trace("@ [Sexlab Subtitles] - importSSet - stageの指定が不正です")
		endif
		; debug.trace("# importSet" + num + "のインポートが完了しました")
	endif
EndFunction
;---------------------------------------------------------------------------
; 指定のインデックス番号（num）の指定ステージの字幕セットを取得する
string[] Function getSSetByIndex(int num, int stage)
	int index = IS_index[num]
	If index == 1
		If stage == 1
			return IS1_1
		elseif stage == 2
			return IS1_2
		elseif stage == 3
			return IS1_3
		elseif stage == 4
			return IS1_4
		elseif stage == 5
			return IS1_5
		endif
	elseif index == 2
		If stage == 1
			return IS2_1
		elseif stage == 2
			return IS2_2
		elseif stage == 3
			return IS2_3
		elseif stage == 4
			return IS2_4
		elseif stage == 5
			return IS2_5
		endif
	elseif index == 3
		If stage == 1
			return IS3_1
		elseif stage == 2
			return IS3_2
		elseif stage == 3
			return IS3_3
		elseif stage == 4
			return IS3_4
		elseif stage == 5
			return IS3_5
		endif
	elseif index == 4
		If stage == 1
			return IS4_1
		elseif stage == 2
			return IS4_2
		elseif stage == 3
			return IS4_3
		elseif stage == 4
			return IS4_4
		elseif stage == 5
			return IS4_5
		endif
	elseif index == 5
		If stage == 1
			return IS5_1
		elseif stage == 2
			return IS5_2
		elseif stage == 3
			return IS5_3
		elseif stage == 4
			return IS5_4
		elseif stage == 5
			return IS5_5
		endif
	elseif index == 6
		If stage == 1
			return IS6_1
		elseif stage == 2
			return IS6_2
		elseif stage == 3
			return IS6_3
		elseif stage == 4
			return IS6_4
		elseif stage == 5
			return IS6_5
		endif
	elseif index == 7
		If stage == 1
			return IS7_1
		elseif stage == 2
			return IS7_2
		elseif stage == 3
			return IS7_3
		elseif stage == 4
			return IS7_4
		elseif stage == 5
			return IS7_5
		endif
	elseif index == 8
		If stage == 1
			return IS8_1
		elseif stage == 2
			return IS8_2
		elseif stage == 3
			return IS8_3
		elseif stage == 4
			return IS8_4
		elseif stage == 5
			return IS8_5
		endif
	elseif index == 9
		If stage == 1
			return IS9_1
		elseif stage == 2
			return IS9_2
		elseif stage == 3
			return IS9_3
		elseif stage == 4
			return IS9_4
		elseif stage == 5
			return IS9_5
		endif
	elseif index == 10
		If stage == 1
			return IS10_1
		elseif stage == 2
			return IS10_2
		elseif stage == 3
			return IS10_3
		elseif stage == 4
			return IS10_4
		elseif stage == 5
			return IS10_5
		endif
	elseif index == 11
		If stage == 1
			return IS11_1
		elseif stage == 2
			return IS11_2
		elseif stage == 3
			return IS11_3
		elseif stage == 4
			return IS11_4
		elseif stage == 5
			return IS11_5
		endif
	elseif index == 12
		If stage == 1
			return IS12_1
		elseif stage == 2
			return IS12_2
		elseif stage == 3
			return IS12_3
		elseif stage == 4
			return IS12_4
		elseif stage == 5
			return IS12_5
		endif
	elseif index == 13
		If stage == 1
			return IS13_1
		elseif stage == 2
			return IS13_2
		elseif stage == 3
			return IS13_3
		elseif stage == 4
			return IS13_4
		elseif stage == 5
			return IS13_5
		endif
	elseif index == 14
		If stage == 1
			return IS14_1
		elseif stage == 2
			return IS14_2
		elseif stage == 3
			return IS14_3
		elseif stage == 4
			return IS14_4
		elseif stage == 5
			return IS14_5
		endif
	elseif index == 15
		If stage == 1
			return IS15_1
		elseif stage == 2
			return IS15_2
		elseif stage == 3
			return IS15_3
		elseif stage == 4
			return IS15_4
		elseif stage == 5
			return IS15_5
		endif
	elseif index == 16
		If stage == 1
			return IS16_1
		elseif stage == 2
			return IS16_2
		elseif stage == 3
			return IS16_3
		elseif stage == 4
			return IS16_4
		elseif stage == 5
			return IS16_5
		endif
	elseif index == 17
		If stage == 1
			return IS17_1
		elseif stage == 2
			return IS17_2
		elseif stage == 3
			return IS17_3
		elseif stage == 4
			return IS17_4
		elseif stage == 5
			return IS17_5
		endif
	elseif index == 18
		If stage == 1
			return IS18_1
		elseif stage == 2
			return IS18_2
		elseif stage == 3
			return IS18_3
		elseif stage == 4
			return IS18_4
		elseif stage == 5
			return IS18_5
		endif
	elseif index == 19
		If stage == 1
			return IS19_1
		elseif stage == 2
			return IS19_2
		elseif stage == 3
			return IS19_3
		elseif stage == 4
			return IS19_4
		elseif stage == 5
			return IS19_5
		endif
	elseif index == 20
		If stage == 1
			return IS20_1
		elseif stage == 2
			return IS20_2
		elseif stage == 3
			return IS20_3
		elseif stage == 4
			return IS20_4
		elseif stage == 5
			return IS20_5
		endif
	elseif index == 21
		If stage == 1
			return IS21_1
		elseif stage == 2
			return IS21_2
		elseif stage == 3
			return IS21_3
		elseif stage == 4
			return IS21_4
		elseif stage == 5
			return IS21_5
		endif
	elseif index == 22
		If stage == 1
			return IS22_1
		elseif stage == 2
			return IS22_2
		elseif stage == 3
			return IS22_3
		elseif stage == 4
			return IS22_4
		elseif stage == 5
			return IS22_5
		endif
	elseif index == 23
		If stage == 1
			return IS23_1
		elseif stage == 2
			return IS23_2
		elseif stage == 3
			return IS23_3
		elseif stage == 4
			return IS23_4
		elseif stage == 5
			return IS23_5
		endif
	elseif index == 24
		If stage == 1
			return IS24_1
		elseif stage == 2
			return IS24_2
		elseif stage == 3
			return IS24_3
		elseif stage == 4
			return IS24_4
		elseif stage == 5
			return IS24_5
		endif
	elseif index == 25
		If stage == 1
			return IS25_1
		elseif stage == 2
			return IS25_2
		elseif stage == 3
			return IS25_3
		elseif stage == 4
			return IS25_4
		elseif stage == 5
			return IS25_5
		endif
	elseif index == 26
		If stage == 1
			return IS26_1
		elseif stage == 2
			return IS26_2
		elseif stage == 3
			return IS26_3
		elseif stage == 4
			return IS26_4
		elseif stage == 5
			return IS26_5
		endif
	elseif index == 27
		If stage == 1
			return IS27_1
		elseif stage == 2
			return IS27_2
		elseif stage == 3
			return IS27_3
		elseif stage == 4
			return IS27_4
		elseif stage == 5
			return IS27_5
		endif
	elseif index == 28
		If stage == 1
			return IS28_1
		elseif stage == 2
			return IS28_2
		elseif stage == 3
			return IS28_3
		elseif stage == 4
			return IS28_4
		elseif stage == 5
			return IS28_5
		endif
	elseif index == 29
		If stage == 1
			return IS29_1
		elseif stage == 2
			return IS29_2
		elseif stage == 3
			return IS29_3
		elseif stage == 4
			return IS29_4
		elseif stage == 5
			return IS29_5
		endif
	elseif index == 30
		If stage == 1
			return IS30_1
		elseif stage == 2
			return IS30_2
		elseif stage == 3
			return IS30_3
		elseif stage == 4
			return IS30_4
		elseif stage == 5
			return IS30_5
		endif
	endif
EndFunction
; 指定のインポート元（index）の指定ステージの字幕セットを取得する
string[] Function getSSetByIndex2(int index, int stage)
	If index == 1
		If stage == 1
			return IS1_1
		elseif stage == 2
			return IS1_2
		elseif stage == 3
			return IS1_3
		elseif stage == 4
			return IS1_4
		elseif stage == 5
			return IS1_5
		endif
	elseif index == 2
		If stage == 1
			return IS2_1
		elseif stage == 2
			return IS2_2
		elseif stage == 3
			return IS2_3
		elseif stage == 4
			return IS2_4
		elseif stage == 5
			return IS2_5
		endif
	elseif index == 3
		If stage == 1
			return IS3_1
		elseif stage == 2
			return IS3_2
		elseif stage == 3
			return IS3_3
		elseif stage == 4
			return IS3_4
		elseif stage == 5
			return IS3_5
		endif
	elseif index == 4
		If stage == 1
			return IS4_1
		elseif stage == 2
			return IS4_2
		elseif stage == 3
			return IS4_3
		elseif stage == 4
			return IS4_4
		elseif stage == 5
			return IS4_5
		endif
	elseif index == 5
		If stage == 1
			return IS5_1
		elseif stage == 2
			return IS5_2
		elseif stage == 3
			return IS5_3
		elseif stage == 4
			return IS5_4
		elseif stage == 5
			return IS5_5
		endif
	elseif index == 6
		If stage == 1
			return IS6_1
		elseif stage == 2
			return IS6_2
		elseif stage == 3
			return IS6_3
		elseif stage == 4
			return IS6_4
		elseif stage == 5
			return IS6_5
		endif
	elseif index == 7
		If stage == 1
			return IS7_1
		elseif stage == 2
			return IS7_2
		elseif stage == 3
			return IS7_3
		elseif stage == 4
			return IS7_4
		elseif stage == 5
			return IS7_5
		endif
	elseif index == 8
		If stage == 1
			return IS8_1
		elseif stage == 2
			return IS8_2
		elseif stage == 3
			return IS8_3
		elseif stage == 4
			return IS8_4
		elseif stage == 5
			return IS8_5
		endif
	elseif index == 9
		If stage == 1
			return IS9_1
		elseif stage == 2
			return IS9_2
		elseif stage == 3
			return IS9_3
		elseif stage == 4
			return IS9_4
		elseif stage == 5
			return IS9_5
		endif
	elseif index == 10
		If stage == 1
			return IS10_1
		elseif stage == 2
			return IS10_2
		elseif stage == 3
			return IS10_3
		elseif stage == 4
			return IS10_4
		elseif stage == 5
			return IS10_5
		endif
	elseif index == 11
		If stage == 1
			return IS11_1
		elseif stage == 2
			return IS11_2
		elseif stage == 3
			return IS11_3
		elseif stage == 4
			return IS11_4
		elseif stage == 5
			return IS11_5
		endif
	elseif index == 12
		If stage == 1
			return IS12_1
		elseif stage == 2
			return IS12_2
		elseif stage == 3
			return IS12_3
		elseif stage == 4
			return IS12_4
		elseif stage == 5
			return IS12_5
		endif
	elseif index == 13
		If stage == 1
			return IS13_1
		elseif stage == 2
			return IS13_2
		elseif stage == 3
			return IS13_3
		elseif stage == 4
			return IS13_4
		elseif stage == 5
			return IS13_5
		endif
	elseif index == 14
		If stage == 1
			return IS14_1
		elseif stage == 2
			return IS14_2
		elseif stage == 3
			return IS14_3
		elseif stage == 4
			return IS14_4
		elseif stage == 5
			return IS14_5
		endif
	elseif index == 15
		If stage == 1
			return IS15_1
		elseif stage == 2
			return IS15_2
		elseif stage == 3
			return IS15_3
		elseif stage == 4
			return IS15_4
		elseif stage == 5
			return IS15_5
		endif
	elseif index == 16
		If stage == 1
			return IS16_1
		elseif stage == 2
			return IS16_2
		elseif stage == 3
			return IS16_3
		elseif stage == 4
			return IS16_4
		elseif stage == 5
			return IS16_5
		endif
	elseif index == 17
		If stage == 1
			return IS17_1
		elseif stage == 2
			return IS17_2
		elseif stage == 3
			return IS17_3
		elseif stage == 4
			return IS17_4
		elseif stage == 5
			return IS17_5
		endif
	elseif index == 18
		If stage == 1
			return IS18_1
		elseif stage == 2
			return IS18_2
		elseif stage == 3
			return IS18_3
		elseif stage == 4
			return IS18_4
		elseif stage == 5
			return IS18_5
		endif
	elseif index == 19
		If stage == 1
			return IS19_1
		elseif stage == 2
			return IS19_2
		elseif stage == 3
			return IS19_3
		elseif stage == 4
			return IS19_4
		elseif stage == 5
			return IS19_5
		endif
	elseif index == 20
		If stage == 1
			return IS20_1
		elseif stage == 2
			return IS20_2
		elseif stage == 3
			return IS20_3
		elseif stage == 4
			return IS20_4
		elseif stage == 5
			return IS20_5
		endif
	elseif index == 21
		If stage == 1
			return IS21_1
		elseif stage == 2
			return IS21_2
		elseif stage == 3
			return IS21_3
		elseif stage == 4
			return IS21_4
		elseif stage == 5
			return IS21_5
		endif
	elseif index == 22
		If stage == 1
			return IS22_1
		elseif stage == 2
			return IS22_2
		elseif stage == 3
			return IS22_3
		elseif stage == 4
			return IS22_4
		elseif stage == 5
			return IS22_5
		endif
	elseif index == 23
		If stage == 1
			return IS23_1
		elseif stage == 2
			return IS23_2
		elseif stage == 3
			return IS23_3
		elseif stage == 4
			return IS23_4
		elseif stage == 5
			return IS23_5
		endif
	elseif index == 24
		If stage == 1
			return IS24_1
		elseif stage == 2
			return IS24_2
		elseif stage == 3
			return IS24_3
		elseif stage == 4
			return IS24_4
		elseif stage == 5
			return IS24_5
		endif
	elseif index == 25
		If stage == 1
			return IS25_1
		elseif stage == 2
			return IS25_2
		elseif stage == 3
			return IS25_3
		elseif stage == 4
			return IS25_4
		elseif stage == 5
			return IS25_5
		endif
	elseif index == 26
		If stage == 1
			return IS26_1
		elseif stage == 2
			return IS26_2
		elseif stage == 3
			return IS26_3
		elseif stage == 4
			return IS26_4
		elseif stage == 5
			return IS26_5
		endif
	elseif index == 27
		If stage == 1
			return IS27_1
		elseif stage == 2
			return IS27_2
		elseif stage == 3
			return IS27_3
		elseif stage == 4
			return IS27_4
		elseif stage == 5
			return IS27_5
		endif
	elseif index == 28
		If stage == 1
			return IS28_1
		elseif stage == 2
			return IS28_2
		elseif stage == 3
			return IS28_3
		elseif stage == 4
			return IS28_4
		elseif stage == 5
			return IS28_5
		endif
	elseif index == 29
		If stage == 1
			return IS29_1
		elseif stage == 2
			return IS29_2
		elseif stage == 3
			return IS29_3
		elseif stage == 4
			return IS29_4
		elseif stage == 5
			return IS29_5
		endif
	elseif index == 30
		If stage == 1
			return IS30_1
		elseif stage == 2
			return IS30_2
		elseif stage == 3
			return IS30_3
		elseif stage == 4
			return IS30_4
		elseif stage == 5
			return IS30_5
		endif

	endif
EndFunction

; インポート用字幕セット
	string[] IS1_1
	string[] IS1_2
	string[] IS1_3
	string[] IS1_4
	string[] IS1_5
	string[] IS2_1
	string[] IS2_2
	string[] IS2_3
	string[] IS2_4
	string[] IS2_5
	string[] IS3_1
	string[] IS3_2
	string[] IS3_3
	string[] IS3_4
	string[] IS3_5
	string[] IS4_1
	string[] IS4_2
	string[] IS4_3
	string[] IS4_4
	string[] IS4_5
	string[] IS5_1
	string[] IS5_2
	string[] IS5_3
	string[] IS5_4
	string[] IS5_5
	string[] IS6_1
	string[] IS6_2
	string[] IS6_3
	string[] IS6_4
	string[] IS6_5
	string[] IS7_1
	string[] IS7_2
	string[] IS7_3
	string[] IS7_4
	string[] IS7_5
	string[] IS8_1
	string[] IS8_2
	string[] IS8_3
	string[] IS8_4
	string[] IS8_5
	string[] IS9_1
	string[] IS9_2
	string[] IS9_3
	string[] IS9_4
	string[] IS9_5
	string[] IS10_1
	string[] IS10_2
	string[] IS10_3
	string[] IS10_4
	string[] IS10_5
	string[] IS11_1
	string[] IS11_2
	string[] IS11_3
	string[] IS11_4
	string[] IS11_5
	string[] IS12_1
	string[] IS12_2
	string[] IS12_3
	string[] IS12_4
	string[] IS12_5
	string[] IS13_1
	string[] IS13_2
	string[] IS13_3
	string[] IS13_4
	string[] IS13_5
	string[] IS14_1
	string[] IS14_2
	string[] IS14_3
	string[] IS14_4
	string[] IS14_5
	string[] IS15_1
	string[] IS15_2
	string[] IS15_3
	string[] IS15_4
	string[] IS15_5
	string[] IS16_1
	string[] IS16_2
	string[] IS16_3
	string[] IS16_4
	string[] IS16_5
	string[] IS17_1
	string[] IS17_2
	string[] IS17_3
	string[] IS17_4
	string[] IS17_5
	string[] IS18_1
	string[] IS18_2
	string[] IS18_3
	string[] IS18_4
	string[] IS18_5
	string[] IS19_1
	string[] IS19_2
	string[] IS19_3
	string[] IS19_4
	string[] IS19_5
	string[] IS20_1
	string[] IS20_2
	string[] IS20_3
	string[] IS20_4
	string[] IS20_5
	string[] IS21_1
	string[] IS21_2
	string[] IS21_3
	string[] IS21_4
	string[] IS21_5
	string[] IS22_1
	string[] IS22_2
	string[] IS22_3
	string[] IS22_4
	string[] IS22_5
	string[] IS23_1
	string[] IS23_2
	string[] IS23_3
	string[] IS23_4
	string[] IS23_5
	string[] IS24_1
	string[] IS24_2
	string[] IS24_3
	string[] IS24_4
	string[] IS24_5
	string[] IS25_1
	string[] IS25_2
	string[] IS25_3
	string[] IS25_4
	string[] IS25_5
	string[] IS26_1
	string[] IS26_2
	string[] IS26_3
	string[] IS26_4
	string[] IS26_5
	string[] IS27_1
	string[] IS27_2
	string[] IS27_3
	string[] IS27_4
	string[] IS27_5
	string[] IS28_1
	string[] IS28_2
	string[] IS28_3
	string[] IS28_4
	string[] IS28_5
	string[] IS29_1
	string[] IS29_2
	string[] IS29_3
	string[] IS29_4
	string[] IS29_5
	string[] IS30_1
	string[] IS30_2
	string[] IS30_3
	string[] IS30_4
	string[] IS30_5
