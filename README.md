# Riverpodならアプリのスクリーンショット撮影も楽になるかも

# 概要

* Flutterアプリのスクリーンショットを自動で撮りたい
* Riverpodを使った実装なら好きな状態でスクリーンショットが撮れるかも

# Flutterのバージョン

```shell
% flutter --version
Flutter 1.25.0-8.1.pre • channel beta • https://github.com/flutter/flutter.git
Framework • revision 8f89f6505b (8 days ago) • 2020-12-15 15:07:52 -0800
Engine • revision 92ae191c17
Tools • Dart 2.12.0 (build 2.12.0-133.2.beta)
```

# サンプルアプリについて

リポジトリ
https://github.com/seiichi3141/take_screenshots.git

* flutter createで作られるサンプルアプリをRiverpod仕様に実装し直して、テーマを変更できるようにしたもの
* 設定画面を用意する。テーマとダークモードの切替ができるようにする
* ホーム画面のAppBarのActionsにIconButtonを追加して設定画面へ遷移できる

