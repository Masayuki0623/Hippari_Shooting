## Hippari Shooting — マウス“ひっぱり”アクション・シューティング

マウス操作でキャラクターをひっぱり、ショットを放つ、アクション寄りの2Dシューティングです。物理挙動を活かした操作感と、ステージごとに異なる敵挙動・UI演出を実装しています。

---

### デモ動画（GIF）

![Hippari Shooting Demo](./Videotogif.gif)

フルデモはこちら（YouTube）：https://youtu.be/If9xWkEPlcU

---

### 今すぐプレイ（Windows 実行ファイル）

OneDrive から実行ファイルをダウンロードできます：

https://1drv.ms/u/c/6087f855e4f022db/Edsi8ORV-IcggGB35wAAAAABPaM-WUbJqyL0XUwN1iXv7Q?e=IHNbez

---

## 概要
- プラットフォーム: Processing（Javaベース）
- 主なライブラリ: Minim, Sound
- 主な特徴: スリングショット×弾幕シューティング


## 操作方法
- マウス移動: プレイヤーの基本位置を追従。
- マウスドラッグ: ゴム紐（スリング）を伸ばしてテンションを溜める。
- マウスリリース: 溜めに応じた速度でショットを発射。


### 動作環境
- Processing 
- 依存ライブラリ: Minim, Sound（ProcessingのContribution Managerから導入可能）

### ビルド & 実行（開発用）
1. Processing をインストール
2. 本ディレクトリをスケッチとして開く
3. Minim / Sound を導入（初回のみ）
4. ファイルを開いて再生ボタンで実行
 

### ファイル構成（抜粋）
- `Prototype5.pde`: エントリーポイント（ゲームループ/シーン管理）
- `player.pde`: プレイヤー操作・スリング挙動・発射処理
- `enemy.pde` / `enemy2.pde` / `enemy3.pde`: 敵の種類別ロジック
- `bullet.pde`: 弾の生成・移動・描画
- `UI.pde`: UI描画・演出
- `Sound.pde`: 効果音のロード・再生（`s/` ディレクトリ）
- `array.pde` / `calculation.pde`: 汎用配列・数値計算ユーティリティ
- `p/`: 画像アセット（未使用）
- `s/`: サウンドアセット（効果音）

### 設計のポイント
- 入力・物理・描画・サウンドを役割ごとに分離し保守性を確保。
- シーン/敵/プレイヤーを状態として管理し、追加実装しやすい構造。
- 視覚（色/太さ/点滅）と音で“手応え”を強調するUX設計。

---

## ダウンロード / 配布
- OneDrive配布（上記リンク）


## リファクタリング版（Python）
https://github.com/Masayuki0623/Hippari_Shooting_refactored

※ Python 版は設計の見直し・リファクタリングに重点を置いた別実装です。

