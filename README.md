# Issue SHSH checker Ver.2.0 (fork)
復元可能なiOSバージョンをベータ版も含め簡単に確認 及び取得できるシェルスクリプトです

## 依存関係
以下が必要です:
- POSIX準拠シェル(dashとbashで動作確認済み)
- cURL
- jq

発行中のSHSHを取得する機能を使う場合、以下も必要です:
- [partialZipBrowser(pzb)](https://github.com/tihmstar/partialZipBrowser)
- [tsschecker](https://github.com/tihmstar/tsschecker)

## 実行の仕方
`shsh.sh`を実行すると検索が開始されます

例: `./shsh.sh iPhone10,3`

![shsh.sh iPhone10,3を実行した図 5つのSHSHが利用可能](Docs/test.png)

引数にECIDを指定するとベータ版を含め発行中のSHSHを全て取得できます

例: `./shsh.sh iPhone10,3 8237910564814894`

![取得した5つのshsh2ファイルをFinderで表示した図](Docs/shsh.png)
