# DepthBook

iOSのデプス（深度）の解説書「[Depth in Depth](https://booth.pm/ja/items/1313752)」のサンプルコードです。

## 書籍の概要

iOSにおける「デプス」（深度）の取り扱いについて、基礎から応用まで詳しく解説した書籍です。

A5版、72ページ。iOS 13, Swift 5.1, Xcode 11対応。

## 目次

第1章 デプスの概要

- 1.1 デプスとは？
- 1.2 デプスの用途
- 1.3 Disparity(視差)とDepth(深度)
- 1.4 AVDepthData

第2章 iOSにおけるデプス取得方法

- 2.1 デプス取得方法1: 撮影済み写真から取得
- 2.2 デプス取得方法2: カメラからリアルタイムに取得
- 2.3 デプス取得方法3: ARKitから取得

第3章 デプス応用1: 背景合成

- 3.1 CIBlendWithMask
- 3.2 デプスデータをそのままマスクとして用いる
- 3.3 デプスマップを二値化する
- 3.4 マスクの平滑化

第4章 デプス応用2: 2D写真から3D点群を生成する

- 4.1 3D点群座標を求める計算式
- 4.2 Intrinsic Matrix
- 4.3 3D点群座標計算の実装
- Intrinsic Matrixを取得する
- Intrinsic Matrixをスケールする
- Intrinsic Matrixを用いてX, Yを計算する

第5章 Portrait Effects Matte

- 5.1 AVPortraitEffectsMatte
- 5.2 Portrait Effects Matteの取得方法
- 5.3 Portrait Effects Matteの取得条件/制約

第6章 Semantic Segmentation Matte

- 6.1 Semantic Segmentation Matteの取得方法
- 6.2 AVSemanticSegmentationMatte
- 6.3 SSMをCIImage経由で取得する

第7章 People Occlusion (ARKit)

- 7.1 PeopleOcclusionの実装方法
- 7.2 personSegmentationとpersonSegmentationWithDepth の違い
- 7.3 利用可能なコンフィギュレーション
- 7.4 segmentationBufferとestimatedDepthData
- 7.5 Metalカスタムレンダリング時のオクルージョン
- ARMatteGenerator
- オクルージョン処理のMetalシェーダ

第8章 デプス推定

- 8.1 FCRN-DepthPredictionモデル
- 8.2 デプス推定モデルを使用する

第9章 一般物体のセグメンテーション

- 9.1 iOSにおける他のセグメンテーション手段との違い
- 9.2 DeeplabV3を利用したリアルタイムセグメンテーションの実装