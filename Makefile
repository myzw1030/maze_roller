# Dart,Flutterバージョン確認
flutter_version:
	fvm flutter --version

# キャッシュの削除
clean:
	fvm flutter clean
	fvm flutter pub get

# パッケージセットアップ
pub_get:
	fvm flutter pub get

# ファイル自動生成
gen:
	fvm flutter pub run build_runner build --delete-conflicting-outputs
