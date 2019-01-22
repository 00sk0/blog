---
title:      "Codeforces Good Bye 2018"
date:       2018-12-31T01:57:05+09:00
categories: ["competitive_programming"]
tags:       ["contest","codeforces"]
draft:      false
---

体調不良で参加は見合わせたのだがそのまま解き続けてみたら結果的に1時間半くらいで4完できたので出ればよかった（+80くらい出たらしい）．

<!--
来年は策に溺れず（？）コンテストに出るようにしたほうがよいかもしれない．でもレート変動的には得をしているのかも……[^cf]．
[^cf]: 個人的感触で大成功してもたいてい+30程度だが失敗すると普通に-60や-90くらい落ちるので．
-->

今日のコードはコンテスト時のものをそのまま貼っているので汚い．本当は[この前の記事](/posts/cf_edu_057)みたいにいちいち書き直したいものの，Codeforces+OCamlでは64bit整数関係のライブラリが必要ということもあり，手間を考えると微妙．

# [A. New Year and the Christmas Ornament](https://codeforces.com/contest/1091/problem/A)

制約が小さいのでyellow ornamentsの個数で全探索する．https://codeforces.com/contest/1091/submission/47768338

## $O(1)$解(editorial)

解を$(p,p+1,p+2)$とすると，$p \le y$かつ$p+1 \le b$かつ$p+2 \le r$を満たす最大の$p$を取ればよい．移項して整理すれば$p$の条件は$\min\\{y,b-1,r-2\\}$以下となる（$b<1$や$r<2$のときはこれだけでは$p$が負になってしまうが，本問では制約からそれが起こらない）．求める値は$p+(p+1)+(p+2)=3p+3$個．

# [B. New Year and the Treasure Geolocation](https://codeforces.com/contest/1091/problem/B)

最初見たときすぐに解法が浮かばなかったのは反省．https://codeforces.com/contest/1091/submission/47768348

obeliskとclueの対応をすべて列挙すると間に合わないが，最初のobeliskと対応するclueだけを全通り試せばよい．するとtreasureの座標が決まるため，残りの各obeliskについてその座標をtreasureの座標から引くことで対応するclueを求めることが可能．clueをMapに入れて存在を確かめることで$O(n^2 logn)$で求解可能．

## $O(n)$解(editorial)

obeliskの座標と対応するclueの座標を足すとtreasureの座標となる．ということはobeliskの座標の総和とclueの総和を足すと$n*$(treasureの座標)となるため，単にこれを$n$で割って済む．

# [C. New Year and the Sphere Transmission](https://codeforces.com/contest/1091/problem/C)

30分は掛け過ぎだった．https://codeforces.com/contest/1091/submission/47768360

$k$が$n$の約数でないときは何周もしてすべての点を通り[^hoge]，和は$1+...+n=\frac{n(n+1)}{2}$となる．
$k$が$n$の約数であるときは1周で終わり[^fugapiyo]，通る点は$1+0k,1+1k,1+2k,...,1+(m-1)k$となる．ただし$m$は$1+mk=n+1$，すなわちちょうど一周するときの値．これらの合計は$m=\frac{n}{k}$より$\sum_{i=0}^{n/k-1} (1+ik)=\frac{n(n+2-k)} {2k}$となる（数学が出来ないのでWolframで計算した）．

[^hoge]: 証明できているか分からない証明：点$1$から点$1$に戻るまでの移動距離は$n$の倍数かつ$k$の倍数だから最短でも$nk$．このとき$\frac{nk}{k}=n$点通るが，先の話はどの点にも言えるので$n$点の中に同じ点は$1$以外無い．よってすべての点を通る．

[^fugapiyo]: 同様にして移動距離が$n$となるため．

肝心の$k$の列挙だが，約数列挙は$O(\sqrt{n})$で十分間に合う．以上の値を列挙すればよい．

# [D. New Year and the Permutation Concatenation](https://codeforces.com/contest/1091/problem/D)

実験したらなんか規則性が出てきたのでその通りに実装した．理屈は全く分かっていないし非想定解だろう．後でeditorialを読んで理解出来たら追記します．

## 実験

https://codeforces.com/contest/1091/submission/47768364

何も分からないので素直に実装して実験するとn=8まではまあまあの時間で計算可能．部分列として同じ数列が出現することがあるので，それらの個数をまとめてみる．これを並べて眺めていると「同じ個数の数列がいくつあるか」もまとめてみたくなるのでそうする．すると次のようになる（次図は1個から）：

* `n=3: [ 3,  3]`
* `n=4: [ 4,  8,  12]` 
* `n=5: [ 5, 15,  40,  60,]`
* `n=6: [ 6, 24,  90, 240,  360]`
* `n=7: [ 7, 35, 168, 630, 1680, 2520]`

$n=k$について一番左は$k$，次は$k\*(k-2)$となっている．それ以降の要素は，斜めに見ると(左上)$\*k$となっている．いま$k=n$についてこの配列を求めたい．これを$a$とおくとき，$k=3,...,n$において左から二番目の要素を前計算して$b[k]$とすれば，aを求めるにはそこから右下に伸ばしていけばよい：すなわち$b[k]$に$K(k):=(k+1)\*...\*n$を掛ければ$a[n-k+2]$が求まる．これを愚直に行えば$O(n^2)$っぽいが，$a$の左から埋めていけばこの階乗みたいなやつを$K(k-1)=K(k)*k$として使いまわせるため$O(n)$で計算可能．答えは$\sum_{i=1}^{n} ia[i]$．

添字をバグらせて苦しんだ．添字を乱択する癖があってよくない．

<!-- [^rv]: あるいは右からでも$K(k+1)=\frac{K(k)}{k+1}$を思い出せば逆元で求まったりするのかしら． -->



