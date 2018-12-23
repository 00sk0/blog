---
title:      "Hugoのテーマ作り備忘録"
date:       2018-12-23T17:12:55+09:00
categories: ["dev"]
tags:       ["website","hugo"]
draft:      false
---

静的サイト生成ツール[Hugo](https://gohugo.io)でこのサイトを作ってみました．導入自体はそこまで難しくないため，主にテーマ作成について**備忘録**レベルですがさっそく記事を書いてみようと思います．

<!--more-->

# 所感

* [Hugo Themes](https://themes.gohugo.io/)のテーマをそのまま使うなら本当に簡単
* 自分でテーマを作ろうとすると大変かもしれません

# Hugoを選んだ理由

* Markdownが使える＋タグ毎の集計など個人的にblogに欲しい機能を実現する機構がある
  * [Pug](https://pugjs.org/)+JavaScriptで簡単なサイトを作った経験はあったものの，やっぱり書けるならMarkdownで書いたほうが楽だろうし，JavaScriptで諸機能を実装するのはそれなりに大変だった
* OCamlで簡単なものを実装してもよいとは思ったものの，[Markdownの拡張記法](https://www.markdownguide.org/extended-syntax/)に対応するものがなかった[^1]
[^1]: 脚注が欲しかった．
  * 自分でMarkdownパーサを書くのは（興味はありますが）今回は見送りました
* 速いらしい（受け売り）

# テーマ作りの備忘録

先に述べたように導入〜記事の追加については扱いません；[公式ドキュメント](https://gohugo.io/getting-started/quick-start/)などを参照してください．

以下**備忘録につき誤りや不正確性を含みます**．何より私がわかっていないので……：

## レイアウトの構成

* 公式ドキュメントが手厚すぎてどこから読めばいいのか戸惑うことに
  * 最初に[Hugo Themes](https://themes.gohugo.io/)のTagsから作りたいサイトの種類（blogなど）を探して出てきたテーマのソースをいくつか読んでみるのがよい気がします
* 雑な認識：ページの種類に応じて読みに行くhtmlの候補が違う（./index.htmlや./_default/\*\*\*.htmlなど）．それらから参照するテンプレートを./partials/内に入れておく．
  * [Block Templates](https://gohugo.io/templates/base/)だとbaseof.htmlに置いたblockをあとから_default/\*\*\*.htmlなどから埋める構成にできるらしいです（まだ試していません）
* その候補一覧が[Hugo's Lookup Order](https://gohugo.io/templates/lookup-order/)にあります
  * 私は記事最初のTipにあるようにindex.htmlと_default/list.htmlと_default/single.htmlだけ持ってあとは場合分けで済ませました[^2]（表を睨むと確かにこれでよさそうな気がしてきます）
  * 雑な認識：index.htmlを参照するのがトップページ，single.htmlを参照するのが各記事やaboutなどの単発文書，list.htmlを参照するのが記事一覧やTaxonomy（tagやcategoryなど）一覧，またはTaxonomy別の記事一覧．

[^2]: 今思うとterms.htmlは使うべきでしたが[^3]，「自分で作ったmdはsingle.html，トップはindex.html，それ以外はlist.html」という単純な分類をしたかったという思いがありました．気が向いたら修正します．

[^3]: category一覧やtag一覧などの表示に使えるはず．現在はlist.htmlにて`.Title`と`.Section`が（大小文字を区別せずに）同一であるかを見るという非常に危険な実装で代用しています．具体的には"tags"というタグを追加すると死にます．

## テンプレート編集

* `{{partial "\*\*\*.html" .}}`の最後のドットを忘れるとハマります
* [二重波括弧+ハイフン](https://golang.org/pkg/text/template/#hdr-Text_and_spaces)を使わないと不自然な空白ができて生成HTMLが汚くなります．そのうち直したい．
* 型の（わから）ない世界で格闘することにはなりそうです：今の"`.`"が何を指すのか，何のフィールドを持っているのか，など．[Variables and Params](https://gohugo.io/variables/)を見ればよいと言われればそうなのですが．
  * 例えば`.Data.Terms`とそれを回数順に並べた`.Data.Terms.ByCount`で型が違うのにマニュアルに書かれていないなど
* 結果的にテンプレートを展開して中身を見るprintfデバッグのようなことを延々としていました
* 文字列操作関数を自作して使うことはできなそう？



# まとめ

読み返すとマイナス面ばかり目立たせてしまったように思います．確かに全体像を把握しづらく次に何をすべきか分からなくなるという形の難しさは感じたものの，理解が進んだ途端に書きやすくはなりましたし，機能的には十分に満足です．




