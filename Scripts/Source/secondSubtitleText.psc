Scriptname secondSubtitleText extends Quest
{sexLab用 汎用字幕コントロールスクリプト}

SexLabFramework Property SexLab auto ; SexLab様
secondSubtitleTextHUD Property SS auto ; 字幕HUD
SubtitleSetSetting Property SSetting auto ; 字幕セットのインポート、汎用字幕の設定など

; 汎用字幕表示の状態プロパティ（外部からのアクセス用）
bool Property isRunningSubtitle auto; 字幕表示しているSexシーンが現在稼働中かどうか
int Property currentStage auto; 現在稼働中のアニメーションのステージ
int Property maxStage auto; 現在稼働中のアニメーションの総ステージ数
int Property situation = 12 auto ; 現在のアニメーションの字幕のシチュエーション

string sexlabID ; 現在稼働中のSexシーンのID
bool IsAggressive ; 強姦かどうか

Actor Player ; プレイヤー
Actor Uke ; 受役のアクター
Actor Seme ; 攻役のアクター
string name_Uke ; 受の名前
string name_Seme ; 攻の名前
bool _samesex ; 受と攻が同性かどうか（v2.2）
int _temp_r ; ランダム表示の再生番号（v2.2）

int _temp = 0 ; 字幕表示の順番を記憶しておく
int Property Temp ; 外部アクセス用
	int function get()
		return _temp
	endFunction
	function set(int a_val)
		_temp = a_val
	endFunction
endProperty

float stageChangeTime = 0.0 ; 前回ステージが切り替わった時間
string[] _sset ; 表示させる字幕セット
string[] Property SSet ; 外部アクセス用
	string[] function get()
		return _sset
	endFunction
	function set(string[] a_val)
		_sset = a_val
	endFunction
endProperty

bool property repeatUpdate = false auto ; true中のみOnUpdateし字幕を表示する
bool property repeatRandom = false auto ; true中はランダムで字幕表示 (v2.2)

;/======================================================/;

Function Initialize() ; ゲームがロードされるたびに呼び出し
	sexlabID = ""
	Player = Game.GetPlayer()
	SSetting = (self as Quest) as SubtitleSetSetting
	registerEvent()
EndFunction

Function CommonSetInit() ; 汎用字幕の準備（Mod導入初回＆更新時）
	SSetting.commonSetInit() ; シチュエーションのセット
	bool importOK = SSetting.importSubtitleSetInit() ; 字幕セットの準備とインポート
	int i = 0
	while !(importOK) && (i < 10)
		utility.wait(0.1)
		i += 1
	endwhile
	SSetting.defaultSSet() ; 初回限定設定
	SS.SetMenuInit() ; HUDメニューの準備（セット名の登録）
EndFunction

Function CommonSetInitUpdate22() ; 汎用字幕の準備（v2.1→v2.2更新用）
	SSetting.commonSetInitUpdate22() ; シチュエーションの追加
	bool importOK = SSetting.importSubtitleSetInit() ; 字幕セットの準備とインポート
	int i = 0
	while !(importOK) && (i < 10)
		utility.wait(0.1)
		i += 1
	endwhile
	SSetting.defaultSSetUpdate22() ; v2.1→v2.2更新限定設定
	SS.SetMenuInit() ; HUDメニューの準備（セット名の登録）
EndFunction

Function RegisterMenukey() ; 字幕メニューリスト呼び出しキーの登録
	SS.Registerforkey(SS.menuKey)
EndFunction

Function UnregisterSubtitles() ; 関連処理の登録を削除
	unregisterEvent()
	SS.Unregisterforkey(SS.menuKey)
EndFunction

;/======================================================
	SexLab用イベント
