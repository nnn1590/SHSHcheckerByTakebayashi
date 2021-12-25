# SHSH checker (fork)
復元可能なiOSバージョンをベータ版も含め簡単に確認できるbashスクリプトです。

![bash <(curl -s https://otintin.world/shsh.sh)](Docs/test.jpg)

実行にはインターネット接続が必要です。

## 依存関係
JSONファイルを解析するためjqコマンドが必要です。

Debian系OSの場合下記コマンドで依存関係を解決できます。
```bash
sudo apt install jq
```

## 仕組み
[SHSH Host](https://shsh.host)からJSON情報を取得しSHSHの発行状況を確認します。取得元の情報によっては最新ではない可能性があるため表示されたバージョンで復元できる保証はできません。

## 実行の仕方
`shsh.sh`を実行すると確認が開始されます。
第一引数には対象となる端末を指定できます。（未指定の場合`iPhone9,1`になります。）
```bash
./shsh.sh iPhone9,1
```

以下のコマンドを使用すればgitからcloneすることなく実行することも可能です:
```bash
curl -s https://raw.githubusercontent.com/nnn1590/SHSHcheckerByTakebayashi/fork1/shsh.sh | bash -s - iPhone9,1
```
