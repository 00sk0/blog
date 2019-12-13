---
title:      "Atcoder: AISing Programming Contest 2019"
date:       2019-01-12T22:00:49+09:00
categories: ["competitive_programming"]
tags:       ["contest","atcoder","ocaml"]
draft:      false
---

ROMっていた．D問題の解説がよく分からない．

<!--more-->

# A. Bulletin Board

https://atcoder.jp/contests/aising2019/submissions/4010740

一瞬迷ったが図にすると分かりやすい．左上に置いてみると，縦に0～(n-h)，横に0～(n-w)移動できるから，総数は掛け算で(n-h+1)*(n-w+1)通り．

# B. Contests

https://atcoder.jp/contests/aising2019/submissions/4010741

問題文の通りに各問題の点数を「a以下」「a+1以上b以下」「b+1以上」に分類する（個数を数えればよい）．各コンテストではこの3種類が揃わなければならないから，これらの個数のminを取ればよい．

# C. Alternating Path

https://atcoder.jp/contests/aising2019/submissions/4010742

隣り合う`'.'`と`'#'`の間に辺を引いてグラフと見ればよさそうなのはすぐに浮かんだ．ここでダイクストラとかワーシャルフロイドとか余計なことを考えて時間を空費する．距離はいらんやろ……．

ここで各連結部分において`'.'`と`'#'`の数さえ分かればよいことに着目する．なぜならば求める値は各`'.'`から`'#'`への移動方法，すなわち`'.'`と`'#'`の組の数であるから．これはそれぞれの数の乗算．従ってUnionFindで各連結成分とそれが持つ`'.'`と`'#'`の数を管理すればよい．

方法としては「$k_0[i]$=UnionFindの番地$i$の要素が根のとき，その連結成分が持っている`'#'`の個数」「$k_1[i]$=`'.'`の個数」という配列を別に持っておき，unite時に一緒にこれらを更新すればよい．

私の使っているUnionFindのコードはめぐる式準拠．ちなみにBFS/DFSでも解けたらしい．確かに．

追記(19/03/04): UnionFindのコードにバグを埋め込んでいた．[この記事](/posts/abc120)で修正．




