---
title:      "Hugo製サイトをWerckerでGitHub Pagesにデプロイ"
date:       2018-12-24T15:13:32+09:00
categories: ["dev"]
tags:       ["website","hugo","wercker","gh-pages"]
draft:      false
---

これも単なる**備忘録**です．[Hugo側のドキュメント](https://gohugo.io/hosting-and-deployment/deployment-with-wercker/)が古いようなので，適当に補足．

<!--more-->

# Github Pagesについて
* \*\*\*.github.ioレポジトリ: masterブランチに置いてあるものしか公開できない[^1]
* 今回はmasterブランチにhugoプロジェクトを置きたい
* そこで個別のリポジトリからgh-pagesブランチを用いて公開する．これは先のドキュメント通り

[^1]: レポジトリのsettingsを見ると確かにそう書いてある．これを勘違いしていて時間を溶かした．

# Hugo-build
- 右上のSteps storeから探す．
- 設定が全部Optionalになっているが空だと怒られた
- yamlが無いとのことだったので設定ファイルを指定しなければダメなのかなと思い`config: config.toml`を追加
- ビルド成功

# デプロイ
- [ドキュメントの設定](https://gohugo.io/hosting-and-deployment/deployment-with-wercker/#add-a-github-pages-deploy-step-to-wercker-yml)をそのままコピー．ただしdomainのig.nore.meは要らない（ignoreされるのだと思ったが……）
- Workflows > Add new pipelineからデプロイ用のパイプラインを追加
- GIT_TOKENを追加．scopeはpublic repositoryを見れるやつにした
- パイプラインを接続
- 先のパイプラインはデプロイ成功によるgh-pagesの更新でも発火してしまう
	- `could not read wercker yml while ` `getting config: No wercker.yml found`と言われた（それはそう）
	- Workflowsからbuildを選び，"When new code is pushed On branch(es)"の\*を消してmasterにする

