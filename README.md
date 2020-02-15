# cron-node

## 要点メモ

* コンテナを常駐させるために docker-compose.yml に `tty: true` を追加
* docker logs でログ確認できるよう `/dev/console` にリダイレクト
* cron を起動するために Dockerfile の `CMD` に `cron && ...` を挿入
* cron ジョブでも環境変数を使用できるように、docker-compose.yml の `environment:` ではなく、`/etc/profile.d/*.sh` ファイルで環境変数を定義。
* その環境変数を node で参照できるように、npm start スクリプトに `. /etc/profile; ...` を挿入
