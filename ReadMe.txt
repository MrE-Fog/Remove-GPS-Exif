Jpeg の GPS 位置情報を削除する

■ これは何?
Jpeg の GPS 位置情報を削除します

■ 使い方
PowerShell プロンプトで以下コマンド入力すると、Jpeg の GPS 位置情報を削除します
オリジナルファイルは -ORG.jpg として残ります

SetNormalPositionExif ファイルPath

1ファイルづつしか処理しないので、ディレクトリ配下にある複数の .jpg を処理したい場合は、パイプを使って以下のようにしてください

Get-ChildItem C:\Test\*.jpg | % { RemoveGPSExif $_.FullName }

■ セットの仕方
PowerShell プロンプトで install.ps1 を実行してください

■ Uninstall 方法
uninstall.ps1 を実行して下さい

■ 動作確認環境
On Windows
	5.1
	6.2.1
	7.1.0

■ Web サイト
Jpeg ファイルの GPS Exif を PowerShell で削除する
https://www.vwnet.jp/Windows/PowerShell/2016051501/RemoveGPSExif.htm

■ リポジトリ
https://github.com/MuraAtVwnet/Remove-GPS-Exif
git@github.com:MuraAtVwnet/Remove-GPS-Exif.git

