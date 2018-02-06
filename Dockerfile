FROM ruby:alpine

MAINTAINER Matt Spurlin <mattsp1290@gmail.com>
# 99% inspired by CenturyLink's alpine-rails
# https://github.com/CenturyLinkLabs/alpine-rails

ARG BUILD_PACKAGES="curl-dev ruby-dev build-base yarn"
ARG DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev libffi-dev"
ARG RUBY_PACKAGES="yaml nodejs"
ARG RAILS_VERSION="5.1.4"

RUN apk --update --upgrade add --no-cache $BUILD_PACKAGES $RUBY_PACKAGES $DEV_PACKAGES && \
    gem install -N bundler && \
    gem install -N bigdecimal

RUN gem install -N nokogiri -- --use-system-libraries && \
    gem install -N rails --version "$RAILS_VERSION" && \
    echo 'gem: --no-document' >> ~/.gemrc && \
    cp ~/.gemrc /etc/gemrc && \
    chmod uog+r /etc/gemrc && \
    # cleanup and settings
    bundle config --global build.nokogiri  "--use-system-libraries" && \
    bundle config --global build.nokogumbo "--use-system-libraries" && \
    rm -rf /usr/lib/lib/ruby/gems/*/cache/* && \
    rm -rf ~/.gem

EXPOSE 3000
