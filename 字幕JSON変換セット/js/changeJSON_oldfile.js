var outputText1;
var outputText2;
var outputText3;
var outputText4;
var outputText5;

var canbeDW = false;
var isIE

function checkFileAPI() {
        if (window.File && window.FileReader && window.FileList && window.Blob) {
	// alert('File APIが稼働するブラウザです');
        } else {
            // alert('お使いのブラウザではFile APIsが動作しません');
            $(".error").css("display","block");
        }
    	}
function checkIE () {
	var userAgent = window.navigator.userAgent.toLowerCase();
	if( userAgent.match(/(msie|MSIE)/) || userAgent.match(/(T|t)rident/) ) {
	    isIE = true;
	    if (window.navigator.msSaveBlob) {
	    	// alert ("msSaveBlob対応");
	    } else {
            // alert('お使いのブラウザでは動作しません');
            $(".error").css("display","block");
	    }
	} else {
	    isIE = false;
	}
}

$(function() {
	checkIE ();
	checkFileAPI(); // 環境チェック
	$("#droppable").fileDrop({
		dragEnter: function(e) {},
		dragLeave: function(e) {},
		drop: function(files) {},
		dropEach: function(f, val) {
			if ( /image/.test(f.type) ) {
				alert ("ドロップしたファイルの書式が正しくありません！");
			}else if ( f.type.indexOf("text") >= 0 || /javascript/.test(f.type) ) {
//================================================================
var text1 = val.toString(); // ドロップしたファイルのテキスト全体

// 字幕の抽出(A)
	var arg_CS1_1 = text1.match(/\$CS1_1_[0-9]\t.*\r/g);

	// ファイルの書式判定
	if (arg_CS1_1 == null){
		alert ("ドロップしたファイルの書式が正しくありません！");
		return
	}else{
		canbeDW = true;
	}

	var arg_CS1_2 = text1.match(/\$CS1_2_[0-9]\t.*\r/g);
	var arg_CS1_3 = text1.match(/\$CS1_3_[0-9]\t.*\r/g);
	var arg_CS1_4 = text1.match(/\$CS1_4_[0-9]\t.*\r/g);
	var arg_CS1_5 = text1.match(/\$CS1_5_[0-9]\t.*\r/g);
	var arg_CS2_1 = text1.match(/\$CS2_1_[0-9]\t.*\r/g);
	var arg_CS2_2 = text1.match(/\$CS2_2_[0-9]\t.*\r/g);
	var arg_CS2_3 = text1.match(/\$CS2_3_[0-9]\t.*\r/g);
	var arg_CS2_4 = text1.match(/\$CS2_4_[0-9]\t.*\r/g);
	var arg_CS2_5 = text1.match(/\$CS2_5_[0-9]\t.*\r/g);
	var arg_CS3_1 = text1.match(/\$CS3_1_[0-9]\t.*\r/g);
	var arg_CS3_2 = text1.match(/\$CS3_2_[0-9]\t.*\r/g);
	var arg_CS3_3 = text1.match(/\$CS3_3_[0-9]\t.*\r/g);
	var arg_CS3_4 = text1.match(/\$CS3_4_[0-9]\t.*\r/g);
	var arg_CS3_5 = text1.match(/\$CS3_5_[0-9]\t.*\r/g);
	var arg_CS4_1 = text1.match(/\$CS4_1_[0-9]\t.*\r/g);
	var arg_CS4_2 = text1.match(/\$CS4_2_[0-9]\t.*\r/g);
	var arg_CS4_3 = text1.match(/\$CS4_3_[0-9]\t.*\r/g);
	var arg_CS4_4 = text1.match(/\$CS4_4_[0-9]\t.*\r/g);
	var arg_CS4_5 = text1.match(/\$CS4_5_[0-9]\t.*\r/g);
	var arg_CS5_1 = text1.match(/\$CS5_1_[0-9]\t.*\r/g);
	var arg_CS5_2 = text1.match(/\$CS5_2_[0-9]\t.*\r/g);
	var arg_CS5_3 = text1.match(/\$CS5_3_[0-9]\t.*\r/g);
	var arg_CS5_4 = text1.match(/\$CS5_4_[0-9]\t.*\r/g);
	var arg_CS5_5 = text1.match(/\$CS5_5_[0-9]\t.*\r/g);
// (A)を文字列に変換
	var text_CS1_1 = arg_CS1_1.toString();
	var text_CS1_2 = arg_CS1_2.toString();
	var text_CS1_3 = arg_CS1_3.toString();
	var text_CS1_4 = arg_CS1_4.toString();
	var text_CS1_5 = arg_CS1_5.toString();
	var text_CS2_1 = arg_CS2_1.toString();
	var text_CS2_2 = arg_CS2_2.toString();
	var text_CS2_3 = arg_CS2_3.toString();
	var text_CS2_4 = arg_CS2_4.toString();
	var text_CS2_5 = arg_CS2_5.toString();
	var text_CS3_1 = arg_CS3_1.toString();
	var text_CS3_2 = arg_CS3_2.toString();
	var text_CS3_3 = arg_CS3_3.toString();
	var text_CS3_4 = arg_CS3_4.toString();
	var text_CS3_5 = arg_CS3_5.toString();
	var text_CS4_1 = arg_CS4_1.toString();
	var text_CS4_2 = arg_CS4_2.toString();
	var text_CS4_3 = arg_CS4_3.toString();
	var text_CS4_4 = arg_CS4_4.toString();
	var text_CS4_5 = arg_CS4_5.toString();
	var text_CS5_1 = arg_CS5_1.toString();
	var text_CS5_2 = arg_CS5_2.toString();
	var text_CS5_3 = arg_CS5_3.toString();
	var text_CS5_4 = arg_CS5_4.toString();
	var text_CS5_5 = arg_CS5_5.toString();
// セリフ部分の抽出
	arg_CS1_1 = text_CS1_1.match(/\t.*\r/g);
	arg_CS1_2 = text_CS1_2.match(/\t.*\r/g);
	arg_CS1_3 = text_CS1_3.match(/\t.*\r/g);
	arg_CS1_4 = text_CS1_4.match(/\t.*\r/g);
	arg_CS1_5 = text_CS1_5.match(/\t.*\r/g);
	arg_CS2_1 = text_CS2_1.match(/\t.*\r/g);
	arg_CS2_2 = text_CS2_2.match(/\t.*\r/g);
	arg_CS2_3 = text_CS2_3.match(/\t.*\r/g);
	arg_CS2_4 = text_CS2_4.match(/\t.*\r/g);
	arg_CS2_5 = text_CS2_5.match(/\t.*\r/g);
	arg_CS3_1 = text_CS3_1.match(/\t.*\r/g);
	arg_CS3_2 = text_CS3_2.match(/\t.*\r/g);
	arg_CS3_3 = text_CS3_3.match(/\t.*\r/g);
	arg_CS3_4 = text_CS3_4.match(/\t.*\r/g);
	arg_CS3_5 = text_CS3_5.match(/\t.*\r/g);
	arg_CS4_1 = text_CS4_1.match(/\t.*\r/g);
	arg_CS4_2 = text_CS4_2.match(/\t.*\r/g);
	arg_CS4_3 = text_CS4_3.match(/\t.*\r/g);
	arg_CS4_4 = text_CS4_4.match(/\t.*\r/g);
	arg_CS4_5 = text_CS4_5.match(/\t.*\r/g);
	arg_CS5_1 = text_CS5_1.match(/\t.*\r/g);
	arg_CS5_2 = text_CS5_2.match(/\t.*\r/g);
	arg_CS5_3 = text_CS5_3.match(/\t.*\r/g);
	arg_CS5_4 = text_CS5_4.match(/\t.*\r/g);
	arg_CS5_5 = text_CS5_5.match(/\t.*\r/g);
// タブや改行を削除
	for (var i = 0; i < arg_CS1_1.length; i++) {
		arg_CS1_1[i] = arg_CS1_1[i].replace(/\t/g, '');
		arg_CS1_1[i] = arg_CS1_1[i].replace(/\r/g, '');
		arg_CS1_1[i] = arg_CS1_1[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS1_2.length; i++) {
		arg_CS1_2[i] = arg_CS1_2[i].replace(/\t/g, '');
		arg_CS1_2[i] = arg_CS1_2[i].replace(/\r/g, '');
		arg_CS1_2[i] = arg_CS1_2[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS1_3.length; i++) {
		arg_CS1_3[i] = arg_CS1_3[i].replace(/\t/g, '');
		arg_CS1_3[i] = arg_CS1_3[i].replace(/\r/g, '');
		arg_CS1_3[i] = arg_CS1_3[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS1_4.length; i++) {
		arg_CS1_4[i] = arg_CS1_4[i].replace(/\t/g, '');
		arg_CS1_4[i] = arg_CS1_4[i].replace(/\r/g, '');
		arg_CS1_4[i] = arg_CS1_4[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS1_5.length; i++) {
		arg_CS1_5[i] = arg_CS1_5[i].replace(/\t/g, '');
		arg_CS1_5[i] = arg_CS1_5[i].replace(/\r/g, '');
		arg_CS1_5[i] = arg_CS1_5[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS2_1.length; i++) {
		arg_CS2_1[i] = arg_CS2_1[i].replace(/\t/g, '');
		arg_CS2_1[i] = arg_CS2_1[i].replace(/\r/g, '');
		arg_CS2_1[i] = arg_CS2_1[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS2_2.length; i++) {
		arg_CS2_2[i] = arg_CS2_2[i].replace(/\t/g, '');
		arg_CS2_2[i] = arg_CS2_2[i].replace(/\r/g, '');
		arg_CS2_2[i] = arg_CS2_2[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS2_3.length; i++) {
		arg_CS2_3[i] = arg_CS2_3[i].replace(/\t/g, '');
		arg_CS2_3[i] = arg_CS2_3[i].replace(/\r/g, '');
		arg_CS2_3[i] = arg_CS2_3[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS2_4.length; i++) {
		arg_CS2_4[i] = arg_CS2_4[i].replace(/\t/g, '');
		arg_CS2_4[i] = arg_CS2_4[i].replace(/\r/g, '');
		arg_CS2_4[i] = arg_CS2_4[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS2_5.length; i++) {
		arg_CS2_5[i] = arg_CS2_5[i].replace(/\t/g, '');
		arg_CS2_5[i] = arg_CS2_5[i].replace(/\r/g, '');
		arg_CS2_5[i] = arg_CS2_5[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS3_1.length; i++) {
		arg_CS3_1[i] = arg_CS3_1[i].replace(/\t/g, '');
		arg_CS3_1[i] = arg_CS3_1[i].replace(/\r/g, '');
		arg_CS3_1[i] = arg_CS3_1[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS3_2.length; i++) {
		arg_CS3_2[i] = arg_CS3_2[i].replace(/\t/g, '');
		arg_CS3_2[i] = arg_CS3_2[i].replace(/\r/g, '');
		arg_CS3_2[i] = arg_CS3_2[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS3_3.length; i++) {
		arg_CS3_3[i] = arg_CS3_3[i].replace(/\t/g, '');
		arg_CS3_3[i] = arg_CS3_3[i].replace(/\r/g, '');
		arg_CS3_3[i] = arg_CS3_3[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS3_4.length; i++) {
		arg_CS3_4[i] = arg_CS3_4[i].replace(/\t/g, '');
		arg_CS3_4[i] = arg_CS3_4[i].replace(/\r/g, '');
		arg_CS3_4[i] = arg_CS3_4[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS3_5.length; i++) {
		arg_CS3_5[i] = arg_CS3_5[i].replace(/\t/g, '');
		arg_CS3_5[i] = arg_CS3_5[i].replace(/\r/g, '');
		arg_CS3_5[i] = arg_CS3_5[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS4_1.length; i++) {
		arg_CS4_1[i] = arg_CS4_1[i].replace(/\t/g, '');
		arg_CS4_1[i] = arg_CS4_1[i].replace(/\r/g, '');
		arg_CS4_1[i] = arg_CS4_1[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS4_2.length; i++) {
		arg_CS4_2[i] = arg_CS4_2[i].replace(/\t/g, '');
		arg_CS4_2[i] = arg_CS4_2[i].replace(/\r/g, '');
		arg_CS4_2[i] = arg_CS4_2[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS4_3.length; i++) {
		arg_CS4_3[i] = arg_CS4_3[i].replace(/\t/g, '');
		arg_CS4_3[i] = arg_CS4_3[i].replace(/\r/g, '');
		arg_CS4_3[i] = arg_CS4_3[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS4_4.length; i++) {
		arg_CS4_4[i] = arg_CS4_4[i].replace(/\t/g, '');
		arg_CS4_4[i] = arg_CS4_4[i].replace(/\r/g, '');
		arg_CS4_4[i] = arg_CS4_4[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS4_5.length; i++) {
		arg_CS4_5[i] = arg_CS4_5[i].replace(/\t/g, '');
		arg_CS4_5[i] = arg_CS4_5[i].replace(/\r/g, '');
		arg_CS4_5[i] = arg_CS4_5[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS5_1.length; i++) {
		arg_CS5_1[i] = arg_CS5_1[i].replace(/\t/g, '');
		arg_CS5_1[i] = arg_CS5_1[i].replace(/\r/g, '');
		arg_CS5_1[i] = arg_CS5_1[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS5_2.length; i++) {
		arg_CS5_2[i] = arg_CS5_2[i].replace(/\t/g, '');
		arg_CS5_2[i] = arg_CS5_2[i].replace(/\r/g, '');
		arg_CS5_2[i] = arg_CS5_2[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS5_3.length; i++) {
		arg_CS5_3[i] = arg_CS5_3[i].replace(/\t/g, '');
		arg_CS5_3[i] = arg_CS5_3[i].replace(/\r/g, '');
		arg_CS5_3[i] = arg_CS5_3[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS5_4.length; i++) {
		arg_CS5_4[i] = arg_CS5_4[i].replace(/\t/g, '');
		arg_CS5_4[i] = arg_CS5_4[i].replace(/\r/g, '');
		arg_CS5_4[i] = arg_CS5_4[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS5_5.length; i++) {
		arg_CS5_5[i] = arg_CS5_5[i].replace(/\t/g, '');
		arg_CS5_5[i] = arg_CS5_5[i].replace(/\r/g, '');
		arg_CS5_5[i] = arg_CS5_5[i].replace(/\n/g, '');
	};

// セット名の抽出、文字列化
	var arg_CS1_name = text1.match(/\$CS1_SetName\t.*\r/g);
	var arg_CS2_name = text1.match(/\$CS2_SetName\t.*\r/g);
	var arg_CS3_name = text1.match(/\$CS3_SetName\t.*\r/g);
	var arg_CS4_name = text1.match(/\$CS4_SetName\t.*\r/g);
	var arg_CS5_name = text1.match(/\$CS5_SetName\t.*\r/g);
	var text_CS1_name = arg_CS1_name.toString();
	var text_CS2_name = arg_CS2_name.toString();
	var text_CS3_name = arg_CS3_name.toString();
	var text_CS4_name = arg_CS4_name.toString();
	var text_CS5_name = arg_CS5_name.toString();
// セット名を最適化
	var name_CS1 = text_CS1_name.match(/\t.*\r/g);
	var name_CS2 = text_CS2_name.match(/\t.*\r/g);
	var name_CS3 = text_CS3_name.match(/\t.*\r/g);
	var name_CS4 = text_CS4_name.match(/\t.*\r/g);
	var name_CS5 = text_CS5_name.match(/\t.*\r/g);
	var text_CS1 = name_CS1.toString();
	var text_CS2 = name_CS2.toString();
	var text_CS3 = name_CS3.toString();
	var text_CS4 = name_CS4.toString();
	var text_CS5 = name_CS5.toString();
// セット名のタブや改行削除
	name_CS1 = text_CS1.replace(/\t/g, '');
	name_CS1 = text_CS1.replace(/\r/g, '');
	name_CS1 = text_CS1.replace(/\n/g, '');
	name_CS1 = text_CS1.replace(/\s/g, '');
	name_CS2 = text_CS2.replace(/\t/g, '');
	name_CS2 = text_CS2.replace(/\r/g, '');
	name_CS2 = text_CS2.replace(/\n/g, '');
	name_CS2 = text_CS2.replace(/\s/g, '');
	name_CS3 = text_CS3.replace(/\t/g, '');
	name_CS3 = text_CS3.replace(/\r/g, '');
	name_CS3 = text_CS3.replace(/\n/g, '');
	name_CS3 = text_CS3.replace(/\s/g, '');
	name_CS4 = text_CS4.replace(/\t/g, '');
	name_CS4 = text_CS4.replace(/\r/g, '');
	name_CS4 = text_CS4.replace(/\n/g, '');
	name_CS4 = text_CS4.replace(/\s/g, '');
	name_CS5 = text_CS5.replace(/\t/g, '');
	name_CS5 = text_CS5.replace(/\r/g, '');
	name_CS5 = text_CS5.replace(/\n/g, '');
	name_CS5 = text_CS5.replace(/\s/g, '');

// JSON出力 - 字幕セット1
	outputText1 = '{\n';
	outputText1 += '\t"stringList" :\n' ;
	outputText1 += '\t{\n' ;
	outputText1 += ('\t\t"import_name" : ["' + name_CS1 + '"],\n')  ;
	// stage1
	outputText1 += ('\t\t"import_stage1" : [\n') ;
	for (var i = 0; i < (arg_CS1_1.length); i++) {
	outputText1 += ('\t\t\t"' + arg_CS1_1[i] + '",\n') ;
	};
	outputText1 += ('\t\t\t"#ssend"\n') ;
	outputText1 += '\t\t\t],\n';
	// stage2
	outputText1 += ('\t\t"import_stage2" : [\n') ;
	for (var i = 0; i < (arg_CS1_2.length); i++) {
	outputText1 += ('\t\t\t"' + arg_CS1_2[i] + '",\n') ;
	};
	outputText1 += ('\t\t\t"#ssend"\n') ;
	outputText1 += '\t\t\t],\n';
	// stage3
	outputText1 += ('\t\t"import_stage3" : [\n') ;
	for (var i = 0; i < (arg_CS1_3.length); i++) {
	outputText1 += ('\t\t\t"' + arg_CS1_3[i] + '",\n') ;
	};
	outputText1 += ('\t\t\t"#ssend"\n') ;
	outputText1 += '\t\t\t],\n';
	// stage4
	outputText1 += ('\t\t"import_stage4" : [\n') ;
	for (var i = 0; i < (arg_CS1_4.length); i++) {
	outputText1 += ('\t\t\t"' + arg_CS1_4[i] + '",\n') ;
	};
	outputText1 += ('\t\t\t"#ssend"\n') ;
	outputText1 += '\t\t\t],\n';
	// stage5
	outputText1 += ('\t\t"import_stage5" : [\n') ;
	for (var i = 0; i < (arg_CS1_5.length); i++) {
	outputText1 += ('\t\t\t"' + arg_CS1_5[i] + '",\n') ;
	};
	outputText1 += ('\t\t\t"#ssend"\n') ;
	outputText1 += '\t\t\t]\n'; // 最後の行はカンマとる

	outputText1 += '\t}\n}\n';
// JSON出力 - 字幕セット2
	outputText2 = '{\n';
	outputText2 += '\t"stringList" :\n' ;
	outputText2 += '\t{\n' ;
	outputText2 += ('\t\t"import_name" : ["' + name_CS2 + '"],\n')  ;
	// stage1
	outputText2 += ('\t\t"import_stage1" : [\n') ;
	for (var i = 0; i < (arg_CS2_1.length); i++) {
	outputText2 += ('\t\t\t"' + arg_CS2_1[i] + '",\n') ;
	};
	outputText2 += ('\t\t\t"#ssend"\n') ;
	outputText2 += '\t\t\t],\n';
	// stage2
	outputText2 += ('\t\t"import_stage2" : [\n') ;
	for (var i = 0; i < (arg_CS2_2.length); i++) {
	outputText2 += ('\t\t\t"' + arg_CS2_2[i] + '",\n') ;
	};
	outputText2 += ('\t\t\t"#ssend"\n') ;
	outputText2 += '\t\t\t],\n';
	// stage3
	outputText2 += ('\t\t"import_stage3" : [\n') ;
	for (var i = 0; i < (arg_CS2_3.length); i++) {
	outputText2 += ('\t\t\t"' + arg_CS2_3[i] + '",\n') ;
	};
	outputText2 += ('\t\t\t"#ssend"\n') ;
	outputText2 += '\t\t\t],\n';
	// stage4
	outputText2 += ('\t\t"import_stage4" : [\n') ;
	for (var i = 0; i < (arg_CS2_4.length); i++) {
	outputText2 += ('\t\t\t"' + arg_CS2_4[i] + '",\n') ;
	};
	outputText2 += ('\t\t\t"#ssend"\n') ;
	outputText2 += '\t\t\t],\n';
	// stage5
	outputText2 += ('\t\t"import_stage5" : [\n') ;
	for (var i = 0; i < (arg_CS2_5.length); i++) {
	outputText2 += ('\t\t\t"' + arg_CS2_5[i] + '",\n') ;
	};
	outputText2 += ('\t\t\t"#ssend"\n') ;
	outputText2 += '\t\t\t]\n'; // 最後の行はカンマとる

	outputText2 += '\t}\n}\n';
// JSON出力 - 字幕セット3
	outputText3 = '{\n';
	outputText3 += '\t"stringList" :\n' ;
	outputText3 += '\t{\n' ;
	outputText3 += ('\t\t"import_name" : ["' + name_CS3 + '"],\n')  ;
	// stage1
	outputText3 += ('\t\t"import_stage1" : [\n') ;
	for (var i = 0; i < (arg_CS3_1.length); i++) {
	outputText3 += ('\t\t\t"' + arg_CS3_1[i] + '",\n') ;
	};
	outputText3 += ('\t\t\t"#ssend"\n') ;
	outputText3 += '\t\t\t],\n';
	// stage2
	outputText3 += ('\t\t"import_stage2" : [\n') ;
	for (var i = 0; i < (arg_CS3_2.length); i++) {
	outputText3 += ('\t\t\t"' + arg_CS3_2[i] + '",\n') ;
	};
	outputText3 += ('\t\t\t"#ssend"\n') ;
	outputText3 += '\t\t\t],\n';
	// stage3
	outputText3 += ('\t\t"import_stage3" : [\n') ;
	for (var i = 0; i < (arg_CS3_3.length); i++) {
	outputText3 += ('\t\t\t"' + arg_CS3_3[i] + '",\n') ;
	};
	outputText3 += ('\t\t\t"#ssend"\n') ;
	outputText3 += '\t\t\t],\n';
	// stage4
	outputText3 += ('\t\t"import_stage4" : [\n') ;
	for (var i = 0; i < (arg_CS3_4.length); i++) {
	outputText3 += ('\t\t\t"' + arg_CS3_4[i] + '",\n') ;
	};
	outputText3 += ('\t\t\t"#ssend"\n') ;
	outputText3 += '\t\t\t],\n';
	// stage5
	outputText3 += ('\t\t"import_stage5" : [\n') ;
	for (var i = 0; i < (arg_CS3_5.length); i++) {
	outputText3 += ('\t\t\t"' + arg_CS3_5[i] + '",\n') ;
	};
	outputText3 += ('\t\t\t"#ssend"\n') ;
	outputText3 += '\t\t\t]\n'; // 最後の行はカンマとる

	outputText3 += '\t}\n}\n';
// JSON出力 - 字幕セット4
	outputText4 = '{\n';
	outputText4 += '\t"stringList" :\n' ;
	outputText4 += '\t{\n' ;
	outputText4 += ('\t\t"import_name" : ["' + name_CS4 + '"],\n')  ;
	// stage1
	outputText4 += ('\t\t"import_stage1" : [\n') ;
	for (var i = 0; i < (arg_CS4_1.length); i++) {
	outputText4 += ('\t\t\t"' + arg_CS4_1[i] + '",\n') ;
	};
	outputText4 += ('\t\t\t"#ssend"\n') ;
	outputText4 += '\t\t\t],\n';
	// stage2
	outputText4 += ('\t\t"import_stage2" : [\n') ;
	for (var i = 0; i < (arg_CS4_2.length); i++) {
	outputText4 += ('\t\t\t"' + arg_CS4_2[i] + '",\n') ;
	};
	outputText4 += ('\t\t\t"#ssend"\n') ;
	outputText4 += '\t\t\t],\n';
	// stage3
	outputText4 += ('\t\t"import_stage3" : [\n') ;
	for (var i = 0; i < (arg_CS4_3.length); i++) {
	outputText4 += ('\t\t\t"' + arg_CS4_3[i] + '",\n') ;
	};
	outputText4 += ('\t\t\t"#ssend"\n') ;
	outputText4 += '\t\t\t],\n';
	// stage4
	outputText4 += ('\t\t"import_stage4" : [\n') ;
	for (var i = 0; i < (arg_CS4_4.length); i++) {
	outputText4 += ('\t\t\t"' + arg_CS4_4[i] + '",\n') ;
	};
	outputText4 += ('\t\t\t"#ssend"\n') ;
	outputText4 += '\t\t\t],\n';
	// stage5
	outputText4 += ('\t\t"import_stage5" : [\n') ;
	for (var i = 0; i < (arg_CS4_5.length); i++) {
	outputText4 += ('\t\t\t"' + arg_CS4_5[i] + '",\n') ;
	};
	outputText4 += ('\t\t\t"#ssend"\n') ;
	outputText4 += '\t\t\t]\n'; // 最後の行はカンマとる

	outputText4 += '\t}\n}\n';
// JSON出力 - 字幕セット5
	outputText5 = '{\n';
	outputText5 += '\t"stringList" :\n' ;
	outputText5 += '\t{\n' ;
	outputText5 += ('\t\t"import_name" : ["' + name_CS5 + '"],\n')  ;
	// stage1
	outputText5 += ('\t\t"import_stage1" : [\n') ;
	for (var i = 0; i < (arg_CS5_1.length); i++) {
	outputText5 += ('\t\t\t"' + arg_CS5_1[i] + '",\n') ;
	};
	outputText5 += ('\t\t\t"#ssend"\n') ;
	outputText5 += '\t\t\t],\n';
	// stage2
	outputText5 += ('\t\t"import_stage2" : [\n') ;
	for (var i = 0; i < (arg_CS5_2.length); i++) {
	outputText5 += ('\t\t\t"' + arg_CS5_2[i] + '",\n') ;
	};
	outputText5 += ('\t\t\t"#ssend"\n') ;
	outputText5 += '\t\t\t],\n';
	// stage3
	outputText5 += ('\t\t"import_stage3" : [\n') ;
	for (var i = 0; i < (arg_CS5_3.length); i++) {
	outputText5 += ('\t\t\t"' + arg_CS5_3[i] + '",\n') ;
	};
	outputText5 += ('\t\t\t"#ssend"\n') ;
	outputText5 += '\t\t\t],\n';
	// stage4
	outputText5 += ('\t\t"import_stage4" : [\n') ;
	for (var i = 0; i < (arg_CS5_4.length); i++) {
	outputText5 += ('\t\t\t"' + arg_CS5_4[i] + '",\n') ;
	};
	outputText5 += ('\t\t\t"#ssend"\n') ;
	outputText5 += '\t\t\t],\n';
	// stage5
	outputText5 += ('\t\t"import_stage5" : [\n') ;
	for (var i = 0; i < (arg_CS5_5.length); i++) {
	outputText5 += ('\t\t\t"' + arg_CS5_5[i] + '",\n') ;
	};
	outputText5 += ('\t\t\t"#ssend"\n') ;
	outputText5 += '\t\t\t]\n'; // 最後の行はカンマとる

	outputText5 += '\t}\n}\n';

// 出力
$("#output .info").css("display","none");
$("#output .stage1").css("display","block");
$("#output .stage2").css("display","block");
$("#output .stage3").css("display","block");
$("#output .stage4").css("display","block");
$("#output .stage5").css("display","block");

$("#output .stage1").append( $("<pre></pre>").text(outputText1));
$("#output .stage2").append( $("<pre></pre>").text(outputText2));
$("#output .stage3").append( $("<pre></pre>").text(outputText3));
$("#output .stage4").append( $("<pre></pre>").text(outputText4));
$("#output .stage5").append( $("<pre></pre>").text(outputText5));

				//========================================
				} else {
					alert ("ドロップしたファイルの書式が正しくありません！");
				}
		} //dropEach: function(f, val)

	});//$("#droppable").fileDrop
//================================================================


$("#export").click(function(){  // 出力ボタン
	if (canbeDW){
		if ( isIE ){
			$(".download_IE").css("display","block");
		} else {
			$(".download").css("display","block");
			setBlobUrl("download1", outputText1, "importSet1.json");
			setBlobUrl("download2", outputText2, "importSet2.json");
			setBlobUrl("download3", outputText3, "importSet3.json");
			setBlobUrl("download4", outputText4, "importSet4.json");
			setBlobUrl("download5", outputText5, "importSet5.json");
		}
	}else{
		alert ('まず先に変換したいファイルをドロップして下さい');
	}
});

// IE用
$("#download1_IE").click(function(){  // 出力ボタン
	setBlobIE(outputText1, "importSet1.json");
});
$("#download2_IE").click(function(){  // 出力ボタン
	setBlobIE(outputText2, "importSet2.json");
});
$("#download3_IE").click(function(){  // 出力ボタン
	setBlobIE(outputText3, "importSet3.json");
});
$("#download4_IE").click(function(){  // 出力ボタン
	setBlobIE(outputText4, "importSet4.json");
});
$("#download5_IE").click(function(){  // 出力ボタン
	setBlobIE(outputText5, "importSet5.json");
});

}); //$(function()

function setBlobUrl(id, content, filename) {
	// 指定されたデータを保持するBlobを作成する。
	var blob = new Blob([ content ], { "type" : "application/x-msdownload" });
	// Aタグのhref属性にBlobオブジェクトを設定し、リンクを生成
	window.URL = window.URL || window.webkitURL;
	$("#" + id).attr("href", window.URL.createObjectURL(blob));
	$("#" + id).attr("download", filename);
}

function setBlobIE(content, filename) {
	var blob = new Blob([content]);
	window.navigator.msSaveBlob(blob, filename);
}

function cutoff(str, len, tail) {
	tail = tail || "";
	return str.slice(0, len) + tail;
}
