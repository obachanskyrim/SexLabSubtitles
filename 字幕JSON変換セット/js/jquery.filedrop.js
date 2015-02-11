;(function(global, $) {
    "use strict";

    /**
     * 呼び出し元のjQueryオブジェクトをファイルドロップ可能にする
     * @param  {Object} opt 設定ファイル
     * @return {this} 呼び出し元のjQueryオブジェクト
     */
    $.fn.fileDrop = function(opt) {

        // FileReaderに対応していない場合は例外を投げて終了
        if ( global.FileReader === undefined ) {
            throw new TypeError("This browser is not support FileReader.");
        }

        var defaults = {
                dragEnter: function() {},
                dragLeave: function() {},
                drop:      function() {},
                dropEach:  function() {}
            },
            config = $.extend(defaults, opt),
            util = {};

        /**
         * ブラウザのデフォルトイベントをキャンセルする
         * @namespace util
         * @method stop
         * @param {Event} e イベントオブジェクト
         * @return なし
         */
        util.stop = function(e) {
            e.preventDefault();
            e.stopPropagation();
        };

        return $(this).each(function($el) {
            var $droppable = $(this);

            $droppable.on({
                // dragoverイベントはキャンセル
                "dragover": util.stop,

                // デフォルトイベントをキャンセルしてdragEnterを呼び出し
                "dragenter": function(e) {
                    util.stop(e);
                    config.dragEnter.call($droppable, e);
                },

                // デフォルトイベントをキャンセルしてdragLeaveを呼び出し
                "dragleave": function(e) {
                    util.stop(e);
                    config.dragLeave.call($droppable, e);
                },

                // デフォルトイベントをキャンセルしてdragを呼び出し
                // 取得したファイル1つごとにdropEachイベントを呼び出し
                "drop": function(e) {
                    util.stop(e);

                    // filesはargumentsのようなオブジェクトなので配列に変換
                    var tmp = e.originalEvent.dataTransfer.files,
                        files = Array.prototype.slice.call(tmp, 0, tmp.length);

                    config.drop.call($droppable, files);

                    files.forEach(function(file) {
                        var reader = new FileReader();

                        $(reader).one('load', function(e) {
                            // dropEachイベントを呼び出し
                            config.dropEach.call($droppable, file, e.currentTarget.result);
                        });
                        reader.readAsText(file);
                    });
                }
            });

        });
    };
}(this, jQuery));
