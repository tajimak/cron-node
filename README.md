# cron-node

docker で node アプリをシェルスクリプトなどと組み合わせて cron 実行する方法

## 要点メモ

* コンテナを常駐させるために、docker-compose.yml に `tty: true` を追加
* docker logs でログ確認できるように、`/dev/console` にリダイレクト
* cron を起動するために、Dockerfile の `CMD` に `cron && ...` を挿入
* timezone も忘れずに設定
* cron ジョブでも環境変数を使用できるように、`/etc/profile.d/*.sh` ファイルで環境変数を定義。

  > docker-compose.yml の `environment:` による環境変数は docker コンテナ起動時のシェルに反映されるが、
  > cron ジョブは別シェルで実行されるためそれらの環境変数は引き継がれない。

* その環境変数を node で参照できるように、npm start スクリプトに `. /etc/profile; ...` を挿入

## 参考情報

* node プログラム内で関数を定期実行する方法

  > [node-cron - npm](https://www.npmjs.com/package/node-cron)