/;
	Function registerEvent()
		RegisterForModEvent("AnimationStart", "startAnim")
		RegisterForModEvent("AnimationEnd", "endAnim")
		RegisterForModEvent("StageStart", "startStage")
		RegisterForModEvent("AnimationChange", "startStage")
		RegisterForModEvent("StageEnd", "endStage")
		RegisterForModEvent("OrgasmStart", "startStage")
		RegisterForModEvent("OrgasmEnd", "endStage")
	EndFunction
	Function unregisterEvent()
		UnregisterForModEvent("AnimationStart")
		UnregisterForModEvent("AnimationChange")
		UnregisterForModEvent("AnimationEnd")
		UnregisterForModEvent("StageStart")
		UnregisterForModEvent("StageEnd")
		UnregisterForModEvent("OrgasmStart")
		UnregisterForModEvent("OrgasmEnd")
	EndFunction

	;SexLabアニメ開始時の処理 -------------------------------------
	event startAnim(string eventName, string argString, float argNum, form sender)
		sslThreadController controller = SexLab.HookController(argString)
		bool hasplayer = controller.HasPlayer

		If hasplayer && SS.SMode ; プレイヤーがからんでいて、かつ汎用字幕システムが有効の場合
			isRunningSubtitle = true
			IsAggressive = controller.IsAggressive
			_temp = 0
			situation = 12
			sexlabID = argString
			Actor[] member = controller.Positions
			If (member.length == 1)
				Uke = member[0]
				Seme = member[0]
			else
				Uke = member[0]
				Seme = member[1]
			endIf
			; ver2.2 ディスプレイネームを優先的に取得（NPCのみ）
			string dn_Uke = ""
			string dn_Seme = ""
			string n_Uke = ""
			string n_Seme = ""
			If Uke == Player
				name_Uke = Uke.getactorbase().getName()
			else
				dn_Uke = (Uke as objectreference).GetDisplayName()
				n_Uke = Uke.getactorbase().getName()
				If !(dn_Uke == "")
					name_Uke = dn_Uke
				else
					If !(n_Uke == "")
						name_Uke = n_Uke
					else
						name_Uke = "$unknown"
					endIf
				endif
			endif
			If Seme == Player
				name_Seme = Seme.getactorbase().getName()
			else
				dn_Seme = (Seme as objectreference).GetDisplayName()
				n_Seme = Seme.getactorbase().getName()
				If !(dn_Seme == "")
					name_Seme = dn_Seme
				else
					If !(n_Seme == "")
						name_Seme = n_Seme
					else
						name_Seme = "$unknown"
					endIf
				endif
			endif
			; 性別の取得
			If  (Uke.getactorbase().GetSex() == Seme.getactorbase().GetSex())
				_samesex = true
				; Debug.Trace("# 攻と受は同性です")
			else
				_samesex = false
				; Debug.Trace("# 攻と受は異性です")
			endIf
			; debug.trace("# SexLab Subtitles - アニメ開始 - スレッドID : " + sexlabID)
		endif
	endEvent

	; ステージ毎の開始時の処理
	event startStage(string eventName, string argString, float argNum, form sender)
		If (argString == sexlabID) && SS.SMode
			currentStage = SexLab.HookStage(argString)
			sslBaseAnimation animation = SexLab.HookAnimation(argString)
			maxStage = animation.StageCount
			string animname = animation.name
			bool isCreture = animation.IsCreature
			; debug.trace("# SexLab Subtitles - スレッド:" + sexlabID + "ステージ" + currentStage + "スタート")
			; debug.trace("# 【" + animname + "】再生中 - 最終ステージは" + maxStage + "、クリーチャーは" + isCreture)

			string currentTag
			If animation.HasTag("Handjob")
				currentTag = "Handjob"
			elseIf animation.HasTag("Footjob")
				currentTag = "Footjob"
			elseIf animation.HasTag("Boobjob")
				currentTag = "Boobjob"
			elseIf animation.HasTag("Masturbation")
				currentTag = "Masturbation"
			elseIf animation.HasTag("Fisting")
				currentTag = "Fisting"
			elseIf animation.HasTag("Cowgirl")
				currentTag = "Cowgirl"
			elseIf animation.HasTag("Foreplay")
				currentTag = "Foreplay"
			elseIf animation.HasTag("Oral")
				currentTag = "Oral"
			elseIf animation.HasTag("Anal")
				currentTag = "Anal"
			else
				currentTag = ""
			endif
			; debug.trace("# 現在のアニメーションのタグ分類は" + currentTag)

			; セリフの表示番号をリセットするかどうかの判定
			float now = utility.getcurrentrealtime()
			If (now - stageChangeTime) < (SS.interval * 1.2)
				; debug.trace("# 前回から" + ((now - stageChangeTime) as int) + "秒しか経っていないためセリフをリセットしません")
			else
				_temp = 0
			endIf
			stageChangeTime = now ; 時刻の更新

			; 現在のシチュエーションをsituationにセット
			getSituation(animname, currentTag, IsAggressive, isCreture)

			If SSetting.isCSdisable(situation) ; 字幕が非表示の場合
				repeatUpdate = false
				; debug.trace("# 字幕を表示しません")
			else
				int ssstage = getSubtitleStageNow()
				_sset = SSetting.getCSsetBySituation(situation, ssstage)
				repeatUpdate = true
				ShowSubtitlesAuto()
			endif
		endIf
	endEvent

	; ステージ終了時の処理
	event endStage(string eventName, string argString, float argNum, form sender)
		If (argString == sexlabID)
			repeatUpdate = false
		endif
	endEvent
	;SexLabアニメ全体完了時の処理
	event endAnim(string eventName, string argString, float argNum, form sender)
		If (argString == sexlabID)
			repeatUpdate = false
			_temp = 0
			sexlabID = ""
			situation = 12
			Uke = none
			Seme = none
			name_Uke = ""
			name_Seme = ""
			isRunningSubtitle = false
			_samesex = false
		endif
	endEvent

