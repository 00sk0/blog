---
title:      "Codeforces Hello 2019"
date:       2019-01-05T02:50:37+09:00
categories: ["competitive_programming"]
tags:       ["contest","codeforces","ocaml"]
draft:      false
---

新年早々水色陥落しかけていますが……．

<!--more-->

# A. Gennady and a Card Game

https://codeforces.com/contest/1097/submission/47945706

各トランプが2文字で与えられるので1,2文字目を比較．どうでもいいが`exit`関数を使うとutop（OCamlのREPL）も終了するので少々つらい．

# B. Petr and a Combination Lock

https://codeforces.com/contest/1097/submission/47945700

$N<=15$に注目．時計回り／半時計回りの組み合わせを全列挙すればよい．すなわち各回転に対して+1倍か-1倍かを選んで足し合わせ，合計が360の倍数であればよい．

この合計は負数となり得るが，これに対してmod演算をしてしまったことに後から気付いて冷や汗をかくなどした．実際は負数であっても余りが$0$かを見るだけなら結果は変わらない．

割られる数が正になるように`mod`関数を再定義することを考えている．

# C. Yuhao and a Parenthesis

https://codeforces.com/contest/1097/submission/47945690

括弧列は次のように分類可能：

* 左側に`'('`が欲しい
* 右側に`')'`が欲しい
* 両側とも必要
* 両側とも必要ない

これらを対応するものごとに組み合わせればよい．最初は括弧の深さ（`'('`のとき+1, `')'`のとき-1）だけを見て，これが正であれば`')'`，負であれば`'('`が必要，0であれば両側とも不要としていた．しかしこれでは両側に括弧の補充が必要な場合を見逃してしまう（例えば本文中にある`"(()))("`は深さの合計は0になるが，左に`'('`，右に`')'`がなければ揃わない）．1WA．

ここでAtCoderに[類題](https://atcoder.jp/contests/abc064/tasks/abc064_d)があったことを思い出した．まず左から見て`'('`の不足を数える：これは-1*(深さの最小値)となる（この数だけ`'('`を補充すれば負の深さがすべて0以上となる）．これを$p$個とする．これらを左側に補充した上で`')'`の不足を数える：これは開始深さを$p$としたときの右端での深さであるから，もう一度ループを回すか，あるいは先の右端での深さ+$p$とすればよい[^1]．以上より文字列が先の分類のどれにあたるかが判別可能．ここで両側に必要とするパターンは本問では組を作れないが，残る3パターンは可能：左側に$n \ge 0$個必要な括弧列に対して右側に$n$個必要なものを組み合わせればよい．

本番ではSystem Testに通らず残念な結果に．これは括弧列の文字数が$\le 5 \times 10^5$という制約の読み落としによるRE，および`'('`の補充を何も考えずそのまま文字列結合で行ってしまったことによるTLEの合わせ技だった．

[^1]: 掲載したコードでは後者を採用．さらに深さが$-1$になるとき，代わりにもう一つの変数$pre$にその分だけ加算している．すると深さが「左側に括弧を補った際の深さ(>=0)」という意味になるため，右端でのこの値が右側の必要個数となる．左側の必要個数は$pre$．



<!-- 掲載したコードでは左右の必要括弧数を1回のループで計算している．走査中に深さ$cnt$が0以下になるとき，深さを負にする代わりにもう一つの変数$pre$にその分だけ加算している．すると先のアルゴリズムにおける深さは$cnt-pre$となる．ここで2回目のループでは右端の深さが$(cnt-pre)+pre=cnt$となり，2回目のループで求めるべき値が$cnt$として求まるから，1回のループで済む． -->

# D. Makoto and a Blackboard

(2019/03/06): [こちらの記事](/posts/cp_001)に追加．
