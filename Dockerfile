FROM ruby:3.2.2

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    nodejs \
    npm

# yarnをインストール
RUN npm install -g yarn

# 作業ディレクトリを設定
WORKDIR /app

# GemfileをコピーしてBundle install
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションのコードをコピー
COPY . .

# ポート3000を公開
EXPOSE 3000

# サーバー起動
CMD ["rails", "server", "-b", "0.0.0.0"]