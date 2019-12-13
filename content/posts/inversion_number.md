---
title:      "転倒数とBinary Indexed Tree"
date:       2018-12-25T14:32:46+09:00
categories: ["competitive_programming"]
tags:       ["algorithm","ocaml"]
draft:      false
---

転倒数とBITについて知ったのでまとめておく．

<!--more-->

以下では自然数配列$a$と普通の大小関係について考える．転倒数とは，組$(i,j)$ s.t. $j \lt i$ && $a_j \gt a_i$の個数，すなわち$i$項よりも左にある$a_i$より大きい項の数の和[^1]．これを高速に求めたい．

[^1]: wikipediaでは右にある小さい項の数を数えているが，視点を逆にすれば同じこと．

# $O(n^2)$解

二重ループで定義通りに計算：

```ocaml
let count_inv a =
  let open Array in
  let a = mapi (fun i v -> i,v) a in
  fold_left (fun sum (i,v) ->
    fold_left (fun sum (j,w) ->
      if j<i && w>v then
        (a.(j) <- j,v; a.(i) <- i,w; sum+1)
      else sum) sum a) 0 a
```

見てわかるとおりこの計算量は$O(n^2)$[^4]．実際はこの問題は$O(n\log n)$で解くことができる．必要なのは元配列の区間$[0,i]$について「値$a[i]$より大きい要素の数」を求めるクエリに答える機能．



[^4]: 普通に（？）実装しても$1+2+...+n = n(n+1)/2$．

# BITについて

これを実現する方法の一つにBinary Indexed Treeの利用がある．BITは次の操作を$O(\log |v|)$で可能とするデータ構造である（以下の[参考文献](http://hos.ac/slides/20140319_bit.pdf)）：

* $v[i] \leftarrow v[i]+w$
* $\sum v[0,i]$を求める（$\sum v[l,r]$も$[0,r]-[0,l-1]$として求まる）

これはサイズ$|v|$の配列$b$を用意することで実装可能．原理については参考文献がわかりやすいので基本的に省略するが，LSBが$x \\& -x$で求まることについて脚注で軽く説明しておく[^lsb]．

[^lsb]: 2の補数を思い出せば$-x$は($x$のビットを反転させたもの+1)となる．以下ビット反転を$\tilde x$と書く．$x$のLSBを$d$桁目(0-indexed)とすると，$x$は$d-1$桁目までは0, $d$桁目は1となっている．よって$\tilde x$は$d-1$桁目まで1, $d$桁目で0となる．ここに1を足せば$-x$が求まる：1を足すと繰り上がりが起こり，$d-1$桁目まで0，$d$桁目が1となる．これと$x$との論理積を取る：$d-1$桁目まではともに0であるから0．$d$桁目も1で等しいから1．$d+1$桁目以降の$-x$は$\tilde x$と変わらないから0となる．したがって0....010...0の形となり，10進法で$x \\& -x=2^{d}$であるからLSBが求まる．図にすると次：
    ```
     x = 011001001110000
    ~x = 100110110001111
    -x = 100110110001111
                      +1
       = 100110110010000
    ```


具体的な実装は次[^fix]（OCamlのモジュールの使い方として微妙なところがありますが，競プロ用と割り切ってあまり気にしていません）：
```ocaml
let rec fix f x = f (fix f) x
module BIT = struct
  let lsb i = i land -i
  let sum i b = (* 0-indexed; Σv[0,i-1] *)
    fix (fun f i s -> if i>0 then f (i - lsb i) (s + b.(i)) else s) i 0
  let sum_closed i = sum (i+1) (* 0-indexed; Σv[0,i] *)
  let sum_interval l r b = (* 0-indexed; Σv[l,r] = Σv[0,r+1-1] - Σv[0,l-1] *)
    if l>r then 0 else sum (r+1) b - sum l b
  let add i x b = (* 0-indexed; v[i]+=x. not b *)
    fix (fun f i -> if i<Array.length b then (
      b.(i) <- b.(i) + x; f (i + lsb i))) (i+1)
  let of_array v = let b = Array.make (Array.length v + 1) 0 in
    Array.iteri (fun i v -> add i v b) v; b
  let make n = Array.make (n+1) 0
  let reconst b = Array.init (Array.length b-1) (
    fun i -> sum_interval i i b)
end
```

[^fix]: 定義が面倒なのでfix関数を使ってしまったものの，少なくとも他の例題ではきちんと再帰関数を定義したほうが速かった．


なお当たり前ではあるが`add`の対象は元配列$v$のほうなのでデバッグ時に混乱しないように注意（私はやらかしたのでデバッグ用に$b$から$v$を復元する関数を作ってみた）．

# BITの利用

今回答えるべきクエリは$i=0,...,n-1$に対して「$a[0],...,a[i-1]$に現れる値$a[i]$より大きい要素の数」だった．ここである配列$v$の$a[0],...,a[i-1]$番目にその値の出現回数を記録しておくことを考えると，$\sum v[l,r]$は$l$以上$r$以下の値の出現回数の和となっている．したがって$\sum v[a[i]+1,\max\\{a\\}]$を見ることで「$a[i]$より大きい要素数」を求めることができる．

BITを用いるとこれが$O(\log|v|)$，すなわち$O(\log(\max\\{a\\}))$で計算できる．$a[i]$の追加とこの計算を$i=0,...,n-1$に対して繰り返すことで，時間計算量$O(n\log(max\\{a\\}))$で転倒数を得ることが可能．

$\max\\{a\\}$が大きいときはBITの空間計算量$O(\max\\{a\\})$が厳しくなるが，$a$を座標圧縮しておけば空間計算量$O(n)$かつ時間計算量$O(n\log n)$にできる．

## 例

$a=[3,1,5,3,2]$の転倒数を求める．BITは$b=[0,0,0,0,0,0]$(0-indexed)．

* $a[ 0 ]=3$を追加：$b=[0,0,0,1,0,0]$．$\sum a[4,5]=0$．
* $a[ 1 ]=1$を追加：$b=[0,1,0,1,0,0]$．$\sum a[2,5]=1$．
* $a[ 2 ]=5$を追加：$b=[0,1,0,1,0,1]$．$\sum a[6,5]=0$．[^aa]
* $a[ 3 ]=3$を追加：$b=[0,1,0,2,0,1]$．$\sum a[4,5]=1$．
* $a[ 4 ]=2$を追加：$b=[0,1,1,2,0,1]$．$\sum a[3,5]=3$．

[^aa]: このように$a[i]=\max\\{a\\}$となる場合のために$\max\\{a\\}+1$領域確保しておく．

以上より転倒数は5となる．コード（座標圧縮なし）：
```ocaml
let a = [|3;1;5;3;2|]
let mx = Array.fold_left max 0 a
let b = BIT.make (mx+1)
let () = print_int @@
  Array.fold_left (fun sum v ->
    BIT.add v 1 b;
    sum + BIT.sum_interval (v+1) mx b) 0 a
```

# ジャッジ
[Chokudai SpeedRun 001: J - 転倒数](https://atcoder.jp/contests/chokudai_s001/tasks/chokudai_S001_j)．座標圧縮しなくても[通る](https://atcoder.jp/contests/chokudai_s001/submissions/3875548)．[座標圧縮版](https://atcoder.jp/contests/chokudai_s001/submissions/3877048)（あんまりテストしてない）．