;/======================================================
	字幕表示関連の処理
/;

; アニメ名、タグ名からシチュエーション番号を割り出し、situationプロパティにセットする
Function getSituation(string animname, string tagname, bool aggressivesex, bool creaturesex)
	If creaturesex
		situation = 0
	elseIf animname == "Arrok 69"
		situation = 1
	elseIf tagname == "Handjob"
		situation = 2
	elseIf tagname == "Footjob"
		situation = 3
	elseIf tagname == "Boobjob"
		situation = 4
	elseIf tagname == "Masturbation"
		situation = 5
	elseIf tagname == "Fisting"
		situation = 6
	elseIf tagname == "Cowgirl"
		situation = 7
	elseIf tagname == "Foreplay"
		situation = 8
	elseIf (tagname == "Oral") && (_samesex)
		If aggressivesex
			situation = 15
		else
			situation = 16
		endIf
	elseIf tagname == "Oral"
		If aggressivesex
			situation = 9
		else
			situation = 10
		endIf
	elseIf (tagname == "Anal") && (_samesex)
		If aggressivesex
			situation = 17
		else
			situation = 18
		endIf
	elseIf tagname == "Anal"
		If aggressivesex
			situation = 13
		else
			situation = 14
		endIf
	elseIf (_samesex)
		If aggressivesex
			situation = 19
		else
			situation = 20
		endif
	else
		If aggressivesex
			situation = 11
		else
			situation = 12
		endif
	endif
EndFunction

; 現在のステージから適用する字幕のステージを返す（5ステージ以上あるアニメーション対応）
int Function getSubtitleStageNow()
	If currentStage == 1
		return 1
	elseif currentStage == 2
		return 2
	elseif currentStage == maxStage
		return 5
	elseif currentStage == (maxStage - 1)
		return 4
	else
		return 3
	endif
EndFunction

; 字幕表示に使う関数
Function ShowSuper(String n_uke, String n_seme, String asMessage)
	SS.ShowSubtitleSuper(n_uke, n_seme, asMessage)
EndFunction

; 字幕セットの表示
Function ShowSubtitlesAuto()
	ShowSubtitles(_sset)
EndFunction

