var outputText;
var canbeDW = false;
var isIE;

function checkFileAPI() {
    if (window.File && window.FileReader && window.FileList && window.Blob) {
            // alert('File APIが稼働するブラウザです');
    } else {
            alert('お使いのブラウザでは動作しません');
            $(".error").css("display","block");
        }
    }
function checkIE(){
	var userAgent = window.navigator.userAgent.toLowerCase();
	if (userAgent.match(/(msie|MSIE)/) || userAgent.match(/(T|t)rident/)) {
	    isIE = true;
	    if (window.navigator.msSaveBlob) {
	    	// alert ("msSaveBlob対応");
	    } else {
            alert ("お使いのブラウザでは動作しません");
            $(".error").css("display","block");
	    }
	} else {
	    isIE = false;
	}
}

$(function() {
	checkIE();
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

	var arg_CS1 = text1.match(/\$((CS1_[1-9])|(CS1_1[0-9])|(CS1_20))\t.*\r/g);

	// ファイルの書式判定
	if (arg_CS1 == null){
		alert ("ドロップしたファイルの書式が正しくありません！");
		return
	}else{
		canbeDW = true;
	}

	var arg_CS2 = text1.match(/\$((CS2_[1-9])|(CS2_1[0-9])|(CS2_20))\t.*\r/g);
	var arg_CS3 = text1.match(/\$((CS3_[1-9])|(CS3_1[0-9])|(CS3_20))\t.*\r/g);
	var arg_CS4 = text1.match(/\$((CS4_[1-9])|(CS4_1[0-9])|(CS4_20))\t.*\r/g);
	var arg_CS5 = text1.match(/\$((CS5_[1-9])|(CS5_1[0-9])|(CS5_20))\t.*\r/g);

// (A)を文字列に変換
	var text_CS1 = arg_CS1.toString();
	var text_CS2 = arg_CS2.toString();
	var text_CS3 = arg_CS3.toString();
	var text_CS4 = arg_CS4.toString();
	var text_CS5 = arg_CS5.toString();
// セリフ部分の抽出
	arg_CS1 = text_CS1.match(/\t.*\r/g);
	arg_CS2 = text_CS2.match(/\t.*\r/g);
	arg_CS3 = text_CS3.match(/\t.*\r/g);
	arg_CS4 = text_CS4.match(/\t.*\r/g);
	arg_CS5 = text_CS5.match(/\t.*\r/g);
// タブや改行を削除
	for (var i = 0; i < arg_CS1.length; i++) {
		arg_CS1[i] = arg_CS1[i].replace(/\t/g, '');
		arg_CS1[i] = arg_CS1[i].replace(/\r/g, '');
		arg_CS1[i] = arg_CS1[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS2.length; i++) {
		arg_CS2[i] = arg_CS2[i].replace(/\t/g, '');
		arg_CS2[i] = arg_CS2[i].replace(/\r/g, '');
		arg_CS2[i] = arg_CS2[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS3.length; i++) {
		arg_CS3[i] = arg_CS3[i].replace(/\t/g, '');
		arg_CS3[i] = arg_CS3[i].replace(/\r/g, '');
		arg_CS3[i] = arg_CS3[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS4.length; i++) {
		arg_CS4[i] = arg_CS4[i].replace(/\t/g, '');
		arg_CS4[i] = arg_CS4[i].replace(/\r/g, '');
		arg_CS4[i] = arg_CS4[i].replace(/\n/g, '');
	};
	for (var i = 0; i < arg_CS5.length; i++) {
		arg_CS5[i] = arg_CS5[i].replace(/\t/g, '');
		arg_CS5[i] = arg_CS5[i].replace(/\r/g, '');
		arg_CS5[i] = arg_CS5[i].replace(/\n/g, '');
	};
// セット名の抽出、文字列化
	var arg_CS_name = text1.match(/\$CS_SetName\t.*\r/g);
	var text_CS_name = arg_CS_name.toString();
// セット名を最適化
	var name_CS = text_CS_name.match(/\t.*\r/g);
	var text_CS = name_CS.toString();
// セット名のタブや改行削除
	name_CS = text_CS.replace(/\t/g, '');
	name_CS = text_CS.replace(/\r/g, '');
	name_CS = text_CS.replace(/\n/g, '');
	name_CS = text_CS.replace(/\s/g, '');

// JSON出力
	outputText = '{\n';
	outputText += '\t"stringList" :\n' ;
	outputText += '\t{\n' ;
	outputText += ('\t\t"import_name" : ["' + name_CS + '"],\n')  ;
	// stage1
	outputText += ('\t\t"import_stage1" : [\n') ;
	for (var i = 0; i < (arg_CS1.length); i++) {
	outputText += ('\t\t\t"' + arg_CS1[i] + '",\n') ;
	};
	outputText += ('\t\t\t"#ssend"\n') ;
	outputText += '\t\t\t],\n';
	// stage2
	outputText += ('\t\t"import_stage2" : [\n') ;
	for (var i = 0; i < (arg_CS2.length); i++) {
	outputText += ('\t\t\t"' + arg_CS2[i] + '",\n') ;
	};
	outputText += ('\t\t\t"#ssend"\n') ;
	outputText += '\t\t\t],\n';
	// stage3
	outputText += ('\t\t"import_stage3" : [\n') ;
	for (var i = 0; i < (arg_CS3.length); i++) {
	outputText += ('\t\t\t"' + arg_CS3[i] + '",\n') ;
	};
	outputText += ('\t\t\t"#ssend"\n') ;
	outputText += '\t\t\t],\n';
	// stage4
	outputText += ('\t\t"import_stage4" : [\n') ;
	for (var i = 0; i < (arg_CS4.length); i++) {
	outputText += ('\t\t\t"' + arg_CS4[i] + '",\n') ;
	};
	outputText += ('\t\t\t"#ssend"\n') ;
	outputText += '\t\t\t],\n';
	// stage5
	outputText += ('\t\t"import_stage5" : [\n') ;
	for (var i = 0; i < (arg_CS5.length); i++) {
	outputText += ('\t\t\t"' + arg_CS5[i] + '",\n') ;
	};
	outputText += ('\t\t\t"#ssend"\n') ;
	outputText += '\t\t\t]\n'; // 最後の行はカンマとる

	outputText += '\t}\n}\n';

// 出力
$("#output .info").css("display","none");
$("#output .stage").css("display","block");
$("#output .stage").append( $("<pre></pre>").text(outputText));

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
			setBlobUrl("download1", outputText, "importSet1.json");
		}
	}else{
		alert ('まず先に変換したいファイルをドロップして下さい');
	}
});
// IE用
$("#download1_IE").click(function(){  // 出力ボタン
	setBlobIE(outputText, "importSet1.json");
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
