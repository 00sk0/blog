---
title:      "AtCoder: diverta 2019 Programming Contest"
date:       2019-05-12T23:40:34+09:00
categories: ["competitive_programming"]
tags:       ["contest","atcoder"]
draft:      false
---

Cで嵌ってしまった．

# A. Consecutive Integers

区間を覆う問題は何度か解いたので記憶していた．図を描けばわかりやすい．https://atcoder.jp/contests/diverta2019/submissions/5375209

選ぶ連続した整数を区間と見る．例えば$N=8,K=3$のとき，
`ooo.....`
のようになり，`'.'`の数だけ区間を右にずらせる．`'.'`の数は$N-K$であるから，答えは初期位置も含めて$N-K+1$．

# B. RGB Boxes

箱がそれぞれ$R,G,B$個だと誤読して3分くらい浪費．実際は箱の中のボールの個数が$R,G,B$個．https://atcoder.jp/contests/diverta2019/submissions/5375264

各色について買う箱の個数を決め打ちすることを考える：例えば赤ならそれぞれ$0$個以上$\lfloor N/R \rfloor$個以下[^1]（$G,B$も同様）．これだと$O(N^{3})$であり間に合わないが，2種類だけ決めれば残りに必要な箱の個数は求まる：箱の個数をそれぞれ$r,g,b$とおくと$b=\frac {N-(rR+gG)} {B}$．これが割り切れかつ先の範囲内でなければならない．この方針なら$O(N^2)$であるから間に合う．

ところでeditorialがそうしているように$r,g$の上限は$N$でも，$N$の上限の$3000$でもよい（どうせ$b$が負になるため）．

[^1]: 一応証明しておく．$N=pR+q\ (0 \le q \lt p)$とおくと$p=\lfloor N/R \rfloor$．このとき$pR \le N = pR+q$ $\lt pR+p = (p+1) R$であるから，$\lfloor N/R \rfloor + 1$個以上は買えない．

# C. AB Substrings

コーナーケースに引っ掛かっていると思って色々試行錯誤した挙句元々の解法が間違っていた．https://atcoder.jp/contests/diverta2019/submissions/5376372

まず各文字列の中の`AB`の個数を数える．次に末尾に`A`や，先頭に`B`があるものを組み合わせて`AB`が作れることに注意する（文字列の中の`AB`とは重ならないので安心）．両方を兼ね備える文字列に注意：パターン`BA`とおく．そうでなく末尾に`A`，先頭に`B`があるものをそれぞれパターン`XA`, `BX`とおく．これらの組み合わせ方を考えたい（どちらでもないパターンはどう組み合わせても意味が無いので以下無視する）．

はじめば`XA`と`BX`，および`BA`をそれぞれ独立に組み合わせた後で合体させればよいと考えていたが，誤りである：例えば`BA=3`,`XA=2`,`BX=2`のとき，`XABX+XABX+BABABA`となって5個であるが，最適なのは`XABX+XA+BABABA+BX`の6個である．このように`BA...BA`の先頭および末尾にある`B,A`を活用してそこに`XA`, `BX`を組み合わせたほうが得をする．

以上より：

* `BA`があるとき：
	* `BA...BA`の中に`AB`は$\text{BA}-1$個
	* さらに両側にそれぞれ`XA`, `BX`を追加できる
		* `XA`, `BX`のそれぞれについて，それが1個以上あれば`AB`が1個増える（`XA`, `BX`も1個減る）．これらは破壊的に更新されたとする．
	* 余った`XA`, `BX`同士を組み合わせて`XABX...XABX`を作る：`AB`は$\min \\{\text{XA}, \text{BX}\\}$個
	* 従って$\text{AB} + \text{BA} - 1 + \min \\{\text{XA}, \text{BX}\\}$ 
* `BA`がないとき：
	* `XA`, `BX`の組み合わせのみ．従って$\text{AB} + \min \\{\text{XA}, \text{BX}\\}$

文字列の中の特定文字列の個数を数える関数が見当たらなかったので適当な実装をした．最初は`Str.split`結果の`length`から1引いたものとしていたが，JavaScriptなどと異なりこれは特定文字列が先頭や末尾にある場合に空文字列が入らないためズレてしまう[^2]．そこで単純にループによる数え上げで実装した．あるいは[検索対象の先頭に適当な文字（例えば本問では小文字は出ない）を入れたり](https://atcoder.jp/contests/diverta2019/submissions/5384221)，[JavaScript版を再現したり](https://atcoder.jp/contests/diverta2019/submissions/5411500)すれば大丈夫．

[^2]: `"abxabyab"`を`"ab"`で`split`する場合，JavaScriptでは`["","x","y",""]`となるが，OCamlでは`["x","y"]`となる．

# D. DivRem Number

感触は300点，数学要素も考慮すると簡単目な400点問題な気がする．https://atcoder.jp/contests/diverta2019/submissions/5375505

500点問題ということで最初数分は難しく考えすぎてしまったが，素直に$N=pm+q$と表示すればよい：$p=\lfloor \frac {N} {m} \rfloor$，$q=N \bmod m$．これらが等しくなるような$m$を求めたい：$N=pm+p=p(m+1)$．よって$N$の約数$d$が分かれば$m$の候補$m = d - 1$が得られる．あとは元々の条件$\lfloor N/m \rfloor = N \bmod m$を確かめればよい（$0$除算にならないように注意）．


