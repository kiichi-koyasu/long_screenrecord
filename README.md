# long_screenrecord

## 注意
* Android端末が1台のみ繋がっている時に正常に動く想定です
* うまく動かずプロセスが残ってしまった場合は`kill -9 PID`で強制終了してください
* 使用は自己責任でお願いいたします

## 事前準備
* adb コマンドを使用するのでパスを通してください
* ffmpeg コマンドも使用するので同様です

## 使い方
1. long_screenrecord.shとmy_screenrecord.shを同じディレクトリ階層に置く
1. Android端末をUSB接続する
1. `sh long_screenrecord.sh`コマンドを実行すると録画開始
1. Ctrl-Cで録画終了
1. 処理が終わるまで待つ
