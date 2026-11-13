# aws-emulator-sample

ずんだもんの実験道具箱「AWS Emulator 入門」回のサンプルです。
S3 にファイルを置き、DynamoDB に1行書くだけの小さな Python アプリを、AWS 公式の [AWS Emulator](https://github.com/aws/aws-emulator) で手元で動かします。

動画で試した環境: Ubuntu（Linux・arm64）、AWS Emulator v1.0.338、AWS CLI v2、Python 3 + boto3。

## 中身

| ファイル | 役目 |
|---|---|
| `app.py` | S3 に `report.csv` を置き、DynamoDB に1行書く。向け先も鍵もコードに書いていない |
| `report.csv` | 置くファイル |
| `setup.sh` | バケットとテーブルを作る（テーブルが作り終わるまで待つ） |
| `teardown.sh` | バケットとテーブルを消す |
| `env_local.sh` | この端末の向け先を手元のエミュレータへ変える |

## 手元で動かす（Linux）

1. AWS Emulator を入れる（公式の手順: [Getting started on Linux](https://docs.aws.amazon.com/emulator/latest/userguide/getting-started-linux.html)）
2. 端末A で起動する: `aws-emulator`（使い方の記録を送りたくなければ `aws-emulator -t off`）
3. 端末B で:

```bash
source env_local.sh
aws sts get-caller-identity   # Account が 000000000000 なら手元を向いている
bash setup.sh
python3 app.py
```

止めるときは端末A で Ctrl+C。中身は全部消えます（メモリにだけ持つため）。

うまく向かないとき: 本物の鍵を環境変数（`AWS_ACCESS_KEY_ID` など）や `AWS_PROFILE` に入れていると、そちらが優先されます。手元で使う端末では外してください（[公式](https://docs.aws.amazon.com/emulator/latest/userguide/point-sdk.html)）。

## Mac・Windows

公式の案内は Docker で動かす形です（既製のイメージは無く、短い Dockerfile から作ります）。
手順は公式の [Getting started with Docker](https://docs.aws.amazon.com/emulator/latest/userguide/getting-started-docker.html) を見てください。
向け先の環境変数は、公式の [全行の設定](https://docs.aws.amazon.com/emulator/latest/userguide/point-sdk.html) を使ってください。
**動画では Mac・Windows（Docker）は試していません。** 上の2行で通ると確かめたのは Linux のパッケージの形だけです。

Python 以外の SDK（Node・Java・Rust・.NET など）は、証明書の設定が別に要る場合があります（公式 docs の各 SDK の節）。

## 本物の AWS で動かすとき

`app.py` は変えずに、`env_local.sh` を読み込んでいない端末で動かせば、いつもの自分の設定（鍵とリージョン）で本物の AWS を向きます。

- S3 のバケット名は世界で一つです。`app.py`・`setup.sh`・`teardown.sh` の `zunda-emu-demo-b0482d4d` を自分だけの名前に変えてから使ってください
- 本物には料金がかかります。終わったら `bash teardown.sh` で消してください
- 権限（IAM・バケットポリシー）は、エミュレータでは本物と同じには確かめられません。権限まわりは本物で確かめてください

## ライセンス

このサンプルは [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/deed.ja) です。AWS Emulator 自体のライセンスは本家のリポジトリを見てください。
