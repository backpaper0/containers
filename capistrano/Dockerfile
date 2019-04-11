FROM ruby

RUN gem install capistrano && \
    apt update && \
    apt install -y vim

ADD vimrc /root/.vimrc
