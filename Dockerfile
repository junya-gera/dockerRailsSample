# ベースイメージの指定をする命令
FROM ruby:2.5.3

# Dockerイメージを作成する際にコンテナ内でコマンドを実行する命令
# 余分にレイヤーを積み重ねないためできるだけ以下のように命令は1つにまとめる
# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
		       libpq-dev \
		       nodejs

# 作業ディレクトリの作成、設定
RUN mkdir /app_name

# コンテナ内の環境変数を設定する命令
# 作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /app_name

# 場所を移動する命令。次以降の命令は移動した先の場所が起点となる
WORKDIR $APP_ROOT

# ファイルやディレクトリを取得する命令
# ホスト側（ローカル）のGemfileを追加する
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileのbundle install
RUN bundle install
ADD . $APP_ROOT