Function ShowSubtitles(string[] subtitleSet)
	; debug.trace("# ShowSubtitles処理開始")
	int len = subtitleSet.length

	If repeatRandom ; ランダムモード
		If len == 1
			ShowSuper(name_Uke, name_Seme, subtitleSet[0])
			_temp_r = 0
			If repeatUpdate
				registerforsingleupdate(SS.interval)
			endIf
		else
			int choice = getRandomDifferent(0, (len - 1), _temp_r)
			; Debug.Trace("# ランダムモード：前回は" +_temp_r + " 結果は" + choice)
			If (choice == 0) && (subtitleSet.length > 0)
				ShowSuper(name_Uke, name_Seme, subtitleSet[0])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 1) && (subtitleSet.length > 1)
				ShowSuper(name_Uke, name_Seme, subtitleSet[1])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 2) && (subtitleSet.length > 2)
				ShowSuper(name_Uke, name_Seme, subtitleSet[2])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 3) && (subtitleSet.length > 3)
				ShowSuper(name_Uke, name_Seme, subtitleSet[3])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 4) && (subtitleSet.length > 4)
				ShowSuper(name_Uke, name_Seme, subtitleSet[4])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 5) && (subtitleSet.length > 5)
				ShowSuper(name_Uke, name_Seme, subtitleSet[5])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 6) && (subtitleSet.length > 6)
				ShowSuper(name_Uke, name_Seme, subtitleSet[6])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 7) && (subtitleSet.length > 7)
				ShowSuper(name_Uke, name_Seme, subtitleSet[7])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 8) && (subtitleSet.length > 8)
				ShowSuper(name_Uke, name_Seme, subtitleSet[8])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 9) && (subtitleSet.length > 9)
				ShowSuper(name_Uke, name_Seme, subtitleSet[9])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 10) && (subtitleSet.length > 10)
				ShowSuper(name_Uke, name_Seme, subtitleSet[10])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 11) && (subtitleSet.length > 11)
				ShowSuper(name_Uke, name_Seme, subtitleSet[11])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 12) && (subtitleSet.length > 12)
				ShowSuper(name_Uke, name_Seme, subtitleSet[12])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 13) && (subtitleSet.length > 13)
				ShowSuper(name_Uke, name_Seme, subtitleSet[13])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 14) && (subtitleSet.length > 14)
				ShowSuper(name_Uke, name_Seme, subtitleSet[14])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 15) && (subtitleSet.length > 15)
				ShowSuper(name_Uke, name_Seme, subtitleSet[15])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 16) && (subtitleSet.length > 16)
				ShowSuper(name_Uke, name_Seme, subtitleSet[16])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 17) && (subtitleSet.length > 17)
				ShowSuper(name_Uke, name_Seme, subtitleSet[17])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 18) && (subtitleSet.length > 18)
				ShowSuper(name_Uke, name_Seme, subtitleSet[18])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			elseIf (choice == 19) && (subtitleSet.length > 19)
				ShowSuper(name_Uke, name_Seme, subtitleSet[19])
				_temp_r = choice
				If repeatUpdate
					registerforsingleupdate(SS.interval)
				endIf
			else	 ; ランダムの結果と字幕の個数が一致しない場合
				If repeatUpdate
					registerforsingleupdate(0.1)
				endIf
			endIf
		endif
	else ; リピートモード
		; debug.trace("# リピートモード 前回_tempは" + _temp)
		If temp >= subtitleSet.length ; 表示回数がセリフ数を越えたら0に戻す
			_temp = 0
		endif
		If (_temp == 0)
			ShowSuper(name_Uke, name_Seme, subtitleSet[0])
		elseIf (_temp == 1)
			ShowSuper(name_Uke, name_Seme, subtitleSet[1])
		elseIf (_temp == 2)
			ShowSuper(name_Uke, name_Seme, subtitleSet[2])
		elseIf (_temp == 3)
			ShowSuper(name_Uke, name_Seme, subtitleSet[3])
		elseIf (_temp == 4)
			ShowSuper(name_Uke, name_Seme, subtitleSet[4])
		elseIf (_temp == 5)
			ShowSuper(name_Uke, name_Seme, subtitleSet[5])
		elseIf (_temp == 6)
			ShowSuper(name_Uke, name_Seme, subtitleSet[6])
		elseIf (_temp == 7)
			ShowSuper(name_Uke, name_Seme, subtitleSet[7])
		elseIf (_temp == 8)
			ShowSuper(name_Uke, name_Seme, subtitleSet[8])
		elseIf (_temp == 9)
			ShowSuper(name_Uke, name_Seme, subtitleSet[9])
		elseIf (_temp == 10)
			ShowSuper(name_Uke, name_Seme, subtitleSet[10])
		elseIf (_temp == 11)
			ShowSuper(name_Uke, name_Seme, subtitleSet[11])
		elseIf (_temp == 12)
			ShowSuper(name_Uke, name_Seme, subtitleSet[12])
		elseIf (_temp == 13)
			ShowSuper(name_Uke, name_Seme, subtitleSet[13])
		elseIf (_temp == 14)
			ShowSuper(name_Uke, name_Seme, subtitleSet[14])
		elseIf (_temp == 15)
			ShowSuper(name_Uke, name_Seme, subtitleSet[15])
		elseIf (_temp == 16)
			ShowSuper(name_Uke, name_Seme, subtitleSet[16])
		elseIf (_temp == 17)
			ShowSuper(name_Uke, name_Seme, subtitleSet[17])
		elseIf (_temp == 18)
			ShowSuper(name_Uke, name_Seme, subtitleSet[18])
		elseIf (_temp == 19)
			ShowSuper(name_Uke, name_Seme, subtitleSet[19])
		endIf
		_temp += 1
		If repeatUpdate
			registerforsingleupdate(SS.interval)
		endIf
	endif
EndFunction

Event OnUpdate()
	If repeatUpdate
		ShowSubtitles(_sset)
	endif
EndEvent

; ランダムで同じ数を二回続けて出さないようにする
int Function getRandomDifferent(int min, int max, int before)
	int n = Utility.randomInt(min, max)
	while ( n == before)
		n = Utility.randomInt(min, max)
	endwhile
	return n
EndFunction
