FROM ruby:3.3.5-slim-bookworm

ENV DEBIAN_FRONTEND=noninteractive \
    EXECJS_RUNTIME=Node \
    LANG=C.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential curl git imagemagick nodejs python3-pip zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /srv/jekyll

COPY requirements.txt ./
RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

COPY Gemfile Gemfile.lock ./
RUN gem install --no-document bundler -v "$(tail -n 1 Gemfile.lock | tr -d ' ')" \
    && BUNDLE_FROZEN=true bundle install --jobs 4 --retry 3

COPY bin/entry_point.sh /usr/local/bin/site-preview

EXPOSE 8080 35729

CMD ["/usr/local/bin/site-preview"]
